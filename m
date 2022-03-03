Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3047E
	for <mptcp@lists.linux.dev>; Thu,  3 Mar 2022 15:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646320991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Er90FEpmBcJNW9tibI3s6E4Ke0Bu9EXz5pzPG70EmLE=;
	b=ZH5wD/Jlo8UwJf+5g9faBxT3QVHG7eXA0EyL4DppBOp0Y3+oO097eEqOFk08twgsrSnyik
	m7qA2MnTucsmul2uWYTMSs2GSEEeVFbkdKXrv28Synq5QSRQI0nh0oJWkMKk6sQSShu+Ns
	eLWR2z8UUWMt8mpsOSShwJIhsANkG2Y=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2057.outbound.protection.outlook.com [104.47.1.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-IKBW_mDkPwG3aqZ7HAvEVA-1; Thu, 03 Mar 2022 16:23:10 +0100
X-MC-Unique: IKBW_mDkPwG3aqZ7HAvEVA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlDtc8ZRE2sWrRP/iZqlucJEMA9VHX3gchKsBG0xFoALDqyRVDOkRkbcKP9xTo2emRN5uvIqmsA1oWWdctSTn/WvFf2KfVvwKgjfwc/Pg5ZCZS1aJQ76s9uN953aPxDE7rngOukKNCp1IuMHgXY3A/VbG8Krrd1CMMToDeavl5GgKV51QQumYK+12bzbCxanBGfTlEa4j8MnCG4TM1Zl8bbIYipW86sDsobsOAM1cgJJbr5sDZHhdgvpCVdeq5aRieZJAKquFmoaYwgNO23CQ1TyO78Ha3PHZFC/NNRTVFc4Pfcn7JtMcL4Y4guKPcuCQ9efo0YT8zIhEZzxQFkxTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ONTR9Ll9gu1xS28KWpnJ2cAiN6XdjqqZj+0mJJO6IE=;
 b=C3FSKZUarg29i/+ut2KYUCa66rVtsanW2/BDkHqcYTF4hY8gjw803+3DIOCU/gAhX4ArNx+9lAUggavz1DnUsLrQZrwL5/SLLiX7Opi+E1Plac+Tn6izSwH07UYFj+Hh2ftoLBOJ06xSyP4T4sRpIJFNaJkuEVlb5a7YCWf4YSHwoRl0m5O1XG+nSuMFYtJUEys0kH1Wyt1HgIWjpiEvihLdwaxXtxfrqOidJr8BC71BjRGLlNhyt4JTNHMsu4xhjDCm0YAF20p0i8FYAQ9m6e4SQl37pZ/03pzfkWNbmWDQ8rGssMMvEQIArND1hHsa8niLETnjF93nBRDM++ROSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR04MB3011.eurprd04.prod.outlook.com (2603:10a6:206:b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Thu, 3 Mar
 2022 15:23:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%5]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 15:23:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v5 3/3] selftests: bpf: exercise bpf_mptcp_sock()
