Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3014C3DE420
	for <mptcp@lists.linux.dev>; Thu,  9 Jul 2026 07:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783580835; cv=none; b=Qqt+ByGs1zhFxeeLdkAJjmDF7njbuvi7SyW7x6gqEEwpd+tMJ9jLDS4a8/kPIOFMOPpI301bY3MybrxRxAJ5ZpD/7sHAgLQFi8iJ7QqRx5H0pFP4Dz9+wdZY81cm3p2UyJrnm9qFjKLXaN4nGxNJ77IQhRHVblN1orXKeEvxnWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783580835; c=relaxed/simple;
	bh=I8qT2AdYHMQHfRNBCzX4DT09OQ/VnBQXRIk9Yi3oVQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knX9cVep6nAaBJ6SaJHjvh1swGwmsTNPWemUlPXvjv8hsNjwPCISBrPDq29fRg0r5pqzmiX/XacBwtgJfQ3E0J6JOyykzqCzmd02bbJGuvisKzFf8qFnk9MBUpTu4VpC5pK0rkU9ec8o0rxnYE62OoZ9lnKNKNC2kfS4H9BOA3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2tPqlrL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2tPqlrL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5B21F00A3E;
	Thu,  9 Jul 2026 07:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783580833;
	bh=c+SdKJeNbX+vFKSuZuEzO0jFu12cTe4FCkqbwvTlLNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J2tPqlrL3Cs7AlXfwuEugiEMEWR5L5lA3NcVKhRpa0CIY4Js3ogXQMk20A4XIS85m
	 +rd7sXaRc1c2scAwrFVlpAQk2Q4VzUIjzex64ZPjxdSnjanjASw0MU+W4YrY5J8bBF
	 v3yhGxWnyKKdGUhPjBngqiZoVi2QwQg+7zJozCvT56XnmeYqc+SnjUJdoy25ZWIINL
	 w0ZTJ32WlcxRGKJ8pbAXebiILgZsgITJXS8HvatM8T0K9+rYdAkgd7wnELDUV/wrEQ
	 Fk14tUZ0cltLw9iKDD5Aa3XJXHzzrEw32aNr6AbSOROpHr0x4bTbeKaKgv00cxyuoI
	 fj6s7imsAFi/g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 09/12] selftests: mptcp: sockopt: add get_tcp_inq helper
Date: Thu,  9 Jul 2026 15:06:18 +0800
Message-ID: <5ee448f59c74c732a2efe0de1d5a717528eefad8.1783579976.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783579976.git.tanggeliang@kylinos.cn>
References: <cover.1783579976.git.tanggeliang@kylinos.cn>
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
 .../selftests/net/mptcp/mptcp_sockopt.c       | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 393c863f3762..1674b660848d 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -750,8 +750,25 @@ static void connect_one_server(int fd, int unixfd)
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
+			memcpy(inqv, CMSG_DATA(cmsg), sizeof(*inqv));
+			return;
+		}
+	}
+
+	xerror("could not find TCP_CM_INQ cmsg type");
+}
+
 static void client_huge_transfer(int fd, int unixfd)
 {
+	unsigned int tcp_inq;
 	char msg_buf[4096];
 	size_t expect_len;
 	ssize_t ret, tot;
@@ -787,6 +804,14 @@ static void client_huge_transfer(int fd, int unixfd)
 			die_perror("recvmsg");
 
 		tot += ret;
+
+		get_tcp_inq(&msg, &tcp_inq);
+
+		if (tcp_inq > expect_len - tot)
+			xerror("inq %d, remaining %d total_len %d\n",
+			       tcp_inq, expect_len - tot, (int)expect_len);
+
+		assert(tcp_inq <= expect_len - tot);
 	} while ((size_t)tot < expect_len);
 
 	ret = write(unixfd, "shut", 4);
@@ -804,6 +829,11 @@ static void client_huge_transfer(int fd, int unixfd)
 	if (ret < 0)
 		die_perror("recvmsg");
 	assert(ret == 1);
+
+	get_tcp_inq(&msg, &tcp_inq);
+
+	/* tcp_inq should be 1 due to received fin. */
+	assert(tcp_inq == 1);
 }
 
 static void process_one_client(int fd, int unixfd)
-- 
2.53.0

