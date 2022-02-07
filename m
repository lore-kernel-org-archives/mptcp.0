Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ED72F26
	for <mptcp@lists.linux.dev>; Mon,  7 Feb 2022 06:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644214555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kQ0TOix5PW0TvgCPCY+H83LucpGq0tGnWPGJ/LMqkZY=;
	b=YdHcS8k3io0XjZuosXbSXC2BEjtT3mPbrXdNex0Jpv5mbhaY62GDwbohexjC+Fr4o1TqBG
	igp4TjgEqBPcsjzm+7ZeSVdrmoXgVBjcdNwijeAxZ91TrD/lTofqyT8rFib/6MgWg9epdi
	3LXBmt4hFIuGXvMFyqlAqYMRXW767c0=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2111.outbound.protection.outlook.com [104.47.17.111]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-kZ7DrOwWOXKD9XnmwVL20A-1; Mon, 07 Feb 2022 07:15:54 +0100
X-MC-Unique: kZ7DrOwWOXKD9XnmwVL20A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdC/cZvYHeTWi4gonF+lf4ZIccVJ1qDym3WgooNFY43aYTlqPHigfkmTdkHD/EpE/fXfeKNHo0WagFWaO5oKXpUcsMw7+rP8DDGmrsRVwdJ934R6Q9f/GebNL/+4rcAvA/jYDw+pAS13PAepErhOHuhmTEFunhpOZOumkgwicINog76YrXjENA/mLnKISHK2D06cejjyZfmejH76eMDi3tFiRhposyj+Ko3ClawIshkZ7VN/X5+wrsDO220v279134ftwNGnbzoSIUetUzmnt8dDDK5TaH5cpFs/Rl3xsyZu/1gZ5SpxXNCjLVuOH4V13II5vn+5WX4N3dHF8MVOMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLHu91fK/oKR32tnLss/vVaMG8WO670+iRD6OFQE3bg=;
 b=jTeHIxK8Gculwtg/F4cOdwBdY1vaQru8d/U23pSaUbhszTNHOh90PoTV1HmJX4VaMBIEbxjdlvlzN4qutvamVTNBRH6gK1jkfgraVN4ca6mBxz0JgiFvTj1Z2SN8pRWmXqJILhbp5EvNmBLkBv8aRel1PrkjVZw0cKxdmX9jEfrQ3C1OIx3WgVdd3gNWdGuJTBUcYbsjvStO7plCZ62PJIIpb6Vm1NCdXK+nZEEbbGMCZfg6tqxC2fZjkDTVfiPM54AkCHT8Ay3zkAr06aY9nwh7ZVzvK/M/5wyO9IjcukC6LXcmOPNxSjy46QbuqPCoM9PYoTUV+bLzkloNjMdIyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Mon, 7 Feb
 2022 06:15:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 06:15:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] selftests: mptcp: adjust output alignment for more tests
