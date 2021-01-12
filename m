Content-Type: multipart/mixed; boundary="===============1558652199623053763=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 mptcp-next 4/4] mptcp: schedule work for better
 snd subflow selection
Date: Mon, 11 Jan 2021 17:20:36 -0800
Message-ID: <c1e596a8-4626-543c-7e8d-7411d95dee15@linux.intel.com>
In-Reply-To: e651a00a0e7fbeade6bf9549e5168da1a3bbadb2.1610359105.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7319

--===============1558652199623053763==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Jan 2021, Paolo Abeni wrote:

> Otherwise the packet scheduler policy will not be
> enforced when pushing pending data at MPTCP-level
> ack reception time.
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> I'm very sad to re-introduce the worker usage for the
> datapath, but I could not find an easy way to avoid it.
>
> I'm thinking of some weird schema involving a dummy percpu
> napi instance serving/processing a queue of mptcp sockets
> instead of actual packets. Any BH user can enqueue an MPTCP
> subflow there to delegate some action to the latter.
>
> The above will require also overriding the tcp_release_cb()
> with something able to process this delegated events.
>
> Yep, crazy, but possibly doable without any core change and
> possibly could be used to avoid the worker usage even for
> data fin processing/sending.
> ---
> net/mptcp/protocol.c | 11 ++++++++---
> 1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 510b87a3553b..0791421a971f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2244,6 +2244,7 @@ static void mptcp_worker(struct work_struct *work)
> 	if (unlikely(state =3D=3D TCP_CLOSE))
> 		goto unlock;
>
> +	mptcp_push_pending(sk, 0);
> 	mptcp_check_data_fin_ack(sk);
> 	__mptcp_flush_join_list(msk);
>
> @@ -2903,10 +2904,14 @@ void __mptcp_check_push(struct sock *sk, struct s=
ock *ssk)
> 	if (!mptcp_send_head(sk))
> 		return;
>
> -	if (!sock_owned_by_user(sk))
> -		__mptcp_subflow_push_pending(sk, ssk);
> -	else
> +	if (!sock_owned_by_user(sk)) {
> +		if (mptcp_subflow_get_send(mptcp_sk(sk)) =3D=3D ssk)
> +			__mptcp_subflow_push_pending(sk, ssk);
> +		else
> +			mptcp_schedule_work(sk);

Seems like a tradeoff here is between the old code trying to continue =

sending on this subflow, versus the latency of the scheduled worker. If =

the scheduler is frequently switching off between subflows the worker =

would be more of an issue, do our self tests exercise that right now?

I still need to look more closely at the RFC patch set for the napi idea.

> +	} else {
> 		set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->flags);
> +	}
> }
>
> #define MPTCP_DEFERRED_ALL (TCPF_WRITE_TIMER_DEFERRED)
> -- =

> 2.26.2

--
Mat Martineau
Intel
--===============1558652199623053763==--
