Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695982;
	b=mjtqpiODuin5Gp3tuYtMm+TOVwwmDQOCg8JwuXjKzm9Dj9/dwZTUQTEDl+QJXPnUC0Y3
	 JsA5wc6udtR33QkiQLyoW98o1yoJPAB+G4FpaQ10PoRUs9Af933lpoeJo58Kvp0wmJJDM
	 m7skh3sCOyuPoT2SGftVb+0Cx6/u4ckC5/Y4lvYQNu4cJT6gWDBGqcsV+rRWFWhten0Z/
	 c2y4ozKK//FDmSiwXl/OnyaxY4zV24wESxTCTfzQvS/LcY8yAKfowRWrGT5y2WoEh0C4b
	 nuY0nYI3Q0fbYP5VzCI11bTuHdc4QxeomI+mRhWIpZibbP0uDxcoeKZf++hWnwHfiuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695982;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bk08wlQLOckMDa/tQlUY0Gs+7pq28CqTbcZ5/8r0npg=;
	b=B0h1DSgEpQyrOMGAT1i4z3pU5v9cInp1gflzpPDn1csU/A064EVVW5F6T233AHIcrbOx
	 sO24ZE07fZ5APVYU0/Ojf5MxikIy4ontoWUqD3b9DI7F8BBF3fqK0rQ0srNE3lwDE19fm
	 vo6K5n/xr/S9E5gOSRw5ZZd2Liw+dPPBGexdx67QD7ng/aZyt6QJnoyuNTsJcma3Zn691
	 GtSC9RJXtJnmF9KOM14SxAeEjdZnG4/YsbbsR3CX2Fez4pHnO3XjfKHaBTF9ioxcz961o
	 KX0tFchVi5I4mk4S2SK/+9s7XXBHif/3mbE6tqCXJDIVN9XWhm45bcESK8hYsVg95/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ItuPpE7S;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4766606A326
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 08:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4766606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ItuPpE7S
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so5544270eec.0
        for <mptcp@lists.linux.dev>; Tue, 03 Nov 2026 00:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793695981; x=1794300781; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bk08wlQLOckMDa/tQlUY0Gs+7pq28CqTbcZ5/8r0npg=;
        b=ItuPpE7SKP2r6gKbOeKkDoxEdQLrNHwPCjTjQnYsXhVhhq8FwYurUcZu4dN/tAmaHA
         yxm76unfHHDBp+nB4ODxRtS2ohUanLloPht9T1VQteMQraNNq8XJ/z+7kVMYUZn5dOWF
         NCexhlUl/yxb+bt9BfRD7IVfdtJT8t3c+WtEhfy3xwujN+WneNxmWCN9/ztJv9MI9yBz
         WPZ11puZ0ugue54vVAitYMiCkY6XIr+5dljnw4s+dlnMnIjvEU5tUnBxVCaJB55+1yiF
         StVST+seoW58MGTHQv77Vus1beu/2ZSUVIjBRaIY3UJmt85R/pqUvHZAjl6bm9VJh4g/
         UXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793695981; x=1794300781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bk08wlQLOckMDa/tQlUY0Gs+7pq28CqTbcZ5/8r0npg=;
        b=Ngrd0ALs38U/k078bmYayBDGSLH7qbhPHAt7Mi4cE1FuGNn8kvfjstiZ/7pLCMf3EF
         07bT3aUAqhwxURAUq601j+0zIbl1+pXwnIOb/9MPEYS4okJKquyvPq9lxsr99LXM0Ams
         NWORMV/WvFF2TVgru+vc5ZkWts6tLpRI03EFX2Z6H7FGVT6I+24Io9js9mYX0l4kHHxP
         XUyD+sZYF3mYp4Hkac4rHWdp9gxaXDwb4D4fWQ1sgwDUuQU0g8xPFzfuBfrC7Dmg4Qu3
         cEERwYAoKz+EssY0re0a2fwc1YrKXHd90Ld8i1AP8ntJfHWdImzQcaokp+NfMriUX5ab
         OO7g==
