Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C997E2F80
	for <mptcp@lists.linux.dev>; Thu, 10 Jun 2021 22:11:40 +0000 (UTC)
IronPort-SDR: ihDcO8dz+dOo87BT8yRrwoMgEgSPeuZXMQppxZKVGebR4gnsGRtGBaMi6f7q9/Q2Tlk5etwAEB
 Bgw8OiwO7/aA==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="269265766"
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="269265766"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 15:11:39 -0700
IronPort-SDR: VeIcWkGWyfVKZL7kKex1Am7Tpif8uwF64VDDg7vzckoQXLIZK3KbX9AQuFHLf8Nilw980t0prr
 tqiYVW2ujeWA==
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="552505575"
Received: from ngattu-mobl1.amr.corp.intel.com ([10.209.121.205])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 15:11:39 -0700
Date: Thu, 10 Jun 2021 15:11:39 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Yonglong Li <liyonglong@chinatelecom.cn>
cc: mptcp@lists.linux.dev, pabeni@redhat.com, matthieu.baerts@tessares.net, 
    geliangtang@gmail.com
Subject: Re: [PATCH] mptcp: use icsk_rto of first subflow as ADD_ADDR timeout
 value
In-Reply-To: <1623219886-69610-1-git-send-email-liyonglong@chinatelecom.cn>
Message-ID: <d5e81793-bdda-9a32-7da3-1f79e8d923d0@linux.intel.com>
References: <1623219886-69610-1-git-send-email-liyonglong@chinatelecom.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 9 Jun 2021, Yonglong Li wrote:

> ADD_ADDR is sent on first subflow, so we can use icsk_rto of first
> subflow as ADD_ADDR retransmission timeout value.
>
> Change sysctl add_addr_timeout type to millsecond and default value
> to TCP_RTO_MIN.
>
> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
> ---
> net/mptcp/ctrl.c       | 13 +++++++++----
> net/mptcp/pm_netlink.c |  5 +++--
> net/mptcp/protocol.h   |  2 +-
> 3 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index 6c2639b..40e8579 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -36,9 +36,14 @@ int mptcp_is_enabled(struct net *net)
> 	return mptcp_get_pernet(net)->mptcp_enabled;
> }
>
> -unsigned int mptcp_get_add_addr_timeout(struct net *net)
> +unsigned int mptcp_get_add_addr_timeout(struct net *net, struct mptcp_sock *msk)
> {
> -	return mptcp_get_pernet(net)->add_addr_timeout;
> +	unsigned int timeout = mptcp_get_pernet(net)->add_addr_timeout;
> +
> +	if (msk->first && inet_csk(msk->first)->icsk_rto)
> +		timeout = inet_csk(msk->first)->icsk_rto;

Since the time to echo an ADD_ADDR may have factors other then 
network-level latency involved, I don't think the timeout should be based 
on icsk_rto.

Is there a specific issue you've encountered with slow ADD_ADDR retries?


> +
> +	return timeout;
> }
>
> int mptcp_is_checksum_enabled(struct net *net)
> @@ -49,7 +54,7 @@ int mptcp_is_checksum_enabled(struct net *net)
> static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
> {
> 	pernet->mptcp_enabled = 1;
> -	pernet->add_addr_timeout = TCP_RTO_MAX;
> +	pernet->add_addr_timeout = TCP_RTO_MIN;

TCP_RTO_MAX is probably too long. But TCP_RTO_MIN is certainly too short. 
While the current upstream Linux code will echo the ADD_ADDR at a fairly 
low level in the kernel, in the future a userspace path manager may be 
involved so the timing on the ADD_ADDR echo should not be too tight.

Maybe a change to a shorter timeout would be sufficient.


> 	pernet->checksum_enabled = 0;
> }
>
> @@ -70,7 +75,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
> 		.procname = "add_addr_timeout",
> 		.maxlen = sizeof(unsigned int),
> 		.mode = 0644,
> -		.proc_handler = proc_dointvec_jiffies,
> +		.proc_handler = proc_dointvec_ms_jiffies,

There are a few issues with this part of the patch:

1. Changes the meaning of the sysctl
2. Not sure millisecond granularity is needed
3. Like above, don't want to allow very short timeouts that could affect 
userspace path managers

Like I asked above, it would be helpful to understand the problem you're 
solving so we can discuss possible solutions. It's also very helpful 
information to explain the motivation in the commit message.

Thanks for the patch,

--
Mat Martineau
Intel
