Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A3337E5F2
	for <mptcp@lists.linux.dev>; Sat,  8 Aug 2026 03:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786160482; cv=none; b=H4IkRmT3QODgW57DRjxYAwfCDQB+0f421IZ8B1WC+GkFZzg4nGuiMLxEGqLrcDGSuIQVKfmUV/fx1QjnZXziKfjlC3MMlzZXtNwsZGz/XOraR2gKg8iMC1i/P3TgtJACb2nN8Rz+oEodFlnZcBZNgxdJbo42YlIZF2O7THTc/aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786160482; c=relaxed/simple;
	bh=uU2ubTbjmwcZNrSzEOXBAAmtiq0X3ijL6W654BWwMEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iP84ABoh6/rXi7ZcwIUmk3pN5dawjbbMvHmay8WBczlFWJYpT1cFNI2zZiBX43RE/6w131rZHtKCK279dGCpqRyGYFcSE2nJdSxWq/cBTIWPIC1gef2QbfUARQHa95jUD+aezELqXRnzXTPzkKvLpySoajluwI9z7xx2q76PQKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0EwR2ep; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0EwR2ep"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F231F00A3A;
	Sat,  8 Aug 2026 03:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786160481;
	bh=c20Mpmv3QU/CCWfP13eRgQrAO/5fSVs0PfiMsAYb3k4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G0EwR2epzayRfsKEcd3zP2OeR7QKaJoyzqeEIYbByfJYNKmv2CCfZDnGKzktE8hN3
	 AflB6pBV3KaV1hX+G1MZl7Dfuk9IFpYECP17QqJ/IVnIUHezau4W+q4fEDbL661nQ6
	 V4VkgBNoH38qEN7pTXz3IgsbzlVKVbVLzGJQ4pdFdlZh7KcKf/E2jmJwz1tDMhhtZQ
	 C7AyJs1F+6JebaUnUFtBrhloKMcfZCz755IfeMBA+XL2swihvlJ1CvGAsWlC49QbPy
	 9RhDMkX0lYQWqMFyQq+CWgzyOGk86zAD7RJ81aEQRcaNsagiiKfBgmTi5geX4WU858
	 9C1xIuW4CjxBA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 03/11] mptcp: inherit sk_reuse/sk_reuseport and fix dev bind override
Date: Sat,  8 Aug 2026 11:40:33 +0800
Message-ID: <445023840741fb5afb83eeb97fee4f3a9afc935d.1786159812.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786159812.git.tanggeliang@kylinos.cn>
References: <cover.1786159812.git.tanggeliang@kylinos.cn>
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

