Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557710;
	b=qLMt72/AeIJtdywxftRh42jktzTS6oqjMQ+Ko7wBmAaCy+Uiza7wlQ8MMabY/SRutBMf
	 BwL6r8IyiKokwgclAfcxTDVJqzffXu3c1a8UQ7NHVhwSU2bwb7YPVAzA5Eg/CRPANG1aq
	 /xGL0JQdu3zF4FuMr/SWQpDZNL8S0e+KwbubPV/7qWges0nc5rBubn3ZODpaeuzqIx0bh
	 WUJHkSPp0pW0W1ht5rkNgQv+OCPdTdKTt0hEPIX/+K/K9BX4otgT4lJX3mh/KcBfcqOK4
	 Z1b+nK9i3x++sTUnLuAbJPnk5/WlBPUkmwKUvs1ev8DuZRBEjEDJLZs5043tQmfzZmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557710;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=PEZwwhiUvCNmEuUcG+vzYmc9W2vxSlt/Vn/YGDhEMBY=;
	b=RKHQHW3XrG3mG/HHrBgugrZIjeV9nLiofCgLK/zNSbQUEXschCCqoYJ8CdtG8jV2tdgb
	 KCFqRBpKJQOeA02NCjqoRx7kpAvBe1JFReKaO+SChkX5DrLHM0HUz2mU2zYhtouRdOvWa
	 rgC5JaNy5Cxui5WXWSTxesAAwy13C8ZjuywuM+rL5ssWyYzMiBR5dMG/j/gBuXbzIKHL9
	 LGHPSWlxzDAusNlcQapKi8Hf0MDfErye8ycOQ0YpxW2/bHzzTEv/a607OnATwWwZC1fly
	 xV/JpODHGMdpiZzdBbLaDHxscyOfVN8QKFX91nbfXSz3CvGNcEwydIqaRgFdrWXQ2RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C9H7yoVs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3D0606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C9H7yoVs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5731F000C4;
	Tue, 24 Nov 2026 22:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557709;
	bh=PEZwwhiUvCNmEuUcG+vzYmc9W2vxSlt/Vn/YGDhEMBY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=C9H7yoVsPoMadSXfwGmWOPNyrKSUSVXpyh7/+S2kqhm3pCpH6JbLD6NTqpZ8Nji0/
	 GNY22t8IsFYkP1zwsCnZIhU00CE5DIDlDlBLAb25QdKfazRlhcHYQ6xpXQJOGid9SM
	 x5GPHjaj+4iBOiQNEX0thpSoDN6XnjJolmkp5DF/279hjsc0I4bhApYjf233Ex2VuP
	 +aWTiD2q7liZ3qk9AX4++A+aERwoM4c+I8H53mS5sLf98cNSE3UjZk3ZLk2C5cMB8k
	 ZArpJIIvBi01a8QOuK5nZW6SDrYWv6UZEEYqKsmm0faQ+1pPpokiMV2TW4I2qsx+r9
	 99p1lk/esD5ww==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:59 +0100
Subject: [PATCH mptcp-net v3 42/50] selftests: mptcp: connect: trunc: wait
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-42-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2970; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=0RLcJEopSMRfxvOzmTtDqRvHPeGB9K5sSrOYzXnOaes=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOAUTMq/v+2DTfPH319DwZK5jE18fZJkVsEXZ37bH8
 mPe5FvTO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbyho+RYa1F4ss08Rfia3d2
 dT4sXOGbtqwya4b++xt9Va6hoe/XL2P4n1ctmDwnxH7KVEO/1BtX9y1oiE4uD7070X3jbO8Pv8K
 P8wIA
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

