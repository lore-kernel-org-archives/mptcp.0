Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5365E18EFEB
	for <mptcp@lists.linux.dev>; Wed,  9 Oct 2024 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728469805; cv=none; b=RaczV3x3RdRGktZ5OUcdAYBT89GHc0+D+f7WZJl3W3vKPjRgOCTtYcCtZFHRIiDoYvv19A9ciyS+1CrGntSkbl+9RdpAdS0sZlse8nJAvttr9KKB/WRl73KnMpnkVjihER1/TI7ldNR85ha3kflfYyuUA8O+ywR8mJl8VNFGs1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728469805; c=relaxed/simple;
	bh=GWK8Emu7Xenj6RbjmBgCMLp8+y4zcVDWsQH+sR0uMj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=niWs9nr6/+UHRwiXw3GTIaruEmeb49crzk5MzeRypQrhXJ8RR/xdXrkm3pZuquNwuALhTn5fp+EGAQdZxWhz0dI5IqOGe5YkSIBesOJGBGyyaXKUlrwvkVw6Nh5c37864XwUywnhhorWEmfbAoPW/9pexpa8U2zo3YDj8wbkbGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=parVqNtI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="parVqNtI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4637C4CED4;
	Wed,  9 Oct 2024 10:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728469805;
	bh=GWK8Emu7Xenj6RbjmBgCMLp8+y4zcVDWsQH+sR0uMj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=parVqNtIm6AROjkh3dPQXKaZ7w9rfmig9cDYPG+tElgyCSzFCLOBcYyJWg9m0KPXp
	 c9i9v4nDExQvKLYkqyf9m4kkH7d2oVuRTH/kaD9Drei+Nz48piaJKyQ/LfIF9USRcq
	 MmaAncdafj6Mh4731AoJMDu7k7rpGZRrTDAYuDbFZvgEsRZ4ecWXJKnBuIzwWvdrfe
	 KHmur9daXNIQpUtuRJoaataU5yNk4z3SdkCv8xCLRykBZOA7tcwOMM/RNNEMNeZqEI
	 Iq0kHl/9FUNbTcRU5ar/2C8LK1i48bTMd48piNLNGah6T55rN7Ko5dPvrTQDEhrkPq
	 Gk+1/tza6ZUSw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 04/10] Squash to "selftests/bpf: Add bpf_rr scheduler & test"
Date: Wed,  9 Oct 2024 18:29:45 +0800
Message-ID: <e01d2a448696870d0ff1655474bd5897eedbe370.1728469555.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728469555.git.tanggeliang@kylinos.cn>
References: <cover.1728469555.git.tanggeliang@kylinos.cn>
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

