Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B792C80
	for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 23:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642117486; x=1673653486;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2R2br+hnPvwC6jFjgDUwqlv1o96HhlDnbQwtLlmOdek=;
  b=WF2wLMyaBKjmC99XpOsfUIx4ySZxGGYVeGFUJd2sRKlvVRcqinLOFAbx
   +/h/6oAem0c7FmUcOKKVgzpdMYW7LXWM8uRhK2MCCj2RUxfW7v6vZ3kx5
   AvkNeiFZgWEy4FvhY2wbOwTQzBo9nC3SO0nJcLN0ws+wjAR+QGb9+ZKdY
   a2nQbgXFT+xI2KygTHq0TH47ozmOImZoA+h7a9yh9+bSI/WTvsy4XU40g
   HJ7gZmEmDJD9CW4zMBkIDqTuTyL0xboSTbzUkkn6dMju/RI1+A1NioI7h
   xOcp5CKFqFiPtd1dHN3PApamZidzO1axBHcjJjwujk8ymvphxAU51X3Pu
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="231487786"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="231487786"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 15:44:43 -0800
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="691990459"
Received: from pialybar-mobl.amr.corp.intel.com ([10.212.252.249])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 15:44:43 -0800
Date: Thu, 13 Jan 2022 15:44:42 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH iproute-next v4 4/4] mptcp: add the fullmesh flag setting
 support
In-Reply-To: <743abd8f6b8311bd0f5747980982b511299e3453.1641979131.git.geliang.tang@suse.com>
Message-ID: <b48ac912-ec4f-5be1-b74d-552a4d704e@linux.intel.com>
References: <cover.1641978967.git.geliang.tang@suse.com> <743abd8f6b8311bd0f5747980982b511299e3453.1641979131.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 12 Jan 2022, Geliang Tang wrote:

> This patch added the fullmesh flag setting support.
>
> ip mptcp endpoint change id 1 fullmesh
> ip mptcp endpoint change id 1 nofullmesh
>
> Added the fullmesh flag check for the adding address too.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> v4:
> - put into 'fullmesh flag setting support' serirs.
> - No code changed.
>

The patch looks good to me:

Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


For future patches that might involve more than one repository, it is 
helpful to group them in a separate series for each repository (for 
example, posting separately for this patch and the previous 3 mptcp-next 
patches). Noting the dependencies in the cover letters or notes section 
of the commit message is very helpful, thanks for doing that. Keeping the 
series separated helps with using tools like patchew and b4.

Thanks!

-Mat

> v2:
> - drop MPTCP_PM_ADDR_FLAG_NOFULLMESH.
> - rename MPTCP_PM_ADDR_FLAG_NOBACKUP to MPTCP_PM_ADDR_FLAG_NONE.
> - Needs to apply the patch "mptcp: add id check for deleting address"
> first.
> ---
> ip/ipmptcp.c        | 16 ++++++++++++----
> man/man8/ip-mptcp.8 |  8 ++++++--
> 2 files changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
> index f85c49a8..564500a8 100644
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
> +			if (adding &&
> +			    (flags & MPTCP_PM_ADDR_FLAG_SIGNAL) &&
> +			    (flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
> +				invarg("invalid flags\n", *argv);
> +
> 			/* allow changing the 'backup' flag only */
> 			if (cmd == MPTCP_PM_CMD_SET_FLAGS &&
> -			    (flags & ~MPTCP_PM_ADDR_FLAG_BACKUP))
> +			    (flags & ~MPTCP_PM_ADDR_FLAG_BACKUP) &&
> +			    (flags & ~MPTCP_PM_ADDR_FLAG_FULLMESH))
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
