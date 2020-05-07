Content-Type: multipart/mixed; boundary="===============2433510462510229417=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 1/7] mptcp: avoid blocking in
 tcp_sendpages
Date: Wed, 06 May 2020 17:58:30 -0700
Message-ID: <alpine.OSX.2.22.394.2005061731110.44349@kwang8-mobl1.amr.corp.intel.com>
In-Reply-To: 20200506130228.1478-2-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4331

--===============2433510462510229417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 6 May 2020, Florian Westphal wrote:

> The transmit loop continues to xmit new data until an
> error is returned or all data was transmitted.
>
> For the blocking i/o case, this means that tcp_sendpages() may
> block on the subflow until more space becomes available, i.e. we end up
> sleeping with the mptcp socket lock held.
>
> Instead we should check if a different subflow is ready to be used.
>

Keep in mind that configurable packet schedulers (when eventually =

implemented) may want to make other decisions when one subflow gets =

blocked, even if other subflows have available space. One specific subflow =

might be favored due to better latency, or a redundant scheduler could =

send the same data on all the available subflows.

I think this patch set makes it easier to make mptcp_subflow_get_send =

configurable and to have the scheduler reselect when a subflow is out of =

space, so that's good!

Mat



> This restarts the subflow sk lookup when the tx operation succeeded
> and the tcp subflow can't accept more data or if tcp_sendpages
> indicates -EAGAIN on a blocking mptcp socket.
>
> In case all subflows are busy, the existing logic will wait until
> a subflow is ready, releasing the mptcp level socket while doing so.
>
> The mptcp worker already sets DONTWAIT, so no need to make
> changes there.
>
> Reported-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> net/mptcp/protocol.c | 23 ++++++++++++++++++++---
> 1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index b22a63ba2348..25427797753b 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -590,7 +590,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
> 	 * access the skb after the sendpages call
> 	 */
> 	ret =3D do_tcp_sendpages(ssk, page, offset, psize,
> -			       msg->msg_flags | MSG_SENDPAGE_NOTLAST);
> +			       msg->msg_flags | MSG_SENDPAGE_NOTLAST | MSG_DONTWAIT);
> 	if (ret <=3D 0)
> 		return ret;
>
> @@ -714,6 +714,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
> 	struct socket *ssock;
> 	size_t copied =3D 0;
> 	struct sock *ssk;
> +	bool tx_ok;
> 	long timeo;
>
> 	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL))
> @@ -738,6 +739,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
> 		return ret >=3D 0 ? ret + copied : (copied ? copied : ret);
> 	}
>
> +restart:
> 	mptcp_clean_una(sk);
>
> 	__mptcp_flush_join_list(msk);
> @@ -759,11 +761,17 @@ static int mptcp_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len)
> 	pr_debug("conn_list->subflow=3D%p", ssk);
>
> 	lock_sock(ssk);
> -	while (msg_data_left(msg)) {
> +	tx_ok =3D msg_data_left(msg);
> +	while (tx_ok) {
> 		ret =3D mptcp_sendmsg_frag(sk, ssk, msg, NULL, &timeo, &mss_now,
> 					 &size_goal);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			if (ret =3D=3D -EAGAIN && timeo > 0) {
> +				release_sock(ssk);
> +				goto restart;
> +			}
> 			break;
> +		}
> 		if (ret =3D=3D 0 && unlikely(__mptcp_needs_tcp_fallback(msk))) {
> 			/* Can happen for passive sockets:
> 			 * 3WHS negotiated MPTCP, but first packet after is
> @@ -777,6 +785,15 @@ static int mptcp_sendmsg(struct sock *sk, struct msg=
hdr *msg, size_t len)
> 		}
>
> 		copied +=3D ret;
> +		tx_ok =3D msg_data_left(msg);
> +		if (!tx_ok)
> +			break;
> +		if (!sk_stream_memory_free(ssk)) {
> +			tcp_push(ssk, msg->msg_flags, mss_now,
> +				 tcp_sk(ssk)->nonagle, size_goal);
> +			release_sock(ssk);
> +			goto restart;
> +		}
> 	}
>
> 	mptcp_set_timeout(sk, ssk);
> -- =

> 2.26.2
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============2433510462510229417==--
