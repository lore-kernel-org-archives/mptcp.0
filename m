Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794892099;
	b=QXVgFPKe4md1sHw9BEcUCfRJCsF7VGQITysM2l41eYQcCPtgclhpIE9e0hj7iTxiFX6q
	 xeGQQ4X940UqecdzogIIl3AQfGsrYRwKdUrmgqJoCXE4WXuz/i7MvR0xIQJ3lJUfD/77x
	 cAR4UMP+7YhiRXIkXCdjYD/7CGmZeHMj1ywuyzE6w5Rb1hIiRbMq8xtLhZazvVBklIMgv
	 L91zhgQhoRQIaabl4CyGFMoZJc8S1cXvHzEIuHJR4jltXERUgvi6RHSZvSR/QKUoDI99C
	 N4xVvadBiLZfQ/zsfvGDtqypZPNd0vGLO7r6jxdqg8q1aX5iVYCJXCONM5HkmpyqHjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794892099;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient;
	bh=H4d7KIJkFIObITZTnujX4CPyQB6DJwd3Cw2HatXHVSA=;
	b=MQ8ubzFE809TVDQ/qojP97b8PzwR5sGwKzqD7mEdWnFw0wD6p7WhmaVNnDyk4hV5rWE6
	 PKUQeEVEPgm75NSNLNBC8p8bi40FcOIPNHxkm2DyKgI2sGhJCBuJ4ycUDaPrjUjH/8nzS
	 mia8rA0O/NIXCfoh8cz4mjz7DDMbN132oFdM/J/sjN7LGCOKEUGxHQCKatXf9KfeBHOXy
	 h8uyCyesfbOCQgN7rCO8m2wFmrSljwjXHNCoNPsE8CK/yXowHntmEsotTvGUQTKP9H8w9
	 KAPSrrR5FW/tKcfPyrEPQwQjcBgtiyywdpJtesjGp3U+2dy0iLHq7lvnQ6byrU44uyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
Received: from sender5-of-o54.zoho.com (sender5-of-o54.zoho.com [165.173.182.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8317606A32A
	for <mptcp@lists.linux.dev>; Tue, 17 Nov 2026 05:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8317606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1794892095; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ilUffvG1oN7iRNBlJ6c3iisHcF0sO6HKzkiclcc11nVc6Nxk6Ol5CBUJMtn19LcSS0ITRdpDNrftrpsttpuRLKfnOzkNY0DbOM12NhXkBMfNKuq9TE7SOPPk4+NPAA+tY8djxumTyXTW8B/oiiztXWfeDgK0TAIMEWb079VL/pc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794892095; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=H4d7KIJkFIObITZTnujX4CPyQB6DJwd3Cw2HatXHVSA=; 
	b=X2f6RY86X/rWFeE43o2p3SVSqYJzx4JOWuugSXSjsnniv3PZhZ03KdujBSXNMh0cgjCavUutEcHOxnOXjdX9HncbzLOe/4nSJS7mvBE5Tx+SsSwdtYdK5K1/MVeLOZUFn7mictlVPLn4pSAls5lv8ILZWkAklX7z/u35SpVeI7U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: a=rsa-sha256; b=mswkJPeUEUTaTu/jTlvuL3ecySwkLEYRopB2Ppll5dQ/0JN+vUz7kx47hmMwQKBaANrqe/w0aGG1iivKPGfOADKvSeqw2IxSdf9I74w67NJ6UGNDjI2fNQdkGA3zdlLsjf0pYTClXVwrL1tcRKNdwLqSN7xRp+ZrJmsv6eC0Ld4=; c=relaxed/relaxed; s=mpiric; d=mpiricsoftware.com; v=1; bh=H4d7KIJkFIObITZTnujX4CPyQB6DJwd3Cw2HatXHVSA=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794892094659683.8001736071109;
	Mon, 16 Nov 2026 21:08:14 -0800 (PST)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Subject: [PATCH mptcp-net v13] mptcp: hide sequence numbers in Netlink diagnostics
Date: Tue, 17 Nov 2026 10:38:04 +0530
Message-ID: <20261117050804.134954-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
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
X-ZohoMailClient: External

MPTCP Netlink diagnostics expose sequence numbers that can reveal
internal connection state.

Clear mptcpi_write_seq, mptcpi_snd_una and mptcpi_rcv_nxt in the
Netlink diagnostic callback.

Keep the getsockopt() interface and its reported sequence numbers
unchanged.

Add a selftest to verify that the sequence-number fields are zero in
Netlink diagnostic responses.

Fixes: ac3b45f60954 ("mptcp: add MPTCP socket diag interface")
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/445
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
Changes since v12:
- Drop address-based sequence number normalization.
- Zero the three sequence-number fields in the Netlink diagnostic callback.
- Preserve sequence-number values reported through getsockopt().
- Add a selftest verifying zero sequence-number fields in Netlink diagnostics.
- Check NLMSG_DONE error status in the Netlink selftest.

v12: https://lore.kernel.org/all/20261106111645.786225-1-kalpan.jani@mpiricsoftware.com/
---
 net/mptcp/mptcp_diag.c                        |   4 +
 tools/testing/selftests/net/mptcp/diag.sh     |  13 ++
 .../testing/selftests/net/mptcp/mptcp_diag.c  | 122 ++++++++++++++----
 3 files changed, 115 insertions(+), 24 deletions(-)

diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
index 136c2d05c0eeb..fe1603ce80162 100644
--- a/net/mptcp/mptcp_diag.c
+++ b/net/mptcp/mptcp_diag.c
@@ -215,6 +215,10 @@ static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
 		return;
 
 	mptcp_diag_fill_info(msk, info);
+
+	info->mptcpi_write_seq = 0;
+	info->mptcpi_snd_una = 0;
+	info->mptcpi_rcv_nxt = 0;
 }
 
 static const struct inet_diag_handler mptcp_diag_handler = {
diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 27cbda68144e8..abe732a5c1c37 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -205,6 +205,7 @@ chk_dump_one()
 	local ss_token
 	local token
 	local msg
+	local zero_msg
 
 	ss_token="$(ss -inmHMN $ns |
 		    mptcp_lib_get_info_value "token" "token")"
@@ -223,6 +224,18 @@ chk_dump_one()
 		mptcp_lib_result_fail "${msg}"
 		ret=${KSFT_FAIL}
 	fi
+
+	zero_msg="....chk dump_one zero sequence fields"
+	mptcp_lib_print_title "$zero_msg"
+	if [ -n "$ss_token" ] &&
+	   ip netns exec "$ns" ./mptcp_diag -z -t "$ss_token"; then
+		mptcp_lib_pr_ok
+		mptcp_lib_result_pass "${zero_msg}"
+	else
+		mptcp_lib_pr_fail "MPTCP diagnostic sequence fields are not zero"
+		mptcp_lib_result_fail "${zero_msg}"
+		ret=${KSFT_FAIL}
+	fi
 }
 
 chk_dump_subflow()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
