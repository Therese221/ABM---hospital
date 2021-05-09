Globals [
  dynamisk_intensiv_pasienter antall_intensiv_pasienter probability-list statistisk_intensiv statistisk_normal antall_omdisponerte antall_die
  beredskapshåndtering beredskaps_vellykkethet beredskapshåndtering_stress_relatert beredskapshåndtering_kompetanse_relatert beredskapshåndtering_døds_relatert beredskapshåndtering_kommunikasjon
  beredskapshåndtering_stress_relatert_ticks multipliserende_faktor_kommunikasjon beredskapshåndtering_totaldødlighet beredskapshåndtering_totaldødlighet_scenario beredskapshåndtering_døds_relatert_multiplikator
  beredskapshåndtering_forventa_døde_37_dager beredskapshåndtering_forventa_døde_52_dager beredskapshåndtering_forventa_døde_82_dager døde_beredskap døde_37_dager
  kompetanse_over_3 kompetanse_under_3 kompetanse_under_2 antall_omdisponerte_31
  antall_kompetanse_over_3 antall_kompetanse_under_3_til_2 beredskapshåndtering_kompetanse_relatert_faktor_multiplikator beredskapshåndtering_kompetanse_relatert_faktor
  stress_nivå belegg belegg_stress_beregning døde friskmeldte_pasienter antall_covid-19_pasienter kompetanse_faktor kompetanse_faktor_arbeid antall_kompetanse_under_3 antall_kompetanse_under_2_til_1
  stress_faktor_sykepleier minus_stress_faktor_sykepleier_sykepleier stress_faktor_sykepleier_omdisponert stress_faktor_omdisponert stress_faktor_omdisponert_omdisponert
  stress_faktor_belegg_under_1 stress_faktor_belegg_under2 minus_stress_faktor_belegg_over2 akseptabelt_stress_nivå minus_stress_faktor_ingen_pasienter kritiskt_stress_nivå sykemelding_stress_nivå konstant_stress_nivå
  sykdoms_faktor_sykepleier_sykepleier sykdoms_faktor_sykepleier_omdisponert sykdoms_faktor_omdisponert_omdisponert sykdoms_faktor_pasient_økning_dag sykdoms_faktor5
  statistisk_normal_starten statistisk_intensiv_starten liggetid_normal_pasienter probability-list_starten farge_intensiv_sykepleier farge_omdisponert farge_intensiv_pasient
  farge_normal_pasient farge_normal_pleier farge_frisk_pasient stress_sannsynlighet_stress stress_sannsynlighet1_mindre stress_sannsynlighet-liste lengde_opphold_ut_av_intensiv
  sykdoms_faktor_kan_ikke_utskrives sykdoms_faktor_sykepleier sykdoms_faktor_omdisponert statistisk_døds_sannsynlighet_intensiv statistisk_ikke_dø_intensiv probability-list_død_intensiv
  åpen_fil
]

turtles-own [
  stress kompetanse sykdom sykhet frisk lengde_opphold kurs_dager stress_faktor normalisering intensiv_pasient_vendepunkt_verdi
]

breed [ sykepleiere sykepleier ]
breed [ omdisponerte_sykepleiere omdisponert_sykepleier ]
breed [ pasienter pasient ]
breed [ friske_pasienter frisk_pasient ]
breed [ sykepleiere_opplæring sykepleier_opplæring]
breed [ intensiv_pasienter intensiv_pasient]
breed [ intensiv_pasienter_ikke_covid intensiv_pasient_ikke_covid]

extensions [csv rnd]

;; Stress som en funksjon av kompetanse, sykepleiere rundt og sykdom
;; stress alene = kompetanse / sykdom
;; stress sammen med kompetent sykepleier = (  sykdom / kompetanse ) - stressfaktor3
;; stress omdisp sykepleier = (sykdom / kompetanse) - stressfaktor 2

to setup
  ca
  file-close-all

  ;; for å kjøre simulasjonen bytt addressen under til der du har lasted ned input.csv og bagrunnsbilde.png

  file-open "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-høy.csv"
  import-pcolors "C:/Users/There/PycharmProjects/ABM---hospital/bakgrunnsbilde.png"

  ;; Endre åpen_fil til input csv filen
  set åpen_fil "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-høy.csv"


  set farge_intensiv_sykepleier 95.2
  set farge_omdisponert 115.2
  set farge_intensiv_pasient 28.8
  set farge_normal_pasient 18.6
  set farge_normal_pleier 42.6
  set farge_frisk_pasient 0



  set beredskapshåndtering  1000
  set beredskapshåndtering_stress_relatert 250
  set beredskapshåndtering_kompetanse_relatert 0
  set beredskapshåndtering_døds_relatert 250
  set beredskapshåndtering_kommunikasjon 250
  set multipliserende_faktor_kommunikasjon 10
  set beredskapshåndtering_totaldødlighet 0.029
  set beredskapshåndtering_forventa_døde_37_dager 6
  set beredskapshåndtering_forventa_døde_52_dager 6
  set beredskapshåndtering_forventa_døde_82_dager 6
  set beredskapshåndtering_døds_relatert_multiplikator 2
  if "C:/Users/There/PycharmProjects/ABM---hospital/input.csv" = åpen_fil [set beredskapshåndtering_forventa_døde_52_dager (1 + 5 )]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-lav.csv" = åpen_fil [set beredskapshåndtering_forventa_døde_52_dager (24 + 5 )]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-høy.csv" = åpen_fil [set beredskapshåndtering_forventa_døde_52_dager (27 + 5 )]

  set kompetanse_over_3 10
  set kompetanse_under_3 5
  set kompetanse_under_2 2


  set kompetanse_faktor_arbeid 0.01
  set kompetanse_faktor 0.05
  ;set kompetanse faktor random range 5

  set minus_stress_faktor_sykepleier_sykepleier 1
  set minus_stress_faktor_belegg_over2 1

  set stress_faktor_sykepleier 2
  set stress_faktor_sykepleier_omdisponert 1
  set stress_faktor_omdisponert 10
  set stress_faktor_omdisponert_omdisponert 5
  set stress_faktor_belegg_under_1 3
  set stress_faktor_belegg_under2 2

  set konstant_stress_nivå 30
  set akseptabelt_stress_nivå 50
  set kritiskt_stress_nivå 70
  set sykemelding_stress_nivå 95
  set minus_stress_faktor_ingen_pasienter 1

  set sykdoms_faktor_sykepleier_sykepleier 2
  set sykdoms_faktor_sykepleier_omdisponert 1
  set sykdoms_faktor_omdisponert_omdisponert 0.5
  set sykdoms_faktor_sykepleier 0.8
  set sykdoms_faktor_omdisponert 0.2
  set sykdoms_faktor_pasient_økning_dag 6 + (random-float 3)
  set sykdoms_faktor_kan_ikke_utskrives 90
  set lengde_opphold_ut_av_intensiv 16
  set statistisk_intensiv 0.0743101495087931
  set statistisk_normal 0.925689850491207
  set statistisk_intensiv_starten 0.5
  set statistisk_normal_starten 0.5
  set probability-list (list (list 1 statistisk_intensiv) (list 0 statistisk_normal) )
  set probability-list_starten (list ( list 1 statistisk_intensiv_starten) (list 0 statistisk_normal_starten) )
  set stress_sannsynlighet_stress 0.907
  set stress_sannsynlighet1_mindre 0.093
  set stress_sannsynlighet-liste (list (list 1 stress_sannsynlighet_stress) (list 0 stress_sannsynlighet1_mindre) )
  set antall_intensiv_pasienter 0
  set liggetid_normal_pasienter 6
  set statistisk_døds_sannsynlighet_intensiv 0.03
  set statistisk_ikke_dø_intensiv 0.97
  set probability-list_død_intensiv (list (list 1 statistisk_døds_sannsynlighet_intensiv) (list 0 statistisk_ikke_dø_intensiv) )
  set antall_omdisponerte count intensiv_pasienter
  set antall_die 0

  reset-ticks

  create-sykepleiere (fast_ansatt_intensiv - (0.5 + antall_i_ren_intensiv_sone)) [
    setxy random xcor random ycor
    move-to one-of patches with [pcolor = farge_intensiv_sykepleier]
    set color blue
    set shape "person"
    set kompetanse 5
    set stress 0
  ]
    create-sykepleiere_opplæring Antall_omdisponerte_ved_pandemi_start [
  setxy random-xcor random-ycor
    move-to one-of patches with [pcolor = farge_omdisponert]
    set color yellow
    set shape "person"
    set kompetanse random-float 1
    set stress random 4
  ]

  ask sykepleiere [
      move-to one-of patches with [pcolor = farge_intensiv_sykepleier]]

  ask sykepleiere_opplæring [
    move-to one-of patches with [pcolor = farge_omdisponert]]



end

to go-1

  if ticks = 60 [ stop ]
  set beredskapshåndtering_stress_relatert_ticks 0
  ;; Her gjennomføres opplæring for omdisponerte sykepleiere og stress påvirkning settes etter sannsynlighet

  ask sykepleiere_opplæring [set kurs_dager kurs_dager + 1 set kompetanse kompetanse + kompetanse_faktor ]

  ask sykepleiere_opplæring [if kurs_dager > 5 and first rnd:weighted-one-of-list stress_sannsynlighet-liste [ [p] -> last p ] = 0
    [set breed omdisponerte_sykepleiere set color yellow set shape "person" set stress_faktor 0.5 ]]
  ask sykepleiere_opplæring [if kurs_dager > 5 and first rnd:weighted-one-of-list stress_sannsynlighet-liste [ [p] -> last p ] = 1
    [set breed omdisponerte_sykepleiere set color yellow set shape "person" set stress_faktor 1 ]]

   if ticks = 3 [create-omdisponerte_sykepleiere 3 [
  setxy random-xcor random-ycor
    move-to one-of patches with [pcolor = farge_omdisponert]
    set color yellow
    set shape "person"
    set kompetanse (3 + random-float 1)
    set stress random 4
  ]]


