Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348A9168DE
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 07:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708069367; cv=none; b=AAeGMuez+HSlYnD6X6vHttyuMlsEX9dEG46ay/jsKNLnpI1ETyMEgQ2Mu/vDTLuTlD4gI0DbZfmdRgNBIJnW4ZFvnvF7M3bYtiTNd61QAWuK3sly9+J/Vbj9h3RDfUf/YFGO46rizfPdfnSaTH9LmNOU5sO/ebjSIB9AUDvtAUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708069367; c=relaxed/simple;
	bh=DoYfkYOQ3ruXSwP0ssiLENI1sxoH9H/fyIQ9Gqc5OqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nd1yirqQlWqMuAOyzdRBpWi70pVAQ7mf9y99KOZne/Mi4HK17nqZ6P/L3sDWqBxuEJyWnxIqZYNTDJygojdJfPbBkXX/Jb5z8wDWuh+kHkXtqlsAir2CFoJUgpKp6PVUOJkRGe0LSo5m1Wbeq8p5CZ5ZymAmi6U3yGfePUnzpQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPUbOPJR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPUbOPJR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6A9C43390;
	Fri, 16 Feb 2024 07:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708069367;
	bh=DoYfkYOQ3ruXSwP0ssiLENI1sxoH9H/fyIQ9Gqc5OqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aPUbOPJRo/Nj9jRVAsda6ThdCdOG3/gneHBUFTtpaEnz2vGfdxi8/fy1bKyBS6trU
	 nS2fy/Fop56bRZOJdfmxsRbu43689GTJDgssuTK4POsxPFXa5cEhzpvYmnBxkO6cSb
	 oDhFFacja5YU/a++QyUTEwSOlB1dlr2DNWJYknSTzyzNUYPCt5NB6fXW6xxZ8vrpKS
	 SX9FLoI/JXmVGFtPfSc62Bd/2J8OHNhPUbm6esA/I6k0BS3f59sWAPwjYFX5Lb6TY5
	 SrFgsHXdB5asEZ4+dQDLkPyuaZI8toJ/dn/ftsphaia2R4cI6kzOjOA98icT40KJSa
	 s8ZwNv6TJFHsA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 13/14] selftests: mptcp: add token for get_addr
Date: Fri, 16 Feb 2024 15:42:15 +0800
Message-Id: <dcfec91595c3192e49fd1eccb56c387fa372bc5c.1708069036.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708069036.git.tanggeliang@kylinos.cn>
References: <cover.1708069036.git.tanggeliang@kylinos.cn>
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

