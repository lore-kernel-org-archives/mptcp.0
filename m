Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3439560244
	for <mptcp@lists.linux.dev>; Tue, 20 Feb 2024 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423131; cv=none; b=VnFbdSpVq+WBEDvFAC54k3Ucm9rTkWzCB1jj4guayPFCV2lFMfDCWkgtnAN6tP+nRFrPQc54TUzoxn4X0Gyvcq9s+c9p2vBE9D+wmlYmPyEfCfP9Fm/dIktQUsI4Hs7KIjzTq2c5JEfX8LBYEflG585b/+8HfPZiIHLLdLVprzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423131; c=relaxed/simple;
	bh=DoYfkYOQ3ruXSwP0ssiLENI1sxoH9H/fyIQ9Gqc5OqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NKhKGRUaY2MPmbDEH18hcJQuTeHcAfXwd4MDEKfHwZ/lf6+qvFvQjzG5Kgpu79ES1pg1M1Pze5v2MEln5Oay95Z3T4lR6XPUIre5HNU7Tl72IWcaKixI9hhyfFd2bx/CwkjvIaZgZ+Vt/Y4gGbY8p6WJHqpZRcPhV53k3L7Is9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfN50wZ8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfN50wZ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477CDC433F1;
	Tue, 20 Feb 2024 09:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708423131;
	bh=DoYfkYOQ3ruXSwP0ssiLENI1sxoH9H/fyIQ9Gqc5OqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SfN50wZ8pNcosroje1YO56wTTgUq94eiZt/jm1zHh5JrGONgkZMrvC52MovtPRaQ8
	 1quijZKKcTkJjkG0LoxxNg98nvcjtZRY0S78k5hCKYLM7GQ/OdnenUG7L1geGy6vQO
	 r/e6kw90KmwksKH/F1xJclIP30tVT7TpEhTyOKKeLG1ZqW3ghKRurBVU7QOBjnoO/N
	 ZdjHf7TDQYD92IJ8vtmcJVcOcOVDoJuy5Iyu4DqJAizCC2MGLH+qvS9vwr4cNpGRtI
	 DulnMwxUe14Ma+j73cKHj5atfLbwVvBxTduMbZNUHfROLOi2Tj9ufptmJdmYZb9DRX
	 jHjbySFV/eBQg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 13/14] selftests: mptcp: add token for get_addr
Date: Tue, 20 Feb 2024 17:58:27 +0800
Message-Id: <f7096776872035eab1f1d25a9217a51eb4cffc2f.1708422758.git.tanggeliang@kylinos.cn>
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

