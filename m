Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8462DCF45
	for <mptcp@lists.linux.dev>; Fri,  3 Apr 2026 13:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775221681; cv=none; b=PriYxeWYEq9p0u0+MrHH/euq2VSvzE/UAKxnsqv50yNwlfsWY15O6QeFIl5hp0qKrtxjyLLlcgRwgirGeqFCEWLLkJDAFCTyoonF13nc611VtOWTwUPzlpRzKvSwliJSBvC3SoXvUSfsJjvyywDQqO+4k66vEG782ddPg8Dc2f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775221681; c=relaxed/simple;
	bh=wD0HQ2QPMI7IaiQGwEwbRAWOKIzYl/MwjepzMuSNXYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xz8QgoQ2+wRW/XIeWN4SKbT+DBFKKfSb/gBzoSOHdkfVMAWD21byQZmeEJUFf3l1+paP54uhxTsE7cNDcd8iZ38aHXG/ZJrjRkwTfL4aKBXFIrrk7G92s4BIqFTeYcj0yw3AzD1hJxrc4PaYyQHueZ1F+xTcobMzyuBUPoNeIIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SnUl4ChE; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SnUl4ChE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775221667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j/YZxgwy/QvL7kUQHh7K5WqqI+LKCK+a5twSKtnFHGE=;
	b=SnUl4ChE15aZeGTnJn+dmNS147UUaMeSjbdfoN0Vd2SBIcFc97uOxZ/R9g+IKnDpOIbjj8
	Ey3OhS0Ps7Y7h7gAUUyjjbcov8knlD07WkCM+htMFXEwklV/bRyqG8her5fIhWrM5oYluM
	QjyiqNXHnasMxaHs9AG4oMCNC5LYU8c=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: mptcp@lists.linux.dev,
	netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v1] net: mptcp: fix slab-use-after-free in __inet_lookup_established
Date: Fri,  3 Apr 2026 21:07:33 +0800
Message-ID: <20260403130734.93981-1-jiayuan.chen@linux.dev>
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
mptcp_subflow_init() into a new mptcp_subflow_v6_init(), which
is called from mptcpv6_init() after proto_register(&tcpv6_prot)
has completed. This ensures tcpv6_prot_override.slab correctly
inherits the SLAB_TYPESAFE_BY_RCU slab cache.

Fixes: b19bc2945b40 ("mptcp: implement delegated actions")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/mptcp/ctrl.c     |  6 +++++-
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  | 15 +++++++++------
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index d96130e49942..5887ddcdb875 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -583,7 +583,11 @@ int __init mptcpv6_init(void)
 	int err;
 
 	err = mptcp_proto_v6_init();
+	if (err)
+		return err;
 
-	return err;
+	mptcp_subflow_v6_init();
+
+	return 0;
 }
 #endif
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

