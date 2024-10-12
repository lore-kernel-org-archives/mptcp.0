Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885D41E511
	for <mptcp@lists.linux.dev>; Sat, 12 Oct 2024 13:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728740560; cv=none; b=p+peYVd8AszsX8EWSL70TZli7eVu38xWVrh6atyyMS3oQcrFGhgQ48Mc/i6ai/RzifWiZCt2hBZKdT1dg6GiFrwpg6ZYEismpb91rstJyuVZxpBZcPiiq800vUbUYr+40RDNkUjR9ezICeLRQqw6SxXJ1uToeLsTsdqVc3vEsFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728740560; c=relaxed/simple;
	bh=LBbhZRE7O7iOP8AKfoYUNWYs3cuAD5rsHQ/AU3RUl5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAvgEGdv0KZxSfJUl9kwrh5O5lb9CkBVgSo6bK8l9IqadkzKvEe9tVlGefcVQA4HLwdfP2rIKbtK2WziO9Y+TR4cW7uBbh6VJznaJz+HQ9qtgNlw2eBX5K7vtHkN/5Z8nLJ6j6zfBSjjfuGSxfuvwo0gIizVlxmoWv6X0TOthzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYh7YuKD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYh7YuKD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5361AC4CEC6;
	Sat, 12 Oct 2024 13:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728740560;
	bh=LBbhZRE7O7iOP8AKfoYUNWYs3cuAD5rsHQ/AU3RUl5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iYh7YuKDEg+BxD6gZhKChIi2DA7ozA/kplcbwf68uog2Pb5AIJx58JH2MnBc3sCsk
	 97nArHAfVhTizuewTrT4yIcrK/sih/oWgZo3zns8yJIz+7AQU9bUgftb9XiNZ88s7G
	 Y3Y5vXncwUB8bagVPqZ9Thfo0dLMX8KBpdsmEbRuXCgH+vg+OQHZq7prh5O6D9JFqI
	 KbvE700hkTEwk3pbG1a2jzU3zNsi3dEIDCXJkQJTfwp7l0QAB1fAxYb+lSfnfCY8Gz
	 AiaY1vyO2FrN9Gh/sFyTS+5UC0FMQPMpjzlZY5LBt7dScKjB+xQtd6NZJwuUAzQ5FV
	 OVVl5cOlYMHvQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 05/11] Squash to "selftests/bpf: Add bpf_first scheduler & test"
Date: Sat, 12 Oct 2024 21:42:10 +0800
Message-ID: <1e5c4f6e9ca1bb672aa6a77f64f9519bc84ab811.1728738220.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728738219.git.tanggeliang@kylinos.cn>
References: <cover.1728738219.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/bpf/progs/mptcp_bpf.h       | 3 ---
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 8 +++++++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index e18796361394..260bc239655a 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -55,7 +55,4 @@ bpf_mptcp_subflow_ctx(const struct sock *sk) __ksym;
 extern struct sock *
 bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow) __ksym;
 
-extern struct mptcp_subflow_context *
-bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos) __ksym;
-
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

