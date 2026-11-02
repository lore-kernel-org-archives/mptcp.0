Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793645688;
	b=WyFxzeEZpur5l5V0Eeg1A9sm6QRBqVuHJETgmkKhIJ4iDZP7GZ1AIrnKHwbkJXrh2YKe
	 VncTpthFgYw6J5HW2n4hItsmQKJRJ5D8+1OAjFvHJ/buaVKkjGVQxrRi0dfvDQtqPpOus
	 Zbloc31tPBEVImk/e8cbX8x80pPA9Ut2lXNWuV5xr31IClOZHTQjwj+ZAh03Ddfwtf+SM
	 eh8IGPIkkFti2vzdgfGlEc6eNws2r8BZsXnXCdVkt6CE1VTY6Euu5ZcyITwMTl5wIDv7+
	 geHbJzUqHUgwbUJjUn9/JGx3qyI2a6aU0mLxUxorr9nW6ypxN6wDIQ8F38X8MUlopCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793645688;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:User-Agent:References:In-Reply-To:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=6aeVIk6rnbx33zfjOjUUS+2fD1SQ2yd81uhuQUT7lRc=;
	b=P3z7OQr6jmtI5tWoGYsJesvY0Jyv9TVLhnZylIeX8hQ9RkMJvQxNyVp2IY7QUwgAdCg4
	 MOMTk2VRv+Dj0u9ksLx/KAwFA49kQ7z9A0a7mUPUxYuXxGPUCTT/aOlUohoZbql0bOvgN
	 StkA939NTennxG6efMomLd78VWiwhaJ4Zsw1GKlw1LWgR6xnbDokS+I4bDVl+AWQjF5wu
	 g9O5+xUQTVfL2uKNwzMMTRJH4TOUoCWyVEkKBWOrS5YuOrumPOZWAlC4wwgbmQauidQcy
	 dVxgXP07GnofBGXG1blG3IA2NdFBhX8dneC/S3fB1g4ZyK7z2YIAZ32mtsiuL+KkqXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vc0QHe5X;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB91606A32C
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 18:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCB91606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vc0QHe5X
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e9d7791b00so26630615ad.0
        for <mptcp@lists.linux.dev>; Mon, 02 Nov 2026 10:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793645687; x=1794250487; darn=lists.linux.dev;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6aeVIk6rnbx33zfjOjUUS+2fD1SQ2yd81uhuQUT7lRc=;
        b=vc0QHe5XlPpkbqndhp/WGTtnCgXIzEP0clN2d+i5z/2rZOSoPL4AbhHUdvuKD3/vzi
         pWzDownrkfnb9adlT51tQygB3rbZ5E1Qu2GE8aYzT5lLBXTwHH6o5xH5nerXSfSezAX9
         ymDsTNsyrtl2+3hqi0MSfix30V7euLhJkkv5VgGr30E9tUI34DAw9L7NP4X0THitZphT
         HNOc47+gQhnd7L0NY0wBo3DtsQZTlRc4KY3CAnwAgMwOKJJxD6wuqqMy15t/NVjo0NtN
         2M52TljKxNiOdK/awABCNgXP/An4W9llr4d/9Y5Ghc+vBpMrZ/NMMjTxyeOub/rYKTeZ
         5kLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793645687; x=1794250487;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6aeVIk6rnbx33zfjOjUUS+2fD1SQ2yd81uhuQUT7lRc=;
        b=K7suGWl4+fbRN3HhR4T7ZSV5fUYx0J/OZFrTVRnI4rUsn60lRvwE6GUQYngHV0EcYe
         k9y/Vg30bXMDyPJl+a7QXsfKa4hO6inggYbhilNPQvNRv5ZbCZNGlF27qBUQbgV2a9XM
         Km/NIqAJsRPUvK4I2g6SQwOB9R4EZ9hOibU1sVAlqlgr1GTIYRiNqEneYc2wmpqbLwkG
         Vd2M4F+DwZPpbjV544r5cWl7GqKDS1FQbEijh+ZzOu1jtlzLqu3oYAvBMbNVmarM6pzl
         s5C8qOUorfRJ4oYkG5yt07sM1wWHFOZDtlLamuqciOIOr/0g50qtfXn1wPYzHQuBw/5Q
         HNqA==
X-Gm-Message-State: APuU4Z/bLSugP8pkjf2R9qape3cz900kDD6NrnTX9tULdQEomnWEqN6W
	1ihH6N1b0nBpK56eW4O1uHX+ZpGx6Xe8aGGpwzsTXdsSJe/t5264SScJuboIKA==
