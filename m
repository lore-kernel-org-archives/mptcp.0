Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696FEA4F
	for <mptcp@lists.linux.dev>; Mon, 21 Nov 2022 10:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669025003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zx/j+/5GM/G9S7TLzhJ+nFTDW9aLVYt/HcLv9HjfphM=;
	b=LJJPrU/+Wl2zRqxLTI1bkwg0c4WuF3AvC91ZELCOqhafFpP2veDQjeE/kjCJO2iAzdVVjt
	D8WFNgHDTZrHsn7F1GygNph0DH3toTU3QjttF/BnKmOxJ4j2b9sfwFz22G79egeSONsdsq
	WDm+Btv9LY+/eDFuc2j8cYq5eEs/ArU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-22-gguJJqA6OwSq7ggF_c4oew-1; Mon, 21 Nov 2022 05:03:22 -0500
X-MC-Unique: gguJJqA6OwSq7ggF_c4oew-1
Received: by mail-qt1-f198.google.com with SMTP id c19-20020a05622a059300b003a51d69906eso11522902qtb.1
        for <mptcp@lists.linux.dev>; Mon, 21 Nov 2022 02:03:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zx/j+/5GM/G9S7TLzhJ+nFTDW9aLVYt/HcLv9HjfphM=;
        b=m7mmmXTSJdhn3MP46KYZ2cW1sbGqQ+lfwoG2BepKxnFW4X5mZLI+Rze+7xCdyqLZGo
         PhEGZ+lk42SQL8C31p5YYwg89hTorFrCp3hg/UUCRfPhs9jUVgD6Vr0zNCIL9w6rUPtS
         USgnrt0CE3kfiB4HC4q+At1c5yqsYD49pExJc/u9YPKSpGGbwDthJmitzQbGQscfX+62
         DjA13lVDb+hErOl0wt8EHreRUqi8PGxWdEPcaEMvfCmw8P58P2BDJ7llcsxn94Tt/p2u
         9j/MFFti6b6aa61luTFScWER3HwG1O7yp0tpcCszEOGAF+H6qUzwYC0Ehar/AUzgKUR0
         7GMg==
X-Gm-Message-State: ANoB5pl2vsYPkLgyvAMJ+5ipSFOCWSD+ioqAj0zScuIedZoDJr0fMvY4
	N2swzWGfOi4DFa+gOejfJ/9md1PI3JT7M0KXWigbxJ884XNXKeYPKifQ2scKKyLtLHOw1pcbQnA
	TB6PVdmQBrb9bung=
X-Received: by 2002:a37:bac5:0:b0:6fa:f354:939f with SMTP id k188-20020a37bac5000000b006faf354939fmr15595940qkf.57.1669025001654;
        Mon, 21 Nov 2022 02:03:21 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5uQLi+T7hpd2V1XzNQwRNJrZyIHQiJIk34acmzu7zSqljuKew18CJ/C1amdThHsiR/xGRq/w==
X-Received: by 2002:a37:bac5:0:b0:6fa:f354:939f with SMTP id k188-20020a37bac5000000b006faf354939fmr15595920qkf.57.1669025001372;
        Mon, 21 Nov 2022 02:03:21 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-203.dyn.eolo.it. [146.241.120.203])
        by smtp.gmail.com with ESMTPSA id f1-20020ac80681000000b0035cf31005e2sm6456114qth.73.2022.11.21.02.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 02:03:20 -0800 (PST)
Message-ID: <11f993d24e509bd92e850415e6c96975c40a7460.camel@redhat.com>
Subject: Re: [PATCH mptcp-net v2] mptcp: don't orphan ssk in mptcp_close()
From: Paolo Abeni <pabeni@redhat.com>
To: menglong8.dong@gmail.com, mathew.j.martineau@linux.intel.com, 
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>, Biao Jiang
	 <benbjiang@tencent.com>, Mengen Sun <mengensun@tencent.com>
Date: Mon, 21 Nov 2022 11:03:17 +0100
In-Reply-To: <20221121034140.548112-1-imagedong@tencent.com>
References: <20221121034140.548112-1-imagedong@tencent.com>
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

On Mon, 2022-11-21 at 11:41 +0800, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> All of the subflows of a msk will be orphaned in mptcp_close(), which
> means the subflows are in DEAD state. After then, DATA_FIN will be sent,
> and the other side will response with a DATA_ACK for this DATA_FIN.
> 
> However, if the other side still has pending data, the data that received
> on these subflows will not be passed to the msk, as they are DEAD and
> subflow_data_ready() will not be called in tcp_data_ready(). Therefore,
> these data can't be acked, and they will be retransmitted again and again,
> until timeout.
> 
> Fix this by setting ssk->sk_socket and ssk->sk_wq to 'NULL', instead of
> orphaning the subflows in __mptcp_close(), as Paolo suggested.
> 
> Reviewed-by: Biao Jiang <benbjiang@tencent.com>
> Reviewed-by: Mengen Sun <mengensun@tencent.com>
> Signed-off-by: Menglong Dong <imagedong@tencent.com>

Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
Reviewed-by: Paolo Abeni <pabeni@redhat.com>

@Mat: could you please add even the fixes tag when applying this one?

> ---
> v2:
> - setting ssk->sk_socket and ssk->sk_wq to 'NULL' in __mptcp_close(),
>   as Paolo suggested.
> - remove the unnecessary 'SOCK_DEAD' check in mptcp_data_ready()
> ---
>  net/mptcp/protocol.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3796d1bfef6b..a4fd971a7aa4 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2352,12 +2352,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>  		goto out;
>  	}
>  
> -	/* if we are invoked by the msk cleanup code, the subflow is
> -	 * already orphaned
> -	 */
> -	if (ssk->sk_socket)
> -		sock_orphan(ssk);
> -
> +	sock_orphan(ssk);
>  	subflow->disposable = 1;
>  
>  	/* if ssk hit tcp_done(), tcp_cleanup_ulp() cleared the related ops
> @@ -2940,7 +2935,11 @@ bool __mptcp_close(struct sock *sk, long timeout)
>  		if (ssk == msk->first)
>  			subflow->fail_tout = 0;
>  
> -		sock_orphan(ssk);
> +		/* detach from the parent socket, but allow data_ready to
> +		 * push incoming date into the mptcp stack, to properly ack it

Nit:                             ^^^^

should be 'data'

@Mat: could you please fix it while applying or do you prefer a v3 or a
squash-to patch?

Thanks!

Paolo

