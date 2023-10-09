Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2053.outbound.protection.outlook.com [40.107.249.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59BD9CA42
	for <mptcp@lists.linux.dev>; Mon,  9 Oct 2023 06:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OdK3flam"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLORyYQwgknl8O//skzDEvPxAUybiqjmPBTDKDr7c0Ee+JvCkBTd6cU4bB7ik2FbYDBkE2Chfxu78R9c/k0E9nY4E0suHHKQf4Y4aWJd+mmW0oTHg9LRptSJSa+Y0D97LtRU+UNbmd+h9t0Lc3bK5meEWFUIcUShen3SIpVudZU6RVJJoNpwV62r8OnO6EljEtUiIRcePkkGNDupiPQlj52t0DLlxPFSUCAPkEmosEFRJGw07z+qC3v0mWJ+pylXOmpAJI1QPS2V2hOa4hFfA1r6+8FWOEqUr9TCjI9Q94No6rusU89wr1KuFK5YprFubeLpgCISNiiK+Y0xAvMqzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYXnd7/nJQmqTWmWETRd/CB5Tf7RvjX4NlKcgExcjIc=;
 b=nx7txpoPkb3rta6aEL5tf1sEVhOx1seSxN0aqYwYIjrqN/HgplM+VhxjYH1dig8TlWODlVRo1ai7MG7qLtVL9NHiMyeA1os8uPFRtZsTkNzDUKJXuI7QHiG91fyjVJTrlEiMtQiqj6hr9H8ZclsWUWUrP5O+0sk2qiUilXkZPZczARHZh9CZMktkmm5eRHPyNQqMLL4+tMOkMdEx6gIYIdk957TjcPgDqQSGPxdm7QB2Id30kY+mwxsKRzdBQbM8IQhS3pW5bMjae26h1GTyMpmIC+28eFV/1F96dHPTGzn0UrhT8sX2I7DX1cbokxXYvbKctCyW0WHgDkhMrfhViw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYXnd7/nJQmqTWmWETRd/CB5Tf7RvjX4NlKcgExcjIc=;
 b=OdK3flam8hjb7v4asFYbc8G5wHht205qo50/doVfc1jYrXNhZEUtxJoyZRQOBcCheygFWLX9Klc2tga3cLuVD5GdEei8q7urMUaNXiSXtidYS1j+Tp7bFgRDaOQgH4+/ALTFq7anKYUKy83tfICP0S/0sd6AYGziDo3RWcGb1Hfh0nh1HCxg+z00smu4W0lUOYTiFLcPbmeK+NDeDEDMupCSzQwNn3gW/bl2zjgAMXRbT8/EJuC/NChmzKneI8SMfb2oK/kAHT+e3yhL6v0Iv8jIcngiimLcaRlv0LCKheeuopRCH+9JPZDTOgB0v6uOX93yAM4M6L/w0C+2Hzw6GA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9658.eurprd04.prod.outlook.com (2603:10a6:10:31f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 06:01:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6838.030; Mon, 9 Oct 2023
 06:01:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 1/5] mptcp: avoid resetting when another subflow available
Date: Mon,  9 Oct 2023 14:02:56 +0800
Message-Id: <2b69fa22510db02a12eb101c3e8173dda76f8133.1696831239.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1696831239.git.geliang.tang@suse.com>
References: <cover.1696831239.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9658:EE_
X-MS-Office365-Filtering-Correlation-Id: 21632c61-92e9-4d56-8b65-08dbc88d3ef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nKYiOLrTucbQJu9oFabsZi2zi7s8wsjX0gCLinrLMbkhRs+l5C7Dl0gAHJj+fX/QXwYnPWHs7hxURnalB60Ky7TocFuZKD3qY94P3Cn0to1juHx5/lDcP6EXiPUK4V4Htx6jfaj1TMTk1t+86fx2P+d1kbMMaFjbW0KVInCF3UmsKfNwK3hPNKSNjmVFny5asdRpjuxfL2xe6QaPXR2VfOFZSo7lZSazP4qa0Y8HCUYxhyLCaDzZQcUmyaeTUNIxWWremqkPUqMM5IX8dJ+m/vRo+SrwKqniRybrHB0jaCJASBKfkxEdzVIwVRor3RkhNk3xtb+lcSwhX6L/ahS/+9k2JwZOj7BFvkHMBAK1pXHdYHrRkgkMR7yfbhTk/BR20FVxS8Gr+mTYYL8CyzXwq4rz8zLIaH2MrZRfPH7+ZLjRbi3HEVPWssQSVsK6Y7hQt/ut8t1V/rZiCHlS8viYHYv2d9I9WeSO1sjCrMnzg7GWE9QoDWs3wAPzjX6FrcKesDFvGdbmHX9GZaKAHTlOmUVQ7tb/+YjC3GWF5RST57+n6N9O6GtCAUS4z+G9h1ZBzVTUP2S23QBJ0tm/4cvBbKr4IiGGklWXLuMxV3lqtCk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(6506007)(107886003)(2616005)(6512007)(36756003)(86362001)(38100700002)(26005)(83380400001)(4744005)(2906002)(44832011)(6486002)(478600001)(41300700001)(8676002)(4326008)(316002)(8936002)(66476007)(5660300002)(6916009)(66946007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FcKSCgpPNtvgZNyDoOYadoT1juUlYIilx5US9XxoDO7Yxy3T5oAPc3tlsL3p?=
 =?us-ascii?Q?zantDrHin1+d1jM1sjxzad2GrwA36BfE/MXH3uOon929LEjpJdor8Ouu13Oe?=
 =?us-ascii?Q?VZ7uUIaG8Xp/YNbCAQ+rzp8ppUL5Qm2ViG1J77oxYkXTSNmZ6MDCGwu8DH9y?=
 =?us-ascii?Q?dYrM5hwbtD+cHKtDiKIadSSndQG793hVulDd5b69lc6fIxbpmFnUJYYN9I/D?=
 =?us-ascii?Q?FVq65j0IOGcTmQasjhQkDMzMzi8NHh3QDJk/VugGv85mpiCvsga6FFdGvYex?=
 =?us-ascii?Q?lD29T2SKYsuxwJGgrhxiV8YtkGOg/PiqWLbJW1EbRF84TlTepuI7KIJ6IEEI?=
 =?us-ascii?Q?CC4XMeK8tgukqwwsOp6SaRMkjW19go4lkC8Qa7cMpJOFjAnY2NyW2dJrEsYI?=
 =?us-ascii?Q?C325xoq9phXW0xjjArAsV1eF366fXK2Ioya1BcTi8NKEMQB0TiHiVhCb3of2?=
 =?us-ascii?Q?IZZ9gHduc2ZsNQk7v+9+Q9uCWVyT5CrVOOUjA1LvrnZp7GMVw1+/KfGeQwTu?=
 =?us-ascii?Q?Yg1TK/Q+d2hRBSwcKNiDb/c+KAhxXwK4K2VQ42P+R1cauXnX/PE5KxoT0sTL?=
 =?us-ascii?Q?DqswUsBOLVwPihr8XRqoqKk4uf/4Jxp0MP3nlnWHDegSiIdR1a2TbhrC48yc?=
 =?us-ascii?Q?NzFoeQOEJAp/n1zmRgkxFbpIX+mwqq1L6Hl3+HVp7/LOrs8WJg36xbpcbZB6?=
 =?us-ascii?Q?U8+VtL10MbPY7g1iaoKq2boQht0MttI9VeM3P3dqEVcBF+1Ee8R0N4ITSmci?=
 =?us-ascii?Q?pzEZ1kwdkTQkfh24uVYNgQlrq3TgsxAvUFqg6q8RBQZbhjsyc7MhK3USN90c?=
 =?us-ascii?Q?GXItQN7ws182DvnKigYp7olIdnuri5YNSpGZmrG1Pm6A5EDSDHDk+K3KNh9t?=
 =?us-ascii?Q?0dIYnIsS6Kju8nVriA/nQCJjBxZNmKZSWy512sTZ4MMtGhgbbbRBR0gyJfkE?=
 =?us-ascii?Q?0SQI7BJdgBQqhB8y30IPTgjeZKW4ofSy+RWE64t6DXIPBa36xyYH0aj9QS4U?=
 =?us-ascii?Q?iiJnlj5ZQIp0SeAnFRwXQJRPGITfElSz8aUgxm3sq1nfgt08g7SXvsVoKys9?=
 =?us-ascii?Q?M1/ittM7aZVYDInAarmr3wVWFbRccLGRjeVRYlQIq1t5fcPXNusmq5GKf4ve?=
 =?us-ascii?Q?hmZyNmMDTBA4fQIeI2hWvELnsYDgzHqWYebBtD0biFcJHDCdQkqXOcP7/+DB?=
 =?us-ascii?Q?IYSz1SwbNldDW3KY2w4GU8l4NKlqa+YUOJ+UEIvjnaD5PugRLpJSYVpVev37?=
 =?us-ascii?Q?LAwDSPbCzEzul/GPgtksUDnbJoU/xv4DEfQPkmh+4mhTdsqKehpNBhdXEWiF?=
 =?us-ascii?Q?lFiaf7AaFWBqRtn3lb7oI2XUOlwNcAnqBrdSE3h+Yg7IZ3Kumy2Be/9PTU/k?=
 =?us-ascii?Q?tZKogp5iFWmBkBr5dkC99m+C7Zv7vLvbCDarVscIQS8phRuGQbR8EklHPXco?=
 =?us-ascii?Q?bGabYCUbvwND7baNwvOjpFckXCJ/F4Bsh/MHYIW+sPKKmuYkQhE1oTp1kRBz?=
 =?us-ascii?Q?WomOKVvjO7bdHrTNsB6FN40EPwv3ctBhuJSmV47DIrwmWx2/nQb+He0mvZfU?=
 =?us-ascii?Q?UCEG5qzU13+0GNMfiJP0W7C7llEQZxXlPlFILkeP?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21632c61-92e9-4d56-8b65-08dbc88d3ef4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 06:01:57.6346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ba1JiLw8H+69kc3XQ+W/Ge4IzYQxKf/+Belvw5fKCeg0wg+TcQdvILj2h5Gbhx2fsNJGeUMpv9tBX2nVt98NRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9658

When closing the msk->first socket in __mptcp_close_ssk(), if there's
another subflow available, it's better to avoid resetting it.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 30e0c29ae0a4..6346a164ed66 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2396,7 +2396,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		goto out_release;
 	}
 
-	dispose_it = msk->free_first || ssk != msk->first;
+	dispose_it = msk->free_first || ssk != msk->first || !list_is_singular(&msk->conn_list);
 	if (dispose_it)
 		list_del(&subflow->node);
 
@@ -2446,7 +2446,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 
 	sock_put(ssk);
 
-	if (ssk == msk->first)
+	if (ssk == msk->first && list_is_singular(&msk->conn_list))
 		WRITE_ONCE(msk->first, NULL);
 
 out:
-- 
2.35.3