;; Her kjøres det sannynlighets beregning for om normal pasient blir intensiv pasient.





  ask pasienter [
    if lengde_opphold = liggetid_normal_pasienter or lengde_opphold > liggetid_normal_pasienter and
    first rnd:weighted-one-of-list probability-list [ [p] -> last p ] = 0 [
     set breed friske_pasienter set color white set shape "person" move-to one-of patches with [pcolor = farge_frisk_pasient]]


    if first rnd:weighted-one-of-list probability-list [ [p] -> last p ] = 1[
      set breed intensiv_pasienter set antall_intensiv_pasienter antall_intensiv_pasienter + 1 set intensiv_pasient_vendepunkt_verdi (random 15) + 10
      set color red set shape "person"
      move-to one-of patches with [pcolor = farge_intensiv_pasient]
      ]


      set lengde_opphold lengde_opphold + 1
  ]

   ;; Her lages normal pasienter fra input.csv

  if file-at-end? [ stop ]
  set antall_covid-19_pasienter file-read
  create-pasienter antall_covid-19_pasienter [
    setxy random-xcor random-ycor
    move-to one-of patches with [pcolor = farge_normal_pasient]
    set color green
    set shape "person"
    set sykdom 0
  ]

  ;; Her gjøres intensivpasienter til normal pasienter hvis sykdom er lavere en sykdoms_faktor4

  ask intensiv_pasienter [
    if lengde_opphold = lengde_opphold_ut_av_intensiv and sykdom < sykdoms_faktor_kan_ikke_utskrives [set breed pasienter set color green set shape "person" move-to one-of patches with [pcolor = farge_normal_pasient]]
    set lengde_opphold lengde_opphold + 1
  ]


  ;; Her lages intensiv_pasienter for å få opp antallet pasienter, kun for teste formål

 ; if count pasienter > 5 [if count intensiv_pasienter < 2 [ask n-of 3 pasienter [set breed intensiv_pasienter set color red set shape "person" move-to one-of patches with [pcolor = farge_intensiv_pasient] set antall_intensiv_pasienter antall_intensiv_pasienter + 1 set intensiv_pasient_vendepunkt_verdi (random 15) + 10 ]
  ;]]


  ;; flytting av sykepleiere her
  ask intensiv_pasienter [if count sykepleiere-on neighbors > 2 [ask one-of sykepleiere-on neighbors [move-to one-of patches with [pcolor = farge_intensiv_sykepleier]]]]
  if count intensiv_pasienter > 0 [ask sykepleiere [
    while [not any? intensiv_pasienter-on neighbors] [move-to one-of patches with [pcolor = farge_intensiv_sykepleier]]]]
  if count intensiv_pasienter > 0 [ask omdisponerte_sykepleiere [while [not any? intensiv_pasienter-on neighbors] [move-to one-of patches with [pcolor = farge_omdisponert]]]]
  ask intensiv_pasienter [if count sykepleiere-on neighbors > 2 [ask one-of sykepleiere-on neighbors [move-to one-of patches with [pcolor = farge_intensiv_sykepleier]]]]

  ;; Her skjer stress beregninger



  ask sykepleiere [
    if any? sykepleiere-on neighbors [set stress stress - minus_stress_faktor_sykepleier_sykepleier]

    if not any? sykepleiere-on neighbors and not any? omdisponerte_sykepleiere-on neighbors and any? pasienter-on neighbors and sum [sykdom] of turtles-on neighbors > 0
    [set stress stress + stress_faktor_sykepleier ]
    if not any? sykepleiere-on neighbors and any? omdisponerte_sykepleiere-on neighbors and any? pasienter-on neighbors and sum [sykdom] of turtles-on neighbors > 0
    [set stress stress + stress_faktor_sykepleier_omdisponert ]





    if stress < 50 and  belegg_stress_beregning < 1 [set stress stress + stress_faktor_belegg_under_1]
    if stress < 50 and  belegg_stress_beregning < 2 and belegg_stress_beregning > 1 [set stress stress + stress_faktor_belegg_under2]
    if count intensiv_pasienter > 50 and (count sykepleiere + count omdisponerte_sykepleiere) > (count intensiv_pasienter) [set stress stress + stress_faktor_belegg_under_1]
    if belegg_stress_beregning > 2 or belegg_stress_beregning = 2 [set stress stress - minus_stress_faktor_belegg_over2]
    if ticks = 37 [set stress stress - 5]
    if stress > akseptabelt_stress_nivå and stress < kritiskt_stress_nivå [set beredskapshåndtering_stress_relatert_ticks beredskapshåndtering_stress_relatert_ticks + 1]
    if stress > kritiskt_stress_nivå and stress < sykemelding_stress_nivå [set beredskapshåndtering_stress_relatert_ticks beredskapshåndtering_stress_relatert_ticks + 5]
    if stress > sykemelding_stress_nivå [set beredskapshåndtering_stress_relatert_ticks beredskapshåndtering_stress_relatert_ticks + 20 die]
    if stress < konstant_stress_nivå [set stress konstant_stress_nivå]
  ]


  ask omdisponerte_sykepleiere [
    if any? sykepleiere-on neighbors and not any? pasienter-on neighbors [set stress stress - minus_stress_faktor_ingen_pasienter]

    if not any? sykepleiere-on neighbors and not any? omdisponerte_sykepleiere-on neighbors and any? pasienter-on neighbors and sum [sykdom] of turtles-on neighbors > 0
    [set stress stress + (sum [sykdom] of intensiv_pasienter-on neighbors / kompetanse) ]

    if not any? sykepleiere-on neighbors and any? omdisponerte_sykepleiere-on neighbors and any? pasienter-on neighbors and sum [sykdom] of turtles-on neighbors > 0
    [set stress stress + (sum [sykdom] of intensiv_pasienter-on neighbors / kompetanse) ]



    if stress < 50 and belegg_stress_beregning < 1 [set stress stress + stress_faktor_belegg_under_1]
    if stress < 50 and belegg_stress_beregning < 2 and belegg_stress_beregning > 1 [set stress stress + stress_faktor_belegg_under2]
    if count intensiv_pasienter > 50 and (count sykepleiere + count omdisponerte_sykepleiere) > (count intensiv_pasienter) [set stress stress + stress_faktor_belegg_under_1]
    if belegg_stress_beregning > 2 [set stress stress - minus_stress_faktor_belegg_over2]
    if ticks = 37 [set stress stress - 5]
    if stress < konstant_stress_nivå [set stress konstant_stress_nivå]
    if stress > akseptabelt_stress_nivå and stress < kritiskt_stress_nivå [set beredskapshåndtering_stress_relatert_ticks beredskapshåndtering_stress_relatert_ticks + 1]
    if stress > kritiskt_stress_nivå and stress < sykemelding_stress_nivå [set beredskapshåndtering_stress_relatert_ticks beredskapshåndtering_stress_relatert_ticks + 5]
    if stress > sykemelding_stress_nivå [set beredskapshåndtering_stress_relatert_ticks beredskapshåndtering_stress_relatert_ticks + 20 die]
    if kompetanse < 10 [set kompetanse kompetanse + kompetanse_faktor_arbeid]
    if kompetanse > 10 [set kompetanse 10]
    set lengde_opphold lengde_opphold + 1
  ]
  if beredskapshåndtering_stress_relatert < 0 [set beredskapshåndtering_stress_relatert 0]

  ;; Her skjer sykdoms beregninger


  ask intensiv_pasienter [set sykdom sykdom + sykdoms_faktor_pasient_økning_dag ]

  ask intensiv_pasienter [
    if count sykepleiere-on neighbors > 2 and not any? omdisponerte_sykepleiere-on neighbors [set sykdom sykdom - sykdoms_faktor_sykepleier_sykepleier]
    if count sykepleiere-on neighbors = 1 and not any? omdisponerte_sykepleiere-on neighbors [set sykdom sykdom - sykdoms_faktor_sykepleier]
    if count omdisponerte_sykepleiere-on neighbors > 1 and not any? sykepleiere-on neighbors [set sykdom sykdom - ((count omdisponerte_sykepleiere-on neighbors / sum [kompetanse] of omdisponerte_sykepleiere-on neighbors) * 2)]
    if count omdisponerte_sykepleiere-on neighbors = 1 and not any? sykepleiere-on neighbors [set sykdom sykdom - (sum [kompetanse] of omdisponerte_sykepleiere-on neighbors)]
    if count omdisponerte_sykepleiere-on neighbors = 1 and count sykepleiere-on neighbors = 1 [set sykdom sykdom - (sum [kompetanse] of omdisponerte_sykepleiere-on neighbors + sykdoms_faktor_sykepleier)]


    if sykdom > 80  and first rnd:weighted-one-of-list probability-list_død_intensiv [ [p] -> last p ] = 1 [ set døde døde + 1 set dynamisk_intensiv_pasienter dynamisk_intensiv_pasienter - 1 set døde_beredskap døde_beredskap + 1  die]
  ]

    ;; Her justeres måltall og friske pasienter blir borte


  ask friske_pasienter [
    if frisk = 1 [set friskmeldte_pasienter friskmeldte_pasienter + 1 die]
    set frisk frisk + 1
  ]

  ask pasienter [
     set lengde_opphold lengde_opphold + 1
  ]
;; Denne justerer størrelsen på agentene etter stress

  let stress-list sort-on [ stress ] turtles let new-size 1 foreach stress-list [x -> ask x [set size new-size set new-size new-size + 0.01]]



  ;; Her beregnes belegg
  if count intensiv_pasienter > 0 [set belegg_stress_beregning (count sykepleiere / count intensiv_pasienter) ]
  if count intensiv_pasienter > 0 [set belegg (count sykepleiere + count omdisponerte_sykepleiere)  / count intensiv_pasienter]
  if count intensiv_pasienter = 0 [set belegg 10]
  if count intensiv_pasienter < 0 [set belegg 10]


  ;; Her trigges omdisponering av ansatte
  set antall_omdisponerte count intensiv_pasienter
  set antall_die antall_omdisponerte - 30


  if count omdisponerte_sykepleiere = 30 or count omdisponerte_sykepleiere < 30 and belegg < Trigger_omdisponering_sykepleiere_per_pasient or belegg = Trigger_omdisponering_sykepleiere_per_pasient and count sykepleiere_opplæring < 5 [create-omdisponerte_sykepleiere 5 [set color yellow set shape "person" set kompetanse (1 + random-float 1) set stress random 4 move-to one-of patches with [pcolor = farge_normal_pasient]]]
  if count omdisponerte_sykepleiere > 5 and belegg > Trigger_normalisering_sykepleiere_per_pasient and count pasienter < 30 [ask n-of 5 omdisponerte_sykepleiere [set normalisering normalisering + 1 ]]
  ask omdisponerte_sykepleiere [if normalisering = 3 [die]]
  ;if count omdisponerte_sykepleiere > 30 [ask n-of (antall_die) omdisponerte_sykepleiere die]



  ;; Her oppdateres beredskaps_vellykkethet




  ;; kommunikasjon
  if (antall_motstridende_beskjeder * antall_ledelsesorganer * multipliserende_faktor_kommunikasjon) = 250 or (antall_motstridende_beskjeder * antall_ledelsesorganer * multipliserende_faktor_kommunikasjon) > 250 [set beredskapshåndtering_kommunikasjon 0]
  if ticks = 10 [set beredskapshåndtering_kommunikasjon beredskapshåndtering_kommunikasjon - (antall_motstridende_beskjeder * antall_ledelsesorganer * multipliserende_faktor_kommunikasjon) ]
  if (antall_motstridende_beskjeder * antall_ledelsesorganer * multipliserende_faktor_kommunikasjon) = 250 or (antall_motstridende_beskjeder * antall_ledelsesorganer * multipliserende_faktor_kommunikasjon) > 250 [set beredskapshåndtering_kommunikasjon 0]
  if ticks = 10 [set beredskapshåndtering_kommunikasjon beredskapshåndtering_kommunikasjon - (antall_motstridende_beskjeder_ppe * antall_ledelsesorganer_ppe * multipliserende_faktor_kommunikasjon) ]

  ;; stress
  if beredskapshåndtering_stress_relatert > 0 and ( beredskapshåndtering_stress_relatert - beredskapshåndtering_stress_relatert_ticks) > 0 [set beredskapshåndtering_stress_relatert beredskapshåndtering_stress_relatert - beredskapshåndtering_stress_relatert_ticks]
  if beredskapshåndtering_stress_relatert > 0 and ( beredskapshåndtering_stress_relatert - beredskapshåndtering_stress_relatert_ticks) = 0 [set beredskapshåndtering_stress_relatert beredskapshåndtering_stress_relatert - beredskapshåndtering_stress_relatert_ticks]




  ;; kompetanse

  if ticks = 20 [ask omdisponerte_sykepleiere with [kompetanse < 5 and kompetanse >= 3  ] [set antall_kompetanse_over_3 antall_kompetanse_over_3 + 1] ]
  if ticks = 20 [ask omdisponerte_sykepleiere with [kompetanse < 3 and kompetanse >= 2  ]  [set antall_kompetanse_under_3_til_2 antall_kompetanse_under_3_til_2 + 1] ]
  if ticks = 20 [ask omdisponerte_sykepleiere with [kompetanse < 2 and kompetanse >= 1 ] [set antall_kompetanse_under_2_til_1 antall_kompetanse_under_2_til_1 + 1] ]


  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-lav.csv" = åpen_fil and ticks = 36 [ask omdisponerte_sykepleiere with [kompetanse < 5 and kompetanse >= 3  ] [set antall_kompetanse_over_3 antall_kompetanse_over_3 + 1] ]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-lav.csv" = åpen_fil and ticks = 36 [ask omdisponerte_sykepleiere with [kompetanse < 3 and kompetanse >= 2  ]  [set antall_kompetanse_under_3_til_2 antall_kompetanse_under_3_til_2 + 1] ]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-lav.csv" = åpen_fil and ticks = 36 [ask omdisponerte_sykepleiere with [kompetanse < 2 and kompetanse >= 1 ] [set antall_kompetanse_under_2_til_1 antall_kompetanse_under_2_til_1 + 1] ]




  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-høy.csv" = åpen_fil and ticks = 21 [ask omdisponerte_sykepleiere with [kompetanse < 5 and kompetanse >= 3  ] [set antall_kompetanse_over_3 antall_kompetanse_over_3 + 1] ]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-høy.csv" = åpen_fil and ticks = 21 [ask omdisponerte_sykepleiere with [kompetanse < 3 and kompetanse >= 2  ]  [set antall_kompetanse_under_3_til_2 antall_kompetanse_under_3_til_2 + 1] ]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-høy.csv" = åpen_fil and ticks = 21 [ask omdisponerte_sykepleiere with [kompetanse < 2 and kompetanse >= 1 ] [set antall_kompetanse_under_2_til_1 antall_kompetanse_under_2_til_1 + 1] ]


  if "C:/Users/There/PycharmProjects/ABM---hospital/input.csv" = åpen_fil and ticks = 20 [ask omdisponerte_sykepleiere with [kompetanse < 5 and kompetanse >= 3  ] [set antall_kompetanse_over_3 antall_kompetanse_over_3 + 1] ]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input.csv" = åpen_fil and ticks = 20 [ask omdisponerte_sykepleiere with [kompetanse < 3 and kompetanse >= 2  ]  [set antall_kompetanse_under_3_til_2 antall_kompetanse_under_3_til_2 + 1] ]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input.csv" = åpen_fil and ticks = 20 [ask omdisponerte_sykepleiere with [kompetanse < 2 and kompetanse >= 1 ] [set antall_kompetanse_under_2_til_1 antall_kompetanse_under_2_til_1 + 1] ]

  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-lav.csv" = åpen_fil and ticks = 36 [set beredskapshåndtering_kompetanse_relatert_faktor ((antall_kompetanse_over_3 * kompetanse_over_3) + (antall_kompetanse_under_3_til_2 * kompetanse_under_3) + (antall_kompetanse_under_2_til_1 * kompetanse_under_2))]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-lav.csv" = åpen_fil and ticks = 36 and beredskapshåndtering_kompetanse_relatert_faktor < 250 or beredskapshåndtering_kompetanse_relatert_faktor = 250  [set beredskapshåndtering_kompetanse_relatert beredskapshåndtering_kompetanse_relatert_faktor]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-lav.csv" = åpen_fil and ticks = 36 and beredskapshåndtering_kompetanse_relatert_faktor > 250  [set beredskapshåndtering_kompetanse_relatert 250]

  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-høy.csv" = åpen_fil and ticks = 21[set beredskapshåndtering_kompetanse_relatert_faktor ((antall_kompetanse_over_3 * kompetanse_over_3) + (antall_kompetanse_under_3_til_2 * kompetanse_under_3) + (antall_kompetanse_under_2_til_1 * kompetanse_under_2))]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-høy.csv" = åpen_fil and ticks = 21 and beredskapshåndtering_kompetanse_relatert_faktor < 250 or beredskapshåndtering_kompetanse_relatert_faktor = 250  [set beredskapshåndtering_kompetanse_relatert beredskapshåndtering_kompetanse_relatert_faktor]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-høy.csv" = åpen_fil and ticks = 21 and beredskapshåndtering_kompetanse_relatert_faktor > 250  [set beredskapshåndtering_kompetanse_relatert 250]

  if "C:/Users/There/PycharmProjects/ABM---hospital/input.csv" = åpen_fil and ticks = 20 [set beredskapshåndtering_kompetanse_relatert_faktor ((antall_kompetanse_over_3 * kompetanse_over_3) + (antall_kompetanse_under_3_til_2 * kompetanse_under_3) + (antall_kompetanse_under_2_til_1 * kompetanse_under_2))]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input.csv" = åpen_fil and ticks = 20 and beredskapshåndtering_kompetanse_relatert_faktor < 250 or beredskapshåndtering_kompetanse_relatert_faktor = 250  [set beredskapshåndtering_kompetanse_relatert beredskapshåndtering_kompetanse_relatert_faktor]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input.csv" = åpen_fil and ticks = 20 and beredskapshåndtering_kompetanse_relatert_faktor > 250  [set beredskapshåndtering_kompetanse_relatert 250]

  if ticks = 20 [set beredskapshåndtering_kompetanse_relatert_faktor ((antall_kompetanse_over_3 * kompetanse_over_3) + (antall_kompetanse_under_3_til_2 * kompetanse_under_3) + (antall_kompetanse_under_2_til_1 * kompetanse_under_2))]

  if ticks = 20 and beredskapshåndtering_kompetanse_relatert_faktor < 250 or beredskapshåndtering_kompetanse_relatert_faktor = 250  [set beredskapshåndtering_kompetanse_relatert beredskapshåndtering_kompetanse_relatert_faktor]

  if ticks = 20 and beredskapshåndtering_kompetanse_relatert_faktor > 250  [set beredskapshåndtering_kompetanse_relatert 250]

  ;; døde
  if ticks = 59 and døde > beredskapshåndtering_forventa_døde_52_dager and ( (døde - beredskapshåndtering_forventa_døde_52_dager) * beredskapshåndtering_døds_relatert_multiplikator ) < 250 [set beredskapshåndtering_døds_relatert beredskapshåndtering_døds_relatert - ( (døde - beredskapshåndtering_forventa_døde_52_dager) * beredskapshåndtering_døds_relatert_multiplikator ) ]
  if ticks = 59 and døde > beredskapshåndtering_forventa_døde_52_dager and ( (døde - beredskapshåndtering_forventa_døde_52_dager) * beredskapshåndtering_døds_relatert_multiplikator ) = 250 [set beredskapshåndtering_døds_relatert 0]
  if ticks = 59 and døde = (157 - beredskapshåndtering_forventa_døde_52_dager) or døde > (157 - beredskapshåndtering_forventa_døde_52_dager)  [set beredskapshåndtering_døds_relatert 0 ]


  if ticks = 59 [set beredskapshåndtering beredskapshåndtering - (250 - beredskapshåndtering_kompetanse_relatert)]
  if ticks = 59 [set beredskapshåndtering beredskapshåndtering - (250 - beredskapshåndtering_stress_relatert) ]
  if ticks = 59 [set beredskapshåndtering beredskapshåndtering - (250 - beredskapshåndtering_kommunikasjon)]
  if ticks = 59 [set beredskapshåndtering beredskapshåndtering - (250 - beredskapshåndtering_døds_relatert)]

  if beredskapshåndtering = 1000 or (beredskapshåndtering > 900) [set beredskaps_vellykkethet 10]
  if beredskapshåndtering = 900 or (beredskapshåndtering > 800 and beredskapshåndtering < 900) [set beredskaps_vellykkethet 9]
  if beredskapshåndtering = 800 or (beredskapshåndtering > 700 and beredskapshåndtering < 800) [set beredskaps_vellykkethet 8]
  if beredskapshåndtering = 700 or (beredskapshåndtering > 600 and beredskapshåndtering < 700) [set beredskaps_vellykkethet 7]
  if beredskapshåndtering = 600 or (beredskapshåndtering > 500 and beredskapshåndtering < 600) [set beredskaps_vellykkethet 6]
  if beredskapshåndtering = 500 or (beredskapshåndtering > 400 and beredskapshåndtering < 500) [set beredskaps_vellykkethet 5]
  if beredskapshåndtering = 400 or (beredskapshåndtering > 300 and beredskapshåndtering < 400) [set beredskaps_vellykkethet 4]
  if beredskapshåndtering = 300 or (beredskapshåndtering > 200 and beredskapshåndtering < 300) [set beredskaps_vellykkethet 3]
  if beredskapshåndtering = 200 or (beredskapshåndtering > 100 and beredskapshåndtering < 200) [set beredskaps_vellykkethet 2]
  if beredskapshåndtering = 100 or (beredskapshåndtering > 000 and beredskapshåndtering < 100) [set beredskaps_vellykkethet 1]
  if beredskapshåndtering < 000 [set beredskaps_vellykkethet 0]
  tick

