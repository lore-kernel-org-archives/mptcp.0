Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2045.outbound.protection.outlook.com [40.107.8.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1751E612A
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="j6RJ30t2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgDPBNjJSP1YBiOtzyvWUfcAAapcMyzZGS3jZb8ysfvkY0SHlYK0/0aJ/OZCnKMowEd5d6saANpCGsd0MQr53DmtI6wgihkZ9VuLlYmsNu8WkT/FqUxWy7UJgIk490C5hrM3whr1V5uiU0k7hUq/2Qu32x4m17WavZ23EMLWwoeTZgdcGFgPjbs+xHzSdKwRXeXZvvvOFfSfxgdA2LW3JQQl0hyrRQeFsIoRuSQqLMEMQrT1UTm6c1RpOalq2IiiLGQJmFYq8PxNtUD3buu6lty6r0v/oGsCh6pt5V2QpAuNE+Ran9CdLXFCjMpGgxtGY5cVigo9tu9CvlVyxdFaFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsRv6aGr6mmmOPvTXHhXyzuRdf8FIBdg1IzuxNO8OK0=;
 b=hOFOC53ZWnrdvnab2rOKlh80Dq6xpag3FJZLOoPI7jOqTpObiYfa+Q0j8Gx8fRnQCLqpHPfxLcDr542kicBNPxBgSJdgNLIbCCpN1e5P4bbVbee4XL/FSmGjzg4x2GKILu6kgKlsW+NYivfno9qS5dlr/MddewGF6S91EWmzkPa/vtny7YpLcWMvfQQqbTNpMaOb+JxiWzTiwWceljlXfQNNmdIhIuV68zi7OYQBrthitMStqzJjp/FVyFuFCD6++mjZzFXEdY8RXRfvUEIMz4//oxC3pYdPKpjF/zd67gN9QJL3c+zhQnuEYohjCCBa7gkCnfW+GwkEBy7PNGLQtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsRv6aGr6mmmOPvTXHhXyzuRdf8FIBdg1IzuxNO8OK0=;
 b=j6RJ30t2myMabsY2APHUo7ziED80l5K0HEL3nvn1AvvsXSUiIM08rBrUpzfgIWL45EQX1b3sWUD408IU5d6DQw9eAb0ICzhSQcnzKOEhNL3OGQCuIicqAi5vHc0lNI1YANJpuIak1AkbPXJzL4F/9wd++mIT6LkailEu0fUneB9VV+/EgrkUuxwJA3TWTGcZFS7/B3AtRMwv3rc6CfzdbZav4dsm7TAX0mumTF0yjlPyyit9cPo6OUSUaFaSRQlxV0Ng8Uo9rxEUXUQHcK5WSWs9Ulbc2i+vA2KkK1NySKcYRLC6z6c9MAHkaqTzEdHyghqfIARcSJcJUPsnCUlPlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7451.eurprd04.prod.outlook.com (2603:10a6:102:93::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:38:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:38:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 05/32] selftests: mptcp: netlink: drop duplicate var ret
Date: Tue, 14 Nov 2023 14:35:24 +0800
Message-Id: <585c4d4a72a6bef3e0b8fb99a93b2b434ce4b0ab.1699943337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699943337.git.geliang.tang@suse.com>
References: <cover.1699943337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: 53a5ef86-9e5e-483c-d75a-08dbe4dc52ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	31S/sKOuB8nJqZVlVKbfns2xBGdsVDNYAj1A8CLFsp6Ct2QXgz7eZuSs/eMjGseXvpq/qX+6VulyWYvVGvkmoppH1dr8Z7cz4yplMl1T1Tc/xpq4tiprF9hN+OSwkVbZXaNiSKi8adRI2+N1+o7siPAR17IIDdZucuVDJoeo5ewu0BKdZDneUwYG/mainqdklZ641WoNJRsVeG6pxQjZqM7BA+U/ApDauL4Am5ZaIwWszvmKLtsY0vq/08HN6yxYeWB8S452ahyJhCNl9YIWYuPaoryDykRk4VUzpt7E2k/yflNizEhFH1An4jS9fsLqrqr3OvJXxHy/NGK/SEs3idrgpiMoOiXuDjNSpm5f1c6UDEyuX8anzpMwcZwwsT0pFeLuNcks2qoazmdwYBeVxsLuCu6hF7CIp7T/XbTwZaF2MaxlxKNko64M/T2zCp0sozwbg6fwDBZA9DXdUlppEvoXvJ9dEa6JB4ygx9Ht/UPinmRcgdP4O4qGefyDajVGGjPpQi9KHCcQ7GyvvNcP+IQTWMaHYQp75HXdxID5K2XX1TbyHkKuIDEEmkzax1dN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(366004)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(41300700001)(4744005)(2906002)(44832011)(36756003)(8936002)(4326008)(8676002)(316002)(66946007)(6916009)(66476007)(66556008)(86362001)(5660300002)(6486002)(478600001)(6666004)(83380400001)(6506007)(26005)(38100700002)(6512007)(2616005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W06DZUr3FCH3mBMcad8v1xn4/N3qt7qdyHoub5+6x2nLCuYoBBiH/xBCHvAX?=
 =?us-ascii?Q?MEJm68sko0ooohdI2ZcTpzhji3RCHr6NrDBD6CoXxiIMlB+IMAmhoSJ79KsI?=
 =?us-ascii?Q?VAdJv1rlZlnq2mOLGk74QZ0/KypYL1tYDbhyx782cPyoGEk8ErGMzaYHAvp7?=
 =?us-ascii?Q?JD/2chq/o3GGSmUobD7mwMOdBL/M5VZ5eVe7e8LNjU4hv7rnAX4i+46QNLxf?=
 =?us-ascii?Q?TLib5rbZ96FV1DS6//giXbA2ZHWi/Tb2BI2eU9paJ4StLjQmPx0opW/ZaMdn?=
 =?us-ascii?Q?1j2ThFVK/UMtzAvDOWFIihbasTNL9MFn01r26/NVXGIrwWl8Q1uEaXbMxX90?=
 =?us-ascii?Q?nYEVBBZVRmN5IJjaDFoWEAB66YYPctdKtwJah3Bpo+GhGBatH2JQOneZdkNW?=
 =?us-ascii?Q?BxjjYOFGhvllvdxR5xUOLSxhm3LMmYm2FERPXU1QPR0hwjIVdOeLTN567ZmW?=
 =?us-ascii?Q?miBKtQZOXdlxr+M2SDBTuvw78lOcn56QUhQRtsaCvRyrSgvK3xm9SjA0hJ+3?=
 =?us-ascii?Q?B7YQnyMUvGg9MZXcYlQK/9f29wdsavT7VIL5z4M0+gcn0Coz4rh6EynQBIxA?=
 =?us-ascii?Q?CuyOcGVPrF18Vhsy8GXWbeNMcz6mAV+soHAZTrdAScV6Rekdfvrf3liIDKMQ?=
 =?us-ascii?Q?lk1OQw1/uISZG3XbC4fn8qhYF6oPKYgvg8lv5p+7aV5HQ1t9+zn6iHYXnvLo?=
 =?us-ascii?Q?5j45bsv8VEaNGQ5udEwvu4Kd/nndtOE4FYLko0NIDs1zLZ2DFUW59Dha5HAT?=
 =?us-ascii?Q?7PFOZ2rXV7IPBsk5w8RoHpuIFUQehu8FoOIEKp5KK3JdKsN/LpU0PN+/OwVj?=
 =?us-ascii?Q?hU6vKVq8eRW5gdM7C1iuUG7eYCzz9jJFvMkd6Qj0SHOovrPxHAJbAr7X7YZd?=
 =?us-ascii?Q?l5S3JKm3O+LQbN+Td+YwbPLv6lq2FZqkLu1swF8MRjX1oL6MfH3gy/2SIAPL?=
 =?us-ascii?Q?srm1mo2qfii7r8x3h8dt3yeflZop++zgHqAGj8wuq9SsfUPLstZFso8llaFF?=
 =?us-ascii?Q?RymdZN1GACSB5nNnDQIj7YpYt7gMx3eODp3ptMxYWJyJCXdCMJJwAGi23dSp?=
 =?us-ascii?Q?C4trCsFd1Zq1lSnCDn69ggc1HSUniOBHUMQHWHMFzxFc+XLiN4PEieeWtV3n?=
 =?us-ascii?Q?8x1OrXEnHSy9exHH+fcHq/9HOg+wI+IYGIINnL434Zs3f7uIkrLxGpYYBihV?=
 =?us-ascii?Q?KAS3eIsZnb9pq7Bhqd0Mhqn1faJ2fTbWqpiaCG5fLUVpjznmm9G+w0RYSCCW?=
 =?us-ascii?Q?Hw689AgLQ/bLnGLJnYtlseraC5fS+UtjQ6PiSBb8vCMpg38ksytYdZ3J1GuV?=
 =?us-ascii?Q?A0EXRlcA7H3iOcth1fzXrX1fCiDCn+6C856w5ZRJi3a9YqJqsw74zlLEXn5B?=
 =?us-ascii?Q?wMXzlLwrLzjkEwh4ytdI/ug55x/biM9e5df4xYIsQZRovoQt0hLttNdeT7Hg?=
 =?us-ascii?Q?5OAu3pRhK9p9QGvIlBUPVKJFUp62Y0SacmcmIo7pd94dMu3WxDpt4W0NkG8d?=
 =?us-ascii?Q?vilWRTlLL9Vexg26NrtJutDZbejyTJvFoyO77EN9uK5R++6oOZweh3+0192F?=
 =?us-ascii?Q?s3omD79nvJrOF3qUili59q2TLMZrGZGxLXpdvGX3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a5ef86-9e5e-483c-d75a-08dbe4dc52ea
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:38:33.9346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2JT1qadcLMprXS5rWa5me0vy69vfVymX8MAQo6bQHgPESloxY4DGJiTQwz8OWzGFZX3ATJBMSo1pC7z6u1eRZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7451

The variable 'ret' are defined twice in pm_netlink.sh. This patch drops
this duplicate one.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 8d30d4a1db57..e995dfca52cc 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -27,7 +27,6 @@ done
 sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
-ret=0
 
 cleanup()
 {
-- 
2.35.3

