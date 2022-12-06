Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194E6194
	for <mptcp@lists.linux.dev>; Tue,  6 Dec 2022 01:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670289735; x=1701825735;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/B9YBRh9fxZkXkHoc+7zrOO6lDtDj17QVD8GHaVZhWU=;
  b=iw95Aejmf5JzmCtFfzkMXPEh8TxoaMxL6Thr9HQUbTD+eFzQbSIB16NL
   oIu1NbwrFnvxnSQu5Ggr1tXuKCaicC2bhu9nF5CeqsQYgKBawcMLql9KF
   A7tk4fIcEFxyFzmyvIghEQhUpfooyBeqSTfY7EQyYn6+/ALS+EkFFk7/w
   uPOLkP4nS9VkDnIKz9NknOj8YVQlQ/KUnLR5D2yIaj/38YUTA/65kKINj
   iYrj2ePI+BGsx+DA+ohCmkUhwllfcFlALaKRytS0mfMnsGl6YMECaGbbr
   X29o7y/GwvYBU3v2ItCeblAU8kQE7mZ3zvJmoy8TKi0Vx6Z+FD5Et4lrS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="304126788"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="304126788"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 17:22:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="788298147"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="788298147"
Received: from psjohns1-mobl.amr.corp.intel.com ([10.209.67.116])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 17:22:07 -0800
Date: Mon, 5 Dec 2022 17:22:06 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 1/2] Squash to "mptcp: use get_send wrapper,
 v22"
In-Reply-To: <4b463a0bf0729201b6d61e26877f1fc4550b7585.1670243225.git.geliang.tang@suse.com>
Message-ID: <0e0b86db-b733-1e5b-955b-2de440f47056@linux.intel.com>
References: <cover.1670243225.git.geliang.tang@suse.com> <4b463a0bf0729201b6d61e26877f1fc4550b7585.1670243225.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 5 Dec 2022, Geliang Tang wrote:

> Cleanup.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 712b183fd80e..ea2e48a74772 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1565,7 +1565,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> 		int ret = 0;
>
> 		if (mptcp_sched_get_send(msk))
> -			break;
> +			goto out;

I prefer the original code here. It looks like you were making this code 
look more similar to __mptcp_subflow_push_pending(), but I'm not sure that 
the changes to __mptcp_push_pending() in patch 2 are needed. (See my reply 
to patch 2 for more details)

>
> 		push_count = 0;
>
> @@ -1605,6 +1605,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> 		}
> 	}
>
> +out:
> 	/* at this point we held the socket lock for the last subflow we used */
> 	if (ssk)
> 		mptcp_push_release(ssk, &info);
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
