Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A937368
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 00:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CNDAUXku"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2fHvbI429tkBQNuANB3lmuGCczdwnKKgGdmV0tOQGnG4EpoQ7C2EoR2IdgH8llntvHMMdAvV8fyiPAFq5fbqSv/8b1dXmrlhab/6wZW5UiDP/D1tP4L2Gxi/wNdTywHVLNm1uRiou8pV2cMCgH/bBpML5IZX1SZYf/+9jL3WkcbSjj+t12qt6/EwtgAyb8QB/rbSzrHzblrsEdGTycLdookLDg9zHbJZC0rE3BGQJr5wcnUYXemubqKnZe3FQ5gMb11rrjICpyLMM7KJ//K7bqw5WdNhuBOor9rQS8F8JBpabwOmgYYMlzr7WnbU9Yh0/yEK6Ze83xxfwqnw1LsfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7W4siDtsD4ZQBVeJyE3H9+b9FxO7aUsgZwDf4zyMnCg=;
 b=gy6YucW/Lvvc/1E7IlBCtnfC4Y1pESx9LY5UW0cH84Fw6a3TllEeXtOh7KQDs0RF7IaBsOeTe9YVF6tkkOLHkFJB5I9zKcG3IpLCIGG2pnd8gXfdUM64rEGmk1TQmCSQCk38ILQ2+Jj088Kofkh1ggT9ZwxZ9eMZpHVQJgsRLK6/kUTjd3qQVAUExot6fjQuFpOUCCA2QlX5H7in+JvuGgVx9YpSR0gKA1882z0fv5P3P5MvahAJrYgcxz5ycvFdkPi/vGSMxES0ozFt+97v6jiXRLMt4sPyHYDW5b/SDW173XE+0MwYyrh+YwzMO5h5AmRhPmuR4bELmJGXnu37PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7W4siDtsD4ZQBVeJyE3H9+b9FxO7aUsgZwDf4zyMnCg=;
 b=CNDAUXkuSOdAHaxaJsBo90AEv/jrf9iKCkJtvBP16tBh5gVijPfn6HoffaVPuMLvQWV743SkFnoMrB5VT9cv9JthBVtGmOYxATC3a395ye3Nh5KQG6Bu8LxAbo3k1l4aSHPGe8nlf1KVD+4zn0k1so5pkuafQ9xALQ9jQHKtN+qx+pF15HxVt5ETxeYrwxCZPH5KUTeBDQPe6pWAeqkPJHDMt28nRQeuxAhsgZO5VSFkPhPtPbZWRYR15nXBREmp3eaWUCb3WlUwDBoAdLPdWQiBqVhlrsN22g/x9qMNU7T0mXVUNFzirDcDR588f1Rbx3n3CHE0RNRcsyql+R4H/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6989.eurprd04.prod.outlook.com (2603:10a6:803:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 00:27:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 00:27:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 04/12] mptcp: drop addr_match and id_match
