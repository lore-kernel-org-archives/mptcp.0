Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48E11C2B
	for <mptcp@lists.linux.dev>; Wed, 26 Apr 2023 08:56:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOVyUNRWeJ/Lof0oL50AzbhzrTIW78KfYDN7dMgiJrfVfBGwfopgZEgAgpBUF3uLzoNlP2KV6UoMfipSVdFkMRiaoh0OjUI2dVbPFxSblO8rHrASG0GdECuRm+8WCIbqkuguSwlG22CbdUpKJ4Lu+MvzOHsX0+JznH+U/0doe97QBqvTT6xDV9jWPLUJrITndoT2AQdTzqM7VgaxDRTeVE3WPa3MoqXeIolGJhUStojhIZ2sxCA9ruBCQy7Y31gWi480uu7U2SkoQ9v8sGEFbedoCANpHqWxlpkWpAc+SSDlFqeOTZllFC3dwIFcl2wGVNrQA+ZMeBs3HSzsUNVlLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLyLKREEUrQB/v2kLSW6hVNPgKS4DjkDMfexn5bUheg=;
 b=cTLeL+boYEKCRUOKdQC/4RNv4wl47cQdwR/aJO86BNx7FCHJSQaT0sCyD0nHLzaGlDjKovOiKRlu8PGe59I1+rZ0NHIlAGcQPg2gnECQsLrnfRS8vNxbp/M86fLCBA8G7dHOIslz+AuuwvdfJrpNYrvg+9HgvmEf2f9mvR4/vl1Don36QIqWFc1TnbWey2Wq9BJhuKGpAEljTQpUxcOEAGoqKQV0oDXzEfgFlbL0slGjQksZBIXbT+w3OG5Ay+XgkwykOmAM2/i2EV+fb4BG5Q6JAVZTAfWI5A3pLnDB6VW949rooHEPR4mxtQdc9PIL9LgjzXA6vPQbrN52nsi9jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLyLKREEUrQB/v2kLSW6hVNPgKS4DjkDMfexn5bUheg=;
 b=gkE287COvyzWzd+k4X+1Bukgb51D+ebe1Os+HYWXSkXU8Fwrfq2yeoi4255RccGvFdSIa8loUlZ2Xb3ZJvz9SDc5AinWoN+/ClbJcIwp/6rrDvxSD9bXeq2dzQUGbw6P0Zb0o9+nQauyxbOm+X4agnGX4AlEWmS0Fn/oBPr8jOa4qBwVlzgrToztvQEH56gCDRqsR1ZzrtyPnhMjWYA0LD3KaeaReO8xnTTpTPG4VbQRysftw7+P12cvMOtE3LJDHJ9sTJhY0MmcDsk6XEORK8ZBDknhZcRXsgn14M05VNJxHpXOrpepyclyyiBByoZ9VJoQEOjOZNG0EfjX20dT0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 08:56:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5%6]) with mapi id 15.20.6319.033; Wed, 26 Apr 2023
 08:56:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 2/6] selftests: mptcp: update userspace pm addr tests
