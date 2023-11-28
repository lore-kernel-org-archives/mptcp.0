Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2060.outbound.protection.outlook.com [40.107.105.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D055674E
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SBnl3J/5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXYwQNdTpiJg7V8faQtFyj1VOtWBfprEne1QmHwVEXWRo8HCGiFtwUbxTIQ+Y8RwUZps/GdSRb6y+6B2/xZSiE0MtzSy8WczdgxEParH4Btqsp37gY+btC/wvERfUQ8Ra7ucrofaTWPzQ1VGRYGO0c0b0J1IqWsxLP2SI7HZDpwfqO/qTaOsNJDVKN89oQj+RktFmOAhKqWhF2cW8tARD5TnDCV+UCS5S/S27GHKHLldWUBcQFn9Gk1l/NxTYN7eK5QerUkCtOH8F1wYma6xFLYngx2rZ57zy0CfMZBhEv1SXAcGPiXB6Iy43jk5/3Uon48RKyeiV53fm94o1h2h6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XISrvyZEEk7+Q58Cv0jrQ8umI/FxldAYsT0aZv7KBE=;
 b=dIVYsvpmK9AePPgetOjDEKxxFoiTcdMjdeu58w6w7xBCy5xkmLQ1ilc9571sRhN1mJMmJvm2eLjJm5G2VapATVYesJm1+3fhdtKpel15J6AA/bRtgmvvPJ1kHuM/Y7GmV22zMxJdcC1XTWaUOccZHug93cM9ASgZxjGLts4RoqjxsXoO+SWaGu/3g0dl9SiGKdEdHvRydrfRfdGqM2yB2nmIG7QOygG6vckGBYetPSd4IBYtLGpOL2CACE+Spak94nW93M9bR/RDVFoadev19jYWwKltBOOWgkf4j45zuZK2z1mhx83gHflCdQjz0lCNZzMoQRjHeeXs11zFzDQg8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XISrvyZEEk7+Q58Cv0jrQ8umI/FxldAYsT0aZv7KBE=;
 b=SBnl3J/5W8MfoZEs66JrhQ/XbLP39HbK9ihKWVje9V7SEBwIt8quZPulGEhpHQQ5HeqtKnbxJsTWKm6WITgpjX1w0yv+U5KPz5KaHv9V5vLVHkQaWzHNaOJqLh2ZWBTpOmQlZQ9t3/OajR8FPMUDmswp+mviFuw/O2Md27w315nvNx3XCLtqW9KMFUrZq6wczRikABCm9sC8nTgps2dcWlhvpIR8P8CxF+IZByOrcHT55KrLhTRovH5kNY5muzOfgLJxarW92pUZpRY3g68DhwhLT+GB7w8NnL//pdysGC1nhaK10cM72nqoXodd/cwBk+3YMafSPIFRAoZ5MUa56g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAWPR04MB9837.eurprd04.prod.outlook.com (2603:10a6:102:385::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19; Tue, 28 Nov
 2023 14:25:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:25:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 31/32] mptcp: map v4 address to v6 when destroying subflow
