Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E953C3448
	for <mptcp@lists.linux.dev>; Fri,  8 May 2026 10:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778235158; cv=pass; b=aojwA4GMNBQxIrCX5NbCjdlo10XqM3q9pCe8Nj6ASN04VlzkXPnlPlzQS4wiB2ajc2jnFC9MHpHQ8jsuY+bjGbYfbk4MPmVkUVEiPxhLS/S4d2JddT56/Q5v7aA2zVGh1UWsmc3676h++R7WxlqXxYs4WAvtI1jEiDSf44JUP/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778235158; c=relaxed/simple;
	bh=LT7ysWygFRb5XHmGYFSi8roQO61YU0XqLJPHPDzg9Qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KwqFyfGnvwzK+W8Q/Dj5KmhVN9Frm1/WVw8GEpahd3AiEtGYq5I0EjwQREs4v9KT1URtNdpyMdG5RXlLsrYi6IJvn53UYPv4vnPCQRz8CbsGxa01q0ybCaBS2w7jocfflFT7dtD9OYhiW+lC6KSxBYiZrKCWBelpm0TECvuC1fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EqP0mTzu; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EqP0mTzu"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8acb3dab8dfso11752366d6.1
        for <mptcp@lists.linux.dev>; Fri, 08 May 2026 03:12:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778235154; cv=none;
        d=google.com; s=arc-20240605;
        b=LBEoEYymgtU7X89skOECiCbA7rXnwUh0GWKYH9PDOKP7eujOXY9vcTu6hoQq043qpf
         FrLrMmiRwM1//nvKWYYQDSFHdOgJWtMvfyjVi9pTEhgVrkLmtRonBrjfIikyboZzsQfD
         4QpdQeO0VD4ydlBIHKeMJiwjaT5S3bNOWk//iOcL22r2z3rQsCjFBl37QU9ehwGOr2Pb
         zwht/EPcnUGxzC77/4cT4UL+R85m2Gij2WnSWCLYayKfBlmDc6HPWvnrSMLuLfJQaIB6
         GRa/pJoJKXJ5YU3pvkhvxenBwlo4FiEyM9l2e0VNjjKDlL3Z+0CBZsQ0MWjCouBZsNSZ
         pWZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7mAtSB0fhfPNmCzgDAnHDDrpvMKYqrii7haYSeS/TPk=;
        fh=+pxo1ZxBvH9/e2RvgCfi4yLXM239RTlbIC6NEhD/ADE=;
        b=LFid6340E3f+LXV2AjNpX7eUSDCYfWESvy+7rK2HDViN8G2BEkqteW32t2QN9yo/dc
         Vk5IglS1dg9YDxpJpEwDgMd5qlE2xSBdzQAVB37vaNM2pSMwLEA1qMmaa3/++BxSBiXz
         Fv8lD/pGnjzNDLkJZFl8CbgU4S72yo8Og+3tGA6pkV4q8Xd2BcGOyHLWkWHZJujIhJrs
         u9XuVMEQFNlPJSHoWiKFhyyPkDwOlvfIq9EZnmcnUgTD8k3eCYr5QwMFhxwZM+rv4t/l
         EnN5bTs0qOQ5FB4I3p7qQisZU1hWYvvrWBjZvw66SNRzQun66hjiSk0fNTVJYj5lz0m9
         l8kg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778235154; x=1778839954; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mAtSB0fhfPNmCzgDAnHDDrpvMKYqrii7haYSeS/TPk=;
        b=EqP0mTzuMQ3EQIrFBSlQ3nQ7KcyKb/6Fdd16J15DUQGkpllOw+Q5q551zrnBRotBr2
         /u0pO7WB2wQWZVaqFTeQDbwZTjtqBSxvicg2zHC52c9rkCl5HzbPH25Iv0PkvxB+NfEt
         XCbSYoDof7nASmC/AJNlmVDCXL+9wYmWtRnQnhrtGMiokkQAz5H+SAUYJ9x3CAmd5jSB
         22K4LSHF+zfO5iqoSYovXvnROkkB056SQNF9HV3TfzMiJvPEsDlHYu86qxiBt4Y6roVb
         0k/xuKbOMdePEGts+7bzsxUHvhassFsaPrAopLGr9p2dfFfa6NPi8Tz00FV9V5bysvbZ
         kTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778235154; x=1778839954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7mAtSB0fhfPNmCzgDAnHDDrpvMKYqrii7haYSeS/TPk=;
        b=LWLYu9JAA3uu/qBG6brZ1nxsuYdUdtexIqOhWv4tgsu1WpjmsowQyY9NJRUPeLxwMU
         tdWMc76FnFQuD4Lg9qo8dodHPaGCVG+zaLEvx2cmkqZrivp5tBpJtKw4jYehFZv+Qa6N
         6+VsekUU1yu0hDnA8lDuaDuS67CCmdfSskp3nBXE/uuUuuDLxH9Fou0qwSeSqlxWfWpZ
         MHRKlca+mfob+YzwX5z3uWgCblKgWeASfpqFJpCpKngrHX+eQYSN5IZxqQVvAj9/+Xs/
         u25DrjQnp9Xy+Tl3Y5V9t3PVcv979KWOKpvHr/ZObWE1Owp35JggCXqWSTlXsGR9Bg4H
         pv+g==
