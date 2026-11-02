Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604170;
	b=kmlIQtUsCtr1XctDjOHG5eqkvcAcKAkftgLW3sHggloM2dd/mOOXuBDhvAyJsnkfmGUb
	 4yiQuX6bvv1nfMOHdnaBwTOSYBcPaQAV8APqY2RnwLcOtoBboHFxOKp0p8DviNTOLtkc5
	 frEVMofihoF4JwY2aGY4nKNDGfIlserbWCTsEQDJ68rngl0NNJ6mnglwRNbjcKi6JRQVy
	 lhO4sYfnsGrNp+xx9ru84dtj8Jlg7PXRRuz2CsgAiSG11Ezx1Lsy+eJLxAhmPFhP0L7SV
	 XD5qXtgm8Uppc/jYPQo3TYDln9sGp5vl+wIogFBPZJW8ZOW6JtS3frgbBgt+otLZm+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604170;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NDzvE7/RY4XbRl2y4tH5HHBBw1sRz/QLmpS0WsHMYoQ=;
	b=oG5y4f2Bw9SZn2qdrJ0AuiGrL61TeeslVi69xJ3HZ45PmtHRDTm4zxpZvQEEDez/Wpi/
	 z1y5r3y/EXZHu5DYYZDToYCtJfVeO0wm7kA9G5ulo7ROgW/Vsq4YW2BU4+QJC9iuERV7i
	 uhbfdN3rnpp8E+tNlOyzid3sbba4gQyaSOgc9IKQBxd6Z/ZnvI5tjaRyngfwc2xFupglq
	 gpCOzdg3JyH+dLzgYOu4z4f00rvju9mAZECkNqX4NAbs0SitvV8CXATLI9vh4qogikDzv
	 uMu7dJ8S++oORnBlLNV/xWo3E2EI7C1EXpsO6FwYaxwJj90xL/9DHHAFWjLr6QIEjPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cGYcF6rC;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA695606A33D
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 07:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA695606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cGYcF6rC
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3adf5f6833cso1355716a91.0
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 23:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604169; x=1794208969; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NDzvE7/RY4XbRl2y4tH5HHBBw1sRz/QLmpS0WsHMYoQ=;
        b=cGYcF6rCoqAOr95SFSknGxluRI/zYLdOnhWcDnYCkGD/cSEuSzJ/KIRBp57t1zvz35
         xcc1DuaJMPgHjeFzipVidNRUBg9ouLb8rYMALS5YFVijTyDclshkI1R+8qYv8pW+fPsI
         LVl3i+dRH6LZOPchAr4MDtm6FqAgL7HaB4mc0ePp1UyIIXozyha/dUgrDvPbuk2yDTp5
         EuQj/KZACIi1XP0XphENXcNiaetIOsv7arMHxVUPcn4fRabAHvYwc7uqAu4nvih82ur8
         m7bqDR3X+g7MTcLn42El/00xPdOQE9HKavSI1Oe0WylkpxypiLmSijN3cpQxQ9WlPFfl
         /yiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604169; x=1794208969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NDzvE7/RY4XbRl2y4tH5HHBBw1sRz/QLmpS0WsHMYoQ=;
        b=RGR7k0SuTp+VS7r4q/lq8ZfX6/PWqfyxA2o1m+lwtvX8SaVBSpcEtljhd7grHLXD/B
         EYex30bQAStuTMgnfAvXqpJSw3JMfdDq7iPqYNZLnE1lbJ/aphNA3D4XBbmhZGHu1co8
         i7QFKlhdmBDUP7pX2uVSTAKgfpQ3FFPJeOSZT9a6148GFyVFO9/j0l2WOG2L7vQgkoKE
         Zp+hF1yJCnZ4uMlUpA7VaTPDHRr5U21YdW+xZBeVqcNpkbtTpw2doc50fulsvWB+HGeX
         c9sv1IbmenkuLaTq2HeTSh+0WPnH7hDcEIqzRlaCks6ddn6WklBU7AaLEdoGLH/KmfSh
         uWEQ==
