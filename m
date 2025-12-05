Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA4A32F745
	for <mptcp@lists.linux.dev>; Fri,  5 Dec 2025 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764942841; cv=none; b=AuRvuEUUmvqfKIsbEFiYSONT50vhFrg2208ggTObka+Mx0Ujv/YXL5uQE2c5kaO/3K4+vP/KZou+mT6+ylzZ434FsreVuleWczsIew8YZyprM1KnS1n/JKjg99qQ2KG6/N3jJigwnqFEx+X17K4L8Pl1NfLEjZszb22/S+sqHas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764942841; c=relaxed/simple;
	bh=82w+VBbLVjRI93GJZfu/Ee8YcShcokjfeyo/cTPWyzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=EqRb/FpapExNRs7TFMUhBeJPQtk0Njkg+OOkJAEN9USnNTpLXJNzbaH0bWwmHM6i6+6L2vv2sRWquxJ9e86xRZ+DMMkvTrvMzIGYDzRpLC4tNoEz5l7T2EIXZ0zgQYOg9x3JhGlphjpdtlh/2V5xW7iG0z44DtUdNsRpeEW4cdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VOvENGiG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VOvENGiG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764942837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CUd+viXQYEoQOgmzIi67znt+7c+hJPUIVLZrsfaP8m4=;
	b=VOvENGiGKx8dJeMZ2IaQAL59oKES5G/nOGOmKAvTWcvrlknLydSdJttTAGvB+9P5oDhN/X
	jf2foCit3+YG37JSid50toRcPD14QX1YJEmeMTC99C0KucqRMS6yLIn6ewHOhNHhOVEFhi
	1c9HNBI45XvqtMy/Sp4Mab2PiIVJQCM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-UcKUPCLQN36CB4wSAnp43w-1; Fri, 05 Dec 2025 08:53:56 -0500
X-MC-Unique: UcKUPCLQN36CB4wSAnp43w-1
X-Mimecast-MFC-AGG-ID: UcKUPCLQN36CB4wSAnp43w_1764942835
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4775f51ce36so17121035e9.1
        for <mptcp@lists.linux.dev>; Fri, 05 Dec 2025 05:53:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764942835; x=1765547635;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CUd+viXQYEoQOgmzIi67znt+7c+hJPUIVLZrsfaP8m4=;
        b=ZXawkh7nXuMrjvcy0VTdQtTnP2SJ9ZoiiDJkSkBz9hg5JwsfMedalF/bPU0TEhdIrD
         AvS+6Y/ReaWwwTL6PEeJMXu8+Ixyc3xnzRdruhdhI1Js4rSqEb89Mgecb6J1+3+Zf2CV
         dFScAW8Nck+4XWnHePQ4iDPF9qwA0TqqhWpNVBI+EfBqYYSI3V3zOl3jbH4QIjsuhdff
         AmSL7kMosqNNLspN6wS5Cj9YnssBorw90jUvFS3nRuvfBlD9QjphUDnprswHLFG4mixD
         T65CMltgLNwKucD/KfRD5MSeN6/0CX5+y4Z4rXInN5YK/UvC7wRXLZnD1iHfsa0Pts/p
         FXQw==
X-Gm-Message-State: AOJu0Yyv5+8/BgXvy7vT4DqiL+mtwV/aMt3ESnNwTq2B7h5Iq6xJx/wy
	gkFRxlPxyrF5SgmivXwuFWFTzz66MFDGOL8K2XDA5MwVw92YY6vfhQ+HibQKiJdYYHxqkdrKqsn
	joWJUCPhZol8cQg7yTZJPQXdij1Nb4cfSLVMF7/9aRvEkNe1Vb0rqvhVXE+X9CQCH
