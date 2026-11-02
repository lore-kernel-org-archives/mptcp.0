Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604150;
	b=PvK/rRPkrSU8az8P28F73vBSvG+GZN6oO3+KLsicOpwai+DB+9ggCmTcZjBhFRznnkTa
	 0OuRgHI5Teaak3vqgEn9tNGiMH3foU4rAPRewESLpkQ76OkgeVpZLyLj8HvO/F7kDau+L
	 QvPU+4zgKg84/M3cv9P7GjR0RXjTunaxpH3frBeCAhkscbjHGB4x6HXj4HAJMuko2rwt7
	 Cjl0+QjOkOjKP/KQelFvZ7URfcwtryhMRikmG7U31Y64q51c9NwSM6FkURrr+2Zjrk87i
	 kdMhcUsSu0R+yUmJDgfoSZQMlXa1h2sghXcJ0ovxIWMDad69SoxVXi7/IxglM3sHcQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9Zt7GQo7rKWxtj60oDqSl5MgB+Al+Ojst9KtoXZQtmY=;
	b=cA2dW3S1ZFRa/bVlo0oML0zCpI7Tbjn7I4HMPExCrhzpd0fVOxZj6JA7zoNbxi2+k/+E
	 3yu04SpS9SZjbXWFLdkKiiSROqUMjPyhVgT4mOCkx7wtTpRFGIvQ4yO6ef6Cu1KxAVRHX
	 jO+8yizHioAwLdLByJ2Iv//ZT+aNdSBboH56axiTmeuz8IYhdYZweASD+YO3SDPzbAGgE
	 qqAr/W14pdx/jMnfhwmPrBdw1E9S/02CxwjBQDzQ12yS3FLoq6VItwFGHUlgBDhOcTotO
	 CCXFnJWJ+QiOACPK8BQT10oQdFc7uDptEfJBgovI9H+Dl9jiSo78R9dMgw0/t3mXq8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nRSsmU1o;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9444606A332
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 07:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9444606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nRSsmU1o
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a05b210703so877343b3a.0
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 23:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604149; x=1794208949; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Zt7GQo7rKWxtj60oDqSl5MgB+Al+Ojst9KtoXZQtmY=;
        b=nRSsmU1obkqFEl8/bSLdojExRZ/cdP8CMu+QHv+/JOjhKF4693Ud8jPPD0TPThmuGN
         +/6ijwzjViIttxNpENYCnqig6Kia/PrBPF9AJNFuAGPRL4TC3gykwz+Pys5+NzZkdHAg
         mWZLowgYwPOYhzSoOXGQWX6/L6fvtyGfBy8cgkzc6R3QvDTfTh4/5VyqNYx0K5P5WgNR
         /e0OFMYR5IKL2oclCK9u+kf9T+UzxIMF55XGaLgNDzFngFGAzuDwPIpnRRCPnQzBQs0K
         Smg6bTTZYPbkmZoZhMwUMmwo8QHnCpzj6swMEsM6OsjpOb9u3aH8Dip5EyOkd7tH+aix
         CfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604149; x=1794208949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9Zt7GQo7rKWxtj60oDqSl5MgB+Al+Ojst9KtoXZQtmY=;
        b=ne1DhypK/9B59kmhPgn7fG11sNY4xN1nJ3h+r9Ehoht2r7xJzk/XPue5ZsnKBoz3Bm
         xmnsPrWa0X5WtgvlXlY63lxWhhB1iYn4IIqAOVsqt72JWE2UagSQlg2t9f0etFOD5pK1
         ux0F6ehaZ6dcwyXWsypm1YkJAJHDk/1ehQa4fqyhHq/3jtt0Cm8WwI/4GVqVU5lUsv+d
         TKkOfkQrIcR3sFnUl2qxi+kSZe23W8j+hfwbdNqW1OD6o/XoCPVJlbOjV4IxU3MBXGNd
         TLdNs01GU4kot9+uuu3GTt7VUqu1n9KqJPcGmrAMkbia4pCEQiMUxTzC2kyonwq5EzGc
         Ye6Q==
X-Forwarded-Encrypted: i=1; AKwUvBycdFgQJhMuZxaIMKE2/ovsIcZXfKXtNNNEUTfKWL+LSXf8tQavnRiQO74vsPnwySBz8vxpYg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9FkjkWeoqlV3aKOP6geD2JGK5EzKnje02gmBBUv2+TFETALGCG
	c7tMiFzCUKKlNdbXCR9wdpULau4Pi/B4JNYuFkTZZYlCsPkXvwrhpXWV
