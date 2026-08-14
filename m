Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DCB3CFF65
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 16:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786725230; cv=none; b=WK9OF0o+FEWdeuvUb9XlXI6iwQcYYtWOHOehAClEUqCa0/XsZ8duBnSKQWP7GgPXhZnW5R0HV9Jb93dPg4kXIBR5i2MUiNjtCvGRI+u3GhESFUZx1RzNgCovA7BIvPOJMoHZbZbGBUDQD8zeLAVY7NNJ3UnCXA3yutSEcf9rPUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786725230; c=relaxed/simple;
	bh=pyHrc9bBxEomdl5XM9q/B52XkX59HhJnj27Srg6oQo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JPxAjwS3dP0NmCNpkccqdLQaQEey4ldHiqiDGjM5LAX59Zs0tSWNdEX1EFNoen+wDH4QSS2p3NqHzreP/ZGg/Ug6yoDy4y1fLN85Dhn9DXj0OLmz5V/umot+2qdcrzGeRslIyjZok9vKRPUYxsk055tyTlKGD2Ox0/oFppbzslU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IB8A09tO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IB8A09tO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786725227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8WV9Wj4SCHBYhAbyzgDfM0gpgoEghIbZbNF8uqhfCQc=;
	b=IB8A09tOsV0UZrnRHoR3O+VvsuTnpuelmyTugqPlbmrib70DTQX9vK4kGA5f484wilgQB3
	1veMGr775/Q1LJoRmjCjR+R2rAUqxK6AtsvJhqRZMaXPvzhoaDlzlhOviGV4tJ2jf5Tivw
	tnkBeMmJisjEyQUUe6t9kqG+ctI9Q+k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-7lT_R_S9NDGDd4hth9i7ZA-1; Fri, 14 Aug 2026 12:33:45 -0400
X-MC-Unique: 7lT_R_S9NDGDd4hth9i7ZA-1
X-Mimecast-MFC-AGG-ID: 7lT_R_S9NDGDd4hth9i7ZA_1786725225
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47407691804so692570f8f.1
        for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 09:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786725225; x=1787330025;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8WV9Wj4SCHBYhAbyzgDfM0gpgoEghIbZbNF8uqhfCQc=;
        b=aTHby67u2qsQBTJuWNg2MvRtBzQn0cGDJMEoopBMcac0618mLBnjTm1SYL17Jck0EE
         WAT5N7rcYYQjGFuAL1jbwsUmipcw1svaVHqKdAHVZatGrFoMJmulT9IK8ns7Vbf/cETn
         UVxBTNfHEN7yssLkW2CHv3zT0GbvEv8Zy4R0997QVjHfHTP9nmK+gBWGNaIAPTTgcUUZ
         6cCWcEvuPoFGuZk0H/LFNBLHJeWgOK9ZFHDfMeiKKkvMGXJnLrR6BqvXb7YPYf3okpuC
         A6AwaKMkJz1c9O1xEPh3zEi8WTEKFktdLYlhS78UiCGfl9tgFLuCsmq9VTiIIfQmWQEF
         CFtw==
X-Gm-Message-State: AOJu0YwZyI0TkwNmj3qPDOWS92yZPcFp7rgasNycu4G/djz2Eo67nFxw
	tpaBI4++3IWbRZHN2bhoyF1MRUo/kf/LjmAmbb5u3fTHvvNg2sxJqfJ+UqS+5+iqOpdo7Q34qx2
	gW72RPcTgQwMom8dlyDLSIGRkWlqkty0iDIQ8YcJSRfILdPph+M/IVgAI
X-Gm-Gg: AR+sD13GBHk8QeeWPDPQpWX8/tErmUjybiJQuO8kmcR0MTj9ATolIck2uizWTlSRbt5
	ujsawWqdDX9KGxxcFRm9ccPwCBTjG96GI1NLnpbKieu1cP4pBrrvoms7+E4mSdr9xi4xjaEOat+
	KFJAOZm+U5T91liltcTzA9a2/KqIT9tPR3dcjKRusbF7EzZx1ZGxQdXtUJhatkbaQVRCBkWw9/r
	ZELURUxTCYgyaApPeme95xZb+vOp4Z0Oq2y/ZzVSF8qHwJKaPHeXND7M3kENpkt09mOsu2ukoq4
	EcXhB52H+hsBoGKtXc/8gCdNSAi8cESdKiqwad0eYDXZqKgk2n69fG8XUXQ8WWn8ghzkfLTB/2P
	4GJoMd5H+o87Xasw5dyW/6xLAMXVqL9qWP0jFmRu1EqdfG3c+O5EeGbIvPnQYt6l4J3D9a9UkRG
	E=
