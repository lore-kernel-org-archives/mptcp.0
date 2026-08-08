Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFC637E5F2
	for <mptcp@lists.linux.dev>; Sat,  8 Aug 2026 03:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786160497; cv=none; b=rx8d5nMj+W60wlHhEjcBVIte++wRGQw4TjPXez8GboGO0SDSm/sH1U7fN+4lhZavtoJHIftv9bmidzYuUsjsT53tWbHdjYwn16U6MiazbiZ5SWawLmgJXC+y4hM8/4veg8vPGfDLWtQ+MNF6Z44ez/jHLAI6el1ZFCfi1hZZD4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786160497; c=relaxed/simple;
	bh=8vg2WGr9hEIywdtIeTvOSrU/IjHQ2RPpSpzBWlm855w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kc5PhTEJhwOkGZzYtmFzd5JAxflH74xJlmwNvPtGMKUzzVIZjyLkQc6T8ugK/2iNPAMqBw+YGZsRRz38PpZrnKAzlcadv0qGQR/Z0vlqOyK21OExnNtqtSYJQTw6rH4At1wR89MDtjrSYZsjmXrcUrCKZ48a163VWEIU4aqhuVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6IO/nBx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6IO/nBx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3318E1F00A3A;
	Sat,  8 Aug 2026 03:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786160496;
	bh=5Xei/qy1FGyVm5DbbVth3b6+3M6xr4VqNW3HpY2bZqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D6IO/nBxCNSMZ87eoaXu6oLoeWWD4+bNg+Pgfjv8WxK2+Sl937EXYYJx3ZZqFn/Jr
	 FH6tk/P7m76HXpMZ/qySFgvrtuIVzuyAKetPKb04d2VtP3lKtKTmxh6DwcbEmfWqjb
	 EQDdYlLO9G1SQ/w3dYOXqs7FtRgpu0yUvfuCauwDYOdg+ooailPIV/JZUuAfV1GLNC
	 KyftB2oQAM2lk+YdE2tAwTy+MR+nCLdK2ddwx8Sz2GRunLaR+v1uPo7N+oc7JSbsZZ
	 K3DjIK872pyhRaMjckMbKyM63rmCrlh3Oa5mJgbeGvRRZeEbddyVr1eJHXtKaogcGQ
	 1SZQF9kNzW5Sw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 11/11] nvmet-tcp: support IPv6 traffic class
Date: Sat,  8 Aug 2026 11:40:41 +0800
Message-ID: <6ef81d4719c74d61becac8693bd7d66b417a938a.1786159812.git.tanggeliang@kylinos.cn>
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

nvmet-tcp currently applies the received IPv4 TOS value when setting
up a queue socket, but does not handle the IPv6 traffic class.

Extend the queue socket setup to handle AF_INET6 sockets. Obtain the
traffic class from the IPv6 socket and apply it through IPV6_TCLASS.
Keep the existing IPv4 TOS handling unchanged.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 75a276d73be3..1d65519ebc0f 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1725,6 +1725,14 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	/* Set socket type of service */
 	if (inet->rcv_tos > 0)
 		ip_sock_set_tos(sock->sk, inet->rcv_tos);
+#if IS_ENABLED(CONFIG_IPV6)
+	if (sock->sk->sk_family == AF_INET6) {
+		u8 rcv_tclass = ip6_tclass(inet6_sk(sock->sk)->rcv_flowinfo);
+
+		if (rcv_tclass > 0)
+			ip6_sock_set_tclass(sock->sk, rcv_tclass);
+	}
+#endif
 
 	ret = 0;
 	write_lock_bh(&sock->sk->sk_callback_lock);
-- 
2.53.0

