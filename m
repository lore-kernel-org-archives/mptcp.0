Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67419339A8
	for <mptcp@lists.linux.dev>; Sun,  9 Feb 2025 10:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739095341; cv=none; b=k6ddgnvMdb6VuJnZJfXZuESfT33uJSurUG7tl2BCICtV8pgAWLgsBVIaj660Malfobf476ghKhm8a2ALJbqVn7o4X/QtR/fNiIKMerih6C40o9ERIqih9jA8o//CkrISzI2BmbcVPVibsrq4AeNbfC+bRBTqW+Wae08LNncEkKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739095341; c=relaxed/simple;
	bh=BO2T5ZZjik4RVsV1yvAk+xTNXjhcBH1jTU7iLLtP4so=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqgbKW+YPWMSm43W9MREll2fpV/GqlH9qESakHKq5dCIr+3F/6iO/SfoBtlQhy9OC20V1s76w+rTF2Wk5eEbSbTyEPqb3Yd8lkD6YkY8vQfTiJ0ZbwRsC/eBH/OQOfpS1s+1ZSq14y9qJaPL7iQkOHkCCcdFcWHNuE0+Gj7nFmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiILfI+q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiILfI+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08214C4CEDF;
	Sun,  9 Feb 2025 10:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739095340;
	bh=BO2T5ZZjik4RVsV1yvAk+xTNXjhcBH1jTU7iLLtP4so=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kiILfI+qsLSTNZxjUV2kaDAuInZwn/mnIsHTpaHPXZogeNu4qT6uvxLKKMwAGJAUN
	 p09jO91lTOtHbrCGkc1IzhF2rqNtg8Ega9NKOMfnuRfi92Udh2Ct7C/LRkHWgXyfB5
	 aM36FG6cuBjSmgQFDQI4GwxaiiwGsUu7obI4fWwmxrLYcIO26MF4RvRfpxhx1faHNp
	 Tcs3e19dK5DLCHUUZkEi6yLQrjOC2EIbahwYFnNSQ/V4BYl2h+uG8AXpaFmfEK6EVE
	 0jPAQmedS6YMzcEI30dokbDh36PX7yv2QnOYLuTWSU9kSjks0RzZgFeO79AOJVtL9q
	 1ZMFW7OtQf1PA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 3/8] Squash to "selftests/bpf: Add bpf_first scheduler & test"
Date: Sun,  9 Feb 2025 18:02:02 +0800
Message-ID: <f13ce7494137058fe89260a474fbd7eb9a4cc48a.1739083794.git.tanggeliang@kylinos.cn>
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