X-Received: by 2002:a05:600c:1395:b0:499:872b:abd4 with SMTP id 5b1f17b1804b1-4998797684cmr87803725e9.6.1786725224676;
        Fri, 14 Aug 2026 09:33:44 -0700 (PDT)
X-Received: by 2002:a05:600c:1395:b0:499:872b:abd4 with SMTP id 5b1f17b1804b1-4998797684cmr87803265e9.6.1786725224244;
        Fri, 14 Aug 2026 09:33:44 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499899753ccsm45933325e9.0.2026.08.14.09.33.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 09:33:43 -0700 (PDT)
Message-ID: <aa683b2d-264e-43bc-b98f-0b8728ad11e0@redhat.com>
Date: Fri, 14 Aug 2026 18:33:42 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH resend mptcp-net 4/4] mptcp: do not reschedule the RTX
 timer for fallback sockets
To: sashiko-reviews@lists.linux.dev
Cc: mptcp@lists.linux.dev
References: <cover.1786713351.git.pabeni@redhat.com>
 <59c6c4dd41bb72b7aef984b14a0c6ad0881f6a4c.1786713351.git.pabeni@redhat.com>
 <20260814140334.39D5B1F000E9@smtp.kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260814140334.39D5B1F000E9@smtp.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JzAeGqyZOjvEGmlTZgkOQ03gsKyr7Tv28O67c_lnE7k_1786725225
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/26 4:03 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The MPTCP_RTX_DISABLED flag makes the TCP_CLOSE state sticky for the RTX timer, permanently disabling retransmissions on reused connections and their accepted children.
> --
> 
> --- Patch [4]: [PATCH resend mptcp-net 4/4] mptcp: do not reschedule the RTX timer for fallback sockets ---
> commit 227375cb381dd3864273cd7170dd28e0f079ff8b
> Author: Paolo Abeni <pabeni@redhat.com>
> 
> mptcp: do not reschedule the RTX timer for fallback sockets
>     
> This patch introduces the MPTCP_RTX_DISABLED flag to prevent the RTX timer
> from being rescheduled on fallback sockets and when the socket state is
> TCP_CLOSE.
> 
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index b311fe30c7855..f22d64ab1c53b 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
> [ ... ]
>> @@ -1121,13 +1122,14 @@ static bool mptcp_rtx_timer_pending(struct sock *sk)
>>  
>>  static void mptcp_reset_rtx_timer(struct sock *sk)
>>  {
>> +	struct mptcp_sock *msk = mptcp_sk(sk);
>>  	unsigned long tout;
>>  
>> -	/* prevent rescheduling on close */
>> -	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
>> +	/* Prevent rescheduling on close and in case of fallback. */
>> +	if (test_bit(MPTCP_RTX_DISABLED, &msk->flags))
>>  		return;
> 
> [Severity: High]
> Since this flag is checked here to prevent rescheduling, will the timer be
> permanently disabled if the flag is never cleared?
> 
> [ ... ]
>> @@ -3360,6 +3362,9 @@ void mptcp_set_state(struct sock *sk, int state)
>>  		 * transition from TCP_SYN_RECV to TCP_CLOSE_WAIT.
>>  		 */
>>  		break;
>> +	case TCP_CLOSE:
>> +		set_bit(MPTCP_RTX_DISABLED, &mptcp_sk(sk)->flags);
>> +		fallthrough;
>>  	default:
> 
> [Severity: High]
> Does setting MPTCP_RTX_DISABLED here without a corresponding clear logic make
> the TCP_CLOSE state sticky for the RTX timer? 
> 
> If an MPTCP socket transitions to TCP_CLOSE (like a failed connect() attempt
> or an explicit disconnect()), and the application then reuses the socket to 
> connect() again, it appears the flag will remain set.
> 
> Furthermore, if listen() is called on such a reused socket, would
> sk_clone_lock() copy the flags to all child sockets? This could cause every
> accepted connection to inherit the MPTCP_RTX_DISABLED flag, permanently
> breaking MPTCP-level retransmissions for all clients.

On nice, I did not read an hallucination this allucinated since a while...

without disconnect() a closed socket can not transition to other non
closed states, because the network-level ops check the 'struct socket'
state, which in turn is cleared only by disconnect().

mptcp_disconnect() explicitly clears msk->flags.

No real issues above.

/P