end

to go-2
;; Legge inn r-tall modell for pasienter



  if file-at-end? [ stop ]
  create-pasienter antall_covid-19_pasienter [
    setxy random-xcor random-ycor
    move-to one-of patches with [pcolor = farge_normal_pasient]
    set color green
    set shape "person"
    set sykdom random 5
  ]

end

to go-3
  ;; Driftsutvalget


  if ticks = 60 [ stop ]
  set beredskapshåndtering_stress_relatert_ticks 0
  ;; Her gjennomføres opplæring for omdisponerte sykepleiere og stress påvirkning settes etter sannsynlighet

  ask sykepleiere_opplæring [set kurs_dager kurs_dager + 1 set kompetanse kompetanse + kompetanse_faktor ]

  ask sykepleiere_opplæring [if kurs_dager > 5 and first rnd:weighted-one-of-list stress_sannsynlighet-liste [ [p] -> last p ] = 0
    [set breed omdisponerte_sykepleiere set color yellow set shape "person" set stress_faktor 0.5 ]]
  ask sykepleiere_opplæring [if kurs_dager > 5 and first rnd:weighted-one-of-list stress_sannsynlighet-liste [ [p] -> last p ] = 1
    [set breed omdisponerte_sykepleiere set color yellow set shape "person" set stress_faktor 1 ]]

   if ticks = 3 [create-omdisponerte_sykepleiere 3 [
  setxy random-xcor random-ycor
    move-to one-of patches with [pcolor = farge_omdisponert]
    set color yellow
    set shape "person"
    set kompetanse (3 + random-float 1)
    set stress random 4
  ]]


;; Her kjøres det sannynlighets beregning for om normal pasient blir intensiv pasient.





  ask pasienter [
    if lengde_opphold = liggetid_normal_pasienter or lengde_opphold > liggetid_normal_pasienter and
    first rnd:weighted-one-of-list probability-list [ [p] -> last p ] = 0 [
     set breed friske_pasienter set color white set shape "person" move-to one-of patches with [pcolor = farge_frisk_pasient]]


    if first rnd:weighted-one-of-list probability-list [ [p] -> last p ] = 1[
      set breed intensiv_pasienter set antall_intensiv_pasienter antall_intensiv_pasienter + 1 set intensiv_pasient_vendepunkt_verdi (random 15) + 10
      set color red set shape "person"
      move-to one-of patches with [pcolor = farge_intensiv_pasient]
      ]


      set lengde_opphold lengde_opphold + 1
  ]

   ;; Her lages normal pasienter fra input.csv

  if file-at-end? [ stop ]
  set antall_covid-19_pasienter file-read
  create-pasienter antall_covid-19_pasienter [
    setxy random-xcor random-ycor
    move-to one-of patches with [pcolor = farge_normal_pasient]
    set color green
    set shape "person"
    set sykdom 0
  ]

  ;; Her gjøres intensivpasienter til normal pasienter hvis sykdom er lavere en sykdoms_faktor4

  ask intensiv_pasienter [
    if lengde_opphold = lengde_opphold_ut_av_intensiv and sykdom < sykdoms_faktor_kan_ikke_utskrives [set breed pasienter set color green set shape "person" move-to one-of patches with [pcolor = farge_normal_pasient]]
    set lengde_opphold lengde_opphold + 1
  ]


  ;; Her lages intensiv_pasienter for å få opp antallet pasienter, kun for teste formål

 ; if count pasienter > 5 [if count intensiv_pasienter < 2 [ask n-of 3 pasienter [set breed intensiv_pasienter set color red set shape "person" move-to one-of patches with [pcolor = farge_intensiv_pasient] set antall_intensiv_pasienter antall_intensiv_pasienter + 1 set intensiv_pasient_vendepunkt_verdi (random 15) + 10 ]
  ;]]


  ;; flytting av sykepleiere her
  ask intensiv_pasienter [if count sykepleiere-on neighbors > 2 [ask one-of sykepleiere-on neighbors [move-to one-of patches with [pcolor = farge_intensiv_sykepleier]]]]
  if count intensiv_pasienter > 0 [ask sykepleiere [
    while [not any? intensiv_pasienter-on neighbors] [move-to one-of patches with [pcolor = farge_intensiv_sykepleier]]]]
  if count intensiv_pasienter > 0 [ask omdisponerte_sykepleiere [while [not any? intensiv_pasienter-on neighbors] [move-to one-of patches with [pcolor = farge_omdisponert]]]]
  ask intensiv_pasienter [if count sykepleiere-on neighbors > 2 [ask one-of sykepleiere-on neighbors [move-to one-of patches with [pcolor = farge_intensiv_sykepleier]]]]

  ;; Her skjer stress beregninger



  ask sykepleiere [
    if any? sykepleiere-on neighbors [set stress stress - minus_stress_faktor_sykepleier_sykepleier]

    if not any? sykepleiere-on neighbors and not any? omdisponerte_sykepleiere-on neighbors and any? pasienter-on neighbors and sum [sykdom] of turtles-on neighbors > 0
    [set stress stress + stress_faktor_sykepleier ]
    if not any? sykepleiere-on neighbors and any? omdisponerte_sykepleiere-on neighbors and any? pasienter-on neighbors and sum [sykdom] of turtles-on neighbors > 0
    [set stress stress + stress_faktor_sykepleier_omdisponert ]





    if stress < 50 and  belegg_stress_beregning < 1 [set stress stress + stress_faktor_belegg_under_1]
    if stress < 50 and  belegg_stress_beregning < 2 and belegg_stress_beregning > 1 [set stress stress + stress_faktor_belegg_under2]
    if belegg_stress_beregning > 2 or belegg_stress_beregning = 2 [set stress stress - minus_stress_faktor_belegg_over2]
    if ticks = 37 [set stress stress - 5]
    if stress > akseptabelt_stress_nivå and stress < kritiskt_stress_nivå [set beredskapshåndtering_stress_relatert_ticks beredskapshåndtering_stress_relatert_ticks + 1]
    if stress > kritiskt_stress_nivå and stress < sykemelding_stress_nivå [set beredskapshåndtering_stress_relatert_ticks beredskapshåndtering_stress_relatert_ticks + 5]
    if stress > sykemelding_stress_nivå [set beredskapshåndtering_stress_relatert_ticks beredskapshåndtering_stress_relatert_ticks + 20 die]
    if stress < konstant_stress_nivå [set stress konstant_stress_nivå]
  ]


  ask omdisponerte_sykepleiere [
    if any? sykepleiere-on neighbors and not any? pasienter-on neighbors [set stress stress - minus_stress_faktor_ingen_pasienter]

    if not any? sykepleiere-on neighbors and not any? omdisponerte_sykepleiere-on neighbors and any? pasienter-on neighbors and sum [sykdom] of turtles-on neighbors > 0
    [set stress stress + (sum [sykdom] of intensiv_pasienter-on neighbors / kompetanse) ]

    if not any? sykepleiere-on neighbors and any? omdisponerte_sykepleiere-on neighbors and any? pasienter-on neighbors and sum [sykdom] of turtles-on neighbors > 0
    [set stress stress + (sum [sykdom] of intensiv_pasienter-on neighbors / kompetanse) ]



    if stress < 50 and belegg_stress_beregning < 1 [set stress stress + stress_faktor_belegg_under_1]
    if stress < 50 and belegg_stress_beregning < 2 and belegg_stress_beregning > 1 [set stress stress + stress_faktor_belegg_under2]
    if belegg_stress_beregning > 2 [set stress stress - minus_stress_faktor_belegg_over2]
    if ticks = 37 [set stress stress - 5]
    if stress < konstant_stress_nivå [set stress konstant_stress_nivå]
    if stress > akseptabelt_stress_nivå and stress < kritiskt_stress_nivå [set beredskapshåndtering_stress_relatert_ticks beredskapshåndtering_stress_relatert_ticks + 1]
    if stress > kritiskt_stress_nivå and stress < sykemelding_stress_nivå [set beredskapshåndtering_stress_relatert_ticks beredskapshåndtering_stress_relatert_ticks + 5]
    if stress > sykemelding_stress_nivå [set beredskapshåndtering_stress_relatert_ticks beredskapshåndtering_stress_relatert_ticks + 20 die]
    if kompetanse < 10 [set kompetanse kompetanse + kompetanse_faktor_arbeid]
    if kompetanse > 10 [set kompetanse 10]
    set lengde_opphold lengde_opphold + 1
  ]
  if beredskapshåndtering_stress_relatert < 0 [set beredskapshåndtering_stress_relatert 0]

  ;; Her skjer sykdoms beregninger


  ask intensiv_pasienter [set sykdom sykdom + sykdoms_faktor_pasient_økning_dag ]

  ask intensiv_pasienter [
    if count sykepleiere-on neighbors > 2 and not any? omdisponerte_sykepleiere-on neighbors [set sykdom sykdom - sykdoms_faktor_sykepleier_sykepleier]
    if count sykepleiere-on neighbors = 1 and not any? omdisponerte_sykepleiere-on neighbors [set sykdom sykdom - sykdoms_faktor_sykepleier]
    if count omdisponerte_sykepleiere-on neighbors > 1 and not any? sykepleiere-on neighbors [set sykdom sykdom - ((count omdisponerte_sykepleiere-on neighbors / sum [kompetanse] of omdisponerte_sykepleiere-on neighbors) * 2)]
    if count omdisponerte_sykepleiere-on neighbors = 1 and not any? sykepleiere-on neighbors [set sykdom sykdom - (sum [kompetanse] of omdisponerte_sykepleiere-on neighbors)]
    if count omdisponerte_sykepleiere-on neighbors = 1 and count sykepleiere-on neighbors = 1 [set sykdom sykdom - (sum [kompetanse] of omdisponerte_sykepleiere-on neighbors + sykdoms_faktor_sykepleier)]


    if sykdom > 80  and first rnd:weighted-one-of-list probability-list_død_intensiv [ [p] -> last p ] = 1 [ set døde døde + 1 set dynamisk_intensiv_pasienter dynamisk_intensiv_pasienter - 1 set døde_beredskap døde_beredskap + 1  die]
  ]

    ;; Her justeres måltall og friske pasienter blir borte


  ask friske_pasienter [
    if frisk = 1 [set friskmeldte_pasienter friskmeldte_pasienter + 1 die]
    set frisk frisk + 1
  ]

  ask pasienter [
     set lengde_opphold lengde_opphold + 1
  ]
