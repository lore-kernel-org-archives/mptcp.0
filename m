Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C33020EC
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 02:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651631953; x=1683167953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T5xudkTKsji2a3B8PwGdmyEVMiXPAnvn3ha+3QnNmE0=;
  b=aeb+qo0VdAhAI6lCFkWwHqeOh4wSS0f35/r4JZ6qYDxZeS+fUCrJJKos
   oFUd+1pQ0xkW9Luo/H+gts9nCHqYNsI9s1fq9P4wFOkrGx+AeI7EKnE5N
   A/sNcNJSh48CJyGW5eDmv1Gt8/WjTnB59bnprflqRkAL0NLnoilMtLAyN
   z/fDrbUyxhA8jGVxTbiU5H8+3Jy357KlhTUN59kCqEaZQZ8PfY9/W3Hj/
   yexI2uPlgwoODYwdZDV9Yb7bvgL1plTG5sWEd7FVrl1/7m2uHGGRwvIBd
   CTPwxI/jcuLxDazHDlyhjw1vfDJ7QOJlE9lg1UfDWbvi7n0yhCdeitkHf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="266488772"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="266488772"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 19:39:08 -0700
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="584493394"
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
Subject: [PATCH net-next 09/13] selftests: mptcp: support MPTCP_PM_CMD_SUBFLOW_CREATE
Date: Tue,  3 May 2022 19:38:57 -0700
Message-Id: <20220504023901.277012-10-mathew.j.martineau@linux.intel.com>
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

This change updates the "pm_nl_ctl" testing sample with a "csf"
(create subflow) option to support the newly added netlink interface
command MPTCP_PM_CMD_SUBFLOW_CREATE over the chosen MPTCP connection.

E.g. ./pm_nl_ctl csf lip 10.0.2.1 lid 23 rip 10.0.2.2 rport 56789
token 823274047

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 129 ++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 3506b0416c41..e2437bacd133 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -29,6 +29,7 @@ static void syntax(char *argv[])
 	fprintf(stderr, "\tadd [flags signal|subflow|backup|fullmesh] [id <nr>] [dev <name>] <ip>\n");
 	fprintf(stderr, "\tann <local-ip> id <local-id> token <token> [port <local-port>] [dev <name>]\n");
 	fprintf(stderr, "\trem id <local-id> token <token>\n");
+	fprintf(stderr, "\tcsf lip <local-ip> lid <local-id> rip <remote-ip> rport <remote-port> token <token>\n");
 	fprintf(stderr, "\tdel <id> [<ip>]\n");
 	fprintf(stderr, "\tget <id>\n");
 	fprintf(stderr, "\tset [<ip>] [id <nr>] flags [no]backup|[no]fullmesh [port <nr>]\n");
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
@@ -969,6 +1096,8 @@ int main(int argc, char *argv[])
 		return announce_addr(fd, pm_family, argc, argv);
 	else if (!strcmp(argv[1], "rem"))
 		return remove_addr(fd, pm_family, argc, argv);
+	else if (!strcmp(argv[1], "csf"))
+		return csf(fd, pm_family, argc, argv);
 	else if (!strcmp(argv[1], "del"))
 		return del_addr(fd, pm_family, argc, argv);
 	else if (!strcmp(argv[1], "flush"))
-- 
2.36.0

