Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793166119;
	b=aPxpjZCEZY+QhWueSohi5gVm5O3+Biq41GweUAxpVVXNpsE8ypTu7pPuYP6Rafuk3t5O
	 QefOddMThBZIhvK7F3zNuXR+9DS+VuXVeO1zyqXiZ7CkjlQV6CzEQzmGRpVXR+vW5SCAZ
	 fQ1Dlzay8wc7kVXt0triK8nrOOXvPZmu6ORkY5XMEXW2JTRIgZ64AEYuEkgdJn+9KjIUK
	 OrQrKlbxE5JtTrGYu56IutsxwqsipETrUJ+5kkji5h7Uqq+abYAkN19AL4GQAV5BJ94OI
	 qxNWH2cqPWbyg0jLkUOquDv39C0tplzbX61oCz/hzKSlkoal5JunK+ADM4WHXfL560A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793166119;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZSJXeJ0U3dpO9Dn/SRJ5riHzWjhsmdC7lpOaZK2mNqs=;
	b=KzmsabVtY0SJvYCF+gefdceCEbp40hZbKgHhrom9PlfByovHG6fQxMHqRU7uLy3neC/4
	 fem3+Hly4gvXUq1+0Z/LwjQkCJF6ISPnsiBa+B5kGLpgviQ5UKte0o38Y18VLILOTXDb5
	 7tltFPuOKfIUjIKPhrPYzxPeT1+DxUXqbaVrwSLhqG1ACOuxEBTp3la1QhWk5kW39hZGS
	 3kEP/X+YpjBW9b/374lK46YbfEJ4bZnZnWCOL1cD16uiJp8Bc2NQlykBEY7vkPhHH4BpQ
	 vfdQWqLlpA1HxD1706HG5TxIJersdHacVJeWxxBSpVc9AlvYjB0H42qCOWPFkD7WTzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=isztLseQ;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91C8606A329
	for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 05:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E91C8606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=isztLseQ
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so971129eec.1
        for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 22:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793166118; x=1793770918; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZSJXeJ0U3dpO9Dn/SRJ5riHzWjhsmdC7lpOaZK2mNqs=;
        b=isztLseQ9MHFr/Hq5WtwcZIQy6dxiR07pb266qsP9EWeVYWWUPHpbMvHk/C7Ur4/v5
         PMv3ni9KrlBLmWWTMPlI14uu/zmrIv5+dlqrTpynx+bV8BeCpSY+xTTnbEu786S3U6nM
         nRGbsiPSOAgNO1yTRMDiiW8klqjJEtwVpptxVY5BkZAvlF9eJujEHISBQborPV4S3dXW
         1CgrykAlnE6KwekiIIsSGxo4wAvU/M6GCeGgdBO0h1mM3+FgmeVdrevDO7gKzC2U+bC1
         24YBe+yFIcLbeByaDJYUGNamSY3Revua54UHQDw/1l5pDmugVUb1zIdaTGWFPNMx+k7X
         taEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793166118; x=1793770918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZSJXeJ0U3dpO9Dn/SRJ5riHzWjhsmdC7lpOaZK2mNqs=;
        b=y4dAaWN+N6uUcW9yX/Ap7fiNtvAeLjcigYncVQDnTJW4BTXJHZNFeedKF8AZJE3zBe
         uuLOwQt5CFdAnv/KRxmpBC2sZ1smnMUFHrvvpTTvLDzP+lamT3q6JMrl7AhXqAAAHBwm
         igyfeLv2Q1lBi+raNGlx/2zF0mSRhmijnPkk6kMjVGOzcMVymN78evO2rcrPaG0ztbxm
         uM1wJKboe4mrgMyy6du2yALyIeLF3RZu4a9Kf/ovCKNe0WSqg8jooxF9c30RcDhQWNwk
         tMp9MKFsuu/1D3OalaBL+GUpkbBWXotReLTwfwpy4mvuZkhyowXdDDGcqaSi0p08BkZM
         c3jA==
X-Gm-Message-State: AFq9FYIWGs3wRxBZpoFuAPgvXkkfpMFSInwl3VLtrhSVXmROTPnYmw8F
	i9Ph8S36TdtHHEprvbgAXXdaoy/Xg0hzpAmnS3jZpi7MU/xZuaB7KjZOj4XymQ==
X-Gm-Gg: AYBFou1inYlrEa2VWaHX+GhgXusf6vccav1kgIxOflN3P6j2QjcFof2wc/2biH3YrEC
	w6Qx8dBDODmWZiH1ngWojdmixTs8okP33DO2ruknYJSjgq0juRd2DM5tVMY8GEnimLkUtlmff0I
	4LMoaY85iWk4nux9PK7a7Wpt6zHm2KUI2hiWW8bTY63SdafTWcfUtlfVBPwgnv1nVta/FXPWetA
	80cgvxn1vv5v1JztuExzRKatuJDprzippQjvkEBdVjzpAe3Hlgb+y7lTZyPvbVzxMMru/jZRmaw
	ri1I2sghTuj4gHjriOO4UdUVlFyunEUbm0rx57RMONfzi/Y9TNVo3UGJ/vtUy9QnQb3JR3tI3cV
	EOQiTn+MegyKnwI+2AGBeGT2oTGo3CwI5NnlsZ8wuQVl6y1UzSyTfI0nCldL7R3IAMZUt+5PIR/
	hBDCD5/1uIpfNwUOeWrXhNKYTGOztiyqfz3pDkfQVzt0UHGF2mhutdfvDlP9I0u6y4mn4WBJIU7
	lf2Jz9Seyq/QW5AHozKWgHY1w2p/wR9BssvQ6rK73vHGFi7ZSXphLdrzabSfWv2aZ+pmwrvgXUQ
	H/ISKAAODiQzgOjtWUJaSPnRKYAK8kel1DPJvOgq0LL4ur1DP+et0sl7BMnagS1sgrjpUyUnLSb
	qrtCdH7b/yuNdxyPBk7iovcGib3KFhyp5s47hiPQYqbVdQa0giLEesSEhW1EhoCc2z/VbsCf08d
	bId+M/6TcF1up4s5IEFIY=
X-Received: by 2002:a05:693c:8956:10b0:369:44b3:99c0 with SMTP id 5a478bee46e88-36a2036d4e2mr2156013eec.8.1793166117739;
        Tue, 27 Oct 2026 22:41:57 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a237be80csm5860973eec.2.2026.10.27.22.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 22:41:57 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v12 5/6] selftests: mptcp: pm_nl_ctl: support the subflow-retries limit
Date: Wed, 28 Oct 2026 05:41:42 +0000
Message-Id: <20261028054143.3222998-6-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261028054143.3222998-1-anilkaushikwireless@gmail.com>
References: <20261028054143.3222998-1-anilkaushikwireless@gmail.com>
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

 .../testing/selftests/net/mptcp/pm_netlink.sh | 53 ++++++++++++++++++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 34 +++++++++---
 2 files changed, 78 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 21bfe1311f11..5c27836f527c 100755
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

