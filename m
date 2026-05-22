Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F693B3BF2
	for <mptcp@lists.linux.dev>; Fri, 22 May 2026 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441177; cv=none; b=MoypyEuO6BZZfnfW1xZoWDkBgGjHDAP9jpvqjigsCysnRwX94uHWBKUAsfVGzZW8l6eKRBVmiwwr0pYCBYEFBpZkCnP24NxpO9yCeVFxMdEuPxOi6kH5ykBL65vmfvUMWhy6Xeu4pnM7PlA0aZ9F3XPdHX7iniwtVZFxm+ikIOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441177; c=relaxed/simple;
	bh=JeiGJhs9LVQVpo7LTQ6wcIXDRqAAGs5IF7ZniyMZJEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g+yzg1flAtBJJeIhoS+fgUtERsvFo2DY5E8VWfJGDkadHMHExUUuKljVR0CRzPlN1BBeXHj4Kgyt32G1+4s8zGmCTBUTdOB5TVPiRbuhn/lMHtjY8ApQ5fbs1OijTY71hBu0C3uDdwa/egKdQQpdTBxs1Mgs2jcNztkvTuL4zP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HY/MYlxF; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HY/MYlxF"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779441173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vXrbvXOk1Orycw+JFqajcA/1rhynzjFDL7o6be1/pFo=;
	b=HY/MYlxFb8OiOkJbeuUzAI+zoiVb2NywCgMgsbmC9T1Q0n371ghzcsF++6xL4JpBjrpl17
	ug204YhWjt+9OY27ZhJio8j15eHaN5+io6CRfutwodHCh7qgED0NpOuxVPUXfsayycCoIi
	z1r2mP4zhvapbR0zjg1nDuwv3mLb224=
From: Gang Yan <gang.yan@linux.dev>
Date: Fri, 22 May 2026 17:12:32 +0800
Subject: [PATCH mptcp-next v5 2/6] mptcp: use sockopt_lock/release_sock in
 sockopt
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-sockopt_lock-v5-2-108629a46e98@kylinos.cn>
References: <20260522-sockopt_lock-v5-0-108629a46e98@kylinos.cn>
In-Reply-To: <20260522-sockopt_lock-v5-0-108629a46e98@kylinos.cn>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Gang Yan <yangang@kylinos.cn>, pabeni@redhat.com
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

TCP and the core socket layer use sockopt_lock_sock() /
sockopt_release_sock() in their setsockopt and getsockopt handlers.

Switch the MPTCP socket (msk) level lock_sock()/release_sock()
calls to use the BPF-aware wrappers, making the MPTCP sockopt
codepaths consistent with the rest of the networking stack.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/sockopt.c | 84 ++++++++++++++++++++++++++---------------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 35a74e44a500..e69d243bde36 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -72,7 +72,7 @@ static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, in
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	sockopt_seq_inc(msk);
 
 	mptcp_for_each_subflow(msk, subflow) {
@@ -117,7 +117,7 @@ static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, in
 		release_sock(ssk);
 	}
 
-	release_sock(sk);
+	sockopt_release_sock(sk);
 }
 
 static int mptcp_sol_socket_intval(struct mptcp_sock *msk, int optname, int val)
@@ -156,7 +156,7 @@ static int mptcp_setsockopt_sol_socket_tstamp(struct mptcp_sock *msk, int optnam
 	if (ret)
 		return ret;
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
@@ -165,7 +165,7 @@ static int mptcp_setsockopt_sol_socket_tstamp(struct mptcp_sock *msk, int optnam
 		release_sock(ssk);
 	}
 
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	return 0;
 }
 
@@ -231,7 +231,7 @@ static int mptcp_setsockopt_sol_socket_timestamping(struct mptcp_sock *msk,
 	if (ret)
 		return ret;
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
@@ -241,7 +241,7 @@ static int mptcp_setsockopt_sol_socket_timestamping(struct mptcp_sock *msk,
 		release_sock(ssk);
 	}
 
-	release_sock(sk);
+	sockopt_release_sock(sk);
 
 	return 0;
 }
@@ -266,7 +266,7 @@ static int mptcp_setsockopt_sol_socket_linger(struct mptcp_sock *msk, sockptr_t
 	if (ret)
 		return ret;
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	sockopt_seq_inc(msk);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
@@ -283,7 +283,7 @@ static int mptcp_setsockopt_sol_socket_linger(struct mptcp_sock *msk, sockptr_t
 		release_sock(ssk);
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
 
@@ -601,7 +601,7 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
 	cap_net_admin = ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN);
 
 	ret = 0;
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	sockopt_seq_inc(msk);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
@@ -618,7 +618,7 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
 	if (ret == 0)
 		strscpy(msk->ca_name, name, sizeof(msk->ca_name));
 
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	return ret;
 }
 
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
 
