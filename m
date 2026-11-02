Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604156;
	b=aBITsYTFS2kFeTnZehugTFVRdTurKubIUSaO49gHAwKf2Ri9NH2uqxiU3fF1fm0Jo5DC
	 meKdYEXwElC1uPmrOYZg885kOtlcOQn7SNxmVhscG+r9FqYYMw16W6tdWHhZhj0+m5UmC
	 l3ox8RnuybUrtzbCb+eonwmX6saPlo1ncUUYZR4bReY6hvCmYZCYQlrxO4DyAcRNKk0ir
	 8Pjly/E3RPi8ebgOlk87pVueqsSaPxxoM1gW2rcs72kWvNBsuIFEXNU8ZvA0+IFYBOZKq
	 lST6AhbNj8kNMFG67rdS3JpM90KMXFbYwMO7rZUWUGQ0QH8L1POSgLZ37zktM9emsGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zkvPy8BTXAWTFCLyRVJ2sIoHit4yKU7xsRMx7Je7ku4=;
	b=rFLqyvvnJwzsei7PcqAaWw8gkvNom0r5flnd7UVknwhrT+E+ZiL3nBswvcyIAAXACSYo
	 KI+bpEVSzL8zkWMu5ocjAQ3IXWSFSYpd2otyncRjxS7fAHvdvPOZEYe/NI71AbuJsgoWY
	 Y7sJUr65LipsVkloI/hik6SGjvs+2haRFrYI5q+FccKt/Pee3/ohdgSE+uS1+AjYz5VNu
	 VTFLOwn9kxjauDJb/1JUhK7El8qFztn98nXoxFBT9EWqOAsWF7Iv3OMA4HEGETPDSzc5j
	 3i523HFMZu9FO4wrpK+eNJQALx62QHWN1yGa/tNS2lwpNKBpQDI7U6LMD86Vx0Jivdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TSgtOzSM;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5012D606A327
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 07:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5012D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TSgtOzSM
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso1205505a91.2
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 23:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604156; x=1794208956; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zkvPy8BTXAWTFCLyRVJ2sIoHit4yKU7xsRMx7Je7ku4=;
        b=TSgtOzSMyvQFGYk+ovpdWC7OIa2E14r+xoa+A+PN0AnAWDSswK+G9GRoL4v00YMm8L
         CMPq3ycMAar8Px72qvZjFXNX+v5iM8sutHNpR/cF9TCxiMdZmTzseob6UTz1jMTojYak
         pNDV9mryoEdFUazUDHWpznOrdqhlY3XZ7lzGCLnWTuYUTYTO+HfTk5o64WwZysqQTEQj
         lQqq8DLdd8YNN8UL1UmbN9+suqVVeQ0YTCwBZqgG3jYtJrdRQ7zLEZwtRGiil/xYKFKQ
         g4uKGPGm1KI8A7y/g3CF+IfVcran2r68Yo4FHwFYtHzQBjyfdk/S5gxC5u5efJYybsZF
         87Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604156; x=1794208956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zkvPy8BTXAWTFCLyRVJ2sIoHit4yKU7xsRMx7Je7ku4=;
        b=MWDR+DEzUH/LKX5FEbu3/76s3bx+OedUwVZPaKC05c25BVa+tLqXcBL1LQHF23iw4G
         cuNHxQx/8Iy4c9eJLVqxy4nQd5WVNgHqsU3jUBAF5kZFBBmOUIm409H6owUqUkfHEidG
         d007z6MYGPbG7csqJrerDzYMR0iKpkED1ea1rnVhUd7ncyQvPEpv5KLjNq1SboVmAhmw
         Sn7o4b2bQAqNvpsLmkS0hqOIa9OzxaRGei787zro1clg86yDjH2yLuINHCfHdYHfYpYN
         MbYBoFPxne7fN0KKnen4ytnoYs/RMOKMNeYyfYqbcV1DazkUDi9UC0UyOSbm0DLuzt9Q
         7TDw==
X-Forwarded-Encrypted: i=1; AKwUvBz/f6hv57dNNHiiAGhVb1Ts7K7hm1NLuotMMdyAMXr4KBLCw5hSTxbKQbwRsQHdwILWxqDq8w==@lists.linux.dev
X-Gm-Message-State: APuU4Z+FLBd3Y3F5g4194yJMlPAoKE0jyhrOz+zsNYApA0Und7LqnHjZ
	pEh+9JTG8mHzXcKlpmPkRIsD/+qVNzWDQIsDMzfs1p+xorhESJ5UPfeW
X-Gm-Gg: AYBFou0wb1SoXsoBzp18dSMipw26rE18TIv2y1nuVfXtgwyZTF12Xd7QD6TYWspJ2/J
	78J5amxl3llDR8Xu42dymK9PhJmYCLIv/gE/iymSnAcxaCVSTP/YvQW7d3Ad6g+3k99IkFTxS8j
	e8uftOSFNSM9wL1L/YWrI2z7vVG4amQdBtnXsogdMoydYl5PYrVkNgKn8pLT47Zer0N3S21pZLl
	b6HLnrhKEHuz515lN9o4i3/aX3h9mFHTyC5Qs0KTotWFahN1uSrpB7kEkbj8fiy+eDV7Hk1d7Nl
	PP0wJB73qcK/7UVDvoWSD7bYJ4RZFbTeXinKYi0nws8ffR7b6ZN1gol5uFh5RNy4ZxO6DxQm43H
	PYela9VFhSNeJ/s9amOIldLgjauyYjTtTW4mnFEgaX/6YUF1PbNnOV2MpbR5H1hCUxuk8miktxQ
	w7UWhNEEDQFxx8mrXKB9weXTtRWCQQzU4WTrca2eLyNMnKb1boIPxzyTs4qTrJG4I+3qJ7Q5Z0o
	zDwpOz1G1AYTMXXwZJtStQKLBwa9Ct3+PVgN6x6RBbIktETZNFBejoOG8EDH7UkabEv0LPtBD3k
	Lw4Am/fW3OQA4yhITn4/RiS8RHAGlfJDKx6h2H/ygjitd4LACZOhmaBf+BWBLCD+ib7GsJLmkRM
	6mD8ny/HnZ/jIuC27R3olDD2kEtyeBgZY7ieCXWBH6JqLsv4OWs513XlontOMHtZWiRkS56oRLw
	==
X-Received: by 2002:a17:90b:2e51:b0:3a0:4668:4cb0 with SMTP id 98e67ed59e1d1-3ae8983f049mr7620183a91.47.1793604155368;
        Sun, 01 Nov 2026 23:22:35 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3aec233ba08sm3292338a91.0.2026.11.01.23.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:22:34 -0800 (PST)
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
Subject: [PATCH bpf v2 12/15] bpf, sockmap: Clear the redirect target before the sk_msg prog runs
Date: Mon,  2 Nov 2026 07:21:09 +0000
Message-ID: <20261102072112.4160195-13-alexei.starovoitov@gmail.com>
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

