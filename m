Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE8B131E38
	for <mptcp@lists.linux.dev>; Sat, 12 Oct 2024 13:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728740559; cv=none; b=BmpQ4LwFCbs5Ix83FiOj99TG12iIGxH/fv4Y6/a9kZHPZshn9sHDawzlStY/bb/SzE9pxIa0IharGt2/RPQEp+4iOFrDUOSt8sOPLRONWx5/XpeGREioV/6zB91aarhsyox6xxhIUrkpF5lnQJ7dAoKlQpZ1uQTkBCMAl8TK90Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728740559; c=relaxed/simple;
	bh=8atzrbDfqZidyNnlDwL9XU+IIOzeh/9RLqX8outzcQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5f7MoVX0mStQVBZZ21Nwfgbh9XaEQxbCPsJwt9KRti9W2SkiPzFgf08qS3JyDpldqQsvifPuGistslUQ7LMW1NNfDduGPMaZBUwbhdtsdLzKQ+USZ/aKSZGGrmgYfWD0o0QStmVcCdf/7hzfeg0KhVPQvi0qOQoq4eweVsKbb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inz9vkeh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inz9vkeh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B5BC4CEC6;
	Sat, 12 Oct 2024 13:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728740558;
	bh=8atzrbDfqZidyNnlDwL9XU+IIOzeh/9RLqX8outzcQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=inz9vkeh54hMb6I1oCmht31jUg4fRueSPzbLkYga4IczigXAROHa0UlOarzQKuFfY
	 jHKXefMMLLZeMi1emVn4yLxwIejBAK17UxOAYyL5I+Rveu+iWdLAZFJqWfe7HqFmy4
	 Etwwn6KqLyFz4F6et11QAnLSkzU+vtppDzbNg+hCr06J6MG38Aj89jXhorK3UL72st
	 BXC6NRF+tRPduHD35lOdiarIaFOpcuLQgTTCF9ouiNnE/9U+9S9VYIyH7x241fu7dL
	 0IXJPrNc7DmZCde7KB647VypQ9WTMe6v0JfMUQT7rjs+1E4+ZKVXOC2FrKSAkbyv41
	 9pFmNqINT/VJg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 04/11] Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
Date: Sat, 12 Oct 2024 21:42:09 +0800
Message-ID: <12824111063f027ed49b3d0c4cce285716959d6c.1728738220.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728738219.git.tanggeliang@kylinos.cn>
References: <cover.1728738219.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Please update the subject to

	"bpf: Export mptcp packet scheduler helpers"

Remove bpf_mptcp_subflow_ctx_by_pos from BPF kfunc set.
Merge "bpf: Export more bpf_burst related functions" into this patch.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c      | 11 ++++++++++-
 net/mptcp/protocol.c |  4 ++--
 net/mptcp/protocol.h |  2 ++
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 627839383b29..38034d3f28f8 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -268,6 +268,11 @@ __bpf_kfunc void bpf_mptcp_sock_release(struct mptcp_sock *msk)
 	WARN_ON_ONCE(!sk || !refcount_dec_not_one(&sk->sk_refcnt));
 }
 
+__bpf_kfunc bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
+{
+	return tcp_rtx_queue_empty(sk);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
@@ -288,7 +293,11 @@ static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
 };
 
 BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
-BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx_by_pos)
+BTF_ID_FLAGS(func, mptcp_set_timeout)
+BTF_ID_FLAGS(func, mptcp_wnd_end)
+BTF_ID_FLAGS(func, tcp_stream_memory_free)
+BTF_ID_FLAGS(func, bpf_mptcp_subflow_queues_empty)
+BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale)
 BTF_KFUNCS_END(bpf_mptcp_sched_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e978e05ec8d1..e420ce9bbfb6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -50,7 +50,7 @@ DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 static struct net_device mptcp_napi_dev;
 
 /* Returns end sequence number of the receiver's advertised window */
-static u64 mptcp_wnd_end(const struct mptcp_sock *msk)
+u64 mptcp_wnd_end(const struct mptcp_sock *msk)
 {
 	return READ_ONCE(msk->wnd_end);
 }
@@ -489,7 +489,7 @@ static long mptcp_timeout_from_subflow(const struct mptcp_subflow_context *subfl
 	       inet_csk(ssk)->icsk_timeout - jiffies : 0;
 }
 
-static void mptcp_set_timeout(struct sock *sk)
+void mptcp_set_timeout(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
 	long tout = 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a93e661ef5c4..7848a1989d17 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -720,6 +720,8 @@ void __mptcp_subflow_send_ack(struct sock *ssk);
 void mptcp_subflow_reset(struct sock *ssk);
 void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
+u64 mptcp_wnd_end(const struct mptcp_sock *msk);
+void mptcp_set_timeout(struct sock *sk);
 struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk);
 bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
-- 
2.43.0

