Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2081.outbound.protection.outlook.com [40.107.7.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFC81FBA
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 06:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="oFu+jOEM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fmr4YYfpIpwhxktcpfUW6h6T6YKqCv0zAXo9kMSE++cGp/yOgV1qUCLMsFCpzsqVkA7ftfrfdRfP/NBHUarrm+J9+t/XBBR+1SYPGItQErGvDLy/mtCO5+kxaVBwBilOGMW0aAF4knmuD8H13ogHtmEDBeIf6f4aRL0tNA1jRMHb8YzLkbEbnP/oWKzKGcagee6Nq2v/4+rzTO2pRzC6rmsYNaJuVvcmTVD0E2HdD+tL9SV4IuV31Ep4TNAGIuVNT0HW/RXxptl0zPQGvt4enQ4cyvweOC6S6/lPYJMDyc72jkU5YYMFfvPXFCkAfRg6cLezaoyOSr+PtITMyQsEdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cF+z6uN5edzwJWV7abOzpoi0PldDrgYlJA7x5/etgv8=;
 b=Pj27b6B0/niJg1QpsZALuyGmzGvPwfmaczJ3sYvWu6LSuNUDN84YtkxgNU1GhwrNdUUFG1U+oupx0RkMxXFm9dFX3erun90rcQomGmGapd5BG5fJ9AhMoBd/aJkZyewRtd+p+/LW8AURRF9aZTpTANVG/D3BUkQEYnM83hAf0W3Ihj73yJH1278zCni64/H7wxnJhZ4bXARh+MIcvUK0KCtCBIlvluXIpRzM98ySFUNlnkYAUbd1eM4tUXYFQOR/9udkRwm750ftQQGF+jaYZByKHMOuKvsXClPKrAM/oBZoQOE0aLzCTwR0q/OkQ4gYu08FNIURikA08WyBGTt/UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cF+z6uN5edzwJWV7abOzpoi0PldDrgYlJA7x5/etgv8=;
 b=oFu+jOEMDWasfIvBPfDp62CFILA3DJUQkxCDHwNbxE2G/Q89yxNHHVAAABf6DYyG9z7Dlm61kDF3mr1MRLC5guhC4dYeQFgSWuvXraI01kzXLykIxhujMR0wyedvkd3ThjaSQ4C0/z52XKDELw/yxIPC0Ote3fxOOA4UZnulQLZ0DX4Pa4oilfktbjA5nfsGGajAhanQd6TApUC+ImFxum6RvJYSFDsjBQeKackQIgRRtYrfgmHXtLIJRGTg59D2Z+PhYBftA5BKacx583vbLHuFLwfEQAZlvxZaxnRA4JGtFTW6INbkOxks5Zwrj2scAlWRtcZH4wyj32Wj0eA8PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB9846.eurprd04.prod.outlook.com (2603:10a6:10:4db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17; Wed, 8 Nov
 2023 06:51:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 06:51:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 17/22] mptcp: drop addr_match and id_match
Date: Wed,  8 Nov 2023 14:49:47 +0800
Message-Id: <7aae46b265de86e0e419f8c1817d93c88c5c9350.1699425895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699425895.git.geliang.tang@suse.com>
References: <cover.1699425895.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0109.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB9846:EE_
X-MS-Office365-Filtering-Correlation-Id: 36471312-ec5e-4c9e-46ba-08dbe027262b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xX+yaP8XU1l5awy5EXmr+zFzDZ7ova0sEHOz8lf12kRiiQg/9h+LCqw/Zd1IoGPSKRkJkPlOavYPoQVCP0Nv89BNIokqQE8cXFTC2QDrhrm+aNPb9I9yc7fljdENiHvF5y1KNxT9ASn5JqfQJcv1vjNEdRPKpKE/yYZfZjyjskeAng4FslXmHgluOwd8bgbmHemGafFRQamImdSLOk4hCyy0hQw5F6P+oagJGmFVcvYLxhQlKJHtNaLh321+G3xcgfI7wm6F29iCHUcJcW1X5kyuwEA0ld04sFubAhmeFTieWuE3WMf9d3LIooDMsm+T3H+cduYBCQQrl9Lz6H96+03D8Rzi6xyg1tTmHeDUYKz6A0qIBMqWt2nZsHLWk++hR7uXmuQWn5bHdI5DEYKAkLcv1z9l3h/F5oO1pXO8TZOqOB7EEDky9QSjaNmnrBUgP4OpUEYxT6+Q0KTU1q1uluzLsISuDAj0KARf47//rXfsJJJjsoJfgA/QiwT+uZUK93vnI57KsmcORzimSR4jpvi6wd9MCjCJ4Tu5XtT6aMdZZbknKHpxJjLqVrm2o2cIPJ/hHb7hm1lhX0cFU0PjXQNkrDmkp4LYzojZj2lxOB0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39860400002)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(86362001)(8936002)(41300700001)(38100700002)(8676002)(4326008)(6486002)(66476007)(316002)(6916009)(36756003)(5660300002)(44832011)(2906002)(2616005)(66556008)(26005)(107886003)(83380400001)(66946007)(6512007)(6666004)(6506007)(478600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Um2j3ZEz/yfQupt0I/klDRKbrlMRHy0LwmFWWHL0H8JUBYp3NO5vLC51Qjp+?=
 =?us-ascii?Q?sCxcDWWhwKTBddnh/IG5mkWV/l23zRqMaNbgjb78UDy0IIm/065VsZEd0b22?=
 =?us-ascii?Q?GsWQ5bhU77TEzXI3kwatXE+X+DjiAS//VRMYaZTXjm0gbcaUd3P4AqpGZlJV?=
 =?us-ascii?Q?gJ5YYFzb6eItUKIuRYzunoBTJusUxb6fjT8GEBaQV1fSwhxdXM3y6iPV/DW1?=
 =?us-ascii?Q?A4EoyNLBwMffQDYIInoHlbY41RUblT9AptWHHMElPbDyuqQPAOZmcp+civAx?=
 =?us-ascii?Q?8UfM8Ixffzk7cBokNqLYIGYmqKTDxd9lT8WamGaohdSdffWFm91Hrsb2Lr7u?=
 =?us-ascii?Q?8uk18ai9i3LYHFCiBeOrQBMppi6PR90zTvt666EhxiycArhxkRVLBDB2Mlom?=
 =?us-ascii?Q?9G2GpA+nI+49jWtSTFEInufrA9IS34eByy7b2IwyA3VTFfzvuaP0MGswfqC3?=
 =?us-ascii?Q?5WCaCQm3FhjckqY2Ja/waPpJ6+7KkwGcikSHcJ3QQJ59oD135WX9yRDUYE20?=
 =?us-ascii?Q?4EHU42WayZbliX9KJenhI5ajXymUdxiG/68fx79zp+siPhJU7cdsemXJmnSz?=
 =?us-ascii?Q?6V/l2I1WbwlDdJUGM482os0kh1U2xaMuAAW56esy1HV9L2lxLA8ejPruZs8W?=
 =?us-ascii?Q?0jwbwhWe8so/8AXMu+0zoFA9FAYzSprnCLj2itN/5yJkmNIlKADU+f+Pdnuk?=
 =?us-ascii?Q?zbA+d7KpnQqFFQD0vN0d9CGnEnOAyYyigs8XsPli6O47tH/30QCJBBerhwU9?=
 =?us-ascii?Q?pYm0ypzyD9IoV2GiNbtn2VfOalIzUC9Vzqn7Wl7EvEZ9pkC1cB1xYtQhKwH0?=
 =?us-ascii?Q?EAZwySss8OynNJ0lLHbWwwtVHtcryoGjE2j/EEDRwj5Mu6uQgEYqvyUArOkX?=
 =?us-ascii?Q?80pUYkVXTZE2YMM7AxziojbZRd2XNPDl7zB2RR1ohNdEZHcpM0KKLhLdKhBf?=
 =?us-ascii?Q?a5Y93vQX0BzRJZoABLCiOoLdEDCJ84HoTkztDABze/XeCxbGVC5lZSFQJC/h?=
 =?us-ascii?Q?t6mLHn87u8Fp/7Jyq2x9RvwCVISfx9g76NhQN0ovdZFV+cHm1J16bLqfg39I?=
 =?us-ascii?Q?bH0fFffv3t2O+BAQd2Brm4CDLIh7CBY+pUmcbxcqzF+XCHt8TkhyFXnE9vzR?=
 =?us-ascii?Q?19SMp5k+TEPKiDErsrysYGc3jFyCCVIC5AfBUCDco4RFvFZVrkzf9opKCgFB?=
 =?us-ascii?Q?zD70QIQ5W1MM0+fDzmzpHYadBUEa9KOK52kfyY8rS6SK29zHRw82TdOZvAYg?=
 =?us-ascii?Q?ftgC5iCeJY1I/AVLg0Ojzf3VcLQiV3d4zUuB+kK7aYmm31Df2SheZIgVhJTH?=
 =?us-ascii?Q?6OAbHF1HR60oxVdAwqjHPW+lLvBNZ1Snpsas8Ddt4tlXR0keQVbzh2D/UB0H?=
 =?us-ascii?Q?zcu9xzbI9KgWXtSdGqOvBArzh80yMXDk+iLWymkwZ8aqqCGs2VLLE5Bwuvnn?=
 =?us-ascii?Q?xJZTqo6O9QdI+iG8DVI/B78mi/ylKHYAh0WV+eIK7/M89N8BLSrLq9dGpOoD?=
 =?us-ascii?Q?D7CRoKbWnQEl2ETZtHk+a0JJRjjcbtn5uDBqLIULcjIKwV5sOMbLIhuu8FAA?=
 =?us-ascii?Q?XOyZIsX8I/WJYd1YbQfUojYnDWx46fyhmeOjBDGoaEYseI8J762/UQYmRLv9?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36471312-ec5e-4c9e-46ba-08dbe027262b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 06:51:35.4821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nn2aSh0MPvipNtHrrF2tbLVrS73gPVVmKyAusp7dmDQz0Hb36WtwqXYMDU8B1tN/dPtgQEzg5LUOIn8590IvbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9846

This patch uses the newly defined helper mptcp_userspace_pm_get_entry()
in mptcp_userspace_pm_append_new_local_addr(), and drop local variables
addr_match and id_match to simplify the code.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 71c47fca375c..994f2bfd74be 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -59,26 +59,13 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct mptcp_pm_addr_entry *match = NULL;
 	struct sock *sk = (struct sock *)msk;
-	struct mptcp_pm_addr_entry *e;
-	bool addr_match = false;
-	bool id_match = false;
 	int ret = -EINVAL;
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
-		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true, false);
-		if (addr_match && entry->addr.id == 0)
-			entry->addr.id = e->addr.id;
-		id_match = (e->addr.id == entry->addr.id);
-		if (addr_match && id_match) {
-			match = e;
-			break;
-		} else if (addr_match || id_match) {
-			break;
-		}
-	}
+	match = mptcp_userspace_pm_get_entry(msk, &entry->addr, true, entry->addr.id);
+	if (!match) {
+		struct mptcp_pm_addr_entry *e;
 
-	if (!match && !addr_match && !id_match) {
 		/* Memory for the entry is allocated from the
 		 * sock option buffer.
 		 */
@@ -97,10 +84,13 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
 		ret = e->addr.id;
-	} else if (match) {
-		ret = entry->addr.id;
+		goto append_err;
 	}
 
+	if (entry->addr.id == 0)
+		entry->addr.id = match->addr.id;
+	ret = entry->addr.id;
+
 append_err:
 	spin_unlock_bh(&msk->pm.lock);
 	return ret;
-- 
2.35.3

