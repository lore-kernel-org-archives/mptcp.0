Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C944330C143
	for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 03:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786939052; cv=none; b=HYMfL+rRIJg6s3BhWnx8WW9YdN5V8MxALa0dDxtkZZntdqlMUAGMXa1RsydY/vAwVKk48E7UqE9tRmMK2eXj7gkAdNgeqYKVvwGPxS1JAtzOMYZBtAbSubN4CZVdTDwY3gY+K5QSwIXCadPPHoSqjjsP0ccpT2B9gB9IaNX+E74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786939052; c=relaxed/simple;
	bh=RcA4ET0WURNa3DxKzaK1SsuKLm0cLwCR4pqv9U2ndRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3d3h9ZvakX56EZ0vwr/F3LYjUCEbfiTpg2zyWochdCElSV1QrcVl/roeMZpsDbFJBhWyIhf3nSNRXL+WXP/Gshczq5LzaaB9J7wBDmDhfRH7Gl+rSLd7A+LxDVbtFzS1tXU56quC8zPkKHsBUFBy+tDey08XlixeP1shyWVtY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZW1iI+FS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZW1iI+FS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A578D1F00A3A;
	Mon, 17 Aug 2026 03:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786939050;
	bh=8C4HAYjLcPN57L64JKI3QjIt7htAu7/bHtTqRLzZ90c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZW1iI+FSeOg3WhD1/NC8aYZmhemt3rGUHu9Rxu8qyTmtBS5YnQwo9HGpPaAiGXxOp
	 GiuPwEyL4AluODoPs1SoFOZ68fWgbDwZzHpZTq0zryqQn8ktWorQylyCQLDbMEBlDh
	 N7cFsp0wKc5cUKbjIZWwUFgqGo88VQFU8zrqJl8ya8z21M/Tpnwp6h7wXvU/k/iJZ2
	 ezkTJtUBMnJxz9IbpnidDyit9bhdDWAp8F+xidPfA9IcqWT6qsvjRbUfp9DP9yPxLX
	 7rRJf4RlxQVSVpZ8eor7TKRo4h7beC/9nr0E8dBzvzFM3SXk+6VfuC25P0RApfwbWz
	 gJCjjnSZVzEmA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 6/6] mptcp: copy subflow's tos/tclass to msk on accept
Date: Mon, 17 Aug 2026 11:57:13 +0800
Message-ID: <0ae5cedc96502c3a89a573b386ce21c017c9bd6c.1786938892.git.tanggeliang@kylinos.cn>
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
 net/mptcp/protocol.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c2762d74f29d..f18af725e8e2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3756,6 +3756,22 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 #endif
 		mptcp_copy_ip_options(nsk, sk);
 
+	if (ssk->sk_family == AF_INET) {
+		inet_sk(nsk)->rcv_tos = inet_sk(ssk)->rcv_tos;
+		__ip_sock_set_tos(nsk, inet_sk(ssk)->tos);
+	}
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	else if (ssk->sk_family == AF_INET6 &&
+		 ipv6_addr_v4mapped(&ssk->sk_v6_daddr)) {
+		inet_sk(nsk)->rcv_tos = inet_sk(ssk)->rcv_tos;
+		__ip_sock_set_tos(nsk, inet_sk(ssk)->tos);
+		inet6_sk(nsk)->rcv_flowinfo = 0;
+	} else if (ssk->sk_family == AF_INET6) {
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

