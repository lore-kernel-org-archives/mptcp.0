Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0383965A
	for <mptcp@lists.linux.dev>; Fri,  9 Sep 2022 07:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1662708832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q7Tb50h6Mxkt55iWpan9/oENkhfa2BKLfN+6CLcdzUc=;
	b=cKgA0am1j9Tit2drXjLLFqA56HbP2lqmnpLR6y4+vzj2Z17qCt5h+6cQvWjsKrWBPpcww+
	lCp85sRlI6qpT3wb3hUGWB7Bgy6GKHnDrgjiEymQ7EXGy0vaXp7yv1P2MCAlq/LHMN8IAR
	NPeBSADgPz0b+TvEdwKaBBC0ElLeWXE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-492-N6RRBqI_Oxu2neI7beZhoQ-1; Fri, 09 Sep 2022 03:33:49 -0400
X-MC-Unique: N6RRBqI_Oxu2neI7beZhoQ-1
Received: by mail-qk1-f198.google.com with SMTP id bk21-20020a05620a1a1500b006be9f844c59so790769qkb.9
        for <mptcp@lists.linux.dev>; Fri, 09 Sep 2022 00:33:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=q7Tb50h6Mxkt55iWpan9/oENkhfa2BKLfN+6CLcdzUc=;
        b=cJ6tulzmElGb02cyQGJEBDycTL3disx0rACRvDBGopOjn8FvsJhe+92K7FnwyAigTi
         Jr/ajyYV6psrgpuQJVZaHvKCYyRkQkMUonX0QYFJFApajsHGqRcd12lUDX/v39GtWjXi
         771ExQ/keneLd4ws80cs6ZN7n+OQgCkv3NF+PdaGw3sVxW/ewPSYJREsKJCQIsD5hT4P
         F2bxvw+Z3VUg9NveAknqsuDIkfBY+jkM7Il0vTzqMTdxXMdrOjDQx3Po8WlIbhAZnmb/
         BOaB3xR/g68zyU2t96xPG7R+L2kTTt4IyO53TtWlh1qqnL64lLaoFZxm9jD7VxoOaXWy
         yOYg==
X-Gm-Message-State: ACgBeo0xVEVO6S6CCInJAll4J+i4fgKCnlwZhNfBm5MPc/POFJPLiv89
	zO0TZwt9MbKq7oJZ5s1xKqmVMa4uPLVtM0K7pBWo6eAqXtn0nV3R1DGQFd/VMhUUNuKSQO7nwFH
	61HKR3mPailROp/U=
X-Received: by 2002:a05:622a:1212:b0:344:6ed1:b49c with SMTP id y18-20020a05622a121200b003446ed1b49cmr11421774qtx.599.1662708828824;
        Fri, 09 Sep 2022 00:33:48 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5VRvMgrAVipnYY81BXaGaRKXiLA75ZsoJfKm4/7Qkf99kxJmAATIo/SAYbWHwqZ4zF/W4JPA==
X-Received: by 2002:a05:622a:1212:b0:344:6ed1:b49c with SMTP id y18-20020a05622a121200b003446ed1b49cmr11421765qtx.599.1662708828588;
        Fri, 09 Sep 2022 00:33:48 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-119-112.dyn.eolo.it. [146.241.119.112])
        by smtp.gmail.com with ESMTPSA id g8-20020ac81248000000b0035a79e18410sm1026592qtj.48.2022.09.09.00.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 00:33:48 -0700 (PDT)
Message-ID: <f200db2b725c1d453d3cc68e4dbeb0883a5d9f4f.camel@redhat.com>
Subject: Re: [PATCH net v4 2/3] net: mptcp: move mptcp_cancel_work() to
 protocol.h
From: Paolo Abeni <pabeni@redhat.com>
To: menglong8.dong@gmail.com
Cc: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>, Jiang Biao
	 <benbjiang@tencent.com>, Mengen Sun <mengensun@tencent.com>
Date: Fri, 09 Sep 2022 09:33:44 +0200
In-Reply-To: <20220909054932.246221-3-imagedong@tencent.com>
References: <20220909054932.246221-1-imagedong@tencent.com>
	 <20220909054932.246221-3-imagedong@tencent.com>
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

On Fri, 2022-09-09 at 13:49 +0800, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> mptcp_cancel_work() is simple enough and we can make it as inline and
> move it to protocol.h. mptcp_cancel_work() will be used in subflow.c
> in the next commit.
> 
> Reviewed-by: Jiang Biao <benbjiang@tencent.com>
> Reviewed-by: Mengen Sun <mengensun@tencent.com>
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---
>  net/mptcp/protocol.c | 8 --------
>  net/mptcp/protocol.h | 8 ++++++++
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 1cfb4f1ff4e4..d6eb033e93b9 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2656,14 +2656,6 @@ static void __mptcp_clear_xmit(struct sock *sk)
>  		dfrag_clear(sk, dfrag);
>  }
>  
> -static void mptcp_cancel_work(struct sock *sk)

I think it's better to just drop the 'static' scope and the function
declaration to the header.

This is not critical/fast path, so it's better to keep the generated
code smaller vs. possibly avoiding a function call due to inlining.

Thanks,

Paolo

