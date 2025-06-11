Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D6922DFA2
	for <mptcp@lists.linux.dev>; Wed, 11 Jun 2025 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749633913; cv=none; b=FTtP4PaL8LbjjOsAF4Q6FVCEdGiJh07fUw71XdmHvIvmotMs5aELGWIPHeVCq+kr2aBE4sc9sGTcKH22Ja2ebeOxU7rxPP1wu0HS99K6I41kd4SN+HwInfpLmM/m3zw9WrZc7p36FuuX10HfibqjPUMNJteQy4r8il/X1HsIq6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749633913; c=relaxed/simple;
	bh=KvjMSIJy3lYCLYwy9S+Qk+3H39d+nm+2nUs2myUa5mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XLltOyyKw5xyab+t4xdpg4smJ3WM14DWOpsP6pdcrxUOSiRCRMfp6hnz6oTirANTHVidICzVjvcvaJh6SNP9khGadE6/Z3vSXVmY1+7HMfpc2B6YMR2ylcw1zOHsWnpCaFBNV3staoo9z298+1BwnRemP/+dYqJ1zhvYgggRW9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=up+9neWw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="up+9neWw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D68C4CEEE;
	Wed, 11 Jun 2025 09:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749633913;
	bh=KvjMSIJy3lYCLYwy9S+Qk+3H39d+nm+2nUs2myUa5mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=up+9neWw1O3GykBFHPmQkPITz8s3dKxz5tFUGriUd5ceBFSFdqSI80X40hOmMR67Q
	 bkcp5OxLckUfPm0xpqm92CPIVd2o+ktuxGjSMZ2/vGYVUQuRFsOr3Stnc8BMQW+UJ3
	 bM0lfepuOV3Viluj6IKla+08ibq2AWEfj33bV/+LdcjOrRe/NLlTH4qsZpyU8lM+zS
	 pK5tWAojb6DwmGsbxzeCNrZU+nP5rS/FrOXRplWnC6SNHMfe+HOe/pwunVTmj5woWo
	 dNYrEpqJFq51JmcMV9rwT4QjiBk1x9ecM+RbF9CAdV+xsOIwtdDFYk95Zd7VmE3Jxk
	 0J+o5qTBBg/AQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/2] Squash to "selftests: mptcp: add splice test"
Date: Wed, 11 Jun 2025 09:24:53 +0000
Message-ID: <756dfb8d54e0f43523f3ab630b807b22da0d6535.1749633671.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1749633671.git.tanggeliang@kylinos.cn>
References: <cover.1749633671.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Close all fds of mptcp_splice.c.
Add splice io mode for mptcp_connect.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 61 ++++++++++++++++++-
 .../selftests/net/mptcp/mptcp_connect.sh      | 10 ++-
 .../selftests/net/mptcp/mptcp_splice.c        | 43 ++++++++-----
 3 files changed, 98 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index ac1349c4b9e5..ce4b4ed9164d 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -51,6 +51,7 @@ enum cfg_mode {
 	CFG_MODE_POLL,
 	CFG_MODE_MMAP,
 	CFG_MODE_SENDFILE,
+	CFG_MODE_SPLICE,
 };
 
 enum cfg_peek {
@@ -123,7 +124,7 @@ static void die_usage(void)
 	fprintf(stderr, "\t-j     -- add additional sleep at connection start and tear down "
 		"-- for MPJ tests\n");
 	fprintf(stderr, "\t-l     -- listens mode, accepts incoming connection\n");
-	fprintf(stderr, "\t-m [poll|mmap|sendfile] -- use poll(default)/mmap+write/sendfile\n");
+	fprintf(stderr, "\t-m [poll|mmap|sendfile|splice] -- use poll(default)/mmap+write/sendfile/splice\n");
 	fprintf(stderr, "\t-M mark -- set socket packet mark\n");
 	fprintf(stderr, "\t-o option -- test sockopt <option>\n");
 	fprintf(stderr, "\t-p num -- use port num\n");
@@ -925,6 +926,53 @@ static int copyfd_io_sendfile(int infd, int peerfd, int outfd,
 	return err;
 }
 
+static int do_splice(const int infd, const int outfd, const size_t len)
+{
+	int pipefd[2];
+	ssize_t bytes;
+	int err;
+
+	err = pipe(pipefd);
+	if (err)
+		return err;
+
+	while ((bytes = splice(infd, NULL, pipefd[1], NULL, len,
+			       SPLICE_F_MOVE | SPLICE_F_MORE)) > 0) {
+		splice(pipefd[0], NULL, outfd, NULL, bytes,
+		       SPLICE_F_MOVE | SPLICE_F_MORE);
+	}
+
+	close(pipefd[0]);
+	close(pipefd[1]);
+
+	return 0;
+}
+
+static int copyfd_io_splice(int infd, int peerfd, int outfd, unsigned int size,
+			    bool *in_closed_after_out, struct wstate *winfo)
+{
+	int err;
+
+	if (listen_mode) {
+		err = do_splice(peerfd, outfd, size);
+		if (err)
+			return err;
+
+		err = do_splice(infd, peerfd, size);
+	} else {
+		err = do_splice(infd, peerfd, size);
+		if (err)
+			return err;
+
+		shut_wr(peerfd);
+
+		err = do_splice(peerfd, outfd, size);
+		*in_closed_after_out = true;
+	}
+
+	return err;
+}
+
 static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd, struct wstate *winfo)
 {
 	bool in_closed_after_out = false;
@@ -957,6 +1005,14 @@ static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd, struct
 					 &in_closed_after_out, winfo);
 		break;
 
