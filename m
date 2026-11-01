Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560947;
	b=D0lPebpb8U3kPcieVKzy++X3nSgh3NF3fYih7zNXN6QES3z/ZCyynaZo3ZXxMnOE8Ngb
	 caitaMva4wBiXKlh4LOGflXUqmYo4JUwlZaSOECrTgW9ceiDnx0aP7CZXagI5swyLi8Hz
	 D2vFqYSLEcEGqPpa6eYyCBpZvNCeLIDJ0GQIS3U+o5fZVjLMcQ03SYlvM7m/Fru665f55
	 InHTm3S+MB20crPxmx+61EHvnxXpDizpZNrkYNpG+LojgIvWH+9rsVg4lzqRddKRhGVZE
	 PSDq+NnYPX6pucO53H4iQGY5eyBNpPDttUr1wSoLtCBOwGSpZ/jUShdn0AvRPvmOjhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560947;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pLfQTSZWiMHhpz6dJ4D5IaCGs2afSNTfy0DFwwVYQDQ=;
	b=wPiFdjtQNm3L/28UdiNgxt3FVn1McQ+vGFB1vJ/0p1PDjULGOqoftXEIsqZtVrHwZCMe
	 YyLLujOL6+WV76V0KnYVcpKVplPgI132ERmorZl+zY7cj3+L8n/bW3fRHNvvuxeISakH0
	 GYc+TSI9ppp8EEiG7EOHPA1w6/zLI/kta45kzjqVyM6armoj9W1Cd+iuEo9pdG4B0dZt2
	 pcPpX4JOBpntOnC+Yrd1kqHKwFtDkINejCBvEdAvT/cg9xOBVc0+m58v5QoM5XSkTwZZF
	 63rqNEDZyMHwO1KzhgCvQ8ThDNqYSIFbzY7SOpGOV3YYsHkErTj6jYhkzMwksWEkRLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OYsXTouw;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C241160A2612
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 19:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C241160A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OYsXTouw
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ab98332238so1199239a91.3
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 11:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560946; x=1794165746; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pLfQTSZWiMHhpz6dJ4D5IaCGs2afSNTfy0DFwwVYQDQ=;
        b=OYsXTouwDcGEbk0gfkfFTm1iKNnPu5Cvr1azRRUjFibcmXqoMuHVx3VVBQS8G3CB1d
         EGa8qS+XPod6BLlSwVsOnNOvoynB4tpFLBpBJcjMMxdOednjTYkvLFZtfWajOkjlGGC9
         JmqFIMmqoN681eAfFC4KUVKzaXxkHkKUlmEI4i9OLapePau5XTz90vkPbrxrXhK/qr7H
         x6R78Lcy/6J4z4oh8D6EuEg5GITT8WaT3T7H1vyMQlkNTku61yHDwStfEUdMCYr2fKux
         Hxmdq7ISntk3WtYcBFyEzBzNUcmS0OhMWeWBiRFIBgmyF3Xu+KkTUo+Z+5wn4bfeko5M
         6ZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560946; x=1794165746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pLfQTSZWiMHhpz6dJ4D5IaCGs2afSNTfy0DFwwVYQDQ=;
        b=SQknXYIhLNYTtZcKS9aIxB2yTtZahnFZcKHS6h64JlEzL161rxCSubkmnk8yE6XWFM
         gQb1wqxAn1y9F1Nq6dhWs2RKQokkPUGSn56CGxKM39qqFCcC13ZgnLmchljuJ6zAdzww
         Wwb6nQMuqMTPGZlu3qvNilhGnc5aWdZhHgvxSNmSJ8jPfp7/U6EUz7ZJakqYpsgbTRQK
         7WA2cw4olCRQ+wkRYAA99mwZPPlFTvjaBVpWQXOFbna0F+HCvJ+1WlqUvCK8SSrqMeeX
         W4CYy3bP6pw1G04v1pi/IMSMqHFVxReEquPq9Jm800yX5OhyPp2G5cVjAeYBAGhTPdz8
         CWfQ==
X-Forwarded-Encrypted: i=1; AKwUvBzXas9nq9aLo0FHmLyxAujxlNvOhOQkCAsnmlXpoJCdQb6CmF+r8yGtr7FaRCWE8mtZ4u+KoA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8JwupGPV0RR7qBqBQPBo4NAj3vGdwceB6GmkUP2zPIfeIM2QS/
	SehiESylV5BAuMWnzSLEC8vBDVLecT3vFqoGt6m1ncsXwLtrl4vJyX5p
X-Gm-Gg: AYBFou3P4kP5SX95pzptmOYLq86BGFyhDBs0tqZPAG2iD1PZYKCzcLy/ZyauyTpTiDH
	gtHhBP2iynnBrX6PVDStugUohy8WiHScDvLp4FZqjSofvJQO/4NXXadOYQLsxtvYxLsGiZ1qFCL
	QKCs0h5IcvqH8lOsB8wrXiFTgzZt8/nFCfCqDVTGOyfrH2oO+eo/Ut/BohISuoCl0yqSvAiFnax
	IObL2e0RKRILKw+k1jb57h0KvUu7PtzDgUfV92M3yd4VtyRxn18tNbc6/G5/RauedZucUrwjS0M
	oZMKvIG8e+ovUnp2wTD3+IdymIJSrtGubSGYvdRBTdb2BlcSpIVqxT6dcozcuV1szEPKl/M+UEi
	7KszPtGZVwuVSiyNlpBVkBfVj6WHpO9mFA8ZUF3iwcbPY6TKLs+ENQoDk83L1rkG735EUqO1TvR
	yAmqOObp6VpV9G08hAEKclbdszQt1zirzvebe4Hua75Dyb5pU//ag47Y1U5SCz0ALyfiebTyasS
	uNiwtiR/cwZ8cOkc4FhrLjNAEi5VoxjwsnT0C5YxT2zxbN2s0J+6CrZHPZiRByAM7zc78KL//sW
	bRL3JWSpDS3B4aWGPCF9ex2nR2V9uNz9SbBGf7z4NYgcFmmndOZXRYeVq3het/FQB6jlTdS+IyU
	lgBG/h26i8pCS1QyZyxyDp0KB+9MLca6jTGzj8gYWUyas3dlNkwxqbCBgG20dBGKEcXMBvvmwZA
	==
X-Received: by 2002:a17:90b:44:b0:3a4:acde:1e3b with SMTP id 98e67ed59e1d1-3ae896f8546mr7005266a91.13.1793560946060;
        Sun, 01 Nov 2026 11:22:26 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e973ac6sm16068213a91.11.2026.11.01.11.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:22:25 -0800 (PST)
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
Subject: [PATCH bpf 14/15] bpf, sockmap: Keep the rest of the cork after a redirect
Date: Sun,  1 Nov 2026 19:20:56 +0000
Message-ID: <20261101192057.2296489-15-alexei.starovoitov@gmail.com>
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
index 9bdcbb0a5998..a9af6be2aadb 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -536,6 +536,14 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
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

