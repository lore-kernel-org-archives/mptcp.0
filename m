Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9967038A722
	for <mptcp@lists.linux.dev>; Sat, 30 May 2026 07:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780127451; cv=none; b=LkuytV/3J+edTGxD7FH12qKN+TIHPaJb1PLNGstQ/tXSgA1WIMuhL1HfBHj1xyASqh8OaKmAqdcRd1wAwrYPvvDULOkSUIslO2zhKiQGo3JCP2yinejiQrzTZJZM11DKpAqC68oSMXwvvCPffk03VgsoRBoJb/vq5dMmK/S4v3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780127451; c=relaxed/simple;
	bh=R7nQoxTl303r8AJmiK0qOoPGvJ4RhTGoGQyfhIokHxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ea3otocSJMWgQJj9P0aSyu6gnWnDeCFgaiEQt3w5m2vWzUTslznUMP5XAWU6MNoqXpVvnKZE3GNLr+mGcK67U1RzXUoWdmzVxprYLIkWg7WR9W5Oqnad4gwDGX0WIx7WovVDAyOnLwJpq9ETl35vHsUzPc/mkxyq0UeZGFmOAR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjC2ZmdN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjC2ZmdN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A811F00898;
	Sat, 30 May 2026 07:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780127450;
	bh=7gemWASG8spRb7VwBUFZraypj2I/Q1VoEgsjVnCwK4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FjC2ZmdNDv8J4sDv3ttoZ+pzLNJ1dn6ZXjbgamQf4xPIwPWvfiKtGvjhis2p/Q5MH
	 KAAikY1QYSS0nBSPSISuxk+ldZC+zZ3bfCQ2H4iJ4V0AibtjD5ZnzgjWsWHb1QUJ3Y
	 eeO2XefE8bFlPxJG7kwgVTrZZuouRr+XZHQZRz+speJm4GZGA3d5dv86niglumfpLt
	 iReScGaxIwpq6AfuaN3ZbfTrX00xvZ16GssIEzPwZbr7ejB07oWcHH/0NZeD0CNtRy
	 S91DfSFz0l218BxwDL8sTSvterWV4kUaSaz6dJovpV+hCyIL/XhKX9rCMCJ7+lGXUy
	 qm7Ba3sP5CvoA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 5/5] tcp: fix ULP diag race by RCU read locks properly
Date: Sat, 30 May 2026 15:50:11 +0800
Message-ID: <9c48fe51896f77bb03aca1c3511d88f85bb99736.1780127277.git.tanggeliang@kylinos.cn>
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

Protect icsk->icsk_ulp_ops access in TCP diag with RCU read lock and
rcu_dereference(). Use smp_store_release() when clearing the pointer
in tcp_cleanup_ulp() to pair with readers, preventing use-after-free
when a socket is aborted concurrently with a diag dump.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/ipv4/tcp_diag.c | 15 ++++++++-------
 net/ipv4/tcp_ulp.c  | 14 ++++++++------
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
index ba1fdbe9807f..6580bb8d190a 100644
--- a/net/ipv4/tcp_diag.c
+++ b/net/ipv4/tcp_diag.c
@@ -133,14 +133,13 @@ static int tcp_diag_get_aux(struct sock *sk, bool net_admin,
 	}
 #endif
 
-	ulp_ops = icsk->icsk_ulp_ops;
-	if (ulp_ops) {
+	rcu_read_lock();
+	ulp_ops = rcu_dereference(icsk->icsk_ulp_ops);
+	if (ulp_ops)
 		err = tcp_diag_put_ulp(skb, sk, ulp_ops, net_admin);
-		if (err < 0)
-			return err;
-	}
+	rcu_read_unlock();
 
-	return 0;
+	return err;
 }
 
 static size_t tcp_diag_get_aux_size(struct sock *sk, bool net_admin)
@@ -169,13 +168,15 @@ static size_t tcp_diag_get_aux_size(struct sock *sk, bool net_admin)
 	if (sk_fullsock(sk)) {
 		const struct tcp_ulp_ops *ulp_ops;
 
-		ulp_ops = icsk->icsk_ulp_ops;
+		rcu_read_lock();
+		ulp_ops = rcu_dereference(icsk->icsk_ulp_ops);
 		if (ulp_ops) {
 			size += nla_total_size(0) +
 				nla_total_size(TCP_ULP_NAME_MAX);
 			if (ulp_ops->get_info_size)
 				size += ulp_ops->get_info_size(sk, net_admin);
 		}
+		rcu_read_unlock();
 	}
 
 	return size
diff --git a/net/ipv4/tcp_ulp.c b/net/ipv4/tcp_ulp.c
index 2aa442128630..aa7fed4ffff2 100644
--- a/net/ipv4/tcp_ulp.c
+++ b/net/ipv4/tcp_ulp.c
@@ -112,19 +112,21 @@ void tcp_update_ulp(struct sock *sk, struct proto *proto,
 void tcp_cleanup_ulp(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
+	const struct tcp_ulp_ops *ulp_ops;
 
 	/* No sock_owned_by_me() check here as at the time the
 	 * stack calls this function, the socket is dead and
 	 * about to be destroyed.
 	 */
-	if (!icsk->icsk_ulp_ops)
+	ulp_ops = icsk->icsk_ulp_ops;
+	if (!ulp_ops)
 		return;
 
-	if (icsk->icsk_ulp_ops->release)
-		icsk->icsk_ulp_ops->release(sk);
-	module_put(icsk->icsk_ulp_ops->owner);
-
-	icsk->icsk_ulp_ops = NULL;
+	if (ulp_ops->release)
+		ulp_ops->release(sk);
+	/* Pairs with rcu_dereference() in tcp_diag readers. */
+	smp_store_release(&icsk->icsk_ulp_ops, NULL);
+	module_put(ulp_ops->owner);
 }
 
 static int __tcp_set_ulp(struct sock *sk, const struct tcp_ulp_ops *ulp_ops)
-- 
2.53.0

