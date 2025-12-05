Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991CA2F5A12
	for <mptcp@lists.linux.dev>; Fri,  5 Dec 2025 08:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764922085; cv=none; b=sfPBHdRfkZdZbrFaH/URlVy13NaUvzMP/lqWwsVNfZLpiM7KkQOTZkGzngdvI3rqHPMi1UCKUgleU+Fyg1jqLdeyyvLOutILI2Ftpw6XwP0y8fd2ydr8j+P7zsTi5nFt1LKA1qfxTViHDEdxR3MjwYYerlaEHJcCqVzVNsNaV98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764922085; c=relaxed/simple;
	bh=q/FW53/Tr8QInTlEVoXgT1eSjNeEe2MPq1epIiL4aXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sB3KVCNAVwkSCZVYo6yGtzGLQK0uc+ojX+VzlJPYiZFuUnBE1EGij3oeBTP6gDkcb3HGjJkNjg+1tLsk38Q3WzS+rrlCvJyXCNzDJ+C7orciok4iJ5fSDl5XqAn3ZrXfOiaEL5kfHoHqtSME75TV8qyovz3uInGjDW2GJ1dmjFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cpuMlKXh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cpuMlKXh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764922071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JNuKXHLW5wEKSw+UKH9afkWTK2xUjxQZMj/Pz0q5ygw=;
	b=cpuMlKXh3FUGKXwb5RBn9ipcPw5b0bK/4NvP+Oe3JhcTdHcHaN2DdGBr+GE/XeEAlhO+fc
	LDr4JzitgnsXPsOsBAvWPRZTEu3yMKzNp5INfFUnL630wBRAtu6DoG0PyzIYBOptjP+vIO
	lZTd/oINzP0gV7WOfPt9gW8LmX9ueYw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-Ha30w2V4O5eVpYHkK03GdQ-1; Fri, 05 Dec 2025 03:06:39 -0500
X-MC-Unique: Ha30w2V4O5eVpYHkK03GdQ-1
X-Mimecast-MFC-AGG-ID: Ha30w2V4O5eVpYHkK03GdQ_1764921998
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4779b3749a8so13663435e9.1
        for <mptcp@lists.linux.dev>; Fri, 05 Dec 2025 00:06:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764921998; x=1765526798;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JNuKXHLW5wEKSw+UKH9afkWTK2xUjxQZMj/Pz0q5ygw=;
        b=jo8fiU8lRUhtzdXTqKYg7NamvwkYlf+pjfreUgMq3VaswGGgDRQs0Q3XSxVGxep2Hf
         XsxZ2xAN/JhzhjeLo6aRfcLqzV2nf8j+6F+gIj7G0sVXZ27Tro0dSOpdrZTXny6/dSI+
         Y2ZAYCjR4SOFoHlxlx9QuwXCXXi0nknTnPKsdfFF+G0vjCFskrLUUmkgvg7LiMatzxJW
         /JDrJGtPpwkUQzr8bh45nA8ZxK1j060gEJtoGKn0gnjc4aNOLVuh5r5Cq4N0NXKYuUdj
         4EeTyPy2X7xxnPn8bBhMs7n+J/sBr78nDy3HPRcGRuZttuN80TkEJSdxnoLZluR2YY1z
         sCLw==
X-Gm-Message-State: AOJu0Yxuii0PoAZcNIQp5OZKh2a+aXp889xfjBfG3s7JpBvhaqCEQa87
	cFzJ0jAmi+wsCC+bN1kz1rNBGYyKGjLVtFzdpU2W0i52yITawppKdoiQVhBH+C1W/NJrEQKs3gQ
	e3OARZBV1hOmfJGYyNtrsVw0qGMLCddYuKfIm0Bt+LO4YKE41HTTiqkqXEwruXfn1
X-Gm-Gg: ASbGncvdhnqshNh9kgS760NHyAwpOaLQXI38NVS2KMQ+vMlGOHDibNm9GQyFxLbOY2U
	Okc8bhzHdlNZgfrK1b6+0w2BAb5WM5O3VFiFmKKtb4j8mc6GgeRI/02dwVrR3yWVxWzJlP07mRV
	VRAPy5S3IZLainOu0Tep7HQy9+JHvu03kTsRIysP3zyX5wBsB3QFWQTah9vsr4F4PNnCnViK17w
	znfGngEarI5MC23m58jrViG6cydSFcz2wiaSakWR4h/mOZikx+7MiPRfB2XyFEl1+RoMPHF3JBP
	qVWdBss6N/xwQ9BykTpYyKMcwTIopJfRvDu6A5HI6xNk6OXV+Q2urbL8cVld8NGuAjKt14rVFXt
	btVzRxrwIQ3LjZQ==
X-Received: by 2002:a05:600c:4706:b0:471:1716:11c4 with SMTP id 5b1f17b1804b1-4792af5e533mr82694305e9.34.1764921997948;
        Fri, 05 Dec 2025 00:06:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrZmnHNZ4ZV7OytmIECya8gG7UINOVfrgplTKiVO4Zqs+7loH+EugWCpKBSxdp3GaVsvFrCw==
