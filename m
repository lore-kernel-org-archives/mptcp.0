Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12973A6B70
	for <mptcp@lists.linux.dev>; Fri,  8 May 2026 09:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778232431; cv=none; b=cHkscD2Gs7pHiLPT6Gyvjjy10BD16kPYM+K77pPa9mFT/tUYdWGivPL1rf22PO3mXzaedy75gTVaylPtMpS5tOnRXpGXW12w8OiS94x9FmBftgN4sAEM2/pdL5mHiJ6JtUy7P0PT7NK7/mRgnMJO+yj+q9hJ46m0Q5+zWXfOau0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778232431; c=relaxed/simple;
	bh=V4kDeJTuxMV4wGE+j3yJ9xkVPECPgWQ/zKTceHzP+MM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MdXCRKb79PsCkASoSqHOF9Zi004l0Z7871UT2mQ5qtE9CrrGrtOk2FgtoTb0lcEqFmA75uzOomLRBcAfGrcZNWY7+HbyABlyXv4mEejolnH8C2cxhGmBM4vefw++CUFcSt8aOWYqWFV/LFo9fXK9maAi5y5DRYIceCtUNnCA3qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IqF5ilOs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IqF5ilOs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778232427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yqFCirjwaNXC71lfQpg3WCqBJm972r3MEu/J87DEZaU=;
	b=IqF5ilOsNxAjOgKqy++z7mk1pew6rTyuEay7Uyk/1WZgC0DNR+wAHJNmb6jyt8aGn9oGVz
	Et6phCq4u4ZAjeLyBkEfG27Y/nOfSxKAQ5QCCFlqq5kClIFT76UcHifY61QbbNxvEL3R89
	gnmfvmRFyTEGumRSUZec3cxGdsOTVFU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-3_FTABT8P2-pewbGvlKLuA-1; Fri, 08 May 2026 05:27:04 -0400
X-MC-Unique: 3_FTABT8P2-pewbGvlKLuA-1
X-Mimecast-MFC-AGG-ID: 3_FTABT8P2-pewbGvlKLuA_1778232423
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44d68ed8f95so1232318f8f.1
        for <mptcp@lists.linux.dev>; Fri, 08 May 2026 02:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778232423; x=1778837223;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yqFCirjwaNXC71lfQpg3WCqBJm972r3MEu/J87DEZaU=;
        b=kSIYPqtJ1/YwUWh3e3mc/T2bot8ZgFRJKvKcaqMYq/VScu0UTmPqZcaeZPWPeZ7NXR
         67jkYKhJrqbYSmteBxgHWwB/M8+BXe/5V0NgeOxZosxUJFvAUWn+ZrYNdTKYV9wd5aSe
         1MxWMEb03qFOR67K3osQRZYsLPuPt5i3RS2/b2e11TniY6eOSFaq6Eyr4G6wN6b4IcBD
         /3fYS73wZ2ga69ThUy0AM8TYXga5KdHRKexQd62DRlsMI9ieBzu69/QJ4be7tsrKdJQB
         Uk7384cgdTmZgMJkKIYgtJ5gV5bdZuOyWCXPoGLO9BQYzsJLXoNFTcf8y/AB4EZC3YBW
         HuSA==
X-Forwarded-Encrypted: i=1; AFNElJ+GcaaKUrX5Ov+Rcd6oOan7tHaWuVd+24wLyNVVd+WAXvhn6D09+wwqS4uftCapQr3qOSY53g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzN7tybBwmbel2W33QBFMUmO6/SQzn6NvVFgwVS/xXih3K81oF8
	+t4xa/lMquYx3wXr6HwM8tDEKbYNWOHzd8J0AGX01vmGg0/9Up3LpWtxLU8trqjxh8z8gdsH8Gt
	l6UM+IKWXm2fc5JOsLwHEf91MnfDvr75OJLpDMgPpehBdTAbjqRleRE5g
X-Gm-Gg: Acq92OEYpCErWZMNyV7DLMwzP3Y77TsMsSyIorM+ypdDDsUorv4ABgjOgpS2f0XdpZ/
	WLwlM+SCO+T7Ox9MWJuw43eHiIQ0J2GwzcccuyvYoN3uwhuZM5aUuC+J+vpz6moZsa+boJ2EQMR
	SG9596tB8LKABBibaWrMJ1yqAxdbQj8QXB29aD6JtTPt0qEMh5g2+UQp2V32kD0/kiVvVnlWjN8
	SVLFQL8m1JUr1oKZW30mPa9Yl4Cn6Qsro4k6LRawqLacxTa0hg07SIkO59JzkoJR4V/+Zv4guQk
	MYBCwZq+4ul5JD1LAgumv5NJHL1HEMGQw+QecIt7+i05alAA1IXAAHAtD9eL2v4OBcQBY4kxk8s
	1rziGl+EOv4PBRX0ZyD7eSweEpkRnFZVTk6heQxGwOO6Lp231IR3Af2ZW0ESyVYiJ27t2
X-Received: by 2002:a05:6000:280c:b0:454:353e:3f4b with SMTP id ffacd0b85a97d-454353e3f91mr2777763f8f.3.1778232422820;
        Fri, 08 May 2026 02:27:02 -0700 (PDT)
