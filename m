Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D3115B4
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 03:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652240415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RzHMu0DhIXXgIrmq93EQ6TWdAuNgoNShD0rrP+6Zaq8=;
	b=lcYYTSWOtfPUQyYMwlzRtC/xTGifenjDJ/u+WSG4GQqn9hrv/SrTQdTyW25oWOAOu5kGU7
	7jo+cMynEU1X3D7ApMsyuriy93SwUPI2+5RMpoxBSuT8rLcIpDl84JaplHLO4I6jUcwNEb
	peg/fWCNZO69Eps1V28LESDqz1D0Si4=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2104.outbound.protection.outlook.com [104.47.18.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-29-PiZMFNObNnetsqpNkmMk4g-2; Wed, 11 May 2022 05:40:14 +0200
X-MC-Unique: PiZMFNObNnetsqpNkmMk4g-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fe5Ri8Ekih1JI5BccPu5Wp/ih9BT1cXa5A4WAIx01Dz3jvpS6fEpRdc4R/HjX0FwGCxcQ2efBMsmdjZ9Z4oJ8ElLWUk+2QZFJECxxmfg31p2U+fcasic0VCkHon4quMBUFonVosTufbIVWOPGNqQW8jrmo4JdZolTuyVcO1ag9VnHwN6KBv6UlYwX2F1yMafd+n+TP0taEOFJOpAsbNMkzqQOXLZkHFnVzJ6BhDeUaX3dQmm8AgGsc4U8aRLsxvN83EHNyoclRMtghmgIPQy8TeW2fN//GFGlqKmY3VHIjRfnwFcr2RaPLIBAsMFX/PWFrgpeuUqEEC0yAzRwXUmQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cmm5PdZwRqf/Yo5VI+SMMioR3Dg8MLhaX1gjthNXcoY=;
 b=oWz/A75uahrlo3sa4ntVRq6ZEwDjMabgassOp8eGWyNSanBYlATVCs7aiMr+8WUTFxICQjlFrOdolNXblR3OrdSXNVRaFAdJUZO1bYxAVHeqx9qNKaZPwGNvtnxWTdmk5/GaQyS+eqTAZxkOar5yA6WDE07VItEX7VSrjTbUq7jVodhPWOEw9ThTTI4xikoMfVD0PDbvD6FomIGCWHpgfFO3ZT0xpRkU1VgX0p/czwcg0RFhiu8ndNJ1jhJASARWlYSMpOWoga+woOQ/iqkxQBK38B2S+MM75ozwexj33brE4GlvIxg6ecUwVYg9dgYCuHiNk32b54R2fmk3scN6mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB7156.eurprd04.prod.outlook.com (2603:10a6:208:19b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Wed, 11 May
 2022 03:40:13 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 03:40:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next 06/15] selftests/bpf: verify token of struct mptcp_sock
Date: Wed, 11 May 2022 11:39:07 +0800
Message-ID: <8c01c19169b5f3a5254d97979fed89da2fcc706c.1652239604.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652239604.git.geliang.tang@suse.com>
References: <cover.1652239604.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0087.apcprd04.prod.outlook.com
 (2603:1096:202:15::31) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40cf365a-e4a8-4f1a-586a-08da32fff4ea
X-MS-TrafficTypeDiagnostic: AM0PR04MB7156:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB715643FA6441DF2321FBC61EF8C89@AM0PR04MB7156.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZpIT5Q6ukKdF6Qk7WvaQoj6YB7fIBV69FKPsqYcs+VM6gcUy4n8Og6ecHwgUdwjYBOo4AJmahnXSBMVOsr3sr6JwTtjoxva3mymlMtXubxuHwIlyaWW3YJieanmp+IdsTvGdqUd3p0VGbheUmwEjQ8AG2iOj1gO0sKBjj08hRdDQjfv+12g+c6+Ze+ES8EImR3jjHFqP7Rs1v9zu+q3cyYcCuG/lHWnafXZAIV5qX+Qs0li/mYDjpkWWHguooMeDVTQWzASvB+sHPgPeBQkBA3DxeUwciV+dK7iGYs1KYAa/CcrUx5zZMu7B5WVkeLxxJBSSlKNYsPRzVbMLM69BLtWmkcmPX+wt5lZIt7DosmtHCaiu0+kZ8ZuxyHizLHU7IPj+7guNNaCtBqhYnvk2NuToLf5CGO8CFAA7mEVLtQSb08+KSuB3V7S35W40FrGcXZ4gsYpKKMP44SOqQZhE9Hx7ceFSo8yH974nlyG7pngCdKWOIHGuD+bvLiRZppOofT083nWTOML0kM8cY2Eg2C+YCfRh96vLcrTaF6F2bh+cfrWxYqGopLO3zB64PDY4e7RVWHM/8rygLWPgg8JrhzpVyZR2WVGipTkaTxmGqvlJJL/FPm5b3sEBhAsdliojwxJ800ci+VudrIgzJyJg0Tu2QJ/5xtd0uPTkM8F8/0Zz4jnLbGQvYLqxqfu39wmg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6512007)(86362001)(5660300002)(4326008)(2616005)(6486002)(66476007)(8676002)(8936002)(6506007)(66556008)(38100700002)(6916009)(6666004)(66946007)(54906003)(316002)(508600001)(15650500001)(36756003)(2906002)(44832011)(83380400001)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0fYJaEQkg9QzPMeu0nkJQQ7ECacVc/O1Hdy1txYdAI+BAnOY9RVgfBzkRFcv?=
 =?us-ascii?Q?neIn+hlLsekiWRcodHs8llnaURNFuRe2FvSyUrHEAguxoNh5kTVCAff88/xk?=
 =?us-ascii?Q?mEBXtI/Ukzxxd4X7lD660hZyQ35mR0CdFRGl4p2nKTpE24dTIi9HmdiwWg9p?=
 =?us-ascii?Q?usnTM6ud4rARhvM3PmksrQiU8lvC/JAXnmqtuW/VpfDzeUUEQx6tE72xLGCD?=
 =?us-ascii?Q?FY1Z+4KvOkgVGlkLBJD9aKw2uxFQ0mvDMWa3aqRRjLotwCQZ3k9YGuw0MkHJ?=
 =?us-ascii?Q?3YPwgveiCSJ7wYMQemfFkDB1gufeRPQXvhZoIPlnDUpaqkRsyFAZA10R8bBL?=
 =?us-ascii?Q?0MnV1WIXvZQMaFe/9HxPNMHoLVBDF2TPiUX6Ltam4nUnYhO91ZrmsEQ+kkiq?=
 =?us-ascii?Q?wUXxSbY4i7Ms5jyebW/0ZYIFw1u8LiN0Hf2kPtOnJFBn10v85kg5OTRdZ94s?=
 =?us-ascii?Q?sG7l2L9r3Lznqs9lbqYZPe3JefZGcD51zuQBswWEI42+2stQCQX2bq/VCsVO?=
 =?us-ascii?Q?DJ/rxLmMtgFH3HyWoGvjqJhzP7dy4qPFV67tEbk0qPbMwBfb+7S+eZZfE/rs?=
 =?us-ascii?Q?Jo5t/LFXVmhnBf3JHmsros9E+DIySF0tiS+kYzMUHWf5hl6KW+JVw/sWOUqs?=
 =?us-ascii?Q?whwvnlFZsUVOsLNVK8ccJmzMAWXudiF9ojVjIG0wNIxZVNLrbGr0RtZOLfwK?=
 =?us-ascii?Q?XOvaBYvhulmlTfRx3bwbqxLlDijLSeJWBUIGeeobYc4ILEtbbneoXmoD1vsl?=
 =?us-ascii?Q?LSe+fldNmV6Ma4MFtl37vDSZBAzjdledodIq9NTx++NWjdghTCt0VW/ngmgX?=
 =?us-ascii?Q?GeEDrFLabCJcwYTumNP2Rxpb4p9UjSUzOScovtlhXnyFPOKH1Sqx+wUzoF3J?=
 =?us-ascii?Q?VlcWBUj3fWjHAHwZmBBCM2n1ZnwRu8rE+6aSqUv6wKIdjbyM2iPNh57BFSOw?=
 =?us-ascii?Q?tY44Kuo0GfJ51inxX9lU2O1agNZvB9bWgfMwJcj3CArzSn9+gIsQWRoWXNBW?=
 =?us-ascii?Q?85LhHsZzukI84yBlPUmnlNntnUunQDKyuApYxvaXIza1/HIqJidssp0DSDz1?=
 =?us-ascii?Q?FZA3nT0E9LXSWM0QCixGEnMz+mfJoFg62UEdRuISIGWielYs3K6tF6FsSV7k?=
 =?us-ascii?Q?DxtyZVO4hVYDSSGY05YLgiaIQ2NGiBn67nJsZTgHLTSwTkWmAy8lvpyacOTl?=
 =?us-ascii?Q?dgrk/h+9G/QRk8KW6LfW7eWkoEStL/2hMXFnyzI6g0m5W/AMK5WdamlXFR9z?=
 =?us-ascii?Q?A9HtkaiWwfhC5L1pRd2cGljSq9zQ5zWRheyrT7gNvmd5aDpI7X9fvFlsDmbP?=
 =?us-ascii?Q?BAshEXCuLhrIi4R37zaf//Zkx2gA92yMDoqUuY2AgZX0UeFx3/jUK0WqJ/V+?=
 =?us-ascii?Q?t9/PDpXO5vmdCI87p+++RXZ5jngn1t+NGIpfmda2U0RNp4jXYtBPKbUEA+4y?=
 =?us-ascii?Q?OIzAlMXo2ZSxXQuY0Ee9L83bnQUAw5itz3nlL8IVdOu++ycrSx9ENjLJuSlx?=
 =?us-ascii?Q?MnaZOQ/IEnaKEhs40Tmq7GM03Ne0nOoLJS/9crvKUQ2VauB9WJe9bPOi5gIP?=
 =?us-ascii?Q?uUH7zD2gDCcor+NCSzjM8B4ZwD18TUrja0IJQEsgzVACb/2HSiWzFhEP8Z2r?=
 =?us-ascii?Q?8rhCu08afcR1nD0ZYrwRzqtWvtJyZeaLzsX90kpMFUEX6DvLaO8v6dt/EnaN?=
 =?us-ascii?Q?YbPrm8Ji6sN8u9vea8u7EV2isjo9c2YNLGkSC2oypERFQJdawIcsnQnoGqCz?=
 =?us-ascii?Q?7w0Y1Gb80cfNg0vGdN45wyI+RC1ZWcc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40cf365a-e4a8-4f1a-586a-08da32fff4ea
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 03:40:13.5113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNPxgOMbFEPodbH0w0NXplqLaUZLaB7xSiwF/AuiwwUsS5EB7ITE+XEt625qumC/5dJ+rbdsfUmHhfCn8kmbtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7156

