Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06B81DFD0
	for <mptcp@lists.linux.dev>; Tue, 16 Jul 2024 13:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721137757; cv=none; b=Tz77HuQATyvHv0LmcczlNyjhYQCz7f918LgKwgVPTwVhhgB0/CVe44HfEfB6P7YP/KIjCZyrOMPJ1LcewcuNsFIHxBHrEUbhtk7U5QCEj+8GkINfbQSgmbd4eZbERffaApTf3pTqU6qUTolbfuJ1Rkev2Im6+JX68QQgNM0l2kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721137757; c=relaxed/simple;
	bh=sn7lypxCZmauXi//bNO27HUYKwTHmzOel2AciXmWIk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jzNJ+HcW+ZVRd8nvKpovo9u7AmOHnhk8olExbPxOar1pIbOYwO2ELnTeZszbDenwyfFfef8/2ug25B817eBnbz9fXFnPmJFjAmuLqOq1AEfAmS7WaLnYViknSkjCKe96vyYhgEEpma1qQ25xotqU16Dq6XBHQUnp7jc9oTxnB7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZGcbddXh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGcbddXh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721137754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YGLTcH9FORLC9WlTdnuIezku9I3uhR1VMZ3VLHcV11A=;
	b=ZGcbddXh7MwfehpPKU3heOcvRiTRCppoWGRoOwdud+VSOHHXQ0UFbCRK3mBYeUXV8FbKTd
	mhSCKa46G8KAifoucJFZJuT4J4kwKAIUk/6I1q1hBsmpmX/pOF8wyvgY4vzehMJ96MGKs+
	smVAC5WebYTsZN385BZSzMhe/41ZfAg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-kHbG1oacNo67srYKKQyAgw-1; Tue, 16 Jul 2024 09:49:13 -0400
X-MC-Unique: kHbG1oacNo67srYKKQyAgw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42669213f26so10322725e9.2
        for <mptcp@lists.linux.dev>; Tue, 16 Jul 2024 06:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721137752; x=1721742552;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YGLTcH9FORLC9WlTdnuIezku9I3uhR1VMZ3VLHcV11A=;
        b=OHdvr24DloKzpFspiZT3rHJduWvIkypPP+WCVlMtk0QqyTT0uopB5baoe3JOrYTd+t
         To7TkYsnXEaAtPNpKr1GtcRQrshcW1jlSrqxft//jisVGtUoa5388aRw4jSmSL8dkP6k
         6u16yTohOk9G8TAB0sjF6tasIoJaPGwHzLiVz1L+nFCh3yKABZH/BTJuUBIAZbQKapE0
         igELVghLAw2uPC/G+9djh7Njxz3rJ8jsDsl7Ts4gVQMQuydml5msinFeQxFYdjxqAcVC
         SKaRCCQTbmgOvXtWwf1tSzIxPlIVWvepRaMZwES6UE9IJjDESHifv7oFsvgVmdi2NJmL
         onlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQWUlTl334CFPY8HfASc6Py4lFDpi3oXPf5i3lOr6pP0iHMPZRSdG8mwLKPJCkHWHczreZM8nk4mYC7i7n/mrQvBRpfLs=
X-Gm-Message-State: AOJu0YxJfvpAfPJAx67TCy+KljwXgxtLwgmoeZJ6iZKT9y5wh9b5ZTak
	KZ0wvgJHTMc1SaAizTTgLVB0tXSMQLslfLxj4wSB/u/ij/PmBogv+S6MQA9M8kU7CMgJ5pe02TQ
	HBHbwYUTSIPvWKhTQymyzzzQI+hgWeGViVEL3CX9Q8xRNieDescyN
X-Received: by 2002:a05:600c:4e8c:b0:427:9f6c:e4bc with SMTP id 5b1f17b1804b1-427b8a51636mr12537815e9.5.1721137752272;
        Tue, 16 Jul 2024 06:49:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxI1sn9atPGxihaurY81gg2wFWlkXsMiRSwoUrMrv/lHtMSvByvC+0ED1E163QJJloUno+Hg==
