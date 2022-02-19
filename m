Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2569D57D1
	for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 23:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645312704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xg8iYX89Q6jBiBgNZ3FkN/yYujeL/imJT30dF8F3UEI=;
	b=muy5LXkMBZ3H7o3AkvDjwJO2qGpw6zuoSweRjc7kUN5T9vnPZPDuqwhuuN1WXMHZwjBHyr
	w1/4pe1FMA7yRwAHdioojDI4U8WL5DYP1YBhuuv/6CSvD2/c7nHTPu6i/nL0zIsPzX8Md3
	umavi03Rgy/u/ioi/9LDwrdvrW0q//c=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-j_s-ADqsN_-CXqmwAefNNQ-1; Sun, 20 Feb 2022 00:18:23 +0100
X-MC-Unique: j_s-ADqsN_-CXqmwAefNNQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bnwvgq38DYTAy7D9tZiMmvq3PVapFQ7usVAv/AxY9rSHr5gFC/ncvKCmvLjYzb2z+w2KwU6W7u55bcE5wy88CgzdJ3pIZbwrEaI0Vro45YbpaQGDBvX+hvyTzxpWRiA2+yNCsrBkQt0CK/6Ity4eLpmWEP9CBmqHfLkeSzKQ6RA+0uPgLg2CXsevbsI22ce/thEUlHK7rAcnq3KnVxunow0DbKo83xUhU4q+IK2v0ZwUtUVKiZdYQmO2HMSOJKxUE3PnefOKZtyU5heSyD/GGvM5hfd8P/qEjKi1HLhKDtLSiEN5roQw4phzDbZ3vbbl1hujXAEdFCqinzpUrQlDbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acSjlODOFcS/ge2pCV+I/xtqJhuV3+6BwL7EZKsNwIA=;
 b=YlRyicEghrYTQHbirGylTGfAT07aiKoeP2vqQLqUh7O5mYdbRESpWBRXNzTlm1jzgEcv0l40wbWbRSmA29l6Zeo7mdjvixzoYzLa6+EzUWxMb8BWMxzJSU2kiV91kLqWF0V/faxwTa+5iiuZ2Rmbyw2S6HAMIDN/R5ccIEO3d5e/hT/rCnTE9JCPuuYtS0/y7k6MjCI7/E2TMGAxM4YvfLyVLfhB2pxwuRf/53Y3CKIO+jDNIskEboCNSVklTPFzNWjHFV9/nZ3m2YnDoK2ZFiYI3IktUXiMGXHJRdE47unBB7bss8WQ9/acDAbCQnfwWev/z+fK2h2LybgjrjHmRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB6841.eurprd04.prod.outlook.com (2603:10a6:10:116::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.25; Sat, 19 Feb
 2022 23:18:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sat, 19 Feb 2022
 23:18:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH RESEND mptcp-next 08/19] selftests: mptcp: add the infinite map mibs check
