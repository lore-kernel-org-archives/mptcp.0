Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52361199C2
	for <mptcp@lists.linux.dev>; Fri, 19 Apr 2024 10:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713522809; cv=none; b=L73Bj36OByAOawmP5I1WDq/b2Tr2QHb6eywwTHZstsn/cqH453tgyWmTJ/b1BpHbwWyK+b6y1bBbJFif35+StGXfGiQYDJ2+0AGWEGNfSwU+6G1K9WKK66cuUXoYRumTVvxv6tA5prIq9lSXlgU+MnSWWXsKGtjBNRg3xntaZ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713522809; c=relaxed/simple;
	bh=T2eVMDOSr9fA112q8YfZKyKdT2UoaQctxG0YPmm1a6s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l+DWJH9txVKbdO5rIF1GVnfZTsxUGIr89LKb4IlGBSVOQJfUJlrOSOOOyeAxNUx++FIpux1ozjWJXmczScQBqyiAkY/RWVEKJ90fPejJgjDLLv+/OCy1PybIu7I86lVre1mrJ2AVd9paxYkFXCUgmQmp3iyc/sB/4vW+czkJkMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bLfz5tTR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bLfz5tTR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713522806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AZYAo09ncDYu5GNdAb38wdzFYQ8k3KAtqO2bTDe/nok=;
	b=bLfz5tTRoK6MfDFe9/cEmiEpN46/1uid7H1vYrESZPW9KchEVUB6PEwTFtkMqX33ISaDEw
	KJOqjtPUcfrpx416Z9JQl8/k7gFf1H+imqb8tO2vn9jgJFeblsv8Awctt5T/xdsHuIEKax
	o2K567QaIiPeCtae+BtpEh7h6Oh09mI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-ApXKAIFfNCy-mlBdifOH0A-1; Fri, 19 Apr 2024 06:33:25 -0400
X-MC-Unique: ApXKAIFfNCy-mlBdifOH0A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-343eb7d0e0eso291580f8f.1
        for <mptcp@lists.linux.dev>; Fri, 19 Apr 2024 03:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713522804; x=1714127604;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H8N99AYH1eAs7PnA6jQEWSZmAlPPhr8PwebTTenusuU=;
        b=lg+OtdstcXzACaXwGkgLhmuLVVK/aWHS2PRoVhbOLuiGElLJjOXeVckLMwNmXwh3Ij
         Oo4QGTKFF7ILZdJu/ZOUEIA0InCa9ZpkIRbnB5ZortN+We+cnadOnLCJoNIn4nmAtZsK
         sCEo41WD1zfn9t4HAeXjjKx3uNSTdEZPcVDzG5Vh9qqET/WyBo6RITu+aX+9GA0mddnk
         wDQYpQNSRKJBV83y1Yj44hGWJ28/ISqDaszO++X/f3eznGUXEK3Yy4tsxfSBLtkVc3rW
         CNg41Bc0zgOi9blL4iauF038Mjanz0i2beQ5qO1gYoYx7Msu1UhWFFZzFQVLDM3RNzQo
         Kk9g==
X-Gm-Message-State: AOJu0YzUmA5yOnguuBufCxxcYzgAhk9b/6ok5aFybwyUDA3avFWbXSJq
	QlyE5DFfGG6B10hj/OhoXCdIcYWfCRCzNPkscYHB00s+kXXv3wrzn/l9bWQ/tc8H/2LHi923ntg
	S9/Vpv+jDHx0ieeReITcvcBFRFEgsYV+uFGiMAUod6jMYrOdxn15p
X-Received: by 2002:a05:6000:10e:b0:343:7228:f715 with SMTP id o14-20020a056000010e00b003437228f715mr955192wrx.0.1713522803703;
        Fri, 19 Apr 2024 03:33:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8G5OnSjHPgAubzcQA2hAIAmSvEpJn199MAWRd6ys6Cs+5qjWUv45V8AW65DJRcBspQRexJw==
X-Received: by 2002:a05:6000:10e:b0:343:7228:f715 with SMTP id o14-20020a056000010e00b003437228f715mr955178wrx.0.1713522803263;
        Fri, 19 Apr 2024 03:33:23 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-227-179.dyn.eolo.it. [146.241.227.179])
        by smtp.gmail.com with ESMTPSA id e4-20020adff344000000b0034349225fbcsm4079416wrp.114.2024.04.19.03.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 03:33:22 -0700 (PDT)
Message-ID: <489104fb63bdef5493a179ee84058cb8aa11c9f2.camel@redhat.com>
Subject: Re: [PATCH mptcp-net v3] mptcp: ensure snd_nxt is properly
 initialized on connect
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <martineau@kernel.org>, Matthieu Baerts
 <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Christoph Paasch <cpaasch@apple.com>
Date: Fri, 19 Apr 2024 12:33:21 +0200
In-Reply-To: <422a4453-7344-e5dd-342f-577baa9743b0@kernel.org>
References: <3b0ca23eaa8906f967a841f55bafed48d0f895cb.1713367699.git.pabeni@redhat.com>
	 <422a4453-7344-e5dd-342f-577baa9743b0@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2024-04-18 at 09:59 -0700, Mat Martineau wrote:
