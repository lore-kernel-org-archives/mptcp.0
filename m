Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795809730;
	b=CEyjNW1tf/0GdAlcooQ2puunB34CxwungjL3+HqOwcSSahFcn/EeEOp5IyXe4AbmKJ2x
	 Y75Z6O4ICd7hoYpHGdS5Rnc2hPauy3hp5wocqOTSUUUWyZ7FaILZ5GPrY+iezRlk4aWwC
	 Y6TZOTuPLBwssqU4xjx5rTqqcTX28ECC67IpLqHW/gRY744ZBi4/mKPJ9KX388X1+kway
	 pxKO3oNbBfPA6e5xvEQJtDRh8ADDbZeQz9YbhGsp5X0NXHJUsAOdCipImbXSnXHjAy51e
	 YSM78dYLpld8Kn8rqrjwOPZ9dJ/mgZvHxo/nQlocPlF9oxXNmtFWoMLtm4Kb0sFtBVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795809730;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=PEZwwhiUvCNmEuUcG+vzYmc9W2vxSlt/Vn/YGDhEMBY=;
	b=2YQZ9c1sUdgW5ev0hj+SN6Hz4StyBEWhqmvFaYTOOTP7/vzptyWqDoftaIIWbeDS7HRB
	 UAjLX4QQCyUJVkELH21FZsG/wxzvK7wKHQ7McmaEzihKAr4QCwTZneEryth6ifecMOIMy
	 7gZ4/btXOhkQkWKWgw2O3SUXhfNmhSFRmL0a2PQ1PNZQopOi61hpfJE15wiNxs99eJhTw
	 +/n3JyQJybbUMknkhRfQYaFOgsPlJbcOzGic4Xzstn+z03ZFUgww4UG33rdUF3mSjLSz8
	 zeAsHUl4tV6uQRvqwY8ABq/phw9f06WKEeBpW+htzq89ijzNUlz14Iu/cf7wujf765w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ex2ijy52;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3A8606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 20:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ex2ijy52
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E27B1F00893;
	Fri, 27 Nov 2026 20:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795809729;
	bh=PEZwwhiUvCNmEuUcG+vzYmc9W2vxSlt/Vn/YGDhEMBY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ex2ijy52raYtaHbvxwlLJXxbBNdDGHcgvbiGdQNNrOotB+8EErPB0+EvHvd7UBjq1
	 v4rM7AcIXSBoKncHaUNAc9hRttMCybyZ/vfj2ZYp4g68UsstBRu5/zMAdZin/uALB5
	 EEuPrLhTl/XhijkCjoa6U1badTjO2mQfcSVJVukq55FCKb4yJgfiVz4HBRgGvxRLUJ
	 4ygF4dPJQ3c3btqoQmdvzHtdhPzvfx0AXX9Ybn0Wyn6V+G4FGd9mA5IiBycfLKvy7E
	 z4yRHgsBtST3Ra1O/DV7Zhj4esuc4aNj2C7Qyk56NnI8TuvU5/9+UtOaeuknePGbYE
	 h7WpxCdGJ2a1A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 27 Nov 2026 21:01:31 +0100
Subject: [PATCH mptcp-net v4 07/20] selftests: mptcp: connect: trunc: wait
 for acks
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-mptcp-cmason-fixes-v4-7-3f393ea8c48d@kernel.org>
References: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
In-Reply-To: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2970; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=0RLcJEopSMRfxvOzmTtDqRvHPeGB9K5sSrOYzXnOaes=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLI5H64pz5+y79YML4dApvwX6WKp17Z+PbmCJS9SyIT/5
 Cn5+6rzO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACay0oGRYb9VhwZz0b2rT7/w
 ybSdmtEnMWmdTz2f9qLvjz62xPaVSDAybAuuPJhmu7hNQVd+qlLY2av13o3rry78W6BdpPNm8+s
 /HAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The "fastclose server test" subtest from mptcp_join.sh was still failing
from time to time, because the client output file didn't have the
expected size, e.g. on NIPA:

  [FAIL] file received by client output file has wrong size (866, 1024)
  Server ns stats (...)
  (...)
    TcpExtTCPOrigDataSent           3
    TcpExtTCPDelivered              2

Here, the server sent 3 data segments only, the last one not acked yet,
and the client received all the data from these segments. The rest of
the data, already written by the server, was still queued, e.g. held by
Nagle, waiting for the last segment to be acked. But the server then
closed its socket, with data from the client still to read, as expected
here: an MP_FASTCLOSE is then sent, and the data still queued is
discarded, as with a TCP reset.

To fix this, wait for the written data to be acked, with SIOCOUTQ,
before stopping in the truncate mode, so before closing the socket. A
timeout is reported: it would look like this issue otherwise.

This issue has been confirmed on a debug kernel, where this subtest
failed a few times: each time, the client didn't have any data left in
its queues, and the data received matched the data in the segments sent
by the server. With this patch, it no longer failed.

Fixes: 6bf41020b72b ("selftests: mptcp: update and extend fastclose test-cases")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for a flaky selftest
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 24 ++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 8c788977e594..861fa2bd70d0 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -643,6 +643,26 @@ static void shut_wr(int fd)
 	shutdown(fd, SHUT_WR);
 }
 
+/* the data still queued would be dropped by a reset: wait for its ack */
+static void wait_for_ack(int fd)
+{
+	struct pollfd pfd = { .fd = fd };
+	int i, queued;
+
+	for (i = 0; poll_timeout < 0 || i < poll_timeout; i += 10) {
+		if (quit || ioctl(fd, SIOCOUTQ, &queued) < 0 || queued <= 0)
+			return;
+
+		/* e.g. reset: the data will not be acked */
+		if (poll(&pfd, 1, 0) > 0 && (pfd.revents & POLLERR))
+			return;
+
+		usleep(10000);
+	}
+
+	fprintf(stderr, "timeout while waiting for the data to be acked\n");
+}
+
 static int copyfd_io_poll(int infd, int peerfd, int outfd,
 			  bool *in_closed_after_out, struct wstate *winfo)
 {
@@ -768,8 +788,10 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 		}
 
 		if (cfg_truncate > 0 && total_wlen >= cfg_truncate &&
-		    total_rlen >= cfg_truncate)
+		    total_rlen >= cfg_truncate) {
+			wait_for_ack(peerfd);
 			break;
+		}
 	}
 
 	/* leave some time for late join/announce */

-- 
2.55.0

