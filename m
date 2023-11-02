Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2078.outbound.protection.outlook.com [40.107.15.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8CB125A3
	for <mptcp@lists.linux.dev>; Thu,  2 Nov 2023 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="4/QRcv58"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zp3kYlQeoFUvHtMxftw2LYXGVeb+j4pJHZYd11BPsK+XSH2Q8yWkst8u4W9C+FGfqw4TlWOiZKWWMN3G3Esm7DimfP7DQj4Hw+BeHVCX3Mry6g5o/QZcFW2tlgkpPS6BMdkFV6YFArog/V4bpQAYfbE0N6zfCOUiz3tLXfAaZOoHfkwSnPW9ViNzU7SqjMQh8VK75ZzIONjNRmwgaTlOGD2+A9WtFwCm1alsHb9BTqjX6frEF3+Jd7wrqQRhIKQXcgN7uooBXE0vEDM1gwBYzJg3knZjm0+Xzo1mJDDrTstH5SHhITsIKhisk99nm1JFyoLpu65mrkNcO6cHNnp5Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uueBCJIb2u+KmEtVLs7Mw5Uetfhq1upRYoI6Tx+so/0=;
 b=BaQ1vgP7b33aA3c/FwtxaH7qSKNgHPpcwJyRSL5Oqw6LUVQ7ydWoUPwUQ2hSa7bSPaeGnablSDKYLPHg1soIl2x+bFg6L68sue9xUudsWeM9dBytcV3lO2GjsTEijKKEgeJHgik2zYR4kk1LCUGy0w3BH+Lq3QiXPM5mlGrrc3D1E4GTR0HH2xeaQ/85DcXRIfMaVkIh+EgpRDZErcLB/bJ72fdLzSeV3MyKPhnQQ2k/voJC6+2EeWpM9/c+PU8+PIW3oW6km5TCbe6YOGNkStUe+sQfhnDCKfL37k9bNB7r4dl+BSCqFZBYxg95XnxwB2Yb7BQDWJZvSLBLhcf9dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uueBCJIb2u+KmEtVLs7Mw5Uetfhq1upRYoI6Tx+so/0=;
 b=4/QRcv58Lh5b4Di2cqC3OKWJktnBEKwQ8B1dtA+eEIh3DB3A1/2LRAvpN2dQOAVqWb77LWoLdgl+SiTM7LOtzUygn5Sr09eSK9vCeRMZhON6txH1WITvf5Ms/UG/52WwWVCjrBtHU4B0gWun97XK+LAmR93vm06eaR55DDMds1lCnQbkBEV9PCgr2oKeTfM9fCxv+F5GQdcpa0f++RdL0dv19Ttu6QwxHIWtHOfOPjs8Ru7KPQlJwoK2es+lHDgBXFQQ7FIw7oj1h9acQfLVNTGWfZXcXC/B2+JbnTUZP978/XJIyDwAN6o7kFD7zRo+ueNqkLLNuIx5UwWO1RZ4Vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9345.eurprd04.prod.outlook.com (2603:10a6:10:355::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 09:50:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235%6]) with mapi id 15.20.6933.011; Thu, 2 Nov 2023
 09:50:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 00/10] add flush and dump for userspace pm
