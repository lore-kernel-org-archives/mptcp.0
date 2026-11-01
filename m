Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560880;
	b=ltb994k9ob50iWJQr+GF2El/XVK1/lz2cd5cyZEPWxPF+evlMUWkvm4WvZO6QHNc0aOy
	 WTLTP31fsnIo7Soiowzk4E/noKgadWOCpBu1/hbltFYcBbvWPThbPcAlYIoOhiXQZWQZz
	 uM0xoiCSZXzMUhk757srvqdoMjDBFU22ibkw1d5+Q1lyS2llwmwBjIc3N8Wr159B2nd2K
	 i1/t/C0fCqTW0iHzvC2HXqfNqbAnum0b1u41RKL2JRxt7ng5DtbwXhfefrs4yH2+BQiuv
	 SplAGjwFDy6mNEcdL/Uw+27Iu+l0x8oCf8VW53dIDK8oOzrsdvNXBGZqjVmiWl9W9Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560880;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SU04LGyxjuYA40ODCW0YIdLfmYd9WdxC4UJ8kuxQrGc=;
	b=t1+RzKh5KUaEsfpTJBf4Ca5SUGiGjC6gluHyqNNgLwkCA4h7JbvrwId0gbhGdEXirhbO
	 kKqMMyQpQk5qutaNiqY4Hk/X3FsPYWiWZUODP6eVzGpDX8LRaXblubdToeofns3KNbNLz
	 MlRv9hLwglE3FhhxCZjPTXMX7llI5BygaXAVDooZ1bgwfMdIhOf+uEqr+LSCR4mqRgMUZ
	 MsA8pX6EDY7eEDgM+WN/ercHobMnqYnHLfUFk9pQuq0q8MM6t/+0x43gZzcQchXM9yv9Q
	 cD7s1DJvctok9JsgYOTdElms6NjzknwdLFAWTtIHZa19AEVyo+C8LUUEBjHEzrThPgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0JFVIW0R;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17D9606A330
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 19:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E17D9606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0JFVIW0R
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a594d313a3so1307864b3a.1
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 11:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560879; x=1794165679; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SU04LGyxjuYA40ODCW0YIdLfmYd9WdxC4UJ8kuxQrGc=;
        b=0JFVIW0Rq06scmyC1KhsuUYlCPMdwCSuJW8EihqeBE+2c/+NJgxmuhJ8QkZNEE0cOp
         OYxP19MFoHnr+2cl2nDxkH8oIPb88kNbxbnwxpUIFyoirVWIQiAcUHuDvImhjBbzAP/R
         nMaoKCAhTvAGCpWfE2cNAS3F+iAQh75NMYJ71V28iElB89W0ym6LmpZIXxns2fpTdHkL
         r6QRR+U7CkdH9zSaaa9v9lPRjw6rlU5dtCmhuensYyS9FlB0++I9RwJyJPUIxm8OBsas
         Zf60XmTowh4Ko4ZrRcpHVhdZSOzmfI9ypL34BBqJPuEmXCJwokvAjTdPsCbdi+Eb3duY
         Y4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560879; x=1794165679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SU04LGyxjuYA40ODCW0YIdLfmYd9WdxC4UJ8kuxQrGc=;
        b=NX/rfWxT5ANYXAyBocnZYIG6isuo19uxVQ2vZaJtsd2NpVJ0ILcw5USHIQdNgfVUPi
         QzEETdEMcqfaYlS5G0iXeiYKodbtAzIOFgk7+laxr3N+pTzdBSjnjOoH48If7ohB8+Zb
         8saGKrVPgZp36EQquRQSEPoKuPDPqnJVxIcLmfvsvGI+6q2O/H2B10iMs3onHWuVhzyh
         NQ5Q7/tkVgnjkZffgTnTWB8hmTeVLpcpTQYid+6b/LWm0y4hGGZzZ/zcP+BlAwrvG+Gx
         8QMt8tONMS7qA4VjloWlggkAnM/9e86mBpyMQGzQzBxdgg0VOe9NmDZHZt9h8l4TQcvI
         vEBA==
X-Forwarded-Encrypted: i=1; AKwUvByW5mkVawN+XkcibZO1aa+FgJHfkBFNBxd36B9A29CpwkpyQlnE/somZ++vg8PZxH4kBX6mfA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKIfXEYXWRjxdgTabB2sCZOdtuRX2v/AtkiIjsvgjVReYkbTn74
	4vHTns66rIP69iCfDpZun2RrFI/btkGRyWwNV4cdamBziZjBMqkmYgRj
