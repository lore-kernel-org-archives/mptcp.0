Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2463FEF
	for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 22:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639693461; x=1671229461;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=C2VI5SqdOWAektSC7DHL1vhcCvIC6JSahI3lmtl6KNM=;
  b=G65K0pex+A3wv7YzpnN7AzBGyEar+zl50BR7nzSrrjChvZyMRo/TdBoE
   xmaJd8Ha3d9UZXkH/PDFne1GclL3cc02VnZ06oxpeF9NqNM6wQ7TURFw8
   WqKno1AAVQaTV0nv/0VKmzPiszgJiYtKYpdVNG4lMUKutMqTvlAxnwNO7
   Lekx9Nbv5BJxil+XJ0hDFdO4Yi2G2DppVgWAqydcGSDixNIGbdIqkl3YJ
   q+bqFj78b7g6mniTl8gNAR7yaD5qjRJeeW0fM64CLBXShdRwT6ut7//I4
   LFmgC7gkPra+fXuRaVVBm2mfJg0BAlKIxBTMG63YSGBnHkb/Ut/1aP8yL
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="300393173"
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="300393173"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 14:24:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="519461274"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 14:24:10 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 16/21] mptcp: selftests: support MPTCP_PM_CMD_REMOVE
Date: Thu, 16 Dec 2021 17:23:09 -0500
Message-Id: <20211216222314.1244708-17-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216222314.1244708-1-kishen.maloor@intel.com>
References: <20211216222314.1244708-1-kishen.maloor@intel.com>
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
index 76dfb5a8984a..8892bf16693a 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -28,6 +28,7 @@ static void syntax(char *argv[])
 	fprintf(stderr, "%s add|get|set|del|flush|dump|accept [<args>]\n", argv[0]);
 	fprintf(stderr, "\tadd [flags signal|subflow|backup|fullmesh] [id <nr>] [dev <name>] <ip>\n");
 	fprintf(stderr, "\tann <local-ip> id <local-id> token <token> [port <local-port>] [dev <name>]\n");
+	fprintf(stderr, "\trem id <local-id> token <token>\n");
 	fprintf(stderr, "\tdel <id> [<ip>]\n");
 	fprintf(stderr, "\tget <id>\n");
 	fprintf(stderr, "\tset <ip> [flags backup|nobackup]\n");
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
@@ -874,6 +924,8 @@ int main(int argc, char *argv[])
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

