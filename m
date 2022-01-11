Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1972C9C
	for <mptcp@lists.linux.dev>; Tue, 11 Jan 2022 01:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641864422; x=1673400422;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OXGZ2QEGuaYsBelkuCdBJTGDj4ky1gs8bEkpTHXDts4=;
  b=mpJR4rp0JX2HytEZ0+o+mLa8nv8/I+E/lQ7MvWFKV5skkKlup0S3FvFw
   mHdwLV0VUG6TBPdCnbHcBSDDyMz5qzdxKrQQ4oCtu2csy8CaxMRXG47U9
   SAVrSALxzC1834Xv4JKtBe0omgOmi0x5I1Vo4crcJGYyC2dqtyF68u3dW
   50ypExQVyDy/g2MjB6cSD1fgRzLc4a1Bsvgp2mZbZpfvOywznYBOIih4s
   6oS1pqbPEjh7r0SglkSFh6JzajB8ZGaBNImFThb/nO2QtBAAtg02uJe3z
   vOVKll0xXluyhnP+URg1q+jPyqnU32fGTpwkBP4AifilRLNH4sr+Uq7/M
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="240927060"
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="240927060"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 17:27:02 -0800
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="558190018"
Received: from rspencer-mobl.amr.corp.intel.com ([10.209.51.95])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 17:27:02 -0800
Date: Mon, 10 Jan 2022 17:27:01 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH iproute2-next v2] mptcp: add id check for deleting
 address
In-Reply-To: <7ea43a885391f9d5bc3fe207d1cb2168c14fcf4e.1641796124.git.geliang.tang@suse.com>
Message-ID: <7b4e14d-15f-9aa4-38ab-cee9c19ded0@linux.intel.com>
References: <7ea43a885391f9d5bc3fe207d1cb2168c14fcf4e.1641796124.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 10 Jan 2022, Geliang Tang wrote:

> This patch added the id check for deleting address in mptcp_parse_opt().
> The ADDRESS argument is invalid for the non-zero id address, only needed
> for the id 0 address.
>
> # ip mptcp endpoint delete id 1
> # ip mptcp endpoint delete id 0 10.0.1.1
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/171
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> v2:
> - rebase for iproute2-next.git
> - drop patch 2 & 3 in v1.
> - change ip-mptcp.8 too.

Thanks for updating this Geliang. The code looks good to me, and I have a 
couple suggestions for the man page below.

> ---
> ip/ipmptcp.c        | 11 +++++++++--
> man/man8/ip-mptcp.8 |  5 ++++-
> 2 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
> index 10dcb1ea..f85c49a8 100644
> --- a/ip/ipmptcp.c
> +++ b/ip/ipmptcp.c
> @@ -24,7 +24,7 @@ static void usage(void)
> 	fprintf(stderr,
> 		"Usage:	ip mptcp endpoint add ADDRESS [ dev NAME ] [ id ID ]\n"
> 		"				      [ port NR ] [ FLAG-LIST ]\n"
> -		"	ip mptcp endpoint delete id ID\n"
> +		"	ip mptcp endpoint delete id ID [ ADDRESS ]\n"
> 		"	ip mptcp endpoint change id ID [ backup | nobackup ]\n"
> 		"	ip mptcp endpoint show [ id ID ]\n"
> 		"	ip mptcp endpoint flush\n"
> @@ -103,6 +103,7 @@ static int get_flags(const char *arg, __u32 *flags)
> static int mptcp_parse_opt(int argc, char **argv, struct nlmsghdr *n, int cmd)
> {
> 	bool adding = cmd == MPTCP_PM_CMD_ADD_ADDR;
> +	bool deling = cmd == MPTCP_PM_CMD_DEL_ADDR;
> 	struct rtattr *attr_addr;
> 	bool addr_set = false;
> 	inet_prefix address;
> @@ -156,8 +157,14 @@ static int mptcp_parse_opt(int argc, char **argv, struct nlmsghdr *n, int cmd)
> 	if (!addr_set && adding)
> 		missarg("ADDRESS");
>
> -	if (!id_set && !adding)
> +	if (!id_set && deling)
> 		missarg("ID");
> +	else if (id_set && deling) {
> +		if (id && addr_set)
> +			invarg("invalid for non-zero id address\n", "ADDRESS");
> +		else if (!id && !addr_set)
> +			invarg("address is needed for deleting id 0 address\n", "ID");
> +	}
>
> 	if (port && !(flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
> 		invarg("flags must have signal when using port", "port");
> diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
> index 0e6e1532..1b8b8c7c 100644
> --- a/man/man8/ip-mptcp.8
> +++ b/man/man8/ip-mptcp.8
> @@ -31,8 +31,11 @@ ip-mptcp \- MPTCP path manager configuration
> .RB "] "
>
> .ti -8
> -.BR "ip mptcp endpoint del id "
> +.BR "ip mptcp endpoint delete id "
> .I ID
> +.RB "[ "
> +.I ADDRESS

Since the 'ip mptcp endpoint add' section above uses IFADDR instead of 
ADDRESS, it is better to use IFADDR again here.

> +.RB "] "
>
> .ti -8
> .BR "ip mptcp endpoint change id "

I suggest adding this before the ".TP\n.IR PORT" section at line 113:


.TP
.IR IFADDR
An IPv4 or IPv6 address. When used with the
.B delete id
operation, an
.B IFADDR
is only included when the
.B ID
is 0.


I also noticed a formatting bug in the existing markup, there should be a 
".TP" line just before ".IR ID" - can you add that too?


Thanks,

--
Mat Martineau
Intel
