Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5389418050
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 05:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712034773; cv=none; b=fyWS8A+f7Ha8md/zZtrtPuobX1zAC/9JIuTJXuBvCEaowzLLzKkWRTTbj6IgzSK8+mEjQn16QhN3LqZP95sr+ee1pqLDY4MspzPTAJkNlXk5f/BVHsqZEtsp8Lx20vrXMKXhJ/RDmwhNeT8SHwPPAVwPzDbDse3JNF6NegxDwrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712034773; c=relaxed/simple;
	bh=eikELp/h/4AdreugnfAmwZQRhA3CaTCb/bvM2aJhlXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RvmrOhNVaufb0d6JbZBd4UHhRlF3pfFJUG8u1NL2D1sckK3yCyI0O0aVS1GN+F9PXh/aLhkZS0hbjptj8jHl2g5x50BnojWg5HBCfSfv9SQIFbezLI4UXhCaEgDpWqKR986zRzfb709wsm8W225pbpDMMSPbRjkbYgdVj2PY9wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJdiKfpB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJdiKfpB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A57BC43390;
	Tue,  2 Apr 2024 05:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712034772;
	bh=eikELp/h/4AdreugnfAmwZQRhA3CaTCb/bvM2aJhlXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KJdiKfpB93J4NfaHQxHe50+8bhvr/h6wBZef1Xa4c1H5jUoRGtMvE82XWO7Su2qGU
	 P3eusQ57TZSeDxR8BuZ4MVYy/d/FDe8VPJSHLLzXfrNDBuVJoF6K3dEIHAP403LQ+n
	 x+JSjrm4A9PLaLd7/q55O1KbBdfwu18SgS8v++FWDll7UUIhNZhJyW27VMuRShYVvL
	 mTv6LNRMr9ApGW3fRzS0qcG4HVR0oIFIXYX/f0xGvJUW+5M3LaQ9ernjWToHlgJVoY
	 PkXkzWHFH+BefPr2I0Y+1b+kKbX6YXx+GmNKhoS3suXscalCu5oEeXJlFwJ7rlx3q7
	 TZEklX/0gaEFQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 06/11] selftests/bpf: Add MPTCP_SCHED_TEST macro
Date: Tue,  2 Apr 2024 13:12:29 +0800
Message-Id: <1eecc64ab7e69de0079edd0a10d09dcb12358709.1712034575.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712034575.git.tanggeliang@kylinos.cn>
References: <cover.1712034575.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch defines MPTCP_SCHED_TEST macro, a template for all scheduler
tests. Every scheduler is identified by argument name, and use sysctl
to set net.mptcp.scheduler as "bpf_name" to use this sched. Add two
veth net devices to simulate the multiple addresses case. Use 'ip mptcp
endpoint' command to add the new endpoint ADDR2 to PM netlink. Arguments
addr1/add2 means whether the data has been sent on the first/second subflow
or not. Send data and check bytes_sent of 'ss' output after it using
send_data_and_verify().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 1268479281fc..dd625ff0e234 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -508,6 +508,36 @@ static void test_default(void)
 	cleanup_netns(nstoken);
 }
 
+#define MPTCP_SCHED_TEST(name, addr1, addr2)			\
+static void test_##name(void)					\
+{								\
+	struct mptcp_bpf_##name *skel;				\
+	struct nstoken *nstoken;				\
+	struct bpf_link *link;					\
+	struct bpf_map *map;					\
+								\
+	skel = mptcp_bpf_##name##__open_and_load();		\
+	if (!ASSERT_OK_PTR(skel, "open_and_load " #name))	\
+		return;						\
+								\
+	map = bpf_object__find_map_by_name(skel->obj, #name);	\
+	link = bpf_map__attach_struct_ops(map);			\
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops " #name))	\
+		goto skel_destroy;				\
+								\
+	nstoken = sched_init("subflow", "bpf_" #name);		\
+	if (!ASSERT_OK_PTR(nstoken, "sched_init " #name))	\
+		goto link_destroy;				\
+								\
+	send_data_and_verify(#name, atoi(#addr1), atoi(#addr2));\
+								\
+	cleanup_netns(nstoken);					\
+link_destroy:							\
+	bpf_link__destroy(link);				\
+skel_destroy:							\
+	mptcp_bpf_##name##__destroy(skel);			\
+}
+
 static void test_first(void)
 {
 	struct mptcp_bpf_first *first_skel;
-- 
2.40.1

