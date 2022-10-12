Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60084.outbound.protection.outlook.com [40.107.6.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C458017CA
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 04:51:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBy7i49LYaYXCDxrGCZTkJHwVrlcqeAfBJ/LR3NU48Wf9MOxvfNhRejs5fsUSRiX+pwSG3HgRfsuypnDEa9OZv4CHlXBkWl1G3yBEpCaGFNRLLhtnmoMRowQ0OEHNTX50uLiuPN2Ou34DxbcrrYTkqI/YTz638ST2sibruXo+sIdN86yIYUW0nqnUMpiigKj2yYkZM72eqktgcrlGNPIJdCy3V8FQdZVa4b8RU0k8ZwPom1BQCt6YiovUZDFJLeFFHr6nMqslWWQUmESYxyWoSIHNVl8FrqGrxI7es3cG7feUqKQ6l06cJ8cKWC2RlSYZQdkldJiqrhtBOyl9cW9Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxZgkUIdqGdN3WykiFqN0t7incaZ0AXJQmvF15SxBn8=;
 b=npPkfULDRhmkZ0S5bsy//SlIEcjFq6sFC0Umrf1pzhr6JwiI+CUqRlUYraM+rM7CB+cE28sAcKYQ1YhQn/f6KHrEx8PaO4f/bYOJsJcUcvCAmDKHST4ogoz9ZuOpGPJCxKHdvQef7x/LxCRKxXHc2rq1fH7TWM5SAQXw32zVF+2o4bzPIh0Jiz5C1TQWOML0OAYCZBBpdxBRqji4Rfn4lg7hHrxmg/YhOjSLagGjlsX90YC81NfG8EluvsRubtwtGGEa/t4bYCNYKsafT3Z5crQVUqm5jUlZ7FVQ7Alni0BDGjngC2kPEx52Q9EBWbbbOY5FsvLO8UiHf4EXK/yPOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxZgkUIdqGdN3WykiFqN0t7incaZ0AXJQmvF15SxBn8=;
 b=PzJcgXsBDScYDpMeJZ7aWGsphQ16CbQgPRBR1a7wtRBEdQoTXcYIpDcx0n72tmEajd4WXNugFVTsW8gD7vtI4Pmq17u/+ROviG+qfNkH+oB+6zLqiSsRoOewSQz8mj5c1195vIpw2PnEfkRjtizmQC3WrV6ORcy/ok6+xzTBJ8bbuCyPKhi9kWKAl9mfQv9C/ewQtHKlPKN8x6Awaq/C4mzLMLQ8tdEVBxB6tdodpnwG2tpBHmsqgkrwihdY6tR0F0ayFwKC1y7gPFaYmiPocE7OzjcIVoYIEi1nNNmukHVvxai+HXgn4QTIzYLh9XgXG3asLWZE2OPSc5RT0mm4EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7722.eurprd04.prod.outlook.com (2603:10a6:10:207::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 04:51:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 04:51:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 05/16] Squash to "mptcp: simplify subflow_push_pending"
Date: Wed, 12 Oct 2022 12:50:26 +0800
Message-Id: <a9ec1d0aefe35aca2254b4b9a47da43a16097d1c.1665549881.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665549881.git.geliang.tang@suse.com>
References: <cover.1665549881.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:3:18::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: 83ac1935-d3d9-426e-1b54-08daac0d662c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bLOsmz8EjqTnedEx7h0RqdtxHbZAFiNgOv/AnYEwYNuiMjDt8genXhMSHk3VwdlN1TGmQrZdHb1Kmwcyv6kzhat/5cR7J3KtS+Jgz1DQbR6cs7MhLEpfAaC8UDtSSb/nhHziBf+a2ErCJmNrcpgZhehUfMgjq5On3BOgTkv2AY0LSo67amawb0rVkbDBEy84cpcVFhkUisTqFKIMIPAkbmlXD8kgL+uabHdFAN7jXhqPNwppViuUUnq59SBqeu6NwBNEz5DEzfDP5p/fMQQDDXN0/D3AHEO1LJPYfolElD+KnH5mU75GsABlY8shYsirEs0h2A9cENuEyzUkdtrpIgdEr+YRs+2t3Es+YRor0pzLF1l5pwM+2nXtr0nvcKbYQJQpt5vO+fd+zN6Zv7+pM8D/QhesGAmR0H590e9yubEvpO0gL88KCKQ8dnSV8m0V0McHXsYtGRG5SA0OyHAgFSJl6Ccf51+TEl/oCrU3LT9X7vpAbF/tGV76CUmPkMHUbAqyAOg0dqkbOupO10nPKNYSPkgTxAYPRTz6AWI18TJDxuGauJSdoJ/DIa5yq0X23GN2t6OqxkltadTU+3tiYjzrNgzh7Ttuk596C4SpNsNU24PLFCNoSuXbmjmdvMVa38x8OatZPH8TwSQ3PnrqCjn4qaOEDvy+jmaDbT+9QUrROHl35tzlyFwa9ITLWp7uoVOFLC/fjWcORMU8h0JBA53ieFJbJ0to5EL4B9URY9MxrvkOCq3eEb5pWPJ+X3tY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199015)(6486002)(478600001)(38100700002)(316002)(6916009)(186003)(66556008)(66946007)(66476007)(8676002)(6666004)(107886003)(4326008)(44832011)(5660300002)(26005)(41300700001)(4744005)(36756003)(8936002)(6506007)(83380400001)(2616005)(2906002)(86362001)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WQ7CN5TM7kxusMCe+ZuKPuWOVzEVbz9kGkfkm4S0H1Y2T7VOeKTaelu/kPrm?=
 =?us-ascii?Q?DPl1L1aLOZt9sShWk6L6TSnl0X+0pLsAa4d+eXoc7foi1bJKLi8CYaq9dNaK?=
 =?us-ascii?Q?+HsCHNFskvqoXac30ZeAuqHa2GQuakZFfOyy+Vn/769w9bP3AS+ChW8AVzUL?=
 =?us-ascii?Q?FSgEfRc0r649h/xKSwjvj7evqtxIrF4RKqSk1bOfoemq5IwODv929LArWh1o?=
 =?us-ascii?Q?U+6oOxWm7BtFo96sy12dWGvfcPXF5Z9xj4B5tVWqsEM0IvkrfiGWXIoVaz/B?=
 =?us-ascii?Q?7E7U9SZMDSQW1naBRvJccdDRxLwiDu0A1Ab9Bp0dsoTwYn/rQRoln3dYYalo?=
 =?us-ascii?Q?rv1lxm1E69Mh7d+E9MvLMCbNuvMe1RdPF0PCTb9pbSNAdnVuPMIsi+Y8XWIb?=
 =?us-ascii?Q?rEGWFvdjxK+2n4ziiFTWyo0GT2OKqIQYGiQQva0yZdVugUf0ol/cn6UYiNK+?=
 =?us-ascii?Q?rj79l8PEZKIjvfHdzq6zcNRT6/6bRG1kS4hUMvA1yOdpkdTlu3jBV6lLfN7W?=
 =?us-ascii?Q?K2xgyAfGVc+5eoQFttQkxpJABcjltoUu+uImZH+KIhW50Pi53Puw1hxOBv99?=
 =?us-ascii?Q?2g3hSa3OH6bsmY+SO+RV7n7L0dH4HvFpgBFVqUK4OWbWlAOaSNg4FntDNJ3A?=
 =?us-ascii?Q?A2y9Raa3ivUxUJn9qVcMVF7X0CBjRc3rX7aPqIkPc8v6mTmlwen42Pu3coiZ?=
 =?us-ascii?Q?Ex9nOHmaYPs4w+6vQedTisbd/XL5KIenIHRLJKWCIMMnhbz5mo75XeBHMg+/?=
 =?us-ascii?Q?CXXAEs6IcRxlYo4Hau/Yxp22e70WRx0vaf7B/GnSJTeZWVbqgrsVP8IHHITf?=
 =?us-ascii?Q?hncEO1EzUm9hQnSrPW4hNOK/WrSnM8iuPdyyB4aF7Q9mSpj02W4rhBgPiKry?=
 =?us-ascii?Q?VpAH8txMBSJCXHV6B1xvzJ9kQHMWPwT9LexeTI/WH5a2HQFaFhCXbIpaOXfS?=
 =?us-ascii?Q?dtJEdzjsiPjIXBPGF1472jhFmtUMYRJkaiMgUP+5eWbMBFL2SSRq6VCFZ/Wt?=
 =?us-ascii?Q?rQmDAoQoueCG8o0vw4tsr9D29erQefoG/9cvdfnropZSiSzDYZwT0ohQOYEy?=
 =?us-ascii?Q?JeByR4cwrxuGFSxXGfnOWAfKr7ANYX/AYimkUBzCvRq2cRp1K5dM0VQ3Gwkf?=
 =?us-ascii?Q?/hM375A9asND9XvspPdcPfCUG4bBVHRio/KIziQpqDhpbizoVzlyZvysLOC5?=
 =?us-ascii?Q?osYdM/ZmwFSTJdjb6dCW9j/jomWcN0PDEWl1EO7IV8U22CCGtDn4PpzMbpEw?=
 =?us-ascii?Q?F5oywDm4KOD3ydvBEAWDXSnQf+xKKTIGQRF5rFApsnz6C6WL0dcdqFyA0sLe?=
 =?us-ascii?Q?4O5rW2FAcw/XZdHPw7v6HD1sYvCBZJKTkKzqQ6NMOBZrmPYkdsz1PgYVZkXT?=
 =?us-ascii?Q?ynqEzV6/vG93BRlpRR9rhs3Syq51F5dliKrGWfM3snEHL/USs5yh/bTWsSRf?=
 =?us-ascii?Q?E+drr1HFxQI1d8mtUWFYxkNh0mDE4I/HbS6laT/fomsSAz47pjnEkg0RNm/M?=
 =?us-ascii?Q?ok/qXghpGuAL+KRI/AIA3FetTgSOzF3S20nXtOcqiwO4Dv/A0ywTZ5hlB7ad?=
 =?us-ascii?Q?MXpAmWjerJT9lgZ2M14zDotLDTeImsxyCQ0CzUGuAW3czzKqeZ5BbZ5BNezD?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ac1935-d3d9-426e-1b54-08daac0d662c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 04:51:17.6315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPd2Bx86/y4yt+fEfP9OFd89JNpShp0sreDHBKDbBcn4I8hygDP96ssN57X1yIvEGh2w9tO71AU2k+Tl1niMfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7722

Pass data to __subflow_push_pending.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 694c07855be9..0f062bf63447 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1606,6 +1606,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 	struct mptcp_sendmsg_info info = {
 		.data_lock_held = true,
 	};
+	struct mptcp_sched_data data;
 	int ret = 0;
 
 	info.flags = 0;
@@ -1615,7 +1616,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 		 * spooling the first chunk of data
 		 */
 		if (first) {
-			ret = __subflow_push_pending(sk, ssk, &info);
+			ret = __subflow_push_pending(sk, ssk, &info, &data);
 			if (ret <= 0) {
 				if (ret == -EAGAIN)
 					goto again;
-- 
2.35.3

