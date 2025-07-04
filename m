Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34262857FA
	for <mptcp@lists.linux.dev>; Fri,  4 Jul 2025 08:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751618225; cv=none; b=J/GmFbq1WbBdJ3egQJ5MPGeTp329Mp1NZ3BUM/rRuy6Ho+kBLycSSONrzJKlzQSP9Lcnx9IY9fuEenfLYsrn9UXLEaLR7J8Vrb6xnj356u9eiSWAuibMlD6gp9nDIrUSsQewkt0tdPdmuepx+WMN8Fq9G3TNXNJNK4seST/15k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751618225; c=relaxed/simple;
	bh=yx7DU53Yf7OjuG4J96383MWhWQk6Bqrkjpzg81VaVyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JdJhoEgBVI9mo0kSi2qoXbS5GPhe2qpBvr+ipPBid2n/ta5kXlH+kHGuHH2LTkFWoLz0ISKO39G3U0FsQYMxhNfoCI8hP66rudAXb8vGf6ea9uVhAPRi+Cp3Ai3A2qPZx+yAFnH71EL8gK3TnHLedLzESJcqf0obCYG1TwSLoY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qrup3gQE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qrup3gQE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751618221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GQUyID1sDkSw26qKaVTks98hpKIuh60IEEVyy+qwdUU=;
	b=Qrup3gQESlNb10/11e4MiGiyUbv8m8tTyxJeAtZ+4Qv0vrZ2MhDNHvVgABoipIK2izZmR7
	jEBf1vKYcrYyJ5+xPdIX6ZiDNGK6XxduaYGbmzInjvtC2O+wqBF599z6NiKQd2WsEQ7Nlu
	zFLX8lTieHI2JM4WXng4w0xBYUKljXA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-Khz8k6TKNRe3Sph9I1CsEQ-1; Fri, 04 Jul 2025 04:37:00 -0400
X-MC-Unique: Khz8k6TKNRe3Sph9I1CsEQ-1
X-Mimecast-MFC-AGG-ID: Khz8k6TKNRe3Sph9I1CsEQ_1751618219
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3af3c860ed7so276935f8f.1
        for <mptcp@lists.linux.dev>; Fri, 04 Jul 2025 01:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751618219; x=1752223019;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GQUyID1sDkSw26qKaVTks98hpKIuh60IEEVyy+qwdUU=;
        b=QlFS7yY684izgH0gdENiYTtZIbxA6DsT109GIsZf8vHdrmmx5nN19uXOhuSn5J07rk
         TWU15G+kEvU2zpk9x1c7O4xMZhb33RcxL7A+k4emRaGiWcWOihiDmN53rVK+LjJ/A7ED
         rtvsSf6D7/LS6TF0W9sBW6Wa1PjYsuipgNkE4ZGzykRJVR8xI2Un4tv6n5gTDOGqX9bX
         41TQQVLbD0f2Y2iKkN0zEyMRUeCz8eLG3m0cNYRdX23sClnQEYn02Yz3sfCZuWxQg/Pq
         ljek+Z6uFgtfjJF+gTKMkMXy5fxSL/FofdxHdAyfCsAJwbnJwrNnL5W4m/DKaoasD3+9
         Gs0A==
X-Forwarded-Encrypted: i=1; AJvYcCVNy+gGiD7K0pCcAklmUhecdxE1/7m+d0lwfV/766yg6th0SaV4js0xs9/YVHaF8jaYkROrFA==@lists.linux.dev
X-Gm-Message-State: AOJu0YysZ+sRAi43j3jFk4yEjBjN4Z3DujPI0rxazpI1bFE+aQIHPiJk
	ULkEKC7rak+LMspvATLb22F1W1fich9CLnXKc1myYyQ2ZXptJd1VZ16PHhYReYz6PwDvygP7b9+
	QPwHyqxg7J/c7HQoJ5a4tbCU1R1QWe+PnFwxxkEibLhna9OsYhdJZlA7X
X-Gm-Gg: ASbGnctXCQj4oLh5b4HVA+4nMRVoeGKWk9gQxzm8Ru6DzuBZNyzv4lQR5tAAIlGdSkt
	MhVTpyCIUXMDkRMhaxRlc79ci6D6O/DZ25tAuc8fnBoZFJ6RQOKJ+0lg/K/si7vdNt2vLdznQdX
	Nl5j030+xGGoy+3wGATrChyvw3wnwWYolFdoiPVjOFz7VlZ1sv5OI2QMnDRUkVSETDSUqpAyUYb
	T4j7hzAQxX4Jum212rnyCfo2q/kAzpSDK3txW/qSc/ytaKRpfOcuooZko9pLHWhOmnxBPRpsBIH
	+DHXV/9f2fgR5hFcFzhJIedRYIlQepjyaczHkHNFXAF68X6Bkg8q9yxZMFnKXcDCYqA=
X-Received: by 2002:a05:6000:4601:b0:3a3:7387:3078 with SMTP id ffacd0b85a97d-3b4970118a3mr740291f8f.4.1751618219251;
        Fri, 04 Jul 2025 01:36:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQ01HVuidLSd/9C8CDwmbZeiHph0rwZuR47B5yDtD2GaqG4xH4xFllFgOz/Ahqq0TUKu6PCw==
X-Received: by 2002:a05:6000:4601:b0:3a3:7387:3078 with SMTP id ffacd0b85a97d-3b4970118a3mr740261f8f.4.1751618218800;
        Fri, 04 Jul 2025 01:36:58 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314? ([2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9bdf038sm49464005e9.27.2025.07.04.01.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 01:36:58 -0700 (PDT)
Message-ID: <20fc2baf-70a8-48b5-a8cc-b292cfddf550@redhat.com>
Date: Fri, 4 Jul 2025 10:36:51 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v4 3/4] mptcp: set .splice_read
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev, hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1751039657.git.tanggeliang@kylinos.cn>
 <84557ee1e03cfe9172e5d52ad78cbf88d3711672.1751039657.git.tanggeliang@kylinos.cn>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <84557ee1e03cfe9172e5d52ad78cbf88d3711672.1751039657.git.tanggeliang@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fmnaWMVyiM6evWHuFIGYt_fWsWm5aOMM77QXM52c2d0_1751618219
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6/27/25 5:59 PM, Geliang Tang wrote:
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 10cc8756877e..33608404b871 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -4039,6 +4039,7 @@ static const struct proto_ops mptcp_stream_ops = {
>  	.mmap		   = sock_no_mmap,
>  	.set_rcvlowat	   = mptcp_set_rcvlowat,
>  	.read_sock	   = mptcp_read_sock,
> +	.splice_read	   = tcp_splice_read,

This is potentially a bit problematic. i.e. if some day
tcp_splice_read() will be modified to actually touch tcp specific fields
into the `sk` argument, it will silently break mptcp.

I don't have a good solution, but possibly it will make sense to have an
mptcp specific splice_read.

Note that most of checks area already coded in mptcp_recvmsg(), so
mptcp_splice_read() and mptcp_recvmsg() could use a shared helper and
not much new code should be needed.

/P