;; Denne justerer størrelsen på agentene etter stress

  let stress-list sort-on [ stress ] turtles let new-size 1 foreach stress-list [x -> ask x [set size new-size set new-size new-size + 0.01]]



  ;; Her beregnes belegg
  if count intensiv_pasienter > 0 [set belegg_stress_beregning (count sykepleiere / count intensiv_pasienter) ]
  if count intensiv_pasienter > 0 [set belegg (count sykepleiere + count omdisponerte_sykepleiere)  / count intensiv_pasienter]
  if count intensiv_pasienter = 0 [set belegg 10]
  if count intensiv_pasienter < 0 [set belegg 10]


  ;; Her trigges omdisponering av ansatte
  set antall_omdisponerte count intensiv_pasienter
  set antall_die antall_omdisponerte - 30


  if ticks > 0 and ticks < 31 and count omdisponerte_sykepleiere = 30 or count omdisponerte_sykepleiere < 30 and belegg < Trigger_omdisponering_sykepleiere_per_pasient or belegg = Trigger_omdisponering_sykepleiere_per_pasient and count sykepleiere_opplæring < 5 [create-omdisponerte_sykepleiere 5 [set color yellow set shape "person" set kompetanse (1 + random-float 1) set stress random 4 move-to one-of patches with [pcolor = farge_normal_pasient]]]
  if count omdisponerte_sykepleiere > 5 and belegg > Trigger_normalisering_sykepleiere_per_pasient and count pasienter < 30 [ask n-of 5 omdisponerte_sykepleiere [set normalisering normalisering + 1 ]]
  ;ask omdisponerte_sykepleiere [if normalisering = 3 [die]]
  ;if count omdisponerte_sykepleiere > 30 [ask n-of (antall_die) omdisponerte_sykepleiere die]



  ;; Her normaliseres sykehuset etter scenario
  if ticks = 31 [set antall_omdisponerte_31 (((count omdisponerte_sykepleiere) / 2) / 9)]

  if ticks > 31 and ticks < 40 [ask n-of (antall_omdisponerte_31) omdisponerte_sykepleiere [die]]


  ;; Her oppdateres beredskaps_vellykkethet




  ;; kommunikasjon
  if (antall_motstridende_beskjeder * antall_ledelsesorganer * multipliserende_faktor_kommunikasjon) = 250 or (antall_motstridende_beskjeder * antall_ledelsesorganer * multipliserende_faktor_kommunikasjon) > 250 [set beredskapshåndtering_kommunikasjon 0]
  if ticks = 10 [set beredskapshåndtering_kommunikasjon beredskapshåndtering_kommunikasjon - (antall_motstridende_beskjeder * antall_ledelsesorganer * multipliserende_faktor_kommunikasjon) ]
  if (antall_motstridende_beskjeder * antall_ledelsesorganer * multipliserende_faktor_kommunikasjon) = 250 or (antall_motstridende_beskjeder * antall_ledelsesorganer * multipliserende_faktor_kommunikasjon) > 250 [set beredskapshåndtering_kommunikasjon 0]
  if ticks = 10 [set beredskapshåndtering_kommunikasjon beredskapshåndtering_kommunikasjon - (antall_motstridende_beskjeder_ppe * antall_ledelsesorganer_ppe * multipliserende_faktor_kommunikasjon) ]

  ;; stress
  if beredskapshåndtering_stress_relatert > 0 and ( beredskapshåndtering_stress_relatert - beredskapshåndtering_stress_relatert_ticks) > 0 [set beredskapshåndtering_stress_relatert beredskapshåndtering_stress_relatert - beredskapshåndtering_stress_relatert_ticks]
  if beredskapshåndtering_stress_relatert > 0 and ( beredskapshåndtering_stress_relatert - beredskapshåndtering_stress_relatert_ticks) = 0 [set beredskapshåndtering_stress_relatert beredskapshåndtering_stress_relatert - beredskapshåndtering_stress_relatert_ticks]




  ;; kompetanse
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-lav.csv" = åpen_fil and ticks = 36 [ask omdisponerte_sykepleiere with [kompetanse < 5 and kompetanse >= 3  ] [set antall_kompetanse_over_3 antall_kompetanse_over_3 + 1] ]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-lav.csv" = åpen_fil and ticks = 36 [ask omdisponerte_sykepleiere with [kompetanse < 3 and kompetanse >= 2  ]  [set antall_kompetanse_under_3_til_2 antall_kompetanse_under_3_til_2 + 1] ]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-lav.csv" = åpen_fil and ticks = 36 [ask omdisponerte_sykepleiere with [kompetanse < 2 and kompetanse >= 1 ] [set antall_kompetanse_under_2_til_1 antall_kompetanse_under_2_til_1 + 1] ]




  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-høy.csv" = åpen_fil and ticks = 21 [ask omdisponerte_sykepleiere with [kompetanse < 5 and kompetanse >= 3  ] [set antall_kompetanse_over_3 antall_kompetanse_over_3 + 1] ]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-høy.csv" = åpen_fil and ticks = 21 [ask omdisponerte_sykepleiere with [kompetanse < 3 and kompetanse >= 2  ]  [set antall_kompetanse_under_3_til_2 antall_kompetanse_under_3_til_2 + 1] ]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-høy.csv" = åpen_fil and ticks = 21 [ask omdisponerte_sykepleiere with [kompetanse < 2 and kompetanse >= 1 ] [set antall_kompetanse_under_2_til_1 antall_kompetanse_under_2_til_1 + 1] ]


  if "C:/Users/There/PycharmProjects/ABM---hospital/input.csv" = åpen_fil and ticks = 20 [ask omdisponerte_sykepleiere with [kompetanse < 5 and kompetanse >= 3  ] [set antall_kompetanse_over_3 antall_kompetanse_over_3 + 1] ]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input.csv" = åpen_fil and ticks = 20 [ask omdisponerte_sykepleiere with [kompetanse < 3 and kompetanse >= 2  ]  [set antall_kompetanse_under_3_til_2 antall_kompetanse_under_3_til_2 + 1] ]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input.csv" = åpen_fil and ticks = 20 [ask omdisponerte_sykepleiere with [kompetanse < 2 and kompetanse >= 1 ] [set antall_kompetanse_under_2_til_1 antall_kompetanse_under_2_til_1 + 1] ]

  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-lav.csv" = åpen_fil and ticks = 36 [set beredskapshåndtering_kompetanse_relatert_faktor ((antall_kompetanse_over_3 * kompetanse_over_3) + (antall_kompetanse_under_3_til_2 * kompetanse_under_3) + (antall_kompetanse_under_2_til_1 * kompetanse_under_2))]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-lav.csv" = åpen_fil and ticks = 36 and beredskapshåndtering_kompetanse_relatert_faktor < 250 or beredskapshåndtering_kompetanse_relatert_faktor = 250  [set beredskapshåndtering_kompetanse_relatert beredskapshåndtering_kompetanse_relatert_faktor]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-lav.csv" = åpen_fil and ticks = 36 and beredskapshåndtering_kompetanse_relatert_faktor > 250  [set beredskapshåndtering_kompetanse_relatert 250]

  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-høy.csv" = åpen_fil and ticks = 21[set beredskapshåndtering_kompetanse_relatert_faktor ((antall_kompetanse_over_3 * kompetanse_over_3) + (antall_kompetanse_under_3_til_2 * kompetanse_under_3) + (antall_kompetanse_under_2_til_1 * kompetanse_under_2))]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-høy.csv" = åpen_fil and ticks = 21 and beredskapshåndtering_kompetanse_relatert_faktor < 250 or beredskapshåndtering_kompetanse_relatert_faktor = 250  [set beredskapshåndtering_kompetanse_relatert beredskapshåndtering_kompetanse_relatert_faktor]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-høy.csv" = åpen_fil and ticks = 21 and beredskapshåndtering_kompetanse_relatert_faktor > 250  [set beredskapshåndtering_kompetanse_relatert 250]

  if "C:/Users/There/PycharmProjects/ABM---hospital/input.csv" = åpen_fil and ticks = 20 [set beredskapshåndtering_kompetanse_relatert_faktor ((antall_kompetanse_over_3 * kompetanse_over_3) + (antall_kompetanse_under_3_til_2 * kompetanse_under_3) + (antall_kompetanse_under_2_til_1 * kompetanse_under_2))]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input.csv" = åpen_fil and ticks = 20 and beredskapshåndtering_kompetanse_relatert_faktor < 250 or beredskapshåndtering_kompetanse_relatert_faktor = 250  [set beredskapshåndtering_kompetanse_relatert beredskapshåndtering_kompetanse_relatert_faktor]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input.csv" = åpen_fil and ticks = 20 and beredskapshåndtering_kompetanse_relatert_faktor > 250  [set beredskapshåndtering_kompetanse_relatert 250]

   if ticks = 59 and døde > beredskapshåndtering_forventa_døde_52_dager and ( (døde - beredskapshåndtering_forventa_døde_52_dager) * beredskapshåndtering_døds_relatert_multiplikator ) < 250 [set beredskapshåndtering_døds_relatert beredskapshåndtering_døds_relatert - ( (døde - beredskapshåndtering_forventa_døde_52_dager) * beredskapshåndtering_døds_relatert_multiplikator ) ]
  if ticks = 59 and døde > beredskapshåndtering_forventa_døde_52_dager and ( (døde - beredskapshåndtering_forventa_døde_52_dager) * beredskapshåndtering_døds_relatert_multiplikator ) = 250 [set beredskapshåndtering_døds_relatert 0]
  if ticks = 59 and døde = (157 - beredskapshåndtering_forventa_døde_52_dager) or døde > (157 - beredskapshåndtering_forventa_døde_52_dager)  [set beredskapshåndtering_døds_relatert 0 ]


  if ticks = 59 [set beredskapshåndtering beredskapshåndtering - (250 - beredskapshåndtering_kompetanse_relatert)]
  if ticks = 59 [set beredskapshåndtering beredskapshåndtering - (250 - beredskapshåndtering_stress_relatert) ]
  if ticks = 59 [set beredskapshåndtering beredskapshåndtering - (250 - beredskapshåndtering_kommunikasjon)]
  if ticks = 59 [set beredskapshåndtering beredskapshåndtering - (250 - beredskapshåndtering_døds_relatert)]

  if beredskapshåndtering = 1000 or (beredskapshåndtering > 900) [set beredskaps_vellykkethet 10]
  if beredskapshåndtering = 900 or (beredskapshåndtering > 800 and beredskapshåndtering < 900) [set beredskaps_vellykkethet 9]
  if beredskapshåndtering = 800 or (beredskapshåndtering > 700 and beredskapshåndtering < 800) [set beredskaps_vellykkethet 8]
  if beredskapshåndtering = 700 or (beredskapshåndtering > 600 and beredskapshåndtering < 700) [set beredskaps_vellykkethet 7]
  if beredskapshåndtering = 600 or (beredskapshåndtering > 500 and beredskapshåndtering < 600) [set beredskaps_vellykkethet 6]
  if beredskapshåndtering = 500 or (beredskapshåndtering > 400 and beredskapshåndtering < 500) [set beredskaps_vellykkethet 5]
  if beredskapshåndtering = 400 or (beredskapshåndtering > 300 and beredskapshåndtering < 400) [set beredskaps_vellykkethet 4]
  if beredskapshåndtering = 300 or (beredskapshåndtering > 200 and beredskapshåndtering < 300) [set beredskaps_vellykkethet 3]
  if beredskapshåndtering = 200 or (beredskapshåndtering > 100 and beredskapshåndtering < 200) [set beredskaps_vellykkethet 2]
  if beredskapshåndtering = 100 or (beredskapshåndtering > 000 and beredskapshåndtering < 100) [set beredskaps_vellykkethet 1]
  if beredskapshåndtering < 000 [set beredskaps_vellykkethet 0]
  tick




end


to go-4
  ;; Intensiv

  if ticks = 60 [ stop ]
  set beredskapshåndtering_stress_relatert_ticks 0
  ;; Her gjennomføres opplæring for omdisponerte sykepleiere og stress påvirkning settes etter sannsynlighet
  if ticks = 0 [create-sykepleiere_opplæring 15 [set color yellow set shape "person" set kompetanse (1 + random-float 1) set stress random 4 move-to one-of patches with [pcolor = farge_normal_pasient]]]
  if ticks = 0 [ask sykepleiere_opplæring [repeat dager_før_start [set kompetanse kompetanse + kompetanse_faktor ]]]
  if ticks = 0 [ask sykepleiere_opplæring [set breed omdisponerte_sykepleiere set color yellow set shape "person" set stress random 4 move-to one-of patches with [pcolor = farge_omdisponert]]]


  ask sykepleiere_opplæring [if kurs_dager > 5 and first rnd:weighted-one-of-list stress_sannsynlighet-liste [ [p] -> last p ] = 0
    [set breed omdisponerte_sykepleiere set color yellow set shape "person" set stress_faktor 0.5 ]]
  ask sykepleiere_opplæring [if kurs_dager > 5 and first rnd:weighted-one-of-list stress_sannsynlighet-liste [ [p] -> last p ] = 1
    [set breed omdisponerte_sykepleiere set color yellow set shape "person" set stress_faktor 1 ]]



