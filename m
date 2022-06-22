Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760A91872
	for <mptcp@lists.linux.dev>; Wed, 22 Jun 2022 18:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655921866; x=1687457866;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Mx3o+3gHiM8oLX9HyzZap33/8cIxily7yQNzQvIQ6io=;
  b=BkTVVYuVvItSNwX2nlmEtaQt+rqLYb/x49I46kFgQ+KcbCbExHFrLKJV
   Dj62g4bNXRxW92DtZ4vkuo7yzburBL1KDlMjqroRC3SLA2jRyEMeE/92w
   vBkKE+2VKgZhuRAiRAus4NoETCMmFHiuqEMTpW7+HWSHu9+FcUAqvg25Q
   cMVokvmD0LYMK6sotiROj4AhhMfLDCi0dKNHsZlxsDClmSKmdPPNCKPjK
   RcpxUtTJ/uRUZ1Rb+P8a5UFB6xt4FAtvcGAjvPO71pGYNYd+5RzZ1WsXr
   FPFyqhbZyLKVGo+GSECJ/tIAd73akZmmlcz56fTJ7xIYqJ4AAqOt418Y3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="344490534"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="344490534"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 10:55:56 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="592302708"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 10:55:53 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 2/2] selftests: mptcp: userspace PM support for MP_PRIO signals
Date: Wed, 22 Jun 2022 13:55:47 -0400
Message-Id: <20220622175547.289717-3-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220622175547.289717-1-kishen.maloor@intel.com>
References: <20220622175547.289717-1-kishen.maloor@intel.com>
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
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 19 ++++++++++--
 .../selftests/net/mptcp/userspace_pm.sh       | 31 +++++++++++++++++++
 2 files changed, 48 insertions(+), 2 deletions(-)

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
index d586bc5ffe01..387f5774d541 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -776,10 +776,41 @@ test_subflows()
 	rm -f "$evts"
 }
 
+test_prio()
+{
+	local count
+
+	# Send MP_PRIO signal from client to server machine
+	ip netns exec "$ns2" ./pm_nl_ctl set id 0 flags backup token "$client4_token"
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

