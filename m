Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A442838A722
	for <mptcp@lists.linux.dev>; Sat, 30 May 2026 07:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780127444; cv=none; b=T1e+m6A6CyYq44756ccvVrMv8ymA9Eu23ZFoJxkDzRJiHckuD+BprlZFAnf+HrMYmut/tUarm0fHM5bw6gdp/ekkiGHHtCTSBRFVRIuzUbS7lfYMR2p2y8wf7w1i6VV++KBzz2QX5RyJoLsU3qi73jnd/Dipz3mDU1PJlktnWfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780127444; c=relaxed/simple;
	bh=1Xa3HorqdIXeDTzjraadWn6wS4K9TVN9YjZYy4vzsd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsNEiE3PwB6CuE2iyZuCN1640YC9s72d6NLyUuzTRnbQTMUZH1cQhiktuSoXLuiK2Lmi6eO3uggKbZk1RabMS4Ybc4cgjBiaXDQaWGKIltbxTDCRFE4HO0l/4yW+9GSezAzuCoMqOXxq16AiNOqmS4sIpyFY5O9NX+PRfP2HTy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVyV7kVu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVyV7kVu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92BD1F00898;
	Sat, 30 May 2026 07:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780127443;
	bh=BIgpVhxMWzmPQViSnTnFslQq5dT70KsqNF1d0bAU2Vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mVyV7kVu+gfSfBhJw94oxjt2IDW+KOJBmSpZWS+0OxSRxFBWDXVMc7RK5yqCIASQK
	 pe+ZM8NxQ17khiJlC6BdCYw/Ra1sELLZ+X2l6gDGJrJa0A3llrt4ta6epbpMulTdFp
	 6ZeFrNk2DETpP0o32W00CIz8Fqe0VhdgXpc9zFR/8OwIFG2Q75D59vzDTaXBBmB2eP
	 n0LaAd5Qtsp6Q562mNUDGZQjafFSqH9e7MRoWWEs1Dwefq1e0TaxTO7REtqWDDKHIi
	 0NmRtxY+tb+6RgdIdbsCKYwAkLAggFayPzS7RKBMPkRRTIXs/eiUMOeBBANOF5C0lM
	 trROP3gtukJKQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/5] tls: add clone callback to prevent NULL crash case
Date: Sat, 30 May 2026 15:50:07 +0800
Message-ID: <f3bf97a9492a4bec4eaeddc45ca7a15479dc8c6f.1780127277.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780127277.git.tanggeliang@kylinos.cn>
References: <cover.1780127277.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

When a listening socket unintentionally has a TLS ULP attached (e.g., via
setsockopt(TCP_ULP, "tls") before accept()), inet_clone_ulp() dereferences
ulp_ops->clone. Since tcp_tls_ulp_ops lacked a .clone member, this causes
a NULL pointer dereference and kernel panic on accept().

Add tls_clone() that clears the icsk_ulp_data pointer on the newly cloned
socket. This prevents the child socket from sharing the parent's TLS
context, avoiding use-after-free and double-free issues. The parent's TLS
context (used for TOE hardware offload) remains intact, while the child
starts without TLS, which is safe because hardware offload handles new
connections independently.

This serves as a safety net even though tls_init() normally prevents TLS
on listen sockets.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/tls/tls_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index fd39acf41a61..c7ad212c97a0 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -1082,6 +1082,15 @@ static int tls_init(struct sock *sk)
 	return rc;
 }
 
+static void tls_clone(const struct request_sock *req,
+		      struct sock *newsk,
+		      const gfp_t priority)
+{
+	struct inet_connection_sock *new_icsk = inet_csk(newsk);
+
+	rcu_assign_pointer(new_icsk->icsk_ulp_data, NULL);
+}
+
 static void tls_update(struct sock *sk, struct proto *p,
 		       void (*write_space)(struct sock *sk))
 {
@@ -1231,6 +1240,7 @@ static struct tcp_ulp_ops tcp_tls_ulp_ops __read_mostly = {
 	.name			= "tls",
 	.owner			= THIS_MODULE,
 	.init			= tls_init,
+	.clone			= tls_clone,
 	.update			= tls_update,
 	.get_info		= tls_get_info,
 	.get_info_size		= tls_get_info_size,
-- 
2.53.0

