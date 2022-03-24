Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E7E7E
	for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 16:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1648140360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gmWLKTsN0RxD3ZGQht//c2O21f6lcUB8yu8WwzBWy/Q=;
	b=Sra9aVYybdqLrrLu0BdMP/q4HrxMIPunRzjIhF//kiz9as+GYWj+IGORPYuZ14CalN5nXa
	ar5dt+nApChtX+GpFMfgWNVhE1N8RHsGSbRE1J3gD8Kbz1jCUh4hmczQMkddICRx31RKzc
	DEkRmwBUbJvtp+ju8vF26Fb9IubCOOI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-tvWsOhQcODOTgYD9_rY8Mg-1; Thu, 24 Mar 2022 12:45:59 -0400
X-MC-Unique: tvWsOhQcODOTgYD9_rY8Mg-1
Received: by mail-wm1-f69.google.com with SMTP id 12-20020a05600c24cc00b0038c6caa95f7so1783975wmu.4
        for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 09:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gmWLKTsN0RxD3ZGQht//c2O21f6lcUB8yu8WwzBWy/Q=;
        b=Gj03eULrOqqEYyWruA9h4yTNqkZjbTrs3Cn46cFl6aOSC5cKOCFigE1yxWNfpa76gF
         GuWgpeMZv8VTunnYZ36rHXi5lUhqfuuONgkSpcU9KlYI5KNDBtPAxiJshryqVE73WeAi
         IPC/sOS91jEyxtr3GgGNzkxwuA6c1UZpkQL46gRFwGpln4usbs/2KuphEmsmG1jHLlra
         38JLHDkvT0gfhFsdU/bcrkg5GX+c2fCeHAJpWCW3pOJZYSYkeUmS4opYE6MYmbzBqySD
         XW7lZgiQOu5om/QaiLJE9pU0hGqZDePA/FFBOUPeAK32kIIpcw4NvOIMdq/I3/rmhO5N
         SkVg==
X-Gm-Message-State: AOAM530qbtaEJE8ignhU/puP1b9HPqfh1IGGFWIQSWdKw7qh4eEE0dUW
	PDUQbCT24bGLuPuSeRhyfxjCfVO4ozwmEiB1XOH8lRLT/Ep4wi3yMOfL2zp3atlQlAYW28Lm1Wt
	D4Jvbm9DbLSWG87U=
X-Received: by 2002:a5d:4570:0:b0:204:34e:71cb with SMTP id a16-20020a5d4570000000b00204034e71cbmr5350042wrc.129.1648140357902;
        Thu, 24 Mar 2022 09:45:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHY4z1w+NIZ8ReUVUutWwi/11Zhokb/qTjrJCP4WR50R1BxddP/VSdOrXYN1FPCTj9oY53dg==
X-Received: by 2002:a5d:4570:0:b0:204:34e:71cb with SMTP id a16-20020a5d4570000000b00204034e71cbmr5350027wrc.129.1648140357667;
        Thu, 24 Mar 2022 09:45:57 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-135.dyn.eolo.it. [146.241.232.135])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c028700b0038cc9bfe6a4sm2388308wmk.37.2022.03.24.09.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:45:57 -0700 (PDT)
Message-ID: <69492012a2c7630ff3b5c036992fbc497de2906a.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 4/4] mptcp: let mptcp listen dump show listen
 backlog size
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Date: Thu, 24 Mar 2022 17:45:55 +0100
In-Reply-To: <20220324135753.25182-5-fw@strlen.de>
References: <20220324135753.25182-1-fw@strlen.de>
	 <20220324135753.25182-5-fw@strlen.de>
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

On Thu, 2022-03-24 at 14:57 +0100, Florian Westphal wrote:
> Before:
> State   Recv-Q Send-Q  ..
> LISTEN       0      0
> 
> After:
> LISTEN       0     20
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  net/mptcp/mptcp_diag.c | 10 ++++++++--
>  net/mptcp/protocol.c   |  5 ++++-
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
> index 6a6dfc7eac33..e1babab45e86 100644
> --- a/net/mptcp/mptcp_diag.c
> +++ b/net/mptcp/mptcp_diag.c
> @@ -189,8 +189,14 @@ static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  	struct mptcp_info *info = _info;
>  
> -	r->idiag_rqueue = sk_rmem_alloc_get(sk);
> -	r->idiag_wqueue = sk_wmem_alloc_get(sk);
> +	if (inet_sk_state_load(sk) == TCP_LISTEN) {
> +		r->idiag_rqueue = READ_ONCE(sk->sk_ack_backlog);
> +		r->idiag_wqueue = READ_ONCE(sk->sk_max_ack_backlog);

What about accessing msk->first->sk*ack_backlog instead ? Are there any
possible subtle races? Otherwise sk_ack_backlog will always be 0,
right?

Thanks!

Paolo

