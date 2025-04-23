Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326432701B1
	for <mptcp@lists.linux.dev>; Wed, 23 Apr 2025 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745401253; cv=none; b=ewOx48mYrvndCrLUPs6n4ZnHXguFgd5S9TL6zPwRrsQaNAlqZ8S9rHPqxzNBCD0ppNryJgNGPEsHq4iW4vhkpXankIQdhTSSHrZJ4BdiHsGj8tLzpWgjhDl3Ep7Ck4gui02g9sp7sI7RSPEdF53fJnAd649ck8UhnMtV+sBMgAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745401253; c=relaxed/simple;
	bh=MhAHx5bVmBey5XvXe90ZD+YCTc0dE13hi9qKwowki4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcgfJXzHeLUgHvGLNkE7GlgBa6GTUQt//tAr4F8KQge3WJq1heCftWA8E5ZCYLVnOcNKyLloydd1ZOlU3q2zjqFchPCHnJ3qni3WwGJNWs0nouXFGaw8VVtJlCmF0KLRPimoZhC2QGTmboS4Cg2ZjKs/klqeWSme1bSfoi6vHUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJdZNcDK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJdZNcDK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F3AC4CEE2;
	Wed, 23 Apr 2025 09:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745401251;
	bh=MhAHx5bVmBey5XvXe90ZD+YCTc0dE13hi9qKwowki4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GJdZNcDKQ1zmnop1OStxOcEXmoMZCb5SPU9BSBNDczDSMhVM0sHmGtANhSYDk89Fh
	 y7Oi2AdRw9go9D8lox9ipF9dokxSNa6ILOdgul0F82b+6+11APWsxZLV+xPyv2rUHd
	 WqnxRfZxeeO4zK89zeH/qlfYwXE+lgRPsfk2VOR4JmznPDaL26EmyId3ZHjnnajtbF
	 hnDe9fvQEKS8xbSLjQST+s7FXyXUB1ebbX6xfhfvRWCqaBFt+anAAoQ4Aklu36+kP/
	 Ow4+jD1fnNXnVj27UHsfTEtlxJ5tgoLOI7jbg672bpRbwu1gyzB/Ol6Jbzo95jn9yo
	 HWf3bxabFnOVw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/3] tcp: add tcp_sock_set_maxseg
Date: Wed, 23 Apr 2025 17:40:40 +0800
Message-ID: <e23dcab208b4fd8208c9d3f43e69dbc091455917.1745401025.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745401025.git.tanggeliang@kylinos.cn>
References: <cover.1745401025.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add a helper tcp_sock_set_maxseg() to directly set the TCP_MAXSEG sockopt
from kernel space.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/linux/tcp.h |  1 +
 net/ipv4/tcp.c      | 24 +++++++++++++++---------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 1669d95bb0f9..0041bc0aaee9 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -623,6 +623,7 @@ void tcp_sock_set_nodelay(struct sock *sk);
 void tcp_sock_set_quickack(struct sock *sk, int val);
 int tcp_sock_set_syncnt(struct sock *sk, int val);
 int tcp_sock_set_user_timeout(struct sock *sk, int val);
+int tcp_sock_set_maxseg(struct sock *sk, int val);
 
 static inline bool dst_tcp_usec_ts(const struct dst_entry *dst)
 {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 4516f93f6cd2..402f4a9b3fd1 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3725,6 +3725,20 @@ int tcp_set_window_clamp(struct sock *sk, int val)
 	return 0;
 }
 
+int tcp_sock_set_maxseg(struct sock *sk, int val)
+{
+	/* Values greater than interface MTU won't take effect. However
+	 * at the point when this call is done we typically don't yet
+	 * know which interface is going to be used
+	 */
+	if (val && (val < TCP_MIN_MSS || val > MAX_TCP_WINDOW))
+		return -EINVAL;
+
+	tcp_sk(sk)->rx_opt.user_mss = val;
+	return 0;
+}
+EXPORT_SYMBOL(tcp_sock_set_maxseg);
+
 /*
  *	Socket option code for TCP.
  */
@@ -3857,15 +3871,7 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 
 	switch (optname) {
 	case TCP_MAXSEG:
-		/* Values greater than interface MTU won't take effect. However
-		 * at the point when this call is done we typically don't yet
-		 * know which interface is going to be used
-		 */
-		if (val && (val < TCP_MIN_MSS || val > MAX_TCP_WINDOW)) {
-			err = -EINVAL;
-			break;
-		}
-		tp->rx_opt.user_mss = val;
+		tcp_sock_set_maxseg(sk, val);
 		break;
 
 	case TCP_NODELAY:
-- 
2.43.0

