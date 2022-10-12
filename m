Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60069.outbound.protection.outlook.com [40.107.6.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D53F8F4A
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 04:50:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mM7Z5kvR3cNqllqXSQoAECQMq4rSOvKlnO+HMmp4GYsudq94xbCGNOymslSYeQVgirtXNhF5Xm8WX3Qc8nZhjrquPat48/lYx5bLa99nW03pHbiEO9pU+moaQxsLr0h2M/0OGDoDjh12uYKn88dvUTdrNB0KfoReVGra6qsxMzCPn2adXrBxxts9PGsNYYmGQ7WZQyXf8V0pqFhXTNqaoWCKApcE/CwFyyixp2VBpe9FPhR7HnuYbkDa142qn0hpD5EUO2CH96TmWKe9rnyTolnWL4IppTDVNhL0nnatGJP09MZCiRHo6opRdPvJEYVA5LnmsAJBrPl2FxdxLjyMZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LpdY/g+tBiEUovNjfo7qICy3b84Yd9DVMb/FwKXUG0=;
 b=TQ13TvQWNwP9jyB0xNTroSbq8W/IygNiYN3vnPeZ+0veHWPQteDk+4+NVh4XxMKg9uJUEJNdJ5Q+lw6ur2+UAQbIZYkhhqQN26MahiIEAiON3SzqUifxFHjlMiEkcCztbJ6g2eiBugu+eoegVJatIS6TqDCDMpCK+cF07CeRlgaMZdmEJfgzmbun9QrkkdNx4qkhj0Nn53joNxIg1RsmvDQjBKI6vw97jJZdlawo7Vnj/4zjZfkI7mHwrp/4Gu90lzA0G7CS2YNi/dVRKuzxKAiTG+gRRjvOGNK/pzGQ5j09zd6aLaVy7H605nxnAB4CiYod0BIKy3osRrnf0k6OyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LpdY/g+tBiEUovNjfo7qICy3b84Yd9DVMb/FwKXUG0=;
 b=LFLutSbiDKWSIuhOvdbByxkzJ9Y6o/Bgt04Wneyj7wpEG84iQGgMrYx93h5S5cT3fvaZjY7DtVEeP9nJ0PpoP8FCYrnqCFCYSOGCFmS0cU3B4LaDoLdE/FwvlsScjOuc67apYMLmnBNMB2AT0kxDBk7tUfMzWpoAATDs+XhtF6RyoGdbyVqCLblB57EL3TY34XXR3+R8dM/rkLV2wRrpijxT4nCdrtyt5GVpH8h08Pncpsrjs8nJ3JFlOfAFzduBcZzINT9fLxWkO9+LGi5QgUSoUP0uNTyFgekg9yZwaeGhKle++i66M6SDfnDcVDvmWhk1dYHOxvWfNZ+kw+JkaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7722.eurprd04.prod.outlook.com (2603:10a6:10:207::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 04:50:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 04:50:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 01/16] Squash to "mptcp: add struct mptcp_sched_ops"
Date: Wed, 12 Oct 2022 12:50:22 +0800
Message-Id: <408456b3b8dcf84c23a999a740370cc805383d0d.1665549881.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665549881.git.geliang.tang@suse.com>
References: <cover.1665549881.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0187.apcprd06.prod.outlook.com (2603:1096:4:1::19)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: ba1fe657-af6a-4e30-a937-08daac0d55ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QcnFj5qMBdGfd1jsAsfuW8nrPawn9HN3X4QcJ96DDkiIm7NfSQl/nP6yKIP6y4qaxsGE5TW+b5KcB17FsyrEv6TqvX2+ZiE9r8u2QZunw9c0WYOz9Y+T7SbtnbQ1P/R7NT2wOBRZtkLjHJtcA+R+r868CbJ1kJToBumR14ModgSDh+sxVLlHf5GBMu7PwmHF7ggWGiUPLRn8W2cf6hotIo6faPszebLxyFSK95OqqJxqANCK+UeU5vntr51AbFZOQXGL7OyTfqUunFEKb8QyKOtsCTG9moLN1+au1u1MbT7k0wCjT3GalZZA++NdWzht4N46ksLwEpMph6biARoBGO6aZ+x8GSLGAjoGO5ABQhOt0e0GiPQ146WvKW0svqwpsn2M8eQ6vph1EQ2MDeXXSp1wWS0KmnHQ1B4lYPMDrUnwovrgJyt2NRvxus1cr4Lrz6n6QRPq2TUj9XSnwCf3LHwO6bLbbEzLIBayhgYlcanRhrbybdbiTXKHQ8+nMeZC+8FEOpaI7TCKy9QxiRzHOzA5trMhLUOEP2IMly3vuTbarE04Y0C0TjLsSzU0HDff4Y87MVJhKzAb3+EIC8XYu2nvygrEHhw8dOKiBdJr76v/sZGsCr/IgzkN9gNMPqYdidPBd1lSDFjXlW6Qt7zh7sMC/5Ja4jq/TywONuJvuipBqjRPnoXVW2GGaNaxK/fwjmnBbhUhcTK59wL3OvkZn+k7FZ/Ub+NwxMEdIYlGZfcTQS0uQ98tdti0Ig8D3iq3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199015)(6486002)(478600001)(38100700002)(316002)(6916009)(186003)(66556008)(66946007)(66476007)(8676002)(6666004)(107886003)(4326008)(44832011)(5660300002)(26005)(41300700001)(36756003)(8936002)(6506007)(83380400001)(2616005)(2906002)(86362001)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ocqjQMKhSpwZeB6DtNjvztAEcH4Ian7gd03IZjDF9NhWs7HaBaGw1/PUKVEY?=
 =?us-ascii?Q?sBANaqffiaaJKhuNfXl8p4Sgvj0vl7EyLzv9p2kBZWJ3ORyZB6v1ThPf1EEs?=
 =?us-ascii?Q?IXcASPBFMVGgAJUy7p36Y68akodNsL+bk9XTTr5FyQBW3kMuCevb50PHmPJT?=
 =?us-ascii?Q?qn4KXhCz+narOWO/ea1wWDFgqr5z4H6CksQ2vlZ9XqUfY8qUC7tiHbKN5z5d?=
 =?us-ascii?Q?9CWZkrexDBYW8HzNPAe7jOSKCGR+FlSTnNgF4p70HPLQw05ZyI6JVvC5SVVC?=
 =?us-ascii?Q?YBC9Dcu70L7c+Qu4a8KQDYayX/GHouR0QLsh1xDi0I8uv3LXxZ7ejp1z6lkj?=
 =?us-ascii?Q?HGIwJwgyBONgbvjomncw4o88MFF63kzRCVoyzsaJZHToAJQ0eHygfDCmuPn0?=
 =?us-ascii?Q?zcRpGOGNxUYvBeg0dQbVi07lFPsmYe2YfIrQtcwW/LG/pdQ6dmsiuU0asOLJ?=
 =?us-ascii?Q?O8OsAsMUFohCwLLa1q2akocspNYwFv91PEZSLhv2ejXdfZQLoJZYPTSAgdvk?=
 =?us-ascii?Q?Kc09fyKD/bOnuWZFp8H3FpKrr9zNz14qh0xTx0NG5ufAKhiiWIFrabCkblx0?=
 =?us-ascii?Q?/VMBbenhUfHK8ZlYdLpcXTMofYxgKoa+ZHE2KuepJmLfUtae/3xCgHzAygno?=
 =?us-ascii?Q?Dzldq72C7fpa41MRqVI08ym2FB3/B2Qo8Mskjtl93o34e9UOlVTMpXJP1Xit?=
 =?us-ascii?Q?rrtZR14YGenO58uuf9tgKA20ANi4Pkik6aNDrv7D8/xuPpdDTuUhWGI3mUyN?=
 =?us-ascii?Q?PAOFCaZnGOLKZsaOq9zzcyqu7xk2srGkNyP42Ak1eBhw8Pz6SBpBwmT2FDSX?=
 =?us-ascii?Q?IrRwx1Q/3Hl0sMwbn3huKCaDrCoMFdwdRnw58P6T06JPkA4twRzdxowJ7T13?=
 =?us-ascii?Q?vC4U6clPOc/OfNAg1KWzYtKe9w/GzfPqS5PTC4BUaKoppMLI9Sile9I0i6m6?=
 =?us-ascii?Q?A/PWgt7UeAZBLKzaXPhlO2TeLoUjDOgqvLNnI2fmjzb/72CIOn8vw41fGDxD?=
 =?us-ascii?Q?A1He8bVP/75Ujrsp8Kz1N1Mj2sXoYGUcFinWAodS8qxbA3ZnzdzzOstONi/R?=
 =?us-ascii?Q?ns2F0sfGh6LOWDMWAd0a5fholfAdYgLyBZzrCXwx7bNdJIkirc0X5sH6rUHf?=
 =?us-ascii?Q?XV3nIWKaC7irEeUoyvOw/gHxCuqHcts7iBe2yRdzXjXFrNZ/oj48KMfpjz4X?=
 =?us-ascii?Q?RQjp8/TF/vAgjUyEzsWYwI9xzyazyBG2VEVPOEcLk/BpZ3UPk45UpQCZfIAM?=
 =?us-ascii?Q?zNu6wJtoAk3Gn3NdH2YVF7p7B7+KFemh/JVjMGe0KJcuaDgvhWeLYI6jF3Q0?=
 =?us-ascii?Q?h1amSRwZ0iWKkVXqfgjufBXrr4RIlsj0Wcl3PpeY9zO+lzwlvRmjuOW4RRU2?=
 =?us-ascii?Q?mpozHNSRDB864G/6fCHFiD1sQ6+X4SsIGEZs1/nB34vTR8KZQyIbOne1p7Nh?=
 =?us-ascii?Q?9CnyDHhtSfmbCRbx60VS4E2BmYnsm1qAPn7qlkUeB3XTFrVDZlq2LPTBlIwC?=
 =?us-ascii?Q?DOnVWVmQVAfZ574t/ylZbuub4jpQts0FoNaBHtV+LSUwvAd55YMVGXXfwWI0?=
 =?us-ascii?Q?i8xAB9FQzdVzkCrTSO2anINq8mVSYrGELIvojvFmbYT6lHX9Kf8GHqi626Lh?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba1fe657-af6a-4e30-a937-08daac0d55ab
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 04:50:49.9462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7u7aL5gPYZXCMRRP4YZAKInFT5w3RMR2LoFRtRULgN8F+xoevkiRnWPxWFcuTuhCXdpimen/pKi20ajMF2Pk+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7722

New api:
 - add new data_init
 - add snd_burst in mptcp_sched_data
 - add an int return value for get_subflow

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h | 7 +++++--
 net/mptcp/sched.c   | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index c25939b2af68..cac5b0d512fd 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -101,12 +101,15 @@ struct mptcp_out_options {
 
 struct mptcp_sched_data {
 	bool	reinject;
+	int	snd_burst;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
 
 struct mptcp_sched_ops {
-	void (*get_subflow)(const struct mptcp_sock *msk,
-			    struct mptcp_sched_data *data);
+	void (*data_init)(const struct mptcp_sock *msk,
+			  struct mptcp_sched_data *data);
+	int (*get_subflow)(const struct mptcp_sock *msk,
+			   struct mptcp_sched_data *data);
 
 	char			name[MPTCP_SCHED_NAME_MAX];
 	struct module		*owner;
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 9b128714055a..6324a8a76382 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -33,7 +33,7 @@ struct mptcp_sched_ops *mptcp_sched_find(const char *name)
 
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
 {
-	if (!sched->get_subflow)
+	if (!sched->data_init || !sched->get_subflow)
 		return -EINVAL;
 
 	spin_lock(&mptcp_sched_list_lock);
-- 
2.35.3

