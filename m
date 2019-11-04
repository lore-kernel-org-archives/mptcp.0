Content-Type: multipart/mixed; boundary="===============3835862475185706296=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: fix stray wake-up event
Date: Mon, 04 Nov 2019 15:49:23 -0800
Message-ID: <alpine.OSX.2.21.1911041546340.10632@mjmartin-mac01.local>
In-Reply-To: 26c4e00e82eae25d5497a24e8712b64f52cb3bbc.1572886095.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2386

--===============3835862475185706296==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Paolo -

On Mon, 4 Nov 2019, Paolo Abeni wrote:

> We always need to set subflow->data_avail after each tcp_read_sock()
> or mptcp_subflow_recv_lookup() may pick the wrong sock.

The patch looks good to me, thanks Paolo.


Mat


>
> Squash-to: "mptcp: recvmsg() can drain data from multiple subflows"
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 18 +++++++++---------
> net/mptcp/subflow.c  |  1 +
> 2 files changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3af5f121af9e..696f1d03a61d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -473,6 +473,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
> 	read_descriptor_t desc;
> 	struct socket *ssock;
> 	struct tcp_sock *tp;
> +	bool done =3D false;
> 	struct sock *ssk;
> 	int copied =3D 0;
> 	int target;
> @@ -498,7 +499,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
> 	len =3D min_t(size_t, len, INT_MAX);
> 	target =3D sock_rcvlowat(sk, flags & MSG_WAITALL, len);
>
> -	while (copied < len) {
> +	while (!done) {
> 		u32 map_remaining;
> 		int bytes_read;
>
> @@ -515,7 +516,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
> 		tp =3D tcp_sk(ssk);
>
> 		lock_sock(ssk);
> -		while (mptcp_subflow_data_available(ssk)) {
> +		while (mptcp_subflow_data_available(ssk) && !done) {
> 			/* try to read as much data as available */
> 			map_remaining =3D subflow->map_data_len -
> 					mptcp_subflow_get_map_offset(subflow);
> @@ -526,8 +527,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
> 			if (bytes_read < 0) {
> 				if (!copied)
> 					copied =3D bytes_read;
> -				release_sock(ssk);
> -				goto out;
> +				done =3D true;
> +				continue;
> 			}
>
> 			pr_debug("msk ack_seq=3D%llx -> %llx", msk->ack_seq,
> @@ -535,13 +536,13 @@ static int mptcp_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
> 			msk->ack_seq +=3D bytes_read;
> 			copied +=3D bytes_read;
> 			if (copied >=3D len) {
> -				release_sock(ssk);
> -				goto out;
> +				done =3D true;
> +				continue;
> 			}
> 			if (tp->urg_data && tp->urg_seq =3D=3D tp->copied_seq) {
> 				pr_err("Urgent data present, cannot proceed");
> -				release_sock(ssk);
> -				goto out;
> +				done =3D true;
> +				continue;
> 			}
> 		}
> 		release_sock(ssk);
> @@ -590,7 +591,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
> 		mptcp_wait_data(sk, &timeo);
> 	}
>
> -out:
> 	release_sock(sk);
> 	return copied;
> }
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 7bae7c35ea6b..f08c4b713978 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -576,6 +576,7 @@ bool mptcp_subflow_data_available(struct sock *sk)
> 	}
>
> 	if (!subflow_check_data_avail(sk)) {
> +		subflow->data_avail =3D 0;
> 		/* set EoF only there is no data available - we already spooled
> 		 * all the pending skbs
> 		 */
> -- =

> 2.21.0
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============3835862475185706296==--