+	case CFG_MODE_SPLICE:
+		file_size = get_infd_size(infd);
+		if (file_size < 0)
+			return file_size;
+		ret = copyfd_io_splice(infd, peerfd, outfd, file_size,
+				       &in_closed_after_out, winfo);
+		break;
+
 	default:
 		fprintf(stderr, "Invalid mode %d\n", cfg_mode);
 
@@ -1361,12 +1417,15 @@ int parse_mode(const char *mode)
 		return CFG_MODE_MMAP;
 	if (!strcasecmp(mode, "sendfile"))
 		return CFG_MODE_SENDFILE;
+	if (!strcasecmp(mode, "splice"))
+		return CFG_MODE_SPLICE;
 
 	fprintf(stderr, "Unknown test mode: %s\n", mode);
 	fprintf(stderr, "Supported modes are:\n");
 	fprintf(stderr, "\t\t\"poll\" - interleaved read/write using poll()\n");
 	fprintf(stderr, "\t\t\"mmap\" - send entire input file (mmap+write), then read response (-l will read input first)\n");
 	fprintf(stderr, "\t\t\"sendfile\" - send entire input file (sendfile), then read response (-l will read input first)\n");
+	fprintf(stderr, "\t\t\"splice\" - send entire input file (splice), then read response (-l will read input first)\n");
 
 	die_usage();
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 5e3c56253274..0b0ed1df710d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -339,9 +339,17 @@ do_transfer()
 	fi
 
 	if [ -n "$testmode" ]; then
-		extra_args+=" -m $testmode"
+		if [ ${testmode} = "splice" ]; then
+			# only use 'splice' mode for MPTCP tests
+			if [ ${cl_proto} = "MPTCP" ] && [ ${srv_proto} = "MPTCP" ]; then
+				extra_args+=" -m splice"
+			fi
+		else
+			extra_args+=" -m $testmode"
+		fi
 	fi
 
+
 	if [ -n "$extra_args" ] && $options_log; then
 		mptcp_lib_pr_info "extra options: $extra_args"
 	fi
diff --git a/tools/testing/selftests/net/mptcp/mptcp_splice.c b/tools/testing/selftests/net/mptcp/mptcp_splice.c
index a04ab7e1448d..a43cbc556ec6 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_splice.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_splice.c
@@ -39,7 +39,7 @@ static int server(char *output)
 	if (setsockopt(server_fd, SOL_SOCKET, SO_REUSEADDR | SO_REUSEPORT,
 		       &opt, sizeof(opt))) {
 		perror("setsockopt");
-		exit(EXIT_FAILURE);
+		goto close_server;
 	}
 
 	address.sin_family = AF_INET;
