Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911FC70
	for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 08:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1627286941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hhF3QD7mJUW67c02BIj97lWxxMeXmrlE0qIbsVGod7k=;
	b=BtjWgx7c8DJBiR1d3k47ihKNKiXwEkrE38rX68KcExl93jc8Yx5MnLQOplX+idq8FQLqdj
	DardmaNMx81eOG6PgW+SR9U5qYr4Ymk2PriLMTgfv4NfDlvWihYzPoaeZMHKkAwDRuNgRV
	OzKOEAnm+qEyLGnomgMachaynnmDF10=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-4MHGUHUeP62qGs4j88vHIw-1; Mon, 26 Jul 2021 04:08:59 -0400
X-MC-Unique: 4MHGUHUeP62qGs4j88vHIw-1
Received: by mail-wm1-f71.google.com with SMTP id 132-20020a1c018a0000b029025005348905so1257528wmb.7
        for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 01:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=hhF3QD7mJUW67c02BIj97lWxxMeXmrlE0qIbsVGod7k=;
        b=G6BK+e81ICpKoM2cN+kAftjeP3JLy9KH27rQ8tjRVGWPitofk0DoBPbvqIW63aBTM0
         bXe40IsfSanZXeyuDGjwC6PFLhZ16l9sJjcycZJMFn5HGgcn3G8RSFmou4Wwdw68+mF6
         am3mJLR4i80aO5mIjxNpb52GogF43ha9U5xJznjje9hntj1fO3LWm9Uqb7Dv7vblwwqe
         hNtjfoR7CnJ/BA8zf2+8cty9g5EApL0x8EVXLau6ai+nBYy2vGmw1sOl0iDLIOmBinTi
         dE40MwEl8Br3UU5D/yHYkyZbkK1dUunLc6lKzQMV+F1ZkS90wnupUT+A78a9HZ/zGgtJ
         U22g==
X-Gm-Message-State: AOAM533RVUjkAbBU9n8LYaPX5IWeQtxOEyFL3jDUTkcnr0PxVskHJtxT
	y8hjQ23ulMDAuM0ua5/+RluPS8wJkwQDVOtZWQQxs9abUUtm6O76mSGkfWJ86zyj2x+GH9UE0vB
	wU210u4hFwC559wg=
X-Received: by 2002:a05:600c:4f85:: with SMTP id n5mr16090286wmq.9.1627286938055;
        Mon, 26 Jul 2021 01:08:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypiJ0Ypt3hZClZBiBwOuh8Kt5wo+qQY5zey2fG5vaWxW2PtFB0uLMEg2r/bxTEzBhuHUkSOQ==
X-Received: by 2002:a05:600c:4f85:: with SMTP id n5mr16090275wmq.9.1627286937876;
        Mon, 26 Jul 2021 01:08:57 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-57.dyn.eolo.it. [146.241.97.57])
        by smtp.gmail.com with ESMTPSA id l39sm9832925wms.1.2021.07.26.01.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 01:08:57 -0700 (PDT)
