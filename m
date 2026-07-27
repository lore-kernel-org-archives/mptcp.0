Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD72F35E1AE
	for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 02:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785119390; cv=none; b=UIvDLYMToLfzY+aOB+GZkD+T//E8GeK9l34ongEyYWQ8ddOIgNQGsABopVHJaemxDX6/XnII1u121WrLM+Aaa3CcM52paZ5X6F31z5fwNDtOUS+tq2UiKQEXr+BFxsPuVYf+tI2vvGI61Y90oOLA1vFZdwTQhrGXbndbg9umgXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785119390; c=relaxed/simple;
	bh=NGpualsv4UOpTyo+hN51G+tZ+BaArzmrtcF/AKCKp+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UexLx23mAGbX5YwjW2ilUTSKot3koNvfKGHEU5j8Ix/Z07QK+aZwWKNQgO5m6RxFENNP+4PQsY2hRpQrv8K75I+eZpxpiw2BJFWPZxvirjfJOpzJoyn2P/T3y9hFUTeCu/FXH9WtcKH9aAbOiWERGLfSCdcQC6vxpcLAc0y3N0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hIjgTkaV; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hIjgTkaV"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785119386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CkMfPAfuHS8MJ+gAskUwod2pjLBlDeXA+fQFfnpePTk=;
	b=hIjgTkaVVfuhnChY1YZ0ceis7eHpVecD4gW9fa0diRtIJHFPwMUMHAxExPnjhe0GfHTLjG
	yly1lyaO0JZ4OzSXqteaqcFNd/TwhLnQRz1z0XU3xZFCG2AOhCXrV8I7q2smOeYplWWHPa
	jJiaplDTMPLGJK8Agq39tip7xDH2YNk=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v3 3/7] mptcp: use sockopt_lock/release_sock in sockopt
Date: Mon, 27 Jul 2026 10:28:45 +0800
Message-ID: <20260727022849.20923-4-gang.yan@linux.dev>
In-Reply-To: <20260727022849.20923-1-gang.yan@linux.dev>
References: <20260727022849.20923-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

TCP and the core socket layer use sockopt_lock_sock() /
sockopt_release_sock() in their setsockopt and getsockopt handlers.

Switch the MPTCP socket (msk) level lock_sock()/release_sock()
calls to use the BPF-aware wrappers, making the MPTCP sockopt
codepaths consistent with the rest of the networking stack.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/sockopt.c | 84 ++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index a7d4135757e7..f00d85809c52 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -78,7 +78,7 @@ static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, in
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	sockopt_seq_inc(msk);
 
 	mptcp_for_each_subflow(msk, subflow) {
@@ -123,7 +123,7 @@ static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, in
 		unlock_sock_fast(ssk, slow);
 	}
 
-	release_sock(sk);
+	sockopt_release_sock(sk);
 }
 
 static int mptcp_sol_socket_intval(struct mptcp_sock *msk, int optname, int val)
@@ -162,7 +162,7 @@ static int mptcp_setsockopt_sol_socket_tstamp(struct mptcp_sock *msk, int optnam
 	if (ret)
 		return ret;
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
@@ -171,7 +171,7 @@ static int mptcp_setsockopt_sol_socket_tstamp(struct mptcp_sock *msk, int optnam
 		release_sock(ssk);
 	}
 
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	return 0;
 }
 
@@ -237,7 +237,7 @@ static int mptcp_setsockopt_sol_socket_timestamping(struct mptcp_sock *msk,
 	if (ret)
 		return ret;
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
@@ -251,7 +251,7 @@ static int mptcp_setsockopt_sol_socket_timestamping(struct mptcp_sock *msk,
 			ret = err;
 	}
 
-	release_sock(sk);
+	sockopt_release_sock(sk);
 
 	return ret;
 }
@@ -276,7 +276,7 @@ static int mptcp_setsockopt_sol_socket_linger(struct mptcp_sock *msk, sockptr_t
 	if (ret)
 		return ret;
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	sockopt_seq_inc(msk);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
@@ -293,7 +293,7 @@ static int mptcp_setsockopt_sol_socket_linger(struct mptcp_sock *msk, sockptr_t
 		unlock_sock_fast(ssk, slow);
 	}
 
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	return 0;
 }
 
@@ -309,10 +309,10 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
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
 
@@ -327,7 +327,7 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 			else if (optname == SO_BINDTOIFINDEX)
 				sk->sk_bound_dev_if = ssk->sk_bound_dev_if;
 		}
-		release_sock(sk);
+		sockopt_release_sock(sk);
 		return ret;
 	case SO_KEEPALIVE:
 	case SO_PRIORITY:
@@ -405,16 +405,16 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
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
 
@@ -434,7 +434,7 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 			break;
 		}
 
-		release_sock(sk);
+		sockopt_release_sock(sk);
 		break;
 	}
 
@@ -611,7 +611,7 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
 	cap_net_admin = ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN);
 
 	ret = 0;
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	sockopt_seq_inc(msk);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
@@ -628,7 +628,7 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
 	if (ret == 0)
 		strscpy(msk->ca_name, name, sizeof(msk->ca_name));
 
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	return ret;
 }
 
