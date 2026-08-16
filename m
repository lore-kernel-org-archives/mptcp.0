Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D15A279DC3;
	Sun, 16 Aug 2026 01:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786842088; cv=none; b=J9tHRpL9TyYgI1HszKYIgY/pmKyNL2xVBBF0EZ+Se28x7KLSJpkLDyKaLTDw6anqWSANwm6u19Zh3Ovc5w6nugzo0EIovQ+gjHpHVyt029vLBIVD5HksCGcN8cm5SzHd3nnqXvJOSHTxbueyuG3qO03Yf6YhWVSWzQcZ7dRxmdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786842088; c=relaxed/simple;
	bh=zXDAcRDLBJrRg4o3QL9h9fE4Lo8nThxModYg1NaH38M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZoMcrqDmIXtFy38v56pNcmSPfUmPLXtYYuw1XemDO7pczemcHtydlnZz2JDVmkJdYPKEigfaFnAaNt0itUNsdXdS6OnDdOHHc9RSQNfeJ5U9VpyoN+8ANV6wDxayazay1/Di6F3OUk6ReDqvH6dQLWhMgEJa3AveQVECaw2TtSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czfC8R9y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czfC8R9y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3381F000E9;
	Sun, 16 Aug 2026 01:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786842087;
	bh=M6/oWTjVc32MSJeTmKKP99yPQCYD/FPPYy/T9OozK4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=czfC8R9yOs75jdwhylZECirPrZ5LlFYiOGNl7SyrCzDk/hQEp49PzzjdZsoRTGwyK
	 sxYe6s5mAAvklYBDo5JbOr2JWgxcQBd4Dp+v9Ysdq9Mf/ukqIvSROiEaH2eBoIHLQ8
	 uTbXbz/AO9VNVvCYqxlyy9i4zsrMP83e4ddibTA6P3dp8u5kGNH4n75ZCD2vMn1+7x
	 dlrvIVmOXecnsyxGFX3OhRpNGy4i/oRa27+fanm0ZItA9lg+9zvn2EMcBUlSEF7QCd
	 ja5wozZpXe67dMf7onmYXMRCTur+1KrmXKiSV809R/jUAEBR2On4VqOZ/fMGohj1We
	 EVcPy66PeLaPA==
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
Subject: [PATCH v3 4/4] nvme-tcp: support IPv6 traffic class
Date: Sun, 16 Aug 2026 09:00:00 +0800
Message-ID: <52c4840e36ee6016d18806c2d205f4f9fdc1e830.1786841319.git.tanggeliang@kylinos.cn>
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

Currently, nvme-tcp host only supports setting the IPv4 TOS value when a
TOS is specified, but does not handle the IPv6 traffic class.

Extend the queue socket setup to handle AF_INET6 sockets by applying the
TOS value to both IPv4 and IPv6 sockets. For IPv6, the TOS value is set
as the IPv6 traffic class via IPV6_TCLASS using do_sock_setsockopt().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/tcp.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 89a82e8248d2..657acae9e4a4 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1815,6 +1815,15 @@ static void nvme_tcp_sock_set_tos(struct sock *sk, int tos)
 			   KERNEL_SOCKPTR(&tos), sizeof(tos));
 }
 
+static void nvme_tcp_sock_set_tclass(struct sock *sk, int tclass)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	if (sk->sk_family == AF_INET6)
+		do_sock_setsockopt(sk->sk_socket, false, SOL_IPV6, IPV6_TCLASS,
+				   KERNEL_SOCKPTR(&tclass), sizeof(tclass));
+#endif
+}
+
 static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 				key_serial_t pskid)
 {
@@ -1876,8 +1885,10 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 		nvme_tcp_sock_set_priority(queue->sock->sk, so_priority);
 
 	/* Set socket type of service */
-	if (nctrl->opts->tos >= 0)
+	if (nctrl->opts->tos >= 0) {
 		nvme_tcp_sock_set_tos(queue->sock->sk, nctrl->opts->tos);
+		nvme_tcp_sock_set_tclass(queue->sock->sk, nctrl->opts->tos);
+	}
 
 	/* Set 10 seconds timeout for icresp recvmsg */
 	queue->sock->sk->sk_rcvtimeo = 10 * HZ;
-- 
2.53.0

