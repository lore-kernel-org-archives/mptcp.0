Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D73639AC3
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 07:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712042685; cv=none; b=AaOW2H2C12SeJdrZd+8iUnOKMcHwFkiFbfklpeYXCiBSJpA/vUw+z51cWAgQflHp27Vf7xiVsNlmfJoMs2RQ3oTps5rd+AcAit54rkyI148In7Sq/qCuw52Yhg03pXORb/KlM+PlpP9YSkp5OrhqGbeY9RYyq7rQXGLwbeQ+cug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712042685; c=relaxed/simple;
	bh=IcGme5b/Wm6kkcRHoKM4Oy+iy4MTvrj9QRdKQlg4kWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C+FbAmI3+CEVGa54FbubWuwmiJFJ+1PtM/ghfBYE3bfwk5zYWeVvyLORopqs5PBR0sNMwQuLbIykjCFXAE8KvGgsa/D6vY4dK1jSJbE/LdrgvI2/9LQj3gvajAAkGiT8lZGNfFN9lBtFP6BW/dgEDxGLc+afRuOwoL+XY78Al3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBtZMOEd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBtZMOEd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEC6C433F1;
	Tue,  2 Apr 2024 07:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712042685;
	bh=IcGme5b/Wm6kkcRHoKM4Oy+iy4MTvrj9QRdKQlg4kWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sBtZMOEdmQGDcinMjeD7aJA/Di8VDf+24WvF1TWfhkQ2c/gaz3PIqqueOSGEK2ZZ1
	 90K3JljFTC/h8HFT7aQ7HQAPdcGieH1ZJvKTlvz4hT0Bop2pepNAaqTQksKxiUwc+9
	 SDuNxL1lPs1rsTsQ7rBVedXtIGnxf6YFG1PQl75IK1LIIp2DN6ECvdysS7qChEUaTa
	 GnbDA7+85clBi32m0GUQzVzkcIgUOabtBbJsLOuCiqcSGsP9Q1WtPWF8wLw9LwJESq
	 2Ln9Tcte0GdZYUo1GWYzvaGsZsM3UBkNW//oF5H99YLbYR/Nm626NFDd8PIHojp33G
	 uDUBC9tSDJQ4A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 8/8] Squash to "selftests/bpf: Add bpf scheduler test" 5 endpoint_init
Date: Tue,  2 Apr 2024 15:24:28 +0800
Message-Id: <8e2c3503798e2781ed7224408ef72a675c4e5068.1712042529.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712042529.git.tanggeliang@kylinos.cn>
References: <cover.1712042529.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use endpoint_init and _ss_search.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 8309ee97ac8c..4ed5e59cc64a 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -395,28 +395,22 @@ static struct nstoken *sched_init(char *flags, char *sched)
 
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
 
 static void send_data_and_verify(char *msg, int addr1, int addr2)
-- 
2.40.1

