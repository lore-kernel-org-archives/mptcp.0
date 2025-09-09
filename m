Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961003D984
	for <mptcp@lists.linux.dev>; Tue,  9 Sep 2025 16:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435442; cv=none; b=kHAZhb8hW7kyPwcurCIFKRTZGm7aRaaW5AUz0LdgsCJhqBusb/JehmkU+9FWctwn8QxET01OYkuJpf65gHdss3J13mNhEWvLyyYqFvhYsZQUUICSQZKTWJPVVhchwqo2aETqvhQxXh651T+MjSWp/0H4yeNJYtYqcp8/jlpost0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435442; c=relaxed/simple;
	bh=TMOFE5nuTKyPJ8OJFYpeW0rNQZRbN40e/gGdyr60250=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ErD+dGk3PA9QQoW/rQdJZGRAv5xHjJUQnS344C+BLQPCKXP8BMFROKH8Rl9YU/p2cztmmEy1Pts7JP/Ii1ktIe57skHV32vM5ncPz6vkP92XYzwcV7cw6J5XK4vo9dS03nXZDGLUHm+bQu8NIDoWlMVsALeMjaCD4hG6bmyWOEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsQIYUUg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsQIYUUg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1ADFC4CEF8;
	Tue,  9 Sep 2025 16:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757435442;
	bh=TMOFE5nuTKyPJ8OJFYpeW0rNQZRbN40e/gGdyr60250=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hsQIYUUgJVkbrQFWO7TqzIUg5rXoANY4h+XGlhoOATCRswtmP0sCPcB5n3SYeR/sL
	 XELIieou4gSwnrrJ2O2iz7soiTgzSEq2nzYPLNx48y66JX4Pa909giWKbxIZotrRiv
	 LVl/0nRRfuYAd006JHKatiYNZytiyxRRGYJa6CqAZAfoLzYsdG0QtzM3Hxelxxc50f
	 5IFrHDPdMRk31hdrRgk7EbQxet+0nV7kF56dohKnDjodukSW6syBqDIoF+OxxVPHUj
	 wsOgvOJWW3SBmSvGVD7HzqFaIRRo2YkNFOIsQXqhJQwWfluHjsPoFDqyqiQuuXLc/m
	 ihFCHclRvxbig==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 09 Sep 2025 18:30:16 +0200
Subject: [PATCH mptcp-next 4/4] selftests: mptcp: pm: get server-side flag
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-mptcp-pm-user-server-side-flag-v1-4-cb8e2b8d1c0c@kernel.org>
References: <20250909-mptcp-pm-user-server-side-flag-v1-0-cb8e2b8d1c0c@kernel.org>
In-Reply-To: <20250909-mptcp-pm-user-server-side-flag-v1-0-cb8e2b8d1c0c@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2068; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=TMOFE5nuTKyPJ8OJFYpeW0rNQZRbN40e/gGdyr60250=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIOhOmetJ0tY7Lb/H5w3MJ/eVs/2lesvnFE2cNV6K5Zy
 2Xf+0x1HaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABPRSWb4Z7xqYd7JuRbn9jIx
 p+dI2E1/wRz/dn5v5bLIC7ynN//iNWVkmLQpVn+vWeLVza6525bMal12Pnnz8U7nzb8CtuRr69Q
 c4wYA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

server-side info linked to the MPTCP connect/established events can now
come from the flags, in addition to the dedicated attribute.

The attribute is now deprecated -- in favour of the new flag, and will
be removed later on.

Print this info only once.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 93fea3442216c8fef43731a99c1d5710f234b150..d4981b76693bbddca74169437a540ad6294cf1d5 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -2,6 +2,7 @@
 
 #include <errno.h>
 #include <error.h>
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -113,6 +114,8 @@ static int capture_events(int fd, int event_group)
 		error(1, errno, "could not join the " MPTCP_PM_EV_GRP_NAME " mcast group");
 
 	do {
+		bool server_side = false;
+
 		FD_ZERO(&rfds);
 		FD_SET(fd, &rfds);
 		res_len = NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
@@ -187,18 +190,22 @@ static int capture_events(int fd, int event_group)
 				else if (attrs->rta_type == MPTCP_ATTR_ERROR)
 					fprintf(stderr, ",error:%u", *(__u8 *)RTA_DATA(attrs));
 				else if (attrs->rta_type == MPTCP_ATTR_SERVER_SIDE)
-					fprintf(stderr, ",server_side:%u", *(__u8 *)RTA_DATA(attrs));
+					server_side = !!*(__u8 *)RTA_DATA(attrs);
 				else if (attrs->rta_type == MPTCP_ATTR_FLAGS) {
 					__u16 flags = *(__u16 *)RTA_DATA(attrs);
 
 					/* only print when present, easier */
 					if (flags & MPTCP_PM_EV_FLAG_DENY_JOIN_ID0)
 						fprintf(stderr, ",deny_join_id0:1");
+					if (flags & MPTCP_PM_EV_FLAG_SERVER_SIDE)
+						server_side = true;
 				}
 
 				attrs = RTA_NEXT(attrs, msg_len);
 			}
 		}
+		if (server_side)
+			fprintf(stderr, ",server_side:1");
 		fprintf(stderr, "\n");
 	} while (1);
 

-- 
2.51.0

