Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19EB3FC9
	for <mptcp@lists.linux.dev>; Fri,  3 Sep 2021 23:50:21 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10096"; a="283248691"
X-IronPort-AV: E=Sophos;i="5.85,266,1624345200"; 
   d="scan'208";a="283248691"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 16:50:21 -0700
X-IronPort-AV: E=Sophos;i="5.85,266,1624345200"; 
   d="scan'208";a="544164522"
Received: from gchandr2-mobl.amr.corp.intel.com ([10.209.38.180])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 16:50:20 -0700
Date: Fri, 3 Sep 2021 16:50:20 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@xiaomi.com>
Subject: Re: [MPTCP][PATCH RFC 1/5] mptcp: don't send RST for single
 subflow
In-Reply-To: <c9504a9a84a501016ddc53ebbf644f827233b7e0.1630656206.git.geliangtang@xiaomi.com>
Message-ID: <221d337-689-3de2-c4fa-30b74c3de5d@linux.intel.com>
References: <cover.1630656206.git.geliangtang@xiaomi.com> <c9504a9a84a501016ddc53ebbf644f827233b7e0.1630656206.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 3 Sep 2021, Geliang Tang wrote:

> From: Geliang Tang <geliangtang@xiaomi.com>
>
> When a bad checksum is detected and a single subflow is in use, don't
> send RST + MP_FAIL, send data_ack + MP_FAIL instead.
>
> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> ---
> net/mptcp/subflow.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 1de7ce883c37..dfcd84abc13e 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1167,14 +1167,14 @@ static bool subflow_check_data_avail(struct sock *ssk)
> 	/* RFC 8684 section 3.7. */
> 	if (subflow->send_mp_fail) {
> 		if (mptcp_has_another_subflow(ssk)) {

Hi Geliang -

Thanks for sharing these RFC patches.


RFC8684 says that this infinite mapping case is when there is one subflow, 
*and* all the data is contiguous. So this condition needs to check for 
contiguous data on the subflow.

We don't currently track whether the data is contiguous on a subflow, so 
that tracking needs to be added. When retransmission happens, we could set 
a "noncontiguous" flag in the msk, and once all retransmissions are 
DATA_ACK'd that flag could be cleared.

> +			ssk->sk_err = EBADMSG;
> +			tcp_set_state(ssk, TCP_CLOSE);
> +			subflow->reset_transient = 0;
> +			subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
> +			tcp_send_active_reset(ssk, GFP_ATOMIC);
> 			while ((skb = skb_peek(&ssk->sk_receive_queue)))
> 				sk_eat_skb(ssk, skb);
> 		}
> -		ssk->sk_err = EBADMSG;
> -		tcp_set_state(ssk, TCP_CLOSE);
> -		subflow->reset_transient = 0;
> -		subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
> -		tcp_send_active_reset(ssk, GFP_ATOMIC);
> 		WRITE_ONCE(subflow->data_avail, 0);
> 		return true;
> 	}
> -- 
> 2.31.1

--
Mat Martineau
Intel
