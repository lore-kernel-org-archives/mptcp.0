Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702B1127E37
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583557; cv=none; b=pRmfXPmjlYAPQxRjXKFGzqQ7Jss5/Gg5K1+SsTFva2sd8gG2QrKj9uPswD36R9al0S/hjBRrUX5PSam5jQIPnMsO9xIpsIceMStWnDtj1wgsgEHeZi7A8Soq9+0tELxovv0ihXzhrH7I+Mn+ItFbay6/6Gcz18FaO90WNYAFBLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583557; c=relaxed/simple;
	bh=Ec8Z7woGTXV2BvkDP0bL2AvpRDclTAnC8E1ey3KzY+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tuhR54QNegnlONSgXrDlr10rUZ6udeAxgu1/P+ukZtZCkVGam1Fw/4evkCDzFmUJfxSh8L+BJ1Z4HaP8mpmPeiWScRfbm/jb0zprf8bFf71p0vvOtPFatmKj4+RO71d6+5iSEZTw5F6hHJ5OlvHnPr38lsWUcvnQoPu6ddVZr2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXSbumeE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXSbumeE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF646C4CEC3;
	Tue, 22 Oct 2024 07:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729583557;
	bh=Ec8Z7woGTXV2BvkDP0bL2AvpRDclTAnC8E1ey3KzY+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FXSbumeEKVNAu8JqiRnmG094YxQZGc2y3+yqHx+kf0Xda4Su2wSw5IJyCjLwxhyAi
	 rL+F1lFKhAHF1SdPOraCM+RD0FixntQOzSIW05IPFBZBcMCkFpB1oIirFtDW1/CDHJ
	 wc66MsZW8gGLktUB6eYJ2lfBcw4Y83lXYnrxAUTc+6xx5QGFQmhGUFqvBg5MY847KQ
	 NFF8JZnPzm4tnsYivAPcpKgcvWhNjQhySmm8vrkGX9gySMX+R9Wv5+fOI0Wyh9Mk0Y
	 Y9FURIs2E8intKxxrJnUFRk7QPPNHfhLV6hE9EBsWA4OX2QGJimewNUFKMr0e4X/r6
	 oG0V9/WwfGb4Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 1/5] Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
Date: Tue, 22 Oct 2024 15:52:25 +0800
Message-ID: <b048667bd1c1ddfd43d7c3da6f02a0486ea27fa5.1729583414.git.tanggeliang@kylinos.cn>
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
 .../selftests/bpf/progs/mptcp_bpf_bkup.c       | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
index 296f0318d843..0c32ce623bab 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -20,30 +20,20 @@ SEC("struct_ops")
 int BPF_PROG(bpf_bkup_get_subflow, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
-	int nr = -1;
-
-	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
-		struct mptcp_subflow_context *subflow;
-
-		subflow = bpf_mptcp_subflow_ctx_by_pos(data, i);
-		if (!subflow)
-			break;
+	struct mptcp_subflow_context *subflow;
 
+	bpf_for_each(mptcp_subflow, subflow, msk) {
 		if (!BPF_CORE_READ_BITFIELD_PROBED(subflow, backup) ||
 		    !BPF_CORE_READ_BITFIELD_PROBED(subflow, request_bkup)) {
-			nr = i;
+			mptcp_subflow_set_scheduled(subflow, true);
 			break;
 		}
 	}
 
-	if (nr != -1) {
-		mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(data, nr), true);
-		return -1;
-	}
 	return 0;
 }
 
-SEC(".struct_ops")
+SEC(".struct_ops.link")
 struct mptcp_sched_ops bkup = {
 	.init		= (void *)mptcp_sched_bkup_init,
 	.release	= (void *)mptcp_sched_bkup_release,
-- 
2.45.2

