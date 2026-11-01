Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560874;
	b=0teAe2TrY92MXBVrtVM3Yj54hV29YTgO2iDdWwV98/Yte9dsXnJmCWK7mWaU4SmCSfHL
	 bPOjim4wPu+gffIj3nuVSKRp/VfmFQI6/xq0LVzAzedOGcqywyVZwcR8jZ0OPxTSawztZ
	 dRDpuyI5YBAHJGFkAruB0IEDIsGrReJjumdAC/2UYiNNqtreAxiWHxdv17KizvJ2dGm4h
	 CdGEI028mdRk4j55p63qXhqNK0G9C3aKkBti0RDdkPOSTLhj67JiPrMOglAn847+heIsj
	 czFx0nSf2vJsABLbJbzfAYKMpfTNhBODa96RIdAzy0aRsHKJ4QzzYZ5E5qx+PDJ9sOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560874;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sdirJ0jP7o+YHEJCnK7VR6r1ybPNKkJjwR4pGDyhi74=;
	b=yRx2SAloPloKukpYCnnSCuDsn10rvUTSoWsV31nq7VI+FeyeC1zKJwXgleP6tgv/pEdf
	 HLMlojXgc2fDMpf9XAFXhLPCJj96dPE4oe2aa97geijMuhExR6aEiH61syLQH3AHwnWQF
	 qCMIQ0zzwYMBhUniaqSIrKDFp71IoY4nMPZqHF3A4yitKkhgatH1soMwI1rQVmyCamQv3
	 bIDd+0d2z9qcT7HcbcpP/MNO0ghls1q2tx+qjzFl1nGIvE3k34H2D8yxdnCJ082hapNjC
	 b2owaPgAwzqfj+AkhTK8XdPnEyfHaHmpu4CzqthK4ONeqoS9sSaw8tJ3pIoR0npyWLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yCdI0YAq;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD330606A326
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 19:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD330606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yCdI0YAq
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ac7c7b3a90so953560a91.3
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 11:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560873; x=1794165673; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sdirJ0jP7o+YHEJCnK7VR6r1ybPNKkJjwR4pGDyhi74=;
        b=yCdI0YAqaxOzabBOd3Dx88Kb59eSu0k+T769hOkADoOFj5iyIo1ASyT6gj712cLPgM
         chPktG1U/MjFTuXbGHjYukQwwqVZDUfslNmMp3Dc+YcmF+0xPyImn4jW0l/vJOirG6+3
         7vZp22LgAzE8RBtdRRdxBF3l5FlsfPSeE0PdY7/zxQvnmSLcP65eLhppCXKKg1yn5Hud
         P2kg+6OURMjCd5u6QJeX4fBd19E5oWUrfiPi7Ycq2CRjPHCQly1A58Co4k1ThO9RcyEl
         rhLzcNn1T8VnwC92UzRC2DVgdI77pkHRYjhcNQlVNax/sunLksWc2PafdOXr8dEuZrXV
         ainA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560873; x=1794165673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sdirJ0jP7o+YHEJCnK7VR6r1ybPNKkJjwR4pGDyhi74=;
        b=WFjAoVUNKeEyFvUKJFG++GLxWBn5iRS1FW59L2y7Rl045EeSV37C5hJ00tD4pxAza6
         Em8HsgHc8ilWdki7pFcvs+/xs/vwBIHXHYkivUEGRVLmtiHu1LhwBp3wnW7Fyi4kPE7X
         6cG2tEVgPRF7P2Kf6c2Akz6p8IuQCvRYPThZTO3iCTXBoyneza0K6uZTFQXgyfaJiuBz
         IPWIlHb2utSljGT45/PKnK8StYJRVAqJRdL/7zrJTUpDUWx5FQ6t3Y3zJXcQVAUvRHW7
         8lOeOuisLWXRFuO2VDiG6l9DDDzN73rfgItSrfwtEpwThs5po1AXo2j7pP9Kko5dnI6d
         7/SQ==