index 3b8d2c8a62160..6f72ca30d7c20 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_diag.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
@@ -3,6 +3,7 @@
 
 #include <errno.h>
 #include <stdio.h>
+#include <stdbool.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
@@ -29,6 +30,7 @@
 			    NLA_F_NESTED))
 
 struct params {
+	bool check_zero_seq;
 	__u32 target_token;
 	char subflow_addrs[1024];
 };
@@ -101,6 +103,7 @@ static void die_usage(int r)
 {
 	fprintf(stderr, "Usage:\n"
 			"mptcp_diag -t <token>\n"
+			"mptcp_diag -z -t <token>  (check zero sequence fields)\n"
 			"mptcp_diag -s \"<saddr>:<sport> <daddr>:<dport>\"\n");
 	exit(r);
 }
@@ -170,6 +173,22 @@ static void parse_rtattr_flags(struct rtattr *tb[], int max, struct rtattr *rta,
 	}
 }
 
+static bool check_zero_seq(struct mptcp_info *info)
+{
+	if (info->mptcpi_write_seq ||
+	    info->mptcpi_snd_una ||
+	    info->mptcpi_rcv_nxt) {
+		fprintf(stderr,
+			"Unexpected sequence values: write_seq=%llu snd_una=%llu rcv_nxt=%llu\n",
+			(unsigned long long)info->mptcpi_write_seq,
+			(unsigned long long)info->mptcpi_snd_una,
+			(unsigned long long)info->mptcpi_rcv_nxt);
+		return false;
+	}
+
+	return true;
+}
+
 static void print_info_msg(struct mptcp_info *info)
 {
 	printf("Token & Flags\n");
@@ -262,7 +281,7 @@ static void print_subflow_info(struct rtattr *tb[])
 	printf("\n");
 }
 
-static void parse_nlmsg(struct nlmsghdr *nlh, __u32 proto)
+static void parse_nlmsg(struct nlmsghdr *nlh, __u32 proto, bool check_zero, bool *seen_info)
 {
 	struct inet_diag_msg *r = NLMSG_DATA(nlh);
 	struct rtattr *tb[INET_DIAG_MAX + 1];
@@ -284,6 +303,11 @@ static void parse_nlmsg(struct nlmsghdr *nlh, __u32 proto)
 			info = RTA_DATA(tb[INET_DIAG_INFO]);
 		}
 		print_info_msg(info);
+		if (check_zero) {
+			*seen_info = true;
+			if (!check_zero_seq(info))
+				exit(EXIT_FAILURE);
+		}
 	}
 	if (proto == IPPROTO_TCP && tb[INET_DIAG_ULP_INFO]) {
 		struct rtattr *ulpinfo[INET_ULP_INFO_MAX + 1] = { 0 };
@@ -303,10 +327,10 @@ static void parse_nlmsg(struct nlmsghdr *nlh, __u32 proto)
 	}
 }
 
