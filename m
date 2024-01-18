Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067AB8F40
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 06:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705558355; cv=none; b=jn9QLs5emyIWKugISXPkdiTKtWWrcWRXBke8mRDeEBR6kc6PJ9wIxX3adnqLqYb96+ElEs3ei8BwWjZ5E1p8JtYSJysgnxYHF0I+icKkV6Gc2Umqiyni8WUACobUt0ZuZja0bgGBNcTWAr4Oia2yvBGsDgH6olJEGweL4O60ze4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705558355; c=relaxed/simple;
	bh=DoYfkYOQ3ruXSwP0ssiLENI1sxoH9H/fyIQ9Gqc5OqU=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=qPiKJtFR6y4/ah9L9xyL8TJyi8K+jiz1CtcY6pe/hOMedX96iGX6wNwzaGF2P6NVPlmjtGVfBRVak9MrgAe2twYxLYyOrC120FD39GoGClYUylO+DLudREdtUckzl0DpBKt+wxuZzOZ77Q5siE/rxV8rNIXUb6FWsk4ujTTAGkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyYeWAEA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyYeWAEA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08275C433B2;
	Thu, 18 Jan 2024 06:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705558354;
	bh=DoYfkYOQ3ruXSwP0ssiLENI1sxoH9H/fyIQ9Gqc5OqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qyYeWAEA1qVIl+Zu8AxXdBIn+KuJAW6cLI9mQFEbhIUoXct8zT5VfqNiLTE8Kj7u8
	 r0g7P0GUPxFpnKGQomEZYLEwuh55jA3nvwKJb8XyoR/5ri8djG2ucfjqvmxPhCvKY0
	 I7rwqXdYkCA+RJ8Y0zny8fhXgaHfUtt03fLgcMnq7/FXYMb2Rnat+zk523Yys0PSwA
	 cAEhM5ANCqr+nHIwa12Ju13eYJTZvIsf1SrCjIONCAl6CyX1tumq2YvZfPadsTtkkM
	 Blejfwu7Ji4GlqikFa0TIf9BNdAmuLUXZR+QDvMd+JrLF2qeVnGJSI/Vyj6xa5o1Eq
	 Fcsl9Jm1uLNoA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 19/23] selftests: mptcp: add token for get_addr
Date: Thu, 18 Jan 2024 14:11:59 +0800
Message-Id: <abb753e11ba4f14595279ecc03005cd608623967.1705558030.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1705558030.git.tanggeliang@kylinos.cn>
References: <cover.1705558030.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The command get_addr() of pm_nl_ctl can be used like this in in-kernel PM:

	pm_nl_ctl get $id

This patch adds token argument for it to support userspace PM:

	pm_nl_ctl get $id token $token

If 'token $token' is passed to get_addr(), copy it into the kernel netlink.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 8d7d1b4ed28e..7426a2cbd4a0 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -1087,6 +1087,7 @@ int get_addr(int fd, int pm_family, int argc, char *argv[])
 		  1024];
 	struct rtattr *rta, *nest;
 	struct nlmsghdr *nh;
+	u_int32_t token = 0;
 	int nest_start;
 	u_int8_t id;
 	int off = 0;
@@ -1097,10 +1098,12 @@ int get_addr(int fd, int pm_family, int argc, char *argv[])
 			    MPTCP_PM_VER);
 
 	/* the only argument is the address id */
-	if (argc != 3)
+	if (argc != 3 && argc != 5)
 		syntax(argv);
 
 	id = atoi(argv[2]);
+	if (argc == 5 && !strcmp(argv[3], "token"))
+		token = strtoul(argv[4], NULL, 10);
 
 	nest_start = off;
 	nest = (void *)(data + off);
@@ -1116,6 +1119,15 @@ int get_addr(int fd, int pm_family, int argc, char *argv[])
 	off += NLMSG_ALIGN(rta->rta_len);
 	nest->rta_len = off - nest_start;
 
+	/* token */
+	if (token) {
+		rta = (void *)(data + off);
+		rta->rta_type = MPTCP_PM_ATTR_TOKEN;
+		rta->rta_len = RTA_LENGTH(4);
+		memcpy(RTA_DATA(rta), &token, 4);
+		off += NLMSG_ALIGN(rta->rta_len);
+	}
+
 	print_addrs(nh, pm_family, do_nl_req(fd, nh, off, sizeof(data)));
 	return 0;
 }
-- 
2.40.1

