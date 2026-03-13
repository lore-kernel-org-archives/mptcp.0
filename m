Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE2617A300
	for <mptcp@lists.linux.dev>; Fri, 13 Mar 2026 04:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773375193; cv=none; b=Hp2kj+OpdUrjs6AHnB/rL7s1OBmXN1NiWPMMQuYB5hFDem9OXp37YniAnjbRnqUWP1zZfies6T5K7tW/tr+d34w1l0vB9qUHCi7IsiaEgkHgeeZgfMA1UAdBYgcLyz26iE5/ZbYi8VpWu11hQv9rvmr1/Ztctdyx4JHk2mlgJeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773375193; c=relaxed/simple;
	bh=9fGVPeyCC48lSRiLlOwPbwecJBzIGIxPHEt+eOWhs9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JaPfnNovlHcGniVascOrSE37pMbQ2w/MxB/cPrnHHgMN39YgZ7RZhyhPNKdiaWWgLzpRAKPJtjJmk2rvid7ryEJIRteqzqFpqiPPl4NdcgY73txiikPVk8+X5Uc1Ur3odBs9tviHBFRShMP42gIoobsmXpyFomOtVZ4QXeKnG+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4IxTeZK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4IxTeZK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C135C19421;
	Fri, 13 Mar 2026 04:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773375193;
	bh=9fGVPeyCC48lSRiLlOwPbwecJBzIGIxPHEt+eOWhs9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T4IxTeZKPHCInLIorT46y3IniDpHg0aFhVthGiZNomfF6ulJduJ/pR2FB7PQ/21XT
	 uX/LU2aay48WvMGl83FUqWKemZAFjraPJzLRElDlpYgwg+Mvw/zyXq1MnIphnt6XY7
	 Hgh1FohO/ZxVSaq54XKQrt0O2d77a8LDq0+FSBpacSfWY1K/osqh1y21WiY0SnEqkf
	 DxO6VeGhzJuibIGuAlwUIa+vV67ix7CC7HyTFrbESm0nW88xoaGuet1GUAm4QTzBKN
	 EkVmkz/jHve5FdQkPQt8+w6tJae55GKYQxZejGeahH65mm5G29+vkfOpVnsXbtybtE
	 GPfQjF6EzZlBA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v5 2/7] mptcp: add sock_set_nodelay
Date: Fri, 13 Mar 2026 12:12:46 +0800
Message-ID: <1f53896c2bdd54166639b28da5e8968f1e11e2f9.1773374342.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773374342.git.tanggeliang@kylinos.cn>
References: <cover.1773374342.git.tanggeliang@kylinos.cn>
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
MPTCP connection. It will be utilized on both the target and host sides
in the 'NVMe over MPTCP' implementation.

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
 include/net/mptcp.h  |  4 ++++
 net/mptcp/protocol.c | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

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
index 7c06b8d9eb37..692111941808 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3800,6 +3800,24 @@ static void mptcp_sock_check_graft(struct sock *sk, struct sock *ssk)
 	}
 }
 
+void mptcp_sock_set_nodelay(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+
+	lock_sock(sk);
+	msk->nodelay = true;
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

