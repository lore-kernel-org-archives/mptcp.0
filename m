Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1F4322E
	for <mptcp@lists.linux.dev>; Sat, 26 Mar 2022 16:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648311897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/0eLDAKqcNcgdhHWAxbkxu2TREA58zR02q92QryspHk=;
	b=hygJ0/zaB8DSb8eh8vChlzq1V0zilRl7j+o45QkHoVjxKEIQzlpViuXOA/btZuse44JRlt
	WtB74ji1rAx/NSTNsEipQ42l7u688PZYlU1tfm0ZfMeNFoQq6mh/c+WASNW9z5E24Zi30b
	5ZL+rSAwXmQjo3gisy+57kAK9EvpO30=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2059.outbound.protection.outlook.com [104.47.13.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-Chly5Sk4PY6O56aumfEzKQ-1; Sat, 26 Mar 2022 17:24:55 +0100
X-MC-Unique: Chly5Sk4PY6O56aumfEzKQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUujxutEk/moUajvNiTmTAvK8GhqfEsQiEPqOcv+MjjcTF9F/6rAdNflcipSB9whP9yBsgYBPmUznID0x3oscrvWPQuK6L0PCMnBW52v6UYzCAbVQBUs1lVwfoefPP0Jk1v4RrRApUzjrs42kpAqq7nFMx1FXaIowWUtmfqSx/IRImWv3NGsxb1cygRV/XgzMHaq53/HL/n4eFKc/7BNomECURTyHiwxvUdVPjNCOfU3TEutW2UHxvLdsZi9ZuegaYNnP4nPnCZYu/H1AigdZ1aVEv/0EyfjgoMDpWn9I6rXclDLP1VnSKyZPWMmzVwQ9Ffe0MLmf9xJQQdyz5HGlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fW4X2bHq1l9C3gmE9lymDxT7IcazF1WzJES0GCoz0OA=;
 b=YXvoMiCTVxIN2eXlwwsD+e8s7Pok5oMsn/ptEJliGk+OstoI1IVx9F/hhvYzwoOoQ3Ym5ZON0zXYq87tw7YkoKgWZG+shrobqLz5uUoH/CkAsszdE6V0d8RVNVRr4q44BR6TAxUMOHoaSEkW1gR4strYQWUkriyOQ0LTNlYg8XCzNFpFzxNRqx7j2I3k1RvIoFAm0S1r8z9KaildsHbvOZq403uuyO9ZjQ0P1DBNOxtwprlf3wnoDg99kZ6vEGwB3slP7qvplomIWciNcx06MwSnkgOfQmGB/dIcYZqYmKD1+Z4MNbqRAgqCgkh1YMmEho8Jd27d7WRWzDznVfzGsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB3067.eurprd04.prod.outlook.com (2603:10a6:7:18::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Sat, 26 Mar
 2022 16:24:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.022; Sat, 26 Mar 2022
 16:24:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v14 4/6] selftests: bpf: verify token of struct mptcp_sock
Date: Sun, 27 Mar 2022 00:24:31 +0800
Message-ID: <a851cdac04b30af74d756d904499eaae82720fdd.1648311457.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648311457.git.geliang.tang@suse.com>
References: <cover.1648311457.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0178.apcprd02.prod.outlook.com
 (2603:1096:201:21::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29ebcc75-e80f-4bfb-4eba-08da0f452920
X-MS-TrafficTypeDiagnostic: HE1PR04MB3067:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB3067275E7BC914D91CD81927F81B9@HE1PR04MB3067.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6/XIhCNcFo7VspsMDoP/yFDdDEC+pajwQR0mqphSHsBJ0V/JvvDdVkDdbQNWgYrfKO1R1fmJ2TlejrCAyVpmJ6Nye/RGwGrFESo7kUkxYuap6plh2VLx073Di+JP0YIfL2FfaUaTXdiK2i6vJ1hfS+sm/nPwO4mx8mgskXkfRRo3Yn+xrxIWVichAcyDJoYdOaPZPF4xBujc8u6YKe6eOGMNSEkV/7kNBXN+yul+pbWvhrry+nQ+KPCEzIfvvDN4NlucFWAIpwdTw6fLKXl5nIdoqJBx79ON4/cCeNr5OANxY1FOKgsco5SLjvdufRTH7Y5oPBsQnvFsp/Nb3R3BdiLGIoQFlwUs0zb/m5Ji/ptsom16IbqJ80+gcSMBBWNY8TXp1kg2Rh+JTlKT/O3N4j2/9yUvtAdLjyKQI622ieQ/l/1SBa33GiayPmvszt+T4rc5chLstmGi6fZdLTt7FH5q6HFOlDWib2SwTDFaZafeDIQ/TANKAoGPK0tNDoak/GatEXEfygktFSn8uLRKtXUAAN2U1h31jhVtpeLYuz0Ly9AdoZM0HD63qFmDUXjh6sVhx3Uy7qFRpWktatnnbjcHG8k1oi3xzjJB0f0UlgX9d+SeQX+JwXhqb6GaJAmu1miIZns0YDBdJrMdK1LOt4bmR9a1oMSItcZXVOs9+V9VH05FPXnGGQ4jLBHEiZmW5tp+YXPZmNN+XN1YVA4GcQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(5660300002)(66476007)(186003)(15650500001)(6512007)(4326008)(8676002)(38100700002)(86362001)(26005)(6506007)(66556008)(8936002)(6916009)(54906003)(44832011)(36756003)(508600001)(6486002)(83380400001)(6666004)(2616005)(2906002)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Eu9DGiFw6xeHaI41lCuSs5BDFkKFPD4IhIT/EovszDY0LozfHxnDEI7QHvsr?=
 =?us-ascii?Q?DbLcYmleg6QvG3eP/PJCqoiwa932hE9/Gp0nQ2KomjYA4tX3Y0aLS2I7JmuX?=
 =?us-ascii?Q?iRD5md6yDOPeUSA6Ph5fk+mWqzt9KIaBdnyPfPDpExJmLdAMy3g9sDJCeTBm?=
 =?us-ascii?Q?EA6wNaFchhB7t8wTGiKO7iFb6TnR6hij7c2mBq1BY7Q/aXwtA2NnYE8pkv3x?=
 =?us-ascii?Q?OEnvTtshX1lRKnTp9+FGR9oV+68qa4gNbg/UIJk0IZN3CSqtV6eUVdZ1KKi9?=
 =?us-ascii?Q?6Ly93H9QcEmOXX62LElLZ59V8MpOC4W31Hy4w1q3u457AcY0VuUppSjJDobo?=
 =?us-ascii?Q?emjRA9APM9UBK9/TO/k49pkZm038Df9n66uzUyaUK1tnUOZlhQVWcU23uPmU?=
 =?us-ascii?Q?vwYJgyS+a2yfHyddI6p18CX9TyV9ecyuFVoOoe1CCbUUzGhVFU5r0pxeezHe?=
 =?us-ascii?Q?7Lx+eeTLBv/N+9yn7wDlvGdWo/zkOq8RnlwQw2EezJBYEaEhnoJOBEV/2prs?=
 =?us-ascii?Q?TqlWYnbwV5tNgu65hc8ur6/BDzNqgktheH7GA86JyAga/gOof38BvDC8u5/p?=
 =?us-ascii?Q?YrlxGyRp4jDHF9rK1leTcPErxmHQTR6m2ZTnZsQ855cqDwA5mNEsHK9rQ3cZ?=
 =?us-ascii?Q?MEfJLo1Rvok2MAvLh8ukp/pIBW+aXuadGSAROWPRZ3rEzYh713QBlkT3y5e4?=
 =?us-ascii?Q?lVdFZUGVP8n7V4GQP6Eha3TklbGxCN6GL26195EdKec/97YzPhZnCVIdo78o?=
 =?us-ascii?Q?mqdx7oyovXoFYDzO3htwRPkxFRCRMRRHuTd99dqs0BDM5r/LpZGLBiUmC0Jd?=
 =?us-ascii?Q?Cej4ofJ5zRmTI9TRAFmVUGnm08XBxjrKi8iCSOXjF6Fzm9pj2CWc5CCqg75Y?=
 =?us-ascii?Q?USxZyArwwMT/xctRZpQ1Yjb0Xfy44Ru85Wklg8P10FxCF2VG13WbKBamxG4Y?=
 =?us-ascii?Q?3uKMmFGcRazQzaJERcWB6gL1sa4L8AE8Exia4VV8sE8g+aoZvBkz2MWihHyt?=
 =?us-ascii?Q?PQFSk2seVLva28bdgOC6dK32sYhzykGxcMI3F5vEhSSTNkz1KCN4qCGmp6GL?=
 =?us-ascii?Q?MZnNidcYF3g1YIT0AEEKKb8Gau2jVy3cxo0h8wT8YlhxzvkB0+uryW7YJBU3?=
 =?us-ascii?Q?2gkRp7xWrSWrmo7tvadu5qcil5O+m0MuEvOD6FIBGLy8iDauzKmUFK0Az6uW?=
 =?us-ascii?Q?EAGqJ7s2obpcVhONsp+lQ41AIMIjYiw/mra7jf8m8RhE+BJIqQNXUTddfru5?=
 =?us-ascii?Q?Nj3AEuvSzsNNVvGscFsCE7vnLwHlGWZd7lEoifkj/vq7xporul6YM4a+VW3x?=
 =?us-ascii?Q?d55yJeACkUjqn0WsQ5OdAVKZ5dDw0haeaxtottZ2IbiOUnbystQgTeGRHflG?=
 =?us-ascii?Q?FyyKAvaz/QMhSO09viuXwNRkjUTXGASeAjBRGjMwV+MHQkM0/D0jnKNuhdQ/?=
 =?us-ascii?Q?bDkuJKVoSzI8JZviGOyz2eE1k2wljxmFtSHixRiXQLLPt4YJ/KdyJQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ebcc75-e80f-4bfb-4eba-08da0f452920
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2022 16:24:54.4427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUvDBQMiVd2kjFcXHo5UMI6ke8C82QmVdHCRFHGB05fGxfHxYTjaeAqdxjc0nuGUNVrOb3b8mAHcnxIsKUt9TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3067

This patch verifies the struct member token of struct mptcp_sock. Add a
new function get_msk_token() to parse the msk token from the output of
the command 'ip mptcp monitor', and verify it in verify_msk().

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  1 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 66 +++++++++++++++++++
 .../testing/selftests/bpf/progs/mptcp_sock.c  |  5 ++
 3 files changed, 72 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index d71616873a3c..9ea6687c8f4d 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -86,6 +86,7 @@ struct tcp_sock {
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
=20
+	__u32		token;
 } __attribute__((preserve_access_index));
=20
 static __always_inline struct inet_connection_sock *inet_csk(const struct =
sock *sk)
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 4b40bbdaf91f..c5d96ba81e04 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -8,8 +8,11 @@
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
@@ -36,11 +39,58 @@ static int verify_tsk(int map_fd, int client_fd)
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
 static int verify_msk(int map_fd, int client_fd)
 {
 	char *msg =3D "MPTCP subflow socket";
 	int err =3D 0, cfd =3D client_fd;
 	struct mptcp_storage val;
+	__u32 token;
+
+	token =3D get_msk_token();
+	if (token <=3D 0) {
+		log_err("Unexpected token %x", token);
+		return -1;
+	}
=20
 	if (CHECK_FAIL(bpf_map_lookup_elem(map_fd, &cfd, &val) < 0)) {
 		perror("Failed to read socket storage");
@@ -59,6 +109,12 @@ static int verify_msk(int map_fd, int client_fd)
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
@@ -124,6 +180,7 @@ static int run_test(int cgroup_fd, int server_fd, bool =
is_mptcp)
=20
 void test_base(void)
 {
+	char cmd[256], tmp_dir[] =3D "/tmp/XXXXXX";
 	int server_fd, cgroup_fd;
=20
 	cgroup_fd =3D test__join_cgroup("/mptcp");
@@ -141,6 +198,13 @@ void test_base(void)
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
@@ -148,6 +212,8 @@ void test_base(void)
 	CHECK_FAIL(run_test(cgroup_fd, server_fd, true));
=20
 	close(server_fd);
+	snprintf(cmd, sizeof(cmd), "rm -rf %s", tmp_dir);
+	system(cmd);
=20
 close_cgroup_fd:
 	close(cgroup_fd);
diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c b/tools/testing=
/selftests/bpf/progs/mptcp_sock.c
index a58cd24da777..afacea5ad9ca 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_sock.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
@@ -11,6 +11,7 @@ __u32 _version SEC("version") =3D 1;
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
+	__u32 token;
 };
=20
 struct {
@@ -45,6 +46,8 @@ int _sockops(struct bpf_sock_ops *ctx)
 					     BPF_SK_STORAGE_GET_F_CREATE);
 		if (!storage)
 			return 1;
+
+		storage->token =3D 0;
 	} else {
 		msk =3D bpf_skc_to_mptcp_sock(sk);
 		if (!msk)
@@ -54,6 +57,8 @@ int _sockops(struct bpf_sock_ops *ctx)
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

