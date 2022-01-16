Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF1A29CA
	for <mptcp@lists.linux.dev>; Sun, 16 Jan 2022 08:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642321146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cqdcw5kG+kgYV2hEAxVW33eGEydeKhvXo9AEVt54lPA=;
	b=JqHDRbMGrMk9SjkbYobhSyXwHUK8tZ35TNgnGbr7yrypQLeq2L+6nlW4Cxog5DtnBopTgK
	wz3A5n9+M6SZ3i75ZmBQer8U3GrFdjxUW/BuKAqoNc+GGk/lJdTFEmLht8kBufTl0vPy8x
	gi91zRkIogorEn4p8NM+AxEHvIjY97o=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2050.outbound.protection.outlook.com [104.47.10.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-E18eGiS4NtKQS4E22OEKqA-1; Sun, 16 Jan 2022 09:19:05 +0100
X-MC-Unique: E18eGiS4NtKQS4E22OEKqA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVr+bejvoHk8WIBw4A/cosyW+VD7qdWnLhcuj4HSoK28jSuOQ7/PBu3VNJZ3gOl14wRwfWoBRqlwKurpAqhufWNcI4U4+3tPDQOUmDLhjXMZNWqsp6kZQpsOrrD6TmdTaDyFd40DO4NU0EfNfrA3G9dwmY81sF2bhDPCKLyWPxEf5rnRRvQyb+fIv4b3mnVzQbYD1ZS6XyTVcdUSUbs1dHm2rrWy7uGhK56KPJeSy51PvPYlZc6TeDnTkHOE0PVKDTgvn1Yo6P5XIh4xBVfF0sOqxrTBYDQ771qLuJzk9+o2tIFA3rOb0vbShihoLoYfkYwQ/1lvsXcn1oysjTryJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvqZT1qqxUHkWSDfw+iQoNwAgbp2xEWqHc0Qca/Ln4I=;
 b=RYg/tmb/7tC2+futP52fK9FwJ6CgDGdLk0fwYCvtOEigL8k/tFHfKHe7Qgtax2xWeEYCbeGre/lwS3ULCwXZ73LfOhjVDMzq8bFFJrPglkXAIS0DKxAfSuQ8DN6SRCz7RtMguq7eTf5FNmWHUbP7zK/ka7qAzkmMDAZuP/aSNt7xnsV96Rv9andeHoQ/Zlewzz6GpUL4wVxUMdR/DL6uZDr1xdiQJev8uDHywnkO75xitqFuEdjj8a9Jb16duGkiQ7INL6RRo/JZWG/UbduEBPnQa/JbBtrP9bl8S7gVXSUP/4tKyExkOcPvhlO1QUJhIjEAkukZLp3+LkXlc9ppUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR04MB3047.eurprd04.prod.outlook.com (2603:10a6:6:a::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.12; Sun, 16 Jan 2022 08:19:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3837:57a2:45dc:e879]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3837:57a2:45dc:e879%3]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 08:19:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 10/10] selftests: mptcp: set ip_mptcp in command line
