Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604163;
	b=e+ULwiuooavXwM8MY0k/sxziiTnzbqeFgkdGDQLnWn+iUzOloQzBIBQsxwDdeZoJW/14
	 rJVSFU7EVHGVz1P+/vXm6rZdtnIlrYfrowUlyB5Q7xpwyQcco+6bmpQMIENy1bHTccXFP
	 BPHI/v/0dbCTrgCnlYKqYXAMaj4tjhLklMTUuuh/+xl0Z9fpmP76UeQCzu9QMbO/tK8Ay
	 7vOTdlMHf/8y3rhnJW4+AcrlNmKwEFmMpfVGb6F976YzGyhxTa3qoUhuEhLYjMNukbxtf
	 /xEUptS5akPPx/ld/tLfbeX+IcFaeKxszmIymKkM0Lo/FoEj5s6lKtrHWT6/5KxJBUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604163;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kV0Z1USHTSrdHd41dgedNKXyUstH61hWM+CBeGfT+gI=;
	b=P/COVGt5VxnuMOvuNuicTsHhJ/P7DToIpQwzlTTGr0XWbP6A+FtvnW1waCtqe49gL00A
	 Z7gM1D6Bx11ivFwM86JHiDAFlkWRgCTz3CvwAW1bovEHWUyBMa4xHOA4b5feqetryCznB
	 Axr8jj5kg5SVlnU/0xGef2GiMtHtED3b1Qd4T3eqiPULpslixbaFEQGD7HQFTcHnAPVLg
	 eNpujlExUUb6A6FolIe81eqtbhli98mVSRzguE5O+UfyD7qAoxE2exSt8KZ1SziKwlywN
	 ztmoLUaxY0hK9ZGcZMdGRJuPOwcHYo+YoE9dBP24kvYMi+3MyKZ7rC10Do4iSpiQhVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VRZcfMop;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F8F606A32C
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 07:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6F8F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VRZcfMop
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so2018393a91.3
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 23:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604162; x=1794208962; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kV0Z1USHTSrdHd41dgedNKXyUstH61hWM+CBeGfT+gI=;
        b=VRZcfMopDc7vfyx9Yh1khBVtutR5PE0gvFGIL45QRN54J48VZCgEgPuNsE1jaikjGb
         pKjwnWIH/jS9vcayZ94RjYj4dUL0w2u+NVmnflea0645ZUYupXlZ3V1C0zJ7ty5V5DEN
         MGH2JHRIm84SJKzGyl8+c/qfji4uvJVL43NsP87ZoJtdE5mt1upghVp6BhnXRkAYHqs5
         DAJc1C+Vx48/Q3doKBnRV61mGvwFgAp1W2Fc/odHrNEtHMu2BDB6szO/Ppn7gZcNzqDf
         M9exvaECxA4uQxhY2ovAN6z2sFtyi5QbYo2C3enzNELaDyhko7omBn9hdGED3xite+UT
         IfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604162; x=1794208962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kV0Z1USHTSrdHd41dgedNKXyUstH61hWM+CBeGfT+gI=;
        b=ihDE+oL3/DxJ8p04bjV/dbIBbsJTi5JCcHoOQvWEPCszF/HJh9V4U8Ef1OQ/+wWm+R
         oubRObYhtzm+7RlLk68qHBMFthAm/vX8Voc0vEUlCDee6YkaqWphk74j0ZRobis/UYS/
         zX2FR5lnGMlTmNuULsWKJjUs6thgZaLyZ1IQuzbNnTBvy3T+cCMh27ucLuTBmHXY9qSl
         foD08Oc9uv6WElPDeUpwEYSXkIMafBITpURVqMKWkLQ7R6hL0FoeduNBscPCsq6m/ezB
         3F++rxTsGpU451vNGOacwkPhV3Ly3dkZzE0SqgGW2EIjHYVai+KiJdd6EOxHqe3sxLyA
         0Ncg==
