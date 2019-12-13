Content-Type: multipart/mixed; boundary="===============8372936508023650070=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Checklist before sending to netdev
Date: Fri, 13 Dec 2019 10:34:10 +0100
Message-ID: <71035e3b-bad3-8188-84f3-121d622eb20f@tessares.net>
In-Reply-To: 9f9c8b54-b0fb-2768-da42-958d58ad35fe@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2923

--===============8372936508023650070==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On 13/12/2019 00:36, Matthieu Baerts wrote:
> Here are the items we need to do before this Friday evening (US time):
> =

> - Test patches =E2=86=92 *all*

     - Compilations: [ OK ]
         - each commit with/without MPTCP, x86_64
         - i386
         - with/without IPv6
     - kselftests, with and without KASAN + PROVE_LOCKING: [ OK ]
         - on "mptcp: add basic kselftest for mptcp" commit
         - on "mptcp: process MP_CAPABLE data option." commit (new)
         - at the end of the series ("export" branch)

> - Share cover-letter for part 3 =E2=86=92 *Christoph*

Done! Thank you!

> - Review cover-letters =E2=86=92 *all*

I just added 2 new items on the list, please see:

   https://annuel2.framapad.org/p/mptcp_upstreaming_20191220


[ ] Review commit messages =E2=86=92 *all*:
     [X] Mat: sent some patches modifying the .topmsg
     [ ] Review patches
     [ ] Apply patches


[ ] Do we need a cover-letter for the cover-letters?:
     - I mean: a short introduction to explain what we are going to send:
         - The protocol is what it is and having a minimal set of =

features already signifies a lot of code.
         - This minimal set of features includes: the possibility for =

the userspace to establish and properly terminate MPTCP connections but =

limited to one subflow while still being able to transfer data in both =

directions
         - We decided to split everything in 3 parts to ease the reviews:
             - Part 1: Prerequisite TCP core changes
             - Part 2: MPTCP minimal set of features including selftests
             - Part 3: a switch from MPTCPv0 (RFC 6824) to MPTCPv1 (new =

RFC 8684 going to obsolete the previous one in the coming days)
         - The idea would be to apply everything in once (?)
     - we can also include that in the cover letter of Part 1


What do you think?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8372936508023650070==--
