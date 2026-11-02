Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604098;
	b=Xxx12U23yxWnE9xcltIfF4Pf9qttVOfTBCLrrn3hh8x0jgh1/BOjD51B/DrN9nyb5zuC
	 FCl6spwKOasAUNlju3z/ubEghOw8J68eKJTgzBYbuyrjkd1k9OncoAMcNnFbYNqg/MQoJ
	 42F1YL8b7bKU3bFoUlPcCHx1xe7QrpMNFMRdSxzrNaS+H80S70pMp+ZAkEmQVetrz7bdu
	 tlcKflYrDn1FYzA7w085diDINHMB9WbWMifGhSzVFBgl7uEPKml6uM8hpHDCgK5kxPVhj
	 mBgoKtQ8UuNcF/wwOc8sTPNYZoE4y7MT4BHYUpWWHOMsOKbPxXpDY2eiwCZ/sVdQPtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604098;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Z7Peb9UAgZRQMeYI4B90l1wzrMCTNfd6vqfD72GCEUg=;
	b=krmUceM+8vGmDs4qW0HIZzQO6zYc2m20l5sV7SvNRfeMBXbEKrf5qer5M8cxRTyGbFfx
	 3WRbSXKHTEbmOsxxvBTsuNkYwRFoTLEAHkWYkIIXWikVzUpHxL1ONrZ5r6xGOw42m+Ddp
	 dAdkd+7LfvI3Yv+kKNDSC2vOZFJ/2zJqH21Fj/Jh3vMNQsGC3IwtdalcGBOA6dEIl0HVp
	 9QtHijJgZk4UmPM580e+E5w4CR7e8VCxV/yh6SU02hCSt3ovwpvKMZVcfwfWGSzfTNuKn
	 2cSoLZwvHFk1giIWSTFNFUJOvgohJk30oVlNyilMfbKtYt4hTvlhS5gumnK2N4pcG6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="U/1gfTvB";
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92924606A32E
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 07:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92924606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U/1gfTvB
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e9eb579c0eso13386085ad.3
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 23:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604097; x=1794208897; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z7Peb9UAgZRQMeYI4B90l1wzrMCTNfd6vqfD72GCEUg=;
        b=U/1gfTvBvk+xzsniVOqlThNSsmmpLJv74/ndwTK9ijTO/4sEJ1oK9m1zMgWiPwRu8c
         7fiuN6jNXBxBAmznPBb/Drtjm5iV4bQwd8DbzReMrb2MuhIbrtomcw9YQmOCKenk1vx3
         n4OL/c30ugLDnXZgJ2FH5J11rsY6D4o/WCpikgr2TEESuF6ZU2jrdKVgO2ibnTBvDd7S
         aBNLTcT251sJff1B8pxzfu1vUtxY769RTkNgvDEGXWah22hg0YOwqx96RKWvPoJIe3Z9
         9SvkpwTcNQ9YZfWA8M5NXBDuklqUaefoFsR6NQfQGbNzKo8dP3XN4Xa5RHxpoDKDIvq9
         b3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604097; x=1794208897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z7Peb9UAgZRQMeYI4B90l1wzrMCTNfd6vqfD72GCEUg=;
        b=hpIZCRMQnXXTQqJHvJoCYqY5NBwquc3PFoVlJtwSInGfxipXFW1UXJ2dT/+Oq0ASqh
         djMQdu6XXsWsH7GEsAwlm4rsv3qyLwQchYhXg6vNyHxSiiOdodTNoskxtUlRUJwaC+j6
         OmQZJ5DMJjSXmPf+DkAy2Hnl+vvW7TIYoLHSYX0wtsA2Mu5QvAMF4doc2bGvNElnxIMq
         tYGanlO2q88igZUP6QjWwzjmoVqlchvY/sbWt9n4b38mN5XG4FUMuK06eUadaOr5sFfo
         tw1w+6io0Be+S96tawxoqwYOs4BsOygg/1DRz+BWrALK2h2FPM7sDkkK/EoOXph/WJkH
         VD7A==
X-Forwarded-Encrypted: i=1; AKwUvByNMzcZa3iXTddFKv6TdOU+VAUyNYHpjmDCAvMGt8a7rRq1TdBSIVJO9B0n4EmNsKOWT80dSw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+VZdYc42jeSibnAbYs+fQP9ycEOavgECAoTwdWcIkT09GbA/nM
	vHUErVqUJEA/EGCIM7JvLTKqtyP9SMIDyK07RUR8oRwKsonmYhBGt+Xo
X-Gm-Gg: AYBFou1qdeVFSyNwS4q+OEiLOKTb8Xh+PbukdHUbwYkBSa1xmu06mic1tJKztzxOqcC
	ucDLfOzLdTa22wEQoZQfORAItiz2KoX7uNrqvpRzY/ZO+aAwMU4lKi/cyERzAF6BXK2lFQzlxZU
	BQ2drWe4+kAHrBwNBjl2buLf0FnTfXkVVvkINUTslGlMs6ksWxsxBzT4sgrJFptUyfRa0q6hAx/
	OcxixpaltpP85o5IGOxUr6ty/kTTEXQF4E/ZC7pUzR2l8VAFc3eONn5A5ZBqySqn53/rPiFSEoF
	dL3PY9XKcFxLQk8r1gq/cCGuVph2meTY9A4NiNfg+3YopEkvFufjqp/OaSZ16nMFRi5U6beWAPX
	b3JTZ0dkKr0eiWtxCImrtQcvgEGjN+SpnZEHBxlIT5/+v8dA/XAbsHenNrxrxiNhEfwXCZvR60E
	0L+3wWwRoMwXAKeqkGPIvpc/KyyoUcp60xQzNclS/vKwqCGUR/BcXBCo8P8ahocRBpX/wS/8YSN
	O05YaAsQkd0pPX+6O6CmtS+bcJYLhrYWKFpaZqz8DYmkV1RoX5bAg/Ghyr+IPTvIO559aLZ57WX
	fx0AU5OliuHDDIJxHm6fBlrvqaskrEYPu2hTuVciwy9sOyeSSCmBukkv9z9vc0of8F48yUBiO/v
	cVri5VWPZa20lIH84qjwyrjAbWJijjjJ0Xt5Y4tTS0AJx3DlEFAHQzjYU0ItctiJaaKQp0QNisn
	4=
X-Received: by 2002:a17:903:4b0e:b0:2e9:9a19:c54 with SMTP id d9443c01a7336-2eb3646ee38mr76369615ad.50.1793604096781;
        Sun, 01 Nov 2026 23:21:36 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3924c858sm24478145ad.35.2026.11.01.23.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:21:35 -0800 (PST)
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
Subject: [PATCH bpf v2 03/15] bpf, sockmap: Don't let an SK_PASS verdict cover the next message
Date: Mon,  2 Nov 2026 07:21:00 +0000
Message-ID: <20261102072112.4160195-4-alexei.starovoitov@gmail.com>
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
the bytes that a failed push does not send. But such a message also lowers
apply_bytes. Thus, if apply_bytes is 0 after the subtraction, end the
verdict, as after a push that returns 0.

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index d90bcc911b36..b016aa419fb2 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -457,8 +457,22 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 
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
+			/* Another sender can use up the rest during the push */
+			if (!psock->apply_bytes) {
+				psock->eval = __SK_NONE;
+				if (psock->sk_redir) {
+					sock_put(psock->sk_redir);
+					psock->sk_redir = NULL;
+				}
+			}
 			*copied -= sk_msg_free(sk, msg);
 			break;
 		}
-- 
2.55.0

