Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5C73D75C3
	for <mptcp@lists.linux.dev>; Mon, 13 Apr 2026 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089540; cv=none; b=YRFS99KVw5vBw4u1i4ToyhxtB9QVVPL3RpgwNDwap8+GZt2rOSMIDjtduJz3ECqhSkqakBmHIjcrrvHwHqnNnD0ArsWDAb3kI0kL3wB9AqPtrv2rAflVRl1BIiMGK4yBGshlMLMOOKTgF92RabOYLKrX2j54n6PS3M0rx1WweWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089540; c=relaxed/simple;
	bh=N19jazivXTMDBQM5jY7wG5Ec0mUGbrDn/0Y2kORbl90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cxGDHhGNgynwtMzSG4JOVfqhQaHDLPnOL9d2HIyv1crPHV3DmZU8mpaud+3eBVfbDI457TPW4dtTgqBNdOnNRNnbZ/C6qh5XRwWnp+rkh2DnwaOBiGGrSKnxx5e+Aj8RgjVT4LiMRYY8f383H7Kd8B+VKvaYsWbOffRW682qHG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=El3byyYd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="El3byyYd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D275FC2BCAF;
	Mon, 13 Apr 2026 14:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776089540;
	bh=N19jazivXTMDBQM5jY7wG5Ec0mUGbrDn/0Y2kORbl90=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=El3byyYddgtbUehpdbmztDafj0I6YX2u2G1Iw6TnQlhNBN1i7jsj5VcfDuF5utVca
	 /GaLdbGhEu08KjAc8IYhedI+rpwQ8W/856+1N6PNWCPJIZ9uzmpH2HohzEFEASjsHK
	 V2nHVlkofDoYJ0Rqnf2rt0LJQ1mFTeuGdKbaPBrPbwZYwCJLEdlFF99cREfC98UJTs
	 SwP9nBjnYcjRdC6/d1ZrbClagBn5XiooH/bao24u+o7qF+lF43JmLG/OL2NuGI+FW6
	 dvqoTzXqVv9PDzLaql2iM4D0QwtRdlJVcScNuFLw9mIp2eFs7ScKz4iMRxCZeWNtLd
	 mQIKvM12zRuuQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 13 Apr 2026 16:12:04 +0200
Subject: [PATCH mptcp-net v3 18/19] selftests: mptcp: pm: use simpler
 send/recv forms
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-mptcp-inc-limits-v3-18-dd36c9360432@kernel.org>
References: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
In-Reply-To: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1778; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=N19jazivXTMDBQM5jY7wG5Ec0mUGbrDn/0Y2kORbl90=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLv/NzCp6r4JGbXeS0+sTTv7CifAFc96/vz3aR5NLJMu
 g/v6fjeUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMJFDUxkZ+tuaq3id/U6mTV6Y
 ECUwTebHuw+aRfa7KkM5J97quMO0leGfCdf9JikN6+c3f0jXeLoaCvEvXPxU+f29/7HnawvXW8l
 wAwA=
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

