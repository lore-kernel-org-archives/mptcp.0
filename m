Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A96223AD
	for <mptcp@lists.linux.dev>; Fri, 25 Mar 2022 10:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648203089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hEsLF83H6+rDx3kwe5teq8fGJlziLMMZDyanSFadu/0=;
	b=MX44AxU7CwBNBc8ri2QPcga9EaSBJnuZqr9YSveQzI9zaSlyYJXLUEHAOJSmzDwq3tkeBa
	v4zpS3JAnBi6QDtcduFKchaBE9Wqp3vglhMBpt3PQefik6OTXU5ZyHu12BkSfh4WTndXn1
	ZrdNnw2b3PqMpKN3h7g4i0aAyV5jyOQ=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-5-SY6MMVKrN0C8RH0VOnnf_A-1; Fri, 25 Mar 2022 11:11:27 +0100
X-MC-Unique: SY6MMVKrN0C8RH0VOnnf_A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKKhAMFCWHLuydpzsL8SwNDgbsObMY2ngL1vDTrOE4UZBcywb+Piuqpd1N7t7cAbPRSntLdPKy+nBylxr/38RzfacVIe1a0Olm+Y7sOGpSTSi2z2yNEg249JcCm/imvHIz2L/Nlc/p3ppls/7Ksad0q/uOF3adfz4dzHLY3CuCgrVF4kBpibkShHRpUG16mSUOD6urCc0AvGX+GV4BnsPzv/RFe45kTsdY7i4AKCbykM8Kh22/ZQehr0S/PSy/Po4xO19j+9WA7S3SL9hwsmlYTsnJxv/CcACE94s/rj/VU/1Qd/9L1uoVE5Y7k0VV/SOWFrFEH9I6YX5sOB+u/ywQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ERdJv3P7gAxP1DQnPoqDvEPGB1ZMKnKomArTGuEwgs=;
 b=gY/zERujvFd1PFI69xnWRdmYkd5/yQQBUvohEfHJYv34pYoNgpNGCVPSg52I1jTBOCGfF+LdbkCtKMsx3F24HL4+7U3cPtOh4/DccYOx0qXYsi+Oy/DdYsOUwSFeq5bFQoyIUySvjfEPi9Eg469dXxHXb3ET26uBOLN5jZt8Wbwnr1NlQk3nFwIcHxkK43hH66mZzkTutj/CMttd6VRL7dpiq7b9QuMU/Xzgiz02BndAgZEfNoX2R2CvSnAcNMVLH/8oi1f3NCmTf8e9nfrdsxHlVf/5tzVMwvIovjhNKSs7y56NRHuZj+MNnyDhvsP2lScNaKp3sqntqZetKnPiIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8726.eurprd04.prod.outlook.com (2603:10a6:10:2dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 10:11:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Fri, 25 Mar 2022
 10:11:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v13 3/5] selftests: bpf: test bpf_skc_to_mptcp_sock
