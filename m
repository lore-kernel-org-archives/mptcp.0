Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ED07B
	for <mptcp@lists.linux.dev>; Wed, 29 Jun 2022 01:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656466030; x=1688002030;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=BV2zJkP2GcXwkzqEjJszAgRr1Hb5MugnnctBzrVIoWc=;
  b=d/OBqkm+AsF80/3hvQcEkyoeSvegyGNk3wL6F5u4r8IhoO/Ntx/xjMD0
   Zc4cou9U6vtoZkqo9WFDMIdko7iGeDlmDCpEG+dl6idzjXLYlWh5YP+mQ
   8x/Pl0nm47aiVLdCjiLbcSFltyXwl8e5y1fDS0zWWvnFHhuD0ns0Sv0YJ
   ckg4z/LDbz3QB5ELjcKaCfLKPMA26T2S5qENaD1amgbutPPima/LqFCcj
   8dEc62yUSS81BrI9oS53IwuNgYy6t7JSlJ3v1uhwQo4s0W9agYZaH+Cua
   rGrbtqulGphtN77ctahjpxI8MWGKKhpWrVyCfXwQUSKqssaQYX7NtY69i
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="281926310"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="281926310"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 18:27:07 -0700
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="693355089"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 18:27:07 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v4 2/2] selftests: mptcp: userspace PM support for MP_PRIO signals
Date: Tue, 28 Jun 2022 21:27:02 -0400
Message-Id: <20220629012702.425574-3-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220629012702.425574-1-kishen.maloor@intel.com>
References: <20220629012702.425574-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change updates the testing sample (pm_nl_ctl) to exercise
the updated MPTCP_PM_CMD_SET_FLAGS command for userspace PMs to
issue MP_PRIO signals over the selected subflow.

E.g. ./pm_nl_ctl set 10.0.1.2 port 47234 flags backup token 823274047 rip 10.0.1.1 rport 50003

userspace_pm.sh has a new selftest that invokes this command.

Fixes: 259a834fadda ("selftests: mptcp: functional tests for the userspace PM type")
Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
v2:
-added a sleep after issuing the MP_PRIO signal in userspace_pm.sh.

v3:
-updated test to pass local and remote address+port to aid in selecting a
subflow.
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 73 ++++++++++++++++++-
 .../selftests/net/mptcp/userspace_pm.sh       | 32 ++++++++
 2 files changed, 103 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 6a2f4b981e1d..cb79f0719e3b 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -39,7 +39,7 @@ static void syntax(char *argv[])
 	fprintf(stderr, "\tdsf lip <local-ip> lport <local-port> rip <remote-ip> rport <remote-port> token <token>\n");
 	fprintf(stderr, "\tdel <id> [<ip>]\n");
 	fprintf(stderr, "\tget <id>\n");
-	fprintf(stderr, "\tset [<ip>] [id <nr>] flags [no]backup|[no]fullmesh [port <nr>]\n");
+	fprintf(stderr, "\tset [<ip>] [id <nr>] flags [no]backup|[no]fullmesh [port <nr>] [token <token>] [rip <ip>] [rport <port>]\n");
 	fprintf(stderr, "\tflush\n");
 	fprintf(stderr, "\tdump\n");
 	fprintf(stderr, "\tlimits [<rcv addr max> <subflow max>]\n");
@@ -1279,7 +1279,10 @@ int set_flags(int fd, int pm_family, int argc, char *argv[])
 	struct rtattr *rta, *nest;
 	struct nlmsghdr *nh;
 	u_int32_t flags = 0;
+	u_int32_t token = 0;
+	u_int16_t rport = 0;
 	u_int16_t family;
+	void *rip = NULL;
 	int nest_start;
 	int use_id = 0;
 	u_int8_t id;
@@ -1339,7 +1342,13 @@ int set_flags(int fd, int pm_family, int argc, char *argv[])
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
@@ -1378,12 +1387,72 @@ int set_flags(int fd, int pm_family, int argc, char *argv[])
 			rta->rta_len = RTA_LENGTH(2);
 			memcpy(RTA_DATA(rta), &port, 2);
 			off += NLMSG_ALIGN(rta->rta_len);
+		} else if (!strcmp(argv[arg], "rport")) {
+			if (++arg >= argc)
+				error(1, 0, " missing remote port");
+
+			rport = atoi(argv[arg]);
+		} else if (!strcmp(argv[arg], "rip")) {
+			if (++arg >= argc)
+				error(1, 0, " missing remote ip");
+
+			rip = argv[arg];
 		} else {
 			error(1, 0, "unknown keyword %s", argv[arg]);
 		}
 	}
 	nest->rta_len = off - nest_start;
 
+	/* token */
+	if (token) {
+		rta = (void *)(data + off);
+		rta->rta_type = MPTCP_PM_ATTR_TOKEN;
+		rta->rta_len = RTA_LENGTH(4);
+		memcpy(RTA_DATA(rta), &token, 4);
+		off += NLMSG_ALIGN(rta->rta_len);
+	}
+
+	/* remote addr/port */
+	if (rip) {
+		nest_start = off;
+		nest = (void *)(data + off);
+		nest->rta_type = NLA_F_NESTED | MPTCP_PM_ATTR_ADDR_REMOTE;
+		nest->rta_len = RTA_LENGTH(0);
+		off += NLMSG_ALIGN(nest->rta_len);
+
+		/* addr data */
+		rta = (void *)(data + off);
+		if (inet_pton(AF_INET, rip, RTA_DATA(rta))) {
+			family = AF_INET;
+			rta->rta_type = MPTCP_PM_ADDR_ATTR_ADDR4;
+			rta->rta_len = RTA_LENGTH(4);
+		} else if (inet_pton(AF_INET6, rip, RTA_DATA(rta))) {
+			family = AF_INET6;
+			rta->rta_type = MPTCP_PM_ADDR_ATTR_ADDR6;
+			rta->rta_len = RTA_LENGTH(16);
+		} else {
+			error(1, errno, "can't parse ip %s", (char *)rip);
+		}
+		off += NLMSG_ALIGN(rta->rta_len);
+
+		/* family */
+		rta = (void *)(data + off);
+		rta->rta_type = MPTCP_PM_ADDR_ATTR_FAMILY;
+		rta->rta_len = RTA_LENGTH(2);
+		memcpy(RTA_DATA(rta), &family, 2);
+		off += NLMSG_ALIGN(rta->rta_len);
+
+		if (rport) {
+			rta = (void *)(data + off);
+			rta->rta_type = MPTCP_PM_ADDR_ATTR_PORT;
+			rta->rta_len = RTA_LENGTH(2);
+			memcpy(RTA_DATA(rta), &rport, 2);
+			off += NLMSG_ALIGN(rta->rta_len);
+		}
+
+		nest->rta_len = off - nest_start;
+	}
+
 	do_nl_req(fd, nh, off, 0);
 	return 0;
 }
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 78d0bb640b11..abe3d4ebe554 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -770,10 +770,42 @@ test_subflows()
 	rm -f "$evts"
 }
 
+test_prio()
+{
+	local count
+
+	# Send MP_PRIO signal from client to server machine
+	ip netns exec "$ns2" ./pm_nl_ctl set 10.0.1.2 port "$client4_port" flags backup token "$client4_token" rip 10.0.1.1 rport "$server4_port"
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

