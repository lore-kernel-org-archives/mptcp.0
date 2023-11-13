Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2080.outbound.protection.outlook.com [40.107.14.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B501F8483
	for <mptcp@lists.linux.dev>; Mon, 13 Nov 2023 02:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="2EHq6syz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HD92Z8mD9RFdgNfWubfEjiEBs9LXmPxZeNMlM5xHBnP2EyfQ5GflHWTRu8cCN6exwDZI68xOScb2/yqb11pYdqK8gU55Pi9+tbtoc3d1t3r+qpju9DMra3NVKRG+ZyIslJ25Lf0S0Rr+hNWMxxa3wjUXmc81TFgE3XAAUuBoKtqaUARbBcZUSaTatj+kH5GrSxS6g4fGQkKuvaQaHmd4zUSxua4DrI4N9hYeriEox8hNZF8303DQdJZm1n+hty+l5VJE9F70lKgcRc2ro5rbBHDL1uLXMJHfhDjNl90ki4kUJt9QVt0PXNfpSqoWlzToZVy0q1uzWDq+E+RAocKsfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hnm3qy/SU4iPkOBcU2U1Nh5IOlmpe4aXFvC9rcYyfTI=;
 b=NcS6W22lklJMiZ/p6pwcPtoPEmXvihBggfs6ooZCAkhb+grP1CNvDtWBhjHnh4zcqGZXEn/WLHouTEstkTaOJSYp1S1p7niM5c+rGIVpmj+psygrpVWFZhK8HfdlWHN2az9WJEVPgB66hmtmhF7zZJBtdzsh+XDeacfx+vjLaK5L1G/brYdOC6jNMi2Z5dvBr/71TV3LFRVO40F7d5/DAszEpzu5BYOShvBguTcb5W69khJSntxP6iTUbtdvnqtKJyEt6JV0sd/mQzZXmi0rzpH1TAeHsK6zDSwRTuI61Lt5iSVWmuuefg9KRbSkh4pRXkANmmGeWMf/4GmHQAaBaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hnm3qy/SU4iPkOBcU2U1Nh5IOlmpe4aXFvC9rcYyfTI=;
 b=2EHq6syzryhDoLM+2JdqAfsWZKdU20kb99zPuYP0axRN6FNjbXirxpH9ZAMymlPKedkU+q6c0vBr8qt9Ki2cVyNHQm7FgchQR1Sjx3qPrBD08crl0Sb5qM0A9IMEFtprCpYsMM51KXFdRaxcsfySj6SbkUMJNidD+/QMPrf8VkFtXUAXWigWCmuqe+VB2AcLXq2orAbBDAj63GAS0Cigayzx+QC0GaS15kEhM3wC5KNx5X0fxy7qrWf8N1lyWYi360IVMp5C30A8U2gx2Dn/mfW+/Ow3mjjcYoe9XI5JRvTNPxHUmr3UhuTN0HxMNJKGXLj17fwBjIN3xfZrBkCe0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8895.eurprd04.prod.outlook.com (2603:10a6:102:20e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.15; Mon, 13 Nov
 2023 02:51:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Mon, 13 Nov 2023
 02:51:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 22/22] selftests: mptcp: rm userspace addr with random order
Date: Mon, 13 Nov 2023 10:49:06 +0800
Message-Id: <27e54f7fe28b65996b69566847e9cc8675a43d43.1699843617.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699843617.git.geliang.tang@suse.com>
References: <cover.1699843617.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::15)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: 9118a550-15b3-4264-5459-08dbe3f3605f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M0aoZNjdOjAPp+LZNLRfb8J5uWVKZHGQJmFye5b7mkoS9lbX8Dk5MEMWsZDItfD1XN96ofQfiXmaxZKYk6NnrDzM6Epqz9OIdfwe44yTtO7Nl/FjhIl0ML9hmzzdlXuQkY9NQYuuAVIdNOBT8yAeukjVoeKEKct54SGFIo1cfwiHGF6dKVX2J8+DMOZEdH8+KjcZrOHk7HFFLaFxrezMtQIr5cdK4E6WRdKvPEbVQEmO83pKffWyANCgLLVo2NPftbUJ7UATTrUQMv8eB5917pld1SHT7uWf2Vfni+mKGWDyykeFCaAW9nuaAeNH7GQgJ4ZwnOlF4sEA10SAmuzqEByTSS68GVnYpk/cnqkvl9pzsGwu7zYCXqBHXkWBpMoltCYo4ikVJ8heMFclwbOBVtVdK0Lo8LexAptRBF342tSgMnsZ79alliOel9Wm84lnpZAiUmm3HfwcO0fKitZQKEoveBGnu1/QGTUS60GeOxIfVcnyvGhnONpowi78ITuCq4NMdlTq5ABOrfxxtOgpDWKNJihjpdJ7dwSKD2lFK+molS2eNzPA7LG18wEFWS8X
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(4326008)(8936002)(8676002)(44832011)(38100700002)(66946007)(6506007)(66556008)(66476007)(478600001)(6486002)(26005)(83380400001)(6512007)(6916009)(316002)(107886003)(2616005)(36756003)(41300700001)(5660300002)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L3bsw+skNEK25jwtkIY0hhHXIml/wZLnxhRNUGrzIhKH4TMhUlVbvs1lahOI?=
 =?us-ascii?Q?ngFJUNxndP+aLw6+KBn49XNZrV2tP8rTiKoTT7EwS8F4bBuTlxja7Xq/nWoJ?=
 =?us-ascii?Q?4V10D9eD8hyhj/mObugEf3m/aFn8S4yZEkJ7HXUvlI8EPK+L+ri1/3kuDAsV?=
 =?us-ascii?Q?HR1JsAJARO4DO4egd7r6DPm0oVm3/8aKoh5HsWNbRBjCu+jRu+ki1+RPgJK/?=
 =?us-ascii?Q?/c/kLzH63jdY0AV85k3DZ7mY2r4dE9ViH1u82rNtOaunir0ysI3VLAfCF3hs?=
 =?us-ascii?Q?+b9Ipusdb6vOhqmHBa/CTj4UteeyeQhCtw6TIpDOPYFKmElR7gD5AWo614kl?=
 =?us-ascii?Q?hwHh1ngxO4+y5JEmZLmCVvBqD+hWe4O2jzgaLpgFtvf0xWNHMdulPt/l6P5m?=
 =?us-ascii?Q?0Dvw91+GsY78isGiS3kgQNlG6OILkj/HGuRLI8gsmZ5EvEzyOwPrq0pCI7oK?=
 =?us-ascii?Q?GG/QWnyJdbkgmtqwXePeKIhyXIVwmdot4WnBBqIPC9CIPp0jMbbuQLD/pjqJ?=
 =?us-ascii?Q?6A3Vlti57/utw3iQ0d+HUoGzYFO8lR7k6KEyHqq5dCFIjX1a84X8rEep/kSW?=
 =?us-ascii?Q?6CJFmf6Vyibktt19LZM1wwvcCP5Qwevy/iUQ/3dYBoJxJXwl5M19PBNKivCx?=
 =?us-ascii?Q?FzKEurWDBVj73mhiDqpVI9Z31y/otX64hH5ditKnSH0OV9VGguYqiBkRjk/+?=
 =?us-ascii?Q?LjO0AVic0qJhd66eR8gHIQXxkvMdK2IBOWUNgZnFMVI5koVpowwe6BPCt/+c?=
 =?us-ascii?Q?LjjJiqDqQB8GpfMvF+pUKUWPI+vDWOw6huqWusQphgi/Zsxv3OqopZsykqL/?=
 =?us-ascii?Q?Eerr2oCdnbwUsQhNlLrgin5ZuH9CpyKRk+P5DP1jEP5vUafY6BWnnR54ADeR?=
 =?us-ascii?Q?jBvnywpIBRYwc3Drt+c799DnFH0/H1rwxw60tzII+k9oiRt9tDFtaSPWHaac?=
 =?us-ascii?Q?9lIa9ZIN08FfjUEJU1ij2IKF/exmmpDtcEVWRFb5DW5EmEa5oBQAkh2RPkDJ?=
 =?us-ascii?Q?mmRkX+86ZL1Jjn5xxVIRF/HN8GGMIYqOQ524RlqtI+N6W4EtzICLfbSCDoL6?=
 =?us-ascii?Q?4WysXEuyR06uqrc6TQBlT02f0b3e8NHGUeBjq9ZYnE3fv0zZjccdlnkwBM1O?=
 =?us-ascii?Q?mj4RA+uOOUqnSVO7WkXHYlaAO+DuxpoZHm93oKvl3iAMrrEhqR5jzn38EMKr?=
 =?us-ascii?Q?rqvWrUSit3QdzJmNVuK/NJjeHLHqFZQnpukMbTKIj5CETwKAwbGnff4rZLW+?=
 =?us-ascii?Q?nEQcGSdtPMEr4QbCjTs0IF7Ai5Dg0GwH+k+GH90AwcY0BwZi59XIDO6tsuqZ?=
 =?us-ascii?Q?fIhC4j8ZAD2eIogi3U0YN12qTHm0dbTn6dQxgbqxtaSzcf58OSIFzpA3MO72?=
 =?us-ascii?Q?ZI6LEj43qt4gUl4uLulO+1gl699jqGkeWhzmnE1TujRGELDciYjJOurd98TQ?=
 =?us-ascii?Q?g7kqHBPVC6b6UTVWgfsT9Lt+ye9OyQQSS4DhBFw8SfSjYi/JkbkOofwCuABY?=
 =?us-ascii?Q?72DG5NbWIisGZeAnQZN1mXfRw159IzcJqKCKLBEyz1cV1JvBG8+yZJK72k7O?=
 =?us-ascii?Q?/kiIA8ZLj4Ni+UVQSzH3T4AMTKJ8GJ94ZYcs2XdA?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9118a550-15b3-4264-5459-08dbe3f3605f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 02:51:03.7910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tCumCjcQoXe7Ama4OrrJ7KX9iDZ4MZxK1CQS74pJcQX0Ii84FTHMFXfQrL0A4oAuI+rmLHswytqUcqAsf8nfyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8895

Previously, when deleting a userspace address and subflow, it was necessary
to follow the current order of deleting the address and then deleting the
subflow. With this series of changes, addresses and subflows can be deleted
in any order. This patch uses random numbers to add this type of tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ada523c160ad..e7560c6f9e3b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3413,8 +3413,13 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
-		userspace_pm_rm_addr $ns1 10
-		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
+		local rm_addr="userspace_pm_rm_addr $ns1 10"
+		local rm_sf="userspace_pm_rm_sf $ns1 ::ffff:10.0.2.1 $SUB_ESTABLISHED"
+		if [ $((RANDOM%2)) -eq 0 ]; then
+			$($rm_addr); $($rm_sf)
+		else
+			$($rm_sf); $($rm_addr)
+		fi
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-- 
2.35.3

