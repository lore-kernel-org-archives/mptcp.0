Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CADE32825A
	for <mptcp@lists.linux.dev>; Wed, 26 Nov 2025 19:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186398; cv=none; b=jy/M29mofkXnooS/ZvjnqZF7LmrmfVg4FTy+JLh2gYW3Q68JpZO/XQADVHBIjqv97jTfGeHS+6QLLZLeEbz4GkGUHKYLCs3RuSr0of1/qP7yS1gyVgaqLKXc3Y06htaqLFIGlGX2ljJDWZTASbxCSVh7USTwNADmv2i4TZvCtaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186398; c=relaxed/simple;
	bh=irdSvN8p3YQiyU1mcrVPjV4TvmyU7tlLo5I/811su7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KXFgxzNIt/jEsv4F9SAFsl/sVI6IQnpLffwjlBCt0uNnH/q54fqfxWb7n5C2+nlINaZ7x8uEot44G7JCSklakIV9QZRLjvgY07JAJE6PVw6q7xEN72gxJfje2LB3I7T+2C+MmH8k3GV+cJssc3wBahGvCsBEArWE2Lw2IaBXixw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ibo8aWOY; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ibo8aWOY"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-bc0d7255434so97351a12.0
        for <mptcp@lists.linux.dev>; Wed, 26 Nov 2025 11:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764186396; x=1764791196; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wM9emwVjFaP8Ns34GcMWOeG3cAT7jXot8heL9Ol9wlQ=;
        b=ibo8aWOYhAa+kxwc6sYVrJvk1/ahbaGGl54ex0fQ0I5B31r9jBt/lokQWDDI58WSk+
         NXqReGUJocoiFvUKrWr8wsYM7XhsVmisOQwecDJ18G6/SfGJoUwyv0wXcgN8DzOTW3Hb
         2DXTP+3k6sRCqH6nI7P5+orweX9bCH92LdCI5hUxr8c6ehz654jtSx5fD6jOBmPNUBJC
         w+25c61y2xy+PsxUYxGyO2CXxuhHOSHbrjFJYHr/tKsnRkfR258CFnvEKnVvbXvOnf9I
         L0fXUPnOUTFgNY9Prv3MZbZ7usnoBQ2L8PPZ895D3EpefDR7tWcAmUj9OpHc38NN9M7W
         EwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764186396; x=1764791196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wM9emwVjFaP8Ns34GcMWOeG3cAT7jXot8heL9Ol9wlQ=;
        b=tCf3nAN9QC7MA8FahbfD+nCFnlQzuJJnTzXyWRJkHqtvaRjToGLfRfAWvYews4R5b1
         tn/H9crckJqvNNQeVbEExFjc2ftj7ADmToFJ+3GL/vSno2l4FKLqAmreLVMfKWo8iM9O
         XVLUIOVetP6Z8SfsJ0G+pDATCwcFQYcXUWrs+t1U87ULpwxW5VViIFK53D9An1ISdnQa
         feCEoKzlPvOBcyNUtSPotMMQ/YX1F0O8w11sL48g+vgoGcJemoCQthGQgxpgERDROL3H
         rYdQZ2z6HnPAQu/HM4b/nbfnlobA1KCxWBluhHcb4yefWUNDQFDzO6aZk9Od/iIA55C6
         oW2A==
X-Forwarded-Encrypted: i=1; AJvYcCUJZiATgXv56wlnh34iQHqm0/cC5aWERGoFir0pgtdKS6qA6pVkvAblOuTGMYnCtWR4oVIvSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxiPH3OtV/sCux/knw6h16vKkWdUWi080Ka1334Iwa6Q2DXJRgp
	OK1QzLyi2kNGH/UymYGf2dY2ocyC7iMuLSy5kt6PZxF8sYgrn8z1eGsLKCRCReq0WrrPF2Sk9ts
	jlcf5CCZF1pb0lPrg/Alfw4dr/or3r5az/IKDClT9
