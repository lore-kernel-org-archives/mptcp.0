Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584F823B62B
	for <mptcp@lists.linux.dev>; Sat, 11 Jul 2026 03:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783741487; cv=none; b=l7etUMuCAtIpfloJOKA8mjUN5PqC6vOsoXtuspj+smBMM4iMz9K+XmjI5kybdk9s28oHWYPFGaM1btNGPiF1M1KludKpGMLfEbcX8jubV0pCQ5wfFUxlw6LWKOn1M82UHTcpcGEZBr41egxJT09wOKrbtWxgwuPxDgZkFBJoxcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783741487; c=relaxed/simple;
	bh=kYxObnbQHJCltpq35EYk5kkH+0SrQJO7FXN6ahRWGVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D70/at0BjDU9imHO4NDDGfNQv4qERUcE/lXWbRYpZXsjM7F3Wo8TkNNNKp8U5o0zwHm+ZeEbMDOsttQNLYDS0zJPoQGw/pF0DTmJ/VC58e+0j94ypwBhP8yhFLXgh7cluocsCGeT3utBggSGWlh1iRIGebjpnqfuSbEjpGmG4IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxtSGf+a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxtSGf+a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791921F00A3D;
	Sat, 11 Jul 2026 03:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783741486;
	bh=QIugCy0SGsMILygQETBQ10PPYnfQOJ/QNqCj7Cbwb24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IxtSGf+acfn26CkhmwIqyAEs6OiOzOhJv42l3PQi7/MMLLDkZpp8CPoUg18Hjn253
	 SkewZHTfCIlCLOR1KS/LF0dFHp1Sk9Y9iGe4vZkaA34oogN7S3yExFxbGZpIepC8m7
	 c7CeaOnssWzKjA5dWEA5uHm/ZgXInbK3rCrnLGqkoGRf+GbJ6w7Y+9Vk8y6A0tkJFF
	 XnDwAay02zrFOW9shrdItM8pAAsn9qFhs/i4yA7p/I9nDtVDQum946ARBZ6GvvcWAc
	 dDCp5QJf6tAkGTue7izJcPNmoUHUwNlLsQ2TwPWKDpDOfczrHfjiIp7HZnrwD9IenY
	 OPvh37wuBYL+w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 13/14] selftests: mptcp: sockopt: get and verify TCP_INQ
Date: Sat, 11 Jul 2026 11:43:41 +0800
Message-ID: <6653ae01c942aeaf0b6816ea41408839ad96874a.1783740443.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783740443.git.tanggeliang@kylinos.cn>
References: <cover.1783740443.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add get_tcp_inq() helper to extract and verify TCP_CM_INQ values from
received control messages. Integrate it into the echo test and huge data
transfer to validate in-queue byte counts at key stages, ensuring correct
TCP_INQ behavior with MPTCP.

Code adapted from mptcp_inq.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 1ae63434d5f4..5116de9429f0 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -793,8 +793,28 @@ static void inq_msg_reset(struct inq_msg *m, size_t iov_len, void *base)
 	m->hdr.msg_controllen = sizeof(m->control.msg_buf);
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
 	size_t expect_len;
 	ssize_t ret, tot;
 	struct inq_msg m;
@@ -823,6 +843,14 @@ static size_t client_huge_transfer(int fd, int unixfd)
 			xerror("unexpected EOF in huge recv");
 
 		tot += ret;
+
+		get_tcp_inq(&m.hdr, &tcp_inq);
+
+		if (tcp_inq > expect_len - tot)
+			xerror("inq %d, remaining %zu total_len %d\n",
+			       tcp_inq, expect_len - tot, (int)expect_len);
+
+		assert(tcp_inq <= expect_len - tot);
 	} while ((size_t)tot < expect_len);
 
 	ret = write(unixfd, "shut", 4);
@@ -841,11 +869,17 @@ static size_t client_huge_transfer(int fd, int unixfd)
 		die_perror("recvmsg");
 	assert(ret == 1);
 
+	get_tcp_inq(&m.hdr, &tcp_inq);
+
+	/* tcp_inq should be 1 due to received fin. */
+	assert(tcp_inq == 1);
+
 	return tot + 1;
 }
 
 static void process_one_client(int fd, int unixfd)
 {
+	unsigned int tcp_inq;
 	ssize_t ret, r, w;
 	struct so_state s;
 	size_t expect_len;
@@ -889,12 +923,31 @@ static void process_one_client(int fd, int unixfd)
 		die_perror("recvmsg");
 	r = ret;
 
+	if (inq) {
+		if (m.hdr.msg_controllen == 0)
+			xerror("msg_controllen is 0");
+
+		get_tcp_inq(&m.hdr, &tcp_inq);
+
+		/* expect cmsg to return expected - 1 */
+		assert((size_t)tcp_inq == (expect_len - 1));
+	}
+
 	inq_msg_reset(&m, sizeof(m.buf) - 1, m.buf + 1);
 	ret = recvmsg(fd, &m.hdr, 0);
 	if (ret < 0)
 		die_perror("recvmsg");
 	r += ret;
 
+	if (inq) {
+		/* should have gotten exact remainder of all pending data */
+		assert(ret == (ssize_t)tcp_inq);
+
+		/* should be 0, all drained */
+		get_tcp_inq(&m.hdr, &tcp_inq);
+		assert(tcp_inq == 0);
+	}
+
 	assert(s.mptcpi_rcv_delta <= (uint64_t)ret);
 
 	if (s.tcpi_rcv_delta)
@@ -915,6 +968,11 @@ static void process_one_client(int fd, int unixfd)
 		xerror("expected EOF, got %lu", ret);
 	r += ret;
 
+	if (inq) {
+		get_tcp_inq(&m.hdr, &tcp_inq);
+		assert(tcp_inq == 1);
+	}
+
 	do_getsockopts(&s, fd, r, w);
 	if (proto_tx == IPPROTO_MPTCP && proto_rx == IPPROTO_MPTCP &&
 	    s.mptcpi_rcv_delta != (uint64_t)r + 1)
-- 
2.53.0

