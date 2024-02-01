Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2103A8D2
	for <mptcp@lists.linux.dev>; Thu,  1 Feb 2024 05:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706764771; cv=none; b=cnvrbCCbn0YBafqT/metDfNq8CceRKbfD83HuQQ3FkzqEowwkw4/WkZPaJivw4vAEvet9WA+u8O6yZnHXI1KJzb1va5Y93oKVk3oajXSSfEhEzeth7ghlNsUcH4NDMXIzdkV31ZWgbe+YAJsfRYaPSuWk7C8tCUpiGsYpkID6JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706764771; c=relaxed/simple;
	bh=DoYfkYOQ3ruXSwP0ssiLENI1sxoH9H/fyIQ9Gqc5OqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mUNhupppvzBMCGBNePLHWyPtncrNft41mExNnPQm1CT/K1uP6j7yOQOVrCoj3O0aYSpLtOP3DaXG1ufMAEiInf1O5SlAKhM+f+XSvLy9pb/kJDQ0u88RgiddMy08IQQnCM5YP/XRiYRsagJ/FRt2jXt7/vH85kPQ8f0FMOa5gag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=km80ovGE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="km80ovGE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D3BC43390;
	Thu,  1 Feb 2024 05:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706764771;
	bh=DoYfkYOQ3ruXSwP0ssiLENI1sxoH9H/fyIQ9Gqc5OqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=km80ovGEcaNANfXa8iBcz/nYtJkI/Jr9PxPkabrkQVwhVhDmeOCB8RW/AoXTO2HfJ
	 B5phWtkljua/QEkciNnzwn8GdUCLuW+S80IRQ42hTcNghH9za1ZzQ9bkInpeNBJEAX
	 HOOIYtvs/g3VqSVrJGdRJBK4p2Je5k/3KvT5AawWC6vap7cvfvDa7DJ0r61m/FvV/c
	 1OLqXVSShFuBqbmJ1H+XQpDGkD4ilHZf8KYLmwAlC+HX/yk2JEzEPcW65k4ExXgqfg
	 dAuji/m07ClEglghpVQYcrnEKXWivDVIUwgNHz+bI1Qv7OSk7qDPoFdSd5yKwiSyS9
	 5N67EXITU7b3Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 14/15] selftests: mptcp: add token for get_addr
Date: Thu,  1 Feb 2024 13:19:04 +0800
Message-Id: <ec793ddffae13a3b1b5ccbde6f5a1c2958656587.1706764519.git.tanggeliang@kylinos.cn>
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

