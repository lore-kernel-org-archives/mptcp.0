Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793019245;
	b=3i1XNmG4mSZqHuJP/3ZB6UnIoFvogxWeSyPVBwD5QGKq7DiLO6/+q6iXUEwPH+tdS7wu
	 MTh4oViKKaiiGeRRXrIDrPRGnk7c0BijKe3eKAs5QOBKigMLxEoob2WDA0nk1v4oPIq/R
	 xbtKvyTtqXDPz2Q+mo1HiBHCS9tzsrRT7nQhzguBhstqMj/kJLs1o0f2ZJto+88PCUGbz
	 unongRYzrPO5X5KXl7rGqKIxDTTj0mZ+UzL/B+HvJ8BrwqTO2O8tUB/IF8Fzz/KPbWMXp
	 1lD3ekAzPa7/JOtScPBEnGOIdFVtLXOFq2oBfKbC7quyUcpIA55KKYXg68WwH+Lv4Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019245;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=17GOmCrtuAsxF144oT296XUfRZYmIcuHgGJDCaIHaZY=;
	b=EvwfwxxafNoRM/dyTaGYpHUuDc/hk70PKgGjdhl1clS2Ab85hNJq3fkDVLgjxdADWA5m
	 OfVd3EX9BqWC0qHWPx0u7fKYFSP2xcUeeYvBk81PhWRPShKZ8FbFszdAiy9vO0YgXm7p5
	 zf3QOFBDCJEwBrCnQimnuobRSC6gzJgKNo5Jvs5oX40BpeZqT53gj0BFhlwO729qTX/Fb
	 5J9Ph8/Hr6cCbw/bx2DwncfnGvS1HHyssd47l1u8KXiWxUffdoqglaezb8rHTwnnkJ6sS
	 nuZ5p+Bn05madtntX5RYAJquYj+KRjOdy5PV9JacVaOKWs56pKsapo6driCJBoCIZPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Hc3GDB/n";
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B38606A31B
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 12:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6B38606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Hc3GDB/n
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1931ff67a29so473979c88.1
        for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 05:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793019244; x=1793624044; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=17GOmCrtuAsxF144oT296XUfRZYmIcuHgGJDCaIHaZY=;
        b=Hc3GDB/nevcyaU3k7oiNcBjcGnseeaH2aTG3YaR0Q4rY+fp2Z6QXeKW+esyb5JR+b0
         g0yCUJu8TP+4IHkvAfCu6zCymCeGtvqx4vyaJp0+HTVq2OB9xNLvYhCs5/L44oh+6HEz
         tBsLnPodRjSTWnkzOP5AJj24iBPU9qAc2T2RG5IazJ4zaInc3wtYFBv3FgSzOCjapHQB
         jxZew2MyEjhstF9/OX88ai7Uhx/xinJitv7w2Fdhv7w6fubR/tESGNP9I+QnnXj4STMF
         FVmHtNLdgjRg17UWcfaZBdrlHcH6E9Zw57NRm02CebbLs2C1cBa/qPr2F7L+qYEJOrz1
         BoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793019244; x=1793624044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=17GOmCrtuAsxF144oT296XUfRZYmIcuHgGJDCaIHaZY=;
        b=l1vDsqK8lgVEP1DfuqOrTqbwRVqjtNlAU5R7hChh6sdkIMpQY1ostnzS6ZSf+cTzCH
         U21YEuM5er98SGpREtynPdzur59WmgwpjXGPNWXBYWk1JWo9+InsXLT79HZZc8yWq3CR
         tIOrmlE9iaj+/JXagZ8y9WUwmW6er2JYYoJxctWftoKZNUAUseDXwidjsjUThwY8+NyG
         hqUMnt1CIS/JOE7GP5sbLEH325IpUANa7ntAcKnDHvZIiuXUN9qPmi3UbdSktaJG0vpj
         YC3mpnOU6XI/3if7ZYegwW3Ij+jFppjH6AuwojGc/fOItZG9YFXHrS8ILIZglAklrWrd
         Vc4A==
X-Gm-Message-State: AFq9FYLT/1Cj46MooIvrNTVk11fva3aXs2ForW/iYV86c3pHiZcsUiBE
	D2m7oPDMDAXuvCz2hneIA/Su4ShAbF5GUSi2KdgoKvr1ozljs6IuxPgBVC+Vqg==
X-Gm-Gg: AYBFou27GNXymKz1nYFUzPmtyGmHboMw7H+iZjoYjKA2y25TAKCdmw3+kkAcamwHWiw
	MuNY4miVFEtn7LcQI7kGziMq/rngx5o8622B+5+/GH/HgZ5E/HBrukxu4dEQEx32GIMQQy9qFdk
	Xm14OKXITrhE6vAoXX0hGvSpMJ04e6rmwGvjMrof/bWgCIIkljH+DUhjfaj41k5AGRSFRhfyUbB
	x2Uoit7c3QDqZ+99QObW7ayG7I649nEnzX9FYmcoLFM9O/vB2ou6qadMFxjIqMacYrfH00TZn0D
	U4kWxRuTs84eEKw04nxVlnzHZYpyswCz474Mf9J1X7u9Vvy+38+cp+0tH9Hgf9AiBBYBo9JEm/j
	OPkXpm+avM1whYaBaZYcLh8M67JzatNMN1DWLxjnMxbshbXumZ7jHIKuXQXV6oijz8CeUjG3tVV
	mNI+0c4RqK5YWXphECxPNlM2dhh4JUKBdRTDf1xhuAHWlctNkKi81dyhGsZHukRavpgt58zVZwY
	pBo2Zz+6GoWwWQ0mSU/2thzECKiGd2qC6Yxfgyg/kzbF9VRqUPeuYR2ZTBCwRX+U/ccLAn94epP
	Rkg3q9AR6MY10VB9EJjY/sJ17MdUwzC1kwIL9qrJ33m5PPHHruAb10iuzHLIshM6OElwawiM39t
	YVT8tw+KclPM2f61bqNy69Bu0
X-Received: by 2002:a05:7300:106:b0:35e:d765:77d2 with SMTP id 5a478bee46e88-369e8629ed9mr11370543eec.41.1793019239699;
        Mon, 26 Oct 2026 05:53:59 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369f4164886sm18377923eec.7.2026.10.26.05.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 05:53:59 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v11 5/6] selftests: mptcp: pm_nl_ctl: support the subflow-retries limit
Date: Mon, 26 Oct 2026 12:53:44 +0000
Message-Id: <20261026125345.3019372-6-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261026125345.3019372-1-anilkaushikwireless@gmail.com>
References: <20261026125345.3019372-1-anilkaushikwireless@gmail.com>
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

