Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5633256F
	for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 10:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663582801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VqiIujQezppmx1y9U3xgJvX8PtANC96pysjxXc4wSl4=;
	b=ebXC3JpEMWX+qIT8jptQu5sHJkuluTmoYFt8K2zJ0E7Pc4fGtqvSmFiY53aCF3GJxDfN3A
	N1QJ7kNsdY0ukGk0GPjVwzy/l+rXSCmGVhYbEEkWMiZDRMWcH380RXa/7dyLCpdb/+37/s
	Vg78TGOaXsuC/Ip4kDF+m4VrxA6fXag=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-529-HPfdVBKDN7yvltUG_zvaww-1; Mon, 19 Sep 2022 06:20:00 -0400
X-MC-Unique: HPfdVBKDN7yvltUG_zvaww-1
Received: by mail-qv1-f70.google.com with SMTP id i10-20020ad45c6a000000b004a25d0fea96so18835834qvh.3
        for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 03:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=VqiIujQezppmx1y9U3xgJvX8PtANC96pysjxXc4wSl4=;
        b=SEqmn+OImJAd+lMB5Au6wI0vHOwf7Q5hNFFpZNPwfxMPBGn7nw0N0mWjT6E4Gta9T+
         0tcpR4rQ8rGSSYAfjrmjMTINxip6sQ48CTyKaw0huUohARyekVqygAjk0WaQe5PmTgb+
         EN22EIQWKy75fA9kBkr6l0LfUvwqZu28J3kw43cgLDZkDFa8T5DGn8vSILw6L02Y3Mdl
         fnRyYpo9CUDqA5rwhSHJDGFJYlyL/RyHL6n509uGkh3Wd6r1gbOpy5gRYYFYCCXc4D/M
         fjubsXJawgctLd48KZnPTwe/eNJqNWlhuWnV2RVzM2YlIgLhCLa+m2OQiUU4WneUf2BX
         5J6A==
X-Gm-Message-State: ACrzQf0bJCGvxRelY+WceBiUJvbvMuIaDgZjfTv5M0RAxMpi2WDCkRhe
	nGGF+lW69oSxeHnG5lKQeCtAaVAb5UYRfi22t4r1sNYqkIwlphEDlCLwelE3YC1DylPzBz3tQo0
	RxEJsPJXWd3e3MR4=
X-Received: by 2002:ad4:5ec5:0:b0:49c:cf39:d4d2 with SMTP id jm5-20020ad45ec5000000b0049ccf39d4d2mr13881747qvb.6.1663582799440;
        Mon, 19 Sep 2022 03:19:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7ZMNkwi74UAbsPKhp0zWZd7fRX2vQrMthu4aW4Kpvoy6w/BI72msI5H5y30ziYi8DNDB7K+g==
X-Received: by 2002:ad4:5ec5:0:b0:49c:cf39:d4d2 with SMTP id jm5-20020ad45ec5000000b0049ccf39d4d2mr13881735qvb.6.1663582799236;
        Mon, 19 Sep 2022 03:19:59 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-114-90.dyn.eolo.it. [146.241.114.90])
        by smtp.gmail.com with ESMTPSA id r1-20020ae9d601000000b006b872b606b1sm12303356qkk.128.2022.09.19.03.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 03:19:58 -0700 (PDT)
Message-ID: <5819cf0613ccb13db1c45d8f71bf5fc85d3b0ccf.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next v7 02/11] add mptcp_stream_connect to
 protocol.h
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev
Date: Mon, 19 Sep 2022 12:19:55 +0200
In-Reply-To: <20220917222853.2406-3-dmytro@shytyi.net>
References: <20220917222853.2406-1-dmytro@shytyi.net>
	 <20220917222853.2406-3-dmytro@shytyi.net>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2022-09-18 at 00:28 +0200, Dmytro Shytyi wrote:
> We call mptcp_stream_connect() from mptcp_sendmsg_fastopen() in

Minor nit: the commit message should be changed to something alike:

"""
In the following patches we will call mptcp_stream_connect() [...],
make such symbol visible.
"""

Otherwise other reviewer may be confused.

Thanks!

Paolo

> fastopen.c
> 
> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
> ---
>  net/mptcp/protocol.c | 4 ++--
>  net/mptcp/protocol.h | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 55442df8fb97..0e5db0a634d3 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3474,8 +3474,8 @@ static void mptcp_subflow_early_fallback(struct mptcp_sock *msk,
>  	__mptcp_do_fallback(msk);
>  }
>  
> -static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
> -				int addr_len, int flags)
> +int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
> +			 int addr_len, int flags)
>  {
>  	struct mptcp_sock *msk = mptcp_sk(sock->sk);
>  	struct mptcp_subflow_context *subflow;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 1bc9f6e77ddd..1e21293bceaa 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -835,6 +835,7 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
>  void mptcp_event_addr_announced(const struct sock *ssk, const struct mptcp_addr_info *info);
>  void mptcp_event_addr_removed(const struct mptcp_sock *msk, u8 id);
>  bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
> +int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr, int addr_len, int flags);
>  
>  static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
>  {

