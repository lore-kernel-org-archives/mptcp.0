Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560939;
	b=HdQY0MTB8fCLZwfTn9azFbyeEsR9NDQFYIQO7vQ6oYa5zxVJADI4x50OTP+MoOhkLqRL
	 hYCDbjsMJV1OHHVSSYUEuUTQGtqoNb2RsIiAfmSC2Eb4mcfwRUb79K7l29jjBn0KTyh81
	 xu5lvuhWQCBrkBr1GwN46EUkDCRRV+Wiqz9dZvEzoVIyV2/ERyGxNPTA3TAcyyAO4IGpS
	 6qYSbLC0F6z+ZTnloD8xvJKIfESwMPYcjBusd8a8/Q37tKhpzu64PC0+2EUnwEtKAhzAb
	 hmZeyx0QTzH5eF3okOaBI2k9E5nq1ArRrNTx72hjMGRqnLiionHDn+f5Mg+tvnegOqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560939;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zkvPy8BTXAWTFCLyRVJ2sIoHit4yKU7xsRMx7Je7ku4=;
	b=QrGdtiOgcYktLn20KSIRIKxNhw+MGj3V3quSw6ypT27bEREcRxPPXHHkiRts/AM5TiSq
	 RWZWbUrqxPIGwWS6Z8KG2h6xE8jJ+yx0ZwGdGAKGeQ01ttnBY3XNtXpnVNGdSJTGCSt2z
	 pizoXE11KF3HCM+O4a0OejpIv7qygZDCcLb7tFOO4pcU4TcyQu8p1xqClstCLPeEHIpHV
	 SnRRkYSM89N9nLYUDKb2ly6ktkMOT99te0J2x3YF4M1E05/N2AmuLETZATITqPc6obIKi
	 vobn3ItdKlUMcHnfNmsluncfzjGR0o9Yu0l3BhloMoA1DKxls1e19FE5FhtWEnFtUYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yWpVjhk0;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6869606A332
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 19:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6869606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yWpVjhk0
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ab60ff4273so1891062a91.0
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 11:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560934; x=1794165734; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zkvPy8BTXAWTFCLyRVJ2sIoHit4yKU7xsRMx7Je7ku4=;
        b=yWpVjhk0EwmMem2o8wXs6FZVTRG28wqfrBqJkWK0YZbIyVuThCI8lBRnxQ7UyCtuc5
         aYrXlO8N7SQQFDts+puF2PQ5jugezfp9Stn7z9MIyKX31KeBoWHFHot7neVW2plY7xwB
         rDlP0BpCwcFc1B5n7Jb89sCGCTNF9aVgCL6Zn3XUfh/4S+nJ/lIif6ToEm9pxFKiTvhN
         PWNxRTUiy6Ak5NXDqFIvLPzM7HEByAV/9cs4nZCb8jZH9iRfPjIRSQT69d4SOM7GS2Z2
         utwtOt/UUPfjBBTgwcDsV1HeZMCjOltDsbBwm3BDY7bol2Sm3QIN2b99dyz/JSBPx2xt
         hL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560934; x=1794165734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zkvPy8BTXAWTFCLyRVJ2sIoHit4yKU7xsRMx7Je7ku4=;
        b=eakVuoTnohJyIr93OlTxFhr727pk67uir9itTp42Zyos+ptmURBFJsybjyn5RaiOjJ
         dtsidyn+1uo2+FoPjtiKc5bmSzcXkTMe86VFSfVugLl42gJOAL8tgDl+NQscXIauAGs+
         nK+/pe/CJYBycqHpRSsMshutvKQUzw5soilDig1lShG6zVK2KLmzeOtAl5eRwivLRPsu
         XVmcbKLQRm2Z9Rcy9EWxekTZKHqnYpnt9gPmiQaK5e9OcQjz1Ra41ni4nxtmXvh1Y4om
         a1OGQrCFunijFWi0KzT1D2UGs3RFT/g7ajhTxp4lhHnM7Bx05r8rtD9Q1BDEfQ5C4a41
         Q1QQ==
X-Forwarded-Encrypted: i=1; AKwUvByB5gKFtqlFq3P1E2tUyrDr8MNplCTwZjGHufbb+dkmjEapVRv3Rlai/ErJl44HqbF2Dxd2YA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+sdJLzRhpyoWd5YxOvR/mS+AmDB6SDLV/caD9Nqiz7b+qbbzeZ
	XkuvVFZDiXc0kVenoQZbKm0PKqrOwqVIwrxBUEhjdBLg1K+fQV/ObeDL
