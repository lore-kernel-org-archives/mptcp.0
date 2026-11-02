Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604117;
	b=RK+sQjiNPBV7+q+4QrE2c8q03AXmGVUPrzExboWNF7a2n91lPtTDgc0KQwgcA6zlKVFj
	 D3JrrooSgOENQ+/ExAyjguxibIs0PDWy1lYvc0CJKTiNctHGNO8lBLktVjAnHsQdVQ3q6
	 jCDlVvLa41jp7sLz0CODfJ+jKlh/g5HtWC2e9A/OYpef85DwejA/iAXLkoK8KDL5FSaEO
	 eqCFIFNzy7HqS0itTevhNgXipNnMKpE8j8NU98pG8Cx0tHMgQ7wu+vzzDo6ZKtU58yK4T
	 7R8a5564aHIOuFr9Rzy72YT/tK2vDtmyDEhk5D3jTSylkIJh4EIUqTMMQ3lIXYD16yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604117;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DJmLVVVW+5deakG/rXx9rSWGIQrWi9+mRR7c5J3o35Y=;
	b=BuPJ4S5zj51RyDzFMHWCXMM3+Tirutrg3g+O2inUmCMEq1jWHhY0cVAF38DbgQx0Cfls
	 fV8fLI+TdypBhc+1JmdXW4I1Ez09YcFyh1ELTZof0y812aUbNRXu5MV6X7K2qOETd2XqD
	 AUGbj94I4wpDt6tNJ9ymVkrSNYidF/K0c3pj+CmU0pZNbtt08gU+ZJBsE/MjfWRaBlXM5
	 Tum9v7t0GGLNwG16NrL+MU1O+oK8YNfIDx19ZsN1HW3wdZQcMjF6Y4eTMWhRs9tfacHzk
	 evAyIrEyfTCJtovaZJ8l3xP7+Rf/cE+bnmWprQikgiz1J1ggpB+WZA13sWsj0zTE5qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nOaCnmtn;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C23C606A324
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 07:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C23C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nOaCnmtn
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ae57dc1ea9so1225383a91.2
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 23:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604117; x=1794208917; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DJmLVVVW+5deakG/rXx9rSWGIQrWi9+mRR7c5J3o35Y=;
        b=nOaCnmtnRhvP8ztS2i1fiR2Ej1uUFb7CL6czQmUyBpWia+Mj12o7sfWZIfWTh3CtYV
         AsRbmkx9714BUd1ZhVSYmi+iD9wi6J9q9QnFkubpQ16V8J9UHj9R1srsAtPSF0fmBcXz
         iNJYMs60pxaGbKLIqYBZeArNTt8pBfEBFPOYBJ3cComFdmbwgMUpGgkTcdvX0w6p0gUx
         A+XcbZS9WtqaKf9SXJNmlu/KYwT0XQEX9trus0EHuyUrrLq6Ibur0f29jvPXIz4BOWU8
         0aUsobDqNY+40+InPYn2ZSZlSeH0GPVnxfDmPnB1Yw9jlqp49n2mLLg1b7pjrrjVgw3f
         KzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604117; x=1794208917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DJmLVVVW+5deakG/rXx9rSWGIQrWi9+mRR7c5J3o35Y=;
        b=mTifbPbJykYTxeITsjfzG6xtXG/0liajyNfl5fRIXkjM+GYh1E2NRwIk6lIAzIgmJ2
         0yK52E815bVs+BhrrUy2qUFgqflQJ5gduC6jROe+vhX4lpzgMP7ZYJy8KdxKDMfYngta
         Gdq08X6q1tj3pM1/fL6IfbcsRLsk8ZsY4sesK+zeEGTVFb+BR96l+nkS6zn6B7M+yr49
         lnr6Ah1F10I+l76+nwsvpH2soLd+XzMvBiI/KD+Xr6E61KEu1V0HJO8YL7ennS4AACL5
         YthMf/azWzBP8Xt/6pUy3Q4ZW+zPDUb5l05oUvauCSpmgAtaPAgtHNfERJkWTtgo0q5p
         buNw==
X-Forwarded-Encrypted: i=1; AKwUvByjQDM4tNzv8tq5NDYA+o000ZAG0tm27HnDm8aXyXMyUrM5Y4W69snwFwxvaWNHTcYfXHfH2Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z+2cyDVU4gqjl6nUGt0CWJjTwoWVjlytKhve2/a5cgRs6db8OrM
	Ar0g4OSgzC6cu0S3tpuXS/cGddOZpMJmReqZ+0+IwTwyw94FToExKiez
X-Gm-Gg: AYBFou3dWOsVSPE03xRGZshw+VRIxmmxV88xmNjsLdEudKmkm7JJli6KzUq/ijXRi1R
	EOXmT9w3GSfudUKi+DTySHj61NEpOARHYl35qrrK5mdffaOzuuWMG7vcm03XmFVXDibspvmttFm
	gvkX3ClbIMa42Zs+zUJvSns5q2h+S9uzEyqtct+NYTfkOtDeCI9WMy1kLL0zENfMJiwAS1vgbe2
	ioJJ+Ks3QtrDm69Tl434C01BhNM3C97XZbvDQFFJuamgKx1J13rHi9MNuhcOBusu/GeecneP9lW
	9plcflqIsjxnRGHonk++TK/mMW6TiuZor8jtr4xJVy/5SjEg5ofVulsfCUta1w0pBEo+JgS6dFq
	GtZZ8DdsKJJvcoEl/jgiA9j5BNly5cc7TSLxpmdkaEItDmnqo/YX0xf1NPCXMyrY9Sz5RmzbFl0
	Gz0pwkxV3syBb433v1Bxnx+1Lk1G4S7AJI7aU07cyGoFY0mXHNF7ca8jHdDVTgARlTF0s/q1jNn
	/OxJ3IVX5BP1mGzVDg0ywnL8BCrtjow8+dFAd2Qdyug4aOB0JZoAIGBkEOFSZtK6muy1aWBHwhS
	JqL/UEj03ypxm/kkTiK5S66/z3+xJneyJl8A+VExeMKcFtw861dAJavnInsfohrpvjzpJWSYyqe
	2ZWofv3UnDDx7sQ2+UOUxuoxlKRJ+ITxnetQ2QPdHNP1gpd4U8QQBOM4Oi4fF/0Sf2cMH5HErk3
	g=
X-Received: by 2002:a17:90b:184f:b0:3ac:83c1:2c0 with SMTP id 98e67ed59e1d1-3ae897e06efmr7231700a91.64.1793604116645;
        Sun, 01 Nov 2026 23:21:56 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae8826a769sm6098801a91.4.2026.11.01.23.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:21:55 -0800 (PST)
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
Subject: [PATCH bpf v2 06/15] bpf, sockmap: Give no progs to a TCP listener
Date: Mon,  2 Nov 2026 07:21:03 +0000
Message-ID: <20261102072112.4160195-7-alexei.starovoitov@gmail.com>
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
index 36d1bf46353a..fd443350f9b8 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -785,7 +785,18 @@ void tcp_bpf_clone(const struct sock *sk, struct sock *newsk)
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

