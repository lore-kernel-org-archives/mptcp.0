Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2048.outbound.protection.outlook.com [40.107.6.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3F51FD2
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 06:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hSfORCz7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+dOGgiHabfBIelfph8jWDw9JOX06lNl9NpMIGYJ5s1AGJZM//UVCbISywGZwq6+uUJm0JlY2H/XmyVwwKUP5naZP9GM9Z2NDgnuU1jpGt9yUSTMLsSiz+q11c3geXThRaiR6z5Nm2fOVxEsMYsCYxeK19q6Cv9sgv2cA3lgkl75Em2c8m4mb/iyJOZABkefBGRGLWUzG7hR4V3U12xNrEDapXuwjhCCxQuuUimsjohK7SHwfDDH1VzX+pIxBo6zYjliljBsMTjUieizl5PUBVzsky1Yiv6og9cTxxVpIeokcZC4oOd4URjM31PGqCP35u0M7oZA5WQ+TG9jm+H/VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZwUjDAc+m5T8vrRPL9heZXbcr5c4tkQFHqtSiJX9oA=;
 b=Xz4VJrFWqzSXKFwa0XfOyVI4miK3nVYsan2rBt3+uduh8OLhKTVNVDixpVsXItWu/iC5BuYzr37t04rfM6jCc352jjfEojQoC+NhVDZOdFk3VfzNX1JFiJir0EPmMVBFbhZv3zGVidcNOVFe/Uyx0KBLkH7uiqE39MskS2e8T3rqVI/cO1VnMDvVjBjYR4hhushcfc3dVltWc5TOFUPxl7bVD5ymSmBZTth9VkvWToZO1LsLwJD187k66syrgmhpevoASYv07+4Mp/ONVs5jE7e3qSiP7+w75UseXfzGJbOmbNdQA6HJB6eTDzJ760XegVe/d6dMnGqsxq7NiBLqdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZwUjDAc+m5T8vrRPL9heZXbcr5c4tkQFHqtSiJX9oA=;
 b=hSfORCz7eV8GAu3mogDfFoNGAnjc2IZPDbfbpE5SNRtq2b74+7WzLxep96cm7kaEqHF1jGZd7sAtGZ387SoOTGHWX5OZqAR3xO8K1VulB6ILBYVboRL9qi4iwJMDxNvYlS8+zTYI1dZ6Dqze4hjCHnH3Ngkm8pA9NBvcFDseUL03jCmm7k2wNYWC907qZ9HCkyhAVAZ/4Jzx3gXIaXdLoJzfv6hzlBPqljx5yG3eNGIJrQ7lsMYRiF5slHv91S2BRX3q0/EYjtIIvbKmWxhCAxIp3YADmZQEZq4qGfNnM5NSBvIPqSAXy64j8WGglPfFTFaupd2dgFOzZctDEjzYcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9304.eurprd04.prod.outlook.com (2603:10a6:102:2b6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Tue, 7 Nov
 2023 06:03:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 06:03:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 17/21] mptcp: dup an entry when removing it
Date: Tue,  7 Nov 2023 14:02:01 +0800
Message-Id: <a6cf7bb6a555044238861fa677fa61c5841aaefd.1699336526.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699336526.git.geliang.tang@suse.com>
References: <cover.1699336526.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:404:15::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9304:EE_
X-MS-Office365-Filtering-Correlation-Id: b938eb29-29cd-44a2-7ada-08dbdf575568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rnepUYL71B5+DsGlANjNwVtI0yZiGzy7IqF6I8shLi0VAQ8Zm4310+i2o2ud/KDpOTs5ltpSvDmnGTqTEw+QqQ7uzGeoA85P62p0cuX3xhF9WdranB2yNlWCmLKDhcG9uMwTNCcWYI9jQWHmlKJ5WdNAOg0fjSuAAzts7WiXOf0iGjVWmz8QZ45VrXKcYwTb9d3GZOSeIKNk6bwQzLkQGMIeuJ6LCn5GT9GtH5ULbuzakROdjyKRz812GnrnrfWl4/uop8UvsECbQQ8T3t5OH+miMHQ13RV64gzqX7/jZXTJUU0UWwHMTqsJiCj+RQSUB7ZMMvyIOpauAdu+/BennO1jHgOgr3+46O/4sdncboxm9Igz0VoI2O7WhfLo9Il9f5w9qXSZoCHu4+BqTvgGRmo2rf7fpSTpvT2rBomu6I66QAt8OD+6FhTUrNAw8eoDBNrFNQVqDDjIPA5L4Bb0MJu4TB5wmd3fkVli5CH51ZnqGPfQYBaS+ORpFWhzS2f16medIbN9cdqYoi/4b6yskg4g3221Fb79RIxD02cx6EbAOtxD1tdnaandsHpiFb7/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(136003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6506007)(44832011)(41300700001)(86362001)(2906002)(5660300002)(4744005)(8676002)(4326008)(8936002)(36756003)(6916009)(6512007)(26005)(107886003)(2616005)(83380400001)(6666004)(38100700002)(66476007)(316002)(66556008)(478600001)(6486002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ikG2Ma6bcGwh27+bsM3VEcZ1UynjpUqi7+VyFCLEa7lwiDa13ndsrdUCbuca?=
 =?us-ascii?Q?x70hn3PZR+PgDLSEFNXYcpIpqm5lyb52SSpCbJVp1cOSdwYJwo+9JGpb97jy?=
 =?us-ascii?Q?E+6Fk27d8NUgnbOTGzIjdmUsEo6rL2IAPEW88eB3/c4r1TpQhbkymwgCyKsF?=
 =?us-ascii?Q?c1eOmaz1a2hk3qnOI7FZjnC8sDpvOhlXFKZIGD4MusQpBFe+V4llDqZ0dwLI?=
 =?us-ascii?Q?tLTpiWgsLcu6wk9iWR0J3f0arhzNqeCBegOF6cBdKxeHhbVN2VLhDU4HhZOj?=
 =?us-ascii?Q?MqyoFbYYNWzZ9tBrAL4TlRzzOaNG9czTJG/TMhE8QhpuQ/ZZUETcetKlMLyo?=
 =?us-ascii?Q?dsAOH/Ctt5iWeNI6vtt4Az9BoTYdANXAZMmudfjRadSn6prVwNgYf/botDOm?=
 =?us-ascii?Q?vtVUEV2d1O4ExyAsQrEVoYtKAyKtDMB5+cKixtnpLi93dbD1tcR/lQQdXv5P?=
 =?us-ascii?Q?LNiFpS6/AyjK+Np5M3Z7TlDNYZlgwQXlxSNfuOWYB3p6xJqNAyIVL2epfOz8?=
 =?us-ascii?Q?dvW7+kFdHB277QrMAVZJ/rlZ8Q/wP5LUJdWbTPP8AUDP369t6uB94Rtbv/JO?=
 =?us-ascii?Q?bkpUc/X67ReXdyEDJtEDhQz2SGik5VoeEQB9xP9LuCTW1jUE5YQh+TpzDnnd?=
 =?us-ascii?Q?pingnNnermi2cTslv4UUTkoyGPT5k9N9L6rNxPKOT9c87RBSkqHqp9/l/2+b?=
 =?us-ascii?Q?MvTVQnpoPInHnbKDeRahUy2HUPnyZ/q+OeqLhwrk92s4ZDsoTT633dCZX20b?=
 =?us-ascii?Q?8N44Fp0Ewaes3Kf3QrG9bS4ebqTUlOEM4dEaIl5wFHC7nBQIc8dpgptb9+2h?=
 =?us-ascii?Q?Pr8fIgy3SrBq4Y0AD9GZqrQoPnaJ+mKVV+BV0HZ2wkLyg8c7/5pnjv5MYK4V?=
 =?us-ascii?Q?Q0lSWMTiiqsqDaUJT76BQSch5vfATOEv1guRto868d+JVX4dSAPQopboKjwM?=
 =?us-ascii?Q?omgex6zsw7crYGVbJmNDFfpdKibMIIBeCllQwmegZa6JhlJi44s2556tjDju?=
 =?us-ascii?Q?x4gL1Tmo2okL8Co8+uPMrWYjkLeqQ+qFpkuwu32B+F04x8kHVSqFKoPG2Kll?=
 =?us-ascii?Q?kad9JwQhVzXkPLXlSVzMhFldJU58xGc4WZjzvm8GMZ+Gt75zYQ74OjgOjOyK?=
 =?us-ascii?Q?iGO2igmNdYkt3DgghSBh64MC64td0tzXGtyxtR3/aatZA0xNzdT6BTIYZbhS?=
 =?us-ascii?Q?Oa5ntkkiufbSgEiNwHopsmdKRTTBxb75/rSojcADo23kC0oANrNTDWYbplMh?=
 =?us-ascii?Q?n4xq6HXBg0SLYFL/TBNHy0MLRsQH8IHuO/fpV1vYZUZUshYNBpQgHfy0lN3b?=
 =?us-ascii?Q?jzYUu02xfL9jjNAkswxy+FR22FTGQaKq/3hvjVo/Ts7v2M018H3TqFbZVL7t?=
 =?us-ascii?Q?C6/zdFc6kjNGwWbuvagHKVMq6qLueO5gT0Ug1AJ1flg23TQ5CpgnH9v4oqjC?=
 =?us-ascii?Q?LwJHf0VEp3l6gskH0pSod60m+kiEtF81oQp13EW2hCI7292mn+FHTQmjGSCR?=
 =?us-ascii?Q?prp7HN5wJfqY09XDSEiCzp75YtOE1bK0p9IdMABZsFffKqhD2NjJD3pWUB7R?=
 =?us-ascii?Q?6HcdFJluLBenSe57LIvHAIDBQqr7MvZ7ACsgWm3m?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b938eb29-29cd-44a2-7ada-08dbdf575568
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 06:03:59.2314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yg1vWFP6nTh08UskMK/iSBtSvmf+6qGtbhBmUMyYcq/pYHaqHe8WtmgmFu5C7NAQwYgO+q2KN2WAhtLJIWydJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9304

In some cases, the address entry does not require free. This patch dups
an entry to separate the deleted address from the free address, so that
the refcounts can be added later.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 5d8130581654..7ba872813933 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -303,10 +303,18 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
-	list_move(&match->list, &free_list);
+	entry = kmemdup(match, sizeof(*match), GFP_ATOMIC);
+	if (!entry) {
+		err = -ENOMEM;
+		goto out;
+	}
+	list_add(&entry->list, &free_list);
 
 	mptcp_pm_remove_addrs(msk, &free_list);
 
+	list_del_rcu(&match->list);
+	kfree(match);
+
 	release_sock(sk);
 
 	list_for_each_entry_safe(match, entry, &free_list, list) {
-- 
2.35.3