X-Gm-Gg: AYBFou3Im8W+2zP/OWYEVinFmS2dfW6J7CZBP+yhlPX8PZOBXxWJz/N2UsRf8Sc+bLB
	iMLdqghO/NIUTtxU61n+RrjxHKEmGoPu7kQnr+3wxXb30WPjx/SiJyvswprH65X6IZOrPLyXuTw
	i3CvuZOxoRpYHqK5J2sMjDP+cxT9dAFW7CR7pBs6RFDX1cbcmGSi9VipqvhMHxu1uw0UVBev0cZ
	ZOZR075gwNI525b9XLZ6u4cZpdc5/tbxTYvxIfuBFrf4GvoUObPLcNrPkna+2I3ziAgLYUaVZR2
	jq7UuoAcskUifvPq/lp5OxvEuILfueD6jUAB2CiLG3sZMUliKzLhxagt3jSEyVupgYUy4lm+Fzh
	h4kq5JlwfKv/q/JqLv9RQy7/77d2oAdz/MnArIwL3at3CUC3hurasEoaSp81pcg+s2quMK/mwjR
	AE4MjOBBZCxr/EtfBGBMC93m9QxZ8gXLA1Nzsv22qSJdY8oMk9wZPPLIAMeVBTUjxJtX900+ry4
	LiHJzsCnhpodU9ufh2qB1rUJeS7MNj4bmDXnf3R9AJVdteQdD7QWwI2OSCNi1iQZTbgEnHKMfow
	FE3LV/bIYq+Lzs6WNe1cZ9wiUAyeCESr5yNHl/Dtsnr7AspWAzKuAEGz53Grv9zVqz9gw33A6Fi
	Yg81rKj1r9Z0O1g==
X-Received: by 2002:a17:902:e88d:b0:2e2:c55c:90c with SMTP id d9443c01a7336-2eb3650b7b7mr104071795ad.64.1793645687169;
        Mon, 02 Nov 2026 10:54:47 -0800 (PST)
Received: from meli-email.org ([98.97.42.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39266f42sm31215645ad.40.2026.11.02.10.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 10:54:46 -0800 (PST)
Date: Mon, 02 Nov 2026 11:51:58 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: mptcp@lists.linux.dev, Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com, matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH bpf v2 03/15] bpf, sockmap: Don't let an SK_PASS verdict cover the next message
User-Agent: meli/0.9.0
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com> <20261102072112.4160195-4-alexei.starovoitov@gmail.com>
In-Reply-To: <20261102072112.4160195-4-alexei.starovoitov@gmail.com>
Message-ID: <tnw1v9.qyjuvdc9kq45@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"

On Mon, 02 Nov 2026 00:21, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>From: Alexei Starovoitov <ast@kernel.org>
>
>tcp_bpf_send_verdict() keeps the verdict of the sk_msg prog in psock->eval
>and runs the prog only when eval is __SK_NONE. For __SK_PASS it resets eval
>only after tcp_bpf_push() returns 0. But the push can release the socket
>lock in sk_stream_wait_memory(), and it can fail. Then another
>tcp_bpf_sendmsg() sends its message and does not run the prog.
>
>With bpf_msg_apply_bytes() the verdict covers apply_bytes bytes. After a
>failed push, apply_bytes still includes the sent bytes. Thus the verdict
>covers more bytes than the prog requested.
>
>Reset eval before the push when apply_bytes is 0. If this push fails, the
>prog now runs for the rest of the message. The same already occurs when a
>message does not fit into one sk_msg.
>
>When the push fails, subtract the sent bytes from apply_bytes. When
>apply_bytes is not 0, eval stays __SK_PASS during the push, and the prog
>does not run for another message, as today. The verdict must still cover
>the bytes that a failed push does not send. But such a message also lowers
>apply_bytes. Thus, if apply_bytes is 0 after the subtraction, end the
>verdict, as after a push that returns 0.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

>
>Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
>Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>---
> net/ipv4/tcp_bpf.c | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)
>
>diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
>index d90bcc911b36..b016aa419fb2 100644
>--- a/net/ipv4/tcp_bpf.c
>+++ b/net/ipv4/tcp_bpf.c
>@@ -457,8 +457,22 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
> 
> 	switch (psock->eval) {
> 	case __SK_PASS:
>+		/* The push may sleep without the socket lock, and it may fail */
>+		if (!psock->apply_bytes)
>+			psock->eval = __SK_NONE;
>+		origsize = msg->sg.size;
> 		ret = tcp_bpf_push(sk, msg, tosend, flags, true);
> 		if (unlikely(ret)) {
>+			/* A part of it may have gone out */
>+			sk_msg_apply_bytes(psock, origsize - msg->sg.size);
>+			/* Another sender can use up the rest during the push */

Interesting. We've never hit this with http parsers. We do use this to
skip payloads some times.

Thanks.