X-Gm-Gg: ASbGncvJOJyJdj3s4Qtoq6mxDLMPxyJmKj0yRzFdJJMeWiQy5/p73wK4LcAywCa06BS
	5V4h4hTlNAH3Tb4Q8HgsB98KuFo55xBKUbBny/c+osaH4HLKJ//qGYYlz+TWqtaEiV1x60UNkO6
	Q8cC/p8K85GlpHPgNZN5Bfq01kkO8vol5AX+5em2x68dFU/Wi5nmpb2aGUcQ+KhLWQgYPJwObhG
	bV9KcjCMvqNZG62aH/MO/J72eV2LkPiMwXE9BvAL5fdL47NGRuFGTkdO8L/Kz6AqOK+0h8FZIJM
	wiqMaCNywzQ1DQtpqO7SQsGZDiNYGJMmdcKm5c+l/TchfUeBPTiKJ5/RCcJ75/e1Cgs0Ef8r3Ur
	cyF5jpmP+gV3xvA==
X-Received: by 2002:a05:600c:4f8b:b0:477:fcb:2267 with SMTP id 5b1f17b1804b1-4792aeeb5f5mr92223465e9.8.1764942834611;
        Fri, 05 Dec 2025 05:53:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXQi5qFaYXGzXS0F1gcPAyym3NOdfKtLVATACb1thWvawSuONtB7a1NhcPtvcJV4FH0LJ4HA==
X-Received: by 2002:a05:600c:4f8b:b0:477:fcb:2267 with SMTP id 5b1f17b1804b1-4792aeeb5f5mr92223295e9.8.1764942834169;
        Fri, 05 Dec 2025 05:53:54 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792b150878sm72721255e9.3.2025.12.05.05.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 05:53:53 -0800 (PST)
Message-ID: <2dbd0bbb-3e40-45dd-a5ff-e6c52c44cf2d@redhat.com>
Date: Fri, 5 Dec 2025 14:53:52 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net] mptcp: avoid deadlock on fallback while
 reinjecting
