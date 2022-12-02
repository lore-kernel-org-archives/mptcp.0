Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EA62571
	for <mptcp@lists.linux.dev>; Fri,  2 Dec 2022 12:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669984671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=koOxf+WE5r0zm8YqSQbklNcBPyAv7LGFJSEGJZw9CQY=;
	b=d3mlW7aDxezhp4hjhZWFS97vtnZ+DfKre6Vo012i9OyUNaglFWk0gVH16oax5jXC+4mlax
	2E1u7UzwQig4469v9u/KnHVwDbzO/Xuik+k4FiyithKm/weKVaZQYUkyRXXVmCkL7iPhjE
	xzXw0O0kmHXT30k/bZKZ7B+8hGHo37w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-426-IcWuHPNHPBO9GJeH5PWNng-1; Fri, 02 Dec 2022 07:37:48 -0500
X-MC-Unique: IcWuHPNHPBO9GJeH5PWNng-1
Received: by mail-wm1-f71.google.com with SMTP id bi19-20020a05600c3d9300b003cf9d6c4016so4064977wmb.8
        for <mptcp@lists.linux.dev>; Fri, 02 Dec 2022 04:37:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=koOxf+WE5r0zm8YqSQbklNcBPyAv7LGFJSEGJZw9CQY=;
        b=dvS+BhgMirQyiVmse7p+F4jbE1u9+2tsfEA4JoDHNqa6M/qoVVIiojSVODkNuAysKV
         YUWC3G3B3ratrClYTRgVCKb4dCH4jX+HZ5zHvPlPXFF8Y2scRLfAp9OOFp/J1tLmuZE4
         iRVNTH0zv9eJS5HDpqvs54NQhOXVgXew6eOp4ceWn6ssNfQFbV6nerXX4e4ffiqRhnai
         xCnX4aE7nDvzZj2Y06AwX3y263ZemsB6jtaUCZ3yQ8CIFSQVRsnJ2OaLrOfdeiXQjmgy
         L+O/GDOC83oDPv1EzhE1Hbj0q4+QRaJ+TxTMcSm7nLoBhlNGhP7u7lNAePe7cZvgUXAR
         l39g==
X-Gm-Message-State: ANoB5pmSEyqC3TIwf/b3jrTbAbfjVAmhoOP6nIhG3WhF+vfIbvkZcwZ4
	J2YL/0J1sjOa5hV+WdyyMSHOe4TsZlWZNBw7YwzuNJSEZ4VnVFYjKpRFyTHlUgFhAC54uZxXD4L
	r9mxwZb0cB3Bb53U=
X-Received: by 2002:adf:a319:0:b0:242:45fe:740 with SMTP id c25-20020adfa319000000b0024245fe0740mr1589507wrb.408.1669984666947;
        Fri, 02 Dec 2022 04:37:46 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7Xzqrx7IfdhrN52RSeSYXTOMJy8CJks5mSoZ0UxgWcwkQyBag2bTsDZkap3+rYaPyJGz9I7g==
X-Received: by 2002:adf:a319:0:b0:242:45fe:740 with SMTP id c25-20020adfa319000000b0024245fe0740mr1589495wrb.408.1669984666714;
        Fri, 02 Dec 2022 04:37:46 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-203.dyn.eolo.it. [146.241.120.203])
        by smtp.gmail.com with ESMTPSA id q1-20020a05600000c100b002422fddcc94sm6333825wrx.96.2022.12.02.04.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 04:37:46 -0800 (PST)
Message-ID: <80c80e5c1813e7df9d15f89d13453f0dce4b8f2c.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v7 2/4] mptcp: add statistics for mptcp
 socket in use
From: Paolo Abeni <pabeni@redhat.com>
To: menglong8.dong@gmail.com, mathew.j.martineau@linux.intel.com, 
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>
Date: Fri, 02 Dec 2022 13:37:45 +0100
In-Reply-To: <20221122034923.804955-3-imagedong@tencent.com>
References: <20221122034923.804955-1-imagedong@tencent.com>
	 <20221122034923.804955-3-imagedong@tencent.com>
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

Hello,

I'm sorry for the long delay with my reply.

On Tue, 2022-11-22 at 11:49 +0800, menglong8.dong@gmail.com wrote:
> @@ -382,6 +383,18 @@ static inline struct mptcp_data_frag *mptcp_rtx_head(const struct sock *sk)
>  	return list_first_entry_or_null(&msk->rtx_queue, struct mptcp_data_frag, list);
>  }
>  
> +static inline void mptcp_inuse_inc(const struct sock *sk)
> +{
> +	if (!test_and_set_bit(MPTCP_INUSE, &mptcp_sk(sk)->flags))
> +		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
> +}
> +
> +static inline void mptcp_inuse_dec(const struct sock *sk)
> +{
> +	if (test_and_clear_bit(MPTCP_INUSE, &mptcp_sk(sk)->flags))
> +		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
> +}

What concern me most with this patch, is the need for an additional 
msk flag and the related atomic operations.

If tracking non fallback sockets is good enough for you - that would
probably make sense - you could place the sock_prot_inuse_add() in the
successful path of mptcp_token_new_connect(), mptcp_token_accept() and 
mptcp_token_destroy() - the in use decrement.

As the token is unique, it's creation/destruction correspond to the
creation/destruction of a non fallback mptcp socket. Additionally that
somewhat correspond to TCP hash/unhash operation, so it will match more
closely the existing accounting in TCP code.

WDYT?

Thanks!

Paolo

