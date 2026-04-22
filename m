Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7F433F8A4
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876056; cv=none; b=r+UsaHG2dtp7nGcf5tRu5thbk/8RiFb+TJ9D/ty5FHJkEX+7s6bUtqzheDTh+SW5O9SLBZdBxvJ3fxOQhH8VkN/XDWwK/F1YzM5swOCG2vcWzEzUympVS6B9VWoOB/rIm7Pa1dh10ctKrVzFxwFr5MHXBa6NmlcgVg9rlms1YQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876056; c=relaxed/simple;
	bh=N19jazivXTMDBQM5jY7wG5Ec0mUGbrDn/0Y2kORbl90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LLehWlDfmzlDlWh/5s0yVVrpVfrS8H7VBFJr5PGLCHS4RXB7NDgMOGxmXrpFacgOVGkuQ3JtZovx1LqqPw7PduYBZQ2VRyjoGWyTUIfNTp417LpRXEr+3LXLPsMjJuEcV6/qaWC+3aEVYxk1ZZWNjnuV81BofXtUK4pSMQA0Y3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkbibBq1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkbibBq1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E261FC2BCB2;
	Wed, 22 Apr 2026 16:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776876056;
	bh=N19jazivXTMDBQM5jY7wG5Ec0mUGbrDn/0Y2kORbl90=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PkbibBq18Iio49sLtNZPice7p+9CnbJSc+dCX/DMQ/0SDdJn3QeJhqNdmyrqGBVWO
	 WXWyBOUZx1eJiyG3IqkNn0pM07hvfCR6dIgvwwNlFLiIf/oSGgztMLHJ3iIOnzq6B8
	 4yJ/aLzNtU1yQ6mSTvTxjQuuBp6bWdytEnkC9d6WHcwG/EM2WfuuSwYmPt0M7psSOY
	 +sYcwSLEmG6ZMRNLGm8x897tpIkQ6xUHkdrDpAbOuUmvQVwGG724zNivuyOkl6CF7w
	 2tyc0n+EaErEejhAliScLEfwxfe29kwMYqCCHvkjr/KrGZ1n0+t7/C3h2B0fPBt+oe
	 hRc1feZyGuXQA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 22 Apr 2026 18:40:33 +0200
Subject: [PATCH mptcp-net v6 19/19] selftests: mptcp: pm: use simpler
 send/recv forms
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-mptcp-inc-limits-v6-19-903181771530@kernel.org>
References: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
In-Reply-To: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1778; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=N19jazivXTMDBQM5jY7wG5Ec0mUGbrDn/0Y2kORbl90=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJf/OJoD/937OrRD2Jqd7+4aAeXS559Eb3Gnvf9Naf9+
 U1aV2XzO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbSfYaRYemLv/LH7d/5s/QU
 vDse0f49mWWCqmDtMbmcyFn5108ZtDL8FbIwTn12hJ/JUmzi7qxlK8z+X61/6mD+rc7nUc02Hck
 oJgA=
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

