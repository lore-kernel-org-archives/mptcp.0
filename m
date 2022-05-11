Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401AA15B9
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 07:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652255818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tmSPwUIsn5U0TGl/705p2xAwdQ6zDZYXbnI8RlgkYeY=;
	b=J9FUlhRi3gYocfqtYsOZbgP448YgNj7oaPwAK9PePDY5yrh+DRpvYBLp0fFbQQSznO8n0l
	ZmNgjVVhvAbZaX81gKzfA19MAmURCESosVF+9ZKlLF1TRkAZ/tP6vsx+E6VpgCK1kpMESZ
	TmfSzvbVRzoKuHcVALV1+CPQRPIV+oM=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2057.outbound.protection.outlook.com [104.47.2.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-PINpv5dkMzCc10drGrfTWQ-1; Wed, 11 May 2022 09:56:57 +0200
X-MC-Unique: PINpv5dkMzCc10drGrfTWQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEJ1NfVfoWBhA8EtH2HYqj8H9mX2Q+UuSt2KfTWN48GeWFDh/Y+dvgOAicnjom6xwSrna3gyAWpsdDWSYKymfQs34pUbb+ILUOynMvoS4tgtp1iekQZn4TPYug8ztG+49KAm/Q7I3PvKF9Es2hzjIplFh3JOdlw/Zb7DVgUytqTWgmNovCHkbo+awhC1QPPNpHQaaT82waZ1jeZhxblNtDLV18GaczF9RxY9ejTyquPXesd0Sbr7aPldCXsGB8GRsCA5oBee/LhdZCpTN1hNV1jB7m+EwLpc67JaIiCxzERBvw930L7i6bYYMIBqQ5JivmjDpu/EXgT3LPte+pzpNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tnn3/X0CNl3doandydVGG5pk4HZd/VNDVXt/sb6J334=;
 b=e0gizi5/EtyL+/B/b0nl5DCwTc9KxzrmjHwgAIzCMcwI2I42dTzYLWfPAhaQZ9MrCeIKfc/RYUQ5hajRqBJqNOpCW2uWSb6YC0MkWrClb8XnYVb7A50f9ivugsx7vPgASE6bjCe1qRK/3LgkRaPUaor07teVw5CY48swrfSx4z++oYsrYaSQwkBUGjhmj6T5DTnFaP42xnNZAA4xeVUPjogrGn8HO1mJQH9o5PLl8KZhjsWSlieiu23fUYkltZA4yCVW1xZmbgsj7D/pdbZ/o0Jkx4XFacJguvCmPj/PwtGmF9nRwfzStUjQnsIz0LpiDnG3rXHBEVTg16UyVbqH8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by VI1PR0401MB2653.eurprd04.prod.outlook.com (2603:10a6:800:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 07:56:56 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 07:56:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v2 05/14] selftests/bpf: verify token of struct mptcp_sock
Date: Wed, 11 May 2022 15:56:11 +0800
Message-ID: <13b4279be26400df1eb925f816e3a426a832e11e.1652255616.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652255615.git.geliang.tang@suse.com>
References: <cover.1652255615.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:196::10) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aba8d370-aa2e-4902-f8b8-08da3323d187
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2653:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0401MB2653D3DAA0AEFCCCB8FFCFD9F8C89@VI1PR0401MB2653.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E00gaOEKDrfJc/QCd0iPfnm/G2JTf3WohzYA6ZK3d9qV5JpyORRIrM5RWF77VRmgKz5S0w2eP2+fMyu7KeVaRmAETpgsTjNVhq43gEAWiC0MWyjEAQwtURNcLFUEmjDTfJVIJOV9V1ednNoMSmR5nMtIT4VJKf9frynbe9iYUVJfgZPzd07V+vCX+DwYI0gIReuG8EIUyacGg/YWPfXDoa/WUi8CgnKqu/Kws9FcEW/34Wmtl4MmOULskFVc30aZbNbB33okOWjGECt5Y6Ec0TdUjeMkUsBC6cVTXHMBOQpG01JWNcygdXZUVMr7Y8BQbAzVS3X7Kj801dnj+GeqxzhIIN/dWKiJJuxa8klz4uurA5aD8UaVHvPHwTVUIfixY21ZIo9A8QDbOaJBOTtGsXO8Vgn9YflgJeqKa+QpNzParRx7GkaogvN1PUJeTRVHfkpGY40ZESI2Ux9VYeUqdmEP8xBrXvgFRhk2Msm3NhrtEBPj2oIg+nwJx7pecIZIAn4TRpnREjXAKDMrEqeMxuhw4ZpOcSFNKBay55GEe6k6qb98l+bFzEOTcog/f+92TArQ3HADR5AqqBQPEl8RSRj0gDSIq0zFe+nwq7aWQ7tP8pJlVR93688Abye7eGvoEiylK2Nz9DmlLa3kG3MrsvSOHQ4kd6qjDrhg+tm9jb4tWE5WMdhwKNMRPI/7bsgn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66946007)(66476007)(186003)(6512007)(86362001)(4326008)(8676002)(44832011)(36756003)(6506007)(26005)(2616005)(508600001)(6666004)(6486002)(316002)(6916009)(54906003)(15650500001)(83380400001)(2906002)(38100700002)(8936002)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ANDJzLOXEh/d4Lsbpi9iWXGOabqZjPZxnV+W2jlja8RhL2Ao+gf+Z2WzPwQZ?=
 =?us-ascii?Q?l00zWEdg591pQ/j6uh6AgzK1SZ9WFodT5QGP448s4e0/Jjwd5IDG0j0ZDFc7?=
 =?us-ascii?Q?UgtNCW63oTwux4ZxFlQ1G8JundXs/Xs222XeWpfZPqaSJX5gWQeuKg2augjm?=
 =?us-ascii?Q?+Phr77dHvKI4kXhUptwFOsEEvvk7LwfnQJd8EzzGKi+jucclxnE0SW36iP00?=
 =?us-ascii?Q?ddOtO2Zy5kqXoqXUNqL5g2QlgF8Y5MYyuiq5BhzYvj1Nh26+hcp70QjE8n6f?=
 =?us-ascii?Q?5K6adSjfNS0pLdZJurJcpV64b7UqEq4D+LacIT4eDfr1dy0e9SL7zOeyJ93m?=
 =?us-ascii?Q?NGFdKeM+5fSe24CVfKDX5IziBg9sc4nOJCp4riNlquGgU4F9uDM9IRHWgV5p?=
 =?us-ascii?Q?1l79T7XV1afV+c33P9a/cx6jID+G/A5x/1CGmLhBI2tkHh3FnkbhhjNH0/LL?=
 =?us-ascii?Q?8DFPu6YzPEJCOdiBtg9MBFRci8x1QmWrKOfAXVbJTEIohO1zuTA0wuXY3lbf?=
 =?us-ascii?Q?X5A4Gszc2v8O42CUKJwss79F9goLQBXnWX5MLgmoCX1tWjHPXcmVIacXcy65?=
 =?us-ascii?Q?Vt+8d54jLpQXBLahzGLh4G1zibC5UFeZAMTtZav4X55qIAuXpez+N6pxj2tu?=
 =?us-ascii?Q?JY5Ij9BDCt6fFBQ4oWEICZLXwGy7egzG/jUGyb4DmU+k+IVnKtV+hLwIIcB6?=
 =?us-ascii?Q?8J/82j3ao+tAHDBUnLNm+kdzj4MtS8eg1w8+7KpeN68KouU/busfGFs+RaeP?=
 =?us-ascii?Q?4sQw6Vla7X02CwostrFPb2P6qeWiiKLsDru1+xYQjzwU6pexAr5e+8z74/u3?=
 =?us-ascii?Q?5pCRVMRLHbsvYpvpBgkAaJgSOwDmwzjDaPHK/YccID+qjnwO+4gptXYgOCff?=
 =?us-ascii?Q?o8/8gh73dxAonlmgA7IIruPxDNd72XkEvwEHGFuImsivyXqdapl6k3NsrNU9?=
 =?us-ascii?Q?ivB+85tLo6oKtvKz+gZ+msd1p++EMITAaugqJ+3DpRdG6q31kMD0L8K4MGDI?=
 =?us-ascii?Q?Kc/BytCw8zUBzk9tfsD83nt5OQvSFu6aVsI5gmHjb0Wfio/mrBmIjGTeXJIO?=
 =?us-ascii?Q?FBPMIRKwiTAvPaOIUvXfs5Pwl1NXhDMBp1dopMrlsrSCAmWrieRcbfQifKja?=
 =?us-ascii?Q?Rf5AR3XRXaglzpiv8Q9ZY5HDfq/Pr1wsojfJN+tnMHeCx8Xh4LCPpiZm2vS2?=
 =?us-ascii?Q?tlDGox5Lc7HrF8vx/avNh3xOigzI4aDQSg2V+r8Dq02FLQ5Fs15b0RiBUpgM?=
 =?us-ascii?Q?TeZCMVGYSrI3gsQT0oM+xjzu30obvOLiI+Lm800VNaRllt15w6Z5OOlhhWk+?=
 =?us-ascii?Q?SsEA/0yFRCMQoP1N5q5plPzpIwpiSWcPoybz2evE7yZiXTKwT6jbfMJC4zdW?=
 =?us-ascii?Q?kBxk+9n+zePy0fN4s395OlNE5TWYGFemnxw0NTeu2BSk97WKBB0BfuqoxiuX?=
 =?us-ascii?Q?rV2tt46DkLm4pUTUu2gMe7253IdCy4dfNYIPZ3FhjnAFdabr5IXNntYsP9XN?=
 =?us-ascii?Q?JoVcP7uzCroANp9Rc+vArR3nZDTzTJ2CFyk6Ccs5sCDANNtZB9IbO0rU7YTw?=
 =?us-ascii?Q?VgIOwvamM7npLwf4fwDXaENWse6Ta/pFuVQlxc69KDRWV/Rm6o9eHLGkiWoU?=
 =?us-ascii?Q?Lq01Hzb2wxiIB3Pv4baeLARHlKENgSIrmPF3VUdNdc0VttG184vyEwSdzMgY?=
 =?us-ascii?Q?YmbkqKzYNGKjaNcU3w1u99u5PRDVn3/sxHkUtLa8sYbBA7W8zAYDSUJouhjM?=
 =?us-ascii?Q?vRFSBIYhL5gaOeDcmdFM1zghLeEtaNU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba8d370-aa2e-4902-f8b8-08da3323d187
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:56:56.1223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: moDgb1IVRpjpO7885foSwQjniNKocqxvHhPLjelpOjKWe59P/iv9pM1HZi33kyBPsuHeBkx3kGo6wnl39lrrAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2653

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
index 90fecafc493d..422491872619 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -229,6 +229,7 @@ extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u3=
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
index 3feb7ff578e2..4890130826c6 100644
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
@@ -48,6 +49,8 @@ int _sockops(struct bpf_sock_ops *ctx)
 					     BPF_SK_STORAGE_GET_F_CREATE);
 		if (!storage)
 			return 1;
+
+		storage->token =3D 0;
 	} else {
 		if (!CONFIG_MPTCP)
 			return 1;
@@ -60,6 +63,8 @@ int _sockops(struct bpf_sock_ops *ctx)
 					     BPF_SK_STORAGE_GET_F_CREATE);
 		if (!storage)
 			return 1;
+
+		storage->token =3D msk->token;
 	}
 	storage->invoked++;
 	storage->is_mptcp =3D is_mptcp;
--=20
2.34.1

