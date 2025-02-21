
-- tabela route
CREATE TABLE bus_route (
    route_number INTEGER NOT NULL,
    origin_city TEXT NOT NULL,
    origin_place TEXT NOT NULL,
    destination_city TEXT NOT NULL,
    destination_place TEXT NOT NULL,
PRIMARY KEY (route_number)
);

-- tabela bus_stops
CREATE TABLE bus_stops (
    id INTEGER NOT NULL AUTO_INCREMENT,
    route_number INTEGER NOT NULL,
    stop_latitude REAL NOT NULL,
    stop_longitude REAL NOT NULL,
    is_outbound BOOLEAN NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (route_number) REFERENCES bus_route (route_number)
);

-- inserir linhas
insert into bus_route(route_number,origin_city,origin_place,destination_city,destination_place) values (628,'Americana','Terminal Rodoviário Francisco Luiz Bendilatti','Santa Bárbara do Oeste','Rodoterminal');
insert into bus_route(route_number,origin_city,origin_place,destination_city,destination_place) values (622,'Americana','Terminal Rodoviário Francisco Luiz Bendilatti','Santa Bárbara do Oeste','Rodoterminal');

-- 628 ida campo sales ate sbo
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7343796,-47.3106312, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7372161,-47.3121689, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.737295,-47.3134781, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7357726,-47.3156415, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7318494,-47.3202891, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7334065,-47.3254566, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.735736,-47.3295579, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7373547,-47.3287533, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7405945,-47.3302226, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7412945,-47.3352243, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7422813,-47.3376083, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.743116,-47.3399304, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7427542,-47.3415824, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7440116,-47.3439035, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7451962,-47.3469208, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7448468,-47.3561727, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7456706,-47.3599339, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7464825,-47.3638017, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7473982,-47.3680174, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7479617,-47.3705772, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7494506,-47.3755657, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7503059,-47.3782211, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7531252,-47.3871712, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7546073,-47.3917487, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.755818,-47.3951539, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7577333,-47.3990835, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7568225,-47.4061782, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7548497,-47.4089484, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7533652,-47.411367, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7525556,-47.4141813, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7543375,-47.4153506, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7550325,-47.4183861, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7547387,-47.4207897, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7544269,-47.4233241, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7546428,-47.4265767, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7556009,-47.4297698, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.76502,-47.43495, true);

-- 628 volta sbo americana
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.76502,-47.43495, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.755329,-47.4284943, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.754616,-47.4260924, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7544808,-47.4233508, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7547341,-47.4212781, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7552084,-47.417539, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7539295,-47.4161185, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7521709,-47.4160057, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7533431,-47.4132256, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.755848,-47.4091478, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7567875,-47.4055732, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.758539,-47.3987279, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.755956,-47.3951439, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7547284,-47.3917945, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7533081,-47.3871031, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7504383,-47.3782605, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7494862,-47.375277, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7475476,-47.3679243, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7464514,-47.3630578, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7456703,-47.3594988, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7447912,-47.3554692, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7448663,-47.3525995, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7453047,-47.346503, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.743401,-47.3429076, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7418689,-47.3390628, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7405351,-47.3356023, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7396838,-47.3308787, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7373547,-47.3287533, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7353002,-47.3278409, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7334068,-47.3251932, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7318947,-47.3198646, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7326551,-47.3163573, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (628,-22.7343796,-47.3106312, false);

-- 622 ida american sbo
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7343796,-47.3106312, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7372161,-47.3121689, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.737295,-47.3134781, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7357726,-47.3156415, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7318494,-47.3202891, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7334065,-47.3254566, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.735736,-47.3295579, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7373547,-47.3287533, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.740976,-47.329587, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.743552,-47.329319, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7466255,-47.3307232, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7497426,-47.3331248, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7525011,-47.3352054, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7547869,-47.3364201, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7568236,-47.3375508, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7597075,-47.3392293, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7612402,-47.3460564, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7617369,-47.3529217, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7626968,-47.3661787, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7630498,-47.3709439, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7637644,-47.3808753, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.764062,-47.3889461, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7620551,-47.3943338, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7593495,-47.3976627, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7577333,-47.3990835, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7568225,-47.4061782, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7548497,-47.4089484, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7533652,-47.411367, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7525556,-47.4141813, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7543375,-47.4153506, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7550325,-47.4183861, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7547387,-47.4207897, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7544269,-47.4233241, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7546428,-47.4265767, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7556009,-47.4297698, true);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.76502,-47.43495, true);

-- 622 volta sbo american
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.76502,-47.43495, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.755329,-47.4284943, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.754616,-47.4260924, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7544808,-47.4233508, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7547341,-47.4212781, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7552084,-47.417539, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7539295,-47.4161185, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7521709,-47.4160057, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7533431,-47.4132256, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.755848,-47.4091478, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7567875,-47.4055732, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7606934,-47.3965867, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.762138,-47.3945507, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7664098,-47.3894949, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7682092,-47.3872511, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7662383,-47.3891828, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.764684,-47.3889534, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.764076,-47.3806916, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7639244,-47.3785003, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7632171,-47.3709928, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7629672,-47.3651922, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7627562,-47.3623872, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.764103,-47.3592008, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.761821,-47.3518889, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7642129,-47.3417915, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7628586,-47.3409858, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.759163,-47.3388231, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7576722,-47.3379913, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7547044,-47.3362933, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7517991,-47.3345988, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7497426,-47.3331248, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7475537,-47.331302, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7460516,-47.3302667, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.744398,-47.3291374, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7410742,-47.3295198, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7373547,-47.3287533, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7353002,-47.3278409, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7334068,-47.3251932, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7318947,-47.3198646, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7326551,-47.3163573, false);
insert into bus_stops(route_number,stop_latitude,stop_longitude,is_outbound) values (622,-22.7343796,-47.3106312, false);
