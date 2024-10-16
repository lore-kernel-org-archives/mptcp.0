Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89151C07E7
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729071261; cv=none; b=e+hDyVQTmnM+m9bt3I+uCxG7stg5E7UwDD4tuWViY3XhYIujR/JpsO3MSpTYV9Cs53xfSLee7rruA0Pnws+ygNikeO24UFoPM5CSkdhJt4H5pqj177FLRYONRq/qO9P72cm3fG7ofBO0o0z97rG23czSsRLw2hmwUuT3xKSuCmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729071261; c=relaxed/simple;
	bh=vcsChg8Zx7puE/i+PPig8eRAVK7A6UTQxj0/MaAo9sU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXSsBfSWImLD9LJslzkuPocYCQKfnClLaj0wce5Dhk8bJZrwK7qb4pGFZCObLzTsyIdiJ6gRDfPC8JM6vUDn4QHobt3mf5RFcPRwRqYCtYufX3tvuEU6CJiXxFi2g84oO+9I4pVmGbpp0ST+t3kU6BvHReEHu8EvtxxxoZEgCZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2ZiGXMi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2ZiGXMi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EA8C4CECE;
	Wed, 16 Oct 2024 09:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729071261;
	bh=vcsChg8Zx7puE/i+PPig8eRAVK7A6UTQxj0/MaAo9sU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H2ZiGXMiPZs9zih8+rFaxl4kEeZMEDXs/lrZNmhRR4MRhKBPlY8P3Sp44Y1REvran
	 nj3+cjZoWSkVUxgO/zWumdQM5CgayYxzqRwiY5y4IS+7ScS4MdQgUVvxNReMMM/5dN
	 WGdo3AF8IwcolirSC6zs/K5wCGsxJ80F9GBrv2P8V3Lnx4o2IHD1AodYszbju23xqV
	 iw2/I9EiVjZnpasRCIsZY+qPN4yfrfjeM5gLwPL3DxyJKEgtHzDm6NlzK848j3vdnJ
	 Tkg3qGZ0KpWpgEe9hhiUQCIhxGUKvmFHKAJylDfacu+dIxbGUWCN7ecMmfebI9PeY3
	 CqN4bFK51DeAg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 08/10] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
Date: Wed, 16 Oct 2024 17:33:44 +0800
Message-ID: <f118f864fe5f5415f2adb8783aa13a1b62d231a9.1729070999.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729070999.git.tanggeliang@kylinos.cn>
References: <cover.1729070999.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use the newly added bpf_for_each() helper to walk the conn_list.

Drop mptcp_subflow_active declaration.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 77 ++++++++++---------
 1 file changed, 39 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index eb21119aa8f7..fe6a9f9984f2 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -11,6 +11,10 @@ char _license[] SEC("license") = "GPL";
 
 #define min(a, b) ((a) < (b) ? (a) : (b))
 
+#define SSK_MODE_ACTIVE	0
+#define SSK_MODE_BACKUP	1
+#define SSK_MODE_MAX	2
+
 struct bpf_subflow_send_info {
 	__u8 subflow_id;
 	__u64 linger_time;
@@ -23,10 +27,6 @@ extern bool tcp_stream_memory_free(const struct sock *sk, int wake) __ksym;
 extern bool bpf_mptcp_subflow_queues_empty(struct sock *sk) __ksym;
 extern void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk) __ksym;
 
-#define SSK_MODE_ACTIVE	0
-#define SSK_MODE_BACKUP	1
-#define SSK_MODE_MAX	2
-
 static __always_inline __u64 div_u64(__u64 dividend, __u32 divisor)
 {
 	return dividend / divisor;
@@ -57,6 +57,19 @@ static __always_inline bool sk_stream_memory_free(const struct sock *sk)
 	return __sk_stream_memory_free(sk, 0);
 }
 
