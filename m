Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27477339A8
	for <mptcp@lists.linux.dev>; Sun,  9 Feb 2025 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739095344; cv=none; b=MOHCqIllM8/ByQWC6n/3/3hH+F7dNI3VL5O5ujsr99COWQxWwG+v8fZrnMjus1JkdMwlXxqdzMquW/ewK4SSaENupFx5bj1VFVSLVNUyq2RDJbmmI7QS09FqiigJ/RWw0+tIpHWkDRwdK7SfAVSkNOnb/FlBHmVLXFtbtrKwu04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739095344; c=relaxed/simple;
	bh=NGXQE9Kif6loAReYC7iiycV9qt5iAyr/88XdrWpLpD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sw9iyOjoYTQXcQv+8kmsZKRAS3Ee4zrHRFFS2q4G9LnfPWW8riS6rU6QfBDUySB4dILL1Cq5zhx+gjAJuKn86FSLkXGw7tH+QOJ3MnpugRxyCrOylgagwWd7pGRKxsZAYvy3R6sAAwZKi9jpldn2uqYgChTY4NsUsBcqG+xOS7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9HoVCXo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9HoVCXo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BC0C4CEDF;
	Sun,  9 Feb 2025 10:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739095343;
	bh=NGXQE9Kif6loAReYC7iiycV9qt5iAyr/88XdrWpLpD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L9HoVCXosXUafaI7u6JIHKrqF7UwD12tGx9RMWMJ4s8GijxRvs376h5KUmnDHUO5b
	 AG/Xt/wL/l1p5UQn4+Wzb5P97gP4L6kZfFsJOrNuac/IUjTL59t+pA/VXkhzxkZS0K
	 uZwHU3+x3XFxCIPqnS2g0GigDAOHTPflLP/AwGKCQIUdjTRg0rC2xEH+3E/3VpRdB5
	 Khm0G8otBDASMAGQJqdZ6+a9zu1uEMoA8SLS4WbRXq7dgZje/Yq8xlrKyHYgVGUHxV
	 qYRm9AKB3bfSIbjP+LG1f8sAGVDDkjxmgApoyxIsk4zijNG3ZUjggyl4ETlO8j9/PQ
	 BDI02z6GKiclw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 5/8] Squash to "selftests/bpf: Add bpf_rr scheduler & test"
Date: Sun,  9 Feb 2025 18:02:04 +0800
Message-ID: <92bef46cc3cf030b91b27f9108045969d9bdb824.1739083794.git.tanggeliang@kylinos.cn>
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

Use the newly added bpf_for_each() helper to walk the conn_list.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 31 +++++++++----------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index 405e96c116d5..4b109adc3602 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -34,38 +34,35 @@ SEC("struct_ops")
 int BPF_PROG(bpf_rr_get_send, struct mptcp_sock *msk,
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
+	bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk) {
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
+	ptr->last_snd = mptcp_subflow_tcp_sock(next);
 	return 0;
 }
 
-- 
2.43.0

