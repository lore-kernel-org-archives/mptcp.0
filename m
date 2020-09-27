Content-Type: multipart/mixed; boundary="===============7710229545724548527=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next 1/3] mptcp: add add_addr_echo
 sysctl
Date: Sun, 27 Sep 2020 18:36:34 +0800
Message-ID: <CA+WQbwtQEhVTtAB=WJse+g72CJGJnkSOjbU1L1Ri3mLL2cNWwg@mail.gmail.com>
In-Reply-To: 2f26faba-2a0c-aa77-a766-a6bd19b87f95@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6062

--===============7710229545724548527==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt, Paolo,

Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2020=E5=B9=B49=E6=
=9C=8826=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=884:45=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Hi Geliang, Paolo,
>
> On 25/09/2020 10:55, Paolo Abeni wrote:
> > On Fri, 2020-09-25 at 13:25 +0800, Geliang Tang wrote:
> >> Paolo Abeni <pabeni(a)redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8823=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=886:26=E5=86=99=E9=81=93=EF=BC=
=9A
> >>> On Tue, 2020-09-22 at 16:12 +0800, Geliang Tang wrote:
> >>>> This patch added a new sysctl, named add_addr_echo, to control
> >>>> the
> >>>> ADD_ADDR
> >>>> echo ability.
> >>>>
> >>>> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> >>>
> >>> If I read the series correctly, this sysctl is only needed for
> >>> self-
> >>> test's sake, right? can you instead drop the add_addr packet with
> >>> some
> >>> netfilter rules ? possibly matching on TCP PROTO, TCP len =3D=3D 0 and
> >>> the
> >>> appropriate packet len should be sufficient.
> >>
> >> I still have not found the rules that can drop ADD_ADDR packets. But
> >> I found
> >> something useful like this:
> >>
> >> # iptables -A OUTPUT -p tcp --tcp-option 30 -m length --length 0:100
> >> -j DROP
> >>
> >> "tcp-option 30" can match MPTCP packets, and "length" can match the
> >> IP
> >> packet's total length. But they are not sufficient.
> >
> > You can use u32 to check that the sub-option type is 3 (=3D=3D ADD_ADDR=
),
> > with something alike:
> >
> > iptables -A OUTPUT -p tcp --tcp-option 30 -m length 80 -m u32 "37&0xFF=
=3D=3D0x1 && 38&0xFF=3D=3D0x1 && 39&0xFF=3D=3D0x8 && 49&0xFF=3D=3D0x1e && 5=
1&0xFF=3D=3D0x3" -j DROP
>
> Another technique is to use libpcap filter and then convert it to cBPF
> filter. That's very similar to Paolo's technique using offsets but maybe
> easier to validate:
>
> - first, find the libpcap filter:
>    - Manual: https://www.tcpdump.org/manpages/pcap-filter.7.html
>    - You can use offset from TCP layer: tcp[<offset>] & <mask> =3D=3D <va=
lue>
>    - e.g. check MPTCP is used at the offset 20(tcp)+12(timestamps):
>      tcp[32]=3D=3D30
>    - and check the subtype is 3: (tcp[34] & 0xf0) =3D=3D 0x30
>    - (of course, feel free to check the length, the protocol, etc.)
>
> - try it:
>    $ tcpdump -nr trace.pcap "tcp[32] =3D=3D 30 and (tcp[34] & 0xf0) =3D=
=3D 0x30"
>      16:58:30.494716 IP 1.2.3.4.5001 > 4.3.2.1.38900: Flags [.], ack
> 3693886387, win 224, options [nop,nop,TS val 525599374 ecr
> 341597418,mptcp add-addr id 3 2.2.2.2,mptcp dss ack 419984920], length 0
>
> - convert it to cBPF:
>    $ docker run quay.io/casey_callendrello/nfbpf_compile "tcp[32] =3D=3D =
30
> and (tcp[34] & 0xf0) =3D=3D 0x30"
>    15,48 0 0 0,84 0 0 240,21 0 11 64,48 0 0 9,21 0 9 6,40 0 0 6,69 7 0
> 8191,177 0 0 0,80 0 0 32,21 0 4 30,80 0 0 34,84 0 0 240,21 0 1 48,6 0 0
> 65535,6 0 0 0
>
> - Use it with IPTables:
>    $ iptables -w -A OUTPUT -m bpf --bytecode '15,48 0 0 0,84 0 0 240,21
> 0 11 64,48 0 0 9,21 0 9 6,40 0 0 6,69 7 0 8191,177 0 0 0,80 0 0 32,21 0
> 4 30,80 0 0 34,84 0 0 240,21 0 1 48,6 0 0 65535,6 0 0 0' -j DROP
>    - feel free to combine that with other matcher, e.g. "-p tcp
> --tcp-option 30" and just use cBPF to find the subtype: "(tcp[34] &
> 0xf0) =3D=3D 0x30"

Thanks for your help. I added this in patch v2.

-Geliang

>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
--===============7710229545724548527==--
