Content-Type: multipart/mixed; boundary="===============3649802020152186117=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/4] mptcp: token refactor follow-up
Date: Fri, 05 Jun 2020 18:04:46 +0200
Message-ID: <33e846dd-e1a1-aeb3-2a3a-fa791194ccce@tessares.net>
In-Reply-To: cover.1591291903.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4597

--===============3649802020152186117==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Christoph,

On 04/06/2020 19:40, Paolo Abeni wrote:
> First patch clean-up a bit the token container refactor
> 2nd adapt the tests cases, 3rd one fixes a long standing
> bug which become apparent with token refactor and the
> last one helps debugging with kasan
> =

> patch 3 will target -net tree hopefully soon (adapted
> to the current -net token apis). will need a little
> rebasing of export branch after that.
> =

> @Christph: this series should replace any pending export branch fixes sha=
red on
> pastebin/mails/whatever (excluding the -net patch submitted little time a=
go)

Thank you for the patches and the reviews/test (on IRC)!

- d439e86abf12: "squashed" patch 1/4 in "mptcp: refactor token container."
- 0cf95b148037..c6c48c061cc1: result

- 80e87cdeeaaa: "squashed" patch 2/4 in "mptcp: introduce token KUNIT =

self-tests"
- c6c48c061cc1..b194cc9477a5: result

The other patches have been added at the end: b194cc9477a5..12401818bff5

"export" branch has just been updated, tests seem still OK!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============3649802020152186117==--
