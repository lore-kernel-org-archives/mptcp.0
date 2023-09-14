Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C423939C
	for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 15:22:12 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-31fa666000dso965772f8f.2
        for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 08:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1694704931; x=1695309731; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9aTYMdPjhDg/5zfkVepPDGZkBQPdPgEeFEca8EXRwYY=;
        b=BfRBlASBqdMaMcO4sq7rzW5/roT3n1BmtIfz57hlmR/gdBHyjrdDZdE+arS7DM4Azk
         gUtgGS2GJsG3V0x+qZl7CMLoCB/ilt1PrNdOeLB1L1/FjYWvyPa17XzUecsSYOxjzwyI
         fB0oK3qy3ec2bci/lgFno9HhlByrkYYi8co1t/HxLIikB3Zzbr6hb99Y1MFgqRzUnXuQ
         +gHbTHcvDhRpFj5qZSigJHdX+gTTm9Pdp77FRvfJUvK7BLMcrRHO2M6nlAapBjArkfWV
         RAEWyP/9i7BSqZalvOhlsY1SBU4u/+kHoa45XYTOw9g/9/ut30gJash7jnSYpxmYigVn
         rKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694704931; x=1695309731;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9aTYMdPjhDg/5zfkVepPDGZkBQPdPgEeFEca8EXRwYY=;
        b=u3nOryBbyEREPO9Y7azgt7WOO1tkoIdRo+ILKTpLnXIzN2bT/FtWPaqPeOGpvDunlt
         0BrWIOkCetrfP7tpLFjZ9ojHQC1QFR/U8IY2WGm8SLt8Xe8qprz4FCe4GPMZbso0FRoj
         hCekJ890/6Qoprw3kJoqwuEiGj3U81BiOdNIEMVvwobSum/EUDyRp5z6twcuFfH1VWR3
         qK3Cs502AFnazF/0NmTWYt1a6ToyVI3ZuENoCRIXVfd0ozY4VpzDXQruoyTv0rFrp867
         wivZSsNj+7q+CTjVFd8zcfA1TTeak93+zIohsTVrXMDt4oWzVp0AZ9M6YBo5eMTnVRmV
         Gvug==
X-Gm-Message-State: AOJu0Yy4AjWhLBS6Fj9Kl4jTR6foh9LPF7MHo2zjFtl0CCang4KxutiX
	Lotga344Tipd8x9VOKC6XDzp4lx35I05dh4M7eCCow==
X-Google-Smtp-Source: AGHT+IHvPWZdqLoraPDGUkZ6xd+1G/HsvFj0W4zoQhTDBE1tDcpDV/ls2h5qeCwJGM2Rd1RR9kV2+A==
X-Received: by 2002:a5d:6201:0:b0:31f:8e7c:6ebe with SMTP id y1-20020a5d6201000000b0031f8e7c6ebemr4938591wru.5.1694704930279;
        Thu, 14 Sep 2023 08:22:10 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:e0c0:cbdd:bd42:c2e6? ([2a02:578:8593:1200:e0c0:cbdd:bd42:c2e6])
        by smtp.gmail.com with ESMTPSA id w16-20020adfec50000000b003141a3c4353sm2021575wrn.30.2023.09.14.08.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 08:22:09 -0700 (PDT)
Message-ID: <25aa3002-8a14-441f-9dec-49154de773e0@tessares.net>
Date: Thu, 14 Sep 2023 17:22:09 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v9 6/9] mptcp: add no_initial_subflow
 mptcpi_flags
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1694702984.git.geliang.tang@suse.com>
 <20644cd216983d409e5e2092f3fa5bd50211dc4c.1694702984.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <20644cd216983d409e5e2092f3fa5bd50211dc4c.1694702984.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 14/09/2023 16:50, Geliang Tang wrote:
> If the initial subflow has been removed, we cannot know without checking
> other counters, e.g. ss -ti <filter> | grep -c tcp-ulp-mptcp or
> getsockopt(SOL_MPTCP, MPTCP_FULL_INFO, ...) (or others except MPTCP_INFO
> of course) and then check mptcp_subflow_data->num_subflows to get the
> total amount of subflows.
> 
> This patch adds a new flag NO_INITIAL_SUBFLOW in mptcpi_flags to know if
> the initial subflow has been removed.
> 
> Add a new helper __mptcp_check_initial_subflow() to check whether the
> initial subflow is closing or closed.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/428
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  include/uapi/linux/mptcp.h | 1 +
>  net/mptcp/pm_netlink.c     | 3 ++-
>  net/mptcp/protocol.h       | 5 +++++
>  net/mptcp/sockopt.c        | 2 ++
>  4 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index ee9c49f949a2..c92421866aaf 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -107,6 +107,7 @@ enum {
>  
>  #define MPTCP_INFO_FLAG_FALLBACK		_BITUL(0)
>  #define MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED	_BITUL(1)
> +#define MPTCP_INFO_FLAG_NO_INITIAL_SUBFLOW	_BITUL(2)

With only one flag, the userspace cannot know if the kernel supports
this feature or not: if you are on an older kernel, this flag will not
be set if the initial subflow has been removed. It means that the
userspace cannot be sure about the total number of subflows. We might
need to set another flag is the initial subflow is there.

But then, instead of adding 2 flags, I wonder if it would not be better
to add a new counter (e.g. 'mptcpi_total_subflows'): we would avoid
confusions with 'mptcpi_subflows' which doesn't take into account the
initial subflow.

>  
>  struct mptcp_info {
>  	__u8	mptcpi_subflows;
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 9661f3812682..4b196235c058 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1462,7 +1462,8 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
>  		struct sock *sk = (struct sock *)msk;
>  		struct mptcp_addr_info msk_local;
>  
> -		if (list_empty(&msk->conn_list) || mptcp_pm_is_userspace(msk))
> +		if (list_empty(&msk->conn_list) || mptcp_pm_is_userspace(msk) ||
> +		    !__mptcp_check_initial_subflow(msk))

Again, sorry it is a quick review but why do you need to do this
modification here?

>  			goto next;
>  
>  		mptcp_local_address((struct sock_common *)msk, &msk_local);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 3c938e3560e4..96e3846b50fe 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1031,6 +1031,11 @@ static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
>  	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
>  }
>  
> +static inline bool __mptcp_check_initial_subflow(const struct mptcp_sock *msk)

Maybe "__mptcp_has_initial_subflow()"?

> +{
> +	return msk->first && inet_sk_state_load(msk->first) != TCP_CLOSE;

No need to do a READ_ONCE() when called from mptcp_diag_fill_info()?

Did you check if it is normal to have 'msk->first' still set after
having removed it? Why do we keep it? (I don't remember)

Cheers,
Matt

> +}
> +
>  static inline void mptcp_do_fallback(struct sock *ssk)
>  {
>  	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 8260202c0066..a2e1c3d159d6 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -919,6 +919,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
>  		flags |= MPTCP_INFO_FLAG_FALLBACK;
>  	if (READ_ONCE(msk->can_ack))
>  		flags |= MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED;
> +	if (!__mptcp_check_initial_subflow(msk))
> +		flags |= MPTCP_INFO_FLAG_NO_INITIAL_SUBFLOW;
>  	info->mptcpi_flags = flags;
>  	mptcp_data_lock(sk);
>  	info->mptcpi_snd_una = msk->snd_una;

-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
