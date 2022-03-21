Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E2663E
	for <mptcp@lists.linux.dev>; Mon, 21 Mar 2022 17:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1647882325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ovqf81yY/lYhQQMdN/K/PRLPLZw83R6/OOeu+Gqmvkg=;
	b=PZjblDxR2yPRpWJIZC2a4EG7dL5edupLLD+UyFKUL8FEXrSVao/giiDiOoTtFcQQ8+yw6r
	FkQEMglQgf7FU3zXs+VjdJOvB7UIAIEM8EJu/zP8FYLBg+1okD4wt/riu8F/RL8Wztjfav
	PaoKFGPwgCfC9+nxpwchSQBmx/kBaPY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-h1LhjyvANO-bNBiOYWxUeQ-1; Mon, 21 Mar 2022 13:05:23 -0400
X-MC-Unique: h1LhjyvANO-bNBiOYWxUeQ-1
Received: by mail-wr1-f72.google.com with SMTP id p9-20020adf9589000000b001e333885ac1so3273989wrp.10
        for <mptcp@lists.linux.dev>; Mon, 21 Mar 2022 10:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Ovqf81yY/lYhQQMdN/K/PRLPLZw83R6/OOeu+Gqmvkg=;
        b=QvGOyRj9p1QO5sbnI79GewJ23EPudZaerdmul19PjrneDmQtr7bBxFo/djbU0oBZVD
         Tgh6R6YiGcM6O9IS8UruXb6jIOUhvbMnH9Ij7IbdSa8RS2GIxA1ZIQ7hH/4bu118joWg
         n4pY0jxIN0qJC3yR6da9i4PNkooiUDepjHbZ/oR6IHYjuV2L2egiWsPc/9klnjma6HSi
         8QSS+m/N0/587qGF/EY8l1nk+ob2O9et1U8PqPlqPSC3RYKMRAsccE6Xstm/w8xVT6w+
         JEY9Ts74VdLVyeFzUoI3yyVtfxDflEppoVtklRpU+jufiZKwKEFt2NUogX+LjQgpw6NF
         mKNQ==
X-Gm-Message-State: AOAM532raPLFChDPDF4xiTycldfyGWpUP9sER/SId6EyiCiYWk2X/aJ8
	xs9uWxBXxHLfHWSB1rdLSkkk55q/1p9C9HuVjNaYh0boi/N50OUu2BwcsNlRXfdYzPvgaLRppeX
	38RcpAI6ij0NgglY=
X-Received: by 2002:a05:600c:3516:b0:389:f9aa:f821 with SMTP id h22-20020a05600c351600b00389f9aaf821mr47534wmq.73.1647882322457;
        Mon, 21 Mar 2022 10:05:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTPbsVFvEQLgcqhfyFZNmMBBd9v+Ve05GoQd5xSp2fq8tVrxJNfpL1FeFHLhskZ3ZBqRdCcA==
X-Received: by 2002:a05:600c:3516:b0:389:f9aa:f821 with SMTP id h22-20020a05600c351600b00389f9aaf821mr47514wmq.73.1647882322107;
        Mon, 21 Mar 2022 10:05:22 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-135.dyn.eolo.it. [146.241.232.135])
        by smtp.gmail.com with ESMTPSA id 189-20020a1c02c6000000b0038c57df82aasm66731wmc.20.2022.03.21.10.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 10:05:21 -0700 (PDT)
Message-ID: <7a7d243670eed6fdd94e8ebd655f63bed3497c7d.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v8 4/6] mptcp: reflect remote port (not 0) in
 ANNOUNCED events
From: Paolo Abeni <pabeni@redhat.com>
To: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
Date: Mon, 21 Mar 2022 18:05:20 +0100
In-Reply-To: <20220317230449.763778-5-kishen.maloor@intel.com>
References: <20220317230449.763778-1-kishen.maloor@intel.com>
	 <20220317230449.763778-5-kishen.maloor@intel.com>
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35)
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

On Thu, 2022-03-17 at 19:04 -0400, Kishen Maloor wrote:
> Per RFC 8684, if no port is specified in an ADD_ADDR message, MPTCP
> SHOULD attempt to connect to the specified address on the same port
> as the port that is already in use by the subflow on which the
> ADD_ADDR signal was sent.
> 
> To facilitate that, this change reflects the specific remote port in
> use by that subflow in MPTCP_EVENT_ANNOUNCED events.
> 
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
>  net/mptcp/options.c    |  2 +-
>  net/mptcp/pm.c         |  6 ++++--
>  net/mptcp/pm_netlink.c | 11 ++++++++---
>  net/mptcp/protocol.h   |  4 ++--
>  4 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 88f4ebbd6515..c9625fea3ef9 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1133,7 +1133,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>  		if ((mp_opt.suboptions & OPTION_MPTCP_ADD_ADDR) &&
>  		    add_addr_hmac_valid(msk, &mp_opt)) {
>  			if (!mp_opt.echo) {
> -				mptcp_pm_add_addr_received(msk, &mp_opt.addr);
> +				mptcp_pm_add_addr_received(sk, &mp_opt.addr);
>  				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
>  			} else {
>  				mptcp_pm_add_addr_echoed(msk, &mp_opt.addr);
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index f9a12e6f4b4e..56b3f29efdd9 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -200,15 +200,17 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
>  	spin_unlock_bh(&pm->lock);
>  }
>  
> -void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
> +void mptcp_pm_add_addr_received(const struct sock *ssk,
>  				const struct mptcp_addr_info *addr)
>  {
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> +	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
>  	struct mptcp_pm_data *pm = &msk->pm;
>  
>  	pr_debug("msk=%p remote_id=%d accept=%d", msk, addr->id,
>  		 READ_ONCE(pm->accept_addr));
>  
> -	mptcp_event_addr_announced(msk, addr);
> +	mptcp_event_addr_announced(ssk, addr);
>  
>  	spin_lock_bh(&pm->lock);
>  
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 94d2bbb14eba..8676aecc52a6 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -2010,10 +2010,12 @@ void mptcp_event_addr_removed(const struct mptcp_sock *msk, uint8_t id)
>  	kfree_skb(skb);
>  }
>  
> -void mptcp_event_addr_announced(const struct mptcp_sock *msk,
> +void mptcp_event_addr_announced(const struct sock *ssk,
>  				const struct mptcp_addr_info *info)
>  {
> -	struct net *net = sock_net((const struct sock *)msk);
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> +	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
> +	struct net *net = sock_net(ssk);
>  	struct nlmsghdr *nlh;
>  	struct sk_buff *skb;
>  
> @@ -2035,7 +2037,10 @@ void mptcp_event_addr_announced(const struct mptcp_sock *msk,
>  	if (nla_put_u8(skb, MPTCP_ATTR_REM_ID, info->id))
>  		goto nla_put_failure;
>  
> -	if (nla_put_be16(skb, MPTCP_ATTR_DPORT, info->port))
> +	if (nla_put_be16(skb, MPTCP_ATTR_DPORT,
> +			 info->port == 0 ?
> +			 ((struct inet_sock *)inet_sk(ssk))->inet_dport :

The explicit cast to 'struct inet_sock' is not needed.

/P

