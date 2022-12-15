Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB7D7C
	for <mptcp@lists.linux.dev>; Thu, 15 Dec 2022 00:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671065590; x=1702601590;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4mIpzVm+9xHcmOsbifl8c+y5GUJ2R8LWyoxQgPShN04=;
  b=lVwZxTEQ9dpbheyAwVPP6etCGZF0d3QgDRwZtgMmgJpOLvKHmQOXYCja
   pu1ePo8T3ZiuHtwny9pDlVek9MTQbvOH0p2fLYib4jyLKLb1Z67v3o64f
   3qkCD94kU/K45uRtf34BV1QY/Jj8QeFiJfIbXCSM8Tli3GEf10KuiGNWp
   dikoMzIezyvdTxFSwWrpS7QBA+A48proLWSdgydQ6wvVqFN7r9N5ZuzRK
   TgezNyt8oKchw5M5tkWxNS3f640C1fn1TrGqL/cgvpgXQw8CFJICMkBvQ
   kJOqZ5s0HgeFfh3NFUPn2yAxT0rAeJH+MmqClReyh0SjdW+oCewjtLMWG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="298227451"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="298227451"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 16:53:09 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="737897088"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="737897088"
Received: from rbcranda-mobl1.amr.corp.intel.com ([10.212.154.86])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 16:53:09 -0800
Date: Wed, 14 Dec 2022 16:53:09 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4 1/2] mptcp: update mptcp_push_release
In-Reply-To: <514fef04b316a78141427871827a65046256e93c.1670724098.git.geliang.tang@suse.com>
Message-ID: <87d7b85c-7f47-2df6-6cb6-aad1ded009c3@linux.intel.com>
References: <cover.1670724098.git.geliang.tang@suse.com> <514fef04b316a78141427871827a65046256e93c.1670724098.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Sun, 11 Dec 2022, Geliang Tang wrote:

> This patch moves the NULL pointer check into mptcp_push_release(). Also
> add a new parameter 'push' for it to set whether to invoke tcp_push in
> it.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 18 ++++++++++++------
> 1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index b3e5d30adbe1..2342b9469181 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1470,9 +1470,17 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> 	return ssk;
> }
>
> -static void mptcp_push_release(struct sock *ssk, struct mptcp_sendmsg_info *info)
> +static void mptcp_push_release(struct sock *ssk,
> +			       struct mptcp_sendmsg_info *info,
> +			       bool push)
> {
> -	tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
> +	if (!ssk)
> +		return;
> +
> +	if (push) {
> +		tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle,
> +			 info->size_goal);
> +	}
> 	release_sock(ssk);
> }
>
> @@ -1578,8 +1586,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> 					/* First check. If the ssk has changed since
> 					 * the last round, release prev_ssk
> 					 */
> -					if (prev_ssk)
> -						mptcp_push_release(prev_ssk, &info);
> +					mptcp_push_release(prev_ssk, &info, do_check_data_fin);
>
> 					/* Need to lock the new subflow only if different
> 					 * from the previous one, otherwise we are still
> @@ -1605,8 +1612,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> 	}
>
> 	/* at this point we held the socket lock for the last subflow we used */
> -	if (ssk)
> -		mptcp_push_release(ssk, &info);
> +	mptcp_push_release(ssk, &info, do_check_data_fin);

If do_check_data_fin is 'true', that means __subflow_push_pending() 
succeeded on some subflow (not necessarily ssk).

Seems like the intent is to only call tcp_push() within 
mptcp_push_release() if data was sent using _that_ ssk. So I think that 
needs to be tracked differently.

>
> 	/* ensure the rtx timer is running */
> 	if (!mptcp_timer_pending(sk))
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
