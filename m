Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D0733CC
	for <mptcp@lists.linux.dev>; Thu, 13 Apr 2023 09:13:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y01p9EYORjTfEU4hIdGdVAGzdrMRFvoHB2fgo07+ltdNGPLnIFTwmuU3Kl/OFUORp9Gz+xKZWljAOLpdO5wJHz3vnaNJ98lz2K5/NOYkgsCUdKGIleSJNc5to6FnK3MRoBcsgnEFJIAArzrwPETTCP+eNJiwhtlbQiSjFj5dH3kmjDS0voeCQQS1K+V70c1txhIUX+JWMVRvFjxBUGqs9n/TbnoCK0Ui31/9SqXpjWkQJhrW1GI0uO+aZgt19COE/nU4erzNyY6J/Kr/4Hv8wgoDzgam2DfYhjdEp9UbSLpZacXpEjFsfxUBYkP0BHIum68WVR1cvrWXXuqp99e6Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fu9brzMo/aLzDSz2mDIvZnOPM7uvP7JXP/Rw1h0K828=;
 b=eig0u9i9KCLoj4hh/A6PDJR2P94SAPMQiLqpwwdXEUP/GnAR3znTr2Red81cA8tdWymKPyYGXg2y7IoPQt86K7AvUJTYxYuAFsaYSQ65w9qh/Jc4jHzcb0z8ktQCWQUtC8UPG1FrTajkvbvs/DKWA1KjUDCY+rrT8S3EC7zp/Ww7wF/2gk/JCm4N/J7Ef5Dwk274OkL5eEMr9TczXTk0M+IP9HMfxuqKLbV8OQY8bjn0UlKYCOJm0UMR675YeKUe2qRwdqTVXm8j/4lLjefUazrF5HbOJyq+VPCQ3ftnDFvuSki96J59abBGelDzb9EAXtBiA3q0kGbyjTK78RNJvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fu9brzMo/aLzDSz2mDIvZnOPM7uvP7JXP/Rw1h0K828=;
 b=ptW14mGDV26aMntgn4oHMndTD0ilox2nGJCEuv9Zb63EyBUFIZYv37FAQI4+B8sXq5QgNXaCOxrspjr30afnuT32AxTp2/k4bVFOzDnvFWjORDsOkkp5fG67+15VPH8V7VDsk6NVBjOu5z5c0knzYYNgw3wnmxZQAfR3HLenRCpAqESDqyGSWMR3352Bz3X+gtrAeQNS4qu57/46JjR+tbqXuvy2nvKwTeAcTktLSeSz5f5B2auxOIOo5iS4tHJHMJAnMo+aP8WQqjhA2hE5dLkh0XmyisCqslD35eRTUklzuO9FurElT7ROgQxIeuAgtwO1rVqb2QbXZTLG+wkmng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7339.eurprd04.prod.outlook.com (2603:10a6:102:8b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 09:13:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7feb:1f7:3ce8:327a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7feb:1f7:3ce8:327a%5]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 09:13:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 7/7] selftests: mptcp: check userspace mptcp_info
