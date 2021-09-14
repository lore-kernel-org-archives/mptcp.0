Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EE83FD0
	for <mptcp@lists.linux.dev>; Tue, 14 Sep 2021 15:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1631634016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r9FgLX12RT/6RV2HSFTl9VhiVpMIFIlOqgvqSHqMzKI=;
	b=GPGpN3TZO5kS+k47PA/lDhihfKvARWNP+dYEFGjakBk7dSwgHUweOwyaMGDMIsZn783Hg9
	x8zfhxS3JDcol9HDskrgeRGuf9NV34G5lNY9iDSUznu/uOkm0RItUpFYxughjwyuJtAzBp
	/kx+2VhCNMlBTvM86nBv4hsOmI4SMkY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-AbYNsTExMYmUUeBkWUJbjw-1; Tue, 14 Sep 2021 11:40:14 -0400
X-MC-Unique: AbYNsTExMYmUUeBkWUJbjw-1
Received: by mail-wm1-f70.google.com with SMTP id x10-20020a7bc76a000000b002f8cba3fd65so860860wmk.2
        for <mptcp@lists.linux.dev>; Tue, 14 Sep 2021 08:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=r9FgLX12RT/6RV2HSFTl9VhiVpMIFIlOqgvqSHqMzKI=;
        b=CxztdLWPmLs/8w8pzoZ7LEdFE/LEgsZ/yZHSDynjUeP9lmvHcn7V9YP507Yd6aklsN
         BDiMU6FiHXSZfycf6vCUzKzWR+5r0i8s8UhCPlcdjczaEs5aOEjgpPdSHKkP+kS+p79Q
         KQuGlkdRrknsGjb+MQBjtJOUd6UKNu/nWVaEXXBhFEBRHy0Jxi6IU1AG6l1N0QpLBa8+
         WyAF1l6iPKryulAwUnAUBOAUV/mYGOAP7Nmfx0BjLKDQ9XBGAW/s2hCap7UxHxY7M/Hm
         h8CmpmsztZQw/RO6t7LsQKvaaX7RHs+4oYgYPCE+DNzj+4LLBIXTsqj25Uw476wTVf/v
         acHw==
X-Gm-Message-State: AOAM530owsOChL5e8JT7cDLLnqxqKQZQgHsxxBDyQGbLAEH3BEAtmOAA
	CUy8iHJjOvMsfr5wrBk6yIHZTIV5L26L4tnxz5Xd/MtF4BO3gWZcndVRFO/ePcBSA4wsHdkvdso
	umXFQGOrvGiZ6Hg0=
X-Received: by 2002:adf:ef92:: with SMTP id d18mr19784868wro.264.1631634013531;
        Tue, 14 Sep 2021 08:40:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqwMqjMFmN+MlOUf1jmbEopO10XBly3dx+evZ9ohhvlCbjthMRg8nNRqtYhijjNpw3rrtMcA==
X-Received: by 2002:adf:ef92:: with SMTP id d18mr19784848wro.264.1631634013325;
        Tue, 14 Sep 2021 08:40:13 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-254-211.dyn.eolo.it. [146.241.254.211])
        by smtp.gmail.com with ESMTPSA id f20sm1442692wmb.32.2021.09.14.08.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 08:40:12 -0700 (PDT)
Message-ID: <fe013dceb2b12f0b346557a1dee18971ce6d5c9a.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v3 2/8] mptcp: add start_seq in the msk
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Date: Tue, 14 Sep 2021 17:40:12 +0200
In-Reply-To: <7b4984f87a23369f9e4896d959945d01289a721d.1631610729.git.geliangtang@gmail.com>
References: <cover.1631610729.git.geliangtang@gmail.com>
	 <7b4984f87a23369f9e4896d959945d01289a721d.1631610729.git.geliangtang@gmail.com>
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

On Tue, 2021-09-14 at 17:19 +0800, Geliang Tang wrote:
> This patch added a new member named start_seq to the msk to keep track of
> the beginning of the last fully-acked data segment. This would be updated
> in __mptcp_clean_una.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>  net/mptcp/protocol.c | 3 +++
>  net/mptcp/protocol.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 71a5427609a9..e804ca0ac9e1 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1071,6 +1071,7 @@ static void __mptcp_clean_una(struct sock *sk)
>  			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
>  		}
>  
> +		msk->start_seq = dfrag->data_seq;
>  		dfrag_clear(sk, dfrag);
>  		cleaned = true;
>  	}
> @@ -2891,6 +2892,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
>  	msk->wnd_end = msk->snd_nxt + req->rsk_rcv_wnd;
>  	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
>  	msk->last_retrans_seq = subflow_req->idsn - 1;
> +	msk->start_seq = 0;

I think 'start_seq' should be initialized to 'subflow_req->idsn - 1'.

The field name itself is a bit unclear to me. Something like
'last_fully_acked_dss_start_seq' would be more expressive, but it would
not be a better name at all ;) Any suggestion for a good alternative
name more than welcome! (otherwise we could add some more verbose
comment nearby the field definition)

/P

