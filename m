Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9E32FF176
	for <mptcp@lists.linux.dev>; Tue, 26 Aug 2025 09:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200600; cv=none; b=VoHwE7pEAdh9J2eqMEK5Yr9TioMOjlh9e3gEAQd7anXTalK0sYywogP+3c6NhXOC2kSY1fxARcF1TFD70XGjbQJ03TUVzCsDgd9b4rokJOT0iE9Cs7xTuG17Vy9u6WcpQri19rKajThlyNe8g8yyACoHHGLfhJ3WwZ6gn6WCiLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200600; c=relaxed/simple;
	bh=NwxROwi9cYQ5TFKU7gsM3OYl4s2YMtciGB1z2OF3GSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAx+CUa4VJzKQm7R9B7EcpB1Ot51XQdeXwT7Lz5DPaGppAgzcq59cBJiWsMyXtqFom3/v7K5G0ffo6zw9EzjkHfhYOF2zQA21W60ofJZxn4mTekz88wRapYNIqZzk+1tBYPmcWk7RcBiaus9ENn8MJcL72beLzgBlti316p/lvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zx0sEINJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zx0sEINJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB65C116C6;
	Tue, 26 Aug 2025 09:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756200598;
	bh=NwxROwi9cYQ5TFKU7gsM3OYl4s2YMtciGB1z2OF3GSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zx0sEINJw40+FXlvLC1rzcDKF8fRXYlEAmUwuvf7FPhTzaU4hTV2dTlTAz2lNCG46
	 dBs5iPsMVrZltgl+7OJtNUmCIKSBun4eWIj2kQA0X+wJn8PtKkGHvlw5jK7KbKB88C
	 QqPmdrsSwQvnHLEUsF2N60f/Wpc8jBQPlxw+Mu6CTkNmwlLHBzX0BmSNQZmc/wO+S1
	 ++wBO4Q3hfPV8YC9XeBbbiVmga1OLgM+Iv9HUKg6Lgc+j2JJBYqXDTcifFvPh3SMJe
	 qh92auR20hftGW6f+gyThNRkya/ACFWScflwfItD+uiqjmnnCrilIwOnaHBR8s6a0Y
	 Mr752KP2H4v8g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 08/14] selftests: mptcp: sockopt: read one byte first
Date: Tue, 26 Aug 2025 17:29:32 +0800
Message-ID: <fdd5fc06975f48b5ed6e2bfe35f70871c4fdf7a4.1756200029.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1756200029.git.tanggeliang@kylinos.cn>
References: <cover.1756200029.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Modifies data reading to first read one byte, then the remainder, ensuring
accurate TCP_INQ validation and data consistency checks.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 28 ++++++++++++-------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 71cb311fcc50..675ed2dcee9f 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -642,18 +642,18 @@ static void connect_one_server(int fd, int unixfd)
 		}
 
 		total += ret;
-	} while (total < len);
+	} while (total < len - 1);
 
-	if (total != len)
-		xerror("total %lu, len %lu eof %d\n", total, len, eof);
+	if (total != len - 1)
+		xerror("total %lu, len - 1 %lu eof %d\n", total, len - 1, eof);
 
-	if (memcmp(buf, buf2, len))
+	if (memcmp(buf + 1, buf2, len - 1))
 		xerror("data corruption");
 
 	if (s.tcpi_rcv_delta)
 		assert(s.tcpi_rcv_delta <= total);
 
-	do_getsockopts(&s, fd, ret, ret);
+	do_getsockopts(&s, fd, ret, ret + 1);
 
 	if (eof)
 		total += 1; /* sequence advances due to FIN */
@@ -685,6 +685,14 @@ static void process_one_client(int fd, int unixfd)
 	ret = write(unixfd, "xmit", 4);
 	assert(ret == 4);
 
+	/* read one byte, expect cmsg to return expected - 1 */
+	ret = recvmsg(fd, &msg, 0);
+	if (ret < 0)
+		die_perror("recvmsg");
+
+	if (inq && msg.msg_controllen == 0)
+		xerror("msg_controllen is 0");
+
 	iov.iov_len = sizeof(buf);
 	ret = recvmsg(fd, &msg, 0);
 	if (ret < 0)
@@ -699,9 +707,9 @@ static void process_one_client(int fd, int unixfd)
 	if (ret2 < 0)
 		die_perror("write");
 
-	do_getsockopts(&s, fd, ret, ret2);
-	if (s.mptcpi_rcv_delta && s.mptcpi_rcv_delta != (uint64_t)ret)
-		xerror("mptcpi_rcv_delta %" PRIu64 ", expect %" PRIu64, s.mptcpi_rcv_delta, ret, s.mptcpi_rcv_delta - ret);
+	do_getsockopts(&s, fd, ret + 1, ret2);
+	if (s.mptcpi_rcv_delta && s.mptcpi_rcv_delta != (uint64_t)ret + 1)
+		xerror("mptcpi_rcv_delta %" PRIu64 ", expect %" PRIu64, s.mptcpi_rcv_delta, ret + 1, s.mptcpi_rcv_delta - ret);
 
 	/* be nice when running on top of older kernel */
 	if (s.pkt_stats_avail) {
@@ -709,9 +717,9 @@ static void process_one_client(int fd, int unixfd)
 			xerror("mptcpi_bytes_sent %" PRIu64 ", expect %" PRIu64,
 			       s.last_sample.mptcpi_bytes_sent, ret2,
 			       s.last_sample.mptcpi_bytes_sent - ret2);
-		if (s.last_sample.mptcpi_bytes_received != ret)
+		if (s.last_sample.mptcpi_bytes_received != ret + 1)
 			xerror("mptcpi_bytes_received %" PRIu64 ", expect %" PRIu64,
-			       s.last_sample.mptcpi_bytes_received, ret,
+			       s.last_sample.mptcpi_bytes_received, ret + 1,
 			       s.last_sample.mptcpi_bytes_received - ret);
 		if (s.last_sample.mptcpi_bytes_acked != ret)
 			xerror("mptcpi_bytes_acked %" PRIu64 ", expect %" PRIu64,
-- 
2.48.1

