Content-Type: multipart/mixed; boundary="===============2621172395051433829=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 6/6] mptcp: use mptcp backlog.
Date: Tue, 17 Nov 2020 16:21:33 -0800
Message-ID: <59803c82-67f5-30db-732f-1da778c22f2f@linux.intel.com>
In-Reply-To: 634d2342cd365d073276847cfa3c3bd8afea486d.1605283958.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6765

--===============2621172395051433829==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Nov 2020, Paolo Abeni wrote:

> We have some tasks triggered by the subflow receive path
> which require to access the msk socket status, specifically:
> mptcp_clean_una() and mptcp_push_pending()
>
> We have almost everything in place to use the msk backlog
> and a standard !owned by user schema for that.
>
> Introduce a dummy per msk sk_buff to trigger into the backlog
> as needed.
>
> Since the worker is no more used to clean the acked data,
> for fallback sockets we need to explicitly flush them.
>
> As added bonus we can simplify a lot mptcp_poll() and
> move the timer update under the data lock.
>
> The worker is now used only to process and send DATA_FIN
> packets and do the mptcp-level retransmissions.
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> --
> v1 -> v2
> - add tx_pending_data accounting in __mptcp_subflow_push_pending()
> - in mptcp_data_acked schedule explicitly schedule the worker if
>   ack is pending - checking sk status is both too liberal and not
>   enough.
> - add missing call to __mptcp_check_send_data_fin() in mptcp_worker()
>   this is needed to cope with __mptcp_subflow_push_pending() deferring
>   send ack to the worker
> - renamed backlog to bl_entry
> - sk_mem_reclaim_partial() -> __mptcp_mem_reclaim_partial() in
>   mptcp_clean_una(). We are both under the data_lock and the socket
>   lock so we can call the more effective mptcp variant
> - do not try to push pending frames on wnd update if no pending data
>   (use the new __mptcp_wnd_updated helper for that)
> - move write queue cleanup in destroy_common() so that it takes place
>   after that subflows stops touching msk->sk_forward_alloc.
>   and we don't need to acquire the msk socket lock spin lock to reclaim
>   the xmit memory
> - explicitly init info->flags in __mptcp_subflow_push_pending(), or
>   horrible corruption will happen later
> - explicitly flush pending data for fallback socket on ack reception.
>   This likely fixes an older issue, which was hidden by the worker,
>   spooling the pending data, just slower.
> ---
> net/mptcp/options.c  |  18 +++-
> net/mptcp/protocol.c | 230 +++++++++++++++++++++++++++----------------
> net/mptcp/protocol.h |   6 ++
> 3 files changed, 166 insertions(+), 88 deletions(-)
>

...

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index db1db0e0fc2f..6fbd394d6701 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

...

> @@ -2726,6 +2758,50 @@ static int mptcp_getsockopt(struct sock *sk, int l=
evel, int optname,
> 	return -EOPNOTSUPP;
> }
>
> +static void __mptcp_add_to_backlog(struct sock *sk, int event)
> +{
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +
> +	if (!sk->sk_backlog.tail)
> +		__sk_add_backlog(sk, &msk->bl_entry);
> +
> +	set_bit(event, &msk->flags);
> +}
> +
> +void __mptcp_data_acked(struct sock *sk)
> +{
> +	if (!sock_owned_by_user(sk))
> +		__mptcp_clean_una(sk);
> +	else
> +		__mptcp_add_to_backlog(sk, MPTCP_CLEAN_UNA);
> +
> +	if (mptcp_pending_data_fin_ack(sk))
> +		mptcp_schedule_work(sk);
> +}
> +
> +void __mptcp_wnd_updated(struct sock *sk, struct sock *ssk)
> +{
> +	if (!mptcp_send_head(sk))
> +		return;
> +
> +	if (!sock_owned_by_user(sk))
> +		__mptcp_subflow_push_pending(sk, ssk);
> +	else
> +		__mptcp_add_to_backlog(sk, MPTCP_PUSH_PENDING);
> +}
> +
> +static int mptcp_do_backlog(struct sock *sk, struct sk_buff *skb)
> +{
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +
> +	if (test_and_clear_bit(MPTCP_CLEAN_UNA, &msk->flags))
> +		mptcp_clean_una(sk);
> +
> +	if (test_and_clear_bit(MPTCP_PUSH_PENDING, &msk->flags))
> +		mptcp_push_pending(sk, 0);
> +	return 0;
> +}

Is there anything happening here in mptcp_do_backlog() that doesn't work =

in mptcp_release_cb()?

(this goes for this version of the patch as well as the updated one in =

https://github.com/pabeni/mptcp/tree/worker_must_die_6.1 )

It looks like mptcp_do_backlog() ends up getting invoked through =

release_sock(), right before sk->sk_prot->release_cb() is called - which =

suggests that maybe mptcp_release_cb() could do it all. Is there another =

code path for MPTCP that calls sk_backlog_rcv() or __release_sock() that =

I've missed?

The zeroed-out bl_entry skb seems fragile. The current code in the =

backlog ends up handling it ok today, but that could easily change. Not =

that I'm trying to veto the idea, but it does need some more discussion :)


--
Mat Martineau
Intel
--===============2621172395051433829==--
