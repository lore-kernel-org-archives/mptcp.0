Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E221368D46
	for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 03:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792379088; cv=none; b=XuWdRSkOAnWPK5ujPO5IPRZe1FUIwJUvdUXT2tKHurBnvGGGImgwizcjd0HjpfydXpz3o6S+I4AgvVA9RKHOYhBCVA6A9T0R9akPP7Adh0TWb57tScWhffVljmXvW9EJN//qFHtSndrMX/Iv14zwv3RACJl8iVcaU6yXiqQk2pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792379088; c=relaxed/simple;
	bh=jYW8Lt13T1bTxzd6fX8A5zPvabOsgx2+AKbqs8yr6Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+k0SpRcnkAOmFYImQEH8AWH//TFwTEEBCTK6mxhy/9+jmp+VnssMKEQGCkAB0ecwN7cg+LSfXCQ5d+9T0qCazoYubZ/fGRii3TDFauxtAX6y1HlEKr3eTnoYsK8fj9UyAClXmzCkptYqGSMX618L568yxl+3xcF1BRFo3t90pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8nXDIds; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8nXDIds"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80691F000C5;
	Mon, 19 Oct 2026 03:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792379083;
	bh=LRRz31708bq10sSxxjIZ5AB8L5mEs3+DQCtoFC2f0Z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q8nXDIdsR6SUiXO5V+uvUq3oraaFAhtrZ5UtuwwhxEnDfaPuhBIjPuA2mq1aSrCwS
	 EbZ26S8hh+Jou/DQuTV4Uc4N+xhU7/WgWnJHinKI9/liu5DOOkOKRu/WiUVX3aetNA
	 AR10rcBt27F3kea1RZldFN3OanbCaINO+4ei7wWGbFiUVagSVwMHBRCeYDUtVFHckd
	 j+MvRmCiFZeJYCjMmICd8WC0BtxmVLkmwjkQzTXOdWgROvwEOKxmJQoECY1g4qM70M
	 +M3LSFG8xwxIvLjpgkMQngC+5YT1h3G7coB6ddZkEOsX2EmTyI/DTtuIZSBekV/y2L
	 qM78UgxDsfzlg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 1/2] mptcp: give MPTCP sockets a distinct lockdep class
Date: Mon, 19 Oct 2026 11:04:33 +0800
Message-ID: <9e27a6113a67e5d5f3af6193f8d20c7c8cd45cd9.1792378794.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792378794.git.tanggeliang@kylinos.cn>
References: <cover.1792378794.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

MPTCP sockets and their subflows share the same k-sk_lock-AF_INET
lockdep class. When both are kernel sockets, lockdep flags every path
that holds the MPTCP socket lock and then locks a subflow (setsockopt,
connect, bind, worker send-ack) as "possible recursive locking".

Extract the lock reclassification logic from PM listener socket creation
into mptcp_reclassify_socket() helper. Assign distinct lock classes
based on both socket type (kernel or user) and address family (IPv4 or
IPv6) to prevent lockdep from conflating kernel MPTCP socket usage
(which may nest with fs/storage locks) with user-space socket API usage
(which records mmap_lock dependencies through page faults).

Call mptcp_reclassify_socket() from mptcp_init_sock() for actively
created sockets, and from mptcp_sk_clone_init() before bh_lock_sock()
for passively cloned sockets. The reclassification must happen before
the lock is held to avoid lockdep warnings. PM listener sockets are
automatically reclassified through the mptcp_init_sock() path when
created via sock_create_kern().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_kernel.c | 16 ----------------
 net/mptcp/protocol.c  | 37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index d3014bf57bf3..03603defdf6c 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -846,13 +846,9 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 	return ret;
 }
 
-static struct lock_class_key mptcp_slock_keys[2];
-static struct lock_class_key mptcp_keys[2];
-
 static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 					    struct mptcp_pm_addr_entry *entry)
 {
-	bool is_ipv6 = entry->addr.family == AF_INET6;
 	int addrlen = sizeof(struct sockaddr_in);
 	struct sockaddr_storage addr;
 	struct sock *newsk, *ssk;
@@ -868,18 +864,6 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	if (!newsk)
 		return -EINVAL;
 
-	/* The subflow socket lock is acquired in a nested to the msk one
-	 * in several places, even by the TCP stack, and this msk is a kernel
-	 * socket: lockdep complains. Instead of propagating the _nested
-	 * modifiers in several places, re-init the lock class for the msk
-	 * socket to an mptcp specific one.
-	 */
-	sock_lock_init_class_and_name(newsk,
-				      is_ipv6 ? "mlock-AF_INET6" : "mlock-AF_INET",
-				      &mptcp_slock_keys[is_ipv6],
-				      is_ipv6 ? "msk_lock-AF_INET6" : "msk_lock-AF_INET",
-				      &mptcp_keys[is_ipv6]);
-
 	lock_sock(newsk);
 	ssk = __mptcp_nmpc_sk(mptcp_sk(newsk));
 	release_sock(newsk);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 60cbd91be632..eae3f25dd3d4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3260,11 +3260,43 @@ static void mptcp_ca_reset(struct sock *sk)
 	icsk->icsk_ca_ops = NULL;
 }
 
+/* The subflow socket lock is acquired in a nested to the msk one
+ * in several places, even by the TCP stack: lockdep complains when
+ * both are kernel sockets. Instead of propagating the _nested modifiers
+ * in several places, re-init the lock class for the msk socket to an
+ * mptcp specific one. Separate lock classes are used for kernel and
+ * user sockets to prevent lockdep from conflating their usage patterns.
+ */
+static struct lock_class_key mptcp_slock_keys[2][2];
+static struct lock_class_key mptcp_keys[2][2];
+
+static void mptcp_reclassify_socket(struct sock *sk)
+{
+	bool is_ipv6 = sk->sk_family == AF_INET6;
+	const char *slock_name, *lock_name;
+	bool is_kern = !!sk->sk_kern_sock;
+
+	if (is_kern) {
+		slock_name = is_ipv6 ? "kmlock-AF_INET6" : "kmlock-AF_INET";
+		lock_name = is_ipv6 ? "kmsk_lock-AF_INET6" :
+				      "kmsk_lock-AF_INET";
+	} else {
+		slock_name = is_ipv6 ? "mlock-AF_INET6" : "mlock-AF_INET";
+		lock_name = is_ipv6 ? "msk_lock-AF_INET6" : "msk_lock-AF_INET";
+	}
+
+	sock_lock_init_class_and_name(sk, slock_name,
+				      &mptcp_slock_keys[is_kern][is_ipv6],
+				      lock_name, &mptcp_keys[is_kern][is_ipv6]);
+}
+
 static int mptcp_init_sock(struct sock *sk)
 {
 	struct net *net = sock_net(sk);
 	int ret;
 
+	mptcp_reclassify_socket(sk);
+
 	__mptcp_init_sock(sk);
 
 	if (!mptcp_is_enabled(net))
@@ -3765,13 +3797,16 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 				 struct request_sock *req)
 {
 	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
-	struct sock *nsk = sk_clone_lock(sk, GFP_ATOMIC);
+	struct sock *nsk = sk_clone(sk, GFP_ATOMIC, false);
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk;
 
 	if (!nsk)
 		return NULL;
 
+	mptcp_reclassify_socket(nsk);
+
+	bh_lock_sock(nsk);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	if (nsk->sk_family == AF_INET6)
 		inet_sk(nsk)->pinet6 = mptcp_inet6_sk(nsk);
-- 
2.55.0

