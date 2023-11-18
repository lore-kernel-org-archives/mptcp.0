Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC01E5672
	for <mptcp@lists.linux.dev>; Sat, 18 Nov 2023 03:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z3brcozK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ay9KNS+uEvoQ21bErd+BRVdZsDWTes1Cm2mQeRCNeXgqkJRv3Hp8pYSCmSNJ+xcUxdRqK/QUVDO+dJfFOwEkTN5BPvqmgew1Twf7+/cPgzSwe9o0hWVEaK8CeNQb9FNhT6q/8pHgSr/WyyvUiDULKuFWX85wfrZZ8VgGRy9f690Ebf+YNCrTWr/3e3LPCdEqpwUI1Kz5cLwlm1UgkkQEPOdqgBe4PuZOLthPUBWnXJ8bMTv5Q//QZ25iTmjO3quUQaJw3ODfyqpcc+B7Hv56WFFeG03Wsn7FgNnUUPlx4DvlKsd0eat0zK8pGMJic2NrVPq1WqASCl9KbnP8lPpm7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADddhFIxK7b3g1vK4LSYkV2ORLFVTyghWsSLKr/mSgI=;
 b=ArjfpF196Vd1lVbox3qUj2LR0fv/mC4o3yv4WPZwBgx9BWUNlL+XBA4xbw9QP/oG9ZI1Gx3nK7nLESuTS5gIpBfxlVlfW0u59zE2H96ArYWDVULlVioOLohrtlBIc0Ta7rEdRuaPHUSC8+GElH6jmQRCaURcunmoxI2udfWdS6Wqa9Rto2G95FCpjzo3cP9P6VOIna4qtKO3zJC+HaLgh6uR17zVZ+lMPQ9RezP9m7DJWmX5WoXjJ3KJlnsKNiO1ozSnBDgS7NWeUainVqELkheFvMyn9oHHgbn5Gm0jZQQYXG2YxG7v+gpy0swGXZ71g7tXYmEa91JRLEheA8pWww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADddhFIxK7b3g1vK4LSYkV2ORLFVTyghWsSLKr/mSgI=;
 b=Z3brcozKO3oSPLqbwn25HWIx/fplhA63oqCpjPg+JikyFXKck0CGXpxGIJn13jQq1CHFpVmvHhWp/BUsMQIqR719mTEt/2TwDM+z2eO0WP9SF5BGEzNz1vFrtmAvFCrRf3U5Y1P6E9XowJJKcJIASC5hp2LTLGj+Rygyp8PFTXWGU5UpFwdzFjx89/EGdC77qMeGL6jqa51IRpefjbetzy6gLaplsp42I6UsGoyZfGvzcvtwya8YheCX2ApjOQ4aJGT1t5q/oSoMx5dTfiqUlOhYn7udRnqsf0E09xqXAn/7onpkeY5KQLjy45ckNoaSendX/x/Xb8KrwbU2/Nvb7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8847.eurprd04.prod.outlook.com (2603:10a6:102:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.11; Sat, 18 Nov
 2023 03:16:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Sat, 18 Nov 2023
 03:16:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: add chk_subflows_total helper"
Date: Sat, 18 Nov 2023 11:16:47 +0800
Message-Id: <4bcf528d5ec4163c0ed64bc62566d8574e7f09d1.1700277365.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0144.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: cf382c68-a17e-411e-6dd0-08dbe7e4c273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W2zKn1cthpBzkE5XbG0NJBXN7KlTJ5XlAfyZ/dFexuWaNB8YL/jMxdc6E1X/KZvjdggoWg8lfc4ZRZ24vVBtl/kTZWpP503+nwAHA0VWrGppJ8WSOdN1RpAFgZtk1W+c9VDkOor9gE9H2aGLb++I8lwwfy4ncgQBfTSKwOEjJm4RToh+uLH1HJbYYT9OVVTFy5HgcijF/hdM26E2WYWhQMVZreEP/wUXW4B9P6lnaXOt6V1QrjNL5UcOMBkxpAlHL6VHGn/FRzdNbPYDrrhvNKj4UleEiWPiAepboKu+HkAYFHWc60r+Sv7b9A/1VcwPEIOY2Zpl+/zDYUVzcHLgRT7FOdZepeJ7RgHURNsJaElksSOvE/BrEKG/cvFRDyrj0KzM9uZrHRR4g89fO/6XHooEdDsRENosS3UVRo61ErUu+Xy4uzau5pcYpnGTAMrHaBfV6AtrITAR2VE9olHXNgxx5xjhyhCVrTHqbKMGy3wZyiRFV8UMm3jk4k1FpORrBVTDqGgEDl/87hkAK21SCVt2/MSqULrxFTGicebG7hKVVaNXkRIZIy1WVRv+qiWLX4Lud6Jgc399ahlZrKnDIJ/rY14XVs6LG+mrmTMLjgI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(107886003)(5660300002)(86362001)(2906002)(4744005)(44832011)(8936002)(4326008)(8676002)(2616005)(41300700001)(36756003)(26005)(66556008)(66476007)(316002)(6916009)(6666004)(66946007)(6506007)(478600001)(6486002)(6512007)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jBqoSYkAeWIueUXBa9MsYOo6HRhM1cdUmtfZDvux5VX2PNIkIKWb2Gh7jkb5?=
 =?us-ascii?Q?txqoS0hPIPPcYbNNBczLqpTzfxPVOX1q9JgGS6FWu2DKEoUOS3I46rnYZ3pP?=
 =?us-ascii?Q?8YSL0sAnEz3DnFcTIe1VcBx8P4jnQf0OqcZ67nzP+KC3LLT86fTgBAUddKEJ?=
 =?us-ascii?Q?SC693pylkMOz7rtEbKgEk8psW5OVycBl0OI1P27oOlUV3zpgGl2fimAU8AJd?=
 =?us-ascii?Q?Ny57tqlUH08Zk5pqIo/SlX8rykYuyXvBKu8fyZg0DRaxlj5/hMkFcOkG36TJ?=
 =?us-ascii?Q?cXDpFp4OfL3IkyIoTIw8Kv18xIRgJdgU+FtNFiRIO6xmO9F2LRjfAbknyyNm?=
 =?us-ascii?Q?94I/W1kQHo8B5STqNURUzdiEDV3UfUORuAvtXOutM+bqiYl8rkS+Khskc0JU?=
 =?us-ascii?Q?6hTES7nYeAdT2+Rj3fqKpXq7XEzXwHAkGiA0dO7k06CAItn9/XW7yXQBSK1d?=
 =?us-ascii?Q?pikfVQisCpmlMgxOXReyqL90AYHFJTMAfGFqf+MVyuiTJJdXbd8YOdpt+Sl3?=
 =?us-ascii?Q?LMT/DEPZPu526rTNmCOqiv6BEpzxBXmghNy2yPMpK/iV91ruJZkDtOky1sQm?=
 =?us-ascii?Q?GrZtafNoQWteGQ7t9w766yiyYn3rzsabT/GplXUcd28fcwTebVySDOGz6KH9?=
 =?us-ascii?Q?fu1SrvhxYypYnPS1Fa+HkHUGlN96yae8BwDG69PWvl80fGpTuYA0HSYO9EF/?=
 =?us-ascii?Q?hvHhcLym3CLb0bt+fv2SI8NVWzxxaQAJDCZylrGvtPosVMwOG7a3dZuG75mT?=
 =?us-ascii?Q?f+dJSB3JhekArbyoKAaSCTaG0zsiQ9PDwCuLpq6RwjWntfZIXdIzclDcmgLW?=
 =?us-ascii?Q?HW8Uy8M6haB1/m2Fuwvi/5T5jGZapabAfWmFR8ZbFqpaSpJoNphsSDLNFEpX?=
 =?us-ascii?Q?b/sUT9nIAKbMoJH9zBcg4tpM+gUqEz2D8U+Cedr/zr92Igb0xyCb1OXbxkd3?=
 =?us-ascii?Q?HKkD6kG2ihrP1ddSaGLjKzRq8zVWb+LFx/vEPjzk/HdoXnYTcG7BAHgUF8tD?=
 =?us-ascii?Q?zqJA6NZGCruEM6oibsj5/f7cCDBrQufrae7koe2DcDDhaFu+yPSrdedYVwaf?=
 =?us-ascii?Q?fv1ZOhBZSSaEfXlD0E0Zzli5JOsD+g1KiT7ZGSl8tWPzEEkdUF4xEgKKbaqM?=
 =?us-ascii?Q?24xys9T0ZR5pAi2wvfc8FgB14hDXJ4CgPTom71GUvCzMolztaEPPp8B9OlKg?=
 =?us-ascii?Q?luKRqUgAVHCJwlJVZVw07mUKxGyESRzFVqKL6zqBAfP35VkDmtru7n0QwRyv?=
 =?us-ascii?Q?mWrsB+KK0XlQtrihGfCroNCJFkPEfN1279oxqGqyVze/DuDBwmYZbZ1T/+rv?=
 =?us-ascii?Q?dfl6Um0mWzV4Jj1VpsI0lr/ji+AwkRts0fupdGxxbYFSkkujGrneLdahbGG3?=
 =?us-ascii?Q?p26aNsJ9hG4IWcjVb1TTPvbAIBLGvl/fZyIyjxE1IT576aKat9qVI3NR1yID?=
 =?us-ascii?Q?ODa9+MbuCnBncbser7QhLT+5ewS4tQPoM/7q5BM/vqTB1lFmuIzLY9mYfuI8?=
 =?us-ascii?Q?F4OP7qfZjqRyr1SyraK5PsrOSWqBeG8bEiD+2oQ197p8SEkiv3xAVsXmNxh4?=
 =?us-ascii?Q?ODUn+0wXwLagiowGoxtePZ93CqYNkuO0bfhBwkrlVDKT575N1C/cXdQ5/pXm?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf382c68-a17e-411e-6dd0-08dbe7e4c273
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 03:16:30.7849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jW/KA4BWgvYA4SOIr5O4S2db2cLL1WegSsTHHtzF9PB8CqIhXxPrmAklM6bgvjmXU5ZY4buq0EPycWCtz/Y48g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8847

Add missing "local dump_stats".

Otherwise, no place to set 0 to dump_stats, if a test fails. Then
unexpected dump infos will be showed in all the subsequent outputs
of chk_subflows_total().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 1606474232f6..8362ea454af3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1841,6 +1841,7 @@ chk_subflows_total()
 	local cnt1
 	local cnt2
 	local info="subflows_total"
+	local dump_stats
 
 	# if subflows_total counter is supported, use it:
 	if [ -n "$(ss -N $ns1 -inmHM | mptcp_lib_get_info_value $info $info)" ]; then
-- 
2.35.3

