Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2051.outbound.protection.outlook.com [40.107.105.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0AC341B8
	for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 04:02:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHD5r+q20uRVPbB8feo4nnnSI3V41O2N54OwsFtnIUIKi1A5qPKz22TBf5QZuZ0cZicBgWpLYqyPBcU3uJcan6GYI6ZjFguGDlfjNxZt1hXFyf0bL2Ol95JqsVon8/1Whr9Cy9yU8Hvj9BzVBmdCtYouzlRk/LsGbeKNllN99W40aCFFkiLsBHtcsroEXiy4f+HVDQN4Nynb/YaPOljXHZN0tAKLiqMtSzfTacFGd+yttXkKP9ICkUwVtbq/JOJdespucQYAbY8QGp1F9WUoqK7IcIv2485F1gZOolvGCopZrsfrbt45tdPub11ldbLcLOjKqhzLNVer5jsTSklczg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dInZIUajdHuxJUDgJG14Kc+DE02JYSEOr7Mb77Eg9HQ=;
 b=ob2IpCRD+F3VStJKp+NqN2UD13jMU5hz/EewpvwaMlKroog/DP8Zj/cnj0URKbl17mIYU9Wm3R0KrSBCUTmMdHXZOKwIhvcqZ0qq9OJrqaKNqTyusU+Wxx4s5Q+ceWt/LOUUJ+Z8/6hqH63+zGur5wWSzi6SZOyUVSPG8pcD9glqqosaUWnCQptuGICUYWWJbZo9eWZjlX7Bm5ywqqtBaR344ARDoMRUREhITHmBXfQVBacFtZclNAwUy63a55fcDSJ388fQdN/XiALd6BteiNBvv44Trrw5GTfkLaSB2CwS53HcuQaJw1egHBduv9ctAgtzVRE8axIAd1IdpXteQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dInZIUajdHuxJUDgJG14Kc+DE02JYSEOr7Mb77Eg9HQ=;
 b=bO9mBnkoGjdTB7w/kF2D55Yzfeo6YufXHXmDvgDaFuUCv9jn4g02VuanIRef1UDfxopceX7MD0/6pZcx6UqFoI/u+rWgcEoFRCcgs5X29j3+dwR1s7/ILQ7VEvLbSdc7VzJFJB407jZAmkEpsQccmkluuMyq34pR+3g5cDU/4LW8bVF4uDLK5kKuNnHDbS3zR9BT/OwLfbtb7pSNYuR8xpfKUcg4rsABp9iZSVpVB6acn+/47ntwPbwCdP2mHeNSGVL3fBiSq0aOL2nEJ4FKQKTDTg3meyVVP2sdM1EoLW69yL0FiOUMDbQ8hc8icnvn21j+VHXzdfRxeHHMspXWsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7297.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 04:02:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 04:02:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 07/30] selftests: mptcp: sockopt: drop mptcp_connect var
