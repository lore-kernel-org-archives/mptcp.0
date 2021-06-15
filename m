Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3899173
	for <mptcp@lists.linux.dev>; Tue, 15 Jun 2021 01:27:24 +0000 (UTC)
IronPort-SDR: 4G5lLyfa8JZojypCHxkE0lbdtDhJSt8v9BMV2CZorPHix1RNHMWGP0jZQ0byC4Hg8Z0hvX9gW0
 8xP3S5ufrozA==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="193020693"
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="193020693"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 18:27:23 -0700
IronPort-SDR: KIcaW4h6Wlmz2F+2qIMzll73ZEjamREjiss7dkAI/fgvb4vwHlej3fHgyzhByGuvTnLhJobTXJ
 d4cq3u6L6wLQ==
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="554286478"
Received: from qyhenrio-mobl1.amr.corp.intel.com ([10.209.5.65])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 18:27:23 -0700
Date: Mon, 14 Jun 2021 18:27:22 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] mptcp: fix bad handling od 32 bit ack
 wrap-around.
In-Reply-To: <356dce030d0adf2bf6b45888876e2c3f9f553a3a.1623691387.git.pabeni@redhat.com>
Message-ID: <1dbd7296-c31f-dce9-69fc-595df927a456@linux.intel.com>
References: <356dce030d0adf2bf6b45888876e2c3f9f553a3a.1623691387.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 14 Jun 2021, Paolo Abeni wrote:

> When receiving 32 bits DSS ack from the peer, the MPTCP need
> to expand them to 64 bits value. The current code is buggy
> WRT detectiong 32 bits ack wrap-around: usaging the 'before()'
> helper is just meaningless: when the wrap-around happes the
> current 32 bit ack value is lower than the previous one, need
> plain direct comparison.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/204
> Fixes: cc9d25669866 ("mptcp: update per unacked sequence on pkt reception")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/options.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index a05270996613..7db1e219f24f 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -952,7 +952,7 @@ static u64 expand_ack(u64 old_ack, u64 cur_ack, bool use_64bit)
> 	old_ack32 = (u32)old_ack;
> 	cur_ack32 = (u32)cur_ack;
> 	cur_ack = (old_ack & GENMASK_ULL(63, 32)) + cur_ack32;
> -	if (unlikely(before(cur_ack32, old_ack32)))
> +	if (unlikely(cur_ack32 < old_ack32))
> 		return cur_ack + (1LL << 32);
> 	return cur_ack;
> }

I think you're right, but I haven't had a chance to test myself (since 
this is tagged as closing #204 it sounds like your tests are good!).

While it's a good thing that mptcp_trunk helped us find this problem, 
maybe this also shows that mptcp_trunk should be more aggressive about 
switching to 64-bit ACKs? Or is this less about speed and only a 
wraparound bug?

--
Mat Martineau
Intel
