Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F604502F
	for <mptcp@lists.linux.dev>; Fri, 31 Jul 2026 01:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785460375; cv=none; b=oLdLCwgf6NsIl8kKiyTu78Du9deB+OBS6685fbrqY1c+IalhsST9uf6N5usqBNxORsoQm7TpcrOx+eCijGycQYi4c+0iRB6wGcR0Qb303/vVHN8d40puzSGfAaezJlmwLo7iWlZN1w73b+W3K0gYahmRQVVPq1rSYn85zB/TYSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785460375; c=relaxed/simple;
	bh=D/9DcwXrGrOCae3qS7GXifMvJank4OnaWe+YQP6EaHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K4O4L/7lUHWjFlZDOxN8YDMQaxGexLgKz4FBkET2mjNrzNIcU3Y1BPuxusopneqS4JjlrDKtxFosw8o0h0wx/15d+cDLd2VDxSOzjOXZ6J3L8oR2lsDsE3q/FGvVkf0UgVH4A762dWax6xJi09P0GzT8AsdBuetnS7PP91TWghw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOf91233; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOf91233"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0881F000E9;
	Fri, 31 Jul 2026 01:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785460374;
	bh=P9q5F7sB9/GI+Z5BQDF+DEPWWGIithY6KW9LA2pli8o=;
	h=From:To:Cc:Subject:Date;
	b=gOf91233T+9JmI8Qu0DAMrzqbknlMYPqt0PvTuI7wAkH7emnRSUO8elc7WuAWyTHb
	 vlzrvTQNdiwULXZm80Jkhdulw/sRzaO7d9yLb56tn7/rlgUnjtA7gZ2cxtOsIg5xaj
	 5a6oKWmo/ynZ63rhiNEYEj5OmDoTr6LdLJWgg4TGeOGfpfxPDMmhUtwSDasS+14RTe
	 wCMDDNhd1kSgchktBf6QKXyXNQ18yA9RwhE2nVGzTLWgeFXSONR80QgYVYHdnYYUU4
	 85cddWaKlUp95akKyuafMUcLkyNqjuPwfrk3SLXNEBm5O22w8Hq1V5ECTYll4NDd/v
	 m41gl1DQiN4Fg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: sockopt: add is_mptcp_socket helper"
Date: Fri, 31 Jul 2026 09:12:48 +0800
Message-ID: <1b103d397cf4a506c608d9ade586e98db770daec.1785460213.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Fix the TCP_IS_MPTCP fallback value from 76 to 43 (matches UAPI), and
handle both ENOPROTOOPT and EOPNOTSUPP so old kernels without the
option don't abort via xerror(). Default is_mptcp to -1 (unknown) so
the helper honestly signals "I don't know" instead of falsely claiming
"not MPTCP", and update the three call sites to use > 0 / <= 0

Based-on: <cover.1785380422.git.tanggeliang@kylinos.cn>

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_sockopt.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index cbc594ff7792..24d34f28bb05 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -39,7 +39,7 @@ static int pf = AF_INET;
 #define SOL_MPTCP 284
 #endif
 #ifndef TCP_IS_MPTCP
-#define TCP_IS_MPTCP 76
+#define TCP_IS_MPTCP 43
 #endif
 
 static int proto_tx = IPPROTO_MPTCP;
@@ -591,16 +591,13 @@ static void do_getsockopt_mptcp_full_info(struct so_state *s, int fd)
 
 static int is_mptcp_socket(int fd)
 {
-	int is_mptcp = 0;
+	int is_mptcp = -1;
 	socklen_t optlen;
 
 	optlen = sizeof(is_mptcp);
 	if (getsockopt(fd, IPPROTO_TCP, TCP_IS_MPTCP, &is_mptcp, &optlen) < 0) {
-		if (errno == ENOPROTOOPT) {
-			perror("TCP_IS_MPTCP test skipped");
-			return 0;
-		}
-		xerror("getsockopt TCP_IS_MPTCP");
+		if (errno != ENOPROTOOPT && errno != EOPNOTSUPP)
+			xerror("getsockopt TCP_IS_MPTCP");
 	}
 
 	return is_mptcp;
@@ -608,7 +605,7 @@ static int is_mptcp_socket(int fd)
 
 static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 {
-	if (!is_mptcp_socket(fd))
+	if (is_mptcp_socket(fd) <= 0)
 		return;
 
 	do_getsockopt_mptcp_info(s, fd, w);
@@ -777,7 +774,7 @@ static void connect_one_server(int fd, int unixfd)
 	if (eof)
 		total += 1; /* sequence advances due to FIN */
 
-	if (is_mptcp_socket(fd))
+	if (is_mptcp_socket(fd) > 0)
 		assert(s.mptcpi_rcv_delta == (uint64_t)total);
 
 	if (inq)
@@ -1012,7 +1009,7 @@ static void process_one_client(int fd, int unixfd)
 	r += ret;
 
 	do_getsockopts(&s, fd, r, w);
-	if (is_mptcp_socket(fd))
+	if (is_mptcp_socket(fd) > 0)
 		check_stat_equal("mptcpi_rcv_delta", s.mptcpi_rcv_delta,
 				 (uint64_t)r + 1); /* +1 for FIN */
 
-- 
2.53.0