Date: Mon,  7 Feb 2022 14:16:17 +0800
Message-ID: <9ecd5de1df130bc1d5cc65de7c940ea546cf4eaf.1644214533.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0110.apcprd03.prod.outlook.com
 (2603:1096:203:b0::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f91f793-bc1b-42f2-9e67-08d9ea014b2c
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB50056683B5B5670F01311338F82C9@VI1PR04MB5005.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:556;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dO9qLTkASAhil4ndumvylvQHQDPfSOpuRN7NRHiB2YLP1yg6WZlG92RpQt25im1b6M7UV+K7HpA2+N9N24FOOYJ/CKqU2n4SDEL2NJy07R07uZLrvviM3eHOs5VUy9zJIwKNkof1glQJPv8Yk/AYID+i8SEbzO7V1GaRrouD6PDqZ8mt1KE5sqF/8ryBZCyTD3TzAzKNDUrQEMq15o2f2kDvhUHFDS8hutGc4S/0wgdD2ML4io8F69+6SrqUKzAKc8qAZW9ZF670hjbgKtD3lLhmIC5CWtDcorsOlc2iREvocQ6ECARFJhvODiuRUlYPm25QkOKmF4/NV1QoOEFRH1Bd2P71D6SkGbvocwaQ5GEiW4dqzgODZoMnRxVOzwaDNy47DEcnBL7AnwE450NrcrQtsNBeG3whX9N16ArGm+6g71K8JrYnU0hQWSl4GEo1t/Of/1mecjUGRLpNiNzpC4ZwvEKROSjQCq+7lDXMGYa4xrTKZJtxFIBRT75XvKTvp/qUHXJL44RotpyHf/fAaOGLegKmkcVf2Myv7utru40LISU1nZ+7lRhWImaJshpak7UyjUMmOw/861lQzvd66VOpEJTiepszQmuKTVR8/dACT4CaQjrHhAW4E53nsc4HVblqQv651mxzhDfG49MLRg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(5660300002)(8676002)(66476007)(66556008)(8936002)(66946007)(4326008)(44832011)(38100700002)(55236004)(26005)(6486002)(2906002)(6666004)(107886003)(36756003)(2616005)(86362001)(6506007)(508600001)(316002)(186003)(6512007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vfw9whte1EAh7PckKV2cQYRVG3GLvG7eiHLIIht49cmk7TAICjd1WAo05Yla?=
 =?us-ascii?Q?78ltfnsAIQ85xUPZENHmGlVdIVrLcs7vvrCTWQLwcRb5fJ/OGs3mjS2gRETN?=
 =?us-ascii?Q?25M792a+RoAk1qJ69Z76jsrOZU9Uc+yCS9FPAPRxYsmJboj3mAAQLuZlL+Zw?=
 =?us-ascii?Q?vSHTBHYe4K6KyCMaw/NJe9tZbTykmNxLDcmWyUDHsGPrqUUyG0y+ZAlxRHYs?=
 =?us-ascii?Q?9fqq7oVC8O4T3XBRbI9XsaO6Dd6b8dnzZCVJE0bP8DKWGu0HnllEdq2pvDy9?=
 =?us-ascii?Q?XXYk2IzsvWS9b3UiJ3tFqFzvy58SzFqTOTGffpj3Jm2EOUZnhzhxScdkwGq5?=
 =?us-ascii?Q?XG04doXKaLi4nTZvI/WbFSZrVYa6F3lCZE005lQTqvxyvGqAB+2xwc4GHSvu?=
 =?us-ascii?Q?sFqVzk5mDPA5gmB/WQ0LqDx4RM6kkEe2Dy7HXBudc0rRbkdezvjXxRfwxlT3?=
 =?us-ascii?Q?2S7PFdglaG4X5CtI/6i0bmFkd4BOtuq9pQL4DimSzGBljLQ0Jfw8Scto7Q5+?=
 =?us-ascii?Q?a29LEixjb/CQZbPFohzz9uvWc88qEPIXe48HAYqQIy+H/vdR5G8Pn0oLjRDa?=
 =?us-ascii?Q?2+/2e59aZyKaU06ucqTheaIJ0rHiJsXPs1wF7spX7gQVlOzrRTtqb60Z036X?=
 =?us-ascii?Q?oIUb3SxBZleQOobxTRabE5JxwE6iuMVFgM+5cdyA2LD543/nTNDuC9luCiHr?=
 =?us-ascii?Q?Jx5nOl7enLNg5wmb3TJYXP2V1IEVpWawMSbOf5aglu86dCxMAgQ0NoPx+hs7?=
 =?us-ascii?Q?iAg9vRFJ0z+VwtR8A4L+a3dBUmalemK7uUy8U6xO1sJPZOM3PlNyZS5WkWI/?=
 =?us-ascii?Q?SOf5OFaNl6HqxItYc101wbb2SCTSj/CKA+pL5V1R5VxRll1tpV8qv0X0jo1N?=
 =?us-ascii?Q?rky1tcoWYidW8Fo+ayymQ5rwjTkDRpRCamswp/XdaCXAl+/ApOrevf71ILjY?=
 =?us-ascii?Q?kxo9bilxbfYeWQnHllibH6q0z2KcOucv5q1LVGKf5nqt9jvicO+5F6Gl49iK?=
 =?us-ascii?Q?oSoa9oO8Mn5GUNzK/6Q6Kj/rskJqVCSMntIbYN7nANUL5oa7yqCH1z4lQIrC?=
 =?us-ascii?Q?XgFqL/0nTJLgVWdCGr0MzTRa/eZEqpI8ojktymFcF9Se3rENIgS0aiPNPx2T?=
 =?us-ascii?Q?MvxZnYP+YQ4GNrvabZl3gvvYqPzl7sx1sUgGx1AYWRbsPX0Fp1I6DkSh2Erf?=
 =?us-ascii?Q?LnLG77pM5Z9ZIiGeLSSX8whGBdDnhRII4p/50WVRk88owEy/wbkCF4a4hjlQ?=
 =?us-ascii?Q?rMGpi/HM+mAZ5qAOa5DYlE959xUWOm5WJJnqKGfDJ9mlTh4v5jRnPppdCm13?=
 =?us-ascii?Q?P0XxQJH1aIDS5ZJcAOcUWYQ7wWHqUw2JzPXiiydn/uWc/N3BiwgqwF3xfSZq?=
 =?us-ascii?Q?nfdbV5tc/1e9aZ+LKZ9UzLbhx4kBWvQA4o97UgNTmU4gFfEmhoM1YCrNVbY5?=
 =?us-ascii?Q?oWlbhIlnegC7BVTMIf/r2ZYafjwzswGzNKeEPK7kV/4f7OsWhvsv4L1SC9w2?=
 =?us-ascii?Q?cji/x0f04+DBb1I9427XC73Osrt1NZbiWNVIlL6Dw6mNVIBR2TFGdqd6bHYZ?=
 =?us-ascii?Q?puKBTLAiRntVSF3BA3VoCsTMY0FQh+ARN3smpAi+E26IUSSKGj3IpxXrZwQe?=
 =?us-ascii?Q?V1Ms2aQ5l1salidyACWIXnQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f91f793-bc1b-42f2-9e67-08d9ea014b2c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 06:15:52.9686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7M9GJVu0GmdJYz7SRH/30QfeTGKO+87AD2p7jot0DxILxvYltLVJRC30FgEBsLwH8TmvbblbxSOJblMf/K0qrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5005

The number of self tests in mptcp_join.sh will soon be more than 100, the
output alignment is no longer OK. This patch adjusted it.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 007223364718..2ddb373b7c1d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -20,6 +20,7 @@ check_invert=3D0
 do_all_tests=3D1
=20
 TEST_COUNT=3D0
+nr_blank=3D40
=20
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) =3D=3D 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) =3D=3D 0x30)'"
@@ -743,9 +744,9 @@ chk_csum_nr()
 	local dump_stats