;; Her kjøres det sannynlighets beregning for om normal pasient blir intensiv pasient.





  ask pasienter [
    if lengde_opphold = liggetid_normal_pasienter or lengde_opphold > liggetid_normal_pasienter and
    first rnd:weighted-one-of-list probability-list [ [p] -> last p ] = 0 [
     set breed friske_pasienter set color white set shape "person" move-to one-of patches with [pcolor = farge_frisk_pasient]]


    if first rnd:weighted-one-of-list probability-list [ [p] -> last p ] = 1[
      set breed intensiv_pasienter set antall_intensiv_pasienter antall_intensiv_pasienter + 1 set intensiv_pasient_vendepunkt_verdi (random 15) + 10
      set color red set shape "person"
      move-to one-of patches with [pcolor = farge_intensiv_pasient]
      ]


      set lengde_opphold lengde_opphold + 1
  ]

   ;; Her lages normal pasienter fra input.csv

  if file-at-end? [ stop ]
  set antall_covid-19_pasienter file-read
  create-pasienter antall_covid-19_pasienter [
    setxy random-xcor random-ycor
    move-to one-of patches with [pcolor = farge_normal_pasient]
    set color green
    set shape "person"
    set sykdom 0
  ]

  ;; Her gjøres intensivpasienter til normal pasienter hvis sykdom er lavere en sykdoms_faktor4

  ask intensiv_pasienter [
    if lengde_opphold = lengde_opphold_ut_av_intensiv and sykdom < sykdoms_faktor_kan_ikke_utskrives [set breed pasienter set color green set shape "person" move-to one-of patches with [pcolor = farge_normal_pasient]]
    set lengde_opphold lengde_opphold + 1
  ]


  ;; Her lages intensiv_pasienter for å få opp antallet pasienter, kun for teste formål

 ; if count pasienter > 5 [if count intensiv_pasienter < 2 [ask n-of 3 pasienter [set breed intensiv_pasienter set color red set shape "person" move-to one-of patches with [pcolor = farge_intensiv_pasient] set antall_intensiv_pasienter antall_intensiv_pasienter + 1 set intensiv_pasient_vendepunkt_verdi (random 15) + 10 ]
  ;]]


  ;; flytting av sykepleiere her

  ask intensiv_pasienter [if count sykepleiere-on neighbors > 2 [ask one-of sykepleiere-on neighbors [move-to one-of patches with [pcolor = farge_intensiv_sykepleier]]]]
  if count intensiv_pasienter > 0 [ask sykepleiere [
    while [not any? intensiv_pasienter-on neighbors] [move-to one-of patches with [pcolor = farge_intensiv_sykepleier]]]]
  if count intensiv_pasienter > 0 [ask omdisponerte_sykepleiere [while [not any? intensiv_pasienter-on neighbors] [move-to one-of patches with [pcolor = farge_omdisponert]]]]
   ask intensiv_pasienter [if count omdisponerte_sykepleiere-on neighbors > 2 [ask one-of omdisponerte_sykepleiere-on neighbors [move-to one-of patches with [pcolor = farge_omdisponert]]]]
  ask intensiv_pasienter [if count sykepleiere-on neighbors > 2 [ask one-of sykepleiere-on neighbors [move-to one-of patches with [pcolor = farge_intensiv_sykepleier]]]]

  ;; Her skjer stress beregninger



  ask sykepleiere [
    if any? sykepleiere-on neighbors [set stress stress - minus_stress_faktor_sykepleier_sykepleier]

    if not any? sykepleiere-on neighbors and not any? omdisponerte_sykepleiere-on neighbors and any? pasienter-on neighbors and sum [sykdom] of turtles-on neighbors > 0
    [set stress stress + stress_faktor_sykepleier ]
    if not any? sykepleiere-on neighbors and any? omdisponerte_sykepleiere-on neighbors and any? pasienter-on neighbors and sum [sykdom] of turtles-on neighbors > 0
    [set stress stress + stress_faktor_sykepleier_omdisponert ]





    if stress < 50 and  belegg_stress_beregning < 1 [set stress stress + stress_faktor_belegg_under_1]
    if stress < 50 and  belegg_stress_beregning < 2 and belegg_stress_beregning > 1 [set stress stress + stress_faktor_belegg_under2]
    if belegg_stress_beregning > 2 or belegg_stress_beregning = 2 [set stress stress - minus_stress_faktor_belegg_over2]
    if ticks = 37 [set stress stress - 5]
    if stress > akseptabelt_stress_nivå and stress < kritiskt_stress_nivå [set beredskapshåndtering_stress_relatert_ticks beredskapshåndtering_stress_relatert_ticks + 1]
    if stress > kritiskt_stress_nivå and stress < sykemelding_stress_nivå [set beredskapshåndtering_stress_relatert_ticks beredskapshåndtering_stress_relatert_ticks + 5]
    if stress > sykemelding_stress_nivå [set beredskapshåndtering_stress_relatert_ticks beredskapshåndtering_stress_relatert_ticks + 20 die]
    if stress < konstant_stress_nivå [set stress konstant_stress_nivå]
  ]


  ask omdisponerte_sykepleiere [
    if any? sykepleiere-on neighbors and not any? pasienter-on neighbors [set stress stress - minus_stress_faktor_ingen_pasienter]

    if not any? sykepleiere-on neighbors and not any? omdisponerte_sykepleiere-on neighbors and any? pasienter-on neighbors and sum [sykdom] of turtles-on neighbors > 0
    [set stress stress + (sum [sykdom] of intensiv_pasienter-on neighbors / kompetanse) ]

    if not any? sykepleiere-on neighbors and any? omdisponerte_sykepleiere-on neighbors and any? pasienter-on neighbors and sum [sykdom] of turtles-on neighbors > 0
    [set stress stress + (sum [sykdom] of intensiv_pasienter-on neighbors / kompetanse) ]



    if stress < 50 and belegg_stress_beregning < 1 [set stress stress + stress_faktor_belegg_under_1]
    if stress < 50 and belegg_stress_beregning < 2 and belegg_stress_beregning > 1 [set stress stress + stress_faktor_belegg_under2]
    if belegg_stress_beregning > 2 [set stress stress - minus_stress_faktor_belegg_over2]
    if ticks = 37 [set stress stress - 5]
    if stress < konstant_stress_nivå [set stress konstant_stress_nivå]
    if stress > akseptabelt_stress_nivå and stress < kritiskt_stress_nivå [set beredskapshåndtering_stress_relatert_ticks beredskapshåndtering_stress_relatert_ticks + 1]
    if stress > kritiskt_stress_nivå and stress < sykemelding_stress_nivå [set beredskapshåndtering_stress_relatert_ticks beredskapshåndtering_stress_relatert_ticks + 5]
    if stress > sykemelding_stress_nivå [set beredskapshåndtering_stress_relatert_ticks beredskapshåndtering_stress_relatert_ticks + 20 die]
    if kompetanse < 10 [set kompetanse kompetanse + kompetanse_faktor_arbeid]
    if kompetanse > 10 [set kompetanse 10]
    set lengde_opphold lengde_opphold + 1
  ]
  if beredskapshåndtering_stress_relatert < 0 [set beredskapshåndtering_stress_relatert 0]

  ;; Her skjer sykdoms beregninger


  ask intensiv_pasienter [set sykdom sykdom + sykdoms_faktor_pasient_økning_dag ]

  ask intensiv_pasienter [
    if count sykepleiere-on neighbors > 2 and not any? omdisponerte_sykepleiere-on neighbors [set sykdom sykdom - sykdoms_faktor_sykepleier_sykepleier]
    if count sykepleiere-on neighbors = 1 and not any? omdisponerte_sykepleiere-on neighbors [set sykdom sykdom - sykdoms_faktor_sykepleier]
    if count omdisponerte_sykepleiere-on neighbors > 1 and not any? sykepleiere-on neighbors [set sykdom sykdom - ((count omdisponerte_sykepleiere-on neighbors / sum [kompetanse] of omdisponerte_sykepleiere-on neighbors) * 2)]
    if count omdisponerte_sykepleiere-on neighbors = 1 and not any? sykepleiere-on neighbors [set sykdom sykdom - (sum [kompetanse] of omdisponerte_sykepleiere-on neighbors)]
    if count omdisponerte_sykepleiere-on neighbors = 1 and count sykepleiere-on neighbors = 1 [set sykdom sykdom - (sum [kompetanse] of omdisponerte_sykepleiere-on neighbors + sykdoms_faktor_sykepleier)]


    if sykdom > 80  and first rnd:weighted-one-of-list probability-list_død_intensiv [ [p] -> last p ] = 1 [ set døde døde + 1 set dynamisk_intensiv_pasienter dynamisk_intensiv_pasienter - 1 set døde_beredskap døde_beredskap + 1  die]
  ]

    ;; Her justeres måltall og friske pasienter blir borte


  ask friske_pasienter [
    if frisk = 1 [set friskmeldte_pasienter friskmeldte_pasienter + 1 die]
    set frisk frisk + 1
  ]

  ask pasienter [
     set lengde_opphold lengde_opphold + 1
  ]
;; Denne justerer størrelsen på agentene etter stress

  let stress-list sort-on [ stress ] turtles let new-size 1 foreach stress-list [x -> ask x [set size new-size set new-size new-size + 0.01]]



  ;; Her beregnes belegg
  if count intensiv_pasienter > 0 [set belegg_stress_beregning (count sykepleiere / count intensiv_pasienter) ]
  if count intensiv_pasienter > 0 [set belegg (count sykepleiere + count omdisponerte_sykepleiere)  / count intensiv_pasienter]
  if count intensiv_pasienter = 0 [set belegg 10]
  if count intensiv_pasienter < 0 [set belegg 10]


  ;; Her trigges omdisponering av ansatte
  set antall_omdisponerte count intensiv_pasienter
  set antall_die antall_omdisponerte - 30


  if ticks > 0 and ticks < 31 and count omdisponerte_sykepleiere = 30 or count omdisponerte_sykepleiere < 30 and belegg < Trigger_omdisponering_sykepleiere_per_pasient or belegg = Trigger_omdisponering_sykepleiere_per_pasient and count sykepleiere_opplæring < 5 [create-omdisponerte_sykepleiere 5 [set color yellow set shape "person" set kompetanse (1 + random-float 1) set stress random 4 move-to one-of patches with [pcolor = farge_normal_pasient]]]
  if count omdisponerte_sykepleiere > 5 and belegg > Trigger_normalisering_sykepleiere_per_pasient and count pasienter < 30 [ask n-of 5 omdisponerte_sykepleiere [set normalisering normalisering + 1 ]]
  ;ask omdisponerte_sykepleiere [if normalisering = 3 [die]]
  ;if count omdisponerte_sykepleiere > 30 [ask n-of (antall_die) omdisponerte_sykepleiere die]



  ;; Her kommer omdisponerte sykepleiere til intensiv etter scenario
  if ticks = 1 [create-sykepleiere_opplæring 15 [set color yellow set shape "person" set kompetanse (1 + random-float 1) set stress random 4 move-to one-of patches with [pcolor = farge_normal_pasient] ] ]
  ask sykepleiere_opplæring [set kompetanse kompetanse + kompetanse_faktor]
  if ticks = 20 [ask sykepleiere_opplæring [set breed omdisponerte_sykepleiere set color yellow set shape "person"  set stress random 4 move-to one-of patches with [pcolor = farge_omdisponert]]]



  ;; Her oppdateres beredskaps_vellykkethet




  ;; kommunikasjon
  if (antall_motstridende_beskjeder * antall_ledelsesorganer * multipliserende_faktor_kommunikasjon) = 250 or (antall_motstridende_beskjeder * antall_ledelsesorganer * multipliserende_faktor_kommunikasjon) > 250 [set beredskapshåndtering_kommunikasjon 0]
  if ticks = 10 [set beredskapshåndtering_kommunikasjon beredskapshåndtering_kommunikasjon - (antall_motstridende_beskjeder * antall_ledelsesorganer * multipliserende_faktor_kommunikasjon) ]
  if (antall_motstridende_beskjeder * antall_ledelsesorganer * multipliserende_faktor_kommunikasjon) = 250 or (antall_motstridende_beskjeder * antall_ledelsesorganer * multipliserende_faktor_kommunikasjon) > 250 [set beredskapshåndtering_kommunikasjon 0]
  if ticks = 10 [set beredskapshåndtering_kommunikasjon beredskapshåndtering_kommunikasjon - (antall_motstridende_beskjeder_ppe * antall_ledelsesorganer_ppe * multipliserende_faktor_kommunikasjon) ]

  ;; stress
  if beredskapshåndtering_stress_relatert > 0 and ( beredskapshåndtering_stress_relatert - beredskapshåndtering_stress_relatert_ticks) > 0 [set beredskapshåndtering_stress_relatert beredskapshåndtering_stress_relatert - beredskapshåndtering_stress_relatert_ticks]
  if beredskapshåndtering_stress_relatert > 0 and ( beredskapshåndtering_stress_relatert - beredskapshåndtering_stress_relatert_ticks) = 0 [set beredskapshåndtering_stress_relatert beredskapshåndtering_stress_relatert - beredskapshåndtering_stress_relatert_ticks]




  ;; kompetanse
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-lav.csv" = åpen_fil and ticks = 36 [ask omdisponerte_sykepleiere with [kompetanse < 5 and kompetanse >= 3  ] [set antall_kompetanse_over_3 antall_kompetanse_over_3 + 1] ]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-lav.csv" = åpen_fil and ticks = 36 [ask omdisponerte_sykepleiere with [kompetanse < 3 and kompetanse >= 2  ]  [set antall_kompetanse_under_3_til_2 antall_kompetanse_under_3_til_2 + 1] ]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-lav.csv" = åpen_fil and ticks = 36 [ask omdisponerte_sykepleiere with [kompetanse < 2 and kompetanse >= 1 ] [set antall_kompetanse_under_2_til_1 antall_kompetanse_under_2_til_1 + 1] ]




  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-høy.csv" = åpen_fil and ticks = 21 [ask omdisponerte_sykepleiere with [kompetanse < 5 and kompetanse >= 3  ] [set antall_kompetanse_over_3 antall_kompetanse_over_3 + 1] ]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-høy.csv" = åpen_fil and ticks = 21 [ask omdisponerte_sykepleiere with [kompetanse < 3 and kompetanse >= 2  ]  [set antall_kompetanse_under_3_til_2 antall_kompetanse_under_3_til_2 + 1] ]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-høy.csv" = åpen_fil and ticks = 21 [ask omdisponerte_sykepleiere with [kompetanse < 2 and kompetanse >= 1 ] [set antall_kompetanse_under_2_til_1 antall_kompetanse_under_2_til_1 + 1] ]


  if "C:/Users/There/PycharmProjects/ABM---hospital/input.csv" = åpen_fil and ticks = 20 [ask omdisponerte_sykepleiere with [kompetanse < 5 and kompetanse >= 3  ] [set antall_kompetanse_over_3 antall_kompetanse_over_3 + 1] ]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input.csv" = åpen_fil and ticks = 20 [ask omdisponerte_sykepleiere with [kompetanse < 3 and kompetanse >= 2  ]  [set antall_kompetanse_under_3_til_2 antall_kompetanse_under_3_til_2 + 1] ]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input.csv" = åpen_fil and ticks = 20 [ask omdisponerte_sykepleiere with [kompetanse < 2 and kompetanse >= 1 ] [set antall_kompetanse_under_2_til_1 antall_kompetanse_under_2_til_1 + 1] ]

  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-lav.csv" = åpen_fil and ticks = 36 [set beredskapshåndtering_kompetanse_relatert_faktor ((antall_kompetanse_over_3 * kompetanse_over_3) + (antall_kompetanse_under_3_til_2 * kompetanse_under_3) + (antall_kompetanse_under_2_til_1 * kompetanse_under_2))]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-lav.csv" = åpen_fil and ticks = 36 and beredskapshåndtering_kompetanse_relatert_faktor < 250 or beredskapshåndtering_kompetanse_relatert_faktor = 250  [set beredskapshåndtering_kompetanse_relatert beredskapshåndtering_kompetanse_relatert_faktor]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-lav.csv" = åpen_fil and ticks = 36 and beredskapshåndtering_kompetanse_relatert_faktor > 250  [set beredskapshåndtering_kompetanse_relatert 250]

  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-høy.csv" = åpen_fil and ticks = 21[set beredskapshåndtering_kompetanse_relatert_faktor ((antall_kompetanse_over_3 * kompetanse_over_3) + (antall_kompetanse_under_3_til_2 * kompetanse_under_3) + (antall_kompetanse_under_2_til_1 * kompetanse_under_2))]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-høy.csv" = åpen_fil and ticks = 21 and beredskapshåndtering_kompetanse_relatert_faktor < 250 or beredskapshåndtering_kompetanse_relatert_faktor = 250  [set beredskapshåndtering_kompetanse_relatert beredskapshåndtering_kompetanse_relatert_faktor]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-høy.csv" = åpen_fil and ticks = 21 and beredskapshåndtering_kompetanse_relatert_faktor > 250  [set beredskapshåndtering_kompetanse_relatert 250]

  if "C:/Users/There/PycharmProjects/ABM---hospital/input.csv" = åpen_fil and ticks = 20 [set beredskapshåndtering_kompetanse_relatert_faktor ((antall_kompetanse_over_3 * kompetanse_over_3) + (antall_kompetanse_under_3_til_2 * kompetanse_under_3) + (antall_kompetanse_under_2_til_1 * kompetanse_under_2))]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input.csv" = åpen_fil and ticks = 20 and beredskapshåndtering_kompetanse_relatert_faktor < 250 or beredskapshåndtering_kompetanse_relatert_faktor = 250  [set beredskapshåndtering_kompetanse_relatert beredskapshåndtering_kompetanse_relatert_faktor]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input.csv" = åpen_fil and ticks = 20 and beredskapshåndtering_kompetanse_relatert_faktor > 250  [set beredskapshåndtering_kompetanse_relatert 250]

  ;; døde
  if ticks = 59 and døde > beredskapshåndtering_forventa_døde_52_dager and ( (døde - beredskapshåndtering_forventa_døde_52_dager) * beredskapshåndtering_døds_relatert_multiplikator ) < 250 [set beredskapshåndtering_døds_relatert beredskapshåndtering_døds_relatert - ( (døde - beredskapshåndtering_forventa_døde_52_dager) * beredskapshåndtering_døds_relatert_multiplikator ) ]
  if ticks = 59 and døde > beredskapshåndtering_forventa_døde_52_dager and ( (døde - beredskapshåndtering_forventa_døde_52_dager) * beredskapshåndtering_døds_relatert_multiplikator ) = 250 [set beredskapshåndtering_døds_relatert 0]
  if ticks = 59 and døde = (157 - beredskapshåndtering_forventa_døde_52_dager) or døde > (157 - beredskapshåndtering_forventa_døde_52_dager)  [set beredskapshåndtering_døds_relatert 0 ]


  if ticks = 59 [set beredskapshåndtering beredskapshåndtering - (250 - beredskapshåndtering_kompetanse_relatert)]
  if ticks = 59 [set beredskapshåndtering beredskapshåndtering - (250 - beredskapshåndtering_stress_relatert) ]
  if ticks = 59 [set beredskapshåndtering beredskapshåndtering - (250 - beredskapshåndtering_kommunikasjon)]
  if ticks = 59 [set beredskapshåndtering beredskapshåndtering - (250 - beredskapshåndtering_døds_relatert)]

  if beredskapshåndtering = 1000 or (beredskapshåndtering > 900) [set beredskaps_vellykkethet 10]
  if beredskapshåndtering = 900 or (beredskapshåndtering > 800 and beredskapshåndtering < 900) [set beredskaps_vellykkethet 9]
  if beredskapshåndtering = 800 or (beredskapshåndtering > 700 and beredskapshåndtering < 800) [set beredskaps_vellykkethet 8]
  if beredskapshåndtering = 700 or (beredskapshåndtering > 600 and beredskapshåndtering < 700) [set beredskaps_vellykkethet 7]
  if beredskapshåndtering = 600 or (beredskapshåndtering > 500 and beredskapshåndtering < 600) [set beredskaps_vellykkethet 6]
  if beredskapshåndtering = 500 or (beredskapshåndtering > 400 and beredskapshåndtering < 500) [set beredskaps_vellykkethet 5]
  if beredskapshåndtering = 400 or (beredskapshåndtering > 300 and beredskapshåndtering < 400) [set beredskaps_vellykkethet 4]
  if beredskapshåndtering = 300 or (beredskapshåndtering > 200 and beredskapshåndtering < 300) [set beredskaps_vellykkethet 3]
  if beredskapshåndtering = 200 or (beredskapshåndtering > 100 and beredskapshåndtering < 200) [set beredskaps_vellykkethet 2]
  if beredskapshåndtering = 100 or (beredskapshåndtering > 000 and beredskapshåndtering < 100) [set beredskaps_vellykkethet 1]
  if beredskapshåndtering < 000 [set beredskaps_vellykkethet 0]
  tick




