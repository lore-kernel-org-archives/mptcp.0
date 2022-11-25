Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80054.outbound.protection.outlook.com [40.107.8.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F092E15C2
	for <mptcp@lists.linux.dev>; Fri, 25 Nov 2022 01:50:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCXFGGw7k9S02LC1MXr7PGOyHBFVdOVAeAuD/Te6pI4aMZoqs7na9+dA+Yagcnj/inB4RJnVynbBwcE3lgTCIba/AWGNnUyClD5FwgNjMbtDVSxQEXLEojgJHL+6OWDrHx8wjhByErLpBvREXNg/cBwUSwyAVRbS82aJibJvLUwoDRom2g7ceSPCqdIJWu4+kwcqZr4J4zwHHLdaoRgZzxYylqace+xau+nK2tWCeRnGic5nmpOZL6cRU+zeWifR/kINObbSCQIu/uEVy3u0VerRVQmhbKMDU5UdwVKiVTnCzACPyR3kVfi16xSYrJE0wxD0jH2zsasIvucI8xjyXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlm9xEYlGPCMyD2ufWGsch6Xzn7uYOjjOfr36GM+J/o=;
 b=HgisVdqlB0bDypP39j+pVzViILe7duXYst8WqRdQBhnX9q0JvvKLJBbxvrc2NDOMg+ZQxRPq/QjJZvyh7gjtF14WiDuHGDUV0WTliScrwDePpJ2nAIfC68jyMFqVLiF1OptAB70A7qh9L5Zj344hjdluM64gl0eDwb11pUtSbEsT18vNP0LppAJ/DMBam22avKl41am3zHwYE6+M+/7xEdX4cxqS7JLefoVqFpBiZJfacox/JT+H5B0412024BdATaznLFEzBsqCoivclzWqeW89H5RVXhI5N9OoD67iSfrj45AKmqdwzC4Uvetb9GKKnTOrrCZMIv6dANe8xOzxHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlm9xEYlGPCMyD2ufWGsch6Xzn7uYOjjOfr36GM+J/o=;
 b=p8ISZfrowM/NCwDtnQKqljZ1DkMZmjCWezRvcfM9K3DygrfrqyOUMwsiuJj6xEGPTvNTtqnGTwibPuRwJryI3Oof7Xa+RcsDQb1RJRC1ZrMpEpWj2OFziC8dHM/xTzowO9NAzZ9N0Z/+tR3RU5+9kxWZ5655hbDiAUcRmMGvtw1fdVNGyoth9FG5KSlfiXxmm9GxRuJUvGvW2rJBg1/6I/580zfjh5nrknWwsG0dbt38nUnjaNElOFOT1s+JVXC9Va6iIokZcxjRY7WNqPTYrBQJKQA0NSweMgRLfZwUh8zOBVIBnKJl6+GDtFO9pW+6hjqziA+nzNj0iDw9wCiZ/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DB9PR04MB9579.eurprd04.prod.outlook.com (2603:10a6:10:306::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Fri, 25 Nov
 2022 01:50:52 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::89bf:6855:abfe:203b]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::89bf:6855:abfe:203b%7]) with mapi id 15.20.5834.015; Fri, 25 Nov 2022
 01:50:52 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/2] Squash to "selftests: mptcp: listener test for in-kernel PM"
Date: Fri, 25 Nov 2022 09:51:15 +0800
Message-Id: <225d8a6c589e80c89d59ccccdbb2438de78597e4.1669340938.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <7416de705544121ada6c71199d728e8307223eb0.1669340938.git.geliang.tang@suse.com>
References: <7416de705544121ada6c71199d728e8307223eb0.1669340938.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0109.apcprd03.prod.outlook.com
 (2603:1096:4:91::13) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|DB9PR04MB9579:EE_
