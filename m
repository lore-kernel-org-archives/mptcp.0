Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDD946AA
	for <mptcp@lists.linux.dev>; Wed, 10 Aug 2022 23:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660173264; x=1691709264;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2rdaUlFUHUylbaoSSx+tDb1TayDfbHwuRClbK0T1RSI=;
  b=flfpd361ZgyZGPJEwaGZkW95Yxg53qBzZ2tdc+cU6DkJDS3NWatoUsaw
   FyYY8fuVmfUS1NkaNwV8nC08IUEB4tH8EK7XsPIJNx9qva6Uwu8PFPyHQ
   SMWaQNEUM/8NHym6pXvTzexpLY4CQ/ia8Egkd5yoCReW3QNvtnRyPT0A8
   Okrms6d0KVO91kmyoF6nqydX1ebE9EbMObm6CV7KuUjoNCmYivVJxc4U/
   8gDZAC6CcwqZGXCgs8mFGPXb/OI1Tn1fxo6LjNRjmqjMcwXPvoG8bD4Iw
   /QeyyEj49P/0jl7oi/m6/pPtbhNQnk5MIUTYCQs9Jn4e5OYOqAvJfckzD
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="278158171"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="278158171"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 16:14:24 -0700
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="601975863"
Received: from hssane-mobl.amr.corp.intel.com ([10.251.14.178])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 16:14:24 -0700
Date: Wed, 10 Aug 2022 16:14:24 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Thomas Haller <thaller@redhat.com>
cc: mptcp@lists.linux.dev, Florian Westphal <fw@strlen.de>, 
    Paolo Abeni <pabeni@redhat.com>, 
    Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-next v2 2/2] mptcp: account memory allocation in
 mptcp_nl_cmd_add_addr() to user
In-Reply-To: <20220810074251.31887-2-thaller@redhat.com>
Message-ID: <f78dc871-386-6a9-875-7251b749b0cd@linux.intel.com>
References: <e95949bf-53cf-bdf-27c8-8cbc3eeda450@linux.intel.com> <20220810074251.31887-1-thaller@redhat.com> <20220810074251.31887-2-thaller@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 10 Aug 2022, Thomas Haller wrote:

> Now that non-root users can configure MPTCP endpoints, account
> the memory allocation to the user.
>
> Signed-off-by: Thomas Haller <thaller@redhat.com>

Looks good:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> ---
> net/mptcp/pm_netlink.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 2c145cdc7bdc..79469178a2a8 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1327,7 +1327,7 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
> 		return -EINVAL;
> 	}
>
> -	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
> +	entry = kmalloc(sizeof(*entry), GFP_KERNEL_ACCOUNT);
> 	if (!entry) {
> 		GENL_SET_ERR_MSG(info, "can't allocate addr");
> 		return -ENOMEM;
> -- 
> 2.37.1
>
>

--
Mat Martineau
Intel
