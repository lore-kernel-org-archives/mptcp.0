Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3414318AE9
	for <mptcp@lists.linux.dev>; Sat, 18 Nov 2023 14:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AtO4SsBT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXmTs+rkIDVULLPKOkQMJ5FTmML0sUEC4OrwF0zBgaoRwYrVO/IeVEcqrtcKAdz1Lf6mFhI1neCfhSxTg6Ig1R/aHY+cV0oassHKxIFmjscOKLUxasN9CaxWBInEXTPC2AjdcAndOjD4eS3rhTMPVx4bRMyH1LZKD9ItQHxq+Y3daFQJwYqLxEPM3UK1Tt9t31JQKxu4TKY+uah59WJoFRKNBs344qiuperjgJ4wgXrkmXYUwYudh5Mw79KzfNLtJYuunzlBgMMJPfu9aO7x09WXopSn0p9xooJJHy4paB/g5UxoCkStUNJOY8VmlHFBChpxlGz0FND2osO14t8SRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zC2jruCPfKtTtFFHrbl69OAzoOSVgLwia2UtUPomaW0=;
 b=ezQqO0b7t3RDFo6hgNPBATD6r6boWg8SHVXwd4niUSoMhgPjuqjLgXbAm02304NAag/fm1RZwnLruVU6q8hEEO0LltsKentmJoLLBDRvwYyhl1q6Ayh1O7iMqPhbHY199GSyKr4KO1aRxSsbrzTjpjI641SIS0rtnC6SyWEM22SOBeoQ9JsLn7tRe7Ob0KcRhWqvB7lcA9WI+SxeuH3RD5AELD2IDmeHv+Hn3OZsyLcx9dqokKtG4htAbhLsBnJhitEGv9K0K1krQB33L2SYbo4rNbiTJTYHnAwqxj4gYatmmqe/rmx8n+ksu194fjqSFZL2adDUq32AFAOHFJWsJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zC2jruCPfKtTtFFHrbl69OAzoOSVgLwia2UtUPomaW0=;
 b=AtO4SsBThP2A/AzIn5bT6lwgonLlkDerrVB8/Nr57IYX3lxvXgfboRhg7PiNxFv/Evm4AxM2mzObx6QBRiiOyx6qUnf9etof9RjAMSbhS2hwqIlGIfEVImDB3Ji6yPxyxMSCv8gby8Gnvu4oree/l4zQqlLHNSSg5u114M+SPr/+bj0HJayMVxvL+05Zq1LnxZHTu+jqn9fuLv1MbaAnuA8DSmpQxUSkaWFVfKrJigOpjSJQR3HFTxzTR5FlTgpvMfNKn5Yn+7m3ns7jVD8ze5x9geSTFFCoM7bxucWaRpbLmHluCJixsZzH8T+Qlem8Alr64ie32eGoNLHWnFiIPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9104.eurprd04.prod.outlook.com (2603:10a6:150:23::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.13; Sat, 18 Nov
 2023 14:31:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Sat, 18 Nov 2023
 14:31:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 22/27] mptcp: add check_id for lookup_anno_list_by_saddr
