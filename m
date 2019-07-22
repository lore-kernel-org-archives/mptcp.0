Content-Type: multipart/mixed; boundary="===============0700202237159561792=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 2/2] net: mptcp: randomness improvements for
 crypto.c
Date: Mon, 22 Jul 2019 15:44:14 -0700
Message-ID: <alpine.OSX.2.21.1907221540460.2401@mjmartin-mac01.local>
In-Reply-To: d63c624fd94a9a11cd65b7f9a0705f1371f8d054.1562864862.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1540

--===============0700202237159561792==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Jul 2019, Davide Caratti wrote:

> use get_random_bytes(), instead of siphash, for MPTCP keys and nonces.
> This should improve MPTCP key/nonce randomness, because seeds are no
> more initialized at a fixed time during the boot process, and we also
> get rid of 'static u32 crypto_seed' (that can theoretically clash in
> case sockets were requesting the key from different namespaces).
>
> CC: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> CC: Florian Westphal <fwestpha(a)redhat.com>
> CC: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> ---
> net/mptcp/crypto.c   | 73 +-------------------------------------------
> net/mptcp/protocol.c |  1 -
> net/mptcp/protocol.h | 11 -------
> net/mptcp/token.c    | 49 +++--------------------------
> 4 files changed, 5 insertions(+), 129 deletions(-)
>
> diff --git a/net/mptcp/crypto.c b/net/mptcp/crypto.c
> index e8644590690f..843bf1b5c4d9 100644
> --- a/net/mptcp/crypto.c
> +++ b/net/mptcp/crypto.c
> @@ -24,71 +24,9 @@
> #include <linux/cryptohash.h>
> #include <linux/random.h>
> #include <linux/siphash.h>
> +#include <net/tcp.h>

I think this header was added for tcp_cookie_time() (in the RFC patch set) =

and isn't needed now.

The rest of the changes look good.


Mat

> #include <asm/unaligned.h>
>
> -static siphash_key_t crypto_key_secret __read_mostly;
> -static hsiphash_key_t crypto_nonce_secret __read_mostly;
> -static u32 crypto_seed;
> -
> -u32 crypto_v4_get_nonce(__be32 saddr, __be32 daddr, __be16 sport, __be16=
 dport)