X-Forwarded-Encrypted: i=1; AKwUvBz6oHm0cnTFuzYpbPFvTfz2K1Q4fB0LU+FL+Mm6vCJnK+/AyTNMAadH8lL0jxBbveIDK5y4BA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+yzf9Pwknx+duegaMh9U4TDh6qIb/YWjRFx78Tl27ztRav3Ht/
	H1pcXWT60QB//MYmsC9sYn0a7DvdxU/WUvoQRzY6hGzELojnLouEOCaI
X-Gm-Gg: AYBFou3JJPbI+r1FPDyUDDfSCd5xvihoS9YGIHNhQxoUgYhOylf/OGiUfjxt0Ace+RF
	lO9BzoH6l9LvurbydFNZbfRUQZJyDEfqMt48CzNVaM05KG8dm9l8BuyeNxWLzOZPKYvj1TzS7oU
	yKSs99+U35OpajiTSvajSGFK1jow8YhXiH0YOfQE4rNonaEpHIk+TdpvkOmmOel8HCZkeagcDud
	KMQoEAWpJ0qHdHxkxbjijo1IWX/5QQh0Vk3iPNXty2pf5ftklRbfgW6BHZA36Dnf2ZPvkVijVUm
	TGvt8dZ2QrdlZ3B3XTq+g+3uIFT3M/7HGEavuI6HwZAywBRTsUJY1tB+72Sql+offjzRFUZ5NrO
	+V6w5TFkn9OmHbn45+iCv60vaEW/gpABI/4AS4hO7c46NOElPWlJrTMqhhcbXCn7xN5mYCew3Mq
	EbQ1pjc/LBcuds/U5tR6w5rBxYHs8rztvI87hUfqSwiAxmNVpRcUcYAu8vto/ow+6RUmZZLhs/O
	RiReuMqS0PoKdiY0fwkcna4+2oWqCdy149x2SfV614XdFn+OyvLvNYFc7QNV1vdHEDBlriGYTQx
	PFldhp9EwPJKDisawLoKj4wTJJ83eQM1tyVWnzc87NevvrlAHBbxorFAVjJs5pFSTwJEBaOVhFN
	72+e3VuQB1BQE5vFHpxIYfhkIoW4pL+5tGuLbbZczNhtf+lyN+sqCI29pUiqTJ9/aFFk+bcyxY0
	c=
X-Received: by 2002:a17:90a:e187:b0:3ac:77c8:ac29 with SMTP id 98e67ed59e1d1-3ae896f862emr6963704a91.15.1793604168982;
        Sun, 01 Nov 2026 23:22:48 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3aec233ba08sm3293330a91.0.2026.11.01.23.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:22:48 -0800 (PST)
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
Subject: [PATCH bpf v2 14/15] bpf, sockmap: Keep the rest of the cork after a redirect
Date: Mon,  2 Nov 2026 07:21:11 +0000
Message-ID: <20261102072112.4160195-15-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

After bpf_msg_apply_bytes() a verdict can apply to a part of the message.
Then tcp_bpf_send_verdict() sends this part and goes to more_data, and the
sk_msg prog runs on the rest. The SK_REDIRECT branch does not go there if
the message is the cork. It removes the cork from the psock before it
releases the socket lock. After the redirect it frees the cork together
with the rest. Thus the rest is lost, and sendmsg() reports it as sent.

If bytes remain after the redirect, put the cork back into the psock. Then
the prog runs on the rest, as after SK_PASS. If the new verdict is SK_DROP
or the push fails, sendmsg() now returns a smaller value or the error.

msg->cork_bytes keeps its value, thus the rest can stay in the cork. If the
psock has a new cork after lock_sock(), the kernel still frees the rest. If
the redirect of a cork fails, sendmsg() still returns success and frees it.

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index b1071b0960cf..788ce08eef4d 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -544,6 +544,14 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 			if (!cork)
 				*copied -= free;
 		}
+		/*
+		 * The verdict was for tosend bytes. The rest goes back, unless
+		 * another thread made a new cork while the lock was released.
+		 */
+		if (cork && msg->sg.size && !psock->cork) {
+			psock->cork = msg;
+			cork = false;
+		}
 		if (cork) {
 			sk_msg_free(sk, msg);
 			kfree(msg);
-- 
2.55.0

