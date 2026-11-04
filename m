Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793752106;
	b=zeNrUc7UlgKEExODohqwTW9asHL1UPMjCHuxIa/f5fcuCWVBBH7sShnlM/+TlklFQDlb
	 wJ3oeEIcMxGEX9rCPM+yy/C+0vGvCzkyO2nLNKEbPwBXdE4gXUmvJYNcAFIOeGj8jCDR8
	 nVByZSwHcwK4udaRplcFrWyxrxPKjk1lMRvMF3qRUZ7sfutl24KYaVaMdt4dgkiDhQcA1
	 E1HlSUCxPts7AwsmRGHtPPKdFiAko2Vtb5FRIUQIAPLd10iC/AwRQkPNk0EnWszMZrhXq
	 /1EmxYv1xmyRzJzos1ZdTyWQeumw5D3qB9znkGlbPLio+zTSKrREgCPcnjNWdgoCfxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752106;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=N9u2giWdwIjOfoxPhFOBtJJGKmXk1nnXCe77BsBVdFw=;
	b=dMyo/fZeR/3bKSl/bjHl6q7LJNYIf8u0AsL9EjNFZVdp2rErVEr33vEWVLLbgUXm7qq+
	 t9h7SB0MT3MtnEwCMkanLkwLwax4Onil7vXl+E5tTSwHO/vQjasApV432B8M+02sjY0Ap
	 clV6xliwBeA8yh+WM5S0T+M6EiAcZw8sZJMaAo8KosSzSvFPfmlGd8ePrEcErQe/m7nm3
	 he57U3DO/gosw0t0Hy8f27GzMgxxNhxNOP+KJEYrgXC8M9di6NcAx+fbnInKDbdW/Su9d
	 OEwEQaXZi+VBrIE2O5HDHgFeZL0/nzyfxz5YzZAIXWxN367ooj9QaKt/Jj883PJ1KdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JMFdv+A+;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A902606A324
	for <mptcp@lists.linux.dev>; Wed,  4 Nov 2026 00:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A902606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JMFdv+A+
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ad787e0593so99719a91.3
        for <mptcp@lists.linux.dev>; Tue, 03 Nov 2026 16:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793752106; x=1794356906; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N9u2giWdwIjOfoxPhFOBtJJGKmXk1nnXCe77BsBVdFw=;
        b=JMFdv+A+nLVRX7TTKXLy3YVCmcjukmmouwKE9qb1/7XuXzNNiit2kl+woSiRoTPrMZ
         waKNYO+VUGCWRZwzLDDauIvM0xJadQTOXNqFKueZQRsaBccDnKNCF2ik6Br59K/Hf4oM
         +wRJ7LNJJ3J900rDFQfW/aYxvbRYd2YST6Mm43R2hUAEA3JUB1ClGqoVESL6Wc5bMrI5
         ZVIopzvBNWStTwftP98XDFoeGE8MI9H8OKFnzcyQ71mWHk1I0B0sIbZdNuFPmUpr6Ort
         mJBO4bvHbRaMpw1K6jIVxoSaUTswld90XGZAj0gka4LE8S3884rS/6EEvCGn1z2l5LNW
         4jIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793752106; x=1794356906;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N9u2giWdwIjOfoxPhFOBtJJGKmXk1nnXCe77BsBVdFw=;
        b=2eAvmNXz0/GxGrBXg/nMW+a82+Q9JEiFhMlnIYvzaciyn3V93Bdmi2y6Jm1gGsWeR+
         QhMVtekQSXsH6x4/VCacUSFKLKuB/O7oXh/0+zrtMZMlvCz/c0Pcbr/XcHnmN7Tlzwcj
         Z6NscRwdX77jvaKwa/pHFvLAUEZKPxJy/aO4vLZjE69oSlyplcodjE88/CVXoUUkv6QT
         fodwJ/ElbKw1envc/YSbkV9/DJpK0uOpelZv2xuQAgsQF8hrNYG7aRmBvR39tCQLvHGb
         nxL8ofsDiQjw1dkvCG8OKr09nwCHmob9sSuLnWH50PFyZZMtTfoF/C45THzzEjnn9rD2
         q7oQ==
X-Forwarded-Encrypted: i=1; AKwUvBx3Ykzd3HuYBn7oLGh7d/yVX9ah+6X4c6KQklTkuW0t2vESxBgNdVlAcGVPQa0jTteo4ijHXg==@lists.linux.dev
X-Gm-Message-State: APuU4Z95o3uk5Pg5auzzEpsnmkAGHtTJQlLeCaHf4PWHv9IxuXs/W9Ts
	YN8v2njKVexycFZMBw9bd8zL4f2UKgqv/v/BlxaRB11+Fa/QFUgwev1H