X-Forwarded-Encrypted: i=1; AFNElJ//VaM6ss4qlNw3vmZvbZn2Xd6PfhQe0VVRxgviGYQAkAn1q5P8jFlxc9FVAM8BWEyWKOLHhg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxvDWb5RvebSF28tUIE5/geVe/L02D07Qp1jPJ2juI4PFz1ruwU
	lJcTWoysz2cilwvAjZ8EAyzQK1DVq66E9XQ/jWrT2KAGmI+WmG3i2o5Rh7/k4hufRD3dW8ee4aS
	U+ZuGTU1Lu357FQMbVUHEP2vlkTZ8NsPc9+W65xpU
X-Gm-Gg: Acq92OEN+parw4/JU3q+/qloECdx4iVt/ZlPq1heDiJBJzNRz7XxxgPbL4znalGCk62
	Mk04sl8N7BD/kE2OVMjZ+lR2lZJZWDB+kyfm8n3bPD2vh5836wQGWtFMcOlBU3LJL7Ux2RWbx7+
	pdrbjGHbQs/FBkUBK4HWk5QXHpEgR16nsxieD1B+uPTDrvaZ3V4a6H0wBMsE681hNCrVQTSXCrG
	nUGUqc7uFpLxSbfoUxDiJ8g1tSp38HRSlkiBNldsrH8Y+ZGfWYMedqEjnzEJokFtgDrbSBTqaTJ
	OhBv0CTm64YTgcf1EDhmmGJqMIfrU6kKmHZkP5QHrQ21OgCG
X-Received: by 2002:a05:6214:800c:b0:8b3:f59b:6c8 with SMTP id
 6a1803df08f44-8bc449ab1a3mr161621136d6.31.1778235153654; Fri, 08 May 2026
 03:12:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <69f8e352.170a0220.bb392.0005.GAE@google.com> <2a9bde65-d2de-44cc-9192-e7aa8a0935a7@kernel.org>
 <672f5b7d-6fa0-41c5-a950-2890028c8572@redhat.com>
In-Reply-To: <672f5b7d-6fa0-41c5-a950-2890028c8572@redhat.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 8 May 2026 12:11:57 +0200
X-Gm-Features: AVHnY4ICtjb03wnJjv5y_YGqHH_Bj4PnE9CvOp-cDffapZw4vrOfw_IVfJ7SdZA
Message-ID: <CAG_fn=Ud-sXzebnwvsiwnu6e0uOHRAFzmUH91Du9pek7Fsx5bA@mail.gmail.com>
Subject: Re: [syzbot] [mptcp?] KMSAN: uninit-value in mptcp_established_options
To: Paolo Abeni <pabeni@redhat.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, kuniyu@google.com, 
	syzbot <syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, mptcp@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 11:27=E2=80=AFAM 'Paolo Abeni' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On 5/7/26 9:44 AM, Matthieu Baerts wrote:
