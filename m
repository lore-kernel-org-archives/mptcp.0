Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0742B6139
	for <mptcp@lists.linux.dev>; Fri, 16 Jun 2023 22:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CE1C433C8;
	Fri, 16 Jun 2023 22:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686956090;
	bh=zBX2d2cLgn9Eh6Wia5VFWyfEZI8WIbl1eazWmA9ZTOA=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=XJPG2Pw2/PTZGGpEvQ4yrkDZTPa0FjFOvBfp6FDuG8MUj2OZbmlz9dEALOgS7kNAl
	 qN+mApwjvMS+jQgtj1VqJKmqb+ytolZJR26AmwjhuRHtiFwmo4zfKdHrPb54cDFLeR
	 JRXxwStkHZKVE1n41qmMnbyAihjjQUzh6jSqSpG9P9Yd4cXkXgDMmbx9W7kM5fyptX
	 kggNJToCxxz3OHWWFMJ7fvyFoLoa9tD0I6tn5oEqPrpf7E/GJmhwoBafdxfyWKA1+z
	 U7ZMurGOpc4IsDQmF3AtKdtAqnTmaGLcpl+tItZE2qBC8iw2XMocVlhbfpIG53pNXP
	 C74BoHJzEbFMQ==
Date: Fri, 16 Jun 2023 15:54:49 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Subject: Re: several messages
In-Reply-To: <65899697-756e-3443-700d-64812b233a8a@gmail.com>
Message-ID: <257ce2f8-3750-83f7-3e06-17491fcf3a87@kernel.org>
References: <3bac625cd995fdb3fc6786b599e3c413f00fc6f5.1686584494.git.pabeni@redhat.com> <65899697-756e-3443-700d-64812b233a8a@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1037099872-1686956090=:46503"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1037099872-1686956090=:46503
Content-Type: text/plain; format=flowed; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 12 Jun 2023, Paolo Abeni wrote:

> Thanks to the previous patch we can finally drop the "temporary hack"
> used to detect rx eof.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> "previous patch" should be replace with a proper commit reference
> once such patch is merged on -net, unless we target both patches on
> the same tree (but this one is really net-next material, while the fix
> is for -net)

Hi Paolo,

To be clear, the "previous patch" is "mptcp: consolidate fallback and non 
fallback state machine"?


> ---
> net/mptcp/protocol.c | 49 --------------------------------------------
> net/mptcp/protocol.h |  5 +----
> 2 files changed, 1 insertion(+), 53 deletions(-)

Hooray for deleting code!

Reviewed-by: Mat Martineau <martineau@kernel.org>

