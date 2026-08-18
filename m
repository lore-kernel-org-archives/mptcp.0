Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFE03890EE;
	Tue, 18 Aug 2026 06:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787033035; cv=none; b=kTbrTS+LDSGD8jhYJeHyBfBUUxVRNLTf4mIZ6Poc/Cceix5FqjWzANmcVO5UyAQkfkLgQqcz2h67brocZB9yiEzg8WCc0LLMqdeBprfrlKgPHpOA4CWyxQysaylvzbmzlLOM0n0B9o3PkFsOlrfOLwqaho8KtFpCXxh8wYsGxjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787033035; c=relaxed/simple;
	bh=kKPJGW/oiaUn0VowSlJHbCgeZO9HPFHZc7oXkGBj39w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uNKG9ilZ1jEsOB68xrJDW3Kp/xe2jey9jB+1w0HQKoHHkbfiN/jrZF4qgFxCsQY9SdC1rcbCT0M+weMmIgc8N5oqnlM2z/Zds+8ZZdYcw6TsCfO83Sz3Cw5mO7IwSXG3N2/jm3hpcmeGgPh1qmnuu+auH4rUozP2Ohtlb4frsMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2UdzNx5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2UdzNx5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A441F000E9;
	Tue, 18 Aug 2026 06:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787033033;
	bh=Nis9dfnj0IQkbN06JcjcoUd3EWxyn7iXPcVuP3vmsVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A2UdzNx5HptTFp1gQu4gHG08W2f7E9uDmm+H84rYpZ/MMKbb035eG6R2U3tweQxiz
	 bYwDEhkzx7I6kqFz+0t3tH2Xs74YWxY+uz00woRJt4BQTEtcfhzEfrncajoy6IN4/E
	 1YxfoCTxEQVL0CDJeDaX/GRBHZL/xcpZK3RHLhkFuALkNJchkNObRyl6Ld0qj/Ip/A
	 9tKkD2jh+sLGuWieQCxKqoZW2mbsOXDHEhvAFMPbD9zf4Y3m7efbMH1Bhma2GmlmI2
	 4IH618bfievO8blR167r2NuPqm9yfl30vTAb7nA/F3YUjnARjMGOhjsURM7/ysvvB8
	 IfiT8d1iQc6lg==
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
Subject: [PATCH v4 3/4] nvmet-tcp: support IPv6 traffic class
Date: Tue, 18 Aug 2026 14:03:02 +0800
Message-ID: <bb4e028580bd0198f1dfd63dbd5608c5656cbe26.1786947923.git.tanggeliang@kylinos.cn>
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

Currently, nvmet-tcp only applies the received IPv4 TOS value when setting
up a queue socket, but does not handle the IPv6 traffic class.

Extend the queue socket setup to handle AF_INET6 sockets. Obtain the
traffic class from the IPv6 socket's rcv_flowinfo and apply it through
IPV6_TCLASS using do_sock_setsockopt().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 38b0c446ae89..ed413aa5601c 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1737,6 +1737,22 @@ static int nvmet_tcp_sock_set_tos(struct sock *sk)
 	return 0;
 }
 
+static int nvmet_tcp_sock_set_tclass(struct sock *sk)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	if (sk->sk_family == AF_INET6) {
+		int tclass = ip6_tclass(inet6_sk(sk)->rcv_flowinfo);
+
+		if (tclass > 0)
+			return do_sock_setsockopt(sk->sk_socket, false,
+						  SOL_IPV6, IPV6_TCLASS,
+						  KERNEL_SOCKPTR(&tclass),
+						  sizeof(tclass));
+	}
+#endif
+	return 0;
+}
+
 static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 {
 	struct socket *sock = queue->sock;
@@ -1772,6 +1788,10 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	if (ret)
 		return ret;
 
+	ret = nvmet_tcp_sock_set_tclass(sock->sk);
+	if (ret)
+		return ret;
+
 	ret = 0;
 	write_lock_bh(&sock->sk->sk_callback_lock);
 	if (sock->sk->sk_state != TCP_ESTABLISHED) {
-- 
2.53.0

