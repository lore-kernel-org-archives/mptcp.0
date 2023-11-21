Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2063.outbound.protection.outlook.com [40.107.105.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9783BB49
	for <mptcp@lists.linux.dev>; Tue, 21 Nov 2023 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="vLfNqLFW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Azx9bgLrKofYoxAQDGbR9VKTRe6HkLwkxUU26DnsDyJiGBR1Z8Ql5Pf8s+H7WYufiMb4mwrIILv6cPDWSH8WodvYEP3i4GkLqoow57Eed8UoQ6cZ65NlaYRs+7Tfu7Wduc0EZv+lYTuDZ3wSNKwkyWZWODdYqX+uGlZ/fbGpFmGg1BrBQtUcJBMKGsp7RYlQyaNC47TI43wwoX23ocrMN+9y6UnJjkdQc15wf6aSq9rEbBHd6T4vb8iMtkLfSVQBd8sSb4Ui8lbIBcwXaXqwdsBZ5K7dH3ItHUAq/2ePlngcQxy1e8PhBweahFCy0erK+W9DkyzzgemNxJrZ+ZHpmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+W/0yUoZ1wnZFt80IkvapzV5PXq/PasaOPYw4JO1yqA=;
 b=SCXZ3MXTFQGCb0EQD3iJJlinG+di/dmcL8g5yCaSoNkQcBu5cqn2SxpJYDdjDKXOhMBZ8Oq32Ko2CgAHZ6+50bEpXsNkuWdXeh+lIGzgKQUwC3wFjCCuKtt9oA4u3ZsRx171sDVGirQnWqfaP80ow6qnsE/SC1cm/kTH1HepJHlnCml93sVbhOBs08CMDbUa5wrA09O9W4VEFG5/AFayTA9T8NxxHLY7Px0p1wVUFoQ9NCSzEgPi+MRLrd5Ek/+RHVMBfkxtBkuohfusvE9LTecOsBZtkYpRG2vbCKmFRYAgeE3YUa+KZBDKlXgmIHCTqc44I2NwSOk9uqnuI3B7mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+W/0yUoZ1wnZFt80IkvapzV5PXq/PasaOPYw4JO1yqA=;
 b=vLfNqLFWh/B8ZUhGjAuD2E7CASeZZQ5HZ9Ho/aVUteR3DzD5oKq2yuCVu3R4OU6pYmol7cUQ6rPvj/2ivM3RDZgIX44V0Qo8QPLg6bzMWJpzYOLyQHn3fdFgXF3pj/+XOGHAveyF7g2NKnWXqtz9+bYsqWmi3mTf/CEvwRquFxftZ/QsgY8EQIdTOy45OU16RIQs92JBIDTlCcNWQQms0zdN0Utib22gYnqAuphRTV06hq3JeeHz6cfCNz+JcOYAzyp7tmRGLMoGwqq3YOeqpB0NNlNOWkKCngwXzAnBzK4fg4DnEzdFk+Sfrf/bK9zKmr++nZjEJhHlbajSuZKWFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7750.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Tue, 21 Nov
 2023 09:55:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.015; Tue, 21 Nov 2023
 09:55:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 14/28] mptcp: check addrs list in userspace_pm_get_local_id
