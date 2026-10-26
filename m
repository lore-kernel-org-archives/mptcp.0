Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792996632;
	b=4l8Hj/j5E7rCqEUhpAkfquuMyq5pFmjPhN7SODeict+iF2WuBLjtqVGFZ6dKW5Y122s3
	 txT+TqfeguV6FqLqtoepVtwJ5oF+gY1ErJTInwFbUJcyW6Jtb4z7lOO+cFfFQrNXy6LE8
	 1m80lRiW2RAyrdx1SkrgBy038o9HCT6RUNGxPnn6acfGQlDo4iM5b+vdklBu3dg1lFta6
	 sRn5bjTbKu0nVqCxul0f9FVs4YOGTmu743RlpzbxLz2GK/joYQd/z/mZeTGyFlDsa/GiQ
	 QHfMjNxb7QSUMTL/TRz/LLKliOeJI0OSyx7ga5liVMJWqkK56iAv0YFfr7zSWjhGVNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792996632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=17GOmCrtuAsxF144oT296XUfRZYmIcuHgGJDCaIHaZY=;
	b=kFUyECsEOta0/Uz11LCY54PzsotEKuJ31o8esURzZLSu7AjO0wOEbiG+fz4TffE/X8vl
	 WG4bLCdkBUjIs1dP7lO8LxTT1oGK4FYGJfvU5k41psJ3C8GMB/3tek6GHDq9lP5gSxtoE
	 8dAg+h63u2Y4YMig7DAllBSNzZwTeC1JPJ5M5G3bqpPRL2dl1c9yx4JaVCy2N0t2wu8A6
	 IJqkT55xagq+hRjuAAaHP7DZYXr1dqMOUoTJND0GnKQLHyTAqxi0UgtugDokl87TKtNUH
	 OxgSotBrJ0m3AsQCR7jUWHxYZ8kv5OItSEKf8jLSQY5KpdD4RndP9I6xq+8gD1/qZ7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q9AmxYvl;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68890606A31A
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 06:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68890606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q9AmxYvl
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36681e85e87so763359eec.1
        for <mptcp@lists.linux.dev>; Sun, 25 Oct 2026 23:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792996631; x=1793601431; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=17GOmCrtuAsxF144oT296XUfRZYmIcuHgGJDCaIHaZY=;
        b=q9AmxYvlJ9LuWWoyT+W+lpbRjRRBPa29q7dMnrm4+VVvpslbtaUYHJgG7s25Vzs4aH
         yFn5thadFZNsQzP+v6ogQAm+kByigxzLtc7qaKNSNR6zqRTnboxJgqMxTWX1kBWsVei8
         iugtYVmWEW9Pt0/bBOnVuKAb+ve2jMiK/8yUIBVlFawW0JR80epkub0Zfh8RxxM9t/MK
         Y4V9l4pKYBMB1HK3vCb2/CrjsYA1xihw0MJoAAJDAk0+TIFFgen5VPRR2jGs+XRmlhKR
         5Vk0ke1eyK26nRYGX49MvO0aOZ9UHvb8W/uX3wHrt2XpWYLBBWKvPtSl1ScZrXUau+lD
         EM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792996631; x=1793601431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=17GOmCrtuAsxF144oT296XUfRZYmIcuHgGJDCaIHaZY=;
        b=BFLeUMBqfMSVawswz8w41ocxKNSiNJM1B2Rr4+A5blOqndjSgCAhSEHc8ZOsWlcvkK
         HPztXTeKy+a/CJLEYjM237lfc2oULPUaPibWcwd+Yh4NmrNBBNTsqaJwC3lPn8hURPBy
         umfifr0xG666Za/cUwKIqhMtdRxyb1iLY8rywQvNSOcrUl5YjSALfwxoyDRpP6vnOXoh
         7Nq6Ywmj+5PszwQfjkl3kLZSYU4JIN08ZfXtPcnnFVXgnZ03a+Lc7MAjrKzRu7rIzVIP
         gFnWfKORDrk83IDHkSvc2j2uhnoGGZu9vbH/BTnRapYdG3dEEfWg51eFuqh2OphilGme
         gPEA==
X-Gm-Message-State: AFq9FYIzUaBfNMfdDFl+eJmPbhMNz9+RhtEEjg3+LoIHBLQlhMrOVC6E
	MjicFgtvenCMv39vfOkOckD6R+j++6Ny0bLy9z6H2+CQOAtoR7SC0T+3CWmjjQ==
X-Gm-Gg: AYBFou3VwC0D2HKvhQwKIfshvR+irqtIQMR53odSf55R9EDOQEVfqBcDScBZoQSIZuQ
	JFxQ2AZEoar9AgNiYOrNet4dMHNewzxRXv3hFv7EtLasybMPIV7UiPZ4WoH5pvVqiJ9sIXC8YOf
	6pPM8UNJXyk1ifGpK5YtcmP8MJHrGMFNeUKxirQe0F/qQWOL53fc2I4KRRfvxkl+nca5g1127k5
	gO08VVU8uTpCNMudKBJxedlP/iyLHYxE3rrtRGBLYHgl/6pz3/KlUKdJmvz/dTo1VhkHoyRhVjY
	VXIOrX8IjFhZuqm5yO7cTdd4TlXmexqj5p+tKOE8bzC9dscgi1rdGY89p874VRn4dZ5IZ2ruGH+
	5JJOIMK5bcWiEM+F31cKaVr7xoQ87xOkKzUnvFTavyV2D1setzZqhNzSRlC4La8lnFiTCZoKcUa
	s7SIoNUgAVJwq/PFQ+dyyDwGXKH0cxLTqqs0UBYhrYpj8/YuWtqj+kF+YB3RrKO3ThdgdW8qo+d
	PpD7re9WihCcloDJSgJgPAGnnDkrHvQgdPvjzf8b799crp6acfvM7tlFpgCAQyOR7wkXaEjh1Dh
	G/IUQXMaevagwf8sEiyaBQWfug/xgCvcaaN2NJxJ/zapQEZGvPrGIGMljlGPoUj7r0uemPs19rs
	ZxYdLzTX92+xwlxv/c5NbtwYGDWUecpTZBJmf8m0O3EJGvA==
X-Received: by 2002:a05:7301:d816:20b0:369:f277:7f09 with SMTP id 5a478bee46e88-369f277b32cmr7379930eec.25.1792996630868;
        Sun, 25 Oct 2026 23:37:10 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369ef6a71a4sm21191609eec.8.2026.10.25.23.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 23:37:10 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v10 5/6] selftests: mptcp: pm_nl_ctl: support the subflow-retries limit
Date: Mon, 26 Oct 2026 06:36:56 +0000
Message-Id: <20261026063657.2955783-6-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261026063657.2955783-1-anilkaushikwireless@gmail.com>
References: <20261026063657.2955783-1-anilkaushikwireless@gmail.com>
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

