Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D475329A5
	for <mptcp@lists.linux.dev>; Thu, 13 Apr 2023 09:12:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvObf7aWHHCnCPkIP+f8qRAnrJtZ2FNOphrIZWgIVDuVvk8UX0td4OkFzGgZ0BATzKCKAD6ONvg7CI8Iws/Bz1jcr1KOwXwhPnHbJJJxi8qcITs/J287dNb/IpBFFNCPpIficbA+A66mb5MguHLc4AK15IgAoedU36naz5CziAprCHPaK6lUBvfBM2G5YsXAwp5UIatz3sz3bsJCzsLMIqGZQ7ubWKhmQYeWsuck3YluUsJrH2DsMZGkuY0RhfUuxyS+M6qW3/kbQRsWGIY+MYV3lQECobU22MwevSiibWZ+McdBeiQL0EyDDi7SJCtwtea+tku9klXwl6UWBGvRyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvWXY+rcygsHpFQ0NjObfWxPO8Dfl1bxguZBZoojt+g=;
 b=euVdhNLM6HbWlWGmeq79JxYPF+IEjLvMiGMi/1fsuwTlIbhi9gQE2TELjYcWuJU84wSatqfUwkhMsW9Vz8vuY/Yc6M/c2Xgdanh1NwJnOIeSHQqA+mBk8uDg8GQwV0ClNVWEI6rncSdEN+5JWee4hVk+qvhdzXP6wCbcaZcrNEYIqyzu9868dhSxxX4cW4zlqEUlKl9rwAL3HKrL1hOqr1tOPY0kBAXbR0DcpP6uouIIOVICXcUFli0HhMosiKcdYYZRbq8V7EPf5Mq63l0oI08L2x8I4Menm0UUFP3eZBz7q1J8gBlM2z/GK7pzAedTiUEaXHZ5QiccXmVWxZe5Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvWXY+rcygsHpFQ0NjObfWxPO8Dfl1bxguZBZoojt+g=;
 b=tcM8asB/ynISqauvLXuze4OnlBI2y93o6+WqYVoEkX/OSCsjyPYH5dy69Evk+n/LB6W3I4B2B5kk5l216NqeB9/Y55LumiM/m/fJfv42BEzdmMYzqIYINQPR01cczWae7UKjQf8Vzp7fYa5ZV8hA/n0kV3EuJIQHbp/bjHfuA/YvtpHuoiq3vxNZmPSg5aUpea+6cEhkcOZnswGv0NjMlf1CJgmciOIiixqQQdYMX0kzEW1Ls4jN8e+ml6IK4i+zUv300cood45KvFXdKXpXwYFtAo1qHFzICFqEd2UBC5PZUWxdIISNciYEqGJc5BN6SlxlDT/6ZIR9I43SVxH9lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7559.eurprd04.prod.outlook.com (2603:10a6:20b:295::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 09:12:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7feb:1f7:3ce8:327a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7feb:1f7:3ce8:327a%5]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 09:12:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 1/7] mptcp: pass addr to mptcp_pm_alloc_anno_list
