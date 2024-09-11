Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62743C144
	for <mptcp@lists.linux.dev>; Wed, 11 Sep 2024 04:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726028697; cv=none; b=L9qWdgyHMsbjhRBGrXj3CPLYJsL6AGDymYq0vTEUUkm1GUlTyAXUcZZ+ro/hNUSj1rm59Nq9Nm4Tf4+Q24tDyFs9Enx1twzSPgfh12fVXXkq71ZzBmwhdyxlLJ3ksTCZ7GT7ASCyAcXk2MP+2WJgY900L+KLEVbemeIRaKoFXl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726028697; c=relaxed/simple;
	bh=bFfQhdyy/lAHVsNw0R0P1gBGvfhURaOjSutyLPj61Bw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ush9+HQv9m9W6fgiDQnJAKnySPY0V9aN4ppyVgnoM/CFPvd84vHQyhX7qrPqQXwQGETbhnWxOhuySrhFLH9M6rvbd88vqxh+CkxpH9dtv0mYky6FSbO7jeiLCQjEPm1GUGUnK/8tQoN5aGd2vsw6o2bGwkwoyOkONStuM0PET0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHjLqF1P; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHjLqF1P"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20551e2f1f8so63116105ad.2
        for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 21:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726028694; x=1726633494; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mij1LP46FkQxBnJLG+loXzR2Zu11pDZfgnHgMpyb6h4=;
        b=lHjLqF1P4XtcCgET9g/tv4IhVzzxjG+u1Q/UtcfZ0Ie/axoVwr5+zhk92LVrY+09xK
         cGFGwNUSGFI7838yuqWQFTMsqYA+jrL6mzc8KbyG+52sbGYW1pSC2MWobWs3y+Rm9Xwp
         t+uwUMN18oFbsn4/rz8Bk281nOJ4WDBvrAzltMKEgTPoHcu0sXmPstdDSS6Q+XdSr+nX
         LbV7o9ytlEZzq0Z1PpLW8SO2flLb5ebYltqkUZ6V6Ie5IFLbYyB9yjH+sF4v5YsKeaeM
         +cMNiJS0xIn61Xk8wU9en020AGDKm1tqeDwgoT5OxZ0TX/ebdBZRRBcx5fwaac2kElLS
         0niA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726028694; x=1726633494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mij1LP46FkQxBnJLG+loXzR2Zu11pDZfgnHgMpyb6h4=;
        b=q+eQiGytdgR2EF6LSne3JQnF7llqsBkLySm46fEb1J0IediqSdW966Wjx6T0ngPOPS
         ZPdJG7BR5j1NGWIoxkHHgLlECtbDR4PeFn5m5x58bWMOuq6gnm6XbskTS9Lo2/uAL49D
         OaAiB/+FjQAAEkjHtORphd3ssHX1gMpPWMuCELmup7KZsvKRub+ig8yZFUEp3nUKOK2N
         yYS3YZorihnjejSzTIG81dVk+g70LN1JxS/JVwG7zenvPYdRlYMXyVqt9+CfQwJG7eXQ
         Rv1c/CE8YJeeYX8GZFmNfoNvv8sZXzfh6atZhYzrGbFCwgZV0oIe92UNlNYKIJcloOsB
         1mWg==
X-Gm-Message-State: AOJu0YwchLUNXcrY8VBnPrvISJ9CD6IE5eA13SgelyDSf3s4ecCHlMRu
	dAMxYWeXqZhpZzgyPF/63OCSx0YLvqgxcmheTX03CSH1rraBbHc3QHKpkX1F
X-Google-Smtp-Source: AGHT+IFRBeojOKxKwnoXNxy+l8eG4PLCzcuyJhIxuMODi48y7tm7RKrcV0BzuY2oSYn5M0bzqqdMLA==
X-Received: by 2002:a17:902:e550:b0:1fd:5fa0:e98f with SMTP id d9443c01a7336-2074c710115mr47589705ad.44.1726028694252;
        Tue, 10 Sep 2024 21:24:54 -0700 (PDT)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:7cb4:335c:8e84:436f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d8241bf55dsm5492192a12.49.2024.09.10.21.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 21:24:53 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: mptcp@lists.linux.dev
Cc: Cong Wang <cong.wang@bytedance.com>,
	syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Subject: [Patch net v2] mptcp: initialize sock lock with its own lockdep keys
Date: Tue, 10 Sep 2024 21:24:25 -0700
Message-Id: <20240911042425.978665-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

In mptcp_pm_nl_create_listen_socket(), we already initialize mptcp sock
lock with mptcp_slock_keys and mptcp_keys. But that is not sufficient,
at least mptcp_init_sock() and mptcp_sk_clone_init() still miss it.