Date: Thu,  2 Nov 2023 17:50:43 +0800
Message-Id: <cover.1698918546.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0182.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: 9859465a-4015-471f-535e-08dbdb8930c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gY4maujZ0NKFoDBruisX0zQ4XesD1OQbzvMWJcMQY1NKjcPdldPh6o/4PyVghaSdNqBVEkC4P58+DM3eMq9U+YOXUpGW6HvsWCnNgCpfo36YKpAViH70WrmTwNOYP2snp0qiqICrblNwSWEu1K+DbVzZVtSTElStHsbHr5/56yVJSdxNRvySvtzFl1RW8zwNuS9uuoavK9lzfHwtfdsArG0hNseof96IgWiCwAhYv1K1fm+Q+4mUAGet78S+mNShMiZwNvQjQiPlS+DMkx/wcTzQgou4YOO8VI0lLOknh55EE5g4eg10/P/jFHze0nv0txIriYSigYguzIE0niswwe3w/2xNeB8Nq+fjQ0+GbU8h++dI4APpA6dNPq4FM1spooBX5jbFd9A82p67AV96Q/+SHQ3PnyB2+EAme6NxFnHDwS0brDgeKOqw/P5JOUn5q3EMe8zRDpY/qKJPwQaYSw6Ze8u5OqOV9R2qVxu3dXLj52SsHOZzEdIsicCY76EahJ8kTM5QYvPJZfLnUhjAmumE6yQHCWNMSu0RdWAf5NGewxULIkDsyBqu7xMRZCQzjIMzqUxPrKB7ED3jiNrLSc60aJUIoIu2V3BEM0CCBAA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(36756003)(83380400001)(6512007)(26005)(6506007)(478600001)(2616005)(44832011)(6486002)(107886003)(6666004)(41300700001)(66556008)(4326008)(316002)(2906002)(5660300002)(38100700002)(86362001)(6916009)(66476007)(4744005)(8936002)(66946007)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vIGuEXwrUEhuIpgi0vKWHGLTKbuTbf0sAWWtdBy9kpFKVZ8NRzUVBgipBJ0r?=
 =?us-ascii?Q?osjlG4NWCZ79uLMAo7Zmn1aWHdhz03pFQJ3uKZGMcsyOvTnml71+B6otnMO/?=
 =?us-ascii?Q?/67sxzxOYR7s0qICDj5bBumj+Mi+CKOWOTFFtKzKfRuJ3RZYacT1wWku8yIh?=
 =?us-ascii?Q?IVqfzOck6lcGDv0sY+osZSvWzFot2CfNbQzRV6+zAYNjpQ8FORVuGX9hmp3/?=
 =?us-ascii?Q?3yE2phD3BND2DjtN9tuXj+Oq51WpUBofmYIDgjsKa73hhuSQWNsPnqFM83i5?=
 =?us-ascii?Q?NbwxdQKHK9U3dKvUX/4Fw+G1xt3V/Fuk5iK6BLYr4TstguqOwOlYW9utETlS?=
 =?us-ascii?Q?S4eE5H3TBn97pciY9EleSNv6Unt57V8VyWwhv6laqAEb69k8tL+l53CLzm4E?=
 =?us-ascii?Q?Gzf/VpRCuqIRKryiiSOjZlRxcNjHuf4MJKHNqId3g0pmnbhak+7pVELxJ4cQ?=
 =?us-ascii?Q?9ohigr9psWBYRLSL5yNRaNn/yleIUrGtu4cFxcDvWwbFatOPgxMgrpRvqL2u?=
 =?us-ascii?Q?dX0tohL6fiPlRUErPKdsYbkKXiICko9eajkwAerUINSjy3Ig+pCbJp3X8pZe?=
 =?us-ascii?Q?+HY0O81fySEhCJmvOkr6BbAQnpK5lhaIvHQ0iK1Od9ecjR85YbqjA2R8dOoM?=
 =?us-ascii?Q?pCjlzDZo5e5+qC0fAS1VTbTIX+gbxkIwDKOt+++V4UYxFO94XzOX/1JqHVpU?=
 =?us-ascii?Q?DBUUc2KDPAt8ucOZ1zNbLKKdKlokmIMqtF5dvvxFMcIcgCPOr/e5zRwhNrRK?=
 =?us-ascii?Q?SYWZLXPG+BxfdPtuzgc2iYhEo0NXDFMEaog8FFQNvwqdbyaWqSb3gjQlEe4n?=
 =?us-ascii?Q?oBbAd/Pi5KQ943jopbi5ewCfov6wQ+JUbravP3A4DEZdFFgwarIOCabXjSzF?=
 =?us-ascii?Q?dcqO2X8zTtiMJEyUHEI0Ya69hzkOfRX1Y9udgnfMiJJN8hndHF1YgZYNoyMc?=
 =?us-ascii?Q?PHBTQa5gdhCk8tqdstD80TIE2Qi4t6XeUb2wkDxeXaPSNEZ0FqCsI5BTJsp3?=
 =?us-ascii?Q?djgFtgdjhPZ7wzYBHX9Lv1KnZdjbim9QzNuVGvbhrlJYBCUDt8c7UsS2SSiI?=
 =?us-ascii?Q?yz8MU9vbIcED9zZdmwvKxPbKqW0blg1KPUChPAoPIbTEg9ktPge9JT5W3jvp?=
 =?us-ascii?Q?CjKhL1toH9+2tSwcu11LqgOH7PGTDarTN/mKoQvBJwx7xByEcgCo/ThPrOB0?=
 =?us-ascii?Q?3kd+3VvfTMd7JDFMNq1xFZht77VmxoOAZhEvvvlROWjTbw35SRpJL18xevy1?=
 =?us-ascii?Q?2Jl0lkmwUwOpj75Bar+8ScCePWWMdJzoxX56BQ6RSj2mKFApAHPAjasozohl?=
 =?us-ascii?Q?onQzl29vH3FBCvawskwNK/ALb2JxyhQrdvDHL7O5LWOcpVP1vcDv8bVAP5aT?=
 =?us-ascii?Q?odwDgywSNwrGA/lSMHPY7tRfadY6byKxwRsyqWpqOWhjWe15cLOvD1OUKVIQ?=
 =?us-ascii?Q?GELmRFsATDouV8CppDoOK7Uj9pbAzRuyYbn/NfYItZK3DxO6DiH1HTyV4a2D?=
 =?us-ascii?Q?hMvpXHmNpvYbXSKzY8FYirzktdd3s9K39Ag7fdkOMeKuEbcJ+LCs3BmA4el9?=
 =?us-ascii?Q?OISuhc976xzkw9pnwkWnu1pNhZlF+HcMKhnECXAD?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9859465a-4015-471f-535e-08dbdb8930c0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 09:50:47.9793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zYWABlPkuvoZOe05AURY1mMS0ZEsQALZJkg01YxR6IuUADT16gBrfpLpRqIIixk0tQFovJBFEOwUSpKNjfhcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9345

This series adds flush and dump commands support for userspace pm.

Geliang Tang (10):
  mptcp: add userspace_pm_get_entry helper
  mptcp: lookup_addr_by_id helper in userspace pm
  mptcp: use pernet id_bitmap in userspace pm
  mptcp: drop addr_match and id_match
  mptcp: rename free_local_addr_list with prefix
  mptcp: flush userspace pm addrs list
  mptcp: dump userspace pm addrs
  selftests: mptcp: flush and dump userspace addrs list
  mptcp: add addresses_ids_equal helper
  mptcp: drop lookup_by_id parameter in __lookup_addr

 net/mptcp/pm_netlink.c                        |  80 ++++++++--
 net/mptcp/pm_userspace.c                      | 150 ++++++++++++------
 net/mptcp/protocol.c                          |   2 +-
 net/mptcp/protocol.h                          |   8 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh |   2 +
 5 files changed, 182 insertions(+), 60 deletions(-)

-- 
2.35.3

