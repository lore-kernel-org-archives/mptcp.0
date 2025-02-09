Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A1D339A8
	for <mptcp@lists.linux.dev>; Sun,  9 Feb 2025 10:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739095338; cv=none; b=U7LAFhtrBLT3sypP6xVV4ZVN22UcL8xLuevmfx0uXRk92uqxhasqVnPP9Dv5G5ypo/BjdytwgKkHFcejydW1fuUo3INiC+2Hpf/4XOMFPPPQV7giTygDz8RzJoDBu1dVhHFg2vnL3vyQPC4OFdT0LkQjTytJvSrjywRIdHRkHtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739095338; c=relaxed/simple;
	bh=SMy40aLgBVrtJFxuhjl6CllCn0Y5zvg4tw/PCEfFLts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1Oj0q8B/3xSi4272fDSxrSe4pwOxhQTtRadUYJZCi/ZXApRygcjPm6GCRtgzwRx0/rcsuUG6L7V55/ZGiYtjFJY3I3NFoAlbjJaEFQPPI/y24rN1J1dy6SKFG1WyjG9ywEroon3k+qgI2gpGL2s5bATI0Gx8M736THxqXqmRQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3dS6YcC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3dS6YcC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234AFC4CEDF;
	Sun,  9 Feb 2025 10:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739095338;
	bh=SMy40aLgBVrtJFxuhjl6CllCn0Y5zvg4tw/PCEfFLts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c3dS6YcCxkScAbpyo6BimQXjGVxEHZJBBoYwZL6P627XP7UQnzUZnlLWZ1poi38d/
	 E9qAuhjCwhixzqaKCAtzhw1TCFhDVMKooBf6MsM4xNr58iH/c8NZwffyCS8nu6qMQy
	 ki3odrkpyvYPHtprlR4yasVwzLLxfRSrETLVPvbR34pt11tINZh5+65v5tv6CqwiLX
	 4z7Zhv1J1hLe+2aZStsjY42FsvjYCFnuNF+82z48UTUej8i1NsMzBN1OXCtMI4O/xU
	 afSSPbRnb7/2MouZs7GapGWk+4TmWJlRtM49eHbFoT5gR292brQtyd0yGSGGokPc3a
	 Es3gvsOyQ5pDA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 1/8] Squash to "mptcp: add sched_data helpers"
Date: Sun,  9 Feb 2025 18:02:00 +0800
Message-ID: <67df18568854d63f58ee33d59fd513390ed16e92.1739083793.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739083793.git.tanggeliang@kylinos.cn>
References: <cover.1739083793.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop bpf_mptcp_subflow_ctx_by_pos.
Keep mptcp_sched_data_set_contexts for future use.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c      |  8 --------
 net/mptcp/protocol.h |  2 --
 net/mptcp/sched.c    | 15 ---------------
 3 files changed, 25 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index a74173cc8998..2e713076af5e 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -276,14 +276,6 @@ bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it)
 {
 }
 
-__bpf_kfunc struct mptcp_subflow_context *
-bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos)
-{
-	if (pos >= MPTCP_SUBFLOWS_MAX)
-		return NULL;
-	return data->contexts[pos];
-}
-
 __bpf_kfunc static bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 {
 	return tcp_rtx_queue_empty(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bac5c925a72f..a1d6d996aa93 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -718,8 +718,6 @@ void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 u64 mptcp_wnd_end(const struct mptcp_sock *msk);
 void mptcp_set_timeout(struct sock *sk);
-struct mptcp_subflow_context *
-bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos);
 struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk);
 bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 37d86aadaeaa..ef3f0250ae1f 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -157,21 +157,6 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 static void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 					  struct mptcp_sched_data *data)
 {
-	struct mptcp_subflow_context *subflow;
-	int i = 0;
-
-	mptcp_for_each_subflow(msk, subflow) {
-		if (i == MPTCP_SUBFLOWS_MAX) {
-			pr_warn_once("too many subflows");
-			break;
-		}
-		mptcp_subflow_set_scheduled(subflow, false);
-		data->contexts[i++] = subflow;
-	}
-	data->subflows = i;
-
-	for (; i < MPTCP_SUBFLOWS_MAX; i++)
-		data->contexts[i] = NULL;
 }
 
 int mptcp_sched_get_send(struct mptcp_sock *msk)
-- 
2.43.0

