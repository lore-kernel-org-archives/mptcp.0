Content-Type: multipart/mixed; boundary="===============5653018707580525268=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 0/7] Minor patches
Date: Fri, 07 Jun 2019 13:24:47 +0200
Message-ID: <b5c034c6-bffc-a8e9-a35d-ab3421924add@tessares.net>
In-Reply-To: 20190606003632.2863-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1313

--===============5653018707580525268==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 06/06/2019 02:36, Peter Krystad wrote:
> Mostly responding to some of Paolo's comments on the MP_JOIN RFC.
> =

> Peter Krystad (7):
>   mptcp: reduce number of pr_debug() calls.
>   mptcp: reduce number of pr_debug() calls.
>   mptcp: reduce number of pr_debug() calls.
>   mptcp: reduce number of pr_debug() calls.
>   mptcp: parsing DSS option should use own flags field.
>   mptcp: Check flags in MP_CAPABLE option
>   mptcp: Refactor mptcp_established_options() to single hook

Thank you for this patch-set!

As agreed yesterday at the meeting, I added patches 2 =E2=86=92 6 in the re=
po.

Please note that the first patch was also doing some refactoring that
were affecting the 6th patch ("mptcp: Check flags in MP_CAPABLE
option"). For more details about that, please see the corresponding email.

When you will send a v2 for the first and last patch, may you do a
rebase and also apply the refactoring in the code changed by the 6th
patch? Anyway I guess you should get a small and simple conflict when
doing the rebase.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============5653018707580525268==--
