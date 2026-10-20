Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792470894;
	b=Hj9C8/gTlYsGjAitGdPytu6266Wtg9F3Al0/uSzTYHYHV5FsM2gI4Yr3M/x2+SYiObew
	 lcwES7fE0fvV8Sa4RcfjnxTMhTs6YVc3n9sbI8w1J6aMsDpPNe322iJycGEy9QQlTq/t4
	 5Kbrc4W+yQcCL7QIj1t3d/RHNe6as0yVuxFv9I41TDcdWjfgVDo7icV+QNUsM8e0hoDfA
	 Xe/T3gTOWaAKYWTXVteS0xWW0BiMI9fS+Iyf383KMK66JLYrah9K9i7RXc4K6LT4ty1UE
	 ckzQP9SBptAp3/OPyTrzMOz8Gv9kI1tbnlwQ7E9bDcpGBTCbArf4Jn9qSBkThChD0QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792470894;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fJP65vf7CMB69ymRYBv2ifWTgzRUCNSkCohui2lA43Y=;
	b=MpUMxTMp272du5FFOxM3ew8eBVDgXoGaJUU9vG0C6FIGKwfn9xS/6Z64EzCj+TmiNT2l
	 7zcXz1zLTZzUIwzkXROwCloyU3ZHLycQ9fHoARooHKKSdXqGrgEQ+lubRgUOLGVW3ZLnG
	 nX6aIEVit9A6y/pHsomtHzWUkG6nkAb7j8WV720VR0OCMbyX/jMXOLYHK3Z2E/HpQSE88
	 PcdCYFKAzXo5uuvPtDofGjAJN6dpB2JtkdNhsTh42HyEBzYHYYTMvexh8Ag8SMC/8w/Jo
	 DDdpnhAN+wPbb+smKDn6Wyf6g2gm0V1h1H9lZYDa2bw5G2HSIh7egEf6IqsXUl/IYvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=krijcdFE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82330606A319
	for <mptcp@lists.linux.dev>; Tue, 20 Oct 2026 04:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=krijcdFE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8862A1F000C4;
	Tue, 20 Oct 2026 04:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792470894;
	bh=fJP65vf7CMB69ymRYBv2ifWTgzRUCNSkCohui2lA43Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=krijcdFEDenVyoGJMg/9KWGTodADC+IH9VGZAKq8azx5Y/OweNQi9YYZuL4uC5n5x
	 IHV4VyyhywDmKVExSop66bvWeM8rKtMSpnioN1MdfYT0VMFFVwD8nXX4qvNZ0wI2ut
	 iU4ueYKxUMxb4oV3azHIyFkrF6ciccaTBWq2S0U9CWSn3WqFneLPOy0H5BD0BEHmpv
	 91/feNSbwGCfBDVyqZoRsRizWyap9/Qz5m4accePkFH/YypcCgJ3RgqYXyR5JUu9CI
	 G3bL3lwa5Jf+8V/RPXzDDHfB1BIgyQswqsRpqcmIaQLEGXNMKCVNyTfettAaXwPAny
	 NNBlMcTUavZnw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 2/3] mptcp: inherit sk_reuse and fix dev bind override
Date: Tue, 20 Oct 2026 12:34:44 +0800
Message-ID: <4adf96455e63a35be3228434cfe2ba79ea99bcb0.1792470313.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792470313.git.tanggeliang@kylinos.cn>
References: <cover.1792470313.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
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
index 922f6ae5c80c..952bc015eee8 100644
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
@@ -1706,6 +1708,9 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 		assign_bit(b, &inet_sk(ssk)->inet_flags, src & BIT(b));
 
 	WRITE_ONCE(inet_sk(ssk)->local_port_range, READ_ONCE(inet_sk(sk)->local_port_range));
+
+	ssk->sk_reuse = sk->sk_reuse;
+	ssk->sk_reuseport = sk->sk_reuseport;
 }
 
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 78e886b20258..5bdfbe172665 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1713,7 +1713,9 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
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
2.55.0