>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 8f3e50065c13..feaedfd2b3eb 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -898,49 +898,6 @@ bool mptcp_schedule_work(struct sock *sk)
> 	return false;
> }
>
> -void mptcp_subflow_eof(struct sock *sk)
> -{
> -	if (!test_and_set_bit(MPTCP_WORK_EOF, &mptcp_sk(sk)->flags))
> -		mptcp_schedule_work(sk);
> -}
> -
> -static void mptcp_check_for_eof(struct mptcp_sock *msk)
> -{
> -	struct mptcp_subflow_context *subflow;
> -	struct sock *sk = (struct sock *)msk;
> -	int receivers = 0;
> -
> -	mptcp_for_each_subflow(msk, subflow)
> -		receivers += !subflow->rx_eof;
> -	if (receivers)
> -		return;
> -
> -	if (!(sk->sk_shutdown & RCV_SHUTDOWN)) {
> -		/* hopefully temporary hack: propagate shutdown status
> -		 * to msk, when all subflows agree on it
> -		 */
> -		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
> -
> -		smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
> -		sk->sk_data_ready(sk);
> -	}
> -
> -	switch (sk->sk_state) {
> -	case TCP_ESTABLISHED:
> -		inet_sk_state_store(sk, TCP_CLOSE_WAIT);
> -		break;
> -	case TCP_FIN_WAIT1:
> -		inet_sk_state_store(sk, TCP_CLOSING);
> -		break;
> -	case TCP_FIN_WAIT2:
> -		inet_sk_state_store(sk, TCP_CLOSE);
> -		break;
> -	default:
> -		return;
> -	}
> -	mptcp_close_wake_up(sk);
> -}
> -
> static struct sock *mptcp_subflow_recv_lookup(const struct mptcp_sock *msk)
> {
> 	struct mptcp_subflow_context *subflow;
> @@ -2193,9 +2150,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> 				break;
> 			}
>
> -			if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
> -				mptcp_check_for_eof(msk);
> -
> 			if (sk->sk_shutdown & RCV_SHUTDOWN) {
> 				/* race breaker: the shutdown could be after the
> 				 * previous receive queue check
> @@ -2726,9 +2680,6 @@ static void mptcp_worker(struct work_struct *work)
>
> 	mptcp_pm_nl_work(msk);
>
> -	if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
> -		mptcp_check_for_eof(msk);
> -
> 	mptcp_check_send_data_fin(sk);
> 	mptcp_check_data_fin_ack(sk);
> 	mptcp_check_data_fin(sk);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index d2e59cf33f57..528586e2ed73 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -113,7 +113,6 @@
> /* MPTCP socket atomic flags */
> #define MPTCP_NOSPACE		1
> #define MPTCP_WORK_RTX		2
> -#define MPTCP_WORK_EOF		3
> #define MPTCP_FALLBACK_DONE	4
> #define MPTCP_WORK_CLOSE_SUBFLOW 5
>
> @@ -481,14 +480,13 @@ struct mptcp_subflow_context {
> 		send_mp_fail : 1,
> 		send_fastclose : 1,
> 		send_infinite_map : 1,
> -		rx_eof : 1,
> 		remote_key_valid : 1,        /* received the peer key from */
> 		disposable : 1,	    /* ctx can be free at ulp release time */
> 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
> 		local_id_valid : 1, /* local_id is correctly initialized */
> 		valid_csum_seen : 1,        /* at least one csum validated */
> 		is_mptfo : 1,	    /* subflow is doing TFO */
> -		__unused : 8;
> +		__unused : 9;
> 	enum mptcp_data_avail data_avail;
> 	bool	scheduled;
> 	u32	remote_nonce;
> @@ -744,7 +742,6 @@ static inline u64 mptcp_expand_seq(u64 old_seq, u64 cur_seq, bool use_64bit)
> void __mptcp_check_push(struct sock *sk, struct sock *ssk);
> void __mptcp_data_acked(struct sock *sk);
> void __mptcp_error_report(struct sock *sk);
> -void mptcp_subflow_eof(struct sock *sk);
> bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, bool use_64bit);
> static inline bool mptcp_data_fin_enabled(const struct mptcp_sock *msk)
> {
> -- 
> 2.40.1
>
>
>

On Tue, 13 Jun 2023, MPTCP CI wrote:

> Hi Paolo,
>
> Thank you for your modifications, that's great!
>
> Our CI did some validations and here is its report:
>
> - KVM Validation: normal (except selftest_mptcp_join):
>  - Success! ✅:
>  - Task: https://cirrus-ci.com/task/6108358801883136
>  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6108358801883136/summary/summary.txt
>
> - KVM Validation: debug (only selftest_mptcp_join):
>  - Unstable: 1 failed test(s): selftest_mptcp_join 🔴:
>  - Task: https://cirrus-ci.com/task/4630615174152192
>  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4630615174152192/summary/summary.txt
>
> - KVM Validation: normal (only selftest_mptcp_join):
>  - Success! ✅:
>  - Task: https://cirrus-ci.com/task/5545408848461824
>  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5545408848461824/summary/summary.txt
>
> - KVM Validation: debug (except selftest_mptcp_join):
>  - Success! ✅:
>  - Task: https://cirrus-ci.com/task/6671308755304448
>  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6671308755304448/summary/summary.txt
>
> Initiator: Matthieu Baerts
> Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/bdbf7858d22c
>
>
> If there are some issues, you can reproduce them using the same environment as
> the one used by the CI thanks to a docker image, e.g.:
>
>    $ cd [kernel source code]
>    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
>        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
>        auto-debug
>
> For more details:
>
>    https://github.com/multipath-tcp/mptcp-upstream-virtme-docker
>
>
> Please note that despite all the efforts that have been already done to have a
> stable tests suite when executed on a public CI like here, it is possible some
> reported issues are not due to your modifications. Still, do not hesitate to
> help us improve that ;-)
>
> Cheers,
> MPTCP GH Action bot
> Bot operated by Matthieu Baerts (Tessares)
>
>
--0-1037099872-1686956090=:46503--
