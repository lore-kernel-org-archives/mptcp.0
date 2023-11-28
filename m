Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464E735888
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dNhaC1WZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aE0IlVLkeuFOm48/AsuK0534/x2uESbzQAuf50bmHzF82fjz9dbbfhwlIkMiton0x48cAG8fxKXcLl8B7gwaentkNlQias9TP02lrUkJwoK4sVY7g6iq3BmHpH5bWuQg7CIQygfAkdtul4rT7EkDe9rxMqQXr9JqKpax70/3848X9Pr0JUTNYof8ibNraars9mC97ssdr8cW+MD56aXWn8xlGf/q1YK7vmKktHw2ye9nbaRNOHAVVqCOy/E7TbVx5R3MoN9nJIZnZH6NQEoqCparIJwlo9iNHzgTVjFzHlp2CW5VoVCum3Ur0xBnXDum+vLxrwpb8G2CNtmwGc/z3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOp2TWhtoPPob1E5rhy13X9kUGO29azvPp9LWLnT+zM=;
 b=QlQ/QVoqhRIXdqokrriO91o1x3rkUsfogZNc9MOfGvfWeF4mpWfduY/N5SkSmk3zOdFmLTxzAHSlasUk0tUAON7OG5nOIVjoHz5ENxkKxxqr8JM6UgXDgpHb+f7gBD/xdox5bEXO1Hk8VVBHXNGgKvA19k145tlADX9tXHfg6VCwY8QWg3zopp+729MVWh5KRyeSkrDJqZb06G12vw4wT0N31lbLUScshnQ5gfwt4/llxRz4pGok2zQ7XbgY/cDIQLDyJ2Ei9gFgIBlYTyfI/T33A3wUW8GuXqT+aWxsenlI2KLcGY9un09Kde8Epgs8HIVCEwBlTsXYDn4cDYhHoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOp2TWhtoPPob1E5rhy13X9kUGO29azvPp9LWLnT+zM=;
 b=dNhaC1WZwNHUS+5cWYTxNSr7vpFPUMgAU8BhGYViPg45JH1Qc/dmuPlrCT+Uw/x4KdP+7oyDX3UvkBYQwI6mNzRs72Kj2B7fMjZpjpsDBzIiyX0AFacQmhrcRNOjLXk5ei6WO+4947hwbduck8LrZyF/QenlA0ZfJQMPxz4Bqtxns3bofOQb57VZljD3bmTHtx+UKs0EkDiUiOOQlcXv6MsajhQ0pS06UfiLZu++f4pshPBVpf28oluuZ5GeD0EHzp5AXjAsMWvox+w4TXydg96VmNONQE8W8zq9HLIsmOG7ipTm1OsOxVaOeDMpGXtj7P7UltKpE3Sdba88XodYcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7001.eurprd04.prod.outlook.com (2603:10a6:10:11f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Tue, 28 Nov
 2023 14:22:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:22:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 08/32] selftests: mptcp: add userspace pm subflow flag