Date: Thu,  3 Mar 2022 23:22:38 +0800
Message-ID: <59d5dd61358bdee3d5b1a95208461e20e006b8fe.1646320786.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646320786.git.geliang.tang@suse.com>
References: <cover.1646320786.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0007.apcprd04.prod.outlook.com
 (2603:1096:202:2::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da133f8b-4517-4ab7-de8f-08d9fd29b955
X-MS-TrafficTypeDiagnostic: AM5PR04MB3011:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR04MB30110BE5DFDEF58CD135C099F8049@AM5PR04MB3011.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GHBJI5nFZ3MApNKXVx6+hYMTFnUIo9uKjumVkp2OoXU/yfmwaUevJlxnSybawd4W4LWlUpYs/l//S7gODAVRfCi9/DdcYRWFYQVd2BGRHStwzFI97vVctBVTB5fGH5Vxz7shekZDy/05g3XJeNAUWI0xVDvphia7yKWb5Ll/ipcDIft6G3oQSncmIZKXBdiGdyU1/jE46JOjCSOJ/VFb4RQgoQqnNgKmeQKM+Gh3Vigk6hpOTsnIRu4rWPJpcN+dEo0jsYz3fXoMTvoNqfW0a5qfl3eq0YlcLF1rD5lwxaxeRfpRnusgLMPQVJ5bulpi5P2J+Pix8uF9NTx9DEwAwTEl/VTeNETuW+fSEoKaOcyN2v/vdp8J0GTcgTkjLWJ0I55jri0s8e5lp+r3Mi6BJaSry9F39c/IJq/VoBH7kvcwWm2pYwGjinsDYk30K4a4rKL9NXAirt95e9vgXYnYZbO3iz2uUW4pimH5Tu1SmCQwOBQcke8Gmgg6RhcfMsSq4ODzvMLXvbigGgAyWAGFroopxxNLMXYbxooWYTyH0Xfh3nlTxMXiVDpXKFPJhfvXisUf679l45pjVSGgnqN4PwrqpS0e4w/JYOyuxCl+jvof3m/ng/OLGfOcDRGKYeq1L/Isc3yvTaV4IqiEtp6BdKGhJJO+VQBRQIHc1SONnK1lBbksxgd7vcMCHjtCJEwH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(2906002)(83380400001)(26005)(36756003)(2616005)(186003)(6666004)(107886003)(6506007)(44832011)(6512007)(8936002)(66556008)(66476007)(316002)(38100700002)(86362001)(508600001)(66946007)(6486002)(8676002)(4326008)(6916009)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9j4XifsIQmcQ42MqTZJnTZKllMZQ3ohr4NDUhe/AuRDZoBNow0BvKm82Xx/k?=
 =?us-ascii?Q?XilBvLXOciy2yEIVFYSOoBmpV7C4W3Y0PmWq9OOMA0XONWUdSgBe8mLlv59l?=
 =?us-ascii?Q?XulFzaHtcJHBt3oJfBnRpJRQCaS2oHdMgwTmxCPU7CweQiM6fe39DJkTF03o?=
 =?us-ascii?Q?NIAySaUqi8z2ze2gsmOMCCQfr2Lnj8aWxDpcIG5uWNyygORyVarw3TFgoBts?=
 =?us-ascii?Q?hfk1f6IbNZbwtAkzQMmjifr9Z3xzoVr99TLycqhf2UJ3FTlKWhOlRH+iz1b8?=
 =?us-ascii?Q?VJYGK392o0sWalzXqGh2W51p+YJfIQkuV62PGhnlzG3XsV0SRB+6Hi3a224t?=
 =?us-ascii?Q?1LWNSycxp5LE17mazvdUMPs0nin3ZdA5xdN6+ZCmClD+MDtjRK5TuuVUP8SY?=
 =?us-ascii?Q?8997QgAC6H59DQMjLLqCeEJjIhul6Ihbrvd6FdaYMML00Nf5kHoQ+llzjCoy?=
 =?us-ascii?Q?5R40Q/V4RcvmY/tZ4+2xkMqjSqiFEX/uEZapJ5gBbeU/DoUvPdXgRKoYHKhB?=
 =?us-ascii?Q?U16ZVyzZ57yVWN5y94yqRAkgjMFYQ9QCThyQp3p4BII2GqPOqTJcNJXZ8oFI?=
 =?us-ascii?Q?kfrrOQHlquBGgwiqTYwteM+xaYEwmxJOdRvUieyoDw+IVCKhW7LPdoCFw5AH?=
 =?us-ascii?Q?AbXDAcwa5PpB/Q2UhcarWOSDF2V4C31T54BOk39Xo/4yPDpMTqIwX89p34XI?=
 =?us-ascii?Q?NkCZps+6grP6sr3zL4A4b3R6dktn0+ra1FFupDxEthGalXJtTHveNueOK/7s?=
 =?us-ascii?Q?i929ZUdol1nwZFkW7MzTiER7Rvqzr/oLu8LtPAlBiQP1lM396kWjrNkAZRog?=
 =?us-ascii?Q?hzYoCUve27pvKuTAUhRCR8HgGRPquc+tg5uCT7kc+xLAL9X2Vd7qSaIT7PfP?=
 =?us-ascii?Q?0k3xkeIF/0LmXuyzmlmcvVJrSQrGSPIHmQ0IxA6eXpa38oUfWvp0xyPjCrfN?=
 =?us-ascii?Q?avJtMgV3XuOwCn+leY1uTlEDC1hh/ud2fsEVYqua1aH2aAjUdAje8oeUXbka?=
 =?us-ascii?Q?5BdLPUJBmyDBQmtGXu+GfNNoildMEp2iqU2I1PGBJRDWWGB56siNXKsPrRTb?=
 =?us-ascii?Q?aPTTIzHPaDKzObNP/wOAtqM8UJLYcOmlek6uTv+uCuS95cvAYpPBU8p+9fC2?=
 =?us-ascii?Q?H4OAw8LgEitxk8vQ9wNkwPAs/uaCMr6/XYPKK5MUATfb0JhpLM1MxeTjWhQ7?=
 =?us-ascii?Q?8OQnnR1Oap9HYaFOAe72Uz1WVCqOuKp3sAwci6DJICYKKb9NkMjfE30c3y0M?=
 =?us-ascii?Q?HkJTf+H8F+BEaoCoPGIGx79S3wULJMYOqdZcHe/B5LKH4+cT+rN+DdJtCI/0?=
 =?us-ascii?Q?sw4BIDC+1rVSuj9MsvqpmD0TRpy9HImbRP25A4aFuOJ6ywTVZa8pacv3VUsS?=
 =?us-ascii?Q?LCL6vP9sFG0NVcb//+o6GcIincGyNLLmLNfdpYP8uwCvONZ1T9EILc9on4wb?=
 =?us-ascii?Q?7Ky8yOHWGyWtuHb/AwsTxVf8XzE3RQCCRnmksqRVXrAfzzrO5clialkl+UtG?=
 =?us-ascii?Q?BWnSlBWrcgRDoPI2JonIr7nnqG4O4WprSSvBYCW5tckoDq/MZlzQ+LDoKyjA?=
 =?us-ascii?Q?Nc60U1AIgDxDTrwvfpkDNfmQPBhGgGaDACGcDZXwb8Bzo5DGkSe6y4eZ2QFu?=
 =?us-ascii?Q?wuvdMxrfHkjYGK6RN9InfFg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da133f8b-4517-4ab7-de8f-08d9fd29b955
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 15:23:09.7503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPXrlUHXgIbwUF6OeapntZ5chCVmfpwOyD7/tLWjYOOJPzx/LKx5rFOjl/Qgj8ukfSQ65FBKJRxwoxBCb1BRxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3011

This patch extended the MPTCP test base, to exercise bpf_mptcp_sock() from
C test as Alexei suggested in v3.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 27 +++++++++++++++----
 tools/testing/selftests/bpf/progs/mptcp.c     | 22 +++++++++++++++
 2 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 04aef0f147dc..ba856956f9c3 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -6,9 +6,11 @@
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
+	__u32 token;
 };
