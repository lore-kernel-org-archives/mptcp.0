Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED4D32693C
	for <mptcp@lists.linux.dev>; Mon,  9 Feb 2026 09:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770627884; cv=none; b=RyCstcGvvcJ0tfWw7t2jX7zw11s5NU/y6oV69q6B1IZd552wVwgbTciVSMpjZWO5ZDP8L2lGOT8UJncHydzNGSxCOvCAYhS95FV/xTYtVUkWxvu7i3s8xHqq7tuadWUSy71MJ45Sm98JAqH9KHunqDf9S080k4iZMms8YkwtdAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770627884; c=relaxed/simple;
	bh=o7WBTFm0ga9ohCpVftjxE/9pYvs1PqJHdLZao8nnits=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnXL8hm0TkOVLpELBnHPqjVwYdj/C7e5yw0YpqjpsgTCw+1YZvocF1WiB0O7VEHOQQKbmwSSrpFWzeFGGbs3iJDu8LO4+YIA7SekfGcCCN6Hm98yP/PxDAT0bbwGmHynoIB5mHUkzMNxUPxJMa55UG1OMUzo3jLrthv3H+thghM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSj6yNuR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSj6yNuR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2989C19424;
	Mon,  9 Feb 2026 09:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770627883;
	bh=o7WBTFm0ga9ohCpVftjxE/9pYvs1PqJHdLZao8nnits=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CSj6yNuR5xeJqKQflgWZb1ENLR3SXV7c+Sqprp4FGhOYy048v0t/IcKJ+OuKf3NJS
	 bZz+d0R8GXrymCsQubDNBg/YV/yBy+GeB/n0uiZuLf9BM/NTU6tvlne+fhRwUbD4hP
	 no5AmQwF5Be8h3m/kwJyeyHFRnbzrNrp+Wr4mMcDW6kd1h7vrABiDGasdcNCi0sQFC
	 /hfs2gS4IIsSZ9z968netqROrI8zubtGFivsD7oQemPKOtJPMNJzFI+oXW/hzfeCYG
	 ovyKInvjBYkTmH4s5qarpRmPRGyvOhkmhwgXlgRI0PX8baL6Nn42SyWb8u7DxOnQIk
	 kYLgzVuDpTcKA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v3 4/7] mptcp: add sock_set_nodelay
Date: Mon,  9 Feb 2026 17:04:19 +0800
Message-ID: <a41c967c8157e54bf61c027e511893a5c5cedc50.1770627071.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1770627071.git.tanggeliang@kylinos.cn>
References: <cover.1770627071.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch introduces an MPTCP-specific helper, mptcp_sock_set_nodelay,
which sets the TCP_NODELAY option for every subflow socket within an
MPTCP connection. It is utilized on both the target and host sides in
the 'NVMe over MPTCP' implementation.

Using tcp_sock_set_nodelay() with MPTCP will cause list corruption:

  nvmet: adding nsid 1 to subsystem nqn.2014-08.org.nvmexpress.mptcpdev
  nvmet_tcp: enabling port 1234 (127.0.0.1:4420)
   slab MPTCP start ffff8880108f0b80 pointer offset 2480 size 2816
  list_add corruption. prev->next should be next (ffff8880108f1530), but
  was ffff8885108f1530. (prev=ffff8880108f1530).
  ------------[ cut here ]------------
  kernel BUG at lib/list_debug.c:32!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  CPU: 1 UID: 0 PID: 182 Comm: nvme Not tainted 6.16.0-rc3+ #1 PREEMPT(full)
  Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011

Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/tcp.c   |  2 ++
 drivers/nvme/target/tcp.c |  2 ++
 include/net/mptcp.h       |  4 ++++
 net/mptcp/protocol.c      | 17 +++++++++++++++++
 4 files changed, 25 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 40d96a77618a..6188e01b85db 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1810,6 +1810,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	tcp_sock_set_syncnt(queue->sock->sk, 1);
 
 	/* Set TCP no delay */
+	sk_is_msk(queue->sock->sk) ?
+	mptcp_sock_set_nodelay(queue->sock->sk) :
 	tcp_sock_set_nodelay(queue->sock->sk);
 
 	/*
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 05718103649b..488f6161d5ae 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2071,6 +2071,8 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	port->data_ready = port->sock->sk->sk_data_ready;
 	port->sock->sk->sk_data_ready = nvmet_tcp_listen_data_ready;
 	sock_set_reuseaddr(port->sock->sk);
+	sk_is_msk(port->sock->sk) ?
+	mptcp_sock_set_nodelay(port->sock->sk) :
 	tcp_sock_set_nodelay(port->sock->sk);
 	if (so_priority > 0)
 		sock_set_priority(port->sock->sk, so_priority);
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 82660374859a..60cbf29448b0 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -244,6 +244,8 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
 }
 
 void mptcp_active_detect_blackhole(struct sock *sk, bool expired);
+
+void mptcp_sock_set_nodelay(struct sock *sk);
 #else
 
 static inline void mptcp_init(void)
@@ -335,6 +337,8 @@ static inline struct request_sock *mptcp_subflow_reqsk_alloc(const struct reques
 static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return htonl(0u); }
 
 static inline void mptcp_active_detect_blackhole(struct sock *sk, bool expired) { }
+
+static inline void mptcp_sock_set_nodelay(struct sock *sk) { }
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 25ed246db7fb..661a27a27b1a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3806,6 +3806,23 @@ static void mptcp_sock_check_graft(struct sock *sk, struct sock *ssk)
 	}
 }
 
+void mptcp_sock_set_nodelay(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+
+	lock_sock(sk);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		lock_sock(ssk);
+		__tcp_sock_set_nodelay(ssk, true);
+		release_sock(ssk);
+	}
+	release_sock(sk);
+}
+EXPORT_SYMBOL(mptcp_sock_set_nodelay);
+
 bool mptcp_finish_join(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-- 
2.53.0

