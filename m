Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087B719AA46
	for <mptcp@lists.linux.dev>; Wed, 23 Oct 2024 09:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729676442; cv=none; b=pICKsiXNcEQEdidvPP4xtrjuLn3VvD+yXsWHjK5y+LNE41wE3QcZihp/nYP64EN6/Y9ofdsWmsu8uA7QvYAWy+xxKlMue9ohREE47tvkSJkfuCg+Qh233b0/2sOF2QMr4jZTVLCvVILyJDIAu5VjuZVaLEt6sgQaHNO68TbWyx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729676442; c=relaxed/simple;
	bh=Xgm8DMyGUevxbQhlUHWB9lrRYhoSP1Ninc5C+Qg/FvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dDOx6gQ6SSSCKSrCshIe6bhXHNyy3D9uE8DhgkX7qpNCbi2pGZk0MeXiCzR2ccf3XhzmJ1cULyBZU/tKQgASGQG1z8QvaHj1rAHUlDT6Rp0XdWCZpdbfgMyuVbUSH5/rFWdwQeC/2uDz+SpWMPS+caKMY/QScn3LzC6vo7vM0L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMxBQCFI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMxBQCFI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F006C4CEC7;
	Wed, 23 Oct 2024 09:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729676441;
	bh=Xgm8DMyGUevxbQhlUHWB9lrRYhoSP1Ninc5C+Qg/FvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZMxBQCFIN3m5jsay9Dl5lQwRoX5GbZRq5BopvYCkJ+OOp08D21xOT+/s1JQrfusFh
	 0qnnPfUIfugxCRSS1gmIYWjzf62SX66AinCSO3+cYsjmv1mJGUDlihFUzMYeABTuSA
	 yEnFymtuZSNQZ7AKiLW7sgo0WidUgnIRMBwhRdqpK6LchuUV1rpsXFXEaR5iOjve44
	 sTgbKWdCJaIzesQusblKzlisLya+mdNKfnf1QipvWEU8ZIlKAMf+SlgwIjjXTagN5+
	 WJBmnn6SlY43SeV28IfZhA8+kwqp1GY00QND4WQlfesRP07DTTtH70JZASrU5H1OfW
	 Tqjn/CAWnF1wA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 06/13] Squash to "selftests/bpf: Add bpf_first scheduler & test"
Date: Wed, 23 Oct 2024 17:40:16 +0800
Message-ID: <4329419175bacbba46793ccb502f5924d35d2931.1729676320.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729676320.git.tanggeliang@kylinos.cn>
References: <cover.1729676320.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

1. Update sched_init.

2. For drop bpf_object__find_map_by_name in test_bpf_sched(), change the
first parameter of it as bpf_map.

3. Implement mptcp_subflow_set_scheduled in BPF.

4. Drop bpf_mptcp_subflow_ctx_by_pos.

5. Use the newly added bpf_for_each() helper to walk the conn_list.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c    | 15 +++++++++------
 tools/testing/selftests/bpf/progs/mptcp_bpf.h     | 14 ++++++++------
 .../testing/selftests/bpf/progs/mptcp_bpf_first.c |  4 ++--
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 9758ee83c81f..1c63396e1eba 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -663,27 +663,30 @@ static void test_default(void)
 	cleanup_netns(nstoken);
 }
 
-static void test_bpf_sched(struct bpf_object *obj, char *sched,
+static void test_bpf_sched(struct bpf_map *map, char *sched,
 			   bool addr1, bool addr2)
 {
 	char bpf_sched[MPTCP_SCHED_NAME_MAX] = "bpf_";
 	struct nstoken *nstoken;
 	struct bpf_link *link;
-	struct bpf_map *map;
+	int err;
 
 	if (!ASSERT_LT(strlen(bpf_sched) + strlen(sched),
 		       MPTCP_SCHED_NAME_MAX, "Scheduler name too long"))
 		return;
 
-	map = bpf_object__find_map_by_name(obj, sched);
 	link = bpf_map__attach_struct_ops(map);
-	if (CHECK(!link, sched, "attach_struct_ops: %d\n", errno))
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
 		return;
 
-	nstoken = sched_init("subflow", strcat(bpf_sched, sched));
+	nstoken = create_netns();
 	if (!nstoken)
 		goto fail;
 
+	err = sched_init("subflow", strcat(bpf_sched, sched));
+	if (!ASSERT_OK(err, "sched_init"))
+		goto fail;
+
 	send_data_and_verify(sched, addr1, addr2);
 
 fail:
@@ -699,7 +702,7 @@ static void test_first(void)
 	if (!ASSERT_OK_PTR(skel, "open_and_load: first"))
 		return;
 
-	test_bpf_sched(skel->obj, "first", WITH_DATA, WITHOUT_DATA);
+	test_bpf_sched(skel->maps.first, "first", WITH_DATA, WITHOUT_DATA);
 	mptcp_bpf_first__destroy(skel);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index 3b20cfd44505..f8c917dc2c1c 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -42,6 +42,14 @@ mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 	return subflow->tcp_sock;
 }
 
+#define WRITE_ONCE(x, val) ((*(volatile typeof(x) *) &(x)) = (val))
+
+static __always_inline void
+mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow, bool scheduled)
+{
+	WRITE_ONCE(subflow->scheduled, scheduled);
+}
+
 /* ksym */
 extern struct mptcp_sock *bpf_mptcp_sock_acquire(struct mptcp_sock *msk) __ksym;
 extern void bpf_mptcp_sock_release(struct mptcp_sock *msk) __ksym;
@@ -52,10 +60,4 @@ bpf_mptcp_subflow_ctx(const struct sock *sk) __ksym;
 extern struct sock *
 bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow) __ksym;
 
-extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
-					bool scheduled) __ksym;
-
-extern struct mptcp_subflow_context *
-bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos) __ksym;
-
 #endif
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
index d57399b407a7..5d0f89c636f0 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -20,11 +20,11 @@ SEC("struct_ops")
 int BPF_PROG(bpf_first_get_subflow, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
-	mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(data, 0), true);
+	mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx(msk->first), true);
 	return 0;
 }
 
-SEC(".struct_ops")
+SEC(".struct_ops.link")
 struct mptcp_sched_ops first = {
 	.init		= (void *)mptcp_sched_first_init,
 	.release	= (void *)mptcp_sched_first_release,
-- 
2.45.2

