Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401063D093F
	for <mptcp@lists.linux.dev>; Fri, 10 Apr 2026 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775831539; cv=none; b=ezjUOgf9BDh7hLuRyC2dFKM+CTX+4DA5qEEM7Yox2vNAde+MjTvckNi8DuDW/tu5mu0TDVLE3v+VjakrgcsYYzV0rUYIAzDJQ+VRL53sRUbByb8cF4ZrnnvARYOQpIfhjyzObrQ/03R7kItqw0DY9rFCe+MJhRaiq9UXdj+9x0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775831539; c=relaxed/simple;
	bh=N19jazivXTMDBQM5jY7wG5Ec0mUGbrDn/0Y2kORbl90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TREwAX6jXm4le02f80iNIF1eRjpasz/nISFSspe1uLflSa7A3TVgL17lNSeuzt3oyB8qjfPRWPmLeYVE1If5n+zU9aw0ldQ9q8oMyPe0CNiaxf0dsm7YAsbdgHGPEWpnzyeGsVrHSMr2hkXvKmhlkGRlvMrT3ZVmiOlIZxKZllM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmhIV52l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmhIV52l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D73C2BC9E;
	Fri, 10 Apr 2026 14:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775831539;
	bh=N19jazivXTMDBQM5jY7wG5Ec0mUGbrDn/0Y2kORbl90=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bmhIV52lhNYb8IX8wXNKxqeJHIRrcaYcZ72cldQkKhvbkDEAVyk/pkGhkbTHmwHYi
	 My7NCq0I1cYZzYAgoj3zHaLAP08RmM8w1fj1hl6jpUUCb2j51Eq3fBgklVkEnA0bhc
	 LPlmZjH8CFIc+wjEn72nvvfN7DiruMY/jTWEYYRfAvVxBCl2e7hSfcJJOb6SHVN+OP
	 +Frxgnz8YKuIF96j0qsL6ffb5gaHDQ6FGDtbQ/atsVCHzeUvKet41zhjEdQL519yj0
	 QZL8JDvd5S2293wP0JuTTvMYOPcxWhJfMafv81Jm3jfIp2jChdaxLxreYwcuJsJ7l0
	 s5S3dgFLaMELw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 10 Apr 2026 16:31:54 +0200
Subject: [PATCH mptcp-next v2 16/17] selftests: mptcp: pm: use simpler
 send/recv forms
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-mptcp-inc-limits-v2-16-5402209f05d3@kernel.org>
References: <20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org>
In-Reply-To: <20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1778; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=N19jazivXTMDBQM5jY7wG5Ec0mUGbrDn/0Y2kORbl90=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJvcj4N9ryTO2+RR1bH6vDjUZFnE0/lL3kQUrs12HR9w
 dnnjPy/O0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZSVs/IcEBwhdNuX3Nu49Nt
 ERuWn9qj2vtVZ3tH3hW5fMV+9rvWSowMF3t6f3+9tlP11QqGw6fzYu0XH+foOzvt57kTeRPl1UT
 ecwIA
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

