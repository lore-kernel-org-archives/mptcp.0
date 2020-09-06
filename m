Content-Type: multipart/mixed; boundary="===============2761902727939001683=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC mptcp-next 2/3] mptcp: rework poll+nospace handling
Date: Sun, 06 Sep 2020 17:58:17 +0200
Message-ID: <a4428c99de218ce78a6128d34e388910dce1dba6.camel@redhat.com>
In-Reply-To: 20200905103324.27066-3-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 5734

--===============2761902727939001683==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 2020-09-05 at 12:33 +0200, Florian Westphal wrote:
> At this time, MPTCP maintains a status bit, MPTCP_SEND_SPACE,
> that is set when at least one subflow and the mptcp socket itself
> are writeable.
> =

> poll path set EPOLLOUT if the bit is set.
> sendmsg path makes sure MPTCP_SEND_SPACE gets cleared when last
> write has used up all subflows or the mptcp socket wmem.
> =

> This reworks nospace handling as follows:
> =

> MPTCP_SEND_SPACE is replaced with MPTCP_NOSPACE.
> This bit is set when the mptcp socket is not writeable anymore
> and makes the mptcp-level ack path schedule the mptcp worker.
> =

> This is needed to wake up userspace processes that wait for a POLLOUT
> event.
> =

> sendmsg will set MPTCP_NOSPACE only when it has to wait for more
> wmem (blocking I/O case).
> =

> poll path will also set MPTCP_NOSPACE in case the mptcp socket
> is not writeable.
> =

> Normal tcp-level notification (SOCK_NOSPACE) is only enabled
> in case the subflow socket has no available wmem.
> =

> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
>  net/mptcp/protocol.c | 98 ++++++++++++++++++++++++++++++--------------
>  net/mptcp/protocol.h |  2 +-
>  net/mptcp/subflow.c  | 11 +++--
>  3 files changed, 74 insertions(+), 37 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 15ecb471602c..bc5231d5b06d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -680,10 +680,12 @@ static void mptcp_reset_timer(struct sock *sk)
>  =

>  void mptcp_data_acked(struct sock *sk)
>  {
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +
>  	mptcp_reset_timer(sk);
>  =

> -	if ((!test_bit(MPTCP_SEND_SPACE, &mptcp_sk(sk)->flags) ||
> -	     (inet_sk_state_load(sk) !=3D TCP_ESTABLISHED)) &&
> +	if ((test_bit(MPTCP_NOSPACE, &msk->flags) ||
> +	    (inet_sk_state_load(sk) !=3D TCP_ESTABLISHED)) &&
>  	    schedule_work(&mptcp_sk(sk)->work))
>  		sock_hold(sk);
>  }
> @@ -841,12 +843,7 @@ static void mptcp_clean_una(struct sock *sk)
>  =

>  	/* Only wake up writers if a subflow is ready */
>  	if (mptcp_is_writeable(msk)) {
> -		set_bit(MPTCP_SEND_SPACE, &msk->flags);
> -		smp_mb__after_atomic();
> -
> -		/* set SEND_SPACE before sk_stream_write_space clears
> -		 * NOSPACE
> -		 */
> +		clear_bit(MPTCP_NOSPACE, &msk->flags);
>  		sk_stream_write_space(sk);
>  	}
>  }
> @@ -1038,21 +1035,37 @@ static int mptcp_sendmsg_frag(struct sock *sk, st=
ruct sock *ssk,
>  	return ret;
>  }
>  =

