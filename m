Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055262CA3
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 22:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642025776; x=1673561776;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Ss88/Z8cZv+ydYrIK8WiMimZ5J5bKagfo/OUsPdr2NA=;
  b=O4BAJ/HeXievmtsKhhEXo14/HvdihK7ktVJm4cCedatb5LaxY/g+8B3i
   zPe1+fOWpQHOw+rw7Z0w1tqPgngj28tmzhyoMQt0Y7yPaNpN1NQSlmj5D
   g9qTXoP8j0jvVffu4qKlTAH6phh9MJnwHQf08/+VYmF5Fph7CP1pc9UVO
   AUFjT7MKYTT4OVAtNvgKjmyVYXGbBg5rPL/3UVt3oPKv+ccVMjn1STGha
   42c8qSM2q3hyGUe/KQeKJ2A88FMTY3CjGKDbrytYQnfIrr/XFghyx7Z6l
   Rox9VU9ae5DvOKTPvQ+xRp4VC1KAB3VAdD0dCh0jDLE1Zujrt/oo8qdua
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="307213948"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="307213948"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 14:16:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="490907380"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 14:16:07 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 18/21] mptcp: selftests: support MPTCP_PM_CMD_SUBFLOW_CREATE
Date: Wed, 12 Jan 2022 17:15:20 -0500
Message-Id: <20220112221523.1829397-19-kishen.maloor@intel.com>
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

This change updates the "pm_nl_ctl" testing sample with a "csf"
(create subflow) option to support the newly added netlink interface
command MPTCP_PM_CMD_SUBFLOW_CREATE over the chosen MPTCP connection.

E.g. ./pm_nl_ctl csf lip 10.0.2.1 lid 23 rip 10.0.2.2 rport 56789
token 823274047

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 129 ++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 8892bf16693a..e3ae1d851a39 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -29,6 +29,7 @@ static void syntax(char *argv[])
 	fprintf(stderr, "\tadd [flags signal|subflow|backup|fullmesh] [id <nr>] [dev <name>] <ip>\n");
 	fprintf(stderr, "\tann <local-ip> id <local-id> token <token> [port <local-port>] [dev <name>]\n");
 	fprintf(stderr, "\trem id <local-id> token <token>\n");
+	fprintf(stderr, "\tcsf lip <local-ip> lid <local-id> rip <remote-ip> rport <remote-port> token <token>\n");
 	fprintf(stderr, "\tdel <id> [<ip>]\n");
 	fprintf(stderr, "\tget <id>\n");
 	fprintf(stderr, "\tset <ip> [flags backup|nobackup]\n");
@@ -173,6 +174,132 @@ static int resolve_mptcp_pm_netlink(int fd)
 	return genl_parse_getfamily((void *)data);
 }
 
