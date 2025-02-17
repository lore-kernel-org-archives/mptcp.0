Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FBE23CE
	for <mptcp@lists.linux.dev>; Mon, 17 Feb 2025 10:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788888; cv=none; b=bohrHFaJKu7vOTT4u56VcPpKMOC9bqDyGO/XLjFLFgQnEVXgDgApn9GsuVa4kp0QTMgm1FB+lMpEpwQiYHK2uXWYDSFf8pY88+mdAO8+3PwFcVf3ERCTw4C8mZoJw/dgTvkuP1ypi2X29rQqKiWXc0U5QZFPHTJMRjxhmfWICR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788888; c=relaxed/simple;
	bh=nQZtedKpWAKqD5FAUaS5Q2jXabjfb2+9JYJPXNxUuYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=et8/65zVJHEOOO7X5zWoSLEGBhn7MFK0d3WoL84PvvE9OKpHkPG6PV48FTrycUCUGH0dO20Wr4PsKPWFwFuBnrMnQ5ZblJQTMzRG42E1GiXjSgsVIarkEyJERuVkT/EocHHoUJh96tt3KgBkO3agOcEVCVLEHngeDk8Z5VVd5ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFU1uQlT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFU1uQlT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D45C4CEE4;
	Mon, 17 Feb 2025 10:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739788888;
	bh=nQZtedKpWAKqD5FAUaS5Q2jXabjfb2+9JYJPXNxUuYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TFU1uQlTC/o1JFzvJyViQWIKdGJmAkCvV4Iv88JwOcA1297eSmFjjz2TwMAwxMF1T
	 Wth6B/XHjLfoCAXar6kJNhzYPqtsmQq/RzIReB0dTNWaMDeR+/Wrk4j6h4kto59cjs
	 0ccMYeRgF+UIZVOBCnc7bD6YdOEOQmmGzRMhPhRlT8sRZNWqoNLEVwoEsg6sMha3Fh
	 LNSt+DVfaI+UE9UqG2zGjIywXJ81dHTthCTlQjdHpsKWKK9436qkkKqb7JJ2LjdvsT
	 wDRfytLj/pdUdYvsZT6B4QZc/D5yztBDPnfHxl+h8eU0DQmehVsnolsF3HhCrtZjjp
	 ln0yclbPKzfCg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v15 3/8] Squash to "selftests/bpf: Add bpf_first scheduler & test"
Date: Mon, 17 Feb 2025 18:41:13 +0800
Message-ID: <472c328dea486ab602e167e5b68084a48cb906b0.1739788598.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739788598.git.tanggeliang@kylinos.cn>
References: <cover.1739788598.git.tanggeliang@kylinos.cn>
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
index 72263672510a..2eb2c1c3bffb 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -49,7 +49,4 @@ bpf_mptcp_subflow_ctx(const struct sock *sk) __ksym;
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

