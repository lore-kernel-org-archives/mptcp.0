Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65122566
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 11:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651664680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H0LIEXS6JVoqEgySI1WiObtbOep3KbVi8egf6lRHKaE=;
	b=BRy0Gx/9wTUGwrk9zKmKKccIUQ89yy0wpRl0bipmEv0phj0iHcb7b5qrqWfWnwmSRxUXmQ
	89cjcJ9M1KFkUmNXrTVkjjGbHmxug+Lu/KNat0OR8rW/DDf53GcgsMAI3Fta5z2ICbe3b2
	GtQd7oGVhPnKGzdi2iiD7+ZcdfLiISk=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2056.outbound.protection.outlook.com [104.47.8.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-OtR6wvqeM9ikXx2vIooXaw-1; Wed, 04 May 2022 13:44:39 +0200
X-MC-Unique: OtR6wvqeM9ikXx2vIooXaw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiraE0QV9QpmElNjyw00J4Notk2I+XOuhNsPyYCbOy0nH1x5yCU9kO5GCMjkah1BxEAhfGUe9SDl4JJ/vUbwLjMn/pSzcDaVo78l9MJmoKybkvmNCX4o0uF0pqdpzkjL9AP2LzLdo6vJW2yU6hh5jQ6teHs0CXoZ6esup/dH6S8cAzdpNBmg+lXabKnULggamQFI9q9EjgtXSR9Wn4cSoGUW9eF7qNIIE9cmNaY51ZQZJJL+NYB+5rpuIGCg1JTK0R3uPk6WL5IWjOkvE/19amcpIXi7czl+dJIuZPrGgpJoTwmZExJw6rEZp7wRgyVY1VoWA34W1TpmfUpypqWQtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvyJgJx/tkCROY7/uV2hAgEmqQ/tXgtrYn5ITWowQls=;
 b=hFH/Y7dIb2QK2kUuY5nbyqai02IsSOc6gkXR5K19nGhGs/W8h3hx2vT/XKsUy7Vf7T91tuAmC1mekphNw8k+WrNrWa4wPxe7uvTfWfTsbqFEtehdCXn3JYJoOav+2hTzRnLF0FBSxDd/OOlK5vP4dAlbUrHcgPFOJw8jCzMGGgavwToq1GRUGoV11KQdWTwRompl54lMt89RcQB4M2yKYOq2d4ZYqz9ASZ7nFIeVz2ubACi721J8hPr6Udq2wYXsTz4Su/XGCd1iHMYnukZCvV1pk3nMam+vtsRqPzQymLVGyRlgdbRk5iC0gGrcti45bA72ZWZKbHVkRUkNRicwAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB6462.eurprd04.prod.outlook.com (2603:10a6:803:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 4 May
 2022 11:44:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5206.025; Wed, 4 May 2022
 11:44:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: add MP_FAIL reset testcase" - cleanups
Date: Wed,  4 May 2022 19:44:24 +0800
Message-ID: <cdcd6b9963a1c15b20ffcf71e06b6de70f67ec4a.1651664645.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0097.apcprd03.prod.outlook.com
 (2603:1096:203:b0::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c4cc2c0-c86a-4e63-ce55-08da2dc3771f
X-MS-TrafficTypeDiagnostic: VE1PR04MB6462:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR04MB646288B5FA67F84BB8294B4CF8C39@VE1PR04MB6462.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/H+gTQuKAL3a8nd/3+9z0HNMzRPOt8xRCQrWs8QbhYYqx4fm9Oz0tO1nnDk1sqA3Pxfa1r/sJeNd1O6ThR/3LmmS22H1lSRCQIIjaju4ibneuZjpOhOnKugT4wmjnqoh0icdFRDwB06oC1ALU6IlQPqrspZOPLho04qkZ3tyw2t+CbH4LVXZVH6dqDIv5D3wSKXAigIEfDM8TrTWr86mGGT25qZVBNEAk0mZb8Otg/kA3MQKYD0V2/KICtXhtv2RWW4DN1hH5Pr4Ks7S4Y5Z3fs0NclkCVi6hoppIZ6gyd/FUi20bwVwap3TcdOmHG/qt58gnT/EwbPqfN7pZBI4Z4coBClMMrQjHM97hA/KC94lt3f+beeCcCYXidUTQgyBR057yedhzM5YjdNOnlt9YGANiGmtns+zABUDXSL2GbJuH8u2g6egLyCHZ4IlZXsfqE1nDhOPUE0XHeQTqc4gEMzYDce1f58UK4A2nKFI7XF20XjlhvPcADVSb/wwQjDj/w3z+e5ajBN7mHkUGXn8vEROWvMabuE8QME5SKyEQ/WdPr/jYjiitRHTKf1SYpDFq5YANbXUaf5ME2I19eTbiX6AiZ67C2Mnm8dvpvswye+bZaURVmMYTU9oAElOjGdXTt+3Kx5a4d6l+KwTgJQex8qO9N0Rnb5FealAFW19h6/jPDgq9+UOP4fW/slfrJTT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(6916009)(8676002)(66476007)(66556008)(38100700002)(4326008)(36756003)(66946007)(186003)(316002)(26005)(107886003)(6486002)(508600001)(8936002)(86362001)(6506007)(5660300002)(2906002)(6666004)(44832011)(83380400001)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Iut0vDUOD0u4x/oJAqCQlLlWlTLFzv2fzpxclrMYzVNR2QyljiRLmmJunmsy?=
 =?us-ascii?Q?uHY4vWqIljMI46VB8z65azuFBYASdzERi78I6cmRF1FYfTyMrh9l366FdVKB?=
 =?us-ascii?Q?26Glol99J6V0CmHFLfxIoBLm3cFhQF+9uEx3q4HmDLp6X2KJnIc/yI3rfGDv?=
 =?us-ascii?Q?tWzi5Ty7/046iwAiXgLXI9vKxLbwt7RhCUJr2iikz/QpdZ4+OSYpPeYbRgjR?=
 =?us-ascii?Q?TrF1ydsm/e0y0+zY+KdSa2RM2UhgVnr7gYEAWZ0UfVs4foO4y626CEMtrPSr?=
 =?us-ascii?Q?AEsds1nNorKXg7g672/lfNBedH3sTrnSfkzmltsNeaLGFYRUdO2eZwT+IACm?=
 =?us-ascii?Q?uSsrr6BlQZLLfvGpEV39iXHNDPcapyc4i0aPQ4t5A5ZfsSOSwQKenNKYX4V+?=
 =?us-ascii?Q?sKzs0pq1QUCcP1IgLBkJNu++zByh9SmeTqO1ERg6RWAPUKe7MrAWSuJrPcVl?=
 =?us-ascii?Q?JMUPAkS1qBLMPoX9KHqJKyfzP9cvAUMrDc3h/GDsSNmIRaagr+zu9Q8Kjt8d?=
 =?us-ascii?Q?uHW+k2NkXse3+IDIB0Y1IWFu+VHZ4UAY8lnU5uJbXG1RoYJiEZ+LGesuUqad?=
 =?us-ascii?Q?79ITNmah9qZaVTVtNbVJH6M/xVA89kCPZsVYw0QlBk9ZTTxP5hsCGgpTgOF+?=
 =?us-ascii?Q?MhWVfV9tt1bI8pQXhuXBhbX9h1OgZS4Fvs6lavmZOqPL3E43lDCmTvoHGWgt?=
 =?us-ascii?Q?CaLfmq8Ox1rLbmbH9T/OqKybIOe8AL1g0tVsnfNg/Zo7RTDmpLncjdonxFL1?=
 =?us-ascii?Q?6LCkBWsO6sJUbmUKkYv7y+qPT43Nj99aXTWu0vuldc95FeL6wrDfQyediuIS?=
 =?us-ascii?Q?oT9SLne9ADSRyG/PkmKLe7fMj4M6baWIJ5fHOuNsSCulzyepdBlV91XHmQKz?=
 =?us-ascii?Q?fRB4aSvh8MmUA87gCFg41mzUohwDbi38851di+byym/EUE+qCCvyiw+7ycmU?=
 =?us-ascii?Q?tD2GeFWhfJI9FnZBsueUnsJolKhucZOGiE4U42Yvqm5axxZ1KgetZ/tTET3c?=
 =?us-ascii?Q?DxEzRKlRoj6diMkH6pzgibZWsnCFZ27HVZddSB+tXGfeAkOexy+P2Th9wyFr?=
 =?us-ascii?Q?/MB7OzHf5O5THy2qKnlUxltJTuKHqEqeixerR5LbCnMQP7+irHAAqutvntJz?=
 =?us-ascii?Q?sY0C11TSJ7CW4mRecbaUf6GTkozn6su2sq1xJYS0svDZh3rJxFqJl5eldqAV?=
 =?us-ascii?Q?J49OLxjxVjIMrX9YhS/bLUDrR39nUvV045mgEcymeU62qi78/EVLDo7pnT/4?=
 =?us-ascii?Q?pcDiTGF6s1dIiuGlZTaldTPrqunC1akCHHnnO4TRs8UY4TBNetgVb+u4SBg2?=
 =?us-ascii?Q?CjyvnDOZq69IciH4LFgXHKjqtq+V6uHaT5DLD2URfVEsAjA3TGkY0AzldpLY?=
 =?us-ascii?Q?G+hFIxPqMZxJaklFONp4UH+cAMKoJFWEtqERbCRthyFNzGEwEwxhOE/3sOrb?=
 =?us-ascii?Q?5bsm8P/J3pRA12GYVxjil64HNcp4Vs5sQNJJpnV+uhjNJSZcgJ7TVqSilOH+?=
 =?us-ascii?Q?xbbwM1hmD1paMESUxA1kx30pEdKRwuF/5R1zEZzXImjo9fLScWcxk2ajFXac?=
 =?us-ascii?Q?1yIq7rALd6/3JkCykqTf3RoG+Q6ull/CGOUkTLBuzn8m+PCNy9T6XgJWE6He?=
 =?us-ascii?Q?flHXM/7EbMdcY6dmEt/wtsHwN+sjZypneBzH16FdxquukWPgSvAPsQ5gSMSf?=
 =?us-ascii?Q?WrEfsjkXXDL3tSl0SCQFwpiaMJrDAxZvPC6xcud1xn3R4tD2Q+8o18jg/dw0?=
 =?us-ascii?Q?HXfCLUw4OUG3KsqrDhYWKR8CjvvAFRw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4cc2c0-c86a-4e63-ce55-08da2dc3771f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 11:44:37.2416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cME+j29XE1/PEXsIHirj0pT//K49e4y+lBO4qSHyHsDksPo8llplEBZmClQsnQbLbgfAw6EHwUUyVPzGkshBOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6462

Two small cleanups for MP_FAIL reset test case:

Reduce the test files size from 1024 to 128, to make the test faster.
With Paolo's fix [2] for MP_FAIL test-case, the test becomes very slow.

Drop '+'s passed to chk_csum_nr, with Paolo's fix [1] for act_pedit, no
extra checksum failures now, no need to add '+'s anymore.

Depends on Paolo's commits:
[1] net/sched: act_pedit: really ensure the skb is writable
[2] selftests: mptcp: fix MP_FAIL test-case

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index a5e90532eaea..91c840ec91c8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2739,8 +2739,8 @@ fail_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 1024
-		chk_join_nr 1 1 1 +1 +0 1 1 0 "$(pedit_action_pkts)"
+		run_tests $ns1 $ns2 10.0.1.1 128
+		chk_join_nr 1 1 1 1 0 1 1 0 "$(pedit_action_pkts)"
 	fi
 }
=20
--=20
2.34.1