Date: Thu, 13 Apr 2023 17:12:42 +0800
Message-Id: <f22b1dcee050479ba19ea7b8e95a04da2c30acee.1681376983.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1681376983.git.geliang.tang@suse.com>
References: <cover.1681376983.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: 84e3f74d-8532-4658-9e4b-08db3bff5cc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CMGmnMD04MarUKr8AQC1v5xt9XPkDp6dYTIAaGUgVf+1Gm5DibfH3rts1JVgNxxuYbmKTBiktGoI+g8QBwwD5Av01kq+jz2OVeqexiqETZQ2jqTxS72qR13qa9seIKjZpQWHdJhFl6ipJDKJTaLhRtccmM49T37loUkJlV3qvo24NUzVvvPFTHY5xV9G8RPZUeb8GKG5YHOd2nhX2/00nMBg7TyYntNfsKOgRwBaCYiyQuiQ2d76IZ1hoVPUIRKOpUSdcR+LQ47tmDkqjY75Zk/fcHt/cPNFC3SKLGPzTOwjHTt9Nfa6M/SHtpXW7+T2TgxyWXZNPMzDJKfM5EvqUfaBSfG2SAumbVzDSl0amvnDTpoAI7Ef8FC+4+/KrZZjWYpnUi90yCB+1swhqkq2hDTNp9+7/Nq6CJ47a2yex67EAK2Y2Hy6ij3Vaaq5h9iFUcEzR+n12+h2xrNe/wtRju/R0sgyWyLtD7sXp2SQYIV6qxyhuFlWobIsddX4tlLcrIbrjQ3Z9GwfqtAR18oTdkG4NxVX54jyIAzozmIdJ33ixggaPsoOel1fe2yH1Dmy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199021)(86362001)(478600001)(6486002)(36756003)(2616005)(26005)(107886003)(186003)(6512007)(6506007)(38100700002)(6666004)(316002)(6916009)(4326008)(66476007)(66556008)(66946007)(2906002)(8676002)(8936002)(44832011)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aWd5c3+nIe+7QtkT9mHMTEjEjCaCr6XerDhHxbxVxlc+HzTfB8huasydIvIn?=
 =?us-ascii?Q?81ptaS62GOP3zllTm6C2JGi80lbkjdjdv3rY5yqLgMSRHMrggxVGN5qCAv+F?=
 =?us-ascii?Q?lBHSqB0szkiBwmZqpW5DLiTVOIesi28T25SL0A31wKUcV7FXWIKb5jkIlJ+s?=
 =?us-ascii?Q?ZceTQvigLX1YHFQ1z0KW4F6RaLO+xWj2DY5ZgmudJduH4GYY6I7PQiXPBgpn?=
 =?us-ascii?Q?IQoZygMMJCng9PjoNFdntIBHRuQX2HVBnb5yjH5f37pL8EVTw6CUMIvw0YT4?=
 =?us-ascii?Q?ZbCSLoVxvundO367uvqUzaA+oYzTJrH4qkQvlRSguFM5eT1bict9iHBIzXOm?=
 =?us-ascii?Q?6DJo0QuyMPlzx5IPYSpIBfXu7Q5FGckjJJr4fWBSYvMU4SSm1tCd7nkfJ3wN?=
 =?us-ascii?Q?Bb8nw2y9wsTbJTpGIMkCOnsksbNkfzZ9//DV7cVDBcuuMxr2YclPM0rdSPUv?=
 =?us-ascii?Q?Jpoo4cRaXBqZiE/bXqkf3jjqFyKfLDUYcmutzbiqLjVGeaoTMvEy7dDwZ3yO?=
 =?us-ascii?Q?mUAkGZgX3S/x09AnCXjAxr24p9eGFCWxuQEhQyj9piWHYBBsOKpff3ddRGvS?=
 =?us-ascii?Q?T3XPhNIlTdxwq6Y2j7SC3Wqx9yVsS3zUQQtOoWIXPv11ruh8xdA2O0M3c2P/?=
 =?us-ascii?Q?MlDTLgAntst3Z+QAjol90N2N/3DAwrZGWbkm46wjhMvn8UnC+M8KnE0Tt+Ol?=
 =?us-ascii?Q?EdE28f/7iU82cEWv2FghvDtFpwdPDSco5CtOyHokkYBoBXnARRSXPUIF5X72?=
 =?us-ascii?Q?6hi6icMjXB+JsvOO247JgIGk/pB3HGZcMt48zh0Fy1KvD8Z12EhBRjL5IVu+?=
 =?us-ascii?Q?THcnq1duC5mKsSum2IzHyXS4bGIgYuqBX3kTHuMV6b/OVw22orpipJuvlERI?=
 =?us-ascii?Q?5UMaq+x0hNgfolGKdFjDjoOktHUi5O0QiUsNPiq6ye5cMdw4+ZxSZc/cUyIa?=
 =?us-ascii?Q?lpEOjYQ2DkBaL/TNfJTvV4Ycw02yV9rD9rhApg7QFob3vWjqr+9OHTzkoB4f?=
 =?us-ascii?Q?L+S5ItnviNI/UR3sELMtrCX3siqQjJTfqKEe6HEDBAPM2I0LbWAmmu9l3sV7?=
 =?us-ascii?Q?fRiYg+BNjtgfX85ZsukZpntKFsH9qkov4amuvuCAY60qGR7M4Zr2mBZZHsQC?=
 =?us-ascii?Q?r00TTBNzkxXri3EBroio4cp28nC7KkDEuZcS5pTabUuBYX4PjuzDkrY7FbIE?=
 =?us-ascii?Q?IkuAuDXqnuJ20ejTP+KXG11BH+/9Np2FYJ/+swwpHZyk2tUBANiP0BS6GGSY?=
 =?us-ascii?Q?LFGTH4fn4cxMld1AOnLLqfCHpS0mKzpaBHqa33ZD+ZqNEIpzHdQ7/mbBb4Vr?=
 =?us-ascii?Q?oL+WsARR/qWUp1lqky9CbXjrhc9s7xL46X0WdYSOzHsGYou2BhwCK00fSlXL?=
 =?us-ascii?Q?TD0t03hcAC9Yz/cm6F+w2udD/Gh0qRkd1K9ZD1rJ3w9Xdd68TmPi9cr/vAGc?=
 =?us-ascii?Q?Lh79M0OIL78RainGvaeA7p+9Rg0sc6r1SFSz0ylgxyFncWGxK+jRUz8Eb7aC?=
 =?us-ascii?Q?gBeIhLLP+nviDtj+dV5/XCN8O7D8yzHf5i/t/1urNMfJQoYeQlNyaNgspgle?=
 =?us-ascii?Q?4sZ80hclL9pqbqQjrvfh0jQvZsjs6XPc4PMnB0E6?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e3f74d-8532-4658-9e4b-08db3bff5cc5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 09:13:36.3654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQ23f4oCcN6zSyeGAHzQwha5ebV57K8rC0Wl5RKBYPPvP5BHk/pRm6L6TZjvARh7qU3K8+34+8toJUvH56uCrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7339