As reported by syzbot, mptcp_sk_clone_init() is challenging due to that
sk_clone_lock() immediately locks the new sock after preliminary
initialization. To amend that, introduce ->init_clone() for struct proto
and call it right after the sock_lock_init(), so now mptcp sock could
initialize the sock lock again with its own lockdep keys.

This patch does not fix any real deadlock, it only makes lockdep happy.

Fixes: 58b09919626b ("mptcp: create msk early")
Reported-by: syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f4aacdfef2c6a6529c3e
Cc: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
v2: Address Matthieu's comments

 include/net/sock.h     |  1 +
 net/core/sock.c        |  2 ++
 net/mptcp/pm_netlink.c | 16 +---------------
 net/mptcp/protocol.c   | 22 ++++++++++++++++++++++
 net/mptcp/protocol.h   |  1 +
 5 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index cce23ac4d514..7032009c0a94 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1226,6 +1226,7 @@ struct proto {
 	int			(*ioctl)(struct sock *sk, int cmd,
 					 int *karg);
 	int			(*init)(struct sock *sk);
+	void			(*init_clone)(struct sock *sk);
 	void			(*destroy)(struct sock *sk);
 	void			(*shutdown)(struct sock *sk, int how);
 	int			(*setsockopt)(struct sock *sk, int level,
diff --git a/net/core/sock.c b/net/core/sock.c
index 9abc4fe25953..747d7e479d69 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2325,6 +2325,8 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 	}
 	sk_node_init(&newsk->sk_node);
 	sock_lock_init(newsk);
+	if (prot->init_clone)
+		prot->init_clone(newsk);
 	bh_lock_sock(newsk);
 	newsk->sk_backlog.head	= newsk->sk_backlog.tail = NULL;
 	newsk->sk_backlog.len = 0;
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f891bc714668..0a89449d45f3 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1049,13 +1049,9 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 	return ret;
 }
 
-static struct lock_class_key mptcp_slock_keys[2];
-static struct lock_class_key mptcp_keys[2];
-
 static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 					    struct mptcp_pm_addr_entry *entry)
 {
-	bool is_ipv6 = sk->sk_family == AF_INET6;
 	int addrlen = sizeof(struct sockaddr_in);
 	struct sockaddr_storage addr;
 	struct sock *newsk, *ssk;
@@ -1071,17 +1067,7 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
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
+	mptcp_sock_lock_init(newsk);
 
 	lock_sock(newsk);
 	ssk = __mptcp_nmpc_sk(mptcp_sk(newsk));
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 37ebcb7640eb..8190618d2771 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2839,6 +2839,7 @@ static int mptcp_init_sock(struct sock *sk)
 	int ret;
 
 	__mptcp_init_sock(sk);
+	mptcp_sock_lock_init(sk);
 
 	if (!mptcp_is_enabled(net))
 		return -ENOPROTOOPT;
@@ -2865,6 +2866,26 @@ static int mptcp_init_sock(struct sock *sk)
 	return 0;
 }
 
+static struct lock_class_key mptcp_slock_keys[2];
+static struct lock_class_key mptcp_keys[2];
+
+void mptcp_sock_lock_init(struct sock *sk)
+{
+	bool is_ipv6 = sk->sk_family == AF_INET6;
+
+	/* The subflow socket lock is acquired in a nested to the msk one
+	 * in several places, even by the TCP stack, and this msk is a kernel
+	 * socket: lockdep complains. Instead of propagating the _nested
+	 * modifiers in several places, re-init the lock class for the msk
+	 * socket to an mptcp specific one.
+	 */
+	sock_lock_init_class_and_name(sk,
+				      is_ipv6 ? "mlock-AF_INET6" : "mlock-AF_INET",
+				      &mptcp_slock_keys[is_ipv6],
+				      is_ipv6 ? "msk_lock-AF_INET6" : "msk_lock-AF_INET",
+				      &mptcp_keys[is_ipv6]);
+}
+
 static void __mptcp_clear_xmit(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -3801,6 +3822,7 @@ static struct proto mptcp_prot = {
 	.name		= "MPTCP",
 	.owner		= THIS_MODULE,
 	.init		= mptcp_init_sock,
+	.init_clone	= mptcp_sock_lock_init,
 	.connect	= mptcp_connect,
 	.disconnect	= mptcp_disconnect,
 	.close		= mptcp_close,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3b22313d1b86..44c2ca04132f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -795,6 +795,7 @@ void __init mptcp_proto_init(void);
 int __init mptcp_proto_v6_init(void);
 #endif
 
+void mptcp_sock_lock_init(struct sock *sk);
 struct sock *mptcp_sk_clone_init(const struct sock *sk,
 				 const struct mptcp_options_received *mp_opt,
 				 struct sock *ssk,
-- 
2.34.1

