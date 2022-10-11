Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C7B3C32
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 17:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1665509930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yr4dB2EH6BUF28dIGd9BRZ7Z6ej27chEoX2+zKtekM0=;
	b=ZNSE2jjm0p6eoAe5treQjOeLV2eaKogyKlfsW0z34Qr/OusAPlKwiMhrrjGV8U2OXEddg2
	A4BBTia8AS3pxitmTFa0Rjaa1wawiR4dpftBU/4/ISdxBEzKI2UK8jDUJvi6Fc7M4LtlB5
	80dq6r3G126MBq8y4bnxcck/2GdwtsY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-179-gaUoyeg7NtaBd-OvpSzcvg-1; Tue, 11 Oct 2022 13:38:49 -0400
X-MC-Unique: gaUoyeg7NtaBd-OvpSzcvg-1
Received: by mail-qk1-f200.google.com with SMTP id bk21-20020a05620a1a1500b006be9f844c59so12138661qkb.9
        for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 10:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yr4dB2EH6BUF28dIGd9BRZ7Z6ej27chEoX2+zKtekM0=;
        b=7CObl/INYXQV04c8EVSaWUY9Oc3vLza7Z90TSHmCaoyHJteVg2esL/EISQrbxAAivR
         PzU531pCCfVKlPtxXGD6aG/Cu/daS5ikb4itVJZDsDZS8UEZgl1pKcmnMbBnsxDtFnBO
         63s+DjAyNbHPxa3BYcQaMyies11H/0PDOppB9N5Ch4VxiuVPs44PeZcin1s5oyQIeBqN
         GnNrNKspdmBY8YnLxf91WsUqfaTUK28cMpZIgJy494NcDHYKiYbwgh6XzUINK8ISFuNZ
         s/bfAoy0zBKGURsL3YeTFE1JaGNyt8V2qWJ/gPoCPZcGg9TQkigTDzgDg2vTh4RFp3TK
         xUfA==
X-Gm-Message-State: ACrzQf2QRJqGC2u1ahMHDt10+ydT4/hUonGFWIg+Djguscb4rU5RVQbI
	auXUsJvux/r2W0ZqNE5I+41C/+/1k2d+rUXOX6NMvgtf6yeVEm3pVV6PUs7IniA2W+bfXP+S2oI
	3q2mfIT47UeV9jvWelOtS/QTXslo/0R3taZ605XrYvpfkenj7pdkY4pai+m+ELr5Q
X-Received: by 2002:a05:620a:1a9d:b0:6cb:e3f3:eb3c with SMTP id bl29-20020a05620a1a9d00b006cbe3f3eb3cmr17171930qkb.711.1665509928573;
        Tue, 11 Oct 2022 10:38:48 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5qpIRzlg3/kGfUpdt3tXwtNqi7xiQd4q7gyIDveDNwwPnfQLNOmrJqifeE+N6TIXCvxfqQ7g==
X-Received: by 2002:a05:620a:1a9d:b0:6cb:e3f3:eb3c with SMTP id bl29-20020a05620a1a9d00b006cbe3f3eb3cmr17171901qkb.711.1665509928102;
        Tue, 11 Oct 2022 10:38:48 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-103-235.dyn.eolo.it. [146.241.103.235])
        by smtp.gmail.com with ESMTPSA id g2-20020ac85802000000b0035d08c1da35sm11259032qtg.45.2022.10.11.10.38.46
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 10:38:47 -0700 (PDT)
Message-ID: <fb7201a8ae4c7cc73af6de247f88c4650098de85.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: fix abba deadlock on fastopen
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Tue, 11 Oct 2022 19:38:45 +0200
In-Reply-To: <a75bb4d763160a59a9059ae8598a542f913ad7e2.1665509144.git.pabeni@redhat.com>
References: <a75bb4d763160a59a9059ae8598a542f913ad7e2.1665509144.git.pabeni@redhat.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2022-10-11 at 19:26 +0200, Paolo Abeni wrote:
> Our CI reported lockdep splat in the fastopen code:
>  ======================================================
>  WARNING: possible circular locking dependency detected
>  6.0.0.mptcp_f5e8bfe9878d+ #1558 Not tainted
>  ------------------------------------------------------
>  packetdrill/1071 is trying to acquire lock:
>  ffff8881bd198140 (sk_lock-AF_INET){+.+.}-{0:0}, at: inet_wait_for_connect+0x19c/0x310
> 
>  but task is already holding lock:
>  ffff8881b8346540 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_sendmsg+0xfdf/0x1740
> 
>  which lock already depends on the new lock.
> 
>  the existing dependency chain (in reverse order) is:
> 
>  -> #1 (k-sk_lock-AF_INET){+.+.}-{0:0}:
>         __lock_acquire+0xb6d/0x1860
>         lock_acquire+0x1d8/0x620
>         lock_sock_nested+0x37/0xd0
>         inet_stream_connect+0x3f/0xa0
>         mptcp_connect+0x411/0x800
>         __inet_stream_connect+0x3ab/0x800
>         mptcp_stream_connect+0xac/0x110
>         __sys_connect+0x101/0x130
>         __x64_sys_connect+0x6e/0xb0
>         do_syscall_64+0x59/0x90
>         entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
>  -> #0 (sk_lock-AF_INET){+.+.}-{0:0}:
>         check_prev_add+0x15e/0x2110
>         validate_chain+0xace/0xdf0
>         __lock_acquire+0xb6d/0x1860
>         lock_acquire+0x1d8/0x620
>         lock_sock_nested+0x37/0xd0
>         inet_wait_for_connect+0x19c/0x310
>         __inet_stream_connect+0x26c/0x800
>         tcp_sendmsg_fastopen+0x341/0x650
>         mptcp_sendmsg+0x109d/0x1740
>         sock_sendmsg+0xe1/0x120
>         __sys_sendto+0x1c7/0x2a0
>         __x64_sys_sendto+0xdc/0x1b0
>         do_syscall_64+0x59/0x90
>         entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
>  other info that might help us debug this:
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(k-sk_lock-AF_INET);
>                                 lock(sk_lock-AF_INET);
>                                 lock(k-sk_lock-AF_INET);
>    lock(sk_lock-AF_INET);
> 
>   *** DEADLOCK ***
> 
>  1 lock held by packetdrill/1071:
>   #0: ffff8881b8346540 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_sendmsg+0xfdf/0x1740
>  ======================================================
> 
> The problem is caused by the blocking inet_wait_for_connect() releasing
> and re-acquiring the msk socket lock while the subflow socket lock is
> still held and the MPTCP socket requires that the msk socket lock must
> be acquired before the subflow socket lock.
> 
> Address the issue always invoking tcp_sendmsg_fastopen() in an
> unblocking manner, and later eventually complete the blocking
> __inet_stream_connect() as needed.
> 
> Fixes: d98a82a6afc7 ("mptcp: handle defer connect in mptcp_sendmsg")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Whoops, sorry this is not the patch I tested. Self-nack

/P

