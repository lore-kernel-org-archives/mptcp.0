Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD43070
	for <mptcp@lists.linux.dev>; Fri,  4 Jun 2021 00:06:48 +0000 (UTC)
IronPort-SDR: sQhRaeRwcuz0ufaV91E4M1URqX3mytBp1yNAQzHQzAlG+Wx0pIms+O8rjUc3HSl1lnNZWy613g
 dm4hWQ9NVZgQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="203997430"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="203997430"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 17:06:45 -0700
IronPort-SDR: XJ19cAAVMcGy2s57TfN5RIDVqRB/lqe84DAfnlHVuUs7bWKca7aOCi8kGAqFBBSwQIxqfGizjh
 Xg62h5nObvkA==
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="550889229"
Received: from jhe12-mobl.amr.corp.intel.com ([10.212.229.108])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 17:06:44 -0700
Date: Thu, 3 Jun 2021 17:06:33 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-net] mptcp: do not warn on bad input from the
 network
In-Reply-To: <637fc17e2c0f833e820f7f8097fdc1212b4c968f.1622719886.git.pabeni@redhat.com>
Message-ID: <414ccd-a370-e7a7-c753-a3327b60347a@linux.intel.com>
References: <637fc17e2c0f833e820f7f8097fdc1212b4c968f.1622719886.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 3 Jun 2021, Paolo Abeni wrote:

> warn_bad_map() produces a kernel WARN on bad input coming
> from the network. Use pr_debug() to avoid spamming the system
> log.
>
> Additionally, when the right bound check fails, warn_bad_map() reports
> the wrong ssn value, let's fix it.
>
> Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/107
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> I think we should really abvoid the warn here. Later patches will add
> MIB counters for the relevant event
> ---
> net/mptcp/subflow.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>

Thanks for the patch Paolo. Looks good.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>



> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 5ef31aa16cc1..259f99b61c35 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -787,10 +787,10 @@ static u64 expand_seq(u64 old_seq, u16 old_data_len, u64 seq)
> 	return seq | ((old_seq + old_data_len + 1) & GENMASK_ULL(63, 32));
> }
>
> -static void warn_bad_map(struct mptcp_subflow_context *subflow, u32 ssn)
> +static void dbg_bad_map(struct mptcp_subflow_context *subflow, u32 ssn)
> {
> -	WARN_ONCE(1, "Bad mapping: ssn=%d map_seq=%d map_data_len=%d",
> -		  ssn, subflow->map_subflow_seq, subflow->map_data_len);
> +	pr_debug("Bad mapping: ssn=%d map_seq=%d map_data_len=%d",
> +		 ssn, subflow->map_subflow_seq, subflow->map_data_len);
> }
>
> static bool skb_is_fully_mapped(struct sock *ssk, struct sk_buff *skb)
> @@ -815,13 +815,13 @@ static bool validate_mapping(struct sock *ssk, struct sk_buff *skb)
> 		/* Mapping covers data later in the subflow stream,
> 		 * currently unsupported.
> 		 */
> -		warn_bad_map(subflow, ssn);
> +		dbg_bad_map(subflow, ssn);
> 		return false;
> 	}
> 	if (unlikely(!before(ssn, subflow->map_subflow_seq +
> 				  subflow->map_data_len))) {
> 		/* Mapping does covers past subflow data, invalid */
> -		warn_bad_map(subflow, ssn + skb->len);
> +		dbg_bad_map(subflow, ssn);
> 		return false;
> 	}
> 	return true;
> -- 
> 2.26.3
>
>
>

--
Mat Martineau
Intel
