Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793011388;
	b=E+kki5XAiWS+KSBAuQhV2O3a9JwZH2+ZTTRkzjD7RvpkKZUdB7oAX4vB3taRobdiiNBv
	 6SkLEWCsRsipSMDOXr1WK4E8t0EufBkcrg4G0cy1dxsr4fYzcBG1UL230ljWeGqrayl59
	 GBKqRijIXLjO0UZCbjSRTJAFdbaM+osxRCKZ9qakEqphCR3sWkLeZQHtO0V0Nlvtp6p9w
	 p3bWxylLvX1pnCdh9CWb7ssO/6e19A+nd4JrOTeGf775UrLwxIp/OwOiNCS8K0iR4Qesy
	 6DI+PE1CWKq8WVH5d3dayYPtAeawuEFdM1p/GiaEE3ptMQxKgr25a4dVEavKZKasotw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011388;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hRusVOW6yPxvo12nJa3Ma+cUdTkKX0KR33lpUjoEUUU=;
	b=ySRjcALQbYK1dI1c1VB9tGY2kbOcvvZVRUTt/1LJTWVdLM997lQwt/wKjvPUI3xwgNib
	 M4xSyoK5Hcj3D64PQEnrblMYRWWJ5BdvGd1uERLXq2SgJAmD9VeHEF2ZP1u8WKzgOw1as
	 Dj6MoloK49U/LHtvh1RCBoP9YzDvDE4/Hx0cfwzDl8RVOXyTTzb2OYFQSDP1Phfx8dY4Z
	 4DIDAORLVhOV+QswIlQn4B4C3PwNc5PklA1PTDd9ehamJ/W1v/iTkHhnSNusGUfsRg3AN
	 +TS42bmI9R3YFaweDpN/ODInpfpijaf5AnajgR+x88XNGtsNzoi0dL5Hh6xYZCg6g3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eipLwFjK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DB9606A31A
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 10:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eipLwFjK
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793011387;
	b=MiBYMoyv1c+nmaOuao9/90PV3U8zo/iGenLjpExiLg1sHkexgabQ9CKPQ5fyutz8QyCh
	 3MCDMx9iqJbXPF/J1AglVl8IC4IaVa6cYLEovpbNyscva9Vsi6Sqc25CMS2R02RIxGoUw
	 ptAHk9y+8HcIOwFUpVQrAw78glE+dzqh5wLixFqK/RKPR5WBSWP50kk7HHuMr6cGGx1A+
	 yVdqm60YUEdS3VXitIK5BtN5xov/+5MQQShcfH9MG04peBKFeAZdKV6oTo3+rZNOSNKFg
	 pChuBJxi5VSk1N8855+8T61M2tVV2eHBcuAijnJ4sjbdsqQ8yI9aNqQyqEMnAUsWsmA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793011387;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hRusVOW6yPxvo12nJa3Ma+cUdTkKX0KR33lpUjoEUUU=;
	b=PDc122ktqeBQ4iFzaKu8zIuqeWM9Vf1KEBn0BINARJUavMty05B23GDkOgmwU18HX7jd
	 N1wqLsKGjO8du/oxfvIuc/2c8X6efpxHupxDXTZwqoUVbR3Cret1pr0InzLoayr6cr2ii
	 5xNfuCqGYxsArrMSg07VlmAa4k95HjK/B47o8LpCa7JDcYdknNZ4PSS6h2QHzoTk6C6k/
	 Vi1AKuFXFbgB+l8yPi9y8MRjfvS/abDpLAaljQNoOfegNRRDO2jvcAYh/zBk+taGqGAmF
	 sf9gg4uzToaD3YJU8JLdglP7ru8OCbk64xBwiBju1WR48ZRLrREaHHURet153qCF2YA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 19D7A1F01825;
	Mon, 26 Oct 2026 10:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793011387;
	bh=hRusVOW6yPxvo12nJa3Ma+cUdTkKX0KR33lpUjoEUUU=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=eipLwFjKd43qw/opw4zuaTbhqfr1mQ6St+ke9H0sjsL6Qh/QR70oN2rJChr7D66Zc
	 TCElXNv6NfOwx9MGmghbiNxgzzohW+RJ3UzQgMOEfp03rQxd+BsiELITVM+4cEVaPx
	 DRjJ/EB6cfAV9qLS2KiI2jOBos5ez6DlPRNMYPZ4kaxMdZrwg4e9FrxUuvholVue92
	 Tz7E4CRtPu3l04u/DLdnzqTyvMwzAZ++d79jxQLwZJcVu7wbVvhWYxJprwCntw0oiy
	 Urh7xNiIMd2xLyFcQrtV9ZRnpgfChxlTvV+tE43Mux+4bQLRRftXUqFBK5KuNMNL+e
	 YvyvM/Xrg+iYQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6D3F144C80;
	Mon, 26 Oct 2026 10:43:06 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Date: Mon, 26 Oct 2026 03:43:03 -0700
