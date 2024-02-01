Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522C139AF6
	for <mptcp@lists.linux.dev>; Thu,  1 Feb 2024 05:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706764762; cv=none; b=QVANMcyPSbqsxJyzUG2QqEqZZz8SGOlBxTNRDbvLexotyaji1Go8TDgXjVUjKyz0E7HqNWwame0VEADITXuNXduylwyoo9z50mS/rb74YMlEfT6+FWPHaGqCPj6bd8khwO25Rlnist/jpPDkaexN42KEgpMK09TFSOSrsTOiGZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706764762; c=relaxed/simple;
	bh=tERbG7TJiLpb8EzivoIRerccEx0mGGYaF5MyxCkw9Rk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q5zh0+TZimTHX7AUsEIOD8f/hyc2z/hpdhuX8UqueKTniX2SCqGsXuML7g35afmPbW1/flVPxg4NXJq4+bCE5vGh9r8zJeoAMzybaj7OaSu9cidBI2DfLC65wOosm1JwLH+wj3FDUB0RE/OmqZAv422fSXcQB+qNWPZbWNNy36A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0yi092w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0yi092w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0384C43390;
	Thu,  1 Feb 2024 05:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706764761;
	bh=tERbG7TJiLpb8EzivoIRerccEx0mGGYaF5MyxCkw9Rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q0yi092w6+ZHKU5CvUBylJkxYuYJNexRz8K6ugpTCozjRw8Dqn82tDgjYCGg9oTVM
	 XIejzGuLsBYL4W/UvFN23C5InbiSw3200M84s1rFNMsdr1N/XpLNKlNQQ0FeBcl3io
	 pbE+MExvKnnblFQ3r6LJde61CaGVpYLWM6KI7fWveRCQUTCCBychAzjPOuTp2VSphj
	 neB7F/nyNzsgcucngHSLlSWKlwezpBu1JDo8JzFUPBV6NVuEPu9pl6UEmyLN7TyYHE
	 l6ii1iO0tOBkufUP244MjczUyyCXZx/0TbHbrP8hIjpAhjHmdFRYW18mg2jpLDwI1T
	 dXXb1f/R3FMVg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 07/15] selftests: mptcp: add token for dump_addr
Date: Thu,  1 Feb 2024 13:18:57 +0800
Message-Id: <f8097d8cbf88ba7fda50dcbdfec4818f85184aa2.1706764519.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1706764519.git.tanggeliang@kylinos.cn>
References: <cover.1706764519.git.tanggeliang@kylinos.cn>
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

