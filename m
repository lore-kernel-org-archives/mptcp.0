Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D7570
	for <mptcp@lists.linux.dev>; Wed, 26 May 2021 22:55:03 +0000 (UTC)
IronPort-SDR: CwD+Hwl0wh9FZj5BGLoEvU68vxR9HiS32jvoazPXzWaImPpSk7nqIeWRPkTMTrWR0usALlrbeW
 MY3ewJ8rFilA==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="202607495"
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="202607495"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 15:55:02 -0700
IronPort-SDR: iem47vSUTa2Cty68V+WRdYwV15avOy9OegdZXTnb33AeXf1Ib0iUJTRnipJRFiuVgex7UHcmTZ
 qBTTjfKZElpw==
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="477168109"
Received: from oelenito-mobl1.amr.corp.intel.com ([10.212.180.42])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 15:55:02 -0700
Date: Wed, 26 May 2021 15:55:02 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, max@internet.ru
Subject: Re: [PATCH mptcp-net] mptcp: let warn_bad_map report relevant
 values
In-Reply-To: <e553550a010387f7ccfafa4010397413b032eef9.1622042688.git.pabeni@redhat.com>
Message-ID: <8bc674-fcaf-8cf-55c0-678a7bf6af1@linux.intel.com>
References: <e553550a010387f7ccfafa4010397413b032eef9.1622042688.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 26 May 2021, Paolo Abeni wrote:

> When the right bound check fails, warn_bad_map() reports
> the wrong ssn value, let's fix it.
>
> Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/subflow.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 6b1cd4257edf..726bc3d083fa 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -821,7 +821,7 @@ static bool validate_mapping(struct sock *ssk, struct sk_buff *skb)
> 	if (unlikely(!before(ssn, subflow->map_subflow_seq +
> 				  subflow->map_data_len))) {
> 		/* Mapping does covers past subflow data, invalid */
> -		warn_bad_map(subflow, ssn + skb->len);
> +		warn_bad_map(subflow, ssn);
> 		return false;
> 	}
> 	return true;
> -- 
> 2.26.3

I agree, ssn is more helpful information here.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