-static void recv_nlmsg(int fd, __u32 proto)
+static void recv_nlmsg(int fd, __u32 proto, bool check_zero)
 {
 	char rcv_buff[8192];
-	struct nlmsghdr *nlh = (struct nlmsghdr *)rcv_buff;
+	struct nlmsghdr *nlh;
 	struct sockaddr_nl rcv_nladdr = {
 		.nl_family = AF_NETLINK
 	};
@@ -320,28 +344,70 @@ static void recv_nlmsg(int fd, __u32 proto)
 		.msg_iov = &rcv_iov,
 		.msg_iovlen = 1
 	};
-	int len;
-
-	len = recvmsg(fd, &rcv_msg, 0);
-
-	while (NLMSG_OK(nlh, len)) {
-		if (nlh->nlmsg_type == NLMSG_DONE) {
-			printf("NLMSG_DONE\n");
-			break;
-		} else if (nlh->nlmsg_type == NLMSG_ERROR) {
-			struct nlmsgerr *err;
+	bool seen_info = false;
+	bool done = false;
+
+	while (!done) {
+		int len;
+
+		nlh = (struct nlmsghdr *)rcv_buff;
+		len = recvmsg(fd, &rcv_msg, 0);
+		if (len < 0)
+			die_perror("Netlink recvmsg");
+		if (!len) {
+			fprintf(stderr, "Empty Netlink response\n");
+			exit(EXIT_FAILURE);
+		}
 
-			err = (struct nlmsgerr *)NLMSG_DATA(nlh);
-			printf("Error %d:%s\n",
-			       -(err->error), strerror(-(err->error)));
-			break;
+		while (NLMSG_OK(nlh, len)) {
+			if (nlh->nlmsg_type == NLMSG_DONE) {
+				int error = 0;
+
+				if (nlh->nlmsg_len >= NLMSG_LENGTH(sizeof(error)))
+					memcpy(&error, NLMSG_DATA(nlh), sizeof(error));
+
+				if (error) {
+					fprintf(stderr, "Netlink dump failed: %s\n",
+						strerror(-error));
+					exit(EXIT_FAILURE);
+				}
+
+				done = true;
+				break;
+			} else if (nlh->nlmsg_type == NLMSG_ERROR) {
+				struct nlmsgerr *err;
+
+				err = (struct nlmsgerr *)NLMSG_DATA(nlh);
+				if (err->error) {
+					fprintf(stderr,
+						"Netlink request failed: %s\n",
+						strerror(-err->error));
+					exit(EXIT_FAILURE);
+				}
+			} else {
+				parse_nlmsg(nlh, proto, check_zero, &seen_info);
+
+				/*
+				 * Single-socket diagnostic responses are not
+				 * multipart and do not end with NLMSG_DONE.
+				 */
+				if (!(nlh->nlmsg_flags & NLM_F_MULTI)) {
+					done = true;
+					break;
+				}
+			}
+
+			nlh = NLMSG_NEXT(nlh, len);
 		}
-		parse_nlmsg(nlh, proto);
-		nlh = NLMSG_NEXT(nlh, len);
+	}
+
+	if (check_zero && !seen_info) {
+		fprintf(stderr, "No MPTCP diagnostic info received\n");
+		exit(EXIT_FAILURE);
 	}
 }
 
-static void get_mptcpinfo(__u32 token)
+static void get_mptcpinfo(__u32 token, bool check_zero)
 {
 	struct inet_diag_req_v2 r = {
 		.sdiag_family           = AF_INET,
@@ -358,7 +424,7 @@ static void get_mptcpinfo(__u32 token)
 		die_perror("Netlink socket");
 
 	send_query(fd, &r, proto);
-	recv_nlmsg(fd, proto);
+	recv_nlmsg(fd, proto, check_zero);
 
 	close(fd);
 }
@@ -394,7 +460,7 @@ static void get_subflow_info(char *subflow_addrs)
 	inet_pton(AF_INET, saddr, &r.id.idiag_src);
 	inet_pton(AF_INET, daddr, &r.id.idiag_dst);
 	send_query(fd, &r, IPPROTO_TCP);
-	recv_nlmsg(fd, IPPROTO_TCP);
+	recv_nlmsg(fd, IPPROTO_TCP, false);
 }
 
 static void parse_opts(int argc, char **argv, struct params *p)
@@ -404,8 +470,11 @@ static void parse_opts(int argc, char **argv, struct params *p)
 	if (argc < 2)
 		die_usage(1);
 
-	while ((c = getopt(argc, argv, "ht:s:")) != -1) {
+	while ((c = getopt(argc, argv, "ht:s:z")) != -1) {
 		switch (c) {
+		case 'z':
+			p->check_zero_seq = true;
+			break;
 		case 'h':
 			die_usage(0);
 			break;
@@ -429,8 +498,13 @@ int main(int argc, char *argv[])
 
 	parse_opts(argc, argv, &p);
 
+	if (p.check_zero_seq && !p.target_token) {
+		fprintf(stderr, "-z requires -t <token>\n");
+		return EXIT_FAILURE;
+	}
+
 	if (p.target_token)
-		get_mptcpinfo(p.target_token);
+		get_mptcpinfo(p.target_token, p.check_zero_seq);
 
 	if (p.subflow_addrs[0] != '\0')
 		get_subflow_info(p.subflow_addrs);
-- 
2.43.0