+int csf(int fd, int pm_family, int argc, char *argv[])
+{
+	char data[NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
+		  NLMSG_ALIGN(sizeof(struct genlmsghdr)) +
+		  1024];
+	const char *params[5];
+	struct nlmsghdr *nh;
+	struct rtattr *addr;
+	struct rtattr *rta;
+	u_int16_t family;
+	u_int32_t token;
+	u_int16_t port;
+	int addr_start;
+	u_int8_t id;
+	int off = 0;
+	int arg;
+
+	memset(params, 0, 5 * sizeof(const char *));
+
+	memset(data, 0, sizeof(data));
+	nh = (void *)data;
+	off = init_genl_req(data, pm_family, MPTCP_PM_CMD_SUBFLOW_CREATE,
+			    MPTCP_PM_VER);
+
+	if (argc < 12)
+		syntax(argv);
+
+	/* Params recorded in this order:
+	 * <local-ip>, <local-id>, <remote-ip>, <remote-port>, <token>
+	 */
+	for (arg = 2; arg < argc; arg++) {
+		if (!strcmp(argv[arg], "lip")) {
+			if (++arg >= argc)
+				error(1, 0, " missing local IP");
+
+			params[0] = argv[arg];
+		} else if (!strcmp(argv[arg], "lid")) {
+			if (++arg >= argc)
+				error(1, 0, " missing local id");
+
+			params[1] = argv[arg];
+		} else if (!strcmp(argv[arg], "rip")) {
+			if (++arg >= argc)
+				error(1, 0, " missing remote ip");
+
+			params[2] = argv[arg];
+		} else if (!strcmp(argv[arg], "rport")) {
+			if (++arg >= argc)
+				error(1, 0, " missing remote port");
+
+			params[3] = argv[arg];
+		} else if (!strcmp(argv[arg], "token")) {
+			if (++arg >= argc)
+				error(1, 0, " missing token");
+
+			params[4] = argv[arg];
+		} else
+			error(1, 0, "unknown param %s", argv[arg]);
+	}
+
+	for (arg = 0; arg < 4; arg = arg + 2) {
+		/*  addr header */
+		addr_start = off;
+		addr = (void *)(data + off);
+		addr->rta_type = NLA_F_NESTED |
+			((arg == 0) ? MPTCP_PM_ATTR_ADDR : MPTCP_PM_ATTR_ADDR_REMOTE);
+		addr->rta_len = RTA_LENGTH(0);
+		off += NLMSG_ALIGN(addr->rta_len);
+
+		/*  addr data */
+		rta = (void *)(data + off);
+		if (inet_pton(AF_INET, params[arg], RTA_DATA(rta))) {
+			family = AF_INET;
+			rta->rta_type = MPTCP_PM_ADDR_ATTR_ADDR4;
+			rta->rta_len = RTA_LENGTH(4);
+		} else if (inet_pton(AF_INET6, params[arg], RTA_DATA(rta))) {
+			family = AF_INET6;
+			rta->rta_type = MPTCP_PM_ADDR_ATTR_ADDR6;
+			rta->rta_len = RTA_LENGTH(16);
+		} else
+			error(1, errno, "can't parse ip %s", params[arg]);
+		off += NLMSG_ALIGN(rta->rta_len);
+
+		/* family */
+		rta = (void *)(data + off);
+		rta->rta_type = MPTCP_PM_ADDR_ATTR_FAMILY;
+		rta->rta_len = RTA_LENGTH(2);
+		memcpy(RTA_DATA(rta), &family, 2);
+		off += NLMSG_ALIGN(rta->rta_len);
+
+		if (arg == 2) {
+			/*  port */
+			port = atoi(params[arg + 1]);
+			rta = (void *)(data + off);
+			rta->rta_type = MPTCP_PM_ADDR_ATTR_PORT;
+			rta->rta_len = RTA_LENGTH(2);
+			memcpy(RTA_DATA(rta), &port, 2);
+			off += NLMSG_ALIGN(rta->rta_len);
+		}
+
+		if (arg == 0) {
+			/* id */
+			id = atoi(params[arg + 1]);
+			rta = (void *)(data + off);
+			rta->rta_type = MPTCP_PM_ADDR_ATTR_ID;
+			rta->rta_len = RTA_LENGTH(1);
+			memcpy(RTA_DATA(rta), &id, 1);
+			off += NLMSG_ALIGN(rta->rta_len);
+		}
+
+		addr->rta_len = off - addr_start;
+	}
+
+	/* token */
+	token = atoi(params[4]);
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
 int remove_addr(int fd, int pm_family, int argc, char *argv[])
 {
 	char data[NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
@@ -926,6 +1053,8 @@ int main(int argc, char *argv[])
 		return announce_addr(fd, pm_family, argc, argv);
 	else if (!strcmp(argv[1], "rem"))
 		return remove_addr(fd, pm_family, argc, argv);
+	else if (!strcmp(argv[1], "csf"))
+		return csf(fd, pm_family, argc, argv);
 	else if (!strcmp(argv[1], "del"))
 		return del_addr(fd, pm_family, argc, argv);
 	else if (!strcmp(argv[1], "flush"))
-- 
2.31.1