Message-ID: <740470b252d4078c702003008d11910fd754435e.camel@redhat.com>
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "Squash-to: mptcp: build
 ADD_ADDR/echo-ADD_ADDR option according pm.add_signal"
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Date: Mon, 26 Jul 2021 10:08:56 +0200
In-Reply-To: <313195dff50905ec809b66b2f195340dd80d68ff.1627219500.git.geliangtang@xiaomi.com>
References: <313195dff50905ec809b66b2f195340dd80d68ff.1627219500.git.geliangtang@xiaomi.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2021-07-25 at 21:41 +0800, Geliang Tang wrote:
> Paolo's patch (Squash-to: "mptcp: build ADD_ADDR/echo-ADD_ADDR option
> according pm.add_signal") reverts back to a single 'addr' field in struct
> mptcp_addr_info.
> 
> Then no need to change the argument of mptcp_pm_add_addr_signal and no
> need to modify the code in mptcp_write_options now, the original code is
> fine.
> 
> So this patch reverts back more code.
> 
> And the commit log needs to be updated:
> 
> '''
> According to the MPTCP_ADD_ADDR_SIGNAL or MPTCP_ADD_ADDR_ECHO flag, build
> the ADD_ADDR/ADD_ADDR_ECHO option.
> 
> In mptcp_pm_add_addr_signal(), use opts->remote or opts->local to save the
> announced ADD_ADDR or ADD_ADDR_ECHO address.
> '''
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>  net/mptcp/options.c  | 25 ++++++++++++-------------
>  net/mptcp/pm.c       |  6 +++---
>  net/mptcp/protocol.h |  2 +-
>  3 files changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index eafdb9408f3a..cb29a5605776 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -668,7 +668,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
>  	int len;
>  
>  	if (!mptcp_pm_should_add_signal(msk) ||
> -	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, opts,
> +	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, &opts->addr,
>  		    &echo, &port, &drop_other_suboptions))
>  		return false;
>  
> @@ -692,8 +692,8 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
>  						     msk->remote_key,
>  						     &opts->addr);
>  	}
> -	pr_debug("addr_id=%d, addr_port=%d, ahmac=%llu, echo=%d",
> -		 opts->addr.id, ntohs(opts->addr.port), opts->ahmac, echo);
> +	pr_debug("addr_id=%d, ahmac=%llu, echo=%d, port=%d",
> +		 opts->addr.id, opts->ahmac, echo, ntohs(opts->addr.port));
>  
>  	return true;
>  }
> @@ -1250,16 +1250,15 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
>  
>  mp_capable_done:
>  	if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
> -		struct mptcp_addr_info *addr = &opts->addr;
>  		u8 len = TCPOLEN_MPTCP_ADD_ADDR_BASE;
>  		u8 echo = MPTCP_ADDR_ECHO;
>  
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -		if (addr->family == AF_INET6)
> +		if (opts->addr.family == AF_INET6)
>  			len = TCPOLEN_MPTCP_ADD_ADDR6_BASE;
>  #endif
>  
> -		if (addr->port)
> +		if (opts->addr.port)
>  			len += TCPOLEN_MPTCP_PORT_LEN;
>  
>  		if (opts->ahmac) {
> @@ -1268,25 +1267,25 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
>  		}
>  
>  		*ptr++ = mptcp_option(MPTCPOPT_ADD_ADDR,
> -				      len, echo, addr->id);
> -		if (addr->family == AF_INET) {
> -			memcpy((u8 *)ptr, (u8 *)&addr->addr.s_addr, 4);
> +				      len, echo, opts->addr.id);
> +		if (opts->addr.family == AF_INET) {
> +			memcpy((u8 *)ptr, (u8 *)&opts->addr.addr.s_addr, 4);
>  			ptr += 1;
>  		}
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -		else if (addr->family == AF_INET6) {
> -			memcpy((u8 *)ptr, addr->addr6.s6_addr, 16);
> +		else if (opts->addr.family == AF_INET6) {
> +			memcpy((u8 *)ptr, opts->addr.addr6.s6_addr, 16);
>  			ptr += 4;
>  		}
>  #endif
>  
> -		if (!addr->port) {
> +		if (!opts->addr.port) {
>  			if (opts->ahmac) {
>  				put_unaligned_be64(opts->ahmac, ptr);
>  				ptr += 2;
>  			}
>  		} else {
> -			u16 port = ntohs(addr->port);
> +			u16 port = ntohs(opts->addr.port);
>  
>  			if (opts->ahmac) {
>  				u8 *bptr = (u8 *)ptr;
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 5fe3805af02a..781da0885f98 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -257,7 +257,7 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
>  
>  bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
>  			      unsigned int opt_size, unsigned int remaining,
> -			      struct mptcp_out_options *opts, bool *echo,
> +			      struct mptcp_addr_info *saddr, bool *echo,
>  			      bool *port, bool *drop_other_suboptions)
>  {
>  	int ret = false;
> @@ -286,10 +286,10 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
>  		goto out_unlock;
>  
>  	if (*echo) {
> -		opts->addr = msk->pm.remote;
> +		*saddr = msk->pm.remote;
>  		add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_ECHO);
>  	} else {
> -		opts->addr = msk->pm.local;
> +		*saddr = msk->pm.local;
>  		add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_SIGNAL);
>  	}
>  	WRITE_ONCE(msk->pm.addr_signal, add_addr);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index b54335857b6e..099e3e6a4c89 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -801,7 +801,7 @@ static inline int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
>  
>  bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
>  			      unsigned int opt_size, unsigned int remaining,
> -			      struct mptcp_out_options *opts, bool *echo,
> +			      struct mptcp_addr_info *saddr, bool *echo,
>  			      bool *port, bool *drop_other_suboptions);
>  bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>  			     struct mptcp_rm_list *rm_list);

LGTM, thanks!

(not sure if my Acked-by tag can be added here, do to many tags already
present ;)

/P