This patch verifies the struct member token of struct mptcp_sock. Add a
new function get_msk_token() to parse the msk token from the output of
the command 'ip mptcp monitor', and verify it in verify_msk().

v4:
 - use ASSERT_* instead of CHECK_FAIL (Andrii)
 - skip the test if 'ip mptcp monitor' is not supported (Mat)

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  1 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 64 +++++++++++++++++++
 .../testing/selftests/bpf/progs/mptcp_sock.c  |  5 ++
 3 files changed, 70 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index a43b1afe22bd..eee49cca092a 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -228,6 +228,7 @@ extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u3=
2 w, __u32 acked) __ksym;
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
=20
+	__u32		token;
 } __attribute__((preserve_access_index));
=20
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 02e7fd8918e6..ac98aa314123 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -9,8 +9,11 @@
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
+	__u32 token;
 };
=20
+static char monitor_log_path[64];
+
 static int verify_tsk(int map_fd, int client_fd)
 {
 	char *msg =3D "plain TCP socket";
@@ -36,11 +39,52 @@ static int verify_tsk(int map_fd, int client_fd)
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
+	if (!ASSERT_GE(fd, 0, "Failed to open monitor_log_path"))
+		return token;
+
+	len =3D read(fd, buf, sizeof(buf));
+	if (!ASSERT_GT(len, 0, "Failed to read monitor_log_path"))
+		goto err;
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
 static int verify_msk(int map_fd, int client_fd)
 {
 	char *msg =3D "MPTCP subflow socket";
 	int err, cfd =3D client_fd;
 	struct mptcp_storage val;
+	__u32 token;
+
+	token =3D get_msk_token();
+	if (!ASSERT_GT(token, 0, "Unexpected token"))
+		return -1;
=20
 	err =3D bpf_map_lookup_elem(map_fd, &cfd, &val);
 	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
@@ -58,6 +102,12 @@ static int verify_msk(int map_fd, int client_fd)
 		err++;
 	}
=20
+	if (val.token !=3D token) {
+		log_err("Unexpected mptcp_sock.token %x !=3D %x",
+			val.token, token);
+		err++;
+	}
+
 	return err;
 }
