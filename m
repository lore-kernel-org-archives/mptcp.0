Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130053.outbound.protection.outlook.com [40.107.13.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989A37A
	for <mptcp@lists.linux.dev>; Mon,  8 Aug 2022 01:45:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V99S/5kvMiSg6/xjS40Am+VJw/aqa/PC3io6iLULNTv7BEyI5TO47ATVqz5+vu35zqzvigWj8rlh9gn33csAeqKZz4hsbGW4jcCJy3KiipD0VFWerVxgDAa1rTDKHFrVWZ/3y2so45cQFt0BizcLEDC+4FMlycrlSuS4FFa28uDzAU267xQQOvI9gHSDbxnO3OCoNrtEKD4ZNcGPqgD+ILToGBRxutxuKZORzAClnPLhuTJ0kWeRc8Wqg5iwwtkiQ1GDK6Y7+Und5fDBPs00HOzPGYDbq27L456vaX0jBZYDylU+tFMTtrFAlpAYw/LUY2XeDCK9m5tb+47iEUCTCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4M7kWxfZJ4/yzdgC9Lm8SbnwZ10WEHcSZtzLCN9mvdQ=;
 b=HEywm6SIoA++BCJckRm/IjIriRKlS956GEgdx61cRPnV1fFfNccvnKiP32zCyWi465vh6UX7IESuFbfpkEr26to72qv94L0XWKxoXTOIa1MN/jhviih9cHu4K2aBTaveRxyjSwVH/Tj/1KruyuNlP8RKMz6ozj1FUuhqmubPRST4oPNgYyhOtZGVU3w9u0fKOFmGXaY44QnxsJsACRaB33bqDdsTNWSVeWOH672lX9N4xjzXfCbUmvSwPIWatKa+jSKMjMlPxhd3V7be4PC/IGvR6L4BQEDxlKRka4ddNRNxYBFwyIIU32KvYYiIIRoRDKzzk+mT9m4zRjz7HGInYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4M7kWxfZJ4/yzdgC9Lm8SbnwZ10WEHcSZtzLCN9mvdQ=;
 b=QaqDFKo/xy6N9+ZwK3ES5bKaH4Vh7Zwcol9fY+s/6f5tEtn5IQOMXpB+ldq9sCChzORDgf33jQKz9FQ83ZJcPZnrqlVUqV2NedD8pK9sJ5t6zr66++fNYqeWs7mHGWeZ4nQ0/hu4C+O/ekQn2RR7Lo6xQK5aUheiP8EBA1YyJV4JN/Ue2i4EB6s6X3h+O4imVSPew4wrPEVudJRT9DT5d54gwvbTnMuTR3AFnPZDrbyLmEVlhMj8ThNfuQs3ZhnawN2ElcNtuznwcgxSu+VEXs6y4reLnWxvtDaWVEKacIPdKWltbBZDJhweYLSGlNdlSJoHeaDQ+gVyom59jmp33A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7846.eurprd04.prod.outlook.com (2603:10a6:20b:2a0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Mon, 8 Aug
 2022 01:45:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c9cf:b207:4052:42e8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c9cf:b207:4052:42e8%4]) with mapi id 15.20.5504.019; Mon, 8 Aug 2022
 01:45:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] selftests: mptcp: move prefix tests of addr_nr_ns2 together
