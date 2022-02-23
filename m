Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5F064E
	for <mptcp@lists.linux.dev>; Wed, 23 Feb 2022 00:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645577561; x=1677113561;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Y7lUjQyXpTkcOesPCdosTkGSQOAhPhFRZ1yep4+9o+I=;
  b=EZ7DJ6vOwj9fsWndbHhdA7iXPy0aXSr22QaJ6IkSACYXdUF6t1bJaw+h
   Lzi9LdWYNTD8ePE/Kt0kc3mtiIRhh3m6kfXSekAEOE3/H1lnuQinaK4y3
   38yakLttG8PzaEj7cO+uu0m6qdozizoRPdLS5JXJMTYNpIxyPuvanPEr+
   BWKyE9WtBb8iDDGpBR6GH50C8jfZ/ucvJX8/ngBmXB/Ur5o9kEeOvHrnz
   TArpvD5lMLAw35pLlJtJcaasEB0qw61/sViCwRpq+pRxk2PGoOvYdBKCV
   wqoysMxWHiX+CV3GY3qqYmbYGqnOenK7Cv6LoFOykfgloMO6e16Swyw4k
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="252040457"
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="252040457"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 16:52:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="683718617"
Received: from fdwikusu-mobl.amr.corp.intel.com ([10.251.6.85])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 16:52:41 -0800
Date: Tue, 22 Feb 2022 16:52:40 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: add fullmesh flag check for adding
 address
In-Reply-To: <02d082c77c58ed6400d319d40e719a4ebe4e7942.1645419055.git.geliang.tang@suse.com>
Message-ID: <7cba6dc-53a-29a5-a684-6f47a39cf568@linux.intel.com>
References: <02d082c77c58ed6400d319d40e719a4ebe4e7942.1645419055.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 21 Feb 2022, Geliang Tang wrote:

> The fullmesh flag mustn't be used with the signal flag when adding an
> address. This patch added the necessary flags check for this case.
>

Hi Geliang -

What happens if FULLMESH and SIGNAL are used together with the existing 
code? Is this a patch that should go to -net with a Fixes: tag?

-Mat


> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/pm_netlink.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index a0e7d5b7e22f..e3b0384ff79a 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1253,6 +1253,12 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
> 		return -EINVAL;
> 	}
>
> +	if (addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL &&
> +	    addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) {
> +		GENL_SET_ERR_MSG(info, "flags mustn't have both signal and fullmesh");
> +		return -EINVAL;
> +	}
> +
> 	if (addr.flags & MPTCP_PM_ADDR_FLAG_IMPLICIT) {
> 		GENL_SET_ERR_MSG(info, "can't create IMPLICIT endpoint");
> 		return -EINVAL;
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