Date: Wed, 26 Apr 2023 16:56:23 +0800
Message-Id: <2663cbe9ab1203202f2ae587475abc36fa93e4fb.1682499136.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1682499136.git.geliang.tang@suse.com>
References: <cover.1682499136.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::31)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: b7ea0105-ba82-438c-9190-08db46342d0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hp4uK13hgEHJvZ5qYvfPQCwDxQ+p5Qq+Bp6k2+AZ+uU1ikhvLbLVeW4gfzpVPRKsLyuTB5DtVSo1gcCac0TSB/uNodx9SMRys1P7n9n6zWCZKWwe4STUvD/4AgKzQCE9/ye3SpIn43Vw9NUZEN1SoTvPT/pgsfPZWfnALbonhM3P5e2K2N1ZfxtZF+eyMCcpQKsjXB4EzO5VQY3HMm+MzOS76kCEZoA+wY4N6fCLAzfI8U8KP8nyz3DjmyaIDzpxaXllBvi9FlolpXsCHxzQM4pzSoFEuuFyd8y2NKhAun2VOMJCzOmQjoWxm4/rXfgdXFCJD3fwLrnv4JYhmwVi54Qyli2t+hWXaTtL/qaEBY7CDZLb5jwgpNu3nyBabJaoFHL5cQr+fUPFigB/4Ixhd560SXWiL2h/IbDqkuV0xzSIckVSsafSGc9LJnp2w33fpe92G+OaBvkQVufIYx9e14AFOep7h2XhiPEPWBJLJGuuekTNNa3vd0VKTuemuwADU8lpXUZibo0y7YSSHA4MrB8Iliy4phe4Nb7isM3xFt0YQSmomtd/U9vj9GSmzyY7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(5660300002)(6916009)(316002)(4326008)(83380400001)(186003)(36756003)(2906002)(478600001)(6512007)(26005)(6506007)(107886003)(15650500001)(6486002)(6666004)(41300700001)(2616005)(8676002)(8936002)(38100700002)(86362001)(44832011)(66556008)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PBMgxmxpLyhyqLA5OOUPWZwjY98bVh9bcnfhyoQaoMimHSe93airbjrRuHA1?=
 =?us-ascii?Q?dmiwRD1HMNlKcRJiG9ZEexO4RtT9YegdvYebBIoOjlQwJnBib2NrTRxcJreZ?=
 =?us-ascii?Q?bAVeQ5WgvIEdmxzdOw2SRlB1f+mVpWnTnKV8iQP9WsHzQvVOALWusSGj2b/H?=
 =?us-ascii?Q?X6Uazo2mq0a3TXylD8xH33cNZNqHaB/1uZHbdlhF3o5rgAyzUFRz4U5kTSi9?=
 =?us-ascii?Q?k0+ttD7mJAymLmHhHIDmLuDTPjT4Z6c8mktgvjGdKUp7KLfv33ace1V5cS3T?=
 =?us-ascii?Q?NE9x89Rsl7BdmBaNP3X9XOe2j4TpoCm59UE7HKDcd35O8NLzQWk/NoJ9j0MI?=
 =?us-ascii?Q?pu7wB9MdKfSRlS6xZa3m7j+AUIJvfVP/kJVbE3Tv/8CqdOKc7pmgAMey+bkQ?=
 =?us-ascii?Q?TZkIt467FhyDNcNfwFfZPxXfXQPZ5m6+0WIh4C2euesiendLnUgxU6SecARy?=
 =?us-ascii?Q?ojg3UrAJVjM8msEdSr0asosb97REfuyWLlsx1K4u5wBswnL6c5meVg+ZI5Xt?=
 =?us-ascii?Q?9NNVTumyVgIzvitfe1V6zWL/Owh9fID57NIeSqzo9LLEhc+Gp55jKJACGvQi?=
 =?us-ascii?Q?pqKMXKReYaHuot5aOKloCLyhE+wUr9ECl/y6msur5jnYUlAT6UdR++Et/DZa?=
 =?us-ascii?Q?ZWoRX5ZgZSd7FBtcWs9xJqUjaWdpK51fs2aF5kzHpGnzCBLDtb0VCcOczWFh?=
 =?us-ascii?Q?3G+JqvjzUR3/B+kOPSJcOtoPvpOqm7pzAI+x5SuB5ZnNriJCpjXrSxeVBep+?=
 =?us-ascii?Q?uihhhRDqEl+W8rT7nlnVVs0juqd5DxL2ss/LlhtEzfqMONKNOx/+gV2CfC8J?=
 =?us-ascii?Q?dV0bwPyU9R+mjoJ8KZNvSs91FticEqJyhm5ifn+XgNYe2pxmYC0AOraM2M/x?=
 =?us-ascii?Q?m3UZYktHFBHoPDg1KIqSq59IxQhBG8tcj+Ip2MROCpnsJXTKeQa2YXwKyxfs?=
 =?us-ascii?Q?DXIxlf4AZ2JTscbDo8gA7JHKHahYYqv7ZKfJHoXCRHEcKNArxk7iPASzFKHq?=
 =?us-ascii?Q?mTIWKjSO8iA3hAaI/HaHYWi+J26UydsK/+Z7kuxUy5Cjw3wn4Xb3evDCmOoT?=
 =?us-ascii?Q?zy+fMQgXTNgleuXzzC+pXugP970VnYTJGjhftsuMU0b4TwC+r3h7GAgc7lH1?=
 =?us-ascii?Q?2BIldzUUe8XjI9b4+ZGg0HNLumpaHtHylMzfvv5l7ZdVAuEGX5g39PodlEST?=
 =?us-ascii?Q?WkLrXFmEmuaYK0kiUGSJQenf5YgAHZbY8ct0EfI7OwalMHTGJfz39pCZuSq5?=
 =?us-ascii?Q?+8vh/LNI0nNtDnaGfHBC9KwG+TUjqPPAogkqXyqe6mDEh7KoPmwhkjFh5F3s?=
 =?us-ascii?Q?IP2PDXrz92k5g5TNkKLH0u8KGXwOiw5pLTsfBBuD5NbnU6sMQ/ZYv3vLN2nT?=
 =?us-ascii?Q?M5IFOy6pXeBsP/wPUPQwhCnBM5mG3Z9FxLGjbxVX378bKs/uX2PaG15CdhX+?=
 =?us-ascii?Q?JD6geejr9iyNzsbFdNfKsXJQZ0iZLl15JHf+Ch5sWIz1U4HEC/97c4B9Qsm1?=
 =?us-ascii?Q?ywSRhMTaItldYTsLIfcQCKH5oxkfhZNWpVMwSQHtenYsL48z5dGqJPXheH1l?=
 =?us-ascii?Q?8SfDQ5jrPQ7+zs6tyzmvcdcO/T7NLFpmes6ALMwv?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ea0105-ba82-438c-9190-08db46342d0f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 08:56:51.3081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kwj+mSX9v0g6N5bY076Aw7XklP/JsFuh5N/oAElTM02t+pxQoOKGBt0YHBaaIfL5Nqi9xdQpoyyuuhcoXHpYqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7500

This patch is linked to the previous commit ("mptcp: only send RM_ADDR in
nl_cmd_remove").

To align with what is done by the in-kernel PM, update userspace pm addr
selftests, by sending a remove_subflows command together after the
remove_addrs command.

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Fixes: 97040cf9806e ("selftests: mptcp: userspace pm address tests")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 26310c17b4c6..67d5d724266a 100755
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
+				ip netns exec ${listener_ns} ./pm_nl_ctl dsf lip "::ffff:$addr" \
+							lport $sp rip $da rport $dp token $tk
 			fi
 
 			counter=$((counter + 1))
-- 
2.35.3

