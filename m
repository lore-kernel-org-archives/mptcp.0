Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A7F7B
	for <mptcp@lists.linux.dev>; Sun, 23 Oct 2022 12:48:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7io60IY+ulLaxJA6zFXuEDXOrmjHOEXERwXk+FLhrHq5N6kVwC5MOcqKKG7LbM7FNlz0OUcQ4pD1Gi+ew5EKw00PALbI7f9F4iVDUeSlguXoZV1GBI0VTj7myg3k8CM5nVOyo6eDG5EaVbxvosqJHDaDhpNyKwgdJOEjvKekHG5zw4WrIYnfqWTS8sUkvrUUqgbK2jXk1eOsy2k/5T7j1+t0OfvuRYutUEz6YK4pb63GrqZxEhyWkyaaBPlUzEAdQ7ID94trKOtU4u1dr47+V2wnH6slIhwF3kLtdnzvT8x7mkumoBm+0b+zRwi88CqksTL4ptKP9kdRoes8gFXbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbq3sRoG4M5N72RVqStxjkCrEoMt/Im2RE4C5BHe6gg=;
 b=ZwizOg9L4LKWAUVgpyjvyrSgtsYTmgKuLVHpmF2WuYOjV9/Fkncx0CuwLpbVxImATJ7UhKNCzLiU+nbLHzbsouZMOB2yd8bx/LQwK9GetEjnIKOduCvQ4gx/lgISRyfQ7UDbh1Z7h/WUpRjkWdvCo0Ziw033P2yfIYR67hoL+E/+TxDMlMJO12d4Ac21C4O2HlSEe4peMqZ/0M+Yjedjp0R+6yWLSsZ4B6EFVgu7bomyzjBhhwI0z1yj9UtdToRqodee7U/rW3S9I6NFu2UXZ6OPHX9uMSOivkgTouxecIgu4UyzDkwYGUI0wvFSME3srfyUUbzBLLMKyDJX7UqxnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbq3sRoG4M5N72RVqStxjkCrEoMt/Im2RE4C5BHe6gg=;
 b=0dfDmZuQ3oi3nVa1hFjTrxPmj3hoQwIYaPb2GTAjgtNJJjTXh8ft1vNMeekxfqRYlIE8wAyTsrPSrO9uFM6hH0Feer2IEEyDkPbBORkq22EvBxIiwWaVsETPSNcMhBkWC7ZrZjCEI60D5PapkTyYva60o4Cv0g5NklWb9ZQykRLdvLn9hY9z4XkDJ6Xi2Rl4vFvptxuIdCSMQJ1JBABFbbzafIUILNYrnQfKYeYtbycilQS0um4eJpSJXGigHs+44Iwl1PIaKjF9Od2o15tBFpd/jjJFy+5qi8MneHQ/x9l3j9gOUUCji53cL/u+hARMmGjEdHXDPL6V54tX3g0ufQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB7156.eurprd04.prod.outlook.com (2603:10a6:208:19b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Sun, 23 Oct
 2022 12:48:38 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5%7]) with mapi id 15.20.5723.032; Sun, 23 Oct 2022
 12:48:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2] mptcp: get sk from msk directly
