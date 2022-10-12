Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2613617CA
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 04:41:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dL9Zrs1fe3EYWSK/YNW2xQXZv4KNEr+RfgOpjQLrp3rSBV/km/41Y/Sz7znOHMbylQVApZp2QIFG4bEYRz2RrhpJ7CCfInOvOY+nfpOmYJolUbODJ/9+A/K9VbJr51HB190Bd7JCdBhK1UvDKoOqzBUBo+L4rlpKA4ta8hxkTSYszlFU1sahqpr7dc567bJiWtXx2aNFqGR9OaX5nidhrr4W0Up7pLdlcDgxbvOIzIOMr7UB1xnQ4dCPwxpGInFRwkv/FyvFNyX3N57j5TbQBK/ZTjl1RgrhX2yCLkrswW5JYZh01oFHdqnRl2n7X1Ucosp8sDUjy9lFXNvvn36rEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0ZxTViTfy5QkUpFD+EcVssFhQKvsQuYt0ib5WyfOsA=;
 b=dHZzAZUtd7TFIkvqRkhCz99KkOuCc/+ENLGN+n6juNXZ3dcdktp4L0l5pPMvkOGNOVwEHsoO3A31p4y0rmrPpm2Tv0ZPOdzXz2YJxVzlxL3OlKrQ4ckOvEME1gbf3puVOZvOHGf8hBSYyqSjTCmFb+kJQziDztL21opqWvGfVujpQ+3s+2/It8Se3JKgznK8RSPEgLbYuXtNhxeQfz2R+5eJC3W5dRAr1cXlgz/E3x1WuP2ZQN301NgzucY13ceDBR9ygkN7kakVgJORueJPS8Pb+VnOj4YEWmKlT/TeyAhC764Yhq8PfaSy70XLFGUhZq1yoteW6/+tb7WldQ8sbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0ZxTViTfy5QkUpFD+EcVssFhQKvsQuYt0ib5WyfOsA=;
 b=FnRuyut0BAB/6dokZZ5BLIXsoJJj/gImVghAsvh3R6q3YFQx6wJGgUHyX83UCTRkqWtdixow6scLFWsjSrvhcfVV/wNMenQB/ZjwbDPPBChVE+LGFpQs9MeqhyqAjW1TwLjYtcS9ZXzvpxVsGd3SXITs6lFtMx38sdSlRh3abQ0tjC+p+GIJagIeF5ScjEdQ8k9NHQXXNERmIpYnGywvV/oYsaClJxVATIkylihS0RiBKVJBubZcCwmClf8ehXRnzyuW6n3/fU/PYJ0nh5NGO3vCe64qynAppFdI1cQW2ntypiC4gBjBqK/ecYAemTHBnQnJb4ACCk/Tt9km3lekyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8814.eurprd04.prod.outlook.com (2603:10a6:102:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 04:41:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 04:41:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 10/12] mptcp: multi subflows subflow_push_pending
