Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2041.outbound.protection.outlook.com [40.107.7.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7431FB4
	for <mptcp@lists.linux.dev>; Tue, 15 Aug 2023 06:30:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjiA0k2b4VPBl6FHctquapxoTxx0g6STU5L3qPobzjCYjBlaMyu7yznSMO6MpxlSfTjAZ9o/KUMIedFXYiCP5FSnRpeavzoPoKw0sGo0sbxpBkMJlg8O6N9zxzTd8wqzdI91Dl2xiwnSxxK/hRa9dx7WrrQJf+MCaLJM/t9n7/okw6mbS94Lbgk390rpza1cBMTkrq0WQpGzCj59lBX8uu+ftWC5AYGyCCzFkPfiMAyoTusRX+njdNItlLRU+qWYeUq1bPLPLeViZjSSxOmM0yNlRAbhUIJw5guxU4yknVPBWs/+8ihcUAWw1FTV+9qbiGS+5P2LW/M4MngkIKDX1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OocR4KM0tHg3NC9ZWNWfD0012JZHbfPUj894DL5ilM0=;
 b=K4lE1rx3is+owVH1hDLw8/zXWSSFXcNr/j/z0vW/R7dYnLkkb1PkUOcmsn+5Mcp5wt6pPA4mi4JvCTaxiJK3al/VxQDs/orQsByfm8wKS3Ma4W4A9zuydjAwLE4PsPEAqKZZUT7WBTWkCD+K6D7aDT9JOSk33/ZKS+MghwcHpKH/3ukobuQ8RdIPhI6wlAWhCx4jZmV7AE9q5vhStUWVaHi5kS8+5DVEXs3OIvNFgkZp/jg+qJqAWfWcPuw3bbRaZTJczvS1nlIB26BWnSjX0T7ot6ojk+Nsux8qjIekX+TqJCWaBLSkrFtp0EdFOdS2o9BSiHkhlLlBrKm1tL3Rdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OocR4KM0tHg3NC9ZWNWfD0012JZHbfPUj894DL5ilM0=;
 b=fg3HgK4J4eFf0dxtlkirUf/+KVzlGzMD2myRUb3nFjGcIf02OTI7lvu79Odwij7XgoywKG4m4xyWwuJglTpiL+MGaEDC/b+Y8Mp1A3nVHpeqfeCajH++M9SjWFPgbAATm2QNu3r0DO/AERdOzKECdMUnYL8gcJHM2UYg4t6XrpjtFDSdaVmLYvsgwI/yx8MTcoEZNoPWiNW+MK7un2fkp99VzyfTRqlpDrdHUsXtLCgQVjK42idJyNqNQV9F2F8TwgkXmlzWq98v1ZubuUATlfR4i2VV8pSPMcRsKKa1lL/ZNR0HojC26Vw0PMjp96JpyIuDjmjSpOmZ9HHr04OBdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7239.eurprd04.prod.outlook.com (2603:10a6:10:1a8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 06:30:25 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 06:30:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 6/9] Squash to "selftests/bpf: Add bpf_bkup scheduler"
Date: Tue, 15 Aug 2023 14:29:26 +0800
Message-Id: <40a9ab12ba7ea1c508d3336e201e0860f021f35c.1692080803.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692080803.git.geliang.tang@suse.com>
References: <cover.1692080803.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0022.apcprd04.prod.outlook.com
 (2603:1096:404:15::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBAPR04MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: a7bd93d9-e5f5-446b-d753-08db9d591bfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lW9sNmeHAr26V6rqL+17RguTAZSp/ionZIMfT4QmA5+T3lmMOMQ3aK1XlPGm3RPYViqHaFtR0Hq8ueF+gXfPoSesUn0HcgJXo9ZPBXppzm0sOfVRr+kB9RywS/kHzu2TmJTOZ+xnAlk7T8rKyu67B4IBIKchlTvuSi70BesZ0Q6cMQ9KFo+BbEDIbA/yCn38n9DEIpCOqSIQ8BQuXATBnxQrljihlA3jc+QqapdXiHfAUbWtl1kYfs+8qzL4rn7MwVFyAeDOQgJ5OREXvQw3teTziH51KngfZt9PqIPU5pyexZmkHp5bB8KRsRiVNU70ItpsbRzvgTCjEPEP4bdyz3gad0E8Lx08/wbDoOglBxCne2R9pD/pQ6fSY86zlGC0ryRoTZykPBi/0KClEGNwcQO+t1B2Yx86IcFRE8hD5eaRbBftBRqhkq/BRNM5inp8jFBuQSaFXqflrpV2rDRBH1PpfTxdShsnZjQy0+XIhsU4JfyyfuNjDm7dtC6sgfRtSqMj0ABF07MU5q2niHdL+yiK4zqLBcWLsw3gd9HCvPBxDItoNlFUDWgx+AE7uBEQ4WnZX6t9sByGpkxOpkVcLxlZW3o8ckjc1kGma9JrIto=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199021)(1800799006)(186006)(6486002)(6512007)(478600001)(2616005)(107886003)(6506007)(26005)(2906002)(44832011)(4326008)(316002)(6916009)(66556008)(5660300002)(8936002)(66946007)(66476007)(8676002)(41300700001)(36756003)(38100700002)(86362001)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z9S2jgzHKJFp38WyN1fWH3j6RW/ufeRz3fGJr5b6l3qMi5xtSEqi3SYbB3J5?=
 =?us-ascii?Q?bGWl7P72R0UIyhR5JLRXQZoT1WZRrHxSueOXhlwMsZH/wdbNG5JF2dw/9Uy/?=
 =?us-ascii?Q?AHwbfA4xtmL3KI4ZGXQ79Ww3VB+xl6k6iF8uvRSk3HQ87EncLlRranFvfRaA?=
 =?us-ascii?Q?DGBd8ks9O3W5qZxnarPIQXTZIBZy8q3CUtAeSCA+PZ46CyyvJGaZUFHgByym?=
 =?us-ascii?Q?08zrGuUtcZP0hZ6ZAPIc3PIc87FUyjXJrb0DKj/IrvmezchHh+/PiPTQubox?=
 =?us-ascii?Q?qEOJhbtL7+nSakAxBajGu1dBgbPk+zG94DpVGuzVvCHI7ZmW3n4x4wJGS4Iu?=
 =?us-ascii?Q?3UdBkhxU2+n7QyRpNqyF5d+V+fm7BZNIqWYW6Y+PQzNAdnl5hnoWMMVEpDQU?=
 =?us-ascii?Q?37PqKGHK/OAjMFehwJqEOVM8eiACaGeZEt75EEPtmBpNgztOm4j/kiC6abbJ?=
 =?us-ascii?Q?TEALEKlrhCkVNCJkQa5W4VYue6QJW6K7oP0VL4G7P6yivn+OvSBVov+DQDhq?=
 =?us-ascii?Q?+QKxkw4QiI3BpY6aYQY9kgIpsso1sHpbI2amYyj9OwQfzQ+FycyEcO1PP15a?=
 =?us-ascii?Q?jQjfY6oz7JxZYDFzPSXEhwjwyK0w5MpQIFV3jp1Pw1Wfe4HS9vIVxwWw9Jo/?=
 =?us-ascii?Q?yq5ab31sF4qaDto2TdxM0Rp3niCYbHOXQcGCMj59+1m70SOKK9B08GazcdHd?=
 =?us-ascii?Q?Vnbxhn47yiGNtpaEk7VdrKuoBd6G7bbPkr15n+PKeiKQAVEVqJhxgiPxfD14?=
 =?us-ascii?Q?xWOp79WpaVCFEZ/w2PwpJr5/IgZBlB2WTRGFj3lO+lXaCeqI3YnlTFhlur0Z?=
 =?us-ascii?Q?HJ1DDU6ZNlPaoR0nDpKqJtPrsU/opI+oqJ62hPAcG4SUOYsjoUNHn2FegKrM?=
 =?us-ascii?Q?H5pXpJMev1tuumWGnfzyTsLpTaXFipbgiHlJ9BHzMa5Bqh2D83jtOd4+O+6f?=
 =?us-ascii?Q?pgtUL6b/lpxo+/9JKLzH4v/eksTSNvufeF7L8N98ITViI2wsdSVggxS9n0MS?=
 =?us-ascii?Q?EuTsBFVbdiwwJP2RD4PouGBE+Kav0TTwk25o/OmZ7L9cLdQlVVCBbKnb25Os?=
 =?us-ascii?Q?2sfBr2HMTOHkdiFspl7PYZdRo3n09H27mxh+VHG/ucx89DP1W5g0+glXxY7k?=
 =?us-ascii?Q?I5jf4ulkGR4VniXeoU4RbFkXi7/7bhEJpU5CYLTgEtFDZm03wUGj5GsA2WRU?=
 =?us-ascii?Q?AU84W/iJ8iNU2MYPDBRsuJFlhmmTXc604coAAgX5lecGMJY7lYUY5jvTbEgN?=
 =?us-ascii?Q?pNsRyBzMqdbwFRJRylFlxJto0AVzYni6Ez8qVZ+D/zmmTQtOAKH9udFMWA8p?=
 =?us-ascii?Q?LcZp7WzLDLNwE8lT5Ca8I8Fs0huWlnxQy+SslY6eF0nCmIA34I3GFOSqtEth?=
 =?us-ascii?Q?Fw6ftdfHbaveKo/fe7jfX3heQ6g/BPlIVGwNvfog3Zj/+CqmkotL9xvfWxi8?=
 =?us-ascii?Q?74cS/NO02z80B6TrJxGbCSaOoYld8X5m+6caol06Ifxyi7tCliUl1jP8FVyj?=
 =?us-ascii?Q?Q78UDC3TX2X9qzK0ULBJLiV3oLjHHHA+9mC34g5C5lZ/7Y8axzp7nmlJo8BO?=
 =?us-ascii?Q?VwLNYMLNOnexohOfwWJ0l9Tu7jGsUs9eKTere4a8?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7bd93d9-e5f5-446b-d753-08db9d591bfa
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 06:30:25.1581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JsrOKvfINSLh8Oo4tpOHnF6pv0WGLEEwKlmGoKgFrFwo3XL6qQYZWay53xm7tdGjNjNhhlexfvWLN/559Kg1UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7239

Drop data_init interface.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
index 21493a3affdb..7e66ab839d14 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -16,17 +16,13 @@ void BPF_PROG(mptcp_sched_bkup_release, struct mptcp_sock *msk)
 {
 }
 
-void BPF_STRUCT_OPS(bpf_bkup_data_init, struct mptcp_sock *msk,
-		    struct mptcp_sched_data *data)
-{
-	mptcp_sched_data_set_contexts(msk, data);
-}
-
 int BPF_STRUCT_OPS(bpf_bkup_get_subflow, struct mptcp_sock *msk,
-		   const struct mptcp_sched_data *data)
+		   struct mptcp_sched_data *data)
 {
 	int nr = -1;
 
+	mptcp_sched_data_set_contexts(msk, data);
+
 	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
 		struct mptcp_subflow_context *subflow;
 
@@ -49,7 +45,6 @@ SEC(".struct_ops")
 struct mptcp_sched_ops bkup = {
 	.init		= (void *)mptcp_sched_bkup_init,
 	.release	= (void *)mptcp_sched_bkup_release,
-	.data_init	= (void *)bpf_bkup_data_init,
 	.get_subflow	= (void *)bpf_bkup_get_subflow,
 	.name		= "bpf_bkup",
 };
-- 
2.35.3

