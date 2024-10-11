Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7934B1F942F
	for <mptcp@lists.linux.dev>; Fri, 11 Oct 2024 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728638858; cv=none; b=PjRTNMobFmn7h2mpTU1/+/ceaJ2nfGL9xSXjhLRXcxr15cqD9DVpLj6WbmpoH/UMMQU0fUI1nQgz/ckDdbzsGejqQHGMGkL/yDVKbFEZcozwgEM7ZAQJn8hJ7Hcc05RO/sp7FEFQaYDNV6zPmhHJK9zSNmpKudetkuzM6BMpnqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728638858; c=relaxed/simple;
	bh=+Ns9vcAYflyNwdX3DkGpNegQAHdxvHGggo6htLg093M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M9OEil99tkKftk3WEqPVrkQ22+XVYCK0m/D07wpChpTH0DucwYdJyQ5pgS7buR/zyfvSU67xZP9L2ZxZJO/we5wcR3mQkFUO0WeSM69CVxFfdGQVwOGp3tsSWvpe8yW58hFiNLuPUQt3bQwFAA6P7YqDfb3PA6LpIy2P4oq0gu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZgM/JmZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZgM/JmZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1957C4CEC3;
	Fri, 11 Oct 2024 09:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728638858;
	bh=+Ns9vcAYflyNwdX3DkGpNegQAHdxvHGggo6htLg093M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AZgM/JmZdGew6ilMrrMLUN8Lipr0MF/aHkIofphr3H53Iwas8pDvoTfTxT7l50axR
	 HIkor/5r2RZ2Srg+U7hM2N9Xdk6yjl4c2LS1124psoyvQoZcrfcHEHEIaZXCTgWalk
	 Hin1yL1shkM8oL7D2ts3FCOhzD+BN9ocJ1i0hRklg1Sg7Qb+TPDmDBGtDDNccVS3ps
	 J6z5qhhY6SmnCltbp76F2XY9AH7Io40CSw1Up9bgJdI/PVO//+Ft1F6e10ZWFgDH6J
	 NA5/VtHX0oRvMZlXWa98cklX5KuJPANLiDP4x/4uy3rYRnxLC4LGWnUQ2eoxZFXYyx
	 0P3bI4vczQhwQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 05/11] Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
Date: Fri, 11 Oct 2024 17:27:17 +0800
Message-ID: <035577c49107a9a76c8d1f509743c22c0d33514d.1728638310.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728638310.git.tanggeliang@kylinos.cn>
References: <cover.1728638310.git.tanggeliang@kylinos.cn>
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
2.43.0

