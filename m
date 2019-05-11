Content-Type: multipart/mixed; boundary="===============1219919670247904609=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2] mptcp: refactor shutdown/close and conn_list
 handling
Date: Fri, 10 May 2019 17:38:16 -0700
Message-ID: <alpine.OSX.2.21.1905101735420.59728@julieann-mobl1.amr.corp.intel.com>
In-Reply-To: 433311552247db0fac6cf87f1c34fdaac32a3f40.1557483775.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1147

--===============1219919670247904609==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 10 May 2019, Paolo Abeni wrote:

> This change the conn_list to a plain list and use the mptcp socket
> lock to mutually exclude shutdown and close execution.
>
> Since mptcp_close() is the only code path that removes entries from
> conn_list, we can safely traverse the list while interrupting the
> he RCU critical section.
>
> This solves the scheduling while atomic splat on shutdown, but still
> retain the RCU sync on close.

Looks good to me.


Mat


>
> v1 -> v2:
> - use the mptcp socket lock in shutdown and close
>
> Fixes: ed375420f78d ("mptcp: Make connection_list a real list of subflows=
")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> Notes:
> - this can be squashed into the fixes commit
> - this is on top of "mptcp: fix state update on accept()"
> ---
> net/mptcp/protocol.c | 63 ++++++++++++++++++++++++++++----------------
> net/mptcp/protocol.h |  6 ++---
> 2 files changed, 43 insertions(+), 26 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index fa77d399a593..4b225d9e1c27 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -490,18 +490,31 @@ static int mptcp_init_sock(struct sock *sk)
>
> 	pr_debug("msk=3D%p", msk);
>
> -	INIT_HLIST_HEAD(&msk->conn_list);
> +	INIT_LIST_HEAD_RCU(&msk->conn_list);
> 	spin_lock_init(&msk->conn_list_lock);
>
> 	return 0;
> }
>
> +static void mptcp_flush_conn_list(struct sock *sk, struct list_head *lis=
t)
> +{
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +
> +	INIT_LIST_HEAD_RCU(list);
> +	spin_lock_bh(&msk->conn_list_lock);
> +	list_splice_init(&msk->conn_list, list);
> +	spin_unlock_bh(&msk->conn_list_lock);
> +
> +	if (!list_empty(list))
> +		synchronize_rcu();
> +}
> +
> static void mptcp_close(struct sock *sk, long timeout)
> {
> 	struct mptcp_sock *msk =3D mptcp_sk(sk);
> -	struct hlist_node *node;
> +	struct subflow_context *subflow, *tmp;
> 	struct socket *ssk =3D NULL;
> -	struct subflow_context *subflow;
> +	struct list_head list;
>
> 	spin_lock_bh(&msk->conn_list_lock);
> 	if (msk->subflow) {
> @@ -514,25 +527,18 @@ static void mptcp_close(struct sock *sk, long timeo=
ut)
> 		sock_release(ssk);
> 	}
>
> -	do {
> -		spin_lock_bh(&msk->conn_list_lock);
> -		/* The spin lock was just acquired, so tell
> -		 * rcu_dereference_check() this access to the list is properly
> -		 * protected even though the rcu_read_lock is not held.
> -		 */
> -		node =3D rcu_dereference_check(hlist_first_rcu(&msk->conn_list),
> -					spin_is_locked(&msk->conn_list_lock) ||
> -					!IS_ENABLED(CONFIG_SMP));
> -		if (!node)
> -			break;
> -		subflow =3D hlist_entry(node, struct subflow_context, node);
> -		hlist_del_rcu(node);
> -		spin_unlock_bh(&msk->conn_list_lock);
> -		synchronize_rcu();
> +	/* this is the only place where we can remove any entry from the
> +	 * conn_list. Additionally acquiring the socket lock here
> +	 * allows for mutual exclusion with mptcp_shutdown().
> +	 */
> +	lock_sock(sk);
> +	mptcp_flush_conn_list(sk, &list);
> +	release_sock(sk);
> +
> +	list_for_each_entry_safe(subflow, tmp, &list, node) {
> 		pr_debug("conn_list->subflow=3D%p", subflow);
> 		sock_release(sock_sk(subflow)->sk_socket);
> -	} while (1);
> -	spin_unlock_bh(&msk->conn_list_lock);
> +	};
> }
>
> static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
> @@ -571,7 +577,7 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
> 		pr_debug("token=3D%u", msk->token);
> 		token_update_accept(new_sock->sk, new_mptcp_sock->sk);
> 		spin_lock_bh(&msk->conn_list_lock);
> -		hlist_add_head_rcu(&subflow->node, &msk->conn_list);
> +		list_add_rcu(&subflow->node, &msk->conn_list);
> 		msk->subflow =3D NULL;
> 		spin_unlock_bh(&msk->conn_list_lock);
>
> @@ -670,7 +676,7 @@ void mptcp_finish_connect(struct sock *sk, int mp_cap=
able)
> 		msk->token =3D subflow->token;
> 		pr_debug("token=3D%u", msk->token);
> 		spin_lock_bh(&msk->conn_list_lock);
> -		hlist_add_head_rcu(&subflow->node, &msk->conn_list);
> +		list_add_rcu(&subflow->node, &msk->conn_list);
> 		msk->subflow =3D NULL;
> 		spin_unlock_bh(&msk->conn_list_lock);
>
> @@ -881,12 +887,23 @@ static int mptcp_shutdown(struct socket *sock, int =
how)
> 		return kernel_sock_shutdown(msk->subflow, how);
> 	}
>
> +	/* protect against concurrent mptcp_close(), so that nobody can
> +	 * remove entries from the conn list and walking the list breaking
> +	 * the RCU critical section is still safe. We need to release the
> +	 * RCU lock to call the blocking kernel_sock_shutdown() primitive
> +	 * Note: we can't use MPTCP socket lock to protect conn_list changes,
> +	 * as we need to update it from the BH via the mptcp_finish_connect()
> +	 */
> +	lock_sock(sock->sk);
> 	rcu_read_lock();
> -	mptcp_for_each_subflow(msk, subflow) {
> +	list_for_each_entry_rcu(subflow, &msk->conn_list, node) {
> +		rcu_read_unlock();
> 		pr_debug("conn_list->subflow=3D%p", subflow);
> 		ret =3D kernel_sock_shutdown(sock_sk(subflow)->sk_socket, how);
> +		rcu_read_lock();
> 	}
> 	rcu_read_unlock();
> +	release_sock(sock->sk);
>
> 	return ret;
> }
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index d67c38a2198b..de1131c543d0 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -37,12 +37,12 @@ struct mptcp_sock {
> 	atomic64_t	ack_seq;
> 	u32		token;
> 	spinlock_t	conn_list_lock;
> -	struct hlist_head conn_list;
> +	struct list_head conn_list;
> 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
> };
>
> #define mptcp_for_each_subflow(__msk, __subflow)			\
> -	hlist_for_each_entry_rcu(__subflow, &((__msk)->conn_list), node)
> +	list_for_each_entry_rcu(__subflow, &((__msk)->conn_list), node)
>
> static inline struct mptcp_sock *mptcp_sk(const struct sock *sk)
> {
> @@ -71,7 +71,7 @@ struct subflow_request_sock *subflow_rsk(const struct r=
equest_sock *rsk)
>
> /* MPTCP subflow context */
> struct subflow_context {
> -	struct	hlist_node node;/* conn_list of subflows */
> +	struct	list_head node;/* conn_list of subflows */
> 	u64	local_key;
> 	u64	remote_key;
> 	u32	token;
> -- =

> 2.20.1
>
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp
>

--
Mat Martineau
Intel

--===============1219919670247904609==--
