Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560910;
	b=GgG4bS8QmtT+4jHZbC7iZ4jTfiC+V0vtuv/7ciMzYr+BlVhtQYvM3dhzSdFbrgyxDdvB
	 G+T3fGKMCK/MUJ44B/PF5IM8fD0ytH7bJeLLJjaEzEsegSFNgepGh96YoJvaQMo9/6UsR
	 +RhC/QR85ksG+4M4loMuKqWcUIcj6wvY11jj84Od5WdLBGdcWhBClfWWVC0zn4mak9O3L
	 k8r1CZTi+C0+nSyEL3IZdKGJkklCDhQz+lEqPMWEswt+2uTmsv1rpDsPT/fLOPOp71iVt
	 GkNGnLMj+cuT+Ta4AH2HTbtjC2JU8I3XvYuh+zNIKWkfSmh97Z9lRK3w9Ysk9iRIsSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=q/uS3MNfywD3Vv+T8KYvUL+u5aHeTIkmuMrEypBwwRc=;
	b=Rgcrsu2N/LJtWtrtvEHz3ZA0aIlmziiCm/ios/wO0/Bn4YO7w6+gPoEckiuLJrMZ2v01
	 XtVCLnrHL2dCEinOr4cIqm4hJq9eBN0V/UST+kowBYsVp+BXPomtvMhsrEkSkzOdGVWBB
	 bNfdShAem//YhfLKJ4PxWa7iLahMlesswPxEknNfzzX1Q6eDlYuIYOJWZCynpxocEG+M3
	 JdcQyckbqy4HVU7ftAve7igx7E1ohu/3FMAO8qWc/6b5PNaEN6yVjeWDEPTlEE7SpOFYF
	 NlcnbnwbH8qmHxTotrSD9/UgTjA/l0aZebQZRub/eqOi7QwX0OK3kDjlrJM5aF4ucjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jq7f7Erg;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF28606A325
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 19:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AF28606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jq7f7Erg
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cdab6ae1ee9so868385a12.1
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 11:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560910; x=1794165710; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q/uS3MNfywD3Vv+T8KYvUL+u5aHeTIkmuMrEypBwwRc=;
        b=Jq7f7ErgqM9YnhxpmVdgqohhdW6ednt2TCRvi6j1I2vMP0c1MNySSLhZljdcgJqfIb
         lD2byqQHMbAKrOnp2cOJqzWl638HshdbtsHHwTRv86zLwneJiU4rvFKHuDJxrm0YmDID
         dVyHh06SDPRZvS6BpPx8xOjMeu5/DhoJ/fzFUExwFd2/uvHkpt1ZRvdH6ySwBH7fAFdP
         ZjwpugqmG9+woDvQpHdkp7xwhL6qodr1KCiEj35Rncq4h91ek458/o729beOow2OTeDV
         I34B9fiewE8xukSJo2T6Z7Dxb+F+Bj5GBcTRGiuBqJuBJ+JigR7QYF3qJiNJIHUbXDHM
         pHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560910; x=1794165710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q/uS3MNfywD3Vv+T8KYvUL+u5aHeTIkmuMrEypBwwRc=;
        b=tuxCk7XEksQte4Bm8pDeNb+UN9/a9wCxLouuD2rHNTj59Kcqeii4RUekU7wMiWnAlR
         prbkQN5ng05mt8IgrB8YCCJpXilBpSzgXbMdLjTpfIz377FQJAKyU6+VR3EBrNX6wyjA
         uwoNVuOF8x0TetRL2MR9AEwK/xzxABoJD9rjeh+ItVKBr+WG+lkd1DIaP4fP06jsi7z3
         k7ncsteTqf0YlRZLOO0XbUJYxHTEWfboZrUBMzMizC4ef6IcblWchfOxo27DZGWY4wD2
         5QrlPnBZbOhV/E2NLXmMsiXJOps35gBpTRuHSG9nopXi5GpYMa2K0jumIeFAHYexaLYM
         Xdqw==
X-Forwarded-Encrypted: i=1; AKwUvBxXALcOxjcqasbv0F1aY5Jjb9kX5GrjNW1nPqVHTcKFjsIetj7qt/yU72id3vnBAwiuFkbnyg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/lNkrGQNDo9GYgaNNHhVvxF0lVne+fuB6KDFfctRsbfMaANTCy
	1dwXY8g1N2hXMKUbGiaiErw9Yn0FRukRpGfcBkAhbUKw4LomXB6K3AAp
X-Gm-Gg: AYBFou2vM/o0MCS4ljhPZ0Xc49ngE4twpi/UkgxCaW2Yoldsnflm9XDYjE5XhgUEbjM
	fqiPfHoGqN5/c6s19x16pZe/j6Et5UeU420fpTiOuz0/gXienTW8jwxCHo4asWmLB3IlvGpctd/
	udY3gk+hGjA+sWDQ5tBoqUB+WaIeYnRA3yRREkbZVL//VbqcHgxyusD4Fiy7L1Yq5MHyYp4nYQC
	9l7gqQMcxwUXUxO86W2+QZe2pIj2789JrCt4WtwYXupFr9Lit5c9m+F5j13wcFeyjDE+zoGS1t0
	HAmEhb9D25v0dwMeoubQlFVswGC7X2TZ4q0CTALlvx2Dst9Gt5gUQVfKsLqc6iTUbt3GUl8RyDY
	NaaXMxblqHHUEOUMDVleb8jMY+h0bk8fweCUKbRCP+HVd9zuTEgOR6q5LhXzmmMXRTQgX5P0LMx
	4W26tnRxVWuXalkLSnUPjt/hc1Q6eTpVz0r7NSLwb0X5KM8kCzTDj2euGRzbyPWQazKDFFGVH+1
	vcO9Hvp8lggkOt2D3eMJb732GnARw14jAhMQfbj+onrLcULcoQmdQ3Zibap+0AOwHUhlWFrzvCV
	6utxsnKZPL1FG45SufF5Dh1akzsSSPqQNhXm82U4PJ2xGjLGKQGXDW3vqFfi2XdcBQ5nywXMay0
	utLng5bgvzBHNk0+15J3DA4TiqAdjecFDNdPzbsY6wE+hJTfnWO+LWHLfCqbjI7OWQpfjR+BN6Q
	==
X-Received: by 2002:a17:90b:2745:b0:3ad:544f:81e9 with SMTP id 98e67ed59e1d1-3ae8977685cmr6101064a91.15.1793560909716;
        Sun, 01 Nov 2026 11:21:49 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3aec233ba08sm1097664a91.0.2026.11.01.11.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:21:49 -0800 (PST)
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
Subject: [PATCH bpf 08/15] net: Leave sk_stream_wait_memory() once the socket is dead
Date: Sun,  1 Nov 2026 19:20:50 +0000
Message-ID: <20261101192057.2296489-9-alexei.starovoitov@gmail.com>
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

