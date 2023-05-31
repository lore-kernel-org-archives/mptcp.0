Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2086.outbound.protection.outlook.com [40.107.247.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AA71FBA
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 08:59:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uzy16IC7F+eRY9Fg9LH/Hoas4qbHMRXhgxX8K91HWvwoRLekMwyYAAH+WQljGwSKD5rgMJIYFog9BHK72mbdr5n0BfeRFsGEE/i2f+cw9/bKijHmIaoXccFoFxUZ4GL/Dggw1ETTUE9HHJf5l9fOpQWYvBdTpQHiywTTyXeaRnIebn+dxBVxmtxGE4N5ox0VPOgtWv/MXFO9YkbNUunJlDnC3iossszYjHhH+rDMkQt2BhrdsvHnZ4TCIm/B+D6Q1nWMGcHB6nFgWnNMpATpx5S2eXAe2wn1er7rhoJYWw4njG+vnkXmUBaJMbuX8JqsPYPzRwNnz/vVRLVzJYNEQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOy0aDlybgrbnIDIKh2hLuxYFK4XtLESonH0RX/CVCw=;
 b=lKE44YHR5wRkMA+Vq4Le8AI56CZRmW5P3QH1qTfEvnhqvvwx/Ui+SWcPsBUKC+MhTJJJv60A4JM689r+s5mv+AotvX1pHNXkD1rT8Yg3bagNoWfR/ljZFiSBhnrtp9pTJixfOgJp5U/IsGKYYv8RzhKnl8N0yJN2cbV4n5dn0+R0MefFIZYz1wGqaLQIbTiKOxWP/p/vmRg/EWmWNx0O7YCX2JI+57NCp+LwUtnF32PErfkIB108LYNohjVM1eW4xkZzINjlBJzrG6jOEj8WYwK5RBbOz8F6+AT05t05YPz+1Sr8EOTuQvD1pCvsWvUCu9QIGqRmi27fpcus5aTbGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOy0aDlybgrbnIDIKh2hLuxYFK4XtLESonH0RX/CVCw=;
 b=yjTKmxJuIbceX/8bEw3ySQ9M/s1cZAfU/9p3+OmEn2+jTyi8/tH90BCP2yNvI8B+kEKHjTyQq+a5S0z3uP/BaZpxIkSi6QbCY2tNrQME8eiVVEtlR6NUwOtbY3jbXMLjp/dlEDJvg93U6Ngh7hZkhyAc6WCUBQ11pDNGJgc7qlE3/LADDnqRyOtLdtdljYJHUpamu4Yqh5dez4PSkPWhPJm0peviPisP5xY541Ocz6VRfyNSnYRSg4SNS7c6INzvovB6VzkDgHKvYs50k/oxuj9KNxnZu2uGVXBN/eEomz+++0zfUaqsaKlGIw3IQkgde0B56IP2IzpIuXJl6gNaVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7902.eurprd04.prod.outlook.com (2603:10a6:102:c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 08:59:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 08:59:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 4/7] selftests: mptcp: check subflows infos
Date: Wed, 31 May 2023 16:58:53 +0800
Message-Id: <1cb85d0746c5c9ae05fe1acd90f5ca9950fffb0d.1685523463.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685523463.git.geliang.tang@suse.com>
References: <cover.1685523463.git.geliang.tang@suse.com>
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
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e04ed02-6603-4359-7a40-08db61b55aa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xc8Fh5la6dVWvuxJ13MvzCP8SZnF8/LMb6Utq5Wta7O/DdR8ZeJTOtNXHqdOMikKnLqmIKKU+uXhI1qqhSzs4tIXVJYemoA4uXy6gb9n0DpgUoh4jejQBS5gd3xrnXGGx2W07/hG6hk0yOASLq7COAI5nz7AtYoz7Hkpa71/uA+xM36wEwU1P+FwV0mTNz5hS1XWlREZKZWyxIhqsZdkEyCuZOSzJQgH/4sCW4D/j8o5VBeOGLb2TzrFUzRO+Mql2PaYtPn4KmCqExIes4qn4IEEkKI5h/2za2ozoa7PyrnVkM2URSAhlYCbmhlcK9Cw23XPo+aZ7AG4+QnU02VbEvRP3UuV8ztJejPiUxHaoQ8SAEoSxjj4oBDWhpznFulsQ2gLfwA0GRDOGpwvISCqC21SVEYZ2YQ2Xe6M74GW2qL9RTwv0ROT9iO0bacCddSv66NvSlNu49oHpXiJHA3xUA0uTVLSZLljK9AZQq52tVlAOXAkbUdC7P6Z1zNZH7iF9/lMzPlgQDU7Isu9aLUPv+d14p/O2zbCHh8lFieqja7tq9gcr9G2Cs+MpmtqIwhR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199021)(107886003)(2616005)(38100700002)(186003)(41300700001)(26005)(6506007)(6486002)(6512007)(6666004)(478600001)(4326008)(6916009)(66476007)(66946007)(316002)(5660300002)(66556008)(8676002)(8936002)(44832011)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2HcdlZLSNnUzKCwNnTBsHRMgQ7tWm6V+1ncGr80DSQ8Gq7krEZthnPHkhct1?=
 =?us-ascii?Q?HQtrx4iq+E1BJ7mKLEjDYvGvs7UKZjvqdNVTAxfp3EUOfKtzbTsPAaIXiK07?=
 =?us-ascii?Q?zJ8oRrMXdyDmG55tIcf8T8di/ulFTQL+Fbp6LD3FpYLkVKDQZzk6OARr5mW1?=
 =?us-ascii?Q?xw29HiLUEmsWV2rQR8YotSNo1KKHpbDd3O5RmHk2FlRoGB4EO3AnpwjZFJ4P?=
 =?us-ascii?Q?6sG5SGr3bHDjNlkZAEeyvS+wwbcR5kM1xRk67RyAhIDZjyinRXyQUtgKmfA4?=
 =?us-ascii?Q?yLMtv6ldViY0Kl5+bEqVgdIfyt4RYimAJYtIfTmqiziqcOb+miuIJT1Pruck?=
 =?us-ascii?Q?3q3Tnce7EipXib3lE/L8LKUFWG4P6URKMJcRTtZsk7kC8yCF46NWvCVs7e2k?=
 =?us-ascii?Q?8jgdPsxF1HS2SBA5NFs5dK+fE4HT63LKQQHr5iAbYKq7nNj34oQkndPdtchD?=
 =?us-ascii?Q?Uij7jbNdnf/XvKd8g7qagVC4XtLOFbKHqvMynUKgeLg4zZ/Q9OlkuptJmoWd?=
 =?us-ascii?Q?QIv6/urnddi9HKIy4rX1On1ZLcp73L++FeQeVgOn5KkVXFocrUpPECuE4cCj?=
 =?us-ascii?Q?Usxp4X26PyeepIgQnkIYUNDOlb3yG24F4N4Vz+gsySzmMtSEnnp8NpWEDZOp?=
 =?us-ascii?Q?xIVRPTuppNPgH2KB9HxhVAcWPswjpgFXrp7fnLqTSmXh8FgKpbyCoq3jetL2?=
 =?us-ascii?Q?Gg1qrZk8sd4l8bOh2OtsNldGhoGESNs/R5EoVGmJrLjP4WVcdwqIx15sARsl?=
 =?us-ascii?Q?AjX95Ly6xa8WPxIlRrMTK9iIowoVC6zsbdpggK9krsRGAj7lfeLyt27JV5H4?=
 =?us-ascii?Q?QX7uUNxV6pjEQ6oynMERM8BEXoY699NTr/EtDvZBdnk+BOirYjX2J4WivR4N?=
 =?us-ascii?Q?5unDkNjnuJkd38FR2T0yPxtWybwRC1iwslJCe9+Wc1MDyTwV8hYoEdNJQwma?=
 =?us-ascii?Q?DfA4NTeJaRV9iEi0yMa9BbM+VL7z/YxRNGXJxDX4ZSGp+pV9GkJK8FtxpzjN?=
 =?us-ascii?Q?a/AOgAu6fTcD0rfSwFZk4K3Mp115aW+Bc4f7IHmMZ4tUsc/L63jseq21I5tQ?=
 =?us-ascii?Q?vB6CYdnkwYhNb8TJ/TQCV468zsFBuZ0Dw+NunaxAEvb3rt/UyzRX6if4LiQi?=
 =?us-ascii?Q?miapqFOi/Ovy8SPdEftqOPNkrcimAcWuFc0fI5f+pAuIWsbJ1si+yfBbIOIJ?=
 =?us-ascii?Q?bjUVlZgJ4FnlIMPF7mtDporNoNqG+MIRmv+DCR5Cxr5gSR3N8Biz6OWJPbKB?=
 =?us-ascii?Q?vuLkdWN97hE7//x96J2imnka5essLdI3KLRjUsTnWu+eTop+7SlqBcSFdRNX?=
 =?us-ascii?Q?OelkDHE+/rAnPIIxegwkLthlstnmS9ymhLCkRwxrcI5Z+xrjITt18RMjBzrT?=
 =?us-ascii?Q?KCekkZ+SHVSx/H3Hk3UHFrePKufxySwTVlAvnceBgw177aAztHoP4iavvuFg?=
 =?us-ascii?Q?KacW9VgKzBnHY/ZIUAmMjsro6a9EL4PB3uTAq2+32MIPpvC/weKXX7MyCCGH?=
 =?us-ascii?Q?aSjkV72D5gHao8/RLGQuPPH7QCGby+cPzyq6ra7D6ly5kFhm0si3H4ELzYS0?=
 =?us-ascii?Q?kXThS1nCzqj5qCgB6A08bbUfLMHLw85j8nVdvK5g?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e04ed02-6603-4359-7a40-08db61b55aa0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 08:59:34.1848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1OQVVgSSHafxlBC/p8HaNHjTQQzR/96gFVgUxnI2BXni+ljDR7CqAGAQM+p66+fkAv919oLvHu+F78q2tewVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7902

