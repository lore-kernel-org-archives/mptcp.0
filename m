Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C5222370C
	for <mptcp@lists.linux.dev>; Wed, 30 Apr 2025 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746004401; cv=none; b=o5sxiEF8oqsLDPqQhcVad5/5yBcnG5EdXx+3+nZVGOBqy4IzuphSlv/Joc1kcjgTXnJYIXFOzRUGUJJ5jCqwN1KchBa4ieWgjc2iFR0QDe+tarAbsAjEY0Q9Ijbe99MLz7f2PwUdaTJfRhsSWJ3BFZHttBHzBFw85kY86woH5XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746004401; c=relaxed/simple;
	bh=OmOhUxZtqhwMSt0luOyqnu39wbBsIjp6sbRu0TL6eaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eTm+sidlwjkwdtpBDTHccCyBprDSj1LCdoWwK0rW0sH7nnQAr9fAZvDx8WvWD7dZb0G+fP3v/zkdRYWUByZSUESjkyN5pUVFLpT9D8tBhNfXm1gx4rC9e4Bsu+Y9mL6NWOxVTVCXNwb8RnY61s/2NvqUO6fMfLb+g59CUtPjQS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0I4tDYd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0I4tDYd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D85C4CEE9;
	Wed, 30 Apr 2025 09:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746004400;
	bh=OmOhUxZtqhwMSt0luOyqnu39wbBsIjp6sbRu0TL6eaI=;
	h=From:To:Cc:Subject:Date:From;
	b=Q0I4tDYdlwv7jxBGV8yB6jAA+D7E1UyNBcuhY9+arHtaAGlh/qHTHhedgETOpO0h1
	 2DXtItbxJ+OSFHLlTOSVL93dhshxIql1ktXpsP2Sqe9moy7NKw7+0dfvTox+W2xRDK
	 km9wZPYdg4fEbjXIdVsGH/JiMHsbopVETDBtrLK0ozu7/xszD7Mlfd0C6FPVdIYNIg
	 BgSo84+MewIT64CUIUNpgkk0RYF57vSJcXH1j9QE5njCXmHxlEz/wahYh784bmr/Fz
	 Y2iZCHjZtNzR4//LiWbZckJ0gA8fLeJ+UIzpcJDRzWu3oQGi2Z6NPqzH/mRGtRzGxl
	 RHzPOGcKM0Jug==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next] sock: add sock_krfree_s helper
Date: Wed, 30 Apr 2025 17:09:15 +0800
Message-ID: <ffe72ff201ea72938b136eb37ea3e0777ae890f4.1746004135.git.geliang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds the rcu version of sock_kfree_s() helper, named
sock_krfree_s(), to free the memory using kfree_rcu_mightsleep()
and adjust the socket's option memory buffer.

This new helper is first used in MPTCP.

Signed-off-by: Geliang Tang <geliang@kernel.org>
---
 include/net/sock.h       |  1 +
 net/core/sock.c          | 14 +++++++++++---
 net/mptcp/pm_userspace.c |  3 +--
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index e223102337c7..94f72f5c8754 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1836,6 +1836,7 @@ void *sock_kmemdup(struct sock *sk, const void *src,
 		   int size, gfp_t priority);
 void sock_kfree_s(struct sock *sk, void *mem, int size);
 void sock_kzfree_s(struct sock *sk, void *mem, int size);
+void sock_krfree_s(struct sock *sk, void *mem, int size);
 void sk_send_sigurg(struct sock *sk);
 
 static inline void sock_replace_proto(struct sock *sk, struct proto *proto)
diff --git a/net/core/sock.c b/net/core/sock.c
index b64df2463300..f9ee0b44ab2a 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2862,12 +2862,14 @@ EXPORT_SYMBOL(sock_kmemdup);
  * condition entirely.
  */
 static inline void __sock_kfree_s(struct sock *sk, void *mem, int size,
-				  const bool nullify)
+				  const bool nullify, const bool rcu)
 {
 	if (WARN_ON_ONCE(!mem))
 		return;
 	if (nullify)
 		kfree_sensitive(mem);
+	else if (rcu)
+		kfree_rcu_mightsleep(mem);
 	else
 		kfree(mem);
 	atomic_sub(size, &sk->sk_omem_alloc);
@@ -2875,16 +2877,22 @@ static inline void __sock_kfree_s(struct sock *sk, void *mem, int size,
 
 void sock_kfree_s(struct sock *sk, void *mem, int size)
 {
-	__sock_kfree_s(sk, mem, size, false);
+	__sock_kfree_s(sk, mem, size, false, false);
 }
 EXPORT_SYMBOL(sock_kfree_s);
 
 void sock_kzfree_s(struct sock *sk, void *mem, int size)
 {
-	__sock_kfree_s(sk, mem, size, true);
+	__sock_kfree_s(sk, mem, size, true, false);
 }
 EXPORT_SYMBOL(sock_kzfree_s);
 
+void sock_krfree_s(struct sock *sk, void *mem, int size)
+{
+	__sock_kfree_s(sk, mem, size, false, true);
+}
+EXPORT_SYMBOL(sock_krfree_s);
+
 /* It is almost wait_for_tcp_memory minus release_sock/lock_sock.
    I think, these locks should be removed for datagram sockets.
  */
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 1911fe1799fa..60ddf4889c51 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -337,11 +337,10 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	release_sock(sk);
 
-	kfree_rcu_mightsleep(match);
 	/* Adjust sk_omem_alloc like sock_kfree_s() does, to match
 	 * with allocation of this memory by sock_kmemdup()
 	 */
-	atomic_sub(sizeof(*match), &sk->sk_omem_alloc);
+	sock_krfree_s(sk, match, sizeof(*match));
 
 	err = 0;
 out:
-- 
2.43.0

