Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2077.outbound.protection.outlook.com [40.107.7.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0A17E0
	for <mptcp@lists.linux.dev>; Fri, 25 Aug 2023 03:51:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hR14XuNtZfE1FJpF7aLreDePCPD4Pomi2bpSI5tdWe2rVgqqml8WavumEP2itDxQDewEL5Z4SO5Z9v66Hr5ZfQW2nRIS2BGllFMwhQcehkADf7xey+o+yOGAAPRFSNJ9CV5TCfdor2LYinj7cJLUYSTgZZc5KbRm48HOEDmtd0kStv/pJWzTZet/y6d5/Uv1HUbyPR7TOuw0cDyUGd/6pnw2Hq0pzF8yUDQaz2c+J5ynZhGEsINJgvnG6FrP2dye74KOvX1ArA1+y3lUO+PNLE0NRA/H5NhTntjQZg+DVzualKa1nShAlOFO+Fs+i9UmGd0mDzibt4duQ6i1KCXMmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBXxv2ywUPW952DmJvFNNo5jkOBh786CgXUKtBJ4Hj0=;
 b=MwgZRYIThAKFuXs7nvL74fY4C42fVatmwaEKGuhvzR+w33Fa4lPTClsWQr0Qgk8x1zqYUXBcDOW4G30Zk9x8PjqG5T76IsJ3L0BaN/gOKKyG+AWcrBAljc/3mB3+HXD4Jl+Qs++ZAJSIDO8os1Xds2xT6/4ipvK5d628/nbST6C7fU1y3QHmr8blYXIn+5hifRBwR7JuDJJXSHn8eJaKBxFa+fKoBa/9XGN8GuXNLWIgi+F+5LD/51G+M7EstFMvS5Md9DrBDsmZZmuSHQjYoTRlrlhAUfTXAAKQu+Zkv0VJW7vk66fjfAqwxz/0R2YC5xA8VWElJ9UUZmlohpyUcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBXxv2ywUPW952DmJvFNNo5jkOBh786CgXUKtBJ4Hj0=;
 b=AfXG05uahazfmwsmp3ViYjC0IXc581JcICGTe5l79sMyhynZ36JIfM+tOCgsfeWCK2YNx6MtXlNrT234DcfaxFpT8pfT4Il68789AcVcM3AWqNXPWUeN7Sy4zFk1j2ncviTSshKucZDwpbs1NzEKQPMOUCQp6E+Ob4oHAu6TDlGDohWG0433KykUitgW+hX+EcVgkeQ/ISIVVTLbBQY/OPWyA1l74qZqxUrDgNOI2+ngIl3NaV7bnOH4hSH4jUzKksbqwjU7GSoHNsBPZZRQm1TLebQbxyhd3KQq29/1izCjKzu6UGMUeXcDMsqoLusuFeMBGjx/CDoaHik4GNOmwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB7091.eurprd04.prod.outlook.com (2603:10a6:208:197::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 03:51:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 03:51:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 06/10] selftests: mptcp: userspace pm create id 0 subflow
Date: Fri, 25 Aug 2023 11:50:24 +0800
Message-Id: <1efe89e0e7aef94a4f507e616c92835c90e8dbe9.1692935143.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692935143.git.geliang.tang@suse.com>
References: <cover.1692935143.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0140.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: 05efc525-b2af-477c-78f9-08dba51e8a00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zFNc8kKiIwB6WsIr34yFp3iOggw8+5kqx5NRkptSbXh/gedMGGCBH4YE8k+6x0EJAV+L5hAGmSlsxod42l1JbotQuHm249XM2yTtZnVWwUmh+S5NOSs70Qiv6Wa9SpwzNLdxSonhbzjYBrqUsE7lwS0Ikq87ZtqIaZsgynKxFJ4uoQ73mNhFYF4Rclo+0e93xsZhAF3bFS2lxbr8yOFeXB+SVHOUKmUN254MJapfXrs4BkPlABnoKbqpZ/xhBS502fsuklOmz+kWE60gk5u0/j36HGtilVMot7gfQ096Z0Hhw42ZPRZniKAcP6qUoCrZAetjNUBiOId4fMJmJcvxUwMQsUQzJ8VKSuyc3VucDOKXpTKXrKKPe8Net1xPwS08U5wZDNlpoo6FXetUJHXhyrG1Mef2D3T/yMYji/OJq90okhTC/lDv870l1WDTG5HKPcwD+MgfXhrGDNPIpgtmvreRCnPIOZddIlh6HJRs3ridGl+Q+VZ/NoBS0gOAowjcNov6ou6/hoK4XMiX+XBis7geCK3HRwGhMiRi6sQQoL9KXZIzfLSM2dNL3529dTo8Wv29aS9DBOaMoss25dmiSuOUpV92qbPRJNYk/aJboAQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199024)(1800799009)(186009)(38100700002)(4326008)(8676002)(8936002)(41300700001)(6486002)(6506007)(316002)(6666004)(36756003)(6916009)(66476007)(66556008)(66946007)(86362001)(6512007)(26005)(478600001)(44832011)(83380400001)(2906002)(2616005)(107886003)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q8AbzgFO7xGTwyPx+iKlXSKMxQeVF31q9ShpKwFojCZWWShsGPRac5PX3kvj?=
 =?us-ascii?Q?7+aByKcpFTW2ktQaMshWmU7sJdTHffNcG9Q8l2g21P9N7kPnCzCsuGLHlU+U?=
 =?us-ascii?Q?9qOuhmDnITDjwTpnA48NqLV5qOtSHNI3DjMyUEtOn1saEGg6qCR5TQvZqTJR?=
 =?us-ascii?Q?S+vOzLrADBe6HBSayGIHYdszzXu/qOLm5iVV3kKJdLz6MK/8t5Smmz4zGftU?=
 =?us-ascii?Q?muyjQpMCHaVNOQDrtBtbA5VRanGJpTQsr1frMjnCmNHvTvQuPgraB3PctauP?=
 =?us-ascii?Q?+5N9Xurb/ulzfBufbrzHKiVz5qE7uuPr5JDOejt9e1bqd+5RHuM+Gxq/jRrI?=
 =?us-ascii?Q?mopYFxFz/WmHPnd2zwYhr+gHQSvFB2gOCSxhtMDma7KT5qQD9wusBJsLjD68?=
 =?us-ascii?Q?3bGoa89riXlJ6pjTHQWSbZSMNBI5BP7CDuMoSatFB6RYdrjXtqDDm8WYYLSs?=
 =?us-ascii?Q?y3RbQWdLqxVIUfveoooAzCFuZ9AwDRllKGsEHC8ZrSqWPc+WT+fOg+b76fcu?=
 =?us-ascii?Q?9+q+sALMp7tyOg8miq4yl3slpuAVVmQjEOY02jnq9bSmd5au8RchB4mJbvlZ?=
 =?us-ascii?Q?ej9qVdd9c3+ZmpjczpvmZwyF/p3E/wY6bKMpj7h4C72XfUNl3qIBRJYHbZjl?=
 =?us-ascii?Q?5H9OoYtzrGG03s7Gibsv0yKUzH6M6D13Tqhb7+ais3EC2zvOMJHkAB96SzrL?=
 =?us-ascii?Q?QLriBc1Jo2AlnLpl3ZMHH6/dAXAGRBW6BtXp7qrchcikITLrRkNFhusDmw6I?=
 =?us-ascii?Q?ArttcfGVefo2LGjbB4x01z9icIOE5jQAndTs0y+Q6Q0MmX309j/HtkkF6oYR?=
 =?us-ascii?Q?jcxubBHK0Qlce9tYmhXDxgXKvXoXa/pMMPvNC3pW9RyeS7X2zhbquc3nZB6m?=
 =?us-ascii?Q?8pjo2C46li4o5WbsWqqHZtN1qaJzTkvIKieKJVBdtdujUYGRQGRl5dnUYez9?=
 =?us-ascii?Q?xi5zmAyvAT4Go4CwP1NQgfv3LdG/DMvvtGJ+KJL/Q05wTsWUoPNBEQaddXcJ?=
 =?us-ascii?Q?+Sx6/9EW5OeEHEFaKg0RiLcOjGY9dtv/6e3RifawSHWDspQkknwYylnXwI9M?=
 =?us-ascii?Q?EaXJnZGRIzD1dipFm021Pl24CMA02Hnh9sYq2P2gDgdMQngTYm028fao2Knz?=
 =?us-ascii?Q?IJoJ+PZ1t5RI2WyyJc40YlO/u8U8n7XLm/gPm+O5NRm+i2EQ20VOIoqTRTpV?=
 =?us-ascii?Q?NzMeciX8t6Gu4iH8Mhh0lZSXiE8WeLf5Z7rtrNOyTm8he+8eaB1OARWaU3YZ?=
 =?us-ascii?Q?9eVJuwisx0I48pptHKIFxWiLt8v4dOldt0cpO5kb5ssemo3NfTkLlo9RwWkE?=
 =?us-ascii?Q?iNos3meT7MnEn951kpoAWrg6Sbyjs5PiR2hRsycxNCmRNAQsaNbl4v6rF6ps?=
 =?us-ascii?Q?XTRj094EutSFLyYrwGmxnUeIDrt48J3LrBSF24BQD8EBpfOH88Cc3iGSqXOK?=
 =?us-ascii?Q?CYHtoI0mXcDZ9l98gLoxMU+JTefo8oXhZvg/SG5DJRvg8NUw0j79xg7wcmxH?=
 =?us-ascii?Q?Nwff/sV7Bv7jgJA1892SyBAw8hopNTipJFflMNdx3fp7WpTwfSlf6K7u/Wt4?=
 =?us-ascii?Q?XhAtt4PZUqJuOXzM+hRjvIJ41QqJREKd7fk7YJrJ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05efc525-b2af-477c-78f9-08dba51e8a00
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 03:51:18.6878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mEez2MbRORzzbUQkPDW2iR/uHbjn7GRGVK5tZPHv/IfRArjOoiq7HuPHudIA0vd9DmNfi8Ktt2ZUMnFjI0s66Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7091

This patch adds a selftest to create id 0 subflow. Pass id 0 to the
helper userspace_pm_add_sf() to create id 0 subflow. chk_mptcp_info
shows one subflow but chk_all_subflows shows two subflows in each
namespace.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c6babafa3b47..9862a27da487 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3467,6 +3467,25 @@ userspace_tests()
 		wait $tests_pid
 	fi
 
+	# userspace pm create id 0 subflow
+	if reset_with_events "userspace pm create id 0 subflow" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 1
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns2
+		chk_mptcp_info subflows 0 subflows 0
+		chk_all_subflows 1 1
+		userspace_pm_add_sf $ns2 10.0.3.2 0
+		chk_join_nr 1 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_all_subflows 2 2
+		kill_events_pids
+		wait $tests_pid
+	fi
+
 	# userspace pm remove id 0 subflow
 	if reset_with_events "userspace pm remove id 0 subflow" &&
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
-- 
2.35.3