X-Gm-Gg: AYBFou2c37fufFTM7+6jQh16AQHLdx3u2vv5jTvsx4FKxWAgei6m8j6F/vDJjtnp0Vx
	s6mfkH4B9LAiLNMI7XIcWbb5Jf/G93r4ctyCRAx0F0fUNIIvWHPkwNLw77qiIp/oHLofr1JCf6b
	2Qhm+ICTpRTwQADz6PtTH57lj/2rQ0IaXfIdf5XdI42yDN+JgShg2gglbB0629Uu1utPMCA4Ncb
	lLcXawLDiC2CGGGuwyOvVv1H7aAuzKT9LSXafrU4DbVl0TF7gh4vFqLl4IvWOilg5xBcegHhFJH
	dc8+i1E2ZQkZtZsEKRhlTesLPmqUtccYsoNmr4Tvh3NCa5Nvg+TGxsgumquL4gUGlVyii6M5k2s
	ozfPe6TPZbU5WahtNcHmWcQERc2diPmras9VZWvvXP5BzYCdtMhsjgnipix7/hA8x0cPA6g5vZU
	1dZv2UrUp8k7WMxSqUpWGrnubd6WL5ZiVtowt1Z9yrhOQi9aeNoL0Cz/bjk1lrMHAE/7gfddKy/
	FBhTbWqbqNIxI1Ttd1vJfdAbsWS4QkSwsPZTftP5L3pHFgIprioPYHfv2YoliMpJvDtSx7224nW
	VCaUQ6WI9CxRm999ypLJiuRM2mE05PCQlxOW04SvWx3RW9XFnchEdqJ0KCNUvXQQ75losp7kqCu
	thlbEqtcmbZF3ruEa4nxDNjIBciJg1a3k+A==
X-Received: by 2002:a17:90b:2741:b0:3ac:7556:8eda with SMTP id 98e67ed59e1d1-3ae897b955emr11276403a91.26.1793752105586;
        Tue, 03 Nov 2026 16:28:25 -0800 (PST)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b093d481a3sm1165337a91.1.2026.11.03.16.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 16:28:25 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 00:28:24 +0000
Message-Id: <DMM01WTK5E12.1RIGV9OGW23PZ@gmail.com>
Cc: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
 <jiayuan.chen@linux.dev>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
 <kuniyu@google.com>, <willemb@google.com>, <matttbe@kernel.org>,
 <mptcp@lists.linux.dev>, <mason@kernel.org>, <josef@toxicpanda.com>
Subject: Re: [PATCH bpf v2 03/15] bpf, sockmap: Don't let an SK_PASS verdict
 cover the next message
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <netdev-bot+sashiko@kernel.org>
In-Reply-To: <179374187706.488855.8366350890804573396@kernel.org>
References: <20261102072112.4160195-4-alexei.starovoitov@gmail.com> <179374187706.488855.8366350890804573396@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 03, 2026 at 01:37 PM netdev-bot+sashiko@kernel.org <netdev-bot+sashiko@kernel.org> wrote:
>> +		if (!psock->apply_bytes)
>> +			psock->eval = __SK_NONE;
>
> When psock->apply_bytes is not 0, eval stays __SK_PASS during the push.
> The budget is still debited only after tcp_bpf_push() returns. Can a
> second sender on the same socket still get past the prog here?

Yes, as today. It's already explained in the commit log.

> But B's message is sized against the budget before A's in-flight bytes
> are removed from it. Would it be better to reserve the budget before the
> push? That means debiting tosend, and ending the verdict when the budget
> reaches 0, before calling tcp_bpf_push(), instead of subtracting after a
> failure.

No. That breaks the single sender. After -EAGAIN the verdict has to
cover the bytes that the push didn't send. A refund after the failed
push can land on B's verdict.

> The shared-cork problem with two PASS senders already existed. The kfree()
> variant used to need a third sender to end a byte-limited verdict. The
> early reset makes it reachable with only two senders.

yeah. It's an old bug, not from this patch.
Two senders are enough today too. B's first message goes out with A's
verdict, and the code after the switch resets eval. The prog runs on B's
second message. SK_REDIRECT frees the cork that A still pushes.
The log of patch 13 says that a cork is not safe for two senders.
Jiayuan proposed to serialize the senders in the reply to that patch.

> With the early reset, can sender A's bytes be charged against a verdict
> that another sender installed?

Not a bug. eval, apply_bytes and sk_redir belong to the socket, not to
a thread. B's verdict ends early and the prog runs again for the rest.
