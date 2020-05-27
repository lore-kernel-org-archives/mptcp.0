Content-Type: multipart/mixed; boundary="===============4695370733656557873=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 2/4] mptcp: refactor token container.
Date: Wed, 27 May 2020 16:16:22 -0700
Message-ID: <20200527231622.GO81884@MacBook-Pro-64.local>
In-Reply-To: 39bb80a64be551c0194806879246b91394fead4e.1590427813.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4518

--===============4695370733656557873==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

(sorry for the late reply - I kind of missed this email)

On 05/25/20 - 19:35, Paolo Abeni wrote:
> Replace the radix tree with an hash table allocated
> at boot time. The radix tree has some short coming:
> a single lock is contented by all the mptcp operation,
> the lookup currently use such lock, and traversing
> all the items would require lock, too.
> =

> With hash table instead we trade a little memory to
> address all the above - a per bucket lock is used.
> =

> To hash the MPTCP sockets, we re-use the msk' sk_node
> entry: the MPTCP sockets are never hashed by the stack.
> Replace the existing hash proto callbacks with dummy
> implementation, annotating the above constraint.
> =

> Additionally refactor the token creation to code to:
> =

> - limit the number of consecutive attempts to a fixed
> maximum. Hitting an hash bucket with long chain is
> considered a failed attempt
> =

> - accept() no longer can fail to to token management.
> =

> - if token creation fails at connect() time, we do
> fallback to TCP (before the connection was closed)
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> v1 -> v2:
>  - __token_bucket_busy is now static (Mat)
>  - drop refcnt on lookup loop (CP)
>  - use sk_node to hash the msk.
> ---
>  net/mptcp/protocol.c |  35 +++---
>  net/mptcp/protocol.h |   5 +-
>  net/mptcp/subflow.c  |  10 +-
>  net/mptcp/token.c    | 249 ++++++++++++++++++++++++++++++-------------
>  4 files changed, 204 insertions(+), 95 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 951c975b8ce5..5f036a2c2940 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1424,19 +1424,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
>  	msk->token =3D subflow_req->token;
>  	msk->subflow =3D NULL;
>  =

> -	if (unlikely(mptcp_token_new_accept(subflow_req->token, nsk))) {
> -		nsk->sk_state =3D TCP_CLOSE;
> -		bh_unlock_sock(nsk);
> -
> -		/* we can't call into mptcp_close() here - possible BH context
> -		 * free the sock directly.
> -		 * sk_clone_lock() sets nsk refcnt to two, hence call sk_free()
> -		 * too.
> -		 */
> -		sk_common_release(nsk);
> -		sk_free(nsk);
> -		return NULL;
> -	}
> +	mptcp_token_accept(subflow_req, msk);
>  =

>  	msk->write_seq =3D subflow_req->idsn + 1;
>  	atomic64_set(&msk->snd_una, msk->write_seq);
> @@ -1611,6 +1599,20 @@ static void mptcp_release_cb(struct sock *sk)
>  	}
>  }
>  =