This patch invokes chk_mptcp_info() to check subflows infos of userspace
PM tests and endpoint tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 04c15fa6f4a1..75f1c69ae78b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3312,9 +3312,11 @@ userspace_tests()
 		sleep 1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
+		chk_mptcp_info subflows_1
 		userspace_pm_rm_addr 10.0.2.1 10
 		wait_rm_addr $ns1 1
 		chk_rm_nr 1 1 invert
+		chk_mptcp_info subflows_0
 		kill_events_pids
 		wait $tests_pid
 	fi
@@ -3330,8 +3332,10 @@ userspace_tests()
 		userspace_pm_add_sf 10.0.3.2 20
 		sleep 1
 		chk_join_nr 1 1 1
+		chk_mptcp_info subflows_1
 		userspace_pm_rm_sf 10.0.3.2 20
 		chk_rm_nr 1 1
+		chk_mptcp_info subflows_0
 		kill_events_pids
 		wait $tests_pid
 	fi
@@ -3351,6 +3355,7 @@ endpoint_tests()
 		wait_mpj $ns1
 		pm_nl_check_endpoint 1 "creation" \
 			$ns2 10.0.2.2 id 1 flags implicit
+		chk_mptcp_info subflows_1
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 33
 		pm_nl_check_endpoint 0 "ID change is prevented" \
-- 
2.35.3