X-Forwarded-Encrypted: i=1; AKwUvBxTT0ajyiyQr38gqZWIbEy6xgVcViIJeWxyK8hhObLlkgARNoClGKbsgaPMitdA7wP3gcAg4w==@lists.linux.dev
X-Gm-Message-State: APuU4Z84ne5vZP85FWWQFLC5EeSppwFr29vpr+ZmNea1GkbbZl1I4hPF
	tDna3oC6pXB91YR0cBSlLqUPfkPHVMKmAGAPcN2jQcQhr6OsQfu9h33K
X-Gm-Gg: AYBFou2qd9u0fp7KECfZWD042vJV4j9HJdbUzIKoNNAGCpapfB3hAmTi3egWZPUTFQl
	gKDXxbNceR+RDWJkCredJg3BaEJVoSOFLYUZUTB11sUAeRg7mxWZwDV0NxiPZtxXD5OtgSu6LHR
	DcpvvVFPcbX/FQ24tTV93motHP948KTjwSOGsJiD7RXDJ0AdkBP+c6uDrSK/7cv13kQYtWbsKrX
	0zkRrdizATDMle6NXcSttjhNlqnXpITIzIPoyyIUcGMJ7REn5XFPnn3mhPMXsvw38jCaHx/eAy4
	OpF5qQ8DQ5ZgUiu57J6q8HTfqKS0D2C7ew/GU84+arnRFdhzBckR0/FeIkm09bEhLMX7HMXKEA8
	yTtqcSosxFz+vXY4d9S+7H8NfTiMIhyDs3EUEqZDQSPXCJ0ghXJI7NNXdQYeMUCWDGPV9BfCrkQ
	JAc8dQCmcm7TFiMxGEyiRPz5Wg6JrjY0kW402Kb0G88mWqnY9kHqwiSgFRI+APBcs/5Xm4nGZXI
	aXqKKSe1zxOXhUx6jakmTTDjeSSzHIJg4ENAqSTNDV31oDaQwf+OVWqV9wKkvW8S+an8Z4L+6ZA
	ZOQrH7ZO8n0XB0wpo3IsIvNlGMwDKJMLUABmUmf6zK0Qgq+sNyJZwZU0kH8Orbo10MKw4vXH0R2
	XGS/fWcCS0X47rATLVeypaDn/jLZfsJhreCZ3g6lrOKSOuyICy9Il581/0CnROD4Q597pYURHKa
	Lxiap5Z3i5RGP3GcpcXrU=
X-Received: by 2002:a17:90b:164f:b0:3ac:9ed8:f310 with SMTP id 98e67ed59e1d1-3ae8984da7fmr7182937a91.49.1793560873116;
        Sun, 01 Nov 2026 11:21:13 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae87f69605sm6059562a91.2.2026.11.01.11.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:21:12 -0800 (PST)
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
Subject: [PATCH bpf 02/15] bpf, sockmap: Don't let an SK_DROP verdict stick
Date: Sun,  1 Nov 2026 19:20:44 +0000
Message-ID: <20261101192057.2296489-3-alexei.starovoitov@gmail.com>
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

From: Josef Bacik <josef@toxicpanda.com>

The verdict of an sk_msg prog is valid for one message, or for the bytes
that bpf_msg_apply_bytes() requests. These bytes can come from many
sendmsg() calls. Thus tcp_bpf_send_verdict() keeps the verdict in
psock->eval and runs the prog only when psock->eval is __SK_NONE. The code
that resets psock->eval is after the switch statement, but the __SK_DROP
branch returns before that code. Then sendmsg() drops all subsequent
messages with -EACCES and does not run the prog.

Reset psock->eval when apply_bytes is 0, as the __SK_REDIRECT branch does.

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 8cf63a9e7fed..d90bcc911b36 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -509,6 +509,9 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 	default:
 		sk_msg_free(sk, msg);
 		sk_msg_apply_bytes(psock, tosend);
+		/* The verdict holds for apply_bytes, not for ever */
+		if (!psock->apply_bytes)
+			psock->eval = __SK_NONE;
 		*copied -= (tosend + delta);
 		return -EACCES;
 	}
-- 
2.55.0