Date: Tue, 19 Sep 2023 12:02:08 +0800
Message-Id: <78919edf30a15920a07adba329b5888049a832ba.1695095289.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695095289.git.geliang.tang@suse.com>
References: <cover.1695095289.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0182.apcprd04.prod.outlook.com
 (2603:1096:4:14::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: b94f0bdf-25e1-4797-9070-08dbb8c54b41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0/A8yS/kNF97cm1hdShIi4jbI3iqo5jKDCFqlIk26riMGbLdnfJQ50wZY8+c66y4/V3dOU7MqqHm5AStsN+pinBXXpnz0Vo93GPf14ccl6et3CfPMh/sAnrZAKCo9Gmu6Ra05KJrYXh/Iqw/HY+BdnlkMADgrD1M0gwHC/5ZGCA1T4gaM1Tlq1gPR+zo+7bayQkG0SB+s1WCUuZtFWtTV9A74MmQoln8jfRifdIBL34wLQTyFBJ9wMPk5NllnkS8y2cdjZI6W/e49xr/8TTeJZ5qbXHs1h1qQLYxIHErYGDtuFW49jznZ57lGqC+EFoEphgrVdfR+ZDtcJ22K78ob/XG4szvLpCpv8z/Bg1u50WqK6Pr5CZcSJV9vr2SBKrN+AoNWAb95/LFVpdFopRI+cpsevKJpdS14WMj9YX+/UPjK8FotMfXTJTLDyWH4MqFF1YZlPjlyJ40dCCtY3sIvA/vclzuAAxqX75ODOcsdX406+HkWqVAPA/QjGrCQsX85zakjcRGSjrIEDcovf2wIpqTv2X/D1y09ZEzWAv9sHSItOb5CpaYazkd/MFjKPCbYMcT9A99aYqhdxEjzIzTeZuZ0tGA//V+Wz7NVzh2/dw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(1800799009)(186009)(451199024)(83380400001)(36756003)(2906002)(4744005)(38100700002)(6506007)(41300700001)(6486002)(2616005)(66476007)(66556008)(6916009)(316002)(66946007)(6512007)(86362001)(26005)(478600001)(44832011)(6666004)(5660300002)(107886003)(8676002)(8936002)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tr9pd93NhCw6YmWj85IhNFPziZty5el6cJrvc6bTwlsDBKC67RGtuW79LaOy?=
 =?us-ascii?Q?D8aG+qWw4uZq7gFzAfGj9UpLRea6+qthEpg4vNNhGR4mwbwh6TYqUNdfz1EF?=
 =?us-ascii?Q?hUIWGOjGUg+yIwidOvmz8UPBYyblSRGTQ83wYBA6jeOkHdRcsW1uRHGb1JZF?=
 =?us-ascii?Q?DhHcTG1cnkc55yh70/yX6OGRhJE1bOH6YsPhNaCko6TbVdxyYXAEgIemJaXP?=
 =?us-ascii?Q?5X8Fw3ek5arSh7cjtmyWP0EtOz4lGTYCGh0bDo5lfbHJBwhbZ+w/pyL27o7h?=
 =?us-ascii?Q?9CgAja1JKTCwkH7pKfa4+2ON3deI4J/0wApxb4PNEAyq+RKD12pUudvlB9i9?=
 =?us-ascii?Q?UsHZC9bo2mvMLLEIBHZbyWVMH9Ds2T05W8B6MpcO//0k+ToX80jMm6FZWgc2?=
 =?us-ascii?Q?17pFE1zxTR5FdHyoy3rNIAaurO8JzG1yZl0nmeWfuDn/6WxMxvnv1rJdAUO7?=
 =?us-ascii?Q?PcPhHYQ0GkokZW0yE/y2CiCFTRdOFkNA+gP6fwFkqqjPi5aHZy5Hf+06u0Sz?=
 =?us-ascii?Q?Pcs3Ds3mzBabLgWggTfYCxnEdgpBXBj80poIPR8xILo/gC/Io+S2rtoNZGzs?=
 =?us-ascii?Q?dzdhlfblNeYrHkLzp4pGSR0oRdp17KxeZQfkc/Tmr3NeBwS8nsI4IBJvbheH?=
 =?us-ascii?Q?HOS1WcsH7A+2rfsjC65o4f0sTH/lUHtez5kQ7V74pc8WZoMS8aL4BycmRBNY?=
 =?us-ascii?Q?GDlvA1tQuqJWUzlrxkkpRsTmzJR+luvZAj39xKo6gb8sPy72+Fa9xJLrn2Wr?=
 =?us-ascii?Q?mbrrmuqn3PYOp9bLGGYVlpRSW8G8KcaUGZglmrBBtivoG12oDn7JakrkuHQT?=
 =?us-ascii?Q?1v5XoYtGWmkytkXg6rc0Ke7Xbe1UYlezgFN8GFB6JOSY3IQ6aamR/2Fa/oFC?=
 =?us-ascii?Q?o84x8MidvVJomWbmcphtYDT8VhLhDZsZZNauDmHqc8uc+H/Rmns48YdPWvap?=
 =?us-ascii?Q?FODCgEi4uq64R6VOoA8NonYPyz2BQrb/QV1GmzLtZHElDiOkzENiv4sQ4P5E?=
 =?us-ascii?Q?Ya27FBIdDeUWpe7GGNIStjubvYmvLxK3nphsP/uKo8najveH0+LKmhkZ+iIx?=
 =?us-ascii?Q?ZJH1JjwUgTug2in6Im9YEgUKqQ7QQDsLHk9sTQjWs6myzesf//Pl+zSOIaAo?=
 =?us-ascii?Q?RhLzpQUK3hIB1KU5Y6b5/pFUXjWgJk1b8RVj/flPfsuWqCrdFoOS8D/EyGxo?=
 =?us-ascii?Q?/AOM6Y7saQC3q/b90O+9sMR+Huacb3T166hBKqomn+Ad9PacZDByoEamj6xW?=
 =?us-ascii?Q?MLZ/w3hiI7HZtnq+vHnvZX1+pVefmzJXjfhQwgPR5LJ/X8pb+ZlgLdSezoZt?=
 =?us-ascii?Q?aQ+cvOzd5URchOhzadplx4xW3BbHiujMNPwXoKcDkpwUuvVZLNUDu+PA/gNa?=
 =?us-ascii?Q?ftSKZnhh7tew2/J/qofEFVD0WG8W0wmYuYtZ8sDvgO8WQVx9zWrSEZ7UaCCY?=
 =?us-ascii?Q?MWQLzIMmAdTOm19mRTK7MEuerM0jkDYNhQV95UcbSSIgMvUIzYJV91tlGUtM?=
 =?us-ascii?Q?KlfL/OppFzXy6BPQPXEqpcgkjTyaV9zQnj1KhWXka4h5yf279Idjhue5Kd1y?=
 =?us-ascii?Q?P0xwEZKV/Pd1w/uyPqev+2V8eHKZObQuJSef2iFd?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b94f0bdf-25e1-4797-9070-08dbb8c54b41
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 04:02:51.5060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: in+de6SutfNCGPaCf1R2KpiZauMv59uuJElsawmZzvO7ayVh1flSj+QRzsNeQR1AVlr5FZOt/EYr1z2BMdxWfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7297

Global var mptcp_connect defined at the front of mptcp_sockopt.sh is
duplicate with local var mptcp_connect defined in do_transfer(), drop
this useless global one.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 8c8694f21e7d..a817af6616ec 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -11,7 +11,6 @@ cout=""
 ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-mptcp_connect=""
 iptables="iptables"
 ip6tables="ip6tables"
 
-- 
2.35.3

