Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A70315D5A
	for <mptcp@lists.linux.dev>; Fri, 12 Sep 2025 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686851; cv=none; b=CqpUGCf0kFehZ4NlbcMknEmvAHCJHZ0NL0y7Zbp0xak7EGQ/2Y8REsyFX0d8ubvrx2JBLnsrHmYqlqwDQGIatcP6zRFblepq4IiI1+8yGi57rJvngJ4Har2og9AHG6pbhTUMpjM0AL+teLFcEu9d/rxJJB2yL+3wlU1jVhmICDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686851; c=relaxed/simple;
	bh=mUNDXDJIOVbJUo86S+lfxiWVLoAz4O6y2Xreaei5Uis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hl2ewRiEh2fswwmQGAT6setn/hDdQqxxPgSbqiCcahJQAbRxqbxkgfZJxteOYxmWzbl3hdbfaOJ0d1d/Sp2naa3XFRpEkIKPnac+QmPhysvpDEK9E2W/NZNorI0GjW+pApRr2QE6HqiywPGet/rXRNQNP8FxWnIeuR82pLdAwXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9YPBOFa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9YPBOFa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A239C4CEF1;
	Fri, 12 Sep 2025 14:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757686851;
	bh=mUNDXDJIOVbJUo86S+lfxiWVLoAz4O6y2Xreaei5Uis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k9YPBOFapK6X2b1cWY8mDDpmuVVdJXJ63+4APPewGHdLwNwlcl1kNj/WSxtYr4DPp
	 zEod1O5MUKuf+Xu4Xn0gCBF225rAhaW60R5PslZd6DiG/791BWxWXLIHb23Npc2OVm
	 PSfraAEGOkwFykeV05vZSeh9b54FbXz34jy7aWcvE1r/Lb/CYvojKUs0yWYRUFv8jd
	 B0p0rXqQEjOZ7Tfr7gB4F8mjwbr2DjX95NOfKpziu+haFgzFenJbtx1qB0r2D28FD3
	 raJ1hxMFUCXyAsyriNeIwISzJuIEVmYrNEuMVjDmXmDmN1eys+8itMnkfR5yD8EeZK
	 D/IdG1UMG4//A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 6/9] selftests: mptcp: sockopt: handle INQ on server side
Date: Fri, 12 Sep 2025 22:19:53 +0800
Message-ID: <1235a810084875277744da045946fecf984aba02.1757686538.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1757686538.git.tanggeliang@kylinos.cn>
References: <cover.1757686538.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Integrate process_one_client() and get_tcp_inq() from mptcp_inq.c into
mptcp_sockopt.c, and rename process_one_client() to process_inq_client()
to handle TCP_INQ-specific operations on server side.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 155 +++++++++++++++++-
 1 file changed, 153 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index aadef8b0aea4..f5342903a80a 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -21,6 +21,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <sys/random.h>
+#include <sys/ioctl.h>
 
 #include <netdb.h>
 #include <netinet/in.h>
@@ -716,6 +717,153 @@ static void process_one_client(int fd, int ipcfd)
 	close(fd);
 }
 
