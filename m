Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9973C1969
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 09:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776849587; cv=none; b=SWKxkWv1Pl/U2dID7Lx39++8L3y820N9F+Zo/oo8Aog2Iq/o3qPm125VG4XdJEbYHF0eGeDfNL3OPQ8yOdpvlSRAWx9ghEFpwxJrAEkFRcmNZpSSUWab7fhXfVJ2l0+r++04zW0YfAHNl2ML9yc1yrrIO6xw0ZlcJvgm8XbUor0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776849587; c=relaxed/simple;
	bh=P7PP2jtqittMvosmQO7pdXyjNe3WOSx1GT3nKtz0aks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V5ljIgQIUFKxQ+W5r8hsN+7+uVXWnNrdqdkVskwaIG9+zPTqmFaaceO9uzd7NGDBUaqzgfDaw4duQ2/hA2mgnVlhSuwOiCcBdmdmYkdH5REMIAkC5IHV+o0KVl82UaQv84GsqSSMIdPkScq55+OEbr2LZs/iuGErk3h+y7iR9Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AKGu2M1T; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AKGu2M1T"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776849583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6P6XI3we9NVLb5TX43wmOkIHiXGtuZM3DJbatEiDbM0=;
	b=AKGu2M1TngZGIjAuJAAsoahkZaAHahu5me8W56jV1xpxNSHXkZzDC0ujd9HolJd3e0mLUP
	3jobxMD0ia917tW+7JmHnBQyF0ybsg+N0Fwz81FaQ8+VWDsLJXpvYCxom+hGQqpFlzDJVy
	G7uGc+rJegibxj17s5pSXqZOiij/0fc=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next 2/2] mptcp: use sockopt_lock(release)_sock in sockopt
Date: Wed, 22 Apr 2026 17:19:22 +0800
Message-ID: <20260422091927.77770-3-gang.yan@linux.dev>
In-Reply-To: <20260422091927.77770-1-gang.yan@linux.dev>
References: <20260422091927.77770-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/sockopt.c | 121 ++++++++++++++++++++++----------------------
 1 file changed, 60 insertions(+), 61 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 0efe40be2fde..a4a7df4a3c8c 100644
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
 
@@ -842,7 +841,7 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	if (ret)
 		return ret;
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	switch (optname) {
 	case TCP_INQ:
 		if (val < 0 || val > 1)
@@ -885,7 +884,7 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		ret = -ENOPROTOOPT;
 	}
 
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	return ret;
 }
 
@@ -909,9 +908,9 @@ int mptcp_setsockopt(struct sock *sk, int level, int optname,
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
 
@@ -934,7 +933,7 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 	struct sock *ssk;
 	int ret;
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	ssk = msk->first;
 	if (ssk)
 		goto get;
@@ -949,7 +948,7 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 	ret = tcp_getsockopt(ssk, level, optname, optval, optlen);
 
 out:
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	return ret;
 }
 
@@ -1120,7 +1119,7 @@ static int mptcp_getsockopt_tcpinfo(struct mptcp_sock *msk, char __user *optval,
 
 	infoptr = optval + sfd.size_subflow_data;
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
@@ -1133,7 +1132,7 @@ static int mptcp_getsockopt_tcpinfo(struct mptcp_sock *msk, char __user *optval,
 			tcp_get_info(ssk, &info);
 
 			if (copy_to_user(infoptr, &info, sfd.size_user)) {
-				release_sock(sk);
+				sockopt_release_sock(sk);
 				return -EFAULT;
 			}
 
@@ -1143,7 +1142,7 @@ static int mptcp_getsockopt_tcpinfo(struct mptcp_sock *msk, char __user *optval,
 		}
 	}
 
-	release_sock(sk);
+	sockopt_release_sock(sk);
 
 	sfd.num_subflows = sfcount;
 
@@ -1212,7 +1211,7 @@ static int mptcp_getsockopt_subflow_addrs(struct mptcp_sock *msk, char __user *o
 
 	addrptr = optval + sfd.size_subflow_data;
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
@@ -1225,7 +1224,7 @@ static int mptcp_getsockopt_subflow_addrs(struct mptcp_sock *msk, char __user *o
 			mptcp_get_sub_addrs(ssk, &a);
 
 			if (copy_to_user(addrptr, &a, sfd.size_user)) {
-				release_sock(sk);
+				sockopt_release_sock(sk);
 				return -EFAULT;
 			}
 
@@ -1235,7 +1234,7 @@ static int mptcp_getsockopt_subflow_addrs(struct mptcp_sock *msk, char __user *o
 		}
 	}
 
-	release_sock(sk);
+	sockopt_release_sock(sk);
 
 	sfd.num_subflows = sfcount;
 
@@ -1321,7 +1320,7 @@ static int mptcp_getsockopt_full_info(struct mptcp_sock *msk, char __user *optva
 				     sizeof(struct mptcp_subflow_info));
 	tcpinfoptr = u64_to_user_ptr(mfi.tcp_info);
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		struct mptcp_subflow_info sfinfo;
@@ -1351,7 +1350,7 @@ static int mptcp_getsockopt_full_info(struct mptcp_sock *msk, char __user *optva
 		tcpinfoptr += mfi.size_tcpinfo_user;
 		sfinfoptr += mfi.size_sfinfo_user;
 	}
-	release_sock(sk);
+	sockopt_release_sock(sk);
 
 	mfi.num_subflows = sfcount;
 	if (mptcp_put_full_info(&mfi, optval, copylen, optlen))
@@ -1360,7 +1359,7 @@ static int mptcp_getsockopt_full_info(struct mptcp_sock *msk, char __user *optva
 	return 0;
 
 fail_release:
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	return -EFAULT;
 }
 
@@ -1515,9 +1514,9 @@ int mptcp_getsockopt(struct sock *sk, int level, int optname,
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