Date: Sat,  4 Nov 2023 08:26:15 +0800
Message-Id: <6e128edc8d400b52dea1147cd652263a85e49447.1699057244.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699057244.git.geliang.tang@suse.com>
References: <cover.1699057244.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: aad7f6ff-7ffe-46e2-052e-08dbdcccc7c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NfOksxBmxNZVgp+kJ/6ekFBJtkR6BgD2ODSWu7k9TJvk1u6j4Am9hA2sttd12W6GyLvyvOiAQq7n4ovJajC/4aXPFjSnQBJ6rcsWtVuQdHinOPSlE04LRnyraLbD70Wt5ap5JD7c8dTGorTsPvKIgaO4EfIJvFuDwtJOJWN3/jRI1aUeCvWazk2ShSUFSGKnIXNke4lm+b3Yndsj8NxslTE9LEj9P/gVwqIaAqn3JskEpZk23uUwjVy7KxZkJ7199/wlZLqQbmbLs90ak/IHYUQI9xKL3RtDDAwY5lCqtLlpKR8tRLwa8didsz/YqAEeKT2OZFSb8gr75hfK6KH+oheteUPoDlqEa7RyooHZurR3rOIpnRKFAyTdc2ItNIitBjM7RkTKGICdCBVsUHcCw2lNBfVe5xjw/B4WEZM2iUGTSZFSlbdbpy3kg6OkAQqeq2EKNLMAUuE+j4wd47Yf83LKAou9WtKwEn2sBkek7Dkdh6ly1Id1JGTS318g1nYY0AkzvxEqRRLNjzcE2CIpWDj4H0bDnL8VVQSy28BzH1h+GQXEpFgtd//uWEc3CHyW5tiEVBAqt7qXSOdOw2zRsVYQz/rVAtFgAsnc5eIF3BA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6486002)(5660300002)(66476007)(66556008)(6916009)(8676002)(316002)(4326008)(2906002)(8936002)(66946007)(6666004)(478600001)(44832011)(6512007)(107886003)(41300700001)(26005)(2616005)(6506007)(83380400001)(36756003)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b+YFoJ4+gMcdW/tjOoGQ/LyEZ2hYhLnaybnbSAM2ffHFoxC4+2yL342oVyOj?=
 =?us-ascii?Q?SUs5GA66Pkq2h5n9N4RKAxxq/IPx2rvopd1dfHQVTeIzBHmKaMaeJuiJkEx/?=
 =?us-ascii?Q?wnHDXIU1IYNa8tTl0DGW+PNYeY8K1FxM7XdLuk1UeTPY2zdX0hfn3UxLRAoH?=
 =?us-ascii?Q?pu6cnx5r8kkrDATuG5Z7qhf3xtirHmNLnh1qod64o3ywhu6Hvam5n4/Cr1dt?=
 =?us-ascii?Q?IvNTPmlU3ROAw5wONocb+hDJmzH6DOW+vC+q/qc3tCCLVrFHavBu6/4xxhqw?=
 =?us-ascii?Q?Urx90cAsXz8LRmky79+kLV7JUZds3eS62q+EDDNg4EVaUzm3cAB3fgc84181?=
 =?us-ascii?Q?dw5PPZ1hM922xVGqC6Csbu18gjJsv6hJ3hHDhZ2k41htv/joRWziYtHUxFPo?=
 =?us-ascii?Q?QPXe7xqxtrOtkk1x8iy8HecMPpjeu3u5DdxxCttNK2pkuIHDUx/FcK27eSeo?=
 =?us-ascii?Q?ORLHWQmOvR4+7XlmtX4l775pSdE0A0TpjNret8kOoVwNBj6tO1nn2n5Yt5Yc?=
 =?us-ascii?Q?l/Clookx0eduEKTVSk4GRhfSImA+2pOeOZgSyDSjmeBnV9QmPFRXd3RFE54s?=
 =?us-ascii?Q?A7ohe+WP9To+91eTwExP2nQA1jwnjzpvZFfFyAeU9xT2WC0woLQQDfx94zvh?=
 =?us-ascii?Q?xc6fDnllpzbAzk/tGVomqh4n1mNCk+c3SPFnOmiHLfflke5uQFWZdLASFx5t?=
 =?us-ascii?Q?kLScJvVyNUKUZTdr9S5cogP9J3iwS2L/AcZu5OfnCco7XZSWA8/fYg5Y5G68?=
 =?us-ascii?Q?jM+nAGKYu1Qys//RYR7rt013StZJdzGY4npCM3mS3cgrsvodIqnIZMi0w/Bh?=
 =?us-ascii?Q?1uOt2C0/feh/5O7Yq9SzCwccMImAX4UQ66z/Z9w+P4qD5LruIov1Q5xiCTLP?=
 =?us-ascii?Q?tTEuhWl94NBLa6IOzlLZ3SV9TNogRYBCKeU1MPF9aovriQp79qw2szouObOK?=
 =?us-ascii?Q?6g+XPEUjPIaoODjIMH+OykBpElyMIqvdrgJSrueqaE0C41R40Ogxt9qQ65qc?=
 =?us-ascii?Q?h03nxLNsb/b7zwcyWq2gAkTUlK1uqMDdasxkX9loXKsHgakp+wnnWDyccchW?=
 =?us-ascii?Q?1ydsf1l5vYFEDA67Nx0MWIbeZS91m4fYvb6FjQAP/PTw4luYNM5vy5KxKqRK?=
 =?us-ascii?Q?vd1VBd1lGGjYq9fuPQK+vZ1QyfhgfvGJpcDZ8zcRXLbQfTQDjGEW0X17+XgK?=
 =?us-ascii?Q?KneVIzd0DYkL6glx0av50Louxxrf5VrGrN88CRSkeeSlYHz4a9pKdh9+4oY9?=
 =?us-ascii?Q?LORzzBbWEyZZj4l8843k2Cg1zNQqSVHvQ/BwRet61m46WW8KxsZ6w1fB2AUo?=
 =?us-ascii?Q?x9IiWJACMMxhTuqlrTCW7JV9GB4O5k5Pj4Z7dmrNzHQQFKOYqcE5zcPBa8rI?=
 =?us-ascii?Q?HXnL92kHameM+k+xafXbiwvUQL8GNKAUIcEXqsccR+EJMo5T0gQCZQkA9f1t?=
 =?us-ascii?Q?4Jm5Ok7IPu8df/5c8jGOrsq+d8BQZ8yc0yPMDoyyFq6Veq4uYww28PaoIKhP?=
 =?us-ascii?Q?Lho5fD9V7TQM1ggi4/4Rpa4El0cr5nJk2z9oWaUyhFSkyWorAdMl9tn1Wu6B?=
 =?us-ascii?Q?G2h5btQLoo8pBl6870oih1hHvS9TtWtM4dbl435h?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad7f6ff-7ffe-46e2-052e-08dbdcccc7c5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 00:27:08.8431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ryFLPvD2pt3/Ub3NZ4ShPBoMLUYRBWeto3I1joh/bGRx2/po6ryA7MFfuGJ40i2mzSJk1GKsIhzGYVHDG5HeFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6989

This patch uses the newly defined helper mptcp_userspace_pm_get_entry()
in mptcp_userspace_pm_append_new_local_addr(), and drop local variables
addr_match and id_match to simplify the code.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 6856bde6c74c..b7fa9481e3b3 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -58,8 +58,6 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *e;
 	unsigned long *id_bitmap;
-	bool addr_match = false;
-	bool id_match = false;
 	int ret = -EINVAL;
 
 	spin_lock_bh(&msk->pm.lock);
@@ -67,20 +65,13 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 
 	id_bitmap = mptcp_pm_get_id_bitmap(msk);
 
-	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
-		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
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
+	e = mptcp_userspace_pm_get_entry(msk, &entry->addr, true);
+	if (e && entry->addr.id == 0)
+		entry->addr.id = e->addr.id;
+	if (e && e->addr.id == entry->addr.id)
+		match = e;
 
-	if (!match && !addr_match && !id_match) {
+	if (!match) {
 		/* Memory for the entry is allocated from the
 		 * sock option buffer.
 		 */
-- 
2.35.3

