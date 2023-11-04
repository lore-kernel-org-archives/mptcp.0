Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2047.outbound.protection.outlook.com [40.107.8.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F68196
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 00:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="s4oU6dNU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCCvAwO9e8nWdJq0tsiyNPd2NHAA3s/3MtWnVtDimyrFEBrQnwAc9ADqDj6ebWwr0EmzYHO37myLXiG0xCThAeUzsH60MaZ2JwD8iCCPXlDFdgV5+QkHd3TB9AwRDLJ2BF/JFWImuil7ndTwjpVvHO2Gn2CJHXO0fdF0CA6viHpmIfhWfbSI7nRk1NmVKIeN67tFZ5IhZqF/TvMWc1SRjHXmGFiTB7MoRDOcmnweZrkERDSo92y+pnamDr2spTz+aza+zC7Xg4HWyoAKkNwKDEduFN+ZiXzyXt7JO1mWj79RXzJiUmw1k1dpj+9lZEfZTMjLYXDq6QKUR6/80kBF3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RoiZMME8vZbB6wWEOE41MEtjuBE8qZ5+KP5ISnfi/Rg=;
 b=cXi4+9OBX0dKxlJOMYg5QN1BOXCM1xowUcPYyIWjH7e0lbejyzbQLzq6d4kjCMxmpiQqJmmcRyPjV/C+6DeZHv6lijYfh2XGDzO39wqfa1CvuR/m4/giVLzoNMOY5guJsqcR+UmdxVhYIo8PXax3BYF/EoXHuUD1dQioUZVBWQmQY5m6Su4OfNzWj/gc+Wu5InifY2b3U0WWpvO+ydXDjD7mSNDfNtiXQaEWcB581FXUO8Xo44aH+2WraxM0sSU+gYNRE/FXth36UJOamRmRt1UYGrWywn/OJg+Sp7b21Vk6KrC88H6boJgTN5ONgDu1yCdRWrIHaFif6jmqFjSfDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoiZMME8vZbB6wWEOE41MEtjuBE8qZ5+KP5ISnfi/Rg=;
 b=s4oU6dNUF6kKsRzfzn08G7Urp/JyCcX5fIOOIiMzuE+pyJrOJWLpA7hMhnf/T3Fq4AzsnJjazUZ4ZUurlScj057cWjmrrGQOb/xFsyAFDpgr2B/DTkdLgH9PJbbgfIYdGB0+URM7wUY1Z9M/01VsXl1/GwXAF7fKXTBdHOv0LCiA1C6MJqnHshEwCroLn9PtcBCiQ3Lv5BOyPy5sfK9fQwng5tvjs7Fl/lU8XkzGXNjYBtKP9evHNsiDegJb3IdDMQhJl6cUCrVOMvNfGkHIUHUT5szRuUQx8vKtwIsWrmXQHL52TS3kkcL7ggLbTkXVLgEL933yYJj0+VmHwYYOqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB9174.eurprd04.prod.outlook.com (2603:10a6:20b:449::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 00:29:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 00:29:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 09/10] selftests: mptcp: rm userspace addr with random order
Date: Sat,  4 Nov 2023 08:26:33 +0800
Message-Id: <9981347073f8e121aed3ef5bb58c640d527e5303.1699057401.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699057400.git.geliang.tang@suse.com>
References: <cover.1699057400.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0235.apcprd06.prod.outlook.com
 (2603:1096:4:ac::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB9174:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bc80beb-a557-427a-19a6-08dbdccd0a4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9/acmhBwd+LXLvlXreVUkbYHzJfKIrNsN0oaNmWVgEofxfftN46RjK1kegvTppdfdP9LWpVi5Ayd+3TPHEdOX98utDvhUAn+kFPPww696thjRFKR9UgC4OIL/EePPiPVpK7MXaOqVCw+Uvx473AGt6PyKkEVm46hlWPCZkBWUS0+VbCwoQGz6f6nJNNBgmoUvp/9Lv9LMEKo4XiBVhvADImh+6WGLY4R+B04zHw/xHzO6FululxbSoGKvSKkD3fLQ++DpshyjmVeN8gGaHFIaCNBoc1R6YAAjTRcgQx36YlyV0j8Xu9UmJaiGHKHkD4LOuMAehOhXnu+n/cBW6AEZN3CT2nhdfV5hGCASKM9vgQxUCX8kEOtCxwGJxgz/3omi+D8b1cj7j87HTaTxp0avgJJbMHyx7k00RuRIqYtFqXrWgxx7EQLeWsqCsrDY/w/+5vdbDzFBBX1rGDIPukhHQ+472wIRL76jLmY78MwlWjLimhhVqYzFDGUf5ToEL2PtefyB3OxRA6OV4eRlbkC8EPFqMTiAHjS+ZwcBRgOGO7OIBZp6aYVXPZuwHuahq58BQIPoXPQTCuJKst7xuxpa3DFsMvoWuiWo1lXgmR/nDg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(39860400002)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(107886003)(6506007)(26005)(2616005)(6512007)(86362001)(36756003)(38100700002)(83380400001)(8676002)(316002)(8936002)(6916009)(478600001)(4326008)(5660300002)(2906002)(66476007)(6486002)(66556008)(66946007)(6666004)(44832011)(41300700001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3nVIjXQyCaEUi16zGCzIUfiYCMiIry2fiwp0haTlib1BkV+y41s+xb+rI9mC?=
 =?us-ascii?Q?6/NOolHw6rD6XKOviX1fPDRexS0Yo3no40wOzVB+1PALkJYU11RJAo8w91MH?=
 =?us-ascii?Q?aVr2iNhG/mcaJKgN/VViGzM6PiwFwEUs833cfNJuuAaa5sLqyrFICyjC9RzH?=
 =?us-ascii?Q?1jj08H6GkMzII5y14Jxl27cJpWp4cVTnzCrJGskeZl6G0F44IJY5DhBEQ9I+?=
 =?us-ascii?Q?Wx4pS8hwGALQ+uUHJdhuXYMPFx1SQHSmYxTINZTVLYglE+IDo25nu2AkAzM9?=
 =?us-ascii?Q?tRt9/nfFOybvkXqGAIfw4aBqielcVc7GcUyPAAAe1zbBI/PjrxWhyi2LV3jO?=
 =?us-ascii?Q?xaIIm0p8sOIBnL69QY6BRQxwLQEHwF+iOnm8CGfWB+P/8+hz9qb5u6H3rh+d?=
 =?us-ascii?Q?T4KSFM4w5iR59V3XCooAL72GKjtiN15/5ay5Pz5DzPqN/G1x7EA6j3SYGZlS?=
 =?us-ascii?Q?48lQjoF3/bVBnD9XJeOm+2O7D7zru7m5dmJNUBdNYSEbsY46YFF2d0D0KGWq?=
 =?us-ascii?Q?Ok0J3JE4uPO3ULtGrGEF7lB9Elo6AZqbBAmir0M6Y3ZUJSFaXD3InOzrOn/d?=
 =?us-ascii?Q?ZYDIsV1ns4kDnYQHeY7YKx9JjLUEaFxmGQjXs5TUfh9/iLL/Re6nzAWCC7EW?=
 =?us-ascii?Q?nUcMb0rvDlfAvJXfwugfdgNQm6WpC6AzOXzDP0/7WpvXFnFWcmWWjds49o9Q?=
 =?us-ascii?Q?wNEniluIFxhMzcqt0YwPm6ZoJQ9MW92aYoU/PZF+LT/pkQrfNMwRuRVrxZsn?=
 =?us-ascii?Q?Bm+ThfvyKNWijr8ABB/OWhFRiLz7BKyYKbDOMq0Q6LIcsn1/5I88n+OkcCfR?=
 =?us-ascii?Q?caVDx+9wBXjSupPkDExOneZ1EBfP7CKfR79Ehfu42lkjSRVTV7JRNXWWjpgo?=
 =?us-ascii?Q?LoyLHw9tMB3unAdGQzxu91xZhYeFFrriLq/ZPUbhQLczTSJhNtHlLU9LsiGZ?=
 =?us-ascii?Q?5p7/IQb6bJPiSOVxdRzy9A9kCm8drwlc6RhMRvBkZ/b2UDT9hBZgQV1Rarcl?=
 =?us-ascii?Q?jfpw2bZy72ZLdkEgjxgvV4sjPL2sTXV6FULIQ/8wV+q86Jy+XTlFHu6PvOZR?=
 =?us-ascii?Q?Ce7WI/j9JMdY4U52/BEN2b3H0fE68Xv/bbw6Kz9nAmRAdITnGMvgcVxB4BJn?=
 =?us-ascii?Q?mKkZOBniP14vOIaPQD18bfpVXtXVptpvwzGQ+Q9pwOs1UCgtrGEz4oP726jG?=
 =?us-ascii?Q?9NcZFZsfI+yq0PNYah/dO0E1dmaOc8HTlT1mXMgnQFaM1466/9XYhWjdC1xr?=
 =?us-ascii?Q?2U1mqOvatB+cBwbGQjzZH9TNFT3zO92yI5Xo2sOmUOifuVejG8CWyQPGOsOl?=
 =?us-ascii?Q?ET+DRgavhNRjcUYVusgxLE8tBZUZZGxItzr9Nh1nRdVTwnKGPFCJch7VhuAO?=
 =?us-ascii?Q?jnBVsnFa1AHAZ5HkzQhAY2RWR/0p0P2O4kKqUWH6Maex062cTth3fSqjWgC/?=
 =?us-ascii?Q?Rf0fjpHqTRmoDBpESTO5GBW7pLkW4MmlDn4j5uhsji/wP0y9edT5n9ygDNdL?=
 =?us-ascii?Q?D3PC2BBob8nhAZ6WDsP1jk7e2Q8Jd7GgL/A2DZBafX7AjdPucZoqEw9gcJUB?=
 =?us-ascii?Q?2x54MIr8DyJSEOmLRCfhrX7PpR9q3hwLUz5TdlWVCMKCcKBXvBdPIesgXW3n?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc80beb-a557-427a-19a6-08dbdccd0a4b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 00:29:00.5759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3wht/cgkUcYm/dh6eHoBARPTxNUtxNrtpJMbFGAJA3qiGLZiBp8hmqzKZIZHmFmz2p68NoSs+rKqg5cXrBhYeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9174

Previously, when deleting a userspace address and subflow, it was necessary
to follow the current order of deleting the address and then deleting the
subflow. With this series of changes, addresses and subflows can be deleted
in any order. This patch uses random numbers to add this type of tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 8f6a045778cb..8109f92e56a0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3355,8 +3355,13 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
-		userspace_pm_rm_addr $ns1 10
-		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $MPTCP_LIB_SUB_ESTABLISHED
+		if [ $((RANDOM%2)) -eq 0 ]; then
+			userspace_pm_rm_addr $ns1 10
+			userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $MPTCP_LIB_SUB_ESTABLISHED
+		else
+			userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $MPTCP_LIB_SUB_ESTABLISHED
+			userspace_pm_rm_addr $ns1 10
+		fi
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-- 
2.35.3

