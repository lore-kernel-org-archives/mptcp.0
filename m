Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939F07B
	for <mptcp@lists.linux.dev>; Mon, 24 Oct 2022 23:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666654657; x=1698190657;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=W5yk7mbSAGP+IFuLyR1CW8CfqAG2Og/VUjsIz7sAquU=;
  b=OE62+LU7YJb/bbeOQkO2kCCRZcbNMNvc1VJaJqwalTEnnk1w8GWfMHyW
   pBKwhm/zkuLoZner3fIMYWB902GXGmoDrTqdc9hK+z33fOEOjTxxVeASD
   /ztpdgf9hyaIgwda9luWNzgTBlPcACA9qyQwdx9JUQedmV8GfaExEe386
   RU9cCVuEN0et5uxZRgOgnfhzuU99Ov7N3LvG3WliembnKqZWhcxGsXn1e
   5RZA38E3cnaJZsppzICQgiBCkBvpAdhD1RvwE3Be914kt1y4eDSrWdSkx
   b1ZEsyPdo8aqARprggpzASOD1sBXmlTMJdzXlM3z5DbP2bGLyBKbX+RsI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="371761665"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="371761665"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 16:37:37 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="626233061"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="626233061"
Received: from mlotfi-mobl.amr.corp.intel.com ([10.212.254.208])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 16:37:37 -0700
Date: Mon, 24 Oct 2022 16:37:36 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: fix divide error in
 mptcp_subflow_get_send
In-Reply-To: <20221022075412.471-1-geliang.tang@suse.com>
Message-ID: <71f12325-6216-f1d8-63da-3876f9b148fa@linux.intel.com>
References: <20221022075412.471-1-geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Sat, 22 Oct 2022, Geliang Tang wrote:

> Fix this divide error:
>
> ----
> divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 0 PID: 14336 Comm: syz-executor.6 Not tainted 6.1.0-rc1-00215-g47aa7f23f440 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:div_u64_rem include/linux/math64.h:29 [inline]
> RIP: 0010:div_u64 include/linux/math64.h:128 [inline]
> RIP: 0010:mptcp_subflow_get_send+0xa87/0x1200 net/mptcp/protocol.c:1486
> ----
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/314
> Reported-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ddeb8b36a677..3a07c0d197d4 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1475,13 +1475,14 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> 	if (!ssk || !sk_stream_memory_free(ssk))
> 		return NULL;
>
> -	burst = min_t(int, MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
> -	wmem = READ_ONCE(ssk->sk_wmem_queued);
> -	if (!burst) {
> +	if (mptcp_wnd_end(msk) <= msk->snd_nxt) {
> 		msk->last_snd = NULL;
> 		return ssk;
> 	}
>
> +	burst = min_t(u32, MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
> +	wmem = READ_ONCE(ssk->sk_wmem_queued);
> +
> 	subflow = mptcp_subflow_ctx(ssk);
> 	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
> 					   READ_ONCE(ssk->sk_pacing_rate) * burst,
> -- 
> 2.35.3

Hi Geliang -

I haven't been able to reproduce the problem using commit id c3917837f483 
(export/20221024T065054 without the "features other trees" patches), and 
the only change in mptcp_subflow_get_send() is the removal of the fallback 
check in "mptcp: add get_subflow wrappers". The stack trace shows that 
mptcp_subflow_get_send() is called directly by __mptcp_push_pending():

RIP: 0010:mptcp_subflow_get_send+0xa87/0x1200 net/mptcp/protocol.c:1486
...
Call Trace:
  <TASK>
  __mptcp_push_pending+0x19e/0x770 net/mptcp/protocol.c:1550
  mptcp_sendmsg+0x694/0x19d0 net/mptcp/protocol.c:1813

So I think the divide by zero is due to the missing fallback check. Seems 
like the fallback check should be moved only when mptcp_subflow_get_send() 
is only called using the wrapper? WDYT?

--
Mat Martineau
Intel
