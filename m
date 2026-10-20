Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792466249;
	b=PLOCaNQl651t9YMMfZYQhS/locvVpFUoxUg98rFoRH40GXK1ceOD7tHqL8R0R78lZiBr
	 jOcEXR2HSvaZJKX0LoYiORckD6GYXC/ghdxfTbE4YLNsnKIfaG8ww0TkFx+fiAAMSe94t
	 SgiVnlsLTR2Ka3iQB7JnlzOapKlHi0JB8EyUkQoGvKwVYnCMWNfb+yFw4gK9Gee/gR/t5
	 pwfRNccffExHgCCggat5kIFeyanNzqE4oCubkAMcSgAQkez3x7oQzgg/vI4iC3K5EhvBj
	 /68UuA+ygqNSnP+VsEHYqPJpAOou6WICdZiwza9UaOinb/LD163u8/hctaSIksZDdEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792466249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Wlfz9/ouZnAnj+rRYCXluV0M/ImmTBT+d95H4iW9a9k=;
	b=3++pXtd9wtQ6SxC7E9fRT3baBVjTjCRlXHOyhbzP3XK1wj41C/1LF3Ydk4nRguJyJ8wy
	 lQ/7X023EVyIZ5RQTNABRiZ+wQ7uXoG4iC5AfkTzMKJ99yO5+s2J3tSTJfKP2MR9A9Bgr
	 cySeamqrCDIrmbmSk2P5HpgTYXY5/iYm9kGivAryc1z5ENeIP7HWFGSu+pnBpr5jqwW8r
	 SkBZf3WByg0kyvNBQK8fmM6xaXkAbmmmKTT+xjT6HRXPy6M2OebqTe8Csq7AJzODgrw66
	 NF/yP8TQnMQJ7palFQe0dNBkl/DIjoJ08O9gMYM/5Vc5GuAyAifc1Vg3ibBr8/cSI2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=od6cRRpI;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26480606A31F
	for <mptcp@lists.linux.dev>; Tue, 20 Oct 2026 03:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26480606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=od6cRRpI
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso3551129eec.0
        for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 20:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792466248; x=1793071048; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wlfz9/ouZnAnj+rRYCXluV0M/ImmTBT+d95H4iW9a9k=;
        b=od6cRRpILrXOnm72mC6urb4q8fphloS1xTN9fAEnjvcVwyMv07BFQ/50Cem41iOHcs
         EcNJObcLf6nGrZQBcOTaZuD3FfoOQBbw4Ff+jaA5Ek24H7tn7S1SstXDf597w4SQsw+B
         Ct5dyqBGn8R+qjFIH1QwCJJoOFAVVLVolZjF7elJbAz8sGfwVFW8gdSHvEuPB1TeP4ma
         LPYnfqyJDcvLP7tZ69hteYfy7vXqcMsRtEm4L6MUtekjOlSGKFeH0rPTiQ6tVsO+czth
         k5fmuGyA6vNywXOCRE1STWopRvw+FbX28l8tdjGPGMaema0I5WHnFRVI8/IZHMOUPoKZ
         Sn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792466248; x=1793071048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wlfz9/ouZnAnj+rRYCXluV0M/ImmTBT+d95H4iW9a9k=;
        b=bMefzM1uDo4u3cUKQJ3K7Vg2OXXwlGIdGT72uGIHEYvqQjS7OdU0nVD+C8KhxsnrSS
         fc3cxCFMD0c5JN0ZMi7wYGfL113pBnPYVI/9iqS52/bRyeTfDByyYc4GJ/hKs3Bl4k6C
         EQE5wjD1iRUnuFSe3ewlsuFS4YaYSUKaTZv/xmFP5svTIErWcySXeTFM9mb0D3xl+AYN
         3uubYMU6K3xqLZVdrjllCoS6mZAIAV+mn2008okN6YPZUuKnSAdVt+rlaAPzubcch+wn
         T2sBPiLd1mx14eAlz0IVJRyIjtUtl5DNT0EiAivSkas2cZRiwo4dzHAk5usnv3MWe7OG
         HzjQ==
X-Gm-Message-State: AFq9FYLF9X2jk1FEU7peMwzhsc+2EbCF4Yxu19XeKF3cK4GtUmFMCP3H
	CdVCtdl0JQSyT5hXt/yvl5IFob1goHi1nvpyFZu4qu1m7DshLAg2nheTNiZ6bg==
X-Gm-Gg: AYBFou2exHmgiKuK31duEv9hAbBmFFzIUJGA1WEEEzdrVeQK+xWz0YmLhnSDPy3Vtg0
	twLGoQb2Z+maKJYj8LHKVB85O1uQfubCCCRyq/O0NdkeMXOwTtmF/N1cjupekaA9zu7gOCWUxL3
	YbnmC9S/ug32K0tdzK6cMQkvhYxGDnvTVSC9vyyCVXIIsiWULn0p94F/gDSyBLCXQdnZ/AepKnL
	lU4X9XOJKq5BREM/wpz0nrotoVoFb2FSnZfgn/mA46HbKSQkE+am9eDLELwYhXaSBUrWaZ33OQX
	8BivKFSH6FNAeCmFl6c7UQ9Mxq3/0a7dEf5txQL42GTVXk3kj0xz/iAfaEoBa/rz4QHksFeyruQ
	tps1DIvjrltX89hbOfC8AA/TzBzZE54YktcmYtWL3j6+sAmw7Sb2ol928K/rFrwsTkaiG0bnSoR
	bmD8A8g9D3OJn5WcPaV3CFJTiSx/9d5RvKhrFxbWWo/PDTySi5hE48t+zoe56GPpZLsFy5DyMLm
	SJJoGG/nUeXJ0ZkrTiJ59AYR3ocwcYBUbiNLCiKJfOBE3QQ/Rkdb2j2Jf38i3jpXQDmWNL7npyr
	gQ/adHorG9wC60L2YmLuT4J4zCXgBVG7qNPi+msZTpU=
X-Received: by 2002:a05:7300:cf81:b0:350:869:d106 with SMTP id 5a478bee46e88-361a2353ad4mr12671031eec.34.1792466248010;
        Mon, 19 Oct 2026 20:17:28 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360826875b3sm38473608eec.21.2026.10.19.20.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 20:17:27 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v7 5/6] selftests: mptcp: pm_nl_ctl: support the subflow-retries limit
Date: Tue, 20 Oct 2026 03:17:10 +0000
Message-Id: <20261020031711.1896660-6-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261020031711.1896660-1-anilkaushikwireless@gmail.com>
References: <20261020031711.1896660-1-anilkaushikwireless@gmail.com>
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
    v7:
     - also check that the maximum value, 127, is accepted (netdev
       Sashiko)
    v5:
     - new (Matthieu)

 .../testing/selftests/net/mptcp/pm_netlink.sh | 47 ++++++++++++++++++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 34 +++++++++++---
 2 files changed, 72 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 21bfe1311f11..f06e4f61fa95 100755
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
@@ -224,7 +247,27 @@ check "get_limits" "${default_limits}" "subflows above hard limit"
 
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

