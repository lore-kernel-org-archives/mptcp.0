Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795308492;
	b=tIupV7MXIivlQ3vtriz+EVXt1/X/xperlWHHr92i+DUjtO8uxPqFZR09oiga/1lmnMol
	 h5V13Iop6w+5gsEUGVwP4lIdoZ3gt/4Ks5Nt6uAYZLxpbpKmNZPwq48XqeltsL+22lBfq
	 Ls4HER4z6KYL/bst3w2uoGycEWEspiWWwY1OTu9RjqjZT1fvr1ZDabPaa7IDiFHXZP7+V
	 StTeh/1DVBQH9wDmp28rdoZIeDaL5MXc6mmwJWCmfW32W+p+8C+AhwZfb8CAumFY1AABV
	 DwE7PtL1s4eWcZkifxD08QyERx5y82yAwy4aZgrp9fZ5XQR/1kytVfWmCxyZDlfW9ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795308492;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=232oChysPA/rWHZj7Zf6OWilFdAvYalPM5CrBj0BvJ8=;
	b=rPFgCVIGlTV8lnAMjW0jsy7l8rYqONTyDsuFN85YVLQ2VtwRGSAORyZdnVruWKUtOTgw
	 iD2xPXAtB7PRsZqlEZtFKSdJJbDLAwjCvq4tJw0C2KO3rZgjl2t74rp9JbI/txFJ7Yguk
	 +40QhnfNB2G3wVXn3ScSJ1u7Cmu6s5Q2D16qd4NHWK4jQ1BcJZEnnTt90yIN00FuaHR2r
	 qD/ugtEIvGyfDsFVpr/y14VGrwtq+rzTmiNDkXygCgYk7OOAvdVwbWF1rUiDbReOqHlv9
	 i+Hd79UR8mg3+E/cZVG1o6O1vj8pagc+OFWpnk8rg6ThkyGqkrXS0qUKm+/n8aEG/Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iPUNYRTR;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E37606A320
	for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 00:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3E37606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iPUNYRTR
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-380b40312e2so4779359eec.1
        for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 16:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795308491; x=1795913291; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=232oChysPA/rWHZj7Zf6OWilFdAvYalPM5CrBj0BvJ8=;
        b=iPUNYRTRxrdWy1X//a0GkjwQ1QE3Z5TsiNL1RVCu2y2jASvChTH5bDVdWAVj/RG8n9
         0nMHpnM9xX4o0F0fTGlMfIPVgpTKueWwj1YkHCSXD2V3P+jyqNTViKPqhntu0gx92/oX
         Gu06PqWL45m+ayaaxUG4lb1I7SUvP3z2dzrZOMAZ2QE0RHgRee/0dD6Ud0TwUh2VkApq
         T0dUzdClY2bhW+d5/jtG4UIkEjzQ3wb/NIot3OYXytYTqxHjjFW64A4ac5VaXNZBf1yw
         SjdgDSVQOZUROKU55SZiqvXcuC6eK1xLhegoE/pY4wIUNkMf9fgQGvnmJShRMdK7UgXM
         GJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795308491; x=1795913291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=232oChysPA/rWHZj7Zf6OWilFdAvYalPM5CrBj0BvJ8=;
        b=TgCFRrb5Mp6YvXES0+zrDUWJnkK6ZVsd9wUNNnSjc7NoFp3Xfq+vNGsmaV3cwSRgRK
         tPMvQlcO6nfwpddgXzsgSqzqrciwPH/s9Q6YaHlAbVW3lMCmzjzHTdm1zPeCImsgnGxU
         rXzSp/nbt5/mBDvFy1UXKMcQdv2FwJzqC/6vd0k5MPnRqi1R6HsYleDWR/LA79Kn5JSc
         +Tjk19dIxOkqvTjXVb/8REZVjwqdOd5nJ9WgzlFw7h9y9+VLzSsGZLtCizOu4HSRF97K
         Iqz0efBShYFzjXNvhec8WMQTMoN8KGm0+dlFClYmiWJiNckqa+kCSkkNag6x6cZdyGJO
         zVQw==
X-Gm-Message-State: APuU4Z8rSpp2uAOB3l88wVv+FmSjC/TNYvKbePELriVzkP2/ep/XQPLG
	aiZYaCe0gQ/S8YNjNVlxmP2hRqXK3AwJlGC/vZ/246gZh2dxXgwWO4b/4UzL7A==
