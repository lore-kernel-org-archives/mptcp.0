Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882951360
	for <mptcp@lists.linux.dev>; Tue, 15 Feb 2022 22:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644964817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HA66sAh5wZD8T6Jzse2emWn8WXvQ+oWv1YqrV58Qe6I=;
	b=c6FZB56f+hAju2glPIghwcSpBZnknJMFmbpcqGm0XkCTeYxzSH2LPNKggc/jUNLFeE4jo4
	JuI6lePC+h16imO9AoQVqQffux+Fv1cx2EWf6d31BAoTeMXKMg0BmdzrqFq/Nxu4Ovkm+O
	PA/9b/BcK20WMd743gNDggtiVfOlUb4=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2054.outbound.protection.outlook.com [104.47.4.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-_lBuXAjcOmeYvcgCFfoovQ-1; Tue, 15 Feb 2022 23:40:16 +0100
X-MC-Unique: _lBuXAjcOmeYvcgCFfoovQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOlXvlOho4GCIOMfI5AOkxZKThfRJ3A7RlQd0670XnN+WSwqj9dJvI/2C5+gul2bq9afcZ2XwcFxd5zuVFp12E2C7Ebrce6DnC+IVGDB+Z7VgL5Vyfue7w2QwSdRN2kHr+CPy8Q2u70A6JSS+PbY2V/EDfvGCl7gsb0n6L5JK4xRce5AJi/BDCQSTZca19rUdAybRMz3kleKgSLaZ31qC/GMkFoigOWcr0Hba0XCgT7Zn4CcIP+2btYHEzwzS348grhz4OySyPEVwV/xMtZnP2SEQvV5rrl8wCGmiNF2FoiKmn4PV6MQIh7psWBHEoo5yphvBovHmFDMMjktmAjOQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEKFwY0EJffzqobw7g1ihvoMnntiUrBOrYvJolyfGAQ=;
 b=Mc836ki/2q95L9bz0AcLlMSCcwckG0C/bcwE90ondcP7/wGIJ0iIarb09xCY0AP2S2rY7+d5HJowq0puLxu6CzAZLUXJoZMpYnXETASPYpzFSp5LD+A6gFKoNpIuP30kNM5PcCTSL7wrDzqCyXYJeDFpsQ+phA33XYgHoHMmNLNXIBGYW+GXHM6Ke8A/MALUwJAX+UeA6PsiNCmcZf3pDmMYOj/DXgcgsWO2ZOznEDCR1EVvswUbVIOxs/kk/NHWjiIW726NaURPcjTkviO3pQKL9L6Ws+sENVbuPGJukA2G3BMnsxvfBvUqLTv8ZT2MerLZqaE5BfZVZGI2Z2++UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8671.eurprd04.prod.outlook.com (2603:10a6:102:21e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Tue, 15 Feb
 2022 22:40:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 15 Feb 2022
 22:40:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: reuse linkfail to make given size files v8"
Date: Wed, 16 Feb 2022 06:40:37 +0800
Message-ID: <915733881311a607504ae90046de9fdcecdced33.1644964809.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0218.apcprd02.prod.outlook.com
 (2603:1096:201:20::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8289928d-e5d4-4bd9-2c6a-08d9f0d421f6
X-MS-TrafficTypeDiagnostic: PAXPR04MB8671:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB8671F15A56A86F6E4D234C59F8349@PAXPR04MB8671.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ti4Z5S2nLE+qEQ3kFpeKoXG23BAYRaQW5LU7tUDlILJJZF1ayire7vbrMMHt9ygu5jfMkRIppdFbZIpOu1P41KlYxdhVlNmuP8oyKoEJ+jQ1uxWV28wbXbD93/M6bnhP+Dx5IfKQ0mLme0RLM722EHdkaQk8Ef9yOebt1IBr533SIrEmAatMvZ18tfvx1GsRoScVBtbVjBJgLvCtmv5VfmlOTnHUG/vRBRgUdB25NqakBsYgyImkWZD61HioL48+0HR+yJq6v4te5j8Lkbia9jUp/c0ZSD87F+SpvfFDWewn0RAnJ146FZdG5s+b1jfU/U7nKQnbFTtQtIEX4a04d2DYpAkCwqKe/N0ly4HXfVg2BVoaJG8ejGlKpUZmavKJxHx9w6DBRZNmKWAQR3BCZfVJXY+Msah14s1ZFGQfHzdGuWrObhYzSHAkkA0MW/KmEaW4Ry5T1hdbitOS7UxAmk2A2K2GE09E2WT+aXuTaL0NpUuyVn+ehXB/+ggNeI3TDpjkw7en4AnIoZMl82PHh+ENvunRvKUIn9U3DRlEIkxPT0TjGHgqZzCckJ2msRQQobhZGCkoZ0zjCApNRolNvxWKSS/Tl7l4crdpwY1W6kmLuOn2glQsCUIf15sD6UQr803Oa3ZbvhuP0YLSlHXF8A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(508600001)(5660300002)(2616005)(6486002)(83380400001)(107886003)(186003)(44832011)(66556008)(6512007)(6666004)(6506007)(38100700002)(316002)(8676002)(2906002)(4326008)(8936002)(66476007)(66946007)(6916009)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZfK1NiPwAurMA6pg0i6nbiYVkQkpVPawDizn1lwZr1epagaSlxG95JM+MDUi?=
 =?us-ascii?Q?m6jvoHI4CXMDosCi7zk+YH3/mRGM7st0xK7/7hSsQRKO3wgX6Oa1HWDNhd5q?=
 =?us-ascii?Q?gV/8HRVSUWrEecDGPfLhYDGq/33xTaRouZPOLMxgbhc/3x3361HKvxeJarAa?=
 =?us-ascii?Q?I+jdkGESE44gvwNNTjzabrR4bkw1Pmwc0ahduFzNceWfAlWMaY0vD4YOqeYl?=
 =?us-ascii?Q?+Cbb341vF3qg5ROn7sL+jDZcSn6KVFaorj7ls89nTkBiJCSX8fXwL26Ws+gX?=
 =?us-ascii?Q?Uw73zJcwZax6IwNMQGmde9B22oVpxj6A28q/8X3CmxiuITtjv6IAzDLRjfFp?=
 =?us-ascii?Q?guqLckTWwxMs6qjJEYMKZY/vLIn24tnA8dMuucThcmHMYlvtshG7iqC1WJTH?=
 =?us-ascii?Q?zBjlgeZ9+/u58la0DNt1j6APMAbpDGzi3rcbGZ1fbNLC3Ws8Jz+czbqmW1Zt?=
 =?us-ascii?Q?8j2mqL1KilRizxwV+aKr9DNdExoqzlBK3q/kpNEr9xxU+sz0KmmeYVqIYh6V?=
 =?us-ascii?Q?oWZ0tmumSxGnZmY/irwOmbvZ7etzLqzhtVlCAg5yit5NPS3BBSUI6f57V4fI?=
 =?us-ascii?Q?B4CSZnBqJno0rfFz+qDWq9jGSUPI6j5qhOC9zcOOPYe349XGQcdREn9U5FRk?=
 =?us-ascii?Q?x+daiWauTz+vBoFWPk4Wg5cnKASODC8ycwVbb/1n9V6/Xoa9Ec7Fr4VaWuSl?=
 =?us-ascii?Q?vh9zt4l+BszRBfR9ieOUmbVP9SGZgYxhIk4mCFnaNRkY1xPGDosz3Vd6KIuT?=
 =?us-ascii?Q?wlRAenqWOsHtYn2MaxK559DasJgvME9V3KCcWtPxemTYHZxyyuCf44WHCStF?=
 =?us-ascii?Q?jch7KrX6do5Sh8Z7OhTuvMQnYnwAVDx+zLn8AR0igxKNqLkKHcQex4A8hmrg?=
 =?us-ascii?Q?E64z+ic1la2v+Xd702I25VFKNrUiQpAcT4PgeFosccki5na7Rx3nAF6+mUVB?=
 =?us-ascii?Q?MUemBnx6+DQBSdsZz+VwE+RwtcgFnqqZRrL56glShEKVarCKgwf27R/YPmsm?=
 =?us-ascii?Q?mGFYF5PPzOCfLz1gD625WgiurSZv3ASU3la7lQDo4PdbUHP09WjuRPw02+3X?=
 =?us-ascii?Q?fCZKeg/h3omUbhhwCCAXVSG+sDz70YuZ16/fDAoMHxCWGjJfw+xXZ2TehzJf?=
 =?us-ascii?Q?SPOx2gUHsKCMvTp+dazC2G5pqSPBjY1Z2Hd+ke8jHkkXiuCnlkXB73zLA79Y?=
 =?us-ascii?Q?7fABwEEHrRfFL3dKE/uYOjmIa40ynnALfz3MDsTw9FSLGLornHiwC4ciSZzn?=
 =?us-ascii?Q?k4B+RQP5ceLb3bXErDvLlpaJDGi6Z1WxvXaYxtB3VqLrnjLpNFA1cd1F9nwB?=
 =?us-ascii?Q?k71+8FOBE5NS+CYmPDyqrRJueXvH9LempWPTctf7WFMKq/eEK6/t1nPlPEX4?=
 =?us-ascii?Q?BOWaFc0fkUUqBfJPodOBlEEjbacYAL8bV4AgypRSa8pRnOOLoJpc79WUgG5W?=
 =?us-ascii?Q?vtHtPOaSCAmBzbuv7kIpWT+oToU4FaBzS8Od3NRcnjnMTlPCCJXc5JMMKMLb?=
 =?us-ascii?Q?ZDoYdWh8bqbeZqykzhFPmjEh7bnzBQ8SKTgaW39Nvl5pJ7FcswZtajtWSbGc?=
 =?us-ascii?Q?EgeZw7Ymxmfe6pijMLCstEAN8TDIuBQFUt4YjIVCvMB4yzS5OioGEdvm1oFE?=
 =?us-ascii?Q?5s5bYCkB0GyEI1mgO/oCpoMdTdO3x4PcoJ3yD3WyJzQ9Y/iqhXpSZ9TOIGp0?=
 =?us-ascii?Q?oXHExkNHMgo2qPDsGw5l6P32Jp0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8289928d-e5d4-4bd9-2c6a-08d9f0d421f6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 22:40:14.4087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fYSC/h8bSxig0/yFXBribAgqWEy/LK3mVf3CSuLQ5rFGqumSdDtQ+C2TyToMeXzjZVB0LkeuE1ICpaUSRgBqiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8671

Add a new variable size.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index e312aac8375b..8c6c41ee1b5a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -715,10 +715,12 @@ run_tests()
 	# The values above 2 are reused to make test files
 	# with the given sizes (KB)
 	if [ "$test_linkfail" -gt 2 ]; then
+		size=3D$test_linkfail
+
 		if [ -z "$cinfail" ]; then
 			cinfail=3D$(mktemp)
 		fi
-		make_file "$cinfail" "client" $test_linkfail
+		make_file "$cinfail" "client" $size
 	# create the input file for the failure test when
 	# the first failure test run
 	elif [ "$test_linkfail" -ne 0 -a -z "$cinfail" ]; then
@@ -735,10 +737,12 @@ run_tests()
 	fi
=20
 	if [ "$test_linkfail" -gt 2 ]; then
+		size=3D$test_linkfail
+
 		if [ -z "$sinfail" ]; then
 			sinfail=3D$(mktemp)
 		fi
-		make_file "$sinfail" "server" $test_linkfail
+		make_file "$sinfail" "server" $size
 	elif [ "$test_linkfail" -eq 2 -a -z "$sinfail" ]; then
 		size=3D$((RANDOM%16))
 		size=3D$((size+1))
--=20
2.34.1

