Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560887;
	b=mE3EH5vCj7NGKWrb4MNwnWgVmQIS5PZgAsxuLOUwUPgCtcIQLO3ueLVKIHlDZ+7YvxNC
	 dGCKqGoxOEYUgVDcz55+GAJ/cnBUnSNcrCiaVXOTQx+XJgORtKQ0iwYvlD0oDHOaj7ADS
	 3BmayTHyD1kKXYN6g6DeoU30sszbIdI3gQn9deDzXXUofbW75GUCNJlTDgE4GvSnSNPmM
	 PPPIEzg67/ecKQgAoe1Xw1vUi6BaITzzfv6IwAhLr84SLJNKm1d+mW/6EjlOwLeA8gwvY
	 vty63lxVMSSfrzEejcJGTJA9CzrJtPE4n+meSe6msgq4HCEpIk/KmHw2pJC0K1EsNzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lvky38gqrvpjSBWUSg+Q6mjoyF0URntzlHpSfOxGZkw=;
	b=U/gb87P9iUMNfc9M7etEysAioEWtOeFYgJ+jk94jMpKZsrvqtZXzxiCROslx0CN2s6Fs
	 PhjxE5sMYsjd64dswdR4Tq0aaHUSTGSgGNDdWprjhUcxoqU2tLKPDMhxrmizl5HELelys
	 /bk8ax/FWo9/voOHe+YT06l4FAYXyzqsLHHntPGC/EsDMGPQ/4/Gg9s+wPQWJ55DlaxOj
	 bne6KabLAg2Tci+TuQMPQey8105e2Y/QMm/4muhrqi8C7Hoo+MqoDkmE/jGJgUQcpL/lr
	 7T1gXGz/Ts2OhCWxC4JwOWwuj1+Nn0vRb3wo3s6fXdb9qBES+mgeol5rCPfxn563uww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uTStMIHc;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F23B606A327
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 19:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F23B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uTStMIHc
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3adf5f6833cso1206578a91.0
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 11:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560885; x=1794165685; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lvky38gqrvpjSBWUSg+Q6mjoyF0URntzlHpSfOxGZkw=;
        b=uTStMIHcS0vVYgJxy7Bq58zu9MWhiZk3MZnyclhvOWz04sz00iZaeVqKqVLE9Gntm7
         +sks9F9/0RLYGajZq3AfpyxJu08acEjQx+3HxXHSu+PatBGVBuVnYlIlevDmFqLhKsM0
         7JEu30FbPps/pdzk8qjrxdzPoMK3twa1xBmGmm5xGswKHAi1g2Tmfo9foBguMnA0mvvA
         DNCVPE036+ibbL64Zx0ef2wf81lhuLtvPX5A6tQ7H+c7OIFbZwMVuBA08pwvH9puS4GI
         Gg4tsKqBJKWkdG1iEUlukoz4nIKSOAP16dLhd3fJA1ybtr4E/iFEWBwrwugujmam9gcH
         zI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560885; x=1794165685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lvky38gqrvpjSBWUSg+Q6mjoyF0URntzlHpSfOxGZkw=;
        b=wfUAT9AhNCfAXWW1IutRYYsZeKyA140UqRm8ids3Bg2simcuW800A/wQnu/GhKtJWK
         uCF39nE5QgQqpG/+PmEwhEdHUiQAIM5W5/2oAAEvdUGApboeBnLs259gBvn8UkAco2ST
         73DtttlLlhlbanps6f9vQDP/Wg5iNcV/IgDEs/Z2S4cniKFUcZ8JcrI5VYpPHq7Ws+TH
         QOFOR2FbAhwpo6Q5tUQfL5NzwxKU8mLszYLLjwzksS+wyowa75nS9wUzq16W3XeY6Odt
         YPmB7t0jzksoHT9DEdDC8Yw4atPI5QFWq9hRzza60HiO6PHWzODmSayTTubVdVaaT3hY
         3mnA==
