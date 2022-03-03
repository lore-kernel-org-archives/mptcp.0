Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D3A7E
	for <mptcp@lists.linux.dev>; Thu,  3 Mar 2022 14:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646318912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sErNYKMOsAhQOEfUf4veJZY5Fiaeha/B21DPUzp+9vQ=;
	b=jBjOzClIyoVeKnaKaCHuCmWRC+GIZka/UBvCuoTE1k8wv/DHLJiEcHBmIAGh3+tIjF/MWO
	sz+22SBxBNSVSlHgF/R16FpaYyOtzLvrr7qIi8IjEeAbZadFdj9bFqbJJhuhTdOI0kXZzD
	+z9yBasUDFOnmIcyIgkgX8NYd7Lqa0U=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2053.outbound.protection.outlook.com [104.47.8.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-V0HobEB3PuW6oUMKh35akw-1; Thu, 03 Mar 2022 15:48:31 +0100
X-MC-Unique: V0HobEB3PuW6oUMKh35akw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IReMNlp/jCS4WVpweTSjAflOZHofL4jBFiH47MiJGH2Pw74AQYEHrMwE/huD/1+o0JZV/VRdYN+DOKJ/0KV207RG7WjINeVi3DAa2q5v+3vqRKng7CVHtQu45ej0cWURG73OvomhP5sVCxSx5MUVXZ2ydbVUUfGzj71NvghGxf9SSXhx6XhE9mvmnScLVvmryKUkyk//UmvPpGOaeBIHl7fBWzgMaqkURvL5wPVMWH4GwSFEzfWGmIEyOg1kbkl0OH5kWJPipkY6LXbkgMfTZPKH6nueeYoW0Qsi2ph74dNeXbn+9TdlZsY2VIDBinoj068bfOqMdYYAdGbNMKnXaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtFDs3NnhzQ2WGQ4SrO0ZYogrqG+bENXapr1ZNfRsqA=;
 b=nUkedROMvGiVNYN2lm1v5aKQO8xlcfeIEeq/YCEjaCHBWzB0WN4iS778u+Clk3woMasXL5AlZ2TvP8be3VSulREIqacuZgt4mH9baHD4gHwmW1amIT9ELeEu3qa3KG7Q4Q04OnpUQ0iaHq8lUcZvRFCoIdJhNGZAVJojVNRdJJdEcC5ctsrF87VWa3i0glwjWEQ4xBLmAHvo+LurBmXE1MKkYbEeLTcjTTI8w0Fqhq3+qpGi4WYKZ6km8GbNaozNzPR8GHpqSJN8UA5yuftls2IOq9nN5asnoxS2i7/ZBwvTVZWw15boCQV16u1Ne9dIBJAnkiLL4a48YcZEx88WHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB6218.eurprd04.prod.outlook.com (2603:10a6:10:d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 14:48:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%5]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 14:48:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 3/3] selftests: bpf: exercise bpf_mptcp_sock()
