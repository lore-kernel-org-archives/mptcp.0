Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584E8227B88
	for <mptcp@lists.linux.dev>; Mon,  7 Apr 2025 07:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744012436; cv=none; b=kqKTjhqiBMc0QBdTPsPObjJErw0Ph5k44Q1lmd7auDmZPKxE2GHVJ5u8ENJbpAYL8dbvWnjoaCFwDJmVm1CrSZyzH3UPe2wlkjWfnzfYIyz6kB0TkbPayhTa1MROrenvq5eYiu/jaRuFlHmBE0cDl9xvMvp+btKUXK9d2eZh0eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744012436; c=relaxed/simple;
	bh=tRwJCULjxWqBa5fkqP6uNZuCgz+sUSJYrqPvMfneEqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u2p0BqPe7AiFbogbr7tDTMv8tvb88MRHQcYR99x+DZPPGXsiNMn6ZXNKL+3W8iER/HzMDm69CiOeUycgzW4+xbOXSbMXW4bjcyKBTo1FjBYUo1e7iccSCTyEFs/JecXnqC0VtxKJOTtkIrMRAZwk+MX4DagzH56y0X5L6HuD+98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHzUNlvV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHzUNlvV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C06C4CEE9;
	Mon,  7 Apr 2025 07:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744012435;
	bh=tRwJCULjxWqBa5fkqP6uNZuCgz+sUSJYrqPvMfneEqU=;
	h=From:To:Cc:Subject:Date:From;
	b=iHzUNlvVUnxVaX5tYsomKivGx4+LVeYm31SisxrzCwdlP0R2Karf/cN4ieKpJ+QKs
	 8ooquokj3Ir0ewBrD9b1C7kA25i2o5zgf+pw5s61tj0V90bpgaRV9raKROLa3wf35K
	 i5B3dEtgLs7OwNrU49B3b20gWPcN37228Y2+hWutkWlUtHyqnVheKxpHpCUrRZbNaz
	 xlL/KraPwiaAcx260/0swvdn4khLVtnR+z2eLaUsGAbaJFKwxy/BzAxJ6X8wl5tGO6
	 ZlwcZccxTH0PpYm1ZJl2i8sX2wZCSEzIGajRN7IbmRLqMkh/ffB1zeSZmsD2PtUC49
	 GE+4NGIWQwjPw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] selftests: mptcp: diag: drop nlh parameter of recv_nlmsg
Date: Mon,  7 Apr 2025 15:53:50 +0800
Message-ID: <0a7cb982ea5886c2f00e69703feb92c3934dcd63.1744012385.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

It's strange that 'nlh' variable is set to NULL in get_mptcpinfo() and then
this NULL pointer is passed to recv_nlmsg(). In fact, this variable should
be defined in recv_nlmsg(), not get_mptcpinfo().

So this patch drops this useless 'nlh' parameter of recv_nlmsg() and define
'nlh' variable in recv_nlmsg().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_diag.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
index 284286c524cf..37d5015ad08c 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_diag.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
@@ -185,9 +185,10 @@ static void parse_nlmsg(struct nlmsghdr *nlh)
 	}
 }
 
-static void recv_nlmsg(int fd, struct nlmsghdr *nlh)
+static void recv_nlmsg(int fd)
 {
 	char rcv_buff[8192];
+	struct nlmsghdr *nlh = (struct nlmsghdr *)rcv_buff;
 	struct sockaddr_nl rcv_nladdr = {
 		.nl_family = AF_NETLINK
 	};
@@ -204,7 +205,6 @@ static void recv_nlmsg(int fd, struct nlmsghdr *nlh)
 	int len;
 
 	len = recvmsg(fd, &rcv_msg, 0);
-	nlh = (struct nlmsghdr *)rcv_buff;
 
 	while (NLMSG_OK(nlh, len)) {
 		if (nlh->nlmsg_type == NLMSG_DONE) {
@@ -225,7 +225,6 @@ static void recv_nlmsg(int fd, struct nlmsghdr *nlh)
 
 static void get_mptcpinfo(__u32 token)
 {
-	struct nlmsghdr *nlh = NULL;
 	int fd;
 
 	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_SOCK_DIAG);
@@ -233,7 +232,7 @@ static void get_mptcpinfo(__u32 token)
 		die_perror("Netlink socket");
 
 	send_query(fd, token);
-	recv_nlmsg(fd, nlh);
+	recv_nlmsg(fd);
 
 	close(fd);
 }
-- 
2.43.0

