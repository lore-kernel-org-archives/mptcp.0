Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFB35226B6
	for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166991; cv=none; b=AqKuUdDtfHsK1EZEFgrsVhUGDKK7zS+psEh2UFgHuwMLboKVg7d8HRcsJzS9y43u/ZReL+L89cEmSRr7HZWqt04p9CCTIFQ5pG10kGTEed2FE2kwkFpguApJpGnYHEB+gq4y9bn0YYtcAbOmTVscRhekEpzNm0NbnuuNvpyaido=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166991; c=relaxed/simple;
	bh=dd0UxJHibigvFGLwqav+zo7qW8LJWgRHmdjpnPtuWcc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JUgm6SGSbZN+6/BHP58445UPwn0lDvYuP6ExTAxWfDXId1FHJWY9u8bYdgfFPF7Fxm6fhoplir+eRA2lYLbzDvYWhOh+P6ZkeT+XyEeoDNN3LFRUUtTuBWZMrxmUBMd5+pfqcuTJ/T3GP7GmKCjkAJQtb0Niy2+qGNi26OJ5/hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnFW4lXS; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnFW4lXS"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-35f036b17easo38830eec.1
        for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 09:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792166984; x=1792771784; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h20OK2aiB6RUSneUr7xKjwtxf0LTm5blGfs0aJrLlL0=;
        b=dnFW4lXSyt3TqerQ55ulPddnNrQydr4IvEB0h0o7APScn3tCBqFrY6CWi2ANEyxo0k
         yCYRf1zQ1o7RrPLT/TteXCdn8UT+JaTQW8Zb0xBefwS3lH0shiFf//jg44WhSZ1K0QU9
         xmeHe5OYz4wDjlQvjIXa/criqdtA5WTiG/vQxX0D879Hre5ryrz3qhgdM63R9Kl0zuEw
         +km/46Y17x5y4qwwL43tyMDBMWeTXfbIHcfg/7+y90t9AzXWCKWAQkqWtYTj6Q8RstxQ
         DNnkaqsRRJzl1cW+Hd1lkWc/WUOJZWe/3p1nsLQTPmDe6GeCEkhs7vtUqiEb+H4XK/wX
         4Uug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792166984; x=1792771784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h20OK2aiB6RUSneUr7xKjwtxf0LTm5blGfs0aJrLlL0=;
        b=0H6NnAoJoeCrM7aZJwF6j9/Sf0/1cpaVyBcedHd/xbnvgrIaJcP+/LircmrPUBWkfG
         eMmygmnxjWAV0GiSU6tIDkp7+GlHuE2OOQYTBtufJdIxysfTm9K8D45HqfLnOi4h4jOV
         3CG+29+O8F+g1eVX691po14Bonht0zxncqrkKSNNGs+UypZ9jYL/fcXGvqc3rRujnu65
         6YX5Elv2G3pXxJfjEuA2UKd5AYaicYR5voLCanFpqdAEqpPsQxr+rTAmh/o7dCgIj6sW
         0TpuG6dYQKUzhq3SadCAnPhiOo02zk03sPXG2yhSD8lp/ZoK68nTde3ZVUbTZo7IXSKe
         JaoQ==
X-Gm-Message-State: AFq9FYI6OlDPCXShGw1FXpbqqnnuBDjer93YDLCbNIC0p0AMF8I+4xc0
	VTLUy3BQZfPQ129svF5r3bu9R+3+RHkxP9LuBCFIHHzX21dg7XDlUt3KmnQVwA==
X-Gm-Gg: AYBFou1bIHamO7OE1SztPSnpqoGHFk+CcIUEIlAB/ulQckhvf7rp9IsDQ3s16J+Vcl6
	3L1SoA8gcDw4TJ0jAzAgnzHntHJxQiFY7j8j9hZ1jnYROWAN0eggYW/vuKYsX3Bo51tTrDnvhOs
	ifYgEAxBPGxTP4KTGkX44gWYD45MT9koqzB4uq9Btm7Hc3J6xDPl5F7YofEOkkO8+EB/b5Xcypz
	tmNUVkVbwY3L9OC7bQJcLImknM8L7RBpfUZ9noZQuNDdDccfD1T6Sx7TjpGSMC7+9TIaKwRo8pr
	H9izBEDJ5P4X1Vw/1CFROKfmcxzoxMuRXLbNVgrmfC8TqOXI435CaH6AKVqqwwwFAVemgh+usS1
	qiCGXp3v9gdpX4KBHG3u8fW4SKprb5RTVMjfzImPc/QMr1I0oQiLCR1HdcJnBDMsERIAcKMifzL
	17TQpg+OQ7yC5H0EeK2oUt/0CrAzYR8nE4/HnFKi3CTg5lstMh5vQDVpP0Q5+kQoO00k6EiuiHw
	gc9tNDPGEwnpfmgGdCzx4QGDiRCxPYOTIlMm+7NFLiR1w/v3myGL6Pk5dwRi1MTFMMqm5zgzII+
	nVqcz6qXv24+FmFjvvd5LBTB5rmDTU+fXnCOs4qZ4srS/6sZmvjx+A==
X-Received: by 2002:a05:7300:ce16:b0:351:45a4:7dd8 with SMTP id 5a478bee46e88-361a2843701mr266105eec.34.1792166983933;
        Fri, 16 Oct 2026 09:09:43 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6791sm9099098eec.6.2026.10.16.09.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 09:09:43 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v5 6/7] selftests: mptcp: pm_nl_ctl: support the subflow-retries limit
Date: Fri, 16 Oct 2026 16:09:25 +0000
Message-Id: <20261016160926.1155262-7-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261016160926.1155262-1-anilkaushikwireless@gmail.com>
References: <20261016160926.1155262-1-anilkaushikwireless@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
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
    v5:
     - new (Matthieu)

 .../testing/selftests/net/mptcp/pm_netlink.sh | 42 ++++++++++++++++++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 34 +++++++++++----
 2 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 21bfe1311f11..ddf2899e4830 100755
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
+		echo 15
+	elif mptcp_lib_expect_all_features; then
+		# missing feature: the defaults limits check will fail
+		echo 15
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
@@ -224,7 +247,22 @@ check "get_limits" "${default_limits}" "subflows above hard limit"
 
 set_limits ${max_limits} ${max_limits}
 flush_endpoint  ## to make sure it doesn't affect the limits
-check "get_limits" "$(format_limits ${max_limits} ${max_limits})" "set limits"
+max_limits_out="$(format_limits ${max_limits} ${max_limits} \
+		 "${default_retries}")"
+check "get_limits" "${max_limits_out}" "set limits"
+
+if [ -n "${default_retries}" ]; then
+	ip netns exec "${ns1}" ./pm_nl_ctl limits ${max_limits} ${max_limits} \
+		128 2>/dev/null
+	check "get_limits" "${max_limits_out}" \
+		"subflow retries above hard limit"
+
+	ip netns exec "${ns1}" ./pm_nl_ctl limits ${max_limits} ${max_limits} 0
+	check "get_limits" "$(format_limits ${max_limits} ${max_limits} 0)" \
+		"set subflow retries"
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

