Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C37338E
	for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 02:24:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GG0aF1BCsBSsTb+W35WEXG4Uby1e7clif512DB4MrI7jN2ETwWBvk/5Vvjn/8lEbuJJVe2u4U/uB8UxjH6lOlmIKbCjAy+GkLmpJaaSbGrH4c1byoLsSXE80xFsk0aOWn2Q0vFBKT9po1ZadvenOr/cKm7CTghh0cwypljLFoJFclkbEUh2gTrDvRvERbWYw5F9x6owbZSW3sht20X8oSJ2BeWYVhZIW+vndwcL4Q+ygQIOr1Iy1xBSM2tsEvIKhRiN5wIaLfW9nEPsFUN7NEJ9Ma7rGf2C0EJv7fX8qtLvqSh0eT9+V47Ycs0I8ORXxpzN7UBHo8Et5++j1Dlxz0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDhdXa56nFMtg3Oj/gp4WGg0PWOfZpM0+yfqSYl9gGY=;
 b=NXaSIqxVwcjcK9jLaa8WoB/AHaldYUxUzIvf9oAmblGiNwE9QbaHeueON7lG9SlUrnzhaHlNAhXtPxIADCL2gYXmlIEwdcwuCIbJku/v6Kh0HPhM0/l/hqSD/TARlsCqp01PHVy+TiUGEpsoVkz11xHM2qFcSlgQ9FIAdgFn2BpwUY7+DCXyPlf0wUFEQeFN23KCh8H9y+KOm9QGht5OjA6N1jATSDPfQ3vCSXUyNgg8WRT/Vv/G4RVkQoszcJD/bWs6/4KS6wTz4NMdIQx/F6j+DSJD+RHDzof1UFxDygJgfVZjSDiwYWG2TyJnrHn/JFvXDJEGpvk0JkokKae25w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDhdXa56nFMtg3Oj/gp4WGg0PWOfZpM0+yfqSYl9gGY=;
 b=5BdBOCQ5hTKSMnYifUzsbW5ODwahaD4jTAKNDaBaLrBjKf7AqMDfSdZnAY3R2BotoxnwJ9xEH0ABI6TKJj4zDWn+bc8LheglKJ/KTzYCFFX1qvGT70f9tVrXXbPMsnUUUq1BpHxvgiEP2d8eb95vmr0n4jwy1lTfr0/6oJWJimjzYmQN9O0y4AT+VhuaUDxQIJ/unKuOuUNqIBuClleJOu3cfP0a5LzubIO0ZFQ54QjUUht+hOkHvmGjF1yK5RcWX1G4TiOOY58beyy+nuBaN2iXb7cTZz3pMJzKagSrD015PgKqMoVYmKONjCwljj4DZY6qTEV7zyeDIJW4CWz2GA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS4PR04MB9241.eurprd04.prod.outlook.com (2603:10a6:20b:4e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 02:24:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 02:24:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 17/23] bpf: Add bpf_burst write accesses
