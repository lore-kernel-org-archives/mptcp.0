Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C7336881
	for <mptcp@lists.linux.dev>; Thu,  5 Mar 2026 04:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772683559; cv=none; b=W66wLg0U/5GpIppd8k1BECs0Lwsh9O3MRnFsJrdv0JdEM/7FHx4Hj1JX2wgl3iBIcudnwECaicR9zfpjx9pjOUP4C4GCeTQqddmW8XW/jWuUnXNJhX5tZp9d43VNNmIoYl1o4iJlrPjtK+Ez8l0jyExo0IE/8/Syx+y/uZAgV/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772683559; c=relaxed/simple;
	bh=+GVZwWw13FtMFjCyXVQu3iPZbPcUzwlM1qsKP0XU/Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CXqQj6Pv9Tc/qMxaqd6UOeexai8kMJVpkp6j7tPfe+4RZUiAu0dN4SAttlV662I7R/3YXcm+A6LJ57+tWIusDLsp1qCp5/XXDBoK3s9uZ0+rMsDRl29ryAN69qwWrn/+hkKpUGT4+QPCht2F0xQPz9AfNtC7rPpWUybC+LwVWpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcTgqWym; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcTgqWym"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5649CC116C6;
	Thu,  5 Mar 2026 04:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772683558;
	bh=+GVZwWw13FtMFjCyXVQu3iPZbPcUzwlM1qsKP0XU/Yg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TcTgqWymXSZtqozEMSvk5hmp3Pc6nhUwzsanRB+HYaSA1KQ3aKCxaZQP+1O1Ar6UZ
	 ILzuLyXh7HekBgxhcKq+ss88q2ZGcKzpoZj65zjfDFYLtJPiB5jahdmL/hmH+gvOBH
	 DLrbF2+IlOsHQuUQzmFchpkHGlbvlcl+Ud96W7wX2mtnTEMUL5zDSnsRSJ5auwhMMZ
	 S7B4lsTVRvIwM8Wwd6kHLbNh4GNXpJJzwhTYM4Mi+XNg3k849d0U5SCVg6iE4p/vLR
	 Zq7UQVRXkZFi0KwX4rvz0w184OFATKATpuoMwHVYJnIKw093xmos74OejdO0R1Ngvg
	 ZMeUxakKlmWrw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	hare@suse.de
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v4 5/8] mptcp: add sock_set_reuseaddr
Date: Thu,  5 Mar 2026 12:05:23 +0800
Message-ID: <8dca88dcac861ed704dd4dba9528bc7f9b6b4892.1772683110.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772683110.git.tanggeliang@kylinos.cn>
References: <cover.1772683110.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch introduces a dedicated MPTCP helper, sock_set_reuseaddr, which
sets the address reuse flag on the first subflow socket of an MPTCP
connection, and applies it to the target side in the 'NVMe over MPTCP'
implementation.

Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c |  2 ++
 include/net/mptcp.h       |  4 ++++
 net/mptcp/protocol.c      | 15 +++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 8452d38614a6..5111c0e690ee 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2086,6 +2086,8 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	port->sock->sk->sk_user_data = port;
 	port->data_ready = port->sock->sk->sk_data_ready;
 	port->sock->sk->sk_data_ready = nvmet_tcp_listen_data_ready;
+	sk_is_msk(port->sock->sk) ?
+	mptcp_sock_set_reuseaddr(port->sock->sk) :
 	sock_set_reuseaddr(port->sock->sk);
 	sk_is_msk(port->sock->sk) ?
 	mptcp_sock_set_nodelay(port->sock->sk) :
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 60cbf29448b0..63b64b7699e3 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -246,6 +246,8 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
 void mptcp_active_detect_blackhole(struct sock *sk, bool expired);
 
 void mptcp_sock_set_nodelay(struct sock *sk);
+
+void mptcp_sock_set_reuseaddr(struct sock *sk);
 #else
 
 static inline void mptcp_init(void)
@@ -339,6 +341,8 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return hto
 static inline void mptcp_active_detect_blackhole(struct sock *sk, bool expired) { }
 
 static inline void mptcp_sock_set_nodelay(struct sock *sk) { }
+
+static inline void mptcp_sock_set_reuseaddr(struct sock *sk) { }
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 451bc4df4fa4..61f4eba02b37 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3823,6 +3823,21 @@ void mptcp_sock_set_nodelay(struct sock *sk)
 }
 EXPORT_SYMBOL(mptcp_sock_set_nodelay);
 
+void mptcp_sock_set_reuseaddr(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sock *ssk;
+
+	lock_sock(sk);
+	ssk = __mptcp_nmpc_sk(msk);
+	if (IS_ERR(ssk))
+		goto unlock;
+	ssk->sk_reuse = SK_CAN_REUSE;
+unlock:
+	release_sock(sk);
+}
+EXPORT_SYMBOL(mptcp_sock_set_reuseaddr);
+
 bool mptcp_finish_join(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-- 
2.53.0