> -static void mptcp_nospace(struct mptcp_sock *msk)
> +/* set SOCK_NOSPACE for any subflow that has no more wmem.
> + *
> + * Returns true if at least one subflow is writeable.
> + */
> +static bool mptcp_set_subflow_nospace(struct mptcp_sock *msk)
>  {
>  	struct mptcp_subflow_context *subflow;
> -
> -	clear_bit(MPTCP_SEND_SPACE, &msk->flags);
> -	smp_mb__after_atomic(); /* msk->flags is changed by write_space cb */
> +	bool ssk_any_writeable =3D false;
>  =

>  	mptcp_for_each_subflow(msk, subflow) {

Not strictly related to this patch, but perhpas we need a =

__mptcp_flush_join_list() call before traversing the subflow list?!?

>  		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> +		bool ssk_writeable =3D sk_stream_is_writeable(ssk);
>  		struct socket *sock =3D READ_ONCE(ssk->sk_socket);
>  =

> +		if (ssk_writeable) {
> +			ssk_any_writeable =3D true;
> +			continue;
> +		}
> +
> +		if (!sock)
> +			continue;
> +
>  		/* enables ssk->write_space() callbacks */
> -		if (sock)
> -			set_bit(SOCK_NOSPACE, &sock->flags);
> +		set_bit(SOCK_NOSPACE, &sock->flags);
> +
> +		ssk_writeable =3D sk_stream_is_writeable(ssk);
> +		if (ssk_writeable)
> +			ssk_any_writeable =3D true;
>  	}
> +
> +	return ssk_any_writeable;
>  }
>  =

>  static bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
> @@ -1160,10 +1173,28 @@ static struct sock *mptcp_subflow_get_send(struct=
 mptcp_sock *msk,
>  	return free ? msk->last_snd : NULL;
>  }
>  =

> -static void ssk_check_wmem(struct mptcp_sock *msk)
> +static bool __mptcp_check_writeable(struct mptcp_sock *msk)
>  {
> -	if (unlikely(!mptcp_is_writeable(msk)))
> -		mptcp_nospace(msk);
> +	struct sock *sk =3D (struct sock *)msk;
> +	bool mptcp_writable;
> +
> +	__mptcp_clean_una(sk);
> +	mptcp_writable =3D sk_stream_is_writeable(sk);
> +	if (!mptcp_writable) {
> +		set_bit(MPTCP_NOSPACE, &msk->flags);
> +		smp_mb__after_atomic();
> +		__mptcp_clean_una(sk);
> +
> +		mptcp_writable =3D sk_stream_is_writeable(sk);
> +		if (likely(!mptcp_writable))
> +			return false;
> +
> +		/* MPTCP ack after MPTCP_NOSPACE was set */
> +		clear_bit(MPTCP_NOSPACE, &msk->flags);
> +	}
> +
> +	/* mptcp socket is writeable, now check subflows */
> +	return mptcp_set_subflow_nospace(msk);
>  }
>  =

>  static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> @@ -1217,7 +1248,8 @@ static int mptcp_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len)
>  				mptcp_reset_timer(sk);
>  		}
>  =

> -		mptcp_nospace(msk);
> +		__mptcp_check_writeable(msk);
> +

Again not strictily related to this patch, but currently we start
sleeping/blocking if msk/ssk are not writeable.

I think we should do that instead when !sk_stream_memory_free() ?!?

>  		ret =3D sk_stream_wait_memory(sk, &timeo);
>  		if (ret)
>  			goto out;
> @@ -1314,7 +1346,6 @@ static int mptcp_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len)
>  =

>  	release_sock(ssk);
>  out:
> -	ssk_check_wmem(msk);
>  	release_sock(sk);
>  	return copied ? : ret;
>  }
> @@ -1811,7 +1842,6 @@ static int __mptcp_init_sock(struct sock *sk)
>  	INIT_LIST_HEAD(&msk->conn_list);
>  	INIT_LIST_HEAD(&msk->join_list);
>  	INIT_LIST_HEAD(&msk->rtx_queue);
> -	__set_bit(MPTCP_SEND_SPACE, &msk->flags);
>  	INIT_WORK(&msk->work, mptcp_worker);
>  	msk->out_of_order_queue =3D RB_ROOT;
>  =

> @@ -2422,13 +2452,6 @@ bool mptcp_finish_join(struct sock *sk)
>  	return true;
>  }
>  =

