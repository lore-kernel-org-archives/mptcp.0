Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD8E309DDC;
	Fri, 20 Feb 2026 18:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771613659; cv=none; b=qwKD2tDP9JH2K20LMRpwM+K/O07TBiMcupXfifIf+Gw+mlczwi+58x52f6uRL/otZ+y5bU6NY46CqmkQJLxw71Sqi9FdB0xA6i5n4l9CdOWd9w9rCFNi5CQRJbKMocGgfx+3M9OuV2/fo38KteSPpHozPIEZ9k7tVZ8tvJWMfxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771613659; c=relaxed/simple;
	bh=kZ7T4vbLUXDKQ17IlLgmTMSibj0aZOJgM0z313YivSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Eb/MG3dXUkwgSNjh9FzPTx+4YUdBRRXd1XLN4bxgq4fB3bZ8cf8LdCKUZxWiNVBu+Cfm0Y2/5OveajYKQWv2Y4Zw5Rt9Row7e55ekdiMBZ/hNzHiz8fXVrqnLBTW4WKsMBomsqgXuc3hstvIA9y2o9fPsW9WLrbU9c+VN7R4Vec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuUAWBP8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuUAWBP8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F30BC19424;
	Fri, 20 Feb 2026 18:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771613659;
	bh=kZ7T4vbLUXDKQ17IlLgmTMSibj0aZOJgM0z313YivSY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HuUAWBP880lAmefrMpf0L+bo/05NRCNZoqPjqnfyIsFrFIgAWo1QIIR0AVLUxjc8W
	 xVARvpO/R+amslmMVdxEzkPKIL37vgjAH2DL1sK+ylX3CEQOko6X/cci0f5hs0Htax
	 STQt3l6vZNfAvm/CPY7HQCL1h4s1y86ihVofcdhXd/FfiHwuuajhx6j1VJ9U0pPqnV
	 MclrfGQ+QhSAVP1OZa1FyKQ+FX17siGhzOI6QQF3s4F23r+kVO/0n/edM9p3FtwXON
	 Kpd1mXi6jO+HcgkcrURhKot5I2JJWYXKVy2hTvTO5Rwaltl7nXqB7FDDH0E1fGi3nu
	 pQf1wGlnqzxrw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 20 Feb 2026 19:54:03 +0100
Subject: [PATCH iproute2-next 3/3] mptcp: monitor: add JSON support
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-ipr-monitor-json-v1-3-eb4b0d5f7820@kernel.org>
References: <20260220-ipr-monitor-json-v1-0-eb4b0d5f7820@kernel.org>
In-Reply-To: <20260220-ipr-monitor-json-v1-0-eb4b0d5f7820@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6393; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=kZ7T4vbLUXDKQ17IlLgmTMSibj0aZOJgM0z313YivSY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJnrL3mKcsztbdixvRpW+50xbN+aPx2pzkqUjRr97oFQ
 ouEZXgdO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbiv5aR4c9V2bgtpfcY+bIN
 yrw0mcUurZdTW3amkqHoxpq0CUntVxkZXj1eH+J9sdrTMXFie1KAv+zaDsUFapfrNk24r+uwmUG
 XCwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The command 'ip [-t[s]] mptcp monitor' now produces an output with the JSON
format.

The previous text output has been preserved.

The JSON support has been added thanks to the print_*() helpers. Note that
it is also needed to add a signal handler to close the JSON and print the
final ']' when stopping 'ip mptcp monitor' which can only be done via a
SIGINT or a SIGTERM.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 ip/ipmptcp.c | 88 +++++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 61 insertions(+), 27 deletions(-)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index 18ec05a8..87557998 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -2,6 +2,7 @@
 
 #include <arpa/inet.h>
 #include <netinet/in.h>
+#include <signal.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -476,8 +477,9 @@ static void print_addr(const char *key, int af, struct rtattr *value)
 	char str[INET6_ADDRSTRLEN];
 
 	if (inet_ntop(af, data, str, sizeof(str))) {
-		printf(" %s=", key);
-		color_fprintf(stdout, ifa_family_color(af), "%s", str);
+		print_string(PRINT_FP, NULL, " %s=", key);
+		print_color_string(PRINT_ANY, ifa_family_color(af), key, "%s",
+				   str);
 	}
 }
 