X-Received: by 2002:a05:600c:4e8c:b0:427:9f6c:e4bc with SMTP id 5b1f17b1804b1-427b8a51636mr12537665e9.5.1721137751824;
        Tue, 16 Jul 2024 06:49:11 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1738:5210::f71? ([2a0d:3344:1738:5210::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f2cc32esm164141955e9.35.2024.07.16.06.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 06:49:11 -0700 (PDT)
Message-ID: <11b9bd49-8e8c-466e-9919-39258ba86c31@redhat.com>
Date: Tue, 16 Jul 2024 15:49:10 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC mptcp-next fixes] mptcp: process MP_JOIN's 4th ACK
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <20240715-mptcp-process-4th-ack-mpj-v1-1-d44fc90245e2@kernel.org>
 <504957bf-8de8-4ea4-aadf-b84b62d267ea@redhat.com>
 <29d1c09f-f082-4740-91e3-91b9b585e30c@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <29d1c09f-f082-4740-91e3-91b9b585e30c@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/16/24 12:44, Matthieu Baerts wrote:
> On 16/07/2024 12:35, Paolo Abeni wrote:
>> On 7/15/24 21:09, Matthieu Baerts (NGI0) wrote:
>>> The 'Fixes' commit recently changed the behaviour for MPTCP Join
>>> requests for listening sockets: when receiving the 3rd ACK of a request
>>> adding a new path (MP_JOIN), sk->sk_socket will be set, and point to the
>>> MPTCP sock that has been created when the MPTCP connection got created
>>> before with the first path. The newly added 'goto' will then skip the
>>> process of the segment text (step 7) and not go through tcp_data_queue()
>>> where the MPTCP options are validated, and some actions are triggered,
>>> e.g. sending the MPJ 4th ACK [1].
>>>
>>> This doesn't fully break MPTCP, mainly the 4th MPJ ACK that will be
>>> delayed, but it looks like it affects the MPTFO feature as well --
>>> probably in case of retransmissions I suppose -- and being the reason
>>> why the selftests started to be unstable the last few days [2].
>>>
>>> TODO: it is not clear to me if we need to fix something for MPTCP. The
>>> following packetdrill test doesn't seem to be failing with the following
>>> patch, we can see a fallback to TCP, which seems OK in this case, no?
>>>
>>>     `../common/defaults.sh`
>>>
>>>      0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_MPTCP) = 3
>>>     +0 connect(3, ..., ...) = -1 EINPROGRESS (Operation now in progress)
>>>
>>>     +0 > S  0:0(0)                 <mss 1460, sackOK, TS val 100 ecr
>>> 0,   nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
>>>     +0 < S  0:0(0) win 1000        <mss 1460, sackOK, TS val 407 ecr
>>> 0,   nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
>>>     +0 > S. 0:0(0) ack 1           <mss 1460, sackOK, TS val 330 ecr
>>> 0,   nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
>>>     +0 < S. 0:0(0) ack 1 win 65535 <mss 1460, sackOK, TS val 700 ecr
>>> 100, nop, wscale 8, mpcapable v1 flags[flag_h] key[skey=2]>
>>>
>>>     +0 write(3, ..., 100) = 100
>>>     +0 >  . 1:1(0)     ack 1 <nop, nop, TS val 845707014 ecr 700, nop,
>>> nop, sack 0:1>
>>>     +0 > P. 1:101(100) ack 1 <nop, nop, TS val 845958933 ecr 700>
>>>
>>> Link: https://datatracker.ietf.org/doc/html/rfc8684#fig_tokens [1]
>>> Link: https://netdev.bots.linux.dev/contest.html?executor=vmksft-
>>> mptcp-dbg&test=mptcp-connect-sh [2]
>>> Fixes: 23e89e8ee7be ("tcp: Don't drop SYN+ACK for simultaneous
>>> connect().")
>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>> ---
>>>    net/ipv4/tcp_input.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>>> index ff9ab3d01ced..ff981d7776c3 100644
>>> --- a/net/ipv4/tcp_input.c
>>> +++ b/net/ipv4/tcp_input.c
>>> @@ -6820,7 +6820,7 @@ tcp_rcv_state_process(struct sock *sk, struct
>>> sk_buff *skb)
>>>            if (sk->sk_shutdown & SEND_SHUTDOWN)
>>>                tcp_shutdown(sk, SEND_SHUTDOWN);
>>>    -        if (sk->sk_socket)
>>> +        if (sk->sk_socket && !sk_is_mptcp(sk))
>>>                goto consume;
>>>            break;
>>>   
>>> ---
>>
>> patch LGTM
> 
> Thank you for having looked!
> 
> Should I already send the patch -- without the TODO, but mentioning the
> fallback to TCP instead -- to have it accepted before sending the pull
> request to Linus if we still have time?
> 
>> but I'm wondering if a similar problem can be reproduced
>> with plain TCP and  TFO?
>>
>>
>> syn + TFO    ->
>>          <- syn ack
>>              [accept]
>> ack        ->
>>          NO 3rd ack????
>>
>> If so possibly the 'if (sk->sk_socket ...' check should be refined even
>> more?!??
> 
> Good point!
> 
> I can mention that in the comment of my patch, and try to reproduce that
> locally. WDYT?

Would be great, especially the reproducer part. pktdrill should be handy 
here.

Thanks!

Paolo

