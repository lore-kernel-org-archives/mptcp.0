Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4017187FEB
	for <mptcp@lists.linux.dev>; Wed, 11 Sep 2024 12:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726058527; cv=none; b=FjQVXAj6KqmVvrcpTc7vGCBxqbUNLvEjbfTmtOKmdPMvrr7M5hgEi0yBZ4DWYM2mihZ94MoYvm/8G+srVxVsCw9bLprB7/HPt9gzsUdEkTZrMnQdLDnZeYaN6/Eb7DUChD9BC6/3rq2ThYP4TJYWUyv2GTYaSDR99vwm9Oam2t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726058527; c=relaxed/simple;
	bh=68M9wWQ6D0/4boJfmPkluVdt1rWMxJpu6wIq5jUm6wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=coWS1I4CU9sHcSfgp9snpWFkdAM0fgAd+BZMsIp+ZMRXT5z0k8uae02ZrdvtZv/PQmg5T4edN2iHT5asV3c633kaZGjRWi96SJxOPtBRZk7ChsOpcf8/PrqgGgKP9rwenGwbsO+ws6jB+ABWyYZBCXA6BCSu99r5//7DqdS9cmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b2wL9wXW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b2wL9wXW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726058524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u0ptzBQhQOoA0oeKPkPmWFxxMGMZSMXArLR2ZEqlrxY=;
	b=b2wL9wXW74NHPipATGLUmFk+RI34c1G49BksEQQdCe+HtoXpGjftkFnh8Dl5xzXbBzdxWW
	y9jpypxdNjHfId13sxFM3EbQthSnBiZSphV9IkBxtzoBGeBSYF0ZnUiE3Qkb+YRVZbq88G
	+e33UzvlCF+0JKiKzg34jNsUMUQURLU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-PRb6tvr-MKSMNwxLBlu87A-1; Wed, 11 Sep 2024 08:42:03 -0400
X-MC-Unique: PRb6tvr-MKSMNwxLBlu87A-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb479fab2so4452905e9.1
        for <mptcp@lists.linux.dev>; Wed, 11 Sep 2024 05:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726058522; x=1726663322;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u0ptzBQhQOoA0oeKPkPmWFxxMGMZSMXArLR2ZEqlrxY=;
        b=HQwsxBFKinUe50hpkOO+4KmoQhNxAqp3qZWf3wMtcBr/6aO8o5J9O4VpPaqpx46dik
         pA++rugjfQ8p66Gb3+h6gIC+H59j5hhfoqN4wRJM4EK1t9Iy8ObOJdr2wXHX5z8Rv9s1
         jkiCbeClgvf7HP7Lnk1h6FOiL1KjyQqag78ErAZ8us8hC/pF33cjB9OkGxCuSYGFpzFU
         u8XaitYfrKK6mW9Po2VhWMP9wC5mjrMS7RHksQLvIDbLMDVPfIW0yvXxjOoONnIPFkKL
         XjTRsKC2dNPK144z2tC9QLT/bW0qHrX+FB7ypAQwh9Ay8yYtyVoB0WR55mBLba87KciR
         AAPg==
X-Forwarded-Encrypted: i=1; AJvYcCXs965NM8I6P4WltTzK4achZSD+oA6mmNGK/n092+0a8Y8350zjNXT40C+9Qw73Afzbdo9wlQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywg531R2KskJCd3Mz8n+fWDFZOCft3cGxwwO456KjCEyRWskSwA
	kyep29cD10HhE9EUViQ+mnUOtmZaiBLA3CVuN/Czv4FGrvSyVE07UD/8u9ReTp/0ZKU4hnq9uZf
	fc1ke0HvKxzu3pqPUrSMXLO5+K1JSqfcu1eGQshffw0e6cUYFsvoZ
X-Received: by 2002:a05:600c:3b9c:b0:42c:b332:1619 with SMTP id 5b1f17b1804b1-42cbddb7904mr38733145e9.2.1726058522434;
        Wed, 11 Sep 2024 05:42:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyWqZ1yjNpZ6SU2nZ/H8bqXLB+fc34r7zTlF3XmhhAnRSHVIk8h1MkTxjZqwZOwfY9aj9Ymw==
X-Received: by 2002:a05:600c:3b9c:b0:42c:b332:1619 with SMTP id 5b1f17b1804b1-42cbddb7904mr38732785e9.2.1726058521473;
        Wed, 11 Sep 2024 05:42:01 -0700 (PDT)
Received: from localhost ([81.56.90.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc01a8ee7sm58414305e9.0.2024.09.11.05.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 05:42:01 -0700 (PDT)
Date: Wed, 11 Sep 2024 14:42:00 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org,
	mptcp@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] netlink: specs: mptcp: fix port endianness
Message-ID: <ZuGQGPDUS6o2B5ai@dcaratti.users.ipa.redhat.com>
References: <20240911091003.1112179-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240911091003.1112179-1-ast@fiberby.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

hello Asbjørn,

On Wed, Sep 11, 2024 at 09:10:02AM +0000, Asbjørn Sloth Tønnesen wrote:
> The MPTCP port attribute is in host endianness, but was documented
> as big-endian in the ynl specification.
> 
> Below are two examples from net/mptcp/pm_netlink.c showing that the
> attribute is converted to/from host endianness for use with netlink.
> 
> Import from netlink:
>   addr->port = htons(nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_PORT]))
> 
> Export to netlink:
>   nla_put_u16(skb, MPTCP_PM_ADDR_ATTR_PORT, ntohs(addr->port))
> 
> Where addr->port is defined as __be16.
> 
> No functional change intended.
> 
> Fixes: bc8aeb2045e2 ("Documentation: netlink: add a YAML spec for mptcp")
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

not sure why we are doing addresses in network byte order
and ports in host byte order for endpoints. But it's like this since the
very beginning, so this host ordering in spec is correct.

Reviewed-by: Davide Caratti <dcaratti@redhat.com>

