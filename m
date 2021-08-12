Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E89F168
	for <mptcp@lists.linux.dev>; Thu, 12 Aug 2021 17:03:28 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="215433563"
X-IronPort-AV: E=Sophos;i="5.84,316,1620716400"; 
   d="scan'208";a="215433563"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 10:03:23 -0700
X-IronPort-AV: E=Sophos;i="5.84,316,1620716400"; 
   d="scan'208";a="485534099"
Received: from cjlin-mobl.amr.corp.intel.com ([10.251.25.227])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 10:03:23 -0700
Date: Thu, 12 Aug 2021 10:03:22 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 3/5] mptcp: add MPTCP_TCPINFO getsockopt
 support
In-Reply-To: <20210811131523.6339-4-fw@strlen.de>
Message-ID: <265d1dc-7ea0-d55c-957f-8aa0eb53f094@linux.intel.com>
References: <20210811131523.6339-1-fw@strlen.de> <20210811131523.6339-4-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII



On Wed, 11 Aug 2021, Florian Westphal wrote:

> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index eba294a071c8..ac8e6823db4f 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -723,6 +723,96 @@ static int mptcp_getsockopt_info(struct mptcp_sock *msk, char __user *optval, in
>
> 	if (copy_to_user(optval, &m_info, len))
> 		return -EFAULT;
> +	return 0;
> +}
> +
> +static int mptcp_get_subflow_data(struct mptcp_subflow_data *sfd,
> +				  char __user *optval, int __user *_u_optlen)
> +{
> +#define MIN_INFO_OPTLEN_SIZE	16

This caught my eye on my first quick review pass, I'm not accustomed to 
seeing inline defines like this in the kernel unless it's part of some 
macro magic. The style guide / checkpatch don't say anything, so I'll just 
suggest it would fit better outside the function scope (but no big deal).


For the rest of the patch set, Paolo already covered the expanded test 
cases, so I'll continue with a more in-depth review when you post v2. 
This iteration of the API is looking like the right direction to me.


Thanks,

Mat


> +	int len, copylen;
> +
> +	if (get_user(len, _u_optlen))
> +		return -EFAULT;
> +
> +	if (len <= MIN_INFO_OPTLEN_SIZE)
> +		return -EINVAL;
> +
> +	memset(sfd, 0, sizeof(*sfd));
> +
> +	copylen = min_t(unsigned int, len, sizeof(*sfd));
> +	if (copy_from_user(sfd, optval, copylen))
> +		return -EFAULT;
> +
> +	/* size_subflow_data is u32, but len is signed */
> +	if (sfd->size_subflow_data > INT_MAX ||
> +	    sfd->size_user > INT_MAX)
> +		return -EINVAL;
> +
> +	if (sfd->size_subflow_data < MIN_INFO_OPTLEN_SIZE ||
> +	    sfd->size_subflow_data > len)
> +		return -EINVAL;
> +
> +	if (sfd->num_subflows || sfd->size_kernel)
> +		return -EINVAL;
> +
> +	return len - sfd->size_subflow_data;
> +}

--
Mat Martineau
Intel
