Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35EE4A1D
	for <mptcp@lists.linux.dev>; Wed, 18 Sep 2024 08:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726647935; cv=none; b=IzVvh02YjxmfL8mBwGja5zgZoyfooH6wsydM8jR1JsKZ5cnG2cuHcYuNVS0ht1LeX89PGb6X/XQdksz32OJU7FjWDeqB1YS0KbAfs8ypv3Wil9B59olTy7MNuK6W3yXS+LNeHkr7fj3apSPFzZv7y1BvCoAUbhaU0QOcn6AJZGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726647935; c=relaxed/simple;
	bh=BxLLcYCta6yKdQKXRoRUhoVzoTnnDducmcWS7Ryz8FE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ardR9BfxKB5QS6kjKe0jBcDm8o+R/Tckx4gz+ZE0PmsVLeS9cI75AWXxKVtf0Hg+P+8VvZejSadcRqO5bncTcq4EudUkWpLGyf/FnkrptiUdohZLEP3lbt+PbhITmZ2efX1xxEqhdlw2hALySV1Rqn/7uRxWQ9bpOFzkuAtt00Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozrX5Y8O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozrX5Y8O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD97C4CECD;
	Wed, 18 Sep 2024 08:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726647934;
	bh=BxLLcYCta6yKdQKXRoRUhoVzoTnnDducmcWS7Ryz8FE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ozrX5Y8O++Sqd72QgHd30xD5F9twqD2R4U/4J4Ah60q3UYGJV+IzADGxjHdh8MYIT
	 aLRl6fFVgUFyP6IjLVXhyVJwUVdX29Hwy4rra6VtPRENeEMVKxE+A07p/HnE+EPC0h
	 DyFW8qBFfVN3/wx/ALLaMQbcxXD6atr8iTzuUpdpD/wglGDyog8iWCxXZTbwe+eUV9
	 o6/1PCW5QttkvsO3gGBXNqoPm5l1P+nJUoGYT9kem44jYYJmma3Byl652wGYgiBhDn
	 L+0hg/0pJb+4kVg1BkcYAQ9Rjof3pJ3BcW0IOgBIxeeRzi8g8SL7sV3wQMq5JrThoM
	 KmYMp17cOTNTA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 5/6] Squash to "mptcp: add sched_data helpers"
Date: Wed, 18 Sep 2024 16:25:17 +0800
Message-ID: <a735f1dae6c7cb7f32eaf4bc65ec86f0eb277fad.1726647599.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726647599.git.tanggeliang@kylinos.cn>
References: <cover.1726647599.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use __bpf_kfunc_start_defs and __bpf_kfunc_end_defs.

Drop bpf_mptcp_subflow_ctx_by_pos declaration.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c      | 6 ++----
 net/mptcp/protocol.h | 2 --
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 6414824402e6..4854421730a9 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -201,9 +201,7 @@ static const struct btf_kfunc_id_set bpf_mptcp_fmodret_set = {
 	.set   = &bpf_mptcp_fmodret_ids,
 };
 
-__diag_push();
-__diag_ignore_all("-Wmissing-prototypes",
-		  "kfuncs which will be used in BPF programs");
+__bpf_kfunc_start_defs();
 
 __bpf_kfunc struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos)
@@ -218,7 +216,7 @@ __bpf_kfunc bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 	return tcp_rtx_queue_empty(sk);
 }
 
-__diag_pop();
+__bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c3942416fa3a..d864c8ccf316 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -722,8 +722,6 @@ void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 u64 mptcp_wnd_end(const struct mptcp_sock *msk);
 void mptcp_set_timeout(struct sock *sk);
 bool bpf_mptcp_subflow_queues_empty(struct sock *sk);
-struct mptcp_subflow_context *
-bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos);
 struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk);
 bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
-- 
2.43.0

