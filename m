Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A79D7C
	for <mptcp@lists.linux.dev>; Mon, 23 May 2022 11:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653305648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d6uYA/QkJlA15vZpHkmitqEOnFSf0okrFwFM2m22sk4=;
	b=eYS01jZINZ/pqf0BNzSUVkwPBM/VmAM3lMKA35BN0UpuoxwAKFZP3B+qN73Rj38yE+tWpq
	KpikU/FFsU//P/1iItUhSpKVlATJma42GLDurdqjUkZicvBPXL3ml5MqrdmFGZ9nOXhBgt
	+frYzw4G08cJwXBbFEw+8xjOVhEoeK8=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2050.outbound.protection.outlook.com [104.47.5.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-ekQEoTHQMea0T55aljTfYg-1; Mon, 23 May 2022 13:34:07 +0200
X-MC-Unique: ekQEoTHQMea0T55aljTfYg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyOyqWZ6aWVZTIuE4HZ6lqGDgFdsNR/34eWwetm+TKflApaT/qGmYfxZgdGnGnfJngE7DKg3QSa9aFqwKS+DYf28ogucc65cpE44gqefkBg8ADxC/9dmQjXVJzLeCK8cZpDMq5zxY9tz+eFAQp6kD+/E74ap2h0QU9AsBrCjoCWmhflbsDaNEMlYdb0UAfnIZ2hV3Rp6Tmn4DtJu1gr8A5rwf8DnZk+clDLS5HhMauZCqHlLd/ofAtT4iEvhg/tSbP2HAuXbzmkH2SPGnDRQlyTbD8/ef1AKwzZ71vG+DKq9oLC05wiNg9dqBzb58vlkOQsusdeaRk0NGPBM95p1/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puVkancq39fypxqXnHmph7ZIbzvnblnYuc2GOiqL16Y=;
 b=m+zsz2B+LFRijyfDJa0XdVXs+ggNY/p0+4+r9k3xYU63cnOGgJK+KFYQ45y1uDw3OdwUXlvoywMRHvLmYn+opalFimyljtpLtpBQ8dceXIzvTyqKxzMPNXl5WOeCnq3ve7rmurnLc4MBBUCSYhrCEkPVYLt1+URISTO7GU9fgPyy2PYMvd+aWYjg2ZZ0bwr1AqSaTijtq60hDyMMDK1wz5faEr7FciF0dVw6WQOp6Pd6ayVM8wWdpWwRdTa64L7DuEz7yR8BO4TJ/VlG8JV1MrR6cVVVCk48yvaabB6RKGojdkj5wu6Cq7wGknywHjG05LnIixYjhlSCxvQ9CDnlpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB3PR0402MB3899.eurprd04.prod.outlook.com (2603:10a6:8:f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Mon, 23 May
 2022 11:34:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 11:34:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 4/5] Squash to "mptcp: add bpf_mptcp_sched_ops"
Date: Mon, 23 May 2022 19:33:38 +0800
Message-ID: <10e0e0ce3da96fba47e47ba60b256fd28cf63815.1653305364.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653305364.git.geliang.tang@suse.com>
References: <cover.1653305364.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0064.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56b3d82f-ad1a-4669-e408-08da3cb0250a
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3899:EE_
X-Microsoft-Antispam-PRVS:
	<DB3PR0402MB3899B4738FB764A23DF837DCF8D49@DB3PR0402MB3899.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o/yCMfjSaNsGEu73tpijUb4VKce8dcKsrS58qBI1RpNjtxItVcNf45QR/UI/bSFLel7oDUIUh3dCl72TQbjCM0hrsVi6uDc/ZKUimZ+UrQC8dWMhr0G8Jg68jj2OHywp0NoQG1DbAQxMkvKX9gUKBr9luH5+HkGpz3uCrwlrfx2pe1U07PYerIDiSdBrud5nCI1RKpai4Gyh/iIYjTi/K0GA1P5fn6w2SNpORvUjOU5mRUPKepmbcwQw8De6EUAmSw2XT71q28dxYNdc8GbfRNuGP4nkzQ0JDXPxeIbuAzkvY7SBDzhIGaoQFHNQkgKau5CdQeT9eJW8ad9CUvL2wm+K16aNFR+KMO0W+mwDgrG5ckNLOv3xDZQ1CLlzAYo1hWVNsCbW72KEMB5QHppwixQ3QEUOOXKMS90/eNmD29TIyHh3u8OVW1lcuI9caxle1XldylicPf3VW96p9Cg6gX+vuMD4Tg360ANXUtClGOXcvfGkBRdghZ8pYMfXlMyIkjT0Ob62k7EAb2vcqIPGJknY+Qlmy7+2RSe3GJGxWctEjvw2wGMMKZHL17tarKtJ88eIEk5gsuzD/Q/Lwc7WSU5ngGWbVhuX3xX7JyGS0bOWzb4Q4Wwyz+5cQ+Mu6xt7rDYCbnCmHWulZp2DFctL707McfQIzESnTQgDdalK3xh1QsXn7pQo3br5jTKO5D/TNdh/U523mIzWGcRML1YXEg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(8936002)(8676002)(316002)(6916009)(86362001)(2906002)(66946007)(4326008)(66556008)(66476007)(36756003)(186003)(6666004)(2616005)(83380400001)(6486002)(5660300002)(508600001)(38100700002)(44832011)(6506007)(26005)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aEKgS221tkFG9AsP8q0Tj9OxMHzmxfBASBVI1sA9YZrCLzKxJYKwG9MG53IQ?=
 =?us-ascii?Q?CTJrYZx2aFNWfC6gi5k6f2av8mvKk2KJMQJ0R7KLqiHBzUFkFhAfeRynQVk8?=
 =?us-ascii?Q?6YmIEqOsdMBUoS1iCg5JtO3Q/RDeowU8JZ0vX2iqPo+NtsNkRM/ABnDUxzxj?=
 =?us-ascii?Q?qRJeDK6TPf63Uo8gHBD4+iY4/1Z6FxX4u5v8TKZ5K/MEyBSf3NbssOJip9yi?=
 =?us-ascii?Q?DlWli1gfWMEtCv8Bf9sAgGiFwVjlKN/wOHC8ylKGbkqPdUQ79B2rv2VUCXGW?=
 =?us-ascii?Q?Mpml9r25KyOkP1rBFdy3ItOb8leGCwuXfS5EDexWC33gCtjBotWQHhCVlYBG?=
 =?us-ascii?Q?ioXs8yXV9lWmD80AMrOtgcrtA/A9+KafToUc8mRR4NNrcoXtWWgVSjqFFyMU?=
 =?us-ascii?Q?DJcoIsY3NVBEFQYG7dUx7WLHMlUrrLq213T8D4K83VxwWT5d3oOhpSgGls9Z?=
 =?us-ascii?Q?yIu/deLujTmjQVBPY+dOXH0b8atQ6rSJaV37SBjWhPXJp0YlsgqJcgGKow3C?=
 =?us-ascii?Q?TIEBk26Lnuf3D5j5+/IMby/zVMRlMcoVxO0uCQs1OTpUfM4qgVeOJbXOaVSy?=
 =?us-ascii?Q?limcZXtnwoOI+DaQm9ivt+N6fqE9/FU3t13e7fXoswtTnp9iirCsKLvtxY6A?=
 =?us-ascii?Q?3OZBW+sYA8wLDkYDfuYIw1ymjQmiNvEtzC6FTLyD8d0X9CHBEwOsYXPYgts4?=
 =?us-ascii?Q?mw5S5OCLWNH4a2JPaY2aGFTXbtL4SsecKyUgon+hJTfXr7tp4lOZ0xlwEy3K?=
 =?us-ascii?Q?YMEwfwwCre+RPuqMUCY58+g+KR2FtPOPWRQc9UCJ0u78g5Yd66DSOTObnLAU?=
 =?us-ascii?Q?4JQqSMtf6wF8YJS2CshD36WBStkhD0T+V/SjjlrBydNiRPHofkDcfR6mWIJw?=
 =?us-ascii?Q?JW5QsXymYhpD3Q44v3aA3rQvyvuVl6gi7byYD8hx5YqmnGiEqH21AhvjqWkX?=
 =?us-ascii?Q?61PVPwPm88h8YA6usjQyocB3ijEXxfYSlVXJEB0gWJgntdDiINCrqO1M3PwN?=
 =?us-ascii?Q?7hhyeIi5+oBkFgD3AVQ/wTpiQsuU3yF4DMSTnndlFS23hATCP+tuDQtqpJRb?=
 =?us-ascii?Q?RirujtYcfs3RN5/dIKCCxVWPkeYtXv1ry6a9KNaYeQWmiCId0871B6H1AuiC?=
 =?us-ascii?Q?6+LRBdXQTu/f8LXJkpAt4D6k0QjrLR34iWABwBfHIbRsLbk7954N3HUX5uzp?=
 =?us-ascii?Q?edfOdXr0LBtp0yM/67r1mpSW+N/Fh37ty0CC/8eP1cWm9jzaEQV/SNFSlGhp?=
 =?us-ascii?Q?mc7f1j1U+syebo2JcjsEXnF0/5KHgRQHHOW0py978iWHzy//9Rado2vkd0YW?=
 =?us-ascii?Q?yCOWidxayeLRqOfz86IAKk0VjHc/oi6edAw1Tl/jnMGNG3D7KRAHFZlWjerX?=
 =?us-ascii?Q?/8UsrLsUUqAv4xQXfO9XCJqkE1cAe+1n4esHD5vHM1oy+NRD8Kfitrut8R/u?=
 =?us-ascii?Q?2+L4hS/eL37pZ6nM4H/F6nBgVP+v5+Yj8VsukxiMuhB8jJKZqBS0oUdZOF1R?=
 =?us-ascii?Q?AAHNDRr5qband2TrRkWL1BVY0DrNPzBTdyBJepj4en363eXof1kGRhmroNVl?=
 =?us-ascii?Q?vqIgeveStdhnLZfGF9ZnLSnL9PeAtl4w+OCe6cIZlvH8JBCCfJaakuIi7JJn?=
 =?us-ascii?Q?HtQagzgN6r/1dTr/WolOl0w+MFhqwgJZA3zl4N0lkq6NZJF2t9ofuXYpV9yI?=
 =?us-ascii?Q?+I3a+7jJlxgW8/G9b6KiQNewF4R8rDLUqIo2oAUhJOHdfOpgZMuii0oIOrwW?=
 =?us-ascii?Q?A2vVEGZwRl1u2VB/ZyOgmVeWgo3DOiY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b3d82f-ad1a-4669-e408-08da3cb0250a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 11:34:06.3165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c+uG+N9Qi56L2ZH7xptie9Puw/xA6jW21LwcumwkTOUCX/ECbkxZd/t1gjFrebtC8ZjnzxVehkzH85C7E/LEIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3899

Drop the access code for mptcp_sched_data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 37 +------------------------------------
 1 file changed, 1 insertion(+), 36 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 338146d173f4..218f78514bdf 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -18,8 +18,6 @@
 #ifdef CONFIG_BPF_JIT
 extern struct bpf_struct_ops bpf_mptcp_sched_ops;
 extern struct btf *btf_vmlinux;
-static const struct btf_type *mptcp_sched_type __read_mostly;
-static u32 mptcp_sched_id;
=20
 static u32 optional_ops[] =3D {
 	offsetof(struct mptcp_sched_ops, init),
@@ -40,33 +38,9 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_=
verifier_log *log,
 					     u32 *next_btf_id,
 					     enum bpf_type_flag *flag)
 {
-	size_t end;
-
-	if (atype =3D=3D BPF_READ)
+	if (atype =3D=3D BPF_READ) {
 		return btf_struct_access(log, btf, t, off, size, atype,
 					 next_btf_id, flag);
-
-	if (t !=3D mptcp_sched_type) {
-		bpf_log(log, "only access to mptcp_sched_data is supported\n");
-		return -EACCES;
-	}
-
-	switch (off) {
-	case offsetof(struct mptcp_sched_data, sock):
-		end =3D offsetofend(struct mptcp_sched_data, sock);
-		break;
-	case offsetof(struct mptcp_sched_data, call_again):
-		end =3D offsetofend(struct mptcp_sched_data, call_again);
-		break;
-	default:
-		bpf_log(log, "no write support to mptcp_sched_data at off %d\n", off);
-		return -EACCES;
-	}
-
-	if (off + size > end) {
-		bpf_log(log, "access beyond mptcp_sched_data at off %u size %u ended at =
%zu",
-			off, size, end);
-		return -EACCES;
 	}
=20
 	return NOT_INIT;
@@ -142,15 +116,6 @@ static int bpf_mptcp_sched_init_member(const struct bt=
f_type *t,
=20
 static int bpf_mptcp_sched_init(struct btf *btf)
 {
-	s32 type_id;
-
-	type_id =3D btf_find_by_name_kind(btf, "mptcp_sched_data",
-					BTF_KIND_STRUCT);
-	if (type_id < 0)
-		return -EINVAL;
-	mptcp_sched_id =3D type_id;
-	mptcp_sched_type =3D btf_type_by_id(btf, mptcp_sched_id);
-
 	return 0;
 }
=20
--=20
2.34.1

