Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1AA34AB01
	for <mptcp@lists.linux.dev>; Tue, 23 Jun 2026 02:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782183383; cv=none; b=YLoWRWp4D5xZ4IAxXijF4y0y82YI1KHyPkyNvqxUuJQiANIiOh1IFsHE+qtlR1ZNMVtRAfjZk5fBaJBpl9v8SLDF0TJL9GFDiIz5l2C0LqW8lxh1Nd/g+p2wolVNSkpm7p6aGdBCih1gRzjpM93HV12cqrJs6Nb4Pf6HqC9RSJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782183383; c=relaxed/simple;
	bh=O0WTLIAf4uKjk+MXlhWW3hPNjVHWoCi6iXyZZVcKBvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fz7zUrfzM2teEoEfyuj2SKjVbYHB3Yjw36exJ0G6RumlltI+4WA3QKECK0Unly1BYtkl2BWTY5Zdxh1uJ7PuYZeeCfxuT9p000UWXoux5db6fKqGiaBBu6uAISNwc4xGhayzZP+CXaEnUJY3wCh6yQc4c0552Z8CK7kwS+bf2Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbjrmCiR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbjrmCiR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED4A1F000E9;
	Tue, 23 Jun 2026 02:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782183381;
	bh=AFnC+eT+wMl/uHSQcoQgrP4Lgt8VIzp0y9FTS7KOTdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IbjrmCiRV0rhRimG82g4pUvfd+XmjT2emUoLhaKnM1k2H9hOkk5+QKYcY2gTvQ/QA
	 VYC1vra57MGstSd0s46wApzJOFUZvBjrsD1XPAyn+oSqa7QEySJmHsO0a1Nmheo3EV
	 7R2D3t1mTOEA4dWRZcqO2eyfW4kqyD1hGR5t6Ns2cBHxKpRFp//iPGAVVu+rblLXJN
	 /1EEVjOw53sO5Gdx6WtXlWQjkSUkxo1QLIuA7kkMkwUh6bBg58RvYg/CQlvwF6R6gd
	 +Nukuj3qaTwXNrlrkRYq0ngpDFTL4yYlQSCJ9o4OqqQTF1sI0n4dHF3bIk8hOUScbC
	 GYoKRW7eVjgiQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/2] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
Date: Tue, 23 Jun 2026 10:56:12 +0800
Message-ID: <fefe045e09c76268ac66e2a03006d674c1c73587.1782183266.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782183266.git.tanggeliang@kylinos.cn>
References: <cover.1782183266.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Implement tcp_rtx_queue_empty() inline in the burst scheduler using
RB_EMPTY_ROOT(), and remove the dependency on the external kfunc
bpf_mptcp_subflow_queues_empty(). Also include bpf_atomic.h for
READ_ONCE() support.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf.h       | 1 +
 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index 4e901941d5dd..de450b2eaf0f 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -3,6 +3,7 @@
 #define __MPTCP_BPF_H__
 
 #include "bpf_experimental.h"
+#include "bpf_atomic.h"
 
 /* list helpers from include/linux/list.h */
 static inline int list_is_head(const struct list_head *list,
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index 48c22f5bce32..8ff529d38a59 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -19,12 +19,12 @@ struct bpf_subflow_send_info {
 #define SSK_MODE_MAX	2
 
 #define min(a, b) ((a) < (b) ? (a) : (b))
+#define RB_EMPTY_ROOT(root)  (READ_ONCE((root)->rb_node) == NULL)
 
 extern bool mptcp_subflow_active(struct mptcp_subflow_context *subflow) __ksym;
 extern void mptcp_set_timeout(struct sock *sk) __ksym;
 extern __u64 mptcp_wnd_end(const struct mptcp_sock *msk) __ksym;
 extern bool bpf_sk_stream_memory_free(const struct mptcp_subflow_context *subflow) __ksym;
-extern bool bpf_mptcp_subflow_queues_empty(struct sock *sk) __ksym;
 extern void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk) __ksym;
 
 static __always_inline __u64 div_u64(__u64 dividend, __u32 divisor)
@@ -39,9 +39,14 @@ static __always_inline bool tcp_write_queue_empty(struct sock *sk)
 	return tp ? tp->write_seq == tp->snd_nxt : true;
 }
 
+static __always_inline bool tcp_rtx_queue_empty(const struct sock *sk)
+{
+	return RB_EMPTY_ROOT(&sk->tcp_rtx_queue);
+}
+
 static __always_inline bool tcp_rtx_and_write_queues_empty(struct sock *sk)
 {
-	return bpf_mptcp_subflow_queues_empty(sk) && tcp_write_queue_empty(sk);
+	return tcp_rtx_queue_empty(sk) && tcp_write_queue_empty(sk);
 }
 
 SEC("struct_ops")
-- 
2.53.0

