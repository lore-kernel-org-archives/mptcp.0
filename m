Content-Type: multipart/mixed; boundary="===============2450667077100222160=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v4 3/3] selftests: mptcp: add
 IPv4-mapped IPv6 testcases
Date: Mon, 21 Dec 2020 20:10:13 +0800
Message-ID: <CA+WQbwu-e3h6hTT9-8-0__nAsQTJSnrszvq9DjaPvOgD2wLYpQ@mail.gmail.com>
In-Reply-To: f0a0f5c3-c047-44f0-c4bf-3612a31b5515@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7235

--===============2450667077100222160==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2020=E5=B9=B412=
=E6=9C=8821=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=887:49=E5=86=99=E9=
=81=93=EF=BC=9A
>
> Hi Geliang,
>
> On 21/12/2020 11:16, Geliang Tang wrote:
> > Hi Matt,
> >
> > Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2020=E5=B9=B4=
12=E6=9C=8819=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=889:07=E5=86=99=E9=
=81=93=EF=BC=9A
> >>
> >> From: Geliang Tang <geliangtang(a)gmail.com>
> >>
> >> Here, we make sure we support IPv4-mapped in IPv6 addresses in differe=
nt
> >> contexts:
>
> (...)
>
> >> +# no subflow IPv6 to v4 address
> >> +reset
> >> +ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> >> +ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> >> +ip netns exec $ns2 ./pm_nl_ctl add dead:beef:2::10.0.3.2 flags subflow
> >
> > dead:beef:2::10.0.3.2 is a invalid address, should we use dead:beef:3::=
2 here?
>
> I used "dead:beef:2::10.0.3.2" on purpose just to have a valid and
> usable IPv4 address at the end of the v6 one. If we try to use the IPv4
> address at the end of this v6 one, we will send the SYN+MPJ to the
> correct host (no routing issue). With the previous version of this
> patchset (v3), this was creating a subflow with 10.0.3.2!
>

Sorry, I didn't realize you did it on purpose, please keep it here.

> I should certainly add a new comment here.
> Maybe you would prefer an additional test with "dead:beef:3::2" as well?

Please add this additional test.

>
> >> +run_tests $ns1 $ns2 "10.0.1.1"
> >
> > We can drop the quotation marks here, only the IPv4-mapped address need
> > the quotation marks.
>
> Yes, I usually add quotes in Bash for each string but I see we didn't do
> that for the other tests, I will remove that!
>
> > And add "0 0 0 slow" behind it, since the test need to slow down when u=
se
> > the IPv6 address.
>
> Do I need to do that here as well even if we don't create v6 subflows?

I think this can be consistent with other IPv6 tests, but it's up to you :)

Thanks.

-Geliang

>
> >> +chk_join_nr "no JOIN with different families v4-v6" 0 0 0
> >
> > This string is too long, it break the alignment of the output. Can we u=
se
> > "diff" here instead of "different"?
>
> Good point, I didn't check that! I will short "different", good idea!
>
> >> +
> >> +# no subflow IPv4 to v6 address
> >> +reset
> >> +ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> >> +ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> >> +ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> >> +run_tests $ns1 $ns2 dead:beef:1::1
> >
> > Add "0 0 0 slow" here.
>
> Same here, is it needed if we don't create any IPv6 subflow?
>
> >> +chk_join_nr "no JOIN with different families v6-v4" 0 0 0
> >
> > This string is too long too.
>
> Will do in v5!
>
> Thanks for the review!
>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
--===============2450667077100222160==--
