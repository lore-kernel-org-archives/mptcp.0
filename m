Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3374E4AF66
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 11:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="nh5Qv3Pg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vz4HCkjcYY0qivIWrLz1eQmmXDMKwvK9GeuNuaTpFOHA4nmSPQ6Ob24kbScIsKUpq/1iCBIuZrdwm/GWaRK/5EZkBQ43qpnlJ0LcFsTOFhh6vaOretT2WdhgNXSMC3RQb3nJJPdNP6CfwNP0WMzpNHK9+SvEJ6wdokoup1fns0tOD9QEbFK7299IzgeePiu/praypi7KxUutCPzm0UJtz/QWe/Lb8OdRugB5McccMwrXUlOpSCcLEtAYm2cf17VGelI4niGX8y3tGd7APSfvRwcL5bt9sbqMo0KUy2FUiP3aSyxe6qe6KqUEEPirliUNx3kMlPY0CtvtRzJqg0wHxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdUl1ixjV1bMwJiLktDaFUKI1bTI5vMYphE5VCSMZrE=;
 b=cJzAJjAn7xXgZ/8MIKM1I1lKWEwDjIMdh4soJ1vpNrIeinPujdXifa2DUpWZeqOAKvmnRiylUQnCNC0duyKTV3NeDLqH7i6ItUmHuy3mYhPcSbr/bS2DDjKTZHgpbmbW37e7uSmptJ3IPvmE9cC/ebegj2FmPni0wEHtb3tgqqCR0Ft+jz3vWUOsfK1mO7/Xjg40Pg89ndBTrzZB/jziwOYKPo5oWxqxAJCalUmpN6b5c/hoOXxHTluzCeqNl/7o1PNqEk6wVmqOlF08XvXt8TSRCl7aQfy4PS5kBnv2mpWSzJbgUY5ZlsHfnD0u9xsH7+YM3ZmiMd8cvCQGY3xXLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdUl1ixjV1bMwJiLktDaFUKI1bTI5vMYphE5VCSMZrE=;
 b=nh5Qv3Pg7Kg83a4vJpMD6k6lsoSFaHjIMW5H6XatvTsJfzyjXXattxBebhC3fNm7v8jquhJmu0+2is9xxxDiKwHLE4apsM2TtCBSgIUGqlBoq4nqnobhntybZqrTzdohAwFFMMJw2XRYP06f2azaKXnk4d/HN9M3HXyRx61XnRmOfQEP+DKyKAIIasHL3tyYbUUMcCd6hn6jO/4jB5b68q0kBUKFjZPNdd5OQUB6lISPZQtw9CdY/bMGa+xEq7xeEVDmE7oQ6/WJy6ty+pYNO/vswiRXK45sYgvYvMzZhNV9peqVJje9HTQ2LLixImx+qiqHXnYY7jM7/mbENpdyUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8858.eurprd04.prod.outlook.com (2603:10a6:20b:409::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 11:34:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:34:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 30/33] selftests: mptcp: diag: change timeout_poll to 30
