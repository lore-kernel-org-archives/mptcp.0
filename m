Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA5B2D94BA
	for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787754951; cv=none; b=hAEHu9a3FaropvQc2IVtpyPrWIWqXQHFvVkE8xrM544PpFvpBif7IGvam8pcB3delNhGnszY2fk9zv1j6usmNd+V3eaZZlGJBSl2Ym2TiFEEVYeoO07V9CwuJbPQOcZwz2sf5ERTgeKiLmzQM2rkOaL5lHbCcIbnlTXlU1q0Rjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787754951; c=relaxed/simple;
	bh=1af2JAzzmtxNrcY2ub1/vpk/70DSS5LjOFhKvk/Ot4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L25Q5Sd4uS5szxXh/31dkcFjQsl+7cR117PwNnEC2HXqtBIaX4zdfVZT0q8/re7NnOKsYIs+WsB+ZEnpKWxDPMOYYWDYEco4jW0LmDh102D3y4Oac5tYmuZUneivpGclr+Y/UmG5zXspYmYpr17lb/+GIZpXKA2V4bmE1nFITy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPj+ug6b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPj+ug6b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787754948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fti2c4O9miRhb4OipV4zro4I90zANgW2I/PvMB6kBJ4=;
	b=EPj+ug6bEXF9VFERorxPLx40GIDKN/MIgYIeY7PSS/22zMdE/goFiE9VBMldxUsyZkgk73
	ld1huvO1/wVKCweopTFs9vSgvrspWgPMoujMZFOVmWvxOw6Gt13d7O+QQ7saXIxhtK9YKr
	//pc6vZcHitwH4JwjLxffohZtHcH7U4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-IYm-gtGPMUejg2hDYFN5cw-1; Wed, 26 Aug 2026 10:35:46 -0400
X-MC-Unique: IYm-gtGPMUejg2hDYFN5cw-1
X-Mimecast-MFC-AGG-ID: IYm-gtGPMUejg2hDYFN5cw_1787754944
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c2192261d79so114635666b.3
        for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 07:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787754944; x=1788359744;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Fti2c4O9miRhb4OipV4zro4I90zANgW2I/PvMB6kBJ4=;
        b=DTY6DvJngp0gsU7Nk0YnJcjUyBPJNFdLLWm8x7KhlvYmi4wP/LqbcbkWzIQ5fJtaKa
         XlaGnL7CNf+oH/pJG3mhfuGTUCW2lG1j4ixrdHHoltnV+OiHT5sUGHshjGbOhXn7mL0S
         cABerxGr8mWpP1u9rjIsfXpFYz92kjqxuXEF+Lqus7mTLKuCt42syvDY7Qi8ViSnrDyd
         5Zm5gL3L0synowAhdVnqtH5voCblWjWDUE3q1xd8HxgKYvQm999c2GAMcZ9RfLZX4243
         6cIRdIwt7q+j/mpTzASplTDHwUMAYuZj42paz6BMwElMCWmS/jyaK63ZoC54R0XLVPpR
         oihQ==
X-Gm-Message-State: AFuF++mqEs/fHPvk+h5f/OgOs8A5JddnbFT+ei6ZP+MZ0czBcbJpWsNa
	Cx6RpG79aKsnSDJIyiv3zdxe1tt68FKXK0ShhMhdhDt4LvqpjR1zwfCXB+DA/7bDdtMUNbDSOac
	gEqYlnfvdZ1gRSsiPKUEcT1tNg+L4M7zLBJIeXdzkV9dBvz2Umrg+fYu7iO4miEFy44QEm5rRob
	7WUrLfjW/ShZgVe6KNFZbYkd/ZJqJOVlRkXLcdfA==
