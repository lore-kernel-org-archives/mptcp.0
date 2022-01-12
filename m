Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EB82CA3
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 22:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642025778; x=1673561778;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=SpQSoRkJ6B9AFRZXa1jjD1SxMeiy+knK/KaJ3iCYi+8=;
  b=j6H5adKO02VEm/MO+wfFoxczAr/2Dtzkq1znEIkcUa+2YLVjMp7mjVn+
   Pb3u4pdOo9VybpSzGH2CVY1xRQnEDfWXBiOPwYY0zR4uYj/B1+a5MKD2x
   ii55BS2jEi/9Ejr+aKpLeZ0I14aMv+qkk/dlYpUrP0ir3tE/faQ3d/Ut6
   n53x3MDsqwyo1BFFb5bbxuLHazBKmsSb3QHQln7Gdp+NoItfEzNKe7ZKh
   F7bYZfUZO9MUWrtmIOL6beCpswdCrJeGSh7SVTn/D8Xr0dPN0bQRJmzkJ
   678T7Ow/F9DzfFz65uyWviGKrOWuc7+nuzC7XAL+8+iNtZG1ucO7ZyAgS
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="307213952"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="307213952"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 14:16:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="490907391"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 14:16:07 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 20/21] mptcp: selftests: capture netlink events
Date: Wed, 12 Jan 2022 17:15:22 -0500
Message-Id: <20220112221523.1829397-21-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220112221523.1829397-1-kishen.maloor@intel.com>
References: <20220112221523.1829397-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change adds to self-testing support for the MPTCP netlink interface
by capturing various MPTCP netlink events (and all their metadata)
associated with connections, subflows and local address announcements.
It can be incorporated into self-test scripts that exercise the
MPTCP netlink commands to then precisely validate those operations
through the dispatched MPTCP netlink events in response to those
commands.

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 161 +++++++++++++++++-
 1 file changed, 154 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index f28d80895a9c..e770df9b0e2a 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -22,6 +22,9 @@
 #ifndef MPTCP_PM_NAME
 #define MPTCP_PM_NAME		"mptcp_pm"
 #endif
+#ifndef MPTCP_PM_EVENTS
+#define MPTCP_PM_EVENTS		"mptcp_pm_events"
+#endif
 
 static void syntax(char *argv[])
 {
@@ -37,6 +40,7 @@ static void syntax(char *argv[])
 	fprintf(stderr, "\tflush\n");
 	fprintf(stderr, "\tdump\n");
 	fprintf(stderr, "\tlimits [<rcv addr max> <subflow max>]\n");
+	fprintf(stderr, "\tevents\n");
 	exit(0);
 }
 
@@ -88,6 +92,105 @@ static void nl_error(struct nlmsghdr *nh)
 	}
 }
 
