Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9851391
	for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 09:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648026613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n33vDTXgFtTLTjX0yjY8jn+qaqLUCn6G5P/M1LctMBU=;
	b=muEZEe1GsSTiJFDe4AoTMcGiLuhEb5ebH6CVbx7GmzJeutvFNfN5WOgosaD64JQu866a1D
	LFDkspk93vBDlBVMbmQqmWJ+gNz53nV6TfUaLWrSigNsfENVKxW5vSe57hlbNgQsyEsj6l
	ZoLFvT/f5h3pAXCJnVsRIJsSVZMFFA0=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2170.outbound.protection.outlook.com [104.47.17.170]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-36-eMUecBh3MJWPkmpRpDiPHQ-1; Wed, 23 Mar 2022 10:10:12 +0100
X-MC-Unique: eMUecBh3MJWPkmpRpDiPHQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDfnvTMUP3S8cA3kZmnN08nZ3xM0vOQoatT81cKcDlbdfvCImMQZKl0GJblWs2LohHFOtBHj3665HfyRTO83VJ5CopD78ZSBeM/c+QIjuuqGk+px1ujSQxqOkM9JfcbwM4yKvHYbHr7Y5OfGkL2XFxPxXEP6sjQGDOSBSvqoRQBDt1cGeFM9OkY//eO1RJaoZ8Sb9xDiU+gze0Az7mPu9IeVeUhYiQup+ryjeG4w47z0xlx2IrjI1nvRcBfYgArPa4zQ1xo2giTVdLKxFp/Isw8P2SqxsSvjxOQt3DT9AVzuQM37BwS/yMPs2WoC5BYW8RzA6x9IuYOEPQ2xilc9AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbVULEfoETovXT1J2HuCSzdv5On/MMhw47xe4gf6/go=;
 b=jgHQKYyUfgXDZDC/qNZ24R9D7FhsiSdjrbYpYmMuVXxiyotbGEhR5g5XBRiqhzc3VeinEFrGG1hBstntGrgIWQvz7OtxNkY/wJc/2C8mXunlSt8UiEaIOfc1QtjlkEtPQS3Y+mF1h5Soapg6px0ySHaDtLQOmg7D918bFAd9hQquQjDHkYfzu6wratdPsgiVtIh+J7l/nslvw2buaELqfsj5WHflh5TnksOyZ4W+xYlg2L9qu9B2/ubEl5D1dM69EawPL96o16rolHcqkti2feoQ1Z1+7/M1Hzlqo2wrLF4XeQF3ffwt03bjUH84UwYeL5XzVoC3XqDnqSEMP7eREw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5988.eurprd04.prod.outlook.com (2603:10a6:208:11b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Wed, 23 Mar
 2022 09:10:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 09:10:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v11 5/7] selftests: bpf: test bpf_skc_to_mptcp_sock