X-Received: by 2002:a05:6000:280c:b0:454:353e:3f4b with SMTP id ffacd0b85a97d-454353e3f91mr2777732f8f.3.1778232422229;
        Fri, 08 May 2026 02:27:02 -0700 (PDT)
Received: from [192.168.88.32] ([169.155.232.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491f8d4c3sm2853992f8f.34.2026.05.08.02.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 02:27:01 -0700 (PDT)
Message-ID: <672f5b7d-6fa0-41c5-a950-2890028c8572@redhat.com>
Date: Fri, 8 May 2026 11:27:00 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mptcp?] KMSAN: uninit-value in
 mptcp_established_options
To: Matthieu Baerts <matttbe@kernel.org>, kuniyu@google.com
Cc: syzbot <syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, mptcp@lists.linux.dev,
 syzkaller-bugs@googlegroups.com
References: <69f8e352.170a0220.bb392.0005.GAE@google.com>
 <2a9bde65-d2de-44cc-9192-e7aa8a0935a7@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <2a9bde65-d2de-44cc-9192-e7aa8a0935a7@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Uvy2UrjV_epmP9Vqvl-N56tFa8WPWo54frzx_-MjZfw_1778232423
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/26 9:44 AM, Matthieu Baerts wrote:
> Hi Paolo, Kuniyuki,
> 
> On 04/05/2026 20:20, syzbot wrote:
>> Hello,
>>
>> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
>> KMSAN: uninit-value in irqentry_exit_to_kernel_mode_preempt
> 
> It looks like the issue is different now:
> 
>> =====================================================
>> BUG: KMSAN: uninit-value in irqentry_exit_to_kernel_mode_preempt+0xb0/0xc0 include/linux/irq-entry-common.h:472
>>  irqentry_exit_to_kernel_mode_preempt+0xb0/0xc0 include/linux/irq-entry-common.h:472
>>  irqentry_exit_to_kernel_mode include/linux/irq-entry-common.h:547 [inline]
>>  irqentry_exit+0x7b/0x760 kernel/entry/common.c:164
>>  sysvec_apic_timer_interrupt+0x52/0x90 arch/x86/kernel/apic/apic.c:1061
>>  asm_sysvec_apic_timer_interrupt+0x1f/0x30 arch/x86/include/asm/idtentry.h:697
>>  kmsan_get_metadata+0x17/0x160 mm/kmsan/shadow.c:125
>>  kmsan_get_shadow_origin_ptr+0x4a/0xb0 mm/kmsan/shadow.c:102
>>  get_shadow_origin_ptr mm/kmsan/instrumentation.c:38 [inline]
>>  __msan_metadata_ptr_for_load_4+0x24/0x40 mm/kmsan/instrumentation.c:93
>>  tcp_data_queue+0xdc/0x7c90 net/ipv4/tcp_input.c:5589
>>  tcp_rcv_established+0x19bb/0x3200 net/ipv4/tcp_input.c:6656
>>  tcp_v4_do_rcv+0xc4b/0x1b10 net/ipv4/tcp_ipv4.c:1852
>>  sk_backlog_rcv include/net/sock.h:1190 [inline]
> 
> That's the input side.
> 
>>  __release_sock+0x360/0x7d0 net/core/sock.c:3216
>>  release_sock+0x22d/0x300 net/core/sock.c:3815
>>  mptcp_subflow_shutdown+0x358/0x690 net/mptcp/protocol.c:3144
>>  mptcp_check_send_data_fin+0x31b/0x3d0 net/mptcp/protocol.c:3218
>>  __mptcp_wr_shutdown net/mptcp/protocol.c:3234 [inline]
>>  __mptcp_close+0x860/0x1360 net/mptcp/protocol.c:3313
>>  mptcp_close+0x42/0x260 net/mptcp/protocol.c:3367
>>  inet_release+0x1ee/0x2a0 net/ipv4/af_inet.c:442
>>  __sock_release net/socket.c:722 [inline]
>>  sock_close+0xd6/0x2f0 net/socket.c:1514
>>  __fput+0x60e/0x1010 fs/file_table.c:510
>>  ____fput+0x25/0x30 fs/file_table.c:538
>>  task_work_run+0x208/0x2b0 kernel/task_work.c:233
>>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>>  __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
>>  exit_to_user_mode_loop+0x306/0x1b60 kernel/entry/common.c:98
>>  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
>>  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:238 [inline]
>>  syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
>>  do_syscall_64+0x236/0xf80 arch/x86/entry/syscall_64.c:100
>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>
>> Local variable mp_opt created at:
>>  mptcp_incoming_options+0x11d/0x43b0 net/mptcp/options.c:1171
> 
> Confirmed here. With "struct mptcp_options_received" while the original
> issue was with "struct mptcp_out_options".
> 
> Plus I'm not exactly sure to understand the issue here: mp_opt is
> defined and used only in mptcp_incoming_options(), and I don't see
> anything using it after the end of this function. Or did I miss something?

I also had hard time understanding the backtrace, I think some frames
are omitted/missing (it happens sometime, IDK why), specifically the one
related to mptcp_options_received() - which would be useful to
understand the issue.

/P

