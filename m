Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2089.outbound.protection.outlook.com [40.107.8.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D88C17ED
	for <mptcp@lists.linux.dev>; Thu, 20 Apr 2023 03:11:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5aSMzByaEHQUCY7jEI3EvVc1u0I5VrtjDliDY6XdVessU1LP6sAve6B4g6I1haKqqhOFFMpx1yWzt8JGiXHtuQqLtAi32k1CMoUwiLQ42dVYaZC4aMkDdsMut/OIUPY8WoFj6CJQaRxS80rEUOSX4BazJiU31UsseCY4e2t53KMF2btZj9h4QV4/W1rnAHffBdFCsX+9cNc3YAjazEzZTONIM0rADZnZuJTTw/W+2kqY8yZgkxkar0le1K5/XR4fevTjxlsYZgdC4exPNPG4q2EN4O5WW3oT+Sb46RyHJfvr0hp4BgltQU4aY4SQs5xkt822Vyv/GJeFuSktM++Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THjQE8m94QZ/AJoP5KLuAXBhOvypb16g6JrluXxwWWs=;
 b=TORtWdj+4HIAUnGBJ3zYo72pmFI2RgHMEcizVpYsw6OPltHaK7A0/HvGQJX9zsGKL22UM8GrErCVRbpqeM1iKB3dZEiWYxqQZ0i4iV+vuBp2deDJEJUb6KoqKydcJYg5M1eElBakTZrWHQkUOxCR54tcc7tu+LuXi1br4LvwrxIh8/gz38rFxEtCnIwqtqxAi5M2MQzu+ywIBOJCDxRcvtVGsndoQf2PHCes+8jocCmy9qjZG7uPFVWw8BZCfrj0xdT94yByFgp6i6Y16zNOP/kFo1ZqcU0M+o13ZjnUkhqxgvbJ9uxw2aa3fMjRjc7OQPr3YEQBo4HvBLAZb1jFCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THjQE8m94QZ/AJoP5KLuAXBhOvypb16g6JrluXxwWWs=;
 b=0XqMhwsNN5aUDRWYQ3oKc196swKMPjcBJSLAclwiVGlAmERV+tkAYfwUxN8Wa9/3rRdMLH4knwkFAKzNqSh/JrP0Oe0ius5Qed+AMKuHDSnC+of2md+MzZzzBPkIaENDL9JOuldnm3a9pcU8/S3zrpKGaeWOOMpuaVGn8XO8DInOareEGocPKZJWiLvgg1+IKbURRS/2dZavHPTdVYxrs6m1NJ8e9ddtHWXHjd8qadbR3EUWf4t4j4UBSbeAse2RVqoxTxeW2IceEp8w9tiTPucRfiwV9sOJZpqu4zKK/LAk/AzXwodCegpI3d/Berr9xoneIt/SPDMIJPKtWvn22Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9103.eurprd04.prod.outlook.com (2603:10a6:150:22::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.21; Thu, 20 Apr
 2023 03:11:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5%6]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 03:11:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 2/5] selftests: mptcp: update userspace pm addr tests
