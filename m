Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254188;
	b=TRoQMs7kzuCQ7lx1FzbcNtrlTefGXFCTVbx/ClBMvQfaA8jufifju+N96TSjbwWM3tkI
	 ef6TGZmgjccgQI2oyYm4egZvrxkPCyt9QWPXfPSMVGl3rF+q9h91qBUSXXOKgs53O7Q/r
	 /6D/jTEmNyXgEXVWsrCDLhYqzFtbqNjfXZ3qQ68JD2/5C7pYZ4Jwsb4Qert3QTjvOAIcL
	 uk1eNGLY8FqpQdBhUb3iJXnXJGp7AxVl7MbQmJ4nveaESZChlkGqVBcHDrdeInLsJomqc
	 RcqViZIY4R5LXJBsPSWHWrKuvO7uOnQlZVxP/y1GAANJK+V4b22vMrQ/PakeiJTlFpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254188;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=PEZwwhiUvCNmEuUcG+vzYmc9W2vxSlt/Vn/YGDhEMBY=;
	b=I3enKfPvYV4pXbi0jq7FNuNwvZQqysOXDWsn1oDTO9Q0a9ax2t4ry/KhRAC4skG2uDjP
	 amjiddfzIDxpeoPHqrbKtJdYPfYnNNMkg26fXSucs6bDSqIxV5sPPM3yoPVM5sAVs2WBT
	 WrcQYL+uT01fx8ghOy6IBpOpnw4i2G0uApl6sZuXpTyYqCMJaDluieXDrImPEEsrZSUMI
	 /4F+LoFip78m1ZZyadtARyytnh+jWjuVNZC9MIXEzM7x+d3fl+0aDxQZYQOb89at6p7pm
	 kdHgUk4Yw/EX1GBmdOMPp0mp7oaNSh4jV7aAxNiH8PM7Y8kHaezZaPwUIBI5rN4WC1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TIT0qrfB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D85F606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TIT0qrfB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A7A1F000C0;
	Sat, 21 Nov 2026 09:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254188;
	bh=PEZwwhiUvCNmEuUcG+vzYmc9W2vxSlt/Vn/YGDhEMBY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TIT0qrfBzvF4uOUc/0ytRZ43eXJWZL9tVbLU+5N+rA+Tx+jwzRQhqfyqmakNog2yC
	 PfK+h2HxFUX+4vHKQl3QS8eGksy9GOSF5/rsG1BL5Zu+2h4fQf4kfGnN5Al6gxzcaZ
	 3zzaLIuHcKncAa/W3sUV8RMDnLYIlvSKgPbUAmcqtlAKF+Ai3wqM+p1hgGbQCB9zLy
	 BnnYPOsVMn7nc5587QnqYm9Fgr85a+xaev3gczF4cuMfb9lD5zRGveDJ24iqlZr97i
	 4qaSpuu5Pb15npJH+hjqDAQIE2nsRciwwYo99XOyeNdiTdVNyFp+VhM5gaeCFf7Pu4
	 TWNBzvatWJHXw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:54 +0100
Subject: [PATCH mptcp-net v2 56/62] selftests: mptcp: connect: trunc: wait
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-56-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2970; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=0RLcJEopSMRfxvOzmTtDqRvHPeGB9K5sSrOYzXnOaes=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ04sOBmqvYqjk/RxsNNnufjH/p6Sa+S5b+e+euLWjy
 q1Xrk6to5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCIl2xj+inzrkLj4Ler2Tu0+
 w0dGEyeanFsx+RJX1fZVDBWeWVOLkxj+qbg2TdxcPl3T5IlIlIl/650d2p9yw07alD/r5ZHKn13
 HBgA=
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

