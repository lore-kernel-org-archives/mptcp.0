Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560953;
	b=i228HXl5uQeFWZc94e18DvSs/QqhSWxStdSgzi983mmFTTl8XQTwZBcU1uRUNw8/+NU0
	 hpxEzZokJYPWAoPpJsn+8XoY1eoDMj1e79dXffHp5i+A/22Br9d3kGjNS2P0lhL0Q/Y9I
	 JdZpFXwp1dZmw3WcK4cSVQUO+dbg2PJP+qZ8U6VJ5jizgZZYcRR05v5JbBbFqL9b5DYG8
	 zr3KGfsd61oYrCR60rLZivzr8l8cKQCsGSYnf4IAVLCTWqNlrO7XziydD5KKiOZBlKGNG
	 ZrwPaN9QAXMvoHHPnszrYAVrPeLjXytzsK1MJOgpPhHgYRH9C2LnxEXm6dm/52xGDXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GRlJOwLDEqVYeEwYcHpzUEpdYNzizl6/DkuHhzPzoUQ=;
	b=nbVeAmqJSoz1gE3zJiVJ1ghAKVhbXz2VD2mhSp07oxfsQ0YD7zeAfe50M6Aes0PS1HpE
	 3c4Tmf2kHf2j8VrGqnUMKHErKX+6VzyPgOVfBLwF6Jwk3lsPq09ZZvoC+95LQu8LUhCLE
	 VEXCv2cYcmZ57MPG+XIdmCiRIYuEErOTmTa/h9a5Mbon7jmH3im7+E4xgj53SB4B0p33z
	 TSUsqXnIda1J5xBnhpTSO5kNOue/O+i4DQNppTd/4t6o3UZKN4HrNnrvWhtJv3JlbvNJa
	 LtVLk3PN11ujlnLxxP6NdwnWk73S8gbVbB8f14jaVNnFnmGWYuPxnR5eBscCZToovag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oqTr3VbU;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D414660A2602
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 19:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D414660A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oqTr3VbU
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ae702d28c4so1007993a91.3
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 11:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560952; x=1794165752; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GRlJOwLDEqVYeEwYcHpzUEpdYNzizl6/DkuHhzPzoUQ=;
        b=oqTr3VbUoMavTUJne5pjQPVruso/tucymwT9pjyBH8lapWuTsxz0tuWMGw7BJ7EDjp
         EWRqQ7G9gbLuAx7ZTh2Z7OyDZATivOUnz91WqD7kI0v5b1PNtjHnQ9DT6kGJxyIY5r9V
         H2clYUlsyHw2qvufvtGFODQkUJimvFX6WZWRLOry0osAEEdveecnY0T5OY6+1qjlH876
         wxVyJNfM0ZO785HuN0RnUg/NTUkI7U5KwLNCIXVpxkiGyQNjgSV/ySpk6nQPRRTfhanV
         GLOmCFZeC5J9A3R7OsOjyPNXxxxUqdcfxUpQeeytaP8GVxo55uIOdYLCLO7aqYjKL4Di
         X+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560952; x=1794165752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GRlJOwLDEqVYeEwYcHpzUEpdYNzizl6/DkuHhzPzoUQ=;
        b=lCgqNglDGSLWTHSaWCcG+Xqh/r3ek0znKQmpP1PCgkbdnJkmc/epWa+i8MYSTbR23M
         kX7Zn7HFhs+SvS4FHeqmb4FkBP/zCpVn2Pp+Je4lW37vHrZdIFIWqexBU0lYR76Ev37s
         EPNzDqAjAM1VVLYB7hXhSIZOd53WuBYIGfZTDQdwYxY/HlNRYXFLfp5+Su1HFtoI7S/h
         gCXipFHKkDw1al87JCuGYUbghUTHigXYbYpPYThRubSZPfee5mYSccJ9r/aOX570yY3P
         3xBXqNCvbfdfaTQG+iSH5cLtvgq+2naZhr1zFOWg5eDONrqadck/ekW7+KEaEu7+uXmb
         9znA==
X-Forwarded-Encrypted: i=1; AKwUvByzxeZPypFJ8/x73q0GCi7rHfmqSV6vGjjPrfo66hDmqxjIJjT0qbyzk6PF8n96uaL90WJn/A==@lists.linux.dev
X-Gm-Message-State: APuU4Z8k6lL7iuCrVeQzaHq4Sl/w5Dtoff04UWidNY5hIOWRBov8TiD0
	ZHV7LM0EOEJMJb6AgfMB87S0+NfY/8ujWSoX4ohVHfuY1hxbBU2iLyYl
