Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792936165;
	b=pf3t6DapOZ0jt0bsiZo22zv9/q7OfT1q7Dm5Iv8XLalsZYdtH1lxhvKo4AlbWi4LqYly
	 rnM2ahkZe8d7dp0glMcGhT3TaRPnmQ4nV5F1q4LHSdvT3qO6PrRCnYbQ/pbtEe0FTsloo
	 jJi2ghyuq0yoh0Ebqe1difqS5ytzpO3xyT+HewY4pXvqYCkbUxoABE1tnmnupV1DEcdGu
	 z8aUvu0ek2+GaleGzODv2j4+2lh/wF7JiOi/owpQp6sXzdTy9Q0nY5vB+7InlT7jwSzd5
	 SAn7pMNFseuk7F/VY+/TGO47wnIL2ynx4qnHi0hicOJcVQ5AJUrvm1TUL8BFd8uBw4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792936165;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KhC19Luu2JMGOYfja02bJsBK5t5EOeLtyB/kLQhB3HA=;
	b=LcKsri5hvXqpF9ZFhkLOspYXoqQ0ekfS4HcVwrC3PtgHVlpk6p1/TEqTWJqMnBodceZm
	 7dmZQAWCmfIt8nh3CFGyUzP35LSE8H22QQ8oxR3o1NSvvCX0QP6N8m3YuHu+m3/wwYIZQ
	 V7lVL91JUZ1nsYpj5oCpgSop0YOXyrVKnrFd3dOGEt0XnZ0jWpr1Xd8syWBirEQCqUe8T
	 atVsJZ4xD4no8tuFTtTtk3XK/nW5XrgSzZAuGFvLb9QV4XtEMk00d1+sfqUOAcHMO/mUh
	 05vfsyGVjSbrIIEQ34KlBGbl8Kqgn4MSjUw6RUWtGtDj8myWYoqBwQpGF8+05hW8FdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="fr/1PCn7";
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF29606A31B
	for <mptcp@lists.linux.dev>; Sun, 25 Oct 2026 13:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AF29606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fr/1PCn7
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36661f953e4so4246413eec.1
        for <mptcp@lists.linux.dev>; Sun, 25 Oct 2026 06:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792936164; x=1793540964; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KhC19Luu2JMGOYfja02bJsBK5t5EOeLtyB/kLQhB3HA=;
        b=fr/1PCn7f/Fi7YB1hrG+fh8/a4+M68qBd/1sZtwxbIevmPQv+Mg6pDi6JbHGArq9PO
         X38BNJ1dYP1rbi+7SeYHyhoF5lrHpdc456GCYaQhQU5uPDfxE3BD2n2kJtxOLGG09dnM
         qfXi2wgfjCwNncC7gcWRKoGYqvUcXO578YSd8TDcTaaGaXU3EOdO4QqpQmgI+YYzwqLr
         tSOjy9P/TMYuPJuepzM+93Xjpl7iqokIFtS3oiFwUu0VtB0YIugsA8jzdW6iNAYccLkF
         E7Wn7jpIFPGfKbbnc2NjuTzZoxNRqpRktdrRpveIui76xPWLTkoDyioM9covuT2x0YLq
         dKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792936164; x=1793540964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KhC19Luu2JMGOYfja02bJsBK5t5EOeLtyB/kLQhB3HA=;
        b=fx2ItuZgVDWNBKz0k6yRhIzMf8lb7+YmEJRvkgOFK24GfCPL/znzNyI4pvwjwVVRt7
         fvHuz31ZorhuVOxdjEEfLBFYYRWhtw3yy+tL+DnPDwLGxNIRugT0mkT58scxt9kUyGIQ
         oJzkrKKvp0A5+XSHEyt1w7lEu57yJUwDgVtHVpRB4dPZs6jCug9jjUELFg4yWRDM8d6x
         KEddmREIwgBc54lejWdw3BwOQWGvKCTsCIYUl/VVPMCYuLvHlK8dxZN4TwPPNslJwHh6
         g1tUqD5VmzHZAAKkfjw+K4smPBLEgBiPZqUcv5krY5rNhuXH7Qg9VLP4jIbPisef+ss2
         RblQ==
X-Gm-Message-State: AFq9FYL9E4uqjS5MYUzJdOB1ZcFFcdEsIZflMpdxbE8Pei8a2APupyKG
	qDthg4XMPnXxGNYkyJQN9aiihPeBfLz2Vw79nvrC45+6sItn4EpG79i6Wph6eQ==
