Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE91E571
	for <mptcp@lists.linux.dev>; Sat,  2 Aug 2025 09:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754126407; cv=none; b=MQcHoNRxr64h5tRG4l31tnghzZAXlJm8GShWceTS7riRTqneaD6QHOS9jQzzUjMqw+yOLOd/zNWaK0BT5tRakQFA2i9koDTMLjktr9/Es3O82ev4iTe7G6zFnSK6Xk3fZHSEu2xB8X2x1MjF35emEfxlC8qKSlo1DHdNZ/8paxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754126407; c=relaxed/simple;
	bh=JTXzgGrb5XLtECMyVyb9i+ochfprsxffLmLY9gbVQMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UoQHudwGoJCmoNp7nnZ1/PxkQT/94Crn2z4cj6/56q1AUdylhvE/05Gw12J9HYBpevKTsTHiGJhm7Kp9OV5smDM983hC7enyQHSSI+K6tiZVJzdHNeniEbzWUiL9dCJADdynMloFKTxo8TY3EfGmaa0nnrvvab2Jzq/q5oIpzSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LepRHHVE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LepRHHVE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04580C4CEF6;
	Sat,  2 Aug 2025 09:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754126406;
	bh=JTXzgGrb5XLtECMyVyb9i+ochfprsxffLmLY9gbVQMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LepRHHVE9NW/4yiBsjMaHcU1wI0TYgJM7eSiMSqa+NeCevGpRWsOAKX+b24Izbf2K
	 F5L8JopaPHwC+82sApEJK8pL5qGJEJjQS5MqCHhy9zFO8sGaLONgzXFsJQ4S5PKw72
	 WeJaASOopg+z9Ow0wR4khRTBlShG16nl+CwdxCHufgTGpTFXFHOy3JmVvtQOw5Ti2+
	 YdcEvBCgTAnyyGGmLNXplkBFKUzhBxkcJhYxxhhn3U94m+ndmaF1gGeyxmbMM/CMH9
	 aeH8BZKh2iyUn2PGVUxs0IPEf3XDokPca17iLTqXzqMIbaL3BHHqMiwVzdd91sbnkT
	 LPObQqdRk5zdA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/3] mptcp: add IP_TTL sockopt support
Date: Sat,  2 Aug 2025 17:19:56 +0800
Message-ID: <49f2613aa883b21ef621840fbac5acf54b0a0af4.1754126092.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754126092.git.tanggeliang@kylinos.cn>
References: <cover.1754126092.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Implement setsockopt/getsockopt support for IP_TTL in MPTCP. This change:
1. Adds mptcp_setsockopt_v4_set_ttl() to handle IP_TTL setsockopt:
   - Applies TTL value to the MPTCP socket itself
   - Propagates the TTL value to all subflows
   - Uses lock_sock_fast() for safe subflow updates
2. Adds getsockopt handler for IP_TTL:
   - Retrieves TTL from inet_sk(sk)->uc_ttl
   - Falls back to sysctl_ip_default_ttl when not set
3. Syncs TTL to new subflows in sync_socket_options()
4. Maintains option sequence counter for consistency

This allows applications to control TTL settings in MPTCP connections
with standard IPv4 socket options, ensuring consistent behavior across
all subflows.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/296
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index b4ccc0acadae..cc13006b5dc9 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -791,6 +791,33 @@ static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optname,
 	return 0;
 }
 
+static int mptcp_setsockopt_v4_set_ttl(struct mptcp_sock *msk, int optname,
+				       sockptr_t optval, unsigned int optlen)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	int err, val;
+
+	err = ip_setsockopt(sk, SOL_IP, optname, optval, optlen);
+	if (err)
+		return err;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	val = READ_ONCE(inet_sk(sk)->uc_ttl);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow;
+
+		slow = lock_sock_fast(ssk);
+		WRITE_ONCE(inet_sk(ssk)->uc_ttl, val);
+		unlock_sock_fast(ssk, slow);
+	}
+	release_sock(sk);
+
+	return 0;
+}
+
 static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
 			       sockptr_t optval, unsigned int optlen)
 {
@@ -802,6 +829,8 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
 		return mptcp_setsockopt_sol_ip_set(msk, optname, optval, optlen);
 	case IP_TOS:
 		return mptcp_setsockopt_v4_set_tos(msk, optname, optval, optlen);
+	case IP_TTL:
+		return mptcp_setsockopt_v4_set_ttl(msk, optname, optval, optlen);
 	}
 
 	return -EOPNOTSUPP;
@@ -1470,6 +1499,7 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
 			       char __user *optval, int __user *optlen)
 {
 	struct sock *sk = (void *)msk;
+	int val;
 
 	switch (optname) {
 	case IP_TOS:
@@ -1486,6 +1516,11 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
 	case IP_LOCAL_PORT_RANGE:
 		return mptcp_put_int_option(msk, optval, optlen,
 				READ_ONCE(inet_sk(sk)->local_port_range));
+	case IP_TTL:
+		val = READ_ONCE(inet_sk(sk)->uc_ttl);
+		if (val < 0)
+			val = READ_ONCE(sock_net(sk)->ipv4.sysctl_ip_default_ttl);
+		return mptcp_put_int_option(msk, optval, optlen, val);
 	}
 
 	return -EOPNOTSUPP;
@@ -1580,6 +1615,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	ssk->sk_ipv6only = sk->sk_ipv6only;
 	__ip_sock_set_tos(ssk, inet_sk(sk)->tos);
 	WRITE_ONCE(inet6_sk(ssk)->tclass, inet6_sk(sk)->tclass);
+	WRITE_ONCE(inet_sk(ssk)->uc_ttl, inet_sk(sk)->uc_ttl);
 
 	if (sk->sk_userlocks & tx_rx_locks) {
 		ssk->sk_userlocks |= sk->sk_userlocks & tx_rx_locks;
-- 
2.48.1