Date: Wed, 12 Oct 2022 12:40:05 +0800
Message-Id: <5ed126ff5fef486cb205b81f7f78fb9e7df4e040.1665549148.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665549148.git.geliang.tang@suse.com>
References: <cover.1665549148.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::34)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: 64de2af2-8e40-4c19-aae4-08daac0c0289
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	17JgTc3boenZZMp5EHTS6VRSa90jozmM5+mVTOWed2an7zHZj1E/hjokiknEAoFP+O3T+tvVuYyb0mACQQY8I6VKpDtqLxCZRcz9kGJr30h/O+tky2XhLPzUB+IKZ8VHO1W56QQ//CQ2VyJq9js4y0R9GS2oW1LQXfxk0W3ykL9yXNr9P4sebalfScy8Rv7MOT35QH2lOQGwHpWL5Q6MiLnX67754wkh5aNR4qUkTsPIoyBHOYAb2eZBNusD9OkLPztA7Whb4+B6shi5VmXRIoUYA5wJ2iEZ2KcoCpcryTELlGdcXVRuogOAFAikghyYMdIMADYYkKpxAtAnFwpMocTOFP+rSJ9cR2yxv3Ubo6Vbv2LH44A0H2vGUpo4R/xDc9DvqGwL9zyVISdWPOiZzzBZyNIv7hvoh88sxmQfQM/S79TRCeO7tkgYDAk1PckSpzSCrC+tkaXYViYHF63vMGDxL2rpZ0rULJyqXT3YRxtqQb9gA+I3fr+1tBkw4h/qBGCwVjuyJDVMJZnBscPRGNfUvS68HSxTwdae5DcK7/9JpN5Omywq/r6C1QnOl5T6GTS8a/D2doXl195u/i407uFM04cfVECMg4q7nrmux3SA7zi2JFg3o5wYIBiggXdPyUor8skSO5ZqZrNSkKzSAISLzkbL8cwlZWdcKoWtDejER0jhEFcfD8jj+WHA/Q5rXfKJ4phWvCucyolIq8YaxRb5t/SBLwlutcPivb06NffqlCA3liomsG/T4ODPNkWj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(107886003)(83380400001)(8936002)(2906002)(36756003)(8676002)(5660300002)(86362001)(41300700001)(66556008)(66946007)(316002)(44832011)(6916009)(4326008)(66476007)(26005)(6486002)(478600001)(38100700002)(186003)(2616005)(6512007)(6666004)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V1pA3F8Lu8T1yr4lS7IaIcdJJNyaB1pELx76wHChWk/GMr80t5zsUpK/k/lR?=
 =?us-ascii?Q?NdoiBvPx8ublm8OHBksvL9JneVIIB/M/6S9q0PHzA1Rjvk+JpK0tfDuSnkUv?=
 =?us-ascii?Q?ZMwqlbodJu1y1J3rHH17M1rNN2+Afe7/v7lsznOwGxERBX04YBHDEkd3ULEr?=
 =?us-ascii?Q?8xMMS52NBw5cFbLdg73omJ1Q3w8Xuk+4wXQF+b4lN4lTM8DeHmR/rXFRL+DV?=
 =?us-ascii?Q?5F3InBcRPXoIf8zuEbWe2z10IareLE8rLQXve3RyhrQ0IxueXnegg9FSZ3j5?=
 =?us-ascii?Q?7KSp1KvpxkEJeQylJqhl+Hvjv66IZ8ZVlhYz54RE5a9vUbI04lJFnpIv8pLP?=
 =?us-ascii?Q?L94NiVJ9eNveheHzJkont7W1Icb6QXtONaJ7Gj2uabqUkf/Mw7QKEG2hQKk6?=
 =?us-ascii?Q?cqBziHrKTUg+NALd9cGT/mZXq5bqktQfoCkCROolIstjCrGQNTFVC2MYldZf?=
 =?us-ascii?Q?OOHXfoDkp/kFfR3i2PcJDwx2QKxz+OHmSCEfYOLLOfBbtOy59MmZ2yFONM4u?=
 =?us-ascii?Q?UG8p82Hx0llN0DZMKWn9YyLoNHHl/2+R/B3dHQ27fi++kjECbUSFKwbDBISU?=
 =?us-ascii?Q?c/cxyLX8jLHkGQqbcXx9KhcfbAwY7jN9MEoO8K5Jl4M12HtzJtcXLRia4sHW?=
 =?us-ascii?Q?RoP0DJT62wJMABXSEBUr5BJMD9X7/cWGBpHM6cvIUvtudvTFnYcGKCGn6Otl?=
 =?us-ascii?Q?QLP3fu81lv+G9zRCNW2KVKCd9ANSfJecBIg68WRYc1FJAP8p2IBfBlOf2i5I?=
 =?us-ascii?Q?fMIRmTNlG6OPoFciSD69/2NrkKx+KCPIdnZEJs6mvyvEmZiFZzao3wGPsu12?=
 =?us-ascii?Q?c3mH8ZHzQGW3hXasBY7jCXRhyrA+3aynpTibCg66Weruw+OepW8p33Y2lNJS?=
 =?us-ascii?Q?rolgCH5drQKetIgIDT9/ZeDjJkna6df0Wm8UAkCyvmBx05z+7GGhB63cBhTs?=
 =?us-ascii?Q?kqsIG8XbHxW9V5ktL1JnP3AdzP8X5+EiY/hKmajXEroYtPsJa/ijex3ZxrxX?=
 =?us-ascii?Q?5UTDYWlZ8/zF3PVygSOaWFOduXLLrQouoteeO5aAFjeOYP15wLKXqbnLv5ph?=
 =?us-ascii?Q?x5V7VZFMBcrZSwwRpuSXcIkKdFrbTbjLMvXhim0YwJPQ2fIGhXsqrlqc6sF1?=
 =?us-ascii?Q?NDTxcEGf43oo2dFOCYPZU+VajHjtpK6CJI4uvg90ac6NWUkSS8jsODC9JNWg?=
 =?us-ascii?Q?FIkG9T+61b6w8iwHGSGQgNnkABX8dhf1PCxgN3wpPGeq7kk2U//z9g+omMA4?=
 =?us-ascii?Q?OG9hePV/hpd18rZ0V5MwHa0aDZiaXvntRCRDJuBjPZndvE9b0udxzj781Yw/?=
 =?us-ascii?Q?a/Jq3lNGF/yJoDMLch/foQuVAIgRi40/DNMxKd+I2yuoKWY/RAoJtY5nJHIj?=
 =?us-ascii?Q?XrnCNzP6Gg9e0AKxX/PB2YILhi/6U/Q5H2x2t+YrVvPP8nd1jWYYcYoTpVBM?=
 =?us-ascii?Q?/YnxYkPTJvYhetWI2ZO86qbc6ZVi3OUhSMRt4xOUay2axw8+muWbG5yuAf3f?=
 =?us-ascii?Q?1GSzk4V52amurwQVMtZGiHslfJ73vaY/Gb/6SMXtABbE1PlsLTdOP+boAWFm?=
 =?us-ascii?Q?X4X5Dwpa8wI2uoYlJ3VF7NVNBhp9dm3rZiIAZ/YpLZDUb8y+6XIBuIcriLC7?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64de2af2-8e40-4c19-aae4-08daac0c0289
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 04:41:21.1789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gcI+ex3C2upBqaaeq/E7MAXd/5Qxkga89Y4qbiAgqALxpYpktOGLAFa8wdxfvryAf3zxKphAm4/NfPYWHSnnGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8814

