Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352B53659FB;
	Tue, 18 Aug 2026 06:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787033043; cv=none; b=dlNUy+RqYq8BwSUJoLXsqeAdbYv8ddcadx8gPjsf4AGwiwn6dJdnQke1qLMFw8qlL0uvD+I2YtXZ09HO+21NBz46nAQBJDTkQ9lUkXTtgpgO7khKgGnwLshQ0LvjVD/yD/gCh49Zdj9k7Halx8l4dUzvzxN1k1X1fBcERjThyPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787033043; c=relaxed/simple;
	bh=Z/IR77niDGTQI2i+rwwTaipv6ufjef5SM5qVq8VLSmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLPVt/RBICLsEqfmc8WONib1bwX13A+jnNsP3mHGBqZW7ZP121ek39RZuoDcC56ypvc9oP4T7w9oHJKjmRMLVYzSPrigMHXl7wno/XRGFRqV1yfq7UKxIzQrmIX0+suchLnEiMQHO+FSF4I9jHdPfSBgTsfbtDqYnxM3CrcXySg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWHxdTg9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWHxdTg9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711821F00A3A;
	Tue, 18 Aug 2026 06:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787033041;
	bh=B2O7HteIhiLtqRyn/DIyOgikrgWD4I8OBbeQRR73W8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LWHxdTg90cikKZA64HRhmzVNAddjUJL6WZIMNJ22gDFgJucfSnFcBwSM9x8B/fvWT
	 Q8CnzzRUthtyG67xBv+GsZjfvUwd4U54mjVqrlux1aJmTV2m2OtlKaKF9m0SCxMhYf
	 PIHFoWxBqG6lfRnQixUnyZGoz9WpkUM5bDqO3AU2L/+e+IxZYRhbRhYCabQC7yMah2
	 7DZq+pqCvPCZXKNDyFMBqTCNOeanYn5wSInTcNwzkgmPgQuxR8yy2yzkPj3gUJCZkO
	 0mPMe7zTe7Yb9e+zJQvSdiiaaC/FVLkjAY6+GVNxubrtVH3eGPbunFuKXlv4zcXXZs
	 ApvJwpWoEMi3g==
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
Subject: [PATCH v4 4/4] nvme-tcp: support IPv6 traffic class
Date: Tue, 18 Aug 2026 14:03:03 +0800
Message-ID: <d6095cd3809af7addc44ed162d70d6327dc237ac.1786947923.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786947923.git.tanggeliang@kylinos.cn>
References: <cover.1786947923.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Currently, nvme-tcp host only supports setting the IPv4 TOS value when a
TOS is specified, but does not handle the IPv6 traffic class.

Extend the queue socket setup to handle AF_INET6 sockets by applying the
TOS value to both IPv4 and IPv6 sockets. For IPv6, the TOS value is set
as the IPv6 traffic class via IPV6_TCLASS using do_sock_setsockopt().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/tcp.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 025cade370b2..5f30be04a9dd 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1815,6 +1815,17 @@ static int nvme_tcp_sock_set_tos(struct sock *sk, int tos)
 				  KERNEL_SOCKPTR(&tos), sizeof(tos));
 }
 
+static int nvme_tcp_sock_set_tclass(struct sock *sk, int tclass)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	if (sk->sk_family == AF_INET6)
+		return do_sock_setsockopt(sk->sk_socket, false, SOL_IPV6,
+					  IPV6_TCLASS, KERNEL_SOCKPTR(&tclass),
+					  sizeof(tclass));
+#endif
+	return 0;
+}
+
 static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 				key_serial_t pskid)
 {
@@ -1909,6 +1920,15 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 				qid, ret);
 			goto err_sock;
 		}
+
+		ret = nvme_tcp_sock_set_tclass(queue->sock->sk,
+					       nctrl->opts->tos);
+		if (ret) {
+			dev_err(nctrl->device,
+				"failed to set IPV6_TCLASS on queue %d err %d\n",
+				qid, ret);
+			goto err_sock;
+		}
 	}
 
 	/* Set 10 seconds timeout for icresp recvmsg */
-- 
2.53.0