> -{
> -	return hsiphash_4u32((__force u32)saddr, (__force u32)daddr,
> -			    (__force u32)sport << 16 | (__force u32)dport,
> -			    crypto_seed++, &crypto_nonce_secret);
> -}
> -
> -u64 crypto_v4_get_key(__be32 saddr, __be32 daddr, __be16 sport, __be16 d=
port)
> -{
> -	pr_debug("src=3D%x:%d, dst=3D%x:%d", saddr, sport, daddr, dport);
> -	return siphash_4u32((__force u32)saddr, (__force u32)daddr,
> -			    (__force u32)sport << 16 | (__force u32)dport,
> -			    crypto_seed++, &crypto_key_secret);
> -}
> -
> -u32 crypto_v6_get_nonce(const struct in6_addr *saddr,
> -			const struct in6_addr *daddr,
> -			__be16 sport, __be16 dport)
> -{
> -	const struct {
> -		struct in6_addr saddr;
> -		struct in6_addr daddr;
> -		u32 seed;
> -		__be16 sport;
> -		__be16 dport;
> -	} __aligned(SIPHASH_ALIGNMENT) combined =3D {
> -		.saddr =3D *saddr,
> -		.daddr =3D *daddr,
> -		.seed =3D crypto_seed++,
> -		.sport =3D sport,
> -		.dport =3D dport,
> -	};
> -
> -	return hsiphash(&combined, offsetofend(typeof(combined), dport),
> -			&crypto_nonce_secret);
> -}
> -
> -u64 crypto_v6_get_key(const struct in6_addr *saddr,
> -		      const struct in6_addr *daddr,
> -		      __be16 sport, __be16 dport)
> -{
> -	const struct {
> -		struct in6_addr saddr;
> -		struct in6_addr daddr;
> -		u32 seed;
> -		__be16 sport;
> -		__be16 dport;
> -	} __aligned(SIPHASH_ALIGNMENT) combined =3D {
> -		.saddr =3D *saddr,
> -		.daddr =3D *daddr,
> -		.seed =3D crypto_seed++,
> -		.sport =3D sport,
> -		.dport =3D dport,
> -	};
> -
> -	return siphash(&combined, offsetofend(typeof(combined), dport),
> -		       &crypto_key_secret);
> -}
> -
> void crypto_key_sha1(u64 key, u32 *token, u64 *idsn)
> {
> 	u32 workspace[SHA_WORKSPACE_WORDS];
> @@ -191,12 +129,3 @@ void crypto_hmac_sha1(u64 key1, u64 key2, u32 *hash_=
out,
> 	for (i =3D 0; i < 5; i++)
> 		hash_out[i] =3D (__force u32)cpu_to_be32(hash_out[i]);
> }
> -
> -void crypto_init(void)
> -{
> -	get_random_bytes((void *)&crypto_key_secret,
> -			 sizeof(crypto_key_secret));
> -	get_random_bytes((void *)&crypto_nonce_secret,
> -			 sizeof(crypto_nonce_secret));
> -	crypto_seed =3D 0;
> -}
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 774ed25d3b6d..7347da1e7a39 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1006,7 +1006,6 @@ void __init mptcp_init(void)
> 	mptcp_stream_ops.shutdown =3D mptcp_shutdown;
>
> 	token_init();
> -	crypto_init();
> 	subflow_init();
>
> 	if (proto_register(&mptcp_prot, 1) !=3D 0)
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 7f15f6aab93d..1997fa69981f 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -207,17 +207,6 @@ void token_update_accept(struct sock *sk, struct soc=
k *conn);
> void token_release(u32 token);
> void token_destroy(u32 token);
>
> -void crypto_init(void);
> -u32 crypto_v4_get_nonce(__be32 saddr, __be32 daddr,
> -			__be16 sport, __be16 dport);
> -u64 crypto_v4_get_key(__be32 saddr, __be32 daddr,
> -		      __be16 sport, __be16 dport);
> -u64 crypto_v6_get_key(const struct in6_addr *saddr,
> -		      const struct in6_addr *daddr,
> -		      __be16 sport, __be16 dport);
> -u32 crypto_v6_get_nonce(const struct in6_addr *saddr,
> -			const struct in6_addr *daddr,
> -			__be16 sport, __be16 dport);
> void crypto_key_sha1(u64 key, u32 *token, u64 *idsn);
> void crypto_hmac_sha1(u64 key1, u64 key2, u32 *hash_out,
> 		      int arg_num, ...);
> diff --git a/net/mptcp/token.c b/net/mptcp/token.c
> index c2f4fcb37566..9c0fe5caaf1e 100644
> --- a/net/mptcp/token.c
> +++ b/net/mptcp/token.c
> @@ -68,22 +68,8 @@ static void new_req_token(struct request_sock *req,
> {
> 	const struct inet_request_sock *ireq =3D inet_rsk(req);
> 	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
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
> 	crypto_key_sha1(subflow_req->local_key, &subflow_req->token,
> 			&subflow_req->idsn);
> 	pr_debug("local_key=3D%llu, token=3D%u, idsn=3D%llu", subflow_req->local=
_key,
> @@ -97,23 +83,8 @@ static void new_req_join(struct request_sock *req, str=
uct sock *sk,
> 	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
> 	struct mptcp_sock *msk =3D mptcp_sk(sk);
> 	u8 hmac[MPTCPOPT_HMAC_LEN];
> -	u32 nonce;
> -
> -	if (skb->protocol =3D=3D htons(ETH_P_IP)) {
> -		nonce =3D crypto_v4_get_nonce(ip_hdr(skb)->saddr,
> -					    ip_hdr(skb)->daddr,
> -					    htons(ireq->ir_num),
> -					    ireq->ir_rmt_port);
> -#if IS_ENABLED(CONFIG_IPV6)
> -	} else {
> -		nonce =3D crypto_v6_get_nonce(&ipv6_hdr(skb)->saddr,
> -					    &ipv6_hdr(skb)->daddr,
> -					    htons(ireq->ir_num),
> -					    ireq->ir_rmt_port);
> -#endif
> -	}
> -	subflow_req->local_nonce =3D nonce;
>
> +	get_random_bytes(&subflow_req->local_nonce, sizeof(u32));
> 	crypto_hmac_sha1(msk->local_key,
> 			 msk->remote_key,
> 			 (u32 *)hmac, 2,
> @@ -145,19 +116,7 @@ static void new_token(const struct sock *sk)
> 	struct subflow_context *subflow =3D subflow_ctx(sk);
> 	const struct inet_sock *isk =3D inet_sk(sk);
>
> -	if (sk->sk_family =3D=3D AF_INET) {
> -		subflow->local_key =3D crypto_v4_get_key(isk->inet_saddr,
> -						       isk->inet_daddr,
> -						       isk->inet_sport,
> -						       isk->inet_dport);
> -#if IS_ENABLED(CONFIG_IPV6)
> -	} else {
> -		subflow->local_key =3D crypto_v6_get_key(&inet6_sk(sk)->saddr,
> -						       &sk->sk_v6_daddr,
> -						       isk->inet_sport,
> -						       isk->inet_dport);
> -#endif
> -	}
> +	get_random_bytes(&subflow->local_key, sizeof(u64));
> 	crypto_key_sha1(subflow->local_key, &subflow->token, &subflow->idsn);
> 	pr_debug("local_key=3D%llu, token=3D%u, idsn=3D%llu", subflow->local_key,
> 		 subflow->token, subflow->idsn);
> -- =

> 2.20.1

--
Mat Martineau
Intel

--===============0700202237159561792==--
