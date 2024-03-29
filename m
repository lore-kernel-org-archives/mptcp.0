Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0906037149
	for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 04:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711688222; cv=none; b=pKEbN1JO1mcSP7v5t3Rdrum2srupmGnPuIq/f4dOwMjYWhNfXypvY1MKAWEGVnjewvA4Mv7tI4wHQtqhVn7obLuVO5Q0uq/vexkDLVai98OyAJJU5lUcPOCu9QhHVRs7+uNpIQSzSzefhiSDy0MqBQ7IFlwl//r2x9Ld05zjiKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711688222; c=relaxed/simple;
	bh=FNXRdZrV3HR+uQ8GnDjTUzVB9KW5XpUVk97vjdQ7Ocg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iiWjEmMPdUoEYsFqyy6u1oFFlCp2g1Z3Ln8aQg5dpY+DqkGFliXGvN/HojsJhjEy2hNC6KQnp5rzirtsp47yewmtlWI3UpLGwqAXlJIdnljjENJFuMnujr5ZW3siQtxXcIi9ZBmuxjMuE3oQEfk1G8LkGcMvRtzohT/fCPrpMHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0cCSgQ2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0cCSgQ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766D7C433F1;
	Fri, 29 Mar 2024 04:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711688221;
	bh=FNXRdZrV3HR+uQ8GnDjTUzVB9KW5XpUVk97vjdQ7Ocg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d0cCSgQ2vZ2RtTAZd/zgCHU883AcrOflRIOku8XruYoP4fMxOUz/QFifXBVVnwyzc
	 MQnapGpw/cIQ+x+EJoYnwQP1S8K2ttwwGae4kVdXoVYKnHIq307Xt8yXYyIeTNXJrt
	 FW4SrFuLJXQo/euDVlh+W7Z4QooJomOXbYKJQaUtNdjJhoKUAL/Pn3G2nh/zkyaqEX
	 U+gNId8IrkZ545rafXuw7+NgCOP3vpjPO5TjDvbkg4eK0kBbWKRZiLIkCjEpOKEvUM
	 iB0xGlxiXXD0cbB0DpBbAatbZkIniU6IAYbcbMLiJxLKmbUAW6OYj4qUX0avfFOhGG
	 tcpWs+QPkvaTw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 03/15] selftests/bpf: Export send_single_byte helper
Date: Fri, 29 Mar 2024 12:55:59 +0800
Message-Id: <f9213ab62ba019f3f6829f93cf8086044d5d332e.1711688054.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711688054.git.tanggeliang@kylinos.cn>
References: <cover.1711688054.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The helper send_byte is defined in both tcp_rtt.c and mptcp.c. It makes
sense to export it into network_helpers.h to let it can be used for all
BPF selftests.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c    | 7 +++++++
 tools/testing/selftests/bpf/network_helpers.h    | 1 +
 tools/testing/selftests/bpf/prog_tests/mptcp.c   | 9 +--------
 tools/testing/selftests/bpf/prog_tests/tcp_rtt.c | 9 +--------
 4 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 6db27a9088e9..8dea4160bfee 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -497,3 +497,10 @@ int get_socket_local_port(int sock_fd)
 
 	return -1;
 }
+
+void send_single_byte(int fd)
+{
+	char b = 0x55;
+
+	ASSERT_EQ(write(fd, &b, sizeof(b)), 1, "send single byte");
+}
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 94b9be24e39b..b3c2238772c8 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -71,6 +71,7 @@ struct nstoken;
  */
 struct nstoken *open_netns(const char *name);
 void close_netns(struct nstoken *token);
+void send_single_byte(int fd);
 
 static __u16 csum_fold(__u32 csum)
 {
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 7fec91ab19cf..42edf9f80d68 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -231,13 +231,6 @@ static void test_base(void)
 	close(cgroup_fd);
 }
 
-static void send_byte(int fd)
-{
-	char b = 0x55;
-
-	ASSERT_EQ(write(fd, &b, sizeof(b)), 1, "send single byte");
-}
-
 static int verify_mptcpify(int server_fd, int client_fd)
 {
 	struct __mptcp_info info;
@@ -296,7 +289,7 @@ static int run_mptcpify(int cgroup_fd)
 		goto close_server;
 	}
 
-	send_byte(client_fd);
+	send_single_byte(client_fd);
 
 	err = verify_mptcpify(server_fd, client_fd);
 
diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c b/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
index 8fe84da1b9b4..5e23cf1e951c 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
@@ -12,13 +12,6 @@ struct tcp_rtt_storage {
 	__u32 icsk_retransmits;
 };
 
-static void send_byte(int fd)
-{
-	char b = 0x55;
-
-	ASSERT_EQ(write(fd, &b, sizeof(b)), 1, "send single byte");
-}
-
 static int wait_for_ack(int fd, int retries)
 {
 	struct tcp_info info;
@@ -121,7 +114,7 @@ static int run_test(int cgroup_fd, int server_fd)
 			 /*delivered_ce=*/0,
 			 /*icsk_retransmits=*/0);
 
-	send_byte(client_fd);
+	send_single_byte(client_fd);
 	if (wait_for_ack(client_fd, 100) < 0) {
 		err = -1;
 		goto close_client_fd;
-- 
2.40.1