Date: Wed, 23 Mar 2022 17:09:34 +0800
Message-ID: <f6f176b0a3e3c6b12bcaad4efe547e25a1d81e21.1648025308.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648025307.git.geliang.tang@suse.com>
References: <cover.1648025307.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0195.apcprd02.prod.outlook.com
 (2603:1096:201:21::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef30d434-e0b8-49bd-3fc9-08da0caceee2
X-MS-TrafficTypeDiagnostic: AM0PR04MB5988:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB59887B9C1C90FC6580070B89F8189@AM0PR04MB5988.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1saGJAZ5Jz+V2sWGKYyH5N8utuQ9n0Jvgs4ph50TWYlJ8uonD9yFnjhSUE3zixArPJot+R8faMhMcZTL5yrA8+nUbz8k2omb+u5o7WdD7qyyA76D5yKN+CPbSFcsvmUbbPiuazq8D+j5imBWUKJ0V314dJKU9loexC1fDaBxJk3foNQBF7RPebuHzBA7Li7jJ+3gn0xMtWLDbMVw8TAWOnZqkXnP+hhi0sICigZlt+IZtatwHowEyRerNdRfUQo75STk07E/ohOodHXdRZsOGCo5RFTliQDbN8YneLin45TRqOjcmiNCM29bipIUZkK4J39AdxOg3O+wizuR2seHbIJ5xJa2s9u1o0VL3cUAnmsFEEBlRRztLEz7hvVSVRTd3Kx4VaMt9pJxetwPYX1lZntqzFSWswpIJBaRCETLO5rHEQdJry9gKNeN2NzR3fqqNbWNfh1DH7kTXS2GA8r62knv2/AQxK3rDjiFvvfgEkETsZA41BfdvWwm0ITB1dis3UXUPBAw7S0GgK/xoAx2oqzP5dCquz+S8kV9sfwSP1tLZ8CPjIppyKTA6Hc+015aU8wmoTPCnuemvGwCQ85hwixg1eIZzXHJbluF19xgewhySsRj2TgwS1uXicTGj6lQ4s79ZFjZvHcbGS/m89XpcCr4HXVkUW4mS8394BQNDXPMwvMWsZrDSQefEfyCIs9+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(6666004)(6512007)(6506007)(508600001)(36756003)(38100700002)(6916009)(86362001)(6486002)(54906003)(316002)(66946007)(26005)(186003)(4326008)(2906002)(66476007)(8676002)(2616005)(5660300002)(44832011)(8936002)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qvkz6DXMA8KnZU6metMBN87IXhei50ryspOIDfeFM8PFm8vTznrFo6vaDC76?=
 =?us-ascii?Q?FuXBtS3L6tEbGrFHuQE0Foj6c3HNL3vnBPzNG6p2geyC+XsH1ckX+9Y/6Bwd?=
 =?us-ascii?Q?fwvAzfrupK88z+xlI4PUPM2E0GiAniGJdUs5p/JKP9dFUGYbJULLCf1oaz/h?=
 =?us-ascii?Q?rmLQcXShDEV4C27ienfcKy6YnSnRLoBoxdWXVQizA8/tb7XW1CyK2OuUYj3U?=
 =?us-ascii?Q?0CzbNvD00mq1OekUuWztlA4jkqODPzJ+UALdcMTPH7nqNzLVaAMSvn7el37B?=
 =?us-ascii?Q?r+tsbjPPnL85qgkJ/S5mXvbFVZWhQQPrLvjKO2BBawYrehHfZABU/1zuCfiw?=
 =?us-ascii?Q?z/BEqLAUwjWoCFRYjKKHBNF0qXzMF/O7fuoxydhjsvUQiLp0V6epnUDsVvu7?=
 =?us-ascii?Q?QcgNVM+a/5vNFjcMjb4kMYS9IUKmpdsBt/ihdC72gqV2VxDE3sCfNsFeeOMy?=
 =?us-ascii?Q?Bb34nRoKNbml2duLVtGmB0ZS4ayjU6oAMWx74K8eQUAqbU1AUZfMDZIMrzJI?=
 =?us-ascii?Q?LURX1nPKox30S7jDjms3I6It3hcrirF6mtQFN+u4GFj+OPAh9uU+uzLMmMTm?=
 =?us-ascii?Q?lj9Zz7dK33sWrlu8kxmAMh29WKf2V/KmzwBpD96qrJ1fn1JrU3uZ80QXJHsO?=
 =?us-ascii?Q?Ue7mBw8UxFoQ78qvWwunXehd1vhfB90CEW459JoyOBZ2R1C5jAYNU11mJH/W?=
 =?us-ascii?Q?KwCuPBLAEuoc9g0ewcp4al3kFxklq+xnx0pR8vpTnPgES2PpHBZCHpWeK+at?=
 =?us-ascii?Q?7+9jl+vQEB06/S1C9YPQizjtJSN8NtR9MObYDsIss3a095LEmHukFLFZFG9w?=
 =?us-ascii?Q?l/yidua2ayxmocNLVJ66BHljsrPTwU73Eq+dnjay4H/c64cf8/boXX8fR73n?=
 =?us-ascii?Q?cQqP0v6+hLVSV+5egEFYJpZv0QQPq3FS9iYmXVvSYnr5lEqCDdXL2gULqM8n?=
 =?us-ascii?Q?QCw+RtM0OX472ibo8q5CkOCek3yj6Q36NyrCI6wb28Yja7oHaH4bzI5TSQE2?=
 =?us-ascii?Q?8HdFuplLWLmjZRzrOyoGoORJu8XcAg0/Br6F/T4ld4Tmci7V2hqN10MeP2vJ?=
 =?us-ascii?Q?akZBVcKb0cgx+XvA1wlYB95L/Cx5GBVFVSJe2dm/J34jydDp7AW8CuQhbGPB?=
 =?us-ascii?Q?Hi4YdB98sX1xE73+U+gDge3+Uas04h3tOY8TsRWA+qq6BQMOHaoU3FSisJ3+?=
 =?us-ascii?Q?AYl1+b49gte6T0Y2Cvg8zESr+T99xxqB3Zi5J4mkObsrI+ZsvfF6HTLN5968?=
 =?us-ascii?Q?EPoKnfQrDmLEDjlyrgmWGBLnT95Wi16V2cRiM7bVw/zmY2m7C1y9vWY/pm62?=
 =?us-ascii?Q?vl3NscKZSZdUZeYlUdRbPW3pCNKeVsp7/I0EzOMchux2i5mDM2Vw6450vU/m?=
 =?us-ascii?Q?16j3khV60wDfa3zOhNzqQ80A7yKUa54czJ9zmFTHev/EGTbPQzl9cKtXVXNJ?=
 =?us-ascii?Q?kh5CCW9AbVsV56g416moXoAJr5PzdVOoQyLl66xSjA1pfue/gnxJsA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef30d434-e0b8-49bd-3fc9-08da0caceee2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 09:10:10.9778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SSo0P+KcU9pjL5kydLM4h48mEiyPT3LMf5kKykUV5c9CLpKMSkR+02eKXZsRGY6V479iTeX3Pg/TaEOts3W4JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5988

This patch extended the MPTCP test base, to test the new helper
bpf_skc_to_mptcp_sock().

Added a new function verify_msk() to verify the msk token, and a new
function get_msk_token() to parse the msk token from the output of the
command 'ip mptcp monitor'.

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
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
index 24d82b19efbc..80e57ca1ea4d 100644
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
@@ -72,8 +152,8 @@ static int run_test(int cgroup_fd, int server_fd, bool i=
s_mptcp)
 		goto close_client_fd;
 	}
=20
-	err +=3D is_mptcp ? verify_sk(map_fd, client_fd, "MPTCP subflow socket", =
1) :
-			  verify_sk(map_fd, client_fd, "plain TCP socket", 0);
+	err +=3D is_mptcp ? verify_msk(map_fd, client_fd) :
+			  verify_tsk(map_fd, client_fd);
=20
 close_client_fd:
 	close(client_fd);
@@ -85,6 +165,7 @@ static int run_test(int cgroup_fd, int server_fd, bool i=
s_mptcp)
=20
 void test_base(void)
 {
+	char cmd[256], tmp_dir[] =3D "/tmp/XXXXXX";
 	int server_fd, cgroup_fd;
=20
 	cgroup_fd =3D test__join_cgroup("/mptcp");
@@ -102,6 +183,13 @@ void test_base(void)
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
@@ -109,6 +197,8 @@ void test_base(void)
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

