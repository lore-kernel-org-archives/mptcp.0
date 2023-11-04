Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2079.outbound.protection.outlook.com [40.107.15.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E107472
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 08:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cA9sepce"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=En+jxVSyiFq+t+1gFFwvuolByQuOid3kBzLH5gWlmkQDOIDgVP0XRhWARvfc66fjJOHYyVNXmNgMywHwuOHmp2cTVBGgkOQq9PwO1V8DzLAmRa/5lnUK8GzbkMKnGEYhiq8sup70fuJmgejTPq9oCZ3YwlyHYsR0N1563tuwtcMHCknYqAevPDXzDNbyojGDVGfwIstF15cYochQ8njyPK1eeSchHvqC0ncy5A/pfORn4riNI9gZqpF5p/bnYdgI+nZPGqXNNyHSTI837rP2th0469atVa8PvMiUe0xHhz7+5XGlPuVDUZLwefSS4cd3AzBjowjGmZ8wmi1jf5+muw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2x5/vC68x3R7Wzp1Hw2MCxSVfKpwwTmhfJX+C/W1sw=;
 b=CZhM1MtRfsNvX651XhrH1yEdHuVtT7WzwWJxFicy9/hKk/xGxVFIHMtSZTJnRNs7kuA1NdSSJ0E4gP2XWc+P3BBIOntJAeqDnnfantHjXLQwjYneeOG0nEkxFcMTlcquyerVEnUdjSa2L0Hw9/9ON0Pk1BE1v/JNBILtt0F/EBY2UN53KovjrgpDVW55zcAdxRVAx7fNScbCWF5R7OjZAsNqHnDgfCYII2Qy3IOhXiyXsKqm3bbpocqvrgjmfBrDRSkvcElji6rQezEzGm8/1Mb38u+IcDH+PU24/1lwvHao0zrTABh3brNdcolOkMtii7xs2S2UohKr9fjTQpatlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2x5/vC68x3R7Wzp1Hw2MCxSVfKpwwTmhfJX+C/W1sw=;
 b=cA9sepceZ/+8I5ZU+rZZieyr1XKZaoKl239y3kXEdE6Phidgm+xxLW8H+1uS/GwS/TSD7/O/wN0HsHergZHNbKLAmsXon2slZumv9Vmk7i2/0EtKUNhk4zW88/i/z54z66yyBC5z+kI3VazMLAr+HjSys8Rs48oZvExiylMHYNguN+iLA+Ou6xmOxk/MES1Q9a6X0b8E3IZ9XWRV4KrddTB9U7MKLYbPpd44OhnlYMMsOe48O9acHvLtAASexzzO/tnJS/zox2ikkjKkgsZ7xW3mimKAVr/7eTwO7fP+E5ufmrBmwT8HUqS9/PA6uq/F2lpQDsRv1gUX7JPhxwnODw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7681.eurprd04.prod.outlook.com (2603:10a6:20b:286::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17; Sat, 4 Nov
 2023 08:37:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 08:37:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 04/12] selftests: mptcp: rm userspace addr with random order
Date: Sat,  4 Nov 2023 16:35:52 +0800
Message-Id: <473d8295b03859398795c0c07e6979cec40b2a83.1699086300.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699086300.git.geliang.tang@suse.com>
References: <cover.1699086300.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: f4f93210-bdfd-46db-8961-08dbdd1145b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P78DEUwRy+JHVHjFgoCZUoM315OTe1e4MOQH3NIdbZOFVba9mKrYafiN0Ds6+7M1euPSMbI4DGNqMNJIHykxW7xAJqFM46DWssMz8Wo0ufqWHyw5iwOi7PKpqfYCEeQWTPNQsJ/vmUnWg/dc93NrT1ydIev5z6N32wrJPqGlppJP6CxZfrYxzsY6vDVwp+oRsaEnMvb35tBc/OJERJCpG9mETGt/PD2b6re7VJ4XiRK6+yq7QHnoZgGTXmpa7zY+c8hfFF+nBqsaaZGQZuZW2ikZDhrWEqOoc2TjHfyPVXbMEp0Cwya7q8V8tnNpm4/ZJ9q5G778Wzp1KsbNwsHsfg6eswBQKzJ98zwrUHA0+nurvK65ytvucLce+vaSjyXCNy8I78elibFlVtSLPrMRGUUvspAsXb9LA2hgJjliqma0O8wy1TIEooVOWyaJj+DIjqaYS3xtnZXbpV3titLB2n1XZJzuEh92kw5O++v7pDgpatBmonBVOHmMcEALPK5ppRPHc0jesMlT6NBepxeqacKuH8xDkBImuYtdWa6hHBRqJcEy+kJryUCI50RwEM/YLbezE5LxLZXaHQvfUMz11h5rpQKuZgqaYX2sh6kneSA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(36756003)(86362001)(2906002)(6506007)(6512007)(6486002)(44832011)(478600001)(41300700001)(6666004)(8676002)(8936002)(26005)(107886003)(83380400001)(2616005)(4326008)(66476007)(66946007)(66556008)(6916009)(38100700002)(316002)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LW+pJYMUKLEYBzwGYqA0y5MV3xb10dQFTjm7bZVeKPcjNggFKw74Uet9HWCZ?=
 =?us-ascii?Q?p/olRoUQ+6Qc9Gey0TbUDjH9QAja/vJKiN5onASeNDDKtL+Aqas0EoM5Q3nW?=
 =?us-ascii?Q?cnqhXot/e5RCFRHcROrRTA8RH58G3DOFlH/EF+AQox+GOEg0oMJMpjVbRoR+?=
 =?us-ascii?Q?xS+gjfhLDOERuHmW5UNSxYRiGYUoZ0H4iLACpYq/N2WsMXpjWf444llGV02N?=
 =?us-ascii?Q?kThrCMzkEchuiFWN1grzPavlfnsG+4MVJrcQKBvOcLW2u7xB5kVEHL38ZC7+?=
 =?us-ascii?Q?U/KGZoRZp8BTsP419CzcvjUbGDpFlfvo9uUXEni5ptih/WK3jdR0Sv2hdk70?=
 =?us-ascii?Q?oiV5/gHJ/Ee3OR+shjQGopfc9+1S3H/z0ja1n8M+nbvihhgybkVecVi0j4QD?=
 =?us-ascii?Q?97CcQvuDFje32DAJtFXdSuOOY8ARzDcTxknrznrq20WQ3Wsgu5Qk8fwtsEne?=
 =?us-ascii?Q?pjZij9jmVEEOuFOk3eWdh0qTG23LntggLcYu9UIe6561cGbJVy0dzklSy0Fy?=
 =?us-ascii?Q?mofTHk8YGwTXZOvP3nnZgT3B6f6qjwLK8WBJTaNoplcx7HJ7arf4y1JmqT9X?=
 =?us-ascii?Q?A+yWUqxFYAYsEUppXlnBjAkXID62Z0yqm2seQj2+Y+0i6SULU17HbaIsFCZZ?=
 =?us-ascii?Q?+mIgKMUdorfr9wfySElFfB9NdTsCigPBP07pkq/l2RBZGlmxnwq6dUtunJtE?=
 =?us-ascii?Q?Zc2ccjdT62GSsw7uEIXniFeJlGc7o0d0qnqQ9Nlg++OOMRmM36dnizWxOjwY?=
 =?us-ascii?Q?5Gz8+5M1O18NNTm+ZhWDEhEKsyfIP+b8tr7/hhaXCaJwzCaVdrApa2o7trre?=
 =?us-ascii?Q?IJcM9ZRJWCGAxUYxaGbuEYdDYNIjCLUhK3bXJhGEHJCHdxzy8yxt22nKiLpl?=
 =?us-ascii?Q?64qUBU1KWtw3ejoDhV34saHl1SFPrYaUoMbuPh+ENVABZESdXUimO6PBzBUC?=
 =?us-ascii?Q?Lf1IYeHjEEpDmSIrqnzHwjEeAHgT8l4n87Eqk6Nc5kQ0dB2/yw7a1ypXkoj6?=
 =?us-ascii?Q?2pgllHeyoRnDTuGq7eF1GmHeSBZMCs2ekkG4D/WmRQ345FI+8JeQMP7uqYfR?=
 =?us-ascii?Q?HOBHIGL0Q4D3xBNE2sE6FVhw6bIYtzoj3Uwgv91EEOEh1YI/t2fqklhJeeiz?=
 =?us-ascii?Q?Ksde97JEGRghj7thVP+1vcFjgKJrU3TSlVQ8TsIq3XRLHAlNuc8lxej4QlKE?=
 =?us-ascii?Q?iJdKkzT+p2IGn5mwXYTDYTFueogNqPqOqZ2+rvCkxU9M+uRG+dkeAygn8Uc1?=
 =?us-ascii?Q?8CGqThbfihbT+Q6/OYh0XDYa/dzVG9JTsht9tbB9d9mOPncwmxBKD1hVPc4S?=
 =?us-ascii?Q?bgV4UouU2YtdaUUxVuCUv/NXqdrCfzQjCeMXdaYDEGqdzoRHQHA24DEUqaf4?=
 =?us-ascii?Q?RKY45t1mtE9+HHBtbO5APy1zJMhVudpOupu/F0rLltWrOmiXsu1iXWoB68dh?=
 =?us-ascii?Q?gbj+tSO4v44piGXkzp1flSXQxVaL30rZQNNfEVK6tMY9RmBgRPoPuo/YQrOu?=
 =?us-ascii?Q?97zgfnUXqkU9JbwEPH2oOnJ+mSeugeuynlWkdybYzGlPAmnO0XQd4xpqXCOB?=
 =?us-ascii?Q?6KJgq4CX/sofaNPrGzW1KZaJtTpz3OPBiSNnfEYtrI502XAKe7Dgk80VDF1k?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f93210-bdfd-46db-8961-08dbdd1145b4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 08:37:25.9682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/1jq2XTpmiLudgJlCE3Z6G0FObTxMUNYxl1qLuLHrCqXYYEoUCpH8uTtCYiNqJp2y8fJWeZVjacucoYnlV6+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7681

Previously, when deleting a userspace address and subflow, it was necessary
to follow the current order of deleting the address and then deleting the
subflow. With this series of changes, addresses and subflows can be deleted
in any order. This patch uses random numbers to add this type of tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b56e141547db..148ff0f57481 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3411,8 +3411,13 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
-		userspace_pm_rm_addr $ns1 10
-		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
+		if [ $((RANDOM%2)) -eq 0 ]; then
+			userspace_pm_rm_addr $ns1 10
+			userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
+		else
+			userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
+			userspace_pm_rm_addr $ns1 10
+		fi
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-- 
2.35.3

