Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA432279DC3;
	Sun, 16 Aug 2026 01:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786842066; cv=none; b=RrZg6+V33VpjrURQhtxtvlUkn43lACZ6CgRnLZ+PCklBZVm/o8Fo3G0vDuWQjR3l3qE0Xg1jUjA0rQzP4llCU9qkSH9UAPFmfZoFI40W+Ohfs8AAbR0zIqmEllRx6Ze9w1J9L2kicHI3ejxZwx78jcv5RY6tzp9pfDsm4dJ9L48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786842066; c=relaxed/simple;
	bh=UssxxIUH/KUZSgyH+QMNkudEWXRiRa2Xo0fwmc7xaC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/ZVJoBWUk0/iSkUuG+TQNQDRJLdvkDkgtP56GbXkoE9+sDEyuVg593DsLPDJim+Xt0OnXsEc2KvS5suNj9DSJFx/w3Zw8HY12ckex+PJdGOsqO6Mc/gH2VaukOe1QKQflYn/qIwiAU8TV2j9AwHddscQ200pHoeVXUItt2bDk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSM5fBhb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSM5fBhb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3815D1F000E9;
	Sun, 16 Aug 2026 01:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786842064;
	bh=7YtFNhH3aq+pBVyobarzrZt+vKIeq8cSqiWKG06sDFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bSM5fBhbA/EbbP2ity52Efrpr6QVWt92jSJ6knuJvwAeNPIGJ5pPMgfR35B8YgcRa
	 cxJ2G68InMgUgFs5CF9tM0Y/Iqu/J3v/UNpoHzcYYiOV+SgoSY4uWo/oACJkBs3x7G
	 eyvGkcmKf8pSjARwJG/Lkaj67YZz2yjffhbs+QX46s38B1QjD8S93s1A4qRS26dmdn
	 Z+ucTsOC0iLoSgVMO8pF18/2OLb3V1Vyga9WWntJr4FZCZlyHNuEIzoBWF4pDQebch
	 P6yh/SL/N4cI8Y0aQSn/3r4j9159mP7QnpwdJt6lgncwtVkrzFuIz2MiKY7rgW/ihu
	 uIIGMPKnPoKFQ==
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
Subject: [PATCH v3 2/4] nvme-tcp: unify sockopt with do_sock_setsockopt
Date: Sun, 16 Aug 2026 08:59:58 +0800
Message-ID: <97e667df6c3755d1f9e2e709dfa1dc64903317e1.1786841319.git.tanggeliang@kylinos.cn>
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

This patch consolidates socket option settings in nvme-tcp by utilizing
the generic do_sock_setsockopt() helper for options including SO_LINGER,
SO_PRIORITY, TCP_NODELAY, IP_TOS, SO_BINDTODEVICE, and TCP_SYNCNT.

Compared to the target-side implementation, this patch additionally
converts SO_BINDTODEVICE and TCP_SYNCNT to use the same unified mechanism.
This change eliminates the need to export and use specialized helpers for
each individual socket option.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/tcp.c | 55 +++++++++++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ba5c7b3e2a7c..89a82e8248d2 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1774,6 +1774,47 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 	return ret;
 }
 
+static void nvme_tcp_sock_no_linger(struct sock *sk)
+{
+	struct linger ling = { .l_onoff = 1, .l_linger = 0 };
+
+	do_sock_setsockopt(sk->sk_socket, false, SOL_SOCKET, SO_LINGER,
+			   KERNEL_SOCKPTR(&ling), sizeof(ling));
+}
+
+static void nvme_tcp_sock_set_priority(struct sock *sk, u32 priority)
+{
+	do_sock_setsockopt(sk->sk_socket, false, SOL_SOCKET, SO_PRIORITY,
+			   KERNEL_SOCKPTR(&priority), sizeof(priority));
+}
+
+static int nvme_tcp_sock_set_bindtodevice(struct sock *sk, char *iface)
+{
+	return do_sock_setsockopt(sk->sk_socket, false, SOL_SOCKET,
+				  SO_BINDTODEVICE, KERNEL_SOCKPTR(iface),
+				  strlen(iface));
+}
+
+static void nvme_tcp_sock_set_nodelay(struct sock *sk)
+{
+	int val = 1;
+
+	do_sock_setsockopt(sk->sk_socket, false, SOL_TCP, TCP_NODELAY,
+			   KERNEL_SOCKPTR(&val), sizeof(val));
+}
+
+static int nvme_tcp_sock_set_syncnt(struct sock *sk, int val)
+{
+	return do_sock_setsockopt(sk->sk_socket, false, SOL_TCP, TCP_SYNCNT,
+				  KERNEL_SOCKPTR(&val), sizeof(val));
+}
+
+static void nvme_tcp_sock_set_tos(struct sock *sk, int tos)
+{
+	do_sock_setsockopt(sk->sk_socket, false, SOL_IP, IP_TOS,
+			   KERNEL_SOCKPTR(&tos), sizeof(tos));
+}
+
 static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 				key_serial_t pskid)
 {
@@ -1819,24 +1860,24 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 #endif
 
 	/* Single syn retry */
-	tcp_sock_set_syncnt(queue->sock->sk, 1);
+	nvme_tcp_sock_set_syncnt(queue->sock->sk, 1);
 
 	/* Set TCP no delay */
-	tcp_sock_set_nodelay(queue->sock->sk);
+	nvme_tcp_sock_set_nodelay(queue->sock->sk);
 
 	/*
 	 * Cleanup whatever is sitting in the TCP transmit queue on socket
 	 * close. This is done to prevent stale data from being sent should
 	 * the network connection be restored before TCP times out.
 	 */
-	sock_no_linger(queue->sock->sk);
+	nvme_tcp_sock_no_linger(queue->sock->sk);
 
 	if (so_priority > 0)
-		sock_set_priority(queue->sock->sk, so_priority);
+		nvme_tcp_sock_set_priority(queue->sock->sk, so_priority);
 
 	/* Set socket type of service */
 	if (nctrl->opts->tos >= 0)
-		ip_sock_set_tos(queue->sock->sk, nctrl->opts->tos);
+		nvme_tcp_sock_set_tos(queue->sock->sk, nctrl->opts->tos);
 
 	/* Set 10 seconds timeout for icresp recvmsg */
 	queue->sock->sk->sk_rcvtimeo = 10 * HZ;
@@ -1864,10 +1905,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 
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