=20
-static int verify_sk(int map_fd, int client_fd, const char *msg, __u32 is_=
mptcp)
+static int verify_sk(int map_fd, int client_fd, const char *msg,
+		     __u32 is_mptcp, __u32 token)
 {
 	int err =3D 0, cfd =3D client_fd;
 	struct mptcp_storage val;
@@ -19,8 +21,23 @@ static int verify_sk(int map_fd, int client_fd, const ch=
ar *msg, __u32 is_mptcp)
 	 * does not trigger sockops events.
 	 * We silently pass this situation at the moment.
 	 */
-	if (is_mptcp =3D=3D 1)
-		return 0;
+	if (is_mptcp =3D=3D 1) {
+		if (token <=3D 0)
+			return 0;
+
+		if (CHECK_FAIL(bpf_map_lookup_elem(map_fd, &cfd, &val) < 0)) {
+			perror("Failed to read socket storage");
+			return -1;
+		}
+
+		if (val.token <=3D 0) {
+			log_err("%s: unexpected bpf_mptcp_sock.token %d %d",
+				msg, val.token, token);
+			err++;
+		}
+
+		return err;
+	}
=20
 	if (CHECK_FAIL(bpf_map_lookup_elem(map_fd, &cfd, &val) < 0)) {
 		perror("Failed to read socket storage");
@@ -76,8 +93,8 @@ static int run_test(int cgroup_fd, int server_fd, bool is=
_mptcp)
 		goto close_client_fd;
 	}
=20
-	err +=3D is_mptcp ? verify_sk(map_fd, client_fd, "MPTCP subflow socket", =
1) :
-			  verify_sk(map_fd, client_fd, "plain TCP socket", 0);
+	err +=3D is_mptcp ? verify_sk(map_fd, client_fd, "MPTCP subflow socket", =
1, 1) :
+			  verify_sk(map_fd, client_fd, "plain TCP socket", 0, 0);
=20
 close_client_fd:
 	close(client_fd);
diff --git a/tools/testing/selftests/bpf/progs/mptcp.c b/tools/testing/self=
tests/bpf/progs/mptcp.c
index be5ee8dac2b3..faf5cbe49d70 100644
--- a/tools/testing/selftests/bpf/progs/mptcp.c
+++ b/tools/testing/selftests/bpf/progs/mptcp.c
@@ -8,6 +8,7 @@ __u32 _version SEC("version") =3D 1;
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
+	__u32 token;
 };
=20
 struct {
@@ -20,6 +21,7 @@ struct {
 SEC("sockops")
 int _sockops(struct bpf_sock_ops *ctx)
 {
+	char fmt[] =3D "invoked=3D%u is_mptcp=3D%u token=3D%u\n";
 	struct mptcp_storage *storage;
 	struct bpf_tcp_sock *tcp_sk;
 	int op =3D (int)ctx->op;
@@ -43,6 +45,26 @@ int _sockops(struct bpf_sock_ops *ctx)
=20
 	storage->invoked++;
 	storage->is_mptcp =3D tcp_sk->is_mptcp;
+	storage->token =3D 0;
+
+	if (tcp_sk->is_mptcp) {
+		struct bpf_mptcp_sock *msk;
+
+		msk =3D bpf_mptcp_sock(sk);
+		if (!msk)
+			return 1;
+		storage =3D bpf_sk_storage_get(&socket_storage_map, msk, 0,
+					     BPF_SK_STORAGE_GET_F_CREATE);
+		if (!storage)
+			return 1;
+
+		storage->invoked++;
+		storage->token =3D msk->token;
+		storage->is_mptcp =3D 1;
+	}
+
+	bpf_trace_printk(fmt, sizeof(fmt),
+			 storage->invoked, storage->is_mptcp, storage->token);
=20
 	return 1;
 }
--=20
2.34.1

