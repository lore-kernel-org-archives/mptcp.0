Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A2B168
	for <mptcp@lists.linux.dev>; Sat,  8 Jan 2022 00:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641601099; x=1673137099;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=i19gdF7YMoILqoYykmROp6RH4BS6kmspvNl9U1kIjjk=;
  b=I7+I2dybFa7Ay7QuIGCzAZ9JFNWW37Xf5G7DiiUPZ4ds7yY+/76YxET7
   Qfi526hnRCOyM0tnSCKMvXsfnpVe1AYLYk7AWCq3dIMKbMZiZC+jx4jnd
   AsAyqbI9yIAklcBqJZS2hLHLN5iDrFTmv1tNU9/Enh/pdlZQOkiv3VNk3
   W0tx1N8QLSy8VVp6f5ey4vbLMPJEjsODUP7jjBv6pyQrdUZsOghKQLGm/
   SJKYxvQIc2CYdDUaL24CHh/hwnSd707Hr2Z3ZG/DE9/0v5IATygMdI2iL
   SlilxB/SO0O5mBYVkyHzcqsYpzv76xplNZbITTSYs7q+0UV5g0Bk/thoa
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="230307323"
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="230307323"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 16:18:18 -0800
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="557428515"
Received: from illipets-mobl.amr.corp.intel.com ([10.209.112.146])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 16:18:18 -0800
Date: Fri, 7 Jan 2022 16:18:18 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH RESEND iproute2-next 1/3] mptcp: add id check for deleting
 address
In-Reply-To: <e45ed5bcca8c7d1692562cb20c88185fb7e331ca.1641289518.git.geliang.tang@suse.com>
Message-ID: <90bfcc8a-a6bf-7933-a18-1fe3f795b95d@linux.intel.com>
References: <cover.1641289518.git.geliang.tang@suse.com> <e45ed5bcca8c7d1692562cb20c88185fb7e331ca.1641289518.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 4 Jan 2022, Geliang Tang wrote:

> This patch added the id check for deleting address in mptcp_parse_opt().
> The ADDRESS argument is invalid for the non-zero id address, only needed
> for the id 0 address.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/171
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> ip/ipmptcp.c | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
> index fd042da8..c2691ef4 100644
> --- a/ip/ipmptcp.c
> +++ b/ip/ipmptcp.c
> @@ -18,7 +18,7 @@ static void usage(void)
> 	fprintf(stderr,
> 		"Usage:	ip mptcp endpoint add ADDRESS [ dev NAME ] [ id ID ]\n"
> 		"				      [ port NR ] [ FLAG-LIST ]\n"
> -		"	ip mptcp endpoint delete id ID\n"
> +		"	ip mptcp endpoint delete id ID [ ADDRESS ]\n"

Please also update man/man8/ip-mptcp.8 for the optional ADDRESS parameter.

> 		"	ip mptcp endpoint show [ id ID ]\n"
> 		"	ip mptcp endpoint flush\n"
> 		"	ip mptcp limits set [ subflows NR ] [ add_addr_accepted NR ]\n"
> @@ -142,6 +142,12 @@ static int mptcp_parse_opt(int argc, char **argv, struct nlmsghdr *n,
>
> 	if (!id_set && !adding)
> 		missarg("ID");
> +	else if (id_set && !adding) {

I think it would be good to move the 'deling' changes (and the change to 
the last parameter of mptcp_parse_opt()) from patch 3 to this patch.

> +		if (id && addr_set)
> +			invarg("invalid for non-zero id address\n", "ADDRESS");
> +		else if (!id && !addr_set)
> +			invarg("address is needed for deleting id 0 address\n", "ID");
> +	}
>
> 	if (port && !(flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
> 		invarg("flags must have signal when using port", "port");
> -- 
> 2.31.1


--
Mat Martineau
Intel
