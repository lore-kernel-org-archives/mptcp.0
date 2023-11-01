Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2051.outbound.protection.outlook.com [40.107.104.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1837F
	for <mptcp@lists.linux.dev>; Wed,  1 Nov 2023 04:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XvGX5qJr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOJi76/xfRYk50gS1DtS3OgVcWWxrSe5TzC3ocXifJcAdQ5Cfmpxlt+/nL3rz1wzAZIhNoY4CZCvu+rBAgzmLbLmRY4H5JjMj7mMjs8hqTdRe+7jeBdTyDMMVpl6gYGeToykdZtvtCVpgbjDtQ6/0u2aHrCGlJUijbne82FQa2ULrF5XRKB5EMQ/Kip5VQb2mqAJsVW2uwZhJw6/q2GkBUeDtLUwIxGnQtnYaTpBSLLaldK3P8otXQ0IJZKJ8Gqzec09YTc1GevqP/Ej3z1FLg2gxHnwWcXf0u02iPa6N9XCuxAdWn9AjyiLvfJNf5i2kBoALrTutC+XnMybVvn5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yzJshEteVhxd/BIc+cIFtVw2eRelqQWDxLK/8Ux9Co=;
 b=cK99G3yBSU+DTyfPjPhnjjRXbJWzvEvcE7vy7Cwh2/KrKKy7V8Yq0BXOyF1ivEiPiphdkFkbx52MYFb4WLYUCIaX7pjCMuWfZVL6Wyu1hF+raYwKA3TBa/ssSFgoWSTX4UIs8jkY2yG3W3gQ29/1JjWkTUSLrYvFuGFbBmTDiST4CFlJT+PbE1oF14YvzWijbmeeToFHeNleMOD3GzWqg8uJyc0bu1kMdcaprfgl8uAs/ieaoKnWTP6oAAj2tYjgk8z8oblyV33og95HGVba7NaZISQAhcvDUr5bSXBdhzjA+uC8tVejOXdQOp25INHuCwVx2rqFN3qtJYDRUDVeRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yzJshEteVhxd/BIc+cIFtVw2eRelqQWDxLK/8Ux9Co=;
 b=XvGX5qJrawQZ2Zfj9bwYRhKzm6aT4b4oQU/NPwBhWEbbK/hpZ/1R5aogRrN1k8333B4rKsItgCulCaEMH9qHHdIvw3vgTbQ866cdFfhvzfa+A5QBTA4puMqQjNG/pmxsi2g6xLsnVbbvH/RINjTMvm37Q2HXmp/LNMIj476nFGt7hDF1ivwPleHZa1NsEhho3Ypv62rW3F8+dk0Coj0M23mf3KtjkpWNR1FMG2IVicVQ7Iv2uGGx+nJiacmxJC3cbV7IoOuZe4dtD+s6TiL2YUwy7KtpQQduchn5HncCd9IntQSsEKK6FmuDVfqmshK/xhSs6xvsDhS00sx0JGYMVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7070.eurprd04.prod.outlook.com (2603:10a6:800:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.18; Wed, 1 Nov
 2023 04:39:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235%6]) with mapi id 15.20.6933.011; Wed, 1 Nov 2023
 04:39:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 8/9] selftests: mptcp: rm userspace addr with randowly order
