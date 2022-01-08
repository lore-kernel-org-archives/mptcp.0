Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D372C9C
	for <mptcp@lists.linux.dev>; Sat,  8 Jan 2022 00:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641602190; x=1673138190;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bNeBNT6JvqVZmQGmWvQaG92Kgp7k2IiptYSi/5YgKzc=;
  b=PYRaNYtprb2vyuQpgafFtSABNpIgzPJXPal0jgRdni5oxia/98xKK9hQ
   b7U9GfN4LeSJ2kscr42IAUo176T1RgZc0RXpT+2OL332ZYqIQ/zk7uMXV
   4htO7EScku/tzJ0sP6q+I+4nYzP6c/jCJnq716cgR9D/qKAYaxCj2T/M2
   D7xje0ca01TZBFk+yrs0w39d48m6UAHyR2x0tMhKbF5GPT2GiazCI3ele
   QqDwbJu/eOI7Xlr84W2mFifk/HJzCBa7X1NVuQy66L5WsFpbyLUb9Ism2
   aRhqx42AwU2EEARPWCBqlEdBvjecH9Ph2F9y0Aknsm83SM6/dPnuCxZPN
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="306332088"
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="306332088"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 16:36:30 -0800
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="489451672"
Received: from illipets-mobl.amr.corp.intel.com ([10.209.112.146])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 16:36:29 -0800
Date: Fri, 7 Jan 2022 16:36:29 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH iproute2-next 3/3] mptcp: add the backup flag setting
In-Reply-To: <faee44620e111eea4205105974c994a5e8ef5683.1641289518.git.geliang.tang@suse.com>
Message-ID: <e422b8c-1ecb-4f31-ba7-c3f8996444d2@linux.intel.com>
References: <cover.1641289518.git.geliang.tang@suse.com> <faee44620e111eea4205105974c994a5e8ef5683.1641289518.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 4 Jan 2022, Geliang Tang wrote:

> The address flag backup setting had been added into pm_nl_ctl.c in commit
> 6e8b244a3e9d ("selftests: mptcp: add set_flags command in pm_nl_ctl"). This
> patch added it to 'ip mptcp' too.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> include/uapi/linux/mptcp.h |  2 ++
> ip/ipmptcp.c               | 22 +++++++++++++++++-----
> 2 files changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index 957743ce..2b76e526 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -75,6 +75,8 @@ enum {
> #define MPTCP_PM_ADDR_FLAG_BACKUP			(1 << 2)
> #define MPTCP_PM_ADDR_FLAG_FULLMESH			(1 << 3)
>
> +#define MPTCP_PM_ADDR_FLAG_MAX				(1 << 8)
> +
> enum {
> 	MPTCP_PM_CMD_UNSPEC,
>
> diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
> index 8c4fd18c..fc1fd5ce 100644
> --- a/ip/ipmptcp.c
> +++ b/ip/ipmptcp.c
> @@ -19,6 +19,7 @@ static void usage(void)
> 		"Usage:	ip mptcp endpoint add ADDRESS [ dev NAME ] [ id ID ]\n"
> 		"				      [ port NR ] [ FLAG-LIST ]\n"
> 		"	ip mptcp endpoint delete id ID [ ADDRESS ]\n"
> +		"	ip mptcp endpoint set ADDRESS [ backup | nobackup ]"

Like patch 1, please update the man page too.

> 		"	ip mptcp endpoint show [ id ID ]\n"
> 		"	ip mptcp endpoint flush\n"
> 		"	ip mptcp limits set [ subflows NR ] [ add_addr_accepted NR ]\n"
> @@ -47,6 +48,7 @@ static const struct {
> 	{ "signal",		MPTCP_PM_ADDR_FLAG_SIGNAL },
> 	{ "subflow",		MPTCP_PM_ADDR_FLAG_SUBFLOW },
> 	{ "backup",		MPTCP_PM_ADDR_FLAG_BACKUP },
> +	{ "nobackup",		MPTCP_PM_ADDR_FLAG_MAX },

Since MPTCP_PM_ADDR_FLAG_MAX is 0x100, and the flags attribute in the 
netlink command is 32 bits wide, this ends up setting a bit and sending it 
to the kernel. While that bit isn't used right now, it could be in a 
future kernel version - and this approach to implementing 'nobackup' could 
have unexpected effects. Could you try a different way of implementing 
this that doesn't have a side effect?


- Mat


> 	{ "fullmesh",		MPTCP_PM_ADDR_FLAG_FULLMESH },
> };
>
> @@ -91,17 +93,24 @@ static int get_flags(const char *arg, __u32 *flags)
> }
>
> static int mptcp_parse_opt(int argc, char **argv, struct nlmsghdr *n,
> -			 bool adding)
> +			 int cmd)
> {
> 	struct rtattr *attr_addr;
> 	bool addr_set = false;
> 	inet_prefix address;
> 	bool id_set = false;
> +	bool adding = 0;
> +	bool deling = 0;
> 	__u32 index = 0;
> 	__u32 flags = 0;
> 	__u16 port = 0;
> 	__u8 id = 0;
>
> +	if (cmd == MPTCP_PM_CMD_ADD_ADDR)
> +		adding = 1;
> +	else if (cmd == MPTCP_PM_CMD_DEL_ADDR)
> +		deling = 1;
> +
> 	ll_init_map(&rth);
> 	while (argc > 0) {
> 		if (get_flags(*argv, &flags) == 0) {
> @@ -141,9 +150,9 @@ static int mptcp_parse_opt(int argc, char **argv, struct nlmsghdr *n,
> 	if (!addr_set && adding)
> 		missarg("ADDRESS");
>
> -	if (!id_set && !adding)
> +	if (!id_set && deling)
> 		missarg("ID");
> -	else if (id_set && !adding) {
> +	else if (id_set && deling) {
> 		if (id && addr_set)
> 			invarg("invalid for non-zero id address\n", "ADDRESS");
> 		else if (!id && !addr_set)
> @@ -183,7 +192,7 @@ static int mptcp_addr_modify(int argc, char **argv, int cmd)
> 	MPTCP_REQUEST(req, cmd, NLM_F_REQUEST);
> 	int ret;
>
> -	ret = mptcp_parse_opt(argc, argv, &req.n, cmd == MPTCP_PM_CMD_ADD_ADDR);
> +	ret = mptcp_parse_opt(argc, argv, &req.n, cmd);
> 	if (ret)
> 		return ret;
>
> @@ -299,7 +308,7 @@ static int mptcp_addr_show(int argc, char **argv)
> 	if (argc <= 0)
> 		return mptcp_addr_dump();
>
> -	ret = mptcp_parse_opt(argc, argv, &req.n, false);
> +	ret = mptcp_parse_opt(argc, argv, &req.n, MPTCP_PM_CMD_DEL_ADDR);
> 	if (ret)
> 		return ret;
>
> @@ -534,6 +543,9 @@ int do_mptcp(int argc, char **argv)
> 		if (matches(*argv, "delete") == 0)
> 			return mptcp_addr_modify(argc-1, argv+1,
> 						 MPTCP_PM_CMD_DEL_ADDR);
> +		if (matches(*argv, "set") == 0)
> +			return mptcp_addr_modify(argc-1, argv+1,
> +						 MPTCP_PM_CMD_SET_FLAGS);
> 		if (matches(*argv, "show") == 0)
> 			return mptcp_addr_show(argc-1, argv+1);
> 		if (matches(*argv, "flush") == 0)
> -- 
> 2.31.1
>

--
Mat Martineau
Intel
