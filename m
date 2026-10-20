Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792470893;
	b=Nh6IXvaPoJgTdiNxF+9gHu9/CrvUEONrDgqKY9qSAw0ltdJ+1s5FGeX2Xoo5vkODtLdE
	 1VFwEEc1nB/0KtAGeybFfhsTXY+VF+6nK3be90zncHFpon5KV09xzthJAy9R22mWivJEQ
	 I0R9Y3zS3nJqdj+zGOWjYYmh9H/at9jyVB6tdfL/8mi6Iavl3gmZ0wo3jyAtPOzV0HI6V
	 F8alNq3jg6hgrZy8zzCoCsF2guAfYlE5yrf4ftM9DQGQ8DE8yP5C6UMZPhVsgdQiAgBp5
	 BDVQ2eMoBxech0NBOe7QaYx77PAN8HpL1tAVRtx/iWR1QPvxMvWDdgxBZtjRAWdLDCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792470893;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LRRz31708bq10sSxxjIZ5AB8L5mEs3+DQCtoFC2f0Z4=;
	b=2Mlul6Vu3ktW1Ucnl8sXPK1k+5dEfRCzjPh2wnckWqo15EaarlPAm4fzVCcSB6L0foFL
	 fzXdgRKhzlbJAzAU0JY0Bae33mdBfUSYfiUffeRhm4n3ySr/CJQLiiOJ/N/R1RZpWBVyt
	 wQyz6x3XE2MKIGMP9N8ofWf0UB02+aldojDjZMsPSI1/umvuZXOIA8+OEc0J58oyNIPwx
	 VO8+acIFOJNRXT5RSYVMg55wSdNoS3IIfzCDucenOjvduQUU7fw5R7ob/mIxSw8oiQZ1T
	 ke9vnWTJjcqsTwhP+8VUWw0rX/fhvcACB4Kdl/+gzkohigVuH4wMOj7a5qUVDzke8MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hsPCHNnf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B39606A319
	for <mptcp@lists.linux.dev>; Tue, 20 Oct 2026 04:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hsPCHNnf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381AB1F000C5;
	Tue, 20 Oct 2026 04:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792470893;
	bh=LRRz31708bq10sSxxjIZ5AB8L5mEs3+DQCtoFC2f0Z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hsPCHNnfDCipHWsAaLCQrJyqZYCP2MZ4KoGAIFIQLLVQNB/r04OC61jk7gHYaSR5s
	 AWR83wBJ0aLHEuFxL5HqjoGxLzC8A3nbD8/pFZYbnohYkqBAd+oc52uHmxyK6dmlOz
	 bdxpeSEdox3gPrMgtR79td7CA+Ck1gzGHTr4JzKpVmP2mvDbj4EXBQyVfk6TY7Czap
	 B+1dXgq3AiWWeA6YExIIUdCFKfAQY37IW1jXhA79wrJamnk6nwCkWarHQQg21ADAax
	 hn9XWNdICJ7H7pphLiUhpw2kGUHK9W/44p7zfBYh6K3spvJT+gLyULs7yqgJZJ4VAm
	 3Am1z3yHwxlFw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 1/3] mptcp: give MPTCP sockets a distinct lockdep class
Date: Tue, 20 Oct 2026 12:34:43 +0800
Message-ID: <57a28e59a137afcf8a5dd8b220037cd753a61591.1792470313.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792470313.git.tanggeliang@kylinos.cn>
References: <cover.1792470313.git.tanggeliang@kylinos.cn>
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

