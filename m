Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560898;
	b=IriDnhnBAn7SIMOqTx3yQ3tGAerIUG0xd7QvXw5Qi+X+eUYbhYBWUVSw3HKLGzRg9JNE
	 rBp5wzUZu3QPx84oZBbf4n0JKQVIk2wpvz9JJhfUAByAzJm6Iy2sVSWzoRFy8DSTV06lm
	 UN1rwHiEw48q3bNOabeoxcy0cs5IR74WOSiETXyH+xsE+B/da7TVEBTH6Q8akBGEACzJw
	 MaDaCk4DqoW2Sk3+Q2f6oRWKdglvHr4P1WLuM34771OP9hiJSW3dm8QlLLO75KfF/wFgo
	 3Egonolpo6ZidzM2At+W+KM9TfXxR9iMayqcGntvZcEFurDhTgvDxT4B4iFtan8qUfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560898;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dz6pRM/Io22GYPHM6stLxgSNOJoApnHNm/0rCYVyXHY=;
	b=zPeEaUl1Ezz6hUW8mAxDDNzqC2MZighvR75eeg5kUabZmbmY7UKKwOXdtfmLHeTWCIf3
	 ofZawrdzLI8/pRqbmY+L1JgmWU++20kqPpHlQSnyZJxBoGMIizySOtRoBOY9uJbLyOo6q
	 QITsVWxCI+rkRsDUJQQ+YkU8ApLkp+A5IDaOIfU8c38dAYCvFyDNMYgHnWkshtl9QgfWI
	 nI9Vw+B74XB94eQWEzbjeFSZbTsWzpF+HLGHVim8ZhTNzP4w3emp69qBPcW5n4JSKA1FX
	 H3u7z4lUSXVZr+ZF3LN8OCGm8/M92Iiu/a59dw5xKwrwYpqL4D6iBWm6trw1r9/cTmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tWyQ6Jc+;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E859606A327
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 19:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E859606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tWyQ6Jc+
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2eac4877accso7440025ad.2
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 11:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560897; x=1794165697; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dz6pRM/Io22GYPHM6stLxgSNOJoApnHNm/0rCYVyXHY=;
        b=tWyQ6Jc+VjHqYvgElhqJOF2WisGR7Un4kSaC8w6rN64FxW8EpXxlkpNzUqHkvttooD
         s9nLyf1L3N2Q8BEwSKstAIssWwXGiRZtlJPDPOlhIwS6si63BckUUCoIPXE2G0moTJml
         Eyc6Ragch/rmZuiE6cpTjZyTLWZmzXRMGT5EL5N9yX0gkbYw/w6Zqeov8kEkLLMdWle3
         U9aEBeOWItNpTH9qTqVC0za+jQTnzh7QgOj5UVDPHzcUiTUg1a6e2OxevMeKzIzOIGr8
         iRkKDk+zwQ9OPy8e7TftBljYC1mf3zVkt/VhW6CHxwdrVLSSDw2ELcOKap6ZB07GFAvc
         BGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560897; x=1794165697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dz6pRM/Io22GYPHM6stLxgSNOJoApnHNm/0rCYVyXHY=;
        b=h3KnxV3cQi6lssRRuREaphpx+9+dGN2F5aek97yLXKnchoMdYat6f75FlNLrcq8eI6
         kTkxwJ5hRrZtp/6Tzjv7USb2hgbS9MFNUdutVo7/QtVY6rKRxdYBDPFMQ+LZUesA+LQM
         +Qrl0RzUSFKnJKLX/Aq+I4qA9rUukjLS+ReO/mxnsjQTxQUvMYZbiNM2uuXrxo21etOz
         WNKuhw7NHQJww4Tb377WOsyszTubfQXNDE0W3pLsjpxzq98x7mBCS1bmxOI1Ud4hd++M
         FjyclwK0ZfWNYks73QyyD5nLaPdyAJd8P8946MKaKPYB6aELKvtmP1TqpfQgk8YkOJwK
         KM/A==
X-Forwarded-Encrypted: i=1; AKwUvBw11IbJnCqt8v5/Xvk0MU5tWqZY0UUc7o0YrEj7O3v1z+b/XIFkiNFosb0HZEIg9Dt3nv/vPA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9O/uRTYaDz/wYF0meIv2rxzhM0pBaSBh76BgzoGDu6zfJQHwKf
	GgwBUJzaXpjbmIG9dTpBSZncHrFoqsa66qkb/aujllYhH5gzWpr1wllV
X-Gm-Gg: AYBFou0NqPWPoDlFCl36TGX4kNIN+yDN5IwnzatM1XYtmEpcMHZf3EA3i1ILYzmvn5E
	mRcYNwD/+A8u+f8GMdBvajqBrpXHdiEMi8Q2jCUeI5EdXmBLS3PGHGK0BN4/puPMluac6Ai4wyw
	sqrmllTNPggg+HcvU5EatnYgaZ1W/QqAHCwJP5hQ8/JgKKOc/eb3DXzPRSKYsxUtwKtH9+b+a3a
	S3bS3lAf1vO2/prrmsq/FPOnLQ6ZTlQ/r9w+5Jme4k/4S3bRTe5/G81uRzD5c48UYAd7VtdbvHA
	JGvjO1IO5R5b8FALR3/LQayzieKwRlfHqrkVj/P2upbzAPXaOJeKaLqyT/1bN6f5P01faZbCNpU
	OoHeOIo5A51ZVx3wTbfebaj9k3Gv6qqKDicdze57/TwzEe4T/0R5yvRJyBTjh+2aDHWxvEtf9mI
	rNKOtco8PqIIWWRH5Elh0Sdn90WqAduO22njkPmC8AjsOYP01qoDX8rTNxGvjKL4xdQta8Nzpsx
	T4B1OJb7orpqBOWjobj/kYfshyQlnNGlKC9zIWBTcK6UF5c0esa6YxUZYw6WfJecQhWDCku4O+0
	vRO+0Gts5VurL0FbACqFlvK/eObhb5ZFEcKXnlxtuxF3gghH780H050u7xTo3zCWRbNAm8wNXoB
	wQklH09N0zH77b9AbTc4NLKabJCACAsAGI0UTsy2kEyyo2X/GlsCcFmjB2mm3vaiq8akdop7VsB
	C1A7X4hnP616SQ8Y90thg=
