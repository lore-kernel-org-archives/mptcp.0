Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB82173
	for <mptcp@lists.linux.dev>; Tue, 25 Jan 2022 01:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643073662; x=1674609662;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WP5fe2gmXaqRk5NOHiH4Y68TnLCdGV4aRIWVxdrEYQI=;
  b=lTZ9W/juEdESg6qqyu3RyJPLdF5ES5hw3jItiiVCCqeja3+LHa3lbytX
   t7W4F8UfaLjJ28UpJEAAPhx3TwgK9n6w3QH29oGVzVtxOZEeJZ33I7qbq
   EWhJoaQX5PdWkuz3rBcs798olkkB0/5CXDH2IdtwsQOJ22cqOg/4dJfw/
   VlgtMJtrs4gTjdI4NafOlODmF1B86wFI/H7CRh7DsFIkYWYtHSSCe5Hr/
   g2r5SidNPS0m9+CiVe5TagENsSE6TWMvhh0pDqgIDp3RTXRSpSIffcf4/
   2wuAP3wwPCoMFADFczJO3LS8IUOP8HY3o0MFylfx/VrA7ExRFRR9ZFXDQ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="332545206"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="332545206"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 17:21:01 -0800
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="534500867"
Received: from nchakrav-mobl1.amr.corp.intel.com ([10.209.84.166])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 17:21:01 -0800
Date: Mon, 24 Jan 2022 17:21:01 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net 1/2] mptcp: mptcp_parse_option is no longer
 exported
In-Reply-To: <20220122093135.4023846-2-matthieu.baerts@tessares.net>
Message-ID: <a1bf984-f037-21e6-92f0-d89fc15d761f@linux.intel.com>
References: <20220122093135.4023846-1-matthieu.baerts@tessares.net> <20220122093135.4023846-2-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Sat, 22 Jan 2022, Matthieu Baerts wrote:

> Options parsing in now done from mptcp_incoming_options().
>
> mptcp_parse_option() has been removed from mptcp.h when CONFIG_MPTCP is
> defined but not when it is not.
>
> Fixes: cfde141ea3fa ("mptcp: move option parsing into mptcp_incoming_options()")
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> include/net/mptcp.h | 6 ------
> 1 file changed, 6 deletions(-)
>

Looks good to me, but it seems more like a net-next cleanup patch. When 
building without CONFIG_MPTCP I don't see mptcp_parse_option showing up as 
a symbol in the files that include mptcp.h.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 04f53352a1c9..8b1afd6f5cc4 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -218,12 +218,6 @@ static inline bool rsk_drop_req(const struct request_sock *req)
> 	return false;
> }
>
> -static inline void mptcp_parse_option(const struct sk_buff *skb,
> -				      const unsigned char *ptr, int opsize,
> -				      struct tcp_options_received *opt_rx)
> -{
> -}
> -
> static inline bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
> 				     unsigned int *size,
> 				     struct mptcp_out_options *opts)
> -- 
> 2.33.1
>
>
>

--
Mat Martineau
Intel
