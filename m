Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793752175;
	b=K3fbyXp7NmXKk+iBg5p6414yRLdX7NKhoBTnO6yz0/eqPIevq18VwECqkzfEYIKT3sH5
	 PqQlVJXfWhu247OQtvgpHzY+NFSaGRS4mMWQwKE9uTH+W1JcdkHuRcLThcyUFFWI5E4oZ
	 oGe1kVjdBhUT5VmrdZ7J4mTn+hW9StxAyoAYw0eMcySW77UJlxdbvD6cixvKVT+sPGuW8
	 PwAAmMQhN6jpXwkZfe7DlBMnYg88M9RCGDBodwJ5qBLhzgarD/W2/ekzvaeOzI7qA/HOq
	 1fl8EzPo2uIi8XUb3B8Io6+//BnRdo2yaQ+Hkv2jEpFd2rvIQn58NatG53kZrx9RTQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752175;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=/eXhEqhme6RLyDy1UKx6O3gu8VaW7aGNyJfDtIx+o0Y=;
	b=r/jtrHnthaOmjZcdMLQbsci8vuQsI/3EnjmMyloceaGm45/0+ezfIaCJfC6npYcGZ+lh
	 A7HCOZl1LRwe4WWWlyc+V52RlsB3GKLunhCv0AMjEunxQVInRNX9PkbOnt/AAHF7K5oUa
	 I6WOALIAHsxaY8MADC1799714sU49XwDyYKLbFRmDDHrr8sVWBaQq8iIF5jVqElE3AxRE
	 yDrYYHZqHyokUrZ1XC3O4H1ixLp1jJoe2NMZVptdG2rBydQrvRQFPgfx3Eg8XpOx+pqWY
	 jx5c5A0bwKRtAEZKZwejBN131XLQrrxnqK7hKXBFR84rHRl7qeY4KnpALcDLQuMDKzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="NuGP/sLQ";
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6003C606A324
	for <mptcp@lists.linux.dev>; Wed,  4 Nov 2026 00:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6003C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NuGP/sLQ
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a06ca6e8f4so151032b3a.1
        for <mptcp@lists.linux.dev>; Tue, 03 Nov 2026 16:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793752175; x=1794356975; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/eXhEqhme6RLyDy1UKx6O3gu8VaW7aGNyJfDtIx+o0Y=;
        b=NuGP/sLQrwvP+Fh8/zZV0NLXfxzLzA3jirlTO29COuBwer7+Zn2EvTHzqBs1oHHrWf
         OlqzDMR4/C2RER7A3Qg9XV5qaAz47fYAYL1Q6lDtKp0TlDb9Jqo1Tc0TYve7yIDVmLmR
         cADVyRoyeunnMDW9ODgYl+KrdxHBv2kB6wutA1LBjFahzYgJETCaP9D6ECDZzU9A2vao
         UGPnGUsthzD3KKFbBVvOqM3uOa1DFiL4PZvK9mMda/UQ2gGqPyhDraOXZ3zS1PzPinSs
         D/XZzp2vfsOSaW0hgl+yUIB2ZYA2S3Vl0SQkkOfEOVWwfF5sdfK3S8kSf7R5NBRZ55aQ
         opYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793752175; x=1794356975;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/eXhEqhme6RLyDy1UKx6O3gu8VaW7aGNyJfDtIx+o0Y=;
        b=OrYDww1gz1JVufEvulqFrU0KaF8UMSiosICDPo/egNe6KOmd7HySN1dwX3LUgZiRYG
         U8fxGqev5giTwVni0hEp5mXgcN6LNJmCNmo05aBQZXkMC42xym1EYuFcYL4RclQEPmmj
         apPwkZIBE0OQqsfKP2N3ABlQOf6sz8FUN6tl8TFvbk0fW9eIqm4t0e7mBDbBhDTCl0Ur
         Viab7mHK7U4p0c6nRbMhTmKZUTYEPwACqLfj2DalxqnmhAVVKYfdw+M24E87M+mw0u56
         cZOuTPUKuvBOgNgOQoW3p4IofoQ499+dPtGZId0KAAdrXTO1fFLqbam6Ny6zGj2tGp/B
         9enw==
