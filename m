Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E0A3C277F
	for <mptcp@lists.linux.dev>; Wed,  6 May 2026 10:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778063666; cv=none; b=LGJSmMvnlyVVC+GP4LVi/uYKWvOOzHBqgzrYDDKUoBZmQ7GGlsnu6dyD++VYI8S3S3YJevBl1uztunrYA7mViYTeoMRvMGyF21qDbS6HE6A1okodbhOjTUKSiKSWeXvePZF4KAUvE79iJ69OJgL8w3a8c66Nd5KlKwGAlpdN1jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778063666; c=relaxed/simple;
	bh=HTKzHKu77xOopIWy2SlztXmWjwz2LKAbTuxcagqL+VM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o9nyZT8jCv2NKiPCpQJYo3SsXRAsLuaDiXG+xPVej9y75xguFen1svuBxjChC1LuoyKBgGpaZVe39Tb5dhegdo8LR3XTNW099okkoJED2ERGGck2W/XsF6b19J7VcvJvQLjgKL3GWAAsPNi/chqgugQTLaug8JL3Hh27I+GT2gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=td2NGEkw; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="td2NGEkw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778063662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FmcaNR3XIftnFnCmmRr38PwDVgpvJOBmYJc3kxUeUOM=;
	b=td2NGEkwMve0Bgxk0QsZ500Ujpyj3fIhCEg+IheRUO3s0rI50x2oin9VSwuJ0m6HZMxfB3
	NyP50tqqZ++Z9Io2uhwWrAFm5jKs1FIllhWHGSKrzdNtSESuEBwVcvlA/UNDFYXRerc2+2
	xGFdQZMPTedUPgD2pDdM0WCiX+J4wjs=
From: Gang Yan <gang.yan@linux.dev>
Date: Wed, 06 May 2026 18:33:54 +0800
Subject: [PATCH mptcp-net v3 1/2] mptcp: use sockopt_lock(release)_sock in
 sockopt
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-sockopt_lock-v3-1-06bd417c6d63@kylinos.cn>
References: <20260506-sockopt_lock-v3-0-06bd417c6d63@kylinos.cn>
In-Reply-To: <20260506-sockopt_lock-v3-0-06bd417c6d63@kylinos.cn>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Gang Yan <yangang@kylinos.cn>
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

TCP and the core socket layer all use sockopt_lock_sock()
sockopt_release_sock() in their setsockopt and getsockopt handlers. It
is a BPF-aware wrapper that skips lock acquisition when invoked from a
BPF program, where the socket lock is already held.

Using lock_sock_fast() on subflows requires extra care: the fast path
holds the socket spinlock with BH disabled, creating an atomic context
where sleeping is not allowed.  Switching to sockopt_lock_sock()
avoids the risk of accidentally introducing sleeping operations inside
the lock_sock_fast() critical section.

Fixes: 24426654ed3a ("bpf: net: Avoid sk_setsockopt() taking sk lock when called from bpf")
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/sockopt.c | 121 ++++++++++++++++++++++++++--------------------------
 1 file changed, 60 insertions(+), 61 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 1cf608e7357b..552e07296b38 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -72,12 +72,12 @@ static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, in
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	sockopt_seq_inc(msk);
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		bool slow = lock_sock_fast(ssk);
+		sockopt_lock_sock(ssk);
 
 		switch (optname) {
 		case SO_DEBUG:
@@ -114,10 +114,10 @@ static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, in
 		}
 
 		subflow->setsockopt_seq = msk->setsockopt_seq;
-		unlock_sock_fast(ssk, slow);
+		sockopt_release_sock(ssk);
 	}
 
-	release_sock(sk);
+	sockopt_release_sock(sk);
 }
 
 static int mptcp_sol_socket_intval(struct mptcp_sock *msk, int optname, int val)
@@ -156,16 +156,16 @@ static int mptcp_setsockopt_sol_socket_tstamp(struct mptcp_sock *msk, int optnam
 	if (ret)
 		return ret;
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-		lock_sock(ssk);
+		sockopt_lock_sock(ssk);
 		sock_set_timestamp(ssk, optname, !!val);
-		release_sock(ssk);
+		sockopt_release_sock(ssk);
 	}
 
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	return 0;
 }
 
@@ -231,17 +231,17 @@ static int mptcp_setsockopt_sol_socket_timestamping(struct mptcp_sock *msk,
 	if (ret)
 		return ret;
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-		lock_sock(ssk);
+		sockopt_lock_sock(ssk);
 		sock_set_timestamping(ssk, optname, timestamping);
-		release_sock(ssk);
+		sockopt_release_sock(ssk);
 	}
 
-	release_sock(sk);
+	sockopt_release_sock(sk);
 
 	return 0;
 }
