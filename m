Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FEE20764E
	for <mptcp@lists.linux.dev>; Fri,  7 Mar 2025 11:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347438; cv=none; b=B2ElZw1zIZb+pGgDTh6C6kmbqN3jyBNzVCVuMbx85pEF2qkgwfGGGqMF6iSdT/Kc8U07+jUAJeFMyFnfTUYtmp95V+TK8dk0/9r8FKGvRwsC8riT14JH/tMHEZ3dMh7HduD3O6E4cf6amJ3EYh0TfBLTfhemLCXTL4aMTkpoKXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347438; c=relaxed/simple;
	bh=/Illmz1o/zIazsySjVDcDkIezFG7hvXGnJQKvjRny9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GpWLgoy2ZYcUwzUwFDElTgCsys+v6p2mVu2SNLioNpRvWkI3c50zXHmHgz42T+BYAf6BmmpkFzduLKqr4Mx0cPtrJDHAUCIqUk3ShvOTtK50Jt4DppX59kj+qbDFg2Zd+qsWYebxiWnGeMU8B4Jq/8Gb8rn6y5hAbHZFRJeK/fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGuAVnwc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGuAVnwc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7549C4CED1;
	Fri,  7 Mar 2025 11:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741347438;
	bh=/Illmz1o/zIazsySjVDcDkIezFG7hvXGnJQKvjRny9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cGuAVnwc3idd6fYmasmO9EyoQtETwymeMeVr+GlyROOnJDE8kgLU1bOo6UvEQ7496
	 0fU6+raic2mK6B1D9MtAZGNwXfQKDVgsfMgdcvd/ol7wasm/DWFF7zMp5cwtQ5AT6G
	 7u7dYwK8XmqwMcb4EwMAc559THW6P6Vz2Q7H0xDDnwgdbozXDr4QjmW/hMggVHKCsh
	 AUipjqOPohmAO9L1THdcvraiJh1eAd+Wqmjlfb1ZOoTfs2nE/vt52epG4O+3dU/lOG
	 +ZVhC0eGkVzjRxrcRL7gA0ZhUTY01bDUGuBeKnVi9OlP2137/babQinCTLzOChSm3E
	 HKZZHDr6QFfkA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 10/11] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
Date: Fri,  7 Mar 2025 19:36:51 +0800
Message-ID: <e86c9c7a430826b7e5b2bddb65e01fc9c6cc5eef.1741347233.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741347233.git.tanggeliang@kylinos.cn>
References: <cover.1741347233.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Keep mptcp scheduler API unchanged.
Use mptcp_subflow_sched iter instead of mptcp_subflow.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index 6d930ff0f09f..3828af40fa50 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -50,7 +50,8 @@ void BPF_PROG(mptcp_sched_burst_release, struct mptcp_sock *msk)
 }
 
 SEC("struct_ops")
-int BPF_PROG(bpf_burst_get_send, struct mptcp_sock *msk)
+int BPF_PROG(bpf_burst_get_send, struct mptcp_sock *msk,
+	     struct mptcp_sched_data *data)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -66,7 +67,7 @@ int BPF_PROG(bpf_burst_get_send, struct mptcp_sock *msk)
 		send_info[i].linger_time = -1;
 	}
 
-	bpf_for_each(mptcp_subflow, subflow, sk) {
+	bpf_for_each(mptcp_subflow_sched, subflow, sk, data) {
 		bool backup = subflow->backup || subflow->request_bkup;
 
 		ssk = mptcp_subflow_tcp_sock(subflow);
@@ -120,13 +121,14 @@ int BPF_PROG(bpf_burst_get_send, struct mptcp_sock *msk)
 }
 
 SEC("struct_ops")
-int BPF_PROG(bpf_burst_get_retrans, struct mptcp_sock *msk)
+int BPF_PROG(bpf_burst_get_retrans, struct mptcp_sock *msk,
+	     struct mptcp_sched_data *data)
 {
 	struct sock *backup = NULL, *pick = NULL;
 	struct mptcp_subflow_context *subflow;
 	int min_stale_count = INT_MAX;
 
-	bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk) {
+	bpf_for_each(mptcp_subflow_sched, subflow, (struct sock *)msk, data) {
 		struct sock *ssk = bpf_mptcp_subflow_tcp_sock(subflow);
 
 		if (!ssk || !mptcp_subflow_active(subflow))
-- 
2.43.0

