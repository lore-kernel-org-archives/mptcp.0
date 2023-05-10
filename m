Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2088.outbound.protection.outlook.com [40.107.14.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FE3808
	for <mptcp@lists.linux.dev>; Wed, 10 May 2023 04:20:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZxGEF4dWxWqBPW9otqdXbany0TocYyleRf/vp2dMHqe1f+msQvUV8Eh1vbCTg6+3PQzeR/7pp60hBKXBZgq4Hs2WTdCD/qOedS9toxwEz8glpkA2xFMG1RgE28vCmMyqYBS0iP+CdkUHep5SSJH6dFrsofxSE8YbTce0394BYfbcpN5W1aX7o/TsFr14CeaUrEkcqVa6RHIIGoZShUucRe9Gd67XThcLGcJnwi29VV2JmayQ+rs7p90joH4I8w+QIrg+OJvnqKhKQbyW4eAgry82kYNHdHLk6OVkvRqkliyCdDJEQ1jJu7SPlgHo+VOA6iCOaKueTnhtRUomnezFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTjgHtFxHRUGA2OOR13fqbi64PVR68kzlKIrFhxtaSU=;
 b=azR466ei6M7BwR5f/+ijm97cZUE7PZo9wPcF7xTPBg3ZUwH4BU+UGiw4z/mHlx4hkjEHoZg5zTR7UxaTUDncf9vLHaHLo0PkPsn0OjOeqkPtVv17ZuDGa0cet9xcRkMW2G0CMsbnGSiF1S0miLvMn8nlwDcDjz8e2v/4noa1biyvFf/SXSdZF+y8Lxlx908/8rGMEgL+V1xAyl0sNgw2890ZW32kh7LUEZmyYuA8ItEivepvngcsCHecguNHxIknLK+udd4wJFOOzFP8XjePcSTkQw94Up/K/claSLyd3p983ZYMC6p1pRBJoO3n616e4p/2J2aBJ+LGO2DTct9VZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTjgHtFxHRUGA2OOR13fqbi64PVR68kzlKIrFhxtaSU=;
 b=27j2ghEAA45ccW5JGexhDgxE82/xlfolQ7j9sCno4S1zkH5xapCnMhUJcNU57GYvYm3LkHs1rFJB+g7nWIu6sYRrcYDwnesRJXQqYi9q9fBUV+Md4GSkWstUcwSYC2zPMiMfHhGnfMwL37hUDxSfziML99bhnzY8RLEd9Y5nfqBpOPz1QhgrgY8TRAufq5MO0InHWJoFK8edZCr9MaYKTx1arb0UsXGFZCmMYrual8to4CRd0J1U0Z/nvSaXhfHfBAYk3e1QryEKdAHcmUN5FGVNvWrBfMLUocT9xAuD2IZRgrSEzFzQuIvmtFzEIiJ3KH3Y0Bdd4aa70r6R2AUnnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7146.eurprd04.prod.outlook.com (2603:10a6:10:127::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 04:20:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2%6]) with mapi id 15.20.6363.025; Wed, 10 May 2023
 04:20:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 2/5] selftests: mptcp: update userspace pm addr tests
