Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB75218B0A;
	Tue, 18 Aug 2026 06:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787033026; cv=none; b=MrIUldFAk4aKNS7fsskd8BxJmas5nB2LBErUfZSUBKGhcQm9n8TM06skI+2TYroDcrv2nyyZ5MGFAtrVSsJrLLRBuDprJYCJb8T3tUXxJiRHrYO7AhmvvPqBRAL1TQJxwRgDDfxafpkW9S/E7T1IoPB2DI44HHn5X5aP26XtiXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787033026; c=relaxed/simple;
	bh=Qq64n4tLRPSTw6ELD6YkUu6/mLx0g+C2oHXtJpaqH/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SEUw6g/QBZI9u2khiFbE7UX4MNLvnAg5I/KZLyso4hiXHVl7dOwYe3Wmf4kuHV9YVlXhy/a581C3B0gxyKlMWeeXl0ldSMn1tm7mOnSdlEhSofTsfxetNVkFxV5cSM9ymjSkfgu0d822iqz0fDrb4aRBy4Pk7x10q/NWgaH8Ib0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5xYytDT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5xYytDT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191A01F00A3E;
	Tue, 18 Aug 2026 06:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787033024;
	bh=bVkuvMHFLexS/2qWy9M58HdBBKwviyPo8XyjkbRCihA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a5xYytDTVyISZUZxjM7M60SlySDlqJoHK1wUwvYsbsWMK/COfvRZ1ttlp+V9lutq7
	 Aijd9f7eNt/QWOUR27Y3VdTj3L9ivz2O9umGUipBouRt6qGlmcVbKU48G0PHGbEryu
	 uHIltNQySmPYbCugrygpF6UhyZQAmb622M1mTrTUYvYR33zOa0dvdHVm+OmdwB0roN
	 5legOzmGFKhJYZlNjvn2uhsEsvSq0uBZEculz9GvYASUVOoehe9pQFq/pmrOtIcmuy
	 mF9xaF44zNRLR/0U6H1FNuVQcuS846xSg5FW4sLxo4VOA/5ovqDYTlXvV0kWJM/Hkh
	 aL24FIA84z+pQ==
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
Subject: [PATCH v4 2/4] nvme-tcp: unify sockopt with do_sock_setsockopt
Date: Tue, 18 Aug 2026 14:03:01 +0800
Message-ID: <5d77334ae43750d8c12923148d71077301242c89.1786947923.git.tanggeliang@kylinos.cn>
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

This patch consolidates socket option settings in nvme-tcp by utilizing
the generic do_sock_setsockopt() helper for options including SO_LINGER,
SO_PRIORITY, TCP_NODELAY, IP_TOS, SO_BINDTODEVICE, and TCP_SYNCNT.

Compared to the target-side implementation, this patch additionally
converts SO_BINDTODEVICE and TCP_SYNCNT to use the same unified mechanism.
This change eliminates the need to export and use specialized helpers for
each individual socket option.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/tcp.c | 91 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 81 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ba5c7b3e2a7c..025cade370b2 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1774,6 +1774,47 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 	return ret;
 }
 
