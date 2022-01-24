Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DC1168
	for <mptcp@lists.linux.dev>; Mon, 24 Jan 2022 10:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1643021949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AQladaDOVuEEsfCyxXIzLBlpOpVFnqecRiYRtn1tYuY=;
	b=MaX6LflZWTEmW2e2gW+yECDllv0qtX8P8Al2muHYlmiN2QP+DEmxnEeTLXr16dSjbPvhwm
	3rykvV7kYmpIiV7GB1hL5nV6SijCfVpzu1anS28vS382pMnidU/wVwam2HhaEkZ0+HluUV
	PdU03s1yvwTbw2kM4f78tBZc+w5bapI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-P9eUaRlNPKaIj973Ti-0sg-1; Mon, 24 Jan 2022 05:59:05 -0500
X-MC-Unique: P9eUaRlNPKaIj973Ti-0sg-1
Received: by mail-wr1-f71.google.com with SMTP id b3-20020a5d4b83000000b001d676462248so1722280wrt.17
        for <mptcp@lists.linux.dev>; Mon, 24 Jan 2022 02:59:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=AQladaDOVuEEsfCyxXIzLBlpOpVFnqecRiYRtn1tYuY=;
        b=c+OR/o6cavTsSlKgKbFkqEXvb9dimmYewGRO3eRahZ/PTqEffJcYBmS3NPXVAzHxsN
         sNOW87HgwfYa527jhwwatPq1zpnvZ1YQRoyrOmFo1m0fK/Ymj8q2NcE50WQwwjkTHp0+
         cuj0IxUroaYNgNEF52qcNtkiLYMeix5m5/bwgJwsSsM+o53Vr2YLitanmItb84WJbif9
         rBbM5J+EBJe4oMsRS36zKwWRitR6swZv/MEa5AGyyMAbBNgisZZNNbkbGsuqBEZCzxPx
         rITOI8+pWsULNnbLC5L9q3A1/H5oXcVb4kDA2cGmGZv+i6VgtaZwhtRmbRVpwANm6/TT
         7NGA==
X-Gm-Message-State: AOAM531wrHNUA8kJ0jhRVbhF6MXWVR6dWbK9gxU6DWlWmfB+zM1jyfBr
	5Mz6BdEaSzwJJ07Yov3n8/7ugXn4ydAJsXnlf3qdexh89BMiSv9aa9TU7+L/BfBeXrKE3yIq4IK
	cCo0dtKy/2l+Bn80=
X-Received: by 2002:a05:6000:152:: with SMTP id r18mr13735183wrx.598.1643021944175;
        Mon, 24 Jan 2022 02:59:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyJsNKfbcbRG3KAKJw8ecxe7f562hd7lfeTDIdtGwhK6cGZ6Yd+LoQbA6SzVa/u0oxH/HddPA==
X-Received: by 2002:a05:6000:152:: with SMTP id r18mr13735175wrx.598.1643021943966;
        Mon, 24 Jan 2022 02:59:03 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id h127sm21203606wmh.27.2022.01.24.02.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 02:59:03 -0800 (PST)
Message-ID: <2b6dbcdfaf0851156fda6c09b9ebedd64b0b1583.camel@redhat.com>
Subject: Re: [PATCH mptcp-net 1/2] mptcp: mptcp_parse_option is no longer
 exported
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Mon, 24 Jan 2022 11:59:02 +0100
In-Reply-To: <20220122093135.4023846-2-matthieu.baerts@tessares.net>
References: <20220122093135.4023846-1-matthieu.baerts@tessares.net>
	 <20220122093135.4023846-2-matthieu.baerts@tessares.net>
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35)
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

On Sat, 2022-01-22 at 10:31 +0100, Matthieu Baerts wrote:
> Options parsing in now done from mptcp_incoming_options().
> 
> mptcp_parse_option() has been removed from mptcp.h when CONFIG_MPTCP is
> defined but not when it is not.
> 
> Fixes: cfde141ea3fa ("mptcp: move option parsing into mptcp_incoming_options()")
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  include/net/mptcp.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 04f53352a1c9..8b1afd6f5cc4 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -218,12 +218,6 @@ static inline bool rsk_drop_req(const struct request_sock *req)
>  	return false;
>  }
>  
> -static inline void mptcp_parse_option(const struct sk_buff *skb,
> -				      const unsigned char *ptr, int opsize,
> -				      struct tcp_options_received *opt_rx)
> -{
> -}
> -
>  static inline bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
>  				     unsigned int *size,
>  				     struct mptcp_out_options *opts)

Nice catch!

Acked-by: Paolo Abeni <pabeni@redhat.com>

