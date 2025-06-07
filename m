Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1972D1F1315
	for <mptcp@lists.linux.dev>; Sat,  7 Jun 2025 08:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749286514; cv=none; b=Pl6ri7J1bQEGT3hzx5fWaTo2R2hDX/qmc1D3HUg+h4bi0nTzBYZjDrmgRMKvmbdxCCVWV636jHLYOyWFXT+eQWuCUftyThBE3bsymndR3NkgrOuXmbLDvPf8z94B8Cvbwow4/fY54zSg3zGmLRV7cY+ehhJIHMkqRXVs7NCoZDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749286514; c=relaxed/simple;
	bh=6jTBX2P/L7dqAlV3vekCvy5AMbcwZq5wYQfVnNhLLBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cv0Im2RQYn2y5Dt28Ykr2s8aO/4/AxHoqBgldXexRKdOu2HtccNyYm0IlpySHR/0/2MC6HbS/wmdLqQ8sXzF7Ywb8DHyvzrQsuAf1GCqBcDukB+pZWrIqM4lbfuQa8GCKVsNHACTDtu8V1z83D1YgLQJ46ZgHHhMJSAwIB7ie3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utU7LmeY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utU7LmeY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D54C4CEED;
	Sat,  7 Jun 2025 08:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749286513;
	bh=6jTBX2P/L7dqAlV3vekCvy5AMbcwZq5wYQfVnNhLLBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=utU7LmeYzFavsbqtjFsRvcABJWdfRoBFuaA06QHkuHnyiRjyNwP7+rts+hBAU3/Jk
	 atEJ/bBv/nGvl1FWhl8wwDqalHUjR3bmD08ZZw85gQzwyAzA0bXyezA1xw2zyqGjwv
	 A1KibvHSSLWC932shbsroECh8WiurmfbBJr4RjKLFKiFwyN8gFS/yCSmkVuN/9RV/T
	 R3RE7Mw6XS1mwkEwPajFg7Uju6fwdD8dgADPTh3mdFWTgVSM1qG19FhQy/UiD0Z7E+
	 c3myaFfa4dM9Smg4rnEaLtc6WuIG0sbmcIwAkFAKUgG2bL0hU5Z42PDFpDhDdb6WkV
	 ZCQv/chm3L9KQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 4/4] selftests: mptcp: add splice test
Date: Sat,  7 Jun 2025 08:54:19 +0000
Message-ID: <bacae02a735867815606871386a1f718656ddcba.1749286212.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1749286212.git.tanggeliang@kylinos.cn>
References: <cover.1749286212.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a mptcp socket splice test named mptcp_splice. And a new
test in mptcp_join.sh.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/Makefile    |   2 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  20 ++
 .../selftests/net/mptcp/mptcp_splice.c        | 201 ++++++++++++++++++
 3 files changed, 222 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/net/mptcp/mptcp_splice.c

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index e47788bfa671..b8c3ffe649f8 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -7,7 +7,7 @@ CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INC
 TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
 	      simult_flows.sh mptcp_sockopt.sh userspace_pm.sh
 
-TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq mptcp_diag
+TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq mptcp_diag mptcp_splice
 
 TEST_FILES := mptcp_lib.sh settings
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b8af65373b3a..fccbe50d3486 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3946,6 +3946,25 @@ endpoint_tests()
 	fi
 }
 
