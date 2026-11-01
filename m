Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560923;
	b=QltHkU75u3QsfYbr121yadGcjhwjEFaX3+wpz9TwNrSuOVweou8NVjksQGWCEOp7EoVi
	 rHcQShL7kQgZvktSzJFRWSJMeSjYm29i5WVZXxhRMfWi5PHgQY0hRKxxNVTNCJOpS804h
	 E5KZnyuiYQIlj46cu7edZMU0G3Jl/7eZ7i4kc5jUNO8FM7KAhnIpA6UpExdD7cZvzkHb5
	 1TsSbBU+Hc3leXHAhD1KTI2nej1Yi0deKB8uL7EqsGDG0zKzOPR6wghu/RXq8Z5HyBrTF
	 5LStewzs6VDfCO2fjM8nYDh9rgVbeyP0Tl3INgCYiiQ8/UGHlX1rbRtMUHZ3dRESPZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XsgHBoShd1l16ZkCMwetUuA2WCLMhgmDmGz78nTCX+Q=;
	b=4KxDsvVfxdoHtnkAe/sSOSnh5PDXTPFQpKwghjOPYBr0+yTu/sONuToRbt3VHpa8pVSp
	 tV2qrLPljvY8yICQD/sEuyQxHX12qv7CzhVfoddEv06GgQ/lKNQzU3+vB3xFqhnpoJJJ4
	 jvgumQdlZ/kQp14Z7srLXkXeN+sNvqB3xN/VJYNcGVTutXrf0ClIMd7vtsYh+4PwAc15T
	 B2dl8aYkoA+jF32kP7SUUSFvrk9YbrUT0lofbopBm5XxOl7a/PEakZeaF1A6NLqxmhI/f
	 zXGWXLIjYaD+yzEBPZv5hSby5Hf3+LX691CWdRx6v4eFaSQWAOe2U+03gLasLqxtwJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=svoILlWG;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7433D606A327
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 19:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7433D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=svoILlWG
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a06b27bf9bso727066b3a.2
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 11:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560922; x=1794165722; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XsgHBoShd1l16ZkCMwetUuA2WCLMhgmDmGz78nTCX+Q=;
        b=svoILlWGydkDv1d8I9aasts8SBa31mNTcLmBm7xcrbq7xc12ipXyJTJB15LyjrhHI6
         9PzYkANRrKdgEetT3sRgdEO/fwnvcuZwAoCd/CDJKzCy+o9I0zNFFdd0M5/vOq7Pmw7k
         2RTckcbYmOX96tLYIB3U0sTzI8S+WfzpxD2OXajW7hLoogJUOtxWsqzYfcSiGwgBpd+k
         aZLrAGN1iA7C7UpOMbUlMO8s+Qu53Dyo4ilPh2h247+kdEqvfwJf6fwcWUfqSScM2IBS
         q5RNWZCYWdNJCkQgspl0M6E9maq5ukMlNTZFGRfF1Bl9AuB+lddgZEnpznQ8+0hUFfxV
         MrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560922; x=1794165722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XsgHBoShd1l16ZkCMwetUuA2WCLMhgmDmGz78nTCX+Q=;
        b=agk4GqxBk7AU6p+T8iRyBxqVn98EN5U6gZgtDS3spR21Q57hwlMEeN1vcSiNRcwpvY
         Ni99buUwcW8PKxQsA5miuY09VIZs0/KpPat+myl1PzVkgfzYaA7dcPL3DwrZzUpyWBMe
         XqFQFPjNp6gxMjG1GfAYXu0vpq7xOqOd98uZw5lf9GIYc8BX2BUdvAnSb8t9RAviXblv
         3T8hq3qkXuW0hFXFtVj6syi6RMZQ9ERvZWvHPooeypRpy3qm7sllA48oqtCw3+amEop/
         10mHT6KriUr54klDGxnYYcZfOy1XcsAjCqyZtadK8JaeayLnlA3X1J+1xGDH4fOf+A3A
         wl0Q==
X-Forwarded-Encrypted: i=1; AKwUvBw/mqPst6kQ86y329pHesMuCVhQkJRH8RRmzOaNueDOrircUGL9u1fMI0rxP+8YIIaeE0gN0A==@lists.linux.dev
X-Gm-Message-State: AFq9FYKOnLt8AwN/cJTOChVEd6ZS+BGxmVrDgYxN2v/dCbLr7+6E6rBL
	mN4OV+s/vUz5KPdoorOFTqTD6BL+pmYUpna+dYtJb5sJOOcJVUojhRXp
X-Gm-Gg: AYBFou2JEcowoFhz2UQQ/9ZkBa27YRu+LDufhkssKtgUbLlFKZcYOWFHWjbRyhM6rgI
	qxS/topBprjwzWDUAH9As7zTnFIZfAX4FKK/xL9qVMBrvxMFefhLmHTsg95zL6tR3jUGh2e2/Fz
	2Sd6tRzUyWp6QXpfquJMtS5n2xCFm/6+2WwDqIgAyaIpaoAPH2ONcaYbXyCCM1X/E21GYrjTAAm
	LvpuE64LcIuNT7EmqVW2Rm+TM2mBye/mUSFDCVHE5/1q1DJDJOJB2ZFq+/Uln0QscG8DimptAXz
	ZFMwBkGRe93OlHO9t2TiN9ZaXpnB/yUcjLRRP65Aa7Jl5i3Iq417+QwPhnIqhPb7M99QNiVnwJc
	i1EfH5ChIHU1FusCV+p7B+hr7pYoRxHASLljSZ9ZoG8j5+tgj7bC+MJYR9OphDAKQjnF0WlFEYU
	bqgW4S1HONc8Wg2deCG3kTDjgajcqZ3Qxra4iEMtF2i5QpjyhRWJpsa8QV4zK7U4xtgff2iSTn8
	UqkLPr5zqLcoq7aWvGo89/fVCLUvX3TTJO4ZnZbc2UIJ2ymB626e+XPlzasCV6X1JLDahtRfsuk
	ZfFCFl94dz3e5OKf6ESAMh6l9kxlmSdVpVTB6XUZV890v4+W3+Db4aK6/Ts3G0ImiFHQGKdEzxU
	gRV8I/4J6PT4c0jYM7OopXpmu7nAZmv7Qn7zbfo/xpGkXY7+EM/yOjiFog4UhBbUqQ6pOELnmFH
	m+nGKD60lmPbd17kd0OLE=
X-Received: by 2002:a05:6a21:487:b0:3dd:a196:30a1 with SMTP id adf61e73a8af0-3e928ad8fd0mr5379597637.81.1793560921776;
        Sun, 01 Nov 2026 11:22:01 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb096b8323sm2347314a12.6.2026.11.01.11.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:22:01 -0800 (PST)
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
Subject: [PATCH bpf 10/15] bpf, sockmap: Reset the copy position when corking
Date: Sun,  1 Nov 2026 19:20:52 +0000
Message-ID: <20261101192057.2296489-11-alexei.starovoitov@gmail.com>
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
index 303c0c44dc2c..e187e3c27999 100644
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
index 9848c8e5a2cd..d24ebcd7633b 100644
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

