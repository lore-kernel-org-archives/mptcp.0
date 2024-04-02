Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33E218028
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 05:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712034766; cv=none; b=YgG5QzXsLTyqWkcs2ON8sX0+aZ5jRE7OqgZappt2sPj/ICaEEcodyZxw93StnqALBjjGDekFyfHCy133m4stn7yCKuxHcTganahfxcHjMLnQLVfGalMF5IPcWiCeCW5bJ0u7zqfCGAmdSNXJL+ptHd53aaJMs94DFZb/6hu/SX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712034766; c=relaxed/simple;
	bh=2AX+Is4y3Wk3xT/v83nqHaYe/s/mHl2JO8mleHGsQ7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hVvXPP9j1WrEE2+F6UbDOCvTJ+JTckF8Aofcz/OpywYRz67rc/ymLALZASWAyTxxvOJAls84QMDNIpP9UI+koqBetgfIAOUigMhXca54rwpE3pvCEihRtm/N2QK2jPCEHXTcuWEsLQf303o9/eyYMlbaqZiBnDA+PPJQMc6i7SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dd+HIL5v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dd+HIL5v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B2CC433C7;
	Tue,  2 Apr 2024 05:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712034766;
	bh=2AX+Is4y3Wk3xT/v83nqHaYe/s/mHl2JO8mleHGsQ7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dd+HIL5vHiZS5q6gZqjWcNoub5sNMiTEBbPEkZjh+QHUsvfRiaBJMhObifdeANM2t
	 G4Kxz2QnBXhSv6bPlRrg78Rj/Tn6jkNNKjtZkcFyaL1NFcy5eu9uLqOWW8ru4MF201
	 U4dp526+Za7lXJcpvu5tLNwGzkONoeAFejKvn6kDvkUgF43zZo0KMn/9xmDSfi2+RB
	 6wkweCarUCn2rrNAavljlpUqaxepILZgtXXQURLD9POFxtzqP+Tyfe4JFB1AM3zlvx
	 6s53qFMhSd+1Es32PX++VVypZUWcI+ksBoMt9tQXcwTyFh0RQt0KNpET3zaFtls4Ue
	 RY7ThsLCqed9A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 01/11] Squash to "selftests/bpf: Add bpf scheduler test" 1 nonblock
Date: Tue,  2 Apr 2024 13:12:24 +0800
Message-Id: <f0b66813ae8274e5653988d80d16171508f05796.1712034575.git.tanggeliang@kylinos.cn>
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

BPF tests fail sometimes with "bytes != total_bytes" errors:

 # test_default:PASS:sched_init:default 0 nsec
 # send_data:PASS:pthread_create 0 nsec
 # send_data:FAIL:recv 936000 != 10485760 nr_recv:-1 errno:11
 # default: 3041 ms
 # server:FAIL:send 7579500 != 10485760 nr_sent:-1 errno:11
 # send_data:FAIL:pthread_join thread_ret:-11 \
		test_default:PASS:has_bytes_sent addr_1 0 nsec
 # test_default:PASS:has_bytes_sent addr_2 0 nsec
 # close_netns:PASS:setns 0 nsec

Here errno 11 is EAGAIN. This patch sets server socket to nonblock
to fix this. It makes BPF tests stable.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 6e28215d7404..d3d51aee440d 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -88,6 +88,16 @@ static void cleanup_netns(struct nstoken *nstoken)
 	SYS_NOFAIL("ip netns del %s", NS_TEST);
 }
 
+static int set_nonblock(int fd)
+{
+	int flags = fcntl(fd, F_GETFL);
+
+	if (flags == -1)
+		return -1;
+
+	return fcntl(fd, flags | O_NONBLOCK);
+}
+
 static int verify_tsk(int map_fd, int client_fd)
 {
 	int err, cfd = client_fd;
@@ -466,6 +476,7 @@ static void test_default(void)
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
+	set_nonblock(server_fd);
 	send_data(server_fd, client_fd, "default");
 	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
 	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr_2");
@@ -639,6 +650,7 @@ static void test_burst(void)
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
+	set_nonblock(server_fd);
 	send_data(server_fd, client_fd, "bpf_burst");
 	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
 	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
-- 
2.40.1

