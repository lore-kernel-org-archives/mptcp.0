Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26072C9C
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 01:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641951136; x=1673487136;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+/LjbuFSbos+TMbclZClF7yLYBjBe0EkECNs2R6J8nc=;
  b=i1hvb3DwWGsgB26GA4SFZJ395ieqRX1A8jKkjYnntvZT59W0Rf5KnZAa
   sfrIG7qWplk1qlCQrxD5PWbiCWNsmGFE/kpXlzyMMq3UGsGHNBB2sAk0P
   oT8pgRsSvgFve+A+fWPgEI9NbL0tv03uLxipJ01MdRTz0KYJSMUvJKnoG
   dmF3Fc64OmxK9L2+MIQ8rSjNoEUZ2/9vOWA3YpTnioedblA1FvtGoNacl
   xoM3Y2Y6XJ07eZCrVPHFphU6PVBan6u4It4yO7SEJScmffFklFqXVB737
   CGBzpIJ9C7meuIAv0+FjFuYbLT+VYudbGXbyVWzT0fBWOpb32R8vuoJLy
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="243433545"
X-IronPort-AV: E=Sophos;i="5.88,281,1635231600"; 
   d="scan'208";a="243433545"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 17:32:16 -0800
X-IronPort-AV: E=Sophos;i="5.88,281,1635231600"; 
   d="scan'208";a="670002096"
Received: from tcastee-mobl.amr.corp.intel.com ([10.209.73.84])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 17:32:15 -0800
Date: Tue, 11 Jan 2022 17:32:15 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH iproute2-next v3] mptcp: add id check for deleting
 address
In-Reply-To: <b28219d0160643d91d154c1be5c7f9ef6f204f07.1641871277.git.geliang.tang@suse.com>
Message-ID: <82aba8e1-6420-2af7-338f-3ded7df4d89a@linux.intel.com>
References: <b28219d0160643d91d154c1be5c7f9ef6f204f07.1641871277.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 11 Jan 2022, Geliang Tang wrote:

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
> v3:
> - update ip-mptcp.8

Thanks for the manual page updates - looks good!

Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


>
> v2:
> - rebase for iproute2-next.git
> - drop patch 2 & 3 in v1.
> - change ip-mptcp.8 too.
> ---
> ip/ipmptcp.c        | 11 +++++++++--
> man/man8/ip-mptcp.8 | 16 +++++++++++++++-
> 2 files changed, 24 insertions(+), 3 deletions(-)
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
> index 0e6e1532..0e789225 100644
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
> +.I IFADDR
> +.RB "] "
>
> .ti -8
> .BR "ip mptcp endpoint change id "
> @@ -107,6 +110,16 @@ ip mptcp endpoint show	get existing MPTCP endpoint
> ip mptcp endpoint flush	flush all existing MPTCP endpoints
> .TE
>
> +.TP
> +.IR IFADDR
> +An IPv4 or IPv6 address. When used with the
> +.B delete id
> +operation, an
> +.B IFADDR
> +is only included when the
> +.B ID
> +is 0.
> +
> .TP
> .IR PORT
> When a port number is specified, incoming MPTCP subflows for already
> @@ -114,6 +127,7 @@ established MPTCP sockets will be accepted on the specified port, regardless
> the original listener port accepting the first MPTCP subflow and/or
> this peer being actually on the client side.
>
> +.TP
> .IR ID
> is a unique numeric identifier for the given endpoint
>
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