+splice_tests()
+{
+	if reset "splice test"; then
+		mptcp_lib_pm_nl_set_limits $ns1 8 8
+		mptcp_lib_pm_nl_set_limits $ns2 8 8
+		mptcp_lib_pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
+		mptcp_lib_pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
+		mptcp_lib_pm_nl_add_endpoint $ns2 10.0.4.2 dev ns2eth4 flags subflow
+
+		ip netns exec $ns1 ./mptcp_splice -l -o "$sout" -p 8080 &
+		local tests_pid=$!
+		sleep 1
+		ip netns exec $ns2 ./mptcp_splice -i "$cin" -a 10.0.1.1 -p 8080
+		mptcp_lib_kill_wait $tests_pid
+		check_transfer "$cin" "$sout" "file received by server" 1052
+		chk_join_nr 3 3 3
+	fi
+}
+
 # [$1: error message]
 usage()
 {
@@ -3994,6 +4013,7 @@ all_tests_sorted=(
 	F@fail_tests
 	u@userspace_tests
 	I@endpoint_tests
+	L@splice_tests
 )
 
 all_tests_args=""
diff --git a/tools/testing/selftests/net/mptcp/mptcp_splice.c b/tools/testing/selftests/net/mptcp/mptcp_splice.c
new file mode 100644
index 000000000000..a04ab7e1448d
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_splice.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025, Kylin Software */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+#include <string.h>
+#include <errno.h>
+
+#ifndef IPPROTO_MPTCP
+#define IPPROTO_MPTCP 262
+#endif
+
+#define BUFFER_SIZE 65536
+
+char *server_ip;
+int port;
+
+static int server(char *output)
+{
+	int server_fd, client_fd, out_fd;
+	struct sockaddr_in address;
+	int addrlen = sizeof(address);
+	int pipefd[2];
+	ssize_t bytes;
+	int opt = 1;
+
+	server_fd = socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP);
+	if (server_fd < 0) {
+		perror("socket failed");
+		exit(EXIT_FAILURE);
+	}
+
+	if (setsockopt(server_fd, SOL_SOCKET, SO_REUSEADDR | SO_REUSEPORT,
+		       &opt, sizeof(opt))) {
+		perror("setsockopt");
+		exit(EXIT_FAILURE);
+	}
+
+	address.sin_family = AF_INET;
+	address.sin_addr.s_addr = INADDR_ANY;
+	address.sin_port = htons(port);
+
+	if (bind(server_fd, (struct sockaddr *)&address, sizeof(address)) < 0) {
+		perror("bind failed");
+		exit(EXIT_FAILURE);
+	}
+
+	if (listen(server_fd, 3) < 0) {
+		perror("listen");
+		exit(EXIT_FAILURE);
+	}
+
+	printf("Server listening on port %d...\n", port);
+
+	client_fd = accept(server_fd, (struct sockaddr *)&address,
+			   (socklen_t *)&addrlen);
+	if (client_fd < 0) {
+		perror("accept");
+		exit(EXIT_FAILURE);
+	}
+
+	printf("Client connected. Receiving file...\n");
+
+	if (pipe(pipefd)) {
+		perror("pipe");
+		exit(EXIT_FAILURE);
+	}
+
+	out_fd = open(output, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+	if (out_fd < 0) {
+		perror("open");
+		exit(EXIT_FAILURE);
+	}
+
+	while ((bytes = splice(client_fd, NULL, pipefd[1], NULL, BUFFER_SIZE,
+			       SPLICE_F_MOVE | SPLICE_F_MORE)) > 0) {
+		splice(pipefd[0], NULL, out_fd, NULL, bytes, SPLICE_F_MOVE | SPLICE_F_MORE);
+	}
+
+	if (bytes == -1)
+		perror("splice");
+
+	printf("File transfer completed. Received %ld bytes.\n",
+	       lseek(out_fd, 0, SEEK_CUR));
+
+	close(client_fd);
+	close(out_fd);
+	close(server_fd);
+
+	return 0;
+}
+
+static int client(char *input)
+{
+	struct sockaddr_in serv_addr;
+	int sock_fd, in_fd;
+	int pipefd[2];
+	ssize_t bytes;
+
+	sock_fd = socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP);
+	if (sock_fd < 0) {
+		perror("Socket creation error");
+		exit(EXIT_FAILURE);
+	}
+
+	serv_addr.sin_family = AF_INET;
+	serv_addr.sin_port = htons(port);
+
+	if (inet_pton(AF_INET, server_ip, &serv_addr.sin_addr) <= 0) {
+		perror("Invalid address/ Address not supported");
+		exit(EXIT_FAILURE);
+	}
+
+	if (connect(sock_fd, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) < 0) {
+		perror("Connection Failed");
+		exit(EXIT_FAILURE);
+	}
+
+	printf("Connected to server. Sending file...\n");
+
+	if (pipe(pipefd)) {
+		perror("pipe");
+		exit(EXIT_FAILURE);
+	}
+
+	in_fd = open(input, O_RDONLY);
+	if (in_fd == -1) {
+		perror("open");
+		exit(EXIT_FAILURE);
+	}
+
+	while ((bytes = splice(in_fd, NULL, pipefd[1], NULL, BUFFER_SIZE,
+			       SPLICE_F_MOVE | SPLICE_F_MORE)) > 0) {
+		splice(pipefd[0], NULL, sock_fd, NULL, bytes, SPLICE_F_MOVE | SPLICE_F_MORE);
+	}
+
+	if (bytes == -1)
+		perror("splice");
+
+	printf("File transfer completed. Sent %ld bytes.\n",
+	       lseek(in_fd, 0, SEEK_CUR));
+
+	shutdown(sock_fd, SHUT_WR);
+	close(in_fd);
+	close(sock_fd);
+
+	return 0;
+}
+
+static void die_usage(void)
+{
+	fprintf(stderr, "Usage: mptcp_splice -l -p <port> -o <output_file>\n");
+	fprintf(stderr, "       mptcp_splice -a <addr> -p <port> -i <input_file>\n");
+	exit(EXIT_FAILURE);
+}
+
+int main(int argc, char *argv[])
+{
+	char *input = "", *output = "";
+	bool listen_mode = false;
+	int c;
+
+	if (argc < 2)
+		die_usage();
+
+	while ((c = getopt(argc, argv, "hli:o:a:p:")) != -1) {
+		switch (c) {
+		case 'h':
+			die_usage();
+			break;
+		case 'l':
+			listen_mode = true;
+			break;
+		case 'i':
+			input = optarg;
+			break;
+		case 'o':
+			output = optarg;
+			break;
+		case 'a':
+			server_ip = optarg;
+			break;
+		case 'p':
+			port = atoi(optarg);
+			break;
+		default:
+			die_usage();
+			break;
+		}
+	}
+
+	if (listen_mode)
+		return server(output);
+	return client(input);
+}
-- 
2.43.0

