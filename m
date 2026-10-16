Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D4E299959
	for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 01:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792114520; cv=none; b=XusA70eXK6FdUShKfPxVgucgngvliGECz7/xKFuo3ZCslpSWWao6Ye02zBhPBh4gqW0ZJBWeJOHOiAo8dEgMZccjcgo/vlDtpiQQ2UROt+FoQgKrNJN6n2p4K+mIU/tsiOoxh5sxtibbuDMC1UEOJ7hUy8+xVxT9ajDQj1BQKuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792114520; c=relaxed/simple;
	bh=i3Jb5QAldAPCcDqjpZoYPjm5RTmnSuNwQkSujkPSd5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBIKQoc0r4sDK6DlZm+ZXr2koB9mpdyD540IxeRwL25M8faUBpkoJadxEaOJRRefc+wWujEpUgDnXAmlCPtcguvSox8iqi3A0Q74FVZfhaeKROi33C3XhD0jWrKugljcnM7B+o4ZmpzleLdQkdgUJbQ7Bd7Js6ONyPLQXBMXTnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeY4upFG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeY4upFG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A1A1F000C5;
	Fri, 16 Oct 2026 01:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792114518;
	bh=hqCkUAjvDQH+bt36hcYem8DUJ3qIfBbeg2g/CiQ3oYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EeY4upFG8iuSlgXeviNen5qSuuPSyNPiimEJMFawEqzIrPYpPhwA4ifpTw6ozNLcX
	 G6j7HggfL7PffNQTGalSl5AwcJdQ+tDAwKo8geEMNEuXMpiIWUlbASHc2p02KRcEzE
	 Dn89nNT7tSOPhA6hItQMuHrz4wdd/9GhO9QvHr1zNujfjGVpTsksmK9eDKtITGjHeV
	 OsRTJ+kq8bt1UczsOn8GGGm0Ez0QgyiBP97xKAcX33JoyyliKWvav1kHNjs0H20fdc
	 MZ0LS5wyZTa+ozwC8nU5Fkk2poZ4XjjaGOWpSHN7TBpXO4Iw/uJmsO/tgG2QNbXvop
	 JY505NvM0hkVA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/2] mptcp: give MPTCP sockets a distinct lockdep class
Date: Fri, 16 Oct 2026 09:35:09 +0800
Message-ID: <8651f29fb4e11de14a7ea7d05d97a33b1e5390f3.1792114102.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792114102.git.tanggeliang@kylinos.cn>
References: <cover.1792114102.git.tanggeliang@kylinos.cn>
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
into mptcp_reclassify_socket() helper to reclassify MPTCP socket locks
to a distinct class (msk_lock-AF_INET for IPv4, msk_lock-AF_INET6 for
IPv6). Call it from __mptcp_init_sock() to cover both active (connect)
and passive (accept/clone) socket creation paths.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_kernel.c | 18 ++++++++++++------
 net/mptcp/protocol.c  |  3 +++
 net/mptcp/protocol.h  |  2 ++
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index d3014bf57bf3..5e8792ad38ca 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -849,10 +849,20 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 static struct lock_class_key mptcp_slock_keys[2];
 static struct lock_class_key mptcp_keys[2];
 
+void mptcp_reclassify_socket(struct sock *sk)
+{
+	bool is_ipv6 = sk->sk_family == AF_INET6;
+
+	sock_lock_init_class_and_name(sk,
+				      is_ipv6 ? "mlock-AF_INET6" : "mlock-AF_INET",
+				      &mptcp_slock_keys[is_ipv6],
+				      is_ipv6 ? "msk_lock-AF_INET6" : "msk_lock-AF_INET",
+				      &mptcp_keys[is_ipv6]);
+}
+
 static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 					    struct mptcp_pm_addr_entry *entry)
 {
-	bool is_ipv6 = entry->addr.family == AF_INET6;
 	int addrlen = sizeof(struct sockaddr_in);
 	struct sockaddr_storage addr;
 	struct sock *newsk, *ssk;
@@ -874,11 +884,7 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	 * modifiers in several places, re-init the lock class for the msk
 	 * socket to an mptcp specific one.
 	 */
-	sock_lock_init_class_and_name(newsk,
-				      is_ipv6 ? "mlock-AF_INET6" : "mlock-AF_INET",
-				      &mptcp_slock_keys[is_ipv6],
-				      is_ipv6 ? "msk_lock-AF_INET6" : "msk_lock-AF_INET",
-				      &mptcp_keys[is_ipv6]);
+	mptcp_reclassify_socket(newsk);
 
 	lock_sock(newsk);
 	ssk = __mptcp_nmpc_sk(mptcp_sk(newsk));
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 60cbd91be632..68f339311993 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3245,6 +3245,9 @@ static void __mptcp_init_sock(struct sock *sk)
 	/* re-use the csk retrans timer for MPTCP-level retrans */
 	timer_setup(&sk->mptcp_retransmit_timer, mptcp_retransmit_timer, 0);
 	timer_setup(&msk->sk.mptcp_tout_timer, mptcp_tout_timer, 0);
+
+	if (sk->sk_socket)
+		mptcp_reclassify_socket(sk);
 }
 
 static void mptcp_ca_reset(struct sock *sk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ed2f363bb915..325499e65236 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1265,6 +1265,8 @@ u8 mptcp_pm_get_endp_fullmesh_max(const struct mptcp_sock *msk);
 u8 mptcp_pm_get_limit_add_addr_accepted(const struct mptcp_sock *msk);
 u8 mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk);
 
+void mptcp_reclassify_socket(struct sock *sk);
+
 /* called under PM lock */
 static inline void __mptcp_pm_close_subflow(struct mptcp_sock *msk)
 {
-- 
2.55.0