Date: Wed, 10 May 2023 12:20:09 +0800
Message-Id: <37b61d99403ec9572724fc2b4f4c0f50ed6ace35.1683692137.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1683692137.git.geliang.tang@suse.com>
References: <cover.1683692137.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0043.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ad01cbb-f984-4479-1e92-08db510ddfb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	05jB0nC0diXIkGEaKmAexPo5Bq9DqBWGQ7mMfFSgFruWTxycQ06fdlTJoq/x4AJpzd6MbbcbbQ1DW7W6EGGA3qO5epYFtS+Dn7wvlUeIhrK1/koigl1TffOqVvCPW9Y1fSUqDHN8T5tTEhf6l/TRrw182Ietd8IwfHzpYWDtgLvhFrA/FT4w+SLY0WRKvXasqSAPgmClP1ZPsk2zgdBtWM/tHSgG5vjP+V1qtFBfYp3JrSUo/Nx8KJuR2vrDYGrA6tXLOf9PMeo5dSDlAkOle3qx4YcKueMNL+rKCKqtuF645jgfwzvDoL209VWdF6LkKimVa0Y/a8lYsSEVG1iWwgvLxXqV40U52sLviTn52cQiT1gkCbPnxDB6prWdOVlCSXfIf7OaXQo1D30y34a/JHCiJWUbMG37wAdkZG/u5/LvLGJ2TMEzum6kqGHc2ig4C1soZmJz+cqLb+qZlxM07Wz9mcIbSBwV2TR3om5G+PhTPWCcrOANJMzG4HMPLAjrRDIDgghKlYumtwoZuwXJLjj6RI5kXsBRnW6wjhCVBwZiEJiLJBG1/18aSRrCtsBd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199021)(478600001)(66946007)(4326008)(6486002)(6666004)(66476007)(66556008)(6916009)(316002)(86362001)(36756003)(83380400001)(2616005)(6506007)(107886003)(6512007)(26005)(5660300002)(2906002)(8676002)(44832011)(15650500001)(41300700001)(8936002)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mwqMLOtnWiEj7EVG+rmWaS0B2pCfnCiX8+Y+o2aAuiTR5SeH8N6lEA4Xlq/0?=
 =?us-ascii?Q?+6bboL+x0gE4GKk0VGRV+Jm7lmFDICkEV1qXQpTqiYVQ6iD4Os3d6Qv16Kya?=
 =?us-ascii?Q?uHj++tlTZfhAJHuo9wQb572BidYz64yyHGXAZOuEqTZ3jaCQZovm20DpDJsT?=
 =?us-ascii?Q?7gcusVA//1SQQs9lLomM+6XqHqPi0XgKzdQVtiGJ91fxIRLojWGWy+Hgn87q?=
 =?us-ascii?Q?tdmZX9xixjSGc/KjvHQ9ADka06miNhyXGWHSYC9GBOw8IvRQ2fQvhzf6X3Iq?=
 =?us-ascii?Q?CnOsGDbnJGU/ks8u+lA9s6pXzEKklUseIwiEQpzFCQD10X7E6vV4vqAqW08n?=
 =?us-ascii?Q?axa0x9yByxGKA3MLKILc7HSIe5Fu5dlccfcS7R6DuBpoGnmob/7+0+Sbwos+?=
 =?us-ascii?Q?4ErkMdV+jSewNSwHBZFFX76TBmf+XePyHVDXxgrJ7LtpnSRFBtNHgYHqMbID?=
 =?us-ascii?Q?xMYt7lyBtft9+1UGMLMbGpo8AcnMA8MuKLX/NSGqS3o1DuGQO+M/LS3FGS0T?=
 =?us-ascii?Q?rXxLZGPHGyCNHC7PoGOh59JjegBM8pq8XxH+P6KrDfU2rA8Y+Irz+FXJ5x0K?=
 =?us-ascii?Q?dHMZX+I8+P4h1d3xsumadiBTmSuGHeH/hCQ8h9r/y0l1nK+4WWOVuZZZ/ebM?=
 =?us-ascii?Q?3QpEi9h7dYRVNVed3+U8TAWlR+sfROaqa6booghc+Z64mm+lIGel6JH0Q2D/?=
 =?us-ascii?Q?N/Sy5FGQIaoAWW3CUwetlU3vN8r6taN2kx0MXTtad9Dmyv+rqsJOje6L0q0B?=
 =?us-ascii?Q?xNzIP2bx9+LoCS/rPuxN2ddLawBMJc0WGV1fnhgYMJN/RiV9GiYYE2UfPRwo?=
 =?us-ascii?Q?mkdYT9/anCbA0Immv4iN7cAl+9sF4gJ4imkrwkza6Kequ/le1IHYmrYHl/wk?=
 =?us-ascii?Q?QGQnebjL0rQ1JIcfqePZ+ca/UbyfYr+s1n9RFEKh8VCceX1afzYdH9FoxjYF?=
 =?us-ascii?Q?dlPiu3Lqpz5VYz7jusHpzZ0aKw3sq/eGz1zFFLya+P9y9Ye6Hxyj8jHSKk2/?=
 =?us-ascii?Q?8AgSzsfd3IBEfU0vM3N3yY6HDJmppzBt+W50QQcKnJtDB3AKBCEQw8XnTzYW?=
 =?us-ascii?Q?r6OXFfnc9G/SBDbn5aI2CEnfkExbQCtGkHTEGabcKUjPgff1iVEUSNHAd/4P?=
 =?us-ascii?Q?dK62lMYZo31WkARq9V+DH60egcA2IUy0quaARHVS3gDSE3nw7rI1MeTMLtRA?=
 =?us-ascii?Q?GE/AfChunXcFoopOqtySP2ppKKiwXlI179TOa7UzM6yMWH5pvAxVrY0zPGoE?=
 =?us-ascii?Q?dap1yYCrZNf5w96hEAcOQP/ALNrKF3g0TwSIsIEsRUO7RczAAUc4eKWdTwvu?=
 =?us-ascii?Q?chk3R4Gbg+CuBu08/QaJ9cmS0usV76k9hsEvRVmU88pbrsu4J7lRre/xtEcX?=
 =?us-ascii?Q?ySU4FffHJkmolWLXUo4KKWjQspP+aSmV8wnHzVQA0kwEfU3tDAhowOpDfTSP?=
 =?us-ascii?Q?KLmGfmn9acEAE8S5xyDYq6DVQYdSe/v8QY2qlqcefLnCK9kpc0uCvLEu6Aw6?=
 =?us-ascii?Q?3E7qWPSi1D3+bKQYY92S4GEbOR0zuq/OYXkK5MoB0m6WamNazAEB9+ldB7il?=
 =?us-ascii?Q?J3zY+wG5YQ/nbdyg8kQoDXA0hlUTfcNUrisZwPdk?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad01cbb-f984-4479-1e92-08db510ddfb0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 04:20:23.6276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sK7MS4jA+1jEI3ZxsnMOaAKA4h7ZtTzhpkYBcvgSPS8tqu6AqmtAQwbTqITXtYnMSivxgn/E3AOn3DqsSQF/Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7146

This patch is linked to the previous commit ("mptcp: only send RM_ADDR in
nl_cmd_remove").

To align with what is done by the in-kernel PM, update userspace pm addr
selftests, by sending a remove_subflows command together before the
remove_addrs command.

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Fixes: 97040cf9806e ("selftests: mptcp: userspace pm address tests")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 627daeb513a0..0737ddd62564 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -863,6 +863,14 @@ do_transfer()
 				     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
 				ip netns exec ${listener_ns} ./pm_nl_ctl ann $addr token $tk id $id
 				sleep 1
+				sp=$(grep "type:10" "$evts_ns1" |
+				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+				da=$(grep "type:10" "$evts_ns1" |
+				     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+				dp=$(grep "type:10" "$evts_ns1" |
+				     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
+				ip netns exec ${listener_ns} ./pm_nl_ctl dsf lip "::ffff:$addr" \
+							lport $sp rip $da rport $dp token $tk
 				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
 			fi
 
-- 
2.35.3

