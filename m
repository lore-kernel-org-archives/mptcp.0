Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604144;
	b=UoS0zT8vTm0ZKjSonPhtc6xM/A8Q6OUV1FMMmWi1q1AdugBIu9e/K4NDSEA0Qx3VuNJP
	 c3HPu1ET7JmUjxOmHG8+kryeMdm0puJBS2KSXDoIj4b0jDPp0gbzTXDWccdHZEgCY/ETP
	 5FaU1x6hy2OH6CQTT/7iXKMAGmOzcDqY4y2PSVPz5w2VBCuKRoz0dzbyE7hzoLIS5Gnbj
	 jKBhVh7J6423q3Bj65uqSdjFJYKiyCl8aPXoDHp/wRZo8WlVlZUkfex8g8nG2VwwU09If
	 o5prpT9I97uVj3gEiawWKPL4g/qEsaOWIQbs/8MFRnEI1eDI2qnaqbbB7Dhr6JbnPgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604144;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iBcyIy0xL+PHZYTiuLv6mXl5Ptne15lxX+AY37+XXm4=;
	b=5Mjr1v8leg3Yu13L0EhmdeRPr4ZmKTMnYtgjth63TS0OTqfYqb7fPqx4JzuUc0VrAoP8
	 6RJ+PAX2CCHB2uEGRDmJyThfWsSyI3a7sGo15Fo0BZdoo1XFS+KGuBY4NeJ+UQf4/Qw0x
	 zLTyFXxV7JZXfY1l/WFLYv2BKlDZOn8B4bH7jJWXk7pzFOwrWGqrUGWhNMp8Ws5YZIXa2
	 LYAoo1QcxWsv2aJNzhsA884Qr6BpH0qfudLRhxEIAsFOW6lTIO3DeWt7vRvBE3JR7shdU
	 1QMVGiYIf2nDk66kaXmV8yfJc7mcFVYfKWDhdW7c/qiv+FFLpJwz1uAPz1sZe9loDyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a2+SRlUb;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250F3606A32E
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 07:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 250F3606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a2+SRlUb
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cdadf7e248aso899138a12.3
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 23:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604142; x=1794208942; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iBcyIy0xL+PHZYTiuLv6mXl5Ptne15lxX+AY37+XXm4=;
        b=a2+SRlUb+5whVAK/wd8ccxbWbcF0S/QRlySpZ54c3SylznO8tOO/esvzEt9oi7K82a
         3n3+YKMZcgE7t+147Uce08nKyglMV2REyQrAb4ImLQtm7JhqMv8vD+wc4hBpxpvU2xDG
         W9zdsNVVPpobCQXhy7gCVpr0TqFbg/CA4YAvOxds5la+2A6Zo82eASvwvH7YoekbAqwq
         hVPXlEPNrxrExW0Mzsvez4k74gaFjZXbG/6THRSFWrVg0BTou/KPeZe3HCWwz1nQq6qY
         xHcORfBcFq+L2rCOD5YyD5K0SVv7G03eI3JGoV2o8TgXS9xn4/do6gW5QN3nOHC0+NaP
         UyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604142; x=1794208942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iBcyIy0xL+PHZYTiuLv6mXl5Ptne15lxX+AY37+XXm4=;
        b=d7Gr85mW3P3C74GU5pVIhQCNr34wYAlMFA/ABsxdkU1isWhwSPNFrAY20dBQSlmNd9
         2JiM6rIBLuqoJUXM4uUB+tRCgRF5IL2bYgH7wPv1xF9+eAVK3rQ2yfSRU1v9FJw3bxjo
         MfKyLzuFV/6rf6gxSDZzmaJ0+xR+T1U6EWRGboC/yi9Y75U+pnE/CzH/uXOSSkhcl1nm
         m4ZsAjSPxtSQs8Q69IZaCo7WIlg4+rHHZrIV75ectRlnMcH/TMw/z5f2LrY3ulxu+vT5
         w3hdIPdAhhBySmnic/nYZgVMu8DQUsc/nUsBh/hJ3ikUndMSiZPVrtU0LYkRpFjkb0k+
         D9ZQ==
X-Forwarded-Encrypted: i=1; AKwUvByAt3Gi4e1gRORKuMgUjuzNMPfi8qDRjD4sepggJXISOg6MhJWjQUTWKcFaDMse0YiWOJkOnQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYKbeXU5V6UjeTcFMaBHbDnZ4bKbWpNLODj6/nMZ4x3fRnceW2WO
	/Q8x/1iGwtedMvelb5a/4FwTmtGMgaHELvcW2vxgdJy5Oq3GNTdSmWbG
