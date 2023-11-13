Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2040.outbound.protection.outlook.com [40.107.14.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FA18466
	for <mptcp@lists.linux.dev>; Mon, 13 Nov 2023 02:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TzgMQfiU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqS+R0AJaNeb56GwwqVbEvpSWUatqkaOCqEULrUhHrnNh4bxhR5O3mm1LqlDqaWqidEFuz4oF0VeVwueYyTKErp6rShmu8GtEpDGyQZINeqqIIsUt3AnzICumFii21ODZNZ7nBbKhnytgbBfWZO94w7OnZ4s9TwxYrcSq38Vzpjva9HFg28rJhqONm0MKCoM6RX60BZu1qNZVHUt9pIP6JSIaW/ODUfVx4tzP3aVolP3pzAYBW2b9Tjz332Z40v3CjCaWYrNwCS/g00YQRY1IRLHBi7puX+REMHyjsCff5lAmlvGXItcMVqbNVOXA/6NUqxwhArE8eJXkwGFPP4ItQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlyJvEqbeWSpQ3OD6OWfSiEP2Cej5OMKDu6QuQbiCjk=;
 b=eY6XrsAEk2NXJn0ISfs19vovkjim5ObS8icLbn1Lv4sX1s+Xv/PzT6WqOUSuurl4tIChMOSCyMi/VrwWrLkmI51JR038CA+MbuVhdO+ZNlCiJSDtKTQHDJQait3VXdRckEogZlNaxUqUTI8/2O8ahfnZcetGW9ITF4u3xnwRfUb94Zvc0fR9odh6vP7JWV87RJh1mTAGf6qZ/8Pb3rOOHCHjB1LaYev0WFkFNs+95kPMRGi6CKTXfnpJ+aXu7UZuSMUVIAP4i3lWDwaCDtVqHQmLVULFbbeIMg1NWqMUq8H8Jf920dsoYDANXWX644yGhx1xZaxa8quHvRpm1Zf+ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlyJvEqbeWSpQ3OD6OWfSiEP2Cej5OMKDu6QuQbiCjk=;
 b=TzgMQfiUTX98WWiP+Wn7pcjdCSYlu17f0I1J1qUuTng3xPYtVubFZWX/TbzsteHbLhpepF0EPMd14f0KBa9XcTIcrmN7NFdnnAbm/lpbMVbpbLBVCTGgNEDThRVNvSN03a9lWOKj8jJCZRmS5sqP5hDyORQzweKPf6dTBVTL0o3yE7ZUsDCa2YVuLOxNYyh73EjmADdyJnqScVk9nslNrIYToTD7sU5uF4cJOVFifKOo1midwxGYgjm1CLtN5L9iSN143yEuNgjrkCegyodHhGZ63W20cGk8MXwam9loDUcGdzYSMbijSiJ8aimjwWx64ZnHoem8//PYSE6X53Jabw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8895.eurprd04.prod.outlook.com (2603:10a6:102:20e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.15; Mon, 13 Nov
 2023 02:50:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Mon, 13 Nov 2023
 02:50:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 18/22] mptcp: add userspace_pm_get_entry helper