X-Gm-Gg: AYBFou2jB60fFD4hsrzcCRr6TLdP1R31Vm9GZdDNX0cxPWluiCKA2MusbBPmjTWCBn5
	cuGSDr8NOzBlqG5rzl7NIJl84S0ma4nsIRKZycS3VJCaz7qYODd/GDD7rKqORux3oV/GW9lLmrI
	ZBOzuzlPK2l1SfBwToaBtnLPCmQ4qW4DsD4eThTvrEbLuJfgzNKMbm2WBsxVGESUnrbKo9KOeTY
	dklh6UxAUsi0RJE8RGYhoxQvAciSlybVjaVF5XqgqedKfVkhkjuvWr8TGg7nfg5QimfDIzG7Qv8
	PjIW+2zWOTDb5kaDNS9hZbR/sA2+Pb7d+TuWm9Ordo5COGl78O9Ln6/Fel3tjP5TGBWK0RcQFAs
	c0GpuxSUOhN3LaRIxAUzT3TXOlaI1krphMexdH/Ri7BkRX0O5/XQhNl8MparFHkmLPI4BME6rFx
	TEQHybhMEU/a4SeQHzNJ3DLAhpB9IFnOyEXyK3j64ZfXssLI8IkAh8WnWN6S5/Xchx+XKVQcwc9
	kLGk4ISfnEJtbf5tk9PcqPA/biG91ilFOujFg6LChh8AsUZ6m3Mm94jnHEWpWGQ/xGmTRPF3ZXb
	Fg0o4ufktw1ULYLKjgOB37gbIBDY8jtzMUurnti3cHzEBVrBa6X1jdeC0nsTemQpRNMZ5u2OIma
	IWhoLSNN/IQIpzia1rf7gXizowG3N0g0WEgCP5axftIAfTvx5sG5hjP1jl+iNZBDFALZava/jaw
	==
X-Received: by 2002:a05:6a00:a215:b0:882:2195:5a6f with SMTP id d2e1a72fcca58-8a9bf04e229mr7517325b3a.43.1793604148654;
        Sun, 01 Nov 2026 23:22:28 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad7707ed0sm1659597b3a.4.2026.11.01.23.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:22:28 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	mason@kernel.org,
	josef@toxicpanda.com
Subject: [PATCH bpf v2 11/15] bpf, sockmap: Don't copy 0 bytes into a full cork
Date: Mon,  2 Nov 2026 07:21:08 +0000
Message-ID: <20261102072112.4160195-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
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

From: Chris Mason <mason@kernel.org>

psock->cork is a ring. sk_msg_memcopy_from_iter() writes at sg.curr.
sk_msg_alloc() adds room at sg.end, where a full ring has a spare element.

When only a part of the data fits, tcp_bpf_sendmsg() copies this part and
flushes the cork. If nothing fits, it copies 0 bytes. This copy writes
nothing, but it moves sg.curr to sg.end and returns -ENOSPC. Thus sendmsg()
fails without a flush. sg.curr stays at sg.end, and from there a copy moves
it past the spare element. Then a copy can skip the first new element, and
the peer gets memory that nobody wrote.

Skip the copy when sk_msg_alloc() adds nothing, as tls_sw_sendmsg_locked()
does. This pass of the loop flushes the cork. The flush empties the element
at sg.curr, thus the copy in the next pass starts at the first new element.
Now sendmsg() on a full cork does not fail with ENOSPC. The prog runs on
less data than it wants to cork, as it does when a part fits.

The first Fixes tag is for the -ENOSPC without a flush. The commit in the
second tag added the spare element. Since then sg.curr can move past it.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Fixes: 031097d9e079 ("net: skmsg: fix TLS 1.3 crash with full sk_msg")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index d534974c33f8..d8e29b09818c 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -619,8 +619,15 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 			copy = msg_tx->sg.size - osize;
 		}
 
-		ret = sk_msg_memcopy_from_iter(sk, &msg->msg_iter, msg_tx,
-					       copy);
+		/*
+		 * copy is 0 if the ring of the cork was full already and its
+		 * last element could not be extended. Flush the cork below,
+		 * and let the next pass take the data.
+		 */
+		ret = 0;
+		if (copy)
+			ret = sk_msg_memcopy_from_iter(sk, &msg->msg_iter,
+						       msg_tx, copy);
 		if (ret < 0) {
 			sk_msg_trim(sk, msg_tx, osize);
 			err = ret;
-- 
2.55.0

