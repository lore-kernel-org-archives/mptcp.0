Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2070.outbound.protection.outlook.com [40.107.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D301FBA
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 06:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="uwqy3TMN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXTdxomhZ9rT+LN8Yzg91IPqCFgkPqjrLHGTIeAkKImAabiqnnT6Lch7R8JBZpnpqOJ1xBKyKj7DIPw+k22ADVRDpY+dyzquiWuGAkNiOsVHDg2nZ2IhjGMhxExaPP7FUso+qracys4cRmXfzTQ08bmEDjZn2qdRitH5OQ0OfQjJIgHHKEu2abIe3PP112JaogHzXffWvycKIPMpuEBAvqInYmCOIQ3Xo6J/LkZEr0XnZq4lH/tAxHDGAdwCtO9WIztZJwCBwRCfIbj/83fJzL1EUmc85b9Tkx/NYoMlMq8wPtP9IYj5u7Paky7mXPGa2l+HWP3aNISBTlwfIEdcFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5O43D9ijb9BIKPHzYDtIYZdhGtMjEN+dhlKgpEMYVs=;
 b=mS+fZLmRceQ63sHeC5r1yMdqZb2zL2w2Pxl2GeP3dzaxVa9kbB3pGyMgHETFFVXM3QrZTusKdBQcCGcq+lOv6wyKGQueEmGK2Uz09/iN0w3Bwr3G7qD8ub6VbezOmGGmEADU8qFI+KzUYhYR1TazdPnoCZjAwAhPc7CBtGJZPLLuV7F7UuvngHyj9G5sUssjVJYlOU7ZpdDTzG4uFv288LG7+BmDmWm6Brc+Zqx5Mj204nPmVTToKjwalM8eCPJzAahaz/h3sO86z2ib5Qc1Kzb8GWpTIvspVXd6Y4B4YRtIh1KbmJS91bnZNmpufwRw24GrdCH4pJntTfd/fEgdNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5O43D9ijb9BIKPHzYDtIYZdhGtMjEN+dhlKgpEMYVs=;
 b=uwqy3TMNG4NqkfKvdpSrqCJKDe94eDGaBGXiKtOJmR2I87PSAEmRxpyJAUFzR4qkEHmAQmll7TESOZHZIw97v+KlyEQIes86Li7g/jw1aCnbVLiqk/u0NnUkCExZSKnvDCcTU/lBE9AEKvmH5fsHp3if63tI7VcCFZnHDOjfNb09tMHXl/INxe8RGG3g+2h3hIJmG7hoqU2TBgzEIdemTO2fC1oYPxcDbpGLRwP5kdRh/5LjkENhdcEPehxzXPV4wK3PSj/ZPcVhcfjZ25/0a/oTxszOHSyGjXFnu6KwnseLYZtKzgaVJn4zX0xoqDke7H6yZ87YCfOSGoRFx6l4cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8803.eurprd04.prod.outlook.com (2603:10a6:20b:42e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 06:50:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 06:50:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 08/22] selftests: mptcp: add userspace pm subflow flag
Date: Wed,  8 Nov 2023 14:49:38 +0800
Message-Id: <58b2e7f0dcf3d8f34c972a3beb3538569fef9bcd.1699425895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699425895.git.geliang.tang@suse.com>
References: <cover.1699425895.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: 922e1ee2-2329-4f22-68f0-08dbe027072a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JEecvCZ6VYQp+/SeeoJX86eUpHqRtjSH5RTANq2qg929+qYCjL4ex7IyyhB3TZ4OiM3ESS+NFJ5oAHfLijRYdcchvgHN4HUPAnKHjYoLaqy4pNDJQMKRfpzpGG3zt12FY/ee0d9xIuq8uwmpWOphSARIo54nwB3+cREorW1sKdkBlgaRNSr+OYaBjfswPsdocIwr3w0EOFphweRLvJ2fmgY2lOlDStumzZsjyRc0mEUcUf3LPGXOk2BAzB97BeQFz4yD9O+800/64//vFONLO2VlBb5kep3DjM4k+k8fk8lACy+B4buvLTCaq3wnKb+cZil/KksDLR2iLSPApj9ifEkkzA1wMX+ii4BTHEgFRikbwGPvV0sziUEUqoVohve9X+oUcv6NJAPaEkoUwZUToh3SJJEr9OiZJJA6plANgnh+JzeDqCuH/v4GW07Y28LZ+19+bWqHE4fGVZlpC0TXWOELgsaP9DfjgQwlQz1psUKICB2r+fYUul94BpiBqBgs3p2FObyMPeyh4JdZglByGLG+6D1HALLb9f0rNB0w9XyisMMOgfkg75iXYoUyuCrYjCKNzYRhkhu1jnMDJ9hJNqKwNvoaAfithst4SzIIcDM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(6666004)(6512007)(6506007)(478600001)(6486002)(107886003)(2616005)(26005)(86362001)(36756003)(8936002)(44832011)(4326008)(8676002)(2906002)(41300700001)(5660300002)(316002)(6916009)(66476007)(66946007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Sx8btLoD6e7OXErNJW1EE2fZa/k4EsBpCLzFRcqjSm2rr3NM/bC5JdFDi4S?=
 =?us-ascii?Q?fwCHGZI73el5oYeG3EsFtlmdPa9nahPrqdmbzH/VJLWZZ5GOCndmQBENZ586?=
 =?us-ascii?Q?feKg7qjAQq+BruWI25xfZf5+K4ubzzwUqP6THR70Zc165fcvhBRVYsKIK+/F?=
 =?us-ascii?Q?CU8Q/uOjHdxOMcskBpQeHaNkwbICyLIz+43arOGoDPlK7irmssnrsDZxgrrL?=
 =?us-ascii?Q?DrdIhgcUnlPsrFsLYia84xQCDPOchyYigTpQtu0hg1Pw//uCsOp/gllzmgP0?=
 =?us-ascii?Q?sTqAH0BLfUmzVdzMgn7V5gFpOqJZhr2wgQHO8cLqGEcCA/xtmokxqd/I2pY3?=
 =?us-ascii?Q?+5TYw8yIeKz2cgqZQVXdH/1UJXpoGVnFmL4+skzb+BunqCbmqmdODZATCT0A?=
 =?us-ascii?Q?ufywm/pv3H0mEyDERDfakcYwksbwUyUdVqkgWlFWyDMAgMyVNlGKrKDy+u98?=
 =?us-ascii?Q?ypQ5dxU00VEVJ4sYbWjgUY8ah/0JwFSb/6buUNO8chx/bqayK9klg7F6Kk6Q?=
 =?us-ascii?Q?LUKdNoFcpGGfbX/ks2H9w6YMYnia/Ly3hKCtAwHseMMdjOAAimLQfE+uADx3?=
 =?us-ascii?Q?Cej1lbteMRpRMGKcjOp9idPMDsVoLESPAaXC4OUnNLD1LPuAela7Sc25vhh+?=
 =?us-ascii?Q?SG9TDfNSQ+qqMpty2eksrzcQcva9appFbFih1WAc80yfzlS9k480IevvT6Ri?=
 =?us-ascii?Q?rIUdkYtcDsYXPF+OlNLQWlS5xa/0hdNU+MkpvUb535CyI8S5JiH3+4O7l1+P?=
 =?us-ascii?Q?i7yZTaCCu4DEhDIR18WG3Q9Z+uAtRRoBa8XP9jAevnP8xIBSSMTA1KtSsty5?=
 =?us-ascii?Q?qogb8Jyie07AVAibSNSuXS9/n0YrYf62TLPpNUQ0VXY5MGq9C1rxk3WQQUS6?=
 =?us-ascii?Q?IIj5zvJScGSiyYIxdqTWAAuOasHwFqOtdCNr++jNpgclpTPcdhgxOvul8x+R?=
 =?us-ascii?Q?vVp2/C+iBFplKe24+KDpmwljNBDgWANQ/Alcb0RHt3KdEJN8gFyWT+83nz/0?=
 =?us-ascii?Q?jfh2K704V6YXgdXUOFC4VcuMi+xkbTEwfQ3h0uiYJOnS8N08M6uzbNmuM23b?=
 =?us-ascii?Q?EfHszhp2N3z6WgPRen90tNL+0gVCnQ2hOt78CQnJo3oTgN/9yAnflQsCEUuX?=
 =?us-ascii?Q?c+fXNoh6KXmuI0I2agWUmD5SzvGzXiR6tNYyzLR2oCuwgD66XQh7IIs2pUtA?=
 =?us-ascii?Q?x/bIorxcMyLwKE7OGA1ISsS6sWmXJeKXR6qvj05Wl7mahhKPOh3rHSJrb9X9?=
 =?us-ascii?Q?tT8+6sbPt+BQ2sgaXYeBwh7YmLVU2YjaWtF5ZP3G84ky6EgOjoCrFbejlZw3?=
 =?us-ascii?Q?zN631r5l74spl85+3wUB4BDLRYEuLTPw39D/wHPTT5OcOjTe9Dozo4nJHos9?=
 =?us-ascii?Q?yVLEb2ruH7iBuw0jyXPlDQ38v1th24yrkvQqBp/Lkhea0drHf/3oZfNfHqE2?=
 =?us-ascii?Q?WfJU31nH2MWhnoyEXTOAmZEtM5kkAecJu5mWUQiEm9iAU2ry7Zhmmbnfs862?=
 =?us-ascii?Q?7n+dCitCgZmZqByicHMzNWjtZ95n5vMYJ1eggC/vxpeKcX8xp3LpoPE7g7ue?=
 =?us-ascii?Q?NTyBuHRbCF/YR52d8r8NTjWBoJUyfSgBZzOb6KmvMEYDNX7CTKIKzTTzvAFP?=
 =?us-ascii?Q?FA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 922e1ee2-2329-4f22-68f0-08dbe027072a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 06:50:43.2990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZKOe63KDRTZ4WKdL1XBXQoo6TY1OYa9OyNGAfQj/98Si6Rv8fuDezzdL2uxma81VUdEudzkt0upt6z1HUnFT2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8803

This patch adds the address flag MPTCP_PM_ADDR_FLAG_SUBFLOW in csf()
when subflow is created by a userspace PM.

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

