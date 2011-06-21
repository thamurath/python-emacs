;; cpp-tests project definition
 (ede-cpp-root-project "RG"
                       :file "/home/eojojos/DataStore/Work/RatingGroups/source/Imakefile"
                       :include-path '("/"
                                       )
                                         ;
                                         ;:system-include-path '("/home/ott/exp/include"
                                         ;                       boost-base-directory)
                                         ;:local-variables (list
                                         ;                   (cons 'compile-command 'alexott/gen-cmake-debug-compile-string)
                                         ;                 )
                       )
                                      ;)
 (ede-cpp-root-project "SASN"
                       :file "/home/eojojos/DataStore/git-sasn-repos/SASN/Imakefile"
                       :include-path '("/"
                                       )
                                         ;
                                         ;:system-include-path '("/home/ott/exp/include"
                                         ;                       boost-base-directory)
                                         ;:local-variables (list
                                         ;                   (cons 'compile-command 'alexott/gen-cmake-debug-compile-string)
                                         ;                 )
                       )
(ede-cpp-root-project "-another-SASN"
                       :file "/home/eojojos/DataStore/git-sasn-repos/another/SASN/Imakefile"
                       :include-path '("/"
                                       )

                       :system-include-path '("/opt/nsfw/include")

                       :local-variables (list
                                        (cons 'compile-command 'make)
                                        )
                       )

