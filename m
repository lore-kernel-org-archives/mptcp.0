Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB48F60244
	for <mptcp@lists.linux.dev>; Tue, 20 Feb 2024 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423123; cv=none; b=T9yMyfbiTlXY8F5ylFGXyf9mW6w7OKRqEJ9yWJue7pamzK8rgSKqc9dcUfd1TO6ZuFrkgvrRqe1C6HclPnU2CKchgj5hM9jShk4kSE2+T8CBtuAwXIaVMgLTEjo/Y5EJnWF67tXupm4L8a6KvsSnm60yn9GusCKEZZLmX5hoszA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423123; c=relaxed/simple;
	bh=tERbG7TJiLpb8EzivoIRerccEx0mGGYaF5MyxCkw9Rk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CJW+qmgN/kIECUAMJrK7t5c/B5lsADF1nrZpIuChkO6k/cJa+syXmDcsz7tXXXahmwlSCo550Zr92St1MeRhUJEUVo7uU0Arky/4SM83nnbT7wWMcI+Oc0sIv1dz793vNJLI28OqrEzhr0BSxd3OJGaCVsecxf9W8RhWjscidrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LD22bedy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LD22bedy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653EBC43399;
	Tue, 20 Feb 2024 09:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708423123;
	bh=tERbG7TJiLpb8EzivoIRerccEx0mGGYaF5MyxCkw9Rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LD22bedySm/l67JXG0Q90D5UpFGBCVICfBV6U6DpZueEIHaoVC8qw9OoBvJvDydpf
	 ir52hfuQKm2cXiaanMbU5mDtJTv9CH12P2ZAQhldsK31nb3S7zsEPZRqfsFb3z+sJA
	 kExZOxviIj14NVbKDq4ai4IMWF1085wA8Wtz6lfhSqpCLwErPWMJjQjH6BzSWisdYG
	 wjNR87GewOE9IKv24ico/pwbxbZhgB68au3AhGTsDWGoaavipTn9C2IwsTXdH5Bxvz
	 DdvBbn2jNLHTBIuUnqHv/H9Fmw3d1SUWQymAq0H7H6mihwPI0+3bdeB7ZYjGw3mbCm
	 KzN71/S+GI8PA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 07/14] selftests: mptcp: add token for dump_addr
Date: Tue, 20 Feb 2024 17:58:21 +0800
Message-Id: <e0efd25748fd45d27c126b6c03828ec65891ac57.1708422758.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708422758.git.tanggeliang@kylinos.cn>
References: <cover.1708422758.git.tanggeliang@kylinos.cn>
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

