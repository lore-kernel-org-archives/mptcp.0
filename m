Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAFC18B482
	for <mptcp@lists.linux.dev>; Thu,  1 Aug 2024 09:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504110; cv=none; b=tjI9LODwbupLk19ZnvPiBfkS13igZb/DppA6yQ3eJ2gYkpReiES03ArJ3ui8ZfqTRpck1sXmE+rWah3NpjpbastaKbNPatjh7Rik8QABR83OQDv3GkL0K7Yp/xFn/Xgin2P3gLNg0Se0uCat3PB0mKNBuWUnJ6kmFUvAM2wVZXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504110; c=relaxed/simple;
	bh=W2TuQyeWiVAbc37Da1tLEgsaRxSP3hpjznqE6RQRQIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5CaRXC5Gyk8wbNEN5VaAu0/Agp1UlRYy/DDOaFG6Fs5SKYaNrQJ4KiDGl7Fe3GnPae1xtv/DHBEziBQuzsKggRE01a8TTzqtcrkVlgwQ0GUUJbhmJlVhp3MgXzsHexieK4cYjf+y8tLMgVnnB7j7x0LKhme0VPan8WrO03hnxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T88/cl+a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T88/cl+a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB4FC32786;
	Thu,  1 Aug 2024 09:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722504109;
	bh=W2TuQyeWiVAbc37Da1tLEgsaRxSP3hpjznqE6RQRQIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T88/cl+ayDzv65IXaxkGzYFJeoLjnWfVEmB676hi3sPz8TfssvRb1FM4tgaoUqbt0
	 8oGZvZYWiqrj7bMi5E40NVlvm2Mw4f4QdAl7k+B6+Gh+UY02WaNGmJyTevuRRkeqkS
	 Aw57jgUNC345opSTbprlVkEhuSEtSb/IlnoGq48OGRa+oiuqujMSkoOze4h4gQsd1/
	 7qCoL3LLYmMTuUF9vlmkLWMp6iz0wr3LQG7wtIlPIdwOLk1LuMKaJkBxyDqwhtexJb
	 NfchIF6KoL1Srbfm/fs5vYgwnTmQhOgnyQk44AcS8heryM/f1s2L3uEfevatQd9pas
	 zR0qVwKfkBRyg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/4] selftests: mptcp: add cfg_timeo for mptcp_connect
Date: Thu,  1 Aug 2024 17:21:39 +0800
Message-ID: <abe63ed463788d59150d7fbf04f6975821f66d08.1722502941.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722502941.git.tanggeliang@kylinos.cn>
References: <cover.1722502941.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new helper settimeo(), which comes from BPF selftests
network_helpers.c, into MPTCP selftests tool mptcp_connect, to set
SO_RCVTIMEO and SO_SNDTIMEO options of the given socket.

Add a new mptcp_connect option "-O" to pass a timeout value and a new
cfg cfg_timeo to store this value.

Invoke this new helper in sock_connect_mptcp() when cfg_timeo is set.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 33 ++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 4209b9569039..ce261a4bb324 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -75,6 +75,7 @@ static char *cfg_input;
 static int cfg_repeat = 1;
 static int cfg_truncate;
 static int cfg_rcv_trunc;
+static int cfg_timeo;
 
 struct cfg_cmsg_types {
 	unsigned int cmsg_enabled:1;
@@ -249,6 +250,30 @@ static void set_mptfo(int fd, int pf)
 		perror("TCP_FASTOPEN");
 }
 
+static int settimeo(int fd, int timeout_ms)
+{
+	struct timeval timeout = { .tv_sec = 3 };
+
+	if (timeout_ms > 0) {
+		timeout.tv_sec = timeout_ms / 1000;
+		timeout.tv_usec = (timeout_ms % 1000) * 1000;
+	}
+
+	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeout,
+		       sizeof(timeout))) {
+		perror("set SO_RCVTIMEO");
+		return -1;
+	}
+
+	if (setsockopt(fd, SOL_SOCKET, SO_SNDTIMEO, &timeout,
+		       sizeof(timeout))) {
+		perror("set SO_SNDTIMEO");
+		return -1;
+	}
+
+	return 0;
+}
+
 static int do_ulp_so(int sock, const char *name)
 {
 	return setsockopt(sock, IPPROTO_TCP, TCP_ULP, name, strlen(name));
@@ -376,6 +401,9 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 		if (cfg_mark)
 			set_mark(sock, cfg_mark);
 
+		if (cfg_timeo)
+			settimeo(sock, cfg_timeo);
+
 		if (cfg_sockopt_types.mptfo) {
 			if (!winfo->total_len)
 				winfo->total_len = winfo->len = read(infd, winfo->buf,
@@ -1384,7 +1412,7 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 
-	while ((c = getopt(argc, argv, "6c:f:hi:I:jlm:M:o:p:P:r:R:s:S:t:T:w:")) != -1) {
+	while ((c = getopt(argc, argv, "6c:f:hi:I:jlm:M:o:p:P:r:R:s:S:t:T:w:O:")) != -1) {
 		switch (c) {
 		case 'f':
 			cfg_truncate = atoi(optarg);
@@ -1462,6 +1490,9 @@ static void parse_opts(int argc, char **argv)
 		case 'o':
 			parse_setsock_options(optarg);
 			break;
+		case 'O':
+			cfg_timeo = strtol(optarg, NULL, 0);
+			break;
 		}
 	}
 
-- 
2.43.0

