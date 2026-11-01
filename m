Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560929;
	b=NH74+PWhMZtwRJ+SnzdU4GYq8PIdbX/UFeEJRUq2MJ7Kvj1GnSTj+klDEvfQxzibAy7N
	 rnebpWuYuylPltUVBuqFfl5Jwat/RpwouKHUJlDZXgrTbGwlUrQ35FhUHxr0qO5UGpSTq
	 Xx2dJvFA4DrG2GapTMlKpgd7iGuQGCMdjlVdgJ903pX39h27iv332X9wdtbU27b3PssII
	 p6TU6YndNEuu6BuJgh54iEgoXI018cTbfKgYyeEtBb1tV6HqZ+jAIykM+3GX2XhVTVoZX
	 Hw13+3ASPKXePT6iTh8qCb8UC+BeYjTx0GsL5TT3qcd22LM1croCQB1aAX7C40zUoGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RP1aCEqwa+3rqWDejhsGdqflKxU5qcv1t4TwDR4XEcI=;
	b=sTmZ4yDXouQB3OERjq8B6fkcdwyvrAokAf4lv+EzBFj4U6b51u3DBiJ30xydftAG85Np
	 BHVuv1BfJKVaQGzUZ9bhpkJTZiJKDQg7Swu5RiC6noRblW9s5IC/kWTbcu9Dwmht+KuQB
	 zX4ds7KcPkbkTaUuc2ikOZhO6bxPGVE1jcfd9+lV1G7HDeFZ20vxsbprqrnWZyfS7Ajku
	 VJnsceFseQSAjdhaDF49C6l+Dvo5WAiAE5Cz1FmNg4aSjy5yKq2aTXW1QxQzriIN2ooFi
	 eWcotRqPk1Zyj9ieDcPVkx9A+iMrdKsEJGpWRB9SUJrLgKQ8FICMVSv8bLfnYF3/PuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ByRncw13;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34C5606A326
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 19:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C34C5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ByRncw13
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e831e86ebfso13076205ad.1
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 11:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560928; x=1794165728; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RP1aCEqwa+3rqWDejhsGdqflKxU5qcv1t4TwDR4XEcI=;
        b=ByRncw13p+dUVyte4aVsJJmzw/LLezS+NNyn+B8BPuluutapIve1xbZs6vu3VHnRdm
         0pdj+voCa+QawWt96RnIIrQ9zLOCl1+E8aNPg6paNI1XPZUFOisjzpug8FYDf8i4VzO3
         rpOog2GAPo70jOaTvDAnuXIUEC+1B4HCl6MEIB65IdrLUBPtpTCoAXqquj2852fSaxcT
         HarYW18v+M6SXY8fHIxj6exdWZIw1X6k9HmdHvFIJgfIqFxuW2qzufYq53O9OJh/qNCw
         YgP3K4HnTFRY/sqbAIEFdobGT6RL1acyPQfRK/TvUeEFSQQ8g1qii/7b7JJiauOktGNc
         KHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560928; x=1794165728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RP1aCEqwa+3rqWDejhsGdqflKxU5qcv1t4TwDR4XEcI=;
        b=gH/ivOSeF+dCNRySBPPyiQG8j0xMHfcijb7g39ZJ0eXrb4kPtXs9n/yGneRgwQdvBa
         tyxct+vRpHK8gY5VhRbbeFAqF6CDtXRPcL4j+vsUiTUfg+5BhD4XGHRvr/ANypF9BIda
         vJY84H+iBcPMPrE1liQPg+tBWt105KLUkui6u7gVGmKp/WQABeN5KgF8tXmNBmzBF/lM
         at5yDXYR3cvzmip2NdOB6b1pRuIrRzfKgNklB9QcG+A5lfnt2/0Ruw1xp2dis5FMFbUi
         JNghOiqHBtIIRw/wZ7ojzplZxfz8Vz2V4JE1DnXmGdEk2isJO7Q7lEtBQZ6mHD+EQRb1
         73aQ==
X-Forwarded-Encrypted: i=1; AKwUvBx6+E8qQD1O/W7pIc/+mckDzYEuzjhJgbuH8AHv90LGMQz7lKRVrKHQm4kEK+d4L2jHFPnxTg==@lists.linux.dev
X-Gm-Message-State: APuU4Z//JdrF86sFdsWGkjhtYpSOHg+WfGIoscorfKlvxEtqEkTAwf+R
	5Lgh6JKaNjz53k7dVaE36ouTilwxrYOzeSejM9KtYOKnyvU3V/F1XvRW
X-Gm-Gg: AYBFou0REJfmRfHDYaNXxf+kn1fM9E7ur8EcFMu4Kdr0pJ3HCRQQzoHNqcSaDXJQmhI
	pYPHPbeIZcF5JxpO4GVcVoCFnXMReqVshAZSNSKNtbKArIIJycbxS7omsAyvwnDoRSdKrK++CeP
	geBiAOeRutLXCHkiEnucNDNEQ0+lGpjO79cIiH6yyt6vyc71USoW+u/FhohPLqXqOzQwgt9/zBT
	Gw/vHdratHWXF8DTpepOnpv76BCrWaggUYsI2PV8aeFL7Rflet0N6801bpXJfmihrO79adqr5Aq
	PmEFLquSLbQOwyuFbCdTiJOWsWz3zec0p43FQ8DZPJmYJUnVFVi1pLTemnEPfMj5AfHRbCsI60+
	Pzda3KZA/DGjrJr0KoS3BMLch9JdTVKD+yF47e3aTm07fBOj6jMteamOucO8CsqZqmEF4/ujahx
	d3GkGaZs8RdZpV4wJOMsa21Wwvz8Cr0DyAKttG/wtEcwQEKinKIAaeDAmpCPgbxDlv1vp60vXRd
	joaO0PPxXObVOYlDXyROFIaZoZIDUu0wMIbqWesHIrNmzpL/35GX6W0zd2d24vWvpqjXbN6K59k
	SB7OjDYcfbJ14eXK1ZXegLFVfnRt1Er88kZunRUDv559LlmT+GhSd2avqNSMb/GUUVoW4AbwZwr
	zRb42V0pnhrFUNakAA2Eti9ZXxJ0VetET1FrqoOeLV1Uoos92IaYa8SPsmqHJbYXyiEv7nZ+fpw
	==
X-Received: by 2002:a17:90b:46:b0:3ac:a11a:7c91 with SMTP id 98e67ed59e1d1-3ae8983f065mr6222829a91.44.1793560927932;
        Sun, 01 Nov 2026 11:22:07 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae8805ebc8sm6392012a91.3.2026.11.01.11.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:22:07 -0800 (PST)
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
Subject: [PATCH bpf 11/15] bpf, sockmap: Don't copy 0 bytes into a full cork
Date: Sun,  1 Nov 2026 19:20:53 +0000
Message-ID: <20261101192057.2296489-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
References: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
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
index d24ebcd7633b..a450b1ff3cfb 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -611,8 +611,15 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
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

