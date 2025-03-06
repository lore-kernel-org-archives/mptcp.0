Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC902907
	for <mptcp@lists.linux.dev>; Thu,  6 Mar 2025 02:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741227360; cv=none; b=GnMHFKnKSCEzBnMzdOs8HU3/r6ajhNfDgv6sRoq2xdvj5WlxdKEwfExuGb2D0A0o5G17VSMCLQWKLIyIjK9MdCRWUtzJE5A6tYUBeFPwxcNOMZ6zUODvgSMx84kFMpDJ0cN+do8CR60JQKyuFDf4Dy62YtLuhAv7zT5TWNrWJ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741227360; c=relaxed/simple;
	bh=SkTUxwHD8Pnmu0TpOT9jbEOh5UD7Z+zF5T829AC7qiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N22pRZW7kZA9WeU4xmXmu1tB9fMMZqyBmoYm0qJyZ33STbyMXrFyNTi+ciZhWrpajQeQtciGTwTxgfDO6S2im+iZgHLDFWT217GyqTtQa9/hydhbCNGUXGXSbxvadd2GmcrSo750tYIr66iLgdiswMOj3KTh3xF4MbivHI019dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WthztUOd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WthztUOd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA434C4CEE2;
	Thu,  6 Mar 2025 02:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741227359;
	bh=SkTUxwHD8Pnmu0TpOT9jbEOh5UD7Z+zF5T829AC7qiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WthztUOd/8vK+XU273VbHsDhzbW+v5LVX/8KTDhE9kR+7f3mgAE9NnkMlB/+B+6rM
	 yTyItJnfkM4YjcftotH8vkD+mjt6SrcTfWgTGama8VcScqz2QzzHy5grS4gmmhy36K
	 fz62dM7uU4heX7ES/usZMRqzbCw/64K39WjXd77x4l+AMUg5WztDG44PVJyRPxGler
	 mW0qj1WkPfwJ5q/MYbM9nARO2Ik5jXE05SsQMR0V2QTbDLDwylKIiJvkhOopDAXorv
	 eMAf690aVQlbMbkTksAYni3q5P3pXFjv6WIa6+2KQM0TYLNKkRphqIxgD770tsVyPz
	 fqmZ9fP6FpieQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 8/8] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
Date: Thu,  6 Mar 2025 10:15:40 +0800
Message-ID: <fe22b329dce74ee3a740af5ba669a2d6693369dc.1741226722.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741226722.git.tanggeliang@kylinos.cn>
References: <cover.1741226722.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Update test_bpf_sched().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c      |  2 +-
 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index c069c08371e4..0951313b1189 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -741,7 +741,7 @@ static void test_burst(void)
 	if (!ASSERT_OK(mptcp_bpf_burst__load(skel), "load: burst"))
 		goto skel_destroy;
 
-	test_bpf_sched(skel->obj, "burst", WITH_DATA, WITH_DATA);
+	test_bpf_sched(skel->maps.burst, "burst", WITH_DATA, WITH_DATA);
 skel_destroy:
 	mptcp_bpf_burst__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index 6d930ff0f09f..693fab55f7be 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -9,6 +9,10 @@ char _license[] SEC("license") = "GPL";
 
 #define MPTCP_SEND_BURST_SIZE	65428
 
+#define SSK_MODE_ACTIVE	0
+#define SSK_MODE_BACKUP	1
+#define SSK_MODE_MAX	2
+
 #define min(a, b) ((a) < (b) ? (a) : (b))
 
 extern bool mptcp_subflow_active(struct mptcp_subflow_context *subflow) __ksym;
@@ -18,10 +22,6 @@ extern bool bpf_sk_stream_memory_free(const struct sock *sk) __ksym;
 extern bool bpf_mptcp_subflow_queues_empty(struct sock *sk) __ksym;
 extern void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk) __ksym;
 
-#define SSK_MODE_ACTIVE	0
-#define SSK_MODE_BACKUP	1
-#define SSK_MODE_MAX	2
-
 static __always_inline __u64 div_u64(__u64 dividend, __u32 divisor)
 {
 	return dividend / divisor;
@@ -163,7 +163,7 @@ int BPF_PROG(bpf_burst_get_retrans, struct mptcp_sock *msk)
 	return 0;
 }
 
-SEC(".struct_ops")
+SEC(".struct_ops.link")
 struct mptcp_sched_ops burst = {
 	.init		= (void *)mptcp_sched_burst_init,
 	.release	= (void *)mptcp_sched_burst_release,
-- 
2.43.0

