Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142D7248F47
	for <mptcp@lists.linux.dev>; Sun,  4 Jan 2026 09:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767519329; cv=none; b=izHValyUoHNDXFohPVZxeavV9QWOqe2rNXsvR8DW+L6KRORCsgJG5Euspz6OU3785prpbkyvMqjRVUWy8MT4dQsN6E1yysELLmfYe2TZ4F9PRyIir/9xaNatlnCf3sLByV2VqOe2pzrf01ceVkx1te9G6zsKzWgBa08LxPNnqcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767519329; c=relaxed/simple;
	bh=EHZH+pSQqIMFf7gQSg0qm/9xfnNosjk+CcxMt4kMvT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HU7WV6pgdTm22m+yWD06kfm3i1iATMyN81WzFR3XiVLWXGNfLqLl8LSlSWqantTwsOJkqrIWhzVHDOAj4iQGZ1Hw+TTQwJpWSyRINEWUhV8kV/AWHwJn/ANvcoyzujZzbm+o8AWUQqnY+9cFAKdmMBuoKH8bOfCHcl0hiEgjJOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/lOVSEr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/lOVSEr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27276C4CEF7;
	Sun,  4 Jan 2026 09:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767519328;
	bh=EHZH+pSQqIMFf7gQSg0qm/9xfnNosjk+CcxMt4kMvT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T/lOVSEryFWqVPoJysX4nBsNQ1Ej30S6FQ5K9/F69lHoSH0ox6gcY55aq8KSQQW9U
	 SipRGSusuYCz3gUPiIKvCffz/dNlsM9znuzs/me79PHPBX6G4WoIxNbDcSz97/GYC4
	 v0ZC9Pzzm/TuCcSrwbN0/LtG//O0cs9V01AdHSopKHwfI+91qu1HceNxJUTuJZMgaa
	 +xutS6jOEpCDjASfTWcVBfh4+S7bgdwjwGkKlZSIJdnKlbdgZ+thR6V51GRHxXErrq
	 scqaDaXEqM3/9Iig11v44zBcm2DwygYyi2Uqw2sKU24Y+rr+a7IzjVJr9fCiYF1DOf
	 jP6DjqhC9FoFg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v6 06/10] tcp: extract sock_set_ulp helper
Date: Sun,  4 Jan 2026 17:35:07 +0800
Message-ID: <4542d190db86f7e3069d0b17cad1ae5afebf28a2.1767518836.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1767518836.git.tanggeliang@kylinos.cn>
References: <cover.1767518836.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Extract the TCP_ULP setsockopt operation into a tcp_sock_set_ulp() helper
so that it can also be used in MPTCP.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/linux/tcp.h |  1 +
 net/ipv4/tcp.c      | 42 ++++++++++++++++++++++++------------------
 2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 6f0becc26402..46b83895908c 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -645,6 +645,7 @@ int tcp_sock_set_syncnt(struct sock *sk, int val);
 int tcp_sock_set_user_timeout(struct sock *sk, int val);
 int tcp_sock_set_maxseg(struct sock *sk, int val);
 int tcp_sock_get_ulp(struct sock *sk, sockptr_t optval, sockptr_t optlen);
+int tcp_sock_set_ulp(struct sock *sk, sockptr_t optval, unsigned int optlen);
 
 static inline bool dst_tcp_usec_ts(const struct dst_entry *dst)
 {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 1ba5794574c7..1ad7e5ed6f25 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3809,6 +3809,28 @@ int tcp_sock_set_maxseg(struct sock *sk, int val)
 	return 0;
 }
 
+int tcp_sock_set_ulp(struct sock *sk, sockptr_t optval, unsigned int optlen)
+{
+	char name[TCP_ULP_NAME_MAX];
+	int err = 0;
+	size_t len;
+	int val;
+
+	if (optlen < 1)
+		return -EINVAL;
+
+	len = min_t(long, TCP_ULP_NAME_MAX - 1, optlen);
+	val = strncpy_from_sockptr(name, optval, len);
+	if (val < 0)
+		return -EFAULT;
+	name[val] = 0;
+
+	sockopt_lock_sock(sk);
+	err = tcp_set_ulp(sk, name);
+	sockopt_release_sock(sk);
+	return err;
+}
+
 /*
  *	Socket option code for TCP.
  */
@@ -3842,24 +3864,8 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		sockopt_release_sock(sk);
 		return err;
 	}
-	case TCP_ULP: {
-		char name[TCP_ULP_NAME_MAX];
-
-		if (optlen < 1)
-			return -EINVAL;
-
-		val = strncpy_from_sockptr(name, optval,
-					min_t(long, TCP_ULP_NAME_MAX - 1,
-					      optlen));
-		if (val < 0)
-			return -EFAULT;
-		name[val] = 0;
-
-		sockopt_lock_sock(sk);
-		err = tcp_set_ulp(sk, name);
-		sockopt_release_sock(sk);
-		return err;
-	}
+	case TCP_ULP:
+		return tcp_sock_set_ulp(sk, optval, optlen);
 	case TCP_FASTOPEN_KEY: {
 		__u8 key[TCP_FASTOPEN_KEY_BUF_LENGTH];
 		__u8 *backup_key = NULL;
-- 
2.51.0

