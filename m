Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F22407CCC
	for <mptcp@lists.linux.dev>; Sun, 18 Oct 2026 04:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792297090; cv=none; b=M0Wg3F+/baZqH529lg6nUdKb6XQezA4lqGKvKcpqtQbc+0ZqqH3jqX09MXKhy6WmIvsmJfq+SCfgfZNZfOeX/3Dqg4YCUp44F9RbyWEoyD1625BUMVcBMmtIuD9+XIxSBS0s5Sm97/rrJrb8fOo2r9JzDlPke0hiXox61q3dEPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792297090; c=relaxed/simple;
	bh=dd0UxJHibigvFGLwqav+zo7qW8LJWgRHmdjpnPtuWcc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G83EklMeKLf5k2f/wqgnUarxCGGTiDGF68GomKV4iG6cJcRUhvFYJn8c++p2T3Uc5ont0A+kXM030iKjVx0zOMHmCF04OJ+Kwj72d9vHPHLp+o+DL7ddQnMNhEwOxrH5mf3/Da6XUsjriMaxVt5u+IXSu4Y/0FjkreJBKslTT4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SugMhgvW; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SugMhgvW"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-33fb4680717so820928eec.1
        for <mptcp@lists.linux.dev>; Sat, 17 Oct 2026 21:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792297084; x=1792901884; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h20OK2aiB6RUSneUr7xKjwtxf0LTm5blGfs0aJrLlL0=;
        b=SugMhgvWR4u7ZbZaMHM5vs/B5hAzICszqAqtW/Wf68B+QmmeHgrndfGn5pKzSG8UO0
         Ggp/irjiheMJRO19MnjBYHMMgx48GWuBfD8g4RUD74ZEfqgXf2i0vyuKy0E0Rh+WuAnD
         emxC5bH+PvoUm2R2whBr1bphlJ4ekDrIaYNJ27GTW1rJBWXYaYatGO7L9j1OOdWE76/P
         nNpG0j85MnYPKYp2dpLccWsWXSKFLoz9vMpnPMSi6WOiHvqvp98T6yrrzQP9f4nwz6FW
         Dgj30Ap2iRUkncL1ZnEhURf2BAbMXzd6xh4H6gNLc4LVEcs5UxtB6FNWs7bhIW/s3PaI
         qI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792297084; x=1792901884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h20OK2aiB6RUSneUr7xKjwtxf0LTm5blGfs0aJrLlL0=;
        b=lGk++FANtD5LfhjSRgpz82Be5XXRIrTORdXAlbWXAcpAWTkZ5JbrLWjO72DwQxc8Ji
         UrOCKHX13OK5uwGFGcIDaTT5URwyc8z/s/SnAdscnsfE96XNZUXNUzXT7nDVEI5AC7HH
         YiB5XqKaGQtY9us1wVR9CgZwn4rOdHBe8EWk1ZpHdNUhEp/tz/qTIZnxQK1JBQ+UgRjQ
         ZtYVO95NljVfTuInMusASgSKE9d9A8t0QOK9oVL++UJAolEc3S8kVlfZ3xWAw1S/0cnB
         W/jvG8xguEX90vq4tAKgV/iXC9ctyFiSu4KBHmlH7p6KASYttYBGPSRbU+YmmvgfJy3x
         12ug==
X-Gm-Message-State: AFq9FYK1R+yI9A8mvlFbi0ZxW+b1dJMVPaY6sdWSnieU/V6dbnVTvTOG
	ex+H9Bn4mRhs7G/z/kUeh6XxGGxMnlMCXpGCWL4n0yJvK90K/rgb3wJ6AJNWHA==
X-Gm-Gg: AYBFou3lYokgbkAZpnqkwtrraHKVlUg3kvG/oQKwi7T3c8rqygG8exS8wZ/2DkT2Syv
	WwSEKzgy8jvyvdjztVix1Au5h1cJqI+5isTnNyG7Q2a0fhxtlzKIjpq2pcKgm23buaPGYofzJIq
	jlgij0arDXr+/gKRU9J4AhHRfWCJDgfJGMoLB8B2foBiFcsIFc8JAMeVfHFYMC9x2ySrSDjZnNl
	avr6XYKUdxL2nt7t/VVZUvDcbEspEEEBNhrctjaEwNJ7BZqVpLujsk+UAuL/RMp0acqlgq9pCby
	3ZxLkwWkbkTfNMrHhuAHSyDXPXOEOWdTjRBPpMp+PKEQgguUI7fVyZXnNwrJOA8hZL43UofcUPL
	B/rvC1dMofvZr++s2HQRMgeQCaTGFI0s4JIwtBQduJNVuTRxuCP2t6xKzSkg9/UdEjmff84vWyB
	LcZeV7Bmn2yl1zqVBkenGpA2cCMfBv9CWiexggWhQkSmvRiOaYQ62X/x2nUcJdgDIKuqZETUCA0
	zPNTdkcdYCox9fEOcjdHtczt1BsQ6ETwLNkijez4IzFYW1uyVM56fG40Ozr7Eu7h3A4eInYBFUa
	BwOH9/dO70490FO5pD5X+Mj9oC947M+jAkOUqwaB0NU=
X-Received: by 2002:a05:701b:4510:20b0:185:fd0c:457b with SMTP id a92af1059eb24-185fd0c49d8mr5112412c88.41.1792297083414;
        Sat, 17 Oct 2026 21:18:03 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831919fdfesm17867932c88.7.2026.10.17.21.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 21:18:02 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v6 5/6] selftests: mptcp: pm_nl_ctl: support the subflow-retries limit
Date: Sun, 18 Oct 2026 04:17:47 +0000
Message-Id: <20261018041748.1655711-6-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261018041748.1655711-1-anilkaushikwireless@gmail.com>
References: <20261018041748.1655711-1-anilkaushikwireless@gmail.com>
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

