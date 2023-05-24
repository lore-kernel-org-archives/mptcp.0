Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCB219526
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 15:19:58 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3f606912ebaso12595415e9.3
        for <mptcp@lists.linux.dev>; Wed, 24 May 2023 08:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684941596; x=1687533596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2dJRExnOaAKCY/4+SpzGf5cyq3nQT4IqA9RRaTKT9go=;
        b=bfexF6QkUmAukE2PZhy9HS5AJ4nvJa0/eJEh69FZVjo+QSjC6CZr10eSPrSRYvtWTY
         a60IYYOoyUMbGdf0ZOUTxycNtaJebolTkPIxWgDVUvqLAFPjCC6OH3yDaCydnXNWXTxM
         fogdeoaQgC01eB7Kby4T/QH1InFuAcAYhBkBjiglLPkI7CB6/N39+dsqH37o+jfLHq0a
         x01cWyIT9Wib8rbw5UWpkPZAoHHCbd+wgF1TOPmAtV3F9bopPizuerOQY2GE0hv0RkOb
         IGVy5f7cPha7TMityp3axHFGeMs7NQ1kyADUDa4F5T6djGvLGoiiUNGNY9+hbWx1uITD
         nQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684941596; x=1687533596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2dJRExnOaAKCY/4+SpzGf5cyq3nQT4IqA9RRaTKT9go=;
        b=C2ZlGKuig+HzL+t9pkiBZq2X8/uUDdnAJx/5sH71evi3abJKGQ4vJByfsLhw1Gchzn
         WzZIbB+IdHa2mFwZ7Dnqy5B3AM54uXdLKRx8UtZPmTVArr+IP3G5ppq6Kt2WOy2uoiIS
         c9qKjWd3joQheOzqipSJVK4xLOM35Ir7h3VSPV1xoL9cSjqbCsJRtcKUJekL4BRTxPmx
         lQ0r1RgGzBAOu28vVWktV/inht2MNGBQRBpqUE/sIoH4H2fEXxQnqBSAp+3sIGQ7JNBB
         5LXHkcEtyq/JJGSm+9VphRos2L1HN1jzW/AS1ZqT2wQp7unf/fHNYiIScOF+CBP0x6ia
         fA4g==
X-Gm-Message-State: AC+VfDzGq3jiaZIxJC3W6fOXOU8+w8RvMR9l6BermS3hsyXEjFbI9TCd
	+hNtZfdu2P2JfOdqxZA0G4Vsj0ieC3OzU4TxKcPtSQ==
X-Google-Smtp-Source: ACHHUZ45nIrkQduJUlqgJH3BJRg81910g2xKbT7qbdtkvA0oMZ+TWGzJ35GsdCpJik8xmvMUXSHSVA==
X-Received: by 2002:a7b:cbd2:0:b0:3f6:e42:8f85 with SMTP id n18-20020a7bcbd2000000b003f60e428f85mr66940wmi.37.1684941596436;
        Wed, 24 May 2023 08:19:56 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f96c:b035:8e06:9e3c? ([2a02:578:8593:1200:f96c:b035:8e06:9e3c])
        by smtp.gmail.com with ESMTPSA id u5-20020a05600c00c500b003f0ad8d1c69sm2646742wmm.25.2023.05.24.08.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 08:19:56 -0700 (PDT)
Message-ID: <20967983-bba3-b843-70af-73ad44a441d7@tessares.net>
Date: Wed, 24 May 2023 17:19:55 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 mptcp-next 2/6] mptcp: introduce MPTCP_FULL_INFO
 getsockopt
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
References: <cover.1684935727.git.pabeni@redhat.com>
 <72ebf53600698f09b96900f8b3fbd2d4c1261b6c.1684935727.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <72ebf53600698f09b96900f8b3fbd2d4c1261b6c.1684935727.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 24/05/2023 15:50, Paolo Abeni wrote:
