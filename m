Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9153CE497
	for <mptcp@lists.linux.dev>; Fri, 10 Jul 2026 08:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673979; cv=none; b=JXJJ9R1CJCgt51tu86Icv2aCB8ajPKtQgrqsHoKYg4br5GcSESSxVwA4SLm5r23AY6UNtD2tq5B+/60NFP1FwPsuheopcDjFAuMHExOWJlmvqDUFBLL6fpCxDS+Eh1PhVAZ5VyOHgkSbJvk2p0nVsc6jiCuM4UHAr4MtgrOR9gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673979; c=relaxed/simple;
	bh=53h4Mt5WAYNzmBKihqoyepbM+3rtvMNhbT7rt125pcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IkVKi1HHswer6X+T8mNRBn3j0E0tR8CbJ0zHLe8LQorFxGyxFNz4kKCOcf8bXUCsrmSQ+EU7v0GeiXOUdVzPwaxVBJTCU6LC5P1ixyRAapIPUoiZ9zaOf7BJE/g6LsS8uKVG9PMju5liuT2vqKYZZl48bgMtpzeo1xm3gRkep9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5PmRiMb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5PmRiMb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A5F1F00A3A;
	Fri, 10 Jul 2026 08:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783673977;
	bh=3ZVZ+WuGBQtQB9i5kiP9Uaa3mDCnJKynM8HoZ4bLa4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e5PmRiMb/Zu03vJMM6JsbPr5VHbzmM948ULU32EeZclrQ7NR0InjfaXBIfjDl6w+B
	 9TzrYMLPlWFNcNDQu8mN3YEj55EbG8P7UVqk5nrg8GDkXanddVvhrBnEFvaraorzRa
	 tNT8rWVNrignyVbuUHNcQ7jb7Dv+UXmR8htSqhylDFvoQwGvyPbDXYcUNoSIuS7yBR
	 WLvdMuauMbziS03Eh1z5ey8kIYykrGFor7LUQqHgXc/ZgGqsM/FpKcFTTv/avkImI/
	 5k3w/SoWh8r99VyKgX+e0ABSH90Z4NRgTlKAeujs7Bs+ICt7KU4CpRXZXXRx2Sr/fK
	 vRycwYUbFe6Gw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 09/10] selftests: mptcp: sockopt: add get_tcp_inq helper
Date: Fri, 10 Jul 2026 16:59:12 +0800
Message-ID: <d7086fd8de594ccb1a4448b63e31d6fa4eef4859.1783673158.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783673158.git.tanggeliang@kylinos.cn>
References: <cover.1783673158.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add check_tcp_inq() helper to extract and verify TCP_CM_INQ values from
control messages, ensuring correct in-queue data tracking during transfers.

These codes are from mptcp_inq.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 53852b44cfeb..ac209070e8f2 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -762,8 +762,28 @@ static void connect_one_server(int fd, int unixfd)
 	close(unixfd);
 }
 
+static void get_tcp_inq(struct msghdr *msgh, unsigned int *inqv)
+{
+	struct cmsghdr *cmsg;
+
+	for (cmsg = CMSG_FIRSTHDR(msgh); cmsg;
+	     cmsg = CMSG_NXTHDR(msgh, cmsg)) {
+		if (cmsg->cmsg_level == IPPROTO_TCP &&
+		    cmsg->cmsg_type == TCP_CM_INQ) {
+			if (cmsg->cmsg_len < CMSG_LEN(sizeof(*inqv)))
+				xerror("TCP_CM_INQ cmsg_len too small: %u",
+				       cmsg->cmsg_len);
+			memcpy(inqv, CMSG_DATA(cmsg), sizeof(*inqv));
+			return;
+		}
+	}
+
+	xerror("could not find TCP_CM_INQ cmsg type");
+}
+
 static size_t client_huge_transfer(int fd, int unixfd)
 {
+	unsigned int tcp_inq;
 	char msg_buf[4096];
 	size_t expect_len;
 	ssize_t ret, tot;
@@ -802,6 +822,14 @@ static size_t client_huge_transfer(int fd, int unixfd)
 			xerror("unexpected EOF in huge recv");
 
 		tot += ret;
+
+		get_tcp_inq(&msg, &tcp_inq);
+
+		if (tcp_inq > expect_len - tot)
+			xerror("inq %d, remaining %zu total_len %d\n",
+			       tcp_inq, expect_len - tot, (int)expect_len);
+
+		assert(tcp_inq <= expect_len - tot);
 	} while ((size_t)tot < expect_len);
 
 	ret = write(unixfd, "shut", 4);
@@ -821,12 +849,18 @@ static size_t client_huge_transfer(int fd, int unixfd)
 		die_perror("recvmsg");
 	assert(ret == 1);
 
+	get_tcp_inq(&msg, &tcp_inq);
+
+	/* tcp_inq should be 1 due to received fin. */
+	assert(tcp_inq == 1);
+
 	return tot + 1;
 }
 
 static void process_one_client(int fd, int unixfd)
 {
 	ssize_t ret, ret2, ret3;
+	unsigned int tcp_inq;
 	char msg_buf[4096];
 	struct so_state s;
 	size_t expect_len;
@@ -878,6 +912,16 @@ static void process_one_client(int fd, int unixfd)
 	if (ret < 0)
 		die_perror("recvmsg");
 
+	if (inq) {
+		if (msg.msg_controllen == 0)
+			xerror("msg_controllen is 0");
+
+		get_tcp_inq(&msg, &tcp_inq);
+
+		/* expect cmsg to return expected - 1 */
+		assert((size_t)tcp_inq == (expect_len - 1));
+	}
+
 	iov.iov_base = buf + 1;
 	iov.iov_len = sizeof(buf) - 1;
 	msg.msg_controllen = sizeof(msg_buf);
@@ -885,6 +929,15 @@ static void process_one_client(int fd, int unixfd)
 	if (ret < 0)
 		die_perror("recvmsg");
 
+	if (inq) {
+		/* should have gotten exact remainder of all pending data */
+		assert(ret == (ssize_t)tcp_inq);
+
+		/* should be 0, all drained */
+		get_tcp_inq(&msg, &tcp_inq);
+		assert(tcp_inq == 0);
+	}
+
 	/* add the first byte */
 	ret += 1;
 
@@ -907,6 +960,11 @@ static void process_one_client(int fd, int unixfd)
 	if (ret3 != 0)
 		xerror("expected EOF, got %lu", ret3);
 
+	if (inq) {
+		get_tcp_inq(&msg, &tcp_inq);
+		assert(tcp_inq == 1);
+	}
+
 	do_getsockopts(&s, fd, ret + r, ret2);
 	if (proto_tx == IPPROTO_MPTCP && proto_rx == IPPROTO_MPTCP &&
 	    s.mptcpi_rcv_delta != (uint64_t)ret + r + 1)
-- 
2.53.0

