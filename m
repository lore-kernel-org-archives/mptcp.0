Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD558820
	for <mptcp@lists.linux.dev>; Mon, 13 Nov 2023 02:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NlysBNkN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTbZYfCEwG1FVze0/TIaWwKf4+DcxbSX+UwYYNm450ako/LuwpE6SYPm+7T9Vj6f4Ugr4TPI48zowrRhzjUGtTJ2k7GQsiLgtnY7hAsq4zlthIAtxzHyE5T7haH6U09XTcVDOjrmIizuQRq+pHDQWpogxoa9aBNamAyK3OTl+Llor2ki0NKibPCnuL2ygqcn3nhh7GbL45GpYby9vBfQ8Ckt8DXgzKlsAZMtBMgZJx/36juIySJlcVGTQpIgBGg50roJJyvIFCe00PErmZiIX/zZPBgN4QWt3TGPy0yjiKjAC+x8ttU5mFIWov2xE9lxRpuePlPJWULq9CE2WAqIBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYuEwtPTT1Xgh2FC4RUPWfAfSYFJlXOMeXPVpClzi64=;
 b=IxTL/u8Ze+wTVCsoE7rBUpL182cYFc1Gg5FSyxqLrXKHPWv8gBd2ZPFOXxyte75ZT/sJw9I80t8ad5IU8YJnmM84/qdSC35HPvm2aD4NPYh+Kvb4cDTUp1Kqg4JRvlDKjkgw0fZHAq4OoCUwVmJ5CvB7QBRh02osl6ae4zgpQMegzhfzsvS0XE8WmM+KLFYGyQoTjZgDGGeoR3YbL4YSiIgrOTd7zNNd7qIe1X35u4PUml5QZMt0xPrQihszBYP9iNtbhaqF2+OoXf9iKsDyZJ0e4SHWzIHcR3NtK3xfDU3uOC8jI39lA/v2xhHm5bAUdnX5j6ZonIfOvP54ovtaQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYuEwtPTT1Xgh2FC4RUPWfAfSYFJlXOMeXPVpClzi64=;
 b=NlysBNkNkg11wR9kP6dDfSXMAmtU6ogSPo9hfyh6XNh2E0iHo/jexPodDNynwuGw7YkZF/qknBCxWoN+mf68z0dZq0YTKOx2cKcUBxjuo4856LQipvJ3W2vB1PqfsNQk3u+ciwmlWRyTDtq47QvUQqoHvoE/bV3gMSth8VXaJxXDe796n768PZET7RHuageC+eDyDpGOgAdehf4rUGNQD6rgb69iF9VrGXLZY/9/Nhfr+lViAYFK69JvhRvBdoCnqA6tPbThzMJO4loJkpKhd4pRh8XyKhbUsqfkOrZ22goZ/m3sOTf84FJ8xelYYF+HWt+2YQWITdyu/vmRNpFWwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB10038.eurprd04.prod.outlook.com (2603:10a6:10:4db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.14; Mon, 13 Nov
 2023 02:50:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Mon, 13 Nov 2023
 02:50:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 13/22] mptcp: add a prefix for free_local_addr_list