X-Gm-Message-State: APuU4Z8UgnaNGCVfkGYgYMLc/B7Hv+6tl8UZOn7JJz0Rkb/udSBWrEht
	b2P4g82kY3iomlaDDjsgxZiuuClJ7If8GWjp4PzNKnqnB/r8XvzFhOXZIifEeQ==
X-Gm-Gg: AYBFou11lZifaWOdLivKd2hMub+3wgkyE+eHBo1zja2kSFwbVJbi3hCbmuCwdBXN9FQ
	bP9MM9zCvTIYhyxARGO3n10FqRR/amjKHuoc087zYfFEaygYs7+9X2ZPGvFrKepgb005aBf8QJP
	VuTh8nRe1DdDhOIpY2yHEADWczN8gh6F729S/PYbpIeJHuHJT+knNlha1rwDEFOwYFEvSz8Z2GT
	XnDDGyOxiUJI89cFRG43Gx3iYvbPk5JIlTvipaiQxf83Brkw790CMPZB/9WvfWSWWWbAcsXRrdi
	WT0tyF+shYmojCTi53VIui5tInHqIkNJPfgD66wKEWODhzY2Lh7++/D9NZPA1i59sqrMmSts6YH
	6XbD3EXQgQAAzo2dKbMZo0TJaZrWExwQrnwkGg4PGsrrNXcEQGmjhuKUzuXsutBELviQpbZhfxY
	OyrMuOWGARcsMsGcTp5PpWrbJnQIhm0QtMm2c34uB+XQL29CZxvrv9xreV3BSul/HIPUlsG/B19
	eC/d2u6+ZXYa4jIkGbDCcYO7jKry7cvytXGZsYIL+EeTV7oTJsVt1z4lXbpYEfZG0GLINrI2SSM
	kY5F+3rP4UtT6+J0QHEdQWr8rEYnmc7LUOmVNAwgDTBXnwbFhW0BU2HMDTUAmcCQyoQkJIXXkVQ
	wkw1Mr2OZdOp+cevTyekbcY0o/urIUIvKAAW9Yp09IbqwklHfCqpAQ36d1u/RuktqWJP6n9+LAy
	lW3dXMuo5s6nW50ZBI1Xmw
X-Received: by 2002:a05:693c:881b:20b0:35d:eb9c:fce with SMTP id 5a478bee46e88-36a423ea9b4mr18762082eec.25.1793695980573;
        Tue, 03 Nov 2026 00:53:00 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm53065635eec.25.2026.11.03.00.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 00:53:00 -0800 (PST)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v15 6/7] selftests: mptcp: pm_nl_ctl: support the subflow-retries limit
Date: Tue,  3 Nov 2026 08:52:43 +0000
Message-Id: <20261103085244.23064-7-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261103085244.23064-1-anilkaushikwireless@gmail.com>
References: <20261103085244.23064-1-anilkaushikwireless@gmail.com>
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
is refused, that it can be set, and that it is kept when only the other
limits are set. This is only done with pm_nl_ctl for the moment:
iproute2 does not support this limit yet.

Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---

Notes:
    v13:
     - get_limits_nb only reads the two limits set_limits restores
    v12:
     - check the limit is kept when only the other limits are set
       (netdev Sashiko)
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

 .../testing/selftests/net/mptcp/pm_netlink.sh | 55 ++++++++++++++++++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 34 +++++++++---
 2 files changed, 79 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 21bfe1311f11..80e100d105a2 100755
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
 
@@ -71,7 +76,23 @@ get_limits_nb() {
 		ip -n "${ns1}" mptcp limits | awk '{ print $2" "$4 }'
 	else
 		ip netns exec "${ns1}" ./pm_nl_ctl limits | \
-			awk '{ printf "%s ", $2 }'
+			awk 'NR <= 2 { printf "%s ", $2 }'
+	fi
+}
+
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
 	fi
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
@@ -224,7 +247,33 @@ check "get_limits" "${default_limits}" "subflows above hard limit"
 
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
+	# not given: unchanged
+	set_limits ${max_limits} ${max_limits}
+	check "get_limits" "$(format_limits ${max_limits} ${max_limits} 0)" \
+		"subflow retries kept"
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