X-Gm-Gg: AYBFou2OfWbZ3ngW+X2qE+2jpZH3P3TDjUzju86zah3tR8KkV20SeuUi9TOdlzBTQ8c
	0U2gHW4JiZPKyM8N6ydpjZ20RO5jiPzS8Ltocb/IfnDvPMEe/2JH7v5QR0ORJ1P3Jb0ZDXfBwIx
	92/7iZG4LPV7gcZA18iOUHjKNmdP/X3DgzLtiffRflqCikFq95gNO8ehYGWJwoQcoRgQ1bsb2Sr
	PpzEUGqjd4mHl9XM4T4/MNvsvy16mfTQrHPi/vQa5NImP9ttHohfgrMAaIzzlWSwrkfCZmNHuZ2
	6NExkjNzNbzYzgGPhUYuWeKBNx++5Aa7X6DL1TCJxrnX73OWDK1CkiVTbiD7NfFX8I9a+xiFi+C
	kfYbqyGu9cQuNLnqYV7hTLYrfHEdpAybt1m9Gb8fKCtH/XoLRfL6zuKixyeKSdfmi7X0G6BSGSg
	UxHVDGO4K1acbvEyxrCcLrdmB1M6tsAEkC/w3XmEg1f1vm/HYukgZLkSNMZTMbXM9Y1ApFPwPJF
	Dg86sXfOMg8I5nwpvRIh/IZ0Dqfk+prXpjH7tbAxP1fWJLR2efgk+GUH5jUODl7CqtJUrnRNxoV
	p8UZFxnlkzhQ89uiDro6HIFpWt1fEbNX/YvdplWuH6JMonNNnkmrCzpluE3eEIbguv6ahdD3ja8
	JgTVe6rIOtyZPsvq4KiwpW4Knprria5dXNMYjxuTjwZr7EVoHNejiEhg59vAVQM/w/JvwQ/H7nw
	==
X-Received: by 2002:a05:6a21:1644:b0:3e2:4350:152c with SMTP id adf61e73a8af0-3e928b8ad69mr8141975637.4.1793604142251;
        Sun, 01 Nov 2026 23:22:22 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb096b4bcdsm2756194a12.5.2026.11.01.23.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:22:21 -0800 (PST)
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
Subject: [PATCH bpf v2 10/15] bpf, sockmap: Reset the copy position when corking
Date: Mon,  2 Nov 2026 07:21:07 +0000
Message-ID: <20261102072112.4160195-11-alexei.starovoitov@gmail.com>
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

From: Chris Mason <mason@kernel.org>

sk_msg_memcopy_from_iter() writes to the copy position: byte sg.copybreak
after the offset of element sg.curr. Both tcp_bpf_push() and sk_msg_xfer()
remove bytes from the front of an element. They increase its offset, but
they do not change sg.copybreak when the element is sg.curr.

tcp_bpf_send_verdict() can send a part of a message and keep the rest as
the cork. tcp_bpf_sendmsg() appends new data to it. If sk_msg_alloc() then
extends element sg.curr, the peer can get memory that nobody wrote:

  old offset    offset    end of data     offset + sg.copybreak
  | removed     | rest    | not written   | new data

Move sk_msg_reset_curr() from filter.c to skmsg.h. Call it when a message
becomes the cork, as the helpers that change a message do. It sets the copy
position to the end of the data. Without removed bytes it changes nothing.

Fixes: 91843d540a13 ("bpf: sockmap, add msg_cork_bytes() helper")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/skmsg.h | 19 +++++++++++++++++++
 net/core/filter.c     | 14 --------------
 net/ipv4/tcp_bpf.c    |  5 +++++
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index d5e35f24738d..f0e27b4b929f 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -196,6 +196,25 @@ static inline void sk_msg_init(struct sk_msg *msg)
 	sg_init_marker(msg->sg.data, NR_MSG_FRAG_IDS);
 }
 
+/*
+ * sk_msg_memcopy_from_iter() writes to byte sg.copybreak of element sg.curr,
+ * counted from the offset of that element. Point both past the last byte of
+ * the message, after something other than a copy has changed its elements.
+ */
+static inline void sk_msg_reset_curr(struct sk_msg *msg)
+{
+	if (!msg->sg.size) {
+		msg->sg.curr = msg->sg.start;
+		msg->sg.copybreak = 0;
+	} else {
+		u32 i = msg->sg.end;
+
+		sk_msg_iter_var_prev(i);
+		msg->sg.curr = i;
+		msg->sg.copybreak = msg->sg.data[i].length;
+	}
+}
+
 static inline void sk_msg_xfer(struct sk_msg *dst, struct sk_msg *src,
 			       int which, u32 size)
 {
diff --git a/net/core/filter.c b/net/core/filter.c
index 9245009d9f1e..50c0cda778db 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2677,20 +2677,6 @@ BPF_CALL_2(bpf_msg_cork_bytes, struct sk_msg *, msg, u32, bytes)
 	return 0;
 }
 
-static void sk_msg_reset_curr(struct sk_msg *msg)
-{
-	if (!msg->sg.size) {
-		msg->sg.curr = msg->sg.start;
-		msg->sg.copybreak = 0;
-	} else {
-		u32 i = msg->sg.end;
-
-		sk_msg_iter_var_prev(i);
-		msg->sg.curr = i;
-		msg->sg.copybreak = msg->sg.data[i].length;
-	}
-}
-
 static bool sk_msg_elem_is_copy(const struct sk_msg *msg, u32 i)
 {
 	return test_bit(i, msg->sg.copy);
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 3d703f1517d8..d534974c33f8 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -469,6 +469,11 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 				return -ENOMEM;
 			}
 		}
+		/*
+		 * A push or a redirect may have taken bytes off the front of
+		 * element sg.curr. The next sendmsg() appends to the cork.
+		 */
+		sk_msg_reset_curr(msg);
 		memcpy(psock->cork, msg, sizeof(*msg));
 		return 0;
 	}
-- 
2.55.0