X-Forwarded-Encrypted: i=1; AKwUvBy8BiFbJoT8cZmAl+5FYalGjBUHWXJ0pFOKflvTW1mjzkmoLbZ/6qpppgrD76dqCCuRcCRbFg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/bSPwoEcdc3QmDUg/IJazGpvZm+qWfEGCq5nFLVbn0cUTybh3+
	+39MEjO1+DLiuihPG1P1mmb583h0YBBPcY1NCpXxqyS33aQieRX50n7k
X-Gm-Gg: AYBFou1kw9OgRsrs9nHVYTsWRPIIt9Ag4llOOQmAesOAt7UB9Xf1yVyOkIv+1/5V8x+
	AjnJQDwTvxA1wVjavbEOQEicqqK8hAdV1FGENwf7FgFeoVPTCpQmy7Er3y8l0IyXYtpl1k0d4E7
	yNX10X6lrGAEOPGkyl8DZz3PZ15ASTqjS2dZYnvjJc/PliUEIsNpDUDhR3KmrSOtLU3kLECuIgz
	i+NG2h/UWfXi8RUlhMV7XenuLOeZ59+kTzlHCaJPfWakOFd2kW3ff+eK/vuiNoCsMnNZ3eiq0lk
	6uQDWkm7+UYUeV7OXjA8RF0YEmsttpCeMSYWmlWdYQk6RcmBtsnt7LpGOycMY+gXO0QAltN13IW
	TAqQDBujMhthyw7dZU7TXanD2uHEWUtWRLpUZycL62KRKem7clQgLlaoFA+yTgMKL1pL2m+ihFq
	uEHVC48kE/scZVjSq/gEsZBy9AatoqYrt5vbXm52Op/bvC161Hr4kDdQvNoTyAAp7VPu9CBbjrB
	ZoA7hGjg0aXIor6Ze9L6dBaAc4E256fa2DZNgrkQk38I7rUaaSN2TqSjq1HPmUUzDx60NrypQXa
	IaOZXIJoHEqya3h66M2+8n+4BQ24CljJlCqgcbFTtKaYxoRQTKKQhlPEWVImFnrW5VW3XgUxIad
	pFabuO7RHeV1tbIXWq+pZN8g247j6xd+xgw==
X-Received: by 2002:a05:6a00:4c15:b0:89d:e6e2:b2a6 with SMTP id d2e1a72fcca58-8a9bd4e6f67mr10982582b3a.45.1793752174633;
        Tue, 03 Nov 2026 16:29:34 -0800 (PST)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09a7cbe56sm180227b3a.10.2026.11.03.16.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 16:29:34 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 00:29:33 +0000
Message-Id: <DMM02SF04UK0.3RQNDSDPR2SGW@gmail.com>
Cc: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
 <jiayuan.chen@linux.dev>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
 <kuniyu@google.com>, <willemb@google.com>, <matttbe@kernel.org>,
 <mptcp@lists.linux.dev>, <mason@kernel.org>, <josef@toxicpanda.com>
Subject: Re: [PATCH bpf v2 07/15] bpf, sockmap: Check the target of an
 egress redirect before each send
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <netdev-bot+sashiko@kernel.org>
In-Reply-To: <179374188061.488855.10389706003415159913@kernel.org>
References: <20261102072112.4160195-8-alexei.starovoitov@gmail.com> <179374188061.488855.10389706003415159913@kernel.org>
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

On Tue, Nov 03, 2026 at 01:38 PM netdev-bot+sashiko@kernel.org <netdev-bot+sashiko@kernel.org> wrote:
> This isn't a bug introduced by this patch, but the comment mentions
> unaccepted children as redirect targets. Can tcp_bpf_push_locked() hold
> the lock of such a child while the listener tears it down?

yeah. It's an old bug, not from this patch, and not only in sockmap.
inet_csk_listen_stop() takes only the BH lock of the child.
tcp_abort() calls lock_sock() on such a child too. See
commit dbd62ad55a4c ("tcp: avoid double destroy in tcp_abort() of an
unaccepted child").

> After that, the retry check here returns -EPIPE. So the window exists only
> at this commit, or in a backport that takes this patch without the next
> one.
>
> Could the series be reordered so that fix lands first?

No need. The window is there without this patch too.
This patch doesn't add it, and patch 8 closes it.
Both patches have Fixes: 4f738adba30a.

> This is a pre-existing issue, but it is related to the sleep above. Is a
> redirect sender that sleeps in sk_stream_wait_memory() on the target woken
> at all when the target's owner closes it?

It isn't. It's an old bug, not from this patch.
The sleep is interruptible. A signal or SO_SNDTIMEO of the target ends it.
