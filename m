Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793336863;
	b=Xs+qAaxZiLQUmVd8Wm8cqjEL1HtItsSQrQlR1pp3ZTU0olEMW9DfQ7B3QOmght0TCrhM
	 wFtHHYfcL8Q5bo6Mv1VFV4UVEU65OcvyL8VTKHBUpM5nCriBW6LaxlRUD8yZyx7CCWE4m
	 980JvozEZ+tjLruDF7oIxgBuZ0EN7TAhXEpFjQzah0CDUnQSdzHmFx9cHPr5O3C2sTLfv
	 PWQ+B0zChj86VSX88IS1kuPRjSqhpecV2Z7uZz0lfeC82hMBuf+azzKt7YuCdv2xVl2jR
	 NEFPTZ7QHA4Dy24lGLupghkZvD76PZd9tywBlT+GueM2hzOpJwhqD68GKIz+Wr0bHZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793336863;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bk08wlQLOckMDa/tQlUY0Gs+7pq28CqTbcZ5/8r0npg=;
	b=y4XP4SNXkf63Kk2L/cOU9KFvM457vN6IA8Sb1G2LGXAG3D3/2EynJP2ylg+5IxbVXIWl
	 mUSVCGNVbh/lhSs9IC/HfVihqh85GVljLuLUSykg696Lt0MPtVw8E5HFzlUqx6X4PC++e
	 gSTCegyZmYHBzrGITO9YVtMO9ebn+NuqP+RM6Hi4k2Lx1b383s+zSTnsYqCPcZ5MiIFEP
	 ZhLGR2tlRCUas1rSqSdenC4BVS4zG8DlUt2GO62kdXf7QgIbR7fnmmgDvSsdlRuXVlelq
	 3DueSPsMMK3rvAalG3vfztbM5qrVB2jsYHyuo760nm1EGF138cek8o+G74Bo+SrGutg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eQG5YLie;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5A0606A31C
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 05:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F5A0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eQG5YLie
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-170135e43c7so425153c88.0
        for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 22:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793336862; x=1793941662; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bk08wlQLOckMDa/tQlUY0Gs+7pq28CqTbcZ5/8r0npg=;
        b=eQG5YLiemcyD7gynS3XoDDdULao3locHDmnrjG4et+2MjK2TgMvkAQrG9QLoWTjkVW
         paQa9x766enbRtr1ES2XUBgwtw6dkysWFI+eKFaWmTxtGZSnw4c9zEF06aFX6jjhneSQ
         eLT/IEu3OY2Xr2GAut6XRd9RvA8dplmGeYr0+3PMIUjAjD0jQYkJUPl+5cHintRFVYmo
         ZLfapipm8xNh3CcogXTVolyfpoZ1fD3mKfzs91GqZ+m33n3HNZTDxE3yVn5vENJXfhQM
         jslvQ6eh5W+XZVtPK7zUGqYsfuJoV/z/dcgudq6tP24oW/qDTEijCD26svya+HVLY3X6
         p+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793336862; x=1793941662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bk08wlQLOckMDa/tQlUY0Gs+7pq28CqTbcZ5/8r0npg=;
        b=pMtJRuu2tIpwPC8/BAYvPWdOpUpNSon+g+M2E+Uz1NQl4xiyY9b3lNs9qr6C8Xbksr
         DkCQ87J0eGQ82LsdnIl9N6I3Q+5LNQuNkKTt4S4L3IomEqYAEtleZUv4A1v0ltzsUI8+
         dRevMuVo9HxPGHMXlDwQRy2ClIf1ub23irn+xebAhQIUgvvTtX3EFpFwsO0bVBNUwMWd
         agXg+xscEu3zRIkuoML5wFEhqYqgMEA+krZz8pRqdcQPaL9Qak/4MbITZ0sDOMfidRce
         nZ/aAZhip2WePattDs5qY92sx/E1CaeC7i7Ssyf28Mf8tW0TLzHjalLks4xc6Gwkv1nX
         dsGg==
X-Gm-Message-State: AFq9FYI4gZc58E2OMkUjP0vTkor1p2yyXhXj3NakWzHnwzR80CK2X9p+
	TIBgpZGtBWGtd5JA2Jwb2ZQntx6d9mzyUCIFWtN5FhAzROfawmDyOleXGMa1bQ==
X-Gm-Gg: AYBFou26sjdL2UgbQ6Wod8+qHp5r5Hx+mqt02oe6HJ0A5bafDhw3I25ljRjfMaDl/po
	1plHNa/CpUSoDokhl1njjpeBnfW/L4mb6fzyfiNo60eDfhBDUBiZo6wTv3YREUEp/hTGqgkXLx9
	3XUfEGFYPlz6qBk1zs4V2KHNL//mbVcHj8zDFX7t6GZPKilGSw7y5mAcv0Dm4NUzU9rpJqiiAjP
	27Pimlk0iR0w0nluxeIwCIw2OdtcXULOq1Xrb5kt5JFzwoxqS4On2kjeGOEhz/tRX6a9o/Ri2+7
	weuMraskHiWMpp7/kuI6Mq1ZQN+YZvBroRNROgPvl4TNzARdt5rCpGOY1llaSXNVhvrHnkpXNpV
	d1hQ0p++KeeFTZau84AKves3fwRAbxR7yNebYVEgWwpoWqpiSBYk1r/naZzdPMgaSwmlCbhcadc
	1ovZi8W9NSBvGO1Rq/YFka6+yfGsdgmfgVZfpsqvmFz6xkPCMN17IS9EuZf2YpQa9bcNYvybbSj
	XZgO/F0GjUsRls17esUnjXZeZ/td/ol0kf3Mmf6tCdsQYUKdXaNCzD4AfVfgAALu9BH5C9kYZCV
	iruezbIoN2SizIFihZ5yB+wVVsOW4cAygIk4KR54n5b9+++p1IfvHtTqANPFlmD/LdH9L2F30w9
	nlQsIdaamXdcQRaIPgon6zHFa8RCCIiE9eS/Ib0kzLpFZei4D1ocTPJ9gvqo7zkDjPO5GAiv6iA
	==
X-Received: by 2002:a05:7022:628a:b0:1a4:c892:b130 with SMTP id a92af1059eb24-1ac5b9cb62dmr2225730c88.15.1793336861983;
        Thu, 29 Oct 2026 22:07:41 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1b38ac58sm3512702c88.23.2026.10.29.22.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 22:07:41 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v13 5/6] selftests: mptcp: pm_nl_ctl: support the subflow-retries limit
Date: Fri, 30 Oct 2026 05:07:26 +0000
Message-Id: <20261030050727.3534304-6-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261030050727.3534304-1-anilkaushikwireless@gmail.com>
References: <20261030050727.3534304-1-anilkaushikwireless@gmail.com>
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