> +static int mptcp_hash(struct sock *sk)
> +{
> +	/* should never be called,
> +	 * we hash the TCP subflows not the master socket
> +	 */
> +	WARN_ON_ONCE(1);
> +	return 0;
> +}
> +
> +static void mptcp_unhash(struct sock *sk)
> +{
> +	/* called from sk_common_release(), but nothing to do here */
> +}
> +
>  static int mptcp_get_port(struct sock *sk, unsigned short snum)
>  {
>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
> @@ -1654,7 +1656,6 @@ void mptcp_finish_connect(struct sock *ssk)
>  	 */
>  	WRITE_ONCE(msk->remote_key, subflow->remote_key);
>  	WRITE_ONCE(msk->local_key, subflow->local_key);
> -	WRITE_ONCE(msk->token, subflow->token);
>  	WRITE_ONCE(msk->write_seq, subflow->idsn + 1);
>  	WRITE_ONCE(msk->ack_seq, ack_seq);
>  	WRITE_ONCE(msk->can_ack, 1);
> @@ -1728,8 +1729,8 @@ static struct proto mptcp_prot =3D {
>  	.sendmsg	=3D mptcp_sendmsg,
>  	.recvmsg	=3D mptcp_recvmsg,
>  	.release_cb	=3D mptcp_release_cb,
> -	.hash		=3D inet_hash,
> -	.unhash		=3D inet_unhash,
> +	.hash		=3D mptcp_hash,
> +	.unhash		=3D mptcp_unhash,
>  	.get_port	=3D mptcp_get_port,
>  	.sockets_allocated	=3D &mptcp_sockets_allocated,
>  	.memory_allocated	=3D &tcp_memory_allocated,
> @@ -1738,6 +1739,7 @@ static struct proto mptcp_prot =3D {
>  	.sysctl_wmem_offset	=3D offsetof(struct net, ipv4.sysctl_tcp_wmem),
>  	.sysctl_mem	=3D sysctl_tcp_mem,
>  	.obj_size	=3D sizeof(struct mptcp_sock),
> +	.slab_flags	=3D SLAB_TYPESAFE_BY_RCU,
>  	.no_autobind	=3D true,
>  };
>  =

> @@ -2037,6 +2039,7 @@ void __init mptcp_proto_init(void)
>  =

>  	mptcp_subflow_init();
>  	mptcp_pm_init();
> +	mptcp_token_init();
>  =

>  	if (proto_register(&mptcp_prot, 1) !=3D 0)
>  		panic("Failed to register MPTCP proto.\n");
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 747a6d081e4b..8d766c4d42bf 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -255,6 +255,7 @@ struct mptcp_subflow_request_sock {
>  	u64	thmac;
>  	u32	local_nonce;
>  	u32	remote_nonce;
> +	struct hlist_nulls_node token_node;
>  };
>  =

>  static inline struct mptcp_subflow_request_sock *
> @@ -382,10 +383,12 @@ bool mptcp_finish_join(struct sock *sk);
>  void mptcp_data_acked(struct sock *sk);
>  void mptcp_subflow_eof(struct sock *sk);
>  =

> +void __init mptcp_token_init(void);
>  int mptcp_token_new_request(struct request_sock *req);
>  void mptcp_token_destroy_request(u32 token);
>  int mptcp_token_new_connect(struct sock *sk);
> -int mptcp_token_new_accept(u32 token, struct sock *conn);
> +void mptcp_token_accept(struct mptcp_subflow_request_sock *r,
> +			struct mptcp_sock *msk);
>  struct mptcp_sock *mptcp_token_get_sock(u32 token);
>  void mptcp_token_destroy(u32 token);
>  =

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 0f725549eeef..ae7bcdb7f990 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -31,11 +31,14 @@ static void SUBFLOW_REQ_INC_STATS(struct request_sock=
 *req,
>  static int subflow_rebuild_header(struct sock *sk)
>  {
>  	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
> -	int local_id, err =3D 0;
> +	int local_id;
>  =

>  	if (subflow->request_mptcp && !subflow->token) {
>  		pr_debug("subflow=3D%p", sk);
> -		err =3D mptcp_token_new_connect(sk);
> +		if (mptcp_token_new_connect(sk)) {
> +			subflow->mp_capable =3D 0;
> +			goto out;
> +		}
>  	} else if (subflow->request_join && !subflow->local_nonce) {
>  		struct mptcp_sock *msk =3D (struct mptcp_sock *)subflow->conn;
>  =

> @@ -56,9 +59,6 @@ static int subflow_rebuild_header(struct sock *sk)
>  	}
>  =

>  out:
> -	if (err)
> -		return err;
> -
>  	return subflow->icsk_af_ops->rebuild_header(sk);
>  }
>  =

> diff --git a/net/mptcp/token.c b/net/mptcp/token.c
> index 33352dd99d4d..251c05717e8e 100644
> --- a/net/mptcp/token.c
> +++ b/net/mptcp/token.c
> @@ -24,7 +24,7 @@
>  =

>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/radix-tree.h>
> +#include <linux/memblock.h>
>  #include <linux/ip.h>
>  #include <linux/tcp.h>
>  #include <net/sock.h>
> @@ -33,10 +33,53 @@
>  #include <net/mptcp.h>
>  #include "protocol.h"
>  =

> -static RADIX_TREE(token_tree, GFP_ATOMIC);
> -static RADIX_TREE(token_req_tree, GFP_ATOMIC);
> -static DEFINE_SPINLOCK(token_tree_lock);
> -static int token_used __read_mostly;
> +#define TOKEN_MAX_RETRIES	4
> +#define TOKEN_MAX_CHAIN_LEN	4
> +
> +struct token_bucket {
> +	spinlock_t		lock;
> +	int			chain_len;
> +	struct hlist_nulls_head	req_chain;
> +	struct hlist_nulls_head	msk_chain;
> +};
> +
> +static struct token_bucket *token_hash __read_mostly;
> +static unsigned int token_mask __read_mostly;
> +
> +static struct token_bucket *token_bucket(u32 token)
> +{
> +	return &token_hash[token & token_mask];
> +}
> +
> +static struct mptcp_subflow_request_sock *
> +__token_lookup_req(struct token_bucket *t, u32 token)
> +{
> +	struct mptcp_subflow_request_sock *req;
> +	struct hlist_nulls_node *pos;
> +
> +	hlist_nulls_for_each_entry_rcu(req, pos, &t->req_chain, token_node)
> +		if (req->token =3D=3D token)
> +			return req;
> +	return NULL;
> +}
> +
> +static struct mptcp_sock *
> +__token_lookup_msk(struct token_bucket *t, u32 token)
> +{
> +	struct hlist_nulls_node *pos;
> +	struct sock *sk;
> +
> +	sk_nulls_for_each_rcu(sk, pos, &t->msk_chain)
> +		if (mptcp_sk(sk)->token =3D=3D token)
> +			return mptcp_sk(sk);

won't you need a "goto again" here if you end up on the wrong nulls?
Same way as in mptcp_token_get_sock.



Christoph

--===============4695370733656557873==--
