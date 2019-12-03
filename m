Content-Type: multipart/mixed; boundary="===============8195153134581496846=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 2/3] mptcp: avoid data stream corruption on
 allocation failure.
Date: Tue, 03 Dec 2019 12:17:45 +0100
Message-ID: <605b0d917d34c013556e6d735e1af4d80211230f.camel@redhat.com>
In-Reply-To: 379cb7e6d48b763a8d09b57dc0d42a94599bf085.1574331014.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2767

--===============8195153134581496846==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-11-21 at 11:31 +0100, Paolo Abeni wrote:
> Currently, when if mpext allocation fails, the data stream
> is corrupted, as we can add the required DSS nor roll-back
> the TCP status.
> =

> Allocate a skb_ext before the actuall skb_buff creation/TCP
> status update: in case of memory allocation failure we can
> bail early, avoiding the above condition.
> =

> Additionally, if the ext is unused to to skb collapsing,
> cache the ext in the msk for the next send.
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>  net/mptcp/protocol.c | 64 +++++++++++++++++++++++++-------------------
>  net/mptcp/protocol.h |  1 +
>  2 files changed, 38 insertions(+), 27 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 1a432abfb176..38259a8a5df3 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -190,6 +190,14 @@ mptcp_carve_data_frag(const struct mptcp_sock *msk, =
struct page_frag *pfrag,
>  	return dfrag;
>  }
>  =

> +static bool mptcp_ext_cache_refill(struct mptcp_sock *msk)
> +{
> +	if (!msk->cached_ext)
> +		msk->cached_ext =3D skb_ext_alloc();
> +
> +	return msk->cached_ext;

nit: maybe it's better to make an explicit conversion to bool, like done
elsewhere, e.g.:

	return !!msk->cached_ext;

WDYT?
-- =

davide

--===============8195153134581496846==--
