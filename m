Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CC22505CB
	for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 06:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755154723; cv=none; b=B4x9Wx7eI01pkX0HTQrrLYvEN3yGRw/dN7qAQxDIN7QnlSqTk6kD15sIk6jc1zvN3x5S4hF7WqtEdOVBLsLW5dn1MI+SxKYg4oD1NYFEYR3aMMZFAE2jSy8msdhbyA6ESobMk5Zr2JOleRcdd2b4nqFVUxqLldMlZ3OShFVaVw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755154723; c=relaxed/simple;
	bh=lhaCorCV9GXNGeu0A6a2Dy2N8IpzPegxto2sUYNMmc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CmF5RzujPKbSXp/Z63pN7e0yynY6TOqaUy2YO1hQQno8UUyBbb3WaspaSwNvF6JJ4wTzyrK2gyqaBPq9NFyxd1kFD5Ztus7cHOLMKNi9Vclbl5a9mK3s7NeWbe11H2Uj0X0nLCy8OSrBR4qHSxOjdQUf1hBcAg0y0Yw7EPKUeZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1518c5ac78dc11f0b29709d653e92f7d-20250814
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:e0a22f4e-7106-4b50-8c76-c949bae9c8cb,IP:10,
	URL:0,TC:0,Content:-25,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,A
	CTION:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:e0a22f4e-7106-4b50-8c76-c949bae9c8cb,IP:10,UR
	L:0,TC:0,Content:-25,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:9e7295e89e43df8e16f6f9898b8bde04,BulkI
	D:250814145833E7UI9UJP,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|102,T
	C:nil,Content:0|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 1518c5ac78dc11f0b29709d653e92f7d-20250814
X-User: yangang@kylinos.cn
Received: from yangang-thinkpad-t14-gen-1.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1236161781; Thu, 14 Aug 2025 14:58:29 +0800
From: Gang Yan <yangang@kylinos.cn>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next] selftests: mptcp: Add a test for self-conn fallback
Date: Thu, 14 Aug 2025 14:58:18 +0800
Message-ID: <20250814065818.34804-1-yangang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'simultaneous_connect' is not coverd by selftests, so this patch
adds a test according to issue#35. When a client tries to connect to
itself, the msk should fallback to tcp due to 'SIMULTCONN'.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 32 ++++++++++++++++++-
 .../selftests/net/mptcp/mptcp_connect.sh      | 29 +++++++++++++++++
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 4f07ac9fa207..e0caef9cbe5f 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -44,6 +44,7 @@ extern int optind;
 #endif
 
 static int  poll_timeout = 10 * 1000;
+static bool abnormal_connection;
 static bool listen_mode;
 static bool quit;
 
@@ -1422,7 +1423,7 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 
-	while ((c = getopt(argc, argv, "6c:f:hi:I:jlm:M:o:p:P:r:R:s:S:t:T:w:")) != -1) {
+	while ((c = getopt(argc, argv, "6c:f:hi:I:jlAm:M:o:p:P:r:R:s:S:t:T:w:")) != -1) {
 		switch (c) {
 		case 'f':
 			cfg_truncate = atoi(optarg);
@@ -1500,6 +1501,9 @@ static void parse_opts(int argc, char **argv)
 		case 'o':
 			parse_setsock_options(optarg);
 			break;
+		case 'A':
+			abnormal_connection = true;
+			break;
 		}
 	}
 
@@ -1511,6 +1515,29 @@ static void parse_opts(int argc, char **argv)
 		pf = AF_INET6;
 }
 
+int self_conn_no_listen(void)
+{
+	int fd = sock_listen_mptcp(cfg_host, cfg_port);
+	socklen_t addr_len = sizeof(struct sockaddr_in);
+	struct sockaddr_in addr;
+
+	if (fd < 0)
+		return 1;
+
+	if (getsockname(fd, (struct sockaddr *)&addr, &addr_len) < 0) {
+		perror("getsockname() failed");
+		close(fd);
+		exit(1);
+	}
+
+	shutdown(fd, SHUT_RD);
+
+	connect(fd, (struct sockaddr *)&addr, addr_len);
+
+	close(fd);
+	return 0;
+}
+
 int main(int argc, char *argv[])
 {
 	init_rng();
@@ -1536,5 +1563,8 @@ int main(int argc, char *argv[])
 		return main_loop_s(fd);
 	}
 
+	if (abnormal_connection)
+		return self_conn_no_listen();
+
 	return main_loop();
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 5e3c56253274..b0c68d83a28b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -819,6 +819,32 @@ run_tests_disconnect()
 	connect_per_transfer=1
 }
 
+run_tests_selfconn_no_listen()
+{
+	local count
+	local msg
+
+	mptcp_lib_pr_info "${TEST_GROUP} test"
+
+	print_larger_title "Client fallback due to connecting to itself "
+	ip netns exec $1 ./mptcp_connect -p 10000 -s MPTCP -A 127.0.0.1
+	count=$(mptcp_lib_get_counter $1 "MPTcpExtSimultConnectFallback")
+
+	if [ -z "$count" ]; then
+		mptcp_lib_pr_skip "Self conn fallback counter not supported"
+		mptcp_lib_result_skip "${TEST_GROUP}"
+		msg="SKIP"
+	elif [ "$count" -le 0 ]; then
+		mptcp_lib_pr_fail "got $count self conn fallback expected 1"
+		msg="Fail"
+	else
+		mptcp_lib_pr_ok
+		msg="Pass"
+	fi
+
+	mptcp_lib_pr_info "test ${TEST_GROUP} ${msg}"
+}
+
 display_time()
 {
 	time_end=$(date +%s)
@@ -883,6 +909,9 @@ mptcp_lib_result_code "${ret}" "ping tests"
 stop_if_error "Could not even run ping tests"
 mptcp_lib_pr_ok
 
+TEST_GROUP=" test self connection"
+run_tests_selfconn_no_listen ${ns1}
+
 [ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem loss random $tc_loss delay ${tc_delay}ms
 tc_info="loss of $tc_loss "
 test "$tc_delay" -gt 0 && tc_info+="delay $tc_delay ms "
-- 
2.43.0

