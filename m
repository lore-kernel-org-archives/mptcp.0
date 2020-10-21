Content-Type: multipart/mixed; boundary="===============1659923643588676360=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] Squash-to: "mptcp: refactor shutdown and
 close"
Date: Tue, 20 Oct 2020 20:51:54 -0700
Message-ID: <1815c494-3a6e-b7dd-9a78-46cb49be634@linux.intel.com>
In-Reply-To: a54e1b917f151b550951a0bad0b69a4924885ce1.1603211002.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6376

--===============1659923643588676360==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Oct 2020, Paolo Abeni wrote:

> we must release the ssk socket only after orphaning it,
> or we may hit UaF in the receive path.
>
> Beyond the error critical code path reported by syzkaller,
> there is also the scenario of a subflow closed by the PM.
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> Should fix 101 by I actually tested this only vs self-tests

Looks fine in terms of code review. I will work on verifying it with =

syzkaller tomorrow unless I hear something from Christoph.


Mat


> ---
> net/mptcp/protocol.c | 34 ++++++++++++++++++++++++----------
> 1 file changed, 24 insertions(+), 10 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index a32c27fe525c..2240fd370014 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1746,16 +1746,22 @@ static struct sock *mptcp_subflow_get_retrans(con=
st struct mptcp_sock *msk)
> void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> 		       struct mptcp_subflow_context *subflow)
> {
> -	struct socket *sock =3D READ_ONCE(ssk->sk_socket);
> +	bool dispose_socket =3D false;
> +	struct socket *sock;
>
> 	list_del(&subflow->node);
>
> -	/* outgoing subflow */
> -	if (sock && sock !=3D sk->sk_socket)
> -		iput(SOCK_INODE(sock));
> -
> 	lock_sock(ssk);
>
> +	/* if we are invoked by the msk cleanup code, the subflow is
> +	 * already orphaned
> +	 */
> +	sock =3D ssk->sk_socket;
> +	if (sock) {
> +		dispose_socket =3D sock !=3D sk->sk_socket;
> +		sock_orphan(ssk);
> +	}
> +
> 	/* if ssk hit tcp_done(), tcp_cleanup_ulp() cleared the related ops
> 	 * the ssk has been already destroyed, we just need to release the
> 	 * reference owned by msk;
> @@ -1771,6 +1777,9 @@ void __mptcp_close_ssk(struct sock *sk, struct sock=
 *ssk,
> 		__sock_put(ssk);
> 	}
> 	release_sock(ssk);
> +	if (dispose_socket)
> +		iput(SOCK_INODE(sock));
> +
> 	sock_put(ssk);
> }
>
> @@ -2165,15 +2174,20 @@ static void mptcp_close(struct sock *sk, long tim=
eout)
> 	inet_csk(sk)->icsk_mtup.probe_timestamp =3D tcp_jiffies32;
> 	list_for_each_entry(subflow, &mptcp_sk(sk)->conn_list, node) {
> 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> -		struct socket *sock =3D READ_ONCE(ssk->sk_socket);
> -		bool slow;
> -
> -		if (sock && sock !=3D sk->sk_socket)
> -			iput(SOCK_INODE(sock));
> +		bool slow, dispose_socket;
> +		struct socket *sock;
>
> 		slow =3D lock_sock_fast(ssk);
> +		sock =3D ssk->sk_socket;
> +		dispose_socket =3D sock && sock !=3D sk->sk_socket;
> 		sock_orphan(ssk);
> 		unlock_sock_fast(ssk, slow);
> +
> +		/* for the outgoing subflows we additionally need to free
> +		 * the associated socket
> +		 */
> +		if (dispose_socket)
> +			iput(SOCK_INODE(sock));
> 	}
> 	sock_orphan(sk);
>
> -- =

> 2.26.2

--
Mat Martineau
Intel
--===============1659923643588676360==--
