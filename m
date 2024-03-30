Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BAE1C0DDF
	for <mptcp@lists.linux.dev>; Sat, 30 Mar 2024 08:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711788658; cv=none; b=I8sYPvTOtOJuA6+0zNkumxCsLb0b4tYRv5dLSyXqE5rjzGaHq/jz0Y5gv83JCXpoT97y80/+ToX/K2zIH7t5YVWnnTyVNSxYYn8v4Wvwz6KlDZUdodU2XH61+PAkayRq5LbQHlincOgvgUGI/ADS1esnsw7EOXucfsYhCrj5VUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711788658; c=relaxed/simple;
	bh=WPUIExjPnp53I2O1BKsv8P7GdLxYNIU3lQWWQ2a6akU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gKYAooEGzseLHbHJzHjoX3e+U7XQSVX2CQzNOD8xttDZv5na2C2sq1QP17QNyI4XA3GPnlh/1SkEDnR9noP/08QSCOArfJD8qewxqZ13pQluzt1v/V5Zj3OUYEHtN1KSii9dOx95xfeyMkKGMCm0/othr4FHDx3090/NwFuY8mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5MizKgU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5MizKgU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58154C433F1;
	Sat, 30 Mar 2024 08:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711788658;
	bh=WPUIExjPnp53I2O1BKsv8P7GdLxYNIU3lQWWQ2a6akU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s5MizKgUZiX7t4Nj8Zi8H76gmz47xAjJB4KOdL3nFOyE9rlZtzzOJNDp6Fk5h2rna
	 +XjxiFxPfgtHT8+r1WWcACu+EnLopme184my3yHsBlyxu5RQcFDfEUmVhPLnOsycxQ
	 0frrPmHL/u1zzBkJUAllAEcLAyll9n0s9jvUCHJrSnAcVPcV6ib5T721myFB/V3otl
	 qWQVesbyYNqG+hxBzKMKSxxPrzFaBei9vJiYRunsBcZjBsagDkGCv/A26xiBL33/Fb
	 WQfKefpGTJZUwBXLi7bWrxpexsP/3g5Bzj2L5AlQwaNnrfZKd7KBlq7mESe/43HEGN
	 VKEnROhGP8EYg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 3/8] selftests/bpf: Add MPTCP_SCHED_TEST macro
Date: Sat, 30 Mar 2024 16:50:45 +0800
Message-Id: <b773c4f1792ac4546acfda85d8b279bb1dd4b784.1711788593.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711788593.git.tanggeliang@kylinos.cn>
References: <cover.1711788593.git.tanggeliang@kylinos.cn>
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
index 856e06ad3246..d6653ce1fc36 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -496,6 +496,36 @@ static void test_default(void)
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
+	if (!ASSERT_OK_PTR(skel, "open_and_load:" #name))	\
+		return;						\
+								\
+	map = bpf_object__find_map_by_name(skel->obj, #name);	\
+	link = bpf_map__attach_struct_ops(map);			\
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops:" #name))	\
+		goto fail;					\
+								\
+	nstoken = sched_init("subflow", "bpf_" #name);		\
+	if (!ASSERT_OK_PTR(nstoken, "sched_init:" #name))	\
+		goto out;					\
+								\
+	send_data_and_verify(#name, atoi(#addr1), atoi(#addr2));\
+								\
+	cleanup_netns(nstoken);					\
+out:								\
+	bpf_link__destroy(link);				\
+fail:								\
+	mptcp_bpf_##name##__destroy(skel);			\
+}
+
 static void test_first(void)
 {
 	struct mptcp_bpf_first *first_skel;
-- 
2.40.1

