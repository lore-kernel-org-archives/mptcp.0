Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321B940DB57
	for <mptcp@lists.linux.dev>; Mon,  3 Aug 2026 13:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764577; cv=none; b=PwT4vtgYjFjZhtMejoavT0kxwz3BzP9wNiyCRTVKSOUy9jcvxeapLSzm28+5MEYG9rDkwuv6+KIHvbCQ1/Yt6AV2ZFjuWzlJ3H+hPZTeGypNaHugkEzzUNSUml+WAcs9xHqi/7RQ3ZO/IabCwtXQu8siatD0Y1N8LbE9Q4CS84c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764577; c=relaxed/simple;
	bh=7hgNn5i2CXZAeHNCzJI18FtpzkKrFl/iGqxowaJ9TbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bY5VUMb4Nuxkfciyjjb2ICf63YcF+S8hVAZgiJRfMOESVkbGFCT+isk4zH3JcpgCcNrfgfFJ832o9kQv0fbqsqicvzDGVj5jiad1bjAylje1T9Rc4YXegS+IUncWlFxLQJOr1nazJBjWwxqdgITVqJu4m+iwWoYhnSzTQdhwHfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eZHH29ah; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZHH29ah"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785764574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q9mewyqdJBERhE/mcQ+h6iaGDeJtrxCLQvnbpvnUU7Q=;
	b=eZHH29ahoYvKuS4P+4ObITDqw/lthXw83Uf89FNzY0qU7iLUFJg+VeIoTDtSYXV8o0gl3l
	wdti/g+A40ka/9E7VmXnvZpr2TjTntILYESnMOT7PpQ9uDy6AhjOT+sLCUJ8Z0mwvSdV0g
	L2KDrSsXw37PyuxpS5644lheD7Kr8eQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-gd3K3vXlOS2UWxt6p8LHYw-1; Mon, 03 Aug 2026 09:42:52 -0400
X-MC-Unique: gd3K3vXlOS2UWxt6p8LHYw-1
X-Mimecast-MFC-AGG-ID: gd3K3vXlOS2UWxt6p8LHYw_1785764571
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49544a639e9so11280495e9.1
        for <mptcp@lists.linux.dev>; Mon, 03 Aug 2026 06:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785764570; x=1786369370;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q9mewyqdJBERhE/mcQ+h6iaGDeJtrxCLQvnbpvnUU7Q=;
        b=R2IQdOGRLRXNpARLwuVdlJUtNMKq5kfSk0Yt3bFFZCZeXNRX/YlIfAewn/WxptFM7e
         4tjOShRHjPfwKIhu1G3vWKFuFZPokQBq2LM6WXYAe3dMl8q4w5/QGLKiHfAo6gux8PQ5
         FQNuA+KFKyEu+810kf0JVnz+sh3Sru2lpeTWu8NNBoh9v+Dpk6gHbdUj3oVUWKVyrTy3
         3lXDujDnKci2/8x7ZOZWMDdCuM7BDVDjIQYvyqX7141NcFP+Q8ZkJCFQmYZtbfKvprRW
         BKXMdOZ6mnx7xoPw0QoexK4L+jXo0gamtDnCjC6mhixxAlwhBe1X0fmc/Ed31SE56zrQ
         PLjA==
X-Forwarded-Encrypted: i=1; AHgh+RpTeJItER9xUdglHhhSOUvIfxU9CIX4ZQoL+94LDacAbYOpaf2lV9/lnrbzoaDGp+ZccmdQLw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzF/QLxfACES/39DGJfY5hfxHP0/UvkXKGhIFTcg/rLAltafVPt
	Yp3O3w69Jqv0O4J3irHrXZllqDxaGe86AhEYOKhn+7oMl5SZwgegifRDWe0GiYmwofy2zvW52G5
	H2zFzHmvk/YQE06FTl7JICejRFo/477LNQW/HRSspMQfOy4STAWVfemz/PvGpKS6q
X-Gm-Gg: AR+sD10POWqz+vayuZsltwLGPeYUKEWv+neSurdpGxJxjgmRyJcuGGQx93GpcWU/3KJ
	Ikj2qUDCsXKQi+UM9WG9OIkI+htdzPJJXgNfJ0aza4sOZpgp5TO/g+jw2NU1hV9qIkay+IgrB+T
	WpVLaoJSj24NQIKi8THk1Y8uADOq99KQkuV229YZjmbTW0QVhqnmFqHenqx76meyHW7YBZOlMc3
	csmX/0PJrRHAUVp6d5FdeUjMT8nG9RTEsi6XRnkSv056Xh3cHx/YrO2yPkSMOv4Wdk+0qBUxPNm
	JTHcTR89PMfFHkJuJPzujz6ds3ZY8ArdwKgNyFSE9znmpfOKgrpj7+94KBOnkYMZkdR2/5TaRYs
	ZIFgmsmQ17KldgYWfVN8W7kYbmS0K59GnY0eP2jSfIJbr3Mvf8QIYcBJcPBHjpi+fyyWBfcQegE
	8=
X-Received: by 2002:a05:600c:4fc5:b0:494:6baa:ccef with SMTP id 5b1f17b1804b1-4980f23257cmr218813035e9.11.1785764570719;
        Mon, 03 Aug 2026 06:42:50 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc5:b0:494:6baa:ccef with SMTP id 5b1f17b1804b1-4980f23257cmr218812405e9.11.1785764570346;
        Mon, 03 Aug 2026 06:42:50 -0700 (PDT)
Received: from [192.168.188.217] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458b73asm31017655f8f.29.2026.08.03.06.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 06:42:49 -0700 (PDT)
Message-ID: <22c1fffc-68c5-44c4-a686-6642e4af4234@redhat.com>
Date: Mon, 3 Aug 2026 15:42:48 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 5/5] mptcp: implemented OoO queue pruning
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, Gang Yan <yangang@kylinos.cn>
References: <20260731-net-next-mptcp-oooq-pruning-v2-0-24838164fa21@kernel.org>
 <20260731-net-next-mptcp-oooq-pruning-v2-5-24838164fa21@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260731-net-next-mptcp-oooq-pruning-v2-5-24838164fa21@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i6n-h-aRbHAx99dGFJ4z-reAtZ1U8iXkp0ittc5R-nE_1785764571
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/31/26 4:24 PM, Matthieu Baerts (NGI0) wrote:
> +/* "Inspired" from the TCP version; main difference: stop as soon as the MPTCP
> + * socket is under memory limit.
> + */
> +static bool mptcp_prune_ofo_queue(struct sock *sk, u64 seq)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct rb_node *node, *prev;
> +	bool pruned = false;
> +	u64 mem;
> +
> +	if (RB_EMPTY_ROOT(&msk->out_of_order_queue))
> +		goto out;
> +
> +	node = &msk->ooo_last_skb->rbnode;
> +
> +	do {
> +		struct sk_buff *skb = rb_to_skb(node);
> +
> +		/* Stop pruning if the incoming skb would land in OoO tail. */
> +		if (after64(seq, MPTCP_SKB_CB(skb)->map_seq))
> +			break;

Clashiko noted that duplicate/old skbs can reach here, leading to
serious damage. It needs to be fixed.

It looks like opus-5 catches a lot of things that previous models (and
humans) were not able to see. It should be a :-) but it feels more like :(

/P

