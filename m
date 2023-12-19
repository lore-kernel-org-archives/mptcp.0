Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C8A18EB4
	for <mptcp@lists.linux.dev>; Tue, 19 Dec 2023 13:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PZX/8NBr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702992739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9YLvVFOoCNrJSE4AAms04hq4jtYeWYnHs4+hrwO8rGs=;
	b=PZX/8NBrFJ02qCIHOFkGDRWGOzG3vdHgxxKTd2O4oROBHsiKcq6mI7GxdHe7QrbUDWHBb/
	JElYZaj2OH117YV6ZOBnN+gcog2ZhTr1dNsointimQp3IExBSlfF2A8Jyhh2sy0znVxX7h
	T239V8m9Jo7eCTyi9ubfdqEL/GnyjzU=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v4 13/14] selftests: mptcp: add token for get_addr
Date: Tue, 19 Dec 2023 21:32:17 +0800
Message-Id: <83901180f6e86b0b6f131637dea0f67f86c8c19b.1702992525.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1702992525.git.geliang.tang@linux.dev>
References: <cover.1702992525.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The command get_addr() of pm_nl_ctl can be used like this in in-kernel PM:

	pm_nl_ctl get $id

This patch adds token argument for it to support userspace PM:

	pm_nl_ctl get $id token $token

If 'token $token' is passed to get_addr(), copy it into the kernel netlink.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
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
2.35.3

