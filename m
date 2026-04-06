Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4483346E64
	for <mptcp@lists.linux.dev>; Mon,  6 Apr 2026 03:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775445329; cv=none; b=R8M3JhQdRwpdx5pzEzLbljP7aTtfRZwTgty3ca9wm3deav1C13hgDZOzkI2foSSOW3OQHlqwnil2IKQEuJ+PLbZzBi3mPARlyw1zR0ZQo6t0e00TsDhvLr19Tek407cXmWAbH5e+JHfQGzXRfKlVSI8TyVJVIWxG/XastJBQzjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775445329; c=relaxed/simple;
	bh=VnKcRhtnXmg3esTxutvPiewGjUarJqAT10kc4eGYok4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tuyPJy+9ibpGRHDEW1smXyEpt24XfaJtLkY+71sbCpYD5c4mNRArVhsAtNO1Ayz8DEfDOU0qY9UpTrCTOVgpGLrbCeOIzjWRgdT7mNCqKi5bN776NPV9e2D1eBbhRbmczQZUqMoW2nSUt6fbYTDf74jybskhxOKzssy32H42Ir8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qMppkvCP; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qMppkvCP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775445324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pCU31PuVLxnkqkH0Q/gfVj7NOZB8sp1JJeyWvm+opn0=;
	b=qMppkvCPiJYh+m7P00Vul4Jo2KsY7FUMAzJ7JHiQ0AAMkRusLuXvkSBInX0nzNiYSiQzSi
	5b+yway8muyT9Hoxbv+KK5va66DvhgtG8FHI00LQa7y1qzFsZpRn2Eb+FmaX8rQRzaDKxI
	l/HKg/HyeNDl9AP70zAEPbpR2S9VYWo=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: mptcp@lists.linux.dev
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	stable@vger.kernel.org,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] mptcp: fix slab-use-after-free in __inet_lookup_established
Date: Mon,  6 Apr 2026 11:15:10 +0800
Message-ID: <20260406031512.189159-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The ehash table lookups are lockless and rely on
SLAB_TYPESAFE_BY_RCU to guarantee socket memory stability
during RCU read-side critical sections. Both tcp_prot and
tcpv6_prot have their slab caches created with this flag
via proto_register().

However, MPTCP's mptcp_subflow_init() copies tcpv6_prot into
tcpv6_prot_override during inet_init() (fs_initcall, level 5),
before inet6_init() (module_init/device_initcall, level 6) has
called proto_register(&tcpv6_prot). At that point,
tcpv6_prot.slab is still NULL, so tcpv6_prot_override.slab
remains NULL permanently.

This causes MPTCP v6 subflow child sockets to be allocated via
kmalloc (falling into kmalloc-4k) instead of the TCPv6 slab
cache. The kmalloc-4k cache lacks SLAB_TYPESAFE_BY_RCU, so
when these sockets are freed without SOCK_RCU_FREE (which is
cleared for child sockets by design), the memory can be
immediately reused. Concurrent ehash lookups under
rcu_read_lock can then access freed memory, triggering a
slab-use-after-free in __inet_lookup_established.

Fix this by splitting the IPv6-specific initialization out of
mptcp_subflow_init() into a new mptcp_subflow_v6_init(), called
from mptcp_proto_v6_init() before protocol registration. This
ensures tcpv6_prot_override.slab correctly inherits the
SLAB_TYPESAFE_BY_RCU slab cache.

Fixes: b19bc2945b40 ("mptcp: implement delegated actions")
Cc: stable@vger.kernel.org
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/mptcp/protocol.c |  2 ++
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  | 15 +++++++++------
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 65c3bb8016f4..614c3f583ca0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4660,6 +4660,8 @@ int __init mptcp_proto_v6_init(void)
 {
 	int err;
 
+	mptcp_subflow_v6_init();
+
 	mptcp_v6_prot = mptcp_prot;
 	strscpy(mptcp_v6_prot.name, "MPTCPv6", sizeof(mptcp_v6_prot.name));
 	mptcp_v6_prot.slab = NULL;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0bd1ee860316..ec15e503da8b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -875,6 +875,7 @@ static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
 void __init mptcp_proto_init(void);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 int __init mptcp_proto_v6_init(void);
+void __init mptcp_subflow_v6_init(void);
 #endif
 
 struct sock *mptcp_sk_clone_init(const struct sock *sk,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6716970693e9..4ff5863aa9fd 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -2165,7 +2165,15 @@ void __init mptcp_subflow_init(void)
 	tcp_prot_override.psock_update_sk_prot = NULL;
 #endif
 
+	mptcp_diag_subflow_init(&subflow_ulp_ops);
+
+	if (tcp_register_ulp(&subflow_ulp_ops) != 0)
+		panic("MPTCP: failed to register subflows to ULP\n");
+}
+
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
+void __init mptcp_subflow_v6_init(void)
+{
 	/* In struct mptcp_subflow_request_sock, we assume the TCP request sock
 	 * structures for v4 and v6 have the same size. It should not changed in
 	 * the future but better to make sure to be warned if it is no longer
@@ -2204,10 +2212,5 @@ void __init mptcp_subflow_init(void)
 	/* Disable sockmap processing for subflows */
 	tcpv6_prot_override.psock_update_sk_prot = NULL;
 #endif
-#endif
-
-	mptcp_diag_subflow_init(&subflow_ulp_ops);
-
-	if (tcp_register_ulp(&subflow_ulp_ops) != 0)
-		panic("MPTCP: failed to register subflows to ULP\n");
 }
+#endif
-- 
2.43.0