X-Gm-Gg: AYBFou0rKG5sQU+8xFaWrn/O2Lw0N2w4GiUg7o3NFGacxOJ+Je1S2Y3jYnKCdADk0K3
	hyfXuNfC593+VK0O08ko06z5a+G1C67I6OwSyB4BUZAwlwNhcYxwCKnliMHnSH5Io64bTJ0ykJv
	hM/3cRhVlj8z35WXmNefSYfalxlCPwtydUMN1ruBliWa8dbB3gmisLtsYSZMqTNWg23cv471JMN
	OkF79ckCI9VTXvUc676/X/n4iQSibsSWeLyKBZNXWDWRFVqisAn7hJmdJcD7SbSj/FWYoIIJ/wO
	B7deqAap892HVNDnCxKkVQXgcE8cLVeVIQH+yBj2VNyck3sCdoKeOoaSWD2ESY7FcplZzRyFmdh
	FQJDzB4QUoSC7dPebmel+1QKo+4yAsbJmqqTF74x/WGLM0vxi1DLbcsw2Yaf2BfQ9HfPK4+Dpcl
	azXxoRUgP7JJx6WrzhTcURyxtaumXCKHDuMb6szge4YkVv51bvUtwUUsEuiE37ouCM9278KiosJ
	nhlmEw5dHn1+QrEIyjDg5nIdWMeHj7BXyJlyjQDGjr8iUxipdnNArQh0WNINkMW6z29jX51AtnA
	C6Eda/HwcnXIEEBf8c0hzicxiE2gob4Tj6+FqWTbD6E6PhnH/pH3BkgddJyPisrlKA1lCe+1E1b
	sJYmaNB1MHxCU2tbaget4mweJ3NEMUd8SIZffIewLnYHQLCGb9QeZCyT0rOCvGwwZSAwMks8JKL
	g=
X-Received: by 2002:a17:90b:1c92:b0:3ac:a521:959 with SMTP id 98e67ed59e1d1-3ae898166c8mr6711734a91.29.1793560933989;
        Sun, 01 Nov 2026 11:22:13 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae85f37e7esm6486678a91.1.2026.11.01.11.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:22:13 -0800 (PST)
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
Subject: [PATCH bpf 12/15] bpf, sockmap: Clear the redirect target before the sk_msg prog runs
Date: Sun,  1 Nov 2026 19:20:54 +0000
Message-ID: <20261101192057.2296489-13-alexei.starovoitov@gmail.com>
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

bpf_msg_redirect_{map,hash}() store the target in msg->sk_redir, without a
reference. After the prog has run, sk_psock_msg_verdict() makes SK_PASS a
redirect if this field is set. But tcp_bpf_send_verdict() runs the prog
again on a cork, and on the rest of a partly sent message. Nothing clears
the field between runs. Thus SK_PASS without a new target is a redirect to
the old target. If that sock is already free, this is a use after free.

Clear msg->sk_redir before each run, as the skb verdict paths do with
skb_bpf_redirect_clear(). Only SK_PASS without a target changes. It now
sends the data on psock->sk. Then sendmsg() can return another value. A
redirect that applies to more bytes uses psock->sk_redir, with its own
reference. The counts msg->apply_bytes and msg->cork_bytes stay as today.

Fixes: e5cd3abcb31a ("bpf: sockmap, refactor sockmap routines to work with hashmap")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/skmsg.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index a5d498982848..8a3b8536c0c2 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -936,6 +936,13 @@ int sk_psock_msg_verdict(struct sock *sk, struct sk_psock *psock,
 
 	sk_msg_compute_data_pointers(msg);
 	msg->sk = sk;
+	/*
+	 * The prog may have run on this sk_msg before: it is a cork, or the
+	 * rest of a message of which only a part was sent. The target of that
+	 * run is not the target of this run, and the sk_msg holds no reference
+	 * to it.
+	 */
+	msg->sk_redir = NULL;
 	ret = bpf_prog_run_pin_on_cpu(prog, msg);
 	msg->sk = NULL;
 	ret = sk_psock_map_verd(ret, msg->sk_redir);
-- 
2.55.0

