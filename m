Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4686633B6D3
	for <mptcp@lists.linux.dev>; Thu,  9 Apr 2026 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775767944; cv=none; b=KosS5SjAQdspHhOHmnEffYgAhxmU9boOxTCyJwiKBBC70T7MtzoQ/GjokkRoZXvDf/LjXqRluV9ctOgQ6d4BH0VmOC4djWu758HhjK3aebJZUYZgwxzgsYHXZwfNPag+nWV/28vLAWf6o5s0rRtZl3laPB+nMHrpWetyJcNxUz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775767944; c=relaxed/simple;
	bh=rZgdK6x7VRpDG0CW+9Lf+hi62t5lY+M3VrlMGSAOWxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=huxi6nWnYdVkvRH5/6QAJqrPCFpW+oFNfaldPVmyE2CaNlhtAFULJ+Ofvfg1GT2mpTfZ1A6MbX0VeQ0YKIXgscNhMDOmLSEqxxvG/M4ipdhNEwmS2QYJ96L6oH5KOgCC+nq0yn68sOkpljts/GNd0jP5tp/YCf/0gZMtE1WQAyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/57ub6S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/57ub6S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85FF2C2BCB2;
	Thu,  9 Apr 2026 20:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775767943;
	bh=rZgdK6x7VRpDG0CW+9Lf+hi62t5lY+M3VrlMGSAOWxY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H/57ub6SxmIZ2FVjkG3wwK5YSMoLVL3jqEP9Iilx2Iw2QkVNRN6hcSfmlnSmD01lh
	 OjBRgJRIQK9Dl3FOtL98fIDsRUYOoDGlJ4+mK7/JvXkn1dD77yF4z2IG8pCyzokSko
	 21T++7dISSl0CvxUVzTeZJ4ATS82XN/eTUzLhj3+RdYno+xjbnIU9BM78aK8+MpJsG
	 jR8hCZFYRJyyafddLuB+7zroTWcTOUlHgxHc2zUilG0UKNn4YLxIQsWW+fT9ft4qW0
	 nGQl7VmPgJ/7qMYk+mLwtfO0DUiQ4xiRjnl55tj0sopSVH2KO0iUONF+AmAV1uK+yG
	 9HsO3iDwCbZCQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 09 Apr 2026 22:51:55 +0200
Subject: [PATCH mptcp-next 15/16] selftests: mptcp: pm: use simpler
 send/recv forms
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-mptcp-inc-limits-v1-15-0e45fa30d914@kernel.org>
References: <20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org>
In-Reply-To: <20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1455; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=rZgdK6x7VRpDG0CW+9Lf+hi62t5lY+M3VrlMGSAOWxY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJvCFYxuug/4m7Y+9PGyGtybuQaq129uWxtpxSeuFumM
 3AWNbzrKGVhEONikBVTZJFui8yf+byKt8TLzwJmDisTyBAGLk4BmMiJKQz/k6KZlMp9T967fnSu
 1qqg3sAZ+7r/nvquNeN+btf81Te23GZk6FJOCfYzrVJg3KL4XSesh7Ph5ObeZUJrj/ZHlNQbT69
 gAAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Instead of sendto() and recvfrom() which the NL address that was already
provided before.

Just simpler and easier to read.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 99eecccbf0c8..439b22f88c93 100644
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
@@ -230,12 +228,11 @@ static int do_nl_req(int fd, struct nlmsghdr *nh, int len, int max)
 	}
 
 	nh->nlmsg_len = len;
-	ret = sendto(fd, data, len, 0, (void *)&nladdr, sizeof(nladdr));
+	ret = send(fd, data, len, 0);
 	if (ret != len)
 		error(1, errno, "send netlink: %uB != %uB\n", ret, len);
 
-	addr_len = sizeof(nladdr);
-	rem = ret = recvfrom(fd, data, max, 0, (void *)&nladdr, &addr_len);
+	rem = ret = recv(fd, data, max, 0);
 	if (ret < 0)
 		error(1, errno, "recv netlink: %uB\n", ret);
 

-- 
2.53.0

