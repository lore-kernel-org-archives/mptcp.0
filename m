Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C65522577D
	for <mptcp@lists.linux.dev>; Thu,  6 Feb 2025 09:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738832717; cv=none; b=Mb2uysBUYai+WLtAJ3gbskPftDZb3eKrUZL+27aCa+3aFEIMdoUXvMk5wY3QzwqUTfOqRyJ+8/VlvKyZt0R5xTpApLdNEF9KBiS5pOON1/KkfsC7ZZRr7jm5DHNdWvAGL6UpjUP8AGk6vBHOEglvUGnOiYK8V/BiRWC/V5Z9WZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738832717; c=relaxed/simple;
	bh=BO2T5ZZjik4RVsV1yvAk+xTNXjhcBH1jTU7iLLtP4so=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XlMbA0A8sdvxzX9Yz48SHId3LAfSqWsWvnw7PsQPnkS47LdM/5IjtP8PZTu01UsCIoXz//sVm+Yh8nea3gwIeTf/7nRsr6NHYuZnwayjfRgaVxME5PEmlJyD4Gth9+kGNAGDEE/K5rBcjRQ289PP4lbDDSnh4sSW5ZP9A1m7ikA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8OHU3mZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8OHU3mZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF27C4CEE0;
	Thu,  6 Feb 2025 09:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738832713;
	bh=BO2T5ZZjik4RVsV1yvAk+xTNXjhcBH1jTU7iLLtP4so=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V8OHU3mZmcqpUbogoGv4f0xY9G547drSDPhuU76HhBmrPvq0NbjJDGUu2rADGKJVK
	 5hYw0TJFedTN9tuG5Ngwg7qV+cQIJ3Jj4yas+gS7PIfiBEper7arBENSQVyKwblwd2
	 1z5wSztUcnDg3M/6255nTqKea0uGz5mykXviFPs93I7WpsKEBwZYScJ8UMwfU2KzE7
	 PximnsQ175vMXFm6SyXcQ9o1AEeeY/4iNzMj57VSdX/goBim5g9DOqma3QvaDyJd7T
	 uM03T/Y89gcSKmX6DFJiBBbaIRENyt4IOj3n/mchxBKP09mAd73IvT7UlPTdn7bwDN
	 zqieaXktUhUtA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 4/9] Squash to "selftests/bpf: Add bpf_first scheduler & test"
Date: Thu,  6 Feb 2025 17:04:54 +0800
Message-ID: <bf236e54cdeeb0ae23fc6437acb05573f0c99942.1738832147.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738832147.git.tanggeliang@kylinos.cn>
References: <cover.1738832147.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use the newly added bpf_for_each() helper to walk the conn_list.
Drop bpf_mptcp_subflow_ctx_by_pos declaration.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf.h       | 3 ---
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 8 +++++++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index ede9111ee597..badcffe0942c 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -51,7 +51,4 @@ bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow) __ksym;
 extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
 
-extern struct mptcp_subflow_context *
-bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos) __ksym;
-
 #endif
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
index ab71ae3c6506..73b18eeeb62f 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -20,7 +20,13 @@ SEC("struct_ops")
 int BPF_PROG(bpf_first_get_send, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
-	mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(data, 0), true);
+	struct mptcp_subflow_context *subflow;
+
+	subflow = bpf_mptcp_subflow_ctx(msk->first);
+	if (!subflow)
+		return -1;
+
+	mptcp_subflow_set_scheduled(subflow, true);
 	return 0;
 }
 
-- 
2.43.0