> > Hi Paolo, Kuniyuki,
> >
> > On 04/05/2026 20:20, syzbot wrote:
> >> Hello,
> >>
> >> syzbot has tested the proposed patch but the reproducer is still trigg=
ering an issue:
> >> KMSAN: uninit-value in irqentry_exit_to_kernel_mode_preempt
> >
> > It looks like the issue is different now:
> >
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >> BUG: KMSAN: uninit-value in irqentry_exit_to_kernel_mode_preempt+0xb0/=
0xc0 include/linux/irq-entry-common.h:472
> >>  irqentry_exit_to_kernel_mode_preempt+0xb0/0xc0 include/linux/irq-entr=
y-common.h:472
> >>  irqentry_exit_to_kernel_mode include/linux/irq-entry-common.h:547 [in=
line]
> >>  irqentry_exit+0x7b/0x760 kernel/entry/common.c:164
> >>  sysvec_apic_timer_interrupt+0x52/0x90 arch/x86/kernel/apic/apic.c:106=
1
> >>  asm_sysvec_apic_timer_interrupt+0x1f/0x30 arch/x86/include/asm/idtent=
ry.h:697
> >>  kmsan_get_metadata+0x17/0x160 mm/kmsan/shadow.c:125
> >>  kmsan_get_shadow_origin_ptr+0x4a/0xb0 mm/kmsan/shadow.c:102
> >>  get_shadow_origin_ptr mm/kmsan/instrumentation.c:38 [inline]
> >>  __msan_metadata_ptr_for_load_4+0x24/0x40 mm/kmsan/instrumentation.c:9=
3
> >>  tcp_data_queue+0xdc/0x7c90 net/ipv4/tcp_input.c:5589
> >>  tcp_rcv_established+0x19bb/0x3200 net/ipv4/tcp_input.c:6656
> >>  tcp_v4_do_rcv+0xc4b/0x1b10 net/ipv4/tcp_ipv4.c:1852
> >>  sk_backlog_rcv include/net/sock.h:1190 [inline]
> >
> > That's the input side.
> >
> >>  __release_sock+0x360/0x7d0 net/core/sock.c:3216
> >>  release_sock+0x22d/0x300 net/core/sock.c:3815
> >>  mptcp_subflow_shutdown+0x358/0x690 net/mptcp/protocol.c:3144
> >>  mptcp_check_send_data_fin+0x31b/0x3d0 net/mptcp/protocol.c:3218
> >>  __mptcp_wr_shutdown net/mptcp/protocol.c:3234 [inline]
> >>  __mptcp_close+0x860/0x1360 net/mptcp/protocol.c:3313
> >>  mptcp_close+0x42/0x260 net/mptcp/protocol.c:3367
> >>  inet_release+0x1ee/0x2a0 net/ipv4/af_inet.c:442
> >>  __sock_release net/socket.c:722 [inline]
> >>  sock_close+0xd6/0x2f0 net/socket.c:1514
> >>  __fput+0x60e/0x1010 fs/file_table.c:510
> >>  ____fput+0x25/0x30 fs/file_table.c:538
> >>  task_work_run+0x208/0x2b0 kernel/task_work.c:233
> >>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
> >>  __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
> >>  exit_to_user_mode_loop+0x306/0x1b60 kernel/entry/common.c:98
> >>  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inl=
ine]
> >>  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:23=
8 [inline]
> >>  syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
> >>  do_syscall_64+0x236/0xf80 arch/x86/entry/syscall_64.c:100
> >>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >>
> >> Local variable mp_opt created at:
> >>  mptcp_incoming_options+0x11d/0x43b0 net/mptcp/options.c:1171
> >
> > Confirmed here. With "struct mptcp_options_received" while the original
> > issue was with "struct mptcp_out_options".
> >
> > Plus I'm not exactly sure to understand the issue here: mp_opt is
> > defined and used only in mptcp_incoming_options(), and I don't see
> > anything using it after the end of this function. Or did I miss somethi=
ng?
>
> I also had hard time understanding the backtrace, I think some frames
> are omitted/missing (it happens sometime, IDK why), specifically the one
> related to mptcp_options_received() - which would be useful to
> understand the issue.

This is probably related to
https://lore.kernel.org/all/69e7ee1f.a00a0220.17a17.001d.GAE@google.com/T/

Let me send the patch, perhaps this issue will also go away.
