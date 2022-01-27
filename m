Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7812C9D
	for <mptcp@lists.linux.dev>; Thu, 27 Jan 2022 00:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643241946; x=1674777946;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5w2mbzmpqThl979PIL9B8laKD2R+P+2IDUg6PJUEaUY=;
  b=hnCo7YBQ924MFge3SxYNmDKRs0gGHaduBzfie7qCBeFTjOfpmTiAlKZr
   hBB9YxqBYW0Npi9dr48CsVzN/6+wW4CFE55vQwRmadMwV8Hu0bP/JZgWT
   0Zps3nmYw6PEvmOfA8XeE8LiwHegUMkzeu0pTH3pxZhmWUFKQ+MC3mA7Y
   XWbbJE+9ypponHcF6DFMgekozblEjvdOE7ymk4f4Tn3K8XmuvMVQ2o9WU
   t9th7IGY7l1n/hM4AnhPEMXlHp0VTR68/kANgRgXx8Pqt3QRAvDMxOV/X
   UCZCwXlHra4uoPgOMq50eQJ/q7CwWqnET9XXJOsjKhXzMc/GH96teNJMC
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="234070039"
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="234070039"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 16:05:46 -0800
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="767306144"
Received: from dhurwitz-mobl.amr.corp.intel.com ([10.209.79.89])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 16:05:46 -0800
Date: Wed, 26 Jan 2022 16:05:45 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 2/3] Squash to "mptcp: infinite mapping
 receiving"
In-Reply-To: <a73dc6f3911c83cc292f4caa6f94675af2e06364.1643110285.git.geliang.tang@suse.com>
Message-ID: <d16d1a56-7874-644-b87c-9f8b6d5574b@linux.intel.com>
References: <cover.1643110285.git.geliang.tang@suse.com> <a73dc6f3911c83cc292f4caa6f94675af2e06364.1643110285.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 25 Jan 2022, Geliang Tang wrote:

> Add a flag infinite_expect in struct mptcp_subflow_context, to avoid
> resetting the subflow when the infinite map wasn't received.
>

Could you give some more details about this too? Does the reset happen 
when the infinite mapping is lost and the peer stops sending MPTCP 
options?

I think a flag like infinite_expect may be needed, but with a bit more 
complexity to discard in-flight data from the peer until the expected 
infinite mapping arrives. Look back at earlier discussions about MP_FAIL 
and dropping data:

https://lore.kernel.org/mptcp/DEA13B0F-B535-42A3-95C6-595859A1CD55@apple.com/


> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.h | 1 +
> net/mptcp/subflow.c  | 7 ++++++-
> 2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 6bcf6cbded45..ddaa86acadce 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -451,6 +451,7 @@ struct mptcp_subflow_context {
> 		send_fastclose : 1,
> 		send_infinite_map : 1,
> 		infinite_sent : 1,
> +		infinite_expect : 1,
> 		rx_eof : 1,
> 		can_ack : 1,        /* only after processing the remote a key */
> 		disposable : 1,	    /* ctx can be free at ulp release time */
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index c8126986793e..e41161048498 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -964,7 +964,9 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
>
> 	data_len = mpext->data_len;
> 	if (data_len == 0) {
> +		pr_debug("infinite mapping received");
> 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
> +		subflow->infinite_expect = 0;
> 		subflow->map_data_len = 0;
> 		return MAPPING_INVALID;
> 	}
> @@ -1174,12 +1176,15 @@ static bool subflow_check_data_avail(struct sock *ssk)
> 				tcp_send_active_reset(ssk, GFP_ATOMIC);
> 				while ((skb = skb_peek(&ssk->sk_receive_queue)))
> 					sk_eat_skb(ssk, skb);
> +			} else {
> +				subflow->infinite_expect = 1;
> 			}
> 			WRITE_ONCE(subflow->data_avail, 0);
> 			return true;
> 		}
>
> -		if ((subflow->mp_join || subflow->fully_established) && subflow->map_data_len) {
> +		if ((subflow->mp_join || subflow->fully_established) &&
> +		    !subflow->infinite_expect && subflow->map_data_len) {
> 			/* fatal protocol error, close the socket.
> 			 * subflow_error_report() will introduce the appropriate barriers
> 			 */
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
