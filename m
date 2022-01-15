Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3E229CA
	for <mptcp@lists.linux.dev>; Sat, 15 Jan 2022 00:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642206996; x=1673742996;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=e5pHscq2Jlkpp5kjkNYQ+Jflb5SyhoSleK/QgF7tm9w=;
  b=I11xXtJiGRywKpHXZJNuutY9qrA1lhoBRStry9TgxY5P8As4Xw8cjY21
   80ixktU4PUPLD1rh0wBUAmV1V71iowjObf9rrhFdnjmFR3E4ETwPYVRI5
   zKBCdRWh2oIyrTAFrSdAbKPfXqyLUxnOVk4w9xwd1Gnd5Ow3JJBpRuyPZ
   R+Tq9pYpNalR49gh60djGaUC3Q0n8ScKeKpYZYGTVYoHXR72NWd8fpXek
   X1dgeKWY9PwWdR9T3H/i+Ie/+SzvFJQxDCkCKnX7NeLFLJlazZWiMEtH7
   UeIFFNhlwKr0TnJZhkZMdyYjFH8kDAr0L+wM9u5DXrR+0BaXunYw5GhLr
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="244316515"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="244316515"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 16:36:35 -0800
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="692418345"
Received: from shajisur-mobl.amr.corp.intel.com ([10.209.76.214])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 16:36:35 -0800
Date: Fri, 14 Jan 2022 16:36:35 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH iproute2-next v6] mptcp: add the fullmesh flag setting
 support
In-Reply-To: <bf32abba571cea5301bf26921b0a8eac705e45d7.1642206093.git.geliang.tang@suse.com>
Message-ID: <dd479e13-371a-93c-5be5-4060164dccf4@linux.intel.com>
References: <bf32abba571cea5301bf26921b0a8eac705e45d7.1642206093.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Sat, 15 Jan 2022, Geliang Tang wrote:

> This patch added the fullmesh flag setting support.
>
> ip mptcp endpoint change id 1 fullmesh
> ip mptcp endpoint change id 1 nofullmesh
> ip mptcp endpoint change id 1 backup fullmesh
> ip mptcp endpoint change id 1 nobackup nofullmesh
>
> Added the fullmesh flag check for the adding address too.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> v6:
> - update the flags check as Mat suggested.

Thanks Geliang, v6 looks good to me:

Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


>
> v5:
> - support to set backup and fullmesh flags together.
> ---
> ip/ipmptcp.c        | 18 +++++++++++++-----
> man/man8/ip-mptcp.8 |  8 ++++++--
> 2 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
> index 4363e753..5c8b1627 100644
> --- a/ip/ipmptcp.c
> +++ b/ip/ipmptcp.c
> @@ -25,7 +25,8 @@ static void usage(void)
> 		"Usage:	ip mptcp endpoint add ADDRESS [ dev NAME ] [ id ID ]\n"
> 		"				      [ port NR ] [ FLAG-LIST ]\n"
> 		"	ip mptcp endpoint delete id ID [ ADDRESS ]\n"
> -		"	ip mptcp endpoint change id ID [ backup | nobackup ]\n"
> +		"	ip mptcp endpoint change id ID [ backup | nobackup |\n"
> +		"					 fullmesh | nofullmesh ]\n"
> 		"	ip mptcp endpoint show [ id ID ]\n"
> 		"	ip mptcp endpoint flush\n"
> 		"	ip mptcp limits set [ subflows NR ] [ add_addr_accepted NR ]\n"
> @@ -46,7 +47,7 @@ static int genl_family = -1;
> 	GENL_REQUEST(_req, MPTCP_BUFLEN, genl_family, 0,	\
> 		     MPTCP_PM_VER, _cmd, _flags)
>
> -#define MPTCP_PM_ADDR_FLAG_NOBACKUP 0x0
> +#define MPTCP_PM_ADDR_FLAG_NONE 0x0
>
> /* Mapping from argument to address flag mask */
> static const struct {
> @@ -57,7 +58,8 @@ static const struct {
> 	{ "subflow",		MPTCP_PM_ADDR_FLAG_SUBFLOW },
> 	{ "backup",		MPTCP_PM_ADDR_FLAG_BACKUP },
> 	{ "fullmesh",		MPTCP_PM_ADDR_FLAG_FULLMESH },
> -	{ "nobackup",		MPTCP_PM_ADDR_FLAG_NOBACKUP }
> +	{ "nobackup",		MPTCP_PM_ADDR_FLAG_NONE },
> +	{ "nofullmesh",		MPTCP_PM_ADDR_FLAG_NONE }
> };
>
> static void print_mptcp_addr_flags(unsigned int flags)
> @@ -116,9 +118,15 @@ static int mptcp_parse_opt(int argc, char **argv, struct nlmsghdr *n, int cmd)
> 	ll_init_map(&rth);
> 	while (argc > 0) {
> 		if (get_flags(*argv, &flags) == 0) {
> -			/* allow changing the 'backup' flag only */
> +			if (adding &&
> +			    (flags & MPTCP_PM_ADDR_FLAG_SIGNAL) &&
> +			    (flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
> +				invarg("invalid flags\n", *argv);
> +
> +			/* allow changing the 'backup' and 'fullmesh' flags only */
> 			if (cmd == MPTCP_PM_CMD_SET_FLAGS &&
> -			    (flags & ~MPTCP_PM_ADDR_FLAG_BACKUP))
> +			    (flags & ~(MPTCP_PM_ADDR_FLAG_BACKUP |
> +				       MPTCP_PM_ADDR_FLAG_FULLMESH)))
> 				invarg("invalid flags\n", *argv);
>
> 		} else if (matches(*argv, "id") == 0) {
> diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
> index 0e789225..bddbff3c 100644
> --- a/man/man8/ip-mptcp.8
> +++ b/man/man8/ip-mptcp.8
> @@ -41,7 +41,7 @@ ip-mptcp \- MPTCP path manager configuration
> .BR "ip mptcp endpoint change id "
> .I ID
> .RB "[ "
> -.I BACKUP-OPT
> +.I CHANGE-OPT
> .RB "] "
>
> .ti -8
> @@ -68,10 +68,14 @@ ip-mptcp \- MPTCP path manager configuration
> .RB  "]"
>
> .ti -8
> -.IR BACKUP-OPT " := ["
> +.IR CHANGE-OPT " := ["
> .B backup
> .RB "|"
> .B nobackup
> +.RB "|"
> +.B fullmesh
> +.RB "|"
> +.B nofullmesh
> .RB  "]"
>
> .ti -8
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
