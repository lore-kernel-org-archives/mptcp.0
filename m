Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739252165E9
	for <mptcp@lists.linux.dev>; Mon,  9 Dec 2024 09:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737778; cv=none; b=NogVI/w9jjjlJ+bC4p23cOLQ1Liv5OkwF0ZFyRUErbR9Vie6rTrDCGUSG71OK7A9pG15K0HQOFooIiPUFgr5Pk+bbefF6+8zBuMXrQ9bAudn/fFpPb3FuJerHV0FO6Rvc9n3fIljvn87Dqi/rL+62A3E8WzoVgbNnJxFFsq84tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737778; c=relaxed/simple;
	bh=26lwXCmDkSh51Qah5xXDC6UXToBWAOQeulBdTYPSCH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8zITnC5yhhjMbOzac+UCnYMFI+zf6ufrxF9RPpYbinS0NUc88ku2UgAsuGpduxu+k/HuHYvReq/klNOfDE2J+2d3S/yBiiuRTMVsIIVGzSb8KLO5HRFjAlypPH2MKeinuPa+O/RimhD8IwXdmx3wK4XbOY4ULR4KKFuOGmNt+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atMR0Ut8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atMR0Ut8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BF8C4AF0D;
	Mon,  9 Dec 2024 09:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733737778;
	bh=26lwXCmDkSh51Qah5xXDC6UXToBWAOQeulBdTYPSCH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=atMR0Ut8xUy+hdBht4ay/DZ5rdCZ2pWOJtyadT2Upuq8ICf4W8RtGAbuHx3Vp5HzV
	 qQKE6XJK66TsKiE98Ag1ZpaDkkpTkMe4gouNIXZudnpioVwXFut56ypCqr0QmE7JRW
	 NIpnOyrHLS0YiZFEIRzTywaHBUOmRVSDJAIxf6zey9UIAc8O9fQHrvdNse5Tw3GW0i
	 2C4Vmy6wx0my14oAj9GDTzZs8kosKhv8D/VS9QJDCd4UxrCMZc/Q1jtD65yBrm+IeS
	 uWEgYX5clPMpEBYCTk/Hnfu5RJOCl7vYZpanqIDWLwKglyF7FrPUWnHka6dyZRBq3w
	 9wBmBM+3MM3eA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 3/9] Squash to "selftests/bpf: Add bpf_rr scheduler & test"
Date: Mon,  9 Dec 2024 17:49:19 +0800
Message-ID: <48393380a8ac873d9d115023c0da22f0dbb17218.1733737459.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733737459.git.tanggeliang@kylinos.cn>
References: <cover.1733737459.git.tanggeliang@kylinos.cn>
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
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 31 +++++++++----------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index 638ea6aa63b7..eeecbba8973a 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -34,38 +34,35 @@ SEC("struct_ops")
 int BPF_PROG(bpf_rr_get_subflow, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
-	struct mptcp_subflow_context *subflow;
+	struct mptcp_subflow_context *subflow, *next;
 	struct mptcp_rr_storage *ptr;
-	struct sock *last_snd = NULL;
-	int nr = 0;
 
 	ptr = bpf_sk_storage_get(&mptcp_rr_map, msk, 0,
 				 BPF_LOCAL_STORAGE_GET_F_CREATE);
 	if (!ptr)
 		return -1;
 
-	last_snd = ptr->last_snd;
+	next = bpf_mptcp_subflow_ctx(msk->first);
+	if (!next)
+		return -1;
 
-	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
-		subflow = bpf_mptcp_subflow_ctx_by_pos(data, i);
-		if (!last_snd || !subflow)
-			break;
+	if (!ptr->last_snd)
+		goto out;
 
-		if (mptcp_subflow_tcp_sock(subflow) == last_snd) {
-			if (i + 1 == MPTCP_SUBFLOWS_MAX ||
-			    !bpf_mptcp_subflow_ctx_by_pos(data, i + 1))
+	bpf_for_each(mptcp_subflow, subflow, msk) {
+		if (mptcp_subflow_tcp_sock(subflow) == ptr->last_snd) {
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
+out:
+	mptcp_subflow_set_scheduled(next, true);
+	ptr->last_snd = bpf_mptcp_subflow_tcp_sock(next);
 	return 0;
 }
 
-- 
2.45.2

