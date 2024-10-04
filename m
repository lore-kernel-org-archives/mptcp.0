Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B47B20FAA7
	for <mptcp@lists.linux.dev>; Fri,  4 Oct 2024 13:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728046802; cv=none; b=KdBLt4Z8KNvIxXbYZMga3txeZk9FGnUdNOvX9HlFQyB0GYwEcRbofTE4xLn96M+42UvDCAdszhuQnPs2dbRvkTfOvGvWFLmk84Ul59vxDiYHlrY7TvfFIVXZhi7vs9CMZIiPeFGf2O3GWNl1KRpBWoydbgZav52MM3coigfI0Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728046802; c=relaxed/simple;
	bh=GWK8Emu7Xenj6RbjmBgCMLp8+y4zcVDWsQH+sR0uMj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uI2ah+rV1o06uPiAzS0I7cXmQ1axjWKTfXrt6KoDRfq4lp2cuKe+MVB9osqZHDS5Ev3sid80JuLkSl3AePeKpwekPpTUbuTjmy5eK+aPkZRGSxB64hS/5luOgG57qvW8OFOSG5F2R2dMQgW9wLXnzsfSwDqi48pcLRwz/Vh83og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4yr4HKo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4yr4HKo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701BEC4CEC6;
	Fri,  4 Oct 2024 13:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728046801;
	bh=GWK8Emu7Xenj6RbjmBgCMLp8+y4zcVDWsQH+sR0uMj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f4yr4HKownUUIApeAWbcW7Na3NcGAuxl+BG7P9jFtOS9TF2UA8QsCirWJMtz/BLwN
	 32Uv2mvXVdXvs8tYqkIK5UFvMLDRAC4W12i5RJKq8EXkbbx+ea3BS3ZU4A+x2x7DRK
	 c/nqY8iawkZSB+ja8VDd3rOnxORmcANg+9ZTJq6sjtCbhEEc9Rie387htpMsh+AySE
	 oUNnRc+jCpEM415F2jZogSb+5LoWPsdmsuqo0QVqvytJhE5vQApPFFQ8oLnwn3Y4iw
	 uffiajwRp6RoRKS5K5uZCEfDX5T/DILHxiXw7MIcieeN0MM/PHTY88B7EyjD8Q/Xyu
	 SsZ7GLtCWvAng==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 4/9] Squash to "selftests/bpf: Add bpf_rr scheduler & test"
Date: Fri,  4 Oct 2024 20:59:44 +0800
Message-ID: <fb440bc65a9ec5e52b9ab08f413919d7dc824e76.1728046491.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728046491.git.tanggeliang@kylinos.cn>
References: <cover.1728046491.git.tanggeliang@kylinos.cn>
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
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 24 ++++++++-----------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index 638ea6aa63b7..0e806caa10df 100644
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
@@ -45,27 +44,24 @@ int BPF_PROG(bpf_rr_get_subflow, struct mptcp_sock *msk,
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
 
-- 
2.43.0

