Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BFD18C933;
	Sun, 16 Aug 2026 01:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786842078; cv=none; b=aQr3W2rkZipn/26tjMcvPW/P6S9iLs4YfUqGfixUqAdVf9Gm/7PWolRwuz3x/ScrP9cl1/fME4XaUCvagC/xWOi9PiY3PvD3IzwBHV5rW1x0dE9zCBe8CR9d5X/FExAc9URG83W7UMlvSgcHgkv9rab72dOSJf/zdK6J3pzyqrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786842078; c=relaxed/simple;
	bh=XMQbsP/XH9XBdepiOX8u0kubmj+K+svPOS/T6k91gb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3Q2tmVN2GxxKR0+jaNcb97/vo2aetyrCQ0LjAGqxViE2xew0P1KGRI6NmQoJfdQWCWyNvWC/RzmV1e7u/LF61vrepR9Q6uRYBrF7EyDX2CBb1pN8x9OHVDZ6xrjHrsquUhoRpRXHuJVk5eBFB66iT2LlY4CSFrlrQS7omeUkt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZzfWCN2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZzfWCN2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B81B1F00A3A;
	Sun, 16 Aug 2026 01:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786842077;
	bh=RFXP0uhwAIzZtIngeZhsEQVAe4WY8w8ld85w5SPVvnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IZzfWCN26y/4FFAh3KmtR6wnGQfgSI7qLm8tekTQKMrp7pDLOYLGQieGL8fw+Kxoh
	 f3rHL49Hzgg/XOzJGn1ETRU6I0MLipzLtLXr+qXiXw+pVkBBR6Shb16LtA8hV7tUAO
	 BIlnCYcxdZNf1mYbxY0purE4aq8+NH3x8P19XFuCA+XFzDpXAv4o3zn1xur14snJ1+
	 TpLvLW8FL1kPptbwPJDOLBcZo3E777b02b4CUJtAi4y+5fmc+nvPMZJNXaMXuNBPby
	 TsR7JUjLFd3TGu0lXS7fF9IVcJjV2nBrLTpMQ1TM+eZGekNLmBBOAYPb20bFCpxC35
	 asA0IsblR8RaA==
From: Geliang Tang <geliang@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH v3 3/4] nvmet-tcp: support IPv6 traffic class
Date: Sun, 16 Aug 2026 08:59:59 +0800
Message-ID: <7d09c3211dfa76d536c7a30505cea6da626ee5e6.1786841319.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786841319.git.tanggeliang@kylinos.cn>
References: <cover.1786841319.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Currently, nvmet-tcp only applies the received IPv4 TOS value when setting
up a queue socket, but does not handle the IPv6 traffic class.

Extend the queue socket setup to handle AF_INET6 sockets. Obtain the
traffic class from the IPv6 socket's rcv_flowinfo and apply it through
IPV6_TCLASS using do_sock_setsockopt().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index e64592b79257..d34249cf3756 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1735,6 +1735,20 @@ static void nvmet_tcp_sock_set_tos(struct sock *sk)
 				   KERNEL_SOCKPTR(&tos), sizeof(tos));
 }
 
+static void nvmet_tcp_sock_set_tclass(struct sock *sk)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	if (sk->sk_family == AF_INET6) {
+		u8 tclass = ip6_tclass(inet6_sk(sk)->rcv_flowinfo);
+
+		if (tclass > 0)
+			do_sock_setsockopt(sk->sk_socket, false, SOL_IPV6,
+					   IPV6_TCLASS, KERNEL_SOCKPTR(&tclass),
+					   sizeof(tclass));
+	}
+#endif
+}
+
 static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 {
 	struct socket *sock = queue->sock;
@@ -1762,6 +1776,7 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 
 	/* Set socket type of service */
 	nvmet_tcp_sock_set_tos(sock->sk);
+	nvmet_tcp_sock_set_tclass(sock->sk);
 
 	ret = 0;
 	write_lock_bh(&sock->sk->sk_callback_lock);
-- 
2.53.0

