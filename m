Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5978382283
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 03:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785381342; cv=none; b=B1pfgM+tgeidZefWNOYiTfhoz16sEy0CkYO1YFvdguq0lL2VXiWihCWIsGZnytYijuyXuE8GOyIJo7feiCqiRRyjTMrFkt0kkYxTfR18WtP+ekDoqRgGslpnNMoQPLHhGmWCEBeSwpAD/JB4innkONYywVJxgJyDYG0hEfXwP04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785381342; c=relaxed/simple;
	bh=0O3up8mLcO2UONzf1P6RLZTfJcycWsJz27kewHaFEWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cl7L9ecwirx8G57Jxh2e7+UgvW6pughMXlZEd0i5KlbUvG+Klb23VUHR5ouJgt5la0iFR/OdSqEn5QT/Q2524dQUltVUxciyv0nc9MhXOEH9PvImlasxbQUJIpKxynAHcGdR2Ggg4Ug+ED055xzloXkGXGzEr+VcKtKOS6u63TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWWQxoIa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWWQxoIa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BFF1F00A3A;
	Thu, 30 Jul 2026 03:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785381341;
	bh=B2EyKeoCM+zSdeD7Y5VHNb0MoiRh9rntgcTDNxCnN0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RWWQxoIatNQDS7RBdjOe2Ec792bJd95l5ijofgmKlzj9nB8oxyOnulDm26E+EVGgl
	 4+NJRYELBPdWYbWS5YHObIjjVm2z1zsTDQ650Yc0GpHV/C6xrGaIVLgzzjMd0Kbhhw
	 fWAqO0IQeYiHOI5wRUCHU4NhAdIoefL16kqY6PKPChPRvLbPAu0yZ241auQU4rgd2S
	 ojLhtBsX+FX0XwoSlcu87qeCQM8Ec3v480IVk8Z4R/iZGzpd1oXbTmiNldWYesrVrZ
	 JUcKKKrdlxnSpsntokAU1YFjHRY/knwcTshnP4FOuVhF+xsidvLw4zcDuZtQaX/bem
	 b2Zsr2u55KtcQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 05/12] selftests: mptcp: sockopt: add is_mptcp_socket helper
Date: Thu, 30 Jul 2026 11:15:16 +0800
Message-ID: <c62aa1281f35a9cdee1f8eba4a6e0859615633a8.1785380422.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785380422.git.tanggeliang@kylinos.cn>
References: <cover.1785380422.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add a small is_mptcp_socket() helper that issues getsockopt(TCP_IS_MPTCP)
and returns whether the fd belongs to an MPTCP socket.

Use it to gate the MPTCP-specific assertions: skip do_getsockopts()
entirely for plain TCP or fallback MPTCP sockets, and skip mptcpi_rcv_delta
checks in connect_one_server()/process_one_client() when the socket is not
an MPTCP socket.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 31 +++++++++++++++++--
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 3a7fcef5aa54..822cbf3de3e6 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -35,6 +35,9 @@ static int pf = AF_INET;
 #ifndef SOL_MPTCP
 #define SOL_MPTCP 284
 #endif
+#ifndef TCP_IS_MPTCP
+#define TCP_IS_MPTCP 76
+#endif
 
 #ifndef MPTCP_INFO
 struct mptcp_info {
@@ -557,8 +560,28 @@ static void do_getsockopt_mptcp_full_info(struct so_state *s, int fd)
 	assert(!memcmp(&sfinfo->addrs, &s->addrs, sizeof(struct mptcp_subflow_addrs)));
 }
 
+static int is_mptcp_socket(int fd)
+{
+	int is_mptcp = 0;
+	socklen_t optlen;
+
+	optlen = sizeof(is_mptcp);
+	if (getsockopt(fd, IPPROTO_TCP, TCP_IS_MPTCP, &is_mptcp, &optlen) < 0) {
+		if (errno == ENOPROTOOPT) {
+			perror("TCP_IS_MPTCP test skipped");
+			return 0;
+		}
+		xerror("getsockopt TCP_IS_MPTCP");
+	}
+
+	return is_mptcp;
+}
+
 static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 {
+	if (!is_mptcp_socket(fd))
+		return;
+
 	do_getsockopt_mptcp_info(s, fd, w);
 
 	do_getsockopt_tcp_info(s, fd, r, w);
@@ -634,7 +657,8 @@ static void connect_one_server(int fd, int pipefd)
 	if (eof)
 		total += 1; /* sequence advances due to FIN */
 
-	assert(s.mptcpi_rcv_delta == (uint64_t)total);
+	if (is_mptcp_socket(fd))
+		assert(s.mptcpi_rcv_delta == (uint64_t)total);
 	close(fd);
 }
 
@@ -683,8 +707,9 @@ static void process_one_client(int fd, int pipefd)
 	r += ret;
 
 	do_getsockopts(&s, fd, r, w);
-	check_stat_equal("mptcpi_rcv_delta", s.mptcpi_rcv_delta,
-			 (uint64_t)r + 1); /* +1 for FIN */
+	if (is_mptcp_socket(fd))
+		check_stat_equal("mptcpi_rcv_delta", s.mptcpi_rcv_delta,
+				 (uint64_t)r + 1); /* +1 for FIN */
 
 	/* be nice when running on top of older kernel */
 	if (s.pkt_stats_avail) {
-- 
2.53.0

