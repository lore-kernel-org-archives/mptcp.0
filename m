Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0A764E
	for <mptcp@lists.linux.dev>; Wed, 23 Feb 2022 01:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645579420; x=1677115420;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=37a+WMpIbMF+BL9FjO1zr/Q3ca5bnzXzdD8F5Y92s+I=;
  b=WIt1LLxqUKiPQujogCNpMT80AG3Lb4BlHjbpwEqBNi4Izes90BSauWFg
   1c+8ZtV1wqDXRFi3Gv6MziW6JsephTucAGGl8cem8x+U95RxDqWhZKDxI
   wwIhmnJW/3JyT/AM54g/nNRlJo5HOiazsnLY46obYBB5OmIbIj+C+o7I1
   WbIoHZHDGnFGuqCGZaCMAvvDe+tu7uRCmgcy3NqGeR0hZzwaNOvcynf0n
   mEtXgfPMokwNKXgG1JHDVwN+DOK7QIyx6Rvq1ZG0iiT/piP5vpqf944uQ
   OnGL8h5nTMQchjG8fOaziupH3gKPR2yxrRpiraaAsZeWB/fAOrQjUfeeR
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="231830818"
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="231830818"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 17:23:40 -0800
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="591523219"
Received: from fdwikusu-mobl.amr.corp.intel.com ([10.251.6.85])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 17:23:39 -0800
Date: Tue, 22 Feb 2022 17:23:39 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH iproute2-next v2 2/3] mptcp: add fullmesh support for
 setting flags
In-Reply-To: <5747de1784ce159db98fd81fa825c451fa0c5dcf.1645422873.git.geliang.tang@suse.com>
Message-ID: <71fbda79-bbab-c45-6f99-ea7b984676cb@linux.intel.com>
References: <cover.1645422873.git.geliang.tang@suse.com> <5747de1784ce159db98fd81fa825c451fa0c5dcf.1645422873.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 21 Feb 2022, Geliang Tang wrote:

> A pair of new flags, fullmesh and nofullmesh, had been added in the
> setting flags of MPTCP PM netlink in kernel space recently by the commit
> 73c762c1f07d ("mptcp: set fullmesh flag in pm_netlink").
>
> This patch added the corresponding logic to pass these two flags to the
> netlink in user space.
>
> These new flags can be used like this:
>
> ip mptcp endpoint change id 1 fullmesh
> ip mptcp endpoint change id 1 nofullmesh
> ip mptcp endpoint change id 1 backup fullmesh
> ip mptcp endpoint change id 1 nobackup nofullmesh
>

I suggest you add an example here in the commit message that includes 'ip 
mptcp endpoint show' and mention that it already supports showing the 
'fullmesh' flag. I think that's what Stephan was asking about on netdev.

Other than that, the series looks good. Thanks.


Mat


> Acked-by: Paolo Abeni <pabeni@redhat.com>
> Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> ip/ipmptcp.c        | 18 +++++++++++-------
> man/man8/ip-mptcp.8 |  8 ++++++--
> 2 files changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
> index 0b744720..247d1caf 100644
> --- a/ip/ipmptcp.c
> +++ b/ip/ipmptcp.c
> @@ -25,14 +25,15 @@ static void usage(void)
> 		"Usage:	ip mptcp endpoint add ADDRESS [ dev NAME ] [ id ID ]\n"
> 		"				      [ port NR ] [ FLAG-LIST ]\n"
> 		"	ip mptcp endpoint delete id ID [ ADDRESS ]\n"
> -		"	ip mptcp endpoint change id ID [ backup | nobackup ]\n"
> +		"	ip mptcp endpoint change id ID CHANGE-OPT\n"
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
> @@ -121,9 +124,10 @@ static int mptcp_parse_opt(int argc, char **argv, struct nlmsghdr *n, int cmd)
> 			    (flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
> 				invarg("invalid flags\n", *argv);
>
> -			/* allow changing the 'backup' flag only */
> -			if (cmd == MPTCP_PM_CMD_SET_FLAGS &&
> -			    (flags & ~MPTCP_PM_ADDR_FLAG_BACKUP))
> +			/* allow changing the 'backup' and 'fullmesh' flags only */
> +			if (setting &&
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
> 2.34.1
>
>

--
Mat Martineau
Intel
