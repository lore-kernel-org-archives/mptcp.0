Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEBC3D3486
	for <mptcp@lists.linux.dev>; Wed, 29 Jul 2026 07:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785311194; cv=none; b=bJ/dP9qDpqOhgx4I8ynoXp94w4UL6HPQXq2IPIZ0+qfmYHgsVpE0/pvXODrtTdLavoowV7RYXMWg0/DIxOGRC7CDhmhSEYRkhol4ILFQAI4+74WWO+cWhtCXAXIxCnC96FrHSdI3Jr9jcBAwsOpTd2xxJK2bs31Vh4LaLEM+aPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785311194; c=relaxed/simple;
	bh=U82mtJyYmBIfql5BBKsGAzLd559RDXNGi6G3qG8P/oA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t4OylDAScxALttYMKM1a67hlBNjVKS72sUzD4f0eizsKdX/7PBDTqHxjczoWSs/Aht5vNWqlmITVaU7GunzG08+yJHsb9e5FIn7lHJItJMWp4DMmWmG6O4t1w+aZKAb0soHuZ7dHXuYL0jiJmWBHOatRrKb7BfDu6fjmuujtm0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DlR11zIi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DlR11zIi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785311178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8g8N3C2agRbTjD+Ssp9W+1TONYuLl+jzcAVZX57jw7k=;
	b=DlR11zIi4eIUrsaZAj1xI+wK7jQLOA2nqtgTMsj1A84ahXMQ1iChTznWILwSOY5pGdP+Wt
	wJ86ule7eJdsHf6aF7NZ9dC+jo6OSoUJKKtqub2bGSO/zub56492bgO3oau0+a4urH356C
	ngUheJJEfRGu0KahQCuSqXbXQ8yU6S0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-ZUg4U0DDNUOsN7iBTIXLsg-1; Wed, 29 Jul 2026 03:46:16 -0400
X-MC-Unique: ZUg4U0DDNUOsN7iBTIXLsg-1
X-Mimecast-MFC-AGG-ID: ZUg4U0DDNUOsN7iBTIXLsg_1785311175
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f4bff865cso447949f8f.0
        for <mptcp@lists.linux.dev>; Wed, 29 Jul 2026 00:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785311175; x=1785915975;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8g8N3C2agRbTjD+Ssp9W+1TONYuLl+jzcAVZX57jw7k=;
        b=HTAaMFpEDPZs1yyIuH4voBTxdllcsOrYWkge0W81nlSH3KF0reBua4l+Q1U4v1sHJL
         H9+DFE3E7Usr8VUczpqSvAkC02HvPCUarECA28uPz4A0F2dKY2zQx5XOIO9iSVCw8+tK
         4BD840XEKvh+bH0zm3XLzO613YfdZaHDQoiHfVcvmeM0BISUX4oTWogXzWSAEFhYWeqo
         QczTKgrw0jrSk7pYnJyXaVcbLJzYcUvSPo3sN/r1Cs4xg53dJtUy3xU5nGoX2V2ySSls
         n6Ee0M5+22tGPHYZnAfXJAwbD2HVhk6hsNpjBexCgVR3tiuwAILZLctvOn04/fFpt/Y3
         QCfw==
X-Forwarded-Encrypted: i=1; AHgh+Rq+L45uBRmKVpG+BjafFPlRb/9/y+lOOV5HLLdoTVwmovWL1LyuBvJIXrTGkTm6vOsq9+pUyg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNFX8qllKrIx6Ut1v8a6FkIQjAWl2A0nj8mRdecL5ZIiLASvGk
	7y3KCJX+1VB2KNq40GWBmw4LrNjLHxkx4d5EMWm97pHI+nn2aoOYYjyrmu4lMqAlU4Sbw6P04BG
	ETZWQ8o0v4TZrYsWi7NXh2JR8GuhEnf2sQ4tscnXpmhxQAbs4D7bvoVAw
X-Gm-Gg: AR+sD10ZER2bknRDy+Z+OaRG2dorjJGFlVsTWO3E/jn9sRkYkj0TLpUDwyOffCWgFnj
	enAxVJlr04oHCUwevX5jJ2yH9QfQ1iPOkKM0zZ1FhkSt1KA9hcMF738GcmmxMvRMoutXjhFeUjG
	9alBQChNBM+8psJC4VpKaX/sfJlsIeGP3ExvJgWoLHkff/mNfQtqFs97mdLJsTSguWeyz1iiUQk
	FfoDgkPJS2oFUcoyEO4d2h71k3Q4LUUV3EpnNwJDqIAFuwbWKGsWnjJT3GpGc+RSWYwH2+TjFoS
	9KlrTkrxOc2+RL+5DkjpDTY1+Lb5ECEYLLwFA38PDWlSYk0qxRqHUGSHs7hejA0kzJncpuCjYzI
	35iZn8sniyOFINh4EyKIvoSuwLfbiYY6Bx07iM6DhKnli+woAXiVTzS0MCcNoHZIq5fNImQ9ZzF
	tGBA==
X-Received: by 2002:a05:6000:290f:b0:47d:fc23:abe8 with SMTP id ffacd0b85a97d-47fb1f125a8mr5991541f8f.28.1785311175555;
        Wed, 29 Jul 2026 00:46:15 -0700 (PDT)
X-Received: by 2002:a05:6000:290f:b0:47d:fc23:abe8 with SMTP id ffacd0b85a97d-47fb1f125a8mr5991508f8f.28.1785311175143;
        Wed, 29 Jul 2026 00:46:15 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6abc703sm5919191f8f.9.2026.07.29.00.46.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 00:46:14 -0700 (PDT)
Message-ID: <69387199-6498-47d9-90c6-aec7556eade4@redhat.com>
Date: Wed, 29 Jul 2026 09:46:13 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v11 1/4] mptcp: sockopt: factor inet_flags
 propagation into a mask
To: David Carlier <devnexen@gmail.com>, mptcp@lists.linux.dev
Cc: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org
References: <20260531145955.322337-1-devnexen@gmail.com>
 <20260531145955.322337-2-devnexen@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260531145955.322337-2-devnexen@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: U0offnQFWMibkWIqCedRXXD3eXBccbEqx8yTabGI65k_1785311175
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I'm sorry for the prolonged lack of feedback: persistent ENOTIME here.
This iteration LGTM, with a few nitpicking that possibly could be
addressed at application time, see below and next patches.

On 5/31/26 4:59 PM, David Carlier wrote:
> @@ -1551,6 +1555,9 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
>  {
>  	static const unsigned int tx_rx_locks = SOCK_RCVBUF_LOCK | SOCK_SNDBUF_LOCK;
>  	struct sock *sk = (struct sock *)msk;
> +	unsigned long mask = MPTCP_INET_FLAGS_MASK;
> +	unsigned long src;
> +	int b;
>  	bool keep_open;

Ordering above.

/P