+static int capture_events(int fd, int event_group)
+{
+	u_int8_t buffer[NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
+			NLMSG_ALIGN(sizeof(struct genlmsghdr)) + 1024];
+	struct genlmsghdr *ghdr;
+	struct rtattr *attrs;
+	struct nlmsghdr *nh;
+	int ret = 0;
+	int res_len;
+	int msg_len;
+	fd_set rfds;
+
+	if (setsockopt(fd, SOL_NETLINK, NETLINK_ADD_MEMBERSHIP,
+		       &event_group, sizeof(event_group)) < 0)
+		error(1, errno, "could not join the " MPTCP_PM_EVENTS " mcast group");
+
+	do {
+		FD_ZERO(&rfds);
+		FD_SET(fd, &rfds);
+		res_len = NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
+		  NLMSG_ALIGN(sizeof(struct genlmsghdr)) + 1024;
+
+		ret = select(FD_SETSIZE, &rfds, NULL, NULL, NULL);
+
+		if (ret < 0)
+			error(1, ret, "error in select() on NL socket");
+
+		res_len = recv(fd, buffer, res_len, 0);
+		if (res_len < 0)
+			error(1, res_len, "error on recv() from NL socket");
+
+		nh = (struct nlmsghdr *)buffer;
+
+		for (; NLMSG_OK(nh, res_len); nh = NLMSG_NEXT(nh, res_len)) {
+			if (nh->nlmsg_type == NLMSG_ERROR)
+				error(1, NLMSG_ERROR, "received invalid NL message");
+
+			ghdr = (struct genlmsghdr *)NLMSG_DATA(nh);
+
+			if (ghdr->cmd == 0)
+				continue;
+
+			fprintf(stderr, "type:%d", ghdr->cmd);
+
+			msg_len = nh->nlmsg_len - NLMSG_LENGTH(GENL_HDRLEN);
+
+			attrs = (struct rtattr *) ((char *) ghdr + GENL_HDRLEN);
+			while (RTA_OK(attrs, msg_len)) {
+				if (attrs->rta_type == MPTCP_ATTR_TOKEN)
+					fprintf(stderr, ",token:%u", *(__u32 *)RTA_DATA(attrs));
+				else if (attrs->rta_type == MPTCP_ATTR_FAMILY)
+					fprintf(stderr, ",family:%u", *(__u16 *)RTA_DATA(attrs));
+				else if (attrs->rta_type == MPTCP_ATTR_LOC_ID)
+					fprintf(stderr, ",loc_id:%u", *(__u8 *)RTA_DATA(attrs));
+				else if (attrs->rta_type == MPTCP_ATTR_REM_ID)
+					fprintf(stderr, ",rem_id:%u", *(__u8 *)RTA_DATA(attrs));
+				else if (attrs->rta_type == MPTCP_ATTR_SADDR4) {
+					u_int32_t saddr4 = ntohl(*(__u32 *)RTA_DATA(attrs));
+
+					fprintf(stderr, ",saddr4:%u.%u.%u.%u", saddr4 >> 24,
+					       (saddr4 >> 16) & 0xFF, (saddr4 >> 8) & 0xFF,
+					       (saddr4 & 0xFF));
+				} else if (attrs->rta_type == MPTCP_ATTR_SADDR6) {
+					char buf[INET6_ADDRSTRLEN];
+
+					if (inet_ntop(AF_INET6, RTA_DATA(attrs), buf,
+						      sizeof(buf)) != NULL)
+						fprintf(stderr, ",saddr6:%s", buf);
+				} else if (attrs->rta_type == MPTCP_ATTR_DADDR4) {
+					u_int32_t daddr4 = ntohl(*(__u32 *)RTA_DATA(attrs));
+
+					fprintf(stderr, ",daddr4:%u.%u.%u.%u", daddr4 >> 24,
+					       (daddr4 >> 16) & 0xFF, (daddr4 >> 8) & 0xFF,
+					       (daddr4 & 0xFF));
+				} else if (attrs->rta_type == MPTCP_ATTR_DADDR6) {
+					char buf[INET6_ADDRSTRLEN];
+
+					if (inet_ntop(AF_INET6, RTA_DATA(attrs), buf,
+						      sizeof(buf)) != NULL)
+						fprintf(stderr, ",daddr6:%s", buf);
+				} else if (attrs->rta_type == MPTCP_ATTR_SPORT)
+					fprintf(stderr, ",sport:%u",
+						ntohs(*(__u16 *)RTA_DATA(attrs)));
+				else if (attrs->rta_type == MPTCP_ATTR_DPORT)
+					fprintf(stderr, ",dport:%u",
+						ntohs(*(__u16 *)RTA_DATA(attrs)));
+				else if (attrs->rta_type == MPTCP_ATTR_BACKUP)
+					fprintf(stderr, ",backup:%u", *(__u8 *)RTA_DATA(attrs));
+				else if (attrs->rta_type == MPTCP_ATTR_ERROR)
+					fprintf(stderr, ",error:%u", *(__u8 *)RTA_DATA(attrs));
+				attrs = RTA_NEXT(attrs, msg_len);
+			}
+		}
+		fprintf(stderr, "\n");
+	} while (1);
+
+	return 0;
+}
+
 /* do a netlink command and, if max > 0, fetch the reply  */
 static int do_nl_req(int fd, struct nlmsghdr *nh, int len, int max)
 {
@@ -121,11 +224,18 @@ static int do_nl_req(int fd, struct nlmsghdr *nh, int len, int max)
 	return ret;
 }
 
