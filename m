Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52E117F7
	for <mptcp@lists.linux.dev>; Mon,  8 Apr 2024 03:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712545281; cv=none; b=jqwbbWMJkK3Rb4Gm22Y3FAbvjpyMxlCRcZ/lWkhVZXggYYU7Cdqwhlm0rdv+LXOGCM1A9nVe7DWbWNQP63JDtJKuyaxuDl14s7ZMG7LqvLvdvXBxh0epa1javX2QOFbQCNhh/hyTcN3Q+iHKWKzwXNo4EGhsuMv/MaUtV91iS48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712545281; c=relaxed/simple;
	bh=miU5/JnDXlMBDqGQ63d1V8r3Bo2+LzfuyBB2UB2k+0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FaB4iakplK3fzSr76sorJ2/nsFPMRuQ4EDmnysoma9MrqnSKMC9FD82saX1iEd6p0jBsZM19/CfnfzqGb74LogQGWX5UfnlG97HZ2ijnxiK1n108PFvSHF6QJwSYbRLXUnwWkqFv6pcVy6PewrffN7XGc+IuNxvavu4WK+yz6os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajg3K7cs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajg3K7cs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4AFBC433F1;
	Mon,  8 Apr 2024 03:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712545281;
	bh=miU5/JnDXlMBDqGQ63d1V8r3Bo2+LzfuyBB2UB2k+0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ajg3K7cslF3uM4uGeyYO1jb8b+VYq1hdblb+wpddu2C7P1CaU8RetgdaEcRUu5Dgh
	 qoBlwcApQ3So5TF88ZNm5Fi1R0K/QBwqyXvSZgtsW3S0mrPWoNGUgDGSqic65Hz2c/
	 Qj8sqwgJRAH/cZdCsKet67CJIDoacFL93cXXjfBe6W9yHlF6HU8gohLtIUgcs0AgHn
	 Q2tYhGKJ33Z1YqIvtp7rLRn1ciOUb6VJ/lohzgGud25qv8O/ZC2Jc5F0AXCXuvpShm
	 Wr+AMgw7gLUTtgCgsaFQ6e0SqnclSIyB06Kni2WaJa+hD+LFMn6hWtvdTwYZX+4KEo
	 77+ztdI8Om5Ag==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 4/9] Squash to "selftests/bpf: Add bpf scheduler test" 3 MPTCP_SCHED_TEST
Date: Mon,  8 Apr 2024 11:01:06 +0800
Message-Id: <2a6911913dc04a33d031977a346c9e459f899fe2.1712544986.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712544986.git.tanggeliang@kylinos.cn>
References: <cover.1712544986.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Please append this into commit log:

'''
This patch defines MPTCP_SCHED_TEST macro, a template for all scheduler
tests. Every scheduler is identified by argument name, and use sysctl
to set net.mptcp.scheduler as "bpf_name" to use this sched. Add two
veth net devices to simulate the multiple addresses case. Use 'ip mptcp
endpoint' command to add the new endpoint ADDR2 to PM netlink. Arguments
addr1/add2 means whether the data has been sent on the first/second subflow
or not. Send data and check bytes_sent of 'ss' output after it using
send_data_and_verify().
'''

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index aa95bb41d5ea..93819f0e76d7 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -498,6 +498,36 @@ static void test_default(void)
 	cleanup_netns(nstoken);
 }
 
+#define MPTCP_SCHED_TEST(sched, addr1, addr2)			\
+static void test_##sched(void)					\
+{								\
+	struct mptcp_bpf_##sched *skel;				\
+	struct nstoken *nstoken;				\
+	struct bpf_link *link;					\
+	struct bpf_map *map;					\
+								\
+	skel = mptcp_bpf_##sched##__open_and_load();		\
+	if (!ASSERT_OK_PTR(skel, "open_and_load:" #sched))	\
+		return;						\
+								\
+	map = bpf_object__find_map_by_name(skel->obj, #sched);	\
+	link = bpf_map__attach_struct_ops(map);			\
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops:" #sched))	\
+		goto skel_destroy;				\
+								\
+	nstoken = sched_init("subflow", "bpf_" #sched);		\
+	if (!ASSERT_OK_PTR(nstoken, "sched_init:" #sched))	\
+		goto link_destroy;				\
+								\
+	send_data_and_verify(#sched, #addr1, #addr2);		\
+								\
+	cleanup_netns(nstoken);					\
+link_destroy:							\
+	bpf_link__destroy(link);				\
+skel_destroy:							\
+	mptcp_bpf_##sched##__destroy(skel);			\
+}
+
 static void test_first(void)
 {
 	struct mptcp_bpf_first *first_skel;
-- 
2.40.1