Date: Thu, 20 Apr 2023 11:11:36 +0800
Message-Id: <6c50f4b82533d9499318cad9d8c846823d7e280e.1681960259.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1681960259.git.geliang.tang@suse.com>
References: <cover.1681960259.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f051159-ec99-4856-fa13-08db414cf916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3L6xsr2Aa+//7thRD1qtJPgdxt9b9Pu/FJKs0ZUyHyVnRXd6lmn6VuJcLbz8uREQQ76wCfXG78OyQ+b0POzlT0ecMJVFNOWrTo7TS0FuygAJqDaXeFwWzGlWHgco1qx8YndJE4LHHMRh+IOkWKiyOLGGL/rMOeEAttAfo/SIr282VGcYmggJgO1JjM5oyrVcaYPCaNiDQUD6ADAPklCHBaVGwm0omJbiyUxI2GVhoi19vOJYOWwlg9bmXt6/rr0Jiwg2REX2W8+WvRPiih/HWdiFjRMycWIFz3pB5WESJa9c8SyRrKDxpZ0J25DE0jqK4Xk5KRWx4LQD1y0Oj0k0u0GndFSdCe02e65RzVKj2Aul7gn+TuEa+vYrOVbwTfyaKiaJ1zjd+ib2e6rnVzp80kQkqRzkuKB0uDHxjFmvetcHcS4mybtjuYpLEK+bx8/OAFns+uTzLh17A+YPG/bBglpaADJvY0Os6CADs7kx3b6xZxAQ1M2ITOggBwFq6zykC+whWVq8z+uramysdsINxML7TihMtLR4rjWx8j/xOKCY+0hYMsj/W5OLHdKZ9pjj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199021)(4326008)(6916009)(316002)(66556008)(66476007)(66946007)(6506007)(186003)(6512007)(107886003)(26005)(38100700002)(2616005)(83380400001)(8676002)(8936002)(5660300002)(41300700001)(478600001)(6666004)(6486002)(86362001)(36756003)(15650500001)(2906002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5GsCWPfsuZoOgUCq4yONuLQQJMmGZ0qZgd0rRU9BGtlsHWpWI0sJGOyBdMEN?=
 =?us-ascii?Q?RimYiHbslu/xcME6MQEubM2JPgUbw7ImRVWfkSfpsj56VftRGph9gU2NkEy3?=
 =?us-ascii?Q?lb4UKixFSHQZzjqq2dOiuuRj4cVDE2b59H3GCIFF5ey8LPUaQGlLdBS97tRG?=
 =?us-ascii?Q?wHsfxP+KFMM6auAJboiBbfIik/xYclmZ9I9TvNxvrFQixkAImHhI0OTqHyot?=
 =?us-ascii?Q?EoFXIToBAfSJCophiPFS8Ueiq6r/Eo+YFfrtZ+RdRyTdvXj2IQy1FQAy6Dru?=
 =?us-ascii?Q?RyebRK5Civdw+topD4hKt7RmwK+2IbMU9TKEX097p7wj6d2QYnLjCTSNGHZ1?=
 =?us-ascii?Q?Y8R2tdjSUNAqli2Ivu+GFQnQw6Hlba9WqhfmqFL4ujgwerrjHzlEA8pIU9Qf?=
 =?us-ascii?Q?gCrMMzi0+K6F0BYc+aYEWSx77GtbgaOS6GbyrskcZj3va8FT3kX3wSrzQ+C5?=
 =?us-ascii?Q?Gox17BJdMAwEABLn6oJCzBj99BWIjKCOJBwksX0P7QX3grpUKfEakTRADMyC?=
 =?us-ascii?Q?tlWP+06gDLViurXF4tRAqg1wBupfW3IRs6lYHkSUctnL+nKlXd96oCSwW4aO?=
 =?us-ascii?Q?aFbtT1fyuXtUh1QGpXCN5sIhbk1oa+EFSITqdl9F8nMc7TLZZ9mMyt/zaSuE?=
 =?us-ascii?Q?04Ti9BRKKsdr8lihtCqfUvspTNEQsDPaTQ6gIr37hIGKc5naH+lo42RtD1l0?=
 =?us-ascii?Q?V6hqbRh/WlOCb8v/cbpyPwS3Uvrb3wA85hVHQppcwYxw0G5X52QYPMQts/Pt?=
 =?us-ascii?Q?oyCgE7IQElKwn/9EU4EQfplmj18h6o/4nCwArNnNRK0U/UAwiQ9uSrrCVgpK?=
 =?us-ascii?Q?/fWG0zeRnZ5DecESM6+4+RpKLwyixcHJxqy4EIirAVuV9kzO7DNJUu8cWQ/3?=
 =?us-ascii?Q?Ror4PHexdQiwYf9nXW9fizEz9NWGRJ/FG8utMzNQDYDfO4SNQBO0ADSCBqSY?=
 =?us-ascii?Q?Ul20eXw4ocEsAOTiKOdzkN1mQfgD0gwdhizJbUCDTr4BtGkTJy83wcNfkIM3?=
 =?us-ascii?Q?1zNrbnTivE7hYC+kYzOPbB/RBFPRHiAtqdtJYeNgYDz4qQw8LTFNbeUeR5JO?=
 =?us-ascii?Q?YmMamEL8xJMx/20NfXNqXFowUeF5iZaCkCd6leDGad6cepjKjskXwTOM5fK9?=
 =?us-ascii?Q?gkBAEPhK7QdC5cu26xg/XVB0qeeNJcmkPZl5NPhwjJKpgY/JSuBtgPZ1jUCH?=
 =?us-ascii?Q?6Lj+8ZwxgFlk6FIoXi6KOVx3eoRY9ir3tO4XH3ob9zFRwfsJpCulLl81lgA+?=
 =?us-ascii?Q?qLsEVvRYj0lr3cnQ0r/+1AqELKL8cXie3Lzj1+VCHvZLuk2Wmhie5q0WiKYu?=
 =?us-ascii?Q?ND6Seri0MLIMkzjhcXTrIDvv7YXbJl9IhNz6iTlFnVeB+0mYss1Z/q7JJu03?=
 =?us-ascii?Q?qL1hTWcYPrpPOOaapyvjUpKDUkYsnb6l2mFsJLSlGGih4NOtwqnCvPJI6ENt?=
 =?us-ascii?Q?/DimZAnXT7wJj0wnf3PsIYmM5bqKRdacUdiegmqR4ucvjv2odUz/pej220BL?=
 =?us-ascii?Q?lcUWdheJiHYsqqBqqYh9v+Qumvv0izbLnj3yhemafQiYU/ofgTwITAwYsJ8E?=
 =?us-ascii?Q?BT1H60xZyiWzCjnfZhWfjvgK5pUN+mICbNGIySkC?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f051159-ec99-4856-fa13-08db414cf916
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 03:11:45.6698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WI5ZhdiykfzvcnTmOQskYvMEmRTZ07A6VfiR0foEciXxj1yTK8y3Icv4tzPWiB8w1+Kh8wOUpH62MvD7Ox1gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9103

Update userspace pm addr selftests, by sending a remove_subflows
command together after the remove_addrs command.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 26310c17b4c6..9a9b6e9b28ab 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -850,6 +850,14 @@ do_transfer()
 				ip netns exec ${listener_ns} ./pm_nl_ctl ann $addr token $tk id $id
 				sleep 1
 				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
+				sp=$(grep "type:10" "$evts_ns1" |
+				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+				da=$(grep "type:10" "$evts_ns1" |
+				     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+				dp=$(grep "type:10" "$evts_ns1" |
+				     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
+				ip netns exec ${listener_ns} ./pm_nl_ctl dsf lip "::ffff:$addr" lport $sp \
+									rip $da rport $dp token $tk
 			fi
 
 			counter=$((counter + 1))
-- 
2.35.3