Date: Sun, 20 Feb 2022 07:17:52 +0800
Message-ID: <e376d665af7a71d106838a1fdb36a97acc249f89.1645311956.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645311956.git.geliang.tang@suse.com>
References: <cover.1645311956.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0018.apcprd03.prod.outlook.com
 (2603:1096:202::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e4e16b5-4929-4bae-cf96-08d9f3fe1efc
X-MS-TrafficTypeDiagnostic: DB8PR04MB6841:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB684185B84E7B0BE5490B0559F8389@DB8PR04MB6841.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rfD+H5JuWcX2PKOKQbNt+lqSjIQB8zN9/MLdRz7RwRneW6T+AHhkLMNv35kLwhm7D/12t86kzCWYztW2vnUdJ/aXybdaqT0+gUXZAEnhLaVZjuzEOFAHXJNdFC8UCxQeTcdK/EpVF8lHEzE7orLsYQpIyAESMuh6w5BY0IQWXuHP2frDqGvNQawPl46QFNvYOnZqGoy2WWgC55MSq+dvbv1PFEkd6h9UNTMfn6+iHKZw/+oCBqkWIamdDwZlvm35aTbhqW/aSRDykU60gAjifH11hioE+t/zBPTpGt6uFMxq5SGp/QjlxD+WnSkI//4Ui+ZD88bFCQ420Tyh4y2nzdAoWIbtFECDG5UpSOGFbhoJpwn3OPa7VxFSKuHiTvARdpjJxQoj0EJrF29//X7QLTdZOTcRpyNNWnBKLpq3W5j2vCwwW1gesrBho2xHtMOJytCdMqaVCDhOgaWUuHbE+WLvakP4AZQyXaqmLgc/bJx3w2M96GZl6EcNKbnABnXzjKw2pl/MWKeZwrMcoC826mtX+e78fRk0OgmYaiqdI7RG4walkzcksR5KGy3Hxe0vG6oK04QaQR4kW/qbNM6ZB+EkTnyxAOUAw8WIqd8eUeEjDpfx3r1rNcag4sG24h3UDNAaCKCv+HGi/6lyHmrt5g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(6512007)(54906003)(6916009)(38100700002)(8936002)(86362001)(2616005)(36756003)(6506007)(2906002)(508600001)(5660300002)(6666004)(66946007)(316002)(44832011)(6486002)(4326008)(66556008)(66476007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gj8uucOrSsd0NP1AxYjvSHaDJszMwyaUJ3uwJ3IXxW3ZUweUrtD5QueYuSZf?=
 =?us-ascii?Q?DRR01e+wU+x0C2xdbl9rJZ5xv8wzlkcpITHWc4SJ+k3QhJzYU5pUm2u2DFwo?=
 =?us-ascii?Q?odGQcbW+7yiJEKj0VSGB55hcFlqEJRVf0f+eNKEMzfDdLSZLZBRMaKOTkoMi?=
 =?us-ascii?Q?BZprlD15+Oprv7Sqx9YXNrC1LfRYU5aSU07MF9kvpP2sugCJT6L67SYlwDql?=
 =?us-ascii?Q?kieutn7he0pNya7YqYysdO008K9qB/MPbUKm7a3QJVHVjLPVHNfOyX93eKWn?=
 =?us-ascii?Q?MaOCC6boXeaKsF3jLO0ClNRV1sb+5l62kmG9+EiG+RVG9fVeFCGZrbtytW3Q?=
 =?us-ascii?Q?JhtSbMUpAGm4cmrODuNm+AcR1Zupa7TOUmxldc180uR5buW5b/3HCO5VM3fL?=
 =?us-ascii?Q?dekV7FG4qIk3ovvmDfWX1tHGqGs+JhjcT8wbEeq13Uhc9+ga3FiXQBWCo7Ij?=
 =?us-ascii?Q?aJHcUiCvboCOtyYvBIITU86LE6IzQf5rZ0s7F7wYgsjrdFAqXAu+40HggNsp?=
 =?us-ascii?Q?RRcm4NMOHxlo6sQcOHm5trgjj83jikmPXf5db+2mgeJZz05aWjdTE4F363rq?=
 =?us-ascii?Q?VOvtcuOdHvYEZRZZFGklLr1Gd5IgW5QTfYYa+K3R7k/3kIpwnATuM8nUWblN?=
 =?us-ascii?Q?Vy60m2nHycSDiun172VgxqyZvBlmJdxCHNkaC4C46GUsMzvsExufpCm07UXs?=
 =?us-ascii?Q?d2jY9KZaNFAoMpy5nhVW53D0Pd/psCG9DQBMTh0H8rsRfvRLPrSr+kIG9GTQ?=
 =?us-ascii?Q?Awv1yqd9kWj2zz4U5M+xlS4un/bq2hpEj7Dba8admGQgT1HJTNcoMutM4N5g?=
 =?us-ascii?Q?GsT9wqa0Wx4nWrUlScwmFiH5OPJrsNH4PZ3JNNZtfy5il0t9QLT3oA7eODYV?=
 =?us-ascii?Q?bUUsHxzkcWNGpXhZc8WvrJx879DjzG3ZrrE7F7ryS/hfFNU9JNG1NaSg23uG?=
 =?us-ascii?Q?PscK7vNCEeHpWVLt80Ueva46GQpDbyIb6mvzzk7RiYGIaMKA9DGZur4JhvxQ?=
 =?us-ascii?Q?kHj55/NWIWUGwohL1/biWkMAdolevA5KLCzs/an1iwJ21yINavH2gXukfGLL?=
 =?us-ascii?Q?jksbMi2yaDTJYq49NALFm/7MueFZJhJvgdwj7HdSCFxT10iGajPl2bDx1yJV?=
 =?us-ascii?Q?2BjfnFaksdht3otF81/rswvq3xO0NMdBaXfWlo5AphQykw7TerYrxJiU1Rrv?=
 =?us-ascii?Q?hFP/GGk07nNDY4PmxdI4aCFowJKjn6814x4FvPCNIIH7Pp7xyvT4+AuqKVqk?=
 =?us-ascii?Q?Dr3RiOuoQPqmZ8MOrNdE+ZxSiH7OiVImTxuy1WpU/WM157CiFQ+oYBWfdQ7Z?=
 =?us-ascii?Q?xesIKYmB7ouVMciBdsecNyixmF0IwE9y1EIwIRlQhBkWCehTBg0M6m+UfdkN?=
 =?us-ascii?Q?/+9j28zP49X9Qzz1qgz4I328F43AChvwF3h6EvlxNvhpX0xruUXMNoj41Q+u?=
 =?us-ascii?Q?7xP+nejTkkbEBXUjRe52IxfICaW5hc7CM49U+qdlQXj/O1tNT5BsSPe/vN1t?=
 =?us-ascii?Q?QaNaTi0J88c9LEXTIZImxw9rArK0QnNo4qt4Mdj4g7YNcFb54gyN3dhC/ej+?=
 =?us-ascii?Q?pGEym3n3Ul7KJFfD6RkjB99/uW+2xSTEYp5oxtctSWEOlL9bwmWC13uip5OP?=
 =?us-ascii?Q?AupsdAR0m9qk3qfbfiR3+lZ+0ttNQjzVau6r4rct11oHnpsNRp2gpa4fvVA/?=
 =?us-ascii?Q?1K+B5O5RQQbX9SJuOH1Kvjuq3Mc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4e16b5-4929-4bae-cf96-08d9f3fe1efc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2022 23:18:21.9731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHes6aD6FrFLvbtjDlvRM9GZGiU8nnaYvBykVi0SkGvCgjSiDeU471TNN9Kt5u20grX3nVTG6eUK0IA+0NV8VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6841

This patch added a function chk_infi_nr() to check the mibs for the
infinite mapping.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index f0f4ff897e60..67910a3645c7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -863,6 +863,38 @@ chk_fail_nr()
 	[ "${dump_stats}" =3D 1 ] && dump_stats
 }
=20
+chk_infi_nr()
+{
+	local infi_tx=3D$1
+	local infi_rx=3D$2
+	local count
+	local dump_stats
+
+	printf "%-${nr_blank}s %s" " " "itx"
+	count=3D`ip netns exec $ns2 nstat -as | grep InfiniteMapTx | awk '{print =
$2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$infi_tx" ]; then
+		echo "[fail] got $count infinite map[s] TX expected $infi_tx"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	echo -n " - infirx"
+	count=3D`ip netns exec $ns1 nstat -as | grep InfiniteMapRx | awk '{print =
$2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$infi_rx" ]; then
+		echo "[fail] got $count infinite map[s] RX expected $infi_rx"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo "[ ok ]"
+	fi
+
+	[ "${dump_stats}" =3D 1 ] && dump_stats
+}
+
 chk_join_nr()
 {
 	local msg=3D"$1"
@@ -917,6 +949,7 @@ chk_join_nr()
 	if [ $checksum -eq 1 ]; then
 		chk_csum_nr
 		chk_fail_nr 0 0
+		chk_infi_nr 0 0
 	fi
 }
=20
--=20
2.34.1

