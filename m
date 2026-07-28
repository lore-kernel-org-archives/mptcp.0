Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418073D0930
	for <mptcp@lists.linux.dev>; Tue, 28 Jul 2026 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785238831; cv=none; b=hvilmKyWmFqmf4cYMYtkcI/BK0dVv8BdiCNQ/LEDyEq4gSbI8VeyssmFanWdBGgNqS8jhaDW1tJNnHQCcd1oGIDYm6TzBa1YhA/ugIxzz4lNXfGRstGpOq1GSl5QaxXaz7nAyz934WjqlzpPP2p89CjT6LCMrJUfcTTgTil6BqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785238831; c=relaxed/simple;
	bh=+7CRiwnxuHoLwr7WcT/rInVjdEOX0bFMa5dd7l4MLLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oog+y20PnK5jHkF0Ejt6SMNnuD2s07FsDMZSlE7x8of7AvtXi12vaWQSxF+O0TCKvjCeYNPUvpsjLM4mzGhVjnjSiZ+Qb/42MzBQgS9pdz3CaorpNc9ZeWyY63o7mJ8nM9JVF5hJJ7DTj5tnlhQ/OFVZwEPz6B1T8MSCfYpngxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLJnkTK2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLJnkTK2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7701F00A3D;
	Tue, 28 Jul 2026 11:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785238829;
	bh=Hj5gKs7hvWneVEMpjZqbbE7be+btTBdPn9D/aUYhVK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dLJnkTK29WNM6fOllDkRgLSbzRXJ3rItqbguUsM9nGlxsurgFrP3t55OWlXV+m9PG
	 1m5W5YHAJSHe1tl98VEfeQUpgbXweZwRLrHlg1pF46JdGNTGlB1Ay6c8kF4xHuOXuZ
	 oXE3aIbTTv6dBjqJGylThMTZDSiIWPi4QUNk+PRIWo/iK8gL/9Obg4wxvkWj4R2y3B
	 nHUTcxKds6FrCGfUUwTzH8JZ7cB2HrTCpfJDevHSZTBevuSrMwl+QuKwq9USIJozpl
	 IGb/73T8OUxH30fKNDcu54B1yyWM64gAeJiiHAGhLFx8n4LpkhCYNJ6TLWNHaha2HW
	 6O34L6qlYT/nQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 9/9] mptcp: copy the subflow's tos/tclass to the msk on accept
Date: Tue, 28 Jul 2026 19:39:42 +0800
Message-ID: <1154f727f96c3edd101c27eb4a68b100b8d69b2b.1785238723.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785238723.git.tanggeliang@kylinos.cn>
References: <cover.1785238723.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

When a new MPTCP socket is accepted, copy the tos (and rcv_tos for IPv4)
or tclass (and rcv_flowinfo for IPv6) from the first subflow to the
newly-created msk.

This mirrors what plain TCP does in tcp_v4_syn_recv_sock() and
tcp_v6_syn_recv_sock(), where these values are copied from the incoming
skb to the accepted socket.

Without this, MP_JOIN subflows created later would inherit tos/tclass=0
from the msk and lose the peer's reflected value, causing inconsistent
traffic class behavior.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 954e20bb27de..749abfc28987 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3699,6 +3699,17 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 #endif
 		mptcp_copy_ip_options(nsk, sk);
 
+	if (ssk->sk_family == AF_INET) {
+		inet_sk(nsk)->rcv_tos = inet_sk(ssk)->rcv_tos;
+		__ip_sock_set_tos(nsk, inet_sk(ssk)->tos);
+	}
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	else if (ssk->sk_family == AF_INET6) {
+		inet6_sk(nsk)->rcv_flowinfo = inet6_sk(ssk)->rcv_flowinfo;
+		__ip6_sock_set_tclass(nsk, inet6_sk(ssk)->tclass);
+	}
+#endif
+
 	msk = mptcp_sk(nsk);
 	WRITE_ONCE(msk->local_key, subflow_req->local_key);
 	WRITE_ONCE(msk->token, subflow_req->token);
-- 
2.53.0

