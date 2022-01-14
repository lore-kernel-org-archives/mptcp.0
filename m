Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17D62C80
	for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 23:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642201501; x=1673737501;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5Kasiy2aqLDi00JjVdmRkCdeUqqvLBb6C47RlHsD8Ho=;
  b=DR758ss7Zzj2PMUZzWlvwCqBQ7KNZWtXxsLGcZ2TaVp/Ds0ucs5vy3cp
   zSEvjmoVZe1ntT4+33gpzr3GoXC0yShMRgF2Nix/6RAmTEwUeGPKDEfWG
   wZOJGQ7QHuhKezXnP6+OWfSdRxfx+g+EVLHTLzbLPnRARnIDcv0pSwZ26
   PekarFbtWepz1DhOFsnr0NsFUA9ck/VLKUm7lxs2HWTk2NnLFxe39gNFG
   xIG/d48mp3ILvyGwY69ST7m0WT2ewhsJ274If2ZKf1rdChERgjDiOfoJ6
   u0XIu/+q9LS2nsSaK+gjP3pV+YLlJNU20miCz30V80MMH1yawxOYGyjSd
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="268714405"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="268714405"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 15:05:00 -0800
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="621153900"
Received: from shajisur-mobl.amr.corp.intel.com ([10.209.76.214])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 15:05:00 -0800
Date: Fri, 14 Jan 2022 15:04:59 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH iproute2-next v5] mptcp: add the fullmesh flag setting
 support
In-Reply-To: <9c1f1e6a704143e0d14c62dff09fc918ce1f218f.1642155488.git.geliang.tang@suse.com>
Message-ID: <c4afb6ec-1acc-417f-d25-7c3e68178a6a@linux.intel.com>
References: <9c1f1e6a704143e0d14c62dff09fc918ce1f218f.1642155488.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 14 Jan 2022, Geliang Tang wrote:

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
> v5:
> - support to set backup and fullmesh flags together.
> ---
> ip/ipmptcp.c        | 17 ++++++++++++-----
> man/man8/ip-mptcp.8 |  8 ++++++--
> 2 files changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
> index f85c49a8..23f15219 100644
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
> @@ -116,9 +118,14 @@ static int mptcp_parse_opt(int argc, char **argv, struct nlmsghdr *n, int cmd)
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
> +			    (flags & ~MPTCP_PM_ADDR_FLAG_BACKUP & ~MPTCP_PM_ADDR_FLAG_FULLMESH))

I think it's more common & readable to write this as

(flags & ~(MPTCP_PM_ADDR_FLAG_BACKUP | MPTCP_PM_ADDR_FLAG_FULLMESH))

Even though the compiled code probably ends up the same after collapsing 
the constants.

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
