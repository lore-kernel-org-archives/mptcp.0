Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2084.outbound.protection.outlook.com [40.107.104.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E5C20F9
	for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 07:20:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mjd3MiJL7W07spMcj7+AxwgDvBfgfUE39YxgwATBW6KgvdL2VT50hcl9rPEcNnj/P8etv5g+geumCp/pPgduC/k7IxrPgq+OohRc/quvCq7WytYI5eetiBOaOs9tRtrkSZ8exYmMTviC5LRRSFtFxf5hxfYEcXYxQwMYRphonf5J0gpu1iJBT3XmSzmr8MfY5tg2onnYv3dlmSr0FIDfaheUAGHbXlex4H/7hbnezWRLgwcPOVdav0Ik7qeBwY/+mA3LT9zCtBedk2vgMFhxbJTHOMqUqPz6pyB1RTy+oscIaHIsmchPdKlYWrZY2e7DjO1vO0Ol2mE8gGOcYQ8Q4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YznfU+FW+dY+t/CREEWU0QB2r1Qi62ux36oOFEzn2MI=;
 b=dXsOsDZ3fK5kgCV68k9kJjCwlN5oYq76/SSVvmNHPJWlKEeCOgJOA6NGGUFR7hCwUoKgD+w6RTNvyDiiU5I2YU8JFXsSRlIiOL/Npk/nOMtQE57Gpdy9RJ9g3ZcEnd2Ki9WxLeafoqiyf3MsxB4bydSb8Pd+n6t07yGB3o1zphDyTskROLl5WcAD4f/CyTInyPn4uNnqEPwEkYtT0nJEgKJNJ96ph7z9ivQnm8aPDfh+ux/blsZpzy+ZdiF6XXhKSLAdF9Wj0jLx/wHfs5g6nGFY3656UvO/O5QiSlSY6weeQ/nThjxCOUblyqJ3HYrPn1PePengFO0H/yJ4TqVrdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YznfU+FW+dY+t/CREEWU0QB2r1Qi62ux36oOFEzn2MI=;
 b=vyCQkeG6fwVY6Gw9cwsK93aCXum6txCWE299hJQuH5RHjKL30XTUonIcnTtZBgy6Vw4+ruhjT4OMd86M0LVmcH14uPvNj34BIyiPgud31WwYcX6U2P/m337Px8hKS7v+ShzhbTldq9T/TpScxoqWSZf3RM+BiLsey3VCIqwCogA9T842GLLovAbzr6nu9c4xSjuIPN9gQsPg416lmJSLwozKYjPpYTA420Gh48tv5nUpwKy+CCG6/2vjM0N7JjrvLjr+7O6kiD0uFpXbiq88jVIqAdzWM3q+2YeXTjmLeVycPIwsnLjpiqs0jr3o7Z+C1zeSx7av50d30rHSUNsm3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8470.eurprd04.prod.outlook.com (2603:10a6:20b:415::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Mon, 12 Jun
 2023 07:20:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 07:20:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v18 0/7] update userspace pm mptcp_info fields part 2
Date: Mon, 12 Jun 2023 15:19:39 +0800
Message-Id: <cover.1686554287.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: a73862d1-37a1-4f50-31dc-08db6b1574c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QKqUz3ajsrPA2t8rDCGDwVLRqjGDb0LyIGJXDYS1usou016+5gskVVezTz48BRUNzBPEssFI72FtlMCE9JsdmYe/RHiot5FD/EQDnsP8o/FPZ46o6htMhkiAMVkS4GmDKXdpUyVSqHoqh5bBJLIYJe2wRhhL98eyu9byqwVNWL0rHZMow/rWDS+W+KOi+/nc7OUzB7GMBC7IPq6D53TVZv2IF5Xe7VNyGy3QsOLFZi2Gzi5YKkzu3exxmDY/CjAs3cruZgevNzCjU9BPYMYiyC7pFmCye3fj/0P8Xe2kRANF+sEvz+eLCaVfZjuTdy4FtIe3WWpEmHl9dbeprSuNOCVQz5fOxy3crPsrfRd2P8f4H+2UooiZ7uJ0pQBSwj7Xk8d024wJWIaDIEGOmSXl0fDlYL8r2TLE5O9Pps7rcu3Y5Q7DKpWxMo4onCtjz289o+55vSJxLmmFdXJZVpLgHabVQyc4XmUNCCbUQYifoLkETyt+VPmTvXnOan4CHq37Ok0VZ1dlGFqM1S5LxRVGUznU0O+bkxlhliZt5DWQVRiSaIw1Os+N5h3Zagg6WTtB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199021)(4326008)(6916009)(316002)(66476007)(66946007)(5660300002)(186003)(41300700001)(44832011)(66556008)(8676002)(8936002)(478600001)(2906002)(6506007)(6512007)(38100700002)(86362001)(26005)(36756003)(107886003)(6486002)(2616005)(83380400001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zvb4IA+NzhAO5SFC5VesJzJjYDxiPMx+PJjIWnbtrxIhETkh9qZPZo7RWsF8?=
 =?us-ascii?Q?VKsyWbJ1Tz3tnDwGFQgee1hOuTA/PKDl/sc+NMTGnflVCIg3ecJhTHiex2k/?=
 =?us-ascii?Q?O48fdh2hNjndnRutm8Svc+obP6gnCxuDpw/JQhcqeoWsMW91aAUhG3IVUXas?=
 =?us-ascii?Q?dCG35tBFqjJJAQ86Go09hvnPmvz1lBR74IRvbvZ4E4HoqGXNQ+YkcwgskZkL?=
 =?us-ascii?Q?Sda4Dk9qv6gUrhwNTXOLG3T96tc2ta0QjaeOgIiMOsSoOj1UJoVpHv/veH1i?=
 =?us-ascii?Q?GkJXLN1TTHoC11t0KSWt135Fxf5oRnGUDLpq5ITYNrHgWOFYcRdKfcrzQqN5?=
 =?us-ascii?Q?Qp5g1W9Npa+QRYIO67DLIxGg+IWoAHGRTM96qFaicZshCJ+2ZlB0F5jVzifA?=
 =?us-ascii?Q?J6/nW68Sob/lxxilSfoGf6IFfv7LBllRNUfMlWFxH+Lkc5cFPpn0LTyjtIJo?=
 =?us-ascii?Q?rSMS/5FcsStA2aaV3scZ5lS4IMZnjpX6IpObIC9B38yXdav7hSUCn0zEoZoc?=
 =?us-ascii?Q?hPdtBI8WUHAh+4buUvtOJuZ/H+MscNHCCo1x+fqNsRAtUe/0JATv+3OeVk+Y?=
 =?us-ascii?Q?tzkFs2IsKqQjJvTb/fVwMg79UBDo2xSLn7btcuMw7gzN1XT7gRLkMc38mr21?=
 =?us-ascii?Q?m5E9f0ChZyYMvRk5n6L0bQZmQk570VnWa2N6AzdaD2Z/ALiE1rq0mEy9eKWC?=
 =?us-ascii?Q?8Sio4KDfMw3RMazmP1U9JWT7RP/U6xD7Q1bqIeVCJPq0tGLB45/izGHg3G98?=
 =?us-ascii?Q?GQ18N6M+t8SYsFWhZYoLirAIKS5a1DWMrcOjMBVMd7ybJmEVsJ5dfBnHT8bc?=
 =?us-ascii?Q?/rkV2qTn/XRgRquKslmIsp/ewlycqWqn8OsljCXij5GdIBeXWwZse4iTfxGz?=
 =?us-ascii?Q?d7KYJdh45XCO+IZjuazaliWH7fmD9hqovqlsupJRdvopkNuDgPzLDPn5o5Ut?=
 =?us-ascii?Q?nAZj7c7m711yA1Ac7fw9PceO+pp4UV6YEIZjQeU/99j2nsmJKoCMbFNubmQf?=
 =?us-ascii?Q?quTeeTvdLYsDth9d1/kwvVL6+T8V35+a6WYHIpusplNHlBdopXr5dunuLGav?=
 =?us-ascii?Q?1RcY2RJFEs1HwwIqGXNDUv55Zl2H1sEvUFUGNI1qdfARyov4GzoxQ/erlsuh?=
 =?us-ascii?Q?tX1X0pto2gIyiNeHglbxgVkuq/y5kqoL3sR1mv2i3nbWrZ+E/b2y2f/lj63W?=
 =?us-ascii?Q?ZevS3vJVS0mjfRrUBoHe2btqCb1HZzoOKg53fkoam0Em+8WcV/EgTNdcN7vm?=
 =?us-ascii?Q?CknmwGSu7r/PeQ7Ww35pAjMxF2Xsp3pILw4fbUDcv5gSCb/lPCHfS67sxY2C?=
 =?us-ascii?Q?NNpdTA7TT7QT//4Hn1LXHq3vwNCupsCnOBoE3N6/GWf6goC+ibzi3AqWZs99?=
 =?us-ascii?Q?JIEzB4+Q0slxmub+MCFSqokbKmfAGdOByhJAU95Z0dclMUMom36/jzOs+bPZ?=
 =?us-ascii?Q?NWPG4nZ7j0v5Xsrg+GGTLrVkSdGDb/8JKdmfcfXSMTCguvBH56RtopK9/nTH?=
 =?us-ascii?Q?G9QS7bPctfyvsGGGaghywF4saXrOeYLaSHyl9+c43EmCi+LN6FqCuIVZ4s2Q?=
 =?us-ascii?Q?AXhVLaX4bQPWwAP3pIPHqb1VUe90e0CB6KSjfyd/?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a73862d1-37a1-4f50-31dc-08db6b1574c4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 07:20:10.2235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tA1GKbkpI7k5fpgERvqSHjdgBTY5WVQCiP39kp9cYuQZ5c4PGjseuLrBjftugSeDIE6SOgjdNH4UISaEIFaLkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8470

v18:
 - address Matt's comments in v17
 - switch to key/value instead of positional parameters

v17:
 - rebased on export/20230607T094151

v16:
 - address Matt's comments in v15.
 - the last two patches in v15 is deponed on "selftests: mptcp: skip
 tests when features are not supported", split them into a new series.
 - this series have no conflect with "selftests: mptcp: skip tests when
 features are not supported" now.

v15:
 - fix the failures reported by CI in v14.

v14:
 - rebased to "selftests: mptcp: skip tests when features are not supported".
 - patch 1 "selftests: mptcp: skip tests when features are not
   supported, v2, patches 8-37"

v13:
 - fix all the failures the CI is complaining about with the debug kconfig.
 - rename endpoint_manipulation to pm_nl_set_endpoint.

Geliang Tang (7):
  mptcp: pass addr to mptcp_pm_alloc_anno_list
  selftests: mptcp: test userspace pm out of transfer
  selftests: mptcp: check subflow and addr infos
  selftests: mptcp: drop test_linkfail parameter
  selftests: mptcp: drop addr_nr_ns1/2 parameters
  selftests: mptcp: drop sflags parameter
  selftests: mptcp: add pm_nl_set_endpoint helper

 net/mptcp/pm_netlink.c                        |   8 +-
 net/mptcp/pm_userspace.c                      |   2 +-
 net/mptcp/protocol.h                          |   2 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 580 ++++++++++--------
 4 files changed, 324 insertions(+), 268 deletions(-)

-- 
2.35.3

