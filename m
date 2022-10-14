Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9DB2F3F
	for <mptcp@lists.linux.dev>; Fri, 14 Oct 2022 23:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665791626; x=1697327626;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZRva+LO+tlt2mIeLxatvjl8wZnLXy5H7gD+e9FY2cr8=;
  b=lPzXozs/9RqMO1BJx7LSZiIgLQvzdl8rU2ZGtWsu4tGg+H0pkGV/cP9w
   zWHIj5togzL0i2BLg+j8NtFze3lzW8XfPP1yRNf3uNxuBlqh1W+OMBqWG
   xSgAZJrMseCMx9iitFkfqYLfl0OVRWuMcfpskfhiDkuzwgfa5nsoPb0kR
   GBBy1VX58a8fxBYK56E3dytlzcv0+2U7JzvwVqfZHBewlPqD8Of70VQq1
   MI+bo9BzAHJ4dJUMMM9D24FjipItb7fyoDbHjUYuJH9af3DDfDojtbtwB
   AlxNpr4NhXIetxl04ZkCL29WfKy5Ta0PwdD5MKRuP7IBMD40A8by5YJmG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="332017995"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="332017995"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:53:45 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="578800885"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="578800885"
Received: from mcunning-mobl1.amr.corp.intel.com ([10.212.193.28])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:53:45 -0700
Date: Fri, 14 Oct 2022 16:53:45 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v8 02/15] Squash to "mptcp: add struct
 mptcp_sched_ops"
In-Reply-To: <f13602e09c6e0854f43ba68cf926dc03b6036f4a.1665753926.git.geliang.tang@suse.com>
Message-ID: <0a5e0508-6dd4-7a00-4294-42f030640535@linux.intel.com>
References: <cover.1665753926.git.geliang.tang@suse.com> <f13602e09c6e0854f43ba68cf926dc03b6036f4a.1665753926.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Fri, 14 Oct 2022, Geliang Tang wrote:

> New api:
> - add new data_init
> - add snd_burst in mptcp_sched_data
> - add an int return value for get_subflow
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> include/net/mptcp.h | 7 +++++--
> net/mptcp/sched.c   | 2 +-
> 2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index c25939b2af68..cac5b0d512fd 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -101,12 +101,15 @@ struct mptcp_out_options {
>
> struct mptcp_sched_data {
> 	bool	reinject;
> +	int	snd_burst;

I suggest moving this addition to "mptcp: drop snd_burst in mptcp_sock", 
since it isn't used until then.


> 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
> };
>
> struct mptcp_sched_ops {
> -	void (*get_subflow)(const struct mptcp_sock *msk,
> -			    struct mptcp_sched_data *data);
> +	void (*data_init)(const struct mptcp_sock *msk,
> +			  struct mptcp_sched_data *data);
> +	int (*get_subflow)(const struct mptcp_sock *msk,
> +			   struct mptcp_sched_data *data);
>
> 	char			name[MPTCP_SCHED_NAME_MAX];
> 	struct module		*owner;
> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index d295b92a5789..949663742f14 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -33,7 +33,7 @@ struct mptcp_sched_ops *mptcp_sched_find(const char *name)
>
> int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
> {
> -	if (!sched->get_subflow)
> +	if (!sched->data_init || !sched->get_subflow)
> 		return -EINVAL;
>
> 	spin_lock(&mptcp_sched_list_lock);
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