@@ -48,12 +48,12 @@ static int server(char *output)
 
 	if (bind(server_fd, (struct sockaddr *)&address, sizeof(address)) < 0) {
 		perror("bind failed");
-		exit(EXIT_FAILURE);
+		goto close_server;
 	}
 
 	if (listen(server_fd, 3) < 0) {
 		perror("listen");
-		exit(EXIT_FAILURE);
+		goto close_server;
 	}
 
 	printf("Server listening on port %d...\n", port);
@@ -62,20 +62,20 @@ static int server(char *output)
 			   (socklen_t *)&addrlen);
 	if (client_fd < 0) {
 		perror("accept");
-		exit(EXIT_FAILURE);
+		goto close_client;
 	}
 
 	printf("Client connected. Receiving file...\n");
 
 	if (pipe(pipefd)) {
 		perror("pipe");
-		exit(EXIT_FAILURE);
+		goto close_client;
 	}
 
 	out_fd = open(output, O_WRONLY | O_CREAT | O_TRUNC, 0644);
 	if (out_fd < 0) {
 		perror("open");
-		exit(EXIT_FAILURE);
+		goto close_pipe;
 	}
 
 	while ((bytes = splice(client_fd, NULL, pipefd[1], NULL, BUFFER_SIZE,
@@ -83,14 +83,22 @@ static int server(char *output)
 		splice(pipefd[0], NULL, out_fd, NULL, bytes, SPLICE_F_MOVE | SPLICE_F_MORE);
 	}
 
-	if (bytes == -1)
+	if (bytes == -1) {
 		perror("splice");
+		goto close_fd;
+	}
 
 	printf("File transfer completed. Received %ld bytes.\n",
 	       lseek(out_fd, 0, SEEK_CUR));
 
-	close(client_fd);
+close_fd:
 	close(out_fd);
+close_pipe:
+	close(pipefd[0]);
+	close(pipefd[1]);
+close_client:
+	close(client_fd);
+close_server:
 	close(server_fd);
 
 	return 0;
@@ -114,25 +122,25 @@ static int client(char *input)
 
 	if (inet_pton(AF_INET, server_ip, &serv_addr.sin_addr) <= 0) {
 		perror("Invalid address/ Address not supported");
-		exit(EXIT_FAILURE);
+		goto close_sock;
 	}
 
 	if (connect(sock_fd, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) < 0) {
 		perror("Connection Failed");
-		exit(EXIT_FAILURE);
+		goto close_sock;
 	}
 
 	printf("Connected to server. Sending file...\n");
 
 	if (pipe(pipefd)) {
 		perror("pipe");
-		exit(EXIT_FAILURE);
+		goto close_sock;
 	}
 
 	in_fd = open(input, O_RDONLY);
 	if (in_fd == -1) {
 		perror("open");
-		exit(EXIT_FAILURE);
+		goto close_pipe;
 	}
 
 	while ((bytes = splice(in_fd, NULL, pipefd[1], NULL, BUFFER_SIZE,
@@ -140,14 +148,21 @@ static int client(char *input)
 		splice(pipefd[0], NULL, sock_fd, NULL, bytes, SPLICE_F_MOVE | SPLICE_F_MORE);
 	}
 
-	if (bytes == -1)
+	if (bytes == -1) {
 		perror("splice");
+		goto close_fd;
+	}
 
 	printf("File transfer completed. Sent %ld bytes.\n",
 	       lseek(in_fd, 0, SEEK_CUR));
 
-	shutdown(sock_fd, SHUT_WR);
+close_fd:
 	close(in_fd);
+close_pipe:
+	close(pipefd[0]);
+	close(pipefd[1]);
+close_sock:
+	shutdown(sock_fd, SHUT_WR);
 	close(sock_fd);
 
 	return 0;
-- 
2.43.0

