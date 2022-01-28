Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF5A3FD3
	for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 00:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643330331; x=1674866331;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=IBulqfuSBFLGNFY77emSb/EM9M+rD8qDo+li1p7GaAI=;
  b=lCgEqahQxGWwbW3RoU+x4t06UE2K+3eLOcBxqZqvk+4GuYWuYYueLljJ
   RCnRlAEANgKIgDvrC7LowPHXwsxlMcYY42ucp4ZulGQWlyz2NfjR29nwv
   hMRIyVVDsBimMdJzkyIBSZz7Y11Jz4S7Kmm0mA1iXvyIminPazF7bwcnu
   uUTkpmcc2WScHpd7ufUBSUlS+gp81ZRrd47f/vmIC+SZrh0vm4OqNUjzk
   Zsrl4Fy1ggAWhXMzrAQ3fQqUkKirUR3Skn7qFMIqNo0+OjTUlDtntd550
   Hq6InlTNtZwickNTpjKe7R/6YnZjM6CKGecWuQ/7b1k570721Cxuy25sD
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="333358342"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="333358342"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:38:43 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="480527142"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:38:41 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v3 12/14] mptcp: selftests: support MPTCP_PM_CMD_SUBFLOW_DESTROY
Date: Thu, 27 Jan 2022 19:38:34 -0500
Message-Id: <20220128003836.2732694-13-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220128003836.2732694-1-kishen.maloor@intel.com>
References: <20220128003836.2732694-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change updates the "pm_nl_ctl" testing sample with a "dsf"
(destroy subflow) option to support the newly added netlink interface
command MPTCP_PM_CMD_SUBFLOW_DESTROY over the chosen MPTCP connection.

E.g. ./pm_nl_ctl dsf lip 10.0.2.1 lport 44567 rip 10.0.2.2 rport 56789
token 823274047

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 115 ++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 0ba357ab6e4e..8d595b653b11 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -30,6 +30,7 @@ static void syntax(char *argv[])
 	fprintf(stderr, "\tann <local-ip> id <local-id> token <token> [port <local-port>] [dev <name>] [nolisten]\n");
 	fprintf(stderr, "\trem id <local-id> token <token>\n");
 	fprintf(stderr, "\tcsf lip <local-ip> lid <local-id> rip <remote-ip> rport <remote-port> token <token>\n");
+	fprintf(stderr, "\tdsf lip <local-ip> lport <local-port> rip <remote-ip> rport <remote-port> token <token>\n");
 	fprintf(stderr, "\tdel <id> [<ip>]\n");
 	fprintf(stderr, "\tget <id>\n");
 	fprintf(stderr, "\tset <ip> [flags backup|nobackup|fullmesh|nofullmesh] [port <nr>]\n");
@@ -174,6 +175,118 @@ static int resolve_mptcp_pm_netlink(int fd)
 	return genl_parse_getfamily((void *)data);
 }
 
+int dsf(int fd, int pm_family, int argc, char *argv[])
+{
+	char data[NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
+		  NLMSG_ALIGN(sizeof(struct genlmsghdr)) +
+		  1024];
+	struct rtattr *rta, *addr;
+	u_int16_t family, port;
+	struct nlmsghdr *nh;
+	u_int32_t token;
+	int addr_start;
+	int off = 0;
+	int arg;
+
+	const char *params[5];
+
+	memset(params, 0, 5 * sizeof(const char *));
+
+	memset(data, 0, sizeof(data));
+	nh = (void *)data;
+	off = init_genl_req(data, pm_family, MPTCP_PM_CMD_SUBFLOW_DESTROY,
+			    MPTCP_PM_VER);
+
+	if (argc < 12)
+		syntax(argv);
+
+	/* Params recorded in this order:
+	 * <local-ip>, <local-port>, <remote-ip>, <remote-port>, <token>
+	 */
+	for (arg = 2; arg < argc; arg++) {
+		if (!strcmp(argv[arg], "lip")) {
+			if (++arg >= argc)
+				error(1, 0, " missing local IP");
+
+			params[0] = argv[arg];
+		} else if (!strcmp(argv[arg], "lport")) {
+			if (++arg >= argc)
+				error(1, 0, " missing local port");
+
+			params[1] = argv[arg];
+		} else if (!strcmp(argv[arg], "rip")) {
+			if (++arg >= argc)
+				error(1, 0, " missing remote IP");
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
+			error(1, 0, "unknown keyword %s", argv[arg]);
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
+		/*  port */
+		port = atoi(params[arg + 1]);
+		rta = (void *)(data + off);
+		rta->rta_type = MPTCP_PM_ADDR_ATTR_PORT;
+		rta->rta_len = RTA_LENGTH(2);
+		memcpy(RTA_DATA(rta), &port, 2);
+		off += NLMSG_ALIGN(rta->rta_len);
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
 int csf(int fd, int pm_family, int argc, char *argv[])
 {
 	char data[NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
@@ -1075,6 +1188,8 @@ int main(int argc, char *argv[])
 		return remove_addr(fd, pm_family, argc, argv);
 	else if (!strcmp(argv[1], "csf"))
 		return csf(fd, pm_family, argc, argv);
+	else if (!strcmp(argv[1], "dsf"))
+		return dsf(fd, pm_family, argc, argv);
 	else if (!strcmp(argv[1], "del"))
 		return del_addr(fd, pm_family, argc, argv);
 	else if (!strcmp(argv[1], "flush"))
-- 
2.31.1

