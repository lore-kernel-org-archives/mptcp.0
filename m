Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D5F1946C
	for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 11:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910861; cv=none; b=JrVn22dg5Y6RhegE3gTgK6IgEyg18wBGb7OuTNbxcIk/VbV6dh6bw6Z3RMFwWcdn3KMRDm1+7mLkp5XywFkXhZWCqhwVjVaD0OVBrgeVlrwrjI/lIcT/mxzH/cLgGMGuEcY6qdOZViYZHhGvQM7+AGlEJO1H6pRTBT+ThKNzVM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910861; c=relaxed/simple;
	bh=tERbG7TJiLpb8EzivoIRerccEx0mGGYaF5MyxCkw9Rk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eCb7wvV1iK3R1lmhim4m4tyv3rwwzqE9uYY0KHnRVkSAwtcMjYeVnIjxpWvGid+iYpE61bIrCbbr7dGwQFUjnc3DAyRcMq1hWu0g6Juff9HkhkByPJGY4QHBmF4GnKfx4OrwmIvDzDthlUVHO+cNLwgdGeYGLCqrbRBzZxC6bA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFnkSfk6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFnkSfk6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B142C433F1;
	Wed, 14 Feb 2024 11:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707910860;
	bh=tERbG7TJiLpb8EzivoIRerccEx0mGGYaF5MyxCkw9Rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FFnkSfk6PTc3kAlIxfP84WSxpr/JdkAecWg8Z+50YUzZrZiZazAGwpgLxIIcUtTF+
	 lRTKTPxDDc1nC9ZDF0anZ2Hfox1COsv5Ku44ay9ThT0cXSfTmkYwQ6NZtlG1TUi5zA
	 zA7csKRGYyUyw2MWxAOdiISz/xY3hp2pr5GWM3OnNwR21KqkOvubm5vRxxqBU+fMfI
	 s0dXg7i5fa8agejEM7cZfdEXblIZon6fsYRAjbsKUflyyKQFq8HDcXv6lPOG1GhsWf
	 EWE2J261KOdwFnPd7nUPbi8qk4IBO+xMCrgrPVCmv3XpS4U9WWPIa9FJ5KEMVSMkBr
	 HZNzJmOdUkDsQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 07/15] selftests: mptcp: add token for dump_addr
Date: Wed, 14 Feb 2024 19:39:58 +0800
Message-Id: <0afbc6fda84562b4e9d4b6ab430d3348e7c0eba5.1707910454.git.tanggeliang@kylinos.cn>
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

The command dump_addr() of pm_nl_ctl can be used like this in in-kernel PM:

        pm_nl_ctl dump

This patch adds token argument for it to support userspace PM:

        pm_nl_ctl dump token $token

If 'token $token' is passed to dump_addr(), copy it into the kernel
netlink.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index e97856323ec3..8d7d1b4ed28e 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -1127,8 +1127,16 @@ int dump_addrs(int fd, int pm_family, int argc, char *argv[])
 		  1024];
 	pid_t pid = getpid();
 	struct nlmsghdr *nh;
+	u_int32_t token = 0;
+	struct rtattr *rta;
 	int off = 0;
 
+	if (argc != 2 && argc != 4)
+		syntax(argv);
+
+	if (argc == 4 && !strcmp(argv[2], "token"))
+		token = strtoul(argv[3], NULL, 10);
+
 	memset(data, 0, sizeof(data));
 	nh = (void *)data;
 	off = init_genl_req(data, pm_family, MPTCP_PM_CMD_GET_ADDR,
@@ -1138,6 +1146,15 @@ int dump_addrs(int fd, int pm_family, int argc, char *argv[])
 	nh->nlmsg_pid = pid;
 	nh->nlmsg_len = off;
 
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

