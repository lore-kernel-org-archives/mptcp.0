Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545583D76
	for <mptcp@lists.linux.dev>; Thu,  7 Apr 2022 23:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649374842; x=1680910842;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=tfzehsJBmGdChZMPc0RL5lKqpr+R150YHyu/cK7Z6gI=;
  b=NVBg7gVTnsP3/lkfG7d15V3oLwtvJng9TiFaSAc1zP1Y7Bn/4ethpTim
   RPG2r/ZShVRn5aaGjmhjAfXm0+XksSzF4tiTvicTfGKJAwLk6FLeZv0z0
   urnI403KxjUPWAD6VZYJ8qQOL17BYcrLHyOXCIwr7kjIFgLCkGxsfoCVC
   czFpeHDmQvRU1FEAuqmW34BqUTXCgz0pzYvT1S3VZVl2sR4962HT9EcrE
   3WJTz4ZUECy+pEavAX3v0vstbmLuAtRDcEvDNLzZG3a2I9UXe4DWiPpIH
   sI1eZOF/MNCu57L9oVWpWATIePxA3fssH7ZrB+uM6FZiZEfmRuZmymrOF
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="259062021"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="259062021"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 16:40:37 -0700
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="571270974"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 16:40:36 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v8 13/14] selftests: mptcp: create listeners to receive MPJs
Date: Thu,  7 Apr 2022 19:40:28 -0400
Message-Id: <20220407234029.1774481-14-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220407234029.1774481-1-kishen.maloor@intel.com>
References: <20220407234029.1774481-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change updates the "pm_nl_ctl" testing sample with a
"listen" option to bind a MPTCP listening socket to the
provided addr+port. This option is exercised in testing
subflow initiation scenarios in conjunction with userspace
path managers where the MPTCP application does not hold an
active listener to accept requests for new subflows.

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index f881d8548153..6a2f4b981e1d 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -25,6 +25,9 @@
 #ifndef MPTCP_PM_EVENTS
 #define MPTCP_PM_EVENTS		"mptcp_pm_events"
 #endif
+#ifndef IPPROTO_MPTCP
+#define IPPROTO_MPTCP 262
+#endif
 
 static void syntax(char *argv[])
 {
@@ -41,6 +44,7 @@ static void syntax(char *argv[])
 	fprintf(stderr, "\tdump\n");
 	fprintf(stderr, "\tlimits [<rcv addr max> <subflow max>]\n");
 	fprintf(stderr, "\tevents\n");
+	fprintf(stderr, "\tlisten <local-ip> <local-port>\n");
 	exit(0);
 }
 
@@ -1219,6 +1223,54 @@ int get_set_limits(int fd, int pm_family, int argc, char *argv[])
 	return 0;
 }
 
+int add_listener(int argc, char *argv[])
+{
+	struct sockaddr_storage addr;
+	struct sockaddr_in6 *a6;
+	struct sockaddr_in *a4;
+	u_int16_t family;
+	int enable = 1;
+	int sock;
+	int err;
+
+	if (argc < 4)
+		syntax(argv);
+
+	memset(&addr, 0, sizeof(struct sockaddr_storage));
+	a4 = (struct sockaddr_in *)&addr;
+	a6 = (struct sockaddr_in6 *)&addr;
+
+	if (inet_pton(AF_INET, argv[2], &a4->sin_addr)) {
+		family = AF_INET;
+		a4->sin_family = family;
+		a4->sin_port = htons(atoi(argv[3]));
+	} else if (inet_pton(AF_INET6, argv[2], &a6->sin6_addr)) {
+		family = AF_INET6;
+		a6->sin6_family = family;
+		a6->sin6_port = htons(atoi(argv[3]));
+	} else
+		error(1, errno, "can't parse ip %s", argv[2]);
+
+	sock = socket(family, SOCK_STREAM, IPPROTO_MPTCP);
+	if (sock < 0)
+		error(1, errno, "can't create listener sock\n");
+
+	if (setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &enable, sizeof(enable))) {
+		close(sock);
+		error(1, errno, "can't set SO_REUSEADDR on listener sock\n");
+	}
+
+	err = bind(sock, (struct sockaddr *)&addr,
+		   ((family == AF_INET) ? sizeof(struct sockaddr_in) :
+		    sizeof(struct sockaddr_in6)));
+
+	if (err == 0 && listen(sock, 30) == 0)
+		pause();
+
+	close(sock);
+	return 0;
+}
+
 int set_flags(int fd, int pm_family, int argc, char *argv[])
 {
 	char data[NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
@@ -1375,6 +1427,8 @@ int main(int argc, char *argv[])
 		return set_flags(fd, pm_family, argc, argv);
 	else if (!strcmp(argv[1], "events"))
 		return capture_events(fd, events_mcast_grp);
+	else if (!strcmp(argv[1], "listen"))
+		return add_listener(argc, argv);
 
 	fprintf(stderr, "unknown sub-command: %s", argv[1]);
 	syntax(argv);
-- 
2.31.1

