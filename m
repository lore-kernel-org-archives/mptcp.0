Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E348511CA1
	for <mptcp@lists.linux.dev>; Mon,  9 Sep 2024 01:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725846942; cv=none; b=tFQr7rWbGEYwQhxmeU7W5OVMFZ5eSOlTV6enHC3LRmbJHYRuOYCXzIvUAPnYf6OJZq5EuTbaOr6wo18x5kR4iW5taWDUZPZ61tqASH/+/MiFLnwK/r2uTI5q9rntbJkmIda4E04e0ReGIVPO5p7T+0PjvaYp64Gxqo4wIRqfqhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725846942; c=relaxed/simple;
	bh=WKuNO3DJK8T2M0Ato5+aw4357ZWLYh9twwY0SMJGtqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kz5mwx52cJLvUffmHfME4vs/mLUiXN+5a6Bmbb3IWfz2aNGdvOlBQ/TuHIqL4L8kT/P3WbLLv7a8cCtiwUtSh+me2hgUuEk1KOZOgYYJwhbkYDNdyiLI55KskiNgB6wXCmoR6xgkI/7CbPIqSxebS0fhBbwsslVkRe4DlKFZjwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E78TrkHz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E78TrkHz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354CFC4CEC3;
	Mon,  9 Sep 2024 01:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725846941;
	bh=WKuNO3DJK8T2M0Ato5+aw4357ZWLYh9twwY0SMJGtqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E78TrkHzmspNFOH312eWCnPK0y8AiadKjYdQq/YF/NQ2GgftgpniGa7Mgj9/Ed8++
	 iXNL8xwQLQKvPSi5nQvnHRW4HSRg+CdjmcVKoXOpSuZblVQaiPULl7B8k4bfojqE9d
	 vDZGFjsnhCK0uqOGT8qW5l2h6/hw9rTZsu9hz6TEmz81w7tH/N6tkgSXGs9HguyvfT
	 AbAhKyJQD65a9EL7oFyuWtIRvjHbc6t0ifzwebVqf1hl+ePnQrEFsO67fCrzA/7Ho5
	 jv7izNjX9KlYTN9GqwxyPQbvS3DrN2LIyK6tlGM7Ah29L98wRSoW7DkQ8WUg2+rNMB
	 KSW45AgfwXGow==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/4] Squash to "selftests/bpf: Add mptcp subflow subtest"
Date: Mon,  9 Sep 2024 09:55:30 +0800
Message-ID: <9dcfd8c36c789c6207275701bb7c93b2d7d25c04.1725846806.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725846806.git.tanggeliang@kylinos.cn>
References: <cover.1725846806.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Should use dedicated ASSERT_OK_FD() to check the fds.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 93869c873cad..987692863fde 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -394,11 +394,11 @@ static void run_subflow(void)
 	socklen_t len;
 
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
-	if (!ASSERT_GE(server_fd, 0, "start_mptcp_server"))
+	if (!ASSERT_OK_FD(server_fd, "start_mptcp_server"))
 		return;
 
 	client_fd = connect_to_fd(server_fd, 0);
-	if (!ASSERT_GE(client_fd, 0, "connect to fd"))
+	if (!ASSERT_OK_FD(client_fd, "connect_to_fd"))
 		goto close_server;
 
 	send_byte(client_fd);
@@ -429,7 +429,7 @@ static void test_subflow(void)
 	struct bpf_link *link;
 
 	cgroup_fd = test__join_cgroup("/mptcp_subflow");
-	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup: mptcp_subflow"))
+	if (!ASSERT_OK_FD(cgroup_fd, "join_cgroup: mptcp_subflow"))
 		return;
 
 	skel = mptcp_subflow__open_and_load();
-- 
2.43.0

