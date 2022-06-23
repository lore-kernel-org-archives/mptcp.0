Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150055.outbound.protection.outlook.com [40.107.15.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8581743E8
	for <mptcp@lists.linux.dev>; Thu, 23 Jun 2022 14:54:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ga3SKIC5oaOrkyvIRKGtUh2s763R3MeguYbyF2JOd5hCdP2Wl3YnZnoyKINFSA0mczXAWN5IKkaO6O0HJ9oz3PSUe1W6m5G94SxPkTKW4pOqDIY9NgXaCUcSDxcPFgS82PKyvukVGrBMFfGjBbpvJLM/C1s2CDznbX79kGX/+ZZLItDgog+YOaq9cVakXF1E3x69FvPoCWkAunqR+D6WNy9DKXhebj1E/yY/95gtRuqO6Z4+hoB7MnrscpGu1v9RuPD2mZ3Yct4qpG0rWHFu5HRj+8vyADf+XAyO5gGTIlZiHob2BP6KuBJ/Q0FzY3sLTxvGHVDYpnJ0jYviz9zkeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26iWokZzac81QCDO3If3ITIZSHHPM6LmLzyOkDdEQbg=;
 b=FkRVfQV1WlbxcqGqdLUUGJkuFQcKkvJ9Y6GzrlHU+KWHZdMs32qtgKv0DFj4Vb/D+zkPkbdwF7FFRH+o3eiaL6aAh+YsWgs3bwVMY58GeHa3eZncCKJB+LVMdwheayH+wagCp3fxhxFNxzqOBm9DkemOyP27ZV+Oaw5huO1D7/RbnmxhU3TwBFS9gvsQZCBJzDhAyOzOLBLjjxg7DwSV3LOlkOc41DaBETS/ERI1063XYnI4vSAk9VFDCEgHptlfGfqouuhciP4mlttSlu2s7Gj8wg+Ea12kbddUZ7rWXGwNa7WUcl81tH9eHelXpk3lg9bOp0IlmZpqr1BOtiZtJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26iWokZzac81QCDO3If3ITIZSHHPM6LmLzyOkDdEQbg=;
 b=v8mRreHAIg+bzg62fDrDZvq+bhfe57kt+zidKlUsj3tQxsHV50cA6Pl1TWAw6UbE9qmEsALxqR762RF8txcSMrfy8NafCdc9C8+I9BqhDYDN9WylXrZLzP269eLPb8+ukZ9TTd6ex6bkf+Kx8yHm4kISK2fsFPwZCS88fIs6dbj2Wp069ulBVEzG34Q1lLAYnBV8wrMHtifsVdh1qt/yhBtIMW0iEa4Fn7ZOe6E6Z834p3DmZoaxLhXW9VMVfHtqeSEsRanGJtSHhkDFyYvUfqybyJAEtQmI6njxZffhMEe4cYVBs+jZU0noVesFRb9RnUTHhqA5rxFAGVCdfRWcEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8299.eurprd04.prod.outlook.com (2603:10a6:10:241::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Thu, 23 Jun
 2022 14:54:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 14:54:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 2/6] mptcp: accept right edge of mapping validating
Date: Thu, 23 Jun 2022 22:54:18 +0800
Message-Id: <6f5dffe33bd23ea18ec8cff99c8944e9d0f9c6fe.1655995770.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1655995770.git.geliang.tang@suse.com>
References: <cover.1655995770.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0215.apcprd06.prod.outlook.com
 (2603:1096:4:68::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29711458-5ddb-421b-b4f3-08da55284a73
X-MS-TrafficTypeDiagnostic: DB9PR04MB8299:EE_
X-Microsoft-Antispam-PRVS:
	<DB9PR04MB8299E21314EA6C1A9E0B4058F8B59@DB9PR04MB8299.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8QnxgYhCbP1ktgOKotH+z8YSI3gjuw2Gl0aEZViwQiteiLt7bOX5iESNkO1/0ILFytmR3GFdtVtZqm8xXyV10a+JSSvn+qqz4QMRyvko3wDs+8ZNjjOnIVYLMUQugPeg3jPRNAdDU4BgWpf6+zVS+mEsQzMsTx2It0GewhLLtnelSb8coeEdxxQVNWg+jK0mT+P2KZfA1QGrOgabNziiG/gu1KxPzuxY15Vvfv+8VpPRgkbRKCNImmMCV2fgVstNNeGM0zd3rOUGYcaft7EuzDhJvHknWyVAasaQ3XGfaKt7o7oBDv6nJ6ovWYhi+y1zW0/4LDgPXfxjE1YZMfa1O4pNo02sQ4LNGCUMlMEP+Iv2H7u1QZ00XO38XMhAumHeRvw7RSV30+Dj2YZcjlI/RedXH62k1iryh/n4MRLWSYtuzZd6pQQ4cn43hfymWD8JNl+ieNF2yK1Nh8CoT8lmo0h+WJyiZlsIM0VgowngN5Xpfmampc7z0hD4DWexG0gafdZP/wkTgeCNaggK4P8TYVoWfX3XYxBl63emNbcf9s9JewU35CvJP4CdXuvfYjDKPO9jsc5eJfzkUYek9jLemUb4UHjw1cyXmMQStMAi76tTqP5yR8FFR7gtOznEp6gz3Bcpe7pJm4zqOl5/6TmMvaXm4nAeoOH1l268i0YRz0aMHjnZ59+gGRPmEVkd4nt+Yozmt8oj2Xnk26Qm9rMSXUUnHzxMkQMQAc9tRZ7cMzJo/OItrDNa256fXUyro4Cc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(39860400002)(136003)(396003)(376002)(66946007)(66476007)(83380400001)(4326008)(8936002)(8676002)(5660300002)(316002)(66556008)(4744005)(2906002)(6916009)(6486002)(478600001)(36756003)(44832011)(41300700001)(6666004)(86362001)(6512007)(26005)(186003)(2616005)(38100700002)(6506007)(107886003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NcZuedrHdwOjLmKo4SEP7jaD67IZbqe4P7TYo3D8skE9eWs8TzQthZIDUl9x?=
 =?us-ascii?Q?C1XfAsNSolvKsywA4PiSc4cCoVJ1GKD8vArOjyA4VXuTUO59FNt2G7lr3dsx?=
 =?us-ascii?Q?S/wm1V4RA02i0/HX3/n/wF+KQrloNYI3rqLiXh+M6Uf3KGK4UhmFhOD7OiJT?=
 =?us-ascii?Q?f5yzg1vnCSM+JhAYOitNkHmmcLTzs73rrPJJM1RChQPrJjgrviAX1Y0QZm+K?=
 =?us-ascii?Q?soygSI1Nd9q4vZOkSbWIqNWaxlw+diJd6OCTa19t1NkrmDM95KeBzPNch+bg?=
 =?us-ascii?Q?dyzP6D2KUjVP3rxqMPdTpYxbWP+JlnPjfC4rMadatLVHg+NpEpiJPAHM7bnn?=
 =?us-ascii?Q?3aiDs+Dwca4iiGfhVkTRFBi3uOFxC5AILv82X/pZsO4DJjzTiVFBp3vMxkrv?=
 =?us-ascii?Q?EUMDimxX25V3nIqa/0Eyk9x0Di+dQIAKzZIxPmyn4mnbrLcBbAhOpM/c+8ZQ?=
 =?us-ascii?Q?ni6TsgNzcFmn4H0cB4hTHt3ehTs4+i/GQf4ssrSH7nO+fzz1OYN1kTzQQHGM?=
 =?us-ascii?Q?M/dbRkYN4YmTj5R5l75e9Gu7/wwr5+vA1nAVF/XKBtjRLqI8dKJJD5Oed/rs?=
 =?us-ascii?Q?rXsZgybkZ0fV83llwCkIuvVDWNEG9zwb0kScGp+H1wFe9Szk/rwXtHeMnqv8?=
 =?us-ascii?Q?vIkaZ2v/OLcrKiyT3S+lDnoPeetP7S5veOxRIKTtAZGjig/AlhTIzOlEArn0?=
 =?us-ascii?Q?UcM2v6kMAZYkD7xccGZSROQ9jmOulscEcKPjurpIvaWPy+IRoVcFqo8YlOzL?=
 =?us-ascii?Q?I0nzirAsyMOs9FYBVANOedsg7Y8UkJcL54PgaPEns9QLNQ+ZrfRTBkeap+6E?=
 =?us-ascii?Q?swyWQPIR9AeICvWfZ8nElJT+IwHff2K9OjNz018E2jquBV3VmxiC5SnsrTDh?=
 =?us-ascii?Q?h1qEerAmaUzP82ap6Y0gTVkaxGO2aZuNV1phkxZcuPsrPYpB7SnMcccbz8sc?=
 =?us-ascii?Q?Sf/Yz+Kpe8eali1bla0nu4xkfNVXame6duYeSDDe5bZZnoKnnxSD2uWlG9DE?=
 =?us-ascii?Q?CLc766TK4D3cdcw9R6xEFwXw1mG3m61KPJEfOmBF1LUzCErFJB54sp9/VNQU?=
 =?us-ascii?Q?L3mctabkG/a/yhAPEasHvAqbnXpKlH/W6Q6CqscKFabe+E2ZcYsFqsXty1XV?=
 =?us-ascii?Q?F0lraGgDHJ2q2+rmyZGzslVn/GEX+FeE63wy2OMtllSUqj93ekGONmkyooY6?=
 =?us-ascii?Q?1Vo0z8LnewgPmuvhtWiQXg/o7iHXkIaI2jXQokKQwNdsRIEiLgePzwiUzvPP?=
 =?us-ascii?Q?Ho7aQCfqQoh39RfEYlOwsKhkresdLeIo/jf2EdvoJLos3hNs1JNZKTlNHGbt?=
 =?us-ascii?Q?boEwONnajtuwkwPDKy0x6EUYK9gqiIfKJX9vwmFBhLnWPuOBNDGo5rKvFLHq?=
 =?us-ascii?Q?jBYxscYS/2nQq94+YXXyG8Oxqwq9DGgsZe8fELWcEGT1W+lcj/M+II79ioF+?=
 =?us-ascii?Q?OMQH/hSJ44HgFtH9THZa+XxRdGBL2DxtP1hiLwtGS9GS+hcRjo6EBgTXJnQS?=
 =?us-ascii?Q?Z0rvNOJRkGszFevrXWsCXo/kMam53vAmrPQ5tHOvgDgr1apu8sArfxCJ8qde?=
 =?us-ascii?Q?r+wVVcC6p7tGx396sFHJ0hHPX9yR8P13Z5QWRqi+6FzQAzY21xA48hPkuBpb?=
 =?us-ascii?Q?FZZ7dBf1FtMSSD/x9Qdo0Yp/hpEqVT39M3COH16yxBMtXO5v8Qt7n9Fm9l19?=
 =?us-ascii?Q?KitFlsWkRbQcZPOswmOWL2eOshLzb8AiELw1xzaJtyQGGIy7VQS5C3NvcnSG?=
 =?us-ascii?Q?++H+yIQMDSrNxsKPWnZsu8n39zCrBPM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29711458-5ddb-421b-b4f3-08da55284a73
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 14:54:36.3433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0wfTGSuV8cuYjc1ynjB/VVOwtqH1x3TVlZ0mDktFAZSwyovySISm/GuSNMiuTFjYoYBP0d+Id2iBOlWuwvVkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8299

If ssn is at the right edge of DSS mapping (ssn == subflow->map_subflow_seq
 + subflow->map_data_len), it shouldn't be handled as a bad map. This
happens in the redundant subflows test cases.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/subflow.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 63e8892ec807..69a2c3e6fd76 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -878,8 +878,8 @@ static bool validate_mapping(struct sock *ssk, struct sk_buff *skb)
 		dbg_bad_map(subflow, ssn);
 		return false;
 	}
-	if (unlikely(!before(ssn, subflow->map_subflow_seq +
-				  subflow->map_data_len))) {
+	if (unlikely(after(ssn, subflow->map_subflow_seq +
+				subflow->map_data_len))) {
 		/* Mapping does covers past subflow data, invalid */
 		dbg_bad_map(subflow, ssn);
 		return false;
-- 
2.35.3