Date: Sun, 16 Jan 2022 16:17:40 +0800
Message-ID: <773f54907c8b2ced601abb57046f7a55800b417e.1642320655.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642320655.git.geliang.tang@suse.com>
References: <cover.1642320655.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0068.apcprd04.prod.outlook.com
 (2603:1096:202:15::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5fd6af9-0f3a-4c39-9df4-08d9d8c8dbf8
X-MS-TrafficTypeDiagnostic: DB6PR04MB3047:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR04MB30478A288462F568438605B3F8569@DB6PR04MB3047.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Mi2xaUi0YLdUS1Fc5oYV4Rz2zWd5eQ5XnOcVNPC6kYcbd0Noo3VJIhtmjlRKkihql+2B0Wc4U/IVm9EpHjf3d2BrLKEvKqtbyaNDND+Ff6IaoVF2tUdSPH7Lvdw7dCgnc6zhlD0bdA++zUOTWnQcgtUpoFrAnIRH6t1ClKu/vw+sq/qlqfrp//vXx3JbNXdUvFGqRPgdTfFF7UaqmIT4uyesGvkohw4uWoL8wu5csZL9RY70oAunU2ZXuULH/2SX8PFJNnXRngC9NbTA0oLMsZUroj5uyzhzlQNMMzLtO5Pk0NvR0lIKBF9HUmHeGBUBDn+cvrJ04HVaNEsj7DSy0SSufQ9gmVfoY2QCmaqlmI/86XeB9rlfKZl14ksI0ZnSyCs+ztWF3lgV2hERrKI06UWOyVexmVEGHunXyDqFXZ73//WBVqcijL7SJduYAIBGVjR7BEov8vef017f13s0VXr1Rr3lCujf6AHzUBE/gsZKPChmMfrloetbjZzQV1b16Ot1TIXmOzN/LURxhmK2CzW8MBRXVjwaoDvRHK26LJXy95sjp+fRRNWDJTp+61DG4zrmtbKxALa4+NkYqGXrA+Eyvr5coEd/WsXYtska78q9eebya85johl5561IXqZ65F5eeO19uOEp87aPJpSjZA5+LRIqpZ+ye0tlYosigtEW6WC/v+j3gUdGAbqrJFJl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(107886003)(4326008)(8936002)(6512007)(5660300002)(6506007)(83380400001)(86362001)(508600001)(6666004)(6916009)(44832011)(36756003)(8676002)(66556008)(186003)(66476007)(66946007)(6486002)(2906002)(38100700002)(316002)(2616005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dyo59PTKL7JvC2udMO/2zsd9a4KlQDSCHyEAZ+EZ0jA7Q3sqFyBHgAzp861t?=
 =?us-ascii?Q?/1qg5xjU4t9/Pq5GfK6S+jEvprp9ThrHLOJfASlBT6sTLR76EHzUQzcsMJFA?=
 =?us-ascii?Q?G6c6VRXfSajSCcrVlrUk6f4Lc1OWpenADqPfbHgVG6ZjsAGVZ0lvZp+Hdc3Z?=
 =?us-ascii?Q?qmGTG4MBYhuaH3cs/PSZjDom2Awjs4uPn3t87CDfqVMfS9BfmEI+1+XtINgm?=
 =?us-ascii?Q?McfG5vzvbwYeiWcL2lFz+QNiN1OiNAmqHuQs2W/JCChlxDv8lgexYn4REs5R?=
 =?us-ascii?Q?3+ShobmjUve/zS+GyR/uRW02qBqMTW/YQemMKZRQXkcasQ8OGFPNhDF4nkAX?=
 =?us-ascii?Q?51BPxXnVz61lb7vnhyBvyRQ0FS8t6rX3Hkr6xQqvuC1PTucJcZHAfaC07iGx?=
 =?us-ascii?Q?lOgxGkkh/3882OtLxOBY1PXKquBVBBUaRfUKWVy2C6xjcfRievATMVMFFn9f?=
 =?us-ascii?Q?OcdRxAxgr2vV44n1qbPjylTbBWb1dYC6AASTdLTu0oxu4eO48v/aIy0rtwNg?=
 =?us-ascii?Q?5Et+avwMVOrr1P3pDC6IIhXTlza1fNmBzNTRWA48YJw+RsH2dYGK7TNbKHSJ?=
 =?us-ascii?Q?imzk+0NvcaQjRCTiuMF6Urf3orCI65ycqbjlvXhFngGDZxHzDTL9YqwdcnDx?=
 =?us-ascii?Q?nOXFzj1/7dNparicTLUVmeUPI+CgCOZgHl8xcf517Qh2P2ff/3w0M/PRruKG?=
 =?us-ascii?Q?nA/fy7XMbQIH+IxDdFwATw1yPzIPlNTdDXFzU+Ie6RqO/4zooDNxjqS1jzVI?=
 =?us-ascii?Q?SoRYaJ7n4oGz+QHD9ffQwfg9ishLWy2rbytr0PLDxjA2JCXL2Vg28Fg0dCDW?=
 =?us-ascii?Q?2TR1QU8cTAy9smWrE0u/OwpI70Gq5euqpwBjBzPhNM+fBk9aQFU1YrI7sxqN?=
 =?us-ascii?Q?WJTBTGJCiytRC4aNtxioG9KKByOKsR4TWxsq6JvyxFts/WfRAnTzkG6lSwFK?=
 =?us-ascii?Q?+ZMMrVpsFnI2i/+6VJlENEP4hNJRtmTa+m8WaGUtjXFhoFzB6Rub+YNJ/9gB?=
 =?us-ascii?Q?yyvN5viSGnTUTFaKBBP5lbN2MoqRO7LQCCT2bI0G2DLDST9CD2vYo1IbIPm5?=
 =?us-ascii?Q?p5tZzX7XbPDTfUL9vRg1m8tX4nvxl7OK+Ssuf1GWbvuBDrlYHKo+/K+hXDMq?=
 =?us-ascii?Q?bXOR6tbUdEWcI0uC4jxsz5TJUfft9thbpQ3ra6nzKcggcMTJjyf55cTBuRtr?=
 =?us-ascii?Q?NAGTjl90/1yEHq3nTliTn9PtZVzqLsW3Q1O6TVqyutQsl5FUqdgV/s1BhBm6?=
 =?us-ascii?Q?nXZjvIAQZc684PlhHyAYGSRW7xRyVF94fjULahIun4fTOTr8hQPRWtC+cwlI?=
 =?us-ascii?Q?4GKAIak/TPEuyLvsxRKVv4MKAte5Rhpu4L5TJD3rkB3f0i6Ps+12k95N8zcp?=
 =?us-ascii?Q?0Q9dEMlacRlL0bBlECNgXqLYlo3eAKIwLm9xdW6KNri2DRbAgvrMBGI3jMkY?=
 =?us-ascii?Q?x+SfbTyzX/P+FwqG0E9aCoaCH+EXtVfI2NNXP4Xzf/BNXcc0SIbT+c/6nGG8?=
 =?us-ascii?Q?oLb1T7m6nCTV/UDmeLceWwu2IW0KxcwAfPcsmbaHd9d5QwqW4ssTXWYVE5um?=
 =?us-ascii?Q?QW5C1soz6xB/n93erBg0jKPQqnL7cts4dV7z9YXXNMg9br4TeGzaZHCNi6mu?=
 =?us-ascii?Q?0UH5iPGGJ9FpPCr/6KFIrPk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5fd6af9-0f3a-4c39-9df4-08d9d8c8dbf8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 08:19:04.8166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FzQZZBayt5upjxEyrXwUwsOWRSs8X/dM/Lja3zoYY2cqzg5+saValL9epIXiOUyPPAuI0FKOBswGSLCEjMYFWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3047

This patch added a command line option '-i' for mptcp_join.sh to use
'ip mptcp' commands instead of using 'pm_nl_ctl' commands to deal with
PM netlink.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 681a72bbca9d..51c0cbd82026 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2222,6 +2222,7 @@ usage()
 	echo "  -u userspace_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
+	echo "  -i use ip mptcp"
 	echo "  -h help"
 }
