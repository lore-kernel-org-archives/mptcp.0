Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2725D32ED43
	for <mptcp@lists.linux.dev>; Fri, 28 Nov 2025 15:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764342115; cv=none; b=RFtCpAJ8WzsmXz5s63z5ud8WTR74IcGhdGxAf4FaOD5EsqtrcoUmh1gIWG58rNmF9neLtlF3M4VilBcZqSDGXWqTFOxNNVQqiQ73Kfxv5zSKzNtx5FFbEnqAO4aAavWSxdcfNdiX3x6G1zq6cqR4GrhwqdRl92QnU5Z2TGQCSSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764342115; c=relaxed/simple;
	bh=KDs3ep7CXasOuqiuJKR8FpJdCxKw98JqC8dJhvClga4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CTyouuHzmnrgZDioVkkufK+D8Et6bHPjVbi2eX0/rzvhe6G2DGNBZGoCizgqr4M+a8/UicrElvWh8tWbhwm07qJrU8W4W1BAlwSewZQhwBC8dEyfAl0mTB9Zd7+0DRf0H0gYpnCXFkv9kuPFYTGXpHxVp7mc+Kv7XUsXLn361sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cr4oPQ4a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cr4oPQ4a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764342113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6/pQqBAPq3vU8DBviKSh7Ys6+IvHfB+6QxuWYuBevTs=;
	b=Cr4oPQ4aAlQJFGKmzeuCB8AO6Nu2Jz2qR2j/td0+zKF4MhqfEg5tdThFm0L6b2ACAbbZdB
	5Hpwk6mgw9YTFwRiGdY70ljG1quNLqXm/+751cWhxsYDbnNkP1VuG6IA65arIZqJ3KwgCm
	F01m2BT8V8bvfo/r+o2gKxVBCV88gl0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-Iieo3VbxNsCwy6kD73yTYQ-1; Fri, 28 Nov 2025 10:01:51 -0500
X-MC-Unique: Iieo3VbxNsCwy6kD73yTYQ-1
X-Mimecast-MFC-AGG-ID: Iieo3VbxNsCwy6kD73yTYQ_1764342110
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4775f51ce36so14806205e9.1
        for <mptcp@lists.linux.dev>; Fri, 28 Nov 2025 07:01:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764342110; x=1764946910;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6/pQqBAPq3vU8DBviKSh7Ys6+IvHfB+6QxuWYuBevTs=;
        b=bowmxDKPyrT5N/7oxT6WKq0166h4egGOBibYIDT2iKG8QhilKrYSoJQx4IxeavU6IW
         voNjiNoBHUaMf1U3+6jSIKzFiGlMQePDOyM6z122z/WLQ3qkZFGrZJ3Zai4rhJCgAY0G
         nr75pfT+H8cADa1ux/UHulOjRefSxCgjfJA1VsP4b1lNX0qcvcguMmulqAzokjQh/2Qw
         OhG5jAUrBz4O9RPhPgYrs77e3z4HKM++OcpgsmBs5ITWio6AjoPQQo+w+MfTN9+8nido
         +PFVzowGAWUJ8IPGBkfOL7Ve11ecrBSU4ylFuyMtdR4mzz7n+Fo/Hs9y9GvRCtcKTNBR
         bRFA==
X-Forwarded-Encrypted: i=1; AJvYcCXp0ZXAUrB7eZpInMnS7DfgOiujXlE26DAoPX4AnMhcXGpH3GQRbIW1o0d5PY9bjs8bFPT9bQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQT2XBQo6n4n0pqzLB+wwwMW2qiq8AQUjmOEMbXj6vQHi3DMSN
	t5rMA9XQ6Nhl3CTf/csg/yY74NlS6Hq2r2rmZtwaUTEJmEm6QGzaBrzik6hlfaDThbRRQ454whg
	kre64NgB71R/JBTo3si2KNOjCzdRDOXRJDSwToNynKx09PeOKr9aozahL
X-Gm-Gg: ASbGncuZoRqGX3RiNLYNeGy4Seo/pu/83IkLsMgu5Z6P7fBLQZlNI8x8cWxRV+ObjjS
	zssP8IKW7t7tZm0aAYY3tkx1MnmPPK4HtEIZS6f571ZrVDJCq7l7c7j+iy5QqW6fGZ/GvgFuN7M
	mtOmsaWhC9ZUs5i1hcSObga9RjOZcfvXULzeHeOG2VSPWrdSjtZ8ENd5ujRcp9DZSw8bb00yKpC
	VM80SAtqv7lJU3A+yQDo8vD6llmWIhEenXtEJOYMQMwwaYuae6FBBjkQvbmEGyvBQgNYRNJPr0k
	0UucBN/ErTnP5p9VYMBeUfeagwjbZPlrsfnuhkpwK3INRrbKXXxRQT/SCi4Mh1TrnNG3wZgbetY
	/H6etr5+uJDnmkw==
X-Received: by 2002:a05:600c:4f82:b0:46e:59bd:f7d3 with SMTP id 5b1f17b1804b1-477c111605cmr244812105e9.20.1764342110393;
        Fri, 28 Nov 2025 07:01:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEXctpRi0LI8K7QlBMNmqZNl2CfdTtmWNQ5kuKkOwn1Ip8BOqLNpFfWU19g8Z/qfbvzj0F3g==
X-Received: by 2002:a05:600c:4f82:b0:46e:59bd:f7d3 with SMTP id 5b1f17b1804b1-477c111605cmr244811615e9.20.1764342109897;
        Fri, 28 Nov 2025 07:01:49 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5c3016sm10367039f8f.1.2025.11.28.07.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Nov 2025 07:01:49 -0800 (PST)
Message-ID: <ad0fedfd-e25b-4054-aabf-ebac46dbbcd1@redhat.com>
Date: Fri, 28 Nov 2025 16:01:47 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tls: check return value of
 strp_load_anchor_with_queue
To: Geliang Tang <geliang@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, Hui Zhu <zhuhui@kylinos.cn>
References: <ce74452f4c095a1761ef493b767b4bd9f9c14359.1764333805.git.tanggeliang@kylinos.cn>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ce74452f4c095a1761ef493b767b4bd9f9c14359.1764333805.git.tanggeliang@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FHAoJDmqP-eJa3FhPCIVMBSzVSfbbKXkXIqO5eN7uxQ_1764342110
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/25 1:55 PM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> In tls_strp_load_anchor_with_queue(), when first is null, strp->anchor is
> not successfully initialized. Accessing strp->anchor afterward will result
> in a memory access error (for example, BUG: KASAN: slab-use-after-free in
> skb_copy_bits).

tls_strp_load_anchor_with_queue() has:

	WARN_ON_ONCE(!first)

and AFAICS all the tls_strp_load_anchor_with_queue() call sites ensure
that the receive queue is not empty before invoking such function.

Hitting the above condition is a symtom of a prior issue that must be
identified and fixed. Please try to solve such problem instead.

/P

