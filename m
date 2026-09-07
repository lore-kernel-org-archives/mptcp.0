Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC10E4CC278
	for <mptcp@lists.linux.dev>; Mon,  7 Sep 2026 13:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788788818; cv=none; b=TAOtEJHRtq4K7u6ZkKEhJsKoVkJnILxIAkFfFyf+ss2LJuVqsYAM8k7DQDzBDKdPra89oOOG7DzU9/dZnmqmB2P1fwuyCM3RfnH0ZZ7o26f5u3O6OTA38XxJNlQ67NXejF9xElOxJMgsh9hBd9mJOemTIt7oKhbQfnyEHBC57Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788788818; c=relaxed/simple;
	bh=hhUgEHmNufylEgj3ERvWoliIbgY3B0/ay3uKuqek/oE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oF0ZDXqPTsBQxzSZ7Glw4608nv28tqMZ7LghuNIbbHf8qZDf3F9usKpWlieL0Yg8hAfqZkgKUzLTRzriv/66lbyTuHxrFyBBxq2QEUdcxJauX/l+Qpnqmza9uF0UH+Hd073RykGftFStvQa5/7MDDHslTroN1Mf7CxXDGNw957M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f7/oiVku; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7/oiVku"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788788810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LbYU6mIGwNAcTeABQ9HUdXCji1Nx0a+jxwN3nhL+4Wc=;
	b=f7/oiVkufWM4+hAZti2k8GNwIBOicF+WFog/de99l10J1xeA0O9b3Zfe+9ZKOJ7b/YaD8h
	9VMH2FgysxngQmL2TbyCKV3xqMBZ4jB1NyUeN2Q1tg5KQ1CAdeOB2g5oVU+zS+VjRDLDCL
	k/ZIKaydYZyUBGx92DrSExd7poEofoI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-WMGAmzNhMY2XDPXbnjKFzA-1; Mon, 07 Sep 2026 09:46:49 -0400
X-MC-Unique: WMGAmzNhMY2XDPXbnjKFzA-1
X-Mimecast-MFC-AGG-ID: WMGAmzNhMY2XDPXbnjKFzA_1788788808
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6a67fdea041so2889833a12.2
        for <mptcp@lists.linux.dev>; Mon, 07 Sep 2026 06:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788788808; x=1789393608;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LbYU6mIGwNAcTeABQ9HUdXCji1Nx0a+jxwN3nhL+4Wc=;
        b=TY4wQ/WRiJIJLAX1s0cU/BQhPCtnV88Nzocpdc3ckwgG8kDt9RXhC0FvbgIH869AEK
         k2Q07WEHqYvQiScTuMEVm+jG5JiyVUmPOkpVebEtxWwB+oxfyRmlMifGyTIKdo8LqJy4
         0EHPYslPdXm3/hAM8B54MrNb7PTmiW+VXXVZfZ8HqmYAcCjRUdvZGctVOGZz4gG9IRIV
         4pvecnnyOpOnGVoONeYL0hgWy3lKd6GdiD/YGk9ERjs4+thNIAG6CjrRw3jAE3vIBzYp
         O4O1ezdkrWUzFArrvemEGaauWZnDh5zrsAGHZ6s02fAmeEB6l7IlHtHqNcp9De3HQUNt
         WGJw==
X-Forwarded-Encrypted: i=1; AKwUvBwx0Jdw3K7HIyWzvVD58xJ8ibLe0EnCy8xgsvZg7A4PdMlterxLhtd0Tx3bEAWcos9xw7LWIw==@lists.linux.dev
X-Gm-Message-State: AFuF++k3uymH5eZDbnLxqRFu3Coq3k0qq4OUqWkFgkfSKRXyRCuOxGPA
	IU4d/HaOlVKUBQUWcu1jh36SjqXLLmgCOCSv1LcpuqO+JZwg1Xk0Q+26yBzjfoFgsVnkhisj/QG
	aFEhRdyuhu5HtXAnbp/xFgwY3nSIW8DUbs95CyoDu3XFYEoM6FnVHaf6D
X-Gm-Gg: AYBFou0e4M8fbfRwGnWyHWaZofc9s2SoHqdB8H9xrnEgXeQnQw02FjIH71YdXpzLWVL
	8P0iQJmmqhSaWShCMA/MR07Rx5XXWWK/U7JGqXA4e+FlIEUy484mRkYkWTJ7ptlp/V8R4AIJOKc
	cEFc6DNpGiCnMyNhZWdASAeP+V5OxBTWXw2UId8m8lCcYBCt4Xq2/Usq6Qrr4oMY+R1IMW8bGJa
	d2SFVx6CL//DWGJtRBF08L8loGTZoUdoUmOKb0OQl5VJ4jjEEc9A3bsyOm7Ov059S0P6PHcNblQ
	fTVr/FdECxfI/501D4XyyfWj5UzAdx2pTi7REe3a8X7JhtB7zGeGMR8QyfY9fEOEaWGhL4cC6ex
	zpTH5kibvg4A9o6+FVoczqHHKFl0Hwyi+7JhWYXkwHhsfrQeicF9tUBvknt+V4pht+L0tlb9u+w
	==
X-Received: by 2002:a05:6402:4150:b0:6a7:ee56:615e with SMTP id 4fb4d7f45d1cf-6a7ee56631dmr7067543a12.32.1788788808338;
        Mon, 07 Sep 2026 06:46:48 -0700 (PDT)
X-Received: by 2002:a05:6402:4150:b0:6a7:ee56:615e with SMTP id 4fb4d7f45d1cf-6a7ee56631dmr7067514a12.32.1788788807779;
        Mon, 07 Sep 2026 06:46:47 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e6c20c0fsm4583465a12.30.2026.09.07.06.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 06:46:46 -0700 (PDT)
Message-ID: <14749060-d011-41e7-9a4b-754eb5bd9d5b@redhat.com>
Date: Mon, 7 Sep 2026 15:46:45 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v3 3/3] tcp: fix data-race in do_recvmmsg /
 mptcp_recvmsg
To: quanyeyang@proton.me, MPTCP Linux <mptcp@lists.linux.dev>
Cc: geliang@kernel.org, matttbe@kernel.org
References: <20260907-mptcp-snd-una-race-v3-0-65ba0d5f0221@proton.me>
 <20260907-mptcp-snd-una-race-v3-3-65ba0d5f0221@proton.me>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260907-mptcp-snd-una-race-v3-3-65ba0d5f0221@proton.me>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hX6PAi8gSdm_SLAeU3xMGV5nErDXlEepVtWzYYRlAcw_1788788808
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/7/26 12:15 PM, Quanye Yang via B4 Relay wrote:
> From: Quanye Yang <quanyeyang@proton.me>
> 
> KCSAN reported a data race between do_recvmmsg() and
> mptcp_recvmsg() on sk->sk_err.
> 
> do_recvmmsg() calls sock_error() without holding the socket lock.
> sock_error() atomically clears sk_err using xchg(), which can race
> with the plain read in tcp_recv_should_stop(), even when its caller
> holds the socket lock.

It looks like the same data-race is present for plain TCP betweem i.e.
multiple concurrent recvmmsg() reader? If so, I think this patch
could/should go separately directly into the net tree.

Also please include the full KCSAN splat.

/P

