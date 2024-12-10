Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782E8111A8
	for <mptcp@lists.linux.dev>; Tue, 10 Dec 2024 03:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733801532; cv=none; b=E7ILV3l+L6GrJDHx0rOdlD1zWtrVBSapNYlnnGgkxC4cWTOlUboJk3GAGY+ioiFxsNfy/I0MV/5nAnXX01mdixjNDhei7n5EIalU/qZkvE+ICD38R2HtEFvZacyMank0q+fvcaEB23NN7JROGUejWYE0k6NF1ne2J972/RR3pBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733801532; c=relaxed/simple;
	bh=ddTfnLgEZoI1Cw8aheiOu4s52mnraFeRRqdqvon/4/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bABymAtVsI/kUg5PKUpKAZg7HIc8Y5WFTtnB6bEaa9rJAYedOqtf8cc11qdWA/fv5r4aFSdN8Aj9Bb7xbA84KAoU7LckaVXZgRAMq6VocPLG14EgvGawGZRXSvy6IpIxUA+penMMXSp6TeKgeKSmxHtaqt5A0559B8gHOfou73Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnPaW1Ft; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnPaW1Ft"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8320C4CEDE;
	Tue, 10 Dec 2024 03:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733801532;
	bh=ddTfnLgEZoI1Cw8aheiOu4s52mnraFeRRqdqvon/4/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SnPaW1Ft2zzOaEgu++B4Y5boB/ujgUF3LuZnSn48qzAn3/Yv/2Mltf6vyDXTjB43+
	 Y5zh4dyDELIqfjALdMGQ358gDwiNpyo6sJ4ExzIJ7DOa9afbNpVFSk2g2FsE5zqjwC
	 ljFdcJdjtxYe2N51pGawkva8I3w2HgwdsC58ruGL/aXt0xYXq5jWxelOlWjsJ+Z5sK
	 rMTdzquT70O9cN960RTtgkYxM3+bkxKt0n/AcZJm4V6EnTX3/Ayq1pE4E9FsY2neBv
	 xJMCLeXJHwSrKH2VZFXh4HTb8WD1/nUMM3fs84/KunGFaI6zaE2JMoMnpg7Z+FyBLM
	 GGr1TvfjurYOA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 4/9] Squash to "selftests/bpf: Add bpf_red scheduler & test"
Date: Tue, 10 Dec 2024 11:31:41 +0800
Message-ID: <77166477ff86902f591621e8f544cff43ad63554.1733800335.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733800334.git.tanggeliang@kylinos.cn>
References: <cover.1733800334.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
index cc0aab732fc4..ce19d604b898 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -20,12 +20,10 @@ SEC("struct_ops")
 int BPF_PROG(bpf_red_get_subflow, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
-	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!bpf_mptcp_subflow_ctx_by_pos(data, i))
-			break;
+	struct mptcp_subflow_context *subflow;
 
-		mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(data, i), true);
-	}
+	bpf_for_each(mptcp_subflow, subflow, msk)
+		mptcp_subflow_set_scheduled(subflow, true);
 
 	return 0;
 }
-- 
2.45.2

