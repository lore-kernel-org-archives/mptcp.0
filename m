Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBED4508E4
	for <mptcp@lists.linux.dev>; Wed, 17 Jun 2026 21:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781733454; cv=none; b=fjbXNgKCJVuOJS8RKA+vs16l8eJ1PJf0G4aPg7MhDUbfLuR6Rms91kRYBgkBGZJ90izAzeZPPsDtQYfh0QnthQV5kbFTKeq0gU6ivhjIfWLAPk1fOQGuFpU7cLgxdfJ/in4JRAXm4tq4sJKh8RxF4xuisel2oV/czgVhfOy6vqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781733454; c=relaxed/simple;
	bh=YFX993hq1Dn+Ak0oODn5emNit7+SDeFwOkckrV1bITo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G0+aaiIuLIo17uNlPok/IVTmgJvKBlkfDofHSXS5Ly3fmyyGHbt61IeGxH+C1s3l9ogt4DiC1idLmcrKhGc5iB3whWCA6xzWfHLFrPY/vhlt4XQt0sDxPMqOpPLM7CG3ydtHfAf1xqeRTVioA3X3iE+h+pIWJ6xUWdmYmh55Y2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJnGdUdv; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJnGdUdv"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-91578122305so42892985a.0
        for <mptcp@lists.linux.dev>; Wed, 17 Jun 2026 14:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781733450; x=1782338250; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OX6t51pm0YrW+eM37YUtdbX6+TWrUjJQf11wIZ0s0II=;
        b=aJnGdUdv2Xn9L2xP3Iar4gHxw9ujayKT1MNK2yW0UbZ7DpKdpdROctQri47igY2wNo
         rxZnHCVa5u52dcyc3/RqqjjT6G+GRhVqghhFMxDCDSLU/RMcj9HOLYq3TyU1KtpL2Ysg
         KoSZVivaouf4yEKByPjO2+yKSoyjPSe6jezakw1VvO7fP5wuUpMQD0tz4Q7FzoqCjgdW
         tEI17koAh+du408Eq9h4QHXKUSMtbwAPYkNXKcF0zMbAQNb/bk/z4K9XZAcH52uRn/Do
         eKQKOy9i4dy/vK3ZBEXXmxl3/uPq/oJnJN/LfwrlG0/hqYOUPUWEbQOH3UuYuPJ6G3js
         Cirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781733450; x=1782338250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OX6t51pm0YrW+eM37YUtdbX6+TWrUjJQf11wIZ0s0II=;
        b=n6Wo7pRn9LYXVVmjZYlHA/jUOtmd4Ljefk3e2sc4V4UJZ6nxXYvaXsl0A9VAw20/1D
         0YeAOlBePR7Q3bDb3meXCju6IRe4sddDwuuHc0NECudNs1sBPZMV0X3h0ooO4JecqEH2
         Uq7qaVuZvASuody/7KGZKIQtBb/+ZkS7SQz/ZKenFBOI/3xo65QcW9rYopzS9HtcIl9P
         E54KpH9styA55UY2K3yHCIq9Gm3XP6BO8fuhbxnpZxkvk6WzFSn1OiUbdpXEwZ4XeHb6
         tw4Pdp6DNKKLBZ25DhY4B/GGNFJu22i2Di4yo2Aou2OJW4UDJI02FNO/nk64H6Y3vKi2
         8/Ng==
X-Forwarded-Encrypted: i=1; AFNElJ9OczIln1tzcToeMg5fwPjFX5MsT1wNlom1HlbFYwkE7mVqHG+2ht8zGgfU04yrcmxqhW5NYw==@lists.linux.dev
X-Gm-Message-State: AOJu0YybZeF4im/YxVhSUWNdNdp6xxcUp2il1FNANULbrdo2mrZ+D72p
	TV9RRmXAeEfEsu9e886o/zNu0WNMqyC68oCOq++q/LFI1kMtfr2LpInF