> On Thu, 18 Apr 2024, Paolo Abeni wrote:
>=20
> > Christoph reported a splat hinting at a corrupted snd_una:
> >=20
> > WARNING: CPU: 1 PID: 38 at net/mptcp/protocol.c:1005 __mptcp_clean_una+=
0x4b3/0x620 net/mptcp/protocol.c:1005
> > Modules linked in:
> > CPU: 1 PID: 38 Comm: kworker/1:1 Not tainted 6.9.0-rc1-gbbeac67456c9 #5=
9
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el=
7 04/01/2014
> > Workqueue: events mptcp_worker
> > RIP: 0010:__mptcp_clean_una+0x4b3/0x620 net/mptcp/protocol.c:1005
> > Code: be 06 01 00 00 bf 06 01 00 00 e8 a8 12 e7 fe e9 00 fe ff ff e8
> > =098e 1a e7 fe 0f b7 ab 3e 02 00 00 e9 d3 fd ff ff e8 7d 1a e7 fe
> > =09<0f> 0b 4c 8b bb e0 05 00 00 e9 74 fc ff ff e8 6a 1a e7 fe 0f 0b e9
> > RSP: 0018:ffffc9000013fd48 EFLAGS: 00010293
> > RAX: 0000000000000000 RBX: ffff8881029bd280 RCX: ffffffff82382fe4
> > RDX: ffff8881003cbd00 RSI: ffffffff823833c3 RDI: 0000000000000001
> > RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> > R10: 0000000000000000 R11: fefefefefefefeff R12: ffff888138ba8000
> > R13: 0000000000000106 R14: ffff8881029bd908 R15: ffff888126560000
> > FS:  0000000000000000(0000) GS:ffff88813bd00000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f604a5dae38 CR3: 0000000101dac002 CR4: 0000000000170ef0
> > Call Trace:
> > <TASK>
> > __mptcp_clean_una_wakeup net/mptcp/protocol.c:1055 [inline]
> > mptcp_clean_una_wakeup net/mptcp/protocol.c:1062 [inline]
> > __mptcp_retrans+0x7f/0x7e0 net/mptcp/protocol.c:2615
> > mptcp_worker+0x434/0x740 net/mptcp/protocol.c:2767
> > process_one_work+0x1e0/0x560 kernel/workqueue.c:3254
> > process_scheduled_works kernel/workqueue.c:3335 [inline]
> > worker_thread+0x3c7/0x640 kernel/workqueue.c:3416
> > kthread+0x121/0x170 kernel/kthread.c:388
> > ret_from_fork+0x44/0x50 arch/x86/kernel/process.c:147
> > ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
> > </TASK>
> >=20
> > When fallback to TCP happens early on a client socket, snd_nxt
> > is not yet initialized and any incoming ack will copy such value
> > into snd_una. If the mptcp worker (dumbly) tries mptcp-level
> > re-injection after such ack, that would unconditionally trigger a send
> > buffer cleanup using 'bad' snd_una values.
> >=20
> > We could easily disable re-injection for fallback sockets, but such
> > dumb behavior already helped catching a few subtle issues and a very
> > low to zero impact in practice.
> >=20
> > Instead address the issue always initializing snd_nxt (and write_seq,
> > for consistency) at connect time.
> >=20
> > Reported-by: Christoph Paasch <cpaasch@apple.com>
> > Tested-by: Christoph Paasch <cpaasch@apple.com>
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/485
> > Fixes: 8fd738049ac3 ("mptcp: fallback in case of simultaneous connect")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > v2 -> v3:
> > - init snd_nxt/write_seq instead
> >=20
> > v1 -> v2:
> > - moved the initialization at established time (Mat)
> > - dropped debug code wrongly landed in v1
> > - added fixes tag
> > ---
> > net/mptcp/protocol.c | 10 +++++++++-
> > 1 file changed, 9 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 3e1b15d76442..4205cef2d45f 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -1002,8 +1002,13 @@ static void __mptcp_clean_una(struct sock *sk)
> >=20
> > =09=09if (unlikely(dfrag =3D=3D msk->first_pending)) {
> > =09=09=09/* in recovery mode can see ack after the current snd head */
> > -=09=09=09if (WARN_ON_ONCE(!msk->recovery))
> > +=09=09=09if (WARN_ON_ONCE(!msk->recovery)) {
> > +=09=09=09=09pr_err("sk state %d:%d snd_una %llx write_seq %llx dfrag e=
nd seq %llx frag len %d bytes sent %lld acked %lld",
> > +=09=09=09=09       sk->sk_state, msk->first ? msk->first->sk_state: -1=
, msk->write_seq,
> > +=09=09=09=09       msk->snd_una, dfrag->data_seq + dfrag->data_len, df=
rag->data_len,
> > +=09=09=09=09       msk->bytes_sent, msk->bytes_acked);
> > =09=09=09=09break;
> > +=09=09=09}
>=20
> Hi Paolo -
>=20
> You dropped this debug code in v2, do you want it included?

Nope, it's there by mistake. @Matttbe: could you please drop this chunk
while applying the patch or do you prefer me to resend the patch?

Thanks!

Paolo