@@ -707,11 +707,11 @@ static int mptcp_setsockopt_sol_ip_set(struct mptcp_sock *msk, int optname,
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
 
@@ -732,13 +732,13 @@ static int mptcp_setsockopt_sol_ip_set(struct mptcp_sock *msk, int optname,
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
 
@@ -754,7 +754,7 @@ static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optname,
 	if (err != 0)
 		return err;
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	sockopt_seq_inc(msk);
 	val = READ_ONCE(inet_sk(sk)->tos);
 	mptcp_for_each_subflow(msk, subflow) {
@@ -765,7 +765,7 @@ static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optname,
 		__ip_sock_set_tos(ssk, val);
 		unlock_sock_fast(ssk, slow);
 	}
-	release_sock(sk);
+	sockopt_release_sock(sk);
 
 	return 0;
 }
@@ -794,7 +794,7 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 	int ret;
 
 	/* Limit to first subflow, before the connection establishment */
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	ssk = __mptcp_nmpc_sk(msk);
 	if (IS_ERR(ssk)) {
 		ret = PTR_ERR(ssk);
@@ -804,7 +804,7 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 	ret = tcp_setsockopt(ssk, level, optname, optval, optlen);
 
 unlock:
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	return ret;
 }
 
@@ -857,7 +857,7 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	if (ret)
 		return ret;
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	switch (optname) {
 	case TCP_INQ:
 		if (val < 0 || val > 1)
@@ -896,7 +896,7 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		ret = -ENOPROTOOPT;
 	}
 
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	return ret;
 }
 
@@ -920,9 +920,9 @@ int mptcp_setsockopt(struct sock *sk, int level, int optname,
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
 
@@ -945,7 +945,7 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 	struct sock *ssk;
 	int ret;
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	ssk = msk->first;
 	if (ssk)
 		goto get;
@@ -960,7 +960,7 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 	ret = tcp_getsockopt(ssk, level, optname, optval, optlen);
 
 out:
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	return ret;
 }
 
@@ -1131,7 +1131,7 @@ static int mptcp_getsockopt_tcpinfo(struct mptcp_sock *msk, char __user *optval,
 
 	infoptr = optval + sfd.size_subflow_data;
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
@@ -1144,7 +1144,7 @@ static int mptcp_getsockopt_tcpinfo(struct mptcp_sock *msk, char __user *optval,
 			tcp_get_info(ssk, &info);
 
 			if (copy_to_user(infoptr, &info, sfd.size_user)) {
-				release_sock(sk);
+				sockopt_release_sock(sk);
 				return -EFAULT;
 			}
 
@@ -1154,7 +1154,7 @@ static int mptcp_getsockopt_tcpinfo(struct mptcp_sock *msk, char __user *optval,
 		}
 	}
 
-	release_sock(sk);
+	sockopt_release_sock(sk);
 
 	sfd.num_subflows = sfcount;
 
@@ -1223,7 +1223,7 @@ static int mptcp_getsockopt_subflow_addrs(struct mptcp_sock *msk, char __user *o
 
 	addrptr = optval + sfd.size_subflow_data;
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
@@ -1236,7 +1236,7 @@ static int mptcp_getsockopt_subflow_addrs(struct mptcp_sock *msk, char __user *o
 			mptcp_get_sub_addrs(ssk, &a);
 
 			if (copy_to_user(addrptr, &a, sfd.size_user)) {
-				release_sock(sk);
+				sockopt_release_sock(sk);
 				return -EFAULT;
 			}
 
@@ -1246,7 +1246,7 @@ static int mptcp_getsockopt_subflow_addrs(struct mptcp_sock *msk, char __user *o
 		}
 	}
 
-	release_sock(sk);
+	sockopt_release_sock(sk);
 
 	sfd.num_subflows = sfcount;
 
@@ -1332,7 +1332,7 @@ static int mptcp_getsockopt_full_info(struct mptcp_sock *msk, char __user *optva
 				     sizeof(struct mptcp_subflow_info));
 	tcpinfoptr = u64_to_user_ptr(mfi.tcp_info);
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		struct mptcp_subflow_info sfinfo;
@@ -1362,7 +1362,7 @@ static int mptcp_getsockopt_full_info(struct mptcp_sock *msk, char __user *optva
 		tcpinfoptr += mfi.size_tcpinfo_user;
 		sfinfoptr += mfi.size_sfinfo_user;
 	}
-	release_sock(sk);
+	sockopt_release_sock(sk);
 
 	mfi.num_subflows = sfcount;
 	if (mptcp_put_full_info(&mfi, optval, copylen, optlen))
@@ -1371,7 +1371,7 @@ static int mptcp_getsockopt_full_info(struct mptcp_sock *msk, char __user *optva
 	return 0;
 
 fail_release:
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	return -EFAULT;
 }
 
@@ -1526,9 +1526,9 @@ int mptcp_getsockopt(struct sock *sk, int level, int optname,
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

