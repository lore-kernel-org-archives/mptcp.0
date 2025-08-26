Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945452E7F32
	for <mptcp@lists.linux.dev>; Tue, 26 Aug 2025 09:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200605; cv=none; b=k6sykQ4MNOlGV6xh3je1TDvhhlkVUDSMbVrY1QgWwWRmDct16gMG+j/qstOUSAkGgxHEX/29hpbMDIamPfnNm4WqGhQwM2mcR97I2tqMRM8wrtDSUP2bB0Lbh94AlnWqjQwmlJ/LQLkt3phpWI2TxHNnxN3/i26NRNI9oYbg3YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200605; c=relaxed/simple;
	bh=qiqbcMib9J43NDONqFdTSTPr23jwgwITCPHvgod6958=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l65yXrkO0xi8/lc9iybqMgNYFJ+ACYYtFnRes4bt1mYl11LFOPiCu9xaRTmsbCvhVwzMjbQu1VxnOoAmdLzBhzclwdGeJpMYCEmL+ud2yIGjQBiZc5nBfb5s8RbZZm5fHW0fLVdjtw7JPrQA8nvmp8sLDVdbWP+tuGqjMfibd5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gs2Gy6fi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gs2Gy6fi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F61FC4CEF4;
	Tue, 26 Aug 2025 09:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756200605;
	bh=qiqbcMib9J43NDONqFdTSTPr23jwgwITCPHvgod6958=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gs2Gy6fikINrZGJF8sv5nSSyjfwmhznGTYZ5rNZoCEqZzkk2Yhzq8cjwRr+WeiPL0
	 cs2NqWW+GHnz2webxwtQrD0gpo0AdpBOTIsJFFurJkvWKBZUk/J8HcNyctWWMhz/xJ
	 3KovyKWOXprryMscjkMDVRyxwqO5+MoLIYXBj0VHK+Coi7kHsd4TYvSxeWCtncpxB+
	 qpI53VHSwtO2QOm24peSsBFplJBZDKt5uO4rdLwjtnPssNGYBxyP3I7pR4llZL6hPM
	 AtQUrBd65oVFakjyPR5UujxN1HBBi6ET3YxcDmO1QdigCSFKQnkq52nlucOkImDlIg
	 mjEKicDXdOmnw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 12/14] selftests: mptcp: sockopt: add check_tcp_inq helper
Date: Tue, 26 Aug 2025 17:29:36 +0800
Message-ID: <8ca40aac424fff8465653c946e84fc29e18f19a8.1756200029.git.tanggeliang@kylinos.cn>
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

Adds check_tcp_inq() helper to extract and verify TCP_CM_INQ values from
control messages, ensuring correct in-queue data tracking during transfers.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 7cc4626b7bf3..fb6f76c4dc07 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -740,6 +740,35 @@ static void connect_one_server(int fd, int unixfd)
 	close(unixfd);
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
+static void check_tcp_inq(struct msghdr *msgh, unsigned int check, bool equal)
+{
+	unsigned int tcp_inq;
+
+	if (!inq)
+		return;
+
+	get_tcp_inq(msgh, &tcp_inq);
+
+	if (equal)
+		assert(tcp_inq == check);
+	else
+		assert(tcp_inq <= check);
+}
+
 static void process_one_client(int fd, int unixfd)
 {
 	ssize_t ret, ret2, ret3, tot;
@@ -797,6 +826,8 @@ static void process_one_client(int fd, int unixfd)
 	if (inq && msg.msg_controllen == 0)
 		xerror("msg_controllen is 0");
 
+	check_tcp_inq(&msg, expect_len - 1, true);
+
 	iov.iov_len = sizeof(buf);
 	ret = recvmsg(fd, &msg, 0);
 	if (ret < 0)
@@ -810,6 +841,9 @@ static void process_one_client(int fd, int unixfd)
 	/* should have gotten exact remainder of all pending data */
 	assert(ret == (ssize_t)expect_len - 1);
 
+	/* should be 0, all drained */
+	check_tcp_inq(&msg, 0, true);
+
 	ret2 = write(fd, buf, ret);
 	if (ret2 < 0)
 		die_perror("write");
@@ -853,6 +887,8 @@ static void process_one_client(int fd, int unixfd)
 			die_perror("recvmsg");
 
 		tot += ret;
+
+		check_tcp_inq(&msg, expect_len - tot, false);
 	} while ((size_t)tot < expect_len);
 
 	ret = write(unixfd, "shut", 4);
@@ -871,11 +907,15 @@ static void process_one_client(int fd, int unixfd)
 		die_perror("recvmsg");
 	assert(ret == 1);
 
+	/* tcp_inq should be 1 due to received fin. */
+	check_tcp_inq(&msg, 1, true);
+
 	/* wait for hangup */
 	iov.iov_len = 1;
 	ret3 = recvmsg(fd, &msg, 0);
 	if (ret3 != 0)
 		xerror("expected EOF, got %lu", ret3);
+	check_tcp_inq(&msg, 1, true);
 
 	close(fd);
 }
-- 
2.48.1