To: Matthieu Baerts <matttbe@kernel.org>
References: <6ad37e65c7501b061811e79b45f7898cff838a4e.1764788106.git.pabeni@redhat.com>
 <e41302f4-6866-49a1-a1bd-49804fe0a6b9@kernel.org>
 <ffcda047-0f64-4348-a65b-d3c2d139e6e4@redhat.com>
 <01a8fa17-6223-410c-921f-985d02ff880b@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <01a8fa17-6223-410c-921f-985d02ff880b@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: j3436bcDAah_n2BrHVhcB6dLC86gx4-2aJ6-RoBXl8c_1764942835
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/25 2:47 PM, Matthieu Baerts wrote:
> On 05/12/2025 09:06, Paolo Abeni wrote:
>> On 12/4/25 6:44 PM, Matthieu Baerts wrote:
>>> On 03/12/2025 19:55, Paolo Abeni wrote:
>>>> Jakub reported an MPTCP deadlock at fallback time:
>>>>
>>>>  WARNING: possible recursive locking detected
>>>>  6.18.0-rc7-virtme #1 Not tainted
>>>>  --------------------------------------------
>>>>  mptcp_connect/20858 is trying to acquire lock:
>>>>  ff1100001da18b60 (&msk->fallback_lock){+.-.}-{3:3}, at: __mptcp_try_fallback+0xd8/0x280
>>>>
>>>>  but task is already holding lock:
>>>>  ff1100001da18b60 (&msk->fallback_lock){+.-.}-{3:3}, at: __mptcp_retrans+0x352/0xaa0
>>>>
>>>>  other info that might help us debug this:
>>>>   Possible unsafe locking scenario:
>>>>
>>>>         CPU0
>>>>         ----
>>>>    lock(&msk->fallback_lock);
>>>>    lock(&msk->fallback_lock);
>>>>
>>>>   *** DEADLOCK ***
>>>>
>>>>   May be due to missing lock nesting notation
>>>>
>>>>  3 locks held by mptcp_connect/20858:
>>>>   #0: ff1100001da18290 (sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_sendmsg+0x114/0x1bc0
>>>>   #1: ff1100001db40fd0 (k-sk_lock-AF_INET#2){+.+.}-{0:0}, at: __mptcp_retrans+0x2cb/0xaa0
>>>>   #2: ff1100001da18b60 (&msk->fallback_lock){+.-.}-{3:3}, at: __mptcp_retrans+0x352/0xaa0
>>>>
>>>>  stack backtrace:
>>>>  CPU: 0 UID: 0 PID: 20858 Comm: mptcp_connect Not tainted 6.18.0-rc7-virtme #1 PREEMPT(full)
>>>>  Hardware name: Bochs, BIOS Bochs 01/01/2011
>>>>  Call Trace:
>>>>   <TASK>
>>>>   dump_stack_lvl+0x6f/0xa0
>>>>   print_deadlock_bug.cold+0xc0/0xcd
>>>>   validate_chain+0x2ff/0x5f0
>>>>   __lock_acquire+0x34c/0x740
>>>>   lock_acquire.part.0+0xbc/0x260
>>>>   _raw_spin_lock_bh+0x38/0x50
>>>>   __mptcp_try_fallback+0xd8/0x280
>>>>   mptcp_sendmsg_frag+0x16c2/0x3050
>>>>   __mptcp_retrans+0x421/0xaa0
>>>>   mptcp_release_cb+0x5aa/0xa70
>>>>   release_sock+0xab/0x1d0
>>>>   mptcp_sendmsg+0xd5b/0x1bc0
>>>>   sock_write_iter+0x281/0x4d0
>>>>   new_sync_write+0x3c5/0x6f0
>>>>   vfs_write+0x65e/0xbb0
>>>>   ksys_write+0x17e/0x200
>>>>   do_syscall_64+0xbb/0xfd0
>>>>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>>>  RIP: 0033:0x7fa5627cbc5e
>>>>  Code: 4d 89 d8 e8 14 bd 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
>>>>  RSP: 002b:00007fff1fe14700 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
>>>>  RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fa5627cbc5e
>>>>  RDX: 0000000000001f9c RSI: 00007fff1fe16984 RDI: 0000000000000005
>>>>  RBP: 00007fff1fe14710 R08: 0000000000000000 R09: 0000000000000000
>>>>  R10: 0000000000000000 R11: 0000000000000202 R12: 00007fff1fe16920
>>>>  R13: 0000000000002000 R14: 0000000000001f9c R15: 0000000000001f9c
>>>>
>>>> The packet scheduler could attempt a reinjection after receiving an
>>>> MP_FAIL and before the infinite map has been transmitted, causing a
>>>> deadlock since MPTCP needs to do the reinjection atomically from WRT
>>>> fallback.
>>>>
>>>> Address the issue explicitly avoiding the reinjection in the critical
>>>> scenario. Note that this is the only fallback critical section that
>>>> could potentially send packets and hit the double-lock.
>>>
>>> Thank you for the fix!
>>>
>>> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>>
>>> Out-of-curiosity: any idea why we only see it now while the fix tag is
>>> from July? :)
>>
>> The deadlock is deterministic, when the relevant pre-conditions are
>> reached; but such pre-req are quite/very unlikely:
>>
>> - the peer send an MP_FAIL [1]
>> - the ssk/pm/msk tries to send an ack reply with infinite mapping
>> - allocation of such skb fails [2]
>> - the scheduler kick a mptcp-level retransmission before any other
>>   later transmit [3]
>>
>> Eech of [1], [2] and [3] is quite/very unlikely and we need all of them
>> with suitable/strict time scheduling.
> 
> Thank you for your reply!
> 
> [1] is expected in this selftest, [3] I can understand, but not [2]. Or
> an issue with the memory size allocated per VM in the new NIPA LF machines?

Allocations can always fail, and this one is GFP_ATOMIC, so even more
likely. (note that the allocation includes __GFP_NOWARN).

Possibly nipa VMs are provisioned with a limited amount of memory (IDK)

/P

