Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2072.outbound.protection.outlook.com [40.107.7.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98F37472
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 08:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="yODc+V2l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKtChIm6b8gdESTze7NlLG2aRwZ8eZLhWryHaF6le1I/Nqyt5e3NWQ1L68EtDR5BCbJJBBIyCQ8uGgNPYEb+ItLQI/JoB4/KCl2dn4Jip8xD78nb9Ud0VwsNFNzYYfPuR1DBF7YOvlvHelxVmcGfK4cD2orYUEuQjtgNJx4W38HjwKD2k9b3WT9uz+M4kOsROVKWDJ4afezjvmoF+Lu7sb1H4jwlrMaU9qF3PkL9wZMVx6ThGXE+pJeMdnGcyXsE2TrjRSV/aNHcGHf1eKB0uClvpCHSKRJk/JTH+Bp/D9MyuIsY6Ky5k/vlW3XnAAWfbHdKJx61y0cWqeukzBTCtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlJw0F4nsVw0wUo4lf6RDN6vdwxBnJn8U4hLlHlHjFM=;
 b=IQg2aiYlGnS6PcQtv4gY6w61EZy2Vzxs/d9RjXE21/Yc6RwzoLFlSAtIg9H6sHOJAddTGdlrZBhQDROYOA49QTiCoH5q11TM+ORYxl+cmSySFgwoqc6WXD9YsXpgg7WrxaT/qtEVYb7Z3O5thbthnBMtUdHEH8B2aoy8Hc2PX5fpbpeophLus6KBVQ0UpxR066f9EGqQeCXooYANBDbblNm5tYIPiynTR1V4RASz/3aaJY2xEBMXcdTJtwVsgEvN+ybB32Pf6nj5oEgyQVIq3mKgnBjiQ7hreK2tPbO3Rqhp8i4/Suu/m6Xu5qUqZT9WU1Rzj5sFh+/+lj0/ui7Kuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlJw0F4nsVw0wUo4lf6RDN6vdwxBnJn8U4hLlHlHjFM=;
 b=yODc+V2l19Axd2Qr4k3VUC3ZLYhSRQeIaC8Sf9b7YIhlslNZmb1GC+hmxQoyKQE3Uo7ixRmej4w0mvO3pdLbo7gi8LjrG6AaLSEBX/vhQ0Qa2xRBX4OitC8N+07OW81Z31ogOnRnhgfyURTM0r34o/xZ3M4Bw+rVMG9TgTuWK3M1vdPZ9xAM92br56hLURM9mlz9BVy+iTDMiJrzU+1/sKiktWzG2gRp0yhO2xpg87QuRi4/rQXk35YVffCXbHdTFp2iz7+uoBySyWnxRXCIpWn8Wf1mJhf5cLajdWdv2sXSRHz9dBuuNsW9tIwA7VcyiVoEg0uihqjWi7nBVtILWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8874.eurprd04.prod.outlook.com (2603:10a6:20b:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 08:36:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 08:36:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 12/12] mptcp: drop lookup_by_id parameter in lookup_addr
Date: Sat,  4 Nov 2023 16:35:47 +0800
Message-Id: <ac3acaec649cf088b9aef476f7d8e0ec38d62ac8.1699086244.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699086244.git.geliang.tang@suse.com>
References: <cover.1699086244.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: 24f2090c-f876-4901-139c-08dbdd1135dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8LrbkzFw6M0+mzppbW/D26zax/rv14Ng3cX822awUGpspnC6IM11hNCPIhdy/2mZzRlTibLbwsVUQi3em3wN2P2mutWBbKfejOuYnyzFpLEVqBZHm6WNumOaGIWHouEbV9wSrW9psGvbmODtLkeog1J15Enq0NCoHMRnLqWnmutz7FqxaXjlHvywBpSklpd8YyukgPVMeQddyofZpaQzrh9Ghd4tsnTDlAPrKVPZtNfldRynrT7m/4YLp+DgK7p6yc8STrd25c7nvLcYim6VMx7SoZPvZI4Y2YqwAtd36kh3Tk60vzWZGTNOaYF6vQCCz1qvxAW3/f550w4vXNiQo3LWjuNWfuzFE0332sDQkuMRoUf5z/GKefGG3z/6rh6KmjVrhw1vDwxtkTl4bWXqR/dsTD0B+7B/nf6UZjdQAYgJw12zXD5jpJyWCsRtVy93nJi/0XufR+kdGVR/sVzK97R4GAyoabtGY3r0JgmcI5BTlKy6HJfK3NbzZR14/OKFZKi6wIFn8NpygPtpzIwTzA+LFNfXI8jH6v2QV5CMbsmZBcMfOONzS4Bn49VmJPyULF4uH1a917Lqwz7c4O9A1oSIzQtjpH4rf4mDuj5wf/4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(316002)(86362001)(83380400001)(107886003)(6486002)(8936002)(44832011)(4326008)(478600001)(66476007)(66556008)(41300700001)(66946007)(6916009)(8676002)(36756003)(26005)(5660300002)(2616005)(2906002)(6506007)(6512007)(38100700002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3GYcRZ1I1w1GJiYT3gc+eGlBxUsJnt/2qQlWeUQOnY2zAFux6xPFsYX2nkmg?=
 =?us-ascii?Q?e+nl80bC5r+pmIVE3wbAaaN+Z99MGQLf2EdNcrGHX+4k8k3jm2o7fHy95SCf?=
 =?us-ascii?Q?sP+VGtsNUsDZdZtS2loKndHM+zGhqcTWi+pS5GdGPlsyvv5Ps+OFCw5KWiEc?=
 =?us-ascii?Q?Z6jzp7aZ++RMI9WrJjx3TNvDIkpa8S/s6zwt5epInqpe6cwovK0lhFbfWmsJ?=
 =?us-ascii?Q?GmUMl7gaxd5sW1ubQCDwvEc1JU0QKZPTFZoWt6FhDBcPyU+M5fmhSEIFBDx0?=
 =?us-ascii?Q?Z8Slkl+z3hPOYpYDnyBZHe9OoFPY4/T6CWp7JMHW5D/43MiOdnWqb4pEd73Y?=
 =?us-ascii?Q?6XBUVsLzlIxT64gcbgGq/YzA0hnLhfMckUgcsK1cO7p0t5YwKj5FYEr2kV27?=
 =?us-ascii?Q?Zh2GFkUAWXhHcUdXxAfDm2YVHqPFucVgPUz0/4iCwXTUBS+KIX5TF6YRcjMN?=
 =?us-ascii?Q?3Vlev9VFsuxoTql7v4TkjmHzdjS8apX7eNL0cuyETA4o2nR3dV4mmjLFUxP9?=
 =?us-ascii?Q?KfvoOjs3qZiaMcvoDK7U+VadS9GPMMyfMWmjDQ5A5IJ2R21G8l4zhHP71wz/?=
 =?us-ascii?Q?p4kLHAUg8q4rodbWfagXW8S8v8ICc0rviA81NeTigqjZVpaD4orLxwIYiAjq?=
 =?us-ascii?Q?leSaRE07MTVBGkwKDnIf1VLPVKPDjer/UIm98SfA2AK1wKCCM9WY5xCle9KO?=
 =?us-ascii?Q?oaJ/m/FEnP4V52V8SDRi1M4UY2IFCgKHJbOlkkTCz6xUHEnRgh6kLx93ZYjv?=
 =?us-ascii?Q?4jIgMuZ6EdDI1HuxXHez/JxuCbxOHtbo+gtx97AWlkJ7qZTb6U1h28q0ke7A?=
 =?us-ascii?Q?d1Sl3WOR1kBJIERRVwVaByD02N3DKn6bQJqzKNAljBZRFV6u+ze2/C2ATcb/?=
 =?us-ascii?Q?yHxU2U5aTy5m7UOynyBlJ0e9f5SYU2hC3HL29BJLPoXQ4x5iaNg2HucW8rzY?=
 =?us-ascii?Q?oNgz/ocxWZDFo/JD3qxz2nBjhuP9deMQLAHGNbaQOUs0ihMnpkUf9q8BvU0B?=
 =?us-ascii?Q?UyauRDNqpXH/9mDKiw/eJp+5kIfxR5Dcd2FrvNRtw6IV9hQ8EZoDx2aEVDAT?=
 =?us-ascii?Q?LNBnXbxN4RZl5r0LntdvwZynibQAG6IyC0XkI+cHxwtLA+Ykge6igEQy7h+G?=
 =?us-ascii?Q?QGiiNThZkvMSu3nvf7DV3sE3brPznoz5tW6l0VIL8flOk/0cFhhR2WhogIDb?=
 =?us-ascii?Q?/8m+KE8dVQNkN4CeM+boEIfCRDB6xwuHH/LHV7NqaXXZbR3KGn/K8DYVT6CS?=
 =?us-ascii?Q?6Yw3YlL4Qv9bU9YNKsx2bivTGYeTPBMFUVrJCzauXpXkRSNOb7Faf5Pxl6cg?=
 =?us-ascii?Q?M+CH688NU34gtrm2wLJRYouyApUK2V+RJOXUGoXn8PeOQrtQFPZs1tHvDSg9?=
 =?us-ascii?Q?ZKNceBiUgeYxbk5r41FPSEgA45baLE0v+kNANi36NJIGI7QXNM2cvl1cu6l/?=
 =?us-ascii?Q?WQOOsEpvPLyVhgnIiS7EnygQ2i6Qb2EEUVkGpdnTs87xQcIoDkWHtCba7t+L?=
 =?us-ascii?Q?j8Ki+DDbFELGOv9ydvvvw635Zsu+hGEqZQuQTXI2KVXsV4FwkuURmE5CeFwB?=
 =?us-ascii?Q?3ALnhvHBlPDvZQ9q1CYQeYjwSHWtw4fN0wcp8yGqw8w3t4pRx1g1uhQGqj8f?=
 =?us-ascii?Q?Qw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f2090c-f876-4901-139c-08dbdd1135dd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 08:36:59.2061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9RlyTwdPgV0DGXscGmOzf4GasUcvJAsFK3cXyGzplOnKdoQ/1pI0cP6tpkhnab4y3mQgWCTJt2+9DigKAW41fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8874

When lookup_by_id parameter of __lookup_addr() is true, it's the same as
__lookup_addr_by_id(). Drop this parameter.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ae5489beb31e..ea507ed7aad1 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -471,15 +471,12 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
 }
 
 static struct mptcp_pm_addr_entry *
-__lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info,
-	      bool lookup_by_id)
+__lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 {
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
-		if ((!lookup_by_id &&
-		     mptcp_addresses_equal(&entry->addr, info, entry->addr.port)) ||
-		    (lookup_by_id && entry->addr.id == info->id))
+		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
 			return entry;
 	}
 	return NULL;
@@ -509,7 +506,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
 		rcu_read_lock();
-		entry = __lookup_addr(pernet, &mpc_addr, false);
+		entry = __lookup_addr(pernet, &mpc_addr);
 		if (entry) {
 			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
 			msk->mpc_endpoint_id = entry->addr.id;
@@ -1850,7 +1847,8 @@ int mptcp_pm_nl_set_flags(struct net *net, struct mptcp_pm_addr_entry *addr, u8
 	}
 
 	spin_lock_bh(&pernet->lock);
-	entry = __lookup_addr(pernet, &addr->addr, lookup_by_id);
+	entry = lookup_by_id ? __lookup_addr_by_id(pernet, addr->addr.id) :
+			       __lookup_addr(pernet, &addr->addr);
 	if (!entry) {
 		spin_unlock_bh(&pernet->lock);
 		return -EINVAL;
-- 
2.35.3

