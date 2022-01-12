Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369AA2CAB
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 22:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642025775; x=1673561775;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=0PKIoAWBG01b+R+jq+AHrVNak7XFUEjF6B66uXs43o8=;
  b=IqZrlJUaw47+dNjrI+fVxML9CjOy9FKX2963AJLEmeFFs1TyETqpvA8p
   AkHbHWZvjo9WKlWcRVzcKgQ+LQxPdVNNT95/IVKBIcBJmOAdb5oEzAkjI
   iNI95H2cqub6uF/4QZ2doMY51NLuTCs+P8r80S+Ollu2H22qSety2Rukc
   pPpbFmBL0ncmRsfmyr6MgrPqg2l4yLR52Zsfalqm/KRWGjOH1+lrWuRtD
   8Q+zHN2yrlKR/rtqWDoEBZRKhCS6z72YbO/xWtmKZP+KRAy3LaLToe9jx
   0c7RWfNgrcuxh7kh5+rFjLY0PEw6PHB7cRz7fRIsdnaebFxIWUh6Q3SDE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="307213944"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="307213944"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 14:16:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="490907370"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 14:16:07 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 14/21] mptcp: selftests: support MPTCP_PM_CMD_ANNOUNCE
Date: Wed, 12 Jan 2022 17:15:16 -0500
Message-Id: <20220112221523.1829397-15-kishen.maloor@intel.com>
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

This change updates the "pm_nl_ctl" testing sample with an "ann" (announce)
option to support the newly added netlink interface command
MPTCP_PM_CMD_ANNOUNCE to issue ADD_ADDR advertisements over the
chosen MPTCP connection.

E.g. ./pm_nl_ctl ann 192.168.122.75 token 823274047 id 25 dev enp1s0

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 130 ++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 354784512748..76dfb5a8984a 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -6,6 +6,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <limits.h>
 
 #include <sys/socket.h>
 #include <sys/types.h>
@@ -26,6 +27,7 @@ static void syntax(char *argv[])
 {
 	fprintf(stderr, "%s add|get|set|del|flush|dump|accept [<args>]\n", argv[0]);
 	fprintf(stderr, "\tadd [flags signal|subflow|backup|fullmesh] [id <nr>] [dev <name>] <ip>\n");
+	fprintf(stderr, "\tann <local-ip> id <local-id> token <token> [port <local-port>] [dev <name>]\n");
 	fprintf(stderr, "\tdel <id> [<ip>]\n");
 	fprintf(stderr, "\tget <id>\n");
 	fprintf(stderr, "\tset <ip> [flags backup|nobackup]\n");
@@ -170,6 +172,132 @@ static int resolve_mptcp_pm_netlink(int fd)
 	return genl_parse_getfamily((void *)data);
 }
 
