Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A825395
	for <mptcp@lists.linux.dev>; Thu, 10 Mar 2022 00:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646870479; x=1678406479;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NhouEjZ+c7Df4iAOOBZ4AKDrr5WgU6eq92vGAvR5JQI=;
  b=EnyxviWJ3I4HJBvhmAe6gQvcG7PFTMFC967DEoiagvV7nLxfltD6KgOU
   1XiTVXy6hoE25KzB+tonjt9jHpTKval7D8jZ4/qKeumAChZcYguniEv85
   xO2e51Ympiq5Mx2SX9S2RiLW+vAItH2DQ7H8pHdyJSI1DJok3DXI7gcI+
   iH1T6LLXWrA5jJm1W7K9j29pHh67BnQzyQR438lJJdsHMj5Ggp0oDN5El
   hMPFB/XBid3KpnhYDsEKNCaKz5rKhJH1CHlvkjGX1SSaSQvsgkHcsiUwv
   Rapj6r25O056AQGAXMY8zdCQRV+JzGoDOOOObZT68pyLLcpFqvmCTCBBX
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="255306324"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="255306324"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 16:01:04 -0800
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="510688338"
Received: from amadhuso-mobl2.amr.corp.intel.com ([10.212.252.248])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 16:01:03 -0800
Date: Wed, 9 Mar 2022 16:01:03 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3 2/3] mptcp: reset subflow when MP_FAIL
 doesn't respond
In-Reply-To: <0bb6b99ffb4ec3c59fa747f5d79e04d6393ffe47.1646829006.git.geliang.tang@suse.com>
Message-ID: <79de2765-fb3-80e2-fa19-bcbc26f351d5@linux.intel.com>
References: <cover.1646829006.git.geliang.tang@suse.com> <0bb6b99ffb4ec3c59fa747f5d79e04d6393ffe47.1646829006.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 9 Mar 2022, Geliang Tang wrote:

> This patch added a new msk->flags bit MPTCP_FAIL_NO_RESPONSE, then reused
> sk_timer to trigger a check if we have not received a response from the
> peer after sending MP_FAIL. If the peer doesn't respond properly, reset
> the subflow.
>

I don't see the sk_timer use?

> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/pm.c       |  2 ++
> net/mptcp/protocol.c | 21 +++++++++++++++++++++
> net/mptcp/protocol.h |  1 +
> net/mptcp/subflow.c  |  2 ++
> 4 files changed, 26 insertions(+)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index c4622b07b7f5..c41aca97ba36 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -284,6 +284,8 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
> 			subflow->send_mp_fail = 1;
> 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
> 			subflow->send_infinite_map = 1;
> +		} else {
> +			clear_bit(MPTCP_FAIL_NO_RESPONSE, &msk->flags);

Here I think you'd clear the sk_timer (if socket not closed).

> 		}
> 	}
> }
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3cb975227d12..6ff7e6eb44ee 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2494,6 +2494,24 @@ static void __mptcp_retrans(struct sock *sk)
> 		mptcp_reset_timer(sk);
> }
>
> +static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
> +{
> +	struct mptcp_subflow_context *subflow;
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		if (READ_ONCE(subflow->mp_fail_response_expect)) {
> +			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +			bool slow;
> +
> +			pr_debug("MP_FAIL doesn't respond, reset the subflow");
> +			slow = lock_sock_fast(ssk);
> +			mptcp_subflow_reset(ssk);
> +			unlock_sock_fast(ssk, slow);
> +			break;
> +		}
> +	}
> +}
> +
> static void mptcp_worker(struct work_struct *work)
> {
> 	struct mptcp_sock *msk = container_of(work, struct mptcp_sock, work);
> @@ -2534,6 +2552,9 @@ static void mptcp_worker(struct work_struct *work)
> 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
> 		__mptcp_retrans(sk);
>
> +	if (test_and_clear_bit(MPTCP_FAIL_NO_RESPONSE, &msk->flags))
> +		mptcp_mp_fail_no_response(msk);
> +

Without the other suggested changes, this would reset the subflow if the 
worker runs for any reason (and at any time) after MP_FAIL is sent.

> unlock:
> 	release_sock(sk);
> 	sock_put(sk);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 83f0205f0d95..bf58d3c886f5 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -116,6 +116,7 @@
> #define MPTCP_WORK_EOF		3
> #define MPTCP_FALLBACK_DONE	4
> #define MPTCP_WORK_CLOSE_SUBFLOW 5
> +#define MPTCP_FAIL_NO_RESPONSE	6
>
> /* MPTCP socket release cb flags */
> #define MPTCP_PUSH_PENDING	1
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index ca2352ad20d4..5a7aa6e37ca6 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1009,6 +1009,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
> 		pr_debug("infinite mapping received");
> 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
> 		subflow->map_data_len = 0;
> +		clear_bit(MPTCP_FAIL_NO_RESPONSE, &msk->flags);

Another spot to clear the timer rather than this flag.

> 		return MAPPING_INVALID;
> 	}
>
> @@ -1219,6 +1220,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
> 					sk_eat_skb(ssk, skb);
> 			} else {
> 				WRITE_ONCE(subflow->mp_fail_response_expect, true);
> +				set_bit(MPTCP_FAIL_NO_RESPONSE, &msk->flags);

Here, start the timer. In the timer handler, set MPTCP_FAIL_NO_RESPONSE 
flag (with required locking) if it was an MP_FAIL timeout.

> 			}
> 			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
> 			return true;
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
