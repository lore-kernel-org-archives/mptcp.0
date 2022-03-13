Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80655A46
	for <mptcp@lists.linux.dev>; Sun, 13 Mar 2022 10:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647169167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=96gp+xDOUKz2nkxzu1pslLJnKIKTgNg4aMpwpyNVUkQ=;
	b=TtnLHU1rTA4fXj8TUAAVph+x0uEKnuyFk0x2yWwpmCFwxtgsNAoBqj0T1oGyok9bscAF60
	F9763E8og9KgBHGuGdBpIlN67L3whIbFXm2lFpuOVi5eKRk5PinAj6uj564dUAkrjfCsQn
	AKAQs4wum8dGnrBY+sqUn1JbDgTZOUA=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2109.outbound.protection.outlook.com [104.47.17.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-CGyBVZ5bMSuXF81NVagbIg-1; Sun, 13 Mar 2022 11:59:26 +0100
X-MC-Unique: CGyBVZ5bMSuXF81NVagbIg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMbbKx2xueeVy1AfVzBhMdNVyU0y81mXN9l0g5PcYcHghZSfq6nL51mDYzZhclmqiQEsl70OplhLxH2WqnM1ZTwHvIdP2ZotbRaGG2R4XXICRouhq37hygTVxSMXEjIIsAP/u7rYSnmwSwGcaBbTwrnrtPgrIohQW93N9UGLgU6kzGhECFBmcelOm/EtseDa5idCMqMTj5POI/yDQKdMDGxIvr2ezFUrLrIzb7VopsuhyqdrN6xr6kR60n1adMqVcPP4Fa+7Hi6oLGtoJTBGKOVKotHx7pYovBaDdP/ui1GBJSVRHZafUeOql+aF7AFDf9eqd//CP5wNmvvPK8TopA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bwv9Z5SMmd5qjqtFaYOnbluR8kJrkFOUVCLlwPAdCb8=;
 b=YQhgEvdOCsUtZ2FcJsuqFqbc164HvN7YA0x2RfRD9qcea8usa9X9Uqrb28w5rG7ss1XyOhPI2WVOE7zS8IipUquPWVwwxeBruP23IIwc9dzmSNFEncbykM/+8ziaR5TOUJvIznLAFH2tYqYzSJJvRjsss5yi3TLIIToxjMCFgaui78sQaCXMX1AkGjcske0KOe9sValdMq6u+V+Z30LWfO/uKjMUxUQm9NFmQmv+IP33Civfcz+Xb9nfxsrf6KknNSp6I3Fp/SBcmhy/uhdRTuWmO6Ft1asvoQQePneBB+g0GNu2q9b/oAfGbtSK9LE+nz6RBU/QRhc5qDEJY/VxBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9283.eurprd04.prod.outlook.com (2603:10a6:10:36d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Sun, 13 Mar
 2022 10:59:25 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5061.026; Sun, 13 Mar 2022
 10:59:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/3] Squash to "selftests: bpf: test bpf_skc_to_mptcp_sock"
Date: Sun, 13 Mar 2022 18:59:11 +0800
Message-ID: <7c826fe90ab1d4aa3a1d604b97dfea94420aa778.1647168955.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647168955.git.geliang.tang@suse.com>
References: <cover.1647168955.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0048.apcprd04.prod.outlook.com
 (2603:1096:202:14::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e9c485b-a6fc-4ad8-154e-08da04e08931
X-MS-TrafficTypeDiagnostic: DB9PR04MB9283:EE_
X-Microsoft-Antispam-PRVS:
	<DB9PR04MB9283D476FAEE43909E50C26CF80E9@DB9PR04MB9283.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LHyP+als8ch5TjBmlKvKaM9F3G/Ox97T70lZWi9QIYz+BFvdsDkx/23S5o92cQlu3A1kLp34jnn5563q6j7OnnuVjVboHU30NYuzQE+tr57iwCVuLH+ks91PXUYQjIQYb0TYElfGH/y826qQ6OsFSDCejksNi3XtONEiaOmWgUzPFYifeFmlKAKdIgBAZyPIlJJI2of588JSamKKsdzJWommZMVag5wVIKR9vnkHqlvvGjRGXtWJ7WaiSMFlZacXiK/OjZcNXbtw+Zx3HWd/BT8g9+cS8AYN07MwikIybyQuJ4h/OBTtOdS8Qr8KrAH7v49vWJ8HXrjhPYmtaxOdEX/JOpFKzaG+W/2GxdcAOUh7u4Dzo0mt1R55nlKgxb9kWMff0ma+GMFDrlQByylNeq5WM5wTl4+Gg1YN+Hl8lJoUhZb7Q39nW7TIJ6B3hSSuVrby1zedFQMwhIXvTibVOPmYdtqBmReiOv8wExCLCt/e4AFXTlCWsAlslRTxMJ7EJEs/Tq4t6UfUsyI7asMwWSdV1oHf/shbOyiWv+4SHZLz31AxXfqELop3RDC0L2/NeJRt8B7VKyvbzPMh7F+cE6ecNf4XhXN5FXrAzaIdmmfz1rmNv6EVS4Vx2PHUuwJMlTvvpB5nvrJKDAoS/zUueI7k6otO+3YXrUwiKz68YCI5Vs4PKe6erxrlD4fHezXzCQa/gRMsSmVDbTn0KQNotQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(107886003)(2616005)(38100700002)(26005)(186003)(6916009)(86362001)(66476007)(8676002)(4326008)(66556008)(2906002)(316002)(66946007)(8936002)(5660300002)(44832011)(36756003)(508600001)(6666004)(6512007)(6506007)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mzbx2WAxLpIA+YyioWRTFTCfq9T9zNC1ucXaDlfVJbcw9jyZ9Om0dEze2KhL?=
 =?us-ascii?Q?7JJIR3GotXcQM+1gVdUT8uJzIidZGukvtplO1M98xIvrGTUTeOcZqWRT7172?=
 =?us-ascii?Q?jEs6xMLhdNNPnkLHKReHHBSRhMuz8KHE8/VJB3FDA8lS3YKQXwzEvSfh5HUP?=
 =?us-ascii?Q?yxWKMJaOs92U5pRhslMYA8Ez4ad7W3Sc43JpQstipMMdCuX6x2X45O2DJOdg?=
 =?us-ascii?Q?j75n7AOW2ml77ls5C/hEzxs1shbrzMyTwqzNdrUcOEQTuQgsjOx7sFrnWQYn?=
 =?us-ascii?Q?HD1k/GWwRvK7VlNZX2lBOQlyDBEdDQVxzjaBEC54H1l+o4aCNj1iXGikBHbF?=
 =?us-ascii?Q?jnNFEc1wWK1RX4PTbRSu9IghrELxk8+Fmk1KzocSjQXiSDq409yt3tFS5Mv2?=
 =?us-ascii?Q?oytlmHnsgKnaxboGa6tdZMRMOB7bpg9wUJ/AV57VI6kNcZaKBDM42jinRjKA?=
 =?us-ascii?Q?3EZBqk5IsSbiVNG34TY4g62z8N0OckzyubIRm5pHqE9bs5lzBJGoS1Ucq4Z3?=
 =?us-ascii?Q?RulOGCnRcemy8cslMt+GtmwwaYULbUx+sOOUKKgsBN6XV3rmWT/AxCO/JOpb?=
 =?us-ascii?Q?Y2vaMtbP6+thQx1ZbmbDLuij/EmqimUnlHf+ihGG2fbWpLXOwoTvziznFaMv?=
 =?us-ascii?Q?hHi9OA7A2c/+McVAhLollY8miWadtUm91jchlF7ni1y5MS0CuNEsIDvzBoZt?=
 =?us-ascii?Q?n3XheryRAhFDWaBdCCBLDZCc2DLmqPTRIi2CCoOudt+EQZSVuwDIYBrmhdfR?=
 =?us-ascii?Q?URVyYEoAQ2OIiOWoXc9hg6xHhAPg+TUOB16dbLs25icmmay0VwFje87zTHPD?=
 =?us-ascii?Q?B3ELHFecOrtPR1OSv7MYDQF1Q/1S0mK2hQvikx+V5q3S7n+GKRzSMH6By1JM?=
 =?us-ascii?Q?ke6i6qQPiy76ihm5qBesv0omyMnzKr7dTXFL0klP7MEZkIgkJhWAfHy1iatM?=
 =?us-ascii?Q?biUF0hX/Du77vORuF0VXLZqdwfoNhXUkw5P0ieu5XgELOcimjAriYdbJkCqY?=
 =?us-ascii?Q?olFFpI/s+ShZsI/KLyKwPTsOLm3PVOr6He4TiefJfuZ8NpbE7uoYdf8KN0IC?=
 =?us-ascii?Q?xj3Ie01komqn5xTqXy5MtdndULxatmPOWw2JfbmPBbDJXwUBm5dx0H0Yjk3f?=
 =?us-ascii?Q?gJFbmvhGsJuOgBtkOBTolWcBS5N0XGT+DnwoCEM/6CMzwKDo3B37xULalF6V?=
 =?us-ascii?Q?k+U7+DgwA4s67u4Wu60/n4P3gcH5cD/s8x05KuZPGJ/o3pBmVG8It+9XqHo9?=
 =?us-ascii?Q?cA4hIshqPQG3hFpjdXIfpcsyQEhCtcVChIuS/oHRzy/beSQWb/62v+7cQqzH?=
 =?us-ascii?Q?ml9QKZ1pRQqGplOyl0tg0oEk7eZJlY3jRv2c2rJSU58JSfEqaL33boy4xPT3?=
 =?us-ascii?Q?SKwge9nZA1+2Ol7KDLB1ku19PnjOxH9JAh0DcF/ct1aaouSofPct3I5TYMVm?=
 =?us-ascii?Q?v+jIBglXhU00eDvzpBntOBkDWOBeSPcy5kdL76HwoQMFAc788a54yQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9c485b-a6fc-4ad8-154e-08da04e08931
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2022 10:59:25.0195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ts2pf5QcFq/iYEpg27wmqU5Vh6tk/tYavWlxCz4n7jRY9Lso2ZClq8U0UD+wDO2NApVnQEIVHl7O8vu2hyn34w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9283

Some small cleanups.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h  | 2 +-
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 2 +-
 tools/testing/selftests/bpf/progs/mptcp.c      | 9 ++++++---
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index 05f62f81cc4d..9ea6687c8f4d 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -86,7 +86,7 @@ struct tcp_sock {
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
=20
-	__u32	token;
+	__u32		token;
 } __attribute__((preserve_access_index));
=20
 static __always_inline struct inet_connection_sock *inet_csk(const struct =
sock *sk)
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 035a87755b94..80ae5a9777bf 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -56,7 +56,7 @@ static __u32 get_msk_token(void)
 	fd =3D open(monitor_log_path, O_RDONLY);
 	if (CHECK_FAIL(fd < 0)) {
 		log_err("Failed to open %s", monitor_log_path);
-		goto err;
+		return token;
 	}
=20
 	len =3D read(fd, buf, sizeof(buf));
diff --git a/tools/testing/selftests/bpf/progs/mptcp.c b/tools/testing/self=
tests/bpf/progs/mptcp.c
index b08448a12c02..928111f56f69 100644
--- a/tools/testing/selftests/bpf/progs/mptcp.c
+++ b/tools/testing/selftests/bpf/progs/mptcp.c
@@ -22,7 +22,8 @@ struct {
 SEC("sockops")
 int _sockops(struct bpf_sock_ops *ctx)
 {
-	char fmt[] =3D "invoked=3D%u is_mptcp=3D%u token=3D%x";
+	char fmt1[] =3D "invoked=3D%u is_mptcp=3D%u";
+	char fmt2[] =3D "token=3D%x";
 	struct mptcp_storage *storage;
 	struct bpf_tcp_sock *tcp_sk;
 	struct mptcp_sock *msk;
@@ -61,8 +62,10 @@ int _sockops(struct bpf_sock_ops *ctx)
 	}
 	storage->invoked++;
 	storage->is_mptcp =3D tcp_sk->is_mptcp;
-	bpf_trace_printk(fmt, sizeof(fmt),
-			 storage->invoked, storage->is_mptcp, storage->token);
+	bpf_trace_printk(fmt1, sizeof(fmt1),
+			 storage->invoked, storage->is_mptcp);
+	bpf_trace_printk(fmt2, sizeof(fmt2),
+			 storage->token);
=20
 	return 1;
 }
--=20
2.34.1