+static int nvme_tcp_sock_no_linger(struct sock *sk)
+{
+	struct linger ling = { .l_onoff = 1, .l_linger = 0 };
+
+	return do_sock_setsockopt(sk->sk_socket, false, SOL_SOCKET, SO_LINGER,
+				  KERNEL_SOCKPTR(&ling), sizeof(ling));
+}
+
+static int nvme_tcp_sock_set_priority(struct sock *sk, u32 priority)
+{
+	return do_sock_setsockopt(sk->sk_socket, false, SOL_SOCKET, SO_PRIORITY,
+				  KERNEL_SOCKPTR(&priority), sizeof(priority));
+}
+
+static int nvme_tcp_sock_set_bindtodevice(struct sock *sk, char *iface)
+{
+	return do_sock_setsockopt(sk->sk_socket, false, SOL_SOCKET,
+				  SO_BINDTODEVICE, KERNEL_SOCKPTR(iface),
+				  strlen(iface));
+}
+
+static int nvme_tcp_sock_set_nodelay(struct sock *sk)
+{
+	int val = 1;
+
+	return do_sock_setsockopt(sk->sk_socket, false, SOL_TCP, TCP_NODELAY,
+				  KERNEL_SOCKPTR(&val), sizeof(val));
+}
+
+static int nvme_tcp_sock_set_syncnt(struct sock *sk, int val)
+{
+	return do_sock_setsockopt(sk->sk_socket, false, SOL_TCP, TCP_SYNCNT,
+				  KERNEL_SOCKPTR(&val), sizeof(val));
+}
+
+static int nvme_tcp_sock_set_tos(struct sock *sk, int tos)
+{
+	return do_sock_setsockopt(sk->sk_socket, false, SOL_IP, IP_TOS,
+				  KERNEL_SOCKPTR(&tos), sizeof(tos));
+}
+
 static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 				key_serial_t pskid)
 {
@@ -1819,24 +1860,56 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 #endif
 
 	/* Single syn retry */
-	tcp_sock_set_syncnt(queue->sock->sk, 1);
+	ret = nvme_tcp_sock_set_syncnt(queue->sock->sk, 1);
+	if (ret) {
+		dev_err(nctrl->device,
+			"failed to set TCP_SYNCNT on queue %d err %d\n",
+			qid, ret);
+		goto err_sock;
+	}
 
 	/* Set TCP no delay */
-	tcp_sock_set_nodelay(queue->sock->sk);
+	ret = nvme_tcp_sock_set_nodelay(queue->sock->sk);
+	if (ret) {
+		dev_err(nctrl->device,
+			"failed to set TCP_NODELAY on queue %d err %d\n",
+			qid, ret);
+		goto err_sock;
+	}
 
 	/*
 	 * Cleanup whatever is sitting in the TCP transmit queue on socket
 	 * close. This is done to prevent stale data from being sent should
 	 * the network connection be restored before TCP times out.
 	 */
-	sock_no_linger(queue->sock->sk);
+	ret = nvme_tcp_sock_no_linger(queue->sock->sk);
+	if (ret) {
+		dev_err(nctrl->device,
+			"failed to set SO_LINGER on queue %d err %d\n",
+			qid, ret);
+		goto err_sock;
+	}
 
-	if (so_priority > 0)
-		sock_set_priority(queue->sock->sk, so_priority);
+	if (so_priority > 0) {
+		ret = nvme_tcp_sock_set_priority(queue->sock->sk, so_priority);
+		if (ret) {
+			dev_err(nctrl->device,
+				"failed to set SO_PRIORITY on queue %d err %d\n",
+				qid, ret);
+			goto err_sock;
+		}
+	}
 
 	/* Set socket type of service */
-	if (nctrl->opts->tos >= 0)
-		ip_sock_set_tos(queue->sock->sk, nctrl->opts->tos);
+	if (nctrl->opts->tos >= 0) {
+		ret = nvme_tcp_sock_set_tos(queue->sock->sk, nctrl->opts->tos);
+		if (ret) {
+			dev_err(nctrl->device,
+				"failed to set IP_TOS on queue %d err %d\n",
+				qid, ret);
+			goto err_sock;
+		}
+	}
 
 	/* Set 10 seconds timeout for icresp recvmsg */
 	queue->sock->sk->sk_rcvtimeo = 10 * HZ;
@@ -1864,10 +1937,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 
 	if (nctrl->opts->mask & NVMF_OPT_HOST_IFACE) {
 		char *iface = nctrl->opts->host_iface;
-		sockptr_t optval = KERNEL_SOCKPTR(iface);
 
-		ret = sock_setsockopt(queue->sock, SOL_SOCKET, SO_BINDTODEVICE,
-				      optval, strlen(iface));
+		ret = nvme_tcp_sock_set_bindtodevice(queue->sock->sk, iface);
 		if (ret) {
 			dev_err(nctrl->device,
 			  "failed to bind to interface %s queue %d err %d\n",
-- 
2.53.0

