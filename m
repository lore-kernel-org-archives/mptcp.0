Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77881373BEE
	for <mptcp@lists.linux.dev>; Sun, 12 Jul 2026 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783850108; cv=none; b=a5iUVscWtd9L8ijnC6HrGSavRMikcvYyQH0nlJdRcjtalBqnZ2UnDYlnz2l0UN2GYFmjIRwuCWt5o7wuae4MGO0VcLbi8tKYf3Kkhi5OVJrUdqMkQ+kvpRkwLub8prvD/WV0dSnbfMMhmKH7JbQKxCMS5SyLbnGhnPXF7mPdQ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783850108; c=relaxed/simple;
	bh=Tk+UKSyZLbkkpPpHzqRFDh+rLqgNjVqPMHNPPpV5bmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAhFH2kPwTaUD7uhsmm90nyB2QKeEbmSoWeLTNxiiFhGmr5zrL3gt2KgjfeDu4AmxDU6sJOuQQeeS6tBX4Bxu2AS2aKySYP+5+DzjLWi2sYSzVYG6mhqOp3U8JTKZW7IY56HEfBBeRWfNf2de6Dmd2TgQK0CXmzi+vMJbi5KBOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7QQXvMN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7QQXvMN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11571F00A3D;
	Sun, 12 Jul 2026 09:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783850107;
	bh=v9nIMCpSlVRdpBZv7tHZ6wwfF5VXhrOG22IzyzQcipk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P7QQXvMNYlT+CXGeQDM6FfKaNcWtGJC33IK6QqC7AuYvBgRn1E3me//tm2g+sCRcw
	 1UNsn/DsOTZZOLGJgAcuMDNxKumYRP+t4XDky6V2EHIlENMZ6MAGTGOiU7pzra6m3a
	 Xi9WllgQpFvIGh1PcL6D4nlGEPpKqt4pNEKutkCiuqdLskiXHly+SQwcclQ50RO2FS
	 6sOXt6ne8rCHD7lHTxhFUp2JouHNp3ZcqkM/jT9TOihKxylIHuoX7OmggUy+mstqzd
	 2yuyeCifAN3xkp2S54h72X5k2ev7CKuTUzKMJc33tce6IndcGo+H5DbVAaTAfOcfT+
	 wX1nUYjM+1FEQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 14/15] selftests: mptcp: sockopt: get and verify TCP_INQ
Date: Sun, 12 Jul 2026 17:54:20 +0800
Message-ID: <da4911b21955a0b55c7cb6965f1f7f4c983b4121.1783849522.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783849522.git.tanggeliang@kylinos.cn>
References: <cover.1783849522.git.tanggeliang@kylinos.cn>
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
 .../selftests/net/mptcp/mptcp_sockopt.c       | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 09136b34468c..61547d70576b 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -794,8 +794,28 @@ static void inq_msg_reset(struct inq_msg *m, size_t iov_len, void *base)
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
@@ -824,6 +844,14 @@ static size_t client_huge_transfer(int fd, int unixfd)
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
@@ -842,11 +870,17 @@ static size_t client_huge_transfer(int fd, int unixfd)
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
@@ -888,12 +922,29 @@ static void process_one_client(int fd, int unixfd)
 	ret = recvmsg(fd, &m.hdr, 0);
 	if (ret < 0)
 		die_perror("recvmsg");
+	if (inq) {
+		if (m.hdr.msg_controllen == 0)
+			xerror("msg_controllen is 0");
+
+		get_tcp_inq(&m.hdr, &tcp_inq);
+
+		/* expect cmsg to return expected - 1 */
+		assert((size_t)tcp_inq == (expect_len - 1));
+	}
 	r = ret;
 
 	inq_msg_reset(&m, sizeof(m.buf) - 1, m.buf + 1);
 	ret = recvmsg(fd, &m.hdr, 0);
 	if (ret < 0)
 		die_perror("recvmsg");
+	if (inq) {
+		/* should have gotten exact remainder of all pending data */
+		assert(ret == (ssize_t)tcp_inq);
+
+		/* should be 0, all drained */
+		get_tcp_inq(&m.hdr, &tcp_inq);
+		assert(tcp_inq == 0);
+	}
 	r += ret;
 
 	assert(s.mptcpi_rcv_delta <= (uint64_t)r);
@@ -914,6 +965,10 @@ static void process_one_client(int fd, int unixfd)
 	ret = recvmsg(fd, &m.hdr, 0);
 	if (ret != 0)
 		xerror("expected EOF, got %lu", ret);
+	if (inq) {
+		get_tcp_inq(&m.hdr, &tcp_inq);
+		assert(tcp_inq == 1);
+	}
 	r += ret;
 
 	do_getsockopts(&s, fd, r, w);
-- 
2.53.0