=20
@@ -2243,9 +2244,12 @@ for arg in "$@"; do
 	if [[ "${arg}" =3D~ ^"-"[0-9a-zA-Z]*"C"[0-9a-zA-Z]*$ ]]; then
 		checksum=3D1
 	fi
+	if [[ "${arg}" =3D~ ^"-"[0-9a-zA-Z]*"i"[0-9a-zA-Z]*$ ]]; then
+		ip_mptcp=3D1
+	fi
=20
-	# exception for the capture/checksum options, the rest means: a part of t=
he tests
-	if [ "${arg}" !=3D "-c" ] && [ "${arg}" !=3D "-C" ]; then
+	# exception for the capture/checksum/ip_mptcp options, the rest means: a =
part of the tests
+	if [ "${arg}" !=3D "-c" ] && [ "${arg}" !=3D "-C" ] && [ "${arg}" !=3D "-=
i" ]; then
 		do_all_tests=3D0
 	fi
 done
@@ -2255,7 +2259,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
=20
-while getopts 'fesltra64bpkdmuchCS' opt; do
+while getopts 'fesltra64bpkdmuchCSi' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -2309,6 +2313,8 @@ while getopts 'fesltra64bpkdmuchCS' opt; do
 			;;
 		C)
 			;;
+		i)
+			;;
 		h | *)
 			usage
 			;;
--=20
2.31.1