Date: Thu, 13 Apr 2023 17:12:36 +0800
Message-Id: <d0d80bd0407f27ae087ad7e37eb2f58b11b7d15e.1681376983.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1681376983.git.geliang.tang@suse.com>
References: <cover.1681376983.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ecf4cc8-3df7-4430-700a-08db3bff437f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iEGtkBj5Fvl3Ebh4d+hJ9ZTSyGYrifzOgkl4svqxV68GmskGIrAmkFwQwH3aWJTAWCVyK56cfcp2S+Ahl58MOfhPIcpD4cjJ1Brrvux6QTkzZ9kxxD7jTn1LpzA5vYoUl4bD5TnJwM4eAFg5E7er1/ZRhX2wURfhtB/ccmKtfRQmtC0YU5xWEnSEMOML2mUTCqu90NMCUr4nsyI8rCA+OXhYsfHt2+YWFvTuBYGMfA/0nEW1QA+nppxm9G8PBdDqQn6H42fbeptrlzZNPJSxEHjTm2He8WJT0TLZhNXK0qV4RmV4NSv258E2gFhHlFOqXqrTHd8gX7aXoE1WC4KFPAywGAh/di/z0Iq66O+Hn8QL/2OHwZ01d3KSCBw8GCPrJ5NzItVsCg0qa9AXWGmKnV/yVeuISEo/4XtcJ0FvZe9QTu9n1mAs5G4B4lkIHaXJ7z7WaUFweQeQqQNjODWXD8C/0kjq5nRxq7DRA4irKlPgQXeKG5U20o8evuOmw9yBdph0OkwzDaBlHfMoLsLQj2WRRPwlC6K6esOgILU66CAr+x/q8c196W27E0//mQzU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199021)(2906002)(8676002)(8936002)(5660300002)(44832011)(478600001)(41300700001)(316002)(66946007)(66476007)(83380400001)(36756003)(66556008)(6916009)(4326008)(186003)(86362001)(38100700002)(6486002)(6506007)(6666004)(26005)(6512007)(2616005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ziZ+vk7kBlZ6n3t+9R6AhHZePC9wx34WS32/sF4jpnn5oTJB4j4X3qD36hhN?=
 =?us-ascii?Q?0nnckY8QnbPUCtFIY0eyvvKE+kokRosPk7Mz+7bEgik0q3MacKXQPWBlKNQR?=
 =?us-ascii?Q?FbjsnX2impOcKZbZvErrgCXcwR7aAqLqFfOy9waOkKc7D91/PjjJsLd82n54?=
 =?us-ascii?Q?4kj3VaMVaJWzgc/cxscCLPmvOhky19nVCyvLb2atjqEVtWsjyjH/ertEMStt?=
 =?us-ascii?Q?P0HKhZbvaktK+rYuFEPFzLKqv5/1ln+FwsQQHwY4AC9lZwDpTxicvywFlyLC?=
 =?us-ascii?Q?/RD/FIlIu1OHGymjdWAIfyQUcvgfJQn+PYFKxWvY1vAcNTJ9TCoGF9PD0Jfl?=
 =?us-ascii?Q?VG1A1WUqWzpf0pBtctQdU6fZ2jbmqJGjZoGZnMW40MkXQRCLHTRnSaDCtQ7m?=
 =?us-ascii?Q?5YvtSETYYE7kuVmOMiukT3Ig1HK1xIugZfOLSLdH7twlgirrxQR5p+UufTh8?=
 =?us-ascii?Q?FWYbiuio1BkA9NOJEy9lx/WHuMGfgHj8vGtGqsVK3/BbdNQ0l+0W+0XjpHO5?=
 =?us-ascii?Q?bJirn3tvsv8tM9nO5Qsp2nJCm+fgsZGr5gT7oEqTxlSpDmeD3YNzQlVczLPq?=
 =?us-ascii?Q?7CVAxCY2WcVMGIrVNuvfgjEDbcXAE5GwCd5nZD2izLnIQx+N0M7fR5pdhnhJ?=
 =?us-ascii?Q?HQRtamyq87v+VXHbguM7ejNOq7PNpH8CnAnnMypNb+rhhh6NUc3/oMLpUmp/?=
 =?us-ascii?Q?kp7k3TTgaAu37padfULruIcRl4Xw0cjVa5yYxhMRHO8VUAd37VNMWMKIYXtQ?=
 =?us-ascii?Q?cOtHUuJGqRbPA/UYcSK2WQvhadZuyeSv84PhBR7jYXGYk1gn+XJiKANIpcTF?=
 =?us-ascii?Q?0Voc+h6i5QE9x0zjlOb4l05zMUcz91UggzxlrArP0PTA1dRfg/7ylsTMN5wB?=
 =?us-ascii?Q?uhbQLz8fxtAqkebv/Iayu5jsUYWCzHeBgEqrID7mJc3pylZzr5TNK3YmlmjV?=
 =?us-ascii?Q?D+mLqIzv+fpXp0YIcJZpXS2he8ms1qEYU1/gFsaAyFWFqhuo8fzFQ+naqjBf?=
 =?us-ascii?Q?7JG2lON9b+m6gzl3ldDykkqjLJ2mt/1fZGb5EpyAdcOthusU9iQ2mGmOP7NL?=
 =?us-ascii?Q?LgvsjawWzHbQ1poVzzfqSVTWcolVyycdfh1hG8D1OST9oWyC02bxzqgnfcLZ?=
 =?us-ascii?Q?vWJ2mDMb0Wzh2MCzRUHI9mcQEtQpfO2jRobS1VoynmjBHmPk3PxQRQJgFilo?=
 =?us-ascii?Q?BH1IGyhDchKpB4ALYVkxeprZUJJRlW67Ll/AlLUlJ+iMKjnYSyC4GQLUYKMQ?=
 =?us-ascii?Q?1gCJYuvX+wJ1mrq+DDqr6tWoB0R293/ORIyBNeXn+gfHk1bjRzFFh854fYY/?=
 =?us-ascii?Q?NB5x3cX9+PXkkRWLcUNfiszKVKaxLBn9uD+nWxcLoHcXyGT91ibnauV24h/9?=
 =?us-ascii?Q?RMBrSb7j7MK9Fc/vsXbblheySX/mdIAp+gQMhyofk2E1KXHktJVok4kKYC/C?=
 =?us-ascii?Q?NxrMJWKLuXCgaJWV92L1567nW9X+QArCnV6DBNgoPRGZL9019wpTS3EBgWGM?=
 =?us-ascii?Q?5Kgev5RkzO/ovAjPbxv0XsO/wHYeUD7cRVFDIRG2eLH5sphZDKWy5Bs3LKlB?=
 =?us-ascii?Q?qIL0hOMz0IldxwQ2bMX27NgJpipOiwpFkcatpiTV?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ecf4cc8-3df7-4430-700a-08db3bff437f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 09:12:54.0335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YfK5NHWyGm5lm4Rv8veiEPvvqwjabFtDS+LSlkeIMY07eFktvhPfy44mwC7leZS8MMbGwc27SWOKGiqqzHiP3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7559