Date: Wed, 14 Jun 2023 10:21:04 +0800
Message-Id: <992a1d557349f3bcef5c7b94940f0161050c31d6.1686709116.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686709116.git.geliang.tang@suse.com>
References: <cover.1686709116.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0012.jpnprd01.prod.outlook.com (2603:1096:404::24)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS4PR04MB9241:EE_
X-MS-Office365-Filtering-Correlation-Id: e1bf863a-a0fe-486b-3f80-08db6c7e768a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v2AfC2Hm+tt0RDqP1orGcxUHTSHsbgIlTdp7FDpQWrVVELYDySAMESE8A/ZwWZcavHbBqjy8YLFzP++/2fJ/NpYOXgOb9bN6wMQAzUDhQ4rzHmiyXyB6LBQOyQaAzJn+yeeTjjth2jmzP34KeT8OgGjz177IGZou/fLnwoucfyhe0TwTls/PZgsafvedohmIxSVvY/gFXXtfSzpAYrJBeWRP5DwjRfj2tg5iviH+TF2AzEulK+IfPjH6F6mvCI1X/A0Z+vMeXAYA6wkuVS4FHMpJtmR9a0cxCNUe+F1Qbht2x1BORLmu5Qht2J1UPVj6U0rTNGWf7hWACEuPMWqvrQnh2nwnCsIei+MUad3vH6yM10jgDxh+yu7o4V4Mo/Duvef6poEusqhdfnyOqdqd8JFWco5tLnMX8pvCJAlZK24EM/Q0q+BhCmjIVS2Old0UQumGr31DGIvuTAoVBcNRUTAZtOtCqgf1Wh8/WU6s3eBbssvlE7N8tymcBZu1RvBZj+hh+BIDuQS5SaEb+WEuxR2wlVdjg0EBI030We989yd/OMcE5lNGKkvbQKq3g0gr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199021)(478600001)(8676002)(5660300002)(8936002)(41300700001)(316002)(4326008)(66946007)(66556008)(6916009)(66476007)(38100700002)(2616005)(186003)(6486002)(83380400001)(6666004)(107886003)(6512007)(6506007)(26005)(86362001)(44832011)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NqldVng0t0dt72dT7Mslq4iKth7qEAOwbN0zzxMmCQ5jVEJEmdQlboNwVtrW?=
 =?us-ascii?Q?1wD9Yw1+dSNA2X2iXLlrxp4EGskihauLQTBPqtIPzXhB5sIA8Le45O808lxY?=
 =?us-ascii?Q?CjYW+y/XxgkNFXAkFPohzQmDAg/sdz0FTSc/CA3Al/H+uyGp7eYXYiFReqCd?=
 =?us-ascii?Q?w3Q8sN2laUvcNJ92aMq1GqbWi8S/6x52D0QX/h6k9N1k2lf2Jj4R9ao9iwfR?=
 =?us-ascii?Q?iYB7lhBy0BqL2FrTtVRhXEQDqObmqLfjmr+MDPO7/tgpT1ZV3F3L+OqIMY/T?=
 =?us-ascii?Q?zeqt2AZoMTJQ/bN+SZXxFTK9d5UsqROBafnhSsqbJHKtrgSb1vYpOfuFyCw1?=
 =?us-ascii?Q?VeQeJjnDVXwP4QdoI/h+09H0mcwETTKOTx6O7H8dmN8AoG+il2OUh0GYGROo?=
 =?us-ascii?Q?TDrT+BwkQWiVsvSmcnJgkdXN7+rfQ6NPRA4dgn8DeD+etUN7elDHH1NGS+SH?=
 =?us-ascii?Q?vUtnTrpy3jCriQZAPq1o96Q0zs5nYskTKuuUasvREBhau3JxYDxugU6cV/99?=
 =?us-ascii?Q?YKl2XlWw3tuUCQ82R0oNExZ1e/ioiD3eMf/xq8AvSh4Ef1aWkJNKk0DgyVa4?=
 =?us-ascii?Q?MGQJglqo2pkBNI99xZkyb/pRU/rL/suOfqyuWfdPXX6RTT5BSzizSPklmTgB?=
 =?us-ascii?Q?1G4wMZfJoCKW15SwO3TdaLILsnRzlTymnQ9RBpHCzByrEspiMlxiZYHvdTVM?=
 =?us-ascii?Q?hrJ/m7n37SgmMLy6kgodnwe738I+w4s3wvpHK/Dicy/xHfXA+GImYUesl5AC?=
 =?us-ascii?Q?5veDrEyqjA/70NtNTOVBbbleKQ/2hrj6O3a3TPWeD/YOIwK2SqdbVXck0vmF?=
 =?us-ascii?Q?XMP9teUERuMvwxASKn+XcVSegnwyXgsQgK0QLo7y74MZuTWB1iT92vfAFTXD?=
 =?us-ascii?Q?RVKDPayYv0/IlF6xJXm6eNTsh3KOskAdDvWLnJWfkrU8I8Yyafjmx/zjHTiA?=
 =?us-ascii?Q?VZglB6Cl7L3x6e+SbX8reCf/1BRWhEFlJhNIBHRY0IZ5IpMLo3Yd9XCYLJn5?=
 =?us-ascii?Q?TKb2/2xy3ziO8zZSx7doOdhZq8ZiazyYvaLy8y3cfo5Jwx+eGdHTC8lgM3lC?=
 =?us-ascii?Q?TLVmFryHl5/7eGLaZ5BNVBLadnwO6W7A+a2DOLv/uAJrVOz5C2PStmKPEkh+?=
 =?us-ascii?Q?EpaNxHSMg0zTSf9B2GsFpmRGiHM67asfeG6eC6obagRRq3Ab9ii79wqPzhVG?=
 =?us-ascii?Q?4DTKDPHLnmyq4vRQlg2hYrF/CY5U4LwPSq1kUi6mucXq5c6c4W1JsY6frBY2?=
 =?us-ascii?Q?iMwroC3lmIDhxVcTFeI7kGevyKpXOe65O0XiFMGl4yVVLrtVRtaDXwlvOHj/?=
 =?us-ascii?Q?usfDE6gsujswTWM8mOKepZhZJoT/R48z6gukzbQ/dR6gG6m2lkCsNJcBcv40?=
 =?us-ascii?Q?WIyDcqAYKW6ZZqiq/qnOY+4P8Yy5hc2eIGPH3mQanJjPNBq+vIR5cNFplVlB?=
 =?us-ascii?Q?umy+MXFWLp1xJMswtaPaW5CtfEQxMeuEJwyluEXT6sh+H+8B4QskQ/K1oD3j?=
 =?us-ascii?Q?QbmUJCGs3cafrRy0A2BP0ltw9xmUuwct5Qoi/gG9xji+IJQvvfHwJaGs4ZPi?=
 =?us-ascii?Q?99sgROsRSMQUocL/lyy9WfQ8vIWdWmsgfFkKVhrE?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1bf863a-a0fe-486b-3f80-08db6c7e768a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 02:24:21.4817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wbFlxYjjvaSQ8/W1JuSSU8mGrFWx6mO9K/NzZ8Wy+NT1AvxGy7GWV+04I8xOpzvhETn/3Z2RDEk349gCL5PqhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9241

Add write accesses for avg_pacing_rate of struct mptcp_subflow_context and
snd_burst of struct mptcp_sched_data in .btf_struct_access. They will be
used in the bpf_burst selftests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 066a02bb26bd..97fc0dc1f3d9 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -51,9 +51,15 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 	case offsetof(struct mptcp_subflow_context, scheduled):
 		end = offsetofend(struct mptcp_subflow_context, scheduled);
 		break;
+	case offsetof(struct mptcp_subflow_context, avg_pacing_rate):
+		end = offsetofend(struct mptcp_subflow_context, avg_pacing_rate);
+		break;
 	case offsetof(struct mptcp_sched_data, last_snd):
 		end = offsetofend(struct mptcp_sched_data, last_snd);
 		break;
+	case offsetof(struct mptcp_sched_data, snd_burst):
+		end = offsetofend(struct mptcp_sched_data, snd_burst);
+		break;
 	default:
 		bpf_log(log, "no write support to %s at off %d\n",
 			t == mptcp_context_type ? "subflow_context" : "sched_data", off);
-- 
2.35.3

