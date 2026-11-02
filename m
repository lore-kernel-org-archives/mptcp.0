Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604130;
	b=MrKMnzhEdHL1AzWnoU6mnTxEXGFjtKM1q/AET6rDOgBHPOM2blXk+uLB84XOxPiEFbXY
	 53k5VZv6ZDNkmC2XO4ajvmQq/lucp0Jr/44QddVvsZ8L/BQtaP+AD7IUgQ2vdSX8aKBck
	 auqG671pFGc0Eh8kqiR+FyUdyy1rxoYk+3PGm/PqCjfhiOxPzKnb/KIw7bL/2w8buQG7s
	 ocn2PqqSo6ZmO5FAeWeYLS08zDEdRzDwjTIcuX/GCl3okkcG9jPy3PpFIvai3rNVrRlhT
	 aNhPn39FQqz9siE85ToEc52DkzqIoKKrJwvhsIOgxIjGWHVPbEpOxNk1flKNBNodAsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604130;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=q/uS3MNfywD3Vv+T8KYvUL+u5aHeTIkmuMrEypBwwRc=;
	b=1SNd7vJXRPpsaRimJOK/EmGBcRImENpKsCZJjvpwJJdafrJ9+92rJzz5YdDcacBDbz63
	 DuPzeJwRJha7wGKCRBCNpXrnqec9fUNUvTVc08ulmR8TYMB4Q05TP9HoEC+/Xh13siCIN
	 fk9avmeUfjmMu1ZpS3DH6wOYhmvPLnB3HM8kjU2GR+d2LW/HLdWq5oRwIWxhHotEd5TIc
	 CwmZPdZ0aQGQ2ooZz4RAlrozJUg9XHcfPvGi4YVw3x63CS8xlLbtLTuSBgGsa15K6srUJ
	 1Es8I9MkagU7v0EOJz+fKffiVG5EXaLain7eagkSHOSalDMo/Lvk2855fSPavZIkpUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pMlpKmmS;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFDA606A326
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 07:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCFDA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pMlpKmmS
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cdaefe02d5dso1423722a12.1
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 23:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604129; x=1794208929; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q/uS3MNfywD3Vv+T8KYvUL+u5aHeTIkmuMrEypBwwRc=;
        b=pMlpKmmSF5P3kUgsB1jgUZIvVfmiWcEVE8McKweTc/d0xxbOPl0eHZnTS23Zgkw7bX
         OCt+AhcZNRGSrQpug7sJBgtnZhREDgo4uDPZWfY2KWIGLD3bhnt1POOV6fGpxkdlHPbN
         fAHMbjU46erzJZ9SeopMmTfM5sADdlc9ur8T9ZtURuuDugcsulpB3xJ24gwnGgT2S0iq
         ZTQrnjJ1Y1s1GzezbCFqfk7T1+pgGwtTBfEXILyg7tF3oQicNht4QfgT930KsJvlkUVV
         +5FJzwtr5Uc6bglrEJnlXI1BOQjHYH5pkx+Z5LBpvk+Yx/HRA4mcF+dNcGnrgYZwt2TF
         jmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604129; x=1794208929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q/uS3MNfywD3Vv+T8KYvUL+u5aHeTIkmuMrEypBwwRc=;
        b=giKIhfR75PnM47bi2NZfVrr0VeMjIxwozJJFffsNalpQuEC03hXPLCrwNutp0GrgIh
         YeuQIV0VdlqqipfOvTFLEwfwT3IfT7G8ZEKfuZQneVk+fSB1jpYxMgCVHbvn3twf9oAT
         Ejtj7InebaWOBQrDp67p+lMvvgdlynsloPmzTQY6sqvlRoHWykQnnuuY8B0mMTQu+xrK
         NFx+aw+w9FHpyS8YRpyfsVrunJWtvTPWTKYb2jf3wSsd7Xc7ZnFOX974EGdrjCVlLutG
         BJqhVS0vNfVgCOCRuaMhChtqc+E3Zckz/EKYeRLNIiJug0mfiddwTZutQtGWKM9TPrXS
         nFYA==
X-Forwarded-Encrypted: i=1; AKwUvByR2TCGPBONzECmkxz4pNJpgLX+xLLY4F03S9ZNxQ5yqrKInt7nbnl0DMEZA9k3e8F5mOCJSg==@lists.linux.dev
X-Gm-Message-State: APuU4Z93mrb2C9GNo0bnNyHnKthZIabt9UUS72TVCPtoKor8zvx4Pdsr
	nxm5BQ17Itg3sK5uiQM4FpWrfkxFOP1ddc3IdeF3vd8k77pB3ICzNaD+
