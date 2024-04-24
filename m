Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EA879CD
	for <mptcp@lists.linux.dev>; Wed, 24 Apr 2024 01:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713921250; cv=none; b=K40qiT2HpwdyG78yWbsrB7ymXWGr4CjajtgjZNC82iTv1pz7USsQDo2W+RYKIwZKQ6herAsmRS2chhvNRMfhNiPMd0tWC0pbNMb6JLgUQE0UVFWqnn1QE0dDnxnSy0oiZoQEFombHdInKiH0LHY+4JFc68v/cnLIBbO9RIfhJ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713921250; c=relaxed/simple;
	bh=t7QELByV4/Sgz3JpQX5FCeugXehCOTqo4curzopiHDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fUV2fWr9KJyaqPbTvXGBPG8EcKKuulAZ2RTmUyeGbe6g6xlcdPyJKo8bKJa2m2R29SXNObvB+1BTfw2RE/VPtPPqW/Z+uMXK2NEWPD1Djnrm2agGUibh7V31z/UgcBRClbeN8GtxR5WZzaU93B/071SJL342FeJZJy/olHySHng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8Zrk3t7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8Zrk3t7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6506C32781;
	Wed, 24 Apr 2024 01:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713921249;
	bh=t7QELByV4/Sgz3JpQX5FCeugXehCOTqo4curzopiHDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T8Zrk3t7yr+wcC2XnNk9GBNUyY74e5ENKq15xs4zx8JGuoupLFPCZWrDTuLJV/Dmj
	 aYZBjFNVjZ7/FNjVJ/I9EZs4vhWUkmPWOmGIGktzY4g1Fs4tC9nP0vVXYJAjsvdNrJ
	 2S3f51RoKPzUZBRJDv80QlLD3i7+1Y3+bqWXyx+To4UoeMA2513p+SPc1iq2Qw/oAx
	 ZzuUZK/SqODkIQvQPEBHwCRj2J4CDIRy1iFWMGeVaZk5vjoJI7Dk5ltbAf/0oBgOuv
	 H+oSpvw6kduhTVyrIFcvOXuNuyEtneUYcypPE1rtyvKXl5GwtBdQGhxC3dGDEK+4Aj
	 Vab4w0HDpIYvQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 4/4] Squash to "selftests/bpf: Add bpf scheduler test"
Date: Wed, 24 Apr 2024 09:13:54 +0800
Message-Id: <c459b29f617283a420f1142f26605e5d3aca5e44.1713920939.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713920939.git.tanggeliang@kylinos.cn>
References: <cover.1713920939.git.tanggeliang@kylinos.cn>
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
index 7409f7c8b1f6..f84c74b87d23 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -536,28 +536,22 @@ static struct nstoken *sched_init(char *flags, char *sched)
 
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

