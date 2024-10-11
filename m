Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC555804
	for <mptcp@lists.linux.dev>; Fri, 11 Oct 2024 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728638863; cv=none; b=fJZi8zjhzLIObrs0IcqCccjyMgXYmlXSsZrQqHPW13B9Kc8C7PYeAuv9HdGb/tehyOPfXbAL0rRDz94dS3H/G14XOy9wunr082lRbmjt3JTAg+Cd/2ZXQZR2HRTE0l/T2BZNIjE0fgalHsgVccAJI2oZNcTSi0DiE+CAxyIL2vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728638863; c=relaxed/simple;
	bh=YE5itFl4lhTWViAjN4W4BCvpGpKDQjjty5wErEoFtO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0ONtHh0QeZuZ5cQpGLohDK5XT3MeX6u4BDL+bPxIa7F5E/uTL2LSWpl7QZs7cz8zn9VKsPA1vh+1OM5Zgtb9Wg2mK3hNI9ptvTaq2jrshwLtbb5hCmQ4zUgMsTzyr9QutHjDkaP8IKUQt4orkzL7lElk3z8j1uvBA/ek1Uue+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/Encg0N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/Encg0N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B41C4CEC3;
	Fri, 11 Oct 2024 09:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728638863;
	bh=YE5itFl4lhTWViAjN4W4BCvpGpKDQjjty5wErEoFtO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f/Encg0NpNcTVybK6JFcGJpv4vIiyd50wLMNawOfJnAveKIoaUfNPl67X3UozTk5e
	 jktdst2zeYf8cXGRgIkjbyjtqclQUdwrJfmdt1BBQaXOO2Uis21LX+e9A0X9v4wJZE
	 4u0a3hgTGRQgwxdnD07q3uRANvmy3nb50ZDmMdGOFPPPumzFxao/S6M/ZI5TzQzjUD
	 DxG+D8/Dnznf3hGeg5dMRqPqDs4ZvZXmedLkM74Xh2H+tie/WfphX7stuUy4UOg9hf
	 rC2ahLOgkG87fv+z1tPxvkD+0iuVP4ldNBpS2sNb6RwPLT/r6daZ3WGdhmozPNHDQX
	 fe3GFngVE8Ovw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 08/11] Squash to "bpf: Export more bpf_burst related functions"
Date: Fri, 11 Oct 2024 17:27:20 +0800
Message-ID: <4975c10ed967386a8281166b1482d5539777f0ee.1728638310.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728638310.git.tanggeliang@kylinos.cn>
References: <cover.1728638310.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop bpf_mptcp_subflow_queues_empty declaration.

Register kfunc set again.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c      | 11 +++++++++--
 net/mptcp/protocol.h |  1 -
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 22caff1d4dc2..6893d908d3c7 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -298,13 +298,18 @@ static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
 	.set	= &bpf_mptcp_common_kfunc_ids,
 };
 
-/*
+BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
 BTF_ID_FLAGS(func, tcp_stream_memory_free)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_queues_empty)
 BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale)
-*/
+BTF_KFUNCS_END(bpf_mptcp_sched_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
+	.owner	= THIS_MODULE,
+	.set	= &bpf_mptcp_sched_kfunc_ids,
+};
 
 static int __init bpf_mptcp_kfunc_init(void)
 {
@@ -313,6 +318,8 @@ static int __init bpf_mptcp_kfunc_init(void)
 	ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
 					       &bpf_mptcp_common_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					       &bpf_mptcp_sched_kfunc_set);
 #ifdef CONFIG_BPF_JIT
 	ret = ret ?: register_bpf_struct_ops(&bpf_mptcp_sched_ops, mptcp_sched_ops);
 #endif
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e774f28a6f8d..7848a1989d17 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -722,7 +722,6 @@ void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 u64 mptcp_wnd_end(const struct mptcp_sock *msk);
 void mptcp_set_timeout(struct sock *sk);
-bool bpf_mptcp_subflow_queues_empty(struct sock *sk);
 struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk);
 bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
-- 
2.43.0