Date: Mon,  8 Aug 2022 09:44:58 +0800
Message-Id: <a13144785eab9f2568fdf9eb7da6714d4a911756.1659923077.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0187.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef53c3c1-a457-4f3c-d26a-08da78df9c7b
X-MS-TrafficTypeDiagnostic: AS8PR04MB7846:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fwEpxrtgPKRodDqsKZYKTp4ZKSqjTm0wiRAKlK7mlSO4AVFEzL6W9oXwE0u9h1po+CZKHijm9mk0iHgz8Tf5VDLJSp5RlYIt3o6irVUvkDAIAXmdhAjWAkOPsFHwNR/br0tcqEBl/n9cLrA0UvjpFIL0azCtjUeFP74ffy1y9+6v7dGucf7CW9etOeZsjxBlD092oj5pe9u5w7iQddK1Shn5Psh46I8GJ8efI+dMmv9u2LLLxWJcVUTlKJ6t3s5DLdGQvK9ZXV3MK2ThSskm55C6r3ttdsxH87lhXedIBY+Cidl38cqVPwWxWHsrL36gP9RPlK0gaDPqjzQDrh3BOzIVKYF89722xiBUINqKWJCs1a2n6DyEJhcWyDHFoEZjEkODg92w86z+g3kSJmlxuKF8p0eZJQMHyEiKm+D7GzRYHrhyiBCXoptgD1fDxi6gPGv52kmmYYW6eIWQc574wiXfr8SNPm6b76e+gaHouN4j7YAihUyX5QjaPvlxiUIcKzP+PptxMJbZX7PKdaifVCG0gIhLFlt1qTm0v05SuXLlYx6FpSIJo3IwV6zPMJ6YUkuw4aC5Xq6+5uDUmBko+A42cvtmdSN2kdzrmHhuZDKl9AH59hnUKF91JcXa2WFsLSXG5hPy0jbFD0DtfwDA1G65SEuKgk23z1d0ijTap67heYJO1o3SsD9qK8fX3KgGWk5lsVBEwCeVznvndayUKnn6j6xSE+oP+3OrvRGoz4oJ15ZMqiWO8eBXSNq+dkU4Jl1cZTJd7g8MyElFz0D9B3yF4k7doEC2HKv5bVHrNyQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(136003)(346002)(396003)(39850400004)(2616005)(107886003)(186003)(316002)(5660300002)(6916009)(66946007)(66556008)(66476007)(2906002)(4326008)(8676002)(8936002)(44832011)(86362001)(36756003)(478600001)(6486002)(6666004)(6512007)(26005)(6506007)(41300700001)(38100700002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MHM7z6akb1AFEowqB3qcEq6jIaJ647EBXwgnHrAzskSpJteFHzmMWq7ejU9/?=
 =?us-ascii?Q?0cZ2498KjebeQhkq6eHk2mvfnrHbh8Qmrez5K1sl4LCvY3TTW1gLsI7l2RFp?=
 =?us-ascii?Q?svln6PkBqWyDQH6GVaZncy2p5tsCkn7vstzt3pmOuywAaIeQKZKU6jmSQKX1?=
 =?us-ascii?Q?Vh2cxwzr+NL+fPy7+e3tnwH1wco1glgNnIk4xztE7xgTh7fq6guX92mSkrAa?=
 =?us-ascii?Q?9PVHnf3YhdBFV1rVY2i3fSwDABg9W0ZDBKqkN5yjt4Wne5m87/ssmQykjTA6?=
 =?us-ascii?Q?gPMSv8yMXlk5Rmh2qisazzChn0khdOMRIV8zDAq8z+pLJUHYzkQMxvH6GP6w?=
 =?us-ascii?Q?oU3pT93cDe8Opcxd8te3ShPKf2sY+mbGUuhT3QVd9AmCsF91/2rJXNXsjhpK?=
 =?us-ascii?Q?3KtcvW3zAgDQGdZcSUMTsKJBq/ojrs0Pcm6cO2CeMNtgklypIDM61PlnE4hn?=
 =?us-ascii?Q?ucZOnhqVssR3apohucvXzQByMHSRyfqZDjCaHIIRwBaMXQxISQN8MmEfSwn7?=
 =?us-ascii?Q?0oULiS4KiOv22tW9GQ0wfc7qKItZ605B4tcZAFIf5t3N1OdeSqRtRj8R33+j?=
 =?us-ascii?Q?ww2Z26QTKGjuQFAfa1kPId1m6n5gqIX/l63QMrfRLGkdyt5SMeIy8JTf9bIz?=
 =?us-ascii?Q?EGyFXHb+gZkIqEJmCRUZfygoqI6I5dD0nGp88dnJX7R9JTvhwU0RWnKsuQoL?=
 =?us-ascii?Q?fVAlXqereNT1i/ql8wwPwH7FCZlhub9Iuf/t6W9VyoVzZ0+eImDi4p8MNnYh?=
 =?us-ascii?Q?LR3/RPhrcTTw3KDlJD/H+R6QGWDWySdM2zNS65solzXiNg8z+WbG4/kPl9DD?=
 =?us-ascii?Q?RnFRcUM+Tuwvwxoh0xPV9vI6DPpdTU7eFbbZ+HtsF46hW0vCBtfDr9LJmh/e?=
 =?us-ascii?Q?Yfjg1mYV21wbUZXElmhbMNor1HuOvYZkJ6tOpXUK4JNDE2Vh8o66X6B9hjhu?=
 =?us-ascii?Q?T6s8CkpZEfroGEoPRHhaNr+C88a9AF1N4fD/Px5eA7VZN9vV9a5Kt8BjJNK7?=
 =?us-ascii?Q?1X2DRoX23AXlorq0TmvLFSA3bwaFd70dUh5oS3nui5KyKTPQLFfT7hrDE8Z4?=
 =?us-ascii?Q?yXLVbCdP5wMSNzalVGNigLlGEy2ZiYkgsOpEBnT2uixEnckRCwzUrcOlDUvD?=
 =?us-ascii?Q?QB4vfmmzrOdmtWkd5Fkl3Jd0cLb9tsrpQd5z3Du1NAZG2x4uR2p4SVUIUFrE?=
 =?us-ascii?Q?Y2JtmGxnFND/PXWi9kHmokyUzH/NVHC8Vxx/tME3dQ42xH/v8STmWY8zDVzy?=
 =?us-ascii?Q?6qeaR3a3lq2rUR0yjMYUTfJJa1luvRDq0BvhKfrVDPcPxg5FjptySsyG4f4C?=
 =?us-ascii?Q?+QjRls+Kh7pXLxstFDqULfG+KOHfptoT+4DNzW1v7/hd8QAPpd0kh8o4iKHD?=
 =?us-ascii?Q?8IgTjQQ6Ll8gX8d6eVn2ApJgX4+Rbyd2RHv8qa41eNK9/LYf+fipkAZgyAs2?=
 =?us-ascii?Q?yqCn21eOnYYoEj4lbDmcSYBLMuVwVlAHokSJ4vG8+KztwIdJ++c/DzPlQpcz?=
 =?us-ascii?Q?xdnQUdlpVPx5i88RYSxEuvaibZpf2gH1DNkr50pOgwmlwq/vUmYBUj3aG/KU?=
 =?us-ascii?Q?tQFM4lUBh2QEv/lzjetDrjMmi7tZRvUdtXkyGOII?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef53c3c1-a457-4f3c-d26a-08da78df9c7b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 01:45:02.6309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OwuFuK1oxD2VY9vv1a6jbzwwIgckO+Gm95cSrTmJ8VCm2uBaEPVHXWS+pmWPTY+Sh6TZ8Hg8qqGwzzNR+I7piA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7846

Move the fullmesh prefix test of addr_nr_ns2 together with its other
prefix tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ff83ef426df5..2957fe414639 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -706,6 +706,7 @@ do_transfer()
 		addr_nr_ns1=${addr_nr_ns1:10}
 	fi
 
+	local flags="subflow"
 	if [[ "${addr_nr_ns2}" = "fastclose_"* ]]; then
 		# disconnect
 		extra_args="$extra_args -I ${addr_nr_ns2:10}"
@@ -713,6 +714,9 @@ do_transfer()
 	elif [[ "${addr_nr_ns2}" = "userspace_"* ]]; then
 		userspace_pm=1
 		addr_nr_ns2=${addr_nr_ns2:10}
+	elif [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
+		flags="${flags},fullmesh"
+		addr_nr_ns2=${addr_nr_ns2:9}
 	fi
 
 	if [ $userspace_pm -eq 1 ]; then
@@ -832,12 +836,6 @@ do_transfer()
 		fi
 	fi
 
-	local flags="subflow"
-	if [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
-		flags="${flags},fullmesh"
-		addr_nr_ns2=${addr_nr_ns2:9}
-	fi
-
 	# if newly added endpoints must be deleted, give the background msk
 	# some time to created them
 	[ $addr_nr_ns1 -gt 0 ] && [ $addr_nr_ns2 -lt 0 ] && sleep 1
-- 
2.35.3