X-Gm-Gg: AYBFou0XGMZVZ47ue74XmxlIYE/g3L4705eKzlFXwI58YPAXqQtgx5PL6JXaanwJ8MW
	Sv18qOTuOXJaW40kRSGFg9SUE4hQhwsqd7BnI5rsDSX+8UldD36pX5zVnZywz/F5Z/PmVmzSR8i
	VQOoirZ0a3yRKrAFVhzR7WvOy/KVz8jXXHkIqTvOmTYLVxxuZQePm4zUPUptQHlmjK4X3J2S2+9
	9EXmUKqFH7YrGMExQdKybJUvFDA1QAgEJQOwy62YTUlVIWJ8U/i9LNtwvF5tcDfe+2qczh1q/7s
	iZ9nPgIE0uxExH+YeTXVSfTYbh70g/O7ernylBfMY1BNZGDe2GoZofcsCJbEAb4qCShrfIMKbap
	v4WnNXOJuvFL6iFxEcNUSb6g6W0bXzej49FLwGC52K+m4Vl4VA5qMqhl65SKrpDbSJlfJ5ht3tF
	OMPnobA/aseMv56ECj7bvyDoKzJ6yYN1xce13/LxpovIBtSH4o0A4UIOTDb11Rehmc+7mRce5Ti
	o/5uAE+oPsBSBwcyEvlRC3wlBP0xzVGv7qzqDLQB1OeWR8cpnNPo/UJGndY+b94OlK7Reva8P6k
	zB8PMwgJXSX/eJOF+nlQov4IorgjoBBPEflHD8Cs9UfS1dFpj3v9r/jmojLWM+zpuW2w4RtBFQQ
	EkSbhaKXltTB3MTNPn9uQ/1LGlGfNI/CB120zCsoe6EZnguQF/ArYmYaB862oyPBjDldixLGR7g
	==
X-Received: by 2002:a17:90b:58e3:b0:3a8:545a:9e87 with SMTP id 98e67ed59e1d1-3ae897cc9f0mr6175910a91.15.1793560952122;
        Sun, 01 Nov 2026 11:22:32 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9426ffsm15652012a91.7.2026.11.01.11.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:22:31 -0800 (PST)
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
Subject: [PATCH bpf 15/15] bpf, sockmap: Clear the end mark of elements added by push and pop
Date: Sun,  1 Nov 2026 19:20:57 +0000
Message-ID: <20261101192057.2296489-16-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

The elements of an sk_msg are in a ring of scatterlist slots. A free slot
can have the end mark, because sk_msg_init() marks the last slot of the
ring. Also, sg_init_table() in tcp_bpf_push() marks each emptied slot. Thus
sk_msg_alloc() and sk_msg_page_add() clear the mark of a new element.

bpf_msg_push_data() and bpf_msg_pop_data() fill a free slot with
sg_set_page(), which keeps the mark. Then the sk_msg can have an end mark
before its last element. bpf_tcp_ingress() copies the mark. Since the
commit below, __sk_msg_recvmsg() stops at the mark and frees the sk_msg.
The data after the mark is lost, and its pages and memory charge leak.

Clear the mark after the two sg_set_page() calls that can fill a free slot.
A free slot keeps its mark, as today. tcp_bpf_push() does not read the
mark, thus SK_PASS and egress redirect do not change.

Fixes: 9974d37ea75f ("skmsg: Fix invalid last sg check in sk_msg_recvmsg()")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index e187e3c27999..d7b364e43b4f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2995,6 +2995,8 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 	msg->sg.size += len;
 	sk_msg_clear_elem_copy(msg, new);
 	sg_set_page(&msg->sg.data[new], page, len + copy, 0);
+	/* A free slot can have the end mark */
+	sg_unmark_end(&msg->sg.data[new]);
 	if (rsge.length) {
 		get_page(sg_page(&rsge));
 		sk_msg_iter_var_next(new);
@@ -3128,6 +3130,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 				sg_set_page(nsge,
 					    sg_page(sge),
 					    b, sge->offset + pop + a);
+				sg_unmark_end(nsge);
 				sk_msg_set_elem_copy(msg, i, sge_copy);
 			} else {
 				struct page *page, *orig;
-- 
2.55.0