Subject: [PATCH mptcp-next v3] selftests: mptcp: sockopt: echo until EOF on
 partial reads
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261026-fix-mptcp-issue-639-v3-1-165485982827@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32OSw6DIBiEr2JYl4aHonTVezRdoPxWmigGkNgY7
 17UjYumy8nMfDML8uAMeHTLFuQgGm/skAS/ZKjp1PACbHTSiBEmKKElbs2M+zE0IzbeT4AFl1g
 KzqXiWjKqUGqODlJspz7QER5gDuh5eH6q39CEDbulO+ODdZ/9QqR75+9apJhiUhS5JqWqq7a6j
 84GO1x72BciOzEY/81giUHz9JmXudBMnxnrun4BJ3d3KBgBAAA=
X-Change-ID: 20261017-fix-mptcp-issue-639-96339a3d921a
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: matttbe@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793011385; l=4942;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=o6McbY/P99n91QwPAyUuPX3sTnYTyHf/vgicwWKGmfM=;
 b=X8+eBXsi2sTnzCxhoiWHd1D7UTHhTKjWO112WhJJMP29BBllJ9D+3fcnHP9IaukOj2pFLw+AQ
 hZ8QGqUU+pqAJA4mni7h7PXo/Sd13WY6ireJl5tq9CM95Vu16RRlzlC
X-Developer-Key: i=quanyeyang@proton.me; a=ed25519;
 pk=9L9FrcvzMgxPaBRU6XV0EnqTgjDqVO596rQKSZ9qZoY=
X-Endpoint-Received: by B4 Relay for quanyeyang@proton.me/20260801 with
 auth_id=963
X-Original-From: Quanye Yang <quanyeyang@proton.me>
Reply-To: quanyeyang@proton.me
Content-Transfer-Encoding: 7bit

From: Quanye Yang <quanyeyang@proton.me>

process_one_client() used a single read() and write() before waiting
for hangup. A SOCK_STREAM read() can return a short count when the
payload is segmented, so the server echoed only part of the data and
then blocked on FIN.

The client keeps reading until it has the full length and only then
closes the socket. The two sides wait on each other and the test
hangs until SIGALRM.

The server does not know the payload length, so echo each chunk until
read() returns 0. Retry short writes, and accumulate nread/nwritten for
the existing sockopt checks. Cast those totals to uint64_t when passing
them to PRIu64 so the xerror() format is correct on 32-bit.

Fixes: ce9979129a0b ("selftests: mptcp: add mptcp getsockopt test cases")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/639
Signed-off-by: Quanye Yang <quanyeyang@proton.me>
---
Changes in v3:
- rebase on latest mptcp/export
- cast nread/nwritten to uint64_t for PRIu64 in xerror()
- Link to v2: https://patch.msgid.link/20261023-fix-mptcp-issue-639-v2-1-14a3d3746d2d@proton.me