X-Gm-Gg: ASbGncuiMuob6UOQRG6qLdVZs7cRqKA81qoJZpPJzQ4d3bolj/BhUJ7utG519D/E5Xf
	LBmhg3jeQjO6Nfs7/zsNxPnqch3DY4o1VbwHe4CzT/lbtFEOVANp9NPl/RDgxj9SRGp48mrfaD9
	bSLuvjHC7xUdi+z3u+607QfIYotQn1q2l2e8vaUXCEob4+IyOfwsM5obLMJdnh+V/IcoanXkKMb
	9JNDZWyOpmfZrQpMd+7yKB9cAnxxzP2mPAwDK4MLBe/OVRxcniQ1JSxbf0psj3b0en7gLVLBmGY
	FmtzaQkuahkl9smu+4P82WzOwet2uyc/EcoDQSNhjHLd3sNZWSNqm8U0Sw==
X-Google-Smtp-Source: AGHT+IG3+tw1osInmsjSD0QyBy+N7qAFiCjoYqj9/jWW2h65Ys+FcevIq1yYaiu32eAr+vyV2K9qgM3gH4+pauXRkTQ=
X-Received: by 2002:a05:693c:8211:b0:2a4:3593:468b with SMTP id
 5a478bee46e88-2a9418bc6c0mr3901206eec.39.1764186395281; Wed, 26 Nov 2025
 11:46:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251125195331.309558-1-kuniyu@google.com> <bd417bb2-212b-4657-a509-e0ed0edb5647@kernel.org>
In-Reply-To: <bd417bb2-212b-4657-a509-e0ed0edb5647@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 26 Nov 2025 11:46:23 -0800
X-Gm-Features: AWmQ_bnIP4IJKRJ-ibS2wKhVbp_zNoX1JN72AlKjF9N-fBhx1Jvn4VelPnOxl0I
Message-ID: <CAAVpQUDqKTmEheVYb31_iGpsePG=CeNLmrpraYFRKu=sE6CpDA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next] mptcp: Initialise rcv_mss before calling
 tcp_send_active_reset() in mptcp_do_fastclose().
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+3a92d359bc2ec6255a33@syzkaller.appspotmail.com, 
	Mat Martineau <martineau@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	MPTCP Linux <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 8:36=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Kuniyuki,
