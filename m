Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017198BF9
	for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 01:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713404207; cv=none; b=rMiHwgWf9iZ2RhSouovE8m1FebXyp5v85wBtEL3ZqoKxVF3n56ZcsjwWw3ZUmxMpdwJ0E3v+DFTEUVTA3YBR58JwXyovV6UbmiXvCJxI/I8xezGP4aUyYeS2MdHePKz0oBKvRnTzC9HibpHr5VPpOpG6MSmV5PSwp3PI63ZCvaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713404207; c=relaxed/simple;
	bh=pPr4PjkT4wy9KHMeDGZQ01kRGwpXReTvEWQ6dFQPDXY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gnJJBAvz9AZ7gotbfCuJ1p3ZN+OaY0rPhH2u0sumqqTCn/sxwjCBZ84mV8BQtIK8SYfpMOqoWHL5EOMSlaGMhWiLwyVSKvxEcUbD4imtl64cWGiIBXEoNBZzrje/FkRj2CelVzs/3q3O2tqnBvHqU+Ya0q63iUbzoZ5A0PAbkLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlYIodkF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlYIodkF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E276C072AA;
	Thu, 18 Apr 2024 01:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713404206;
	bh=pPr4PjkT4wy9KHMeDGZQ01kRGwpXReTvEWQ6dFQPDXY=;
	h=From:To:Cc:Subject:Date:From;
	b=mlYIodkFP+ANwZe1nByHNUkurjmagBeWfOr3YbEloqNzubO7z/sJS7HscjUdx2tZ3
	 XFULYiVkS0PZHHjVce5G4HzPLtPYXh2fFwQAnnfv8KPGCZ66rZB7okSHt0XhsC8OMi
	 gH+qN1ZVyKUd3uBxJG9kV93ZRZRRT7Kpm0Sp6T/6Do1jR4C2a1FY4Yo7X32oSKw0y0
	 4NQWKlo/e+GpYB/Eo+B/9u+urK6ioL1gwKLoJvvEAjzZFfPahw80wVRUFwbOtNw4Xo
	 a0wwa2wYRsov6GatZf9o87om+taowjhYgxK9IBmKuIzggi21K31yNM4uxs0q+PEcc5
	 MvMuiQeFZG3nw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] Squash to "selftests/bpf: Add bpf_first scheduler & test" 2
Date: Thu, 18 Apr 2024 09:36:36 +0800
Message-Id: <cc01abb2882608ac5f719e0f7960aa2a2d9fca41.1713404174.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Check the string length of sched as Mat suggested.

Please insert this patch into "refactor mptcp bpf tests" v9 as the
last commit.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 9f17453b2d59..56dca35f289d 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -509,6 +509,10 @@ static void test_bpf_sched(struct bpf_object *obj, char *sched,
 	struct bpf_link *link;
 	struct bpf_map *map;
 
+	if (!ASSERT_LT(strlen(bpf_sched) + strlen(sched),
+		       MPTCP_SCHED_NAME_MAX, "too long string"))
+		return;
+
 	map = bpf_object__find_map_by_name(obj, sched);
 	link = bpf_map__attach_struct_ops(map);
 	if (CHECK(!link, sched, "attach_struct_ops: %d\n", errno))
-- 
2.40.1