+static void get_tcp_inq(struct msghdr *msgh, unsigned int *inqv)
+{
+	struct cmsghdr *cmsg;
+
+	for (cmsg = CMSG_FIRSTHDR(msgh); cmsg ; cmsg = CMSG_NXTHDR(msgh, cmsg)) {
+		if (cmsg->cmsg_level == IPPROTO_TCP && cmsg->cmsg_type == TCP_CM_INQ) {
+			memcpy(inqv, CMSG_DATA(cmsg), sizeof(*inqv));
+			return;
+		}
+	}
+
+	xerror("could not find TCP_CM_INQ cmsg type");
+}
+
+static void process_inq_client(int fd, int ipcfd)
+{
+	unsigned int tcp_inq;
+	size_t expect_len;
+	char msg_buf[4096];
+	char buf[4096];
+	char tmp[16];
+	struct iovec iov = {
+		.iov_base = buf,
+		.iov_len = 1,
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = msg_buf,
+		.msg_controllen = sizeof(msg_buf),
+	};
+	ssize_t ret, tot;
+
+	ret = write(ipcfd, "xmit", 4);
+	assert(ret == 4);
+
+	ret = read(ipcfd, &expect_len, sizeof(expect_len));
+	assert(ret == (ssize_t)sizeof(expect_len));
+
+	if (expect_len > sizeof(buf))
+		xerror("expect len %zu exceeds buffer size", expect_len);
+
+	for (;;) {
+		struct timespec req;
+		unsigned int queued;
+
+		ret = ioctl(fd, FIONREAD, &queued);
+		if (ret < 0)
+			die_perror("FIONREAD");
+		if (queued > expect_len)
+			xerror("FIONREAD returned %u, but only %zu expected\n",
+			       queued, expect_len);
+		if (queued == expect_len)
+			break;
+
+		req.tv_sec = 0;
+		req.tv_nsec = 1000 * 1000ul;
+		nanosleep(&req, NULL);
+	}
+
+	/* read one byte, expect cmsg to return expected - 1 */
+	ret = recvmsg(fd, &msg, 0);
+	if (ret < 0)
+		die_perror("recvmsg");
+
+	if (msg.msg_controllen == 0)
+		xerror("msg_controllen is 0");
+
+	get_tcp_inq(&msg, &tcp_inq);
+
+	assert((size_t)tcp_inq == (expect_len - 1));
+
+	iov.iov_len = sizeof(buf);
+	ret = recvmsg(fd, &msg, 0);
+	if (ret < 0)
+		die_perror("recvmsg");
+
+	/* should have gotten exact remainder of all pending data */
+	assert(ret == (ssize_t)tcp_inq);
+
+	/* should be 0, all drained */
+	get_tcp_inq(&msg, &tcp_inq);
+	assert(tcp_inq == 0);
+
+	/* request a large swath of data. */
+	ret = write(ipcfd, "huge", 4);
+	assert(ret == 4);
+
+	ret = read(ipcfd, &expect_len, sizeof(expect_len));
+	assert(ret == (ssize_t)sizeof(expect_len));
+
+	/* peer should send us a few mb of data */
+	if (expect_len <= sizeof(buf))
+		xerror("expect len %zu too small\n", expect_len);
+
+	tot = 0;
+	do {
+		iov.iov_len = sizeof(buf);
+		ret = recvmsg(fd, &msg, 0);
+		if (ret < 0)
+			die_perror("recvmsg");
+
+		tot += ret;
+
+		get_tcp_inq(&msg, &tcp_inq);
+
+		if (tcp_inq > expect_len - tot)
+			xerror("inq %d, remaining %d total_len %d\n",
+			       tcp_inq, expect_len - tot, (int)expect_len);
+
+		assert(tcp_inq <= expect_len - tot);
+	} while ((size_t)tot < expect_len);
+
+	ret = write(ipcfd, "shut", 4);
+	assert(ret == 4);
+
+	/* wait for hangup. Should have received one more byte of data. */
+	ret = read(ipcfd, tmp, sizeof(tmp));
+	assert(ret == 6);
+	assert(strncmp(tmp, "closed", 6) == 0);
+
+	sleep(1);
+
+	iov.iov_len = 1;
+	ret = recvmsg(fd, &msg, 0);
+	if (ret < 0)
+		die_perror("recvmsg");
+	assert(ret == 1);
+
+	get_tcp_inq(&msg, &tcp_inq);
+
+	/* tcp_inq should be 1 due to received fin. */
+	assert(tcp_inq == 1);
+
+	iov.iov_len = 1;
+	ret = recvmsg(fd, &msg, 0);
+	if (ret < 0)
+		die_perror("recvmsg");
+
+	/* expect EOF */
+	assert(ret == 0);
+	get_tcp_inq(&msg, &tcp_inq);
+	assert(tcp_inq == 1);
+
+	close(fd);
+}
+
 static int xaccept(int s)
 {
 	int fd = accept(s, NULL, 0);
@@ -756,10 +904,13 @@ static int server(int ipcfd)
 	alarm(15);
 	r = xaccept(fd);
 
-	if (inq)
+	if (inq) {
 		do_setsockopt_inq(r);
 
-	process_one_client(r, ipcfd);
+		process_inq_client(r, ipcfd);
+	} else {
+		process_one_client(r, ipcfd);
+	}
 
 	close(fd);
 	return 0;
-- 
2.48.1

