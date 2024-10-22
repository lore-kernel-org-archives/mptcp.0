Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497BA127E37
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 07:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583559; cv=none; b=Pz8322G9sSUKJ7hrS3OjIyaRAkQR/69+tB3bkPscb9YkiIQJyiygUPxp+IxBodRuri4PJjykjzPfiQEcmlDptKQCtYH/0BjwQOxNrUdPM0QhXb01bT1F52FiB3ZTyhwt/YZnbTv9HGvM6BZ274ghpI9Pti3mJgDSrOfRYmOssIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583559; c=relaxed/simple;
	bh=BXAkn57XeLeVxj5gIP0uzffNzK3MLWYTvRXhGad04EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jyGfqqzZwKPXLKHUdI5MvJJRV1QRPtkIPrYiJBKF6qiSZtDb/9YP8EtCZkFQd5PYibLoqzD0IYhWCVCe8E5JsCheQ7hi59GCX8KpM5U+TnvGlUqoEG0bSi9CflGcW+irgspZDX3wHkjLNG0Rb2IQZqiPBkSGV7sL1j2g0MwZPko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7C+DF2W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7C+DF2W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DB7C4CEC3;
	Tue, 22 Oct 2024 07:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729583558;
	bh=BXAkn57XeLeVxj5gIP0uzffNzK3MLWYTvRXhGad04EY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l7C+DF2W4bQLi451dppX3h8gz4H5fAHDJpzv8UFlS5GVoPSRCCNukP1i3rQjnitix
	 LPU+eXJqkpF9oI69flhefEEGV052/Ru3feE0CkR0d448y2A0G5G6WuOsycqNcg+Qj+
	 Ifev8GtC+QicWoeGTCpDWPd4y+ljJLiVXhVct9HCew+cpckl25WGOTu87yZI8mElKt
	 I8dIKA3zeSqQbbPnZ3PpGo+EynqkYj+re/bPUK0eNeYWIfsa7smC5HRnk37iP0Rkus
	 oCglznVuwMYgG19DMRXtivP+KQitONxMsPRuoJdfqsmY09Dk6QyWEVmbMOLTp+YbkI
	 wct64yK0xv4jA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 2/5] Squash to "selftests/bpf: Add bpf_rr scheduler & test"
Date: Tue, 22 Oct 2024 15:52:26 +0800
Message-ID: <cc23cd700d88642bf4396739181286262e208d8b.1729583414.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729583414.git.tanggeliang@kylinos.cn>
References: <cover.1729583414.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use the newly added bpf_for_each() helper to walk the conn_list.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 26 ++++++++-----------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index 638ea6aa63b7..e02b8cfb262b 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -34,10 +34,9 @@ SEC("struct_ops")
 int BPF_PROG(bpf_rr_get_subflow, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
-	struct mptcp_subflow_context *subflow;
+	struct mptcp_subflow_context *subflow, *next;
 	struct mptcp_rr_storage *ptr;
 	struct sock *last_snd = NULL;
-	int nr = 0;
 
 	ptr = bpf_sk_storage_get(&mptcp_rr_map, msk, 0,
 				 BPF_LOCAL_STORAGE_GET_F_CREATE);
@@ -45,31 +44,28 @@ int BPF_PROG(bpf_rr_get_subflow, struct mptcp_sock *msk,
 		return -1;
 
 	last_snd = ptr->last_snd;
+	next = bpf_mptcp_subflow_ctx(msk->first);
 
-	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
-		subflow = bpf_mptcp_subflow_ctx_by_pos(data, i);
-		if (!last_snd || !subflow)
+	bpf_for_each(mptcp_subflow, subflow, msk) {
+		if (!last_snd)
 			break;
 
-		if (mptcp_subflow_tcp_sock(subflow) == last_snd) {
-			if (i + 1 == MPTCP_SUBFLOWS_MAX ||
-			    !bpf_mptcp_subflow_ctx_by_pos(data, i + 1))
+		if (bpf_mptcp_subflow_tcp_sock(subflow) == last_snd) {
+			subflow = bpf_iter_mptcp_subflow_next(&___it);
+			if (!subflow)
 				break;
 
-			nr = i + 1;
+			next = subflow;
 			break;
 		}
 	}
 
-	subflow = bpf_mptcp_subflow_ctx_by_pos(data, nr);
-	if (!subflow)
-		return -1;
-	mptcp_subflow_set_scheduled(subflow, true);
-	ptr->last_snd = mptcp_subflow_tcp_sock(subflow);
+	mptcp_subflow_set_scheduled(next, true);
+	ptr->last_snd = bpf_mptcp_subflow_tcp_sock(next);
 	return 0;
 }
 
-SEC(".struct_ops")
+SEC(".struct_ops.link")
 struct mptcp_sched_ops rr = {
 	.init		= (void *)mptcp_sched_rr_init,
 	.release	= (void *)mptcp_sched_rr_release,
-- 
2.45.2