@@ -266,11 +266,11 @@ static int mptcp_setsockopt_sol_socket_linger(struct mptcp_sock *msk, sockptr_t
 	if (ret)
 		return ret;
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	sockopt_seq_inc(msk);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		bool slow = lock_sock_fast(ssk);
+		sockopt_lock_sock(ssk);
 
 		if (!ling.l_onoff) {
 			sock_reset_flag(ssk, SOCK_LINGER);
@@ -280,10 +280,10 @@ static int mptcp_setsockopt_sol_socket_linger(struct mptcp_sock *msk, sockptr_t
 		}
 
 		subflow->setsockopt_seq = msk->setsockopt_seq;
-		unlock_sock_fast(ssk, slow);
+		sockopt_release_sock(ssk);
 	}
 
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	return 0;
 }
 
@@ -299,10 +299,10 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	case SO_REUSEADDR:
 	case SO_BINDTODEVICE:
 	case SO_BINDTOIFINDEX:
-		lock_sock(sk);
+		sockopt_lock_sock(sk);
 		ssk = __mptcp_nmpc_sk(msk);
 		if (IS_ERR(ssk)) {
-			release_sock(sk);
+			sockopt_release_sock(sk);
 			return PTR_ERR(ssk);
 		}
 
@@ -317,7 +317,7 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 			else if (optname == SO_BINDTOIFINDEX)
 				sk->sk_bound_dev_if = ssk->sk_bound_dev_if;
 		}
-		release_sock(sk);
+		sockopt_release_sock(sk);
 		return ret;
 	case SO_KEEPALIVE:
 	case SO_PRIORITY:
@@ -395,16 +395,16 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 	case IPV6_V6ONLY:
 	case IPV6_TRANSPARENT:
 	case IPV6_FREEBIND:
-		lock_sock(sk);
+		sockopt_lock_sock(sk);
 		ssk = __mptcp_nmpc_sk(msk);
 		if (IS_ERR(ssk)) {
-			release_sock(sk);
+			sockopt_release_sock(sk);
 			return PTR_ERR(ssk);
 		}
 
 		ret = tcp_setsockopt(ssk, SOL_IPV6, optname, optval, optlen);
 		if (ret != 0) {
-			release_sock(sk);
+			sockopt_release_sock(sk);
 			return ret;
 		}
 
@@ -424,7 +424,7 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 			break;
 		}
 
-		release_sock(sk);
+		sockopt_release_sock(sk);
 		break;
 	}
 
@@ -601,24 +601,24 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
 	cap_net_admin = ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN);
 
 	ret = 0;
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	sockopt_seq_inc(msk);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		int err;
 
-		lock_sock(ssk);
+		sockopt_lock_sock(ssk);
 		err = tcp_set_congestion_control(ssk, name, true, cap_net_admin);
 		if (err < 0 && ret == 0)
 			ret = err;
 		subflow->setsockopt_seq = msk->setsockopt_seq;
-		release_sock(ssk);
+		sockopt_release_sock(ssk);
 	}
 
 	if (ret == 0)
 		strscpy(msk->ca_name, name, sizeof(msk->ca_name));
 
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	return ret;
 }
 
@@ -633,10 +633,10 @@ static int __mptcp_setsockopt_set_val(struct mptcp_sock *msk, int max,
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		int ret;
 
-		lock_sock(ssk);
+		sockopt_lock_sock(ssk);
 		ret = set_val(ssk, val);
 		err = err ? : ret;
-		release_sock(ssk);
+		sockopt_release_sock(ssk);
 	}
 
 	if (!err) {
@@ -657,9 +657,9 @@ static int __mptcp_setsockopt_sol_tcp_cork(struct mptcp_sock *msk, int val)
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-		lock_sock(ssk);
+		sockopt_lock_sock(ssk);
 		__tcp_sock_set_cork(ssk, !!val);
-		release_sock(ssk);
+		sockopt_release_sock(ssk);
 	}
 	if (!val)
 		mptcp_check_and_set_pending(sk);
@@ -677,9 +677,9 @@ static int __mptcp_setsockopt_sol_tcp_nodelay(struct mptcp_sock *msk, int val)
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-		lock_sock(ssk);
+		sockopt_lock_sock(ssk);
 		__tcp_sock_set_nodelay(ssk, !!val);
-		release_sock(ssk);
+		sockopt_release_sock(ssk);
 	}
 	if (val)
 		mptcp_check_and_set_pending(sk);
@@ -697,11 +697,11 @@ static int mptcp_setsockopt_sol_ip_set(struct mptcp_sock *msk, int optname,
 	if (err != 0)
 		return err;
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 
 	ssk = __mptcp_nmpc_sk(msk);
 	if (IS_ERR(ssk)) {
-		release_sock(sk);
+		sockopt_release_sock(sk);
 		return PTR_ERR(ssk);
 	}
 
@@ -722,13 +722,13 @@ static int mptcp_setsockopt_sol_ip_set(struct mptcp_sock *msk, int optname,
 			   READ_ONCE(inet_sk(sk)->local_port_range));
 		break;
 	default:
-		release_sock(sk);
+		sockopt_release_sock(sk);
 		WARN_ON_ONCE(1);
 		return -EOPNOTSUPP;
 	}
 
 	sockopt_seq_inc(msk);
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	return 0;
 }
 
@@ -744,18 +744,17 @@ static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optname,
 	if (err != 0)
 		return err;
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	sockopt_seq_inc(msk);
 	val = READ_ONCE(inet_sk(sk)->tos);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		bool slow;
 