Date: Tue, 21 Nov 2023 17:52:37 +0800
Message-Id: <f709ed341d6277deeee383fd327d2424452a5ef2.1700560046.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700560046.git.geliang.tang@suse.com>
References: <cover.1700560046.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0173.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 34686a26-8046-43d2-d88b-08dbea77ed5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JFZbNWb7bDWCcVYI1Hyk6sbWJ+JHnn+ie7ZG9RwJguFN6Vp8TKxBWX78FypDcSoZlmyPZDzanxz4NJZPRqLg9j7J/y8I4wCD6NhBSnFhWb9b4uk5x5r7BpHV3Tb6CeUK9RqGNCcQM2z+6AD3qPcIUFgrj33u2XTaBTmvKjXuFl0ki6mytMAx8DN6Q4GfprzKdcjjlduPbgNrDOpPArbFSNri3BU32HY4tadzDBlw/UVWbWA5m6gxMRpJ/v+znCDUjzOqh5cr67/mG+KsW3V7XqyuGyj5DuTeskTF91Speqotnf/5fhg1HeczbkqF9w+2QwUqAicbsnwfHuXp7zg5rgqEv24fvvo5lXGjOKhogWJ6hkCncY6mmRDX2quRdCOZYnlQVJSeV760/yvPtE8MOs5q/7xRO2xspF47R0Fiexpvbh6UOyhXN7DMzlCPeQWZwPZNUwMrBCEhrax4zfEygkyDtJODz63iMjNOnoHDu9XiFkmnYRPd5YuTwreo5CfLjU2KsfAqDA8XDWLRGQp0d55J7rHH695t0UPrmUxZmjWL7sDiZ8OkZQiA0cLne+m2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66946007)(66476007)(66556008)(316002)(6916009)(6506007)(36756003)(6512007)(6666004)(2616005)(26005)(107886003)(6486002)(478600001)(38100700002)(83380400001)(86362001)(2906002)(44832011)(5660300002)(4326008)(8936002)(41300700001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y+/rgTrnW74J++hiB77y7NiYF6jiOgJrbihW0VXqRbs1cuu+t8jCBxbKqpkH?=
 =?us-ascii?Q?rjNWnkxAJ61p2YzT2Vh/A/d5SLrb3kdqDioIkhg2lhx4z4pQRsEObw+hBLQj?=
 =?us-ascii?Q?MZec5Y0s/t3a9+wTSzTDea7hyLnwPSLRgOF8WAzDcnHNWrgIKoiJET0/mqZh?=
 =?us-ascii?Q?mGcGaXhrKRy3lAw7HKupAymHJGOMh53dQ6UrNBvqA/P19goRLnDIK1o8ELh2?=
 =?us-ascii?Q?0VjkrOH8w5OwjKEu77mLl77h+wCy+SlZaUvHOy60+u02Qa7NtcN2nNUkwQqQ?=
 =?us-ascii?Q?QWA/ikSsbMVGg38ffveMtUU4V+Mz8SYKpM+O4FcwaMm5qUqqsk87IhtA35gc?=
 =?us-ascii?Q?CPoq9jgLxEV8v2sIecKuVdZPDHhBcezVFLs1FVO/tOXAGh7P/1ZSF4cyXFMR?=
 =?us-ascii?Q?B00NtZ06s1mRTSlQSdcX3H0xjVYeoWosWHkuhhamBnxUOggQ9Iy0AlZ3cfjN?=
 =?us-ascii?Q?Cjnia3OgUPmILLB5tJSjmZP+bc5ooj2tONg+FCMsnn0NG60BZziIoxz5wqfJ?=
 =?us-ascii?Q?4JrMoy2MV7Bls2Ooc3jQmttAU7ozIpYIsWYURYNKwPih2SnAEzCFKmTJd2fK?=
 =?us-ascii?Q?cdjhtUZ0ZhQAwJ7i4KKhw9042QPQsnsuQKjRaRRmI9Ld1btm76i500+qoBoB?=
 =?us-ascii?Q?TZCAqj5q8/blSNIAgxklrFZcTu//a70tUc4ejQ05i86g3p9/43wLFcENZZR1?=
 =?us-ascii?Q?+oGFjPmTUwiIhA6pnKJwliA7ZqEoXFq40PKie0vgjcBwGjQya0OJcH98wrC0?=
 =?us-ascii?Q?RX9zV1QXHCfsvsFPXHxHuwnvlexKf9ny9tiqeqWp5A1xmykGduV6GmStzgRz?=
 =?us-ascii?Q?qwMjpXHfNOUzckv1SWnEzuuwbhr7o8Xl5DFRliwahhnfom6RcrHonstG7obU?=
 =?us-ascii?Q?L9HF9MykVYIkfJ/Dsh0XRwKPEbdOpcyg+0pnkp3nw4jrJNitpV0d6gvZ8eW1?=
 =?us-ascii?Q?kyTg6v4n5wa/biBMOBNEqQidq9pjtxRxYyUPpCrc+/NCzKZ4oX8qwm5bo+nn?=
 =?us-ascii?Q?iWrfPPDMACHfPIBHlZsXCG5nUaDw0HwXWzISkL/kfHMUti1nlwUVnLSLmuRx?=
 =?us-ascii?Q?q8QzYvPgLnB6iJbOr1KddN+HdhZyE4Oi5cxjB8Zcq03zeeTN3TGpE3Lqh4E6?=
 =?us-ascii?Q?p7x/k5tl/074gs1sNRjGBXst+vTtfxd82U5KT59wthhdqu6LJ44DmC+90xFp?=
 =?us-ascii?Q?oC8XMsomfZwB0EazApKVg0JZreGWul35NorRSmilWGI3jrumxCVEBRp+Ub/a?=
 =?us-ascii?Q?Fl1baU0VvyABRkVpCbS4Qkx8Fj5qfaIDopJv+SFN6py9NcGUgawc9QscdObt?=
 =?us-ascii?Q?+2xIy5AKynuFsgUPVFiCfLSQ1ds+z1nkNwBSvGi9A2Z8rb6OaZpfgg941Ja7?=
 =?us-ascii?Q?FDluVlFp+HT3yChGIRKSdr+HDaZjHjcn4+RdxVJLZJ+TB86fYGAmMmtBKkR7?=
 =?us-ascii?Q?tXpjgb7wKypCC9ohzKFdxKAyBZfUGrZ36Fom+pkcczrDuMh4B8j/lc8MJbnc?=
 =?us-ascii?Q?uz4SDHcQKuvdPcjAqz7qcpKFLXVBM2LopLRF+d820bfYj4SN/AxDfpEzVP3l?=
 =?us-ascii?Q?ZB9kJSMaEn/JqO4EcvHoM4+sExtK6xhM+z7yITIXWuFpFgrb0g9H4FPF105Y?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34686a26-8046-43d2-d88b-08dbea77ed5c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 09:55:01.1568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HxHVZNukUGOL2rv2iDQdatfOrMTjahIr3QM92OyQDmuuL/WNInvdpOBq4tADAm4WB0tMCQnuGzvv6jZc5w5G3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7750

Before adding a new entry in mptcp_userspace_pm_get_local_id(), it's
better to check whether this address is already in userspace pm local
address list. If it's in the list, no need to add a new entry, just
return it's address ID and use this address.

Fixes: 8b20137012d9 ("mptcp: read attributes of addr entries managed by userspace PMs")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index c9dc25fa8540..489bb0e61118 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -136,10 +136,21 @@ int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 				    struct mptcp_addr_info *skc)
 {
-	struct mptcp_pm_addr_entry new_entry;
+	struct mptcp_pm_addr_entry *entry = NULL, *e, new_entry;
 	__be16 msk_sport =  ((struct inet_sock *)
 			     inet_sk((struct sock *)msk))->inet_sport;
 
+	spin_lock_bh(&msk->pm.lock);
+	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (mptcp_addresses_equal(&e->addr, skc, false)) {
+			entry = e;
+			break;
+		}
+	}
+	spin_unlock_bh(&msk->pm.lock);
+	if (entry)
+		return entry->addr.id;
+
 	memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
 	new_entry.addr = *skc;
 	new_entry.addr.id = 0;
-- 
2.35.3