X-Gm-Gg: AYBFou29Pn2eAvE1vvXT0WxvsK2R9d53TZKkYBTOChVvTbA23ushoyQxp1OtvO7L+bf
	E/TamHxuvqLsm7uS1dFbzqZfsk0tMJPDKM3kqkTmMlmKFpUqog2G1PweG4ywBxFSygRqK7JKiMm
	33+ZYH/bX9VP+KiUcvDB7M+pdNLLvnPV8HIsZaBlDWXNwnNUUq4dtl659P57NMP4Www8flw93Z8
	5ZrWDI3Ds8DlG0CA/MhDG/uOA4+gJRMIey4CrK5B2lkWLLqaHi8osgeQmRjpVfIkqWzGU/k7F32
	EjhMPiCZrjrqdIDC1orYTT6bKjHYPpLg+8C0sXLMAiV4TnsprdP4P5hMMSaUbJyiI23buP4ZhIQ
	Btivg900t+nh3/AZ+2sUmQtrU6VUXYjZMDt6T9Ih5ZfFBofUJaNHM1X5ZJ+JCZGBut6bWT98b+W
	A8YHl0pkNlZk5ZT3OD/bEKKCyW9GezNJkBCqNRJWxM/hldnVIAVzPzDaH+gtqEMCWUTRDorrl8m
	plVA9/7FmeI0ullk1JL7rd4srh9cjEFE3+YPePPIbTXYmZpJBzn3hXWcIhMqCz1er4E1njedQ7T
	39kGcTjHcrJXN0Pcxn/JNqmsjtZYTEOjC6B1EcHzV7IFCosJFMxsAi3caom8/H7axEoosbXZaM1
	HdoU8PkCmC5sRw28bNOq0ki7S2m2CZMn3sj8QEL74qXwir0RaiW4RdyKhHNoiCaDjTP/4T/Zhs1
	k=
X-Received: by 2002:a17:90b:53c7:b0:3a4:77b8:1770 with SMTP id 98e67ed59e1d1-3ae897c7747mr7453233a91.15.1793604129139;
        Sun, 01 Nov 2026 23:22:09 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845ae5b9sm13043295a91.12.2026.11.01.23.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:22:08 -0800 (PST)
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
Subject: [PATCH bpf v2 08/15] net: Leave sk_stream_wait_memory() once the socket is dead
Date: Mon,  2 Nov 2026 07:21:05 +0000
Message-ID: <20261102072112.4160195-9-alexei.starovoitov@gmail.com>
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

When an sk_msg prog redirects data to the egress of another socket, the
sender calls tcp_sendmsg_locked() on that socket. The sender holds a
reference to the sock, but not to its file. Thus __tcp_close() can call
sock_orphan() while the sender sleeps in sk_stream_wait_memory().
sock_orphan() sets SOCK_DEAD and sets sk_wq to NULL.

After the sleep the loop continues and does not test SOCK_DEAD. The
subsequent sk_set_bit() can dereference the NULL sk_wq. The tests of sk_err
and sk_shutdown do not always stop the sender. sock_error() clears sk_err,
and __tcp_close() can call tcp_disconnect(), which clears sk_shutdown. The
sender then adds data to the write queue of the dead socket, and
inet_sock_destruct() warns.

Leave the loop with -EPIPE when the socket is dead after the sleep. The
function already tests SOCK_DEAD before remove_wait_queue() for the same
reason. A caller that has the socket open never sees SOCK_DEAD.

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/stream.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/core/stream.c b/net/core/stream.c
index cb255e2a3a5d..334124d683a7 100644
--- a/net/core/stream.c
+++ b/net/core/stream.c
@@ -150,7 +150,11 @@ int sk_stream_wait_memory(struct sock *sk, long *timeo_p)
 				    (sk_stream_memory_free(sk) && !vm_wait),
 				    &wait);
 		sk->sk_write_pending--;
-		if (ret < 0)
+		/*
+		 * A sender which sockmap has redirected to sk does not keep it
+		 * open. A dead socket has no sk_wq.
+		 */
+		if (ret < 0 || sock_flag(sk, SOCK_DEAD))
 			goto do_error;
 
 		if (vm_wait) {
-- 
2.55.0

