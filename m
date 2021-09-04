Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A46A3FC1
	for <mptcp@lists.linux.dev>; Sat,  4 Sep 2021 00:31:51 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10096"; a="217688421"
X-IronPort-AV: E=Sophos;i="5.85,266,1624345200"; 
   d="scan'208";a="217688421"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 17:31:50 -0700
X-IronPort-AV: E=Sophos;i="5.85,266,1624345200"; 
   d="scan'208";a="692524923"
Received: from gchandr2-mobl.amr.corp.intel.com ([10.209.38.180])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 17:31:50 -0700
Date: Fri, 3 Sep 2021 17:31:49 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@xiaomi.com>
Subject: Re: [MPTCP][PATCH RFC 3/5] mptcp: infinite mapping receiving
In-Reply-To: <3a3eda61ce3b885b2c43cbe63320ecf068bf8267.1630656206.git.geliangtang@xiaomi.com>
Message-ID: <71790a1-de87-bd6e-dcec-96214b895d42@linux.intel.com>
References: <cover.1630656206.git.geliangtang@xiaomi.com> <c9504a9a84a501016ddc53ebbf644f827233b7e0.1630656206.git.geliangtang@xiaomi.com> <7d43c0b1c5f336641d9c8edef80cd0e37b93b668.1630656206.git.geliangtang@xiaomi.com>
 <3a3eda61ce3b885b2c43cbe63320ecf068bf8267.1630656206.git.geliangtang@xiaomi.com>
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
> This patch added the infinite mapping receiving logic.
>
> Added a new struct member infinite_mapping_received in struct
> mptcp_subflow_context, set it true when the infinite mapping is
> received. And added another new struct member infinite_rcv_seq to save
> the received infinite mapping sequence number.
>
> In subflow_check_data_avail, if the infinite_mapping_received flag is
> set, fallback to a regular TCP.
>
> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> ---
> net/mptcp/protocol.h |  2 ++
> net/mptcp/subflow.c  | 17 +++++++++++++++++
> 2 files changed, 19 insertions(+)
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 33400fcdf1b1..ad26e7c0a18c 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -433,6 +433,7 @@ struct mptcp_subflow_context {
> 		backup : 1,
> 		send_mp_prio : 1,
> 		send_mp_fail : 1,
> +		infinite_mapping_received : 1,
> 		rx_eof : 1,
> 		can_ack : 1,        /* only after processing the remote a key */
> 		disposable : 1,	    /* ctx can be free at ulp release time */
> @@ -449,6 +450,7 @@ struct mptcp_subflow_context {
> 	u8	reset_transient:1;
> 	u8	reset_reason:4;
> 	u8	stale_count;
> +	u64	infinite_rcv_seq;
>
> 	long	delegated_status;
> 	struct	list_head delegated_node;   /* link into delegated_action, protected by local BH */
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index dfcd84abc13e..95ea01694bb3 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -967,7 +967,10 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
>
> 	data_len = mpext->data_len;
> 	if (data_len == 0) {
> +		pr_debug("infinite mapping received, data_seq=%llu", mpext->data_seq);
> 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
> +		subflow->infinite_mapping_received = 1;
> +		subflow->infinite_rcv_seq = mpext->data_seq;

RFC 8684 doesn't seem to call for any validation of the data_seq in an 
infinite mapping. I'm not sure we need to do anything with it, we would 
have to keep track of recent mapping values related to the DATA_ACKs we 
sent in order to compare. Does anyone else see this in the RFC?

> 		return MAPPING_INVALID;
> 	}
>
> @@ -1179,6 +1182,20 @@ static bool subflow_check_data_avail(struct sock *ssk)
> 		return true;
> 	}
>
> +	if (subflow->infinite_mapping_received) {
> +		pr_fallback(msk);
> +		__mptcp_do_fallback(msk);
> +		skb = skb_peek(&ssk->sk_receive_queue);
> +		subflow->map_valid = 1;
> +		subflow->map_seq = subflow->infinite_rcv_seq;
> +		subflow->map_data_len = skb->len;
> +		subflow->map_subflow_seq = tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
> +		WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_DATA_AVAIL);
> +		subflow->infinite_mapping_received = 0;
> +		subflow->infinite_rcv_seq = 0;
> +		return true;
> +	}
> +

I don't think we should duplicate the code from later in the function, 
maybe the code below:

> 	if (subflow->mp_join || subflow->fully_established) {

could be changed to this:

if (subflow->mp_join || (subflow->fully_established && 
!subflow->infinite_mapping_received)

?


I think the intent of this fallback mechanism is to not throw away any 
data in the contiguous stream. Instead, it seems like the assumption is 
that the checksum problem was in the MPTCP header and the 
MP_FAIL/infinite-mapping signaling is supposed to let MPTCP do fallback 
while still delivering all the data to the user. Anyone else read the RFC 
the same way, or know better?


> 		/* fatal protocol error, close the socket.
> 		 * subflow_error_report() will introduce the appropriate barriers
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
