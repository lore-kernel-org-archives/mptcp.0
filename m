Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1AB331EA8
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 02:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785380067; cv=none; b=pSf9bRWtdHrmDqcvCqLIeDrrwHM2r4WtZjDtQ1JddfttKeiRCpcGBwi0o5KHD6k4Ii8POTZXT/NWI9OJxennevT8RmTEGEd7xvyrbxUY4BxSk0MMJhdciICF4Hol2cpaiqPbN5DWCagd4f73jyCDto5jGClrDdvOJv3talLgjgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785380067; c=relaxed/simple;
	bh=KRPh7fISW5NMLh5Vzahx09rCQt+9Yh5tDak4XkwJJiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMDoTHqqrjuGnrmY/jGofxm4Yvxa0z1dXbiMeePMQnXzfGLrS2v+vJNrzI/LqVgse7azfBnhqDBWvwKQCyNF3VPoE7d4cHF3aOtuqWZcIDMAEqLpMQRRfJ+XK1BApaInKpjd4med24juUoNI8YNw1P0vNGrZyMxKr1N9dRUyY60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afkO11/A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afkO11/A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87BF1F00A3A;
	Thu, 30 Jul 2026 02:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785380066;
	bh=9MRMLyR4gDDDsa0qYB4qq0t3wlbO7Eh+ftCeQ0k2BlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=afkO11/ACYPb93bE/mx+5pdKSq5wAau5KaZM6j/zj+uagmy8biFJL0IMJeo0XLuGP
	 +pNnnSlscVc+Vut8ITcpHqa89jo7Y03DlWUmXMsd5fDlEqZdZQYtd4Q4zHiEdresHb
	 YozJSIGd0pd6PsTfm0CLZNkHg+thHaoOxCwK8nX5cNeDdrHMETLBjgi8Q+qYTp+4NB
	 7D3TfuSUM+87AWVtI1QhyzMsGTwr6lHmc129ptkCitlMP6iYQh/108fhiE1KkWAH78
	 LHpUwOUmk0ZDbzzKZ5fPlRIHnGCaOWa6jziHAcsaS6MRGBgCYst/x3We1kKjnnQHlo
	 JrO62Yc9cV2pQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 07/10] mptcp: copy the subflow's tos/tclass to the msk on accept
Date: Thu, 30 Jul 2026 10:54:00 +0800
Message-ID: <eb35da8169f0ff292b1f4c023a9e6c47a44ad77c.1785378180.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785378180.git.tanggeliang@kylinos.cn>
References: <cover.1785378180.git.tanggeliang@kylinos.cn>
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
index 90dc894cb976..1544a4e411b5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3706,6 +3706,22 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
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
+	}
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