+int announce_addr(int fd, int pm_family, int argc, char *argv[])
+{
+	char data[NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
+		  NLMSG_ALIGN(sizeof(struct genlmsghdr)) +
+		  1024];
+	u_int32_t flags = MPTCP_PM_ADDR_FLAG_SIGNAL;
+	u_int32_t token = UINT_MAX;
+	struct rtattr *rta, *addr;
+	u_int32_t id = UINT_MAX;
+	struct nlmsghdr *nh;
+	u_int16_t family;
+	int addr_start;
+	int off = 0;
+	int arg;
+
+	memset(data, 0, sizeof(data));
+	nh = (void *)data;
+	off = init_genl_req(data, pm_family, MPTCP_PM_CMD_ANNOUNCE,
+			    MPTCP_PM_VER);
+
+	if (argc < 7)
+		syntax(argv);
+
+	/* local-ip header */
+	addr_start = off;
+	addr = (void *)(data + off);
+	addr->rta_type = NLA_F_NESTED | MPTCP_PM_ATTR_ADDR;
+	addr->rta_len = RTA_LENGTH(0);
+	off += NLMSG_ALIGN(addr->rta_len);
+
+	/* local-ip data */
+	/* record addr type */
+	rta = (void *)(data + off);
+	if (inet_pton(AF_INET, argv[2], RTA_DATA(rta))) {
+		family = AF_INET;
+		rta->rta_type = MPTCP_PM_ADDR_ATTR_ADDR4;
+		rta->rta_len = RTA_LENGTH(4);
+	} else if (inet_pton(AF_INET6, argv[2], RTA_DATA(rta))) {
+		family = AF_INET6;
+		rta->rta_type = MPTCP_PM_ADDR_ATTR_ADDR6;
+		rta->rta_len = RTA_LENGTH(16);
+	} else
+		error(1, errno, "can't parse ip %s", argv[2]);
+	off += NLMSG_ALIGN(rta->rta_len);
+
+	/* addr family */
+	rta = (void *)(data + off);
+	rta->rta_type = MPTCP_PM_ADDR_ATTR_FAMILY;
+	rta->rta_len = RTA_LENGTH(2);
+	memcpy(RTA_DATA(rta), &family, 2);
+	off += NLMSG_ALIGN(rta->rta_len);
+
+	/* addr flags (..SIGNAL) */
+	rta = (void *)(data + off);
+	rta->rta_type = MPTCP_PM_ADDR_ATTR_FLAGS;
+	rta->rta_len = RTA_LENGTH(4);
+	memcpy(RTA_DATA(rta), &flags, 4);
+	off += NLMSG_ALIGN(rta->rta_len);
+
+	for (arg = 3; arg < argc; arg++) {
+		if (!strcmp(argv[arg], "id")) {
+			/* local-id */
+			if (++arg >= argc)
+				error(1, 0, " missing id value");
+
+			id = atoi(argv[arg]);
+			rta = (void *)(data + off);
+			rta->rta_type = MPTCP_PM_ADDR_ATTR_ID;
+			rta->rta_len = RTA_LENGTH(1);
+			memcpy(RTA_DATA(rta), &id, 1);
+			off += NLMSG_ALIGN(rta->rta_len);
+		} else if (!strcmp(argv[arg], "dev")) {
+			/* for the if_index */
+			int32_t ifindex;
+
+			if (++arg >= argc)
+				error(1, 0, " missing dev name");
+
+			ifindex = if_nametoindex(argv[arg]);
+			if (!ifindex)
+				error(1, errno, "unknown device %s", argv[arg]);
+
+			rta = (void *)(data + off);
+			rta->rta_type = MPTCP_PM_ADDR_ATTR_IF_IDX;
+			rta->rta_len = RTA_LENGTH(4);
+			memcpy(RTA_DATA(rta), &ifindex, 4);
+			off += NLMSG_ALIGN(rta->rta_len);
+		} else if (!strcmp(argv[arg], "port")) {
+			/* local-port (optional) */
+			u_int16_t port;
+
+			if (++arg >= argc)
+				error(1, 0, " missing port value");
+
+			port = atoi(argv[arg]);
+			rta = (void *)(data + off);
+			rta->rta_type = MPTCP_PM_ADDR_ATTR_PORT;
+			rta->rta_len = RTA_LENGTH(2);
+			memcpy(RTA_DATA(rta), &port, 2);
+			off += NLMSG_ALIGN(rta->rta_len);
+		} else if (!strcmp(argv[arg], "token")) {
+			/* MPTCP connection token */
+			if (++arg >= argc)
+				error(1, 0, " missing token value");
+
+			token = atoi(argv[arg]);
+		} else
+			error(1, 0, "unknown keyword %s", argv[arg]);
+	}
+	addr->rta_len = off - addr_start;
+
+	if (id == UINT_MAX || token == UINT_MAX)
+		error(1, 0, " missing mandatory inputs");
+
+	/* token */
+	rta = (void *)(data + off);
+	rta->rta_type = MPTCP_PM_ATTR_TOKEN;
+	rta->rta_len = RTA_LENGTH(4);
+	memcpy(RTA_DATA(rta), &token, 4);
+	off += NLMSG_ALIGN(rta->rta_len);
+
+	do_nl_req(fd, nh, off, 0);
+
+	return 0;
+}
+
 int add_addr(int fd, int pm_family, int argc, char *argv[])
 {
 	char data[NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
@@ -744,6 +872,8 @@ int main(int argc, char *argv[])
 
 	if (!strcmp(argv[1], "add"))
 		return add_addr(fd, pm_family, argc, argv);
+	else if (!strcmp(argv[1], "ann"))
+		return announce_addr(fd, pm_family, argc, argv);
 	else if (!strcmp(argv[1], "del"))
 		return del_addr(fd, pm_family, argc, argv);
 	else if (!strcmp(argv[1], "flush"))
-- 
2.31.1