X-MS-Office365-Filtering-Correlation-Id: 2749dde6-6444-4df3-d599-08dace877c08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k3TDo0lIcqzCo3fNX9t1bQXxPDfDlu0imko3qc9/eOulGMCZpHU4l/JXwVYT5tqF+KufLwbjZ1vOCfGX+zKrogL3uvh9t2uisn6ws+KU9zbc7Q8it39lZHSJQtHfA+3EFkXNSfUxoAfFmgMJqzkGaNCvAyWdvIc2B4VN3K+oPxMb69EimxhniZruSa9yjR7sQ70SjM4RtkDaK+GfCZWsZNfGLOT7apNZhRX8i2Oc9uXarXqllcVWSUxBO01JYFGEo5XH29Ub44dTmrcdqSMyWO0EIVP91kqJAZgw+XLb9OlH+pjWa2x5sHzHDlYO4zCjWD9YViZMAQARVlfxsjxT/v3tHQ3h3AbCIzE6ZcJOX1PxiU/vbxgtEe9F79zS24p3BeUdQov6Li9Ej9tmlhTFn5MDjsC/zFNP/8//7ttUfkRPbnWoXY/r7q14z1SMsq0iL7ZJVaSWYnhowDdfWflj5gSiHCEAIlslss3AYrjjTKEGqIvsxupDezmvIU3L4W713oK/WbcxHHvA9WWyqa4qesIUCI+hbKYa0vmfZcGuj0uE3M96cFg1knsBETST+1Y4dWpXg6HfoDw3+jFUGcYN5HtDj8DyTIcdkbYXfJWtyis5i9nqQkdrzBsTqbFxv1ci6qWoqTqKD+n4N30RMIHPUg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199015)(2616005)(186003)(6506007)(6666004)(6512007)(26005)(107886003)(316002)(6916009)(6486002)(478600001)(66556008)(66476007)(66946007)(8676002)(41300700001)(86362001)(44832011)(5660300002)(4326008)(83380400001)(8936002)(38100700002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LX3hH+OHWMH4qs2yvmgUgJN9xHdOJ7uUKN3Akl9cNcHSHqbCLgJBoE3NlHk7?=
 =?us-ascii?Q?QB394vvt6FOHC85XjGFzaw9EcWZUT+z26tQ+HciarCC7bb3OgbPh9kemGcah?=
 =?us-ascii?Q?qVhOncApkbDScMjaWM34LH3zfB55r3GlscayeZJQKR3ipp+Yyd20Io+Qp3y2?=
 =?us-ascii?Q?ZflBIAIYE171QX+jiovN90YMkKdNuG1JWUOxAzcoesyTKPKAESBul5BmmeT+?=
 =?us-ascii?Q?W2mRpLrEd4Qs3D+5uI+x5HeDglDDYp2mQgHo4ob7zZQejH1bmdsWySFBh/cI?=
 =?us-ascii?Q?dDQnYA+bEUy5Jls9z8Hqi/2m24uv2ccPF3wE8oLTJpZU+JeuoVIt7Azxhg2k?=
 =?us-ascii?Q?Ph5uVvvsgcM+RhpC99/7Ew+8yGn6JWx2cfJ9YFSDEaqZ4Iv2NjCnQoZmFCrJ?=
 =?us-ascii?Q?ik5jMi+eCRIsZDmewoPnVBf/Ms12+ujTj0xgUCY9QJ0Wv5llpazlQdVbR5CQ?=
 =?us-ascii?Q?tc0keQyQutG1LjmEFJXmK/jsG5APxtQtx0S7YBY9dfZPMbmCg69mPQOhTHze?=
 =?us-ascii?Q?XilQXzNlfbkC2fVCqT4cbgJS/zwNchkIH+O1qixX9hfLe8BAxDg+e9m+7iNG?=
 =?us-ascii?Q?mEfcccTNflNSDZClAYNUHSsTVbtTMIqVQX/PivciFTjTWDhJXlRG0G3W4z/D?=
 =?us-ascii?Q?UrsSzYomAcsN0I7mR8OFj+cGiAKoat3pW6fNs/g+hnXRSs6jhh3/WOdkMq2f?=
 =?us-ascii?Q?SQVNrFAHoEn2iHgmUX8QXlmcf81V9iz/FK85gyjduW+lEl21If+hCpsAmE9a?=
 =?us-ascii?Q?G3GPVFrjmG53z/Xlw8PR99HYS4ON7floHAzpjCBqUOY6Nt7LCkj8AsQGzaEn?=
 =?us-ascii?Q?BjxQpnFRQoyG396dMS0e/h30hc2y76SlMe14cZy5CmaH1cz5hLYU+u1LE2vH?=
 =?us-ascii?Q?YX8hKLFI80WFTmI5Tb2qIKWCf8kWOzn6BTQozdL7zmRcNCKkoGtKFWmmhEHm?=
 =?us-ascii?Q?65j5xpshwKdpLZKxPd9acRQmorCOVeAPixRXaSLAT5PBR1LJbfIIDEvTzlYz?=
 =?us-ascii?Q?GXUuT00mfdMTz95P0Ixy6DgSP0Ed7i2t2ZZUjloL44E63Vh5HaEY98yLd49Y?=
 =?us-ascii?Q?uHgRMCWroQBvYEPD8+7z9pP/+ReMYbNW3RMvjxcQPI1QEZB9PBxZertMgAbR?=
 =?us-ascii?Q?uyjd/mGDsjPguTPhHJDPrE7+Ahgqh3OZdILLqGuG3N+nBA1D3QqEVbdwneeH?=
 =?us-ascii?Q?5EsPQtdYJJx7dvzomtJSIQ1ZaAlmXcAjRmh42yzHvh8fuD5Z9GJz7WtP1Gs0?=
 =?us-ascii?Q?Ked8vP2vjE3IPuw4Q4sbuuLxbMR3kPJHth3ml8eEEotT4IoB+/wK8ktdqz3u?=
 =?us-ascii?Q?q78Bpm/KlWedn/dWgbYy9gECPnM+NoE8DnT1LTAu3FplhWHx8Abzj/W/vmMm?=
 =?us-ascii?Q?vkaETEjgoXqmNBAMZtWk/T6BzZ6VBNUbnztFanNQYT7G9uKhOy21Fd0RDtSL?=
 =?us-ascii?Q?KiOopW4uRZBpaoQ1UW/xNCVMDfA+9w3rT83NEb8Nt5aSPlhVBeK3kXrvkScV?=
 =?us-ascii?Q?vCj8Sb90qnB5I40fjI58kAUasI7SLdJSGFXVFbuIRtFobjC86ybfKbu6/hx0?=
 =?us-ascii?Q?zUNfiI/mFiRhn6T3hCj5sMH+PSoZfY3lf8MDXb4BFEyIm5O4/7G2fLn9uxKp?=
 =?us-ascii?Q?HQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2749dde6-6444-4df3-d599-08dace877c08
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 01:50:52.3988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1zJCtN7gD08PdOnKkAx0HXM/LjjyMK2Dab0QVbUGOdt+RFahN2leVZHrr2gGur2Ldak85AJAHhXmfELQQebfog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9579