X-Gm-Gg: AZFdTZd3d8A+Ucy7iSIivcR8CTStUNhou2DhyQF3Rd03KFxZnVD4u3Q2f/B1HuCIgzh
	FLTvtey0064k1MQ58cy54vjM4xVrAxwONH2TwVlCtxiV1ExroXibNp/Z/dXKHXn7GmRb6xJd28F
	A0veBIyrzD966O8tskGoYx+LfMAr7xSCq4aM91lM0XnARogZcS2t7cjcpRx6/NoMBU2zfQqiqns
	ixuoim/ptnhPRIEv5dXMeUOa3Ae99kbyMC4CzLk/m5GI1QO07/Fcevg1ndjdqCyrTYL3wcTZmOf
	bf3+NwYS12J5btrr75lYlyLiVIcGbAJytahHW3YRjTZyXUhkcj0DHkshtxYbbtSCHQe05d7ezIU
	VQ0vyC1KGqhVUrGFI8C+lJhsVF9TFq+5509B+WhF0rz7QbGU2KYfXo8N4CsgyVRhU7/AR9sHdgc
	vAdCU3gVrUeRTAkR4+AeLDAl5SRZ72R1rdrpARfr7aGgTqTXnGGyCz53n1ML9QKodvVzgJPQq+4
	A4QqQUWVkcQVvVbj9CsdSj2LY3SfVxCvpj9uOMqx0LIVszbg7HVcIq2LZ1+Mi83dcD22z+t2uo/
	EXc44yqUrwY+qalBHaF5CC62nFOLDjb3jbTrDlX185sBveeZDQh0wJ08crYnRZOkkVubtmaCF2U
	FfSehJq8hTsXv9YUT1M4Xw1aqi/cyQBJFkX1JuZtSSYq27gU79/TBwnBoiKm+Tw+kboleIBDfFg
	==
X-Received: by 2002:a05:7300:d941:b0:381:3a24:1be2 with SMTP id 5a478bee46e88-3856fd5d566mr8431101eec.13.1795308490734;
        Sat, 21 Nov 2026 16:48:10 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672ce402sm20219599eec.16.2026.11.21.16.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 16:48:10 -0800 (PST)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: anilkaushikwireless@gmail.com
Subject: [PATCH mptcp-next v16 6/7] selftests: mptcp: pm_nl_ctl: support the subflow-retries limit
Date: Sun, 22 Nov 2026 00:47:53 +0000
Message-Id: <20261122004754.2276802-7-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261122004754.2276802-1-anilkaushikwireless@gmail.com>
References: <20261122004754.2276802-1-anilkaushikwireless@gmail.com>
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
value, and shows it when the kernel supports it. The shared
mptcp_lib_pm_nl_set_limits() helper takes it as an optional value too,
for both ip and pm_nl_ctl: the existing callers are not changed.

pm_netlink.sh checks its default value, that a value above the maximum
is refused, that it can be set, and that it is kept when only the other
limits are set. With "-i", this is done with "ip mptcp" when it supports
this limit, and the expected "ip mptcp limits" output includes it then.
With an older kernel or an older ip, these checks are skipped.

Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  8 ++-
 .../testing/selftests/net/mptcp/pm_netlink.sh | 59 +++++++++++++++++--
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 34 ++++++++---
 3 files changed, 88 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index e1c8c6fd8820..7039ee7356ce 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -689,15 +689,19 @@ mptcp_lib_pm_nl_get_endpoint() {
 	fi
 }
 
+# $1: ns, $2: rcv addrs, $3: subflows, [ $4: subflow retries ]
 mptcp_lib_pm_nl_set_limits() {
 	local ns=${1}
 	local addrs=${2}
 	local subflows=${3}
+	local retries=${4}
 
 	if mptcp_lib_is_ip_mptcp; then
-		ip -n "${ns}" mptcp limits set add_addr_accepted "${addrs}" subflows "${subflows}"
+		ip -n "${ns}" mptcp limits set add_addr_accepted "${addrs}" subflows "${subflows}" \
+			${retries:+subflow_retries "${retries}"}
 	else
-		ip netns exec "${ns}" ./pm_nl_ctl limits "${addrs}" "${subflows}"
+		ip netns exec "${ns}" ./pm_nl_ctl limits "${addrs}" "${subflows}" \
+			${retries:+"${retries}"}
 	fi
 }
 
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 21bfe1311f11..ca8c5db00ea4 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -46,15 +46,24 @@ trap cleanup EXIT
 
 mptcp_lib_ns_init ns1
 
