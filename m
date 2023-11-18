Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2057.outbound.protection.outlook.com [40.107.249.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F03F182A7
	for <mptcp@lists.linux.dev>; Sat, 18 Nov 2023 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="5g7d4EZ9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBkGmLNfsyF+zCi6CJ1R1lYdhZioybpwACCt6kSQq3JeyHo0fiUsyChrgaFD79C4kGyhtvBNJY194rRpL+JLVu/j8TQUr3pVRjtQECZY4kCpsSXlKoiy5vHpU1u+bE+Qw7VwBv/1BEnQLJtYccO7OGILtNg8k1cVcdlnKHmUDJEBrsg/IFNdnfTA/jtp8xUUJLMEG+g5gIeydd9DX7pFdeI/uRcTL5Ch7b5iQle/mGV9VduL5JQuZNJNXTVYdbDz57Oi1gmrv8NvkX/5uXKbFLYYudlBLpqEorCzRrtwporGihfhsfnPqWDEp6A7pPg31i+reKulmfFN+R6UtodVPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+W/0yUoZ1wnZFt80IkvapzV5PXq/PasaOPYw4JO1yqA=;
 b=UFFJB+IxBNznxdTmTH44cKKPLUm/l/qp/Or/V5YXwNM6trRuHuNJ2+Omq9W6Fwxxt/zWZJ4CXKtgVytBoFQhJBXSuJVIjg3hjuV3DMuq3wi4RBsSiFEoRTj58gCnaiIUVODL/sQh7VXtprZgC7EPDdk0WRx8wAJzPuDZKFEaZzK9M9YLbqC9v4LRX2pLCqVTao7ef3zSaCeD3Qgdq7OaKA1rAFIYub2OL5Hx2Au7IDHcfhWq7jTR4gEcCTGnnyUIVBW/zbQoi2khUGi2aSMGE6O163hBYa7LKJBpFr4w6vhLFcXLAwMj2fMShM0Tb6YKPjlbtJnneGKGXbPqAZjHrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+W/0yUoZ1wnZFt80IkvapzV5PXq/PasaOPYw4JO1yqA=;
 b=5g7d4EZ94QQlMmR9trPp1pKAx+ZDPzogkxFDytwuf52mhTUxQxIthniwmdSzZ7nEMUSgJKU6kn87wJQpOWgzXZJtQkaFPK4cy/+MFfVaIfVI92CunLkiXPi4SdPt/HM+yvKfuWuhed11Krt/+SGeYld8mMBTpUJ+mzvL5viVf1w+6unIoP6h3eUzKJMoy4TDCPT8RKH7srfTuzPfQ192MVzMqNsjWGBCVSh1Cu5VpkyVDQVje5g/q2zXm36tbKuokIvWpcPBNs5e7uivdZnv9RYJQo3BvWPqntzN4KKMGuVz1J42gBdSwXxMOcgGb2WlMSWmiQ9KqF0xZpclj28GJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6869.eurprd04.prod.outlook.com (2603:10a6:20b:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.13; Sat, 18 Nov
 2023 14:30:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Sat, 18 Nov 2023
 14:30:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 14/27] mptcp: check addrs list in userspace_pm_get_local_id
Date: Sat, 18 Nov 2023 22:28:29 +0800
Message-Id: <7c9ed6ee069dd4fc4dec1d3278b812bfe97986e7.1700312872.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700312872.git.geliang.tang@suse.com>
References: <cover.1700312872.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0137.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: abffa6dd-d890-430c-fec0-08dbe842f636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2PEZSLbrxm72YiFHJFAq6dwU/IawgS34yrJzBEioZs9fMDjWyaY/tFkM6tU5XMkdiU3bQXqxE+pxLbEpYo4JxHAJmUC6tqUOqMk4oV6USwAklJePqMMm+3GHS6E/xkdPz9gLK5fwce308Ud4KzBOhYchK3/VzktlIk4Cu1fkrYaeUJ9Et+BvHUTurdUPuJ2HZQOgwCY4Jggq7SVwbkZbFrxD7BC7paCFJ4C3nkY2mdN5D72m/MO/Z1G2vuClHYuq+u1rn7AeRlkgQKVTXZwq71VVlvZTaeExdckRIPZy6JMjGWJBia6fE0d59gAprppRvr/VAyvor/4TPJvrZV54RwCGhX05VANJt0IxQT86pLgikN9Fd3m9zeKXiYqrt0TMFJqvfDPGlnjlckgT86N8vhbAYF6LwDCKr55SI84YFLNeJQvOL3BWZVr1nIjC+lTk4gCkp4FYLqjO3ISORBDTAzRrt//UmAVlWxxbdbO/YeAiOjuTMzw2Ow+u+96ReMI/GiMa9trFvY/yrcss1P+ThLKT0Fixtk8Gr/sTQuHTNvSrng1M/kaUsuRZtu1eGVM0gdvuUqv/u4QaxbQ3JS0qTAO1T1IEK557JNSsJPvXUxA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(316002)(4326008)(8676002)(8936002)(66556008)(44832011)(66476007)(66946007)(6916009)(5660300002)(6486002)(478600001)(83380400001)(86362001)(2906002)(6506007)(41300700001)(26005)(107886003)(2616005)(6512007)(36756003)(38100700002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?me0I7YqqeTS4+tFbx0lBirjN9GpDx7Sm1mTYXx6j7qP8Xz3671n/OHEoCOhH?=
 =?us-ascii?Q?P31YIJsPb8u7jHdsNk/g1b2Wq3tgGUU1ahSJ5NYsdDDWfmltLIFcoRgw7Lw2?=
 =?us-ascii?Q?dWdFF6FHnHx5Cl+qG60tFGZbZHFimp6/eh2RzicvCNbn2gC19WnREhhXK6H+?=
 =?us-ascii?Q?PWzT/+fBGN9JRmegSyXEj7BBg+b0NVyonYojBx2ENpMiAslElPJk76DPcSUJ?=
 =?us-ascii?Q?ZW8d94DCq6RSJ3KYST4O+jQ+NHycz23dN3hEAJ4S0ukj0WSYFZykk26Vqaod?=
 =?us-ascii?Q?3FCP0kehP5URvKtxG1dOknHmAZsLMNpmrLBuFkGxR+BoE8DZo4lEXClPVPIm?=
 =?us-ascii?Q?cAjPkalJKEhRMQJGanxz9x8qI6QXhGB2KpwGdBhIE+aO/Mk4KCPuWNS+WLc1?=
 =?us-ascii?Q?r84TCX323MMSiX91j8T3J6FBUYumue76nE8/ti5q3F7ughMOylxwdJ4KoN/n?=
 =?us-ascii?Q?zGMEFDHeszePGWvxkCssVey8sj3n2TTtNlf5BSQGt6xSjM0gnJmWY+cbP1hS?=
 =?us-ascii?Q?ye5lRPOAdOzM1jYX2JMuh/SMNfCp2WwC4DDs145f5TDa7IJOn4z0/3YNFfpr?=
 =?us-ascii?Q?irH3Dc9QJa8/4FM8GMFShzGAImOxRvYRtvRmdYBrFS6BGu1zeBpMDKWqbE2I?=
 =?us-ascii?Q?zWayJ6H8G2Jf0U+GCcizH61PY8oyfd3/dd7oSg6PeTxfItGnImw48KE3fKrR?=
 =?us-ascii?Q?kBs4MOYdAKWMCBUEdkPIBZciBf77eQdULfvE8jcCvE22o58U+bUABF7hOxKm?=
 =?us-ascii?Q?xbAsLovzZ8A1aZFgLxgBiNMHpq/hpUTEZnoRzlhD3YA0ZbiaGrNoHRJbBEgG?=
 =?us-ascii?Q?rL3DOvbV2UKUXKNBCDkZgqcDOL73v/rWykOnVpNEIVUbSxo3dfrLkSlNmRJt?=
 =?us-ascii?Q?c+p08g0vqEvvn8NmLtj/muVJCdeVsM/vgwQJH7+uw7FJ67Gc8+4aFRiYzEz5?=
 =?us-ascii?Q?EySRiCYQEke7WdgAO/99bPjosfvBQr6Au3quzEhqb+N472yhPafekt+rqZ+l?=
 =?us-ascii?Q?r3nHpvpe/cudyyG9A/h7DUcQLPq8mw7sktpKQwtQGpKyltHGMHMejj3aHpmX?=
 =?us-ascii?Q?RvwPhwhiufyLQNYjy8VKXab3p9s/HnQc08fYAo4xj6O98qa2YEVHtjQ6bfX5?=
 =?us-ascii?Q?DIw2EzLXkTRRpu2va18yMviv0EEMttnc4ctXrxIUKgw5M1vaV2hhdjadfemd?=
 =?us-ascii?Q?SMeJAAD1xYYJKqtHCtBRL5MzclgPMKMo4AAFhyIvjyfoa8wjNf+6C8yy0/zQ?=
 =?us-ascii?Q?X4+HFWUDRia0GITS1A+2k/zMa3t3r1vqvXURtX5O9M/d6gEB+V42vQYXy7Jq?=
 =?us-ascii?Q?IKZ+eRKn1j2CxdPfI87yaS1+p0gVRRn3nBD1bpAcxgYxd7TfI46wGI6/pyNZ?=
 =?us-ascii?Q?i6L+2PGdYI5oiroipAx7N5z8L4BRw1mYtfzV2dQgm8j3TOwUF08m5AFxs35w?=
 =?us-ascii?Q?r2UVbNsLpC3dI1Kz/7g5q4ABg9cQ1c4g/TjcEKw288HSb5X310D8DMGxP8Oc?=
 =?us-ascii?Q?1dbW19xYlP2kt/NVEWioxUe2VD+OTIDtvYiF8vF00BGtzFvpLs32efQLAaeR?=
 =?us-ascii?Q?DMT2Yh/LyzacqugLlk99dsthhNZM7ULIwuC/p68l8suV342lVddnCMiNXS6+?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abffa6dd-d890-430c-fec0-08dbe842f636
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 14:30:50.1491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apPQBKjfmK9CDEZQUyrZY18bfTb7EHBnnTJGyBsCpPDUEnB6e5d8L+sCDbocWT3Au2pSdDrEnEjPrmcmDebZgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6869

Before adding a new entry in mptcp_userspace_pm_get_local_id(), it's
better to check whether this address is already in userspace pm local
address list. If it's in the list, no need to add a new entry, just
return it's address ID and use this address.

Fixes: 8b20137012d9 ("mptcp: read attributes of addr entries managed by userspace PMs")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index c9dc25fa8540..489bb0e61118 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -136,10 +136,21 @@ int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 				    struct mptcp_addr_info *skc)
 {
-	struct mptcp_pm_addr_entry new_entry;
+	struct mptcp_pm_addr_entry *entry = NULL, *e, new_entry;
 	__be16 msk_sport =  ((struct inet_sock *)
 			     inet_sk((struct sock *)msk))->inet_sport;
 
+	spin_lock_bh(&msk->pm.lock);
+	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (mptcp_addresses_equal(&e->addr, skc, false)) {
+			entry = e;
+			break;
+		}
+	}
+	spin_unlock_bh(&msk->pm.lock);
+	if (entry)
+		return entry->addr.id;
+
 	memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
 	new_entry.addr = *skc;
 	new_entry.addr.id = 0;
-- 
2.35.3

