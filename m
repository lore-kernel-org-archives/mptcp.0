Content-Type: multipart/mixed; boundary="===============6187700679502495244=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Checklist before sending to netdev
Date: Thu, 12 Dec 2019 15:47:35 -0800
Message-ID: <alpine.OSX.2.21.1912121545440.22800@amhui-mobl1.amr.corp.intel.com>
In-Reply-To: 9f9c8b54-b0fb-2768-da42-958d58ad35fe@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2905

--===============6187700679502495244==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 13 Dec 2019, Matthieu Baerts wrote:

> Hello,
>
> A few hours ago, I recreated the TopGit tree using Paolo's branch.
>
> Now I just applied all pending patches except the ones adding the MAINTAI=
NERS =

> file (because it is late and not affecting tests :) )
>
> My CI detected that when running the kselftests on the latest "mptcp: add =

> basic kselftest for mptcp" commit (MPTCPv0), we have an issue. Not when =

> running them on "mptcp: process MP_CAPABLE data option." (MPTCPv1) or at =
the =

> end of the series.
> It seems that the issue has been introduced after having applied patches =

> cleaning the fallback handling.
> Paolo is already looking at that in cave mode.
>
> Please also note that now the CI is testing the kselftests with 3 differe=
nt =

> version:
>
> - on "mptcp: add basic kselftest for mptcp" commit
> - on "mptcp: process MP_CAPABLE data option." commit (new)
> - at the end of the series ("export" branch)
>
>
>
> Here are the items we need to do before this Friday evening (US time):
>
> - Test patches =E2=86=92 *all*
>
> - Share cover-letter for part 3 =E2=86=92 *Christoph*
> - Review cover-letters =E2=86=92 *all*
>
> - Remove the fix in KSelftest framework =E2=86=92 *Matth*
> - Apply the fix in KSelftest framework only for CI =E2=86=92 *Matth*
>
> - Apply patches related to the MAINTAINERS file =E2=86=92 *Matth*
> - Add our mailing-list in the MAINTAINERS file =E2=86=92 *Matth*
>
> - Share patch(es) fixing kselftests when introduced =E2=86=92 *Paolo*
> - Review this/these patch(es) =E2=86=92 *EU-based people* (and others lat=
er)
> - Apply these patches =E2=86=92 *Matth*
>
> - Share patches fixing remaining checkpatch issues =E2=86=92 *Davide*
> - Review these patches =E2=86=92 *EU-based people* (and others later)
> - Apply these patches =E2=86=92 *Matth*
>
> - Add Mat (part 1 & 2) and Christoph' (part 3) signed-off =E2=86=92 *Matt=
h*
>
> - Share patches like we are going to send =E2=86=92 *Matth*
> - Review these patches =E2=86=92 *all*
>
> - Send Part 1 =E2=86=92 *Mat*
> - Send Part 2 =E2=86=92 *Mat*
> - Send Part 3 =E2=86=92 *Christoph*
>
> Did I miss anything? Anything wrong?
>

Addition:

  - Tag part1/part2/part3 and push to github

It's fine if you leave that for me in case there are last-minute tweaks =

affecting commit hashes.

--
Mat Martineau
Intel

--===============6187700679502495244==--