=20
 	if [ ! -z "$msg" ]; then
-		printf "%02u" "$TEST_COUNT"
+		printf "%03u" "$TEST_COUNT"
 	else
-		echo -n "  "
+		echo -n "   "
 	fi
 	printf " %-36s %s" "$msg" "sum"
 	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{=
print $2}'`
@@ -777,7 +778,7 @@ chk_fail_nr()
 	local count
 	local dump_stats
=20
-	printf "%-39s %s" " " "ftx"
+	printf "%-${nr_blank}s %s" " " "ftx"
 	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPFailTx | awk '{pri=
nt $2}'`
 	[ -z "$count" ] && count=3D0
 	if [ "$count" !=3D "$mp_fail_nr_tx" ]; then
@@ -809,7 +810,7 @@ chk_infi_nr()
 	local count
 	local dump_stats
=20
-	printf "%-39s %s" " " "itx"
+	printf "%-${nr_blank}s %s" " " "itx"
 	count=3D`ip netns exec $ns2 nstat -as | grep InfiniteMapTx | awk '{print =
$2}'`
 	[ -z "$count" ] && count=3D0
 	if [ "$count" !=3D "$mp_infi_nr_tx" ]; then
@@ -843,7 +844,7 @@ chk_join_nr()
 	local count
 	local dump_stats
