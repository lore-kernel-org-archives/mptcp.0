Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792681908;
	b=BGsjzAZcpa2ceviNQj+Ucx/1yWsIYGpXud96p/QauSDsVu7llY6H8qPiKf4Y5dDJs3YB
	 JjTJt8Cl6d9xLJTKJKrFmGKQQV+jcL19GD4UG0TyWI43VmO6OJ9Bx6FWZFP4Wnf2M65u2
	 XfVO7PckzN4u3SI3FvzQGxfKmAsSPSXOYOaBw9liZ3iNuHBX/Hynxq5O6FNyX1v6M6yWz
	 tBLc5NkKmiogMpkZ3g637otJ6Lr5al9/aujxbyyHSNQ0irWpSbXp/0cjxJaFQWPA3BZ7w
	 EErt6B4iM9jwM/CJpfBxBYrL7vap9NGnkp28CvGrbs7ZfWprrJUB0GnRg3OqOg8p0HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792681908;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=H31FavLHUZ5NifMPACDn/bsGGxOI9xS7MhE1+80jhvo=;
	b=Aw4duJPMk5Equ3jvj+hVeC6ArkEyFmYD1Nx1a/Vqb2ODzMn6ZmvT/bQEjIxK6GN5vCyG
	 pQ1jjXz71+wMyx5ufkia5n2gmMYL5BpA0M6699dcOLjyKNXqpHqsNVZ9nSL41TrUdNakj
	 El8cYw+5RmejM7zb6eqNr5RpyF11469xm4WrB+HUQOhcdbkXq4tTgz8QJc+0KyH6xIEx+
	 4TzT6JdjkfEYTRHM1cDKPCjVWiFRjow2lg5wrr92F8HApwHWk5EIObiF4Tcr+IGFgVsME
	 /W9B20dQv+pIbndDrCU+z+RKWsBAmccCOSHNigNPDS14PZiu2Dcss4TRw/1b95hudCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y5wlDCC6;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F069460A6F66
	for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 15:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F069460A6F66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y5wlDCC6
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso3296831eec.0
        for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 08:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792681907; x=1793286707; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H31FavLHUZ5NifMPACDn/bsGGxOI9xS7MhE1+80jhvo=;
        b=Y5wlDCC6z5/XXgiHEubILZ67tHy9f9OOLnpJqyGZ9khwz1D4WBc6xeqJvLzGRIhUV8
         De2apzIxMTVvn2J3cdGQycABWS30BD/t82XMca+lTNMXSs3xnJOhiigCaK1Q3DLPcbpO
         Xd79fy1w7Dxs/u/GxyI295n/PzXoyBVerPjCoSENXqTmb6+4V0iKoxS2pNlPDY/tZnqj
         X4VqXmH2xfUZHCnN2+ZnybY8C7lUqFZw0dqmlWLgOqCxRcMGouyMh2NhCgEw2gFHhWro
         Wo381MCoubFQab5ZUgTYKzrRQqtHsfnTyL1+BKFMcpGKNycEMu8saB9Fi6DnzmoE1hle
         DW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792681907; x=1793286707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H31FavLHUZ5NifMPACDn/bsGGxOI9xS7MhE1+80jhvo=;
        b=eWWxlqtw009qRvmWeh36ZBP1addfxHCYuOzhNA95O5FqRr5kM/9DwmGD4Rq52HU2yX
         HprWJawOVTVrlAVHohI2VDtcVDOPiy+Mcl3dqyZetl9XMOHNIOEzwyB0e/Y6xZeuZA3J
         Xm/iFM+eAX4TJNde3M96UACbW+KGJb3omPC5Ss48yhj3yMfa6pdGCMTj7yCZAgM8GyXx
         MgVDVVnXnXdV+bXnluOBGYfKpORxaHna5yOpk4ZhIqh7rCLy32uERyNYQRH7JRCDP6FV
         ed0XQSXlrhhj1/ojNBQ3y7B37ehiR0PKBUGraD3d7P81nfWWcbXxNdaWWuX5rxuZpiPH
         5eeg==
X-Gm-Message-State: AFq9FYIbJTyO5SYLEMynSXOUQr05lNtUsPryGCywajLjDG4ia4H6FSqy
	AJwB2nJf998VCKYBkyXLr5ICue4gOPtjQV8qFFULzg9yd/0/qpx0nI32y7CtMw==
X-Gm-Gg: AYBFou1OcrLwC9emm/pmPBd0ljeASmeG7ZDmRpJbfANTlT73yCTTGPt5s3i/xnB1AVz
	v99Fo19zFH/S2IR11yI8o+qPMa1IwgJTz6o/DDYTKUGYsj4YVYzfzByknrFXAOiUvztafCVqKNg
	tpyehjmRNd/aasTErJxDylk0Zh68WA8LrKACVJQymwHGstpfhUqJIxNaeNbGA1ldtlJk9YVvAn5
	SjUzSl8zVobgmuGrGYFdSXz0OpItOMIFap3BnjAf1w3VrdqwlKWtGlEY1c2x2bCEdOY8p5jcWKd
	AT8A+ApeXQ258fYiqD+PTXhIgw4w1P5AGq8jBtTiXOegCcT3S1K36sFurLR+g7hzfQmJBTWhUFV
	kDLMTbzYSiCqOYq8i7Dml1vfGIzbS674o2ql8i1PcCgW9DqhLFDokdYtpJhqA0qG/vNFwl+ZwNS
	EAV21fMpKDPAVYD5ilfYJGdY51C3n3TQQGryxKrDPFiDXdaDvY4RxMswKqLp/10Gr5jGnKdNgpl
	ykmNZ+7q7wKfa5DOs8QKE2mFaDUykCg4W1wqfCGrOKcuUzvijuMTz0z9HQ9LKgGTpfC4LMkX3fH
	U6xENCqd5yz0f1tUJ/CR4ZATkft8kwIuTCrVI7Tq5P+xxHd3Wh9/NXhXXN6PYlXzO0MEBUFu0Qc
	USyw36xlghPkRfsPkr6C142OC
X-Received: by 2002:a05:7301:da02:b0:358:45f5:daf with SMTP id 5a478bee46e88-3674e35502cmr6819438eec.29.1792681906492;
        Thu, 22 Oct 2026 08:11:46 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36741e71eaesm36327560eec.26.2026.10.22.08.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:11:45 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v8 5/6] selftests: mptcp: pm_nl_ctl: support the subflow-retries limit
Date: Thu, 22 Oct 2026 15:11:29 +0000
Message-Id: <20261022151130.2285198-6-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261022151130.2285198-1-anilkaushikwireless@gmail.com>
References: <20261022151130.2285198-1-anilkaushikwireless@gmail.com>
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
    v8:
     - the default value is now 127
    v7:
     - also check that the maximum value, 127, is accepted (netdev
       Sashiko)
    v5:
     - new (Matthieu)

 .../testing/selftests/net/mptcp/pm_netlink.sh | 47 ++++++++++++++++++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 34 +++++++++++---
 2 files changed, 72 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 21bfe1311f11..99072ad8052d 100755
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

