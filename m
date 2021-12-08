Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824B02CA6
	for <mptcp@lists.linux.dev>; Wed,  8 Dec 2021 01:59:38 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="237964206"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="237964206"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 17:59:36 -0800
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="543042224"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2) ([10.212.226.172])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 17:59:36 -0800
Date: Tue, 7 Dec 2021 17:59:36 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH iproute2-next] mptcp: add support for changing the backup
 flag
In-Reply-To: <cb2ddffb2211d6fdde7a8bf81879a3a83c620f00.1638542999.git.dcaratti@redhat.com>
Message-ID: <8a517-d825-f27c-1fe4-4dceae4fd2d7@linux.intel.com>
References: <cb2ddffb2211d6fdde7a8bf81879a3a83c620f00.1638542999.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 3 Dec 2021, Davide Caratti wrote:

> Linux supports 'MPTCP_PM_CMD_SET_FLAGS' since v5.12, and this control has
> recently been extended to allow setting flags for a given endpoint id.
> Although there is no use for changing 'signal' or 'subflow' flags, it can
> be helpful to set/clear the backup bit on existing endpoints: add the 'ip
> mptcp endpoint change <...>' command for this purpose.
>
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/158
> Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Matthieu -

Since you already Acked, what should be the status of this in patchwork?


-Mat



> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
> ip/ipmptcp.c        | 20 ++++++++++++++++----
> man/man8/ip-mptcp.8 | 14 ++++++++++++++
> 2 files changed, 30 insertions(+), 4 deletions(-)
>
> diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
> index 857004446aa3..7fb48a420a6b 100644
> --- a/ip/ipmptcp.c
> +++ b/ip/ipmptcp.c
> @@ -25,6 +25,7 @@ static void usage(void)
> 		"Usage:	ip mptcp endpoint add ADDRESS [ dev NAME ] [ id ID ]\n"
> 		"				      [ port NR ] [ FLAG-LIST ]\n"
> 		"	ip mptcp endpoint delete id ID\n"
> +		"	ip mptcp endpoint change id ID [ backup | nobackup ]\n"
> 		"	ip mptcp endpoint show [ id ID ]\n"
> 		"	ip mptcp endpoint flush\n"
> 		"	ip mptcp limits set [ subflows NR ] [ add_addr_accepted NR ]\n"
> @@ -45,6 +46,8 @@ static int genl_family = -1;
> 	GENL_REQUEST(_req, MPTCP_BUFLEN, genl_family, 0,	\
> 		     MPTCP_PM_VER, _cmd, _flags)
>
> +#define MPTCP_PM_ADDR_FLAG_NOBACKUP 0x0
> +
> /* Mapping from argument to address flag mask */
> static const struct {
> 	const char *name;
> @@ -53,6 +56,7 @@ static const struct {
> 	{ "signal",		MPTCP_PM_ADDR_FLAG_SIGNAL },
> 	{ "subflow",		MPTCP_PM_ADDR_FLAG_SUBFLOW },
> 	{ "backup",		MPTCP_PM_ADDR_FLAG_BACKUP },
> +	{ "nobackup",		MPTCP_PM_ADDR_FLAG_NOBACKUP }
> };
>
> static void print_mptcp_addr_flags(unsigned int flags)
> @@ -95,9 +99,9 @@ static int get_flags(const char *arg, __u32 *flags)
> 	return -1;
> }
>
> -static int mptcp_parse_opt(int argc, char **argv, struct nlmsghdr *n,
> -			 bool adding)
> +static int mptcp_parse_opt(int argc, char **argv, struct nlmsghdr *n, int cmd)
> {
> +	bool adding = cmd == MPTCP_PM_CMD_ADD_ADDR;
> 	struct rtattr *attr_addr;
> 	bool addr_set = false;
> 	inet_prefix address;
> @@ -110,6 +114,11 @@ static int mptcp_parse_opt(int argc, char **argv, struct nlmsghdr *n,
> 	ll_init_map(&rth);
> 	while (argc > 0) {
> 		if (get_flags(*argv, &flags) == 0) {
> +			/* allow changing the 'backup' flag only */
> +			if (cmd == MPTCP_PM_CMD_SET_FLAGS &&
> +			    (flags & ~MPTCP_PM_ADDR_FLAG_BACKUP))
> +				invarg("invalid flags\n", *argv);
> +
> 		} else if (matches(*argv, "id") == 0) {
> 			NEXT_ARG();
>
> @@ -182,7 +191,7 @@ static int mptcp_addr_modify(int argc, char **argv, int cmd)
> 	MPTCP_REQUEST(req, cmd, NLM_F_REQUEST);
> 	int ret;
>
> -	ret = mptcp_parse_opt(argc, argv, &req.n, cmd == MPTCP_PM_CMD_ADD_ADDR);
> +	ret = mptcp_parse_opt(argc, argv, &req.n, cmd);
> 	if (ret)
> 		return ret;
>
> @@ -298,7 +307,7 @@ static int mptcp_addr_show(int argc, char **argv)
> 	if (argc <= 0)
> 		return mptcp_addr_dump();
>
> -	ret = mptcp_parse_opt(argc, argv, &req.n, false);
> +	ret = mptcp_parse_opt(argc, argv, &req.n, MPTCP_PM_CMD_GET_ADDR);
> 	if (ret)
> 		return ret;
>
> @@ -534,6 +543,9 @@ int do_mptcp(int argc, char **argv)
> 		if (matches(*argv, "add") == 0)
> 			return mptcp_addr_modify(argc-1, argv+1,
> 						 MPTCP_PM_CMD_ADD_ADDR);
> +		if (matches(*argv, "change") == 0)
> +			return mptcp_addr_modify(argc-1, argv+1,
> +						 MPTCP_PM_CMD_SET_FLAGS);
> 		if (matches(*argv, "delete") == 0)
> 			return mptcp_addr_modify(argc-1, argv+1,
> 						 MPTCP_PM_CMD_DEL_ADDR);
> diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
> index 22335b6129ae..574cb60dc7c0 100644
> --- a/man/man8/ip-mptcp.8
> +++ b/man/man8/ip-mptcp.8
> @@ -34,6 +34,13 @@ ip-mptcp \- MPTCP path manager configuration
> .BR "ip mptcp endpoint del id "
> .I ID
>
> +.ti -8
> +.BR "ip mptcp endpoint change id "
> +.I ID
> +.RB "[ "
> +.I BACKUP-OPT
> +.RB "] "
> +
> .ti -8
> .BR "ip mptcp endpoint show "
> .RB "[ " id
> @@ -55,6 +62,13 @@ ip-mptcp \- MPTCP path manager configuration
> .B backup
> .RB  "]"
>
> +.ti -8
> +.IR BACKUP-OPT " := ["
> +.B backup
> +.RB "|"
> +.B nobackup
> +.RB  "]"
> +
> .ti -8
> .BR "ip mptcp limits set "
> .RB "[ "
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
