Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8446815534D
	for <mptcp@lists.linux.dev>; Tue, 24 Sep 2024 09:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170127; cv=none; b=poGoUzRR67mDgolyJNQvWeAw7QQyg8XKSaDoD/NpAnm+buSRg2QRhL1YnUDPGjYziL0BENlCtRcjeQjRy0f0XWL8osG4tXD8nUtF0d7zSsExQmWgly5yg+N8VjwYNwk8kWIeF4BiZus531IJMYLaYDoYvp+Qe0zKZXKZwJZHids=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170127; c=relaxed/simple;
	bh=1v+87NR0V3OhPTa2SkWcT/M8UKDCxC31vaswOmge5yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TdIgwp8nrVIDa31OLkaZmqg94thvf7Mw5znHoKzvpruDb7o0mfyd/DuEIslO6P26GVFe1Evz8Zj0MUbG3IEu3T7fP3aYkfYQKE0s0PX9SsBhCKyIjOkQVrzJZu8SUC40DjADhE7i01b4ENSD90+UlCodUBZoHFY9lo1uVw9SiKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUyc6V9z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUyc6V9z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6FEC4CEC5;
	Tue, 24 Sep 2024 09:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727170127;
	bh=1v+87NR0V3OhPTa2SkWcT/M8UKDCxC31vaswOmge5yQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hUyc6V9zNi39d1JAdKC1eAQg1frXXrYOTncGPyqbCdwt0eHbmN6ELp6fP9LNGgWor
	 Nnx+HKBhW+lLKjkmGs/kGzcw2n0bzLF4wFKtHegscjWb6eXN3CDGvMnmp6cqdThDJ6
	 TuMH/tZ7Ujz8mb3TjRZ2SwPm/A6yoC9oR4rHsTpS0hxys8FoKLs/3rakQnSzKZx5FY
	 ADJWbLRJIakMhQ8ArnBomRy6C2Zv/Anu4HrZrGzoiAlmcVUiCjBlPWKHafBJ/NKO6E
	 rOsFaAPrf2+R1xj7iuRn+NYGDYho0lUZCQOSo9uOwhmT13LlWxEGEpbRFlhdpSD57M
	 n6ksEw0RerZLw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 3/8] Squash to "selftests/bpf: Add bpf_first scheduler & test"
Date: Tue, 24 Sep 2024 17:28:31 +0800
Message-ID: <81baea3a0aa8a949b8f1465cecf0a4c1ea45cc12.1727169534.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727169534.git.tanggeliang@kylinos.cn>
References: <cover.1727169534.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/bpf/progs/mptcp_bpf.h       | 2 +-
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index ab46b66422c4..43262a4e85c2 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -53,6 +53,6 @@ extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
 
 extern struct mptcp_subflow_context *
-bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos) __ksym;
+bpf_mptcp_lookup_subflow_by_id(struct mptcp_sock *msk, unsigned int id) __ksym;
 
 #endif
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
index d57399b407a7..807685b3ab97 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -20,7 +20,13 @@ SEC("struct_ops")
 int BPF_PROG(bpf_first_get_subflow, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
-	mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(data, 0), true);
+	struct mptcp_subflow_context *subflow;
+
+	bpf_for_each(mptcp_subflow, subflow, msk) {
+		mptcp_subflow_set_scheduled(subflow, true);
+		break;
+	}
+
 	return 0;
 }
 
-- 
2.43.0

