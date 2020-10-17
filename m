Content-Type: multipart/mixed; boundary="===============2710254309669988093=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v5 mptcp-next 2/2] selftests: mptcp: add
 ADD_ADDR timeout test case
Date: Sat, 17 Oct 2020 08:53:33 +0800
Message-ID: <CA+WQbwtACx2FLMHBCF7raR49Bg-aCx2hVALH_bddrkK8_qoiWw@mail.gmail.com>
In-Reply-To: a53638d5-c832-4bb2-1cd9-16a7e385a947@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6334

--===============2710254309669988093==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2020=E5=B9=B410=
=E6=9C=8816=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=8811:02=E5=86=99=E9=
=81=93=EF=BC=9A
>
> Hi Geliang,
>
> On 16/10/2020 11:28, Geliang Tang wrote:
> > Hi Matt,
> >
> > As I mentioned in the last meeting, I want to add ADD_ADDR timeout IPv6
> > test case. My patch is something like this:
> >
> > +reset_with_add_addr6_timeout()
> > +{
> > +       reset
> > +
> > +       ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=3D1
> > +       ip netns exec $ns2 ip6tables -A OUTPUT -p tcp \
> > +               -m tcp --tcp-option 30 \
> > +               -m bpf --bytecode \
> > +               "$(nfbpf_compile '(tcp[34] & 0xf0) =3D=3D 0x30')" \
> > +               -j DROP
> > +}
> > +
> >   for arg in "$@"; do
> >          if [ "$arg" =3D "-c" ]; then
> >                  capture=3D1
> > @@ -590,6 +604,22 @@ ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2
> > flags subflow
> >   run_tests $ns1 $ns2 dead:beef:1::1 0 0 slow
> >   chk_join_nr "single subflow IPv6" 1 1 1
> >
> > +# add_addr timeout IPv6
> > +reset_with_add_addr6_timeout
> > +ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > +ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> > +ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
> > +run_tests $ns1 $ns2 dead:beef:1::1 0 0 slow
> > +chk_join_nr "signal address, ADD_ADDR6 timeout" 1 1 1
> > +chk_add_nr 4 0
> > +
> >   # signal address IPv6
> >   reset
> >   ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> >
> > But this BPF (tcp[34] & 0xf0) =3D=3D 0x30') is not working on IPv6, ple=
ase
> > give me some help
> > about how to get this right offset value on IPv6. Thanks very much.
>
> It looks like it cannot get the offset correctly with TCP. The best is
> then to start from the IP layer and suppose there will not be any IPv6
> extension: we control the selftests environment and we already check
> with IPTables that we have TCP.
>
>
> $ docker run quay.io/casey_callendrello/nfbpf_compile RAW "(ip[54] &
> 0xf0) =3D=3D 0x30"
> 8,48 0 0 0,84 0 0 240,21 0 4 64,48 0 0 54,84 0 0 240,21 0 1 48,6 0 0
> 65535,6 0 0 0
>
>
> $ docker run quay.io/casey_callendrello/nfbpf_compile RAW "(ip6[74] &
> 0xf0) =3D=3D 0x30"
> 8,48 0 0 0,84 0 0 240,21 0 4 96,48 0 0 74,84 0 0 240,21 0 1 48,6 0 0
> 65535,6 0 0 0
>
>
> May you try with these two new bytecodes please?

I have tested these two bytecodes, they all work well. I'll add them in the
ADD_ADDR IPV6 testcase patch.

Thanks.
-Geliang

>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
--===============2710254309669988093==--
