Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F54C37E5F2
	for <mptcp@lists.linux.dev>; Sat,  8 Aug 2026 03:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786160488; cv=none; b=Vz3aDrCkYlK50tC7fl2rwXMNNDIXJsfxQEpuQ7Vhc1QHpVittoQ2T3QEWA7NgtP90OTGgwenBdQ9JN9593LgN7wlIYEy1M+dPDtDK5dQ1v3MSM/Gkh1ikv9u6KNMRKpknIQvBP6KqTp0rlQbAeWciEvkIorA/bSZk3CcdAjw8Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786160488; c=relaxed/simple;
	bh=aNhh2466VEw/g9sVKM/2S9cwmj5cYQTlXEY3d2PymLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qtx4UeKUWD+atf6usN41iKLxZgKB7urAB7v3BLOzj7yEPRi2Li9HqRxgaygLGm6y7ow59DlmNuX+EEZcObVXdQpTWsHQKGBT1eYfWoR/dsd3R1Qw0p1/QdjrRwe0VyQLMUVxKR/RQJZEcKVfyjiICEO4Ohck6QmyA6MRhWwKSf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3sMfIXl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3sMfIXl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70761F000E9;
	Sat,  8 Aug 2026 03:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786160486;
	bh=+egxvkdob2ePNh9QOLEcmeK3Dls+Mn404Ma5F4xXm4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R3sMfIXlswlzCy/oO8yFAemPQ3jZ0rir6qFdRnZRhtmfONAPBBSB7MrkudUmh68df
	 85lxOU/539Cu1NiGX9dq3KqhgOkfmQqFknoqxm6gLIDbByvqDXJ33aYb5U/NPhSNDA
	 3s5/qLrvf1eoyh0+kLwWvRGZkyEbuicG+fcHNKrMk4z0dFD6dQiqqN0ybA2EYba+al
	 aFM1AVhP555gXpxlWzT8jxU6+ceNJiVrvUa+wpjOhry4jQUmh4KFzAk0JEn/VaLiZ8
	 Vf1v5DkwJ9IYnXPb9mKvTuvCs0pSjDbwGzfMhrhxcWNMohCxhoJIzyLN47/8bfE447
	 LhxhjOgEnAI7Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 06/11] mptcp: report v4-mapped subflow addrs as IPv4
Date: Sat,  8 Aug 2026 11:40:36 +0800
Message-ID: <933ec45a29ec3764446ef462cef3813d5cdf2689.1786159812.git.tanggeliang@kylinos.cn>
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

mptcp_get_sub_addrs() currently fills sin6_* for any AF_INET6 subflow.
Detect v4-mapped destinations (guarded by CONFIG_IPV6) and reuse the
IPv4 branch so MPTCP_SUBFLOW_ADDRS reports match userspace's view.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 71a4a2aaa838..43a8d1c37137 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1256,10 +1256,15 @@ static int mptcp_getsockopt_tcpinfo(struct mptcp_sock *msk, char __user *optval,
 static void mptcp_get_sub_addrs(const struct sock *sk, struct mptcp_subflow_addrs *a)
 {
 	const struct inet_sock *inet = inet_sk(sk);
+	bool is_v4 = sk->sk_family == AF_INET;
 
 	memset(a, 0, sizeof(*a));
 
-	if (sk->sk_family == AF_INET) {
+#if IS_ENABLED(CONFIG_IPV6)
+	if (!is_v4 && sk->sk_family == AF_INET6)
+		is_v4 = ipv6_addr_v4mapped(&sk->sk_v6_daddr);
+#endif
+	if (is_v4) {
 		a->sin_local.sin_family = AF_INET;
 		a->sin_local.sin_port = inet->inet_sport;
 		a->sin_local.sin_addr.s_addr = inet->inet_rcv_saddr;
-- 
2.53.0

