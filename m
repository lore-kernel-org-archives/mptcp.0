Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792766793;
	b=T70ThkThJm0H3rQpWAwxhdFVaCZtbssiJfMHOgDA0ee+VsKeL5a/1OwC+I5K0D9E8OJm
	 A+715bTDVa2zqpXrTaq7Gnf6CbUL0Aj6hWtQuifQnM5U1UQuO/H5PKgNnK6us++ICNY4T
	 hDKTnQY2KQ/UkOEgmOzpKN70vaNhRVPVQ0HA5KC5WC716FTUzkrnjWH7sVbz+rSHqLN80
	 eaCLOtoYkWSBBON7Sy+df99WfHQqShFQ1WrXyATlUV812Pyp/t45wLH7riEehoRCRHyPD
	 fbyfS+xBLuMMwvyRw0v2pXsHk7EkBvrTQF9C1FRQgx8lSWSMoPLqjc3Cx+jh3c7uilw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792766793;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=G4Z4rtFsjtXFqz4ZYaXAo7VrVRocMEtqqJZfM7rlH9k=;
	b=VHkqbAm9kKehCqN1V/I9kb9QLIZesQMcayD5hrcm1AXAwicU4ieRa7F3B8LpWlLx74i9
	 wWe4N/1HerDI29Iwqj9jUpZAWSYBEbtFAW5tA7wX9zfoX1fepkacPvG4Dvz0Y5EHxte6O
	 m4OPOp/ibUSCK4zW/6obYj1D1o5Ghoe0Bi73qriW9k6kNMpPFyC6iyVjExvLnzxOX71yP
	 4491X0EfWqbubTBlGdkuoBUUzIcC24tHeFcKN+N6kvNPZXkCeQUPe3kAgWX5rh+yrNz3m
	 Dp0ph3km4Jrc2RfIYqzANZXwcfDINHQDA7rr4eNUtw6kM1DaWYwEhLCqHeL4KmqrIIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tva5fBNi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DE2606A31B
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tva5fBNi
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792766792;
	b=LWIuiz3xamUVTOAVwT0dNUTNVb1CrnkvcwiVLNKa4f92hxEa5CmeJ1F9rzB+IFXkIB1K
	 7Od4TXXsKGxfa5kxu9G9rSP9OX15OWFjXYFPhrpEef8uyAde8Y6NDVk2f5KbnDHAiguxF
	 Y6UGyCqx2qjX5fOw1O9SBcZgmHIOIFWTRvZLNT3IyE7YYzqbFkEYQZR7tlp05d0gJOgsY
	 sC8dZbnZ/qXUbC7Qpw9HViyjAJ+WySKhFaWUfCkvziI3XJjWvL+iFbSfd6xnorZd8PHA+
	 5/yEjYonN3QsWHR3MYZkiZHWT++xRKro8jCoT1/Se1axzr386AN7u4jmC3dKDrRA9Zw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792766792;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=G4Z4rtFsjtXFqz4ZYaXAo7VrVRocMEtqqJZfM7rlH9k=;
	b=M3Jvnr7yeuVCOnLsq4Kcd0516phEXrBGqgSHA1y3gCI6hU28KsmiDlMEib5VhynIYGXd
	 8WpW0KGwLUSdNjcy8lHZ2DtGpazorLtHSMYHlrNDSqCQQSGrsxXnvgDYtqwf7Xu1ctGn1
	 BxuPeoH7y7WJpv1eytxs1jcXPFB8VMAmzVVGd+H10RF5YuZkk9boqwbGfu5KEFrgoprxR
	 Hur87j1/oKxBzjV2NGAzh2eLyn+neZWNZjxdC2mRh/t6TEnpD4XIQkjzVp4nQdP/Spp/u
	 IcJap7an5J5k5oyk4MO8/Zm1O8uoDd00/JkpeNCruXV7NK3131GaubYG2yDkfbtphQw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D34DB1F01825
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 14:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792766792;
	bh=G4Z4rtFsjtXFqz4ZYaXAo7VrVRocMEtqqJZfM7rlH9k=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Tva5fBNi+caf5VfVDMbSbBQ4DbSbZW9ixj3mwLdC2iJ5TE39aWvAKqGERMBBDwA8A
	 t+UugdDxnSm7ITi4H15JLjY17z2mx4kvrQagvKboIZlI04vJPjQnifEk7EJ5+/lqv7
	 ZsKdV5txk7AECBWJIZ9rhCrA3KpgAGU5k9TfiAnZKdrC3fu4u6r2k+oOak4hXD1yZ4
	 6sVwwdUX0y7cacJbGLD/An5CM0Hz8JGQhnGx2SLBQWqlUYDRL+u9kt/j6SMWU5fgBq
	 Xc/5Z7B7ruT8oZfk+82h9j8zBrm599mn2IQQfgrr8V65VSOqOeHWlfeFdkz04LqYeY
	 xBKXL95WvNBPg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2E7EA4455B
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 14:46:31 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Date: Fri, 23 Oct 2026 07:46:28 -0700
Subject: [PATCH mptcp-next v2] selftests: mptcp: sockopt: echo until EOF on
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
Message-Id: <20261023-fix-mptcp-issue-639-v2-1-14a3d3746d2d@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32OyQ6CMBRFf8W8tc90kKGu/A/DosBDagJt2kIwh
 H+3wN7lzT13WCGQNxTgcVnB02yCsWMS4nqBptfjm9C0SYNgIueMF9iZBQcXG4cmhIkwlwpVLqX
 SslWCa0hJ5ylhR+sLTnikJUJ1emGqP9TEvXanexOi9d/jwsyPzN+1mSNHlmX3lhW6Lrvy6byNd
 rwNBNW2bT+CCqIH1AAAAA==