-static int genl_parse_getfamily(struct nlmsghdr *nlh)
+static int genl_parse_getfamily(struct nlmsghdr *nlh, int *pm_family,
+				int *events_mcast_grp)
 {
 	struct genlmsghdr *ghdr = NLMSG_DATA(nlh);
 	int len = nlh->nlmsg_len;
 	struct rtattr *attrs;
+	struct rtattr *grps;
+	struct rtattr *grp;
+	int got_events_grp;
+	int got_family;
+	int grps_len;
+	int grp_len;
 
 	if (nlh->nlmsg_type != GENL_ID_CTRL)
 		error(1, errno, "Not a controller message, len=%d type=0x%x\n",
@@ -140,9 +250,42 @@ static int genl_parse_getfamily(struct nlmsghdr *nlh)
 		error(1, errno, "Unknown controller command %d\n", ghdr->cmd);
 
 	attrs = (struct rtattr *) ((char *) ghdr + GENL_HDRLEN);
+	got_family = 0;
+	got_events_grp = 0;
+
 	while (RTA_OK(attrs, len)) {
-		if (attrs->rta_type == CTRL_ATTR_FAMILY_ID)
-			return *(__u16 *)RTA_DATA(attrs);
+		if (attrs->rta_type == CTRL_ATTR_FAMILY_ID) {
+			*pm_family = *(__u16 *)RTA_DATA(attrs);
+			got_family = 1;
+		} else if (attrs->rta_type == CTRL_ATTR_MCAST_GROUPS) {
+			grps = RTA_DATA(attrs);
+			grps_len = RTA_PAYLOAD(attrs);
+
+			while (RTA_OK(grps, grps_len)) {
+				grp = RTA_DATA(grps);
+				grp_len = RTA_PAYLOAD(grps);
+				got_events_grp = 0;
+
+				while (RTA_OK(grp, grp_len)) {
+					if (grp->rta_type == CTRL_ATTR_MCAST_GRP_ID)
+						*events_mcast_grp = *(__u32 *)RTA_DATA(grp);
+					else if (grp->rta_type == CTRL_ATTR_MCAST_GRP_NAME &&
+						 !strcmp(RTA_DATA(grp), MPTCP_PM_EVENTS))
+						got_events_grp = 1;
+
+					grp = RTA_NEXT(grp, grp_len);
+				}
+
+				if (got_events_grp)
+					break;
+
+				grps = RTA_NEXT(grps, grps_len);
+			}
+		}
+
+		if (got_family && got_events_grp)
+			return 0;
+
 		attrs = RTA_NEXT(attrs, len);
 	}
 
@@ -150,7 +293,7 @@ static int genl_parse_getfamily(struct nlmsghdr *nlh)
 	return -1;
 }
 
-static int resolve_mptcp_pm_netlink(int fd)
+static int resolve_mptcp_pm_netlink(int fd, int *pm_family, int *events_mcast_grp)
 {
 	char data[NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
 		  NLMSG_ALIGN(sizeof(struct genlmsghdr)) +
@@ -172,7 +315,7 @@ static int resolve_mptcp_pm_netlink(int fd)
 	off += NLMSG_ALIGN(rta->rta_len);
 
 	do_nl_req(fd, nh, off, sizeof(data));
-	return genl_parse_getfamily((void *)data);
+	return genl_parse_getfamily((void *)data, pm_family, events_mcast_grp);
 }
 
 int dsf(int fd, int pm_family, int argc, char *argv[])
@@ -1149,7 +1292,9 @@ int set_flags(int fd, int pm_family, int argc, char *argv[])
 
 int main(int argc, char *argv[])
 {
-	int fd, pm_family;
+	int events_mcast_grp;
+	int pm_family;
+	int fd;
 
 	if (argc < 2)
 		syntax(argv);
@@ -1158,7 +1303,7 @@ int main(int argc, char *argv[])
 	if (fd == -1)
 		error(1, errno, "socket netlink");
 
-	pm_family = resolve_mptcp_pm_netlink(fd);
+	resolve_mptcp_pm_netlink(fd, &pm_family, &events_mcast_grp);
 
 	if (!strcmp(argv[1], "add"))
 		return add_addr(fd, pm_family, argc, argv);
@@ -1182,6 +1327,8 @@ int main(int argc, char *argv[])
 		return get_set_limits(fd, pm_family, argc, argv);
 	else if (!strcmp(argv[1], "set"))
 		return set_flags(fd, pm_family, argc, argv);
+	else if (!strcmp(argv[1], "events"))
+		return capture_events(fd, events_mcast_grp);
 
 	fprintf(stderr, "unknown sub-command: %s", argv[1]);
 	syntax(argv);
-- 
2.31.1

