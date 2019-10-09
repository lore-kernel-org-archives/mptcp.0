Content-Type: multipart/mixed; boundary="===============7341948784131090541=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: fix kbuild warning
Date: Wed, 09 Oct 2019 19:48:24 +0200
Message-ID: <bffefd18-7208-6733-8260-9d9719c8bbcd@tessares.net>
In-Reply-To: 20191009115415.13181-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2076

--===============7341948784131090541==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 09/10/2019 13:54, Matthieu Baerts wrote:
> The warning:
> =

>   net//mptcp/protocol.c:440:4: warning: format '%ld' expects argument of
>                                type 'long int', but argument 4 has type
>                                'size_t' [-Wformat=3D]
> =

> '%zu' should be used with size_t.
> =

> Reported-by: kbuild test robot <lkp(a)intel.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

I hope you don't mind if I already merge this to avoid one very basic
warning from kbuild test robot before creating a new tag.

- 3d7ed33d467e: "squashed" in "mptcp: Implement MPTCP receive path"
- signed-off already there
- ac0acc93b158..4ab3777d5ac7: result

Tests are still OK.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============7341948784131090541==--
