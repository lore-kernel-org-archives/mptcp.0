Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D59C2C9C
	for <mptcp@lists.linux.dev>; Sat, 22 Jan 2022 01:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642813393; x=1674349393;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YHtFjA8FQO7BufZyx6qA73ckWLjl79S/eNdk+qkxhLM=;
  b=bfhMq4N7WR6a/vO3ADROF74n+8ED/YGAwoL9mofTjhFW1T4pun2D2/OA
   6uaTSXhmJhTr7WRs3gwfM8XxJVFq+gNbHk5R/zMnWaLCd6MufTxHhD+f+
   4T2Cu6rMBOyX6ZbqwUAPsNo7ElDQR3CSjyftTSSEfP0LPk3RBeUvpXdny
   zE0uh+OA9iamrxwC83lYgED+IO6e+IRerFTqAypMzQ/kmryp4dUA2s/0z
   vSuEpr9hjNXqFB2pAyJQl2fTrqBHrV6MTrlfwOPlCTcxBeyoo5amqcpLm
   nKqu0w1Knk9cFpS7A7ncP2Th0+D1nxNqX5ixsC/ONtJsqmVy39jYMf2JT
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="309101246"
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="309101246"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 17:03:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="626915529"
Received: from hma4-mobl2.amr.corp.intel.com ([10.212.239.251])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 17:03:12 -0800
Date: Fri, 21 Jan 2022 17:03:12 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH iproute2-next v7] mptcp: add the fullmesh flag setting
 support
In-Reply-To: <1a295b3d53f3da82e8c47173fded5e679a25345d.1642748699.git.geliang.tang@suse.com>
Message-ID: <6b67e296-4ef4-d48e-d4a-e6dc97c9b330@linux.intel.com>
References: <1a295b3d53f3da82e8c47173fded5e679a25345d.1642748699.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 21 Jan 2022, Geliang Tang wrote:

> This patch added the fullmesh flag setting support, use it like this:
>
> ip mptcp endpoint change id 1 fullmesh
> ip mptcp endpoint change id 1 nofullmesh
> ip mptcp endpoint change id 1 backup fullmesh
> ip mptcp endpoint change id 1 nobackup nofullmesh
>
> Add the fullmesh flag check for the adding address, the fullmesh flag
> can't be used with the signal flag in that case.
>
> Update the port keyword check for the setting flags, allow to use the
> port keyword with the non-signal flags. Don't allow to use the port
> keyword with the id number.
>
> Update the usage of 'ip mptcp endpoint change', it can be used in two
> forms, using the address directly or the id number of the address:
>
> ip mptcp endpoint change id 1 fullmesh
> ip mptcp endpoint change 10.0.2.1 fullmesh
> ip mptcp endpoint change 10.0.2.1 port 10100 fullmesh
>
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> v7:
> - allow to use the port keyword with the non-signal flags for the
>   setting flags, then we can use the address argument for "ip mptcp
>   endpoint change" too.
> - update the usage and man-page.

The v6->v7 changes look good, but both versions of the patch only apply to 
the iproute2 repo, not iproute2-next. Please rebase on iproute2-next 
before sending to netdev.

-Mat

>
> v6:
> - update the flags check as Mat suggested.
>
> v5:
> - support to set backup and fullmesh flags together.
> ---
> ip/ipmptcp.c        | 26 +++++++++++++++++++-------
> man/man8/ip-mptcp.8 | 17 ++++++++++++-----
> 2 files changed, 31 insertions(+), 12 deletions(-)
>
> diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
> index eef7c6f4..efda7ef2 100644
> --- a/ip/ipmptcp.c
> +++ b/ip/ipmptcp.c
> @@ -25,14 +25,15 @@ static void usage(void)
> 		"Usage:	ip mptcp endpoint add ADDRESS [ dev NAME ] [ id ID ]\n"
> 		"				      [ port NR ] [ FLAG-LIST ]\n"
> 		"	ip mptcp endpoint delete id ID [ ADDRESS ]\n"
> -		"	ip mptcp endpoint change id ID [ backup | nobackup ]\n"
> +		"	ip mptcp endpoint change [ id ID ] [ ADDRESS ] CHANGE-OPT\n"
> 		"	ip mptcp endpoint show [ id ID ]\n"
> 		"	ip mptcp endpoint flush\n"
> 		"	ip mptcp limits set [ subflows NR ] [ add_addr_accepted NR ]\n"
> 		"	ip mptcp limits show\n"
> 		"	ip mptcp monitor\n"
> 		"FLAG-LIST := [ FLAG-LIST ] FLAG\n"
> -		"FLAG  := [ signal | subflow | backup | fullmesh ]\n");
> +		"FLAG  := [ signal | subflow | backup | fullmesh ]\n"
> +		"CHANGE-OPT := [ backup | nobackup | fullmesh | nofullmesh ]\n");
>
> 	exit(-1);
> }
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
> @@ -102,6 +104,7 @@ static int get_flags(const char *arg, __u32 *flags)
>
> static int mptcp_parse_opt(int argc, char **argv, struct nlmsghdr *n, int cmd)
> {
> +	bool setting = cmd == MPTCP_PM_CMD_SET_FLAGS;
> 	bool adding = cmd == MPTCP_PM_CMD_ADD_ADDR;
> 	bool deling = cmd == MPTCP_PM_CMD_DEL_ADDR;
> 	struct rtattr *attr_addr;
> @@ -116,9 +119,15 @@ static int mptcp_parse_opt(int argc, char **argv, struct nlmsghdr *n, int cmd)
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
> @@ -166,9 +175,12 @@ static int mptcp_parse_opt(int argc, char **argv, struct nlmsghdr *n, int cmd)
> 			invarg("address is needed for deleting id 0 address\n", "ID");
> 	}
>
> -	if (port && !(flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
> +	if (adding && port && !(flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
> 		invarg("flags must have signal when using port", "port");
>
> +	if (id_set && setting && port)
> +		invarg("port can't be used with id", "port");
> +
> 	attr_addr = addattr_nest(n, MPTCP_BUFLEN,
> 				 MPTCP_PM_ATTR_ADDR | NLA_F_NESTED);
> 	if (id_set)
> diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
> index 0e789225..72762f49 100644
> --- a/man/man8/ip-mptcp.8
> +++ b/man/man8/ip-mptcp.8
> @@ -38,11 +38,14 @@ ip-mptcp \- MPTCP path manager configuration
> .RB "] "
>
> .ti -8
> -.BR "ip mptcp endpoint change id "
> +.BR "ip mptcp endpoint change "
> +.RB "[ " id
> .I ID
> -.RB "[ "
> -.I BACKUP-OPT
> -.RB "] "
> +.RB "] [ "
> +.IR IFADDR
> +.RB "] [ " port
> +.IR PORT " ]"
> +.RB "CHANGE-OPT"
>
> .ti -8
> .BR "ip mptcp endpoint show "
> @@ -68,10 +71,14 @@ ip-mptcp \- MPTCP path manager configuration
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