X-Gm-Gg: AR+sD12Y5pSQClxPhQlPAS264EnKnvCwqkKulA9j9NBqjaSgsbM/KYjp4h99GnQpkon
	YOte68Nw/AboqF5JBDf1nYq9/dOgZSEvnN/GbcSaoRp+WFuizU3AM2NwgI1dnsvYqWMl3vZoixl
	6xpM2cHOmQaBLcaJxSwVZCHOQNbfUumIZvbOud75jcJN+n7hFE1Vm6BtMaU8A7zyv75HHCgUL3K
	4tkecBvvom7XTdqakBR3hflpT2ndznaNow8A95bgSL0MSsoZinaQnMWTB3RMBcfLPB0qaTsNvAn
	uDWCNNYaP0JTNSiSnnSD+5TA1crbtawLbBw7Rc6YYHbGLIw31qP8PZ27e6SYoR1njwIlYfG0L37
	DGzZmqqMRB2Ke+Dn0pe6KsgqgBosM32wY3ErdAV0P8KGAvCUsAxeHEHXhBer1ldPGoKAM4A8=
X-Received: by 2002:a17:907:c408:b0:c24:6045:2a94 with SMTP id a640c23a62f3a-c250bbbefa3mr1177455066b.4.1787754943751;
        Wed, 26 Aug 2026 07:35:43 -0700 (PDT)
X-Received: by 2002:a17:907:c408:b0:c24:6045:2a94 with SMTP id a640c23a62f3a-c250bbbefa3mr1177446666b.4.1787754943191;
        Wed, 26 Aug 2026 07:35:43 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250dfd6e6asm414925366b.19.2026.08.26.07.35.41
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 07:35:42 -0700 (PDT)
Message-ID: <973f5156-e829-471c-a099-1fe3935e15a0@redhat.com>
Date: Wed, 26 Aug 2026 16:35:41 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net 2/2] Squash-to: "mptcp: do not reschedule the
 RTX timer for fallback sockets"
To: mptcp@lists.linux.dev
References: <f1e8ffe44c3756195391a25ecf60e56e02e0f34f.1787739122.git.pabeni@redhat.com>
 <3d8a1534a8b0609c6ddcd593f4ed8957be019657.1787739122.git.pabeni@redhat.com>
 <20260826103038.1CE861F000E9@smtp.kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260826103038.1CE861F000E9@smtp.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MxzryIhA0ro-MNRbEe8I8fjsgJZnwid2efvuB2Vg3LE_1787754944
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/26 12:30 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Non-blocking MPTCP Fastopen bypasses `mptcp_connect`, leaving the socket permanently in `TCP_CLOSE` and failing to enable the RTX timer.
> --
> 
> commit 4679eada053d3ad7385facbcb9d12c98ccd146f2
> Author: Paolo Abeni <pabeni@redhat.com>
> Subject: Squash-to: "mptcp: do not reschedule the RTX timer for fallback sockets"
> 
> This commit replaces the MPTCP_RTX_DISABLED flag with MPTCP_RTX_ENABLED to
> explicitly control the retransmit timer status across the socket lifecycle.
> It sets the enabled flag during active connect and passive initialization.
> 
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 2f17c5daa704e..a28a0506d28da 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
> 
> [ ... ]
> 
>> @@ -4154,6 +4155,7 @@ static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
>>  		return PTR_ERR(ssk);
>>  
>>  	mptcp_set_state(sk, TCP_SYN_SENT);
>> +	set_bit(MPTCP_RTX_ENABLED, &msk->flags);
> 
> [Severity: High]
> Does this change leave the RTX timer disabled during non-blocking Fastopen
> connections?

Funny, opus-4.8 locally had the same concern and discarded it as
hallucination. Unfortunately I don't have the log handy.

> 
> When a non-blocking TCP Fast Open connection is initiated on an MPTCP socket
> (using MSG_FASTOPEN and MSG_DONTWAIT), mptcp_sendmsg_fastopen() skips the call
> to __inet_stream_connect(), which bypasses mptcp_connect() entirely:

It looks real, I'll send a v2.

/P