X-Received: by 2002:a17:90b:2549:b0:3ac:a7ee:678c with SMTP id 98e67ed59e1d1-3ae89536be7mr6671928a91.2.1793560897506;
        Sun, 01 Nov 2026 11:21:37 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9426ffsm15650206a91.7.2026.11.01.11.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:21:37 -0800 (PST)
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
Subject: [PATCH bpf 06/15] bpf, sockmap: Give no progs to a TCP listener
Date: Sun,  1 Nov 2026 19:20:48 +0000
Message-ID: <20261101192057.2296489-7-alexei.starovoitov@gmail.com>
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

A psock with a verdict prog replaces sk_data_ready and sk_write_space of
its socket. It saves the old callbacks, and the new callbacks call them.
sock_map_link() does this to a TCP listener too. Its new sk_data_ready
cannot read and does not call the old one. Thus it does not wake accept().

sk_clone() copies the new callbacks to each child, but not the psock.
tcp_bpf_clone() restores only sk_prot. Without a psock the child loses data
or does not wake its reader. If it gets a psock, the psock saves the copies
as the old callbacks. Then sk_psock_verdict_data_ready() calls itself until
the stack overflows. sk_psock_write_space() calls itself too, without end.

Give no progs to a TCP listener, as before the first commit below. A
listener receives and sends no data. It stays in the map and keeps its own
callbacks. Add this exception to map_sockmap.rst. A listener no longer gets
-EBUSY from a second map with progs of the same kind.

Since the second commit below, a socket keeps its psock when TCP unhashes
it. sock_map_link() does not see the state that the socket gets later. Do
not depend on TCP to keep such a socket out of TCP_LISTEN. Set both
callbacks in tcp_bpf_clone() to the TCP defaults.

Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for datagram sockets")
Fixes: b8b8315e39ff ("bpf, sockmap: Remove unhash handler for BPF sockmap usage")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 Documentation/bpf/map_sockmap.rst |  4 +++-
 net/core/sock_map.c               |  9 +++++++++
 net/ipv4/tcp_bpf.c                | 15 +++++++++++++--
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/bpf/map_sockmap.rst b/Documentation/bpf/map_sockmap.rst
index 2d630686a00b..eb466b86df17 100644
--- a/Documentation/bpf/map_sockmap.rst
+++ b/Documentation/bpf/map_sockmap.rst
@@ -33,7 +33,9 @@ of ``__SK_DROP``, ``__SK_PASS``, or ``__SK_REDIRECT``.
 
 When a socket is inserted into one of these maps, its socket callbacks are
 replaced and a ``struct sk_psock`` is attached to it. Additionally, this
-``sk_psock`` inherits the programs that are attached to the map.
+``sk_psock`` inherits the programs that are attached to the map. A TCP listener
+is an exception. It gets a ``struct sk_psock``, but it keeps its callbacks and
+inherits no programs.
 
 A sock object may be in multiple maps, but can only inherit a single
 parse or verdict program. If adding a sock object to a map would result
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index efe49551caba..282c6a4b2b05 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -228,6 +228,14 @@ static int sock_map_link(struct bpf_map *map, struct sock *sk)
 	struct sk_psock *psock;
 	int ret;
 
+	/*
+	 * A listener receives no data. With the callbacks of a verdict program
+	 * or a parser it would no longer wake accept(), and its children would
+	 * copy them.
+	 */
+	if (sk_is_tcp(sk) && sk->sk_state == TCP_LISTEN)
+		goto no_progs;
+
 	stream_verdict = READ_ONCE(progs->stream_verdict);
 	if (stream_verdict) {
 		stream_verdict = bpf_prog_inc_not_zero(stream_verdict);
@@ -262,6 +270,7 @@ static int sock_map_link(struct bpf_map *map, struct sock *sk)
 		}
 	}
 
+no_progs:
 	psock = sock_map_psock_get_checked(sk);
 	if (IS_ERR(psock)) {
 		ret = PTR_ERR(psock);
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index b9761af13989..aa904ded816f 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -777,7 +777,18 @@ void tcp_bpf_clone(const struct sock *sk, struct sock *newsk)
 {
 	struct proto *prot = newsk->sk_prot;
 
-	if (is_insidevar(prot, tcp_bpf_prots))
-		newsk->sk_prot = sk->sk_prot_creator;
+	if (!is_insidevar(prot, tcp_bpf_prots))
+		return;
+
+	newsk->sk_prot = sk->sk_prot_creator;
+	/*
+	 * sock_map_link() gives a listener no programs, but a socket which got
+	 * them in another state and listens now has the psock's sk_data_ready
+	 * and sk_write_space, and sock_copy() has copied them.
+	 * sk_psock_init() refuses a socket that has sk_user_data or a ULP, so
+	 * what the psock replaced were the defaults of a TCP socket.
+	 */
+	newsk->sk_data_ready = sock_def_readable;
+	newsk->sk_write_space = sk_stream_write_space;
 }
 #endif /* CONFIG_BPF_SYSCALL */
-- 
2.55.0

