Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6374839FCD1
	for <mptcp@lists.linux.dev>; Fri,  3 Apr 2026 14:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775227977; cv=none; b=HpfONJdZZagY74UMlqxaZjP8a2qgAdPDVf3wP7SXzuCQVpPDqZe7H+5qCx8pk9ot0iYzJ8pec0u3UgOCRP3jWy76UCrmr8JYjzHKgQryWAA37cHoEkMqsQrvRWzhMxCmudg7fbesvlqPL3IAub/gK6XWwFN6QTlksbyCgvOjEYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775227977; c=relaxed/simple;
	bh=BDYMd/3BoKsa2+jGZVE+d4xGft9Yo7RJsCIgC4AOSz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUI8CMneBsmIqH4Jx9yQx7FXMEaCMKg65ts6RDKdCZM4t3PzexITnNNbO3WADgHdRC9Jyocos8ABZTEYqoxcskCUCDdbBcq2rG91VQ5N5C9BhvR4OhR5G/TMJheRoLNaVmf9uPniM3lMllnWZhX/Y15sA+LM/ojt9IFwEci+17w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIw4+PnO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIw4+PnO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36C3C4CEF7;
	Fri,  3 Apr 2026 14:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775227977;
	bh=BDYMd/3BoKsa2+jGZVE+d4xGft9Yo7RJsCIgC4AOSz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sIw4+PnOnFFunJDj/q8mquXzCYMTht9K6fx+4rLe9P5upcrwVdhuyYmIOF03RDL83
	 4Hqan6z93hdn7eSleV9/TLLBe2KN7gt7xColfBpqWPDKLdUkVPotMVBbZwzgsVE+3Y
	 e/EOHpeEVELmBAJ4323Ym/GwpqlArw0eGVwUP8vt6emjEFuK5hXSr0BLsxWlmeEdqI
	 PSTEaqbbxtyydJdRoMnLcepCnAnr752c0xCFq1V6CMgJaLeqyXnJXJKrMGXUxFsdkP
	 /cJBhW/5gDIsIs9q2qp2vatGI33m3YgrOEYbo1WcMJN7v6UWEhwWFxB6A2sXXpyhlv
	 Z0Clj6XIfHhcw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v13 08/16] mptcp: update ulp getsockopt for tls support
Date: Fri,  3 Apr 2026 22:51:26 +0800
Message-ID: <2397ce16fd58e538885a0a8c4fbba93c56ff483a.1775227717.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775227717.git.tanggeliang@kylinos.cn>
References: <cover.1775227717.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch extracts TCP_ULP getsockopt operation into a tcp_sock_get_ulp()
helper so that it can also be used in MPTCP.

TCP_ULP was obtained by calling mptcp_getsockopt_first_sf_only() to get
ULP of the first subflow. Now that the mechanism has changed, a new helper
mptcp_getsockopt_tcp_ulp() is added to get ULP of msk.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/linux/tcp.h |  1 +
 net/ipv4/tcp.c      | 36 ++++++++++++++++++++++--------------
 net/mptcp/sockopt.c | 12 ++++++++++++
 3 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 6982f10e826b..2bb1cbd3eeab 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -653,6 +653,7 @@ void tcp_sock_set_quickack(struct sock *sk, int val);
 int tcp_sock_set_syncnt(struct sock *sk, int val);
 int tcp_sock_set_user_timeout(struct sock *sk, int val);
 int tcp_sock_set_maxseg(struct sock *sk, int val);
+int tcp_sock_get_ulp(struct sock *sk, sockptr_t optval, sockptr_t optlen);
 
 static inline bool dst_tcp_usec_ts(const struct dst_entry *dst)
 {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 4b8cf7ca2695..c3c6cd6ee95a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4473,6 +4473,27 @@ struct sk_buff *tcp_get_timestamping_opt_stats(const struct sock *sk,
 	return stats;
 }
 
+int tcp_sock_get_ulp(struct sock *sk, sockptr_t optval, sockptr_t optlen)
+{
+	struct inet_connection_sock *icsk = inet_csk(sk);
+	int len;
+
+	if (copy_from_sockptr(&len, optlen, sizeof(int)))
+		return -EFAULT;
+	len = min_t(unsigned int, len, TCP_ULP_NAME_MAX);
+	if (!icsk->icsk_ulp_ops) {
+		len = 0;
+		if (copy_to_sockptr(optlen, &len, sizeof(int)))
+			return -EFAULT;
+		return 0;
+	}
+	if (copy_to_sockptr(optlen, &len, sizeof(int)))
+		return -EFAULT;
+	if (copy_to_sockptr(optval, icsk->icsk_ulp_ops->name, len))
+		return -EFAULT;
+	return 0;
+}
+
 int do_tcp_getsockopt(struct sock *sk, int level,
 		      int optname, sockptr_t optval, sockptr_t optlen)
 {
@@ -4582,20 +4603,7 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		return 0;
 
 	case TCP_ULP:
-		if (copy_from_sockptr(&len, optlen, sizeof(int)))
-			return -EFAULT;
-		len = min_t(unsigned int, len, TCP_ULP_NAME_MAX);
-		if (!icsk->icsk_ulp_ops) {
-			len = 0;
-			if (copy_to_sockptr(optlen, &len, sizeof(int)))
-				return -EFAULT;
-			return 0;
-		}
-		if (copy_to_sockptr(optlen, &len, sizeof(int)))
-			return -EFAULT;
-		if (copy_to_sockptr(optval, icsk->icsk_ulp_ops->name, len))
-			return -EFAULT;
-		return 0;
+		return tcp_sock_get_ulp(sk, optval, optlen);
 
 	case TCP_FASTOPEN_KEY: {
 		u64 key[TCP_FASTOPEN_KEY_BUF_LENGTH / sizeof(u64)];
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index de90a2897d2d..a6230f7910fd 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1393,6 +1393,17 @@ static int mptcp_put_int_option(struct mptcp_sock *msk, char __user *optval,
 	return 0;
 }
 
+static int mptcp_getsockopt_tcp_ulp(struct sock *sk, char __user *optval,
+				    int __user *optlen)
+{
+	int ret;
+
+	lock_sock(sk);
+	ret = tcp_sock_get_ulp(sk, USER_SOCKPTR(optval), USER_SOCKPTR(optlen));
+	release_sock(sk);
+	return ret;
+}
+
 static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    char __user *optval, int __user *optlen)
 {
@@ -1400,6 +1411,7 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 
 	switch (optname) {
 	case TCP_ULP:
+		return mptcp_getsockopt_tcp_ulp(sk, optval, optlen);
 	case TCP_CONGESTION:
 	case TCP_INFO:
 	case TCP_CC_INFO:
-- 
2.51.0

