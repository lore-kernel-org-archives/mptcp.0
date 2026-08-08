Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9812D376A19;
	Sat,  8 Aug 2026 06:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786172180; cv=none; b=rb18Lhknni/rOtsdQ2SuUPOsj8G9F3NshrHyxjuB4rECYu7YLoJwrvHV9Jgvvn+rnGNIxHF0h1ZOVnylvV1pT0pFFBSksqj+VrUnqCRl07tinBS0w25yPh5dk4W+xj/73GfIC6bTgzuHSPYrbRVHp8rLYPuzsVVhJ2JzTsDZo6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786172180; c=relaxed/simple;
	bh=iKNubltje/DbF0zoiCKsalbe/R4Kp81SgSbhJzRz+tY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vnd3WvQfSFcoBQiR68pY2OoA/5QbGlmeot44bwtX8TaMJd/cCkUbOLkUbsyqxeD1WonNayvV8U1MX80bv8V4lOdpiSbVBauHFmGdffcVLjPHxFJrgYjfOX+iqpUuABs65MunwWy0DN0FedXTnd1Hz+U27OQN18FnM1cZiJWqP0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SH5FOaiU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SH5FOaiU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2063E1F00A3A;
	Sat,  8 Aug 2026 06:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786172179;
	bh=eOli6oQDuvK/j5yjuVJfio8ypK3vDCmN1PA1hPchLUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SH5FOaiUpsypafEkbFKZt/ckxoPTspIen1L9PpnyuZ+1JGdbzIlToLyq8j5gmA+LA
	 uB0Vs/NdC2YBfvenqs+tlajOzBRwjMnrz0DT5om1zNNu4haEW0TpXmwFTnJka4SgBe
	 EBEvUQIsxMqQpjOnM4XjYJZk6kTvxgZTi/bicxiqi5tOpew1dk22k57fvaEOULQVHz
	 QdXHs/jC8f/Y3RHCogjUe2vB6kToSj5LXMH5j2gd5RYviMutF6pdjY77ePBGaE0Q6p
	 nQM0Az1BmI6/LIiiFWCbuuqvScMlMz5OL3pexZmyQcUdm1bDBpGm/frw/zGcT3PbqQ
	 vaCZeOjDPzm2Q==
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
	Hannes Reinecke <hare@suse.de>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH v2 3/3] nvmet-tcp: support IPv6 traffic class
Date: Sat,  8 Aug 2026 14:55:01 +0800
Message-ID: <ef1d3f9cbd321aeb0a49f37685f2fb7e01c60623.1786171863.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786171863.git.tanggeliang@kylinos.cn>
References: <cover.1786171863.git.tanggeliang@kylinos.cn>
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
traffic class from the IPv6 socket's rcv_flowinfo and apply it through
ip6_sock_set_tclass(). Keep the existing IPv4 TOS handling unchanged.

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

