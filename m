Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1612F3E
	for <mptcp@lists.linux.dev>; Wed, 10 Aug 2022 23:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660172929; x=1691708929;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iJtb88Hv6eG0V1fccsfw2JeYBsaOFzS6QoOugTicVA0=;
  b=ZaU8amMuJtlyV0edD+9Djp5vyEQFDrJZof3XwJFwc6PE3ezqLW2Z4q2d
   721lvrUcQbd7/XeJ/da9D4J5jNOQZrSh6YcjuH1Vj5jmlunXlQWl5WPrj
   sKXkkllafoiSKoM0Q4UM1InSa0CofZx0xYx9R5nE7IewfYdccn7BT+CU2
   JpWH4NkIktuPx5wpsZafthZ5gIbGOhWB5yLDMhzjmhJYBhqfOMAe/SQ9K
   2YOZ+bVQGqux5TTC3YWqnW2h+nEhbrEILbI96sj/KGzW50WI1N9QbPKHa
   SMBqnzLTHazkRwPVkko+a7/bz8/pK6KlhmQneuPLHPBqwbjHpzLzbytWF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="270990356"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="270990356"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 16:08:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="601974824"
Received: from hssane-mobl.amr.corp.intel.com ([10.251.14.178])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 16:08:48 -0700
Date: Wed, 10 Aug 2022 16:08:48 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Thomas Haller <thaller@redhat.com>
cc: mptcp@lists.linux.dev, Florian Westphal <fw@strlen.de>, 
    Paolo Abeni <pabeni@redhat.com>, 
    Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-next v2 1/2] mptcp: allow priviledged operations
 from user namespaces
In-Reply-To: <20220810074251.31887-1-thaller@redhat.com>
Message-ID: <3af41bc6-436a-5849-b2d-9564dd8f46c7@linux.intel.com>
References: <e95949bf-53cf-bdf-27c8-8cbc3eeda450@linux.intel.com> <20220810074251.31887-1-thaller@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 10 Aug 2022, Thomas Haller wrote:

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

Thanks Thomas, looks good:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


Florian had mentioned preferring net-next in the discussion of v1 (which 
Thomas has agreed with by labeling this for mptcp-next), and I agree. I 
don't think it quite meets the bar for -net or stable backporting and it 
would be easier to explain that "6.1 and later support user namespaces for 
MPTCP generic netlink commands". (Matthieu, if someone makes a convincing 
case for -net, it's up to you :) )


- Mat

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

--
Mat Martineau
Intel