+static struct mptcp_subflow_context *
+mptcp_lookup_subflow_by_id(struct mptcp_sock *msk, unsigned int id)
+{
+	struct mptcp_subflow_context *subflow;
+
+	bpf_for_each(mptcp_subflow, subflow, msk) {
+		if (subflow->subflow_id == id)
+			return subflow;
+	}
+
+	return NULL;
+}
+
 SEC("struct_ops")
 void BPF_PROG(mptcp_sched_burst_init, struct mptcp_sock *msk)
 {
@@ -67,8 +80,7 @@ void BPF_PROG(mptcp_sched_burst_release, struct mptcp_sock *msk)
 {
 }
 
-static int bpf_burst_get_send(struct mptcp_sock *msk,
-			      struct mptcp_sched_data *data)
+static int bpf_burst_get_send(struct mptcp_sock *msk)
 {
 	struct bpf_subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -84,16 +96,10 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 		send_info[i].linger_time = -1;
 	}
 
-	for (i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
-		bool backup;
+	bpf_for_each(mptcp_subflow, subflow, msk) {
+		bool backup = subflow->backup || subflow->request_bkup;
 
-		subflow = bpf_mptcp_subflow_ctx_by_pos(data, i);
-		if (!subflow)
-			break;
-
-		backup = subflow->backup || subflow->request_bkup;
-
-		ssk = mptcp_subflow_tcp_sock(subflow);
+		ssk = bpf_mptcp_subflow_tcp_sock(subflow);
 		if (!mptcp_subflow_active(subflow))
 			continue;
 
@@ -109,7 +115,7 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 
 		linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
 		if (linger_time < send_info[backup].linger_time) {
-			send_info[backup].subflow_id = i;
+			send_info[backup].subflow_id = subflow->subflow_id;
 			send_info[backup].linger_time = linger_time;
 		}
 	}
@@ -119,10 +125,10 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 	if (!nr_active)
 		send_info[SSK_MODE_ACTIVE].subflow_id = send_info[SSK_MODE_BACKUP].subflow_id;
 
-	subflow = bpf_mptcp_subflow_ctx_by_pos(data, send_info[SSK_MODE_ACTIVE].subflow_id);
+	subflow = mptcp_lookup_subflow_by_id(msk, send_info[SSK_MODE_ACTIVE].subflow_id);
 	if (!subflow)
 		return -1;
-	ssk = mptcp_subflow_tcp_sock(subflow);
+	ssk = bpf_mptcp_subflow_tcp_sock(subflow);
 	if (!ssk || !sk_stream_memory_free(ssk))
 		return -1;
 
@@ -141,23 +147,18 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 	return 0;
 }
 
-static int bpf_burst_get_retrans(struct mptcp_sock *msk,
-				 struct mptcp_sched_data *data)
+static int bpf_burst_get_retrans(struct mptcp_sock *msk)
 {
-	int backup = MPTCP_SUBFLOWS_MAX, pick = MPTCP_SUBFLOWS_MAX, subflow_id;
+	struct sock *backup = NULL, *pick = NULL;
 	struct mptcp_subflow_context *subflow;
 	int min_stale_count = INT_MAX;
-	struct sock *ssk;
 
-	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
-		subflow = bpf_mptcp_subflow_ctx_by_pos(data, i);
-		if (!subflow)
-			break;
+	bpf_for_each(mptcp_subflow, subflow, msk) {
+		struct sock *ssk = bpf_mptcp_subflow_tcp_sock(subflow);
 
 		if (!mptcp_subflow_active(subflow))
 			continue;
 
-		ssk = mptcp_subflow_tcp_sock(subflow);
 		/* still data outstanding at TCP level? skip this */
 		if (!tcp_rtx_and_write_queues_empty(ssk)) {
 			mptcp_pm_subflow_chk_stale(msk, ssk);
@@ -166,23 +167,23 @@ static int bpf_burst_get_retrans(struct mptcp_sock *msk,
 		}
 
 		if (subflow->backup || subflow->request_bkup) {
-			if (backup == MPTCP_SUBFLOWS_MAX)
-				backup = i;
+			if (!backup)
+				backup = ssk;
 			continue;
 		}
 
-		if (pick == MPTCP_SUBFLOWS_MAX)
-			pick = i;
+		if (!pick)
+			pick = ssk;
 	}
 
-	if (pick < MPTCP_SUBFLOWS_MAX) {
-		subflow_id = pick;
+	if (pick)
 		goto out;
-	}
-	subflow_id = min_stale_count > 1 ? backup : MPTCP_SUBFLOWS_MAX;
+	pick = min_stale_count > 1 ? backup : NULL;
 
 out:
-	subflow = bpf_mptcp_subflow_ctx_by_pos(data, subflow_id);
+	if (!pick)
+		return -1;
+	subflow = bpf_mptcp_subflow_ctx(pick);
 	if (!subflow)
 		return -1;
 	mptcp_subflow_set_scheduled(subflow, true);
@@ -194,8 +195,8 @@ int BPF_PROG(bpf_burst_get_subflow, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
 	if (data->reinject)
-		return bpf_burst_get_retrans(msk, data);
-	return bpf_burst_get_send(msk, data);
+		return bpf_burst_get_retrans(msk);
+	return bpf_burst_get_send(msk);
 }
 
 SEC(".struct_ops")
-- 
2.43.0

