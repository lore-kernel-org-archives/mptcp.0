Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBB3139E
	for <mptcp@lists.linux.dev>; Thu, 23 Jun 2022 00:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655945997; x=1687481997;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=iUv7CrXlBd8xzkmyJQHh19NwFYdx1qcyUfy+h4KvXZQ=;
  b=DW3qx0xwdwJnzuhtIWyYX3jKBPy+8bdqrp6uKckzlT4+RanthRf2S4vD
   Mmc/sJJBiL8NWp4ugLSb6lZ4WXLpaGUOlYxRPD1kHDry8TAlmu4O/jX9X
   wLp1CvFp5qMpNRUw2kYMJAuazcmn2ASDfL6WmTokxaY5hwQg0hp4PWZfo
   hhI53hxIRsnsdk5LtynPdDFHSfo2f7/9/l9KpKl/aLTELjg3jVVZHT6ZP
   AKVOPSTeKUjy5n2JFIWtOnq2UGe0WFeQwkCIFMMp6eBq2+fLwuQ2duW2o
   eCPx+Kkb4hqcU6Ah7un23bq1AQGVj+6NpbdpUTTH1sgtxHFq6OuXZbkie
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="278137860"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="278137860"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 17:59:54 -0700
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="914950199"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 17:59:54 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2 2/2] selftests: mptcp: userspace PM support for MP_PRIO signals
Date: Wed, 22 Jun 2022 20:59:48 -0400
Message-Id: <20220623005948.291792-3-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220623005948.291792-1-kishen.maloor@intel.com>
References: <20220623005948.291792-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change updates the testing sample (pm_nl_ctl) to take a
connection token as an optional param for the MPTCP_PM_CMD_SET_FLAGS
command. This is used to test the userspace PM code path for issuing
MP_PRIO signals over a connection for the specified address ID.

E.g. ./pm_nl_ctl set id 0 flags backup token 823274047

userspace_pm.sh has new selftests which exercise this command.

Fixes: 259a834fadda ("selftests: mptcp: functional tests for the userspace PM type")
Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
v2:
-added a sleep after issuing the MP_PRIO signal in userspace_pm.sh.
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 19 +++++++++--
 .../selftests/net/mptcp/userspace_pm.sh       | 32 +++++++++++++++++++
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 4dd87bb9ee91..0512d64b1d11 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -39,7 +39,7 @@ static void syntax(char *argv[])
 	fprintf(stderr, "\tdsf lip <local-ip> lport <local-port> rip <remote-ip> rport <remote-port> token <token>\n");
 	fprintf(stderr, "\tdel <id> [<ip>]\n");
 	fprintf(stderr, "\tget <id>\n");
-	fprintf(stderr, "\tset [<ip>] [id <nr>] flags [no]backup|[no]fullmesh [port <nr>]\n");
+	fprintf(stderr, "\tset [<ip>] [id <nr>] flags [no]backup|[no]fullmesh [port <nr>] [token <token>]\n");
 	fprintf(stderr, "\tflush\n");
 	fprintf(stderr, "\tdump\n");
 	fprintf(stderr, "\tlimits [<rcv addr max> <subflow max>]\n");
@@ -1279,6 +1279,7 @@ int set_flags(int fd, int pm_family, int argc, char *argv[])
 	struct rtattr *rta, *nest;
 	struct nlmsghdr *nh;
 	u_int32_t flags = 0;
+	u_int32_t token = 0;
 	u_int16_t family;
 	int nest_start;
 	int use_id = 0;
@@ -1339,7 +1340,13 @@ int set_flags(int fd, int pm_family, int argc, char *argv[])
 		error(1, 0, " missing flags keyword");
 
 	for (; arg < argc; arg++) {
-		if (!strcmp(argv[arg], "flags")) {
+		if (!strcmp(argv[arg], "token")) {
+			if (++arg >= argc)
+				error(1, 0, " missing token value");
+
+			/* token */
+			token = atoi(argv[arg]);
+		} else if (!strcmp(argv[arg], "flags")) {
 			char *tok, *str;
 
 			/* flags */
@@ -1384,6 +1391,14 @@ int set_flags(int fd, int pm_family, int argc, char *argv[])
 	}
 	nest->rta_len = off - nest_start;
 
+	if (token) {
+		rta = (void *)(data + off);
+		rta->rta_type = MPTCP_PM_ATTR_TOKEN;
+		rta->rta_len = RTA_LENGTH(4);
+		memcpy(RTA_DATA(rta), &token, 4);
+		off += NLMSG_ALIGN(rta->rta_len);
+	}
+
 	do_nl_req(fd, nh, off, 0);
 	return 0;
 }
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index d586bc5ffe01..8bf16ad51074 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -776,10 +776,42 @@ test_subflows()
 	rm -f "$evts"
 }
 
+test_prio()
+{
+	local count
+
+	# Send MP_PRIO signal from client to server machine
+	ip netns exec "$ns2" ./pm_nl_ctl set id 0 flags backup token "$client4_token"
+	sleep 0.5
+
+	# Check TX
+	stdbuf -o0 -e0 printf "MP_PRIO TX                                                 \t"
+	count=$(ip netns exec "$ns2" nstat -as | grep MPTcpExtMPPrioTx | awk '{print $2}')
+	[ -z "$count" ] && count=0
+	if [ $count != 1 ]; then
+		stdbuf -o0 -e0 printf "[FAIL]\n"
+		exit 1
+	else
+		stdbuf -o0 -e0 printf "[OK]\n"
+	fi
+
+	# Check RX
+	stdbuf -o0 -e0 printf "MP_PRIO RX                                                 \t"
+	count=$(ip netns exec "$ns1" nstat -as | grep MPTcpExtMPPrioRx | awk '{print $2}')
+	[ -z "$count" ] && count=0
+	if [ $count != 1 ]; then
+		stdbuf -o0 -e0 printf "[FAIL]\n"
+		exit 1
+	else
+		stdbuf -o0 -e0 printf "[OK]\n"
+	fi
+}
+
 make_connection
 make_connection "v6"
 test_announce
 test_remove
 test_subflows
+test_prio
 
 exit 0
-- 
2.31.1

