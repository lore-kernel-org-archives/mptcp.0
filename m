Content-Type: multipart/mixed; boundary="===============1483858967616392675=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 2/2] net: mptcp: randomness improvements for
 crypto.c
Date: Tue, 23 Jul 2019 17:01:32 +0200
Message-ID: <916ec827-f9e9-00dd-1017-68234ae01282@tessares.net>
In-Reply-To: d63c624fd94a9a11cd65b7f9a0705f1371f8d054.1562864862.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1542

--===============1483858967616392675==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide,

On 11/07/2019 19:12, Davide Caratti wrote:
> use get_random_bytes(), instead of siphash, for MPTCP keys and nonces.
> This should improve MPTCP key/nonce randomness, because seeds are no
> more initialized at a fixed time during the boot process, and we also
> get rid of 'static u32 crypto_seed' (that can theoretically clash in
> case sockets were requesting the key from different namespaces).
> =

> CC: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> CC: Florian Westphal <fwestpha(a)redhat.com>
> CC: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> ---
>  net/mptcp/crypto.c   | 73 +-------------------------------------------
>  net/mptcp/protocol.c |  1 -
>  net/mptcp/protocol.h | 11 -------
>  net/mptcp/token.c    | 49 +++--------------------------
>  4 files changed, 5 insertions(+), 129 deletions(-)

(...)

> diff --git a/net/mptcp/token.c b/net/mptcp/token.c
> index c2f4fcb37566..9c0fe5caaf1e 100644
> --- a/net/mptcp/token.c
> +++ b/net/mptcp/token.c
> @@ -68,22 +68,8 @@ static void new_req_token(struct request_sock *req,
>  {
>  	const struct inet_request_sock *ireq =3D inet_rsk(req);
>  	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
> -	u64 local_key;
> -
> -	if (!IS_ENABLED(CONFIG_IPV6) || skb->protocol =3D=3D htons(ETH_P_IP)) {
> -		local_key =3D crypto_v4_get_key(ip_hdr(skb)->saddr,
> -					      ip_hdr(skb)->daddr,
> -					      htons(ireq->ir_num),
> -					      ireq->ir_rmt_port);
> -#if IS_ENABLED(CONFIG_IPV6)
> -	} else {
> -		local_key =3D crypto_v6_get_key(&ipv6_hdr(skb)->saddr,
> -					      &ipv6_hdr(skb)->daddr,
> -					      htons(ireq->ir_num),
> -					      ireq->ir_rmt_port);
> -#endif
> -	}
> -	subflow_req->local_key =3D local_key;
> +
> +	get_random_bytes(&subflow_req->local_key, sizeof(u64));

May you add a comment here (and maybe also below) mentioning that this
is enough for the moment but a hash with the right info might be
interesting to do as an optimisation for later? We briefly discussed
about that at the last meeting.

Just to know if I can apply the current version after having removed the
#include mentioned by Mat or if I should wait :)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============1483858967616392675==--