Date: Mon, 13 Nov 2023 10:49:02 +0800
Message-Id: <c297dc43f7d99d5a12060ab389b76e96a84e6e51.1699843617.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699843617.git.geliang.tang@suse.com>
References: <cover.1699843617.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cab72a7-07ce-4704-bb95-08dbe3f351e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eSx+Z7ddIQpX2GoaUHoVVzCOfUaBzjzlVd6zVS7TDC3hSKwHnVZDFZkuOWTw9MwfcYPwlm6z2JmgqGtq50aEEg5HcO9a6wtm3oCWX7nKqOTZJ2XdgkZ8HvXLB3uYdMpNeGt/lmA0oxvXVjY/E+8K8bUwZtKoyIo8kt/NgQDAFUN5nZ8BHGwHRdHo/TQoLq0HUWr6qeLTZyPxz3mk9wlkSUrBy6Umq27ZveYERf/36PSQ9i4jfdrRYYWbjVagHHVv4FfWX28cp+RlHgV+yCTxAx/6UjGjDduv1ZyFOgzsxXhUKNh1dWJlqfXDUqLbbjcQVVE2q9aZoPhVs7g2NAXIpb9uTfyF2rjgpd+pWuNTKQeghssOCwJODL3IKHXzeXKmbtsWsRrHWnwPaJ6SEnP1bJmds8SRTqHhJEm/jMFSef5TZw+bkfzIIyEeIMhT6jOTTpy2FcqV3/ETkVOJmZn7Js+HfxYYs5uOaKuTBFPUlBkqHNa+x6HVLZJR9oYs3uulXkvQin751ZMhoga3uiBNuWY9+GjwclBz1ysv9hsmumX5oOtq9OQGr8H4/wpJOD/Q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(4326008)(8936002)(8676002)(44832011)(38100700002)(66946007)(6506007)(6666004)(66556008)(66476007)(478600001)(6486002)(26005)(83380400001)(6512007)(6916009)(316002)(107886003)(2616005)(36756003)(41300700001)(5660300002)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c/PJXc7fJvGLnEZ7n9AnkLxDch+dh48OoA+i7G+mwN3KzicbjAoCVfKSI//t?=
 =?us-ascii?Q?OFYBHDHg+0L0q5uIadRCS2z31k8fPsi97WsrFDF92nfcznAvO7aJOxtef/nU?=
 =?us-ascii?Q?Z1rOYQP7qLsR9sOYuilfmu+rnmBNoi/kgWAQvI/PuisZKmn5emHN+3wAD2fP?=
 =?us-ascii?Q?5RkhdEzEfEl6IPNJqUrAgnga6+SuO1DepLZSjbv2EZLI/q+suaL8h4/BEcll?=
 =?us-ascii?Q?f1CT4GeeidNGZeLy2Y65rVT9JlttJkOlXmXxKNwT7vLjjOO2zOCf/iWKUgv9?=
 =?us-ascii?Q?rseQJCfcWnFYgJas4zhu76Z2KEevi3hF8DRyiieeziCtzTfOo8ltLYfmes6Y?=
 =?us-ascii?Q?aYa4LYDK6DD2pt08hbhW4JxeKyWAeBt2LKEjD7AhE0C0ImAdMrxY8k+TDB1r?=
 =?us-ascii?Q?wvzBogwrzLUIL2JaGcnLKlG9cpM61rvh17s5tA4TH2a4nxTkJl4GEgdxY3U2?=
 =?us-ascii?Q?mauYxW1q/x6gCHcFhyLrUFhT4ero9QSQZB7HbYQvo2Qkd6M9PG/UGsZWW9Oz?=
 =?us-ascii?Q?zWgwt7/TL1EGTtzU9pVp3aOAGK00PW7JCZtpdZYuBf6ErvRMWQ8aotsVWq6Z?=
 =?us-ascii?Q?Cfr/7FwKRgVtMtjAXGeumXFBuCZDqevjFg8Wx7PeN6PXdj9g9h9u1HWA1tXc?=
 =?us-ascii?Q?2u80uTA9Wdoe8BMkTI7DcQpPFiOiMKnKDNpZt0/Ybl8kJjdqy6IMUL5g1RTy?=
 =?us-ascii?Q?WJta3RCefwNXE5EWAPhsV3i6qZXdFk0/hB+DQZQWHFAh7okaDR6fn8u57viL?=
 =?us-ascii?Q?+uUzrOVD6ywXrIz2D0SbDW9X1eRHIWWdm1axGysNukK5sZXWshcrFbkPuw77?=
 =?us-ascii?Q?84niq9LruD9LsMz56OTnikNcVC1HjNj9AhZYa/moKqw0dWdSCW+g0wyvyD/N?=
 =?us-ascii?Q?N8E9TRIz3aJCvlqZ5DmPuIYk4cbwzbsIb1Gp/IhtbVcX1Tsij93WimIvLhKJ?=
 =?us-ascii?Q?uQYKHeK4/xE+SMCPvEngSS0JpYX3QAubQ3f1d00L7eA5847koSgRRF9VviUT?=
 =?us-ascii?Q?g27eRhhfvhlBwlpV3eBsT337ToyoKrlIBXGNADSrNYeSBcOCaXLxmKjh4IgD?=
 =?us-ascii?Q?JRDRhs8sysbpfLs3he3jPyCdc++lY1oZM9YrT+7z8G2bw4Sfuy8IXUqDHV7K?=
 =?us-ascii?Q?WHY/TeC4xpizy6qVEL1CVxPk8lfQZ+aq2GdEk8UlD8d/K97tb7nO8rC79koL?=
 =?us-ascii?Q?E4w/N9+zjUb17UxU7FpQdYdO7AzpZdu6u8cnQCGryrQCP2ETGxHsni3mtzeR?=
 =?us-ascii?Q?2AUglLhrJo8KIrDfXiwpD6JWyq/zqzfaTosThQk7c0ndtNsEZklOo0F5AJ7t?=
 =?us-ascii?Q?+OKKojaGoQ5Eh4sK+1nO9BrTPU/aaoJ+TVYnk4ygEm7zr4wC/SnPdeBWBIR6?=
 =?us-ascii?Q?Sxwcs/O49GyqS6+sKEg/JPPXKG1UWfEI6ML3c+Lja+KbWSR0PmBCGJyf6W8C?=
 =?us-ascii?Q?tGc51UkboAFwcNpEhVag91qneWLdtX16/BndsS26C5IPQ1MUrvpBWi/9g7yA?=
 =?us-ascii?Q?RMcq0lFX3rK+c74QihF0w9WcY1z+whjbxJImthPI9qhXgR8F6s4wyQMiUaqk?=
 =?us-ascii?Q?YPywL+mS5keHb4/x9cFCUv5oDm3wigTDwJZTpwKS?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cab72a7-07ce-4704-bb95-08dbe3f351e8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 02:50:39.4820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GR4mMBo+cpzyz508hPEuZKDmjWSyMCntJ2MUickOO8VA/pKOxu2LDr1bo8vgMuXsnWGryArDa0LuipGZSrvO+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8895

