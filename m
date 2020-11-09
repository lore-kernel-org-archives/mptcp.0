Content-Type: multipart/mixed; boundary="===============7288722692853328855=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next 11/12] mptcp: add the mib for
 ADD_ADDR with port
Date: Mon, 09 Nov 2020 11:44:19 +0800
Message-ID: <CA+WQbwu91RptcVW547aLpSx+=sMMF+_yx6Uuob2QHfj-0qzUig@mail.gmail.com>
In-Reply-To: b3a5f89c-8ec8-981c-6921-98e9537f163b@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6586

--===============7288722692853328855==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Thanks for your review.

Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2020=E5=B9=B411=
=E6=9C=885=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8810:04=E5=86=99=E9=
=81=93=EF=BC=9A
>
> Hi Geliang,
>
> On 05/11/2020 09:01, Geliang Tang wrote:
> > This patch added the mib for ADD_ADDR with port, named MPTCP_MIB_PORTAD=
D,
> > for receiving of the ADD_ADDR suboption with a port number.
>
> This MIB is useful!
>
> I think what could also be useful is a MIB counter we would increase
> when we receive an MP_JOIN to a different port than the original one.
> What do you think?
>
> It can be useful for those using this feature and also for our
> selftests: to validate we correctly receive the SYN+MPJ on a different
> port than the original one as expected, no?

I have sent out two squash-to patches to add more MIBs:
 Squash to "mptcp: add the mib for ADD_ADDR with port"
 Squash to "selftests: mptcp: add testcases for ADD_ADDR with port"

>
>
> I just see a risk with the new selftests that we don't see the new
> subflow is in fact established to the wrong port, not the one we
> expected. Or do we have a check for that?

And I have sent out a new patch named "mptcp: add port number check for
MP_JOIN" to do this check.

-Geliang

>
>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
--===============7288722692853328855==--
