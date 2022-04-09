Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E2A652
	for <mptcp@lists.linux.dev>; Sat,  9 Apr 2022 01:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649468322; x=1681004322;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=RAhrEvJmyKeoBz/vW0WCe2KrNVdwr/PvsJn+yTOk/F0=;
  b=U0DgJfUNAnii0LUdCai47cpkEU6exNvnRBGcVl9fQ5JgT9NY034kgdeC
   PR6NUjsYZsoTGzz/DDPTpoIGPt6zDLXruG2HXtU7gb87/Tq1MtWh6vMKi
   2KYDfT5lwjC5Bi9WzqVfRrr2Yu8/0IXRn+cOZdqgiJ6NIpPSgwtLAFppP
   hntXoukg791r6KUUOhNPWMx9BSfY0mSxXeFo+9A3saySsvUgoP1j1pr0I
   eihwguftO9WdmQ18z+TOXAtGM6j3Kxgw52NuQJhMARJ6qIvfOc4D3iwls
   v5LbIig9p/j1jg74QYxG/l//gnb2fuEk/jG+O4ProU4FgpDb68DUilJzM
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="261921151"
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="261921151"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 18:38:30 -0700
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="698436091"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 18:38:30 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v9 08/14] selftests: mptcp: support MPTCP_PM_CMD_REMOVE
Date: Fri,  8 Apr 2022 21:38:19 -0400
Message-Id: <20220409013825.1877395-9-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220409013825.1877395-1-kishen.maloor@intel.com>
References: <20220409013825.1877395-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change updates the "pm_nl_ctl" testing sample with a "rem"
(remove) option to support the newly added netlink interface command
MPTCP_PM_CMD_REMOVE to issue a REMOVE_ADDR signal over the
chosen MPTCP connection.

E.g. ./pm_nl_ctl rem token 823274047 id 23

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 0ef35c3f6419..3506b0416c41 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -28,6 +28,7 @@ static void syntax(char *argv[])
 	fprintf(stderr, "%s add|get|set|del|flush|dump|accept [<args>]\n", argv[0]);
 	fprintf(stderr, "\tadd [flags signal|subflow|backup|fullmesh] [id <nr>] [dev <name>] <ip>\n");
 	fprintf(stderr, "\tann <local-ip> id <local-id> token <token> [port <local-port>] [dev <name>]\n");
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
@@ -917,6 +967,8 @@ int main(int argc, char *argv[])
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

