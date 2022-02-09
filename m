Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B681A2C9C
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 10:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644403392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p1cnhmfvOg1lGapreID3J2bgUAhluk3TVZnCBFXpbmQ=;
	b=gJp1U54n77lZ2M1Jt7jZuAFrEfCBrloIf6QV7Af/N+uDQzYKjJiny39G40MOW5mctFUiPf
	w8uuWPwJnt9l1CG+RGvDwa1495fwdcpfzfSs/euGccUQqOmp8M+bcleStIbwWA+3S6ILir
	1R83lL68FVtnuOQ1B09rR4Mp+kbO/Gw=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2107.outbound.protection.outlook.com [104.47.17.107]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-7-Xn5GzT6NMqyhpV5GoxdS6w-1; Wed, 09 Feb 2022 11:43:10 +0100
X-MC-Unique: Xn5GzT6NMqyhpV5GoxdS6w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ya8t2BLPg4Byh+bChT7kq66TsEx9p/0UoFrT2VawWCx3GdXRbUq81Ri1Jh4Iv9lgAE8vtn5SmsRov7NhJGrcEAzOWAUhuDc2h2bt619se9jJauJgGN/t14pmImpSNS16c4JXvQl1b0TFXFTJcPl+h4mgLfLyImHGmMvIdDyTqXnIEXQKNvehAZhl7p0RcYScXe6o+h9Gopaqz6h830u9ggCwU1Uah9kkNeJtjAZa5CQW9BdkRUkT8qf6HCKqlNn7bWBsoLcKusOG5KEnpaY/EE6UUEw3Ve6BtltPX0tQYzB5Ilo2USlHY3Rx5VcESVaIzwJhAnW94+mNLqSwnbXcSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llTAtFlYKBFVPMj2ywwSufNYjArxy/q7XOS0f5KZK5o=;
 b=IM6gH26C5VSOYDJFSlaqaJFYPP2up7nSkn8dXKYrZ45MMxDmrXfpVNaBAJuPllz66pUop7F+QgxanDuJ8W+RzOhesLluzwbf7dNyEsd8WL9bciXvDyNCi+qs3BRbwhag0Nb60c+583DRZ7t0jPWZbkSKjuXMCOn0tSgNTtfOHruPSOuidYhyAj1C4HNQ1ya/Vc3RSdx5kfnaYIAExTXraqhUkvsJSmfKempzz4Rgiu4MOsFyTAUf/YiW/Oxso/k5O6TUhBM3xEY1C5E1qfHbE0WCOpruZh618VbHX4oLuG5z3WccjcBPhaG5a821YYUA5/0PrGK4T6JDVAEF9ePCsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB7389.eurprd04.prod.outlook.com (2603:10a6:800:1b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 10:43:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 10:43:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 2/5] Squash to "selftests: mptcp: add infinite map mibs check"
