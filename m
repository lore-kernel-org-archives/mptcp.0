Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2042.outbound.protection.outlook.com [40.107.8.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D689E79D8
	for <mptcp@lists.linux.dev>; Mon, 13 Nov 2023 02:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="j7V+s7eX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezWYlEsL48ljt/nDJqx2BgHpKTLXuuE1JOdx1Th0z7WSVt34vRiJRiBa/0HCN0qDQwut+7TVVG/lgqAiICXH8wQ5Vbwj8SEihleozwZTvDpmdn96CVrsf+8b74LuogdE9371sezcOhOEPoUDta4sazR5H7iwplQneRdvV8EH7BimJZmW5Z8SvSRaCkAWhrZvsradbgfIfo57fRiM0mOzoa3Kn1Ffk69AiNdSX0PWymr/KQxFaTDYwAvE1sYaQhoGjYdqz/ZoSEughX5NsFR8fBjSmXj5nopgPAZUEAkEQl8WjtMwpBSrtFSKg/EOKDxkbxYfSAPqClauDmkLNv6mNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOp2TWhtoPPob1E5rhy13X9kUGO29azvPp9LWLnT+zM=;
 b=lUVpDHcD7tpsa7FJq68G/Z0TvxEMkt8A+LHYhw46siKqD3HZuCJgfGGTjRu07J05bVFY/29Nh+CdspIP+IAh9htUKiUL3cdSPcVkbMrETNkkLM6cTSLbhHN+DAtNhAgEyB802RgY3+8i0VJKcBeqtH/Jwzdcj/IJ2Q+2oRjRh3rTQByKPLVIFCVOrgN7km9gXn7yDvn1JGCKHzzZHVqlMJ9c5pEd44CSBL1dp6TBG7tX+dgZegZVnHzwB56fN9PjWlY8sBZ2HZaI5qazzz3TWhvU5s/lLBp/5XhbU+3ZMmnxsLwhVv4J0/s2Yc9kZR8GlsYbdNNsIp9uv1XARGqp3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOp2TWhtoPPob1E5rhy13X9kUGO29azvPp9LWLnT+zM=;
 b=j7V+s7eXm4PJodNOOf2qwaiWZgodcUvhGJWYnLTGz5zullgHmc9YQPrHMOEWXMfXeEr+MquEXc8+abbxxp1NL4fcSziE4L8VNSf4wiVKS04Cb2tX3ZdfGIznB6yqIeubpb8aFPShqe5csjHv3wRG5jKDG1E07wbm8GYJ4Uy/Ke+iVGWONbqu0NddDunOs+LeEljCLtIwv31v6iBfexRyBSIJB+BHTCB4VP4j7gpeNH6JJ2bMxRz3ipyE/Jgp40K8ogEu/NZwlQU35vpTJw+nfLNRQa06VFqjHjzfRlAWrOHrPbbkabq1BGdSXNUVQLrgBbZUGuyreq6zfh1IaHQFUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB10038.eurprd04.prod.outlook.com (2603:10a6:10:4db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.14; Mon, 13 Nov
 2023 02:49:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Mon, 13 Nov 2023
 02:49:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 08/22] selftests: mptcp: add userspace pm subflow flag
Date: Mon, 13 Nov 2023 10:48:52 +0800
Message-Id: <a4bc78babc72e017b5d3fbf956d267c99a1f5a35.1699843617.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699843617.git.geliang.tang@suse.com>
References: <cover.1699843617.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB10038:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a9ea1be-da37-4ca7-fd18-08dbe3f33202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3ksWEaHGpiHzef274pV337oWborPUY8aYN5Q/aMzaQ3xc3oY+ea50glxK4tqKrsmr8Up9h999ULdf9DmQ2D27+cc08kDUMHQKEJUWNQJ5jVADlhF53iLa53a9Qo6UR2miEH0GmrqvKmAEVgEs0rCZyoVm9SCGsRh0lDdvQ+BlGYumfl/P9ctIqoib9kfhwqF7cOQu4q2XOlSguQpG3Vq1MDlM2FcIVV+I/vzb6X+7vxKobAS2lBpdBFsX81mhJ8mK/ZHH1BYDcM2/e7eUOSPmMZpDH3wFnm7iPaKaERNbRfs+5I0XIeTgpN8YCdXP5u1dK90brM1iKjantcEA6yUtn8vMZgBp9U3p7dHS5SX+Ygohy8fiIc5EY6pfDLan6AVex/IqNdEJDNtlvirf/EiEXXuRkcJRb9GqyRdn/D6djQMxqsUFil8eezyO9whSnMcpXpxpHGQZNkD1TtbqiknV9fC9oddRmajyUCIERfNMY4wsfUqicK8EnfaQkbK+Tnih+kxwPcDn8eA1qSV9iboOdcf//9MhFgLcWsqLbCMqXndTdF9aD1INBljT+LTuRzf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2906002)(5660300002)(41300700001)(38100700002)(36756003)(6666004)(86362001)(2616005)(107886003)(478600001)(26005)(6506007)(6512007)(6486002)(4326008)(8676002)(8936002)(44832011)(6916009)(316002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dn+ERAnf45BSKBiJ435GkdWdF4MIHnsOA3SgRvxiTC8Nm+Yj05rvbZp0hbFz?=
 =?us-ascii?Q?ux9mJDH4cHH7ysU+PC0vbfk173MpQm3mqNkSmmcYRyar6GVIDL2zfuQlycuw?=
 =?us-ascii?Q?kQm4CyO/YMLgvhEu+HReoC40Z4FRs1Y5zS5I+l/qzom7/EuKoSWT7wZDUMlP?=
 =?us-ascii?Q?5s7l7dBXDPxiRfqHGcDoMl+DAMSNWTygXNrxwoDJWZUAe+d6lhaUPKM7W0hY?=
 =?us-ascii?Q?DGa87sJev/7dsaHBtFS6VoG5bi0pmonZE1+20MavXcDHO2RpaQaBiauCMxKb?=
 =?us-ascii?Q?7a/ecqX1poyF4WBYsgJnnEXNNzxCDlj0JXmod9tmbfA5y5q1ffmJWUX3KDCX?=
 =?us-ascii?Q?rqDOFIRT4bEgrW1dd7UPCVXD7Etf1Q8UV/o+t/vdM2Wczyi3qqLVT7qA6La3?=
 =?us-ascii?Q?yOluelVeM19fp1O/r/oHmuMfbj5q3rcxLziXrazqyq5HvNnv0nNov+VAAfQc?=
 =?us-ascii?Q?sgoHwLXmCzrqx5OI5ayTIhKAipcNpsWmTPe0J68U8DyuhP+pSEVt6MXCxqvH?=
 =?us-ascii?Q?SQOD6hzb+Pb3OywMdYGh2T0Cu2LlXXQLarRp9rJGpf/EPNVjpmNTPtyrmf16?=
 =?us-ascii?Q?uk4sNG+lrM5hAG/adieNrb2fOz0dvNk8PVwkz294VXifGuyDU8D1ZqAAbknV?=
 =?us-ascii?Q?nE4TxAqzCPcVsruIL4cmwH2xnbquhMtxgSkh0/zxwWrv14mIPadEgbyYS84A?=
 =?us-ascii?Q?7KYluWRFKedfCbqFlwR4v3E4Qa3C7q5d6TGIPyRUjh/NMXMtNffk4mmiVXQV?=
 =?us-ascii?Q?JfTw15p1RiRRaoLRcyQNlmur1+Xq+nNMhEACJe2qpJY829ugfu5Y/uHW6tTC?=
 =?us-ascii?Q?ua09ZasUa66z+C/z9blFECw0tjsL46JQVIsEPeq0V+Me/eijV98+l6yTb3Xq?=
 =?us-ascii?Q?Q2kCnTetgq3y+sVmanAvtgWn7LtsHvy+Gb4VZhrPDa7ParPQeHim+CxsDefZ?=
 =?us-ascii?Q?59FD7gUMRe6sCd0be86t44EWf6OQKE7HSuB5RSXRVLZ67djxH85Bt3fMTWND?=
 =?us-ascii?Q?BAPybSNEYgmkOqfeJtlYvl2XIrd5GikqGyahWCUnDs/Z01pJL0iPtk0E1vbK?=
 =?us-ascii?Q?HYgPLSGl63OJsV5gmaeUHF1L74qyvl9pUCfXeZXaRqc+IwSCOCgNLFI9LxzJ?=
 =?us-ascii?Q?URPpqH+f/BiL/vjh+G2sfvDzaOK38DZk/9+WKvKnDQWs6v9Re8arMnqwOW45?=
 =?us-ascii?Q?Pr/yWDdhicWgqIPEKpbcZGabDmxAhXTR+GLY9qjNNdwNVzKILUUFDUcDu9O8?=
 =?us-ascii?Q?TE7Hs1ZcfDIN5kfPAbZcHt259W3cchd14Lu7wVhE4E/TK76/1xL8G6Smo9+F?=
 =?us-ascii?Q?h2TPVy/O9EfwZM/cZXXP7cy7M1p5r9hbUkSB+uaCfi6OYxMtHrL5nBsUUx8m?=
 =?us-ascii?Q?tBZHB/KpPNM71A50kDGLsIJ/do0llaS5H+o8eSXKzmMI51LxantqzTcacYJI?=
 =?us-ascii?Q?5/be+cP4Vax64xTC5yYjWO9LY90xkeLqgSCKV/5GGTHdQ+23FX8A1P10MPNB?=
 =?us-ascii?Q?1nghH+lPfU60qRrCnFlsSvQwrkXrCB85IScF+E5tHHpuHtJztzJs84iPguSK?=
 =?us-ascii?Q?UBAKlom4G+diCQe5CwwvtzT66IrpyysehXNz56Le?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9ea1be-da37-4ca7-fd18-08dbe3f33202
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 02:49:45.9841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83AKYKvmzGlWlJYcBi0/hXo/3fHE5kJqM5Yq9sfJTTFf8cl1cLqEPCOr3GaJKfAjuASabrjKEmHUh8Nb6ULWTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10038

This patch adds the address flag MPTCP_PM_ADDR_FLAG_SUBFLOW in csf() in
pm_nl_ctl.c when subflow is created by a userspace PM.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 49369c4a5f26..e97856323ec3 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -453,6 +453,7 @@ int csf(int fd, int pm_family, int argc, char *argv[])
 	char data[NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
 		  NLMSG_ALIGN(sizeof(struct genlmsghdr)) +
 		  1024];
+	u_int32_t flags = MPTCP_PM_ADDR_FLAG_SUBFLOW;
 	const char *params[5];
 	struct nlmsghdr *nh;
 	struct rtattr *addr;
@@ -558,6 +559,13 @@ int csf(int fd, int pm_family, int argc, char *argv[])
 			off += NLMSG_ALIGN(rta->rta_len);
 		}
 
+		/* addr flags */
+		rta = (void *)(data + off);
+		rta->rta_type = MPTCP_PM_ADDR_ATTR_FLAGS;
+		rta->rta_len = RTA_LENGTH(4);
+		memcpy(RTA_DATA(rta), &flags, 4);
+		off += NLMSG_ALIGN(rta->rta_len);
+
 		addr->rta_len = off - addr_start;
 	}
 
-- 
2.35.3

