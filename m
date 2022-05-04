Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678B820EE
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 02:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651631950; x=1683167950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sW7hf1a4QtQVlP6hNueUerYRWH19zVXDJGN2cz//nbQ=;
  b=hnYuClM/YS4lS8p+QatkQqotGbeZeY1tQDaPBfLu8lIvoVbE/cQ91F5Z
   n4uBtSE1UrIveq7fNSvw60hWJ4WrEwZh3M5JuMp8tuZuy0PEVqfxyaMy8
   Ck3gX5oWvOqkjQ1HZFZS34Hu8lFuE9mwyfDedTqu2wEBssGgJRdrRTTZC
   BAgc1Oqmx9yUlx3bYzxddJhFXmfhgv8gR/eQi/Ppu6RJTTXC2l3ew2NOS
   ctJespZ4sYzqlcb5qSZ0qhpsgtSQCUPUE+ACmRu28tyeCoXV76OKsemoF
   Gmy6Rb7//haCw6IXDgNrbEt+bX82BO/116XWRHisKDdzYi76U7jJW2nAK
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="255109477"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="255109477"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 19:39:08 -0700
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="584493405"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.20.240])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 19:39:08 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Kishen Maloor <kishen.maloor@intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 12/13] selftests: mptcp: create listeners to receive MPJs
Date: Tue,  3 May 2022 19:39:00 -0700
Message-Id: <20220504023901.277012-13-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220504023901.277012-1-mathew.j.martineau@linux.intel.com>
References: <20220504023901.277012-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kishen Maloor <kishen.maloor@intel.com>

This change updates the "pm_nl_ctl" testing sample with a
"listen" option to bind a MPTCP listening socket to the
provided addr+port. This option is exercised in testing
subflow initiation scenarios in conjunction with userspace
path managers where the MPTCP application does not hold an
active listener to accept requests for new subflows.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
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
2.36.0