-		slow = lock_sock_fast(ssk);
+		sockopt_lock_sock(ssk);
 		__ip_sock_set_tos(ssk, val);
-		unlock_sock_fast(ssk, slow);
+		sockopt_release_sock(ssk);
 	}
-	release_sock(sk);
+	sockopt_release_sock(sk);
 
 	return 0;
 }
@@ -784,7 +783,7 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 	int ret;
 
 	/* Limit to first subflow, before the connection establishment */
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	ssk = __mptcp_nmpc_sk(msk);
 	if (IS_ERR(ssk)) {
 		ret = PTR_ERR(ssk);
@@ -794,7 +793,7 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 	ret = tcp_setsockopt(ssk, level, optname, optval, optlen);
 
 unlock:
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	return ret;
 }
 
@@ -846,7 +845,7 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	if (ret)
 		return ret;
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	switch (optname) {
 	case TCP_INQ:
 		if (val < 0 || val > 1)
@@ -889,7 +888,7 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		ret = -ENOPROTOOPT;
 	}
 
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	return ret;
 }
 
@@ -913,9 +912,9 @@ int mptcp_setsockopt(struct sock *sk, int level, int optname,
 	 * is in TCP fallback, when TCP socket options are passed through
 	 * to the one remaining subflow.
 	 */
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	ssk = __mptcp_tcp_fallback(msk);
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	if (ssk)
 		return tcp_setsockopt(ssk, level, optname, optval, optlen);
 
@@ -938,7 +937,7 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 	struct sock *ssk;
 	int ret;
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	ssk = msk->first;
 	if (ssk)
 		goto get;
@@ -953,7 +952,7 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 	ret = tcp_getsockopt(ssk, level, optname, optval, optlen);
 
 out:
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	return ret;
 }
 
@@ -1124,7 +1123,7 @@ static int mptcp_getsockopt_tcpinfo(struct mptcp_sock *msk, char __user *optval,
 
 	infoptr = optval + sfd.size_subflow_data;
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
@@ -1137,7 +1136,7 @@ static int mptcp_getsockopt_tcpinfo(struct mptcp_sock *msk, char __user *optval,
 			tcp_get_info(ssk, &info);
 
 			if (copy_to_user(infoptr, &info, sfd.size_user)) {
-				release_sock(sk);
+				sockopt_release_sock(sk);
 				return -EFAULT;
 			}
 
@@ -1147,7 +1146,7 @@ static int mptcp_getsockopt_tcpinfo(struct mptcp_sock *msk, char __user *optval,
 		}
 	}
 
-	release_sock(sk);
+	sockopt_release_sock(sk);
 
 	sfd.num_subflows = sfcount;
 
@@ -1216,7 +1215,7 @@ static int mptcp_getsockopt_subflow_addrs(struct mptcp_sock *msk, char __user *o
 
 	addrptr = optval + sfd.size_subflow_data;
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
@@ -1229,7 +1228,7 @@ static int mptcp_getsockopt_subflow_addrs(struct mptcp_sock *msk, char __user *o
 			mptcp_get_sub_addrs(ssk, &a);
 
 			if (copy_to_user(addrptr, &a, sfd.size_user)) {
-				release_sock(sk);
+				sockopt_release_sock(sk);
 				return -EFAULT;
 			}
 
@@ -1239,7 +1238,7 @@ static int mptcp_getsockopt_subflow_addrs(struct mptcp_sock *msk, char __user *o
 		}
 	}
 
-	release_sock(sk);
+	sockopt_release_sock(sk);
 
 	sfd.num_subflows = sfcount;
 
@@ -1325,7 +1324,7 @@ static int mptcp_getsockopt_full_info(struct mptcp_sock *msk, char __user *optva
 				     sizeof(struct mptcp_subflow_info));
 	tcpinfoptr = u64_to_user_ptr(mfi.tcp_info);
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		struct mptcp_subflow_info sfinfo;
@@ -1355,7 +1354,7 @@ static int mptcp_getsockopt_full_info(struct mptcp_sock *msk, char __user *optva
 		tcpinfoptr += mfi.size_tcpinfo_user;
 		sfinfoptr += mfi.size_sfinfo_user;
 	}
-	release_sock(sk);
+	sockopt_release_sock(sk);
 
 	mfi.num_subflows = sfcount;
 	if (mptcp_put_full_info(&mfi, optval, copylen, optlen))
@@ -1364,7 +1363,7 @@ static int mptcp_getsockopt_full_info(struct mptcp_sock *msk, char __user *optva
 	return 0;
 
 fail_release:
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	return -EFAULT;
 }
 
@@ -1519,9 +1518,9 @@ int mptcp_getsockopt(struct sock *sk, int level, int optname,
 	 * is in TCP fallback, when socket options are passed through
 	 * to the one remaining subflow.
 	 */
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	ssk = __mptcp_tcp_fallback(msk);
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	if (ssk)
 		return tcp_getsockopt(ssk, level, optname, optval, option);
 

-- 
2.43.0

