Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7472F26
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 21:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644530235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xXKiSYx1Jts3qlpJpLr4UXG4vMy2wsX93y9g2R3CHTY=;
	b=CbutJxD0CqYA0gxrb5KItwIubCx7qkajMSyQeTu0gPnd1KQXbRxwtt8Ho4vjquQC9fL5kI
	TTjFod2etZ797CtU6LIKx2d7X5TFVz9ZdeJ92Ohszo2QG/FvbH9eJtTvtbLKjGuvlJXqBx
	WpLwie6wdyrQyIW310NHWo2mLquodhs=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2057.outbound.protection.outlook.com [104.47.0.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-gnlsz7__ObGHW94iWcnbTA-1; Thu, 10 Feb 2022 22:57:14 +0100
X-MC-Unique: gnlsz7__ObGHW94iWcnbTA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWWZ8SfqzIc5jX0/UIx7VLZyLz4IwpZ+lXB4o3Nj0DdHt/nl3N8w+GC6hn9X+3xXBp4baEkyFz3fc3rZsCLPoRI28ShqWQ5NvrRVqcDwhCI5g/ey/bSuRsCmc6pbZbvBMiwdtTUBL1GcMOmoB0brf/Qg+x6Yg5/BMBKNJDLk5qysC8DmMX8pFu7Qavum0oFIpeXPp1x/cjloPb4RENXT/NAHqbiBHC+IBSB6nZSHkPDf8Cnfkblo2Uv55PsspeeO9cn7/KuCbaXjn4LeT6J1QAmn11oiVcPJAMgnYMn+TXA57dqHPF2UsOWYgXUNK0EU1owc2c+Yc1vyQtl9rfUJLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zN7emGceJ406ICyUHb8J8rL8+uT4fsLZPqYHYrYUfaA=;
 b=MX9wtGDAjV3dn1csGJTrSnlgEzClN5hIf2cM1QmovVx994eiZwertnLZQj0sdVAIDJLWZ41QiWGcjMBBCATYAjO+nViI4dOx8WTcu5ln1l8Qrbb+Hr/g1QUub9B3IsFkmomCj6bIm3fbSZTrbGJysjUa3ld3z5irpv8haF5jK6dwtfJmgytrAewwMwKkjc/fe7LKiHiiBG+H6PCcj1e7+EWnUmTL5wkz5NCL+hD6W5GkRfEg9164G8lRou3/XSRXFf71KxlcGye6rWfZoyqWXKRa4cYN8gE8QSzW4EwlivCn8GbeH4Bg0gaPh221h5U01Z6eQjIKDb0x7koJ162pzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DBBPR04MB6153.eurprd04.prod.outlook.com (2603:10a6:10:d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Thu, 10 Feb
 2022 21:57:11 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b823:3668:e8d8:beb]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b823:3668:e8d8:beb%3]) with mapi id 15.20.4975.014; Thu, 10 Feb 2022
 21:57:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2] Squash to "selftests: mptcp: add the MP_FAIL testcases v6"
