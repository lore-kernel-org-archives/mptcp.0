Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793517666;
	b=HBagkh6poZroEZ7jfA1AfnEnYx2Hyk7aG0lpb1+vpPKlsFLUmZYLKLzUtulHDPlbXsQc
	 ClTg+gZPTNdk1Hyr6+OV8z2J10+XgZhwpI1AUMJTJ2Hxg4/Puz+ZTtKb/Fl2f60exGauW
	 pjo0Wtut6jwFCmQJ1SnoXixg0iK8qVy7/rYZaZjStDnGF2NtCZ9VaGjsS8To/sluDGlbH
	 31FBaKoxTXq9kTZA0Co49HYr0qc0GjELM9eoNx8bU2N4XAjwIJgE2GSgjlJ8xvjmG/ymA
	 RDjt5S36S2mxOT75EEkzBjfzndTNaILPO4dMh3bPv34/Zg+L09nMb4liPRjBK40Brwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793517666;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bk08wlQLOckMDa/tQlUY0Gs+7pq28CqTbcZ5/8r0npg=;
	b=g/VlX8iVuNdllsRglIh1RBqHzXwwtXfHXWJHkPinIM7QAkZMirpKFWQNdE5fNzdCWtaj
	 1GohoE7pgemhlKa3VU2VmZssUK5EQsgUnCnTKSOK3/8ghDPDhxuRuCze01hxy4Ch4K9Ah
	 Uppmmwso+7QPUmwlNBLcQ0nSwjVD1psepWddGvGop1tu2Tzkwex5nOuuei4waXlIcG0Gl
	 EMjquQuCKpjU5Oj8w7xbPcNJjcQs1QLjhW3dE+pb2wsf0Eh8k/WJH4kLosITfm6Rerg7X
	 6EKSYteFQvHdANlnpslxJXlrZCxTDWIIsjCT9dkcky8PaLD6WwEapD+r9AF8dJxXw/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XmKwBUdk;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B874606A327
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 07:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B874606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XmKwBUdk
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so3676465eec.1
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 00:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793517666; x=1794122466; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bk08wlQLOckMDa/tQlUY0Gs+7pq28CqTbcZ5/8r0npg=;
        b=XmKwBUdkbo8n9UzBtWyscJEB661MdVSyToO1VY2IJ+fcRKBXlMOgyL694On1b5oKlP
         Zn35uz30DglljsbJ7DcucazifGT8O5h7JPuhBs0McAyt1wQsFINYYfPoU2pgaA33L90b
         qNsB0XrFVPGy7gJXG8Bj8W/c4NokcZeDHViQpa17bKXTWDBKCsWL0X7BsRYDcXIznASZ
         AbvZ19glirB5wwSaSbDdGW20yDxzmw7QiBdb7K1LH76DrkEvFTjsDKRAnbWpmd8jSMqH
         jBh4nST4/eUmsRIzKiB9Qh8s89bVrVJQWWmW6vD5kBMElym91abRmxs4uQbWfTMuVllR
         jLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793517666; x=1794122466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bk08wlQLOckMDa/tQlUY0Gs+7pq28CqTbcZ5/8r0npg=;
        b=hYltb5wmDp9SollT03R85ww1vPKDbMpVOnNHo+czUFJAz2AE0Vb4Om7TFNlSMLL9JC
         dv/ycnIJaYqtosSCFM1Cc0V5EHNumHGi3adeAA7/96jZ0z2tWdPA43VR4hOhp7mauyeq
         hJyhQheJBtJgyIUn5PYalLq9PnpXBQuW/T1u83+PD2yFLLhrDVKyPp16bMZwvg/HWNZ6
         YQYNsNPr9XKPkwv4f7QQb+grT0lqaT0hiMLz12pLBNnP/xY4V+vzrWWMZwTpoxEFZk1I
         kmF8TjEQx3XVjBsuoJTAwYsUoTzoWdnT6Ctt5txcyfOjzfEMx34gyBXiFc+UDHmPkc+7
         rf4Q==
X-Gm-Message-State: AFq9FYKL+Tj+G/vp6fsRiwmY6JZpm8XZyUdsp3BvBDmHE8EinOX4sG0C
	SiY2Swq95mBk6AcvLNjXkX6g/EzVjtL+2X2DBjXJHGpSeInXZbOcnpW2TsPgaA==
X-Gm-Gg: AYBFou2xN4eLlchbdvZMkEaLD1YQhqoGaMv/AuMSOirNeCzVa+UjR9QZQKcc2QU3ArU
	/zWpzYJO+/kDbKheS6SxLrJGO178no0bUfHOM09eYQZJiujs3/C2zU5DW43R4SQ+NdLgcfoL6Bn
	Q3Z9pNa33fZmF/O3vedXYdU0LfF+IrO4FBmvHURucz9Or3sAK9JUM3QfZrsVtG31zEWFWzGukFs
	xgvI49wlimEChurb56izuLyPJWaHInORdy+EW/P7t7plNQ/7/AqCnjG2VvKw9jnNVpYj/Ckerb9
	DaPoS5MY27MHkmAlrzWlo1imd/WZZeKeRu3puAbmLako/K7hSQCApIG9Eo5OAlwFIQBl6/VFYII
	izBEK0TnPCFZg3626sRNE3WVzVghVWz0FafxzzHBHkEl9coh5uE8ODjSd3EALuq6DHR6zA3/hKD
	LiDomdRwowRlrrlsF7j9Hf/evWgL/sSfsGXAObz32hMJG75FrI3uFYAU3hVXLLzIlhhRCCbwL2X
	iuWRzYjzsNG0Ce5MAMOoyfuR0qGPJii8+w05IaUtLUYtxvTIRcNAngiUTWsqdiFjOEQdQjjLkBK
	Kj9tyEg2nNN2NU+R01lERcqaTQ6hJ9eFHh//8Xp5HrTlgvIjpEG0LTwVhnjGkUurEz43lOssYG1
	CPkMHzox1WYIgpgD/7zLNb/FgS3wHZY+n+JzJQEmZrB/UZVX8kpcqoX/k1m5gx4mA2L0v1wYP6w
	==
X-Received: by 2002:a05:7022:ea46:20b0:144:c128:4c4d with SMTP id a92af1059eb24-1ac5da76f4cmr10792716c88.38.1793517665495;
        Sun, 01 Nov 2026 00:21:05 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1854da78sm29851495c88.6.2026.11.01.00.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 00:21:05 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v14 5/6] selftests: mptcp: pm_nl_ctl: support the subflow-retries limit
Date: Sun,  1 Nov 2026 07:20:50 +0000
Message-Id: <20261101072051.3853492-6-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261101072051.3853492-1-anilkaushikwireless@gmail.com>
References: <20261101072051.3853492-1-anilkaushikwireless@gmail.com>
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