Changes in v2:
- target mptcp-next instead of mptcp-net
- echo until hangup with goto; retry short writes; use nread/nwritten
- Link to v1: https://patch.msgid.link/20261017-fix-mptcp-issue-639-v1-1-0554d07ab8f8@proton.me
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 60 +++++++++++++----------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b8158a1198eb..367ff12bf6c7 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -640,7 +640,8 @@ static void connect_one_server(int fd, int pipefd)
 
 static void process_one_client(int fd, int pipefd)
 {
-	ssize_t ret, ret2, ret3;
+	size_t nread = 0, nwritten = 0;
+	ssize_t ret, n, w, off;
 	struct so_state s;
 	char buf[4096];
 
@@ -650,46 +651,53 @@ static void process_one_client(int fd, int pipefd)
 	ret = write(pipefd, "xmit", 4);
 	assert(ret == 4);
 
-	ret = read(fd, buf, sizeof(buf));
-	if (ret < 0)
+read_more:
+	n = read(fd, buf, sizeof(buf));
+	if (n < 0)
 		die_perror("read");
+	if (n == 0)
+		goto hangup;
+
+	for (off = 0; off < n; off += w) {
+		w = write(fd, buf + off, n - off);
+		if (w < 0)
+			die_perror("write");
+		if (w == 0)
+			xerror("write returned 0");
+	}
+	nread += n;
+	nwritten += n;
+	goto read_more;
 
-	assert(s.mptcpi_rcv_delta <= (uint64_t)ret);
+hangup:
+	assert(s.mptcpi_rcv_delta <= nread);
 
 	if (s.tcpi_rcv_delta)
-		assert(s.tcpi_rcv_delta == (uint64_t)ret);
-
-	ret2 = write(fd, buf, ret);
-	if (ret2 < 0)
-		die_perror("write");
-
-	/* wait for hangup */
-	ret3 = read(fd, buf, 1);
-	if (ret3 != 0)
-		xerror("expected EOF, got %lu", ret3);
+		assert(s.tcpi_rcv_delta <= nread);
 
-	do_getsockopts(&s, fd, ret, ret2);
-	if (s.mptcpi_rcv_delta != (uint64_t)ret + 1)
+	do_getsockopts(&s, fd, nread, nwritten);
+	if (s.mptcpi_rcv_delta != (uint64_t)nread + 1)
 		xerror("mptcpi_rcv_delta %" PRIu64 ", expect %" PRIu64 ", diff %" PRId64,
-		       s.mptcpi_rcv_delta, ret + 1, s.mptcpi_rcv_delta - (ret + 1));
+		       s.mptcpi_rcv_delta, (uint64_t)nread + 1,
+		       s.mptcpi_rcv_delta - ((uint64_t)nread + 1));
 
 	/* be nice when running on top of older kernel */
 	if (s.pkt_stats_avail) {
-		if (s.last_sample.mptcpi_bytes_sent != ret2)
+		if (s.last_sample.mptcpi_bytes_sent != nwritten)
 			xerror("mptcpi_bytes_sent %" PRIu64 ", expect %" PRIu64
 			       ", diff %" PRId64,
-			       s.last_sample.mptcpi_bytes_sent, ret2,
-			       s.last_sample.mptcpi_bytes_sent - ret2);
-		if (s.last_sample.mptcpi_bytes_received != ret)
+			       s.last_sample.mptcpi_bytes_sent, (uint64_t)nwritten,
+			       s.last_sample.mptcpi_bytes_sent - (uint64_t)nwritten);
+		if (s.last_sample.mptcpi_bytes_received != nread)
 			xerror("mptcpi_bytes_received %" PRIu64 ", expect %" PRIu64
 			       ", diff %" PRId64,
-			       s.last_sample.mptcpi_bytes_received, ret,
-			       s.last_sample.mptcpi_bytes_received - ret);
-		if (s.last_sample.mptcpi_bytes_acked != ret)
+			       s.last_sample.mptcpi_bytes_received, (uint64_t)nread,
+			       s.last_sample.mptcpi_bytes_received - (uint64_t)nread);
+		if (s.last_sample.mptcpi_bytes_acked != nread)
 			xerror("mptcpi_bytes_acked %" PRIu64 ", expect %" PRIu64
 			       ", diff %" PRId64,
-			       s.last_sample.mptcpi_bytes_acked, ret,
-			       s.last_sample.mptcpi_bytes_acked - ret);
+			       s.last_sample.mptcpi_bytes_acked, (uint64_t)nread,
+			       s.last_sample.mptcpi_bytes_acked - (uint64_t)nread);
 	}
 
 	close(fd);

---
base-commit: 77f43f9f764392db19087a46499b301ae629f437
change-id: 20261017-fix-mptcp-issue-639-96339a3d921a

Best regards,
--  
Quanye Yang <quanyeyang@proton.me>


