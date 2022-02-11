Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226017D
	for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 09:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644573201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sVkMdiHkZzAxwJ24B1qJM4rVr73teD4T5rL7mkEO0Vw=;
	b=lgE6hlDzFo/N98TOa/BsvHTsM68Z8Ng7va0izr8KiEc+s4XzumOE9KZDDdjrd8oS7bFXq1
	DtWr6O01BOwqwg7SN+41gQNcMe/lt4v4RbBoAOgJKqsrR3/9iUQfmiTjuqi4u7g8AqN/9i
	Q/J4BIfuYOv5lfOCkLB+jkbQEtx7boI=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2113.outbound.protection.outlook.com [104.47.17.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-23-2_GTDiW2PAiJebvdFt9v2w-1; Fri, 11 Feb 2022 10:53:19 +0100
X-MC-Unique: 2_GTDiW2PAiJebvdFt9v2w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8/9trDqIiGo1au1sbOnXZgKsWp+Bt2gDk2kK1j4tuvhQoS0Rw0NkyyCQRW/EuGYne/8yXQiuNltjRj31evigaxh+eVLY/M+kWyRTs5ssCk5WpzYWelx02HE5F/PcWGjRBO1JNKhICQs60N0o1m9pPtYsX9oNh8YGLIy+xgCUgzfNGC0ncRRNlHRKrhu6atbT9gs07gpqGtnj9d/ra58K9uEdyCLtkvOy+ljTWUzkm0UcqWtsw+RN91QYL1+hqg8/1d+B50ocDQPpBMHuylpVJURLsJH1ZlO0IBYMQRe43hexX7cbr3paDoKjVp3CMd8UHRu+zir2AmmOLpCqyFtFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HK+Ngn5Ubz6cDBVLdz/zLR9zSbY70dWaIMwNoPlRBqY=;
 b=C5lMepmOPaF9vekKdxm6pZhVQM4a9AytWynMRQN39TFFjxfKaIeB42IN6GfBepNm65eNrezCYKvHGgtL/mdL5hFM+OhQjBPJn3DjfPgTVHkHx1c67KP2+vrK/vXYhevnVvVntF2jsvAL01RvNyq82YJtX4TB7Sz2BErHzCPJdFEcp2rFaktmp3eaQm+ZOkbQ5cFRogPYEhfDtEBp+t/vjlaPgXbmbW+m0n1I5FXRqTGUbAxffzXQ69Kxx9M49yHGC53UrY0eWys/U1bCPJJ+R0KdehdVIKRRmphFVMo8dhcnyDLPuZojHOEQvDbZaBkOu6ONjFlcfYTGmfIVZZ6iHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7878.eurprd04.prod.outlook.com (2603:10a6:20b:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Fri, 11 Feb
 2022 09:53:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 09:53:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 4/7] selftests: mptcp: add the MP_RST mibs check
Date: Fri, 11 Feb 2022 17:53:02 +0800
Message-ID: <728ca52e45b1b11236f58e5936cfda27164c106e.1644572307.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644572307.git.geliang.tang@suse.com>
References: <cover.1644572307.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0052.apcprd03.prod.outlook.com
 (2603:1096:202:17::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb851aa2-5544-4b38-4604-08d9ed44547b
X-MS-TrafficTypeDiagnostic: AS8PR04MB7878:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB787826EF59546C7C78AEB581F8309@AS8PR04MB7878.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3KNHruZpg3AS3A03T6gFoSQKkkGT+rvodB0N4uwehN0KDkkyRpX+zBok2jZgu1ra66ouNdNXRI150dZQ2IaR3sojiLodgZscWCe5ntTg5YNTxNI5Wzf8HO83U2F/NDl2B4Dnqa6CoBUIFA7mGqsxrS6iCsp1HTzLiwPnNgANrZZ/naDByUTmzOQ2D3v0HJFStLHWsDQmJmjxQaXDKa/WrviMsd5qDMHwWkuOVH9o65WxOyihvf4PHa5PK0cIBXsxDw0X2UsrD1woy4dlQYJgA/HFyyfMkI3zrZ821qN2UK5IbZHAP+StkmygaBTLLnusUO8rMbTTOF1MsdzhyEoC6Yqyg1r89GlXhv351GvsAUiR/rfgfNhbRNuUmFX2jTEmy4xbNedZK0jND3dpPB/SpslO5rEABG4Xqco4hfBzlnRUQDzsGAiLeGrqK0mUvUsxmhyk5UAXBN3cKyHgVDZG3EGRkQ08+0PQTNFAhdOyVj5rZhI4reGhhH2Z5T3RDRSWH92D2fusoGptLVYsQWdbXxN7QWe6mmtXGNsyrbnsBvT8tXg0rYBeMOVxcXXcZ3U7NbcAfzm4QH4qiJvuVTdl+p7XI5p0dr1hq4PBtRJlphbnzuk007YvmTvTJ7zOJJ2Lgk2CfbYEl2RoolL88XYZEw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(44832011)(66476007)(66946007)(6916009)(508600001)(38100700002)(8936002)(66556008)(6486002)(4326008)(6506007)(36756003)(6512007)(2906002)(55236004)(6666004)(86362001)(107886003)(5660300002)(8676002)(26005)(2616005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RuyPcLAi040LA3sH9psJocf5iDEOKWMqpLbBPdUJ1Bw24y9WuXYph4pvqgXs?=
 =?us-ascii?Q?2ok7RnCpGSM1Nj3qv21rdZ8SDtqcsCQWG0FjtYZhdtdHAOqlcD7n/GDvhbul?=
 =?us-ascii?Q?X+hqEtT0yXYvDX5KWb66Ktmh5ZVkISJSdHhChUxr6cLAvAPnxXtV+o6vgED1?=
 =?us-ascii?Q?Xfh1TDUdRa2Q6xGDIe0NsB+0pGhXNd8VN8+3uwEjo5iRkMkcMIPHwz/+gTzx?=
 =?us-ascii?Q?6NLSGfb//KRQyUS2urI/sVC2uevkRCDuN0OMXYwrOohUeQu++9yZIYZWg199?=
 =?us-ascii?Q?ZOUEl0+jXrrnHD/2qKHWYXROFh4X6T1/yTfYjjQfhEXEIt+QLfVNQB70eBut?=
 =?us-ascii?Q?v4yb+w6l9H3ofBflbgCsoEe+8PxaKHn2m8rCztEIJaDi9uPSRgyov6yqXmfp?=
 =?us-ascii?Q?j/axKjmMgRt6Re3YTU5nADr+NgCyJyxcXW453vn/BOcXGg7HUwBfcQvBLVJc?=
 =?us-ascii?Q?yryb9da/Za5skUwoxeUEyptjvnSkmlSl7aQwSjI9IJS3gljKfnDhIs0XkLkQ?=
 =?us-ascii?Q?UkWqJ/vP35FjFnme1PZzhBDMQt0U91i5RVCosVNkM3O4XiPqF5DfRIrtIaAX?=
 =?us-ascii?Q?A1TFbwW0bFbSL4OXdVTAdcoEFrc3CBV6L56BPCjkYwcB0yZajAxJ6TtavMpq?=
 =?us-ascii?Q?hKjfMFZRfCi7Za6cNXTMmkETg6ES09QKUmi02FwaOuZPZ4u4a87KYW8Zdd6D?=
 =?us-ascii?Q?J8NviDMO41TzQR0rlNNA2pdAFMnR5acg+7TjTT95I/D6268nuZKjuz50J8GF?=
 =?us-ascii?Q?Zv0pdvttUEbwB3Ek8yF66mZw72xG6QXS+BpW6dbopwkogxOYy1j+LqYsC6uY?=
 =?us-ascii?Q?NUm3Ltn89KxMZ9VhSzeurq/49T2zrkaJVIftSdKBnPmRH17yXRbXJp0faX4C?=
 =?us-ascii?Q?cUnWJPRSkl0wHGGh5zYRDKjDzxUxrkJXtHlSYgFF+NS+S09qdE4kSnnj9IoH?=
 =?us-ascii?Q?6QkXKcOD/Wod0CN4ahX8guJNLIl/bK5YccOs6/L5Ch6VSyDvNPY+Ni8OGSr/?=
 =?us-ascii?Q?yxzukwGB9TkY+F3QW9dKqxVvoMJElM01p7kjgdfsTZPUREXNNYPI5xjtiv0H?=
 =?us-ascii?Q?/FQMAVDY6E4YLsrpSasG4s2Yz4vjmr7pZr6wkv+VMdHnzVnDqbcMXrhwzkdW?=
 =?us-ascii?Q?clvSPQffAZi18wBmKtnUSBKA4+JLNxxyA8TZjgm1iDlZXcdFrlLNo9WEuwMa?=
 =?us-ascii?Q?lA791HCmGksX59oso0Cd9ryj4XQMvZ1BA2gEeP0ciJ3lo1WSiM30y3I6fhnd?=
 =?us-ascii?Q?v2wjjGjknXt10nQQ4K/LHzw5u5PmdTMoFwBdqtXxpiqbAVAQSU/ahvHCDsrl?=
 =?us-ascii?Q?ShdvXjANLDKqKJjAIf+5tmeMVHq6yzRuQysGZtVsBmXBQ1yYy5F9l/1/JjmV?=
 =?us-ascii?Q?gKLtjNU5CvYA36AgEyx+oOz4ljMvn2AcG/MvjFEt6Yf949BZIAdzI6Lgi1bP?=
 =?us-ascii?Q?q58YGkwm51g8NMw5AhsFN4LaAoQ6o2b3SkRizkuZolmdHAvrLTPJ3ws+C1nr?=
 =?us-ascii?Q?wCKieI+XyqAgj8mhYIv9hnJoJ7CEhWKPtuVOoQp9RliQZ3evEvLlbqTcUf0m?=
 =?us-ascii?Q?T/3J04+NHXNI5FUoLOnDccO+mUGBJJyy1I6U0QQFIGIFtdE4gMK2bRxRioBV?=
 =?us-ascii?Q?AvICO6DrTtZrl/rv7VaMTj8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb851aa2-5544-4b38-4604-08d9ed44547b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 09:53:18.1497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f3gnmYgfmxAC7/CsZnD8lLfBNTJwYP0XGOZmkqMJmpsfG+hOjxQwMzk2i+HVMdqJx7aH+4AwGpdMoiAIqCXvrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7878

This patch added a function chk_rst_nr() to check the numbers of the
MP_RST mibs for sending and receiving.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 9b75569e423a..7537f4fe8078 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -782,6 +782,38 @@ chk_fail_nr()
 	[ "${dump_stats}" =3D 1 ] && dump_stats
 }
=20
+chk_rst_nr()
+{
+	local rst_tx=3D$1
+	local rst_rx=3D$2
+	local count
+	local dump_stats
+
+	printf "%-${nr_blank}s %s" " " "rtx"
+	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPRstTx | awk '{prin=
t $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$rst_tx" ]; then
+		echo "[fail] got $count MP_RST[s] TX expected $rst_tx"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	echo -n " - rstrx "
+	count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtMPRstRx | awk '{prin=
t $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$rst_rx" ]; then
+		echo "[fail] got $count MP_RST[s] RX expected $rst_rx"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo "[ ok ]"
+	fi
+
+	[ "${dump_stats}" =3D 1 ] && dump_stats
+}
+
 chk_infi_nr()
 {
 	local infi_tx=3D$1
@@ -868,6 +900,7 @@ chk_join_nr()
 	if [ $checksum -eq 1 ]; then
 		chk_csum_nr
 		chk_fail_nr 0 0
+		chk_rst_nr 0 0
 		chk_infi_nr 0 0
 	fi
 }
--=20
2.34.1