Date: Thu,  3 Mar 2022 22:48:00 +0800
Message-ID: <ad07af14b07078bf3162924a5c3ab69198fa68c8.1646318613.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646318613.git.geliang.tang@suse.com>
References: <cover.1646318613.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0139.apcprd02.prod.outlook.com
 (2603:1096:202:16::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41ab80b4-f86b-4798-97c0-08d9fd24e22b
X-MS-TrafficTypeDiagnostic: DBBPR04MB6218:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB6218565AF42114F65EA61195F8049@DBBPR04MB6218.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OWLnvzywbeV7ArielKV5NVYaZGBkvczMf91EcHEhLpbmGc2Vh8aVokp8fIREqZXrDft57emu/ER/zUjJIM15w0hado+8gpa0iqBDDksL1tW2tt3xGvINczZ+nje7MmXwldg3J/MJS1rYKUQyOFzFhY3dcnrI84humpP/pZJ1lkjcnXSjuZrlnttfOg0voNlpeQMxVLQYXHPd/mSk55PtAsx5DzP19dFXFBiUor1KdhqsLqC6gYAPF0srHSL1ovePBvopSFbIl9rfeh8NA2ejtdCi/vCZbK187ZQJgqWKnA6j8atPJhWlHAQZd12juSS/G40I9EMpsEtVV7UJJyCu2f72W9++NRYmP5vVpmdD/Xa/ffDwanwk8zEaURDDXQ/pta9D0toA9Itdi3KR04wt1rAVfbTErBpj3Ex2kBOJIgEHLKXDHPNfhg8DFBL7McuE4M/kqMPHQCmk1jES8/SU9E6JJgpZDTdiV2ISb8Jn4nwnhNhzE0UP2ZnkWLx2KbCJSUaa0+gwHXknPWjSuDciwZZVyN28g/P2aP1U21dPlTNBfOz9E8jGMbpIAbZFYpcTcZaYFs8hQxIZkJrLHuA0XuA8tIoO7+O0ZFv14CT7GrSD5BBt89JdFaeTOOUr9dhZUedqbmxhVgVIM1/d5PGxHkfOu4nUE7XQBuQrYD0e8xg4LXSGngUWyE0zGwESXPy/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(86362001)(8936002)(5660300002)(38100700002)(26005)(44832011)(186003)(2616005)(107886003)(6916009)(6506007)(6512007)(6666004)(508600001)(6486002)(36756003)(66476007)(66556008)(66946007)(4326008)(8676002)(83380400001)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5wdL0cOsY2h+pIbcDfcbQ9BHXGVUcvkFcW6jKvXLTpApgDjig2swSeD/dwRm?=
 =?us-ascii?Q?0YLSKzkoGIsgRkWw3wvRCRkzNKM8RQdGZkjdPT+FurRffr3FYsSx5sqlAmPB?=
 =?us-ascii?Q?8RJVxncMvimTjkzmILgNCooZe6yhtG2Wgg/dp26VBsILFVBnNVH8MRVrqm3A?=
 =?us-ascii?Q?dqd0QYHNgAfhX2qX7DOIaHvpWKBpxWaO2JRbPBm3/0pbezoW7rf/IWMzj+Nd?=
 =?us-ascii?Q?otIzACqJl30paurI9BxFGwEo056U12MxwnP6TRE8OzYJdlAu4JAf0sYHSElv?=
 =?us-ascii?Q?7cN+32lk8ApxAXDXaQxvTfVteIWcT6aK+AlbhV4lA/gWEHIdOHJTngb8Wtkw?=
 =?us-ascii?Q?AnpEQwKbDdXfth4RiJh8tjB1sRte8kBys/x1SfW1gjlRSpQzPjfBqkTQvhSz?=
 =?us-ascii?Q?2LZjgN0NU+bLdtgPcmt8Vd0QRTXiqYnZxi7+LZpQVzto2xB6E5kKI6Xb0RKI?=
 =?us-ascii?Q?Xa2swebGMqGa9n/8m8PuvXNmJZhzAhp4LqQxY+o7BT7m/j76ZeNQyMwef5kF?=
 =?us-ascii?Q?96jVlhfk8PLpk9/fiGHv0+SVGReT1+mxvUr34+F+DsoO/oC7EkZaBlfIJcnd?=
 =?us-ascii?Q?4Hii4lBCLpcd6Jl0EUJsL8CfuOvkc+RP7ozsUNHNhBUhTbZGVsWSt5OhyKyq?=
 =?us-ascii?Q?YGZcX6hseyJUN0+9ZOrAwKtKmdDdDBnBYyDVgb1AOlStgV6XY7suH0vxagwm?=
 =?us-ascii?Q?dSv1mB4VSu5ufwfYebvODP+6oTRL6SGuukRI+hSB7sM1iVe5ZEdwKf8l9QrE?=
 =?us-ascii?Q?OhxtDM8BxLLqYm8ztlkSCtQMOvarNtTvFaAlnHdOIe98Vbxwc54eCgCcSxMH?=
 =?us-ascii?Q?6RAVOk1wZHEwnWCJ3WxQ0L5Ks57u6alxes9PRbuHOxzvawR9Ytexhgj13kVr?=
 =?us-ascii?Q?v+oMEUk63rZFQQxmFqHDxLHuET6PPD8CrfWmV8JRycPTMPQrHbNeAGWSX7F8?=
 =?us-ascii?Q?n9HXu5nU/UCzgatc/xx9mVMJJ1vFvNCwgTfA2/F8+056gP87/LrYKHA0DVNX?=
 =?us-ascii?Q?ObIGoJe87R3bwvpfFguIMuipCUJS734tAMhgna21AXq7hqyWQEw+ZP4WxhBD?=
 =?us-ascii?Q?KnbUx3kDjATBIk15EyF3z/OiHWdYvxpBPm5Pk4R99BdRr4emXSQoUawg2zLi?=
 =?us-ascii?Q?1TrW05zbChx92Xna34DEtVVHrIzrSM/BhLLDKnpSaW4S4oHbzN+KeNv1cLht?=
 =?us-ascii?Q?BEhel5WbBaAXhPWSedDBsBbqCFbocgJON3Q6cPeOgwQkBKJSYeG34zG87spa?=
 =?us-ascii?Q?wFG2OW9xvUryFJ3y5u/QoJ7cVwyEKM3b2LXDIPaaiXbNE8dfJhvn3FPk9L+B?=
 =?us-ascii?Q?ZLe9C1JL+ropSHhhGuNmmDXEKEbhQv9AbVP8pHThUsMaQP6bgMuT8C31rPZ8?=
 =?us-ascii?Q?HLcP01K+iLK/H2wHoC2AlYmYhaYVIEQ6AdvTk1eWZkIk7GIfgHXKSjLa8+S+?=
 =?us-ascii?Q?eEUlC/0fykZzNWA/BX021HliFf5UYjkwxXD+v1NGpo/JBCZtdNBuHSX6XVPj?=
 =?us-ascii?Q?DzAjXY+0IiTzI6s0AF8Qr3q2APlRkk8MGzdLgDwtSkcaiEPHZRmWv9fttQMG?=
 =?us-ascii?Q?b5HZCSNrX2oD/pH3Mm1t7Xdt5zyQPmEseqtVROAved9J/zC/PIg+GK4YKekn?=
 =?us-ascii?Q?iNDf7eflr/Oh+zidN8TEMEg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ab80b4-f86b-4798-97c0-08d9fd24e22b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 14:48:30.8230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYY4hTyRqr3uruWN9ngkA7EISERFPC4vE/Fqra3qqTtRyixeWkMVd3imVXPFFg5q29YwC2AiWTpTo6XmbOcsMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6218

This patch extended the MPTCP test base, to exercise bpf_mptcp_sock() from
C test as Alexei suggested in v3.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 25 ++++++++++++++++---
 tools/testing/selftests/bpf/progs/mptcp.c     | 22 ++++++++++++++++
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 04aef0f147dc..5682afdf468d 100644
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
+			log_err("%s: unexpected bpf_mptcp_sock.token %d !=3D %d",
+				msg, val.token, token);
+			err++;
+		}
+
 		return 0;
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