=20
@@ -123,6 +173,7 @@ static int run_test(int cgroup_fd, int server_fd, bool =
is_mptcp)
=20
 void test_base(void)
 {
+	char cmd[256], tmp_dir[] =3D "/tmp/XXXXXX";
 	int server_fd, cgroup_fd;
=20
 	cgroup_fd =3D test__join_cgroup("/mptcp");
@@ -140,6 +191,17 @@ void test_base(void)
=20
 with_mptcp:
 	/* with MPTCP */
+	if (system("ip mptcp help 2>&1 | grep -q monitor")) {
+		test__skip();
+		goto close_cgroup_fd;
+	}
+	if (!ASSERT_OK_PTR(mkdtemp(tmp_dir), "mkdtemp"))
+		goto close_cgroup_fd;
+	snprintf(monitor_log_path, sizeof(monitor_log_path),
+		 "%s/ip_mptcp_monitor", tmp_dir);
+	snprintf(cmd, sizeof(cmd), "ip mptcp monitor > %s &", monitor_log_path);
+	if (!ASSERT_OK(system(cmd), "ip mptcp monitor"))
+		goto close_cgroup_fd;
 	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
 	if (!ASSERT_GE(server_fd, 0, "start_mptcp_server"))
 		goto close_cgroup_fd;
@@ -147,6 +209,8 @@ void test_base(void)
 	ASSERT_OK(run_test(cgroup_fd, server_fd, true), "run_test mptcp");
=20
 	close(server_fd);
+	snprintf(cmd, sizeof(cmd), "rm -rf %s", tmp_dir);
+	system(cmd);
=20
 close_cgroup_fd:
 	close(cgroup_fd);
diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c b/tools/testing=
/selftests/bpf/progs/mptcp_sock.c
index dd2448d1e7fc..2a0decd78a0d 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_sock.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
@@ -12,6 +12,7 @@ extern bool CONFIG_MPTCP __kconfig;
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
+	__u32 token;
 };
=20
 struct {
@@ -46,6 +47,8 @@ int _sockops(struct bpf_sock_ops *ctx)
 					     BPF_SK_STORAGE_GET_F_CREATE);
 		if (!storage)
 			return 1;
+
+		storage->token =3D 0;
 	} else {
 		if (!CONFIG_MPTCP)
 			return 1;
@@ -58,6 +61,8 @@ int _sockops(struct bpf_sock_ops *ctx)
 					     BPF_SK_STORAGE_GET_F_CREATE);
 		if (!storage)
 			return 1;
+
+		storage->token =3D msk->token;
 	}
 	storage->invoked++;
 	storage->is_mptcp =3D tcp_sk->is_mptcp;
--=20
2.34.1