Date: Tue, 28 Nov 2023 22:22:01 +0800
Message-Id: <771f20d661d95b6b2da50dacb2db03f14e74bf62.1701180969.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180969.git.geliang.tang@suse.com>
References: <cover.1701180969.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0182.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: ad0aaa64-b788-4af4-0f01-08dbf01d7d79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5CxZQW99T08u2yCG2U73abT1B+e6Lk7oKVUWUPs0/4gT1gnBXy+Rn1AOvCRh8pk9HzDGRgKPSFvtSoCT61mON/MCzfjEHcmWOZxJ8OYDSUXwK6F0wAqR+Lpl4VgfDa+i2Lpz0odzqCT0r3Vcd8KdAvFki1hMtJGzWskxm28vGQwIDVobm6f9oqyihsvkW2tvGiJrQ/APDPYzAKQkLdeCBHSXmKJ4I8WUA/eHcZ3fhvx1XYY+qzGqlNH3+QYqSobRQ6C4o7Lalh86zgEh0c+P8Evj8X5RfJy4RW9cR599WgInPsrlUvhAsCazpMTtMfjayO8YFvkR9A0x+c4bl99wL5mtTfDWoNCCO2x0b6ssBIGUF+bnuCvQZo5ZiP22qQdRDDkGloHt4iEwjfg22auGOukqHVaI4pRysql1XVmhN5NElYxPHmv2lU2ziCsc0e+rhPA6eNKG3fXVFyIOcylt5oU78ZcnaajGMnO6pKlwV6h5cVGDGHd6w2erfcS+rTkXy8DfAguvWNnmZLMamOWjJ9QIY/Uf4XXzs2fDnUkxDjdmdUv97MFvrGG/9zOwhU/v
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(2906002)(36756003)(5660300002)(86362001)(26005)(6666004)(6512007)(107886003)(2616005)(6506007)(38100700002)(478600001)(6486002)(44832011)(66946007)(66476007)(4326008)(8676002)(8936002)(6916009)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DzNI9KX+jkijNMm+0MEeD1FGBFkKPhk9XaJeCTJd9ldFpQDidumPkop2B7kp?=
 =?us-ascii?Q?fDIPhrmsrQj6illOds+auptAXizvfCvGPEuSiR0uIeAwA7myGKBhmV0KWfWx?=
 =?us-ascii?Q?K7lUksZVvIC4YOT3wmHs2shlSR+5sCFczspsrHvLtSO4gUafRpTJB/5MSbIA?=
 =?us-ascii?Q?RylbnDArm0+n4WbbKeQgPeGlBhp1F6Mz9k5SlM81RH858gfCVgaR5GFSUOOo?=
 =?us-ascii?Q?EBALJXfHhWGxvG0CA1bwjtNHyOU7yE4c6sowG55vaJeY7wgjmmqWur9jqFln?=
 =?us-ascii?Q?PWokUDZKgdknCUohWLxkSDrzAY1vmK5wGvwOWBsyJED6wMGqrtE8vHXoi6NB?=
 =?us-ascii?Q?8Fx2qHARNNX4s6RnctHXSMXLk1KuL02ZNIOoGwAIB+XxQoEKrLIPig/somPI?=
 =?us-ascii?Q?7VtvT0MKxtrjf0OeRxoHVNX88fET8rjmOlciHfP3d8RXggsBtFuPVkU+Exc0?=
 =?us-ascii?Q?mnix+fkcTo3+PUaTtUUAB3vb1Lgx+Gz88rhOPp1Tx2Ww1HHWCuej7pFwQPo0?=
 =?us-ascii?Q?bX7ZA28phJQ9E+411S3q8sWr+b/tJddIQ5mrscHGibex6tz6uGYexYwj72wG?=
 =?us-ascii?Q?kyFNj9UqXtyK/OX8H1eKGS7usCJ/ROnDWWeEdfJfsijfOVfeKwIyfc0kx3Ka?=
 =?us-ascii?Q?Hk/28Q1sYQkm2swS+yF5f5Aw8e9DX/cuxtIet+gBPUgrz77DequNBsMkD9JA?=
 =?us-ascii?Q?fSgTSoPJ/uz2YyMosmrCnVTNsVCppXXz8Zt6d5KD83pZ3RkroKtplhAHuMVO?=
 =?us-ascii?Q?ixdELUSMalKhAN8zgBNQcFbZCReYw70Y5afg6Z4gGvkGs1duDOmwU6umi9/9?=
 =?us-ascii?Q?AfsUqhCN3/ciRWD1j+gnEnuayKcra9OcMljxSC7+gF4XNNh7URCC1s0Pr+3e?=
 =?us-ascii?Q?1RMaTzzhoLMb24wkxM3cMQBtRp3Kkkm0xgdJ2zBJCAYXaPlCEPxuz/s8AsbL?=
 =?us-ascii?Q?wwACN0031GPKcLDfaCjEoJI3///96h8iA5pmzvtwJNz4S5xM85smjdeq2TX2?=
 =?us-ascii?Q?E7gdETxwLTqtTl+9eSzo12NX/nM8IT38wD4YRsPw8G7+7+F/Tfsnep1Z/Mok?=
 =?us-ascii?Q?VFfLMl9ldIeXGMR9pV2NFtGDhC97AN8g53MJ18l+qqoE8/hhYRMyr3OA6V1y?=
 =?us-ascii?Q?JIWj1pf7VR1f8yJeBpqcK+wFlznhJ8DVDlothcP1KkV23Kwl1p36yEpv7mMB?=
 =?us-ascii?Q?3eUlVlv+5cU/Un4c3pUxGdX7pPXRvgYR2Avgljujv65hor9BvZRgIVyuMqtU?=
 =?us-ascii?Q?uo6V9UstZfiR0LYRIdn/lAzjG6NZz6VPu0oEbsUmREoXpX56p8X86FGt8Wx9?=
 =?us-ascii?Q?fiGZ22W+jzfyXC7+O3HJIJmi9RGxF+bFyGm0RD4eVS5Ft9yRZzmFR/aqmasG?=
 =?us-ascii?Q?Xb5TWp3ycKnrT0oVb5TkWeImgBzTdUPaWOmQSqXoQU473e3R148BKlSJOBDR?=
 =?us-ascii?Q?pAdH6HoGRtAwnxPMcStMcdOTyg8YOQe0uStLkkBJcRXf9RIX3U6R6qFiU3wP?=
 =?us-ascii?Q?DyWCC43XtkC92Ffy3KUONVyBhJnkP2fTgSdgbvZ9mNG5f0Q/77iX7Raoxgv7?=
 =?us-ascii?Q?/eWMTR8asUG/9aZqCHGglyEua7Axe/bMRA3yUv4G?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0aaa64-b788-4af4-0f01-08dbf01d7d79
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:22:45.5855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CEOKlVLgPpSVEGd35my8yUEmCal9cU/7EuPjUezX/B4bCpv0l+WJ9I/O7P4FHwlMqlfWVIJw9c+SfC67MSjCuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7001

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

