Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874A119DF41
	for <mptcp@lists.linux.dev>; Tue, 10 Dec 2024 03:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733801528; cv=none; b=exFafvNx2ePbZRWTmoVSraqAdSzIIG8dgCzgJ9SJX4PbcoaZmyJWPSIoHk9AYMJcM8gxjYv6QAnPi0JEoY/FWNsUydv7TQFJE6fDLsZwrJd6HZxk/9mgng5uinQHJOhX4nwkyts7ir6LdO4pQlasdkR3U4XC1GLXZ9dD0tOsq8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733801528; c=relaxed/simple;
	bh=Ae5ZluSOvGKGy4++0Dz1LYKoAm6vXOPxH/8pQHBeTqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RcH1munD1C75rYfPdVJlcbJ4mmjXWI7bNlyTFDRYlms3VpFBQ601OQ6DruZtepcu/qxVkdlOWq22YVMDAzU8H0QmEWB1FJdYA0gQa+9eL1E3/yRLrd88ebSmadZ0j/i/WwMJWfbBw6WMgxoinczS6/ryF7F6REJFm2s0palB2HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZnA85yD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZnA85yD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309D6C4CED6;
	Tue, 10 Dec 2024 03:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733801528;
	bh=Ae5ZluSOvGKGy4++0Dz1LYKoAm6vXOPxH/8pQHBeTqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WZnA85yDHZF9oZH6Sqkmz+ILzfEzwDRn4LXS6Pc42SDRyVlw6vbcl8zqVQ13ZQ9ce
	 4lhhwn0uaVGmfy/PXMSTgvTww9n+gXSgVm+DvBwYOPYoKAukEamAsw3+LK3swKIYc/
	 hdGFr4a32+wD+0IkSF2VQCJulwZjui5zOg2dGapvoFn+8RLBssOdpAPmuu72chERKZ
	 osnxlhRFSnY+akuLrCgLBPF4F55NvJ3UalX1T3PUrNDkpva3mCP11k8NISuTG4hUwC
	 MvPz8GFsyT9ldvD+iONTGIgM42Tg5elLmOMuf+JFA8TaDOw8uFZoMNXKv22YJKInIg
	 tk8+dOr7+6ZgQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 2/9] Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
Date: Tue, 10 Dec 2024 11:31:39 +0800
Message-ID: <e75e4fdc41ec45eb53335d64d8d1d49a91d4f123.1733800335.git.tanggeliang@kylinos.cn>
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
 .../testing/selftests/bpf/progs/mptcp_bpf_bkup.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
index 296f0318d843..70c3a69d4a47 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -20,26 +20,16 @@ SEC("struct_ops")
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
 
-- 
2.45.2

