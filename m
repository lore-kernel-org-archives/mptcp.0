Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2077.outbound.protection.outlook.com [40.107.15.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CF4DDC5
	for <mptcp@lists.linux.dev>; Fri, 17 Nov 2023 08:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="5B1YUMLn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYHzPFArr7R2lXxLsz3bFWDaPxntMzC3dPBkmXjnoAryjoQwUuqe+bqT3TGjWG9N4/tNfUxEsvJgIEnQ9diJKOpEJL5TGYLlECC3T8puzhqgK650T2QegoKqGpvTGlYLFvj3j0heBjGlc41QWmjS5AJZPlAUwvNPqSA2UI+6ITYfEWFEh7olLDEC/T39yagE6keA2S4eeK8+w9znBBR6TGpw9zehy5CXmsLxCjrwY7B7HaaLa2ZVLVIE7qB6WWxv8Ph/OBflQh5Cl7IyLlvXgxjNWyrtDHtfNwAo2+KTDQ7Dcs5Yl9yey8JAUu3oB5unPSNpsxCB3g7WNILW7OXZMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dph7slE2gv8EAzbuXoW1AIj1s2dm2ND+F4+zezBtKwE=;
 b=DBY4LgoR+lW2/I4la7ctXZpxO33KuPq4Zokd0CYtIFELrB8sYXO5EppnQnOm+xwT+kBob+O8ta6UVSn9zSvsBV8YgSupyxQx6GdELAIPNcp5hLtHjSY55iEClfsGQpT+YtY3dsGqZihfUVs1IlYaPdCmjZ8Rw5JMhXlg6kFOjW0PFDHU4NFM2QbipkL/TAwlt+c4MkZCC53CHRRNHixQ9yaQx0MWb56ly/YPlzhrSvc5ZtyaEcVr1M6tof0BChMyz1+YdmBQf9XYEsS/1B4L65b8yM4cg7OEKlYY9PAXDsOLDRwuctB5Q8QBiSikqcbB0cT3WoSwJisRTAVGCQuJCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dph7slE2gv8EAzbuXoW1AIj1s2dm2ND+F4+zezBtKwE=;
 b=5B1YUMLnpXaIp8hRZWjWgwzQ+7oT/vmqRAN8ln9GT5++DClKV2DK7DvrzxrnJ6xDAy+m9WAU9e84xQmm8sR6Mjv20iDgXEaPkDSXUhqunXZEKR0GJvqdriMUyNEojfd9Da7ow6LoI0NsoUw9KJNktAwWb8G6QAWjD/43IMJOfwluVzOMQ/M7PLWpDqPVcaUFmblw0OI4Kx2c+4+GCbwlJg1MBr9kJTqIR0x5I6hMLr1/tdWDmWHF1n3Em3FnRQMUD4vQCdoizHjpbaB9LeoKVQs+3U++twtgGZ91zLINZB9fQgGLrjElyqKbxKwG82X4Y14I4CJBLNci/IpcOCu4/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7271.eurprd04.prod.outlook.com (2603:10a6:10:1a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.8; Fri, 17 Nov
 2023 08:56:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Fri, 17 Nov 2023
 08:56:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 07/26] mptcp: check userspace pm subflow flag
Date: Fri, 17 Nov 2023 16:56:00 +0800
Message-Id: <f1930e651bf4d94c0312959e5be1db402952e37d.1700210966.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700210966.git.geliang.tang@suse.com>
References: <cover.1700210966.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0312.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBAPR04MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f6c6db9-9c16-4374-db37-08dbe74b2808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ayGWXXwXNMblnclAefiug0G5MtCuU6yPhqB9VoKSLm77aNexQI6ePuhdVnMGHhdo6GlljT8egF8KvogIHT3RuUSbWFIO6p4iEuv0IBDhOryHUToo0LwIRaEgzH/LsbkNL5s5NnSyzHBMBS+hmqifjEbTJ+ePzrfHPzhHwbtlTMOPJ5UxTlKa8kHUFpMK0xMhTQHTAaSGSMfbOYgsGFR+MEnJYl8G9jzoC6HZcYBZbPCo7exu3dNHJ1keRdg5rNSZZi/8k8kO+TjOxRVEEosnIw2bZDmbcKvyyEbxQRDraCPAblH5kV2ZFwNi/9LXeXqpbUZTSytoOXOQ1e5tVtYnrPDQDurW2Dl3uqB2Xize/Ny3zT1nXZiLG+jQZ7+yAQ+h0V93WTX8a5V9fiPQsPRapibbdRVaNcSGaBmAS5qQGLUG7euwsvEiswGED2jRpgdeUzNF18lSNsJQX8ti+qMtSvdR1cFxo8kfsrtMYqHFrpyg0o5MX6/6/9nYn2CRMCq0qgk7o3cacWu61gDR0vZqRy8llbVYMt0eSFu7bqKCZLG48idbbKS0lxiaE3twOZ/2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(86362001)(38100700002)(36756003)(66946007)(66556008)(66476007)(6916009)(316002)(26005)(107886003)(2616005)(6512007)(6486002)(478600001)(6506007)(6666004)(5660300002)(44832011)(2906002)(8676002)(4326008)(8936002)(41300700001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fuyPbOvMyYMKdtU6ZU+V+U5vmfNCPQmhT86+8p3LCUwnHnnM+Gy4jsGQhi2y?=
 =?us-ascii?Q?mbYZj8PYMOPbZVgI/sR/I9uEjDM0wxs9GMwIdmNS45PBQfguAm8kWHGv0Bhy?=
 =?us-ascii?Q?/qwm2q7+Sv//rQlXIKaLHEQggdBN+aNbGBjwxIraJaDYBThXS+4IexRMeUgu?=
 =?us-ascii?Q?0gviOXubVqu3ie2bs2SM02t1tnm077QTpqwte7frhCbwSdK+BMi7ivrATlam?=
 =?us-ascii?Q?lw351vggfA4N3RqhFu0f/KHcbp4/pBYBVCnag0MwVV1zEKDk+/Twti3LmFLh?=
 =?us-ascii?Q?C5cz8W8oMcLCz/IMT+U7LRxOcedRfP/CoEgJC1wDHs3RjHsPWxJ7MNvqbLvw?=
 =?us-ascii?Q?zzR/TpEXzxT8YNVLuYTMkD0rPxg4gcFSEgfp3PDhWrYApHnDE3Qrb57nUdqV?=
 =?us-ascii?Q?9LsVtsiVF6p4ldOU5qonmCX0xBR6E7Zyz3H6QggscR0R44BBRzJ8iqQvTmNf?=
 =?us-ascii?Q?/pgezA9epT/vNVgwOC+qEyBekEQOPtSiYD+BW7ysE+B1awFRXCUv4TvrD6fS?=
 =?us-ascii?Q?VbvETaTkDQg/GNXDKrxJTGXLVMMvhaxMFI3iYgvwhcpili9Tst41Zb/xNjCP?=
 =?us-ascii?Q?NqA+UxHPJ6BcYzBOGCh8DREb2XHBG0xlVgVXa4AUmBLpUVAq20+r/gf/99o8?=
 =?us-ascii?Q?heN0pMmHbuhQJUqOjCc8V5+Xh7lATvX7B80NZuP3ntYczBHxRQPIhMZKZaKP?=
 =?us-ascii?Q?iHnNw49KRxraKzhy+Y0QH4eAzPdt41cBZl+yPnjYre+JSUogPwKD7k/ZkIwM?=
 =?us-ascii?Q?mRiRfuyHJJuUzG5z6kZiG3WmnL8ayQN4DaDytYlYIG9sBe+TIokcaULfulde?=
 =?us-ascii?Q?mvmQeGLAFg+QM2kEuRvEKm11HC12e4u71mDMogOYf4Q8rUcJBJlTxNA/F19l?=
 =?us-ascii?Q?VHkD6uaWY9YGlXZwpfiCyUnMOC2DMD+FtsOMHxgTkso87ISnU/c29w03u0XJ?=
 =?us-ascii?Q?KaCBkJ1uDWg1WCEdj+3B8agH4w6/lHYlaf2Wh1IDTD4GTJZbpOozl0nWdNuS?=
 =?us-ascii?Q?W9MiWhAzUlwzshrhfc7kXQxXWxNwbX7W3az/jIpchr5t70AQx9aP41KbY+J2?=
 =?us-ascii?Q?0jXZUkSNPJEnSTFNevAIXYLT4rCZOgJ112+98PLaqgUqb8neh+a49xP8jtsp?=
 =?us-ascii?Q?VLcpYlrJP0AHnzw6PXVO5TNuRRr+CPdSC99Nu/Bf36d2MBuA+KOipQvthW51?=
 =?us-ascii?Q?iJqfqJPFaW7JazFd0YD1G71EIC0B22SsgBl7S2UnmuVgMEOiPEoRjfQk28m7?=
 =?us-ascii?Q?8y/y3+6DWzsMerrhtCGXAkGIkn8hLqUhukGH9HpFz9PWSSjbIqJYQNCGPx3v?=
 =?us-ascii?Q?Zw/9dQJzyIu1WRyZWJzzo66Yn2cZHLS3y7P4Bbwmvlc7buHZNwJvxyCRX9Ar?=
 =?us-ascii?Q?pK5bAmdOfYtf0qrJwZbfBDWUUuAO8OahRE6FYUdOZOGd7dWDnrYPN1RHr4+l?=
 =?us-ascii?Q?sPWaFSIe0SbQAGjOtGAMYYNFZAMaJlGggqRTjs8Fb8Dq2zrpEwSqGGv8i7At?=
 =?us-ascii?Q?6QTU7jshFb9MtVl9FQYYZ4uNMISVfZLqHCwN9zFwIO+Wk8Ct/4P9Y1nP6q4X?=
 =?us-ascii?Q?KBS+kliDtpFVUHRpMebA0zBqQ2ytLs3Vt+VZU6EOUH7JAPTFI4GbJCMBDQ9e?=
 =?us-ascii?Q?dA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6c6db9-9c16-4374-db37-08dbe74b2808
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 08:56:59.5114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 45+8bqNt0j+Xo/XLE9ulk70A4xMEW+qHfIDQCi0JZA0InTu+B0R9c8Pxuh32KF8bvqo/VQzHI/Xnt25KEotDHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7271

This patch uses mptcp_pm_parse_entry() instead of mptcp_pm_parse_addr()
to get the flags of the entry. Add MPTCP_PM_ADDR_FLAG_SUBFLOW flag check
in mptcp_pm_nl_subflow_create_doit().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 5e45e36ce1d3..de10be21bf26 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -347,12 +347,19 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	err = mptcp_pm_parse_addr(laddr, info, &addr_l);
+	err = mptcp_pm_parse_entry(laddr, info, true, &local);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
 		goto create_err;
 	}
 
+	if (!(local.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)) {
+		GENL_SET_ERR_MSG(info, "invalid addr flags");
+		err = -EINVAL;
+		goto create_err;
+	}
+	addr_l = local.addr;
+
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
@@ -365,7 +372,6 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	local.addr = addr_l;
 	err = mptcp_userspace_pm_append_new_local_addr(msk, &local);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
-- 
2.35.3

