Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF832FB2
	for <mptcp@lists.linux.dev>; Sat, 26 Jun 2021 00:19:09 +0000 (UTC)
IronPort-SDR: I/yuIVT7OUcj6AS1GmFCHERA7wgBNSlp5VQBPJ2twi21z22sMlYCLQZQs4p7bPy0m3jXIJ2okK
 M1O2X2JxLp7A==
X-IronPort-AV: E=McAfee;i="6200,9189,10026"; a="207794672"
X-IronPort-AV: E=Sophos;i="5.83,300,1616482800"; 
   d="scan'208";a="207794672"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 17:18:58 -0700
IronPort-SDR: +Q0YZYmr3Fgdvjn8teqHYh0Q4BRaIAZyV1WuAmgQ5V2MjaisaIuIkK5Y5H+Z8XyqT35Q2iMr6Q
 xLeyvlj0D3MA==
X-IronPort-AV: E=Sophos;i="5.83,300,1616482800"; 
   d="scan'208";a="407122312"
Received: from vsampat1-mobl2.amr.corp.intel.com ([10.212.210.249])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 17:18:58 -0700
Date: Fri, 25 Jun 2021 17:18:58 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH v2 mptcp-next 3/5] mptcp: send out MP_FAIL when
 data checksum fail
In-Reply-To: <92e3fde76e7efe8c6a5efaae133b21ad637c47e8.1624535762.git.geliangtang@gmail.com>
Message-ID: <623bc473-5c4-948f-8a59-e5c9e23072d9@linux.intel.com>
References: <cover.1624535761.git.geliangtang@gmail.com> <a3f24604a58ac18c29284160503bd8fd19169334.1624535761.git.geliangtang@gmail.com> <1755dbb007864483285783ca4c9a1b25923ab99a.1624535761.git.geliangtang@gmail.com>
 <92e3fde76e7efe8c6a5efaae133b21ad637c47e8.1624535762.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 24 Jun 2021, Geliang Tang wrote:

> When a bad checksum is detected, send out the MP_FAIL suboption.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> net/mptcp/subflow.c | 15 +++++++++++++++
> 1 file changed, 15 insertions(+)
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 0b5d4a3eadcd..13e53a6bd3a1 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -913,6 +913,7 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
> 	csum = csum_partial(&header, sizeof(header), subflow->map_data_csum);
> 	if (unlikely(csum_fold(csum))) {
> 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
> +		subflow->send_mp_fail = 1;
> 		return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
> 	}
>
> @@ -1159,6 +1160,20 @@ static bool subflow_check_data_avail(struct sock *ssk)
> 	return false;
>
> fallback:
> +	if (subflow->send_mp_fail) {
> +		if (mptcp_has_another_subflow_established(ssk)) {

mptcp_has_another_subflow_established() can return false if there's 
another subflow that's not fully established yet. It's not clear what 
happens to such a join-in-progress subflow in the 'else' case below.

Probably safest to only do the "single subflow fallback" case when there 
are no other subflows at all.

> +			mptcp_subflow_reset(ssk);
> +			while ((skb = skb_peek(&ssk->sk_receive_queue)))
> +				sk_eat_skb(ssk, skb);
> +		} else {
> +			pr_fallback(msk);
> +			__mptcp_do_fallback(msk);
> +		}
> +
> +		WRITE_ONCE(subflow->data_avail, 0);
> +		return true;
> +	}
> +

Existing fallback code has only been implemented for not-fully-established 
connections, when the process is much simpler. This checksum-triggered 
MP_FAIL case could happen when more data is in-flight or queued in the 
MPTCP socket (ooo queue).

The RFC uses an "infinite mapping" to fallback after a checksum failure, 
which isn't implemented yet. The MP_FAIL section of the RFC has several 
requirements around this different type of fallback, including a sender 
knowing that all in-flight data is contiguous, and other requirements for 
clearing send buffers with subflow ACKs. This is probably the biggest 
task for MP_FAIL.

> 	/* RFC 8684 section 3.7. */
> 	if (subflow->mp_join || subflow->fully_established) {
> 		/* fatal protocol error, close the socket.
> -- 
> 2.31.1

Thanks,

--
Mat Martineau
Intel