This patch invokes chk_mptcp_info() to check mptcp_info of userspace PM.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 072f77b6b206..a5dc64129422 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -842,8 +842,11 @@ do_transfer()
 				tk=$(grep "type:1," "$evts_ns1" |
 				     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
 				ip netns exec ${listener_ns} ./pm_nl_ctl ann $addr token $tk id $id
+				chk_mptcp_info subflows_1
 				sleep 1
 				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
+				sleep 1
+				chk_mptcp_info subflows_0
 			fi
 
 			counter=$((counter + 1))
@@ -906,12 +909,15 @@ do_transfer()
 				dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
 				ip netns exec ${connector_ns} ./pm_nl_ctl csf lip $addr lid $id \
 									rip $da rport $dp token $tk
+				chk_mptcp_info subflows_1
 				sleep 1
 				sp=$(grep "type:10" "$evts_ns2" |
 				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
 				ip netns exec ${connector_ns} ./pm_nl_ctl dsf lip $addr lport $sp \
 									rip $da rport $dp token $tk
 				ip netns exec ${connector_ns} ./pm_nl_ctl rem token $tk id $id
+				sleep 1
+				chk_mptcp_info subflows_0
 			fi
 			counter=$((counter + 1))
 			add_nr_ns2=$((add_nr_ns2 - 1))
@@ -3149,6 +3155,10 @@ endpoint_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
 		pm_nl_check_endpoint 0 "modif is allowed" \
 			$ns2 10.0.2.2 id 1 flags signal
+
+		chk_mptcp_info subflows_1
+		pm_nl_del_endpoint $ns2 1 10.0.2.2
+		chk_mptcp_info subflows_0
 		kill_tests_wait
 	fi
 
-- 
2.35.3

