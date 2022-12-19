Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9240CA23
	for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 08:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1671438739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VfRLtWwwMhRGRArwUG8jCnA6tyJ8aYpINU7tsIfr7Sw=;
	b=NnYiAUNw9D6iKVlOeS5NAhwcOIFBF60QPIBLJRfnnQQOl4IaomGgcW4n1zT+LLWBWoxbxE
	93Cb132Nfs0bkJkKQ47UaJGdKQ4A294MgR1OmPD8OlwUtFrLYIhHYgHRscIomheeHdaKBB
	3ujA/XnR4XYIvNuUEhW97/9UTZu4md8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-197-b9FT3oY8OtiWCx2JthnzHA-1; Mon, 19 Dec 2022 03:32:18 -0500
X-MC-Unique: b9FT3oY8OtiWCx2JthnzHA-1
Received: by mail-wr1-f70.google.com with SMTP id v14-20020adf8b4e000000b0024174021277so1282805wra.13
        for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 00:32:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VfRLtWwwMhRGRArwUG8jCnA6tyJ8aYpINU7tsIfr7Sw=;
        b=VWFfdbHlTKgDZ7gp1qhho7n6ZPSXoUTEWHH88O+klGXxkg0fiyYFCwzmzDAkMqBbF0
         Wq012vr4xthjm7c8m/2N2g9K5aTyIhfi/rnQi4beg/65W3xwaBQMq4jboGR0G4Z00tc6
         uK7XmrtkdxhR4gzLmYxFDqgTv+s8W2fwJZtW5crEziu/w1lKwoaNiCGpOaopbHNzN+bO
         dnwcTk05oCpxb+JNcMrzMzWq1G2DajUSaTyTGzUbvJiCywcVMECjRgv3rj3QZaQ628RP
         j8pCXZ4frq9P/kiHLIatbTEcQbRem2/8jufQ7ZB+ytTL2L0ugAQ5SzmAhxoT2OyTvYSZ
         iTuw==
X-Gm-Message-State: ANoB5pkMXpmHa+pSZ4/PVnduc9yObxNHE3bq+wvIk+tyP+PpmNFboLQJ
	FYBrdW7mKor0iO7cm+6Z4T22ZjHZAlvE6Qxeaa6SuGOkAyaR1hI0b2DBlPAh62aOtcqD5fZMA5X
	JiLt1chsd16QVMBI=
X-Received: by 2002:a05:600c:1e18:b0:3d2:26e1:bd45 with SMTP id ay24-20020a05600c1e1800b003d226e1bd45mr30028228wmb.29.1671438737361;
        Mon, 19 Dec 2022 00:32:17 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4+SDXMDxDi7uxVYLVzwLgBabcwS2Mkf0zx7LpMK2EksBppys7D2IIOsuFR7HAuhvSV6edacQ==
X-Received: by 2002:a05:600c:1e18:b0:3d2:26e1:bd45 with SMTP id ay24-20020a05600c1e1800b003d226e1bd45mr30028215wmb.29.1671438737181;
        Mon, 19 Dec 2022 00:32:17 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-101-173.dyn.eolo.it. [146.241.101.173])
        by smtp.gmail.com with ESMTPSA id k5-20020a05600c1c8500b003d237d60318sm12369626wms.2.2022.12.19.00.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 00:32:16 -0800 (PST)
Message-ID: <2225c7fa3484a262aa143b2e250cdc87beef410b.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v9 4/6] mptcp: init sk->sk_prot in build_msk()
From: Paolo Abeni <pabeni@redhat.com>
To: menglong8.dong@gmail.com, mathew.j.martineau@linux.intel.com, 
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>
Date: Mon, 19 Dec 2022 09:32:15 +0100
In-Reply-To: <20221219075048.255811-5-imagedong@tencent.com>
References: <20221219075048.255811-1-imagedong@tencent.com>
	 <20221219075048.255811-5-imagedong@tencent.com>
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

On Mon, 2022-12-19 at 15:50 +0800, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> The 'sk_prot' field in token KUNIT self-tests will be dereferenced in
> mptcp_token_new_connect(). Therefore, init it with tcp_prot.
> 
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---
>  net/mptcp/token_test.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/mptcp/token_test.c b/net/mptcp/token_test.c
> index 5d984bec1cd8..0758865ab658 100644
> --- a/net/mptcp/token_test.c
> +++ b/net/mptcp/token_test.c
> @@ -57,6 +57,9 @@ static struct mptcp_sock *build_msk(struct kunit *test)
>  	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, msk);
>  	refcount_set(&((struct sock *)msk)->sk_refcnt, 1);
>  	sock_net_set((struct sock *)msk, &init_net);
> +
> +	/* be sure the token helpers can dereference sk->sk_prot */
> +	((struct sock *)msk)->sk_prot = &tcp_prot;
>  	return msk;
>  }
>  

Since you likelly have to post another revision of this series, I think
it would be better moving this patch before "mptcp: add statistics for
mptcp socket in use" - so that self-tests are always functional.

Otherwise LGTM, thanks!

Paolo

