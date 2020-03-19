Content-Type: multipart/mixed; boundary="===============7611739530530387312=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] net: mptcp: don't hang in
 mptcp_sendmsg() after TCP fallback
Date: Thu, 19 Mar 2020 23:48:21 +0100
Message-ID: <3121516743a4acdb67799565d0251531092244e7.camel@redhat.com>
In-Reply-To: 9a7cd34e2d8688364297d700bfd8aea60c3a6c7f.1584653622.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3997

--===============7611739530530387312==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-03-19 at 22:45 +0100, Davide Caratti wrote:
> it's still possible for packetdrill to hang in mptcp_sendmsg(), when the
> MPTCP socket falls back to regular TCP (e.g. after receiving unsupported
> flags/version during the three-way handshake). Adjust MPTCP socket state
> earlier, to ensure correct functionality of mptcp_sendmsg() even in case
> of TCP fallback.
> =

> Fixes: 767d3ded5fb8 ("net: mptcp: don't hang before sending 'MP capable w=
ith data'")
> Fixes: 1954b86016cf ("mptcp: Check connection state before attempting sen=
d")
> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> ---
>  net/mptcp/protocol.c | 4 ----
>  net/mptcp/subflow.c  | 6 ++++++
>  2 files changed, 6 insertions(+), 4 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index e959104832ef..92d5382e71f4 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1055,10 +1055,6 @@ void mptcp_finish_connect(struct sock *ssk)
>  	WRITE_ONCE(msk->write_seq, subflow->idsn + 1);
>  	WRITE_ONCE(msk->ack_seq, ack_seq);
>  	WRITE_ONCE(msk->can_ack, 1);
> -	if (inet_sk_state_load(sk) !=3D TCP_ESTABLISHED) {
> -		inet_sk_state_store(sk, TCP_ESTABLISHED);
> -		sk->sk_state_change(sk);
> -	}
>  }
>  =

>  static void mptcp_sock_graft(struct sock *sk, struct socket *parent)
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 052d72a1d3a2..06b9075333c5 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -109,9 +109,15 @@ static void subflow_v6_init_req(struct request_sock =
*req,
>  static void subflow_finish_connect(struct sock *sk, const struct sk_buff=
 *skb)
>  {
>  	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
> +	struct sock *parent =3D subflow->conn;
>  =

>  	subflow->icsk_af_ops->sk_rx_dst_set(sk, skb);
>  =

> +	if (inet_sk_state_load(parent) !=3D TCP_ESTABLISHED) {
> +		inet_sk_state_store(parent, TCP_ESTABLISHED);
> +		parent->sk_state_change(parent);
> +	}
> +
>  	if (!subflow->conn_finished) {
>  		pr_debug("subflow=3D%p, remote_key=3D%llu", mptcp_subflow_ctx(sk),
>  			 subflow->remote_key);

LGTM, thanks Davide!

Acked-by: Paolo Abeni <pabeni(a)redhat.com>

--===============7611739530530387312==--