>
> (+Cc MPTCP ML)
>
> On 25/11/2025 20:53, Kuniyuki Iwashima wrote:
> > syzbot reported divide-by-zero in __tcp_select_window() by
> > MPTCP socket. [0]
>
> Thank you for having released this bug report, and even more for having
> sent the fix!
>
> > We had a similar issue for the bare TCP and fixed in commit
> > 499350a5a6e7 ("tcp: initialize rcv_mss to TCP_MIN_MSS instead
> > of 0").
> >
> > Let's apply the same fix to mptcp_do_fastclose().
> >
> > [0]:
> > Oops: divide error: 0000 [#1] SMP KASAN PTI
> > CPU: 0 UID: 0 PID: 6068 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT=
(full)
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 10/25/2025
> > RIP: 0010:__tcp_select_window+0x824/0x1320 net/ipv4/tcp_output.c:3336
> > Code: ff ff ff 44 89 f1 d3 e0 89 c1 f7 d1 41 01 cc 41 21 c4 e9 a9 00 00=
 00 e8 ca 49 01 f8 e9 9c 00 00 00 e8 c0 49 01 f8 44 89 e0 99 <f7> 7c 24 1c =
41 29 d4 48 bb 00 00 00 00 00 fc ff df e9 80 00 00 00
> > RSP: 0018:ffffc90003017640 EFLAGS: 00010293
> > RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88807b469e40
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > RBP: ffffc90003017730 R08: ffff888033268143 R09: 1ffff1100664d028
> > R10: dffffc0000000000 R11: ffffed100664d029 R12: 0000000000000000
> > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > FS:  000055557faa0500(0000) GS:ffff888126135000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f64a1912ff8 CR3: 0000000072122000 CR4: 00000000003526f0
> > Call Trace:
> >  <TASK>
> >  tcp_select_window net/ipv4/tcp_output.c:281 [inline]
> >  __tcp_transmit_skb+0xbc7/0x3aa0 net/ipv4/tcp_output.c:1568
> >  tcp_transmit_skb net/ipv4/tcp_output.c:1649 [inline]
> >  tcp_send_active_reset+0x2d1/0x5b0 net/ipv4/tcp_output.c:3836
> >  mptcp_do_fastclose+0x27e/0x380 net/mptcp/protocol.c:2793
> >  mptcp_disconnect+0x238/0x710 net/mptcp/protocol.c:3253
> >  mptcp_sendmsg_fastopen+0x2f8/0x580 net/mptcp/protocol.c:1776
>
> Note: arf, sorry, I just noticed my small syzkaller instances found it
> too, and I should have caught it before. I thought this issue was linked
> to another one [1]. It is not: this one here is specific to TFO where
> mptcp_disconnect() is called directly in one error path not cover by the
> selftests.
>
> [1]
> https://lore.kernel.org/20251125-net-mptcp-clear-sched-rtx-v1-1-1cea4ad21=
65f@kernel.org
>
> >  mptcp_sendmsg+0x1774/0x1980 net/mptcp/protocol.c:1855
> >  sock_sendmsg_nosec net/socket.c:727 [inline]
> >  __sock_sendmsg+0xe5/0x270 net/socket.c:742
> >  __sys_sendto+0x3bd/0x520 net/socket.c:2244
> >  __do_sys_sendto net/socket.c:2251 [inline]
> >  __se_sys_sendto net/socket.c:2247 [inline]
> >  __x64_sys_sendto+0xde/0x100 net/socket.c:2247
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f66e998f749
> > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ffff9acedb8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
> > RAX: ffffffffffffffda RBX: 00007f66e9be5fa0 RCX: 00007f66e998f749
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
> > RBP: 00007ffff9acee10 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> > R13: 00007f66e9be5fa0 R14: 00007f66e9be5fa0 R15: 0000000000000006
> >  </TASK>
> >
> > Fixes: ae155060247b ("mptcp: fix duplicate reset on fastclose")
>
> I see that this patch targets "net-next". I think it would be better to
> target "net". No need to send a new version, this patch applies on top
> of "net" without conflicts, and Paolo told me he can apply it on top of
> "net".

Ah sorry, I didn't find mptcp_do_fastclose() in my net worktree
and started working on net-next, but my net tree was just stale.

Thank you for the review and sync-up with Paolo!


>
> The patch looks good to me, and can be applied to "net" directly:
>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
> While at it, just to help me to track the backports:
>
> Cc: stable@vger.kernel.org
>
>
> > Reported-by: syzbot+3a92d359bc2ec6255a33@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/69260882.a70a0220.d98e3.00b4.GAE=
@google.com/
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  net/mptcp/protocol.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 75bb1199bed9..40a8bdd5422a 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -2790,6 +2790,12 @@ static void mptcp_do_fastclose(struct sock *sk)
> >                       goto unlock;
> >
> >               subflow->send_fastclose =3D 1;
> > +
> > +             /* Initialize rcv_mss to TCP_MIN_MSS to avoid division by=
 0
> > +              * issue in __tcp_select_window(), see tcp_disconnect().
> > +              */
> > +             inet_csk(ssk)->icsk_ack.rcv_mss =3D TCP_MIN_MSS;
>
>
> I initially thought this should have been set in mptcp_sendmsg_fastopen,
> before calling mptcp_disconnect(), but doing that here is probably safer
> to catch other cases, and it aligns with tcp_disconnect(). So that's
> perfect, no need to change anything!
>
>
> > +
> >               tcp_send_active_reset(ssk, ssk->sk_allocation,
> >                                     SK_RST_REASON_TCP_ABORT_ON_CLOSE);
> >  unlock:
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
