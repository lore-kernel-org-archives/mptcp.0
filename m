Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3721FC1C
	for <mptcp@lists.linux.dev>; Sat, 20 Apr 2024 11:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713612261; cv=none; b=tK3fV+hmlbTDANB9MDbc54C469yYbiMY2vI01DZuBZ6BEKglzaeEgjlUDy7dHBvs2wyfHiooC9EVnj5mfhn8ATp+AVGjm/fqIt5PNMrXdgjN7wlsaarcfhSd3yGVS7uJ6qjsOHeBeY8b+ti2gBQhAk3eJmZFEzbWrnVkM6Kfgh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713612261; c=relaxed/simple;
	bh=QvrpkTAiB7kGDAbS0EJvrZaamoUYJT7gHdi8wJSBwLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g2sN5LYkLzXI7uvqcvu4KiEWJ9rrpdI2RhTjtmEyL3PktVsRTZvqVeDxxlJbXpV01Ebi9aMjDHJQeOKwKieAIHfG1+e5Xo2mQ7aNcowMjEnyIR4RQUzCC4hJ/mKWYs+xf8MnUtP7my18LOX8Wkwj092OxyqVwk9S/AHQNBozV+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HylC7W/J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HylC7W/J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CABEC116B1;
	Sat, 20 Apr 2024 11:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713612261;
	bh=QvrpkTAiB7kGDAbS0EJvrZaamoUYJT7gHdi8wJSBwLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HylC7W/JK7MfTVQ6TlfaP66+j75tdBBll8IeeEXiYNLfz6L4zAEDQd4yZWeaiUCgH
	 ys8szZPVtp0+jljjoBOuGfss/ZEH3Pv3fuVBl6Hh6wABtVrjJeNrvCCS/E+2fUD5ig
	 nppmDol6lD3TDDV5Z58iJh2ru7C0UUcoBGhws01AIFUbTdhl8sbR8DcSJE2VQWKa2I
	 Go+LETUfrruunt24yvdZWIynjbxEhA9/Wwhjyw2msrfPSGdeK9/hzDjP2C3M9oR678
	 5dOg/9L9rhQ2Tvo+qbv+XLlaHpiGroh0VrBmHJmtk/Ye37NGnsshr7x7HmF9A1Xrnu
	 LdNm5p3qOdVoQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 4/4] Squash to "selftests/bpf: Add bpf scheduler test"
Date: Sat, 20 Apr 2024 19:23:29 +0800
Message-Id: <7f88de31a64fb954a1a2aa164c51a1cd059a5444.1713612119.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713612119.git.tanggeliang@kylinos.cn>
References: <cover.1713612119.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use endpoint_init in sched_init and use _ss_search in has_bytes_sent.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 307d4b360350..10206f1d1157 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -532,28 +532,22 @@ static struct nstoken *sched_init(char *flags, char *sched)
 
 	nstoken = create_netns();
 	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
+		return NULL;
+
+	if (!ASSERT_OK(endpoint_init("subflow"), "endpoint_init"))
 		goto fail;
 
-	SYS(fail, "ip -net %s link add veth1 type veth peer name veth2", NS_TEST);
-	SYS(fail, "ip -net %s addr add %s/24 dev veth1", NS_TEST, ADDR_1);
-	SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
-	SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
-	SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
-	SYS(fail, "ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags);
 	SYS(fail, "ip netns exec %s sysctl -qw net.mptcp.scheduler=%s", NS_TEST, sched);
 
 	return nstoken;
 fail:
+	cleanup_netns(nstoken);
 	return NULL;
 }
 
-static int has_bytes_sent(char *addr)
+static int has_bytes_sent(char *dst)
 {
-	char cmd[128];
-
-	snprintf(cmd, sizeof(cmd), "ip netns exec %s ss -it src %s sport %d dst %s | %s",
-		 NS_TEST, ADDR_1, PORT_1, addr, "grep -q bytes_sent:");
-	return system(cmd);
+	return _ss_search(ADDR_1, dst, "sport", "bytes_sent:");
 }
 
 static void send_data_and_verify(char *sched, bool addr1, bool addr2)
-- 
2.40.1