X-Received: by 2002:a05:600c:4706:b0:471:1716:11c4 with SMTP id 5b1f17b1804b1-4792af5e533mr82693875e9.34.1764921997430;
        Fri, 05 Dec 2025 00:06:37 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47933aef61fsm34823695e9.7.2025.12.05.00.06.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 00:06:36 -0800 (PST)
Message-ID: <ffcda047-0f64-4348-a65b-d3c2d139e6e4@redhat.com>
Date: Fri, 5 Dec 2025 09:06:35 +0100
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
Cc: mptcp@lists.linux.dev
References: <6ad37e65c7501b061811e79b45f7898cff838a4e.1764788106.git.pabeni@redhat.com>
 <e41302f4-6866-49a1-a1bd-49804fe0a6b9@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <e41302f4-6866-49a1-a1bd-49804fe0a6b9@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zp7wEuqOyrB-pm7Wb9ZiMPPCemAlOKNajI1nWYKfyXY_1764921998
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/4/25 6:44 PM, Matthieu Baerts wrote:
> On 03/12/2025 19:55, Paolo Abeni wrote:
>> Jakub reported an MPTCP deadlock at fallback time:
>>
>>  WARNING: possible recursive locking detected
>>  6.18.0-rc7-virtme #1 Not tainted
>>  --------------------------------------------
>>  mptcp_connect/20858 is trying to acquire lock:
>>  ff1100001da18b60 (&msk->fallback_lock){+.-.}-{3:3}, at: __mptcp_try_fallback+0xd8/0x280
>>
>>  but task is already holding lock:
>>  ff1100001da18b60 (&msk->fallback_lock){+.-.}-{3:3}, at: __mptcp_retrans+0x352/0xaa0
>>
>>  other info that might help us debug this:
>>   Possible unsafe locking scenario:
>>
>>         CPU0
>>         ----
>>    lock(&msk->fallback_lock);
>>    lock(&msk->fallback_lock);
>>
>>   *** DEADLOCK ***
>>
>>   May be due to missing lock nesting notation
>>
>>  3 locks held by mptcp_connect/20858:
>>   #0: ff1100001da18290 (sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_sendmsg+0x114/0x1bc0
>>   #1: ff1100001db40fd0 (k-sk_lock-AF_INET#2){+.+.}-{0:0}, at: __mptcp_retrans+0x2cb/0xaa0
>>   #2: ff1100001da18b60 (&msk->fallback_lock){+.-.}-{3:3}, at: __mptcp_retrans+0x352/0xaa0
>>
>>  stack backtrace:
>>  CPU: 0 UID: 0 PID: 20858 Comm: mptcp_connect Not tainted 6.18.0-rc7-virtme #1 PREEMPT(full)
>>  Hardware name: Bochs, BIOS Bochs 01/01/2011
>>  Call Trace:
>>   <TASK>
>>   dump_stack_lvl+0x6f/0xa0
>>   print_deadlock_bug.cold+0xc0/0xcd
>>   validate_chain+0x2ff/0x5f0
>>   __lock_acquire+0x34c/0x740
>>   lock_acquire.part.0+0xbc/0x260
>>   _raw_spin_lock_bh+0x38/0x50
>>   __mptcp_try_fallback+0xd8/0x280
>>   mptcp_sendmsg_frag+0x16c2/0x3050
>>   __mptcp_retrans+0x421/0xaa0
>>   mptcp_release_cb+0x5aa/0xa70
>>   release_sock+0xab/0x1d0
>>   mptcp_sendmsg+0xd5b/0x1bc0
>>   sock_write_iter+0x281/0x4d0
>>   new_sync_write+0x3c5/0x6f0
>>   vfs_write+0x65e/0xbb0
>>   ksys_write+0x17e/0x200
>>   do_syscall_64+0xbb/0xfd0
>>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>  RIP: 0033:0x7fa5627cbc5e
>>  Code: 4d 89 d8 e8 14 bd 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
>>  RSP: 002b:00007fff1fe14700 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
>>  RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fa5627cbc5e
>>  RDX: 0000000000001f9c RSI: 00007fff1fe16984 RDI: 0000000000000005
>>  RBP: 00007fff1fe14710 R08: 0000000000000000 R09: 0000000000000000
>>  R10: 0000000000000000 R11: 0000000000000202 R12: 00007fff1fe16920
>>  R13: 0000000000002000 R14: 0000000000001f9c R15: 0000000000001f9c
>>
>> The packet scheduler could attempt a reinjection after receiving an
>> MP_FAIL and before the infinite map has been transmitted, causing a
>> deadlock since MPTCP needs to do the reinjection atomically from WRT
>> fallback.
>>
>> Address the issue explicitly avoiding the reinjection in the critical
>> scenario. Note that this is the only fallback critical section that
>> could potentially send packets and hit the double-lock.
> 
> Thank you for the fix!
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> Out-of-curiosity: any idea why we only see it now while the fix tag is
> from July? :)

The deadlock is deterministic, when the relevant pre-conditions are
reached; but such pre-req are quite/very unlikely:

- the peer send an MP_FAIL [1]
- the ssk/pm/msk tries to send an ack reply with infinite mapping
- allocation of such skb fails [2]
- the scheduler kick a mptcp-level retransmission before any other
  later transmit [3]

Eech of [1], [2] and [3] is quite/very unlikely and we need all of them
with suitable/strict time scheduling.

(mostly wild guesses on my side)

/P

