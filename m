Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F5372
	for <mptcp@lists.linux.dev>; Tue, 18 May 2021 21:43:54 +0000 (UTC)
IronPort-SDR: jpxuJmY/bd4hnvTcr3YIqKhDDlHzwFbj3ysS+u5OJyPerTRtS3ynO57iX3eHz14+wgqaT0DEzz
 vn3lPERxW1Hg==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="187953927"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="187953927"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 14:43:51 -0700
IronPort-SDR: pemQ8i3Jlc4XnUBbkXcL7h94AOsjsU9iyuwDS0d+wH2UMvKbuHgR+nK+1pdpAzs2qhucYUIZzA
 Zpssoffr6hkA==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="473160625"
Received: from isofinsk-mobl.amr.corp.intel.com ([10.209.83.65])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 14:43:51 -0700
Date: Tue, 18 May 2021 14:43:51 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] mptcp: drop unconditional pr_warn on bad opt
In-Reply-To: <a4a3c36230b2aeb1315c6234fa39f9ef711be759.1621358150.git.pabeni@redhat.com>
Message-ID: <57c29c35-a7a7-36cf-627c-37a134c1efd8@linux.intel.com>
References: <a4a3c36230b2aeb1315c6234fa39f9ef711be759.1621358150.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 18 May 2021, Paolo Abeni wrote:

> This is a left-over of early day. A malicious peer can flood
> the kernel logs with useless messages, just drop it.
>
> Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/options.c | 1 -
> 1 file changed, 1 deletion(-)

Thanks for catching this Paolo, looks good.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index b713828819b6..f5daccaaac99 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -141,7 +141,6 @@ static void mptcp_parse_option(const struct sk_buff *skb,
> 			memcpy(mp_opt->hmac, ptr, MPTCPOPT_HMAC_LEN);
> 			pr_debug("MP_JOIN hmac");
> 		} else {
> -			pr_warn("MP_JOIN bad option size");
> 			mp_opt->mp_join = 0;
> 		}
> 		break;
> -- 
> 2.26.3

--
Mat Martineau
Intel
