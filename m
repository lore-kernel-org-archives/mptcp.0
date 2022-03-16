Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506C13B38
	for <mptcp@lists.linux.dev>; Wed, 16 Mar 2022 19:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647457700; x=1678993700;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=6tUEGEq7qfMExdibwnnCI5ns47dsvrSupHUEhvsxv/Y=;
  b=UYUGT3Q4RNIJxLKiPEWS8mwyTWGTeuHWZtLHPQaSr06qfzCQ7TC/Gr6+
   RGe8AcIvGufNCD29kDQmpQxg0DXqCUB9IkmbmfCbUsAuhB9DQhnO66q62
   gBwIL1IXPWXmRkI37AnpdK6a+Khvj+aHFebtZ52iRiybMFgSwCJV/hC7U
   17osHpol0z7rKPR/jxOK7nYpx9u2HrQNQud42tgQQF+9/W2piQoT6YaeQ
   AE6qb/A7+axiTMIHN+kIBL4XuLaEHqDwPkQ956Zkyr2T3AHM6PeLc4vuI
   O5GNW0vcD2w5fOf1dY5QqVBDQG/ticsChNQx0EwuryACZjBQsuRqaHthj
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="256880335"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="256880335"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 12:08:18 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="557595352"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 12:08:18 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 13/14] selftests: mptcp: create listeners to receive MPJs
Date: Wed, 16 Mar 2022 15:08:12 -0400
Message-Id: <20220316190813.634423-14-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220316190813.634423-1-kishen.maloor@intel.com>
References: <20220316190813.634423-1-kishen.maloor@intel.com>
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
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index f881d8548153..fc1843f9a35e 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -41,6 +41,7 @@ static void syntax(char *argv[])
 	fprintf(stderr, "\tdump\n");
 	fprintf(stderr, "\tlimits [<rcv addr max> <subflow max>]\n");
 	fprintf(stderr, "\tevents\n");
+	fprintf(stderr, "\tlisten <local-ip> <local-port>\n");
 	exit(0);
 }
 
@@ -1219,6 +1220,54 @@ int get_set_limits(int fd, int pm_family, int argc, char *argv[])
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
@@ -1375,6 +1424,8 @@ int main(int argc, char *argv[])
 		return set_flags(fd, pm_family, argc, argv);
 	else if (!strcmp(argv[1], "events"))
 		return capture_events(fd, events_mcast_grp);
+	else if (!strcmp(argv[1], "listen"))
+		return add_listener(argc, argv);
 
 	fprintf(stderr, "unknown sub-command: %s", argv[1]);
 	syntax(argv);
-- 
2.31.1

