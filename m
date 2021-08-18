Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5A372
	for <mptcp@lists.linux.dev>; Wed, 18 Aug 2021 00:54:35 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="277255283"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="277255283"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 17:54:35 -0700
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="449483918"
Received: from sreddy3-mobl.amr.corp.intel.com ([10.251.13.114])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 17:54:35 -0700
Date: Tue, 17 Aug 2021 17:54:34 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 3/5] mptcp: add MPTCP_TCPINFO getsockopt
 support
In-Reply-To: <20210816162636.25611-4-fw@strlen.de>
Message-ID: <8b5d6f4e-5e8d-6b1-38de-8faa5ce9c3fc@linux.intel.com>
References: <20210816162636.25611-1-fw@strlen.de> <20210816162636.25611-4-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII


On Mon, 16 Aug 2021, Florian Westphal wrote:

> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index f7683c22911f..77838933760c 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c

...

> @@ -727,6 +729,117 @@ static int mptcp_getsockopt_info(struct mptcp_sock *msk, char __user *optval, in
> 	return 0;
> }
>
> +static int mptcp_put_subflow_data(struct mptcp_subflow_data *sfd,
> +				  char __user *optval,
> +				  u32 copied,
> +				  int __user *optlen)
> +{
> +	u32 copylen = min_t(u32, sfd->size_subflow_data, sizeof(*sfd));
> +
> +	if (copied)
> +		copied += sfd->size_subflow_data;
> +	else
> +		copied = copylen;
> +
> +	if (put_user(copied, optlen))
> +		return -EFAULT;
> +
> +	if (copy_to_user(optval, sfd, copylen))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static int mptcp_get_subflow_data(struct mptcp_subflow_data *sfd,
> +				  char __user *optval, int __user *optlen)
> +{
> +	int len, copylen;
> +
> +	if (get_user(len, optlen))
> +		return -EFAULT;
> +
> +	/* if mptcp_subflow_data size is changed, need to adjust
> +	 * this function to deal with programs using old version.
> +	 */
> +	BUILD_BUG_ON(MIN_INFO_OPTLEN_SIZE != sizeof(*sfd));

checkpatch complains that the constant should be on the right.


--
Mat Martineau
Intel
