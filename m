Content-Type: multipart/mixed; boundary="===============6344167587550972239=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 mptcp] mptcp: use untruncated hash in ADD_ADDR
 HMAC
Date: Thu, 21 May 2020 14:48:51 -0700
Message-ID: <20200521214851.GA21533@MacBook-Pro-64.local>
In-Reply-To: 20200521211719.346750-1-todd.malsbary@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4448

--===============6344167587550972239==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 21/05/20 - 14:17:19, Todd Malsbary wrote:
> There is some ambiguity in the RFC as to whether the ADD_ADDR HMAC is
> the rightmost 64 bits of the entire hash or of the leftmost 160 bits
> of the hash.  The intention, as clarified with the author of the RFC,
> is the entire hash.
> =

> This change returns the entire hash from
> mptcp_crypto_hmac_sha (instead of only the first 160 bits), and moves
> any truncation/selection operation on the hash to the caller.
> =

> v1 -> v2:
> - move the hmac declaration in subflow_finish_connect to where it is
>   used (Christoph)
> =

> Fixes: 12555a2d97e5 ("mptcp: use rightmost 64 bits in ADD_ADDR HMAC")
> Signed-off-by: Todd Malsbary <todd.malsbary(a)linux.intel.com>
> ---
>  net/mptcp/crypto.c   | 24 +++++++++---------------
>  net/mptcp/options.c  |  9 +++++----
>  net/mptcp/protocol.h |  1 -
>  net/mptcp/subflow.c  | 15 ++++++++++-----
>  4 files changed, 24 insertions(+), 25 deletions(-)

Reviewed-by: Christoph Paasch <cpaasch(a)apple.com>


Christoph

--===============6344167587550972239==--
