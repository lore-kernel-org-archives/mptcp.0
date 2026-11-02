Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604177;
	b=nw3m0nnCg/kTPuRMm7EWiPUUnPx30I2DbtQ/RoE/Z92bYZuy8ZkQxaabc6yuu1CVsV+O
	 xRxrxK3RMf/7uCz6yQKoVY11MTn5W78uGlgQMfCd9P2XoxCQScLmvDE8KO9nWmxuJV0N1
	 dlK2qyI/iraVKCgVW7jtaFgaXOwQ0C5Oc6q7KL2GBGtIy48jr+ZnUdBtJMJL04ivrO8Wt
	 VKO9ksevJpftwxbbpEG9PVZ5Wb4A2LXPz6KxElDNO0v4TAnEnSljwwtULloS0Jm9N3Yda
	 C5eym2Cm8KyYh+Q2JLJq1Qvu0yJjOFpZyrL7ePJD9iFBHfM0N+2MIz63yTg0LyFj5Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604177;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iOc7GMvRx5yq+dlbPNKyqujbMy6NRm7RjZeRF42pKDU=;
	b=IHKVTnP9y6Otvw1jWeG1ylFNlnbtPQdIxo7Z9jHHmsV22DazHrTVowgdcZkYr6UUEae9
	 6PL6WjYw/nBTCWJd3kD3USdWXwtdeb0QIM31CnXJVj2wHJpjHlvYUbqxFxhGLxOEASM8K
	 WFqMAxbIni950LYobG2XjCD6pgLOPdEf742kD7qcNB2pFpWLtMHMP8SgET+I77BV4MUE/
	 4ftUH9nbjI0KEixLzHcYav47L95Haoh6DPYqJS9F0hSFlbuEJShx6+eFAo9HlW9LH2mTb
	 pRycfw29+VaE/NP6bSEqzYP7QirUTbuB1M/wTBBCJbYxOs/pXDFfWRiddz2Zn+CqlGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aYlLKTTK;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF428606A329
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 07:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF428606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aYlLKTTK
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so1436306a91.1
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 23:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604176; x=1794208976; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iOc7GMvRx5yq+dlbPNKyqujbMy6NRm7RjZeRF42pKDU=;
        b=aYlLKTTKnatNbIlsjI9jHc9Xcl8XjY7laBrXOhbQRhGN2YbVeVxQmmmDhtYivJMqwP
         4q5przJXA2pWm3M0Gj3uoiMjZomaIs+SZjd/x4nr6zrcH6SKaRoR8yo/6X1QpSe2JW13
         Ap6eEPtH3BBUY8hnqyXm1/dApeFnfOTDOj1J2laACADtZhzAubhVaAqPtzP9SJM4kYGp
         ZMwCNqOJXStJJKWEWKD4ilOUfk9vwx1QMFNw3g4Cm/Ds/eImR69tf6rEegiQYGmLXseN
         beYliVnL2O/FUYU7K/3C+FPyvXlPZZNqcXFY7oHxM5tQQtADKiS2EARdYYM+wlAtzZcg
         o79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604176; x=1794208976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iOc7GMvRx5yq+dlbPNKyqujbMy6NRm7RjZeRF42pKDU=;
        b=RhUr3e7q2+p3cy1KYU+nAtDrpUe5aCrSQEKSiXkwbHhM7mYBh6mZeYXkBjTFNcj7JO
         LfxczdisUg0zsTO64v8rQfJuFZLfwJqeDxOmr8imCw/CGOvLX7EZTDjvM+Xs+sP3SrTF
         Pe5p1j2GUaplq8ddstGn/hpUcPeeUsYmsiuWXcyFr1NJoOe8le4wwJ0KM4/wjoN6zFGG
         rPdmgQQx+kOQ0hO+qpmF+9scSFI2rGFR1i83PDa8RFx0DeM6BupHUzOqyXA64alPxm26
         4WobG0QnnGBUCKgCYkzls9RAdLI6ge49lu7T3ABjDnT1s9SzBu17TzKVM3+OYTOqnc/m
         O1WQ==
X-Forwarded-Encrypted: i=1; AKwUvBzWiej4tF6XNw0PlbRlhMvgN2+/Y3P6uN5r6E5s9CqL6iBaVnw9SSzoOCqgClvbCUi2bppB1g==@lists.linux.dev
X-Gm-Message-State: APuU4Z9ZX+MCun/vgGAOQCIJk+daBX3PeRVvbXrmAbdGb7Z9vKr6kROQ
	7WoHkondT66rPuuwp0CR9dI8XXDRstV8aUZAvTytEIdHwPWE2lgl1veO
X-Gm-Gg: AYBFou175Seme8bzVIM3+BnoO7rjGvxfzMQyAs4FUvZvt3gP2exdb+UMOIAC93YHk41
	7JcNGOvPdd5PnY3aaYNX0LiqMbohfTOeA1axDf+szwmirpSrW//OlfuVw+UsHC0gXIMbrKgaS+h
	6wCYrHydOoKL3Jzwrrza4OKGFKhgpMo6UlCk/o2Xk5VdSlp3SX9nG4yQQ7qaOmAVNpiA/tpm0He
	FBTAqILlj5qy4hZ8DLsDevYfsI/t9PFVE5dzUqFMBaTfbswc/Qa7MJn519li49R4Aeu4pC84d1E
	g3UV+W/fXVB+bPbHN4DOwK6eN0mYRE/C0wFB1Ivk/2nkrGrMpZ29/I77frgsWjkwScuGVFs6V6S
	bMYYrzBwBhtwDsvfzhsXtwHDv/R+heqU1bEQKOFq9khn8hH6K1fI3eFWv1jdWUZlu1BX2KzeZJv
	85/iMqx8NXnk7vaTFhbsjEYXVLjK3YcWBmZ1lyvGDKtsXy47eDS7cictSzfawVE4Wf1hhEGAlk4
	hzD3lPZWlb+Grl4Syp5dozCMcCdBzrBqo8fZ23M+45Wy6zIq/Xj6WvRcOi/bOrXZ6P6Pwhk4pZO
	J3/Rzy6qm8najX1aseMFnKSiEj8Fl1NMOryDGlDbd5QOBYYFAF+m8R2RRTFfUOlRKklA1+5+dA9
	Ci4sqS3AXS/lGVi/SasIIUwpxi+lVLGGIPrrlcqb4xco0YCHHqR/rbTtZ6p46hGxLWT+XnLV+KA
	==
X-Received: by 2002:a17:90b:5347:b0:3ab:be66:ddd3 with SMTP id 98e67ed59e1d1-3ae897994b7mr5021140a91.32.1793604176024;
        Sun, 01 Nov 2026 23:22:56 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845aa27esm12518065a91.11.2026.11.01.23.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:22:54 -0800 (PST)
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
Subject: [PATCH bpf v2 15/15] bpf, sockmap: Clear the end mark of elements added by push and pop
Date: Mon,  2 Nov 2026 07:21:12 +0000
Message-ID: <20261102072112.4160195-16-alexei.starovoitov@gmail.com>
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
index 50c0cda778db..d68b52150405 100644
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