> Some user-space applications want to monitor the subflows utilization.
> 
> Dumping the per subflow tcp_info is not enough, as the PM could close
> and re-create the subflows under-the-hood, fooling the accounting.
> Even checking the src/dst addresses used by each subflow could not
> be enough, because new subflows could re-use the same address/port of
> the just closed one.
> 
> This patch introduces a new socket option, allow dumping all the relevant
> information all-at-once (everything, everywhere...), in a consistent manner.
> 
> To reuse the existing helper to manipulate the new struct, keep the binary
> layout of the initial few fields the same as mptcp_subflow_data.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v3 -> v4:
>  - full_info struct re-design (Florian)
> 
> v2 -> v3:
>  - added missing changelog (oops)
> ---
>  include/uapi/linux/mptcp.h |  25 ++++++
>  net/mptcp/sockopt.c        | 165 +++++++++++++++++++++++++++++++++----
>  2 files changed, 174 insertions(+), 16 deletions(-)
> 
> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index 32af2d278cb4..37c46cf05795 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -12,6 +12,7 @@
>  #include <linux/in.h>		/* for sockaddr_in			*/
>  #include <linux/in6.h>		/* for sockaddr_in6			*/
>  #include <linux/socket.h>	/* for sockaddr_storage and sa_family	*/
> +#include <linux/tcp.h>		/* for tcp_info				*/

(we don't directly use tcp_info here below, no?)

>  
>  #define MPTCP_SUBFLOW_FLAG_MCAP_REM		_BITUL(0)
>  #define MPTCP_SUBFLOW_FLAG_MCAP_LOC		_BITUL(1)
> @@ -244,9 +245,33 @@ struct mptcp_subflow_addrs {
>  	};
>  };
>  
> +struct mptcp_subflow_info {
> +	__u32				id;
> +	struct mptcp_subflow_addrs	addrs;
> +};
> +
> +struct mptcp_subflow_full_info {
> +	__u32		size_subflow_full_info;	/* size of this structure in userspace */
> +	__u32		num_subflows_kern;	/* must be 0, set by kernel (real subflow count) */

(maybe better to call it num_subflows if it is the "real" number of
subflows?)

> +	__u32		size_tcpinfo_kernel;	/* must be 0, set by kernel */
> +	__u32		size_tcpinfo_user;
> +	__u32		size_sfinfo_kernel;	/* must be 0, set by kernel */
> +	__u32		size_sfinfo_user;
> +	__u32		num_subflows_user;	/* max subflows that userspace is interested in;
> +						 * the buffers at subflow_info_addr/tcp_info_addr
> +						 * are respectively at least:
> +						 *  num_subflows_user * size_sfinfo_user
> +						 *  num_subflows_user * size_tcpinfo_user
> +						 * bytes wide

The "longish" comment seems to suggest the name is not appropriated,
maybe: size_arrays(_user) or similar?

> +						 */
> +	__aligned_u64	subflow_info_addr;
> +	__aligned_u64	tcp_info_addr;

(the "_addr" suffix is confusing, I thought it was linked to subflow
addresses :) why not "_ptr" instead? or put "addr_" as a prefix?)

> +} __attribute__((aligned(8)));

Out of curiosity, why not including "struct mptcp_info" in "struct
mptcp_subflow_full_info" (and strip "_subflow": "mptcp_full_info")?

It looks like it is a bit hidden that this getsockopt() also writes
mptcp_info in the buffer if there is space and mptcp_info size could be
explicitly given making clean it can be set to 0 if we don't want it
(instead of not knowing we can give a bigger size to have it included).

Plus the userspace has to create a custom structure to get it:

  struct my_mptcp_full_info {
  	struct mptcp_subflow_full_info i;
  	struct mptcp_info mi;
  };

(but maybe that is common and fine?)

And while at it, why not doing like subflow_info_addr and tcp_info_addr
and use a pointer to a structure? I don't know if it would be better, it
is just to know why, just because it is not an array I suppose :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