This patch adds the multiple subflows support for
__mptcp_subflow_push_pending(). Use mptcp_sched_get_send() wrapper
instead of mptcp_subflow_get_send() in it.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 50 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 36525d7ea8e7..4c9c2c6dfbe5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1599,11 +1599,11 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 					 bool first)
 {
+	struct mptcp_subflow_context *subflow, *last = NULL;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_sendmsg_info info = {
 		.data_lock_held = true,
 	};
-	struct sock *xmit_ssk;
 	int ret = 0;
 
 	info.flags = 0;
@@ -1612,20 +1612,46 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 		/* check for a different subflow usage only after
 		 * spooling the first chunk of data
 		 */
-		xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
-		if (!xmit_ssk)
-			goto out;
-		if (xmit_ssk != ssk) {
-			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
-					       MPTCP_DELEGATE_SEND);
+		if (first) {
+			ret = __subflow_push_pending(sk, ssk, &info);
+			if (ret <= 0) {
+				if (ret == -EAGAIN)
+					goto again;
+				break;
+			}
+			first = false;
+			continue;
+		}
+
+		if (mptcp_sched_get_send(msk))
 			goto out;
+
+		mptcp_for_each_subflow(msk, subflow) {
+			if (READ_ONCE(subflow->scheduled))
+				last = subflow;
 		}
 
-		ret = __subflow_push_pending(sk, ssk, &info);
-		if (ret <= 0) {
-			if (ret == -EAGAIN)
-				goto again;
-			break;
+		mptcp_for_each_subflow(msk, subflow) {
+			if (READ_ONCE(subflow->scheduled)) {
+				struct sock *xmit_ssk = mptcp_subflow_tcp_sock(subflow);
+
+				if (xmit_ssk != ssk) {
+					mptcp_subflow_delegate(subflow,
+							       MPTCP_DELEGATE_SEND);
+					mptcp_subflow_set_scheduled(subflow, false);
+					if (last && subflow != last)
+						continue;
+					goto out;
+				}
+
+				ret = __subflow_push_pending(sk, ssk, &info);
+				if (ret <= 0) {
+					if (ret == -EAGAIN)
+						goto again;
+					goto out;
+				}
+				mptcp_subflow_set_scheduled(subflow, false);
+			}
 		}
 	}
 
-- 
2.35.3

