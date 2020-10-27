Content-Type: multipart/mixed; boundary="===============1196312190111123282=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next] Squash to "selftests: mptcp:
 add link failure test case"
Date: Tue, 27 Oct 2020 15:23:06 +0800
Message-ID: <CA+WQbwu-xkUtyay4sxxs7rFY22BYdqHLXtFeO323zywW+NVhJA@mail.gmail.com>
In-Reply-To: fa59c2bd-cce6-1c98-82c8-b6e13f375972@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6440

--===============1196312190111123282==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Sorry that I didn't write the commit message clearly.

Here is the original patch:

$ cat 0001-selftests-mptcp-add-link-failure-test-case.patch  | grep run_tes=
ts
 run_tests()
@@ -300,14 +330,32 @@ run_tests()
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
+run_tests $ns1 $ns2 10.0.1.1 1
-run_tests $ns1 $ns2 10.0.1.1 0 0 slow
+run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
-run_tests $ns1 $ns2 10.0.1.1 0 1 slow
+run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow
-run_tests $ns1 $ns2 10.0.1.1 0 2 slow
+run_tests $ns1 $ns2 10.0.1.1 0 0 2 slow
-run_tests $ns1 $ns2 10.0.1.1 1 0 slow
+run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
-run_tests $ns1 $ns2 10.0.1.1 1 1 slow
+run_tests $ns1 $ns2 10.0.1.1 0 1 1 slow
-run_tests $ns1 $ns2 10.0.1.1 1 2 slow
+run_tests $ns1 $ns2 10.0.1.1 0 1 2 slow
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0

It changed run_tests 22 times with test_linkfail=3D0,
and only added one run_tests with test_linkfail=3D1.

If we change test_linkfail as an optional argument,
and set it's default value to 0. We don't need to change
all 22 run_tests, we just need to change the 6 run_tests
with the "slow" flag. It can save some code.

-Geliang

Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2020=E5=B9=B410=
=E6=9C=8822=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8810:57=E5=86=99=E9=
=81=93=EF=BC=9A
>
> Hi Geliang,
>
> On 22/10/2020 05:47, Geliang Tang wrote:
> > Change run_tests()'s test_linkfail as an optional argument, and set it's
> > default value to 0.
>
> To be honest, I don't know what we should do here: either we only have
> explicit parameters or we use the default ones most of the time.
> For example, I see that the 3 first parameters are always the same ($ns1
> $ns2 10.0.1.1). Do we need to define them each time?
>
> Maybe clearer if we always set them but in this case it is not really
> clearer if you just have:
>
>    run_tests 0 0 0 fast
>
> Except the last one, it is not obvious what they are referring to :)
>
> Alternative solutions:
>
>    run_tests linkfail 0 0 fast
>    linkfail=3D1 run_tests
>
> Or maybe we don't need to care because it is "just" a script for some
> selftests!
>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
--===============1196312190111123282==--