Date: Wed,  9 Feb 2022 18:43:10 +0800
Message-ID: <d133ed1ceac1bd9ba3b55c9b9601cb3d01b6d7bb.1644402973.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644402973.git.geliang.tang@suse.com>
References: <cover.1644402973.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0162.apcprd02.prod.outlook.com
 (2603:1096:201:1f::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3540a8c4-1e53-4aaa-196e-08d9ebb8f685
X-MS-TrafficTypeDiagnostic: VE1PR04MB7389:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR04MB73890596928EF6A51BB9BC21F82E9@VE1PR04MB7389.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:88;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b1SShCeCGEgXva4Ljizym7VZH8AYaSYK3AMu3UuWQdM+3sOXwnbUiioiT5syCwI5v5+jpQM8NdYk72XkL67ojW8lP/+P/7X9QTiuLi03fQqmagcCkY8XmRp8oS8kR6GcU/8QK/DcBsKJT2KDifX1dF2I3rIY0oXPBln6m5VDJXb1u4tU4UBqD3t0IvpEGwPwo8/aqsO8Wbh1b8NBLaUDGfZfoC2rWm/YJJ4T5cHIMLfRc2JJhluQchZvNZLbTdJVHHRPiH6Eb88khWIZFgP+XIAotT2WGlw8wGKpTGlyslcQLlTBCH3XNMV093Ez6nF9oknZZPIWlmldipWGYcfB9QTSGIwIQjaWROtPDUl8Ic5jIFSgx/N4535gH2UFAvvqcKQOrolJdIOtD+VAWdyPBwPvldqq74a9zUvyA3T09D4uFxumszXkxs6Sdnq6443I1T2LT1Re0gJ87g//2ANnZzaoTpCoDcPRYgUhE4unQMeL2kwdp3q+7orV9oGa/Flw1B5+ojx0/HBWZtgi0tXPif+F63p0+AampiGS7Q5dXsPbCbVRSSXDr13oW7jAWiNheddLoezLJvkIYzUoCURnYcbd55lKqNkcDf2L5EukiGXWdJSSTSGs3/gtcEG6r9lD4t3mBS6AdKC1OCvo3VPobw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(2616005)(36756003)(6512007)(316002)(107886003)(6506007)(55236004)(6486002)(6916009)(508600001)(6666004)(8676002)(83380400001)(66476007)(86362001)(66556008)(4326008)(186003)(66946007)(26005)(44832011)(2906002)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lCvytEMKZ0w0wijskWyi5yIiIpxe0lC6jVAeMTTuZBDP2LD9h8sn+Hxv1kfG?=
 =?us-ascii?Q?mkV40MQfyz7JZzvjwB5XnwnhQfL3bVqyg0GClx33BuN7P1UYQOYs+H3se8f5?=
 =?us-ascii?Q?NEb09gGOoqt7o5paySIhE9cdKF6FgAE0m5GuFF3QdQFLeGY02KCkJUtpzV0H?=
 =?us-ascii?Q?ss9W3EycHZdfltX95CP7Rq8sE+fJ4XvXY7S1pbWsoM6Aip/xTgTqOh12yF53?=
 =?us-ascii?Q?WujY7FE78Gpo01IHkcvr1YtqGXvgNHnUQwyDcyxUmy70v2VqTOYSWS/UR62q?=
 =?us-ascii?Q?ORU5k7TsmEIjhlYkI1llIZ/vYF0/BqZCRRFLeig/OTG1VSBh6BpdgT/jfmbv?=
 =?us-ascii?Q?U6k2DbQXroNI82aIABeWVy34iVfzVWuhNx76hcgLJGnJK8L86sDrlO6EaUSF?=
 =?us-ascii?Q?MS0CshvyIP5aBm0bfDp8ZvD7zdV3vssG3LZR5I7qK03DGvSCK30jq74nNENQ?=
 =?us-ascii?Q?usffwuLni49Xg8awjd2kIzZ5Z3ht/aGMEZy5HYS86Gbw7S1Z6DWCqgLlftqX?=
 =?us-ascii?Q?rAHElK+yFgEx114EYm8DGvuLH4PpwcodulQ66SGwlQEsStTUX3suO+HM8/iI?=
 =?us-ascii?Q?6fu5xSsXFYv5L2vDEj66CvcUyH7qTcMuMAZ3WSAmE8mvdkJJqI1dlS0iCO0l?=
 =?us-ascii?Q?Vuk1rznf2vbblyojuyrDmQ7LRcFJ8V+UDfZxlNgmDnz0Dsab5Wgsgk6XTft4?=
 =?us-ascii?Q?+uad3kwOFJJQC8gwNKgbj+mbjkVlpRSxZdnXp0eDlIT8qWG2sJDdmoxGHCSk?=
 =?us-ascii?Q?uT+6a0hB2iHkChBkXY8gDHiJzsRgdHM5JnCkmKBOPCDWmtdQ8oPM4eybzp52?=
 =?us-ascii?Q?tREK2jLUfZ0TwfS9Et9+VS1O2SFGBi6mS88uWC2WWCG0K1/nBPUiDaPQ4T3p?=
 =?us-ascii?Q?ulJpf1jhogXkQ/BiHUZHf0lZSEYArkRx486q4AIKGJMHeTSVcxGN+qG9I4l5?=
 =?us-ascii?Q?pPu2Cg7tnmNh0SyvzmBF8QlP6tGadW0ruTrqC1PsmQ1cKiITZAA5RQNogSZh?=
 =?us-ascii?Q?2MEtde2Kuussq56oQ/H5EejiKlutN0OzmN7y8Z6uMD0+1eo5Dwu8+znMH144?=
 =?us-ascii?Q?KOAIaTNg+9pSl3g2/U1Bkvc8C0G7rOvjuFeBrZEIs9c78QGF5JhmOxkApnRL?=
 =?us-ascii?Q?CZ6oOe17tKowC3iJhF9E5bO5Vqg05xjG3zCXvofPn9ly+R/mRdXk+wGOQXjY?=
 =?us-ascii?Q?S9A9nLtmoZ6EVx4Eb2seFDLcgNz0MOLZVicakvGY4M1gKS81E6cuu2jzRCoa?=
 =?us-ascii?Q?DyDhKx+1pQfVU/uwVhDv3OtswDKbb/6zCupFldDlHkHK9osJPXSYJejNFQjK?=
 =?us-ascii?Q?p17MbobXNDLPfzkmp4a2MD4jAxm30LIDzsgkFhBLXgSISeMzvS8wa0CS34EO?=
 =?us-ascii?Q?x8X3Oo74K66w9vChgSIXfgXPHH43HCQRBW2Ionne6HY1UGcMcDnv+P9ASBco?=
 =?us-ascii?Q?EwTI1OEDSoyMtx4n5TSnPgUmSXMUtrVNDh1aPYmofFsfA4PQ/CKDzLFCb5SQ?=
 =?us-ascii?Q?7FSBm07Tae4TR3Vj1HhF6cEDIBiCLi6pnV5Rcpd7CXAh/rLI0G5w3p2MvSwY?=
 =?us-ascii?Q?Q6697oOmyItimYHb9mnljO+e4FI8jYt8QQtJEupIZu5s4bIdXZZsaZA2ORcF?=
 =?us-ascii?Q?07pT2KTQGDzQwc4bbnUKUxQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3540a8c4-1e53-4aaa-196e-08d9ebb8f685
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 10:43:09.2844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4fYLU/he8NDIWCbqn27yNwMQCkHfIViYfMTco5m5TKKIH/VpJ44vV5hUudcxbto+o+FazbvST4dLQgWWPRR7fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7389

Rename mp_infi_nr_tx, mp_infi_nr_rx and irx.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 90a6adc36490..3577716cd5e6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -784,27 +784,27 @@ chk_fail_nr()
=20
 chk_infi_nr()
 {
-	local mp_infi_nr_tx=3D$1
-	local mp_infi_nr_rx=3D$2
+	local infi_tx=3D$1
+	local infi_rx=3D$2
 	local count
 	local dump_stats
=20
 	printf "%-${nr_blank}s %s" " " "itx"
 	count=3D`ip netns exec $ns2 nstat -as | grep InfiniteMapTx | awk '{print =
$2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D "$mp_infi_nr_tx" ]; then
-		echo "[fail] got $count infinite map[s] TX expected $mp_infi_nr_tx"
+	if [ "$count" !=3D "$infi_tx" ]; then
+		echo "[fail] got $count infinite map[s] TX expected $infi_tx"
 		ret=3D1
 		dump_stats=3D1
 	else
 		echo -n "[ ok ]"
 	fi
=20
-	echo -n " - irx   "
+	echo -n " - infirx"
 	count=3D`ip netns exec $ns1 nstat -as | grep InfiniteMapRx | awk '{print =
$2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D "$mp_infi_nr_rx" ]; then
-		echo "[fail] got $count infinite map[s] RX expected $mp_infi_nr_rx"
+	if [ "$count" !=3D "$infi_rx" ]; then
+		echo "[fail] got $count infinite map[s] RX expected $infi_rx"
 		ret=3D1
 		dump_stats=3D1
 	else
--=20
2.34.1

