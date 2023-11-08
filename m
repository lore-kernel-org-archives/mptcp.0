Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2088.outbound.protection.outlook.com [40.107.7.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5704B320F
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 06:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R8yqTDhq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmuArMCOuuNO1ouafdalmaoARFPO97zioRqRAjE1EuzABZx3RyahO1D9EAhdTw6oHJ03V/OPMbCMFkQFDWLlTbb9hIsCsH5VVEg6YarrIJGXCdaWLu3y3fMwuqa955cJLA9IK9nduiWKafGdMgb8z44yCOZJrFa8ZUAFguAoo72nk1R+mTi3LiyoW3/4fw6i5HaavH9pzwozjCJ8URPekyA+RrgklwIbt1FJAIIO5TRxKh5LAf1D/Tt/TP/Uyj63QMdug0fiWbedkaJlYVEyiqPHAyCuKppUiSslc/3vpy5TYXaUgpxVjKsBUhk0+hkJHDUPsNJFyUUlSiAwO5Ofpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Z/jSx08fqckMH8buLmDXS6iDsvH1tOIz7nXEcKGUHI=;
 b=kMa/YOHlRUKSn+q1DdlAPgQLEBfAs2vjYd21t2IvFeg3Hv43YbEMhrKRlSqjgHatzOPcIAHqIO6TWXEXQgrbTNMYE4qta35vPkC2LcyeNBDTV0jO/6w/KSms5wyLLLNX4wwZiDrdlcmszeggCeFWrRpA/Kf1GUzscY/bxbbX9/3ggzNWi3lNqVR0Wi5Y6ArNKk9DjFLzZJxLCw/9EF91+bTgAgLHRXa2wxD0SCC3zF9tR0Ir1UQMKqblB8bHdgOR3Ga+DwcTE9ltY196u2AOi9qCqtwgTa0q7uRK1BKibMpStbNje7DYxui+6ZsO1m/2T9rguZ08K0fyUz3xMpHI1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Z/jSx08fqckMH8buLmDXS6iDsvH1tOIz7nXEcKGUHI=;
 b=R8yqTDhqou5xuMeodelQ1wjYP35nYfNqjGfnWThrUWq6ihmVrD/p2X1Fza9aOn2AiJLMK4l6a5t0FURU8H9bSJjpFmOUHLoDmR0LVcdwttptYw/oG7uznusg+/+Kngp3qtns8UvW9PAs/fWOFCuUXczexTv2AjoQz9mnAZjiIhZ1UQMDdAM29SQPKYy8i4l0af5SMfADz/1F2/Nq1HFdaoLlvklMiewGTuk/k0CPyJ1joMStS2qv+AQiK64eeLq3DHsNWn/AI9I7HU4/GER+dOqF7uh/lH0YynHtaHfjpAjPnZonnqFF+sM+23V2sYgkAKLosScl8qTol3CRZfmwMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB9846.eurprd04.prod.outlook.com (2603:10a6:10:4db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17; Wed, 8 Nov
 2023 06:51:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 06:51:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 20/22] mptcp: add netlink pm addr entry refcount
Date: Wed,  8 Nov 2023 14:49:50 +0800
Message-Id: <976e56b3ade5a20701cf2ebb2653eee2bbd33443.1699425895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699425895.git.geliang.tang@suse.com>
References: <cover.1699425895.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0120.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB9846:EE_
X-MS-Office365-Filtering-Correlation-Id: cf4c3048-3b6a-455e-a967-08dbe0272f95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AB6AKl9ZwipYzHIkN1+0N1nCFstRDq5L6UvQ1XQRWpE0Q/qfZzlicmwMPchJN1VVl8F1uTHyrvMMxHXH38EUENiYgyuLmmyCw4vD+JjIsbftRkpn+wwGdyApYoQ68xlkw4TrDF0CkvjeCAaVXih5zVF0Pr4INdCPB18gBlBTYEkPmUKpjJmjLnz4NOYonzCu3ntJE6zSsdBh+Gh0JRZmj0e35HzvlMydZNo9Rzi34VnB++5zfWg8/+DXdhowD9ri9/t9JGOeO2lIGhN+cr2Lw/cvR3bE0xXaH85fz8798wIDq/Byzc3mGO3gXmY+dv+lG4PPTNXBj3wWHcLWs/d+OKDA5INTREIH0ryWrLp3JRRkmIOKM17wv1RHrqAl62uTZf7TJM4S1heea5yelRw+FQxXXFp20d/yLQ9xZdAswJkzDOOgX2/u9FK1uz/QIKa1N4NN7cmwmYQL9ttIpFgLfoE9xtL+NDuZKo8u2op4dns14Rt6fFD+9xbzFGeZLEN0Hk/Wx588kdCn6wLztZtEIpapdq1z+6V0aQ6xF9IznVbfB/hHsXx7yem1+ZeDsICZ0Li4uSCcwmUwLotHKYsK5f6ksEG+G6KPpGXkniP9cd4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39860400002)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(86362001)(8936002)(41300700001)(38100700002)(8676002)(4326008)(6486002)(66476007)(316002)(6916009)(36756003)(5660300002)(44832011)(2906002)(2616005)(66556008)(26005)(107886003)(83380400001)(66946007)(6512007)(6506007)(478600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gIZUzllO721xcuNuHFiiiX6MEsH5dAcGjhEytOGasuZ+YJAfIc98KLid+sv/?=
 =?us-ascii?Q?rnZwkV1GLy2wrri0GcBp7EGl9P6gosPi1M7Wip0dp5HKzeAYHvQTjYLd9FD4?=
 =?us-ascii?Q?PJRZfzL2l4Oor2Aj/6PzVbfzrVp35m0QgJub/7TQYtWBpzTAc+KS/sV3hdRf?=
 =?us-ascii?Q?3g5oYo5TxdCgM5VeNuqtQa6Chlv8p32RP+C2pdqwUajDzSD1JTYwYHB8RoGK?=
 =?us-ascii?Q?bQe4fc2O5OmnMMImD0kxku+JV2tKFPNkroXNWNhWd5DNS9LGAFHA5dD8VZ5z?=
 =?us-ascii?Q?LoQwsHXgQc2WdW/FMVJO/yzSxr2hyHY3h31RDXVxka66JAjuNj7iWu10Ffnm?=
 =?us-ascii?Q?jjMqQNijfRE2jM/9puRMTPedEIWzUwS9Of+JEMHuP+bv3gMeXawypK9cjrOS?=
 =?us-ascii?Q?kbhuaSV/WSlGrH/BvJW4KW8CH3DDErOaLb7e9KkXJIoJqSa8UKdGs/82Acqz?=
 =?us-ascii?Q?GluVDhQwlT45I5uixHYmXOYhSyGJraMsltapXxLf3HCat3BZ/5U9QosNCpl7?=
 =?us-ascii?Q?y4nrastRBgg1+mITIHJ2QUtygmhGoIVzd2KhbY4rCcURF35ULWGyXFtLxRb4?=
 =?us-ascii?Q?24XZ7gxWdvQQteuss+ndquynDb/RmOKogWlbTlwaNjsFBJA58zv1eWq4GecI?=
 =?us-ascii?Q?b2KZg77hI17/c0ymK4Bf05dRfIHtO/MGJ/Vh6X27bFjrCGM6LAQY1scJ+77e?=
 =?us-ascii?Q?Wx3Ts9pO5oKFAVn8gUuLz97iSuHWGR55E0a3Tj8Ae9W0C+WSziFpLNTix9sR?=
 =?us-ascii?Q?8yMvdlvvHmYXqy5oDufF18uu5RiX+MhM9loFxLIy3nDtL8jWcYsjdLVmEnLp?=
 =?us-ascii?Q?qQHV6QBiHjzKVG/WpI0VggdQemvfmSsYVNVz+hDSLNlzFBr8TS8h/+KWpTAr?=
 =?us-ascii?Q?ZL/tDC7xvpEauU78oVtMQq7yI34663NdVITTv9OLhYaqvhMkdA/1jPZHp80A?=
 =?us-ascii?Q?Fuh+/vi3n7WyLfDWLDqbHM2n0RTUxszJgRkXJ5e2S3VuPFNn3KCLk61UyVVl?=
 =?us-ascii?Q?pjV1oX653+ymfXm6UiANPl/yX4oddyKMmxqtN1E1AOPqsBpGn50rXC26eNC+?=
 =?us-ascii?Q?ga0Y+iesRTnA70v8V9eMMR87PTQeJjIVFY6xqaAhq7BwtUgF+UUht/Dp5Qyd?=
 =?us-ascii?Q?JipwGrdle698wHDorkopbPNJaSYdJYheys/VTSMp7BLkbwdjxaboFbm0Gt//?=
 =?us-ascii?Q?ZUK/rt7mrwddEYvAm2RsV44aRZAWZvh4o/XVAO0ARyGhREq+d/SWNSjKIWjR?=
 =?us-ascii?Q?BJgGSVj1QRjQu/TsSe9ZcCu4OYOxInWRrG+u5dtmjDK4woN6X8VHK6JETwMm?=
 =?us-ascii?Q?ykTMyF7yDIjZ5OV7xsWS0l0l7PIguNN/VAJoT6WZqZUT1gd7p3mtb/Z/+aIw?=
 =?us-ascii?Q?zKjWZp0M0GFXcb2E7768/alaeWJC8PUIevQhnHKrnz/lk2hDcjH82QosI8CU?=
 =?us-ascii?Q?r57O1/QDqg7Uy5UrrnuIPQXL91JDAQUXanr3PSKJOTWZov++q1/yLj5amHEk?=
 =?us-ascii?Q?crr17aY6MDYOKqX887zncc4x1Zq5Uz71HYFL9XRuItcO5aVu8RoafQzeZ2Jz?=
 =?us-ascii?Q?N0ao6F1WaKEq0dOOMSjHYuC3meysnu+WDg2ml9CmuDzI4Ib0DfNlZ7ZKJa3j?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4c3048-3b6a-455e-a967-08dbe0272f95
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 06:51:51.2908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83m0a3q3rsXGMUJKNNvmyUZFzjKg3fhBtJqrxPp1i8Cs0vomDT057XtdDwU00l3kGVPhQtUxybJUQLSzmHpu3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9846

This patch adds netlink PM address entry refcount. Init 'refcont' of
every address entry to 1.

Increase this refcount counter when a subflow connecting or an address
signaling in mptcp_pm_create_subflow_or_signal_addr() and
fill_local_addresses_vec().

Decrease it in mptcp_pm_nl_del_addr_doit(). When the counter reaches
1, then free this entry.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index af915ba3dff5..636fc822a257 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -533,7 +533,8 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			return;
 
 		if (local) {
-			if (mptcp_pm_alloc_anno_list(msk, &local->addr)) {
+			if (mptcp_pm_alloc_anno_list(msk, &local->addr) &&
+			    refcount_inc_not_zero(&local->refcnt)) {
 				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 				msk->pm.add_addr_signaled++;
 				mptcp_pm_announce_addr(msk, &local->addr, false);
@@ -562,8 +563,10 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			continue;
 
 		spin_unlock_bh(&msk->pm.lock);
-		for (i = 0; i < nr; i++)
-			__mptcp_subflow_connect(sk, &local->addr, &addrs[i]);
+		for (i = 0; i < nr; i++) {
+			if (refcount_inc_not_zero(&local->refcnt))
+				__mptcp_subflow_connect(sk, &local->addr, &addrs[i]);
+		}
 		spin_lock_bh(&msk->pm.lock);
 	}
 	mptcp_pm_nl_check_work_pending(msk);
@@ -603,7 +606,8 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 		if (!mptcp_pm_addr_families_match(sk, &entry->addr, remote))
 			continue;
 
-		if (msk->pm.subflows < subflows_max) {
+		if (msk->pm.subflows < subflows_max &&
+		    refcount_inc_not_zero(&entry->refcnt)) {
 			msk->pm.subflows++;
 			addrs[i++] = entry->addr;
 		}
@@ -1048,6 +1052,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	entry->ifindex = 0;
 	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 	entry->lsk = NULL;
+	refcount_set(&entry->refcnt, 1);
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
 	if (ret < 0)
 		kfree(entry);
@@ -1275,6 +1280,7 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	*entry = addr;
+	refcount_set(&entry->refcnt, 1);
 	if (entry->addr.port) {
 		ret = mptcp_pm_nl_create_listen_socket(skb->sk, entry);
 		if (ret) {
@@ -1427,6 +1433,7 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry addr, *entry;
+	bool release_entry = false;
 	unsigned int addr_max;
 	int ret;
 
@@ -1458,14 +1465,19 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 		WRITE_ONCE(pernet->local_addr_max, addr_max - 1);
 	}
 
-	pernet->addrs--;
-	list_del_rcu(&entry->list);
-	__clear_bit(entry->addr.id, pernet->id_bitmap);
+	if (refcount_dec_not_one(&entry->refcnt) &&
+	    refcount_read(&entry->refcnt) == 1) {
+		pernet->addrs--;
+		list_del_rcu(&entry->list);
+		__clear_bit(entry->addr.id, pernet->id_bitmap);
+		release_entry = true;
+	}
 	spin_unlock_bh(&pernet->lock);
 
 	mptcp_nl_remove_subflow_and_signal_addr(sock_net(skb->sk), entry);
 	synchronize_rcu();
-	__mptcp_pm_release_addr_entry(entry);
+	if (release_entry)
+		__mptcp_pm_release_addr_entry(entry);
 
 	return ret;
 }
-- 
2.35.3