=20
-	printf "%02u %-36s %s" "$TEST_COUNT" "$msg" "syn"
+	printf "%03u %-36s %s" "$TEST_COUNT" "$msg" "syn"
 	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinSynRx | awk '{=
print $2}'`
 	[ -z "$count" ] && count=3D0
 	if [ "$count" !=3D "$syn_nr" ]; then
@@ -898,7 +899,7 @@ chk_stale_nr()
 	local stale_nr
 	local recover_nr
=20
-	printf "%-39s %-18s" " " "stale"
+	printf "%-${nr_blank}s %-18s" " " "stale"
 	stale_nr=3D`ip netns exec $ns nstat -as | grep MPTcpExtSubflowStale | awk=
 '{print $2}'`
 	[ -z "$stale_nr" ] && stale_nr=3D0
 	recover_nr=3D`ip netns exec $ns nstat -as | grep MPTcpExtSubflowRecover |=
 awk '{print $2}'`
@@ -936,7 +937,7 @@ chk_add_nr()
 	local count
 	local dump_stats
=20
-	printf "%-39s %s" " " "add"
+	printf "%-${nr_blank}s %s" " " "add"
 	count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtAddAddr | awk '{prin=
t $2}'`
 	[ -z "$count" ] && count=3D0
 	if [ "$count" !=3D "$add_nr" ]; then
@@ -970,7 +971,7 @@ chk_add_nr()
 			echo "[ ok ]"
 		fi
=20
-		printf "%-39s %s" " " "syn"
+		printf "%-${nr_blank}s %s" " " "syn"
 		count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinPortSynRx |
 			awk '{print $2}'`
 		[ -z "$count" ] && count=3D0
@@ -1009,7 +1010,7 @@ chk_add_nr()
 			echo "[ ok ]"
 		fi
=20
-		printf "%-39s %s" " " "syn"
+		printf "%-${nr_blank}s %s" " " "syn"
 		count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMismatchPortSynRx |
 			awk '{print $2}'`
 		[ -z "$count" ] && count=3D0
@@ -1059,7 +1060,7 @@ chk_rm_nr()
 		subflow_ns=3D$ns1
 	fi
=20
-	printf "%-39s %s" " " "rm "
+	printf "%-${nr_blank}s %s" " " "rm "
 	count=3D`ip netns exec $addr_ns nstat -as | grep MPTcpExtRmAddr | awk '{p=
rint $2}'`
 	[ -z "$count" ] && count=3D0
 	if [ "$count" !=3D "$rm_addr_nr" ]; then
@@ -1091,7 +1092,7 @@ chk_prio_nr()
 	local count
 	local dump_stats
=20
-	printf "%-39s %s" " " "ptx"
+	printf "%-${nr_blank}s %s" " " "ptx"
 	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrioTx | awk '{pri=
nt $2}'`
 	[ -z "$count" ] && count=3D0
 	if [ "$count" !=3D "$mp_prio_nr_tx" ]; then
@@ -1127,7 +1128,7 @@ chk_link_usage()
 	local tx_rate=3D$((tx_link * 100 / $tx_total))
 	local tolerance=3D5
=20
-	printf "%-39s %-18s" " " "link usage"
+	printf "%-${nr_blank}s %-18s" " " "link usage"
 	if [ $tx_rate -lt $((expected_rate - $tolerance)) -o \
 	     $tx_rate -gt $((expected_rate + $tolerance)) ]; then
 		echo "[fail] got $tx_rate% usage, expected $expected_rate%"
--=20
2.31.1

