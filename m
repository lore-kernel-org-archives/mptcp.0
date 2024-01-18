Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907EA8F51
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 06:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705558345; cv=none; b=XfcIuiVIgZ67Wsvxokn2OwqfvxY8N4ohjsa6gduBz1OS06z+7Sfdi+EwNieJx5/z75CXDlGLCjk5Jog0HXudxBAw8CyIMO1Ol2B+ygS3UN45XlSuQ1w9guFuanznYmMj/NcDFFMY8GwUkMYu8EkzC3bWEIJFiOEqHIVQ57qhhFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705558345; c=relaxed/simple;
	bh=tERbG7TJiLpb8EzivoIRerccEx0mGGYaF5MyxCkw9Rk=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=QiMt3HjvbJTrp44LCs2uDO1Nz6risJaiET48q+fDA9VPEowKTfS404SHpdP1xRjeFnXmYqhR39V8x3POi2E67GpQ+dw3WC+BS2pU9T/rhFf4TdZOtRGCWKEpOudViX5TKdO6EaODglunY/8Wqo75rEPc1cArb9RSebbAZ8CAv9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdZ0g0Lh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdZ0g0Lh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59017C433F1;
	Thu, 18 Jan 2024 06:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705558345;
	bh=tERbG7TJiLpb8EzivoIRerccEx0mGGYaF5MyxCkw9Rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YdZ0g0LhGToCnIFS/HJvFOt0q0X1NCFSmZRCIwMqCuW5VWP0V6YZAAGDLrSWYjbXR
	 3S9injopvUjrKzGdj7jLYO3bln3NmW1b81b7oNo8FKmvn7FWcbEDr76JZNBCt19+GB
	 ed6z2paRR6kMlugLJ3Kp34R1Nny/LhEmNZcvneX/o2wXugdEW3E33cuBbbj6zCTJJd
	 vCI6n6KzH/0yUs36/4QRoty6Ft7feWDulfP5UhvB4Zz33IvYcjbn+bYjSVVLe7kaFh
	 Nm7Proee/NqN8Cz1VjWsYUj0lG2SyXvTL3iux1qqF/H0RxE6uonC+eZER6Y0HDBA6T
	 prLUm/rJk3JpA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 12/23] selftests: mptcp: add token for dump_addr
Date: Thu, 18 Jan 2024 14:11:52 +0800
Message-Id: <ab2f6221f17a06e475650140c744fdd9f1fc3fb9.1705558030.git.tanggeliang@kylinos.cn>
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

