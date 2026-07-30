Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDA936F8E7
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 02:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785380073; cv=none; b=QeK6/GSXxn1sS+tsQ8P/NXeUfT5F/r7DqO4fhL85sqc4kQWtIOVU4zjDjhOcQJwqmkz09BVHQc5Nf4EkRXbMfxwDIM8bjRxxD4+0V8HI5I5T02+2aUzMyKT9pHVFJfyuoiwDE8H7K20poX2XDnHCwXPutif+nQ7gfM+ExDhD7Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785380073; c=relaxed/simple;
	bh=ij2Yk5YhHFuMQr9YC3ophp+TBdFRNHp5ZfZRVq8iVWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSQxiAM82YsfEt2UTsTrErdYBh0/zmh3JQe0Zb/mKYaKyt9ku5tD1LNPUXRtl/zIB/ZoEAV31MRnszgtjN0Zjfr6hfVV6ZpcTTCDjAq+JBZh/5LoF4aVl1LgCAUu8CmimQRMFC/1x/g52WQwDk56+SXREcoAQarpO4RExHkC710=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEbC9N6S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEbC9N6S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A1A1F000E9;
	Thu, 30 Jul 2026 02:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785380072;
	bh=QFd3mQMcTQwAZXKmOniaBKEFZgoMzw5MyeZqqxsCm4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AEbC9N6S+GxgePz/7pTeaOmpMHBXqvFPwRYBacIcetokW6iD1LZARUOjg0Uuwb0cn
	 xuUZ9kfbiIhdtKyX5NWUJk5d+KfsMuF9XrK0LEUJ6bA7pElrCKrBHdN2lgTPzTYAE/
	 U6MyxCsoqJs/J1cg9rzWHDqXe7EyqXHpW6yKvs1VZIJYPthKrQOxyCbntX9qJqF/dU
	 MDzcrbH+aTr9l2Idx3NThBtJWmBQmsF/G0y9HjFbRxLwo1BIC7XgpEpW7dwuEen9qf
	 uftD8rk6IUyxjxwOBc6L+oRs6Da6mcItVkKHpATvG3RYRJ9uAUs7eGr8HhPSPuwiVa
	 4NEx9OG9jl7dg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 10/10] nvmet-tcp: support IPv6 traffic class
Date: Thu, 30 Jul 2026 10:54:03 +0800
Message-ID: <0fa74e2213b703f9680ad053196e799cc7111f7b.1785378180.git.tanggeliang@kylinos.cn>
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
index 75a276d73be3..e775c4d3ede6 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1725,6 +1725,14 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	/* Set socket type of service */
 	if (inet->rcv_tos > 0)
 		ip_sock_set_tos(sock->sk, inet->rcv_tos);
+#if IS_ENABLED(CONFIG_IPV6)
+	if (sock->sk->sk_family == AF_INET6) {
+		struct ipv6_pinfo *np = inet6_sk(sock->sk);
+
+		if (np->tclass > 0)
+			ip6_sock_set_tclass(sock->sk, np->tclass);
+	}
+#endif
 
 	ret = 0;
 	write_lock_bh(&sock->sk->sk_callback_lock);
-- 
2.53.0

