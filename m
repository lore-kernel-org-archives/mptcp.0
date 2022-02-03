Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972282CA6
	for <mptcp@lists.linux.dev>; Thu,  3 Feb 2022 03:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643858053; x=1675394053;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=C4l3p6tFPmwIdITMHYdRnSwVY78HGRvYQSgg/UPc39c=;
  b=WWGKUjbFYRz6bSfwGlz8M/jfDB/15blO2dPcz69MUKJ9szq2LQWydxpJ
   MwbyePzdoLpxoWlIXlVxTmGEdXTnzvK29gfRbJ0UPXHzR3PKXoJZwTIvE
   WA1LKtJR0ByKTMczwg57WzJsXZY45v/UPAJeRmQCPcyWYErMCxiw5VmhL
   RJsrCu0fXBWoATbwbGVH/T+Eyuvj7tvIrIJnzQJkY4Nk5ELgWUwAB9wwO
   imPlEe+c+RtZRsTkcxVYjZLm4nTY2Pnn+o2WLhjEyTARtAEvxX+iQWEru
   jBSayaMxZppw8ISefHY1BsvD2i7rAXeMEy9EwHSZKI4qZZY/axUWC84YF
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="235467503"
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="235467503"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 19:14:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="631204639"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 19:14:09 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v4 08/13] mptcp: selftests: support MPTCP_PM_CMD_REMOVE
Date: Wed,  2 Feb 2022 22:13:58 -0500
Message-Id: <20220203031403.2996549-9-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220203031403.2996549-1-kishen.maloor@intel.com>
References: <20220203031403.2996549-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change updates the "pm_nl_ctl" testing sample with a "rem" (remove)
option to support the newly added netlink interface command
MPTCP_PM_CMD_REMOVE to issue REMOVE_ADDR signals over the
chosen MPTCP connection.

E.g. ./pm_nl_ctl rem token 823274047 id 23

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 0044fdc461ff..56759d9883c9 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -28,6 +28,7 @@ static void syntax(char *argv[])
 	fprintf(stderr, "%s add|get|set|del|flush|dump|accept [<args>]\n", argv[0]);
 	fprintf(stderr, "\tadd [flags signal|subflow|backup|fullmesh|nolisten] [id <nr>] [dev <name>] <ip>\n");
 	fprintf(stderr, "\tann <local-ip> id <local-id> token <token> [port <local-port>] [dev <name>] [nolisten]\n");
+	fprintf(stderr, "\trem id <local-id> token <token>\n");
 	fprintf(stderr, "\tdel <id> [<ip>]\n");
 	fprintf(stderr, "\tget <id>\n");
 	fprintf(stderr, "\tset [<ip>] [id <nr>] flags [no]backup|[no]fullmesh [port <nr>]\n");
@@ -172,6 +173,55 @@ static int resolve_mptcp_pm_netlink(int fd)
 	return genl_parse_getfamily((void *)data);
 }
 
+int remove_addr(int fd, int pm_family, int argc, char *argv[])
+{
+	char data[NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
+		  NLMSG_ALIGN(sizeof(struct genlmsghdr)) +
+		  1024];
+	struct nlmsghdr *nh;
+	struct rtattr *rta;
+	u_int32_t token;
+	u_int8_t id;
+	int off = 0;
+	int arg;
+
+	memset(data, 0, sizeof(data));
+	nh = (void *)data;
+	off = init_genl_req(data, pm_family, MPTCP_PM_CMD_REMOVE,
+			    MPTCP_PM_VER);
+
+	if (argc < 6)
+		syntax(argv);
+
+	for (arg = 2; arg < argc; arg++) {
+		if (!strcmp(argv[arg], "id")) {
+			if (++arg >= argc)
+				error(1, 0, " missing id value");
+
+			id = atoi(argv[arg]);
+			rta = (void *)(data + off);
+			rta->rta_type = MPTCP_PM_ATTR_LOC_ID;
+			rta->rta_len = RTA_LENGTH(1);
+			memcpy(RTA_DATA(rta), &id, 1);
+			off += NLMSG_ALIGN(rta->rta_len);
+		} else if (!strcmp(argv[arg], "token")) {
+			if (++arg >= argc)
+				error(1, 0, " missing token value");
+
+			token = atoi(argv[arg]);
+			rta = (void *)(data + off);
+			rta->rta_type = MPTCP_PM_ATTR_TOKEN;
+			rta->rta_len = RTA_LENGTH(4);
+			memcpy(RTA_DATA(rta), &token, 4);
+			off += NLMSG_ALIGN(rta->rta_len);
+		} else
+			error(1, 0, "unknown keyword %s", argv[arg]);
+	}
+
+	do_nl_req(fd, nh, off, 0);
+	return 0;
+}
+
 int announce_addr(int fd, int pm_family, int argc, char *argv[])
 {
 	char data[NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
@@ -915,6 +965,8 @@ int main(int argc, char *argv[])
 		return add_addr(fd, pm_family, argc, argv);
 	else if (!strcmp(argv[1], "ann"))
 		return announce_addr(fd, pm_family, argc, argv);
+	else if (!strcmp(argv[1], "rem"))
+		return remove_addr(fd, pm_family, argc, argv);
 	else if (!strcmp(argv[1], "del"))
 		return del_addr(fd, pm_family, argc, argv);
 	else if (!strcmp(argv[1], "flush"))
-- 
2.31.1