Date: Wed, 22 Nov 2023 19:31:18 +0800
Message-Id: <41e3afed4d500ca463ad9f534317b5a6512a14d8.1700652422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700652422.git.geliang.tang@suse.com>
References: <cover.1700652422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0242.apcprd06.prod.outlook.com
 (2603:1096:4:ac::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: e2be7d4c-6d5c-4ed8-344c-08dbeb4effff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xS4UlZBS28QctxebGBmfUPKslflDLBod6qD7snCD/4PowKZxVFa6YSN6NQIYVuWUDSYHvESrnOPpLG4FH9e4Tp3PHun6sRZrigwkYugWugV+O8suDmwX9h/iPyL/Slj6hI+pHwCdPLHt5QUBNY+ZAMAgtU+DNH1qJvNX74HZ46HF7VOO9yqOiG9WRDDmgg3mfl339D4hY0u9i9C41Ff+2bn6aA+q1MX30QRQcbQjAC1sWMINKsws1K9Azn1B2gZQfudD/nAt2VZaWs+BE1OBcAB+3lv57B2D1svcZtqG1jCjdqka9pZoZjtoONCCoz5ie1uEMPL8UyGXvusCpcUn2332afJ6xnS1fKtTY2DP3lqIcAYudWaWQgqzrqxKN9xrKtmHtsYSp8nRpV8Qe56Pxhb5TZ0HCUsnxN9/b5+tHKteS03AkMX+r3tsb6CuHhtCcqaWby6WXmh8r5AFy+hMUYODkctV/GhiKq4w14ZDUBTnl0hOt7ibgu42DiIuPP913oo34f4cbRgMmt2uT4sghi/TQVf5EGQLDP1VLSD2oNva1jtI5em6FwMCw+o1aHftI/ULbHYgWX+Cq4VPuj8D0C2W0v94NIoBx336GPn6RhM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(346002)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(5660300002)(36756003)(8936002)(44832011)(8676002)(478600001)(6486002)(86362001)(4326008)(6512007)(316002)(6916009)(66476007)(66946007)(66556008)(4744005)(41300700001)(38100700002)(2906002)(83380400001)(26005)(2616005)(107886003)(6666004)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jRtaimAAmax+/+Sc5EnclEGLWKE9kgBOU4NaL498o3defYva1JKBfpzJo8uK?=
 =?us-ascii?Q?i+sS/8hFsa2tVYqpHLeFo2oqndUDltbiKIkCRRprGUcaHiX3rG5aXcnKv0kL?=
 =?us-ascii?Q?R7Yxb+IOQ3DlVawYOqGhyelBt6OxsnE7S4ypzxq2aWul6SDflWfN/gaj2ESd?=
 =?us-ascii?Q?zI0vZ5Wx/5js6S93tmMbYkr2SKu2u51yqU5vkyCYdwEzWkStbHiL8emAWnLD?=
 =?us-ascii?Q?ZoYWGQ8qUcvon6kcs0hsLkQebywNM+OxDPnUm75LwOXuiOWRz+X2543iiamw?=
 =?us-ascii?Q?+RyJhTTEO+09KoJoM7EfqTAfBzc38c+HjUmmJdQFkEBC6i+ovJEKd24boQpz?=
 =?us-ascii?Q?J8hleGMcyVvMDNQcXNLuSoh9WVriYjmfrgtgQnQJkq6ETPsF2NaSCJ12X/c1?=
 =?us-ascii?Q?hbYHT6JhLR0O2ASDtT5m4Hw/vkdTgD74fEd9J6Z3CLQzGIqjbsVbClTIrqWj?=
 =?us-ascii?Q?z09JxHJAV9eMt0K3wGJqu8Jb1loXIMWJVCG57t7ogxz8Pr9bdVrXu8ay6KeE?=
 =?us-ascii?Q?8YomqPa7Y0ITCAkoWa6xo1qE5hXw0bO7RYGdGHAsyPbutALv+ljpdHH0gAdG?=
 =?us-ascii?Q?h3ZSzXrXYKE5LSEtPrpS2TxlN5IpMYjt0kbpExRJQ42hRlCDqvnB/Ihqg3P+?=
 =?us-ascii?Q?yrlsp936eOlvVEbAmXrRUq8PlPfhR9ZXQqvpCtVQiWSRPEkephQ+T2PTFqUi?=
 =?us-ascii?Q?3qsCqt4FdTQA+InLNuWoiMKhl0MURZtamsyj3yluwf+OWRRqf4dflMlibWal?=
 =?us-ascii?Q?idsmX9t4GaQIJ8IndmYaa8EIPUErMhqxxk6BMQYnJxvFbLk/nSEC7bCYM63X?=
 =?us-ascii?Q?ONoAkH/qJxRCJsonjuZj3Xi6Goc5NDS1YAlxu47nLPPUcHgCTaX7yuSedrYJ?=
 =?us-ascii?Q?rxzR8sxHsDTPV76ZOX1jpjd/ZstQuZvqfWJi8c5QDjvZjI6FTXlJ5DL2QHSH?=
 =?us-ascii?Q?uWKPumVXvZ+8lynLNdGFQniwAL1cKViIvlbWFZ+9jrdHbJeN6ATZjhG9qqFG?=
 =?us-ascii?Q?2z2Bi2Q9AyVCykN0WJuAOnlq2gsTu0SWqqBgdr1xPonJnF7y6OBW2DZbYhtY?=
 =?us-ascii?Q?lYUBaPZPyQiQjjOrkSLgsio1iMMTlRHDu48BRPN7izWnJuCYa1ENrrxowjau?=
 =?us-ascii?Q?Hg5sl8BdK4zGW2rGWUeKDM5C8cQH8mCo/8eqxTT7iW8GcWLLLwOEBPPp+Ue6?=
 =?us-ascii?Q?O5z+ERgEUOKkZ68reqpprRM+eQKeciQS8A9kA3yiGCKxCCYTLUcgF4yFz4pQ?=
 =?us-ascii?Q?z/XfZYymkOjFqANRygcJTahU7L52eF56kR3y15WNHrVsb80sUTPoV8Rf6KQK?=
 =?us-ascii?Q?keFNZ4DyLLabLUgE/EMN1auLar4J8iTdc9LJz0eWa1q4w+xDM2ce0BgPWtjA?=
 =?us-ascii?Q?lRsghZCMROcEABt2p2td8Hs/0+ZjOlsqM73lIvDTyi0OYHheEbDdjvYjkWB6?=
 =?us-ascii?Q?RrEHy313ceFS2a/sfg4oQa5ti23J9tUrKPv3+PFzdeh31oEHJkhPbS9y/wrf?=
 =?us-ascii?Q?i48K6hzUUyKVNC03erNu3aMU0sE3Y8JHjcG1PymISNjFrvyfSwUc/ZD5PGIr?=
 =?us-ascii?Q?ZmlCDEPQaTZ6HW8WPjk19yCx7KaUxNQJ8+fanSnRiPvmNMGAYA1JOii3bzPX?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2be7d4c-6d5c-4ed8-344c-08dbeb4effff
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:34:33.9065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /3orPy2jIihNCmX0yipYhphQ3I1YT/TzK2AH3nfUqn1VhMzH+Nt50MebkbzI4QUo9JsUNAN8ulxoeLGZKj1OgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8858

In most scripts timeout_poll is defined to 30, but in diag.sh,
it's 100. To maintain consistency with other scripts, this patch
changes it to 30.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index c7a7c0d2792c..b5a17d2b6723 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -5,7 +5,7 @@
 
 mptcp_lib_ns_init
 ksft_skip=4
-timeout_poll=100
+timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 
 flush_pids()
-- 
2.35.3

