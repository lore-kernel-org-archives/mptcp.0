Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878FB215F63
	for <mptcp@lists.linux.dev>; Wed,  2 Oct 2024 19:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727898117; cv=none; b=nWx9AFmIihjkcNzPl00G1uV/ycQxO8OaPWJ7JU8p27Objpg5hq3GbMtTAwvj56C3PYhqfws8v8uwWn+OGnJ0i6gF5OdBxK3Pu+qK9EjaCVqRk3tYqyWP5A4F4lbqfo04+HXR01yFimH4JXqdzPnKGoTeo5eVbalrZIYiUItnOVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727898117; c=relaxed/simple;
	bh=j0qrt55x7q+Jvj39oTHItc3gMQ2rO9gcxh/OjHuLBNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LS9daMf9Ez2QoeBtBF9QrVwcCzb4jw6/56db9JfI/TWw6Phm9JjUxr4MiSo5pfoOLmHx4xGwXDPv1EFWFcCJKmFJWWLhjmNPHgX88M9BwAcpqMrhXW38si3BSimneL9gMwgRZm6nHpvU3fCDLvyWshE7LU8u1iRrov3u65P2134=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P/naO05C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/naO05C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727898114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vqf/deMM8dThl/qKc7cKVuFjMB36wYSBF543N4jltcs=;
	b=P/naO05COCLIyR5gAQ61OEUFILEiiyukmKp5UGZ3JFFePQsnEuCEHBgxuuA0S2BqqOEwsh
	wJsQK2ZHUuVZrz37zGwczTtB8LGvbTYJDb7ms/fXB2pfjcoiifMX05RrlwRdgGqp35yYTw
	mzutJ+jIE3rjoBGUZMQu2FjP8cVUIg0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-3RoqnGDoM3uPb8YWVoZVXg-1; Wed, 02 Oct 2024 15:41:53 -0400
X-MC-Unique: 3RoqnGDoM3uPb8YWVoZVXg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a93d0b27d37so7132566b.0
        for <mptcp@lists.linux.dev>; Wed, 02 Oct 2024 12:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727898112; x=1728502912;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vqf/deMM8dThl/qKc7cKVuFjMB36wYSBF543N4jltcs=;
        b=mVJmkRDNt+YZ1t7yFZEQa2NoTJmLbL5NR2aW2dHZIC28RZufalxv+uY43llAr2VEKj
         MeQTK+1tIVgFycal2B3TNf7aHS56J1lYkjw9C4v2FTbmM99F2/SIdJsW3roeeY2cdT2s
         a6VuHFUAjdEQb0CKljkAKGS/d5j1Su7Yo8LTJy1Ij8WSxGrWTYqERVSucOk9n2gcPCrI
         11u7QX1H8f/7h4oDM1roft9NTXX0NGSitWXzqHGcLRXaDrO090P1bqPaH7veYguYpJxD
         GCn5PtZ1NhUVQSsyr2Hm7xNdHkHq7JBZcM5LOFla9MRDIXuDX7ek64TjkgkMYloQSP5X
         bxCg==
X-Forwarded-Encrypted: i=1; AJvYcCXQbSDSrAcNw4Z6rwnaIjcOpEGuYe6bBFCekipDGg07nkHvpVMwqHLmcgL4NBC9HRauusyUKA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyRXt2XsRRPAvyHuXcf5KTuWVLTjdMkasaRhdPTPfT9C2mspdvy
	l38Z2quUVpGJuGmWGh2OYlwXomi5E1IBt5l8pLXZ4Zdr1/X5l0z5VSQez0xiueWGY4hoGHmCiTY
	Zh6xZUhvfgrGXPIl4aaj5O7E7xwNukmL5LLLqrVCqSyjO9rocNve4
X-Received: by 2002:a17:907:9345:b0:a8d:5d28:8e0d with SMTP id a640c23a62f3a-a98f837b6c6mr332462066b.45.1727898111748;
        Wed, 02 Oct 2024 12:41:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ9gc1FVYCfMextFw3dMZoj8TmOhmZRKDjjfdXgpsAItmfV0hPOJaQsaydmM1LN7DiZD1e2g==
X-Received: by 2002:a17:907:9345:b0:a8d:5d28:8e0d with SMTP id a640c23a62f3a-a98f837b6c6mr332460966b.45.1727898111347;
        Wed, 02 Oct 2024 12:41:51 -0700 (PDT)
Received: from [192.168.0.114] (146-241-47-72.dyn.eolo.it. [146.241.47.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2947ae8sm901858466b.112.2024.10.02.12.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 12:41:50 -0700 (PDT)
Message-ID: <a5289a0d-2557-40b8-9575-6f1a0bbf06e4@redhat.com>
Date: Wed, 2 Oct 2024 21:41:49 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net v2] mptcp: initialize sock lock with its own lockdep
 keys
To: Cong Wang <xiyou.wangcong@gmail.com>, mptcp@lists.linux.dev
Cc: Cong Wang <cong.wang@bytedance.com>,
 syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com,
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>
References: <20240911042425.978665-1-xiyou.wangcong@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240911042425.978665-1-xiyou.wangcong@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/24 06:24, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
> 
> In mptcp_pm_nl_create_listen_socket(), we already initialize mptcp sock
> lock with mptcp_slock_keys and mptcp_keys. But that is not sufficient,
> at least mptcp_init_sock() and mptcp_sk_clone_init() still miss it.
> 
> As reported by syzbot, mptcp_sk_clone_init() is challenging due to that
> sk_clone_lock() immediately locks the new sock after preliminary
> initialization. To amend that, introduce ->init_clone() for struct proto
> and call it right after the sock_lock_init(), so now mptcp sock could
> initialize the sock lock again with its own lockdep keys.
> 
> This patch does not fix any real deadlock, it only makes lockdep happy.

Indeed the syzbot reported splat is a false positive.

However the splat show a real problem: the locks acquired are in order 
the signal endpoint tcp listener lock a newly created msk lock, that 
means that the signal endpoint tcp listener allows successful MPC 
handshake completion.

That in turn is a bad thing, as the subflow sockets created by such 
handshake will never be accepted, the client will stuck. Additionally, 
when the listener queue will be full, not even MPJ subflow will be 
accepted. We need to explicitly make such MPC handshakes fail. That in 
turn will also avoid the reported splat.

I'll try to cook a patch tomorrow.

Thanks,

Paolo