Date: Fri, 11 Feb 2022 05:57:36 +0800
Message-ID: <8c97b0e89a9af0429eed517ed7b08b13602f3814.1644530148.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::19) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99fd4fe9-1f78-4c5a-824d-08d9ece04a13
X-MS-TrafficTypeDiagnostic: DBBPR04MB6153:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB6153E87E6D6A52B679EDEC27F82F9@DBBPR04MB6153.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/rVJQ54BmBbhaGHsbZZsTme3iXrE7ay3aIBnFsAEHhe2q1rOICaQMlK9FaKTWGdhDO9LoltQxj470wU3qJTjm4Y9/6LE2V/qeKsXtNZEdNylrscAim3mYZcJ4xo3pU0j5f/qeqx0YP3zg4sqJIcsdLfB/fGFy7oDQAQ0ovD8yuamhAqBKn6zgdfPus3VnBUyNLfvm4fuRy0ojFPfFalXM9G2n4MI6ACf9bwhGFB3aum8fpgq6xmD9WR8huhDXqS9s2z4mCHpqh5tpA6GmBoRsIj7aF8IoIwije8CjSlg0gDVcw2oM3bmmY9f6Tdx6PLG2JPd0F1RBmnxIkH4AQuqnx/b0dPopjP0aeJsDrE0wglqmoz8D6wM2uCJZAlMPMyXvqypJE3JlTQMvZrY7HGfOvOGu/EQHsYDWFilTveFmnm+bMz/Snm7BGOon0UFVrDdXmEzO3J/ZtOHFlb5QZPfWl24q3rII2FPiDQlEZyg5KPmmq5AdNsgXkLzvcDPRb2VA3Nl5GshyGc4f79+7Ivq/N2jGSB0vKgR0fccMng+azBg/sAZEHXgfqacTwrTt02Tw75pOUi/9wWNjpihxNBitK1s7ED0qrrmsw/XfSWWaReIda4tOyIUIa/SQIPAgMotu+gUxg0+J0Ju3vLqGaFEMg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(2616005)(6666004)(44832011)(186003)(6512007)(4326008)(83380400001)(6506007)(8936002)(8676002)(2906002)(38100700002)(107886003)(36756003)(6486002)(508600001)(66946007)(86362001)(6916009)(316002)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vMm9wXzaHvumVzZJEcNp79adL4wF4fc7/VP6K3rZcB5+gxKgaKIoz7BQfxGn?=
 =?us-ascii?Q?LyhWl7YjovwF9g0rZ8MysjiiusfQpSWBmQWpfyNOxXCVo8nQgXjICsAN7X1l?=
 =?us-ascii?Q?t158oEtGntzM8/wy0su8jYCy0kbYZRr0EHfc7jLSpVsZ0NcXHuGgarBbbsA2?=
 =?us-ascii?Q?f0ZuEcpcrDNUfTJpMaoQYyNn8nBe9ZtnEKvgXf8yUTP7/k/aOwuDi/IwkPU+?=
 =?us-ascii?Q?PS/jmKRf+X+8DE4Q59Rz6aLebn6SuiaZ96abtjLuaPUKP1jTkURx1OUYz8eU?=
 =?us-ascii?Q?Jiny42tjoi/U09bUhPmX99ROW9Bk3B2GujPGW9XrjYQIo0z6EW861zlUbLEG?=
 =?us-ascii?Q?K898KUWH40qfEoYxXGwLmVn4pAdW3qsGIGdZPUitpbgbOALHiNKHYryM3jV5?=
 =?us-ascii?Q?Mch7paA8VGTbwWE3e5ucWGrOJI1NhVxLFMwLMo+tju3Ga6PtFAiQe+7BNbS8?=
 =?us-ascii?Q?GID5kzWb4Z5WV0Hpb6ITo37fBRitfq7KRqOWfOk4qVRjg2ITs1Ik0ewng7qK?=
 =?us-ascii?Q?VzBUbSnO5FIXepOA50oZdzdrGbJHdr4PmikOcD7YAGUJG9hFnEYaexl8PD51?=
 =?us-ascii?Q?tK47aAmvfAC1/s7GLBOV6TSYuCvvFpiRmVFT1knBZKMuCmEjDcCTqgrUw+xA?=
 =?us-ascii?Q?jNFCtmTcVH2Q43fn81kBEeO2oLAv41wFMb3ujuCj4MhV/pjEfdPZp0riJsY0?=
 =?us-ascii?Q?jkQa6jpTaCUBjtjB7AWV/lbY8ZAzFY9sD6obTXX3tKXzQJVzsxHkid7SMVSo?=
 =?us-ascii?Q?+4bIGiRfPnJj14NAmM9GTqgUW+CVE4MiXUs2lp4SByXk2rGbKtcVFmUmHVAT?=
 =?us-ascii?Q?lTidlwZeP8lUNZnAjj4ONgQqiXTiJAAQVH1M3csxXQ4OC45/tArOfFWYqBKE?=
 =?us-ascii?Q?IAABHlxPARPM3jEqAKPceUK3b17tSB7stF4F6YTWhE1zKuaQHTbkJVOq6BSn?=
 =?us-ascii?Q?6lpaiTb5PPHYC8SXynDjM0qVFO5kR5cOJ8Hrw2JIxyC3PnLPEDnkkNam+BM7?=
 =?us-ascii?Q?vhUfLBzsYykTwWklEXNvpH0EfmW/Or/ZZxqZBa0KwoeC9y5OjCRncOj66fI/?=
 =?us-ascii?Q?Ks+Qs7PAIAAKz5AJKcU/QyyKQTe/Kpnmj6eKLlgAXqpM4Znq6nro8mNJ7evR?=
 =?us-ascii?Q?04Ivs+rETFoRiDfts1NjUO4E62LngwuNfQq5m4bXt7HhlFISILE8mt8a/cyj?=
 =?us-ascii?Q?fi541Rpt3bAFCiuAgUbiIy3tBkxOeeBiXcjAw/fcXdX9SnCz7ZU4pnwGKFR/?=
 =?us-ascii?Q?e2RqHmqqWSbmOerkF9saLedwTR8iat9xQE2w2yEV9xHa2i7aW74IKg4aiQ6E?=
 =?us-ascii?Q?Sh26SeeNgLX7+hQ+5wBEVPgfRqB/RRTM4HdLfJG1mLI68SQySbvPq4peM6Vw?=
 =?us-ascii?Q?QI343kcMeswjDSFMqNceaiSBNnZvb7+Hr/cmOmOk3c3tGzI+54h/SOSxiDgO?=
 =?us-ascii?Q?C0qRqqVYbif686oN5HFEHY2ITFpzU7sz1WY4EkLvvKkBFaPGj2uOeLOLbN8T?=
 =?us-ascii?Q?Nkmyr8o9vTgubEEP4ABaYOY+/x/9/gv8moBq8+sJPtsB+H3AL5u8eTJB/o2R?=
 =?us-ascii?Q?vMcvtqn8hTuRS8doEi2oO0TCcDEzvcUvLV3/v8Za7iLTghoDrXhUhr2ogWPj?=
 =?us-ascii?Q?ecgEJ2Mwkk2e3bUlH3CuUaNs/duQ3QNrwqrmefD4jrTURIZCSN1V7+wGD1c1?=
 =?us-ascii?Q?KlwBPcU/kIEm46uJ765d75Y6ZnU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99fd4fe9-1f78-4c5a-824d-08d9ece04a13
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 21:57:11.2538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iEI0a1wxVKGb7Lj1RREfZtCh3SfzY5yxoqyx5sbAfx84umWy8q16ctjbahX6NVzTSa+/AIl2Zzpi7ZWTUjXrMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6153

Add delays and drop 'retry' in the multiple subflows test.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
v2:
 - add delays in fail_tests, instead of reset_with_fail.
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 22 +++++++------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index dbc73e28cc06..0b8f253d95cd 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2291,20 +2291,14 @@ pedit_action_pkts()
 fail_tests()
 {
 	# multiple subflows
-	# If the tc rules didn't produce the bit flips, retry three times.
-	for n in `seq 1 3`; do
-		reset_with_fail 2
-		pm_nl_set_limits $ns1 0 2
-		pm_nl_set_limits $ns2 0 2
-		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
-		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 1024
-		if [ $(pedit_action_pkts) -gt 0 ]; then
-			break
-		else
-			printf "%03u %s\n" "$TEST_COUNT" "MP_FAIL MP_RST: retry $n"
-		fi
-	done
+	reset_with_fail 2
+	tc -n $ns2 qdisc add dev ns2eth1 root netem rate 20mbit delay 1
+	tc -n $ns2 qdisc add dev ns2eth3 root netem rate 20mbit delay 1
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
+	pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1 1024
 	chk_join_nr "MP_FAIL MP_RST: $(pedit_action_pkts) corrupted pkts" 2 2 2 1=
 1
=20
 	# single subflow
--=20
2.34.1