end




to go-5
  ;; Beredskapsledelsen

  if ticks = 60 [ stop ]
  set beredskapshåndtering_stress_relatert_ticks 0
  ;; Her gjennomføres opplæring for omdisponerte sykepleiere og stress påvirkning settes etter sannsynlighet
  if ticks = 0 [create-sykepleiere_opplæring 15 [set color yellow set shape "person" set kompetanse (1 + random-float 1) set stress random 4 move-to one-of patches with [pcolor = farge_normal_pasient]]]
  if ticks = 0 [ask sykepleiere_opplæring [repeat dager_før_start [set kompetanse kompetanse + kompetanse_faktor ]]]
  if ticks = 0 [ask sykepleiere_opplæring [set breed omdisponerte_sykepleiere set color yellow set shape "person" set stress random 4 move-to one-of patches with [pcolor = farge_omdisponert]]]

  if ticks = 0 [create-sykepleiere_opplæring 5 [set color yellow set shape "person" set kompetanse (1 + random-float 1) set stress random 4 move-to one-of patches with [pcolor = farge_normal_pasient]]]
  if ticks = 0 [ask sykepleiere_opplæring [repeat 13 [set kompetanse kompetanse + kompetanse_faktor ]]]
  if ticks = 0 [ask sykepleiere_opplæring [set breed omdisponerte_sykepleiere set color yellow set shape "person" set stress random 4 move-to one-of patches with [pcolor = farge_omdisponert]]]

  if ticks = 0 [create-sykepleiere_opplæring 5 [set color yellow set shape "person" set kompetanse (1 + random-float 1) set stress random 4 move-to one-of patches with [pcolor = farge_normal_pasient]]]
  if ticks = 1 [ask sykepleiere_opplæring [repeat 10 [set kompetanse kompetanse + kompetanse_faktor ]]]
  if ticks = 1 [ask sykepleiere_opplæring [set breed omdisponerte_sykepleiere set color yellow set shape "person" set stress random 4 move-to one-of patches with [pcolor = farge_omdisponert]]]

  if ticks = 1 [create-sykepleiere_opplæring 10 [set color yellow set shape "person" set kompetanse (1 + random-float 1) set stress random 4 move-to one-of patches with [pcolor = farge_normal_pasient]]]
  if ticks = 11 [ask sykepleiere_opplæring [repeat 10 [set kompetanse kompetanse + kompetanse_faktor ]]]
  if ticks = 11 [ask sykepleiere_opplæring [set breed omdisponerte_sykepleiere set color yellow set shape "person" set stress random 4 move-to one-of patches with [pcolor = farge_omdisponert]]]

  if ticks = 11 [create-sykepleiere_opplæring 10 [set color yellow set shape "person" set kompetanse (1 + random-float 1) set stress random 4 move-to one-of patches with [pcolor = farge_normal_pasient]]]
  if ticks = 21 [ask sykepleiere_opplæring [repeat 10 [set kompetanse kompetanse + kompetanse_faktor ]]]
  if ticks = 21 [ask sykepleiere_opplæring [set breed omdisponerte_sykepleiere set color yellow set shape "person" set stress random 4 move-to one-of patches with [pcolor = farge_omdisponert]]]

  if ticks = 21 [create-sykepleiere_opplæring 10 [set color yellow set shape "person" set kompetanse (1 + random-float 1) set stress random 4 move-to one-of patches with [pcolor = farge_normal_pasient]]]
  if ticks = 31 [ask sykepleiere_opplæring [repeat 10 [set kompetanse kompetanse + kompetanse_faktor ]]]
  if ticks = 31 [ask sykepleiere_opplæring [set breed omdisponerte_sykepleiere set color yellow set shape "person" set stress random 4 move-to one-of patches with [pcolor = farge_omdisponert]]]


  ask sykepleiere_opplæring [if kurs_dager > 5 and first rnd:weighted-one-of-list stress_sannsynlighet-liste [ [p] -> last p ] = 0
    [set breed omdisponerte_sykepleiere set color yellow set shape "person" set stress_faktor 0.5 ]]
  ask sykepleiere_opplæring [if kurs_dager > 5 and first rnd:weighted-one-of-list stress_sannsynlighet-liste [ [p] -> last p ] = 1
    [set breed omdisponerte_sykepleiere set color yellow set shape "person" set stress_faktor 1 ]]