X-Gm-Gg: AYBFou3EK+U8Um/hnH6a/QW2ogR/qQ6uC1yyiLnjDqx7SWaCnONu2Uzct8jzjsmS5yb
	zwewoqhP0ktyGPIgQc+tNM9/S9q0hqIL3xtfZyWNE6yc7ODuyyWIg3uhXNItX+TngbuWjHIAuO1
	abrnciX9GZT6tULPbkexGLMvrNZf5v6kWLJlGKWw137aSM1fNut2Z3sWDcOum2vvpK01nQiQdes
	yKvaWgzJ/3naIjR17N+dT6zC0yWafG63qQUpLTQzJCz4J+M8Ras68zP2w891B0MnWRGt4tQZA/5
	4nsuy5LRUZyVTuC4rpnoHkmjxsEixAgJInF4DQQEARAahMDIYZKyhVOyP1mou+b+WCW587UfP7G
	4EKevpn7Gh/iqpbJPKTZsYpZXZdJSxdj2SXyw/5qRTlPQLPhlludCWHvGei1IX6TJgbNTkcJGEp
	TCeXUrKvKRo42Q56+ardGM3U8aU2Lm9zbw0UhOhIIYD0oSexhploRaPq5n58JyJDHpPvV+Lb1dG
	kcR+U+qB9PzfWoaaz5Z4sCysXeybQpH3paca0lQTnRi71o59UXEVgzCPrZasXU70/ILZxIxzQnK
	I73qXhKyqDuvPwYl8msu+oRG08kyYloJsVQSqEYwyXZb7IlamPtBp59hAHlxj4OYf7DgF5c9+r7
	FP2e2gJL/STMxcxynnoxnJPLJ
X-Received: by 2002:a05:693c:68d2:b0:369:f3c4:e1fa with SMTP id 5a478bee46e88-369f3c4e87bmr3303481eec.24.1792936163871;
        Sun, 25 Oct 2026 06:49:23 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a002a486csm1188159eec.22.2026.10.25.06.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 06:49:23 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v9 5/6] selftests: mptcp: pm_nl_ctl: support the subflow-retries limit
Date: Sun, 25 Oct 2026 13:49:08 +0000
Message-Id: <20261025134909.2794368-6-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261025134909.2794368-1-anilkaushikwireless@gmail.com>
References: <20261025134909.2794368-1-anilkaushikwireless@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'pm_nl_ctl limits' can now set the subflow-retries limit with a third
value, and shows it when the kernel supports it.

pm_netlink.sh checks its default value, that a value above the maximum
is refused, and that it can be set. This is only done with pm_nl_ctl
for the moment: iproute2 does not support this limit yet.

Assisted-by: LLM
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---

Notes:
    v9:
     - try the value above the maximum after setting 0, not the default
       value, which is also the maximum: a refused value is then told
       apart from a clamped one (netdev Sashiko)
    v8:
     - the default value is now 127
    v7:
     - also check that the maximum value, 127, is accepted (netdev
       Sashiko)
    v5:
     - new (Matthieu)

 .../testing/selftests/net/mptcp/pm_netlink.sh | 48 ++++++++++++++++++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 34 ++++++++++---
 2 files changed, 73 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 21bfe1311f11..9a6209181962 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -46,15 +46,20 @@ trap cleanup EXIT
 
 mptcp_lib_ns_init ns1
 
+# $3: subflow retries, only shown by pm_nl_ctl, if supported
 format_limits() {
 	local accept="${1}"
 	local subflows="${2}"
+	local retries="${3}"
 
 	if mptcp_lib_is_ip_mptcp; then
 		# with a space at the end
 		printf "add_addr_accepted %d subflows %d \n" "${accept}" "${subflows}"
 	else
 		printf "accept %d\nsubflows %d\n" "${accept}" "${subflows}"
+		if [ -n "${retries}" ]; then
+			printf "subflow_retries %d\n" "${retries}"
+		fi
 	fi
 }
 
@@ -75,6 +80,22 @@ get_limits_nb() {
 	fi
 }
 
+# The subflow retries limit is only set and shown with pm_nl_ctl for now.
+# Prints its default value if it is supported.
+get_default_retries() {
+	if mptcp_lib_is_ip_mptcp; then
+		return
+	fi
+
+	if ip netns exec "${ns1}" ./pm_nl_ctl limits |
+	   grep -q "^subflow_retries"; then
+		echo 127
+	elif mptcp_lib_expect_all_features; then
+		# missing feature: the defaults limits check will fail
+		echo 127
+	fi
+}
+
 format_endpoints() {
 	mptcp_lib_pm_nl_format_endpoints "${@}"
 }
@@ -154,8 +175,10 @@ mptcp_lib_subtests_last_ts_reset
 check "show_endpoints" "" "defaults addr list"
 
 default_limits="$(get_limits)"
+default_retries="$(get_default_retries)"
 if mptcp_lib_expect_all_features; then
-	check "get_limits" "$(format_limits 0 2)" "defaults limits"
+	check "get_limits" "$(format_limits 0 2 "${default_retries}")" \
+		"defaults limits"
 fi
 
 add_endpoint 10.0.1.1
@@ -224,7 +247,28 @@ check "get_limits" "${default_limits}" "subflows above hard limit"
 
 set_limits ${max_limits} ${max_limits}
 flush_endpoint  ## to make sure it doesn't affect the limits
