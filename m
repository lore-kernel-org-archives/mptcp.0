Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2704739852
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712042170; cv=none; b=A/NYIlS0pBt+j8vvs8y0ZVbNFpnf/lE80UvvSCFBJT8r3wjZfNScIuAu2DvbvYmTG7N8NpfDXvdKg53M3iZbGvwtmatFiPnINN7C4YOco05Xtr+Ct8spsLFdBl4PotbPRTx/rmZfyJ2Hok91XPmzmtrTZuW22GMNsf3Fgn6b/S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712042170; c=relaxed/simple;
	bh=QafWfS2LZbeSBYlGhUn2bG26PGArW6b9e+VVgunz6RI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b3dTX10wfkA0LtWtbpfzmfdsMno/1ehINKIy72hkZgXBmMDxojCc7w7PI4FfraeE4DdVd1oitCUQNcr/F+cRug+h6MibTp9rEiTmYUmmgIeo/e1CRhnkwZlhlFlVNNbMZdzNNFnIMKkOUeDD0pH6BYkFwR0x9Z6HrNHQPpEOVWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6W9L5bS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6W9L5bS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7EAC433C7;
	Tue,  2 Apr 2024 07:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712042169;
	bh=QafWfS2LZbeSBYlGhUn2bG26PGArW6b9e+VVgunz6RI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b6W9L5bSoyphEtmxeOXiiR5RUauiyo38fdYBJG2Cmvxh9HCEP/6J3A/LsSu2m2iyk
	 yXpjAYx5YCJIAp6Ypt1/FSpAC44TSfVsb2d0WzqSPZa213qhXvcjdsxmMYhO+4SemC
	 JsvVTiZZ9p6lCM8GhlglfcowvCpo/YL7tg0pe89O12lfqkDGpmVKnkAsAX+pTeGj3X
	 wJoCIHCaWUM8YNOLNQzHPk0t7ZCvj+Lo5uD4Vlva+1uU8Jna/Sxb1OmvmJLEEDyraB
	 uDtQiR2q5AyO6a3yEj6fnduU0AZxUaeielfMc/sDMceYvdHLUzwt5WtoxISPd6sr8k
	 3NDBNgG33jOhg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 05/10] selftests/bpf: Add MPTCP_SCHED_TEST macro
Date: Tue,  2 Apr 2024 15:15:53 +0800
Message-Id: <4dfb7501458615003c1afe3feff373e48d1f8a72.1712042049.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712042049.git.tanggeliang@kylinos.cn>
References: <cover.1712042049.git.tanggeliang@kylinos.cn>
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
index 31808da47ab6..24e3b5a1134c 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -509,6 +509,36 @@ static void test_default(void)
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

