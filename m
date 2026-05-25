Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E8D3D0937
	for <mptcp@lists.linux.dev>; Mon, 25 May 2026 08:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779697947; cv=none; b=qXqbti9nkIA+3Iassbo3IN0MyvYpcGUOyJL4DANt0CsAJ2SWTKU49YWef7XHswIfqpJA+VoLGPi+Ay6KIVOfWyghzPXKYv6AHFemEHSpuWPw9nZO9eLLGsgPNFFpWMPkBn0pOkjC0p6rGAUz2ubpW0yJQQ8cZbcWPk5tc2YXWZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779697947; c=relaxed/simple;
	bh=9SxXnLrzuKm1Oo4HIGOD5nXeRor32f0I7riDbBByC/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X5ULpNboE+KCUeMeFFCxNjEFnUyEGDcpfKIeegv3OE1HS4763tuFjAoZPx5WUcPkRqA7aSrtYdBU6btrsvHd/eIpS2XqzzuLeV+DeE5gr7NHYFn7oxMiLVZnKC4mjxc41PBiAkTGW5NKmYU6vNcHdKl2bbcbbTwqUupyYW9BPQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RJf+YhQV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RJf+YhQV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779697945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0gn8w/dLZnNvqa2nQqu0iy7F+1PKgXl2TGmK3DRniA=;
	b=RJf+YhQVYFvE/gTT7quJSrniEC4fEi29OXzBHxYjOlm1Hljs6u2EboY1CQf5nDCE3YK+Zp
	EmT4NDk5c7XS0u2mMcJAd/Mn7rT73Sr9Gr12rJVcbm5rX678fWJGQhm/i60Zcu+8SAJQ36
	Aer3fqWaBVVQnxxkNnsEmTAU2JfLNdA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-iqCnuMiDNFu7TLAJW6D4uw-1; Mon, 25 May 2026 04:32:23 -0400
X-MC-Unique: iqCnuMiDNFu7TLAJW6D4uw-1
X-Mimecast-MFC-AGG-ID: iqCnuMiDNFu7TLAJW6D4uw_1779697942
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48fe6894f3fso51971845e9.2
        for <mptcp@lists.linux.dev>; Mon, 25 May 2026 01:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779697942; x=1780302742;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y0gn8w/dLZnNvqa2nQqu0iy7F+1PKgXl2TGmK3DRniA=;
        b=MPZrRT2gZZSK0GIKrCG14l7EHUJ3mszKuwIglocvDD2aGvh95TMbAfwZy37EZxu+zB
         7DMRdwaOIdZUz+Oe3XT+VeU6eejuIea+ysd+opzcC5hf29BajMaqoOdZyl8cdXh+Mm6/
         Ooc8SO7grJi7Ixiz8+0A/xuWuHH69zkESju/kKYbcWFFJa08DQeo7EtXHGeGzPLfk9DG
         addXv7diR3mPg04+Wb6v3lK09zNbSKuM4EddvDANAcu1qedUZPaWfA//Qoe1dNMCtpnh
         P4o5LGxPP3A8+0qoyECTFz6uNZ+2Y/ICH8HVEfb0YODWUExV07+lyxqRbG+s7zlGNsCJ
         Wx4g==
X-Forwarded-Encrypted: i=1; AFNElJ9liFpsfLcKG7k82yvd2Z2+MjgBWoA3vkfA+f55ewaJ9llhAgPRPcv9HLaSulh4BmCCH/ty5w==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywal2Bou/0r271s5r2sRYgDRbjaTChzry2freBey8AEu1e2CCRb
	MvlMpZDiCmPYjgW+NDEB2+PR+/kR4ac05+seRf3H3dc4dGEWTc1k5ivjjgIG3hsNsjHkDuBM3JH
	LpAUySFgnRbqGvwYbELbdwap6h1KuhyebM3i6zuYbOvf79Ksyx58C8zBjJXN86gO6
X-Gm-Gg: Acq92OHRUtvMC8TjFpBkBUcBz070ZnMSo+wCG4AcXAkFEzsJ8UBV3ANkfAw8/UnpmVh
	RhNAINE+VwFQVUxgBHEpbkuFqT18h1wUFGz12ZAMKZ6KVcPPL5SnJw6/nGpP8cs97eNfDSROctL
	wK9jwxbSWsUyuj3WWlo8cj1Ii2hDB+SJFbLUOdI+tkIZgzbilrSQrcqy5I8RpNnhC3wA9eLGs7S
	GV7YXSJgY+lHWsiti6ja7p9e+Sqck7pujrnSlg7c6mCMUHP5ctV77zU0dnDaXZY82y16DqpPcbr
	XOsQ+aQzcYD6nk0AmlvX8WeWwjc6gpQQqadsKRnuDjpPVFkTbHVa8jPLFnXubpTEwNJcnHP8QdB
	GEo+bpVYSpQdIs9ChkBPZ59Pvt2Q58YYBAQozbYUJM3F/rwN9VvD118lcJw==
X-Received: by 2002:a05:600c:84ce:b0:48e:6db3:ff2e with SMTP id 5b1f17b1804b1-490426aba7fmr121960995e9.15.1779697941930;
        Mon, 25 May 2026 01:32:21 -0700 (PDT)
X-Received: by 2002:a05:600c:84ce:b0:48e:6db3:ff2e with SMTP id 5b1f17b1804b1-490426aba7fmr121960715e9.15.1779697941432;
        Mon, 25 May 2026 01:32:21 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454c60b5sm255194145e9.1.2026.05.25.01.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 01:32:21 -0700 (PDT)
Message-ID: <0887aa80-13c0-47eb-9178-a7f1cf9ba5e5@redhat.com>
Date: Mon, 25 May 2026 10:32:20 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v5 4/6] mptcp: reject sockopt requiring ssks'
 lock in BPF context
To: Gang Yan <gang.yan@linux.dev>, MPTCP Linux <mptcp@lists.linux.dev>
Cc: Gang Yan <yangang@kylinos.cn>
References: <20260522-sockopt_lock-v5-0-108629a46e98@kylinos.cn>
 <20260522-sockopt_lock-v5-4-108629a46e98@kylinos.cn>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260522-sockopt_lock-v5-4-108629a46e98@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 21ejMwyK0wS0HktU8OoowSwu14qn0AglTFLYWCf_CQ4_1779697942
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/26 11:12 AM, Gang Yan wrote:
> @@ -600,6 +609,9 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
>  
>  	cap_net_admin = sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN);
>  
> +	if (has_current_bpf_ctx())
> +		return -EOPNOTSUPP;

I think it would be better to move the check earlier and drop the
previous patch.

Possibly it would be considered avoiding touching in patch 2 the other
functions where EBPF support is disabled here, but I have mixed feeling
WRT this later option, due to code consistency. Not a big deal either way.

/P