Pass addr to mptcp_pm_alloc_anno_list() instead of entry.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   | 8 ++++----
 net/mptcp/pm_userspace.c | 2 +-
 net/mptcp/protocol.h     | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e8336b8bd30e..a02822111218 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -342,7 +342,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 }
 
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-			      const struct mptcp_pm_addr_entry *entry)
+			      const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
@@ -350,7 +350,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	add_entry = mptcp_lookup_anno_list_by_saddr(msk, &entry->addr);
+	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 
 	if (add_entry) {
 		if (mptcp_pm_is_kernel(msk))
@@ -367,7 +367,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	list_add(&add_entry->list, &msk->pm.anno_list);
 
-	add_entry->addr = entry->addr;
+	add_entry->addr = *addr;
 	add_entry->sock = msk;
 	add_entry->retrans_times = 0;
 
@@ -574,7 +574,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			return;
 
 		if (local) {
-			if (mptcp_pm_alloc_anno_list(msk, local)) {
+			if (mptcp_pm_alloc_anno_list(msk, &local->addr)) {
 				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 				msk->pm.add_addr_signaled++;
 				mptcp_pm_announce_addr(msk, &local->addr, false);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 27a275805c06..4d0e54fab5cf 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -170,7 +170,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	lock_sock((struct sock *)msk);
 	spin_lock_bh(&msk->pm.lock);
 
-	if (mptcp_pm_alloc_anno_list(msk, &addr_val)) {
+	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
 	}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5a35c77723e3..990c21a97975 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -822,7 +822,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 				 struct mptcp_addr_info *rem,
 				 u8 bkup);
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-			      const struct mptcp_pm_addr_entry *entry);
+			      const struct mptcp_addr_info *addr);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
 struct mptcp_pm_add_entry *
-- 
2.35.3

