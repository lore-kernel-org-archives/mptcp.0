Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E29E23BD
	for <mptcp@lists.linux.dev>; Mon,  6 Jun 2022 09:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654508874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dcxFYknSSqn2iCp/EC6eSvsoTZmmfAXbqcIbOIVxtBU=;
	b=CQ/DpOGKNQfrGss6c7e6NGElWClT6aGGxII81rUSuznMWDELdC9dmWE0KcHk9AjEWmZMIN
	HxFX3+smBgIT23QHFa03C/WWBSirSHp51WEM7oSeQatIRykkk0uhMVQM/c5uzqGoiqpWag
	SoF0ZtYTrE5V95m5kBUn2TAtwsux9Ls=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2057.outbound.protection.outlook.com [104.47.0.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-1yT--EyOO92x12rzERZsCg-1; Mon, 06 Jun 2022 11:47:53 +0200
X-MC-Unique: 1yT--EyOO92x12rzERZsCg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQAJnJFtWsljb4VjbtsftjmWIwx2T6OpqvLsC5mxsRfvhOsdjn8t/BB4ydvmmsC6vjaED5bHKramhcBKSDBd8QUaMBMvlanP8nXSToYfxXyRHt02AEtbT6vQpGb4eNnlb8+zDs3AiYjROFaM/b3KNHqD5BlYl2k385LOS36b3a5ZC20CsC8nAOxVODwf/2BPdrDxRfY7r2fo7vPd1JXmK2TOiAGxeELk9acUKqhq/SPGsKCY+/ml7SltmIw8X6yGmJKmyHIZLMwBNYeRXXcsyqCL3rLkI0ezQcSc/o/fn47gFQ1j9ceiY28q1MNXTVf4Q0jFL8gZHqcbtPudZiVtEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MJQgoHc2RXthhjd/g/4xWmqUBrv08pWo3t2q2k3m3E=;
 b=GqvwMAvVVhHckdJLAgRaaz7F6BF+I4NEpdBccN0otTHBjnLqXv34EfSCwRO/06U8HJ/KCm73TfpG1G8wXlTd6rzFwMAR1M1NGBYzbjIS44VQdBuA9qfSRHlgKjnCxe/x8mCb1pzKH9mTrP6O/mCFuYKmUeWVF5SMLPM5Tvz5sVnXvQiTrOu1aLXO6oHj/+55ZU4eb8tp58t24MEzbtSUoJLL4uPvTgyWUBnDOnzqQcb48o4Km0/rxQgC8Hd5SgGlrHxgntEIk4Kryg9ZMMpT+Z3ClNEgltW5ccE0az+0OwM+Cq/neQ4jfhYUogJnNkFBWUK4Sae9VKmPOziTtehDWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB4802.eurprd04.prod.outlook.com (2603:10a6:208:c2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 09:47:52 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 09:47:52 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 5/5] selftests/bpf: Add bpf_red test
Date: Mon,  6 Jun 2022 17:47:15 +0800
Message-ID: <9555cebeab769c715468f99ebdbf967a715a3b59.1654508532.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654508532.git.geliang.tang@suse.com>
References: <cover.1654508532.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aea76e6a-28ef-42e6-9bac-08da47a19fd3
X-MS-TrafficTypeDiagnostic: AM0PR04MB4802:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB4802AD8E9A9666FBEA259315F8A29@AM0PR04MB4802.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	km3h1XNd06+K7FQ/XG8CNEZyxXE0M5Dzhi7Uy6g9eD1JJhINHKTiyN2+s9UWILInN1qfRv3VjhIVo8qlrBAVFeyJNH1J/hwXGHYi/Pvk+KfSoh535zZC+TK4nTe4GtIRdJtzXrq9zCDwVAs+a+aUXU97FpBKPqGlhk4h6WbFJVV+2aPeOpAGMi0zhZbm/PhN7L21ctOXHbTdsjCfJeyOXhdsgR2KC7tAVU8Cj8B7Uxahcad8Z/TE14XYYum1+NKDdNwfyirabBHtFgZhriG6ypaVzYajL8EWW16WasRxum6TKXeH5TaNr2kIGU4CHevBeOiJjo5UjEkTA7FtrqFyLtm/FQyTcWm/88f2lybusAFPTzh+trdD8RIuW8fhXWSCv85FNNwzfQMSEe85KOGbNVru0GM/rFfnm3The2dydMRR0i7/WOzORvYVivCsmBqdszFKvLNaclo7lvGBqJrRjql+v2TDTiyAdx3x1ikcNMhxm+LMTmt3k+aQd3CQwGfx1+hGfa2l5VVMCHddVHseTWMX7E/QwAR5NqWhk0qxN4deaWVzWVAVDM4eMtJF6VpUYEq51CmjNBpUFRauVgjMDdph785NTrr95KCTEC5KulpKRWLg/P0J35LTTJz3l0fDIJMZUzQ4ZQQvTLxl26UlN9NVIyu/jhLLOz3XZYkXpRhFQs2RE0iEZspTaJlOuuFR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(36756003)(6916009)(38100700002)(66556008)(66476007)(107886003)(316002)(5660300002)(26005)(6512007)(2906002)(4326008)(44832011)(8676002)(6506007)(83380400001)(2616005)(6666004)(508600001)(6486002)(186003)(86362001)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eYW7vNt4GUYbPp3vjkD+VW5AVTBplA7/uDbI8CEtXNkR/6uAICBXDgpMXdaN?=
 =?us-ascii?Q?y+crRSpvVmtQrgj9yZXwZm2CTNDbs7czbPQGIgi5O3aYNAP5yvh/puNsotSK?=
 =?us-ascii?Q?kDSFYZ3zbwPwUnmPpdha89m8yedOv+TrkCAaaLYiUUiEwGS4vNVRcJ+9NcFR?=
 =?us-ascii?Q?XHWhTcr69+LRPFKgdkodU7lPPMrB43zUMgEHgLwcQOn2x43hOcLm6XgesLbt?=
 =?us-ascii?Q?20zgiCXclKXc5UIdKe0CEaA46B4KQccXAJPTW5iOPFBQkqME3+kqtJu3NrXm?=
 =?us-ascii?Q?bNk9tRlb6mq0yvveer9aO4NY0K48SW1YF29YovZXlBQpeNZUHF/Ptb9aHfpT?=
 =?us-ascii?Q?xkz9F+qPI+xac4Ja1AQaJTWXoB0ZYm4oof8IhxswUo/bVdIcg6Hzt+xvzXMR?=
 =?us-ascii?Q?vUUkFsz9CTQGbhdJgoTc4qudaTtj6tdB8aai5mauuNWLCcrVSluM8Ay3+OvV?=
 =?us-ascii?Q?tgKg3B2gGPcSUVyV2S6LapZl9Q71nBA9uwIbCo+I4w22qyP/18DtV1dFT4V8?=
 =?us-ascii?Q?hT9Ly+azPBQDU0hjfHbsSbhYbKv+hArYJZPZX9Mi1J2Y1GiBXBvkmryNznY0?=
 =?us-ascii?Q?OXnsEcTtrGVvy4oQst2FuSTpO+UxYE54MXpAs4h6DPBtHN3GKGhk5p/aNMkf?=
 =?us-ascii?Q?jgKtGf4dKDKP0VuTemZ60K4xruL6p7ErMKoY3t08Ji+nNeT2hrK+Ng2Wduxh?=
 =?us-ascii?Q?9CBeksgElzwdG2O1S8D+QVJoodIXxhzZkFIovGZ3LPmCOMF6rV50lKl/gR+F?=
 =?us-ascii?Q?wCW8J39Y1cbf5EegrIDnPv3s31753uSJBTK9JxGFx6/Y0aAVi6krZYQRuEe8?=
 =?us-ascii?Q?D8e/XISVDTTRQ2496Rk6caEZnaYNZB3aTcsR3UJSNYWiFVNRhTqxpDVRL4M/?=
 =?us-ascii?Q?AdZlXdIRBMAXe3CvOISL2kGvxzGgsz0Wr2JDboFKv6PfLlH8zoFrcDFu8Dhx?=
 =?us-ascii?Q?b1C48ww6YA7f+c1zmBI0eyBnVskBnryESlrQIveRE9VRvlUsT6nPiF00No24?=
 =?us-ascii?Q?dzIomsVfcAAAyGKyqmVok4GD5cC8kkdp/1k0f31rEoGZ8q+aPQQselkeAq9V?=
 =?us-ascii?Q?iUta8VbPBKBuJ68NVX0M4qr638mxDy79Qei/lD4I19CZZAve2kzpOx2BoKau?=
 =?us-ascii?Q?99C9gseDpp9cRdMJ6bEyEwMQCVygI16vT8iYYTHaNRv939l3QvPKOHpUelHO?=
 =?us-ascii?Q?a7i2o7wEP4tG6x0u+zmAiKUyu0Qsmj3gHvA3N/U91MERGVu+EAzQsq0+YQUc?=
 =?us-ascii?Q?6PnFmCL9OmW4a+jjrPhw4DeCVJDCQcLmjEgdhqHZAKpoAWPUyD+2JVQmg8CO?=
 =?us-ascii?Q?G1EenUxJB88u5tdK7Na0vcljmiCtIHVraUNRYQG7oAZzMZC4x+mlj7ykc+13?=
 =?us-ascii?Q?yEKryR+cxgZtR48wraH9fcM6XmYObiYGJbTVTLEfa+UHZblIyoLm7qEAvYOp?=
 =?us-ascii?Q?25OB7+FA5QhA3y2B0ttPpBwjT89f6cT1h6evB6YFUPaATR60g79h+ckHOozj?=
 =?us-ascii?Q?QPMjZ0G8NfKFZzyyaU8K0d+LcZK9LTtorqVeWWfeZBKtA34VwomlAGU0DamQ?=
 =?us-ascii?Q?3OtDQsO7Nw4dczwhxE//JMwxkG1qxeOBVcVrm+6oRm6x1B7d1WjESEDw4Mis?=
 =?us-ascii?Q?a6qQLdWIzK4BZGGzqluZ1W9zfURRYaNBCWvnxx+4VTMSaxcz0VPa+3W3ERtA?=
 =?us-ascii?Q?CJmTAWNRf6YMmL8JsU7kQgvTC8wWAJ1X2LGwmunUUF7sILOVnAi9+lrMlYZd?=
 =?us-ascii?Q?MhCmGUM6P4s+13J3BGT73lcGw7rL6uY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aea76e6a-28ef-42e6-9bac-08da47a19fd3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 09:47:52.5910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzCkv6IC2Zbanc0VmtOF8H0NiKTk1GSLtUEeZKdtL5wLyNrrDue26RTufTztqLqz6EnyuQV2ejlp+ZaYeVw2EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4802

This patch adds the redundant BPF MPTCP scheduler test: test_red(). Use
sysctl to set net.mptcp.scheduler to use this sched. Add two veth net
devices to simulate the multiple addresses case. Use 'ip mptcp endpoint'
command to add the new endpoint ADDR_2 to PM netlink. Send data and check
bytes_sent of 'ss' output after it to make sure the data has been
redundantly sent on both net devices.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 8b2fe1004323..9f3242c7920a 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -9,6 +9,7 @@
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
+#include "mptcp_bpf_red.skel.h"
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -381,6 +382,37 @@ static void test_rr(void)
 	mptcp_bpf_rr__destroy(rr_skel);
 }
=20
+static void test_red(void)
+{
+	struct mptcp_bpf_red *red_skel;
+	int server_fd, client_fd;
+	struct bpf_link *link;
+
+	red_skel =3D mptcp_bpf_red__open_and_load();
+	if (!ASSERT_OK_PTR(red_skel, "bpf_red__open_and_load"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(red_skel->maps.red);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_red__destroy(red_skel);
+		return;
+	}
+
+	sched_init("subflow", "bpf_red");
+	server_fd =3D start_mptcp_server(AF_INET, ADDR_1, 0, 0);
+	client_fd =3D connect_to_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
+	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
+
+	close(client_fd);
+	close(server_fd);
+	sched_cleanup();
+	bpf_link__destroy(link);
+	mptcp_bpf_red__destroy(red_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
@@ -391,4 +423,6 @@ void test_mptcp(void)
 		test_bkup();
 	if (test__start_subtest("rr"))
 		test_rr();
+	if (test__start_subtest("red"))
+		test_red();
 }
--=20
2.34.1