Date: Mon, 13 Nov 2023 10:48:57 +0800
Message-Id: <2bcb1be9d0ad10e3181d04fc33b1e459db5521cb.1699843617.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699843617.git.geliang.tang@suse.com>
References: <cover.1699843617.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB10038:EE_
X-MS-Office365-Filtering-Correlation-Id: e5d8e70c-d587-4e38-202d-08dbe3f3420a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GxCjbhtV+KDq30RciYsTrvVSvGWc6JF32d365ErTWf3V4zuM2+7Q9gpvW7jdNo/Sd/MLFh3rpv5MdOyFSdo2xiZcUoeoO4OFrgfqRlfMSb/JRdiDphWZrtHkgeUSU/x5x5+Vjz2VWOtcZ7zdTKHI+hCjv5Q/SA6o1wPhir77/tuBisg1SvkKDsFp58iuEqd/HYa3uNigyMvUmiUSMb8TExXOVn6YqicKz/1wfGhMgy9AwR77KyQtL8BlBeTSwy/ItWNzvAK22P8+2M4Dfugx3bAbWA1dXYCJbW6K35dw8oDLUI0bN9OBdHkNclChg3IbtTAmPh7vLPD/xaQB6lbuYUNNQHesP+tZ/ZLTVjZOjcwv8Wdp80nmUq/gSSyn8o/qAQ3Ye7tOZuMPOQ1bueCD5FO7mcF7YGc+lvJdZkfDhzuY34jMwcUK5ckG3xGy37UWg3CB2E1kauMc81VpBiHZD+ucO/GzvZG2YZkveo2xgiBL9jMqkzFBPZpJBDVHoEVQAXp3hXZqe7eEVmaKfivLWpHY74SJvgQjBnaNUuPjlHe2P+rWGdqreVOeCK8hng/s
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2906002)(5660300002)(41300700001)(38100700002)(36756003)(6666004)(86362001)(2616005)(107886003)(478600001)(26005)(6506007)(6512007)(6486002)(83380400001)(4326008)(8676002)(8936002)(44832011)(6916009)(316002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F6xAtRckcRKFHGCRFp+19vFQKpE1U6ze3pOpOmu/AUP/ia+LvazGNLwK9Yta?=
 =?us-ascii?Q?t4oF3jmRrMXD+FOFeTBX+QbhaW1j2oMkHC/s0uNbITdN+BiZCX6mzWMSbBhi?=
 =?us-ascii?Q?RKNf2wknsyaEe4c3AI/Mi48xX52Z0Zed1GvEYgANgpvdOj5REzbmSXNtf65k?=
 =?us-ascii?Q?ib9aTMMGy4tjZklrgEwNxId2OXeUACCt8svLn2EFo0sMFkGbG3Fb21XAESJ+?=
 =?us-ascii?Q?B0Kr/m+Ei4Sp9doIsDSrN+ec4UBhB1wy31DOazIfQNLGH9gpl8QrgDY3XdbD?=
 =?us-ascii?Q?CVFrOlLt+C8zbo0Ja07o/LU0Qupj/GE9hfYKd/QRxNFRLOMRtD1Ixm3bo43j?=
 =?us-ascii?Q?zYESjufE0luX+HVUTfjMAAR77fXHZgAroSTx+aLCTyiaZbh7JoHO1JZMI0eB?=
 =?us-ascii?Q?WAlKhWUwC7rZNBJA+KCPsKhFRXYQQ0yUzZp42u/gehm71G72HHYSnmrPBBA9?=
 =?us-ascii?Q?eJKjATxfGjiQQXXADRk9H6jrcFilSluxMu7AZJmQnw7s+5tmyaZw+xB/sSU2?=
 =?us-ascii?Q?8It59N1mHV/sIdbh+t9LCqNZZePUrDfZxK+o5MNGKlnQX4V6P8jvbZ43VKn2?=
 =?us-ascii?Q?gXzkdkNSWks0oKdYjnhl2IQc/S6YAXTiturOgbY7NERtd1AQF1GBoXBMPKl9?=
 =?us-ascii?Q?kxEPLylMuzAfvuS6SoJxSvNMTI5dMcOWzfXocR7EXqp1mcIrxupjudB5WtzM?=
 =?us-ascii?Q?+cGXbGgW+8CLI49NJLtWBpPNzsOsg8jtK+1sB1z7UPxqkdcyWBWFs87dd6UM?=
 =?us-ascii?Q?kgMl9gXSSvsInAZlDAJTM/n/ABMcttHt8T8MQkzkKV2YxcP4eoKlKlehlaH+?=
 =?us-ascii?Q?wkxJQyOEqzUg9VRvMLDCq4uiDx+HbTdGAmSstUsgcigwHF5/GFnOjb33mczw?=
 =?us-ascii?Q?x60KrfAyuwuQ1Q+AZacCHgsIVGo+IJGbYlLxE9RVssaECyiFbWtpaS+wSCvG?=
 =?us-ascii?Q?SdLyb81bQ+wfw8ZPNfudXN2ZZM8EoeHTgAcxp/lwj7NVb0Mb5DaCMeGTiT3F?=
 =?us-ascii?Q?oddHgEdBynCWxVgYqZQXny4SsGbxt5JFE7Q4znjNPRAxccW9qTlva6NijDg3?=
 =?us-ascii?Q?7CoFCMzMDPNy6ovEgCYNTqMdMVp6kXG86HwaroD8o3G7n7bPEq6U1zqPCacN?=
 =?us-ascii?Q?MqikFlTo0ZHo7rUDOkrbIrouOFFBbYrFxGUaYE5nDLnZCMR8b4VUD9fU1XuB?=
 =?us-ascii?Q?4Ve9nrLK/RoYbAa3qzSWu7qLFtLMVYgh+7Si10emS8SybFKntVPydFBNNwzu?=
 =?us-ascii?Q?t+lqMcJnYATXnb2fitZSZLKx5I8EdXo2SLQJu7jywyQ+m/Oxx3bv6Bor8n7L?=
 =?us-ascii?Q?yiHLyw9Yekc6/aZnMii73Pm5+LotkKNhUlQVLIELvblZF4UuigIkVbQzsbNj?=
 =?us-ascii?Q?6mb+PAAdy0w4TwLYl2C88q5h00gqzEHBaIk4prbJqbG6dK2Psi+MkwLDulrN?=
 =?us-ascii?Q?al2dlWBp+68w/+73jovotdErzh5sMezJ9k50W9Me1LNFqOoCpw0gVAAKl7gZ?=
 =?us-ascii?Q?9M5jfRzs64j8v1sWqp/C9DnbR41K2cH4Xb0vamZo3uLxj8Fba9BRX7UWp4+i?=
 =?us-ascii?Q?OZGTQsJh2Cb7cuB6K/An6LM49TwQUH3pBy+9CyTW?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d8e70c-d587-4e38-202d-08dbe3f3420a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 02:50:12.8590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RxdpG29FNfQccnHTWUtWn4bIZF6oV9boGkt2ccyWL+OxrZ8C1DvhjmUQ8Sdvv7BjW6EkWyiyVdp9954+yVwJqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10038

Same as other functions in pm_userspace.c, this patch renames
mptcp_free_local_addr_list() with the userspace pm prefix as
mptcp_userspace_pm_free_local_addr_list().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 2 +-
 net/mptcp/protocol.c     | 2 +-
 net/mptcp/protocol.h     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index de10be21bf26..70f6a510e3b4 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -7,7 +7,7 @@
 #include "protocol.h"
 #include "mib.h"
 
-void mptcp_free_local_addr_list(struct mptcp_sock *msk)
+void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_addr_entry *entry, *tmp;
 	struct sock *sk = (struct sock *)msk;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6956fde61c68..f2f0ce608219 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3321,7 +3321,7 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 	WRITE_ONCE(msk->rmem_fwd_alloc, 0);
 	mptcp_token_destroy(msk);
 	mptcp_pm_free_anno_list(msk);
-	mptcp_free_local_addr_list(msk);
+	mptcp_userspace_pm_free_local_addr_list(msk);
 }
 
 static void mptcp_destroy(struct sock *sk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c30e59278080..76981adcac22 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -943,7 +943,7 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
 void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list);
 
-void mptcp_free_local_addr_list(struct mptcp_sock *msk);
+void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
-- 
2.35.3