X-Change-ID: 20261017-fix-mptcp-issue-639-96339a3d921a
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: 
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792766790; l=4572;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=YFBOuJzzXnClbJR18ebSuZTHm9Q2G8VNkK/qk0+YwCo=;
 b=2DCnDe3eQBEdXXw5WJ4YIEVv1hcxesRVTcOX7vCIIOAo/4ohN8fI3DYfVMCXmN2E9SKbePm9E
 kW0YvEDBm75Dy/M0mhGoY5c1VYZh6xNA5kan6vtgG+XubZJ4SKCGah2
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
the existing sockopt checks.

Fixes: ce9979129a0b ("selftests: mptcp: add mptcp getsockopt test cases")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/639
Signed-off-by: Quanye Yang <quanyeyang@proton.me>
---
Changes in v2:
- target mptcp-next instead of mptcp-net
- echo until hangup with goto; retry short writes; use nread/nwritten
- Link to v1: https://patch.msgid.link/20261017-fix-mptcp-issue-639-v1-1-0554d07ab8f8@proton.me
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 60 +++++++++++++----------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b6e58d936ebe..deb239058e79 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -638,7 +638,8 @@ static void connect_one_server(int fd, int pipefd)
 
 static void process_one_client(int fd, int pipefd)
 {
-	ssize_t ret, ret2, ret3;
+	size_t nread = 0, nwritten = 0;
+	ssize_t ret, n, w, off;
 	struct so_state s;
 	char buf[4096];
 
@@ -648,46 +649,53 @@ static void process_one_client(int fd, int pipefd)
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
+			       s.last_sample.mptcpi_bytes_sent, nwritten,
+			       s.last_sample.mptcpi_bytes_sent - nwritten);
+		if (s.last_sample.mptcpi_bytes_received != nread)
 			xerror("mptcpi_bytes_received %" PRIu64 ", expect %" PRIu64
 			       ", diff %" PRId64,
-			       s.last_sample.mptcpi_bytes_received, ret,
-			       s.last_sample.mptcpi_bytes_received - ret);
-		if (s.last_sample.mptcpi_bytes_acked != ret)
+			       s.last_sample.mptcpi_bytes_received, nread,
+			       s.last_sample.mptcpi_bytes_received - nread);
+		if (s.last_sample.mptcpi_bytes_acked != nread)
 			xerror("mptcpi_bytes_acked %" PRIu64 ", expect %" PRIu64
 			       ", diff %" PRId64,
-			       s.last_sample.mptcpi_bytes_acked, ret,
-			       s.last_sample.mptcpi_bytes_acked - ret);
+			       s.last_sample.mptcpi_bytes_acked, nread,
+			       s.last_sample.mptcpi_bytes_acked - nread);
 	}
 
 	close(fd);

---
base-commit: a22035be824449c4921ec406f6383089016a628c
change-id: 20261017-fix-mptcp-issue-639-96339a3d921a

Best regards,
--  
Quanye Yang <quanyeyang@proton.me>


