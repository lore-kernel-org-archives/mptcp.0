Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2087.outbound.protection.outlook.com [40.107.249.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A41B10A2E
	for <mptcp@lists.linux.dev>; Sat, 18 Nov 2023 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Dt6RUB2k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bq4UVnOxri6wlPCLyNRp2d5p0xj7DxW+k2Mab0nvPJH0oXUyWiVtaHhwG9dAiniInQLp809OzixUoV7d7OaGgVioeUynk9B9/sRTL47aXhIgLClB2zk4i4xn8qEB8gwqbQHmbyuPO0oAZIXnSyrWS3/efr6fePfm+UtSNrRXAthP/lvR11k8tHQ0825ozPfRNIo+ng2nK9qrQAzE+ysMmH83ihs919LurYPVuHClZ2wykrNDrdWaA2MuD8DPWSJRdOX0Ed/sz5O9VARqBr9F9ub1PFSXp8C11HPsmg1o4uALWaNR6Vm022l5W2EK7sQJ3kYQ67C+cIMYxKJ9YUElwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dph7slE2gv8EAzbuXoW1AIj1s2dm2ND+F4+zezBtKwE=;
 b=AsxWy6pTYN0QUDJ+5u9sSMM2Sjw1gN95BZm+0v+dQB1hvAyvmdl5VxnKBfv6d/ghzGUTsO0j0ZJIiIFYufMvKiFP70c6VUiVi9XuwPsJFxY4rHW3IN0FTd7bfu7HWDoTqQDrjNMaU+sTcVglNSkjnEucj1PmhwyvIqOmWHTONkrCPCoaK0EM36W2GjzhN4L+KJVK8/S6Z+3WcvQr9vey116jDSFXXJhr4I4D0LP4EjHju5b+xseLQfEo5lCYX27Sn5/3UP+H0zLykP0d1pOx7JCPvQMLQHo79CqiebGnLuUELyyuoS0KAForvJ+BKXE1oGC7kroWrq2pSpG0leJJsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dph7slE2gv8EAzbuXoW1AIj1s2dm2ND+F4+zezBtKwE=;
 b=Dt6RUB2kEQBrtLiXjurIOp/A/iUuATioZuz++JfgMu7I1yppdU5xibxg+xL1YIz0JbOsMS1gOa4zjkP/8znUEikE6wPiYI6L0h7C1bwnbcsUQrREDiJi4krSlphV/Q0kwHUPJruAEmmKRH7njlm5hhsHmXUQdAULk7ILIGtWIshPJdx5ydDvBmFX4r0c/bRtHkE/FFCBtM4ZiE9gv9tgGKDTk4uPr/KPgpdtBp5+bdKybSuRkraTU7eW0FRN0OLYXdcByYO8kukb4/NWDEYm03msth/gVHCwIeTf30Dsz1I7mJkNaRbWdtkfH232VX3BDgEKRz1On6fU3pYoVC6sxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6869.eurprd04.prod.outlook.com (2603:10a6:20b:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.13; Sat, 18 Nov
 2023 14:29:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Sat, 18 Nov 2023
 14:29:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 07/27] mptcp: check userspace pm subflow flag
Date: Sat, 18 Nov 2023 22:28:22 +0800
Message-Id: <9d73256eca0811d0104a92c3f8a1b751c31e4c2e.1700312872.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700312872.git.geliang.tang@suse.com>
References: <cover.1700312872.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0138.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e8abc75-fda6-411f-a8fd-08dbe842cc50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vo98EXxDb5Kg2cJs+I1jGr6njd3awDhT5UATnhndXr4jEbKeIfthC20dbvfJXw45T3KXiPaD2Y+9yuiyD6RNRn17v9fHodeVVKH/kf2DASSApkPZ8KB9wDrW+BGLrXNGcpHFTyXCtlhGPv5ZTyTNWxKbI5VLymtYgjRac2N6Nea95z8SMMB7FmE67YHGlotNwLmLYEgH4/vmcgWV7Ff+PtqUWSx7cmwKm22e0A8YmHHhGhY8rUBgAJtC+h9xiRF0Q9wc96t+sUWTqHEN/MHHw9VBmKk1GNw9sS+8PDTIdWBHziEXqBjsE7SrGaouBUnq/7cQiOVrWidBMnh4NYUyg0EGyG1SkWk1d5y32Jugsd4VLSBdlSP77bno5Bv77DJ6qGyKNPMYoXQhcglWvrANQT7H0ocTOE3DJczElxqdPCw3Y0+EkMFQIvVtijgeX3wHhlKqLxt/O7PwFTis4uUXg3vEA9X65dTsjntn9dgY/2FJcxGGBPdqZr213d1zzGIScbnYXeDku7RIJQmetTkULnPoGIJZ1G48XoFAnEYfbeXkFbLQ/VHcBuWHnHnvRRImDH5D3IYM2DcUBpTtnnD0nnA1CD8o8iYXbrxBD2Z+2Ek=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(316002)(4326008)(8676002)(8936002)(66556008)(44832011)(66476007)(66946007)(6916009)(5660300002)(6486002)(478600001)(83380400001)(86362001)(2906002)(6506007)(41300700001)(26005)(107886003)(2616005)(6512007)(36756003)(38100700002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rSSg6rgYv2ieX3h1yWZ33UaCQqoNpfIW6zY5NOot8aCdJUQaKxPFY5E7tCyj?=
 =?us-ascii?Q?8YM5vl4WwhsNwjhHUWq5vGUvtQ8IK9cFlfArIhOTM2c2puF5TpT6bQHJmcZF?=
 =?us-ascii?Q?CH2WZ+/Zot93ZKKEAyUC/AXp/BoXdbHcAh5R6RnXuox60tVQ2rwHh5EgxAi1?=
 =?us-ascii?Q?SuPnIYC85PwfzJlRcrup3L8mzEe1svzznGHAudfUNVHK+LDUd3wnAVOYg4mQ?=
 =?us-ascii?Q?sPEgUN9IaGFj92vwNfnLTJXyNGBJhLAxYFOu+vuAEPiYDZf4WlwGrqcI5rxx?=
 =?us-ascii?Q?oykWBGKM1kVq+S6bTeZe1cWdwGIGoLP7p5LrR/yLngfJqSb+r9g0YZOIT2v8?=
 =?us-ascii?Q?9QIWpwT2YASJsG02rGw67FaAG0OFDwgHWf45I7wMg941sxyUis2WINS0dbif?=
 =?us-ascii?Q?cKoM9n2YL3egmKr9gIkj6hoQCMirfHW4+8KbgnSZWRsCwtKnlemFhfx1OkDN?=
 =?us-ascii?Q?08bK0rzP+vDGNEcXN4GLHKfNYr+95WV1NXUPlT9D0EnHh67mNKuEpMxpdNzI?=
 =?us-ascii?Q?+OZcicqrZGvq2qPQ6Vkj6A6XyPQpjuWSLbo6e2wDkTqFfQLCf8l1dMv9V37w?=
 =?us-ascii?Q?Etpks5/pWQUn7rUy114DPkdUOvRWY1Gzc6EWOPh9BQ/IW1Zg5a78CgBRc9ri?=
 =?us-ascii?Q?ElwXyab2uj4+dh4dFL6NfvRth4aHhzykEYs7CIcqjyEQhjdLgDTJUq2Sna6U?=
 =?us-ascii?Q?VHKBKKWRQ/YNcN+szXodZs5bYDj/nOso0rbupl9CXzm4wE5OlQ08jR0SDh8y?=
 =?us-ascii?Q?DMFySBelYzOEiZHqJW//Fkdsn1BWYTK0QIt1AeTa8np80e2ifOxzC//lBn/v?=
 =?us-ascii?Q?OEQIUWdeRpi+OmUXVSB/t1428hezEOH4Ay6oTGQapLGV3rHvkfnyDnQsDmd2?=
 =?us-ascii?Q?ulOAmomDiEes5kDZZFDfb4k4GTe5Gwp1qFLeOmcXIWF5Dm2Cg7ps4ZkO4SyB?=
 =?us-ascii?Q?C81KAnkrvQFiFFDZStUvuVF8InkZtq89ETwV+EcA7OIm+PmrgCDnXlhVok2k?=
 =?us-ascii?Q?wiT6o2AGO31+/kXTE1+MrVmQDPpYLEEV5IP5VJXuyXwsbhrIb+wvD92se3Qd?=
 =?us-ascii?Q?dfxHLbiHrr+MK6RM7XLoYHeAwVdeT9NZa8ETfvoMRcMUVIkyjslGREdisePo?=
 =?us-ascii?Q?x2VbqKMd7A0OcI5mGRepOKNDLfPtssaAagRBblRss04e7yvuyTQvGqMtmoXg?=
 =?us-ascii?Q?UV9KXQaREknUneAdCa6/q5JG00UXnluoPQrknBVFrYekbc8U8GbGt7k73yow?=
 =?us-ascii?Q?S6hP/1uA8oHE9yDGy9XbbJyedqHRuKUsfSRnt/PITfFkmEyvE1oGmhBN54Hd?=
 =?us-ascii?Q?KylercDW93Nhoh9xZukhYNa0HK75WkFfhI8fSLdc2Jb4+7rkOqikFt+XE9JJ?=
 =?us-ascii?Q?TGcTTcYt3LzT9FTA7TO1N1lV3yOfpDuInFLWJPViaG4vS2ZF8krp550TG3Pr?=
 =?us-ascii?Q?lvlXbLhChLyXWEPCG3JiMYcgjginlElsJ5zuAQGBtnvHoZbwRwZZplHkoO8v?=
 =?us-ascii?Q?t5T5GxXIJ4+Zj2KskD1CslxgbSB+7jPD2TgPSO1uQB7lTN/xDA3Cy9cFSx3Z?=
 =?us-ascii?Q?b61BNSlNx+OaFWmGfFr/2A9RkZESXz8CmRbnNt5l?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8abc75-fda6-411f-a8fd-08dbe842cc50
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 14:29:40.6578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sc/PU+7FumxW3nbqytLpWLul9km6/fuIiuUgH8L7yzTpdK21gwAbEqnOFdIh6OBVFUYukrLbHxBg6DiegOjIsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6869

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

