Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2043.outbound.protection.outlook.com [40.107.21.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553E251035
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 11:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d/VDoNH9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzEfGZAb8HBX0XBSlvWgjm/jyx7hd1p+pBWAsZplBYI/rVO1zG4m0AhkjITSTpTJJjPGaizRsKkorD3iI8kTziLcP3k+Jgls08TpFWtC9dYEt+1Ydmavwq08SUJmiG605mFs96idA/d8d+hJT181MLuLizQYOzyZG9ele/WbeoujDCViR7oIM1CUm03ePjjxWHLYh3Mk4QlKobH/epPFY2DH/AMkYz2giqo0rOnWzEELAk37IdIzX0Ow3QMQlNsqhd8zOjKwnqop/ssKDhzuLP1B1ubxhoM5gVwnkWvxfLMEPiZ9Pd2SSiekYxs7Yl3NS2an4DhdUggEu6KJDKS60g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYr1NMFMKvfGcN0MRxRaig0LTgbAKiIHMgkQ7i4xZF0=;
 b=U99MjkbmkdZDYkp4pElBRqF1jE17sFPsNHOcs7qWgMcYasNv2vo/DaaPY6HQH37G7gHr7H7QNRgd241DoKLf+3FD91QhOgfNpeaLFP2fYj8z+Zv6JFcYcb6Xo8s1qjG29WLITXPSET4UB4V6xDw0dLNt68w8mfneqzFd/qFyx0xVSBPCLPtev1E5ilU53Pgx2QySmXFHD/R48u9tzxrenqjdc9vWR1Yr8Vvqrj1nA05szzPzN+XF5HzdLf3TQnw+7NuuDdQHhrIasvsV1fig1LxMAShIWkwVKOAKVrGn3Esj7uGdjpa0vzcvp4Rxt81JAFsxGZASQYs4unkPtc36+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYr1NMFMKvfGcN0MRxRaig0LTgbAKiIHMgkQ7i4xZF0=;
 b=d/VDoNH9PZVZEQMhadKuML2ySS776Wgvi8dvWeu9JQZNe+puNe830lidv69UDHZ3GiF4AMDrRMY+T3VtVGY62sV+cS128AXOcVXIJ3o7tgBtwJrYBHffQDU+WitE6Og9sS2nh9lP52bGBaqdvFPG9a9wtAEx1NGTDHd721f81OFB2wZ3MI8HXbHyd7KzGa7THNlNRJdcYTZn9onpvVCZvCjNxlcBWrC1NyekgYcZ7Za4BOExbPMJjssDUUV7UPB9AdPxsPvy7YwSNbAXN7dKy/oAN9iVLpDVxPUeQYJnvobLTI2zCEVolxFXsV/3/P0rXRwWFIuUsREYt7OFzvq2XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8858.eurprd04.prod.outlook.com (2603:10a6:20b:409::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 11:33:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:33:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 23/33] selftests: mptcp: netlink: print out test counter
Date: Wed, 22 Nov 2023 19:31:11 +0800
Message-Id: <cb76bcdfc72dce8fa9663089e415a1f819443fa2.1700652422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700652422.git.geliang.tang@suse.com>
References: <cover.1700652422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0244.apcprd06.prod.outlook.com
 (2603:1096:4:ac::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f956b29-21c7-4610-a1a5-08dbeb4ee92b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5fdpBUpe0mP3C+5R/qHRkJfE4ChObpvc0DYmH5pF3V9J5MIKRaBZecYDQUXEtNPoBH1DOH5IEt9OAQ+mJTzNpGr8Hm9vpAs5EbMSN74Jls2TXpZW/sshn+9+4s5LwSSpmypBccGWaxbV0OHZBVfUERwNdjI6LhNTCUpKyYw0WSyC9b1wlyBmBAr4QJ06DPay5HsXOk+pNHjaMhfvhltU6M0eNlhwLGDPhUFhQ4J4S/qVpw1Qo34uIpBmoV1qOH/dwqegqo+RnK9icJfU3bQL8Fhnms88jgH868q/1KgrZI6sq434XGpRlRv+REr+TnGkpyracJqb8irklcV5rua8ldr/teN3aRKlVRpNOdUUCsuu/QSO9ceqjStrLjzu2cujD83bOhADLmegR7n6fzDBWIhK9bmmLpxICtJQ8+5m5CCwN50xsIc1x5UUxBSVPdumU7qTePs9hUX8CVBOvKljkdoAcCxPx+VyTYsv8XWjEA9DtbgbTTHH8K5zT+p0MIYPn+93EBgd9ja39SzJTvM6k2tZX673+98YZtP4kLFYojxwntt4GLesY86VWGLo9W/KEC3YtR66jTOtEkJo0fdyOvRIyNI3WcEt2lkDhWoHtEU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(346002)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(5660300002)(36756003)(8936002)(44832011)(8676002)(478600001)(6486002)(86362001)(4326008)(6512007)(316002)(6916009)(66476007)(66946007)(66556008)(41300700001)(38100700002)(2906002)(83380400001)(26005)(2616005)(107886003)(6666004)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FA2/Dx5hZ9C1+GL8ygwl+f9qtiU2p1I6XCYiwTA51Zbk9vRSQg6zkUT77s8R?=
 =?us-ascii?Q?98cA9peE5t2EFJwcmSaoc8kQmhZ+icjnJT/Hx+X20e4yKLwWZ4x+Vv47/5Z6?=
 =?us-ascii?Q?SjlCZymIunRqyOAGDMfOfze+JHdYj8Tu0zDktCLHysQitwVfPyUQZe6wuJuM?=
 =?us-ascii?Q?H1u1I9Y+5WpfJk+dXcVpprs1hSW0J9ZVPcA4yPvgkg06r01ixuejKGJ+sgJx?=
 =?us-ascii?Q?m6z5W1akBkcRJmNpbXrAAHRyEs3gry03aXygIDVdsZrOsjUtiExDI+8bT7Gx?=
 =?us-ascii?Q?v8YcnyWkCAO8j5xbKM/cSLwFh3/HnIBtTvlZofxt+g+r65E/euNWz9QC9lsZ?=
 =?us-ascii?Q?y+cS4rdVzjr6uGwRQPaVNSNekixMeNlElwMuT0igHYp1MAx5rYyZJWraMcm3?=
 =?us-ascii?Q?r8I4FU7ePQ36xSHoi0/nCLLxeyL4o17VqGO81wnFb74Xwn3fzAbXwJb7zEFz?=
 =?us-ascii?Q?6XKCLQLKKzbVAYNjx/GeLaWp1VcjK+pXwn4wOHAyOwPsNGP3dCMYumNBJC1+?=
 =?us-ascii?Q?rNEm29+L0eJWsT0nUX3fMH85gO9hx0+hzVRvwexHqj9jUYmhsZ8/n2a6Hd0k?=
 =?us-ascii?Q?UgaOYgplAh5y1mpC4UxndHnQobqPRle6CY/Kdf7hv1n3Zq9iUIVM/nMBTklL?=
 =?us-ascii?Q?wBHHHmLVnXu0BAHH+itSGWTc0qV3IWajpeNBlfG05mb5LltmQb19I8kgEKS1?=
 =?us-ascii?Q?GumFUZKfK0UCDuvYi1gQbB281yhGGKYTvugg79rOPnXSeTa7TgKYZIw0RHDL?=
 =?us-ascii?Q?G2uj02BSJQLkcjQtCAVjJSfKgEje3MaYYTeH2WUChByRKuDzG0XjGqA9mYGS?=
 =?us-ascii?Q?1GmpaShmXo74gtNHzmyWD1Sb+V/3KixNhSrxUgiRE64Bc44owa+4kQK3D0+p?=
 =?us-ascii?Q?MxPaA5RmXZn4vYaS3x8PDqBfFksid7eobamnEGh9efXViY0SA2ZuazlMpQp/?=
 =?us-ascii?Q?9T+aq9+M6aKHJQdRSROwWyNnBCa8oADs+Go7vLiOPkJAeTDFnCGLHu1Zpbc2?=
 =?us-ascii?Q?E7+qxaHhLHiFUoDStxIfIjXje7aG8IP6eKf/gYfwcsVkhvN+CINRRdP/2h+1?=
 =?us-ascii?Q?WgIOKB25lZHmR1wLmD1aULsjdUl3xLaen2v4uczRhUSWq6PaGyc+m4YEr/9W?=
 =?us-ascii?Q?S5pHi9Vd69/zZs6An7rSxwJEHPeYE82GFYCNmE2dXEUlaBDkrC/1WYyd9WJP?=
 =?us-ascii?Q?VL2igULiHo3LsCOSnkAT+1DYWTx1NvbVNvcc3VTTaHwvN1olxv73y9NqPhka?=
 =?us-ascii?Q?4Bn1YUJZK3xfv149vJxFdo94KFW0nDQFs4JEsTz/xb4JE5SOq5ikQJIc9nfT?=
 =?us-ascii?Q?4x+JLDEuYbDjSGnsKIuoLW5BqVeEqHkus+bJKr223YAm1pLN/Jq7rgjVpeym?=
 =?us-ascii?Q?dPCLPIo0cbQ9nCCeI+jGIqw0FoU1Xjd5kClp7CJVzRcMcXPQMwvj3z0j9PdE?=
 =?us-ascii?Q?Z7QoXFmyphJDDdmEIPBAA12CIvANSknK1QWApUctUK0bv4G1Lx/QrVgX8/UW?=
 =?us-ascii?Q?M2gkzj3aHHb8tGCqXLRYnDVAlUx2c8bbF7PB8/bjBAkUJb4hVUkhVFc8aORq?=
 =?us-ascii?Q?3K88fbr6ZMHwkphM6MxqwkKZq0DcRNE0kKBLvxyGFGhMC76HWyZCLUNUUfLP?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f956b29-21c7-4610-a1a5-08dbeb4ee92b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:33:55.6152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: prxjsV/tb71ijHu/KK7zE+wg601dHYpQu4AABLeMO/2AG5lbQ3bhSIHphjZHGNVa7qT/kREL6ePsxEZB8rpsKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8858

This patch prints out TEST_COUNT for every tests in script pm_netlink.sh.

The output looks like:

  1 defaults addr list                        [ OK ]
  2 simple add/get addr                       [ OK ]
  3 dump addrs                                [ OK ]
  4 simple del addr                           [ OK ]
  5 dump addrs after del                      [ OK ]
  6 duplicate addr                            [ OK ]
  7 id addr increment                         [ OK ]
  8 hard addr limit                           [ OK ]
  9 above hard addr limit                     [ OK ]

Having test counters helps to quickly identify issues when looking at a
long list of output logs and results.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 32265d4ecb41..e89b78e7d4a0 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -45,6 +45,8 @@ ip netns exec $ns1 sysctl -q net.mptcp.enabled=1
 
 check()
 {
+	TEST_COUNT=$((TEST_COUNT+1))
+	printf "%2u " "$TEST_COUNT"
 	# ${*} doesn't work here since there're spaces in some arguments.
 	mptcp_lib_check "${1}" "${2}" "${3}"
 	local rc=$?
-- 
2.35.3