X-Gm-Gg: Acq92OGuaqRpuznz7S+kEnNYzGX0U3jnLpbp0aRihxnVwVVLLtk/Dkub0CGtY1LHv9D
	RfQtpp9QlC3sB4rGaI/ljGgDRHE2KKU6WFvVeC2TSMaq72hyktCzlPmaCU6IGFHXMDbQ0x2ILwz
	xcArin+4ozqwmaaAF2VzY+1rlsaq0YaPWvq1ltuzYsHqlTlQNE9IBBYDgKup9V9s93nJ6mUo+Cf
	VHGnxDgfLfnJ+O7Soo5hJX67p2Cum95j6kOjPQ4OLz9U09pcmqtkGAvcgU6xVMr0E/tchBuXO2b
	PaJTLErLLv+Gp+iZN0TJRam0EavW8wArXqp+nw079K1fPVtLGCregogtqqlc0GuzQXhmzRNK/8A
	Bi0R4w6XlYW7KXmk+U6RMHbSFA/3FiOX02GgCDIUn7PjQe8I0//ednDXlqZe9eE9cSTMxrPIOGH
	wrAQszbO2tt7OTkVLVPhTRLwxPTE/I7Jyk2eUf1RTqvdkQ+08SPnvb1WTGLqA1FYTg65HWSg7v5
	FBQg1z3zMmmwDOIhbE9JylT/wVdkWGkD5BIVx4uuJ4=
X-Received: by 2002:a05:620a:4625:b0:915:aa7d:42bc with SMTP id af79cd13be357-91f2a9c1356mr146659285a.10.1781733449733;
        Wed, 17 Jun 2026 14:57:29 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a006441sm1974497285a.27.2026.06.17.14.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 14:57:29 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mptcp: only honor zero-length DATA_FIN when a mapping is present
Date: Wed, 17 Jun 2026 17:57:25 -0400
Message-ID: <20260617215725.1116295-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

mptcp_get_options() initializes only the status group of struct
mptcp_options_received; data_seq, subflow_seq and data_len are set by
mptcp_parse_option() only inside the DSS mapping block, which runs when
the DSS M (mapping present) bit is set.

A peer can send a DSS option with DATA_FIN set but the mapping bit clear.
The parser then sets mp_opt.data_fin while leaving data_len and data_seq
uninitialized, and for a zero-length segment mptcp_incoming_options()
reads them; KMSAN reports an uninit-value in mptcp_incoming_options().

Impact: a remote peer that has completed the MPTCP handshake makes
mptcp_incoming_options() read uninitialized data_len and data_seq (KMSAN
uninit-value) by sending a DSS option with DATA_FIN set and the mapping
bit clear.

A DATA_FIN is always sent with a mapping (mptcp_write_data_fin()), so
gating this path on the mapping bit drops only the malformed no-map case
and leaves valid DATA_FIN handling unchanged.

Fixes: 43b54c6ee382 ("mptcp: Use full MPTCP-level disconnect state machine")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
The stale data_seq then reaches mptcp_update_rcv_data_fin(); no further
consequence is demonstrated, so this is a robustness fix. The read site
for a zero-length segment is:

	if (mp_opt.data_fin && mp_opt.data_len == 1 &&
	    mptcp_update_rcv_data_fin(msk, mp_opt.data_seq, mp_opt.dsn64))

Reproduced under KMSAN: a no-map DSS DATA_FIN crafted on the wire and
injected over a TUN device into a real MPTCP listener produces twelve
"uninit-value in mptcp_incoming_options" reports on stock and none on the patched build (the unrelated mm-side
KMSAN boot noise present on both trees is not affected); a well-formed mapped DATA_FIN
(control) drives the same branch with no report. Harness on request.

 net/mptcp/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index dff3fd5d3b559..e40efa26a6694 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1227,7 +1227,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 	 * present, needs to be updated here before the skb is freed.
 	 */
 	if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq) {
-		if (mp_opt.data_fin && mp_opt.data_len == 1 &&
+		if (mp_opt.use_map && mp_opt.data_fin && mp_opt.data_len == 1 &&
 		    mptcp_update_rcv_data_fin(msk, mp_opt.data_seq, mp_opt.dsn64))
 			mptcp_schedule_work((struct sock *)msk);
 
-- 
2.53.0

