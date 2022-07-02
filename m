Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB4D1360
	for <mptcp@lists.linux.dev>; Sat,  2 Jul 2022 00:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656720267; x=1688256267;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=k330/OTTnVWGkawsVvCHea3xXRduXeddcRUW2VfXUhA=;
  b=GXVuEa0DaNq2SXc9eBSsJYvYYWegEFGsG1RDe+vpdv454I0m18oPn1c9
   Ccw8TBdTXCSTJsLhCaTRX7zCaBGXPFKCr6tKItIC0Q0jfF4FLxAhDtUyl
   Zig5Xtr5XJKsVm+7n5QsYVabMk45ljnm8jBZvxmOkDRWC/Ngz2b46Bunn
   v+rZp3P+itlXeYHlFD/pWbLmbM2cerOwShEQjZZ6GVuZMR3PDC/jqtSIO
   FfqlDifpRPYRlcqnhw4gZSUAFnoHT7q9B8nRJgYw0rSZbPWEGMi+kQlas
   AKOLk0qKwp1nzOaxca2u7NE+P2tFxtiP/Tk9nkpyAqYPyUDJIElfm/WEg
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="265800207"
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="265800207"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 17:04:27 -0700
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="659601554"
Received: from shubhaml-mobl.amr.corp.intel.com ([10.255.229.171])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 17:04:26 -0700
Date: Fri, 1 Jul 2022 17:04:26 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 1/6] mptcp: fix local endpoint acconting.
In-Reply-To: <f0f5893c05f19d5076a9d03c84b65495f488fbf2.1656669391.git.pabeni@redhat.com>
Message-ID: <1dc71764-4046-79c3-c6f-5c736d2d64c0@linux.intel.com>
References: <cover.1656669391.git.pabeni@redhat.com> <f0f5893c05f19d5076a9d03c84b65495f488fbf2.1656669391.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 1 Jul 2022, Paolo Abeni wrote:

> In mptcp_pm_nl_rm_addr_or_subflow() we always mark as availble
> the id corresponding to the just removed address.
>
> The used bitmap actually tracks only the local IDs: we must
> restrict the operation when a (local) subflow is removed.
>
> Fixes: a88c9e496937 ("mptcp: do not block subflows creation on errors")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Looks good to me. Ok to apply this one to the net branch, separate from 
the rest of the series?


For this single patch:
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> ---
> net/mptcp/pm_netlink.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 0a295acf99b8..f1909006a859 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -800,7 +800,8 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
> 			removed = true;
> 			__MPTCP_INC_STATS(sock_net(sk), rm_type);
> 		}
> -		__set_bit(rm_list->ids[i], msk->pm.id_avail_bitmap);
> +		if (rm_type == MPTCP_MIB_RMSUBFLOW)
> +			__set_bit(rm_list->ids[i], msk->pm.id_avail_bitmap);
> 		if (!removed)
> 			continue;
>
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