> -static bool mptcp_memory_free(const struct sock *sk, int wake)
> -{
> -	struct mptcp_sock *msk =3D mptcp_sk(sk);
> -
> -	return wake ? test_bit(MPTCP_SEND_SPACE, &msk->flags) : true;
> -}
> -
>  static struct proto mptcp_prot =3D {
>  	.name		=3D "MPTCP",
>  	.owner		=3D THIS_MODULE,
> @@ -2449,7 +2472,6 @@ static struct proto mptcp_prot =3D {
>  	.sockets_allocated	=3D &mptcp_sockets_allocated,
>  	.memory_allocated	=3D &tcp_memory_allocated,
>  	.memory_pressure	=3D &tcp_memory_pressure,
> -	.stream_memory_free	=3D mptcp_memory_free,
>  	.sysctl_wmem_offset	=3D offsetof(struct net, ipv4.sysctl_tcp_wmem),
>  	.sysctl_mem	=3D sysctl_tcp_mem,
>  	.obj_size	=3D sizeof(struct mptcp_sock),
> @@ -2622,6 +2644,23 @@ static __poll_t mptcp_check_readable(struct mptcp_=
sock *msk)
>  	       0;
>  }
>  =

> +static __poll_t mptcp_check_writeable(struct mptcp_sock *msk)
> +{
> +	struct sock *sk =3D (struct sock *)msk;
> +	__poll_t ret =3D 0;
> +	bool slow;
> +
> +	if (sk->sk_shutdown & SEND_SHUTDOWN)
> +		return 0;
> +
> +	slow =3D lock_sock_fast(sk);
> +	if (__mptcp_check_writeable(msk))
> +		ret =3D EPOLLOUT | EPOLLWRNORM;
> +
> +	unlock_sock_fast(sk, slow);

It's a pity we need to acquire the lock in mptcp_poll()... perhaps we
could try to acquire it only if sk_stream_is_writeable(msk)?

> +	return ret;
> +}
> +
>  static __poll_t mptcp_poll(struct file *file, struct socket *sock,
>  			   struct poll_table_struct *wait)
>  {
> @@ -2640,8 +2679,7 @@ static __poll_t mptcp_poll(struct file *file, struc=
t socket *sock,
>  =

>  	if (state !=3D TCP_SYN_SENT && state !=3D TCP_SYN_RECV) {
>  		mask |=3D mptcp_check_readable(msk);
> -		if (test_bit(MPTCP_SEND_SPACE, &msk->flags))
> -			mask |=3D EPOLLOUT | EPOLLWRNORM;
> +		mask |=3D mptcp_check_writeable(msk);
>  	}
>  	if (sk->sk_shutdown & RCV_SHUTDOWN)
>  		mask |=3D EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index ba253a6947b0..d18af92723e4 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -86,7 +86,7 @@
>  =

>  /* MPTCP socket flags */
>  #define MPTCP_DATA_READY	0
> -#define MPTCP_SEND_SPACE	1
> +#define MPTCP_NOSPACE		1
>  #define MPTCP_WORK_RTX		2
>  #define MPTCP_WORK_EOF		3
>  #define MPTCP_FALLBACK_DONE	4
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index e31900ff0c56..bdf28d1baba8 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -972,17 +972,16 @@ static void subflow_data_ready(struct sock *sk)
>  static void subflow_write_space(struct sock *sk)
>  {
>  	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
> +	struct socket *sock =3D READ_ONCE(sk->sk_socket);
>  	struct sock *parent =3D subflow->conn;
>  =

>  	if (!sk_stream_is_writeable(sk))
>  		return;
>  =

> -	if (sk_stream_is_writeable(parent)) {
> -		set_bit(MPTCP_SEND_SPACE, &mptcp_sk(parent)->flags);
> -		smp_mb__after_atomic();
> -		/* set SEND_SPACE before sk_stream_write_space clears NOSPACE */
> -		sk_stream_write_space(parent);
> -	}
> +	if (sock)
> +		clear_bit(SOCK_NOSPACE, &sock->flags);

for server socket 'sock' is 'shared' among all the subflows (ssk-
>sk_socket points to the same data). The above is disabling write space
notification on all subflows, is that intended/correct?

> +
> +	sk_stream_write_space(parent);

If I read correctly, this means that the msk could be woken-up even if
not writeable (a subflow is writeable, but msk does not have enough
wirte space), am I correct? =


Thanks!

Paolo

--===============2761902727939001683==--
