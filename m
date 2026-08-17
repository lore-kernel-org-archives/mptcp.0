Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C0F2EEE99
	for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 03:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786939047; cv=none; b=L59rQc78TJ/FcwWRKamZ872r242/ka7izKSaAVpj1I1zwv4iMGfUH7K3Fx/tfl0jQeIOjuR+tNfosu7xI76+Jtl5j9CnOZ7dJakuxe7gJDP/wcWmTkopNaT8qbdlFBSorMieCD1UdDophsDdIp6AL4CPeNhu33QUFqOLR+32Mf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786939047; c=relaxed/simple;
	bh=uU2ubTbjmwcZNrSzEOXBAAmtiq0X3ijL6W654BWwMEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mBtlLpVUd3PTN0EhIJGWWczI16msYmLmSh+QgHN5iy0TczHe5JQP831pWXHG4ovxsIcnydvb3IF5atwe/SiDbyeQTxYwjvc3bFWoKuwMW1JZ/+f5jfduppEgm1+wzTk+Z7Te3jQPtMGcxQH7xNtkIJjbhJNQHFCe6mYhgfy/mIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZHUbDEJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZHUbDEJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4ED1F000E9;
	Mon, 17 Aug 2026 03:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786939045;
	bh=c20Mpmv3QU/CCWfP13eRgQrAO/5fSVs0PfiMsAYb3k4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HZHUbDEJz+kRV1zk3cycGN455PtIVNeHkB80lJRlLJMOLw0utN8yvnLFfQn/hoFzW
	 dW+PYkLDDr5iuvTIKWOb9gUMSTkOSrDL6Sibm52Tz8yprfgiDTC+A+pd1ZgMDdcsHs
	 ZJFaIFrIVQaX8ypmDp0XdMZ8ZCIgXtGmp8ez9EJpZlVzvKumu2ZfhN02OJsNacJwKF
	 khpzB6Se1WfkaB6BbsBpHJxvHvgk52t0aAYZCDm3zxSa5X3SpsCgQ4wpOOftMUBRFr
	 RAjeD7xv6tGhkl68L0ZDE6cIfbRaWb+PP6oU4fqcsycWSs2mxtxMpn4HLMMXGBzK9q
	 532/QAMh7TWSQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 3/6] mptcp: inherit sk_reuse and fix dev bind override
Date: Mon, 17 Aug 2026 11:57:10 +0800
Message-ID: <e75ce15c1f4177bff9d2640e5ace10369db6100a.1786938892.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786938892.git.tanggeliang@kylinos.cn>
References: <cover.1786938892.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Propagate sk_reuse and sk_reuseport from master socket to subflows, and
bump setsockopt_seq so later subflows pick up the changes.

This patch also fixes unconditional sk_bound_dev_if override in
__mptcp_subflow_connect(): only set it when local->ifindex is non-zero,
otherwise preserve the value inherited from the master socket via
sync_socket_options().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 5 +++++
 net/mptcp/subflow.c | 4 +++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 5de371e29721..d79139eb5b8a 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -335,6 +335,8 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 				sk->sk_bound_dev_if = ssk->sk_bound_dev_if;
 			else if (optname == SO_BINDTOIFINDEX)
 				sk->sk_bound_dev_if = ssk->sk_bound_dev_if;
+
+			sockopt_seq_inc(msk);
 		}
 		release_sock(sk);
 		return ret;
@@ -1704,6 +1706,9 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 		assign_bit(b, &inet_sk(ssk)->inet_flags, src & BIT(b));
 
 	WRITE_ONCE(inet_sk(ssk)->local_port_range, READ_ONCE(inet_sk(sk)->local_port_range));
+
+	ssk->sk_reuse = sk->sk_reuse;
+	ssk->sk_reuseport = sk->sk_reuseport;
 }
 
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index af81ad5e699d..47ff736c4d66 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1672,7 +1672,9 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
 	if (addr.ss_family == AF_INET6)
 		addrlen = sizeof(struct sockaddr_in6);
 #endif
-	ssk->sk_bound_dev_if = local->ifindex;
+	/* Only override the bound device if the path manager picked one. */
+	if (local->ifindex)
+		ssk->sk_bound_dev_if = local->ifindex;
 	err = kernel_bind(sf, (struct sockaddr_unsized *)&addr, addrlen);
 	if (err) {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNTXBINDERR);
-- 
2.53.0

