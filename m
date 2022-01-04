Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB05C2C9C
	for <mptcp@lists.linux.dev>; Tue,  4 Jan 2022 10:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641291117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zTliQydwIJYMGhhc85buxfYo71yzoTSDYzDeeHXYdaE=;
	b=lsApbXcl5dI8ww2Ryk5FUH89Bf75vNNUbdXNGGI09NL10xIMjXQ7FiFqTeBVFqCUeKiCw1
	67WvWSid7l4phNQg1jSRg6S4D5DcRvab4TnAg9ga+W0EEGd93nHOCQZGyDcQtfq6Cs8Pwn
	AcsYkBe03hK/u+ScHhVx90kFKy3VAjg=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2053.outbound.protection.outlook.com [104.47.12.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-kNeS0hYZO5mdn56zde3FCQ-1; Tue, 04 Jan 2022 11:11:55 +0100
X-MC-Unique: kNeS0hYZO5mdn56zde3FCQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLE/DJVR9iTWydQ5cNtyi9rWoId/Hqcy8KELwdd9F9uSE6UgOztNMBOAalTb4SOHLFOi4RRpbDoDeVlgdmWT2SytzDsB0KA8Fbsg663Z5BweZnf97io1rVRT7Q+QByVebWmAmzfTg+z+7GNIBp4bp1/GnoeaXLIVEOOeJtR9yH1xE5bE2kFQ6jQLqES5Sb/ZfOB/SWs1qslC5Op+omaFvqTkFrBCRwavqHW9ecRQVtepVm5sIcKYUvEJ6AeGHxyeHMnt2aYcMDSTWSHFvfVgnLJUCrGD2lcRE7o9rtVvIeUoEXtQZ3udG179pwO67dOqFcPjUAh4x7wnFJIwwAifgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phYuzi6RE58qlRybUuzXEulnkwGBCwGqqFb5/9j8Zp0=;
 b=c+CmAPMeruElHVcCTiO/4Un+Q5fXTZeSGP5y1+N7U5M1fcmklAk9j9bN43GB2zUJ3ygjC5462Uo5i9NtP98z0kLDt7gZqUe57j6qf3JDXrqFR7WZOazb9on4lneVNYMYra67LE8oFPq1Q88ftlvGegOKNiXALgBvoslwynKiT7TCrxpwM1ZlwwGXmH/SGJMH9NRQ2uxK19sBnXIeZ2pt4Sru9R/C+kgNN1/fzQp1RzqYSf4MIRyTCDyA+FQgtoSd9ABxUiwPpq1peI+CC7gtsxp3heH+cREo57TzPU7NZORICmEUIo+YFt/UC0yo+K8g/bTIiM6u0zxJwzPi7qkIcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB3162.eurprd04.prod.outlook.com (2603:10a6:7:20::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 10:11:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 10:11:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 4/4] selftests: mptcp: use 'ip mptcp' in simult_flows.sh
Date: Tue,  4 Jan 2022 18:11:19 +0800
Message-ID: <7010ef65ca65ccfe3a5b118fcc296515a8ade984.1641290905.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641290905.git.geliang.tang@suse.com>
References: <cover.1641290905.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0211.apcprd02.prod.outlook.com
 (2603:1096:201:20::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46271311-4ffb-4a7a-b873-08d9cf6aa273
X-MS-TrafficTypeDiagnostic: HE1PR04MB3162:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB3162371AAA0D635C01449F3CF84A9@HE1PR04MB3162.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dEN22M35Tc2lYyacw/3tIEfndBjaasf4fN+fuX/6ryUp5arTl/DFlqD6rVyWt2N13Jsz/PDX4BJK4VQpfWCaxad1chFxJuM/FMAFwZjJTe69Nxy0tkWWQNKoip/vJDMPQ4DYTEUlmJkpjSe+kpvf2ZGrEvrK/MvCLFI+2b6l9hBn4JMIeyWCCEc8sfkhTSXV00vAdEOXZldmlBkA0j1wH/2P8JiAR5vJCQeFs+kz5TPpK4u2QtWjQD1jql/kkCfUNw37t1DSfotPRmJJeW/pMWfVCXwac1R8ZrBTRGqT+vybsQegEdh13i14L+pjrB6+I+ALtUZ70cIiHf6cr60wxSKS75gH85Bw9NZu3l9SHrpFfCq6Paeg6KKA0RATWhHLQVVNMr+79z3vji7tZHBisw19GGVqPxWugd4K54MOfXVfPFCia71MSeEukti8YCpVMSIz8HXkpIzC7L7Pws65f5nlT8vf/KmpSmUTCCe1yD4yQL+b1MddGGdNrJnlqM82PqYhX57dqBR/oL86CKYRPrWdpo7xGfWqxMjYo/stDJS7RHY10QQwM0i9/IrcL+VOkB9dW8UQqi1easH50J3OC+N+C98JEjZqKb6OQPYXJCCrGkAfW3Dc+bu5vRnB2v0EYZ5YjKXFIKejJ4w8szz17w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(66476007)(44832011)(508600001)(26005)(83380400001)(316002)(4326008)(66946007)(107886003)(66556008)(2906002)(6512007)(36756003)(55236004)(2616005)(6486002)(6506007)(8936002)(86362001)(8676002)(6666004)(186003)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XouPcXTl+V5UT5dwxYh81ubRohLL94XlLusfnffQtqwZNqXrO5l00/4EOgHC?=
 =?us-ascii?Q?QjyItkxemE8fkF8zF9heFAv/fduVJKUpXUhbveZRXY+WIuH6j7iESBgkTtG2?=
 =?us-ascii?Q?Z82K3eUT6L5HSbu/a90SUBZGTBG6BHPKCnUXZKTnpPTCF+tVeqbRfRy6qqqH?=
 =?us-ascii?Q?W3IqP9EOwsW1y/9qeS7wHiaFFL7Xc1CZoCkWiOrrZnCLkeDvF+aa2LzmMaYM?=
 =?us-ascii?Q?L1KlKEHHjvU/yFkoFQ409+FWL4JM36B3KKcPY71Rj4QgvsVv3U60e6K00xlO?=
 =?us-ascii?Q?rQNjrPQJ7d7DQK0s04xj9W3r0gqA9AXYZVp4dOpgfz8KTQqRs2gUpMHV7m9P?=
 =?us-ascii?Q?q+dbsz8oZTphFRjvSqps3pCPoy78CQGkFf0d4XYPKiq362V6/zZStV8xA4JN?=
 =?us-ascii?Q?1+wic0pRoYoaOIHL7BjlZwRJtJO9ncoP62XEX2WXwg010aE3GtIYxd2Sh62y?=
 =?us-ascii?Q?4JVzo22/rbiSjLh7SZ/aeu+WAEL+i7+I/jT92w9/FGysikWxos/R8vPP77up?=
 =?us-ascii?Q?HfOPube5iJPjZaqth/NFa9vO1T55hU7pJz1NHLsg1Xyy/BCrDSBwYHn1Hn9w?=
 =?us-ascii?Q?xv2gOuMhFzqq35mziwcN3ljouxN+KnF3BaK6E2b5yDlgxjdlB/W/bMTz8+iP?=
 =?us-ascii?Q?URtGCufj2y/YBHHqGCZOzRMkqEt/KdILWslmJdn1FPAxnuWqQRiJQ/Z8Jn26?=
 =?us-ascii?Q?a6gf7nwofQRN4zLaP2bKRoyESxcC0u8yyBl4jjNgkfkIBGYp4Sfj9/kCOlv2?=
 =?us-ascii?Q?l4rlNhiqxS4B1ZOb89vzMXfyPVOpGH3qbOZSrekk1yWPi4ixmYArbVO70w4T?=
 =?us-ascii?Q?qfgBPDBeoV9x2g7VLTJVZYus2tkPv6gz3LR8N5H43iw+K8ubr7N9jB3tt2Uj?=
 =?us-ascii?Q?8dfkrv9R5ziHg4D96L3Q9JT9sq/UQwYAS8eYKRPVnf0aF62WCdSgRpMa2RYs?=
 =?us-ascii?Q?A2MLaGTCqBmbAgO5mpDHFpird8E26KlsKBW98A453ehqpkYhUsssQ4rEdLzm?=
 =?us-ascii?Q?G5211bvewwbd20esSnOC8cyQnChd/xVKUjrNIv55Qo4aEMO2h+yHUoQtqWFD?=
 =?us-ascii?Q?0dnpQ9WOxLLnKkw94sEvJNbpR7cHV2L6tLr3bnpK5QoG4DWJHNtfJPhZrH53?=
 =?us-ascii?Q?IhlWJKxIitYAkJ0aKFFwqvdRJnolx5yHgATA2jSLsD/HNAgTkXn+t8mE+Y1m?=
 =?us-ascii?Q?6aKQYEz2vrvoVZ3ztVf5O+YKrWkI0B+Ov/52Y20ZkNuaOyUqkgU7spwry8T5?=
 =?us-ascii?Q?DeVv9RNi+yUW0BHMt0TtxEZvjjidbF5LN68gR2gMQlarZ8iiNioNKe4+y0+n?=
 =?us-ascii?Q?sRxfVizSIDeZU/OR3EUSfBrpnwymXDz0R2CpdJ/5A1bmJt/WHsv30F1vHKvh?=
 =?us-ascii?Q?zsW1EkfdbuzPz6b9J1c1THB400j30D20d6nKyzbIxm6C4FHwQzhNXa8L79rt?=
 =?us-ascii?Q?izyOR2dwPV3ZoYCurlN1d70JQjtn9nqaI1o+sllBzlsMChZAbf6NeuYLwVHJ?=
 =?us-ascii?Q?JonJ3ju3RoLi/uYivfKbIzPL+ds2D68772CiLbtVQQIYhb/x2Edggo1Y6WKi?=
 =?us-ascii?Q?ozu2r8CFtnFd2PHOQ3BDu5yj7KWjzF4/EXzbBuVcMTbnDlaOnt3yoluqQuQD?=
 =?us-ascii?Q?4AuRwf6D9Tb1bUfkNy838Yw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46271311-4ffb-4a7a-b873-08d9cf6aa273
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 10:11:54.9080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DO/sX8QyZKSPyzz2MFIDKkq9oUyZbogRwPBZueizNRgVPquaF4kOT6vYdnncu0TDoTYQd1WZMClcGdbZOhI/kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3162

This patch replaced all the pm_nl_ctl commands in the simult_flows.sh
script with the 'ip mptcp' commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/test=
ing/selftests/net/mptcp/simult_flows.sh
index f441ff7904fc..af2eb5b3da66 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -80,8 +80,8 @@ setup()
 	ip -net "$ns1" route add default via 10.0.2.2 metric 101
 	ip -net "$ns1" route add default via dead:beef:2::2 metric 101
=20
-	ip netns exec "$ns1" ./pm_nl_ctl limits 1 1
-	ip netns exec "$ns1" ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags subflow
+	ip -net "$ns1" mptcp limits set add_addr_accepted 1 subflows 1
+	ip -net "$ns1" mptcp endpoint add 10.0.2.1 dev ns1eth2 subflow
=20
 	ip -net "$ns2" addr add 10.0.1.2/24 dev ns2eth1
 	ip -net "$ns2" addr add dead:beef:1::2/64 dev ns2eth1 nodad
@@ -103,7 +103,7 @@ setup()
 	ip -net "$ns3" route add default via 10.0.3.2
 	ip -net "$ns3" route add default via dead:beef:3::2
=20
-	ip netns exec "$ns3" ./pm_nl_ctl limits 1 1
+	ip -net "$ns3" mptcp limits set add_addr_accepted 1 subflows 1
 }
=20
 # $1: ns, $2: port
--=20
2.31.1

