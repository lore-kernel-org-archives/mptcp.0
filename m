Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EEA70
	for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 09:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1627378700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TtEf3Ll6s+fwEuG8xLm+H5IPCXbxY3FzGzldnE0pME4=;
	b=jGLaSxxMJclhEI/JFi4HfcOEqlS+ISsCPVxm8l+YXpYPQBr+7tCoMQn+3+wNa1qXiaM16A
	bzJ/SR5dyHqaJ96e3rFt5DaryqvHDXiO4HLaWtcC0w4wZXCzJjX57opdej+MqssaSOrMiH
	TmHU7MYgYcD0U9q6iF1yKOhrepXEfvw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-7-clBJvvOUCEnZjJjfylCA-1; Tue, 27 Jul 2021 05:38:19 -0400
X-MC-Unique: 7-clBJvvOUCEnZjJjfylCA-1
Received: by mail-wr1-f70.google.com with SMTP id n1-20020a5d59810000b029013cd60e9baaso5772336wri.7
        for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 02:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=TtEf3Ll6s+fwEuG8xLm+H5IPCXbxY3FzGzldnE0pME4=;
        b=t8lye07Q4v+b6bWS/FbI2X5qGOJTapaj4IYdfHp7gNbxaTfJP2XgWJGUKtkBQwvCIy
         /G5O/a9Y3Wd3Mszk38N3nCI1eI/LhS15PJxaAQ8nPdsAeV1YIzwvvux/ywv+LX4MvNPx
         vnGutSmfCoxRbmfM0/NJkmW83h/B0FCLiBz4jv3kcX/Xti0naPZrfqP+ddBKKloJcNTP
         7t929NG7vqlDnL8/IycWSeFu5vcNj/AFnBWA6feG9uKVvapSmRygFvo7g0FyK1ZRuL0w
         XYf9BBF5QdPKnepbmK+USflXWBTzuVik745jXJ8pZDHnHz4j/GGp1+vP6JA0j2h3+6yU
         a/JQ==
X-Gm-Message-State: AOAM531YG0IL5OWhssL0ym89UOrQX5wAkUkDYGtiPdajJ31Rkyhj8ksU
	4l/REEH0NVtzIOyjXrLhVYMcRr7p4Iy9fhAbrPoSs2mC7Ig9fgjvMCdF7xMEOhMqFGD3zgAr5wk
	ub6gpB2gSrD+RNWw=
X-Received: by 2002:a05:6000:1b02:: with SMTP id f2mr19623979wrz.274.1627378698203;
        Tue, 27 Jul 2021 02:38:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmqsQTBv0DLhhLUfJ7S5TiH2lpVD3013Rj4xok0xYmXxa9ZQorJQDmr0CA4SvpDrChXkSISQ==
X-Received: by 2002:a05:6000:1b02:: with SMTP id f2mr19623964wrz.274.1627378698024;
        Tue, 27 Jul 2021 02:38:18 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-57.dyn.eolo.it. [146.241.97.57])
        by smtp.gmail.com with ESMTPSA id n5sm1936604wmq.17.2021.07.27.02.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 02:38:17 -0700 (PDT)
Message-ID: <ca9473da6544d61bc5f0271fbab57fc113b6020d.camel@redhat.com>
Subject: Re: [MPTCP][PATCH v5 mptcp-next 1/5] mptcp: remote addresses
 fullmesh
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@xiaomi.com>
Date: Tue, 27 Jul 2021 11:38:16 +0200
In-Reply-To: <b8af3a77da2fcd8e16e8b5d6b63c7c8386abcbac.1627372396.git.geliangtang@xiaomi.com>
References: <cover.1627372396.git.geliangtang@xiaomi.com>
	 <b8af3a77da2fcd8e16e8b5d6b63c7c8386abcbac.1627372396.git.geliangtang@xiaomi.com>
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

Hello,

On Tue, 2021-07-27 at 15:58 +0800, Geliang Tang wrote:
> From: Geliang Tang <geliangtang@xiaomi.com>
> 
> This patch added and managed a new per endpoint flag, named
> MPTCP_PM_ADDR_FLAG_FULLMESH.
> 
> In mptcp_pm_create_subflow_or_signal_addr(), if such flag is set, instead
> of:
> 
>         remote_address((struct sock_common *)sk, &remote);
> 
> fill a temporary allocated array of all known remote address. After
> releaseing the pm lock loop on such array and create a subflow for each
> remote address from the given local.
> 
> Note that the we could still use an array even for non 'fullmesh'
> endpoint: with a single entry corresponding to the primary MPC subflow
> remote address.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> ---
>  include/uapi/linux/mptcp.h |  1 +
>  net/mptcp/pm_netlink.c     | 80 +++++++++++++++++++++++++++++++++++---
>  2 files changed, 76 insertions(+), 5 deletions(-)
> 
> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index 7b05f7102321..f66038b9551f 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -73,6 +73,7 @@ enum {
>  #define MPTCP_PM_ADDR_FLAG_SIGNAL			(1 << 0)
>  #define MPTCP_PM_ADDR_FLAG_SUBFLOW			(1 << 1)
>  #define MPTCP_PM_ADDR_FLAG_BACKUP			(1 << 2)
> +#define MPTCP_PM_ADDR_FLAG_FULLMESH			(1 << 3)
>  
>  enum {
>  	MPTCP_PM_CMD_UNSPEC,
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index ba0e1d71504d..2259c424485f 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -158,6 +158,27 @@ static bool lookup_subflow_by_daddr(const struct list_head *list,
>  	return false;
>  }
>  
> +static bool lookup_subflow_by_addrs(const struct list_head *list,
> +				    struct mptcp_addr_info *saddr,
> +				    struct mptcp_addr_info *daddr)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct mptcp_addr_info local, remote;
> +	struct sock_common *skc;
> +
> +	list_for_each_entry(subflow, list, node) {
> +		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
> +
> +		local_address(skc, &local);
> +		remote_address(skc, &remote);
> +		if (addresses_equal(&local, saddr, saddr->port) &&
> +		    addresses_equal(&remote, daddr, daddr->port))
> +			return true;
> +	}
> +
> +	return false;
> +}

I'm sorry for not noticing this earlier, do we need this function and
the related check in fill_remote_addresses_vec()?

'saddr' is the return value of select_local_address(), so existing
subflows is bound to such address. 

> +
>  static struct mptcp_pm_addr_entry *
>  select_local_address(const struct pm_nl_pernet *pernet,
>  		     struct mptcp_sock *msk)
> @@ -410,6 +431,53 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
>  	}
>  }
>  
> +static bool lookup_address_in_vec(struct mptcp_addr_info *addrs, unsigned int nr,
> +				  struct mptcp_addr_info *addr)
> +{
> +	int i;
> +
> +	for (i = 0; i < nr; i++) {
> +		if (addresses_equal(&addrs[i], addr, addr->port))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk,
> +					      struct mptcp_pm_addr_entry *local,
> +					      struct mptcp_addr_info *addrs)
> +{
> +	struct sock *sk = (struct sock *)msk, *ssk;
> +	struct mptcp_subflow_context *subflow;
> +	struct mptcp_addr_info remote = { 0 };

Minor nit: no need to initialize the 'remote' variable

Cheers,

Paolo

