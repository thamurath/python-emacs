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

                       ;; :local-variables (list
                       ;;                  (cons 'compile-command 'make)
                       ;;                  )
                       )

(ede-cpp-root-project "SASN"
                       :file "/home/eojojos/HugeDataStore/Source/SASN/Imakefile"
                       :include-path '("/NSdiametercom/lib/diameter"
                                       )

                       :system-include-path '("/opt/nsfw/include")

                       ;; :local-variables (list
                       ;;                  (cons 'compile-command 'make)
                       ;;                  )
                       )

(ede-cpp-root-project "CooperativeVisitor"
                       :file "/home/eojojos/HugeDataStore/Source/Projects/CooperativeVisitor/Readme.txt"
                       :include-path '("/." "/../"
                                       )

                       :system-include-path '("")

                       ;; :local-variables (list
                       ;;                  (cons 'compile-command 'make)
                       ;;                  )
                       )

(ede-cpp-root-project "TypeLists"
                       :file "/home/eojojos/HugeDataStore/Source/Projects/TypeLists/Readme.txt"
                       :include-path '("/." "/../"
                                       )

                       :system-include-path '("")

                       ;; :local-variables (list
                       ;;                  (cons 'compile-command 'make)
                       ;;                  )
                       )

(ede-cpp-root-project "CompileTimeTools"
                       :file "/home/eojojos/HugeDataStore/Source/Projects/CompileTimeTools/Readme.txt"
                       :include-path '("/." "/../"
                                       )

                       :system-include-path '("")

                       ;; :local-variables (list
                       ;;                  (cons 'compile-command 'make)
                       ;;                  )
                       )
(ede-cpp-root-project "CooperativeVisitorTest"
                       :file "/home/eojojos/HugeDataStore/Source/Projects/__CooperativeVisitorTest/Readme.txt"
                       :include-path '("/." "/../"
                                       )

                       :system-include-path '("")

                       ;; :local-variables (list
                       ;;                  (cons 'compile-command 'make)
                       ;;                  )
                       )
(ede-cpp-root-project "Variant"
                       :file "/home/eojojos/HugeDataStore/Source/Projects/Variant/Readme.txt"
                       :include-path '("/." "/../"
                                       )

                       :system-include-path '("")

                       ;; :local-variables (list
                       ;;                  (cons 'compile-command 'make)
                       ;;                  )
                       )
(ede-cpp-root-project "StringUtilities"
                       :file "/home/eojojos/HugeDataStore/Source/Projects/StringUtilities/Readme.txt"
                       :include-path '("/." "/../"
                                       )

                       :system-include-path '("")

                       ;; :local-variables (list
                       ;;                  (cons 'compile-command 'make)
                       ;;                  )
                       )
