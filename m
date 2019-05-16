Content-Type: multipart/mixed; boundary="===============1259089366403283324=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH mptcp v2 3/3] mptcp: accept: don't leak mptcp
 socket structure
Date: Wed, 15 May 2019 17:30:20 -0700
Message-ID: <alpine.OSX.2.21.1905151724550.30025@jdicke-mobl1.amr.corp.intel.com>
In-Reply-To: 20190514103647.15994-4-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1184

--===============1259089366403283324==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 14 May 2019, Florian Westphal wrote:

> accept() is supposed to prepare and return a 'struct sock'.
>
> The caller holds a new inode/socket, and will associate the
> returned sock with it.
>
> mptcp_accept however will allocate it via 'struct socket', then
> returns socket->sk.
> This then leaks the outer socket struct inode returned by sock_create():
>
> unreferenced object 0xffff88810512e8c0 (size 936):
>  comm "mptcp_connect", [..]
>  backtrace:
>    [<00000000872561ba>] alloc_inode+0x35/0xe0
>    [<00000000646e04ed>] new_inode_pseudo+0x12/0x80
>    [<00000000e2e77036>] sock_alloc+0x26/0x100
>    [<00000000870a8688>] __sock_create+0x8f/0x3c0
>    [<000000000558b3fa>] mptcp_accept+0x140/0x530
>    [<0000000044718d60>] inet_accept+0xac/0x470
>    [<00000000da8f3979>] mptcp_stream_accept+0x62/0xa0
>    [<00000000c9010499>] __sys_accept4+0x228/0x3c0
>
> To fix this, make several (unfortunately, intrusive) changes:
>
> 1. Instead of allocating a new mptcp socket, clone the
>   mptcp listen socket socket->sk.
>
>   This gives us a mptcp sock without the inode container.
>   We return this sock struct to the caller, the caller will then
>   complete creation of the mptcp socket.
>
> 2. For the 'compat' (old tcp, not mp capable) case, return the
>   tcp socket directly and release the socket coming from
>   kernel_accept().
>
>   We can use mptcp_getname() to override the socket->ops to
>   tcp.  This will make mptcp_accept work like tcp accept, and
>   mptcp won't be involved anymore for the particular socket.
>
> v2: add mptcp_init_sock() that got lost during last rebase.
>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> net/mptcp/protocol.c | 65 +++++++++++++++++++++++++++++++-------------
> 1 file changed, 46 insertions(+), 19 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index e738bfad7430..a897f40bf966 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -613,9 +613,9 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
> {
> 	struct mptcp_sock *msk =3D mptcp_sk(sk);
> 	struct socket *listener =3D msk->subflow;
> -	struct socket *new_sock;
> -	struct socket *new_mptcp_sock;
> 	struct subflow_context *subflow;
> +	struct socket *new_sock;
> +	struct sock *newsk;
>
> 	pr_debug("msk=3D%p, listener=3D%p", msk, subflow_ctx(listener->sk));
> 	*err =3D kernel_accept(listener, &new_sock, flags);
> @@ -625,28 +625,34 @@ static struct sock *mptcp_accept(struct sock *sk, i=
nt flags, int *err,
> 	subflow =3D subflow_ctx(new_sock->sk);
> 	pr_debug("new subflow=3D%p", subflow);
>
> -	*err =3D sock_create(PF_INET, SOCK_STREAM, IPPROTO_MPTCP, &new_mptcp_so=
ck);
> -	if (*err < 0) {
> -		kernel_sock_shutdown(new_sock, SHUT_RDWR);
> -		sock_release(new_sock);
> -		return NULL;
> -	}
> -
> -	msk =3D mptcp_sk(new_mptcp_sock->sk);
> 	pr_debug("new msk=3D%p", msk);
>
> 	if (subflow->mp_capable) {
> +		struct sock *new_mptcp_sock;
> 		u64 ack_seq;
>
> +		local_bh_disable();
> +		new_mptcp_sock =3D sk_clone_lock(sk, GFP_ATOMIC);
> +		if (!new_sock) {

new_sock is non-null (it's dereferenced in the first line of this hunk), =

it looks like this is supposed to check new_mptcp_sock.


Mat

> +			*err =3D -ENOBUFS;
> +			local_bh_enable();
> +			kernel_sock_shutdown(new_sock, SHUT_RDWR);
> +			sock_release(new_sock);
> +			return NULL;
> +		}
> +
> +		mptcp_init_sock(new_mptcp_sock);
> +
> +		msk =3D mptcp_sk(new_mptcp_sock);
> 		msk->remote_key =3D subflow->remote_key;
> 		msk->local_key =3D subflow->local_key;
> 		msk->token =3D subflow->token;
> 		pr_debug("token=3D%u", msk->token);
> -		token_update_accept(new_sock->sk, new_mptcp_sock->sk);
> -		spin_lock_bh(&msk->conn_list_lock);
> +		token_update_accept(new_sock->sk, new_mptcp_sock);
> +		spin_lock(&msk->conn_list_lock);
> 		list_add_rcu(&subflow->node, &msk->conn_list);
> 		msk->subflow =3D NULL;
> -		spin_unlock_bh(&msk->conn_list_lock);
> +		spin_unlock(&msk->conn_list_lock);
>
> 		crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
> 		msk->write_seq =3D subflow->idsn + 1;
> @@ -655,14 +661,20 @@ static struct sock *mptcp_accept(struct sock *sk, i=
nt flags, int *err,
> 		subflow->map_seq =3D ack_seq;
> 		subflow->map_subflow_seq =3D 1;
> 		subflow->rel_write_seq =3D 1;
> -		subflow->conn =3D new_mptcp_sock->sk;
> 		subflow->tcp_sock =3D new_sock;
> +		newsk =3D new_mptcp_sock;
> +		subflow->conn =3D new_mptcp_sock;
> +		bh_unlock_sock(new_mptcp_sock);
> +		local_bh_enable();
> +		inet_sk_state_store(newsk, TCP_ESTABLISHED);
> 	} else {
> -		msk->subflow =3D new_sock;
> +		newsk =3D new_sock->sk;
> +		tcp_sk(newsk)->is_mptcp =3D 0;
> +		new_sock->sk =3D NULL;
> +		sock_release(new_sock);
> 	}
> -	inet_sk_state_store(new_mptcp_sock->sk, TCP_ESTABLISHED);
>
> -	return new_mptcp_sock->sk;
> +	return newsk;
> }
>
> static void mptcp_destroy(struct sock *sk)
> @@ -852,6 +864,18 @@ static int mptcp_getname(struct socket *sock, struct=
 sockaddr *uaddr,
>
> 	pr_debug("msk=3D%p", msk);
>
> +	if (sock->sk->sk_prot =3D=3D &tcp_prot) {
> +		/* we are being invoked from __sys_accept4, after
> +		 * mptcp_accept() has just accepted a non-mp-capable
> +		 * flow: sk is a tcp_sk, not an mptcp one.
> +		 *
> +		 * Hand the socket over to tcp so all further socket ops
> +		 * bypass mptcp.
> +		 */
> +		sock->ops =3D &inet_stream_ops;
> +		return inet_getname(sock, uaddr, peer);
> +	}
> +
> 	if (msk->subflow) {
> 		pr_debug("subflow=3D%p", msk->subflow->sk);
> 		return inet_getname(msk->subflow, uaddr, peer);
> @@ -965,9 +989,12 @@ static int mptcp_shutdown(struct socket *sock, int h=
ow)
> 	lock_sock(sock->sk);
> 	rcu_read_lock();
> 	list_for_each_entry_rcu(subflow, &msk->conn_list, node) {
> -		pr_debug("conn_list->subflow=3D%p", subflow);
> +		struct socket *tcp_socket;
> +
> +		tcp_socket =3D mptcp_subflow_tcp_socket(subflow);
> 		rcu_read_unlock();
> -		ret =3D kernel_sock_shutdown(mptcp_subflow_tcp_socket(subflow), how);
> +		pr_debug("conn_list->subflow=3D%p", subflow);
> +		ret =3D kernel_sock_shutdown(tcp_socket, how);
> 		rcu_read_lock();
> 	}
> 	rcu_read_unlock();
> -- =

> 2.21.0
>
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp
>

--
Mat Martineau
Intel

--===============1259089366403283324==--