@@ -485,12 +487,13 @@ static void print_iface(int index)
 {
 	const char *ifname;
 
-	printf(" ifindex=%d", index);
+	print_int(PRINT_ANY, "ifindex", " ifindex=%d", index);
 
 	ifname = index ? ll_index_to_name(index) : NULL;
 	if (ifname) {
-		printf(" dev=");
-		color_fprintf(stdout, COLOR_IFNAME, "%s", ifname);
+		print_string(PRINT_FP, NULL, " dev=", NULL);
+		print_color_string(PRINT_ANY, COLOR_IFNAME, "dev", "%s",
+				   ifname);
 	}
 }
 
@@ -509,30 +512,34 @@ static int mptcp_monitor_msg(struct rtnl_ctrl_data *ctrl,
 	if (n->nlmsg_type != genl_family)
 		return 0;
 
+	open_json_object(NULL);
+
 	if (timestamp)
 		print_timestamp(stdout);
 
-	if (ghdr->cmd >= ARRAY_SIZE(event_to_str)) {
-		printf("[UNKNOWN %u]\n", ghdr->cmd);
+	if (ghdr->cmd >= ARRAY_SIZE(event_to_str) ||
+	    event_to_str[ghdr->cmd] == NULL) {
+		char event[40];
+
+		snprintf(event, sizeof(event), "UNKNOWN %u", ghdr->cmd);
+		print_string(PRINT_ANY, "event", "[%s]", event);
 		goto out;
 	}
 
-	if (event_to_str[ghdr->cmd] == NULL) {
-		printf("[UNKNOWN %u]\n", ghdr->cmd);
-		goto out;
-	}
-
-	printf("[%16s]", event_to_str[ghdr->cmd]);
+	print_string(PRINT_ANY, "event", "[%16s]", event_to_str[ghdr->cmd]);
 
 	parse_rtattr(tb, MPTCP_ATTR_MAX, (void *) ghdr + GENL_HDRLEN, len);
 
 	if (tb[MPTCP_ATTR_TOKEN])
-		printf(" token=%08x", rta_getattr_u32(tb[MPTCP_ATTR_TOKEN]));
+		print_uint(PRINT_ANY, "token"," token=%08x",
+			   rta_getattr_u32(tb[MPTCP_ATTR_TOKEN]));
 
 	if (tb[MPTCP_ATTR_REM_ID])
-		printf(" remid=%u", rta_getattr_u8(tb[MPTCP_ATTR_REM_ID]));
+		print_uint(PRINT_ANY, "remid", " remid=%u",
+			   rta_getattr_u8(tb[MPTCP_ATTR_REM_ID]));
 	if (tb[MPTCP_ATTR_LOC_ID])
-		printf(" locid=%u", rta_getattr_u8(tb[MPTCP_ATTR_LOC_ID]));
+		print_uint(PRINT_ANY, "locid", " locid=%u",
+			   rta_getattr_u8(tb[MPTCP_ATTR_LOC_ID]));
 
 	if (tb[MPTCP_ATTR_SADDR4])
 		print_addr("saddr4", AF_INET, tb[MPTCP_ATTR_SADDR4]);
@@ -543,42 +550,60 @@ static int mptcp_monitor_msg(struct rtnl_ctrl_data *ctrl,
 	if (tb[MPTCP_ATTR_DADDR6])
 		print_addr("daddr6", AF_INET6, tb[MPTCP_ATTR_DADDR6]);
 	if (tb[MPTCP_ATTR_SPORT])
-		printf(" sport=%u", rta_getattr_be16(tb[MPTCP_ATTR_SPORT]));
+		print_uint(PRINT_ANY, "sport", " sport=%u",
+			   rta_getattr_be16(tb[MPTCP_ATTR_SPORT]));
 	if (tb[MPTCP_ATTR_DPORT])
-		printf(" dport=%u", rta_getattr_be16(tb[MPTCP_ATTR_DPORT]));
+		print_uint(PRINT_ANY, "dport", " dport=%u",
+			   rta_getattr_be16(tb[MPTCP_ATTR_DPORT]));
 	if (tb[MPTCP_ATTR_BACKUP])
-		printf(" backup=%u", rta_getattr_u8(tb[MPTCP_ATTR_BACKUP]));
+		print_uint(PRINT_ANY, "backup", " backup=%u",
+			   rta_getattr_u8(tb[MPTCP_ATTR_BACKUP]));
 	if (tb[MPTCP_ATTR_ERROR])
-		printf(" error=%u", rta_getattr_u8(tb[MPTCP_ATTR_ERROR]));
+		print_uint(PRINT_ANY, "error", " error=%u",
+			   rta_getattr_u8(tb[MPTCP_ATTR_ERROR]));
 	if (tb[MPTCP_ATTR_TIMEOUT])
-		printf(" timeout=%u", rta_getattr_u32(tb[MPTCP_ATTR_TIMEOUT]));
+		print_uint(PRINT_ANY, "timeout", " timeout=%u",
+			   rta_getattr_u32(tb[MPTCP_ATTR_TIMEOUT]));
 	if (tb[MPTCP_ATTR_IF_IDX])
 		print_iface(rta_getattr_s32(tb[MPTCP_ATTR_IF_IDX]));
 	if (tb[MPTCP_ATTR_RESET_REASON])
-		printf(" reset_reason=%u", rta_getattr_u32(tb[MPTCP_ATTR_RESET_REASON]));
+		print_uint(PRINT_ANY, "reset_reason", " reset_reason=%u",
+			   rta_getattr_u32(tb[MPTCP_ATTR_RESET_REASON]));
 	if (tb[MPTCP_ATTR_RESET_FLAGS])
-		printf(" reset_flags=0x%x", rta_getattr_u32(tb[MPTCP_ATTR_RESET_FLAGS]));
+		print_0xhex(PRINT_ANY, "reset_flags", " reset_flags=%#x",
+			    rta_getattr_u32(tb[MPTCP_ATTR_RESET_FLAGS]));
 
 	if (tb[MPTCP_ATTR_FLAGS])
 		flags = rta_getattr_u16(tb[MPTCP_ATTR_FLAGS]);
 	if ((flags & MPTCP_PM_EV_FLAG_SERVER_SIDE) ||
 	    (tb[MPTCP_ATTR_SERVER_SIDE] && rta_getattr_u8(tb[MPTCP_ATTR_SERVER_SIDE]))) {
 		flags &= ~MPTCP_PM_EV_FLAG_SERVER_SIDE;
-		printf(" server_side");
+		print_string(PRINT_FP, NULL, " server_side", NULL);
+		print_bool(PRINT_JSON, "server_side", NULL, true);
 	}
 	if (flags & MPTCP_PM_EV_FLAG_DENY_JOIN_ID0) {
 		flags &= ~MPTCP_PM_EV_FLAG_DENY_JOIN_ID0;
-		printf(" deny_join_id0");
+		print_string(PRINT_FP, NULL, " deny_join_id0", NULL);
+		print_bool(PRINT_JSON, "deny_join_id0", NULL, true);
 	}
 	if (flags) /* remaining bits */
-		printf(" flags=0x%x", flags);
+		print_0xhex(PRINT_ANY, "flags", " flags=%#x", flags);
 
-	puts("");
 out:
+	print_nl();
+	close_json_object();
 	fflush(stdout);
+
 	return 0;
 }
 
+static void sig_exit_json(int signo)
+{
+	delete_json_obj();
+	rtnl_close(&genl_rth);
+	exit(0);
+}
+
 static int mptcp_monitor(void)
 {
 	if (genl_add_mcast_grp(&genl_rth, genl_family, MPTCP_PM_EV_GRP_NAME) < 0) {
@@ -586,6 +611,15 @@ static int mptcp_monitor(void)
 		return 1;
 	}
 
+	new_json_obj(json);
+
+	if (is_json_context()) {
+		struct sigaction sa = { .sa_handler = sig_exit_json };
+
+		sigaction(SIGINT, &sa, NULL);
+		sigaction(SIGTERM, &sa, NULL);
+	}
+
 	if (rtnl_listen(&genl_rth, mptcp_monitor_msg, stdout) < 0)
 		return 2;
 

-- 
2.51.0