Date: Sat, 18 Nov 2023 22:28:37 +0800
Message-Id: <3866642c4bdabccf24fe23895fbd50f876c88340.1700312872.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700312872.git.geliang.tang@suse.com>
References: <cover.1700312872.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: bbefefdb-d3ee-4129-acc6-08dbe84315ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CDMH/di70LvmidFGz6eT1VtOWnC2x5X9/dcv+XPr073ABEUjMXyCy9+QF4cU6f09EkltOGEqjmCdK19IZkuIocyxc4nzQdAcOJopvZZheXbSvwjusvypErWFbY8jnLxMHbI9dz+OWAhW/WoEUF03Fzl2s7DTwfwIJmyF75kX3mjiQV99dnk/r1Q49T5Ir5Z3H00tiS5iA/ac3HmFIYxQt5U5w6G8pK/bu4Rk1DrhNwriKQikoxjaBBYUylIL7RBjnfn76ckuVVDlJNQwUTZyk6Qosy2+6DetgGErA5Vnmy9xOXxV39G7Z8Z/yR0wvhlU59PjJssl+zoXWc2Idbr4y9zXo6zpbZ3YYTTHHE8AUaV8xnW4QhWbEu0ZZZkr1TkAs0qC9wcBLwvF/D3jwCXWcYmom+BkHVPbi3FNcAQ3WqR4WWpD8trdPeokH+Ue/ERPh6oNjmBBeAecNjkHGTSXnTrGXaTgo/ur2vR74NNtdXiaqd+M5yftIxze2K8BBxUfU3nScdIttxRT7LwXyPyqykiSpmufgVYOUcJO70DV00gOyKcFo/+527FK3YxzmkIYSNeIhZkuOuSK/QPfLQks+qKlEQup6gZt/xDJ5Yxr/lY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(66946007)(6916009)(316002)(4326008)(66476007)(8936002)(8676002)(6666004)(478600001)(6486002)(41300700001)(36756003)(5660300002)(86362001)(44832011)(2906002)(38100700002)(2616005)(107886003)(26005)(6506007)(6512007)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z9mvdnUZI9ni1RB0EoZQUW26XkMaPrNc162/yTh8VO5wkT09Wwll3UbCJGwh?=
 =?us-ascii?Q?tt9PB8IGnTZQ0Xmx04vopAgQL5BW+DM5RetbdgZQv8/1w3/T6yl4RGd/FCJ0?=
 =?us-ascii?Q?5sIZSlgzckWFpnFTYS5sUGM6BJTXFLBp6eRClQ8rCw4LFZkBhMC2bKUBZk8u?=
 =?us-ascii?Q?qPFTojQq4kFfiEo0cWypVD/0VYQgiYZ2S30esrr62xTxITCdrcI3EAXxvNwd?=
 =?us-ascii?Q?AJemnfCQd599nl78SfCe06drmnRhOLWOnYlMny3lkvP8lLkw8gLlpci9ic58?=
 =?us-ascii?Q?3dgHdc5CoiO878A2IuT1XQolcM4H8CRBVkvehkTZTZ/c3Kyt5vChbwwYHjhH?=
 =?us-ascii?Q?ChM2B3Rri3ESNVgOmtwXFAxG+OpiVwg1jZSDgSUWUnSbOngMasdvaNUA1lyJ?=
 =?us-ascii?Q?kvRYkqMd+wnEawkZDbGPtZ05n+OcvWlld29SpR9hBu/m0tZldW1t2WaYCpXj?=
 =?us-ascii?Q?8IxxYeCDgsrl+NfeXM1Gd14+vNjYdAvC5QhuSGwh4faDtAXPMidJIwDnilT/?=
 =?us-ascii?Q?y1LmeiL6p1EfAekpeey8Ca3hXdh+qwIALi+hIsIHYBLSGo0MGdq/J8AsbOoM?=
 =?us-ascii?Q?SzGOYKiprRYT7d6s0OHseVv+pLuGD54muaNesPzr1H0mJ0ZcUXD0QOUeNPcn?=
 =?us-ascii?Q?FlBTAkmFEQF8VpTfTJCB5+FZ/IQjaYDntV82RQyVW+VNA0GivWVqtDq0uN79?=
 =?us-ascii?Q?rS4OBh0hdwHy9Q0YQeS+SRorGSW7SvFCJFyhfeBLcmZJzt9UoKsCGNumsciH?=
 =?us-ascii?Q?woU0ASyDqcWU+8cMTdosikiUDS0oXuru3tcHPtbIOTRpo+QEF/N6QUacDFor?=
 =?us-ascii?Q?dBZGGldaBD1SOSayZoFyfiCv0JdndbOftwQQ2ieROvcLSFUpLAGdGi7bPfvT?=
 =?us-ascii?Q?kGyEMX7dQpFF2Z2BjEPE7TZ9qnL/EuSCZJ0jcsRn/XQ/vehbprc5v51OC9aR?=
 =?us-ascii?Q?Kf4XFrD3Heeu7GX/NvlE6DWQjml/AadzlZ0GXKII7mb7tpdFIHv9tBPMkiUJ?=
 =?us-ascii?Q?wuapsxL/BHrxzZgzUukilYm9crTcAmw63LE5yGWUVbR0ltLdLjd0kVV1xmUp?=
 =?us-ascii?Q?Pu4Le44zahiKGvUJKdhJTs7Bvt6tyJpLtzrtfhqUHItoGwcc03YQTqaIDW2h?=
 =?us-ascii?Q?6mPTXK3qlfEP6rSZ42rJu29loKzPVSfMyvT5VDOmtuYorhbnqFagdnOyATGE?=
 =?us-ascii?Q?5OQZD9W2V1tJWFDUQJre+3ae0s3N3NCf1za4BApoEDjZ4/NxeDst+Tq23RAK?=
 =?us-ascii?Q?T81QQzym4zMHpr42YxfxsHSOUT2YT7udV5mGy3RBL3am3ryFNQu+3TGwZleG?=
 =?us-ascii?Q?vfUjqowmTEBy+Hb32k3PoLQ3nd9vshQRXw+yF+SpPR+Ej9AXzkgXqqrlaQ06?=
 =?us-ascii?Q?zP0CexROFwth10hP/AXchDhj8EQiYEX4rpMPNcO+3Lu/gg2S1dNbnC3ovs6r?=
 =?us-ascii?Q?dalnA8zfbCZQMIvkrdUHwfIHfW199t0gHxZPUGwl8cG0GuU5RUqUWU7Aiqea?=
 =?us-ascii?Q?DZZNaj9qRgB3UFBIBxE2xey6h8f/I4zgyi9cj21dDzcVyg05AfczX4V8hpbe?=
 =?us-ascii?Q?9V/mVdioccYAhnuxTadM46SijS/t4hZwdTwxfItSEFMuGmuhnU5DLbXZ0Zsk?=
 =?us-ascii?Q?bA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbefefdb-d3ee-4129-acc6-08dbe84315ea
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 14:31:43.4145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RrOYioMRev+5aUfS6tRAHeGDKjoLl31iLWV2/YBJLdsvmLdvgrP9I+gJVGD1H2iwdsQnA8GV3jYyZTeV4zEZ1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9104