This patch adds a new helper mptcp_userspace_pm_get_entry() to find out
the address entry on the userspace_pm_local_addr_list through the given
address. Use this helper in mptcp_userspace_pm_delete_local_addr().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 58e9ba51ad36..71c47fca375c 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -39,6 +39,20 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
 	return NULL;
 }
 
+static struct mptcp_pm_addr_entry *mptcp_userspace_pm_get_entry(struct mptcp_sock *msk,
+								struct mptcp_addr_info *addr,
+								bool use_port, bool use_id)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, addr, use_port, use_id))
+			return entry;
+	}
+
+	return NULL;
+}
+
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    struct mptcp_pm_addr_entry *entry)
 {
@@ -100,18 +114,17 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 						struct mptcp_pm_addr_entry *addr)
 {
-	struct mptcp_pm_addr_entry *entry, *tmp;
+	struct mptcp_pm_addr_entry *entry;
 
-	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false, false)) {
-			/* TODO: a refcount is needed because the entry can
-			 * be used multiple times (e.g. fullmesh mode).
-			 */
-			list_del_rcu(&entry->list);
-			kfree(entry);
-			msk->pm.local_addr_used--;
-			return 0;
-		}
+	entry = mptcp_userspace_pm_get_entry(msk, &addr->addr, false, false);
+	if (entry) {
+		/* TODO: a refcount is needed because the entry can
+		 * be used multiple times (e.g. fullmesh mode).
+		 */
+		list_del_rcu(&entry->list);
+		kfree(entry);
+		msk->pm.local_addr_used--;
+		return 0;
 	}
 
 	return -EINVAL;
-- 
2.35.3