Date: Sun, 23 Oct 2022 20:48:31 +0800
Message-Id: <20221023124831.8959-1-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0176.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::20) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AM0PR04MB7156:EE_
X-MS-Office365-Filtering-Correlation-Id: 88b518b6-6423-411a-88ed-08dab4f4e78e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GHcxoDynmHDJtTFvj4vpL7t8osvYDSDFZVsKt/Rtf8FHgoCIdI7esuMowt2t9nlZ2iPuqFJpIyPrEzE/QsDk9GAkoQlKnS1pImlYsGQqjVyJLey1YWpMql5jlfq+cNhBFgd5TqIPdC4cgnq3+Kisecs1feG54bi7QmGnmHb6oXfNH7ZOwPAXHSdyX0JimgEdoZ7eWwoHwz0OLlyrm/UynIwmc88bsPSMUereqxs4zSJLMUQlbwGvS00yF0hV4eniZ5J5bOvqFm4Zbyw5cDecCPZ6zdZBeT1c8n8OpaOmfMTNp3WlWx5PrS6MIs9tIhLzMkUG+jRRUqHP/5DvuZrD4UeyB94/YOIxWtAhtvE9cUdegvKVt/oQnZ4jIMpup+9zxCSAcG6BXFCUlb/yZorz5LLebIfPBewQdRW4NZJMrzMNmWsZToexko+DQCmwwguql2jKYDGAXk3ieihrSHWt6EKFWVFNGtG+4RhxkoNjeeohCsUAOO8AFECoUcNdbhLq38vQ62k6NBKZxiSYI9JZN78lYaRjeHhOr5Ij/HKJwdX3SiJtGiZII3wwlbCsH0iDxdhG6mt1qplNpqjiDaxXlQbVHO816T+y344pV9Wc8SWiKxC3a7VH7puzyQzTAWm8KYPK8G3/Knb2lcGKttSx0z7chCi+8FFFBLFi26Iu3eSttDeNxWp5ZU0imwyQUcT2fy8cjLWH0SNUiAVqi745gTY01FXJCh5BCmJM5UrbmTYHLlL/GylPmOgsvvRv08M4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(39850400004)(136003)(346002)(451199015)(478600001)(8676002)(8936002)(2906002)(41300700001)(6666004)(107886003)(316002)(6916009)(5660300002)(66476007)(66556008)(66946007)(4326008)(44832011)(86362001)(6486002)(38100700002)(36756003)(2616005)(186003)(1076003)(26005)(83380400001)(6512007)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VQPAs+Vn7sRGca7xY7J6u+dcuBScNpHsuJbeiYj6x1yj2w0KMCYEbddFokzl?=
 =?us-ascii?Q?gflkHLyItamsEpqbP8A1d+u8AU1RxYF7xHusq4/Bj3OsUUuKkxiw47jPIW38?=
 =?us-ascii?Q?85YtrkykO7c17BbuMXAvut6QRxAjM3fC9Pp/D52noJt7OdAqLZoxzUMeYlna?=
 =?us-ascii?Q?DHxLIfQhs8S4UZaar+3yjAqSekwxuhwMnqCzzGkWutxUpXgJju9CMcW6lkhn?=
 =?us-ascii?Q?lM9mCmLmWG4p3gTbpxSZYNbEom6tLevZGTK3NIiDIWe/qUO00FWeg9GRy596?=
 =?us-ascii?Q?KwwL0GXDzSexSfjHfyWDnf34l66wd/cE1EDLtLPhPEG1EssPlXr8PlVvNcWI?=
 =?us-ascii?Q?h15Q+LGvWIoVZdm92fMs9D5TD5aHIJGMWBDWO2ICOZhYBvkDLxS7mXMrpIo8?=
 =?us-ascii?Q?+hPcEOZcLXL7BSj+8EsC3m9rqQ1+60UFXB6b0kS29BS4J8/RvVQIRO2kkOnC?=
 =?us-ascii?Q?lM6AFW4d66hcNzc9l8SsBUGXtXvWFuONfJRu705R270n2zGYX0qYQtJiKRli?=
 =?us-ascii?Q?Acn8fnjDE/wz//36UJZLRwy/GrsIHAuNkPozLokpgs6tcLqhRItii964DHvK?=
 =?us-ascii?Q?Y195tNahJ+eeu2UqOcNPmTTH6yVorEFkOo2y65iy70vLu+nsNQMJPMHb38TG?=
 =?us-ascii?Q?dZokrDPvZQeRqFHemShIx9QwpZveDFJC9qKxNG+3rtJNYzh/yQu0Yt6sIjm3?=
 =?us-ascii?Q?IppGy3hUyQSh5kMSucdSz2pDpMMdWsNaM2EtQG5EZtSQRYyDkis98qsB8hSs?=
 =?us-ascii?Q?7mDVyaQ2CJBO5soSwzfmKPtcockju0KlE+6246bZaIk8ZmK82cCiSk4aBY/N?=
 =?us-ascii?Q?oLe0+seILkbLw7SFbNba/TZwVdAgYElSFm0Pk1z003RX6B2nuWk3vKNAPsre?=
 =?us-ascii?Q?pw+dEJmlZWjpJd1cj8lusgJNJJuxXbE4MqAeUnZ+KQCxGImS42PbwKtbSFYe?=
 =?us-ascii?Q?mM0CPq80hLsoqGBJ7Psx96EyRexFinD4RhKwe4StaNGLaeGgYUFAZJafmpw2?=
 =?us-ascii?Q?KI/6iUtTmIZsB/Lsl+MIZieJ8sJQ20b0xVLHExn3SrDe/FTYYYD8ADYJ1kPN?=
 =?us-ascii?Q?DYXmoD2d4AmwX8fdXnkeK1ttG+5bLHREGox6b+PeWALrVVnbXYj76ZQLFkRZ?=
 =?us-ascii?Q?R5ViO+26c+o051kq/a4FESBGiWb9cPH82FIDhy89IiakAFwLML6p8nppzKUD?=
 =?us-ascii?Q?iJ5Vh0xwKXbbvYGtAkwJuImRbWCx3g7VdWbSi5RulV63nCKq2SaENApubeEd?=
 =?us-ascii?Q?moL5FtsYDyNS0RoljHKzDXVDNKD7ZB7jM3awIWBk70/vDoz9aQkQXovmfFWk?=
 =?us-ascii?Q?oRWNdi3na810g1mpU5Ol/64x8SjIvZjY/sbjQvIYX2aTZ8wTrgKWP6iGYFkp?=
 =?us-ascii?Q?Nabu34TC58p1EtkVC3JoRHaEvpL40nhQrCw7VweZGuugYSstqr2H4oXz65lE?=
 =?us-ascii?Q?kktHJEr5/tpSq2Ti1l18j5rlHBQDw+N0Upg4gzMVMeyFtdx+2JyzmX7jsVzs?=
 =?us-ascii?Q?smPQEoGbPqIoccWGWoNZDmerbCICuGgz3C7pqNMbR6+NuQ+6ZuyxNaboXOqA?=
 =?us-ascii?Q?VQwA0Zq8Xl5zi+p4F4Y95pVnVf0kSwNfdNqtni3E1Q3UI67d7fTHCZEoYRBa?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b518b6-6423-411a-88ed-08dab4f4e78e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2022 12:48:37.7963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFZTUf28K09oOA60n+yQl5kfJIzVtyCf+I7FYrcbvtDr0lNNX5NzRVgt8w0IrGSEHi8DvYOXd1SRXmBpkQVnVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7156

Use '(struct sock *)msk' to get 'sk' from 'msk' in a more direct way
instead of using '&msk->sk.icsk_inet.sk' in mptcp_nl_cmd_sf_create()
and mptcp_nl_cmd_sf_destroy().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
v2:
- fix the "uninitialized use occurs" error reported by kernel test robot
<lkp@intel.com>
---
 net/mptcp/pm_userspace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 9e82250cbb70..5cb65f0928f4 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -291,7 +291,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	sk = &msk->sk.icsk_inet.sk;
+	sk = (struct sock *)msk;
 	lock_sock(sk);
 
 	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
@@ -403,7 +403,7 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 		goto destroy_err;
 	}
 
-	sk = &msk->sk.icsk_inet.sk;
+	sk = (struct sock *)msk;
 	lock_sock(sk);
 	ssk = mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
 	if (ssk) {
-- 
2.35.3

