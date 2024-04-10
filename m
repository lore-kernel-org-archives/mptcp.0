Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEA4A5F
	for <mptcp@lists.linux.dev>; Wed, 10 Apr 2024 02:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712714741; cv=none; b=Y5moivqQRnOZ02XEDjnYYP2zMSJjPqiyXwK3k42C6Fvo5LF/F8G610SocNJGEUnVT0cqp7Ud+U8LZLA2Ze4pOpw47jzdc1ZlJeB881ck/zDy6KZpQNNPE92gGBnMGNJ6qxniXQpcHq+VCEK8MLJLoQN0r1+s7N0HEqOOz1mpHM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712714741; c=relaxed/simple;
	bh=CljGcGmyOWVga8WPbxOA+yv/kSTijkdZF/RdammhdVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LBhoA6KCPyjCHE4L3901Q4/ws22yaNyf2Dn9FSswL6jLvhQpURMzvIYRoykWeC0bF0XtKvJNyW9E9r8R7Bs0l6xUCOQAXfFKeKalRSJ4afi+fIvOoc3cC/6OhrnBe3fEqw0oavVshHMQXm1rXc19U8o+p6xcz6e1BQ5+VDpBmPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcahqXtn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcahqXtn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45090C433F1;
	Wed, 10 Apr 2024 02:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712714741;
	bh=CljGcGmyOWVga8WPbxOA+yv/kSTijkdZF/RdammhdVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YcahqXtnqwbrDgB9yvtqiyruj8sK/e/hMri0zSofrAI9No37JCam9G6F/CJF8Nbz2
	 BtfOOjX/WByzaf1xKVji7Aw8JQM4v5ZzDbAsIpmMw0kmJiK54NTARoPd0N4KkzwMSV
	 Ocl0Up/yMKfWeKWJW4ZzJgrJ3UDq0J3RIjdQNjVsZIgVHWyCgb7OWVAtViVIk1MS2p
	 PMzW8By0wi4cZhaBvrcJXKOWW3SWbZ4veLHl7mpe1K7PsRXUrBf9cwmMhGu97ccMzS
	 BPYAXjQATDmc3Iiu0tobhDk/ZuTSwqBE1+UnDjrSbjdGx40X2wC6bTaFpbjE3J71it
	 xJCO+uTwlK1ZQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 4/9] Squash to "selftests/bpf: Add bpf scheduler test" 3 MPTCP_SCHED_TEST
Date: Wed, 10 Apr 2024 10:05:19 +0800
Message-Id: <ad3d2ce4863dc542d754471d8e566c084a0bc52c.1712714407.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712714407.git.tanggeliang@kylinos.cn>
References: <cover.1712714407.git.tanggeliang@kylinos.cn>
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
index e8df18c28961..0144db1425ed 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -500,6 +500,36 @@ static void test_default(void)
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
+	send_data_and_verify(#sched, addr1, addr2);		\
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

