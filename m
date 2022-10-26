Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5201A805
	for <mptcp@lists.linux.dev>; Wed, 26 Oct 2022 00:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666744364; x=1698280364;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iazV0pwMycP0zEgw605fjeGfJQ9kdwZFSk9XBYUgDrk=;
  b=lFAz5+K6HVJ7sFqx4Fmd312Zhxy3CMVBRZ7cKDv4ysWHTOKT0Kjcy+VQ
   aHuj+mS+/SrcAlflQ5ECafhi+qaeDDRDeiKBld9LWX9Pz0/fHUuMaeKaV
   5dEFdff/rab0hs55R4xcO/pfxPJdfKBh0ngK8vqPPXOWBd6wli1ZLBT+g
   IDb9CXusnqkYQl9K81H47OrXmD1lMNa7URq9ro4dXzl1vnMSMa+8xR2Rm
   4QWeqAHiUeiTffB1XLbzXCWnTaQpgmg+rOOsrDgjF/a4NPZ3N0fcCVpag
   jb111q6UKOndmVW0ky/heMEAJ4ZtialH+m/L1KxygMtS3DRMOC03ryy52
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="394137876"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="394137876"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 17:32:43 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="663003381"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="663003381"
Received: from knnguyen-mobl1.amr.corp.intel.com ([10.209.107.240])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 17:32:43 -0700
Date: Tue, 25 Oct 2022 17:32:42 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "mptcp: delay updating
 already_sent"
In-Reply-To: <20221022075412.471-2-geliang.tang@suse.com>
Message-ID: <6e81c47c-96f5-6dd8-e8aa-bc4b03345a01@linux.intel.com>
References: <20221022075412.471-1-geliang.tang@suse.com> <20221022075412.471-2-geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Sat, 22 Oct 2022, Geliang Tang wrote:

> No need to update info->limit, drop it.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

Hi Geliang -

Please include this in the next revision of the "BPF redundant scheduler" 
series.

Thanks,
Mat

> ---
> net/mptcp/protocol.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 958c7fd6da2b..a21bf43472f6 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1244,8 +1244,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
> 	pr_debug("msk=%p ssk=%p sending dfrag at seq=%llu len=%u already sent=%u",
> 		 msk, ssk, dfrag->data_seq, dfrag->data_len, info->sent);
>
> -	if (info->sent > info->limit ||
> -	    info->limit > dfrag->data_len)
> +	if (WARN_ON_ONCE(info->sent > info->limit ||
> +			 info->limit > dfrag->data_len))
> 		return 0;
>
> 	if (unlikely(!__tcp_can_send(ssk)))
> @@ -1573,7 +1573,6 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
> 			}
>
> 			info->sent += ret;
> -			info->limit -= ret;
> 			copied += ret;
> 			len -= ret;
>
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