;; Her kjøres det sannynlighets beregning for om normal pasient blir intensiv pasient.





  ask pasienter [
    if lengde_opphold = liggetid_normal_pasienter or lengde_opphold > liggetid_normal_pasienter and
    first rnd:weighted-one-of-list probability-list [ [p] -> last p ] = 0 [
     set breed friske_pasienter set color white set shape "person" move-to one-of patches with [pcolor = farge_frisk_pasient]]


    if first rnd:weighted-one-of-list probability-list [ [p] -> last p ] = 1[
      set breed intensiv_pasienter set antall_intensiv_pasienter antall_intensiv_pasienter + 1 set intensiv_pasient_vendepunkt_verdi (random 15) + 10
      set color red set shape "person"
      move-to one-of patches with [pcolor = farge_intensiv_pasient]
      ]


      set lengde_opphold lengde_opphold + 1
  ]

   ;; Her lages normal pasienter fra input.csv

  if file-at-end? [ stop ]
  set antall_covid-19_pasienter file-read
  create-pasienter antall_covid-19_pasienter [
    setxy random-xcor random-ycor
    move-to one-of patches with [pcolor = farge_normal_pasient]
    set color green
    set shape "person"
    set sykdom 0
  ]

  ;; Her gjøres intensivpasienter til normal pasienter hvis sykdom er lavere en sykdoms_faktor4

  ask intensiv_pasienter [
    if lengde_opphold = lengde_opphold_ut_av_intensiv and sykdom < sykdoms_faktor_kan_ikke_utskrives [set breed pasienter set color green set shape "person" move-to one-of patches with [pcolor = farge_normal_pasient]]
    set lengde_opphold lengde_opphold + 1
  ]


  ;; Her lages intensiv_pasienter for å få opp antallet pasienter, kun for teste formål

 ; if count pasienter > 5 [if count intensiv_pasienter < 2 [ask n-of 3 pasienter [set breed intensiv_pasienter set color red set shape "person" move-to one-of patches with [pcolor = farge_intensiv_pasient] set antall_intensiv_pasienter antall_intensiv_pasienter + 1 set intensiv_pasient_vendepunkt_verdi (random 15) + 10 ]
  ;]]


  ;; flytting av sykepleiere her

  ask intensiv_pasienter [if count sykepleiere-on neighbors > 2 [ask one-of sykepleiere-on neighbors [move-to one-of patches with [pcolor = farge_intensiv_sykepleier]]]]
  if count intensiv_pasienter > 0 [ask sykepleiere [
    while [not any? intensiv_pasienter-on neighbors] [move-to one-of patches with [pcolor = farge_intensiv_sykepleier]]]]
  if count intensiv_pasienter > 0 [ask omdisponerte_sykepleiere [while [not any? intensiv_pasienter-on neighbors] [move-to one-of patches with [pcolor = farge_omdisponert]]]]
   ask intensiv_pasienter [if count omdisponerte_sykepleiere-on neighbors > 2 [ask one-of omdisponerte_sykepleiere-on neighbors [move-to one-of patches with [pcolor = farge_omdisponert]]]]
  ask intensiv_pasienter [if count sykepleiere-on neighbors > 2 [ask one-of sykepleiere-on neighbors [move-to one-of patches with [pcolor = farge_intensiv_sykepleier]]]]

  ;; Her skjer stress beregninger



  ask sykepleiere [
    if any? sykepleiere-on neighbors [set stress stress - minus_stress_faktor_sykepleier_sykepleier]

    if not any? sykepleiere-on neighbors and not any? omdisponerte_sykepleiere-on neighbors and any? pasienter-on neighbors and sum [sykdom] of turtles-on neighbors > 0
    [set stress stress + stress_faktor_sykepleier ]
    if not any? sykepleiere-on neighbors and any? omdisponerte_sykepleiere-on neighbors and any? pasienter-on neighbors and sum [sykdom] of turtles-on neighbors > 0
    [set stress stress + stress_faktor_sykepleier_omdisponert ]





    if stress < 50 and  belegg_stress_beregning < 1 [set stress stress + stress_faktor_belegg_under_1]
    if stress < 50 and  belegg_stress_beregning < 2 and belegg_stress_beregning > 1 [set stress stress + stress_faktor_belegg_under2]
    if belegg_stress_beregning > 2 or belegg_stress_beregning = 2 [set stress stress - minus_stress_faktor_belegg_over2]
    if ticks = 37 [set stress stress - 5]
    if stress > akseptabelt_stress_nivå and stress < kritiskt_stress_nivå [set beredskapshåndtering_stress_relatert_ticks beredskapshåndtering_stress_relatert_ticks + 1]
    if stress > kritiskt_stress_nivå and stress < sykemelding_stress_nivå [set beredskapshåndtering_stress_relatert_ticks beredskapshåndtering_stress_relatert_ticks + 5]
    if stress > sykemelding_stress_nivå [set beredskapshåndtering_stress_relatert_ticks beredskapshåndtering_stress_relatert_ticks + 20 die]
    if stress < konstant_stress_nivå [set stress konstant_stress_nivå]
  ]


  ask omdisponerte_sykepleiere [
    if any? sykepleiere-on neighbors and not any? pasienter-on neighbors [set stress stress - minus_stress_faktor_ingen_pasienter]

    if not any? sykepleiere-on neighbors and not any? omdisponerte_sykepleiere-on neighbors and any? pasienter-on neighbors and sum [sykdom] of turtles-on neighbors > 0
    [set stress stress + (sum [sykdom] of intensiv_pasienter-on neighbors / kompetanse) ]

    if not any? sykepleiere-on neighbors and any? omdisponerte_sykepleiere-on neighbors and any? pasienter-on neighbors and sum [sykdom] of turtles-on neighbors > 0
    [set stress stress + (sum [sykdom] of intensiv_pasienter-on neighbors / kompetanse) ]



    if stress < 50 and belegg_stress_beregning < 1 [set stress stress + stress_faktor_belegg_under_1]
    if stress < 50 and belegg_stress_beregning < 2 and belegg_stress_beregning > 1 [set stress stress + stress_faktor_belegg_under2]
    if belegg_stress_beregning > 2 [set stress stress - minus_stress_faktor_belegg_over2]
    if ticks = 37 [set stress stress - 5]
    if stress < konstant_stress_nivå [set stress konstant_stress_nivå]
    if stress > akseptabelt_stress_nivå and stress < kritiskt_stress_nivå [set beredskapshåndtering_stress_relatert_ticks beredskapshåndtering_stress_relatert_ticks + 1]
    if stress > kritiskt_stress_nivå and stress < sykemelding_stress_nivå [set beredskapshåndtering_stress_relatert_ticks beredskapshåndtering_stress_relatert_ticks + 5]
    if stress > sykemelding_stress_nivå [set beredskapshåndtering_stress_relatert_ticks beredskapshåndtering_stress_relatert_ticks + 20 die]
    if kompetanse < 10 [set kompetanse kompetanse + kompetanse_faktor_arbeid]
    if kompetanse > 10 [set kompetanse 10]
    set lengde_opphold lengde_opphold + 1
  ]
  if beredskapshåndtering_stress_relatert < 0 [set beredskapshåndtering_stress_relatert 0]

  ;; Her skjer sykdoms beregninger


  ask intensiv_pasienter [set sykdom sykdom + sykdoms_faktor_pasient_økning_dag ]

  ask intensiv_pasienter [
    if count sykepleiere-on neighbors > 2 and not any? omdisponerte_sykepleiere-on neighbors [set sykdom sykdom - sykdoms_faktor_sykepleier_sykepleier]
    if count sykepleiere-on neighbors = 1 and not any? omdisponerte_sykepleiere-on neighbors [set sykdom sykdom - sykdoms_faktor_sykepleier]
    if count omdisponerte_sykepleiere-on neighbors > 1 and not any? sykepleiere-on neighbors [set sykdom sykdom - ((count omdisponerte_sykepleiere-on neighbors / sum [kompetanse] of omdisponerte_sykepleiere-on neighbors) * 2)]
    if count omdisponerte_sykepleiere-on neighbors = 1 and not any? sykepleiere-on neighbors [set sykdom sykdom - (sum [kompetanse] of omdisponerte_sykepleiere-on neighbors)]
    if count omdisponerte_sykepleiere-on neighbors = 1 and count sykepleiere-on neighbors = 1 [set sykdom sykdom - (sum [kompetanse] of omdisponerte_sykepleiere-on neighbors + sykdoms_faktor_sykepleier)]


    if sykdom > 80  and first rnd:weighted-one-of-list probability-list_død_intensiv [ [p] -> last p ] = 1 [ set døde døde + 1 set dynamisk_intensiv_pasienter dynamisk_intensiv_pasienter - 1 set døde_beredskap døde_beredskap + 1  die]
  ]

    ;; Her justeres måltall og friske pasienter blir borte


  ask friske_pasienter [
    if frisk = 1 [set friskmeldte_pasienter friskmeldte_pasienter + 1 die]
    set frisk frisk + 1
  ]

  ask pasienter [
     set lengde_opphold lengde_opphold + 1
  ]
;; Denne justerer størrelsen på agentene etter stress

  let stress-list sort-on [ stress ] turtles let new-size 1 foreach stress-list [x -> ask x [set size new-size set new-size new-size + 0.01]]



  ;; Her beregnes belegg
  if count intensiv_pasienter > 0 [set belegg_stress_beregning (count sykepleiere / count intensiv_pasienter) ]
  if count intensiv_pasienter > 0 [set belegg (count sykepleiere + count omdisponerte_sykepleiere)  / count intensiv_pasienter]
  if count intensiv_pasienter = 0 [set belegg 10]
  if count intensiv_pasienter < 0 [set belegg 10]


  ;; Her trigges omdisponering av ansatte
  set antall_omdisponerte count intensiv_pasienter
  set antall_die antall_omdisponerte - 30


  if ticks > 0 and ticks < 31 and count omdisponerte_sykepleiere = 30 or count omdisponerte_sykepleiere < 30 and belegg < Trigger_omdisponering_sykepleiere_per_pasient or belegg = Trigger_omdisponering_sykepleiere_per_pasient and count sykepleiere_opplæring < 5 [create-omdisponerte_sykepleiere 5 [set color yellow set shape "person" set kompetanse (1 + random-float 1) set stress random 4 move-to one-of patches with [pcolor = farge_normal_pasient]]]
  if count omdisponerte_sykepleiere > 5 and belegg > Trigger_normalisering_sykepleiere_per_pasient and count pasienter < 30 [ask n-of 5 omdisponerte_sykepleiere [set normalisering normalisering + 1 ]]
  ;ask omdisponerte_sykepleiere [if normalisering = 3 [die]]
  ;if count omdisponerte_sykepleiere > 30 [ask n-of (antall_die) omdisponerte_sykepleiere die]



  ;; Her kommer omdisponerte sykepleiere til intensiv etter scenario
  if ticks = 1 [create-sykepleiere_opplæring 15 [set color yellow set shape "person" set kompetanse (1 + random-float 1) set stress random 4 move-to one-of patches with [pcolor = farge_normal_pasient] ] ]
  ask sykepleiere_opplæring [set kompetanse kompetanse + kompetanse_faktor]
  if ticks = 20 [ask sykepleiere_opplæring [set breed omdisponerte_sykepleiere set color yellow set shape "person"  set stress random 4 move-to one-of patches with [pcolor = farge_omdisponert]]]



  ;; Her oppdateres beredskaps_vellykkethet




  ;; kommunikasjon
  if (antall_motstridende_beskjeder * antall_ledelsesorganer * multipliserende_faktor_kommunikasjon) = 250 or (antall_motstridende_beskjeder * antall_ledelsesorganer * multipliserende_faktor_kommunikasjon) > 250 [set beredskapshåndtering_kommunikasjon 0]
  if ticks = 10 [set beredskapshåndtering_kommunikasjon beredskapshåndtering_kommunikasjon - (antall_motstridende_beskjeder * antall_ledelsesorganer * multipliserende_faktor_kommunikasjon) ]
  if (antall_motstridende_beskjeder * antall_ledelsesorganer * multipliserende_faktor_kommunikasjon) = 250 or (antall_motstridende_beskjeder * antall_ledelsesorganer * multipliserende_faktor_kommunikasjon) > 250 [set beredskapshåndtering_kommunikasjon 0]
  if ticks = 10 [set beredskapshåndtering_kommunikasjon beredskapshåndtering_kommunikasjon - (antall_motstridende_beskjeder_ppe * antall_ledelsesorganer_ppe * multipliserende_faktor_kommunikasjon) ]

  ;; stress
  if beredskapshåndtering_stress_relatert > 0 and ( beredskapshåndtering_stress_relatert - beredskapshåndtering_stress_relatert_ticks) > 0 [set beredskapshåndtering_stress_relatert beredskapshåndtering_stress_relatert - beredskapshåndtering_stress_relatert_ticks]
  if beredskapshåndtering_stress_relatert > 0 and ( beredskapshåndtering_stress_relatert - beredskapshåndtering_stress_relatert_ticks) = 0 [set beredskapshåndtering_stress_relatert beredskapshåndtering_stress_relatert - beredskapshåndtering_stress_relatert_ticks]




  ;; kompetanse

 if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-lav.csv" = åpen_fil and ticks = 36 [ask omdisponerte_sykepleiere with [kompetanse < 5 and kompetanse >= 3  ] [set antall_kompetanse_over_3 antall_kompetanse_over_3 + 1] ]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-lav.csv" = åpen_fil and ticks = 36 [ask omdisponerte_sykepleiere with [kompetanse < 3 and kompetanse >= 2  ]  [set antall_kompetanse_under_3_til_2 antall_kompetanse_under_3_til_2 + 1] ]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-lav.csv" = åpen_fil and ticks = 36 [ask omdisponerte_sykepleiere with [kompetanse < 2 and kompetanse >= 1 ] [set antall_kompetanse_under_2_til_1 antall_kompetanse_under_2_til_1 + 1] ]




  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-høy.csv" = åpen_fil and ticks = 21 [ask omdisponerte_sykepleiere with [kompetanse < 5 and kompetanse >= 3  ] [set antall_kompetanse_over_3 antall_kompetanse_over_3 + 1] ]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-høy.csv" = åpen_fil and ticks = 21 [ask omdisponerte_sykepleiere with [kompetanse < 3 and kompetanse >= 2  ]  [set antall_kompetanse_under_3_til_2 antall_kompetanse_under_3_til_2 + 1] ]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-høy.csv" = åpen_fil and ticks = 21 [ask omdisponerte_sykepleiere with [kompetanse < 2 and kompetanse >= 1 ] [set antall_kompetanse_under_2_til_1 antall_kompetanse_under_2_til_1 + 1] ]


  if "C:/Users/There/PycharmProjects/ABM---hospital/input.csv" = åpen_fil and ticks = 20 [ask omdisponerte_sykepleiere with [kompetanse < 5 and kompetanse >= 3  ] [set antall_kompetanse_over_3 antall_kompetanse_over_3 + 1] ]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input.csv" = åpen_fil and ticks = 20 [ask omdisponerte_sykepleiere with [kompetanse < 3 and kompetanse >= 2  ]  [set antall_kompetanse_under_3_til_2 antall_kompetanse_under_3_til_2 + 1] ]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input.csv" = åpen_fil and ticks = 20 [ask omdisponerte_sykepleiere with [kompetanse < 2 and kompetanse >= 1 ] [set antall_kompetanse_under_2_til_1 antall_kompetanse_under_2_til_1 + 1] ]

  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-lav.csv" = åpen_fil and ticks = 36 [set beredskapshåndtering_kompetanse_relatert_faktor ((antall_kompetanse_over_3 * kompetanse_over_3) + (antall_kompetanse_under_3_til_2 * kompetanse_under_3) + (antall_kompetanse_under_2_til_1 * kompetanse_under_2))]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-lav.csv" = åpen_fil and ticks = 36 and beredskapshåndtering_kompetanse_relatert_faktor < 250 or beredskapshåndtering_kompetanse_relatert_faktor = 250  [set beredskapshåndtering_kompetanse_relatert beredskapshåndtering_kompetanse_relatert_faktor]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-lav.csv" = åpen_fil and ticks = 36 and beredskapshåndtering_kompetanse_relatert_faktor > 250  [set beredskapshåndtering_kompetanse_relatert 250]

  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-høy.csv" = åpen_fil and ticks = 21[set beredskapshåndtering_kompetanse_relatert_faktor ((antall_kompetanse_over_3 * kompetanse_over_3) + (antall_kompetanse_under_3_til_2 * kompetanse_under_3) + (antall_kompetanse_under_2_til_1 * kompetanse_under_2))]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-høy.csv" = åpen_fil and ticks = 21 and beredskapshåndtering_kompetanse_relatert_faktor < 250 or beredskapshåndtering_kompetanse_relatert_faktor = 250  [set beredskapshåndtering_kompetanse_relatert beredskapshåndtering_kompetanse_relatert_faktor]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input-scenario-høy.csv" = åpen_fil and ticks = 21 and beredskapshåndtering_kompetanse_relatert_faktor > 250  [set beredskapshåndtering_kompetanse_relatert 250]

  if "C:/Users/There/PycharmProjects/ABM---hospital/input.csv" = åpen_fil and ticks = 20 [set beredskapshåndtering_kompetanse_relatert_faktor ((antall_kompetanse_over_3 * kompetanse_over_3) + (antall_kompetanse_under_3_til_2 * kompetanse_under_3) + (antall_kompetanse_under_2_til_1 * kompetanse_under_2))]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input.csv" = åpen_fil and ticks = 20 and beredskapshåndtering_kompetanse_relatert_faktor < 250 or beredskapshåndtering_kompetanse_relatert_faktor = 250  [set beredskapshåndtering_kompetanse_relatert beredskapshåndtering_kompetanse_relatert_faktor]
  if "C:/Users/There/PycharmProjects/ABM---hospital/input.csv" = åpen_fil and ticks = 20 and beredskapshåndtering_kompetanse_relatert_faktor > 250  [set beredskapshåndtering_kompetanse_relatert 250]
  ;; døde
  if ticks = 59 and døde > beredskapshåndtering_forventa_døde_52_dager and ( (døde - beredskapshåndtering_forventa_døde_52_dager) * beredskapshåndtering_døds_relatert_multiplikator ) < 250 [set beredskapshåndtering_døds_relatert beredskapshåndtering_døds_relatert - ( (døde - beredskapshåndtering_forventa_døde_52_dager) * beredskapshåndtering_døds_relatert_multiplikator ) ]
  if ticks = 59 and døde > beredskapshåndtering_forventa_døde_52_dager and ( (døde - beredskapshåndtering_forventa_døde_52_dager) * beredskapshåndtering_døds_relatert_multiplikator ) = 250 [set beredskapshåndtering_døds_relatert 0]
  if ticks = 59 and døde = (157 - beredskapshåndtering_forventa_døde_52_dager) or døde > (157 - beredskapshåndtering_forventa_døde_52_dager)  [set beredskapshåndtering_døds_relatert 0 ]

  if ticks = 59 [set beredskapshåndtering beredskapshåndtering - (250 - beredskapshåndtering_kompetanse_relatert)]
  if ticks = 59 [set beredskapshåndtering beredskapshåndtering - (250 - beredskapshåndtering_stress_relatert) ]
  if ticks = 59 [set beredskapshåndtering beredskapshåndtering - (250 - beredskapshåndtering_kommunikasjon)]
  if ticks = 59 [set beredskapshåndtering beredskapshåndtering - (250 - beredskapshåndtering_døds_relatert)]

  if beredskapshåndtering = 1000 or (beredskapshåndtering > 900) [set beredskaps_vellykkethet 10]
  if beredskapshåndtering = 900 or (beredskapshåndtering > 800 and beredskapshåndtering < 900) [set beredskaps_vellykkethet 9]
  if beredskapshåndtering = 800 or (beredskapshåndtering > 700 and beredskapshåndtering < 800) [set beredskaps_vellykkethet 8]
  if beredskapshåndtering = 700 or (beredskapshåndtering > 600 and beredskapshåndtering < 700) [set beredskaps_vellykkethet 7]
  if beredskapshåndtering = 600 or (beredskapshåndtering > 500 and beredskapshåndtering < 600) [set beredskaps_vellykkethet 6]
  if beredskapshåndtering = 500 or (beredskapshåndtering > 400 and beredskapshåndtering < 500) [set beredskaps_vellykkethet 5]
  if beredskapshåndtering = 400 or (beredskapshåndtering > 300 and beredskapshåndtering < 400) [set beredskaps_vellykkethet 4]
  if beredskapshåndtering = 300 or (beredskapshåndtering > 200 and beredskapshåndtering < 300) [set beredskaps_vellykkethet 3]
  if beredskapshåndtering = 200 or (beredskapshåndtering > 100 and beredskapshåndtering < 200) [set beredskaps_vellykkethet 2]
  if beredskapshåndtering = 100 or (beredskapshåndtering > 000 and beredskapshåndtering < 100) [set beredskaps_vellykkethet 1]
  if beredskapshåndtering < 000 [set beredskaps_vellykkethet 0]
  tick




