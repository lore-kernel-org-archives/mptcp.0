Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2042.outbound.protection.outlook.com [40.107.7.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EFD1FBA
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 06:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YyvIBueN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkPFYYBVDZ/Pf0xMrKfCa8SW0WqmZFrqcBxL8N9CCX70W/6BpOkOMXIcvvK3dB+1Z9h2dMESK9M1iZTh2bd+Iyt8W/p7mYl1+BGi/nv3ak6ib8cGFqx8hkg/HPOLBkgUl1yFMZIn5vRaK2ZVjNvNUHYRjYp6qNh6/i+c+ecwEFJ5eFvkjc1/hnRmLBZj9/TuEbrT797cV2H2+kkJ7YmjuhlzzWBxQKsp3aU8UELuI0BeM8q8N4lEbS3jU34Zip/bbKCKS0KlfAdn0CGyxEFkjyk/kiGDt3qTwn9w34w6TKbE2s87TBXCsKLrPMWOfaFOyDW1kw487z9h5q73lkb57w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIp5cD0EI7QTXP0DCZ+EvQq9UnqJZrrDxfcKnTTWKtk=;
 b=KvdIUWj+6/lOINSoGDM8Dr/sF9IGLcYirfCH3Cof66u8XObr/i25zN8cgo4VSUcBnZd9yIm9Rm3R0FCUzE43lshRaqKvarSrhZocP3w6UX3UI9PvIdblPLApSXO9Oi3/1HuMA/VbYKmwmThHLyeTj62FhO7blKZxhXDIi9U/ieWMTg1Q/XPa4PCTv8BCOgajv3D+KzmJILDRX5wxjBvs9fXhUEOYzXF4kbYaV28gMOupdyCr0HYZXc7ygMBdwZ2JwdLhncEXHD4kFRBaT74wZUsr6bNbZAKFgyWUW2yJQbdBR3pGtsnHIui57YI9d2w/nqBzus26CdfFkGqqTT1W4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIp5cD0EI7QTXP0DCZ+EvQq9UnqJZrrDxfcKnTTWKtk=;
 b=YyvIBueNUOcdVHGxi8Ua21qys+INpl5EV9C7yeRTzdwn7d0MQ43gXLTaH+TkbrEEjYPuO+xNHP3FX3DmjnZRxLTl9HK6HkGe9bbNuGNBN5g3Pj338cc+m32zaeDThx1x8NyFTn36hFJPvhFwBYEIEUrYcAjXR89+AHKmbhCHL/BpO8Wswwz03OcSP/jeqDVwowzSowVo5YIivZFoSGojP9GcYPhyOMegl7/PXAXJ7xHybZUYTC2/Z/mpqQcOUf2h+IVBJxIsOD6E2a0JQf0JQ5qxm/zLC7JwqoouSJ58F6ow8rHl0+oEvy9XGhBaF10CwGvMVShSgtW3MTYYYaLsWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB9846.eurprd04.prod.outlook.com (2603:10a6:10:4db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17; Wed, 8 Nov
 2023 06:52:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 06:52:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 22/22] selftests: mptcp: rm userspace addr with random order
Date: Wed,  8 Nov 2023 14:49:52 +0800
Message-Id: <e8876e80bb1365e3b42abb36d343c5cebb3f6cf8.1699425895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699425895.git.geliang.tang@suse.com>
References: <cover.1699425895.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0116.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB9846:EE_
X-MS-Office365-Filtering-Correlation-Id: eee8d38c-5cc6-40bb-8908-08dbe027354d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1+Gmv5bEYU9kSdI/k2qU2GXf3ptgAwXaQXG8bOy4U4aCirspFURfOnmLYoiFvDtZEq5eSTG3RhkbhxqElLtayujlwgmqzXhfHS4Izc9jCvQWIwp/5DJmlL+z46zDc1bUusVuIyIO2DdtmZfGTskyxpxuVjv0WvchPsjYNhQ080Epie1guXPAb6za1UCWCVwW7Up2BrdSIeqzHv/QYcIcBFXSZDIJ2+Nncr/paDwaDzw+BSQd18BDeomy5EPOYiBxXqmVR3QiukLifnUs1V+oEcRznj7PjIAFAqikHPJLLrH8w9kwiOz3N6CRM5z+tJlhjsWoT2AAherRzEmP0k9Qvz7BlTukOnXm3NIIhgZV+WikWBDbnMJpr5xCZ4I78xx1YSsTLm3DB2Id6VtYbtF02A0bixD71g4k+oqwRdpL8UVHngp6rvexyvajkGseo8ZLny0PlFjPFU7qD3hokI7Ttu6ngwrBlBGi1pn8hvqwHlQv7qpNv8slx2czoR6e961w94JHRBzvPcslSWR0CUCSsThKoUQ5AJP+NR1w+p3THn+SgMzrSit/393Xquoajz1+7lcCD1iFzVstQJhSC962dpK8Ctx4TU+1WqpXvkfXxJ8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39860400002)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(86362001)(8936002)(41300700001)(38100700002)(8676002)(4326008)(6486002)(66476007)(316002)(6916009)(36756003)(5660300002)(44832011)(2906002)(2616005)(66556008)(26005)(107886003)(83380400001)(66946007)(6512007)(6666004)(6506007)(478600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hRVgdKUOqe38gyenj4TB35NAxV6i0AOa8PTuHEOdK/BFstxzILLJ2UYBj9St?=
 =?us-ascii?Q?jzcPM7KnVh4Ocm4PYQYi+ONkT0i6Fmabcz/WfG71SB3Fv3HJZz8I1TUO8Iw5?=
 =?us-ascii?Q?6ekflWjlQVwx4oaTolUjblTeUbGN4Mml14ePWJdBpwW+fDI8USus3JklBIHd?=
 =?us-ascii?Q?KOeYjlU7KKxJ0qIEQwz6+RrbgujYeEirNCoPMGG4x3MzP03i0hVA+Y7HTRax?=
 =?us-ascii?Q?yx5rApgWrCh51OVxKqszcsAwRg6deAapdeJ7DXSyn5gCqXcsE82lJUsTRDM5?=
 =?us-ascii?Q?Y7L+7b6kZsS59wIVAzJ4kYY/F4enQVc10WpVOTAncuurIErtsiKghCKA5KAP?=
 =?us-ascii?Q?35oL26ypV5zak/07wdCZ1L+5kLUddKGabMzf6rsmbA4VuMxIY/iRzrSaudrd?=
 =?us-ascii?Q?2EJqRnAYk+9ecVkfr3waWtjHbV24LXqsIKSZkh27bCcioPzhr+XU0qSDD2h9?=
 =?us-ascii?Q?nyQc4fpbXRmcf2mDCfbY7f5cqTguo0SIfekLJ+AWMeYTbgjnQ5hqzMmfKaIK?=
 =?us-ascii?Q?nwzIjJpOZ5/gQ7cver2laoom2e+J2fM/xPKxXFFLMmQoIQeoBqdTNB9UaKp/?=
 =?us-ascii?Q?5tF7FmRVSnWSy/sSccX8mPDW/UsumDiZ8Cx/FWfLvTcQOBraEa0kElpqPayg?=
 =?us-ascii?Q?350IR5RfV4EDnA+noOVVFeVCjcPNuO/czGmMwI10yi/rEz07cCoM6ZqPGgGP?=
 =?us-ascii?Q?BpzQAxvRiup6+LTvMw6MNOLBdVuJJ4sKzKzM9J0Ol1RDeEIRBNR+g/hIOXNQ?=
 =?us-ascii?Q?1/JjRUWxQGlPFsM0l+tGIKpIW99te4zi75wuc3ngZ7eNpN3BvW/EDCaFgBAE?=
 =?us-ascii?Q?VVSGt128FmVOD5D4hJ3t7XyqYLw+60Z2AuA4LCan42uYumSMBXsRKHH+9hwi?=
 =?us-ascii?Q?M6FGaVmjgYOopnFIfXVcWspJ8XRKyg93uh/yY16MNOXagR39Me/A3rfX4bq4?=
 =?us-ascii?Q?FeV/8Uq9ET1gjk7+ZQqQhs5Nb6/0jGIvarWK42asVg2IrY9AUexgaQv/Hhym?=
 =?us-ascii?Q?f3yQkX/05Ov9h5NYxSTSUKvaRtGEJKh92kR1fXbBRzNOQj8lWfsei29JModN?=
 =?us-ascii?Q?ZHddC3h1pzkUxNXNM94larGKXZuboTeVoIpjiXUf/SMzlPr179opfjN4I6QS?=
 =?us-ascii?Q?NGgYTBxV4N273DIbX9fzTn8Qdm+TeHMro43dEsqfE+qIN5vAnqQBQOndD8v8?=
 =?us-ascii?Q?BpKQV5VZDm8ApkExH9KpDlbnQtW7NCfYbhQHsGmAwtbjURzvVQT9934+lpkM?=
 =?us-ascii?Q?JJeiVEFS2LHDTIPk12GuuuewHCXe1Qafaq32+vmZBQpVAfu1c3d3Llu/d1GN?=
 =?us-ascii?Q?Vb3F12ImEk051U/Zpqez1R2cpfgI0WPulInsYkyo+zMevWDk2XkDByqUxXuq?=
 =?us-ascii?Q?mjTzov9EsL2u0cuw5vk+oCpUtxHHxcCOFYLL43b9v1fey+6nQuRu1P8BuUBZ?=
 =?us-ascii?Q?HQhGXPjfwfmjpe0e/e64bePNXDus8jhh2UdEdVN9/QGaUTVguZz1qQlRsX2+?=
 =?us-ascii?Q?RtP501GtP47McN8elFKbUyT78CuTRoOerZlI837ovfDx5bH05kNofhfkKInY?=
 =?us-ascii?Q?WqZ56FB1kFXs88wsb8CvDtDmgYhvl4+gyLRXHaLqJgUxZfvWTkd9XYfPHQl+?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eee8d38c-5cc6-40bb-8908-08dbe027354d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 06:52:00.7163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /aU4UWLcIMFvAzV8xC4KZ6EPlTVNc2vAivOJOoPWo3qx8D8O0A6bfH4TpvMpQf7SWt3TV06oV+Ew9u0r4oAXoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9846

Previously, when deleting a userspace address and subflow, it was necessary
to follow the current order of deleting the address and then deleting the
subflow. With this series of changes, addresses and subflows can be deleted
in any order. This patch uses random numbers to add this type of tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f922d32f4f20..8f7112cb120e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3390,8 +3390,13 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
-		userspace_pm_rm_addr $ns1 10
-		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $MPTCP_LIB_SUB_ESTABLISHED
+		if [ $((RANDOM%2)) -eq 0 ]; then
+			userspace_pm_rm_addr $ns1 10
+			userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $MPTCP_LIB_SUB_ESTABLISHED
+		else
+			userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $MPTCP_LIB_SUB_ESTABLISHED
+			userspace_pm_rm_addr $ns1 10
+		fi
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-- 
2.35.3