Date: Tue, 28 Nov 2023 22:22:24 +0800
Message-Id: <48657f917c3cc536ff123b673b0de5b3330fe8d3.1701180969.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180969.git.geliang.tang@suse.com>
References: <cover.1701180969.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAWPR04MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: 450e24f3-3219-46da-1161-08dbf01dde9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZJ3Jm6gwXmhP0GHYotyzPlePm8hr7bLIxZGacuF+VUae8ox+Y8yFBxvkgznuY9skI8S2hSyhOS+2jB6PN2ORsC1cwY55RHf6laEIGKncuIjh5vWGbkCYDPEdkUE4vAdrhLp5FCAeFdo0untKzqjl4FyDuoAuu/ERJmEq6D2sDFFpweVhbWTLBdVzP9ifQdG8jzWgjTpn45xNnRbnMUmZPbMCKO+QPZV0MEr2c9m2hG+hG4tZaT2lZ1bfLi8z+O1JkrGX49Aug3J0/VD86WZYForj4lW268hD0nrhqou8Waeu4qrqUJd5uMRpWQp7wkfyjRECIdlNMM7NG3iSTY9111aQ4GOdmtX5Jl05HDbBNEBUttSYy02CHOU3rBX8dxrvmBiyPUszGDwQUECusWLnqhkGI6p/y5M9nUF1YfCYTk4amXitHncUrSq/rUaLsEvDpsPHoz83uvLhZ2SEBH0+rVXnUxVouqz9dvFCsMZKOln9j0RTQ4bTuvFniWAeCNNmMsBrskWSzPssMzvdxrw0yfAEKkQmzIvi3yrsxFRgOVh69oP/9kKJq+G0pANgwOdM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(44832011)(8676002)(5660300002)(4326008)(41300700001)(26005)(8936002)(2906002)(478600001)(6666004)(6506007)(6512007)(107886003)(2616005)(36756003)(86362001)(316002)(66946007)(6916009)(66556008)(6486002)(66476007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4F7Cf7BZjHxr5z78FjmcvfM5ldZxeqa6ZPAfbE5ygM/wr2Ecb4lnx6Y2a7TJ?=
 =?us-ascii?Q?8OpiRB2u6Pl8Smn7nZ+PofpI0Bllw+ZI35cmZpoYgGbzT2uqFgd6t+LW3eg5?=
 =?us-ascii?Q?RbJbfrxHjlQywxmcEr5/aEQrhOBWHu044voUo2Colmg3JiTnHW7ol/qFM/zW?=
 =?us-ascii?Q?dBwB3jOfbTQ13cbaeDZhAn+EZLguaRrw2cLXrAWjT2Jqj46DMfTrYm4hxC/6?=
 =?us-ascii?Q?M6AuV+6hcKVw6jgPOtT9mLD3MdvQHeZtothv4r4D8brHyKknJETBZc2Jm+42?=
 =?us-ascii?Q?cl5uuGuC2OvYAcgwaA4satsS+igihTAXQKdrBA6nPOd64o2pJHrJLGVvRj2W?=
 =?us-ascii?Q?1y4tbJTX/hPSn4+ZMK33qbzsvqwxyiB77aMmMtx2S8slfiIIy5eVnDhweVya?=
 =?us-ascii?Q?Z/WZkfkXgYkg5DWFq1UPljFBWxV1I2/D2gJ3Na+0GzIhHYmLynhJnz0GLpGC?=
 =?us-ascii?Q?MA0hixQMeOw7CRSH8yYQFO5XGaLna24ZzzCc4RxROaze0ZX0RlMICh83S1aw?=
 =?us-ascii?Q?xSPSTdjetj/9ghnrVQylGe/JYoZ6nVJtJ6k3zIA5ophdtrval/Mls7d10Cun?=
 =?us-ascii?Q?z1NykbcKNEW8HGFnANiK3ayBEYBSo2OaTVhMO3kOej5SE5DNkFJOny9j3Ikf?=
 =?us-ascii?Q?r8ezgoLsD5K0fA8GVckon4cdc1HY185rg6ykuyqSpaB8z9eieYnzKQiK+xsU?=
 =?us-ascii?Q?0R2NCmh957cZS7DYb8+jS1tcq/zrmp0zmAhHGgGRSBIpI0bRTmUmDF/wn9nM?=
 =?us-ascii?Q?jZ+jxzaiQphR5cHo/nBz9rVXm355Rkd/g3FE6UownTiliPjEMwdauZ7UVRB5?=
 =?us-ascii?Q?o9PnC/hG0pgnAJLjwvJsXrUxA/MNaRgbCmO6SfXHu/4+eey6ytgID631/Sc3?=
 =?us-ascii?Q?wv8Ijojc64EDYtH8xrHJcl1/Cb9rDOqxRwK6igbQhx29KbuPrEWHHaoBnGMQ?=
 =?us-ascii?Q?hlUzv/WUJAY/CFz534SmGNRmpM3MO5vcd5lzgNRDt8XFhEyE8RIi2exlhUzz?=
 =?us-ascii?Q?jGXCO4mqNl8HGD783zakgS7SWDdHWZUkGhNp569vVuOb4vG6yFwGdvK+SR2Y?=
 =?us-ascii?Q?0f+0Gs5imcHWw+e4fZDmiHy4qJEECYtGxaca+ncIAYpnX/UYGYeu6B0R7zg2?=
 =?us-ascii?Q?NCvIAS8WIgbSMdMR1X44w/w13DjVxsqUvSeaH0snBj2nBwEB9iAzsdB3299m?=
 =?us-ascii?Q?sk9oBFpcXBIcUjK/hwVn3UqOdXU9U9+eWY8X8Q8lUlA/LKMwCo4HTNrs+RCa?=
 =?us-ascii?Q?8hNCC+kuZkInrwLJq1fT/d6bcm2abi+mLnYxshCsnW22Kfa0jkQDVLXFkkr6?=
 =?us-ascii?Q?f1reIP2eNu29uLdTqoio0qEGBvQTDCj5o5Y4qWIZG7KTZuJbW3T+krJJ5cOZ?=
 =?us-ascii?Q?igFx9pO1kmZo+PJsRXLpknQk/yknJgGJjNqBAa1XrkZ99hada6jD80cq/mlM?=
 =?us-ascii?Q?jV0kv9+I1IReS6kRFxNhU5pNrrCMCIFL2iBdUhtldWVizaTCrmko5zRIvDvQ?=
 =?us-ascii?Q?A6Fk0vlvuJr/JuoKUIDd7T4bZw90F+VbcMQOkfUZQN0JjbS1/kO7DtynwFO2?=
 =?us-ascii?Q?Yd5X0U8+xJGeQopFGt/zqLxmSj3XfTiW5xjBSXAB?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450e24f3-3219-46da-1161-08dbf01dde9e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:25:28.3544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NBmtcbgauqEkkGrrq9WQgJVraWQXhQvOpx7UgD8mYOMOChysb3dxXDSQt/GR3NADLauP8QiGoRb27SWnlMmf6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9837

In mptcp_pm_nl_subflow_destroy_doit(), before checking local address
family with remote address family, map an IPv4 address to an IPv6 address
if the pair is a v4-mapped address.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 43a1217503ea..a28197a4d0b6 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -524,6 +524,16 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 		goto destroy_err;
 	}
 
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	if (addr_l.family == AF_INET && ipv6_addr_v4mapped(&addr_r.addr6)) {
+		ipv6_addr_set_v4mapped(addr_l.addr.s_addr, &addr_l.addr6);
+		addr_l.family = AF_INET6;
+	}
+	if (addr_r.family == AF_INET && ipv6_addr_v4mapped(&addr_l.addr6)) {
+		ipv6_addr_set_v4mapped(addr_r.addr.s_addr, &addr_r.addr6);
+		addr_r.family = AF_INET6;
+	}
+#endif
 	if (addr_l.family != addr_r.family) {
 		GENL_SET_ERR_MSG(info, "address families do not match");
 		err = -EINVAL;
-- 
2.35.3

