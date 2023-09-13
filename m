Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2045.outbound.protection.outlook.com [40.107.13.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C69E1DA2E
	for <mptcp@lists.linux.dev>; Wed, 13 Sep 2023 08:02:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBBRDSIc5w/GTWzhZABlwGwz+zMQUVCPr+78J+oZSNZOKgzWmI5hVGRBEH9Xw+2ZrfEn6jeI+NJ2693lI+wwbl1iyEuKoXEwzKWR91AZkJMfgVhoqGQGXe9ayez8r4GAT2iGhgZOkO29Su81PLnCButNADMcDHhypgcQPSPcAW+UIA630rFTz0/C9seUZnw2H/tQIkyn+gHbTM6/soBEuVTM90M1Xa/rUYWxuM/VvyqZhEP4CPNr7nJD7/nCJFHoI5MK+Kn/dJp63hThA1K6m6E20fQfNS+5oI2Gq/lvCcYxjXD1XJTVk8k8QxFy/J5VleGaSIY6VMXPM2GjwTQWfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEBK3dSuCi+W4a02ytkoDtartq5tGNHEuuuUWnZ/cd0=;
 b=kytiIbJ/HKyATXtvyTtJS2GCpIGDx7tQBFtDm2oPZZjbu1fx6wxLNgzmW7pg1kZWwPtiIVsBE1U4OFHb9ycI9sLLxBdHU3DT0kIa2o9GlRnukf8XSQtcHvQviw3/96rUZ0DTcb2sCsGfM1XezEokKLOvCScvQ9pvk9DRh7T1L6QaZA7Z+ixHf9VzzTINQmMuqIAfr99+taCylQuGWw3uZL4cgKuAsS0e9UWAT83cuqFpWQ2jDAj94F4XgyTBHHbOUmcPmGBpjlxMxWysvyG7YvIhyeux0wOyJBk/3AN64RSq9PTZ7Pqv+uJ5B4A047lfCVsyYV4snVPxhoe2efUjFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEBK3dSuCi+W4a02ytkoDtartq5tGNHEuuuUWnZ/cd0=;
 b=F7mwLkSl87d8zH3Bu9QuB4Baxt/1Hv6bOOC/DbhwWHAr/5lWOk43AaojX1bOC4Gz2CPrAtQkI062uPOotLUEwfN2LSLvP3N5hts4SLlGdu1r3koNpXcYnXITG/KcwW+I6et3MI/0OrDVpIpkHVTfIjaO5/jvCis85q3oHI4iYZeakVtODEsPzXn7qz3dNdhG3oJshoFQYmIdO1PlvPeNjnCd6xQzJdQssDoopb7T0jbKT33F1oGBPdrYty2UUXf+mPtImsxfQCafzC382pnHLVP2T+Hy783LobemVgdljYHcOh6jhCugKpQ6fpvO5+WE33yptagtA/TzEDVIm8KgPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB8002.eurprd04.prod.outlook.com (2603:10a6:20b:247::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Wed, 13 Sep
 2023 08:02:52 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 08:02:52 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "mptcp: userspace pm remove id 0 address, v7"
Date: Wed, 13 Sep 2023 16:03:29 +0800
Message-Id: <d5518faca37fa1b14122feb4d5a2c775d23eae3a.1694592191.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0060.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:115::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: 0241647f-ea3f-49ee-6e6b-08dbb42fd411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rjt8fqMdiAawZ3DGeIz4BP/llL/qi7SFubgKIbeVsfUAhYgggSLc1Y0ucVvI8L4PVBNtvWPcfxcqgSSo4tI8vxQ2BOVhC7FCBMw/ryjfGT/mG+S/wZZNoAhnh8bnzaW2nfrNCAGyqDhc51yc3TqXrl+Ry15wmCy/tOX/Cg41wEmXoCqH4FoNi4v79Gt/XXp6iGuV6k0vOtJUYQ0KJlPZH9Js2LtHws4W9xT0Roycg7t/uyWShKtZkqqJNUdfc+ZNGOGAixn77ZQ2ZcMJ1NpAt91ag/2+92N1NZm45jqp5kHH9iO7q7zErvnnWNvl3Qn27/GkCu3NiOjoaZrwt40ubmorPS6svCxRWtlDNW+lhdTWBSl4O1UEkJ2cGZK/Tn0fuhGuXjlxJ21FonehjZyYD5v66z+8n32+StGr2V4er9oj/+gj/7B/AVOaw3XrD/relmGTitoWScPJbZjcqtG490dyci+lD1c0pUq3flx7FSls4GoncHtTpMVsW8vi5M0xIRWSR+rK9wUaB3TkDTbQW5F+/AkaY6KRcHImbrvTE12Oa2flHYZ0lSZ6XtmNIJHdCHAvlVPjUnitEJDRQZOD66w4aJ/ieLaNR2GeorZyN0c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199024)(1800799009)(186009)(83380400001)(2616005)(66476007)(66556008)(41300700001)(26005)(107886003)(6486002)(6666004)(6506007)(478600001)(66946007)(4326008)(8936002)(6916009)(44832011)(8676002)(5660300002)(316002)(38100700002)(2906002)(86362001)(36756003)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aHiXMc1rojBfAF8mgBAyAVJo7+HzRFNWIGAeOsgJXdACIK/mLQYTRy8jklBp?=
 =?us-ascii?Q?QUBs4mR4z5NdjtznDJQxSXHgSwCikfGa/uyealKH3aqwWqtkaVX/FzB9epHQ?=
 =?us-ascii?Q?4CpBmIpC4suH93WeBwfZv06NwOYwG5n4uzcgc3k5QEmDVm7qqRGrrS+Omk0k?=
 =?us-ascii?Q?Po66/4z2kU3Ad4Giid5uScTl312o97w4WtNuxSB4wqaHViWEVhXIsF24L+xk?=
 =?us-ascii?Q?2rUOaJCYmVwkx6ZJ+JLm3nAdq5MxJeCY6NRm9MvmZTN3g3B2b8PTgfSZSZQN?=
 =?us-ascii?Q?H8R86VER831FWgw9TgusMo3TIgGY5J40Zpt3R2/hbIGWO+27W7vXf6wr7tPB?=
 =?us-ascii?Q?ZI/waBo1+QMucWvkhShXuIKUVWq7CjHPVx+LD98Fbk5kE3XDuVZG9h0dF6Wl?=
 =?us-ascii?Q?vWZn8LgeDhe5el+pqC7qnvl9qY3mqKP7sG91+6xqNDx5dcwLCl27L/Z6+iBo?=
 =?us-ascii?Q?sGk0n6MTOm5ppeJn6R+N82mcdngn42EyEB2PmlebCqq8lgSvXuwS3zvMuhfU?=
 =?us-ascii?Q?9tBKrqkGXbDjarApPdRTBx+S9Ods48fldPvTaYwnlhiCy+6C01CyYTusX7eo?=
 =?us-ascii?Q?REo0qzNO+ES3tOnK/EpZ4LrYxdVSTSA1Jv8zOe4aO3Mj0W7Kwzf6irs1sQQj?=
 =?us-ascii?Q?uP0SOihLPox5LLN65zYtbKZXl9PKiAwIquXpZdKpJGRuBzKKum2Osbc+mzub?=
 =?us-ascii?Q?aARs6wyJNyepDN9ChnAyo5QDn8BV/HFhxhKO/7Z5fVmNCLv4Oo4E1gEzY8+9?=
 =?us-ascii?Q?TfktVBlVlhnOX2yW/o33KVJ1UEG94Y7rcwAOFHbbq/eTluRam7P9HSOWj+dg?=
 =?us-ascii?Q?7DmtIuUcFYWPNJVgMiArPW/3CzmbaMgkCkWf3mGXYHHFvrp6z63vV+wky/bs?=
 =?us-ascii?Q?S1V4zqjRwooZPd+j40AAZhQUD7aS12KhEeVtX5S9TSATOhxWMbawY5+ZwKFq?=
 =?us-ascii?Q?GiwyMFWrer9vXDWT8On0o9oYUKBwBJQaHLNa8BIBvX0Qqdv64TAbTF95Vl4q?=
 =?us-ascii?Q?rseRDHXVP88oRqxtIQ8k9y68ujIgYWx4wI2a0XeTC6SG7UDQMrYP688m6s4V?=
 =?us-ascii?Q?6JwdASIK2NEaXrXamfhbifZ/kpGSnMUX/B3W60eis+150sef3+s8ns6J3s4O?=
 =?us-ascii?Q?zGN3ZJdjjF1VM/Qf9NJL0Qaoc21Y6twMUZVubNRn421uelNvv6WHT4h6404i?=
 =?us-ascii?Q?KJ+fGlO0nAMMNSLFoQF9EGsRQWSiI9lSPAUMEkyzC9S+enq5+SbLKN02niCY?=
 =?us-ascii?Q?CKh0EmfHNLptJS1tM4iQqf13v/GdTliKHmlLDxvi2LpQv1DbAZiNJLmUTkQf?=
 =?us-ascii?Q?Rs4J64/VwwY9k5oYqfgO7eLjAoJkPvqsUgAmvs9h3EuaDm9FDfzVKeAqJR0P?=
 =?us-ascii?Q?L5+1LcTBn7ihksGQh4BevKEtsLRRpPq/ddR4OGgbXIfgcwzfowWdTzWg12zn?=
 =?us-ascii?Q?ecRRvRk9ED7PRz7pyxE3ErdbbJkLEMZxzzA4LRrkU6Vej7ZWlx4UmitwPZs5?=
 =?us-ascii?Q?deU2wER++ws1TGpBCZ0tuXRijPR3basPnZUh4yLYIjIKKGVYXh94HiHKGnra?=
 =?us-ascii?Q?dJToaajRipKkJ+DwHTsBIbwGoXwlfLrd/MR+I7WiLEvbksNOxBvhRr5D8yVG?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0241647f-ea3f-49ee-6e6b-08dbb42fd411
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 08:02:52.1340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6pZm0QxES1/pRdr2C3os7ATuB8Vgm+PW419WXsxnJ9YPWbBsZmowHP6uFkMIEGpbO+b3RQ7qHWW20mKdtmaog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8002

Define sk = (struct sock *)msk.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 41d2d57b570c..b0fd7440016d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -213,10 +213,11 @@ static int mptcp_userspace_remove_id_zero_address(struct mptcp_sock *msk,
 {
 	struct mptcp_rm_list list = { .nr = 0 };
 	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
 	bool has_id_0 = false;
 	int err = -EINVAL;
 
-	lock_sock((struct sock *)msk);
+	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
 	mptcp_for_each_subflow(msk, subflow) {
 		if (subflow->remote_id == 0) {
@@ -234,8 +235,8 @@ static int mptcp_userspace_remove_id_zero_address(struct mptcp_sock *msk,
 	err = 0;
 out:
 	spin_unlock_bh(&msk->pm.lock);
-	release_sock((struct sock *)msk);
-	sock_put((struct sock *)msk);
+	release_sock(sk);
+	sock_put(sk);
 	return err;
 }
 
-- 
2.35.3