X-Forwarded-Encrypted: i=1; AKwUvBxycQjku9/H/BW7JWxDPyCDqT1VdH20SedfsI7Ybb8U4L7/FuhIa56302deGCmr61+633dgKg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9D8yIp7WHm2PbpfsqMxJ5axKpSM7a3xX0s4jKvj8WlWYCMMCX2
	qaWcofF/sFckgm12Md8bRDdEJa0Gp0FsIJ+KbGAU/YXUz6cr/v4tklhz
X-Gm-Gg: AYBFou0pgnM2m8B0qcKjEOHDcNCAOhMmnjYL/c6S8y6vTODqtB06tF9tN1sGxsX0Eq7
	hsZ/xYU1jVaPdmQM9VXjanYxU8X9Fcids07lSV/72xRvhWoyXI8knmH/7b72I9bOEdqReX78Rcr
	HkAcFaPT6xwekefltfBJ9ZnhffskoRQQK4sghQsfZgJY7Df3OON7vp9sLcUdpBqMw+Ya6kTKKOL
	8yIDn/CJlz7VtQ9DfGfuwPm47cKyYODug6bRzzVDqwWncR9p7PNcuK3CBjdNTdIt1CdTNCWBEzj
	MNzjNoipGSyEPweFv8wyjdV58GqOiUwwbbk4IiiVnhNvna57VvV4mRzUqfCqHJjMRsiLvJqisSm
	si9/hYgqFbO9pnVWEp7K1sR4Xn/6Qu2fwCyKXLO9JOvnw5xEzCp0HfIVY3Ib9UkQmual4J0Q6wm
	CkOZxy6deKSC+kcObtSmPHh9pMbOau2dKX2+/otO233N32RED0KBeLL42f33poXE2Vsf9B164y0
	dSJW3JCuqyNXFuOTacsvKpou/NBfMd0hz1XdOIeDBZJ0WNmNHlpgYWK7vxNkuJjapEvvu0BGHdU
	120nV8yTNH5OpT3qia6vs5xhfzWokfevn7Ax6SJ8x1Qo/Hdp9tb2wFpdM5sAD334og+JSWz0v5+
	kxVEprDuwVjTcG5RwsGmBlKjZp+eS4Ns8N6Qyo0STpS25G6/4s6UmhoHnSg7HCWWvmWMAZTZ/Og
	==
X-Received: by 2002:a17:90a:d2ce:b0:3ac:9176:e83c with SMTP id 98e67ed59e1d1-3ae89720616mr8312885a91.12.1793604162098;
        Sun, 01 Nov 2026 23:22:42 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845df666sm13045987a91.14.2026.11.01.23.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:22:41 -0800 (PST)
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
Subject: [PATCH bpf v2 13/15] bpf, sockmap: Check that the redirected message is the cork
Date: Mon,  2 Nov 2026 07:21:10 +0000
Message-ID: <20261102072112.4160195-14-alexei.starovoitov@gmail.com>
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

In tcp_bpf_send_verdict(), msg is psock->cork or the sk_msg on the stack of
tcp_bpf_sendmsg(). If psock->cork is not NULL, the SK_REDIRECT branch sets
it to NULL before release_sock() and calls kfree(msg) after the redirect.
Thus the branch assumes that a cork is msg.

This is not true after release_sock(), because a second sender on the same
socket can make a cork. The first sender can run the branch again, and then
psock->cork is not its msg. Nobody sends or frees the cork of the second
sender. kfree() gets the sk_msg on the stack, and the kernel crashes.

Compare psock->cork with msg. Nothing changes for one sender, because
psock->cork is then NULL or msg. The other branches do not change, and a
cork is still not safe for two senders on one socket.

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index d8e29b09818c..b1071b0960cf 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -517,7 +517,11 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 			psock->eval = __SK_NONE;
 			psock->sk_redir = NULL;
 		}
-		if (psock->cork) {
+		/*
+		 * Another thread can make a cork while this one sends msg
+		 * without the socket lock. Leave that cork alone.
+		 */
+		if (psock->cork == msg) {
 			cork = true;
 			psock->cork = NULL;
 		}
-- 
2.55.0