Add a new parameter check_id for mptcp_lookup_anno_list_by_saddr(), and
pass it to mptcp_addresses_equal(). Then in mptcp_pm_del_add_timer(),
the input parameter check_id can be passed as the new parameter into
mptcp_lookup_anno_list_by_saddr(). After this, this condition:

        (!check_id || entry->addr.id == addr->id)

can be dropped, only test if 'entry' is NULL is enough.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c         |  2 +-
 net/mptcp/pm_netlink.c | 13 +++++++------
 net/mptcp/protocol.h   |  3 ++-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 77a0e859076c..d5ae2e775059 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -259,7 +259,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 
 	spin_lock_bh(&pm->lock);
 
-	if (mptcp_lookup_anno_list_by_saddr(msk, addr) && READ_ONCE(pm->work_pending))
+	if (mptcp_lookup_anno_list_by_saddr(msk, addr, false) && READ_ONCE(pm->work_pending))
 		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
 
 	spin_unlock_bh(&pm->lock);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c7c49bf4daac..c174665e4f12 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -203,14 +203,15 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
-				const struct mptcp_addr_info *addr)
+				const struct mptcp_addr_info *addr,
+				bool check_id)
 {
 	struct mptcp_pm_add_entry *entry;
 
 	lockdep_assert_held(&msk->pm.lock);
 
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, addr, true, false))
+		if (mptcp_addresses_equal(&entry->addr, addr, true, check_id))
 			return entry;
 	}
 
@@ -290,12 +291,12 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	struct sock *sk = (struct sock *)msk;
 
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
-	if (entry && (!check_id || entry->addr.id == addr->id))
+	entry = mptcp_lookup_anno_list_by_saddr(msk, addr, check_id);
+	if (entry)
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
 	spin_unlock_bh(&msk->pm.lock);
 
-	if (entry && (!check_id || entry->addr.id == addr->id))
+	if (entry)
 		sk_stop_timer_sync(sk, &entry->add_timer);
 
 	return entry;
@@ -310,7 +311,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
+	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr, false);
 
 	if (add_entry) {
 		if (mptcp_pm_is_kernel(msk))
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4a004eea9c38..02ae42135072 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -920,7 +920,8 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr, bool check_id);
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
-				const struct mptcp_addr_info *addr);
+				const struct mptcp_addr_info *addr,
+				bool check_id);
 int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 					 unsigned int id,
 					 u8 *flags, int *ifindex);
-- 
2.35.3

