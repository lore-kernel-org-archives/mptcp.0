Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9413219E0
	for <mptcp@lists.linux.dev>; Thu, 26 Jun 2025 08:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927334; cv=none; b=l7ekR2B152OEMKZ3yD6TxiEYxU00J/D8qA4EJzvfYTW4x1tL2apoSFiKwfDaOBK/sYe+85rO/+kuJezejjONeFdt8qWKNklxQ9aRbxhsbCVyQMpbIZXisd3A5Sk4xkiFOdgZrDAp2SpaiIbUK5i3DHA7nxRa4M5iYgrGTL+WEuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927334; c=relaxed/simple;
	bh=dP9m+arofxMkgE5b4/LQq4IsABALEjKhl/dyYhFny/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYd/C21/PegljJ7lb/ADDP+KJVZF6NB6Y3fPacdOxKURMFF6cq1/JHTDFQqq1f/jnQDm4LK1fLdZNDYvatHdpUg+dCfnp7NUOY1wyetag3IAJeHOrDjk7lZtgOPNy3TlMeGmz0UZ7Jr53mN3OxCSiJzgf3b48mbHLMf9PpXWnFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmOb0Eq7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmOb0Eq7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D445FC4CEEB;
	Thu, 26 Jun 2025 08:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750927333;
	bh=dP9m+arofxMkgE5b4/LQq4IsABALEjKhl/dyYhFny/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gmOb0Eq7FBbP3a3f6hT8Osy/3ZDVI7Zy6Sn36i1DYUWGatKC/82t6RBC85Ptj2a1f
	 m3xfkAuv3o3FYxiDdkqBRvBgeT/S2XKpp3X7KAi1d/bE+XOfE0MoSV7IWvAZc+PpCx
	 uoeufsZ3UIt4H4npV90mkUa1K1NUvMf+QuANhM9IJI13NLKbu+dajRH1z3iDQ0JZNz
	 sPt5BsQI1B9nvuce73j00MX55dsOouNMfFZGU4pMWFqDrKhjytlOJ029r4BUy7Tiem
	 jCrt3qp2BfmjGV5WXEy/nkpL1IRFvgEOYZaQaQQqpbjN0aXoDsnmKwrKQeHqrNfFt2
	 dpCbWS5KqGACQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 4/4] selftests: mptcp: add splice io mode
Date: Thu, 26 Jun 2025 16:41:53 +0800
Message-ID: <2ed975ed4ca56a1a87fe38e7ad993e5c2d84513a.1750926916.git.geliang@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1750926916.git.geliang@kernel.org>
References: <cover.1750926916.git.geliang@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new 'splice' io mode for mptcp_connect to test
the newly added read_sock() and splice() functions of MPTCP.

	./mptcp_connect.sh -m splice

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 61 ++++++++++++++++++-
 .../selftests/net/mptcp/mptcp_connect.sh      |  9 ++-
 2 files changed, 68 insertions(+), 2 deletions(-)

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
index 5e3c56253274..4dd59a2ed21e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -339,7 +339,14 @@ do_transfer()
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
 
 	if [ -n "$extra_args" ] && $options_log; then
-- 
2.48.1

