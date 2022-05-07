Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACFFA52
	for <mptcp@lists.linux.dev>; Sat,  7 May 2022 06:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651904265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MnKhgbCEdB7MIbRiyNpXuFA4KhxBhzDtYzmRLyhyESs=;
	b=VW0Va6Tm8nOopho1hK7rxhQPdHrZzEqAoFqpGUYjt35s6hby77LrNGK0jPQUlOpJPElAfG
	2Bk1u6H4zRrxa6kYG8qODfaVe4i8v/XDwBkvbrzOQgfcI5adAV187DJaMyqu1IIyieq11B
	nxno1BvRHltzTLqP0XFIjf9StiKGeFU=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2105.outbound.protection.outlook.com [104.47.17.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-oGihJepVOkyif78D-_KzyQ-1; Sat, 07 May 2022 08:17:43 +0200
X-MC-Unique: oGihJepVOkyif78D-_KzyQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxcLG7KdAxSYnLVm8LFTM3U68jzrLXsZSPc27rXtgM3ohp2jsHMyWVyRVitgnqVCFY2gri7vxtBxu2QlRmjAmt2zNULD9UscdCY50EDYk/V8dtJtcXii+RCSVeZHXH4OjFeABR+5vVfzzf71UJ1yS3R0WhwijZ5r4quaJqCteub79V30xdF63ZnOj6WJgrNGyg3nXTN3vxv6GwXspZ7hhYdQRVGxtk9wnNzC/BPNmEzcN/fOIhtIKtFVMhbvLqh5UUUTQd/evEMBU+pa9UHTziF5xT/aNeqtu1TOGozzo6/kJOGBbMLOK0t0TXf++eBjrkf8qNs/552PlPy2Ti6qtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFIYUZvWV/GhrUeh1HTOkVdlogYxgT6BNvE65d1Uqs0=;
 b=HcCGVXs73Nr6Uii4V+16ezRYhnmOnM5u63+tu3+3ZGavy0gIgKW0fqrxx0WXR43dTk8gh/r/sDRPB56dfrHJs1+HB7HWlibkXCAQm6d9ty8EU+8S6fzwoOHe6m5jMsWXn2GKDSyIFwbCO3/FFvk6wjI34fsQ35rTW4Y/jAW0B1sxFtdhzSBirg7kBmPqUO1WBps7s/pvelMyU/2MQ5E3RFDeqfQQihaaHtRoSRglhY6Zbk4OtCrwDD0zpIouy8CFnbspn+zpeo82ZqssCbgNXC6WPQabQ3tKixHX+tgXk2ReR/b4q+Pk13VDsW5XQ9igU0sAweZ3mbe5D6Plmr/1iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7489.eurprd04.prod.outlook.com (2603:10a6:20b:281::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Sat, 7 May
 2022 06:17:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5206.027; Sat, 7 May 2022
 06:17:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: bpf: add MPTCP test base"
Date: Sat,  7 May 2022 14:17:30 +0800
Message-ID: <83acce83a5bafc3b45c45b56105678210d07ac92.1651904124.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0057.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b740a1e0-3d3d-4ea7-d787-08da2ff14b59
X-MS-TrafficTypeDiagnostic: AM9PR04MB7489:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB7489EAB9EEF7D0B62C8C4902F8C49@AM9PR04MB7489.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hOhVs5XG1wiXzJjgoxcVSwmxyvCHvk13vUtuam6VCZz2cfog3XwUAcE8eJwAjmbyK7fU67pI8KLjN3W4X7bKWYYI0OTBdpApi2Uf24QtIoBPzw2hfY1d4QNEsbu7nE7Fj83FrjLEZcKJGrkovnZRrQyFczErz2j6QFvX+iz+8siWxTSXw7tMeJ/Zkk54FVl0dM2DnavgT2SZEwLB7Nvi5XlKA3Z0giwIGCFLLUfumkYF1k+EvaWcGuDW7Qw3R46KmUsZwSM7vRjZM8D9ffkuo0FU2BCmu9x/nR4SyHJFmIs4Ey/BrIpde/ohljz/8OSJB7KbcrcL0W3+R9ekd9TIWrDMjNOS3KxRdkJXp1pDTXGxLq65nGz9e/4InEDpjZ0Ntj5WnigVm48d+SJdZ0ctVDp3KWi7R/8Z6qJCZfJG4AV0QHqSWN61GKJavhrcRz9QeeM8XGil5oRK6ku9YM4CcGC/SA+vTR7jvWlDR4nPy+QBeyEP3rmQ/VmutizfaFy452v7Ar1wPDsEMSfHR8bcFGZGgKI/6OBMfbi3T4eNd81WZ4DDBzSDr16DcOe//4JxH0EfaiaGUgSjToCNR5NsWPKzbQiD740pvh3/sYXqSEz4iOgB504VD+i/+RukwYWeSZrvQnNlu5dnhEFKcoF0WN+uauGsHbs62rviIYwZEqB8NrTADC0Gh3M7VsXcX9yR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(8936002)(2616005)(2906002)(5660300002)(44832011)(186003)(6666004)(316002)(508600001)(6486002)(66556008)(8676002)(4326008)(66946007)(66476007)(26005)(6512007)(6916009)(86362001)(6506007)(83380400001)(36756003)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hE7rF67cCt5wsT7ea2TS7ls5mPitlQieljIF23RpU+XEmQVbqPmdygof8qOo?=
 =?us-ascii?Q?P13BDiREL5uAbE+7qjyQ2qBcUHn5DXXQphGiVtCxssySsBZJpiHzztjs4xj6?=
 =?us-ascii?Q?K03sJt8BZg6j+sEWIvgaP8UKODWbULDRpfEaTXQGiBg1D6/QVxLT12r+xGRe?=
 =?us-ascii?Q?5dXWzfuzFjMAnARelmFbiWMDulbyVRzu74kPYdyfp/B8lOHM6opWkzHaTf6c?=
 =?us-ascii?Q?FTV8avSgOISnbAqBWlWW1Voo/NeSBtpzHboxGsIFP7nnk61068qnjhXLhbwv?=
 =?us-ascii?Q?3i+/xHrHFSKLSS5rt/6U1an1QlOMu4UtAdGfJ76XzbEgjQAePiuJT2YZ9Sts?=
 =?us-ascii?Q?tCy7RWRLHUO8rdez5XUcC4reXfPkKBl9MpYdYbdMlISAclM/hrVSSkz1C1fC?=
 =?us-ascii?Q?/vIFvF81GCi/Gty7r6qY/Md3vLs/V2FEPYyoXvqbK4ar+D2eM4tQgcES3ifA?=
 =?us-ascii?Q?PoBKbcmnuntW7eOsKNfpH4GK409NjHUuGKqkwd6PSXHGzfJrZRmUrCK5zXvP?=
 =?us-ascii?Q?xpGYCDRZmTtlDSCT9nTEK6rhjq3nz98wDuxEaeuWqo4re9R5hgPisFQDZQaf?=
 =?us-ascii?Q?GWHaWbLGysqQc4Il59iSDRHHxtKi+/Rhx6FW6UxfVVPL159H2y0XDQJE2PdR?=
 =?us-ascii?Q?DAxNt6ZMDDCowr/7XnrN0vttwmtwXzx7i4tEWMGCJCxFUYF5fFOLcvUgdM/A?=
 =?us-ascii?Q?O+R3WfIpso4lsg4XA2SA6rEd2jdiZsLxehHpRrAsOOsmelNcUHNN/sYf0EXO?=
 =?us-ascii?Q?q0H3ZyR5BEHK5tz4gJn5FH/DwO3O9ywpQTWuWEGpPs18UJ+w7AzMAVqCKyiw?=
 =?us-ascii?Q?a6MhkHcEVg/zEO46U7L0vTXSdXVRrdMviOWabv2yWmZWJZZvQV+TtaYurXCi?=
 =?us-ascii?Q?BpyYK+1Ry2FIMQx36Ep6f/uNthDKMJcjdl80IIUJF4l788/ubFEOFuA1MbnP?=
 =?us-ascii?Q?k8I0f6DQq1AE+8z33aQlYn3wwPyRnB6qMsDNNv5EUeozVA4aU6aegu69scRP?=
 =?us-ascii?Q?lUNbBzxPuY+AFvfyKiNh4FGD6AhwxrZthln8vdevklXOh9sNO7ZaDXfTQ/N6?=
 =?us-ascii?Q?iUY+ocev+DtymW/97YB12MemyAebFEL3d5EScWC8DpnwWszmerrix1iyiQ2V?=
 =?us-ascii?Q?eqsVHQKDt8rNCKXz9XX4XvuGifNWzIrT+po9AVNgkdnZ7W9QUfOF1oqZR0zs?=
 =?us-ascii?Q?LWl8t5qaS/cBHl9noEW3G9ujqrJteCgzNoG8QRKa9yWpv+xAfRki8tqbAoDT?=
 =?us-ascii?Q?9k6pd4ocmvBG/x0cBBbbQWZnv1/78cVuqqKrmgiCpP07fFu/bMsA3TG5KoNK?=
 =?us-ascii?Q?MKcENNyXsNUQdsNM0opLO9hLNcHEN/m1nmEenDTb48hvgH3QwiXnz4TXZbgC?=
 =?us-ascii?Q?LlyrEyRoRLZIEgYb08mIfwdiPaokCrSLcXctaJQUxJ6uJfY30JDUtvQWUdLp?=
 =?us-ascii?Q?ahyz+Yv2eCV+lLZXewRPDP0BAXXhnAililZrp2Ki66H9jWTu/EvJbtYBu0wE?=
 =?us-ascii?Q?Fy06XeA5D484NA05QXVo9Kr8Ha79zjZhWqGADisc3by4bYmwPSzTBG3FTUPb?=
 =?us-ascii?Q?sSKEY/iqV0IqicvFBRtDDzC3ERCsh4vciJtAU/VJhygMi4u8Yp0U3wuhuvtO?=
 =?us-ascii?Q?UQPvPYtPjqBStSYKjxQ/xxP5cXYwQcgcuhngX40QDMu0epwgPxXF6TrRWkbC?=
 =?us-ascii?Q?hvjo4WD+87XLA3b5xnOVtTTdop+TfINeKwMsrixpUwY4VVCuuZQu4rdT3CNj?=
 =?us-ascii?Q?DyxtNIgrQ8mZlLcvjzOqN006a38yYLs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b740a1e0-3d3d-4ea7-d787-08da2ff14b59
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2022 06:17:42.7117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yhC181yiq/h78WURExTSNSR9D3w/XOlpU0MFcOXG4UnYnSv6deH03iGBmtdyUVOcvxd2cKPkP+OHjRzOWt5h8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7489

Address to Andrii's comments:
 - add copyright 2022
 - use ASSERT_* instead of CHECK_FAIL
 - drop SEC("version")

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 24 +++++++++----------
 .../testing/selftests/bpf/progs/mptcp_sock.c  |  2 +-
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index cd548bb2828f..760374f1fce4 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020, Tessares SA. */
+/* Copyright (c) 2022, SUSE. */
=20
 #include <test_progs.h>
 #include "cgroup_helpers.h"
@@ -12,16 +13,15 @@ struct mptcp_storage {
=20
 static int verify_sk(int map_fd, int client_fd, const char *msg, __u32 is_=
mptcp)
 {
-	int err =3D 0, cfd =3D client_fd;
+	int err, cfd =3D client_fd;
 	struct mptcp_storage val;
=20
 	if (is_mptcp =3D=3D 1)
 		return 0;
=20
-	if (CHECK_FAIL(bpf_map_lookup_elem(map_fd, &cfd, &val) < 0)) {
-		perror("Failed to read socket storage");
-		return -1;
-	}
+	err =3D bpf_map_lookup_elem(map_fd, &cfd, &val);
+	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
+		return err;
=20
 	if (val.invoked !=3D 1) {
 		log_err("%s: unexpected invoked count %d !=3D 1",
@@ -50,40 +50,40 @@ static int run_test(int cgroup_fd, int server_fd, bool =
is_mptcp)
 		return -EIO;
=20
 	err =3D bpf_object__load(obj);
-	if (CHECK_FAIL(err))
+	if (!ASSERT_OK(err, "bpf_object__load"))
 		goto out;
=20
 	prog =3D bpf_object__find_program_by_name(obj, "_sockops");
-	if (CHECK_FAIL(!prog)) {
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name")) {
 		err =3D -EIO;
 		goto out;
 	}
=20
 	prog_fd =3D bpf_program__fd(prog);
-	if (CHECK_FAIL(prog_fd < 0)) {
+	if (!ASSERT_GT(prog_fd, 0, "bpf_program__fd")) {
 		err =3D -EIO;
 		goto out;
 	}
=20
 	map =3D bpf_object__find_map_by_name(obj, "socket_storage_map");
-	if (CHECK_FAIL(!map)) {
+	if (!ASSERT_OK_PTR(map, "bpf_object__find_map_by_name")) {
 		err =3D -EIO;
 		goto out;
 	}
=20
 	map_fd =3D bpf_map__fd(map);
-	if (CHECK_FAIL(map_fd < 0)) {
+	if (!ASSERT_GT(map_fd, 0, "bpf_map__fd")) {
 		err =3D -EIO;
 		goto out;
 	}
=20
 	err =3D bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_SOCK_OPS, 0);
-	if (CHECK_FAIL(err))
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
 		goto out;
=20
 	client_fd =3D is_mptcp ? connect_to_mptcp_fd(server_fd, 0) :
 			       connect_to_fd(server_fd, 0);
-	if (client_fd < 0) {
+	if (!ASSERT_GT(client_fd, 0, "connect to fd")) {
 		err =3D -EIO;
 		goto out;
 	}
diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c b/tools/testing=
/selftests/bpf/progs/mptcp_sock.c
index 0d65fb889d03..19f5f8a183f5 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_sock.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020, Tessares SA. */
+/* Copyright (c) 2022, SUSE. */
=20
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
=20
 char _license[] SEC("license") =3D "GPL";
-__u32 _version SEC("version") =3D 1;
=20
 struct mptcp_storage {
 	__u32 invoked;
--=20
2.34.1