+# $3: subflow retries, if supported
 format_limits() {
 	local accept="${1}"
 	local subflows="${2}"
+	local retries="${3}"
 
 	if mptcp_lib_is_ip_mptcp; then
 		# with a space at the end
-		printf "add_addr_accepted %d subflows %d \n" "${accept}" "${subflows}"
+		printf "add_addr_accepted %d subflows %d " "${accept}" "${subflows}"
+		if [ -n "${retries}" ]; then
+			printf "subflow_retries %d " "${retries}"
+		fi
+		printf "\n"
 	else
 		printf "accept %d\nsubflows %d\n" "${accept}" "${subflows}"
+		if [ -n "${retries}" ]; then
+			printf "subflow_retries %d\n" "${retries}"
+		fi
 	fi
 }
 
@@ -71,7 +80,24 @@ get_limits_nb() {
 		ip -n "${ns1}" mptcp limits | awk '{ print $2" "$4 }'
 	else
 		ip netns exec "${ns1}" ./pm_nl_ctl limits | \
-			awk '{ printf "%s ", $2 }'
+			awk 'NR <= 2 { printf "%s ", $2 }'
+	fi
+}
+
+# Prints the default value of the subflow retries limit if it is supported.
+# With ip mptcp, it also needs an iproute2 version supporting it.
+get_default_retries() {
+	if mptcp_lib_is_ip_mptcp; then
+		if ! ip mptcp help 2>&1 | grep -q "subflow_retries"; then
+			return
+		fi
+	fi
+
+	if get_limits | grep -q "subflow_retries"; then
+		echo 127
+	elif mptcp_lib_expect_all_features; then
+		# missing feature: the defaults limits check will fail
+		echo 127
 	fi
 }
 
@@ -154,8 +180,10 @@ mptcp_lib_subtests_last_ts_reset
 check "show_endpoints" "" "defaults addr list"
 
 default_limits="$(get_limits)"
+default_retries="$(get_default_retries)"
 if mptcp_lib_expect_all_features; then
-	check "get_limits" "$(format_limits 0 2)" "defaults limits"
+	check "get_limits" "$(format_limits 0 2 "${default_retries}")" \
+		"defaults limits"
 fi
 
 add_endpoint 10.0.1.1
@@ -224,7 +252,30 @@ check "get_limits" "${default_limits}" "subflows above hard limit"
 
 set_limits ${max_limits} ${max_limits}
 flush_endpoint  ## to make sure it doesn't affect the limits
-check "get_limits" "$(format_limits ${max_limits} ${max_limits})" "set limits"
+max_limits_out="$(format_limits ${max_limits} ${max_limits} \
+		 "${default_retries}")"
+check "get_limits" "${max_limits_out}" "set limits"
+
+if [ -n "${default_retries}" ]; then
+	set_limits ${max_limits} ${max_limits} 0
+	check "get_limits" "$(format_limits ${max_limits} ${max_limits} 0)" \
+		"set subflow retries"
+
+	# not given: unchanged
+	set_limits ${max_limits} ${max_limits}
+	check "get_limits" "$(format_limits ${max_limits} ${max_limits} 0)" \
+		"subflow retries kept"
+
+	# not from the default: a refused value differs from a clamped one
+	set_limits ${max_limits} ${max_limits} 128 2>/dev/null
+	check "get_limits" "$(format_limits ${max_limits} ${max_limits} 0)" \
+		"subflow retries above hard limit"
+
+	set_limits ${max_limits} ${max_limits} 127
+	check "get_limits" "$(format_limits ${max_limits} ${max_limits} 127)" \
+		"set max subflow retries"
+	set_limits ${max_limits} ${max_limits} "${default_retries}"
+fi
 
 flush_endpoint
 add_endpoint 10.0.1.1
diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 36a6d39b31bb..b8413246d3ad 100644
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

