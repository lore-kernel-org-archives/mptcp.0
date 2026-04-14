Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61A2271A94
	for <mptcp@lists.linux.dev>; Tue, 14 Apr 2026 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173666; cv=none; b=sWe8MIUWQ2o2470ggrSm4f2bHFXXiMKXtpDEknDnxdoteuG6GZaoKOwXzK406y9B8G4kgQxHVnqUxHKmiWD6AD4RDPDw2VInPoj+UqjJMXjsPxODQ09VK+bBq+M6WD6IKRMl86ks8AUR5cxfF4n0Om8KQm9ejNRGVt1Bum23nko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173666; c=relaxed/simple;
	bh=N19jazivXTMDBQM5jY7wG5Ec0mUGbrDn/0Y2kORbl90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oDHrz7CogqSBBH28YR0/WpLRsQBNZyQEtdzyyOqJ3JmtbKBaIWDphLmgmeE57IbbS8sO3JtXhUBkZiYjixcfXjsWstFl/cIcxDt+WlfZA3LJlczpKBfOJ9wcf7B7W6JGY0c8aJB6x53C1s5FsPu01dG+xs62tTF4OSL3FrRdyF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGxUZS9V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGxUZS9V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE61C2BCB0;
	Tue, 14 Apr 2026 13:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776173666;
	bh=N19jazivXTMDBQM5jY7wG5Ec0mUGbrDn/0Y2kORbl90=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RGxUZS9Vp7khMiIPcmi4BfoGLXFiljWNL+LEAt+TYLNnga3JW13EZ4WT0lo5puiPB
	 BA2zrYD2lO2+zUaTxBwH9n3VshNmrsLFlw9ZAxw10Vw7aUe/RTbKqCgBctZ2ratQAL
	 hPODc3siunshX4Sg0eYexJER5Fa/i80t1D/w2p7E9Y7FKkzE7sZMvM+aUK6nbHYOp2
	 0hdF1MP+Zz7pcGhGDbVzytoaxBDnmIaYL0bN4WFzAB7gkcNikqao6kDJ1bdIbGlEDA
	 o+GyXEOO3APqtzVhE8TtPu/hyhoHn9PlHrEq9o8ZyvdGX/m6SkKoXiJFpWNyYAyST0
	 THKeiHUrgPyZg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 14 Apr 2026 15:34:12 +0200
Subject: [PATCH mptcp-net v4 19/20] selftests: mptcp: pm: use simpler
 send/recv forms
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-mptcp-inc-limits-v4-19-78274edda5dd@kernel.org>
References: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
In-Reply-To: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1778; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=N19jazivXTMDBQM5jY7wG5Ec0mUGbrDn/0Y2kORbl90=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvOQU9qKg/Ge72lWPKyq7CfSYWNXf+ZF75elJMufxNz
 wRDtWcWHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABOx1mZkWJ7Wtudd64fvU053
 HzrXukk8Mnvt6xhFuaje+JlrvKR7pzL8d9x2uzSmbNvM71L1P76xfUhM7t1kZuUsEsrQPPnFJfZ
 6HgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Instead of sendto() and recvfrom() which the NL address that was already
provided before.

Just simpler and easier to read without the to/from variants.

While at it, fix a checkpatch warning by removing multiple assignments.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: fix already present checkpatch warning.
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 99eecccbf0c8..78180da1efcc 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -217,8 +217,6 @@ static int capture_events(int fd, int event_group)
 /* do a netlink command and, if max > 0, fetch the reply ; nh's size >1024B */
 static int do_nl_req(int fd, struct nlmsghdr *nh, int len, int max)
 {
-	struct sockaddr_nl nladdr = { .nl_family = AF_NETLINK };
-	socklen_t addr_len;
 	void *data = nh;
 	int rem, ret;
 	int err = 0;
@@ -230,15 +228,15 @@ static int do_nl_req(int fd, struct nlmsghdr *nh, int len, int max)
 	}
 
 	nh->nlmsg_len = len;
-	ret = sendto(fd, data, len, 0, (void *)&nladdr, sizeof(nladdr));
+	ret = send(fd, data, len, 0);
 	if (ret != len)
 		error(1, errno, "send netlink: %uB != %uB\n", ret, len);
 
-	addr_len = sizeof(nladdr);
-	rem = ret = recvfrom(fd, data, max, 0, (void *)&nladdr, &addr_len);
+	ret = recv(fd, data, max, 0);
 	if (ret < 0)
 		error(1, errno, "recv netlink: %uB\n", ret);
 
+	rem = ret;
 	/* Beware: the NLMSG_NEXT macro updates the 'rem' argument */
 	for (; NLMSG_OK(nh, rem); nh = NLMSG_NEXT(nh, rem)) {
 		if (nh->nlmsg_type == NLMSG_DONE)

-- 
2.53.0

