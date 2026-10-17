Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A662E7370
	for <mptcp@lists.linux.dev>; Sat, 17 Oct 2026 11:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792236131; cv=none; b=RzAZGMF5D66IZNACbsnTpiT1YwXb6v0zIrG7itpIClvVclpJecpFKx77CUNMgPh16mJ6fBfp0phOobsy5GzSwgoQW+a+Sbjns13mEQ6zINzZf1hOmZVti+YVNwES0pSJtzAQj8ktrPmNAsRlIJIFlgaq9Jq3VoPRdwYDTIHqxPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792236131; c=relaxed/simple;
	bh=QM6YH1oQb2mPCP1KOBoNCq+ENoL49+IBswtGhdWHfIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ph4xMf+SB2nm4f7J8glWx4ko0Vyg5j3SJTnsldcfzwtvsic8KIYFRDQDT0m6btRfIVA2A+y/HoPqmbz3ShYsNbRYKqVg5+gsNpJuW/jedF20HGG/+UIPGHIal+6JQ0Tl1UskdJDZkI61AKb6PH6NunOaywZ3qxeXd3JkQR3YRoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C55HsRxf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C55HsRxf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D12BC2BCF5
	for <mptcp@lists.linux.dev>; Sat, 17 Oct 2026 11:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792236131;
	bh=QM6YH1oQb2mPCP1KOBoNCq+ENoL49+IBswtGhdWHfIk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=C55HsRxf8O+hmIniFuozmlnKo6D9kIQP4Orbx+enhSctno/eEQzxV/zQLseryb3fJ
	 OJEP3jy0YXq1rsBCFw00K2XUZET7JBLu+CYa8V1ulntWL6eGYQnlOzQHw7pDb7yppa
	 dXBP+2WxYq2ZKS1lCV88a1P26Xcqica8QtcygRCJVSPFkJh9quYnYidoweTCKEt2BJ
	 auFE9hFvyLK/nOf85A/LwYcgeazER2kBhVFCeSt3Ow7fiqRMmoWgdb8uaQd+4Lc9TJ
	 4hEIIm92wYLMIW26njD5y6AKg2nBPLcbU7fyIpcV9yTPgeQyahJD3q+gkMjy9/IZQh
	 uvieHyWdSv0bg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DC1CCF2C9
	for <mptcp@lists.linux.dev>; Sat, 17 Oct 2026 11:22:11 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Date: Sat, 17 Oct 2026 04:22:09 -0700
Subject: [PATCH mptcp-net] selftests: mptcp: sockopt: echo until EOF on
 partial reads
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-fix-mptcp-issue-639-v1-1-0554d07ab8f8@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMBAEf6XsswdNApH4K+JDTE89wRhyaRFK/
 91oH4ednRXKVVhxGlZUXkTlnTuYw4D0iPnOJFNn2NF6M5oj3eRDr9JSIVGdmbwLFLxzIbopWBP
 Rn6Vy1/7VM3Y5c8Nln3S+Pjm1XxXb9gVuv6T6ggAAAA==
X-Change-ID: 20261017-fix-mptcp-issue-639-96339a3d921a
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: 
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792236130; l=2550;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=0NlNMl4TVlVwcMzE5vOqapeIyEyPNrpzFN+zJ7PBm3M=;
 b=xXOYKpsUPcqVjiU9P6KbNzpSw6MyX3rWBK+ZoXqJr4zyHodB0epJX+SqxZlJjByj8ELnXfKRO
 UMSlzKgUiTBCgyhr7il3oLnZbMKyVIHSbK0VlrAunX5f9uv4/ejljAO
X-Developer-Key: i=quanyeyang@proton.me; a=ed25519;
 pk=9L9FrcvzMgxPaBRU6XV0EnqTgjDqVO596rQKSZ9qZoY=
X-Endpoint-Received: by B4 Relay for quanyeyang@proton.me/20260801 with
 auth_id=963
X-Original-From: Quanye Yang <quanyeyang@proton.me>
Reply-To: quanyeyang@proton.me

From: Quanye Yang <quanyeyang@proton.me>

process_one_client() used a single read() and write() before waiting
for hangup. A SOCK_STREAM read() can return a short count when the
payload is segmented, so the server echoed only part of the data and
then blocked on FIN.

The client keeps reading until it has the full length and only then
closes the socket. The two sides wait on each other and the test
hangs until SIGALRM.

Loop the server read/write until read() returns 0, and accumulate the
copied byte counts for the existing sockopt checks.

Fixes: ce9979129a0b ("selftests: mptcp: add mptcp getsockopt test cases")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/639
Signed-off-by: Quanye Yang <quanyeyang@proton.me>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 34 +++++++++++++----------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b6e58d936ebe..5e1ec3336859 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -638,7 +638,7 @@ static void connect_one_server(int fd, int pipefd)
 
 static void process_one_client(int fd, int pipefd)
 {
-	ssize_t ret, ret2, ret3;
+	ssize_t ret, ret2, n, w;
 	struct so_state s;
 	char buf[4096];
 
@@ -648,23 +648,27 @@ static void process_one_client(int fd, int pipefd)
 	ret = write(pipefd, "xmit", 4);
 	assert(ret == 4);
 
-	ret = read(fd, buf, sizeof(buf));
-	if (ret < 0)
-		die_perror("read");
+	ret = 0;
+	ret2 = 0;
+	while ((n = read(fd, buf, sizeof(buf))) > 0) {
+		if (!ret) {
+			assert(s.mptcpi_rcv_delta <= (uint64_t)n);
 
-	assert(s.mptcpi_rcv_delta <= (uint64_t)ret);
-
-	if (s.tcpi_rcv_delta)
-		assert(s.tcpi_rcv_delta == (uint64_t)ret);
+			if (s.tcpi_rcv_delta)
+				assert(s.tcpi_rcv_delta <= (uint64_t)n);
+		}
 
-	ret2 = write(fd, buf, ret);
-	if (ret2 < 0)
-		die_perror("write");
+		w = write(fd, buf, n);
+		if (w < 0)
+			die_perror("write");
+		if (w != n)
+			xerror("short write");
 
-	/* wait for hangup */
-	ret3 = read(fd, buf, 1);
-	if (ret3 != 0)
-		xerror("expected EOF, got %lu", ret3);
+		ret += n;
+		ret2 += w;
+	}
+	if (n < 0)
+		die_perror("read");
 
 	do_getsockopts(&s, fd, ret, ret2);
 	if (s.mptcpi_rcv_delta != (uint64_t)ret + 1)

---
base-commit: a22035be824449c4921ec406f6383089016a628c
change-id: 20261017-fix-mptcp-issue-639-96339a3d921a

Best regards,
--  
Quanye Yang <quanyeyang@proton.me>


