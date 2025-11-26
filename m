Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029EA3195E8
	for <mptcp@lists.linux.dev>; Wed, 26 Nov 2025 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764153628; cv=none; b=CnhfvotHq4fTMmsCzk2fICyJ33qDojHJ4J/pZmFQ51/cOC7t12q6hvQbmLyPqPFavX7GK2uHSoUV12JIz+/3+IOHK7+eDVhIWGTTMa1r6OlLyjKUbTOcinYbN+osfhJC0ogzdH9vBRKLf5Fd9GGZSiUZJ4i2DPnbGCxWFgS7mN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764153628; c=relaxed/simple;
	bh=3y0gLlhhbc5UrU+QOBiG/fxqKbQWulPa+7KuNAMJYnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xo6Dhd/IvAl8FURhUzmyrnrt0LLby6miHP7U66AuPIuuQFxBN3kxVsIVS4jBP096nhCehFjw/oDHkTYMFC4ReCT/Ktbsp4bxOj4u9xYxxZxx4pAVzKiwjidmxPfDruYmiXG/HzCs9PzUcMVtV1ikSBFiN2ZwESVwkXjpl22d3lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3GERNrw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3GERNrw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB57C116D0;
	Wed, 26 Nov 2025 10:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764153627;
	bh=3y0gLlhhbc5UrU+QOBiG/fxqKbQWulPa+7KuNAMJYnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o3GERNrw7Aqka5vkTwOVGdM868WVQGPcYuhc8S9F2wEd1d7+Jddy1Vbe/ra0S/xDT
	 Uzb/MVnTdQp18TYcyRZ++XlBIfzWOJvZciZSMoKXzuxpku99h2mvchWZEXWpdVCM3p
	 ue54988E7BUdwiw4xE6Rz0QDXvi049AP3MN9LfZAaeKxIY5rlNZpGiLXWGn1P3BPDS
	 qVw7ce1wLWYtIN6Jdr+q+F/77LggydkqC7JvdFjcVb0cKPT9V48Sm+dK/lAyoduGr0
	 O3lTRMT9B7pCQd9qzcAYsOFDIi/txe9MtQEL8L0+WbiohSGxdKJyNMLb0DUvyeuvH8
	 0yAq0nr/KqEpw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@suse.de,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>
Subject: [RFC mptcp-next v2 2/7] mptcp: add sock_set_reuseaddr
Date: Wed, 26 Nov 2025 18:39:59 +0800
Message-ID: <ff2a24c1ef454b1a56b56496c092e5053e438de6.1764152990.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1764152990.git.tanggeliang@kylinos.cn>
References: <cover.1764152990.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Implement an MPTCP sock_set_nodelay helper, which will be used for NVMe
over MPTCP. Using tcp_sock_set_nodelay() with MPTCP will cause list
corruption:

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

Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h  |  4 ++++
 net/mptcp/protocol.c | 15 +++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 4cf59e83c1c5..c7bf444eee56 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -237,6 +237,8 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
 }
 
 void mptcp_active_detect_blackhole(struct sock *sk, bool expired);
+
+void mptcp_sock_set_reuseaddr(struct sock *sk);
 #else
 
 static inline void mptcp_init(void)
@@ -323,6 +325,8 @@ static inline struct request_sock *mptcp_subflow_reqsk_alloc(const struct reques
 static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return htonl(0u); }
 
 static inline void mptcp_active_detect_blackhole(struct sock *sk, bool expired) { }
+
+static inline void mptcp_sock_set_reuseaddr(struct sock *sk) { }
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f9a544e31637..21067245a8f5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3764,6 +3764,21 @@ static void mptcp_sock_check_graft(struct sock *sk, struct sock *ssk)
 	}
 }
 
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
2.51.0