@@ -744,7 +744,7 @@ static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optname,
 	if (err != 0)
 		return err;
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	sockopt_seq_inc(msk);
 	val = READ_ONCE(inet_sk(sk)->tos);
 	mptcp_for_each_subflow(msk, subflow) {
@@ -754,7 +754,7 @@ static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optname,
 		__ip_sock_set_tos(ssk, val);
 		release_sock(ssk);
 	}
-	release_sock(sk);
+	sockopt_release_sock(sk);
 
 	return 0;
 }
@@ -783,7 +783,7 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 	int ret;
 
 	/* Limit to first subflow, before the connection establishment */
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	ssk = __mptcp_nmpc_sk(msk);
 	if (IS_ERR(ssk)) {
 		ret = PTR_ERR(ssk);
@@ -793,7 +793,7 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 	ret = tcp_setsockopt(ssk, level, optname, optval, optlen);
 
 unlock:
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	return ret;
 }
 
@@ -845,7 +845,7 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	if (ret)
 		return ret;
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	switch (optname) {
 	case TCP_INQ:
 		if (val < 0 || val > 1)
@@ -888,7 +888,7 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		ret = -ENOPROTOOPT;
 	}
 
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	return ret;
 }
 
@@ -912,9 +912,9 @@ int mptcp_setsockopt(struct sock *sk, int level, int optname,
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
 
@@ -937,7 +937,7 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 	struct sock *ssk;
 	int ret;
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	ssk = msk->first;
 	if (ssk)
 		goto get;
@@ -952,7 +952,7 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 	ret = tcp_getsockopt(ssk, level, optname, optval, optlen);
 
 out:
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	return ret;
 }
 
@@ -1123,7 +1123,7 @@ static int mptcp_getsockopt_tcpinfo(struct mptcp_sock *msk, char __user *optval,
 
 	infoptr = optval + sfd.size_subflow_data;
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
@@ -1136,7 +1136,7 @@ static int mptcp_getsockopt_tcpinfo(struct mptcp_sock *msk, char __user *optval,
 			tcp_get_info(ssk, &info);
 
 			if (copy_to_user(infoptr, &info, sfd.size_user)) {
-				release_sock(sk);
+				sockopt_release_sock(sk);
 				return -EFAULT;
 			}
 
@@ -1146,7 +1146,7 @@ static int mptcp_getsockopt_tcpinfo(struct mptcp_sock *msk, char __user *optval,
 		}
 	}
 
-	release_sock(sk);
+	sockopt_release_sock(sk);
 
 	sfd.num_subflows = sfcount;
 
@@ -1215,7 +1215,7 @@ static int mptcp_getsockopt_subflow_addrs(struct mptcp_sock *msk, char __user *o
 
 	addrptr = optval + sfd.size_subflow_data;
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
@@ -1228,7 +1228,7 @@ static int mptcp_getsockopt_subflow_addrs(struct mptcp_sock *msk, char __user *o
 			mptcp_get_sub_addrs(ssk, &a);
 
 			if (copy_to_user(addrptr, &a, sfd.size_user)) {
-				release_sock(sk);
+				sockopt_release_sock(sk);
 				return -EFAULT;
 			}
 
@@ -1238,7 +1238,7 @@ static int mptcp_getsockopt_subflow_addrs(struct mptcp_sock *msk, char __user *o
 		}
 	}
 
-	release_sock(sk);
+	sockopt_release_sock(sk);
 
 	sfd.num_subflows = sfcount;
 
@@ -1324,7 +1324,7 @@ static int mptcp_getsockopt_full_info(struct mptcp_sock *msk, char __user *optva
 				     sizeof(struct mptcp_subflow_info));
 	tcpinfoptr = u64_to_user_ptr(mfi.tcp_info);
 
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		struct mptcp_subflow_info sfinfo;
@@ -1354,7 +1354,7 @@ static int mptcp_getsockopt_full_info(struct mptcp_sock *msk, char __user *optva
 		tcpinfoptr += mfi.size_tcpinfo_user;
 		sfinfoptr += mfi.size_sfinfo_user;
 	}
-	release_sock(sk);
+	sockopt_release_sock(sk);
 
 	mfi.num_subflows = sfcount;
 	if (mptcp_put_full_info(&mfi, optval, copylen, optlen))
@@ -1363,7 +1363,7 @@ static int mptcp_getsockopt_full_info(struct mptcp_sock *msk, char __user *optva
 	return 0;
 
 fail_release:
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	return -EFAULT;
 }
 
@@ -1518,9 +1518,9 @@ int mptcp_getsockopt(struct sock *sk, int level, int optname,
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

