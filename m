Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7388C839F8
	for <mptcp@lists.linux.dev>; Thu,  4 Apr 2024 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712235843; cv=none; b=Kl10VVZqkTg08WHJvoueujGTh96Zj0fDJr2hGtsB81R+q7k11rqfKCFZeFBUfjAOfb6v8YY2Dunw3TOtkLlnERdGpH97wCiZU97Q/l+xWX+megL7sG1Fy3+XJOsTZtALowjQQybNI4zVPfzL0IpN4InoXeeaZlGDQB3uakCjjzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712235843; c=relaxed/simple;
	bh=dDeoNmT3NeHZ+6HP46u50EuQUWr23pnneM363Z0h6EU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iAXxTZlTl8UddfRb0+znFWC6kwDLbo10IZReuHRtVaGXCdlEC/dw/FKyBn1O+nxNmMErc4sQTALHNfQPCSWP9Y0HUBKiJZM+nIFGlT4+cNmFhIaJFu0QRRTVGz4NnHPIp3kaS2Z5z8Dsuvd1hy0vzLQxX3LwSl9YEjOyhq+HaOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r47wbyDy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r47wbyDy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013A3C433C7;
	Thu,  4 Apr 2024 13:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712235843;
	bh=dDeoNmT3NeHZ+6HP46u50EuQUWr23pnneM363Z0h6EU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r47wbyDyvpNlTCxiS7ukHBs8lyqrkj/H9Cd4j3DOHwvFDXmskwJBaKinYWHxk3yd9
	 hqbxMPunn860QCmb1vgVNGpDhjcUotwEq1QAlt2pMm+MXrU9nCesozy0iS5vEIfrsZ
	 xN+6WxdUe4kQVON2SFg1ngYHZruVPyzOH45WuiZFmuVYchrjp/mo0I0SNxEvJovGV5
	 bkw7RFAo7HfJONWZRbJroHhjZDXOkm9dcUyZXUxwCKpcW6h5lZPamqRm3tXxgQA/Jh
	 YhLS9EqA7QgTnoQ6VH1meCz/f8lAZPqj6lp3HvBgp39daHOobnIqCzLYYpt2pzADcN
	 CKYvDdIhAupIw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 4/9] selftests/bpf: Add MPTCP_SCHED_TEST macro
Date: Thu,  4 Apr 2024 21:03:06 +0800
Message-Id: <ae75e2c884eb6a1742af12aaeae9015bb0b4d90c.1712235380.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712235379.git.tanggeliang@kylinos.cn>
References: <cover.1712235379.git.tanggeliang@kylinos.cn>
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
index ffcd5ebe38b9..8a6b09a97698 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -498,6 +498,36 @@ static void test_default(void)
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

