Content-Type: multipart/mixed; boundary="===============4871554510046282241=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] token: fix rcu ptr manipulatation.
Date: Fri, 18 Oct 2019 12:02:51 +0200
Message-ID: <c60cf402-fd3a-20b5-c1f0-2f21d7baf82a@tessares.net>
In-Reply-To: 73846495d8826b1b1ec820d6206dfaa1c2e5b9a0.1571326920.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2235

--===============4871554510046282241==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 17/10/2019 17:43, Paolo Abeni wrote:
> the radix tree slot manipulation needs some extra care to fit
> the RCU annotation. Also replace raw *slot assignment with
> the related radix tree helper - elsewhere sparse will lament there, too.
> =

> Squash-to: "mptcp: Add key generation and token tree"
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>   net/mptcp/token.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Good catch!
Thank you for the patch.

- a82b36982240: "squashed" in "mptcp: Add key generation and token tree"
- signed-off already there
- f112b4fbab2a..164ffcf0299c: result

Tests are still OK!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============4871554510046282241==--
