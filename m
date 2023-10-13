Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2054.outbound.protection.outlook.com [40.107.8.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592D05692
	for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 07:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HZJ3hVu5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TK8WEyHUDHT/TniaXk+KmB8PJSf5NpWqUgHfLn9QL6AsdtngJvaqQ/KRrqXX0XwC7RzoHLRy5LvwcmB/7Cw4AbEe9pGtB+8kueMJqgB2egGnkWmwJ4rokB+E/Kjjd20D4r55wMCXzeKVV8hfz3vdHx2dCsIVuxPdQq69P/CWDz2B3OY56e9OqfREVRI0XvjxlkeJYBpn/DLrAgKE6jZrguFPoFQxZp5p6VQ1p5T7cFXHwOU3RZBb/l4IzD30zEGCWVYyP1BrgvKj8eNPQf6VN8zA9+0N1NliQX2M8V6JUDGJxaEO0KcdQ7aHXGnEiymQ15K9jlhAGAKMO/bkUVnYoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JNVmNnTEIcvD1la1zSsg634c8AvD30oSF2kKpbxTAk=;
 b=iQ1Rp+wp/k6dNUMMbtIMw+NohyZyefp6Rgb/Y5bx/xBRFSTtVpWfxJ2F6D534/3tU7spUdbZIvC88AgiE75BmBvRuoQ7rAxWNvLcNYVrb8C11ts/GQ6K3W5AoKTnr/TPp3281SSazww40oBt3Btcw7BvX1/AAgo/sybeIiNCQzUyhgOcgjyMwUkFuMqJTMEVI/2ZDW1KtJPRDBA9gRMDEz2oLptjNjReZfVB1IhSEv1IFfQldIkbETj9UGJ1NAiETMFPVvv0lXV0x36cZSC/UnNI1yWRRzdDtnRNh/+F9Pjw3LPpbVldzlch+fpPxZHydgZ+MwsB8odNfcOQbN9GWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JNVmNnTEIcvD1la1zSsg634c8AvD30oSF2kKpbxTAk=;
 b=HZJ3hVu5Vj8Q5Z+3/1Fa+ymU3VBBQLLhcFSWUKk8iUCGgIcM2B+jY3XRmgtn2oF7ekC/mEg1TdEAq7WOhKEDGHS4G9gRQ52XsIDnFsZehC6B3EMCUHjpyQD2P6r6w0WwaY0Kh38xvGaMrPPwRrujN8Uo6tHxb0o3CwYHM+LNwg3dxOpSSrl+KnIwWzvR6NX4b7dxI52UKZ6c3aT99hI9UyLT99mXLoNwzL1iCFPyhQieEQWLu6XYRpi30FLTYEjBJH9y+nJKKrexXM9/zaJFeM9585JxhaIKfVU2N0WJeD8oEvOoKG/TebdKqiTu0mhp5LP+Osbjm+BgjjrzvlGz8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8566.eurprd04.prod.outlook.com (2603:10a6:10:2d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 07:43:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 07:43:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 0/7] export helpers to mptcp_lib.sh
Date: Fri, 13 Oct 2023 15:44:30 +0800
Message-Id: <cover.1697182955.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec3dcc0-21b0-4851-465f-08dbcbc0114c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x0O50RB2N7HTk+GSKhqHT/MHG96+nr7t8UCWpYZVmW2z4/A7tCrI+0H8VBkp69hj3docOogF2yS9KMw7bqIAkVJ0sNZo2TsXSH01E+X3XJIGUySbG9IrLvAGqHrfTzYEAR4IlGkgRG2oh21TiHfqg1grDdU3Eb79+THBWBdgNUkZznLfbTDYE5SbX6Ddu4eONeL95CTDHMN+FJ71IMBCWEWUSQcqyEEuVLNnTWdQ9L8SQ75OXbBU2eitjrgF0SBEWKxhyjX0LTh325/ISCTyyHUs1NVGFSYykeV9iswLI6TYE/nK+IwJrvfrY6lIeNR4IQAfxrluiDpbF3qiA1xecYIr0ly0Zkoyz1bN2N1yKx6AaStu7BzaxJy8dvhd0jgX8JWtyAzlCbwif728VM7ceEO2pqPZdlt74UxWwhFDagIHZqqRKwpCi1mZy9nRYPkw7SHyl4w9zvJQsL6I1NmxgXOo5xFCkSnBdOMY2t2aXWBV7pc0zC2gnHSzpsjnB1ZQ/9KG9QWpuuEuHOdwv2WatZV4I0fkTbnTInGccD943DjvnbmWC10r+GUV4QB7ElHmJ94xumbtNC9dcctZ9s1i3Pyw6n9MiY+gnRXs7ENuP3E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39850400004)(136003)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(6486002)(6666004)(38100700002)(316002)(107886003)(66946007)(6916009)(41300700001)(2616005)(66476007)(66556008)(5660300002)(83380400001)(44832011)(8676002)(4326008)(8936002)(6506007)(6512007)(478600001)(2906002)(4744005)(86362001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E9kIVHtIJyE6fYZkhTx5aJbabSs/7C9c/ApHPTOgdv7HkA7aO0p4ifzUzkJA?=
 =?us-ascii?Q?Tvs1jKaP2Km96T0QstZkmpVndRwhaRuT7ybUXDJlyAuwjOruDDV9J1F4mDyi?=
 =?us-ascii?Q?wW7FpPYRhcxKDZtkv4hDNijxTAE3U/a+qhLlvl4fJKrqLOCEgUBO3iywkEGS?=
 =?us-ascii?Q?5SQWa2H3E49CHKhb8Y2Pz2VgF70+FlpNOwP0atm7xy2PGdxtl3Ykdadz2BOj?=
 =?us-ascii?Q?vSeZ0eIQoOGdQAYkDmW/fnOoCnmRZ5hzRpnkFhtk1PeVlg6q5RBe5IP6p2vw?=
 =?us-ascii?Q?WBRvtgXruMVekCV4aASmrlsqdYm6vWATkrnQQMtD3IV680TP122ckoAEJyMX?=
 =?us-ascii?Q?fOYhDy1bfp6iM8VaX4uTiZ/2c4J1a53gCCETnSqM/xRFg1oM7aaMXe1FUkOz?=
 =?us-ascii?Q?5Z2HbeCvf2RpiHkNEBJG4dk+vAEqz7TjurGfOWozY1v38yZGe4d/1vXAagpv?=
 =?us-ascii?Q?Od0vfR5yTJcPhCG5uJqKtcpbUOu9c/gC5yL78Ysbews+d1oKCLLxGq3nvCPE?=
 =?us-ascii?Q?5eFj8kyhsKRSD6YkGoxPxMM6bLq89+6fRfqPCcK08v6Z9rJUwDHDeH210FWL?=
 =?us-ascii?Q?0xrDtcSX4ZmbWB7vN7YOwbMwYZAKqz/uMwvvFjBGzMMPoilWbpn16juqVrv4?=
 =?us-ascii?Q?7Hes0ODIqdvBN/vLyjMd0bK5VmCHMmPxghMSYaRQXset8y1Hk0NFu1TyJey5?=
 =?us-ascii?Q?bfdlapXpELihmDUKWgmOsnpBuFPrXXx5SPhvHG7tz/YhDhaxaSYGVsknKpA9?=
 =?us-ascii?Q?9UVoEuwsFAfvKqlBa0HxsBH6lXHPXZBfFrTqYpTmxqtRRK2CdL4UKlc3oo01?=
 =?us-ascii?Q?GPZIv944YIbBiTzbUOG4DppgUbBcfVnnc75pNm1YipmR+wP2C0s4l8hsv0uF?=
 =?us-ascii?Q?iMb56akotd7sMUHexBddaRx1R74rAv/gT+NrNT/3l5FYoKTvk52NNpwYNcyh?=
 =?us-ascii?Q?2MQHsj+I9yqnmh9cZbo+7vONeltHApWXErj7unB7hwdPLOhaX+TypJEQlAc3?=
 =?us-ascii?Q?fzn/h6ElXLDnYJvX+Eo6Oe8TiXLbIJOd7AqIgQAQnZAa8Umicz6jYUAm9C/j?=
 =?us-ascii?Q?S+hQRAFjqlTlDSTGlu7thUvtPQWJVUmg85khINhfU3m1L3ZDR2sss92EeZTY?=
 =?us-ascii?Q?hL3qd2z6Qdtyt4AOMtbUmCwFLTkX2dXZTqv/BiPp6P/64dTWR3hGf2R6jfKr?=
 =?us-ascii?Q?wTuEtKvinIy3alOk37MMYmUcTbTLwFPqCC36pCoRh6UYYBCQql9rT6qbhKOg?=
 =?us-ascii?Q?RYNIuG68yUUp+ix0UOmDDMlN7ci9e0Umvx21aA69HYgd+JHz5k2aIjm7jBV2?=
 =?us-ascii?Q?n26cNBhvTVqK7TSHAt48BHE591NY0KmHnmJ+OareMcePYnvvNcU10DCwoWCr?=
 =?us-ascii?Q?gfNwEbhB56CY04wyB1E7TtTZQ1aCcX1wttBF9rPw3F/zgxZyx3EA7MaDjSIX?=
 =?us-ascii?Q?yF9zSOqLK49Rbul1iCeOuBNlaH49fxfhJq5qG3BOZmIP+nBOTl4t5kZayiJs?=
 =?us-ascii?Q?5YawNyM1sLjvuRTDzDDCSuJbJd6XfY6xu/wSbWrwnrQCPi+HEUpOL+tF4lqz?=
 =?us-ascii?Q?ioCQh+DjqgzfkT2XmzmKvfwX6XEa8+pA5sUfZens?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec3dcc0-21b0-4851-465f-08dbcbc0114c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 07:43:18.9123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4PVzo5OcM/ZvkuSIti1aeEluzxolUdjwtH/3V9wSqdp0vgZdgKF5m+zMtMtIKL2nL6bBWqMD9dZDjsEGgXE6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8566

v4:
 - address Matt's comments in "userspace pm enhancements" v3.

Geliang Tang (7):
  selftests: mptcp: add mptcp_lib_kill_wait
  selftests: mptcp: add mptcp_lib_is_v6
  selftests: mptcp: add mptcp_lib_get_counter
  selftests: mptcp: add missing oflag=append
  selftests: mptcp: add mptcp_lib_make_file
  selftests: mptcp: add mptcp_lib_check_transfer
  selftests: mptcp: add mptcp_lib_wait_local_port_listen

 tools/testing/selftests/net/mptcp/diag.sh     |  23 +--
 .../selftests/net/mptcp/mptcp_connect.sh      | 110 +++----------
 .../testing/selftests/net/mptcp/mptcp_join.sh | 146 ++++++------------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  82 ++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  39 +----
 .../selftests/net/mptcp/simult_flows.sh       |  19 +--
 .../selftests/net/mptcp/userspace_pm.sh       |  43 ++----
 7 files changed, 170 insertions(+), 292 deletions(-)

-- 
2.35.3

