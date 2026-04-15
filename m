Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8856333F5A5
	for <mptcp@lists.linux.dev>; Wed, 15 Apr 2026 09:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247105; cv=none; b=GnFS2wdW5KDgIM50Nx9/JRhyOMmJLhYCYxoQK4NF8eoLY2RYnig0b3VRwcYfJy/dDOoQzGBMSJyAZlQYrcWf9Kwz/Pyuvcf2uMUIuJ2jqEzlJ5jhcM0z0bkyr7Bgq59HUN/X/yvYeqmlVNiOhEyfkoPPJ5jLTwyHbmfjavATOEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247105; c=relaxed/simple;
	bh=N19jazivXTMDBQM5jY7wG5Ec0mUGbrDn/0Y2kORbl90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NR/jCAIBZLIQw5YeoERUotgheF+4SaFHNOCLX2+WRsI4Zaua21RpLZ1beZdyknqFfJ/bFPXbLD3QbtRpn415GlofIvXw+QeRpJDPV+296SQU6yxR9D/3+/qmQOR4xjjmJ5g6Z55MJxIVi55RiOxKMR70O9gZMG3yatAtFkgDml0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IplQ1dtZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IplQ1dtZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFF5C19424;
	Wed, 15 Apr 2026 09:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776247105;
	bh=N19jazivXTMDBQM5jY7wG5Ec0mUGbrDn/0Y2kORbl90=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IplQ1dtZwbWMurc4mSMgg5T2cgO3qxmlvGi1frIIARCn5Uw6serL+gpDuMPqeTX/Y
	 A11W9tL7Q0UpSRpHmfX8oHh8cf7eTL4Ky5r0DPbA4cHONEYPeI3fYocm8D54zRjgVd
	 P/WdhA1QS1cgHLNjy8o0oCNrLA0WvyhRjpUoEjb4smWLxh0moUZ53mnfNP3kg6fJGT
	 C+vovU9zFCDED2bEiaog8FgQopFsPkSO4KEQ7XsfKRBudERVaPig7s6sUQ4yMIhTwS
	 x+7nU9nGf5Am/4frR5YdoQaFcDCxVlvYF3AtQGecuJCVXbMI5OeUOSsWF1PU9ajbZg
	 hYI/P+ssPHlnw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 15 Apr 2026 11:57:07 +0200
Subject: [PATCH mptcp-net v5 19/20] selftests: mptcp: pm: use simpler
 send/recv forms
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-mptcp-inc-limits-v5-19-e54c3bf80e4e@kernel.org>
References: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
In-Reply-To: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1778; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=N19jazivXTMDBQM5jY7wG5Ec0mUGbrDn/0Y2kORbl90=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvJxqGfv8mu/FAReIqjm8mq8+4PZGt0Fkb8b1HUIZxu
 1lhZc2KjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgInsNmFkeMwaaREst4Zx54vt
 QpeaW4SWeLCt9K/0VI+Z2n3dnD0+kuF/faH45/BkL/eNd83+LAi/v/jo9JBFWzr+vSm6qDIjXK2
 ZGwA=
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

