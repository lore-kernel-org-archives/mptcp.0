Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F2B71
	for <mptcp@lists.linux.dev>; Sat, 19 Jun 2021 00:19:31 +0000 (UTC)
IronPort-SDR: rQPChLQjemNJccrIfSbIGdUv53atjplCnldMRQYBtB6y0LUfgiqO/bh1iNx8Y1WMS8EuRc3+vR
 tdi6TS47HPRQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="206588774"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="206588774"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 17:19:31 -0700
IronPort-SDR: jHHPICdYRkf3MiIZuq5hukwPaE6cJpg9gfTjk18AeHe+B66kNsrPJdIK5/5QZsUBFjSFqQgBk/
 BPnvf5Tww/EQ==
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="485863906"
Received: from rsurapan-mobl2.amr.corp.intel.com ([10.209.105.229])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 17:19:31 -0700
Date: Fri, 18 Jun 2021 17:19:30 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: wujianguo106@163.com
cc: mptcp@lists.linux.dev, pabeni@redhat.com, fw@strlen.de
Subject: Re: [PATCH v5 4/4] mptcp: avoid processing packet if a subflow
 reset
In-Reply-To: <1623840570-42004-5-git-send-email-wujianguo106@163.com>
Message-ID: <45dcfe4c-1918-2d78-accf-141bb4af2c5b@linux.intel.com>
References: <1623840570-42004-1-git-send-email-wujianguo106@163.com> <1623840570-42004-5-git-send-email-wujianguo106@163.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 16 Jun 2021, wujianguo106@163.com wrote:

> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>
> If check_fully_established() causes a subflow reset, it should not
> continue to process the packet in tcp_data_queue().
>
> setting:
> 	TCP_SKB_CB(skb)->end_seq = TCP_SKB_CB(skb)->seq;
>
> so that the following check will drop the pkt in
> tcp_data_queue():
>  if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq) {
> 	__kfree_skb(skb);
> 	return;
>  }
>
> Fixes: d582484726c4 ("mptcp: fix fallback for MP_JOIN subflows")
> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
> ---
> net/mptcp/options.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 1aec01686c1a..be435c5421cd 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -926,6 +926,12 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
> 	return true;
>
> reset:
> +	/* If a subflow is reset, the packet should not continue to be
> +	 * processed in tcp_data_queue(), so setting: end_seq = seq,
> +	 * then tcp_data_queue() will drop the packet.
> +	 */
> +	TCP_SKB_CB(skb)->end_seq = TCP_SKB_CB(skb)->seq;
> +

This does have the desired effect when mptcp_incoming_options() is called 
from tcp_data_queue(), but mptcp_incoming_options() is also called from 
tcp_reset() and tcp_rcv_state_process(). The other callers appear to 
tolerate the sequence number modification.

I think it would be clearer to either add a return value or output 
parameter to mptcp_incoming_options() to explicitly tell the caller that a 
reset has been sent and tcp_done() called. Then it would be clearer in 
tcp_data_queue() that the packet is being discarded due to mptcp header 
content.

(It also looks like it unexpected behavior may be possible if we get a 
strange TCP_RST + MP_JOIN packet when not fully established, but that's 
unrelated to this patch. Maybe I'll try to create a packetdrill test to 
see what happens)

> 	mptcp_subflow_reset(ssk);
> 	return false;
> }
> -- 
> 1.8.3.1

--
Mat Martineau
Intel
