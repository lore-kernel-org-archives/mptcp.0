Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2052.outbound.protection.outlook.com [40.107.241.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CDF5ABB6
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QAPriX+b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+HwBX55GjSsz5RZJ8jt9DrWVqOI6e4GyP6EBHLzzrh21s3Hzkrt6bLtPcNgCu/MJ4kG9qblZf8HzU+E92WOVwOLb8Y/rm8xnh5Rnd4ssX9cMkSDYvH+JRUM5YhBKh+viGXeCIqty+r6PC1Uw4tuUKcxtavv/r+X+nW2vtXQHEgN2rg0gU/heSL3PB05DAU6oh0bavLAoY9WiebvBU3Ibk8WcP81pcRgI1LRsVxoA9FCMh9OWDFdxzOg4WmV/RsigzRH3ondu95w8SDZaAfxxOzvL1aVtAeBjcxWuuVrV866oUNUzySkfKnQkKNjWUfFyOFK9tteSp+GD0wB4vrg6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dph7slE2gv8EAzbuXoW1AIj1s2dm2ND+F4+zezBtKwE=;
 b=PMUKRCWk5XZrVEy2gEZpcrHwcTshTWTijAlTQavi3AEShWyBbM/gcNGa702O7F52z8sr3uX5ZDXmuDEh/6qQhyG6hfcc+TVPbzvV8a3eph5je7EbeGSR7BhCUTIgVO/ahWCQZjs1X4FopKmA8+jyq9pr/V8NdjoL1NCt8L7iKdPjBmjAlfHGysakyeGcbx8P/khfpu3xWfkVBk0CE9AHVddEgYxdQ9eXVAPscYlb8sE9qpcW8E62EsLPQBpADrR2wt0fJuM9mrv6pylOVI9AZTUmFgLA5/CZ7UHR1aU5pAijOVBrnAI5mkObKoE9uKKRy1bUFq08wWNP/Fq4ZVzivw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dph7slE2gv8EAzbuXoW1AIj1s2dm2ND+F4+zezBtKwE=;
 b=QAPriX+bYzETXYlt5jdk1tVH4crDtg0QL3UC00Y8RRJoYYV+UU5KAyptyF5Qm8m4ByyUvL8OiAOhaB7lZFSWSwmF5fBpQ3VCyL7178DNzWblAwBw9RvKcvgeWw+sgts2PKN6JT1VEHb7s5+GJOmv8q+6IcsCnhsW4xlZhDTxSo8dhHeKq7N97dNpmAQsK1xcM9Z3V6ZHGSq6mUd8IB8oJFbV25D2zWv22a9tcoSd/e7ZoCiBwn4/9jXOF6wMgmrTB4VR8PnYvTDwW6t5SSdxLUM6MOfikZ1onLAxjcL5I+5kxeLmIRO2AySFtgEMIV0FUwVsG8qezeuWPpgOB1Lx5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7001.eurprd04.prod.outlook.com (2603:10a6:10:11f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Tue, 28 Nov
 2023 14:22:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:22:38 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 07/32] mptcp: check userspace pm subflow flag
Date: Tue, 28 Nov 2023 22:22:00 +0800
Message-Id: <d3fcfbdfe44a0a82152cd7e05c24f4002b6f1502.1701180969.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180969.git.geliang.tang@suse.com>
References: <cover.1701180969.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0175.apcprd04.prod.outlook.com
 (2603:1096:4:14::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: cc7bd06a-650c-4b1e-be62-08dbf01d792e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b5qdrdkcQ/26u0JORFOznFyZOI05gGphEtHc9ubMJi1NAM3J6VUBFjanVaKxOCgjdo6OY2iTZK5KXFYBSiqBsWmXbywmZhzKMseKhLiecef/j2kOja4yi18AUpezy4rtSqqMDa+PxTJBvRSBfnkHbTyk9jz3D0NhkbDb3w8LdxShg9vlnguDevIF7Tj22DsO5qvjv/d6+oOSWt85CZh6X3ORTFmHk7HD8WGHIYBSgc80LvQAeH3u6PJvdQgaY+qK+rIGVIisDxp9cAX7wq8TAIunWYKCuIzOvmuY0AaWLoKQPTQzBz6FGxtQ9wMBQ2DaUEVIcXg/N8Bnqbas25hI1ft+Cp/xBkIzLqUsEGLoMimQ0NeWUTSpKNE/JeoNIKZis/IJtvRYhhKe6OyqjCqidSzKTEG0OjLsKLn0BeZ3JNuhMjSKbacWSdOZPz1HbG/S7INL4eg/ljHX7FfZyabqQMiI8G4F8nUaLdTincxdJfYn500hOMhiOcMAOrOhckmCU4ssWTFb0/3EfJmjsISmKGYZvBs8t9330DoVcCPkSYbRX1TEQ9uUbln6yjNi4+59
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(2906002)(36756003)(5660300002)(86362001)(26005)(6666004)(6512007)(83380400001)(107886003)(2616005)(6506007)(38100700002)(478600001)(6486002)(44832011)(66946007)(66476007)(4326008)(8676002)(8936002)(6916009)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uxXV0KaaO3AxNhdHGlq8+ce9AQbl+HLrSxs+I9Nv3Cb5daoP32KaX6El2OMl?=
 =?us-ascii?Q?vKqBK/3yf/aWgbZS5IWatGojNVF75d2xONaS30rRVpSBo0QG7tRhwWoLzBaL?=
 =?us-ascii?Q?aZKRCIMW3NRHtKnDpz8+uZEy7ImsR34YFXEqKt0zHLkv6IHkBfAjjTABOSh0?=
 =?us-ascii?Q?6v5TEabJZ4ltw5cXR0DHZzsb3SOwFwaMGP8rU6Cfm6pTUs3mD2mw9G7Bu7xT?=
 =?us-ascii?Q?6f9H4cbTDuvfn7GqomdnrLOCOd5upDTwsfL4Ne/9ndgXavoX9JQSiHXmoV+/?=
 =?us-ascii?Q?Mx8zJ5ApLWHLFZS5A2zrENrGrdk7Jq8CpRRBx9GVZS6i48qrl5aLDGCKGoXa?=
 =?us-ascii?Q?Q3pK3DFo/gtoz7p22GS8osv0N4A48AKN2Vh+BE/q6YXQkjJRnOtAcqTPZj5h?=
 =?us-ascii?Q?5Yw6Dmi/Y4792Kh4vaBH+z0QNiAm5DogAUsjQawMx9TsshHV0Mjs9BMrRsTU?=
 =?us-ascii?Q?zfnoQcCZQOv5sM41PzIcZEbJaUpusfGyiozq52O19sdrLFZ1bow9nouqbPP7?=
 =?us-ascii?Q?992SmjiN0o8FIp78671xOSoqBW8uRK3GryK75jZL3nZ0KMNXBEycqlN1ypg9?=
 =?us-ascii?Q?NBNr3kE2FGjh2ZxOrRkalS09hM29JCvyF0kCrvbBJTIdWt/v6kQbT6Zm42zv?=
 =?us-ascii?Q?y2th5Z/kiczrXfB55INC+UAY32LniFzf59cY4mt72EpgS7g/QCQCOWSjZVPt?=
 =?us-ascii?Q?lEpGbVK+dHl3D39xPvXBW8wSxw1bQhcVuBllivrbuvc+vGw8iWY/aIzqd/cq?=
 =?us-ascii?Q?aqzNaaforj6hb6LN0eIrWqrrlfp6fvTxft4OnyU9mXmF5tX7514dLj3XcaEP?=
 =?us-ascii?Q?aN+9dDqg695XPu0fXPrdFIUb6zNF/M88OrsyX0yHr4NGcPkaomZVPytSVQcW?=
 =?us-ascii?Q?QmZjQ3AOtrjtEBpmhF03FLnxsxfs+Avzr+CX66d0c44Tmn3L3qYn7CFtuKW+?=
 =?us-ascii?Q?BrxT9wq9E/tx4vVa5e4EQ7cmVSADJ8irOo0LFaeXq6gn/xRHtYBGjP4jd/nI?=
 =?us-ascii?Q?Z7AkDAoPRbMr9nkRWgHi9t7vBxQavNyhWa9Ju5Ni1i9W78owKh3OkUGaj4L3?=
 =?us-ascii?Q?fawrscfCpZlDZsm/0Eah1Bpg5AxUuPvrDK3mom2C0Oafn+gVZ7ChSGxUqFoo?=
 =?us-ascii?Q?z3QLpG3YjDh6/7BrnR/SaeT1I62xdCVEtRgFonCH/6SUH8hCjuLwkEwy4qsW?=
 =?us-ascii?Q?LRprIWz2fuPheVo1dmxUf8+VgWcqiNT+nHE1F4Y28rtOiGYNFzQnbGC+H5Av?=
 =?us-ascii?Q?Yz1G0E0xJdKIqpBPUoAGOJ1FJFQ3zevzqbJIwEFbDird6TxXAK1bPLBQpgil?=
 =?us-ascii?Q?G3Ie+pQcxtbmX0Zi46G+mOOaOeEWB2ZC9mPhr40Z4tPX79lEvtSABqlBaoZ2?=
 =?us-ascii?Q?g0OOYMHexepfvFT8ZP2/pudWdPQ1BD70vsOTxDd4mnb/mKQ+kbE6RRLIsZ9X?=
 =?us-ascii?Q?AbjDQ8QfrDk11c4HzGeZg4IcVH4dlBE6k9KYyEnu8VT4qiSQX3rwW7zpw83T?=
 =?us-ascii?Q?9U9CDkGqhhxSiidmS07MJI7p1LH2wkbbGju6QBrMZac3BWRj0KKmiJpbWdph?=
 =?us-ascii?Q?n8I2PYbYX8Ok8sunKOcFA0PbG1K2LKpmHWz7vwKa?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc7bd06a-650c-4b1e-be62-08dbf01d792e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:22:38.2066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ii/CTY82ZlkLGnSGNOanKYNfWdBXCpE4Fqc5BVWVEcXt19aBqla7xnVUl+SAHjQEyIYJa9KFZLF2r/d+57JXKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7001

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