-check "get_limits" "$(format_limits ${max_limits} ${max_limits})" "set limits"
+max_limits_out="$(format_limits ${max_limits} ${max_limits} \
+		 "${default_retries}")"
+check "get_limits" "${max_limits_out}" "set limits"
+
+if [ -n "${default_retries}" ]; then
+	ip netns exec "${ns1}" ./pm_nl_ctl limits ${max_limits} ${max_limits} 0
+	check "get_limits" "$(format_limits ${max_limits} ${max_limits} 0)" \
+		"set subflow retries"
+
+	# not from the default: a refused value differs from a clamped one
+	ip netns exec "${ns1}" ./pm_nl_ctl limits ${max_limits} ${max_limits} \
+		128 2>/dev/null
+	check "get_limits" "$(format_limits ${max_limits} ${max_limits} 0)" \
+		"subflow retries above hard limit"
+
+	ip netns exec "${ns1}" ./pm_nl_ctl limits ${max_limits} ${max_limits} \
+		127
+	check "get_limits" "$(format_limits ${max_limits} ${max_limits} 127)" \
+		"set max subflow retries"
+	ip netns exec "${ns1}" ./pm_nl_ctl limits ${max_limits} ${max_limits} \
+		"${default_retries}"
+fi
 
 flush_endpoint
 add_endpoint 10.0.1.1
diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 78180da1efcc..41467b997018 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -39,7 +39,7 @@ static void syntax(char *argv[])
 	fprintf(stderr, "\tset [<ip>] [id <nr>] flags [no]backup|[no]fullmesh [port <nr>] [token <token>] [rip <ip>] [rport <port>]\n");
 	fprintf(stderr, "\tflush\n");
 	fprintf(stderr, "\tdump\n");
-	fprintf(stderr, "\tlimits [<rcv addr max> <subflow max>]\n");
+	fprintf(stderr, "\tlimits [<rcv addr max> <subflow max> [<retry>]]\n");
 	fprintf(stderr, "\tevents\n");
 	fprintf(stderr, "\tlisten <local-ip> <local-port>\n");
 	exit(0);
@@ -1217,6 +1217,7 @@ int flush_addrs(int fd, int pm_family, int argc, char *argv[])
 static void print_limits(struct nlmsghdr *nh, int pm_family, int total_len)
 {
 	struct rtattr *attrs;
+	const char *name;
 	uint32_t max;
 
 	for (; NLMSG_OK(nh, total_len); nh = NLMSG_NEXT(nh, total_len)) {
@@ -1235,13 +1236,22 @@ static void print_limits(struct nlmsghdr *nh, int pm_family, int total_len)
 		while (RTA_OK(attrs, len)) {
 			int type = attrs->rta_type;
 
-			if (type != MPTCP_PM_ATTR_RCV_ADD_ADDRS &&
-			    type != MPTCP_PM_ATTR_SUBFLOWS)
+			switch (type) {
+			case MPTCP_PM_ATTR_RCV_ADD_ADDRS:
+				name = "accept";
+				break;
+			case MPTCP_PM_ATTR_SUBFLOWS:
+				name = "subflows";
+				break;
+			case MPTCP_PM_ATTR_SUBFLOW_RETRIES:
+				name = "subflow_retries";
+				break;
+			default:
 				goto next;
+			}
 
 			memcpy(&max, RTA_DATA(attrs), 4);
-			printf("%s %u\n", type == MPTCP_PM_ATTR_SUBFLOWS ?
-					  "subflows" : "accept", max);
+			printf("%s %u\n", name, max);
 
 next:
 			attrs = RTA_NEXT(attrs, len);
@@ -1254,15 +1264,17 @@ int get_set_limits(int fd, int pm_family, int argc, char *argv[])
 	char data[NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
 		  NLMSG_ALIGN(sizeof(struct genlmsghdr)) +
 		  1024];
-	uint32_t rcv_addr = 0, subflows = 0;
+	uint32_t rcv_addr = 0, subflows = 0, retries = 0;
 	int cmd, len = sizeof(data);
 	struct nlmsghdr *nh;
 	int off = 0;
 
 	/* limit */
-	if (argc == 4) {
+	if (argc == 4 || argc == 5) {
 		rcv_addr = atoi(argv[2]);
 		subflows = atoi(argv[3]);
+		if (argc == 5)
+			retries = atoi(argv[4]);
 		cmd = MPTCP_PM_CMD_SET_LIMITS;
 	} else {
 		cmd = MPTCP_PM_CMD_GET_LIMITS;
@@ -1287,6 +1299,14 @@ int get_set_limits(int fd, int pm_family, int argc, char *argv[])
 		memcpy(RTA_DATA(rta), &subflows, 4);
 		off += NLMSG_ALIGN(rta->rta_len);
 
+		if (argc == 5) {
+			rta = (void *)(data + off);
+			rta->rta_type = MPTCP_PM_ATTR_SUBFLOW_RETRIES;
+			rta->rta_len = RTA_LENGTH(4);
+			memcpy(RTA_DATA(rta), &retries, 4);
+			off += NLMSG_ALIGN(rta->rta_len);
+		}
+
 		/* do not expect a reply */
 		len = 0;
 	}
-- 
2.25.1

