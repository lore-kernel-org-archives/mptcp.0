Content-Type: multipart/mixed; boundary="===============8601211737324414117=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/2] kselftests: remove modif in framework +
 commit msg
Date: Fri, 13 Dec 2019 15:21:11 +0100
Message-ID: <381ad755-29d1-054c-272b-2728ef773bb0@tessares.net>
In-Reply-To: 20191213113854.1690771-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2934

--===============8601211737324414117==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On 13/12/2019 12:38, Matthieu Baerts wrote:
> As discussed yesterday, better to remove the modifications we did in
> the kselftest framework [1]. While looking at it, I propose to add more
> details in the commit message.

Because the first patch is a simple revert and for the second one, we =

can easily fix the commit message later, I propose to already apply =

these two patches:

- c62d1714fe95: "squashed" patch 1/2 in "mptcp: add basic kselftest for =

mptcp"
- 7c41e5e60cbb: "squashed" patch 2/2 in "mptcp: add basic kselftest for =

mptcp"

The CI scripts have been modified to re-apply the patch just before =

launching the tests and remove it after.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8601211737324414117==--
