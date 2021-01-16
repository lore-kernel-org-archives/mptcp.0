Content-Type: multipart/mixed; boundary="===============6965288148848444848=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] Squash-to: "mptcp: re-enable sndbuf
 autotune"
Date: Fri, 15 Jan 2021 16:11:05 -0800
Message-ID: <669aef6a-fdab-2da-64a6-139bcc674a7c@linux.intel.com>
In-Reply-To: b12a934d3ccfa77941c04f19a61fbf02fe733537.1610730637.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7400

--===============6965288148848444848==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Jan 2021, Paolo Abeni wrote:

> In the current code there are a bunch of bugs, very
> apparent in unidirectional stream tests with a single
> flow- which are not covered by the self-test unfortunatelly:
>
> __mptcp_clean_una() can clear SOCK_NOSPACE, since that can happen
> before tcp_data_snd_check()/tcp_new_space()/subflow_write_space,
> we end-up with no autotune.
>
> subflow_write_space() can clear SOCK_NOSPACE when subflow can send
> but not the msk, that is wrong and can cause hangup.
>
> The fix is moving the msk wake in subflow_write_space()
>
> Commit message should be updated replacing:
>
> """
> Let's sendmsg() set the subflows NOSPACE bit when looking for
> more memory. Additionally, cleanup the sndbuf propagation from
> subflow into the msk, leveraging the subflow write space callback
> and dropping a bunch of duplicate code.
> """
>
> with:
>
> """
> Let's sendmsg() set the subflows NOSPACE bit when looking for
> more memory and use the subflow write_space callback to propagate
> the snd buf update and wake-up the user-space.
>
> Additionally this allows dropping a bunch of duplicate code.
> """
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 1 -
> net/mptcp/subflow.c  | 8 +++-----
> 2 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 583154c1f72d..75cd4646730d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1040,7 +1040,6 @@ static void __mptcp_clean_una(struct sock *sk)
> 			__mptcp_update_wmem(sk);
> 			sk_mem_reclaim_partial(sk);
> 		}
> -		mptcp_write_space(sk);
> 	}
>
> 	if (snd_una =3D=3D READ_ONCE(msk->snd_nxt)) {
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 0a34d21e4d1f..77810c4c24e5 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1052,13 +1052,11 @@ static void subflow_data_ready(struct sock *sk)
>
> static void subflow_write_space(struct sock *ssk)
> {
> +	struct sock *sk =3D mptcp_subflow_ctx(ssk)->conn;
> 	struct socket *sock =3D ssk->sk_socket;
>
> -	if (mptcp_propagate_sndbuf(mptcp_subflow_ctx(ssk)->conn, ssk))
> -		mptcp_write_space(ssk);
> -
> -	if (sk_stream_is_writeable(ssk) && sock)
> -		clear_bit(SOCK_NOSPACE, &sock->flags);
> +	mptcp_propagate_sndbuf(sk, ssk);
> +	mptcp_write_space(sk);
> }
>
> static struct inet_connection_sock_af_ops *
> -- =

> 2.26.2

Thanks Paolo, this looks ready to squash.

--
Mat Martineau
Intel
--===============6965288148848444848==--
