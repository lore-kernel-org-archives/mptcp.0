Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008AD2309A9
	for <mptcp@lists.linux.dev>; Tue, 12 Nov 2024 11:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731412556; cv=none; b=cikyU34cof21OEn7RWim17UF+uXssEtPW3Iym4EnyiA1TZQ0bDx9w6VGAXQ3IARYZZU7qVMQAkq6PEPDT8jipUHYyPi9lfKsSOd2kEj5TAsFdPNvvjbjAT9B4cgYMZxVynJj4UOrll3NYeXUQh7Ttd+kjXZtt2vurLzTfFtyPow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731412556; c=relaxed/simple;
	bh=RAnrM8rdx52Q2UP6GKYZWpJm6rC3fqhyPtxUVzyayys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mt/K1kQik1mJB557welLvip8DGeIZcKSORSiOzWbjSzjJOZcLfcpbJcjPsFIzQ9z29VbLjQqLvKrXO101D3BpesmLaf22VZP1mHSSDP70a7shh+B/AE5maTZX0gpypUglKN1/dWyHXfVqvwMYpD6K8uxUyT840beBsXgl9mPZVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UAlkqYpy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UAlkqYpy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731412553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bd9qc51re6A5a6FAkiNj1HI8rqia0+AfoPF7/bIZCmE=;
	b=UAlkqYpysRuFx+UY6zNYDMoUWhmy9gzFsqUQLZxJ2C4OCecClNHXPYJNdVQgQpeU1hKJYm
	SuOJPfZmoFp+FT//f+AxOEkNGRyfx5TU3eej1caXC2mUbp130Pnp3JMoSbzGDVOX6VVEQB
	DihpXEUuyyIiGl2rZvkawThEkkf0JKM=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-ExFo-OxvOGyZs7mabkmh1w-1; Tue, 12 Nov 2024 06:55:52 -0500
X-MC-Unique: ExFo-OxvOGyZs7mabkmh1w-1
X-Mimecast-MFC-AGG-ID: ExFo-OxvOGyZs7mabkmh1w
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-6ea90b6ee2fso94587457b3.1
        for <mptcp@lists.linux.dev>; Tue, 12 Nov 2024 03:55:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731412552; x=1732017352;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bd9qc51re6A5a6FAkiNj1HI8rqia0+AfoPF7/bIZCmE=;
        b=HMbG0c1/e5IeLQxWlEp0YYeUUAjqaQG2rZWpUPI3LavUIrgmXvq/pM2mrC09udyKuS
         JrwaeDJZEmOo0s0CObAHx8lgjoQc6UesL/vtvNuWnhBhO2lGXXLAAV71tj8Iy83RLYrH
         uuGfzu+rZHGlu5oMGFEhHKaaup/x4gLAEzU80Mxjm5RCc5Dk/wy0oSaCuggFUjMpCjXB
         qqFnks0dLFAtq0VmtedfO8/QMM7WGSZUIkyDKLWuCyr1yTtu5AAfinXtByIwvfAsZGdb
         WmvzgNMoHgIS5khJtLL8Z3RsXZIUxNChYqFq5FMjQzT20sZg9NMwulpSKAScvAbwJdH9
         pMZQ==
X-Gm-Message-State: AOJu0Yw1x70ikv+l0swzV2qF+2PFQnr+FQaXAVX6qiLscN2ajddeK/gC
	4amH76/ptIFmaBAG71f4EABb7OeCaoE/BCpWNJeTBVmsyw037t/0QaIFTPTsbnJrg/LGMZkPMWg
	hnyS0TVdSqgz/qF9L8SkQZMoE5HCocwvFt7Woj0toE+D5lavz3ZOa
X-Received: by 2002:a05:6902:1826:b0:e30:cd98:56dd with SMTP id 3f1490d57ef6-e337f8621d9mr11135351276.19.1731412552094;
        Tue, 12 Nov 2024 03:55:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExxsL8KQH6sSlTqzq5ybTHyM0xyItjc9HT4wepfzFL7i/TIMY1vaRLkkc9Foohkv+wz8eXKw==
X-Received: by 2002:a05:6902:1826:b0:e30:cd98:56dd with SMTP id 3f1490d57ef6-e337f8621d9mr11135336276.19.1731412551763;
        Tue, 12 Nov 2024 03:55:51 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff3df16fsm74010941cf.14.2024.11.12.03.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 03:55:51 -0800 (PST)
Message-ID: <c882e54c-34ac-4258-83c8-d900c3893a4c@redhat.com>
Date: Tue, 12 Nov 2024 12:55:48 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mptcp: fix possible integer overflow in
 mptcp_reset_tout_timer
To: Dmitry Kandybka <d.kandybka@gmail.com>,
 Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, netdev@vger.kernel.org,
 lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
References: <20241107103657.1560536-1-d.kandybka@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241107103657.1560536-1-d.kandybka@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YrMAV9JoZ4LmNGVcpy2Q7xFqLzehZapZ4sWxYS2_6zI_1731412552
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/24 11:36, Dmitry Kandybka wrote:
> In 'mptcp_reset_tout_timer', promote 'probe_timestamp' to unsigned long
> to avoid possible integer overflow. Compile tested only.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
> ---
>  net/mptcp/protocol.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index e978e05ec8d1..ff2b8a2bfe18 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2722,8 +2722,8 @@ void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout)
>  	if (!fail_tout && !inet_csk(sk)->icsk_mtup.probe_timestamp)
>  		return;
>  
> -	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies +
> -			mptcp_close_timeout(sk);
> +	close_timeout = (unsigned long)inet_csk(sk)->icsk_mtup.probe_timestamp -
> +			tcp_jiffies32 + jiffies + mptcp_close_timeout(sk);
>  
>  	/* the close timeout takes precedence on the fail one, and here at least one of
>  	 * them is active

The patch makes sense to me. Any functional effect is hard to observe as
the timeout is served by the mptcp_worker, that can and is triggered
also by other events and uses the correct expression to evaluate the
timeout occurred event.

@Mat: are you ok with the patch?

Thanks,

Paolo