X-Gm-Gg: AYBFou0taVrOXArXlLi5zTEDh6Ft9k9TchqKULH8J7hOrFJWFQK2ZdnHb/+G4qMiFVm
	AT+zXnBKUURB4cLVX3Xc6ZRwvFZurRA2zXo/khCqYZnpxpD0jl74j2Oi2VVadbu1+Y1GoNLYVUZ
	wMaxciFUUCbnRiRn1/oo8vtRh45LHkO8U4/GeTSA7Srltm3d9GAg4UY9wwhCodm9TFQ76CkcgBa
	2G7ruZ1d90fwQC9GCGVTNbFxYFGfm5C5Kd8kEWDic+aHFnuVtmeWTbw0hKRiTt/gMLmLBx6AfVg
	2lMqcd7aVnj7w6YwLf6HilZmQxMcksVZO44Iqs7x8FdDnSevjsmmVjPSKa7/yOKAwSY9TnD6eeC
	zc3PH7m1sGBtcsAW2nsLynquL/vuSekMeErke/IVKbQms57KAGr0So8i7fI4ii7DFYGMPwPxdBH
	CiS/+gt4QqUuUEItR5cwGXF/o35KIxpEvp1nFfIYA9za1wh0DWbJkUn35n+LhCrXft44vBLbRMb
	LqlC/I06Z4MSu1RSWgF8EDlfwmsLBn3kHQY/tmXMX+Lv1LgoTdxyjINjpT2LlQH+hbNnPqHtaKZ
	qXU2FlcLeALblZ0Hbqse6tgujY1ci6SEqS2admKQ9Dyh1OGQGyHv8WeSES6zKI2G6c78zI0oH3p
	Iky49Japd2o82LSBMGFuv2YhiHt0vdqsk7f1MOuwGO4OGlMZiiJhNE17c4X9ez3UreynI5N0sP5
	8=
X-Received: by 2002:a05:6a21:1bc1:b0:3e2:1a3e:395c with SMTP id adf61e73a8af0-3e928a51d5dmr7646160637.59.1793560879239;
        Sun, 01 Nov 2026 11:21:19 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad963d055sm1140810b3a.14.2026.11.01.11.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:21:18 -0800 (PST)
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
Subject: [PATCH bpf 03/15] bpf, sockmap: Don't let an SK_PASS verdict cover the next message
Date: Sun,  1 Nov 2026 19:20:45 +0000
Message-ID: <20261101192057.2296489-4-alexei.starovoitov@gmail.com>
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

tcp_bpf_send_verdict() keeps the verdict of the sk_msg prog in psock->eval
and runs the prog only when eval is __SK_NONE. For __SK_PASS it resets eval
only after tcp_bpf_push() returns 0. But the push can release the socket
lock in sk_stream_wait_memory(), and it can fail. Then another
tcp_bpf_sendmsg() sends its message and does not run the prog.

With bpf_msg_apply_bytes() the verdict covers apply_bytes bytes. After a
failed push, apply_bytes still includes the sent bytes. Thus the verdict
covers more bytes than the prog requested.

Reset eval before the push when apply_bytes is 0. If this push fails, the
prog now runs for the rest of the message. The same already occurs when a
message does not fit into one sk_msg.

When the push fails, subtract the sent bytes from apply_bytes. When
apply_bytes is not 0, eval stays __SK_PASS during the push, and the prog
does not run for another message, as today. The verdict must still cover
the bytes that a failed push does not send.

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index d90bcc911b36..072ffd8347a6 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -457,8 +457,14 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 
 	switch (psock->eval) {
 	case __SK_PASS:
+		/* The push may sleep without the socket lock, and it may fail */
+		if (!psock->apply_bytes)
+			psock->eval = __SK_NONE;
+		origsize = msg->sg.size;
 		ret = tcp_bpf_push(sk, msg, tosend, flags, true);
 		if (unlikely(ret)) {
+			/* A part of it may have gone out */
+			sk_msg_apply_bytes(psock, origsize - msg->sg.size);
 			*copied -= sk_msg_free(sk, msg);
 			break;
 		}
-- 
2.55.0

