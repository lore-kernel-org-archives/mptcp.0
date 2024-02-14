Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B291D1B958
	for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910871; cv=none; b=gSZqzbnal2r9KNWRkrLRvOgQkRZ+ECb5+xAbeRwTDd1+GPwlJhgMpXIYBFGBoT9K8PkQJVrjlqiPyovz0PsVT2AUuk/34aSy46NofAlEZp08OsarJ7zjnUz6I+07fYLIZbGCviM5U4BnHvIdbkZ1K3Ofmyd57RlekApPTbBDgHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910871; c=relaxed/simple;
	bh=DoYfkYOQ3ruXSwP0ssiLENI1sxoH9H/fyIQ9Gqc5OqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YvleiGkb95Ws7djEBly8tvey4zJ2ME0AiCizQcM6Z/zeOZy1EE4dCh9ypG73+bIHUQPXFP3NzntNY1JyPgyAYOAOgHscQo+LzbkaPTFzxZWai874wy0c48vfATPWSi1v3g7EslrnzynzRs+dq2tqsMfdaFQ2D7HVou1KiOtZYpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5pJKCsS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5pJKCsS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF79C43394;
	Wed, 14 Feb 2024 11:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707910870;
	bh=DoYfkYOQ3ruXSwP0ssiLENI1sxoH9H/fyIQ9Gqc5OqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d5pJKCsSUhX30LRm7bDy8iJgXgVVNUt5E4f6IlQoeirVY7Q+kXd/WjV7qxLmdNp/5
	 fQU13k5+9nXGVdJDprjBWI+vdQzYvOp6GFWaPHsx56OK6XEMMvr2NtaqcMZ/1s3OdJ
	 noIeDcsE1ifoaa/HviotfADOy8ikGqnb1J6L+nvnEzGbdAjTfco23m1VGgY0yUsMVa
	 7O5JVomWsO1bzi4O580uxsbyWObl/kCc+iYduXFMz1v9pBaiL9Kq9voovkAWkVHOg3
	 ezbiMXESG2BX7YIS//wdOI3550GyRmO2BrtXP1wR7bPNpyY+2hLinn1Lz3AqVX0tAb
	 lYfj5KN9nr/7Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 14/15] selftests: mptcp: add token for get_addr
Date: Wed, 14 Feb 2024 19:40:05 +0800
Message-Id: <0d8f288e99acead175eb1882ca3957133edfae89.1707910454.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1707910454.git.tanggeliang@kylinos.cn>
References: <cover.1707910454.git.tanggeliang@kylinos.cn>
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