Date: Wed,  1 Nov 2023 12:38:23 +0800
Message-Id: <2793ea98c23993208ee30837395d1fa6da3be908.1698813419.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1698813419.git.geliang.tang@suse.com>
References: <cover.1698813419.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 97fad3a8-796a-4462-db61-08dbda9479bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wXTpwTbKKQ/1Ndh57Z1wX/bDa1Tk9RcrBZLHyPhreoMgxcrfVFozEE+0nUwTf/ER0BOvMT4pZOjxk4+A0RhI8oCzkV2ZE9toYRFPx6yPUkO8iSrJwyXmDO0SIKD325aE4PmlD935d3g/2imIprMAVC/lWwGxxjyxjRr7bSlHbIygNiwuzfhb3+HqhLY0RRKu7iQhJdshFptfV98q5eRjkfNZHMKNDw6a9B+I098yXNvlbVKJObbfxC3VpX1wS7UxahDI/6/H84PHo3/TpmyMLnl8QMaQMQn71QoHIUM+/hiMF3yKNAcY7tPdgm0qLt4K5ft5h6sZBc5WnTHit8qcFv/cCS9glt5e2vrIvZnn7xwuyzbJT3OFtqLRI9J5Jb4gz4Px4GFE9sdmwnZXEVvRDGHqnxkYNdvHPSkanGIZpXk9jOpqSGBwSW1BZBZAxgwPPSP4i+LJE6QWtWst9orrNwXMX/dYP8Ze1rAgeZckarLlxfW6G56dSeOXyGGqlsXLgk4KcjFqOv/migvsJ4YYChAH7KO6Jgb8hHhZsCXj0/ysfP6vWfCk/vRX6hdLuiad/GYCRshNbHWJHAHkAt6t1fWmd/Ynun1OcV6Xi8x2DPw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(366004)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(44832011)(38100700002)(66556008)(66946007)(66476007)(36756003)(2906002)(6916009)(41300700001)(316002)(8676002)(8936002)(83380400001)(4326008)(6512007)(26005)(86362001)(107886003)(5660300002)(2616005)(6666004)(478600001)(6506007)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ps1+0SXM6uMsiEZqJ8jh1cG9IznwEAWF/6ZCzfl8xAx8OFpvV6y/LpgHjCUn?=
 =?us-ascii?Q?rcuGFr1qLuKDBpKL/mqUkU51z257W6rj2uha16wzS1fXo26SUSesdhKJGWvQ?=
 =?us-ascii?Q?TktEMJaZQbooVWo5Cck3SIO8z8pqVguWgvFujezr1ju68feFnAVOXKpBd6jL?=
 =?us-ascii?Q?GggpG26lncrbFW58vJNepFf6RGi56oak6fFls7RjtRN7UDFRDJ48JSNPu1+v?=
 =?us-ascii?Q?Ja0K5hk7SSKYh11aIKSurHtKCMKXPODmY9diuHgPjK+tJ8anwhp14TfY1jGr?=
 =?us-ascii?Q?I9lgNeGt2gME/ypOKY05tlgxzI6fLZ80N2ZZFwDQGu9c3MDrhLqEF4CN3vOq?=
 =?us-ascii?Q?QYKfroyZFZLlh9kCXIEdr51M77AdT8etX0Il2Si+134cH+k4iG/LAapeDSd6?=
 =?us-ascii?Q?7YkOjakFKufVTXAeCy9V/esIuV2x0BDeTceXZGCA6bdPDlxFj2pVvCUBG562?=
 =?us-ascii?Q?GB867AiCaeJGIDQt9sb6Rn9SdkTcjqWYdZsQZKNG8wYpGFhq3cUFdmmtlNUy?=
 =?us-ascii?Q?XotVWtymQKcFm4AV1J6cQZRLW2HA6uYaYMIgOw0yt7UQEgwr7HB189H1I0pu?=
 =?us-ascii?Q?UaoLTWz8oZNuBWkr7sDdG+J/Qh+IGSYZhQqz96hDgDPJ8bAdBYN9nWL4ulmn?=
 =?us-ascii?Q?iRtND7YsodMl7GPxFusDmC6Ar97dlrzR6nNz+pSLROGk2ZZUeRngJw8V0JuT?=
 =?us-ascii?Q?kCUbMSj9zzXhy0TLutDsRjeCMIilLQ10ez8N/uQ4GS7efhHkzpSFQaCV8Ye4?=
 =?us-ascii?Q?ARGMj1LsUGwHn1eXG1LWXyfWLKpH+buRGFudmAJIet6d1PX6rG1cwsoR8pgm?=
 =?us-ascii?Q?Qd/ZNry1QXnRq23BX4lCrl84mmLMbFrLxlBCDD3YPu65Im4FpuTNm+hAiiup?=
 =?us-ascii?Q?40SDVTJQOEEMgR9hD3S9dCJsYvFf9VewweuqWoskuclziBlF+TV3xMwIXOCx?=
 =?us-ascii?Q?zcRlboNehJHrubqMI402DTkJEj+AQF8DYwrlSSHWrEq1EYvjL18NaxYe9zio?=
 =?us-ascii?Q?M+ambx/lj5r49XuUelUn7FYlHZvwoXBXT9YP4lQx0C0DlcJWz0oEWbxhtusg?=
 =?us-ascii?Q?yTTtUTiZQnAGFKurn1bd0WqUoCXtVMJlvGvx4GBDAD26rjif23mWePnAjura?=
 =?us-ascii?Q?n4iHewonH4vt5i1o5SicLgaVkTJC9FzDwfQb7VDFGe5CNS5zznNiSGsfrine?=
 =?us-ascii?Q?opaTW4yMPZrnKJ3O/DxCfIWlXR61ljBVuJNdFO/9p19jetufYGtAjvRCWvdM?=
 =?us-ascii?Q?lV9snE+oDgwFJTGhlTelsjcSqOzkBorX16G8hPru5/8SZ6X5yfVjd6uI6gzj?=
 =?us-ascii?Q?/QGVNsFtMoNaOQojgnJH3+jKuRFM2H56OQf5i+o6xJB8REQ4HGYaGgHX1Du2?=
 =?us-ascii?Q?0zoTVqRXDGKBycb4/epqvatfy9zX56aeshWtzv94LKnJopnKh+kHe6bhCo9I?=
 =?us-ascii?Q?YOFbljgtjZIckogbtjcziZUE9jgiTer25gKXMDFtS0wFJqjyKyrO5CLki6RZ?=
 =?us-ascii?Q?f8XCi6WrUeqHwLIRE5TDESMxeEl1Q2/VqLcrKK8S5HGDat6bJvkPA0TLASk8?=
 =?us-ascii?Q?AzISXWWuXEOtoQN3OJuVMRdSwqp9PV/t3amgF/hm?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97fad3a8-796a-4462-db61-08dbda9479bd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 04:39:03.6765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bF/uroRglsXFq/xBgNGxoo186ziAk9bcP/BkXyFbAbAumOzVWUzBITspsgZpAAhCiE/ewutig3JjdEdu1KxdJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7070

Previously, when deleting a userspace address and subflow, it was necessary
to follow the current order of deleting the address and then deleting the
subflow. With this series of changes, addresses and subflows can be deleted
in any order. This patch uses random numbers to add this type of tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh  | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ac7cee3f4dac..2c4fadb3cee9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3394,8 +3394,13 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
-		userspace_pm_rm_addr $ns1 10
-		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
+		if [ $((RANDOM%2)) -eq 0 ]; then
+			userspace_pm_rm_addr $ns1 10
+			userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
+		else
+			userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
+			userspace_pm_rm_addr $ns1 10
+		fi
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
@@ -3416,8 +3421,13 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
-		userspace_pm_rm_addr $ns2 20
-		userspace_pm_rm_sf $ns2 10.0.3.2 $SUB_ESTABLISHED
+		if [ $((RANDOM%2)) -eq 0 ]; then
+			userspace_pm_rm_addr $ns2 20
+			userspace_pm_rm_sf $ns2 10.0.3.2 $SUB_ESTABLISHED
+		else
+			userspace_pm_rm_sf $ns2 10.0.3.2 $SUB_ESTABLISHED
+			userspace_pm_rm_addr $ns2 20
+		fi
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-- 
2.35.3