Do some cleanups.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 89a30225bbd7..e24884f9c039 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2541,7 +2541,7 @@ verify_listener_events()
 		 sed --unbuffered -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q')
 	sport=$(grep "type:$e_type," $evt |
 		sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
-	if [ $family = $AF_INET6 ]; then
+	if [ $family ] && [ $family = $AF_INET6 ]; then
 		saddr=$(grep "type:$e_type," $evt |
 			sed --unbuffered -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
 	else
@@ -2549,12 +2549,16 @@ verify_listener_events()
 			sed --unbuffered -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q')
 	fi
 
-	if [ $type = $e_type ] && [ $family = $e_family ] &&
-	   [ $saddr = $e_saddr ] && [ $sport = $e_sport ]; then
+	if [ $type ] && [ $type = $e_type ] &&
+	   [ $family ] && [ $family = $e_family ] &&
+	   [ $saddr ] && [ $saddr = $e_saddr ] &&
+	   [ $sport ] && [ $sport = $e_sport ]; then
 		stdbuf -o0 -e0 printf "[ ok ]\n"
 		return 0
 	fi
+	fail_test
 	stdbuf -o0 -e0 printf "[fail]\n"
+	return 1
 }
 
 add_addr_ports_tests()
@@ -2599,8 +2603,8 @@ add_addr_ports_tests()
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1 invert
 
-		verify_listener_events $evts 15 $AF_INET 10.0.2.1 10100
-		verify_listener_events $evts 16 $AF_INET 10.0.2.1 10100
+		verify_listener_events $evts $LISTENER_CREATED $AF_INET 10.0.2.1 10100
+		verify_listener_events $evts $LISTENER_CLOSED $AF_INET 10.0.2.1 10100
 		kill_wait $pid
 		rm -rf $evts
 	fi
-- 
2.35.3

