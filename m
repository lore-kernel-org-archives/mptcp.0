Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA66161
	for <mptcp@lists.linux.dev>; Tue,  9 Aug 2022 00:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660003444; x=1691539444;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Nswy2VWRRsiVQ58stWqz0iGx2j+GipnbiMyWHRcsoPg=;
  b=elEJb6iYhfINxer9m78dJM1HmyMJMDxgRU99DtMQXZ+eTjJ/HDVrbrsK
   gf1PulVw0yXdSzifel7WvCvmsB50n2/DfM1JCqXKeCS8wGTeFFYB2yXfK
   Ub2FohypIf9mCpbBaZLT6ISLy7kLoy2XrCa3U78FRm9FXKEJczbnU0y7F
   8r5KRYEdDBeNT4N8bLBNC8PSLad9A4wPrBBVcJFYp4GHoUTJk6j67Pg7a
   e86zgygbiaxEst4kToiOOPUzHZsZUwbNCow1224Zt66gwplmeNM0/PIHD
   JZdlcBHYUsPcipx+vXBNrCv/M7vwQiRmyF+xtqcyjAK5VZgONClh7C4zt
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="291504827"
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="291504827"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 17:04:03 -0700
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="780675453"
Received: from srinathm-mobl.amr.corp.intel.com ([10.212.202.204])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 17:04:03 -0700
Date: Mon, 8 Aug 2022 17:04:03 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Thomas Haller <thaller@redhat.com>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>, 
    Florian Westphal <fw@strlen.de>, 
    Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH] mptcp: allow priviledged operations from user
 namespaces
In-Reply-To: <20220805115020.525181-1-thaller@redhat.com>
Message-ID: <e95949bf-53cf-bdf-27c8-8cbc3eeda450@linux.intel.com>
References: <20220805115020.525181-1-thaller@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 5 Aug 2022, Thomas Haller wrote:

> GENL_ADMIN_PERM checks that the user has CAP_NET_ADMIN in the initial
> namespace by calling netlink_capable(). Instead, use GENL_UNS_ADMIN_PERM
> which uses netlink_ns_capable(). This checks that the caller has
> CAP_NET_ADMIN in the current user namespace.
>
> See also commit 4a92602aa1cd ('openvswitch: allow management from inside
> user namespaces') which introduced this mechanism. See also commit
> 5617c6cd6f84 ('nl80211: Allow privileged operations from user
> namespaces'), which introduced this for nl80211.
>
> Signed-off-by: Thomas Haller <thaller@redhat.com>

Hi Thomas -

Thanks for the patch! This does seem like a good idea to me (and it seems 
to work ok with our MPTCP tests), but I'd like to get some more community 
input before merging (Paolo/Florian?).

We also need to figure out which branch this belongs in (we usually tag 
the patch subject with [PATCH mptcp-net] or [PATCH mptcp-next] to indicate 
this). If we upstream it to the net branch it will get in to 6.0-rcX and 
be eligible for backporting to the stable branches. Looks like it would 
need manual backporting to pre-5.19 kernels due to the incremental changes 
to mptcp_pm_ops over time.

To upstream this to net it also needs a Fixes tag:

Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")


Thomas, do you have any thoughts/preferences on upstreaming to net or 
net-next?


Thanks,
Mat


> ---
> net/mptcp/pm_netlink.c | 18 +++++++++---------
> 1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 291b5da42fdb..2c145cdc7bdc 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -2218,17 +2218,17 @@ static const struct genl_small_ops mptcp_pm_ops[] = {
> 	{
> 		.cmd    = MPTCP_PM_CMD_ADD_ADDR,
> 		.doit   = mptcp_nl_cmd_add_addr,
> -		.flags  = GENL_ADMIN_PERM,
> +		.flags  = GENL_UNS_ADMIN_PERM,
> 	},
> 	{
> 		.cmd    = MPTCP_PM_CMD_DEL_ADDR,
> 		.doit   = mptcp_nl_cmd_del_addr,
> -		.flags  = GENL_ADMIN_PERM,
> +		.flags  = GENL_UNS_ADMIN_PERM,
> 	},
> 	{
> 		.cmd    = MPTCP_PM_CMD_FLUSH_ADDRS,
> 		.doit   = mptcp_nl_cmd_flush_addrs,
> -		.flags  = GENL_ADMIN_PERM,
> +		.flags  = GENL_UNS_ADMIN_PERM,
> 	},
> 	{
> 		.cmd    = MPTCP_PM_CMD_GET_ADDR,
> @@ -2238,7 +2238,7 @@ static const struct genl_small_ops mptcp_pm_ops[] = {
> 	{
> 		.cmd    = MPTCP_PM_CMD_SET_LIMITS,
> 		.doit   = mptcp_nl_cmd_set_limits,
> -		.flags  = GENL_ADMIN_PERM,
> +		.flags  = GENL_UNS_ADMIN_PERM,
> 	},
> 	{
> 		.cmd    = MPTCP_PM_CMD_GET_LIMITS,
> @@ -2247,27 +2247,27 @@ static const struct genl_small_ops mptcp_pm_ops[] = {
> 	{
> 		.cmd    = MPTCP_PM_CMD_SET_FLAGS,
> 		.doit   = mptcp_nl_cmd_set_flags,
> -		.flags  = GENL_ADMIN_PERM,
> +		.flags  = GENL_UNS_ADMIN_PERM,
> 	},
> 	{
> 		.cmd    = MPTCP_PM_CMD_ANNOUNCE,
> 		.doit   = mptcp_nl_cmd_announce,
> -		.flags  = GENL_ADMIN_PERM,
> +		.flags  = GENL_UNS_ADMIN_PERM,
> 	},
> 	{
> 		.cmd    = MPTCP_PM_CMD_REMOVE,
> 		.doit   = mptcp_nl_cmd_remove,
> -		.flags  = GENL_ADMIN_PERM,
> +		.flags  = GENL_UNS_ADMIN_PERM,
> 	},
> 	{
> 		.cmd    = MPTCP_PM_CMD_SUBFLOW_CREATE,
> 		.doit   = mptcp_nl_cmd_sf_create,
> -		.flags  = GENL_ADMIN_PERM,
> +		.flags  = GENL_UNS_ADMIN_PERM,
> 	},
> 	{
> 		.cmd    = MPTCP_PM_CMD_SUBFLOW_DESTROY,
> 		.doit   = mptcp_nl_cmd_sf_destroy,
> -		.flags  = GENL_ADMIN_PERM,
> +		.flags  = GENL_UNS_ADMIN_PERM,
> 	},
> };
>
> -- 
> 2.37.1
>
>
>

--
Mat Martineau
Intel
