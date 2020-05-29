Content-Type: multipart/mixed; boundary="===============6523587792010033356=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 0/4] mptcp: token container refactor
Date: Fri, 29 May 2020 17:11:57 +0200
Message-ID: <f30f3b5c-1449-3740-4944-35e5490f83dc@tessares.net>
In-Reply-To: cover.1590688878.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4554

--===============6523587792010033356==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 28/05/2020 20:01, Paolo Abeni wrote:
> This series supersede the RTC patch for token refactor. The relevant patch
> is unchanged, but this additional bring in some related minor cleanup
> (patch 1/4) and KUNIT (!!!) self-tests (4/4). To make things cleaner it a=
lso
> moves the existing in-kernel tests (crypto) to KUNIT.

Thank you for the patches and good to see KUnit tests :-)

These patches are now available on the export branch!

Just one small modification (as discussed on IRC):

- 1bb52f30810a: mptcp:kconfig: KUnit tests check token helpers

Tests are still OK!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6523587792010033356==--