end



to-report total_stress
  if sum [stress] of turtles > 0 [report sum [ stress ] of turtles]
end

to-report maks_stress
  if sum [stress] of turtles > 0 [report max [ stress ] of turtles]
end

to-report gjennomsnitt_stress
  if sum [stress] of turtles > 0 [report sum [stress] of turtles /(count sykepleiere + count omdisponerte_sykepleiere)  ]
end


to-report antall_pasienter
  report count pasienter
end

to-report antall_intensiv
  report count intensiv_pasienter
end

to-report kummulativt_antall_intensiv
  report antall_intensiv_pasienter
end


to-report antall_sykepleiere
  report count sykepleiere + count omdisponerte_sykepleiere
end
@#$#@#$#@
GRAPHICS-WINDOW
823
10
1254
442
-1
-1
20.143
1
10
1
1
1
0
0
0
1
-10
10
-10
10
1
1
1
Dager
30.0

BUTTON
678
10
776
43
Reset setup
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
142
320
284
365
Sykepleiere per pasient
belegg
17
1
11

BUTTON
678
43
795
76
Virkeligheten
go-1
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
0
53
136
98
Beredskapshåndtering
beredskapshåndtering
17
1
11

MONITOR
0
275
100
320
NIL
døde
17
1
11

MONITOR
0
446
139
491
NIL
friskmeldte_pasienter
17
1
11

MONITOR
110
363
213
408
Antall  pasienter
antall_pasienter
17
1
11

MONITOR
0
362
110
407
Antall sykepleiere
Antall_sykepleiere
17
1
11

MONITOR
98
276
214
321
Nåværende stress
total_stress
17
1
11

MONITOR
0
404
146
449
Antall intensiv pasienter
antall_intensiv
17
1
11

MONITOR
140
404
315
449
Total antall intensiv pasienter
antall_intensiv_pasienter
17
1
11

SLIDER
339
40
616
73
Antall_omdisponerte_ved_pandemi_start
Antall_omdisponerte_ved_pandemi_start
0
100
15.0
1
1
NIL
HORIZONTAL

SLIDER
338
10
510
43
dager_før_start
dager_før_start
0
71
30.0
1
1
NIL
HORIZONTAL

SLIDER
340
103
512
136
fast_ansatt_intensiv
fast_ansatt_intensiv
0
100
22.0
1
1
NIL
HORIZONTAL

SLIDER
339
167
661
200
Trigger_omdisponering_sykepleiere_per_pasient
Trigger_omdisponering_sykepleiere_per_pasient
0
10
1.0
0.1
1
NIL
HORIZONTAL

SLIDER
339
135
529
168
antall_i_ren_intensiv_sone
antall_i_ren_intensiv_sone
0
10
7.0
1
1
NIL
HORIZONTAL

SLIDER
339
72
633
105
dager_opplæring_omdisponerte_etter_start
dager_opplæring_omdisponerte_etter_start
0
100
30.0
1
1
NIL
HORIZONTAL

SLIDER
339
201
654
234
Trigger_normalisering_sykepleiere_per_pasient
Trigger_normalisering_sykepleiere_per_pasient
0
10
5.0
0.1
1
NIL
HORIZONTAL

MONITOR
214
276
292
321
Maks stress
maks_stress
17
1
11

MONITOR
0
320
142
365
Snitt stress på avdeling
gjennomsnitt_stress
17
1
11

MONITOR
0
10
155
55
Beredskaps - vellykkethet
beredskaps_vellykkethet
17
1
11

SLIDER
339
232
513
265
antall_ledelsesorganer
antall_ledelsesorganer
0
10
1.0
1
1
NIL
HORIZONTAL

SLIDER
339
265
559
298
antall_motstridende_beskjeder
antall_motstridende_beskjeder
0
15
0.0
1
1
NIL
HORIZONTAL

MONITOR
2
187
227
232
NIL
beredskapshåndtering_stress_relatert
17
1
11

MONITOR
1
143
259
188
NIL
beredskapshåndtering_kompetanse_relatert
17
1
11

MONITOR
0
98
218
143
NIL
beredskapshåndtering_døds_relatert
17
1
11

MONITOR
2
231
228
276
NIL
beredskapshåndtering_kommunikasjon
17
1
11

MONITOR
180
544
380
589
NIL
antall_kompetanse_under_3_til_2
17
1
11

MONITOR
181
591
381
636
NIL
antall_kompetanse_under_2_til_1
17
1
11

MONITOR
180
499
343
544
NIL
antall_kompetanse_over_3
17
1
11

SLIDER
339
297
535
330
Antall_ledelsesorganer_PPE
Antall_ledelsesorganer_PPE
0
10
2.0
1
1
NIL
HORIZONTAL

SLIDER
338
330
580
363
Antall_motstridende_beskjeder_PPE
Antall_motstridende_beskjeder_PPE
0
15
2.0
1
1
NIL
HORIZONTAL

BUTTON
680
76
788
109
Driftsutvalget
go-3
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
682
110
772
143
Intensiven
go-4
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
681
142
821
175
Beredskapsledelsen
go-5
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

@#$#@#$#@
## Hva gjør modellen?

Denne modellen simulerer hvordan et sykehus sin intensiv avdeling håndterer covid-19 pandemien gjennom den første bølgen av pandemien. Input data er hentet fra et sykehus i oslo regionen.  
Scenario 1 - Virkeligheten
Scenario 2 - Beredskapsledelsen
Scenario 3 - Intensiv og infeksjonsavdelingen.

## Om bakgrunnstallene

Antall intensiv pasienter følger den statistiske riktige verdien for antall covid-19 intensiv pasienter for perioden mars til juni 2020 på 16% med en snitt liggetid på normal covid_pasienter på 6 dager. Ved å justere sliderne kan vi simulere ulike oppsett av beredskapsutførelsen. Sykehuset som simuleres startet opplæring av personell 12.03.20, som er lik 0 i dager_før_start. I Norge er det i snitt 7,21799 intensiv sykepleiere per intensivplass og de jobber tredelt turnus. 
## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.2.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="Virkeligheten" repetitions="100" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go-1</go>
    <metric>beredskaps_vellykkethet</metric>
    <metric>beredskapshåndtering</metric>
    <metric>beredskapshåndtering_døds_relatert</metric>
    <metric>beredskapshåndtering_kompetanse_relatert</metric>
    <metric>beredskapshåndtering_stress_relatert</metric>
    <metric>beredskapshåndtering_kommunikasjon</metric>
    <metric>døde</metric>
    <metric>gjennomsnitt_stress</metric>
    <metric>kummulativt_antall_intensiv</metric>
    <metric>friskmeldte_pasienter</metric>
    <metric>antall_kompetanse_over_3</metric>
    <metric>antall_kompetanse_under_3_til_2</metric>
    <metric>antall_kompetanse_under_2_til_1</metric>
    <enumeratedValueSet variable="Antall_ledelsesorganer_PPE">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="antall_i_ren_intensiv_sone">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Antall_omdisponerte_ved_pandemi_start">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Trigger_omdisponering_sykepleiere_per_pasient">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Antall_motstridende_beskjeder_PPE">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Trigger_normalisering_sykepleiere_per_pasient">
      <value value="3.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="antall_motstridende_beskjeder">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fast_ansatt_intensiv">
      <value value="22"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="antall_ledelsesorganer">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="dager_før_start">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="dager_opplæring_omdisponerte_etter_start">
      <value value="7"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Driftsutvalget" repetitions="100" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go-3</go>
    <metric>beredskaps_vellykkethet</metric>
    <metric>beredskapshåndtering</metric>
    <metric>beredskapshåndtering_døds_relatert</metric>
    <metric>beredskapshåndtering_kompetanse_relatert</metric>
    <metric>beredskapshåndtering_stress_relatert</metric>
    <metric>beredskapshåndtering_kommunikasjon</metric>
    <metric>døde</metric>
    <metric>gjennomsnitt_stress</metric>
    <metric>kummulativt_antall_intensiv</metric>
    <metric>friskmeldte_pasienter</metric>
    <metric>antall_kompetanse_over_3</metric>
    <metric>antall_kompetanse_under_3_til_2</metric>
    <metric>antall_kompetanse_under_2_til_1</metric>
    <enumeratedValueSet variable="Antall_ledelsesorganer_PPE">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="antall_i_ren_intensiv_sone">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Antall_omdisponerte_ved_pandemi_start">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Trigger_omdisponering_sykepleiere_per_pasient">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Antall_motstridende_beskjeder_PPE">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Trigger_normalisering_sykepleiere_per_pasient">
      <value value="3.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="antall_motstridende_beskjeder">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fast_ansatt_intensiv">
      <value value="22"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="antall_ledelsesorganer">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="dager_før_start">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="dager_opplæring_omdisponerte_etter_start">
      <value value="2"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Beredskapsledelsen" repetitions="100" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go-4</go>
    <metric>beredskaps_vellykkethet</metric>
    <metric>beredskapshåndtering</metric>
    <metric>beredskapshåndtering_døds_relatert</metric>
    <metric>beredskapshåndtering_kompetanse_relatert</metric>
    <metric>beredskapshåndtering_stress_relatert</metric>
    <metric>beredskapshåndtering_kommunikasjon</metric>
    <metric>døde</metric>
    <metric>gjennomsnitt_stress</metric>
    <metric>kummulativt_antall_intensiv</metric>
    <metric>friskmeldte_pasienter</metric>
    <metric>antall_kompetanse_over_3</metric>
    <metric>antall_kompetanse_under_3_til_2</metric>
    <metric>antall_kompetanse_under_2_til_1</metric>
    <enumeratedValueSet variable="Antall_ledelsesorganer_PPE">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="antall_i_ren_intensiv_sone">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Antall_omdisponerte_ved_pandemi_start">
      <value value="15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Trigger_omdisponering_sykepleiere_per_pasient">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Antall_motstridende_beskjeder_PPE">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Trigger_normalisering_sykepleiere_per_pasient">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="antall_motstridende_beskjeder">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fast_ansatt_intensiv">
      <value value="22"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="antall_ledelsesorganer">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="dager_før_start">
      <value value="26"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="dager_opplæring_omdisponerte_etter_start">
      <value value="10"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Intensiven" repetitions="100" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go-5</go>
    <metric>beredskaps_vellykkethet</metric>
    <metric>beredskapshåndtering</metric>
    <metric>beredskapshåndtering_døds_relatert</metric>
    <metric>beredskapshåndtering_kompetanse_relatert</metric>
    <metric>beredskapshåndtering_stress_relatert</metric>
    <metric>beredskapshåndtering_kommunikasjon</metric>
    <metric>døde</metric>
    <metric>gjennomsnitt_stress</metric>
    <metric>kummulativt_antall_intensiv</metric>
    <metric>friskmeldte_pasienter</metric>
    <metric>antall_kompetanse_over_3</metric>
    <metric>antall_kompetanse_under_3_til_2</metric>
    <metric>antall_kompetanse_under_2_til_1</metric>
    <enumeratedValueSet variable="Antall_ledelsesorganer_PPE">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="antall_i_ren_intensiv_sone">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Antall_omdisponerte_ved_pandemi_start">
      <value value="15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Trigger_omdisponering_sykepleiere_per_pasient">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Antall_motstridende_beskjeder_PPE">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Trigger_normalisering_sykepleiere_per_pasient">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="antall_motstridende_beskjeder">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fast_ansatt_intensiv">
      <value value="22"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="antall_ledelsesorganer">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="dager_før_start">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="dager_opplæring_omdisponerte_etter_start">
      <value value="30"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
