Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB95111A3
	for <mptcp@lists.linux.dev>; Fri, 29 Dec 2023 12:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I+Bcsd3J"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703854126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=elnfC3kiUln0kUdIoW4sMFNmDfg5c0tbwFo3j5pB284=;
	b=I+Bcsd3J807xbCN+XGmDZDxVrBW3wWKLTfLJ3X5pXODLimtbH2YoDWBXWOpSgpfESFHWOK
	Y1X0Ql+ll++3qr6mjIEwaCFEU5YomGEWhbgu+CGb1hzbwenHXHnhl1e7gOWeJo18t8mbHp
	Qn4tVAiztSf1MePA0OP3SchW3EyHkvI=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v6 13/24] selftests: mptcp: add token for dump_addr
Date: Fri, 29 Dec 2023 20:47:31 +0800
Message-Id: <080c31fdfe221535ce89e536ec5b63a08afc08ea.1703853513.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1703853512.git.geliang.tang@linux.dev>
References: <cover.1703853512.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The command dump_addr() of pm_nl_ctl can be used like this in in-kernel PM:

        pm_nl_ctl dump

This patch adds token argument for it to support userspace PM:

        pm_nl_ctl dump token $token

If 'token $token' is passed to dump_addr(), copy it into the kernel
netlink.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
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
2.39.2

