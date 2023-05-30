Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2077.outbound.protection.outlook.com [40.107.249.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E28134C8
	for <mptcp@lists.linux.dev>; Tue, 30 May 2023 13:19:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwWjoJqaoWIxyo1IjP2McEF/4q691z80kfYnb9iC7fRMPltTgdOWAH9d7/msAt0V/9DijiTfURW8g96vkPE3s38Tf36uQRetUb7FKNmunjky3Xk0NF84RJo0O05VLOHzDlr4JHJM7vVL26Uc7DKPKUFNHuKcXsTmMloHsrRZ1CWIZuqVVMaGoo3wI+hGFcPL5mqj9baEKC3fmVakz0m957YeWo5KRVVOe1rbeexXyfy7IWD9jIU4KmhD8epjoU/khkM5q1SV3iZN2EoAI16RBN5n+juBQa9cdR4csvaOm9UwR0Uynbgeep0uSo2j59l1eJJu0pmPW8g7qfciHmfZFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAAXpxTwQ1Zi08PGAKLlb0QSz/kVoLq/lZtYIFLzxNM=;
 b=iyHX1AAaKdj40DcT/FV8b+woE2RwqU+C5KbEKf6miNg6FBoqLmZwNHdpuqV8GtUZB66pXA6kr6O/HMbn6v4PaeoI9BactRTMvEBAXVbiuDpGOYoe+fCGhysV8FhIqoyx05Za2BqAXeZoIlZOsYWI1xUXkDP0T/Ff8i0DwFXDQTuLQq1PEN9RWfmtz+KuFwz1wN3AhX6Yu5kD2MuP3LcQ7eyT/3w5hr3+xer7xLP9MeP+65c6eIH0s/AVdC6Cpt0mSaZc262/kJSEcnOj+IIz3qZ6R8Hi9zR4MUaBcagXEJn3d+QyWTaWmphZR0pyR0JzxUDP7nnn/cQsu+DQOtgFKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAAXpxTwQ1Zi08PGAKLlb0QSz/kVoLq/lZtYIFLzxNM=;
 b=X8qYJjPu3Tpt+wXnm2VWamw+B4RT18v5+QSI16Jv/qgu26+SnkPY4Tm7XVEbztqnSlU1MzhbCJOHKWeEUO1yfO2hwYZzRZb6BDltUuNxwctKYos8uY8Q41qQdKkvUGPykM0faGf+z2nb/Pbsvuf+pGj7AUrmxZouMyg1LJqRC8Eir1mnvG78hQqXG34hY+m3nKa7FUackPQ0InrpOcLIpRnJYaLBeaMcoPa8Ja/n6Cn38L32UPJL4UHkW929PXeqc3n7ejUGm0rHN5gptWztQQ22jFST0GQTibT6alQx+9u3O3q3Zi2ybeVx2rARp+Rw8dbPZHJfzMWeC0CwB6rsUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8916.eurprd04.prod.outlook.com (2603:10a6:20b:42f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 13:19:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 13:19:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 12/15] Squash to "selftests/bpf: Add mptcp sched structs"
Date: Tue, 30 May 2023 21:17:32 +0800
Message-Id: <8a5d534cc9accaf2fab4682513aafd7e61f94ba2.1685452619.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685452619.git.geliang.tang@suse.com>
References: <cover.1685452619.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0075.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: f1748ea2-d5bb-4c8f-0d6b-08db611082ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GOCopVv4wjp4uST68/X+sJbLS7D8GHAl5+rnQlgumZTvL1YVk2h8XdpQKj9gWkZMeK2ptgZVx3XoCmO3UVunOiV0U+kuRB5parPsELrggZRV2qMCUdpURZHMZdwALXKMZXsdzR+2YLkAnZpk/nFyo4Uj6gIdaDqGgdeTihxqNsPPD0KRB8+UgT8naUuZdhLVHpvrOStTb+uMylm3AcMeVC7vVELttOyWPnU9V1v77k+DgfkJPWqczvsW6CCjv2/ju2T7Tndy9v3ztW9Ug68Rjn6X+0GoEa71o91kTlAJHhnCUznO4GM8Cktdr8mkMWZRSMs2v2m+9B6g1PhqszpyyYltviojoubKDSBGq/pA/8wKK5JAlB9r9+FGzoMz5uWtEqZDFldjJTmDts08fbv6ZQsuT2FE++cuA6WJiiuJlyiPNUSAePu5aCrlMidxg9KHIglonu0YHvW5vZ97BIKKDqM+3rLUHrYBEkGyX3Xx9WkUJxUIVbicZKSzF7M/R7sWGNdz0vEA7v5Slbv1OAphjwf5UHl6FkyAhKFFs1HBqF5kt3igpJb8lzGrqYswuiBl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199021)(478600001)(8936002)(8676002)(44832011)(5660300002)(2906002)(36756003)(4744005)(86362001)(66556008)(4326008)(66946007)(6916009)(66476007)(316002)(38100700002)(41300700001)(26005)(107886003)(83380400001)(186003)(6506007)(6512007)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9EW8tWgjblddDK/PYz4RL0nHeVIcB5smEXZ7fVtb0Dq3JcTKF2vTDTdUWcgf?=
 =?us-ascii?Q?Ym9l1e6vc1Vgcx37ihAepteCCFYp6/V0X78FbAXYsGbF+KKah6P4KWukkWxE?=
 =?us-ascii?Q?9wMpmUHIYytKuH3F0SuOPZXnwSCPRAzQjImNo0CxooxDGipi4L1F8oxqhVHH?=
 =?us-ascii?Q?zwUi3r9rYc8vTgn8G+1GBbxJEnDVPtIJIUUd4BxV1BBnOMPyVcUIuU6r3X6W?=
 =?us-ascii?Q?TpUh27AMDm8nISD9Yi8uhqWe/JF3d4dLnqN1VY1W7JOT0MGXjom8Y//yDxKD?=
 =?us-ascii?Q?0w/opbXQSKBsPFpk4KB1Ji3FG7ymEFf5MwVxfBc1ZbaFWJ7YEh2H9qaE9QaA?=
 =?us-ascii?Q?tPx2aqOviJKt7H4/DB6JRDavVlnJe8F6RDngyouwxKDrzzHy5FinVIEX6u5S?=
 =?us-ascii?Q?AY5ny7cXt5dlO8SZ/nW9h2qCp+mHWAKrlGdAayFlvc8H0BUf/HDa1Q2ig61Q?=
 =?us-ascii?Q?T0dEV6h+HcT/PA/lvcuQ4tACu8+mgnCP6ZyQE7emdX0tsmFK6tFgxVhPbykM?=
 =?us-ascii?Q?OjHqgg/POjTglPKT5WhL1/AU5pHdxRCRbl7d7xL6ORAcsnAkX6c4DxhkwmZt?=
 =?us-ascii?Q?EgmHRPUVq/rXsjVxEKX+8Kfys8/kFvstLGjCPOGT7b80Retqda/tXtNrSK/n?=
 =?us-ascii?Q?wQh1lHsS92ECEmlQUhgYBi0MzoDtJQ+kWU/Q2r4M5Eht/8L6UN4cvU5SvQYG?=
 =?us-ascii?Q?afadBlX8TWbw6dX7CpIKw1kw5y6RH2IwB45C0V7SiVxn/acrZw6RgMz2lK4u?=
 =?us-ascii?Q?JIjh7CaKLoft3hW9ZMSBJq7q8LZQBHYhE5R0bEm7yE/5u6PMI/ocXP8NnKZl?=
 =?us-ascii?Q?QGAETCZWglm8IFTheifzIlwXex4HIQALGr4/Y6Ss56HlBuDWg6ieddg+voP7?=
 =?us-ascii?Q?QTBGpmckjUvFL5DORaGkOAQ6H4zDbHlVt+4PWkqGF2LY7lbKsyF1b6s4G0hj?=
 =?us-ascii?Q?n1Z3DovIIJTpu6N6DprQ67vACBPPi0VPltxWmEm09vP3ApIzNJZh+OyLrd4N?=
 =?us-ascii?Q?C+cl541CZKmm3VNSlF+FRLldxYwGUmuBtH6AbGmrFD1R/GyUBSzmd6ThdETf?=
 =?us-ascii?Q?N2x87jSUh0qqDIrv98SKFH4TmdjqjEsA2BBnBd24sqwwrFZr1Ci7Irkdw9++?=
 =?us-ascii?Q?3rqNDVjVUrg1QQ/COBLSj+0eTMr2PW/boApyvKbcTQDwcWJP/WckI7VKUAz9?=
 =?us-ascii?Q?lAmSYHxuVmAUpwIQoLyCO9ZRHcGFufxxN4PcjWNztqsj8Oq+jCd5IId7EmKj?=
 =?us-ascii?Q?SMWEw+PmT4NW6jGLPwoE6g0oDi9IiDrGZPXbxloGXP46DfITK9Rk1Clbb1K4?=
 =?us-ascii?Q?7efce8mooYMsq2BsRiR/gFMdyGdr8P0EkSsy4C3yXbO//208mQ7dF+aS5R/O?=
 =?us-ascii?Q?R0AI8T93TufXpi60Ds7X868gzNkq1TSGvGfNbbWnDRO1rFMTWkltIOK9mbbR?=
 =?us-ascii?Q?S7O7rDdncLqGoyQsDH1++C0j9zg8Y5r5csCRttY64ZNtv1jqliFTg4f3EoU/?=
 =?us-ascii?Q?LM4ZLzl98fH9fgdXjlk2OZ5PgZctjbokt7LQwKQK732TwPJ5hIt8fV441AtL?=
 =?us-ascii?Q?6njr4G3/1GMGCFIG8FJGmZXOnR1jLLtOLNYVwvPi?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1748ea2-d5bb-4c8f-0d6b-08db611082ca
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 13:19:34.5915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2nFb0nPLYMdu0umj8OtxDa50zF4S5bFcgDHEpOObJVLOFtAU3PILHCL0mGPgZk1WpCyxmZ7a/dN0mZGdAgh/lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8916

Use two tabs.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 72c618037386..fcb023a749ad 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -239,7 +239,7 @@ struct mptcp_subflow_context {
 } __attribute__((preserve_access_index));
 
 struct mptcp_sched_data {
-	bool	reinject;
+	bool		reinject;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 } __attribute__((preserve_access_index));
 
-- 
2.35.3