Date: Fri, 25 Mar 2022 18:10:54 +0800
Message-ID: <7dece35e50a19add02d10e243b6f28e382c4e1bd.1648202310.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648202310.git.geliang.tang@suse.com>
References: <cover.1648202310.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0108.apcprd03.prod.outlook.com
 (2603:1096:203:b0::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bea32d49-19cc-4fbf-a339-08da0e47d25f
X-MS-TrafficTypeDiagnostic: DU2PR04MB8726:EE_
X-Microsoft-Antispam-PRVS:
	<DU2PR04MB87260A7D0029A1924E7DD8F6F81A9@DU2PR04MB8726.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xlkybvWkxR3gN5FcgDv1GT2x+WaOBoorEWtB6A/imIWXEBw4koKF+n3WSGxKAyqeNG2RJBE0BQ0zos5itI9EXvzDGX+M+5qX+AA4js9t72v63e2OD8TgaxI7Ks87LRACo+RmsHnUUoKTcNh36D1S2m3cXG9rC/bggr+CdK+Hy7Q1OoA2SEFuSMlJ9mf4/2j65w0AhYQHQ3fd1rD60woVhRb42M++wh+c9837E4BPiwVCprXRNZ9P4qPruIuo7M2wGOdd+/0rzQnojrUBotXZ23Wm6CAPu2ObbEA6SuLVsaTwI+qCuBPQHIeN3+PQnxnjPB4PHrtn7B2ibP5S6reZ/5o4p9e/q5JDRD3mcB9BIlOKJNMYFwXz3SDuJoxY+LdN+cdlBg0eb7n3SD2doJ4Km5SXYRyy7czI6MiNfUSIcneqgKxjbNc7FW1VMpXkqiXB0nzGDPWvr3Yb0ywt3iEeCdwsv5eV+RlVreMDZ5SGqfBiTZVvwCRfm3//B7Et1xu+e1kSltsmhzPDwLsw0bhxLeDVavQ+ADBhKq3bTfFxxMYU9KF720lxQZwE5xfrnXZ/kRKO6bG/epXKFFQiEuzqP5WhJQnq2z84AXPOIlXqVBEChFdajNF9wNZObOI3wc54QeghO76SdPOgXpCzZMN6+1Z1Tmm+UvdNh14tgzU0fZBaCOCJpgpCV4Xw7k19rhcJ+1kDe7X6JNkLD0ti6m3gAw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(6506007)(6666004)(8936002)(316002)(6916009)(36756003)(54906003)(66556008)(8676002)(83380400001)(186003)(2906002)(2616005)(44832011)(66476007)(38100700002)(66946007)(508600001)(4326008)(26005)(5660300002)(86362001)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oBSPaIi2B0crfgWCuBB/uzwiwX8iiittXrpsG0Cv8GTWKyIS/p3/F5NpJUMD?=
 =?us-ascii?Q?s9AujHDT7W1A6mVuHBzFztRVA4TkYWxMkjCzx9f+y1F91GXD3sNXBWplT9tK?=
 =?us-ascii?Q?w6xiKMXam8HzOIIozslv2nx7d0W1abxwZIb+leRuuZoCteeR51tOA9YRZ7ld?=
 =?us-ascii?Q?Q7MqoJQhFyIxILUYBn5E4aI4I8EtCYptv6TdnkL1jvrplPeG16T1VLWBd7IA?=
 =?us-ascii?Q?eoaXgS1B64om+kXZhUxfS8GTQL2YQLbhp917QH7chb4vC4SxgBSqaTgvY8qQ?=
 =?us-ascii?Q?Cs466iQ9BnSlCUPkg3RywF4LF1beY+0El4twl+S2obkrHByPht+DxZG0+qJO?=
 =?us-ascii?Q?CAFDZAv7keGReIAEfe+DErmctR6Pvz8qNbuwLOaA/1XcU8mmlJ8ROLv52wBv?=
 =?us-ascii?Q?EkpeMuC7VBC/Yo45WDll52nAe1FR0BkXyT6KCoyhKHEc9P9yHCrHEEZgd1uU?=
 =?us-ascii?Q?Oi+Ttt7/3SNaVpO11rKXxxZsMmx8DUa6PZLq/SAxZmUcKV7ude/3HOqQB/hg?=
 =?us-ascii?Q?wGmeKpc752mdl712Ez+wltGwHZWaJxygpjL0/nkLhu+IqK8Krc2WTJUr30yM?=
 =?us-ascii?Q?GLQA8nx89auT82dFFJ+dHQtaqabTQpFV09nbDnKv+05WQOidSnCXMwWgUgQH?=
 =?us-ascii?Q?/+GuSB6SdExr60x3j8SDWIlJMPjaJQowPZTtGDtcJKzatIgGhTNDvbTGgzq4?=
 =?us-ascii?Q?HaMONvzMoLMfhPC+bZW8psOC6gxr/RiE4vShydy95JosXNSzkroZSlmV6KfK?=
 =?us-ascii?Q?ZxiYB8rcFtS7B1k5EZRJMr777wciCOFDxcDEPa98JcT61l/W6INXhVwuCBGo?=
 =?us-ascii?Q?kU1BOrqCs+2/SKAd3r2Av23H/EFOqcPAuTtgywhgHrLRMKrAtkGNvlD7IYi2?=
 =?us-ascii?Q?Yc00oG6oEBeOMwnQYMq8u0wE6AIaeannXgMfwUf/5U/RJ+Bofdr5eOdz3Y9b?=
 =?us-ascii?Q?fIA29mhUM/QZtbYutMUeqV7zGyalQLaGga8Y6X0pf07neRRIMzcupY6R041w?=
 =?us-ascii?Q?Y5/JgFjcms4BN2ah6gYiOdD8WFZ+/C2BzoHlr6mMBDm9kseNIcLt+tPQboIH?=
 =?us-ascii?Q?eiOCUxpDLlBZVCjQVkrWbp9cxy3jZa0QzGXgPMEmBgU/N5gghBp3Ro0KV3pO?=
 =?us-ascii?Q?b4oT7WItRxdbJVfVkRfLdG0J7aJXiUrFdAQY2eBPRsTFdDn/rz8SdTes0ULt?=
 =?us-ascii?Q?hiOWmhkzZrRKaPpBuG5h7MKNgDy7W4+0tjAzt6dTEU31SIhtas0xIF8pkQkw?=
 =?us-ascii?Q?0dyrCYToP+Cqd/Gq475votHngjWwlAuebZJ5fI8QBwf04zxYAKJJWEp8tRys?=
 =?us-ascii?Q?VHFmdURty6Q6T1vaaynA4nOzHldyJaZ5C7Ne9dEBvEJWeBllTMQpkUW9GiKn?=
 =?us-ascii?Q?7fkHMeXT4nb5+26V8gTJvGShX6TPs1cXccCLhyyyLEG8WGB13Jv7f2wEiaUV?=
 =?us-ascii?Q?TpXJxH2ua5fHm5Dg8D7iLmgM/+KfEeo3Y6ua749Z77jSVWBQ7NiTYzCbxhqC?=
 =?us-ascii?Q?6rwxm1U7yGCWl1/updFaqNi+uf49haSdY3LkYlsEF42guCgIpY6jOmoMH7DK?=
 =?us-ascii?Q?YQqLwMvXIns3Oc0VRMH0Ha/XqtskcvFqwF4GsEvOmU+mQw8oiYMOhkJuAKUt?=
 =?us-ascii?Q?ej5+bgNysv1seyqsb3WEDFm1DYV579GkY99WXbg1kI4uiAfH2wgzv1I07cWu?=
 =?us-ascii?Q?AJk/MqgTc/8GcJs1iYpZT6FgWV7ekQyv3QMkxjojQr6bInxJVxYO43Vy0swB?=
 =?us-ascii?Q?dzHxmUunb5/QNdnkw4lsz2ZhbVRPcIM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea32d49-19cc-4fbf-a339-08da0e47d25f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 10:11:26.4733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4jJpTjRvFBF/5xEyPCvWYKGbZraCkKTX4PxcXrMlkn2xIM3dlxPuQAIiQZSqzV579wVjPEA1ey+elS1d7Tc2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8726

This patch extended the MPTCP test base, to test the new helper
bpf_skc_to_mptcp_sock().

Added a new function verify_msk() to verify the msk token, and a new
function get_msk_token() to parse the msk token from the output of the
command 'ip mptcp monitor'.

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |   6 ++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 102 ++++++++++++++++--
 tools/testing/selftests/bpf/progs/mptcp.c     |  25 ++++-
 3 files changed, 123 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index b1ede6f0b821..9ea6687c8f4d 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -83,6 +83,12 @@ struct tcp_sock {
 	__u64	tcp_mstamp;	/* most recent packet received/sent */
 } __attribute__((preserve_access_index));
=20
+struct mptcp_sock {
+	struct inet_connection_sock	sk;
+
+	__u32		token;
+} __attribute__((preserve_access_index));
+
 static __always_inline struct inet_connection_sock *inet_csk(const struct =
sock *sk)
 {
 	return (struct inet_connection_sock *)sk;
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index bfd521e17711..3232ace122c9 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -8,16 +8,17 @@
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
+	__u32 token;
 };
=20
-static int verify_sk(int map_fd, int client_fd, const char *msg, __u32 is_=
mptcp)
+static char monitor_log_path[64];
+
+static int verify_tsk(int map_fd, int client_fd)
 {
+	char *msg =3D "plain TCP socket";
 	int err =3D 0, cfd =3D client_fd;
 	struct mptcp_storage val;
=20
-	if (is_mptcp =3D=3D 1)
-		return 0;
-
 	if (CHECK_FAIL(bpf_map_lookup_elem(map_fd, &cfd, &val) < 0)) {
 		perror("Failed to read socket storage");
 		return -1;
@@ -38,6 +39,85 @@ static int verify_sk(int map_fd, int client_fd, const ch=
ar *msg, __u32 is_mptcp)
 	return err;
 }
=20
+/*
+ * Parse the token from the output of 'ip mptcp monitor':
+ *
+ * [       CREATED] token=3D3ca933d3 remid=3D0 locid=3D0 saddr4=3D127.0.0.=
1 ...
+ * [       CREATED] token=3D2ab57040 remid=3D0 locid=3D0 saddr4=3D127.0.0.=
1 ...
+ */
+static __u32 get_msk_token(void)
+{
+	char *prefix =3D "[       CREATED] token=3D";
+	char buf[BUFSIZ] =3D {};
+	__u32 token =3D 0;
+	ssize_t len;
+	int fd;
+
+	sync();
+
+	fd =3D open(monitor_log_path, O_RDONLY);
+	if (CHECK_FAIL(fd < 0)) {
+		log_err("Failed to open %s", monitor_log_path);
+		return token;
+	}
+
+	len =3D read(fd, buf, sizeof(buf));
+	if (CHECK_FAIL(len < 0)) {
+		log_err("Failed to read %s", monitor_log_path);
+		goto err;
+	}
+
+	if (strncmp(buf, prefix, strlen(prefix))) {
+		log_err("Invalid prefix %s", buf);
+		goto err;
+	}
+
+	token =3D strtol(buf + strlen(prefix), NULL, 16);
+
+err:
+	close(fd);
+	return token;
+}
+
+static int verify_msk(int map_fd, int client_fd)
+{
+	char *msg =3D "MPTCP subflow socket";
+	int err =3D 0, cfd =3D client_fd;
+	struct mptcp_storage val;
+	__u32 token;
+
+	token =3D get_msk_token();
+	if (token <=3D 0) {
+		log_err("Unexpected token %x", token);
+		return -1;
+	}
+
+	if (CHECK_FAIL(bpf_map_lookup_elem(map_fd, &cfd, &val) < 0)) {
+		perror("Failed to read socket storage");
+		return -1;
+	}
+
+	if (val.invoked !=3D 1) {
+		log_err("%s: unexpected invoked count %d !=3D 1",
+			msg, val.invoked);
+		err++;
+	}
+
+	if (val.is_mptcp !=3D 1) {
+		log_err("%s: unexpected bpf_tcp_sock.is_mptcp %d !=3D 1",
+			msg, val.is_mptcp);
+		err++;
+	}
+
+	if (val.token !=3D token) {
+		log_err("Unexpected mptcp_sock.token %x !=3D %x",
+			val.token, token);
+		err++;
+	}
+
+	return err;
+}
+
 static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
 {
 	int client_fd, prog_fd, map_fd, err;
@@ -88,8 +168,8 @@ static int run_test(int cgroup_fd, int server_fd, bool i=
s_mptcp)
 		goto out;
 	}
=20
-	err +=3D is_mptcp ? verify_sk(map_fd, client_fd, "MPTCP subflow socket", =
1) :
-			  verify_sk(map_fd, client_fd, "plain TCP socket", 0);
+	err +=3D is_mptcp ? verify_msk(map_fd, client_fd) :
+			  verify_tsk(map_fd, client_fd);
=20
 	close(client_fd);
=20
@@ -100,6 +180,7 @@ static int run_test(int cgroup_fd, int server_fd, bool =
is_mptcp)
=20
 void test_base(void)
 {
+	char cmd[256], tmp_dir[] =3D "/tmp/XXXXXX";
 	int server_fd, cgroup_fd;
=20
 	cgroup_fd =3D test__join_cgroup("/mptcp");
@@ -117,6 +198,13 @@ void test_base(void)
=20
 with_mptcp:
 	/* with MPTCP */
+	if (CHECK_FAIL(!mkdtemp(tmp_dir)))
+		goto close_cgroup_fd;
+	snprintf(monitor_log_path, sizeof(monitor_log_path),
+		 "%s/ip_mptcp_monitor", tmp_dir);
+	snprintf(cmd, sizeof(cmd), "ip mptcp monitor > %s &", monitor_log_path);
+	if (CHECK_FAIL(system(cmd)))
+		goto close_cgroup_fd;
 	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
 	if (CHECK_FAIL(server_fd < 0))
 		goto close_cgroup_fd;
@@ -124,6 +212,8 @@ void test_base(void)
 	CHECK_FAIL(run_test(cgroup_fd, server_fd, true));
=20
 	close(server_fd);
+	snprintf(cmd, sizeof(cmd), "rm -rf %s", tmp_dir);
+	system(cmd);
=20
 close_cgroup_fd:
 	close(cgroup_fd);
diff --git a/tools/testing/selftests/bpf/progs/mptcp.c b/tools/testing/self=
tests/bpf/progs/mptcp.c
index 0d65fb889d03..afacea5ad9ca 100644
--- a/tools/testing/selftests/bpf/progs/mptcp.c
+++ b/tools/testing/selftests/bpf/progs/mptcp.c
@@ -3,6 +3,7 @@
=20
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_tcp_helpers.h"
=20
 char _license[] SEC("license") =3D "GPL";
 __u32 _version SEC("version") =3D 1;
@@ -10,6 +11,7 @@ __u32 _version SEC("version") =3D 1;
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
+	__u32 token;
 };
=20
 struct {
@@ -24,6 +26,7 @@ int _sockops(struct bpf_sock_ops *ctx)
 {
 	struct mptcp_storage *storage;
 	struct bpf_tcp_sock *tcp_sk;
+	struct mptcp_sock *msk;
 	int op =3D (int)ctx->op;
 	struct bpf_sock *sk;
=20
@@ -38,11 +41,25 @@ int _sockops(struct bpf_sock_ops *ctx)
 	if (!tcp_sk)
 		return 1;
=20
-	storage =3D bpf_sk_storage_get(&socket_storage_map, sk, 0,
-				     BPF_SK_STORAGE_GET_F_CREATE);
-	if (!storage)
-		return 1;
+	if (!tcp_sk->is_mptcp) {
+		storage =3D bpf_sk_storage_get(&socket_storage_map, sk, 0,
+					     BPF_SK_STORAGE_GET_F_CREATE);
+		if (!storage)
+			return 1;
+
+		storage->token =3D 0;
+	} else {
+		msk =3D bpf_skc_to_mptcp_sock(sk);
+		if (!msk)
+			return 1;
+
+		storage =3D bpf_sk_storage_get(&socket_storage_map, msk, 0,
+					     BPF_SK_STORAGE_GET_F_CREATE);
+		if (!storage)
+			return 1;
=20
+		storage->token =3D msk->token;
+	}
 	storage->invoked++;
 	storage->is_mptcp =3D tcp_sk->is_mptcp;
=20
--=20
2.34.1