X-Forwarded-Encrypted: i=1; AKwUvBxa/XVCN9S9OlZ2FDPdwgSUPbBqzwUFetlrWBs5QI5GBJhc+mmUpFr1rjhJ5qnk05PpurVmYg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+fbCc/V7scU5/4Zprlkfr0MAsIPU140Ku8Ybe5o+Qm8xVmXxP8
	ZkVJo+fNBTthbtCWhbCeD5T11rbpHwnd67sgWTAPhriGtphIk2iUYOr7
X-Gm-Gg: AYBFou1hAXojEYvMLg+MxRYRV1/T3E/v1JTc/wu/NX0HtX3F5xedHMI5HKOATN1Panv
	NWbDCFsOyICcEVK6248IyHT6a1lAME9L7z+Ry3suVEM0vkzmmgylx5SI4oOrJXuV2s8u0vctXbK
	1KCUrEV5s1ng4iy9JZqFG2lqMw8FqfSR1T02scdQSVwslJ9QkS716hitVq76CZF68UP279+xquy
	xZuJmwQ/9lek2xzoNt1H/MowMXV90GP7F6bd1ptOGdGqSrf+nJj4s8/zPPebdmE80FQVAuwu27V
	7WYcP+YlJ7VNSv+HyoO/+6/4B5hOPi/TWxY1m3V23HGN/3SEaOjAh6Hc1nbqwc0Mf3syG1etQE8
	zQ24f/VnAw5KfowaTdzC2vgmdt6pKGh0JbobXAEMuXX5K182YuW+py//nYbIex8MW57H47y6T3R
	8mugDYs43aJQvLyF5ofPoYvw2W8pD0PV886y3yqEFIlsJ464DblR+Pov7FDVtswX0Xb7kkviS2G
	me3D8IAjgt0ZS0c1F4gDL1PfbuTSPKpF3djgHRqp30K0diTNHbxq/We3yr0eliFd5wn+BOyo9NG
	o6BEubCHKkiyURsuUxgSBltRURKZGZNtcqXZr0LpK/w07vM5KoZ+FypYuCPVH5zKh6/8ZxZoswk
	4GlgLFJFZqlLi0/s/kMBYPNYjf3ZQ+GiwLW4KTHtlZLio2UXMF5dJCO7F4TPT1Qc8p8k7pW7jtw
	==
X-Received: by 2002:a17:90a:ec8d:b0:3ac:b7b9:6484 with SMTP id 98e67ed59e1d1-3ae897ae130mr6233275a91.45.1793560885317;
        Sun, 01 Nov 2026 11:21:25 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae84596e3bsm11151183a91.9.2026.11.01.11.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:21:24 -0800 (PST)
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
Subject: [PATCH bpf 04/15] bpf, sockmap: Subtract all dropped bytes from the return value
Date: Sun,  1 Nov 2026 19:20:46 +0000
Message-ID: <20261101192057.2296489-5-alexei.starovoitov@gmail.com>
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

When an sk_msg prog returns SK_DROP, tcp_bpf_send_verdict() frees the full
message. It then subtracts tosend bytes from *copied, the return value of
sendmsg(). But tosend is the number of bytes that the verdict applies to.
After bpf_msg_apply_bytes() tosend can be less than the message size. Then
sendmsg() reports dropped bytes as sent.

Subtract the number of bytes that sk_msg_free() frees. After an error the
SK_PASS branch already does this. The SK_REDIRECT branch does the same if
the message is not the cork. Nothing changes when tosend is equal to the
message size. Otherwise sendmsg() now returns -EACCES if it sends nothing.

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 072ffd8347a6..b9761af13989 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -513,12 +513,12 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 		break;
 	case __SK_DROP:
 	default:
-		sk_msg_free(sk, msg);
+		/* All of it is thrown away, not only tosend bytes */
+		*copied -= sk_msg_free(sk, msg) + delta;
 		sk_msg_apply_bytes(psock, tosend);
 		/* The verdict holds for apply_bytes, not for ever */
 		if (!psock->apply_bytes)
 			psock->eval = __SK_NONE;
-		*copied -= (tosend + delta);
 		return -EACCES;
 	}
 
-- 
2.55.0

