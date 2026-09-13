Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C53939F168
	for <mptcp@lists.linux.dev>; Sun, 13 Sep 2026 10:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789294528; cv=none; b=WPylIC/IAyWkO6d2qOSkhKfna6dr/jkRSx7fuUVZ5BJ5S4ZQ+fx01zgZ9t0l+M/pAk+F3XMVi9n2onGeGbW4rtv8qRQKLGf2n34PMOBAtXIzbg+YK9RySvg12mm6RPE5J7hoh/hVIAKcY8gesLfY381VoXa0pmqf6weOSASVFE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789294528; c=relaxed/simple;
	bh=YCAKtc9Y53WbhN9EpsdfoNSajkqfASwyTG2aFpSRkgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOoQVifSIwriYQX5KByzPkVK8nxiUC1ptJ5yRKzPEivvyLLjIVmiv6yY7L1e1MLb62hln4zv9/aoNB0go6tU2ice+iiy9dI5On8ZNsY9ZnY0pxTrpHelOUpLvh0W1Od5THXmEx6hJoBVy1tITymI38BZVAgjxbw++wJc4UWbNGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENb89wyp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENb89wyp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8701F00893;
	Sun, 13 Sep 2026 10:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789294527;
	bh=6i4fNQa/xgVC6yxvV84RgV+u48LDEveAR9LFSEh/+mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ENb89wypk5kgxiTswdMiJyoEhS7StVkJyizLAHXfghY2TCIiEvZM5iUCD7L5O3SW8
	 E2znRKRzPGvu/CJ6IORQU/fT7an/kKIUusUCgkz+A7fqd9NqUwQWaBRYSw9xUFUsAn
	 Mh5+rsGDhDxGkkjJ1y3HUnV5+b45qlIWfORINYbfxZFSVY3z736EMK4q/x15j3IiEL
	 prwoyBVrvNpM2m5Jz8qr9VsD+7dp3i1bVpTgrClegPurdYHgf6c8NpRIuRYPx/a+jI
	 lTRiRoqWlP1JK/yR6F4UJrqACfTH5i0PUupdBEmpC67lAw54WaEhuozljVRsHdD5X5
	 DMslYrZs/h70w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 13/16] mptcp: add sk_is_msk() helper and use it in sockmap
Date: Sun, 13 Sep 2026 18:14:52 +0800
Message-ID: <29ec7b3fc7febc1c8946add34f859c8253d9714f.1789294365.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789294365.git.tanggeliang@kylinos.cn>
References: <cover.1789294365.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Introduce sk_is_msk() to check whether a socket is an MPTCP socket
(IPPROTO_MPTCP on SOCK_STREAM), modeled after sk_is_tcp(). Unlike
sk_is_mptcp() which tests a subflow socket, this helper takes an
MPTCP parent socket directly.

Use it alongside sk_is_tcp() in sock_map.c so that MPTCP sockets are
treated the same as TCP sockets for strp linking, redirect checks,
state validation and egress redirect in bpf_msg_redirect_{map,hash}.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h | 12 ++++++++++++
 net/core/sock_map.c | 10 +++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 333bde2a0b76..6ab8d3e5e0f8 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -150,6 +150,13 @@ static inline bool rsk_drop_req(const struct request_sock *req)
 	return tcp_rsk(req)->is_mptcp && tcp_rsk(req)->drop_req;
 }
 
+static inline bool sk_is_msk(const struct sock *sk)
+{
+	return sk_is_inet(sk) &&
+	       sk->sk_type == SOCK_STREAM &&
+	       sk->sk_protocol == IPPROTO_MPTCP;
+}
+
 void mptcp_space(const struct sock *ssk, int *space, int *full_space);
 bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 		       unsigned int *size, struct mptcp_out_options *opts);
@@ -258,6 +265,11 @@ static inline bool rsk_drop_req(const struct request_sock *req)
 	return false;
 }
 
+static inline bool sk_is_msk(const struct sock *sk)
+{
+	return false;
+}
+
 static inline bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 				     unsigned int *size,
 				     struct mptcp_out_options *opts)
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 3e3e85e3bd54..e9e0b676aa1c 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -303,7 +303,7 @@ static int sock_map_link(struct bpf_map *map, struct sock *sk)
 
 	write_lock_bh(&sk->sk_callback_lock);
 	if (stream_parser && stream_verdict && !psock->saved_data_ready) {
-		if (sk_is_tcp(sk))
+		if (sk_is_tcp(sk) || sk_is_msk(sk))
 			ret = sk_psock_init_strp(sk, psock);
 		else
 			ret = -EOPNOTSUPP;
@@ -527,7 +527,7 @@ static bool sock_map_op_okay(const struct bpf_sock_ops_kern *ops)
 
 static bool sock_map_redirect_allowed(const struct sock *sk)
 {
-	if (sk_is_tcp(sk))
+	if (sk_is_tcp(sk) || sk_is_msk(sk))
 		return sk->sk_state != TCP_LISTEN;
 	else
 		return READ_ONCE(sk->sk_state) == TCP_ESTABLISHED;
@@ -540,7 +540,7 @@ static bool sock_map_sk_is_suitable(const struct sock *sk)
 
 static bool sock_map_sk_state_allowed(const struct sock *sk)
 {
-	if (sk_is_tcp(sk))
+	if (sk_is_tcp(sk) || sk_is_msk(sk))
 		return (1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_LISTEN);
 	if (sk_is_udp(sk))
 		return sk_hashed(sk);
@@ -683,7 +683,7 @@ BPF_CALL_4(bpf_msg_redirect_map, struct sk_msg *, msg,
 	sk = __sock_map_lookup_elem(map, key);
 	if (unlikely(!sk || !sock_map_redirect_allowed(sk)))
 		return SK_DROP;
-	if (!(flags & BPF_F_INGRESS) && !sk_is_tcp(sk))
+	if (!(flags & BPF_F_INGRESS) && !(sk_is_tcp(sk) || sk_is_msk(sk)))
 		return SK_DROP;
 	if (sk_is_vsock(sk))
 		return SK_DROP;
@@ -1289,7 +1289,7 @@ BPF_CALL_4(bpf_msg_redirect_hash, struct sk_msg *, msg,
 	sk = __sock_hash_lookup_elem(map, key);
 	if (unlikely(!sk || !sock_map_redirect_allowed(sk)))
 		return SK_DROP;
-	if (!(flags & BPF_F_INGRESS) && !sk_is_tcp(sk))
+	if (!(flags & BPF_F_INGRESS) && !(sk_is_tcp(sk) || sk_is_msk(sk)))
 		return SK_DROP;
 	if (sk_is_vsock(sk))
 		return SK_DROP;
-- 
2.53.0

