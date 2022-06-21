Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20040.outbound.protection.outlook.com [40.107.2.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CF2A23
	for <mptcp@lists.linux.dev>; Tue, 21 Jun 2022 02:00:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8o+ShZ61ovceeCnyVJKECytFLHv52ZfYbTgTwYi9hmSgKpsECirLJqELVj4rtVW8c84p3+KChCC8qTkIeg+Tqt39Mp0Evrf6cPgrN8ChmsfhHIswndJGpVUpUN9NAY0O8K6NB4bAj/OeYRsuOU5H9HYAwYKJWseGbpjg5rox2f0N6BfavLGj53DEYfGlsnleKvMUpHqzx3z55hRweq9rnc3OlYbnOBQ8moLZlyLT5WGkOI4FJJ0ay72xOFps6ds/kwVGzQbyfTShsFmX5cganut3ugsYohEHm1lBOqEzXWU6jaNIpEVH0HTHsi4K0CHMqv+TnjpSav+hgAc6iLmmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpa/bPfNM6JfK8ZP7vD7fY0SBhXjOxJkyD7TI3qjq70=;
 b=aaQzJXA66KuZM6HLctHUr/hMHhD6XhFBgoR68Eld0hcfrlra0oax6QD+7pmffB7IJJ6o8g0VW7hylbYb/Co+PX/JVzRoYkBEH9FBqOc3tpdH041qsWTOtiIMTwQDPdujeyvPhW7dKaNs5tbYUEDUOJden8DDyzIJ4SxcNU+AFqmUgjnmUsGgxd00Kh7ZbFGQq2C9TMIBjkRgmJce84KwXpyHcadaIVTW9m6MMB056Zr51Gb11Cu9lVQZi9bWstiYgrbkyJrhjtazlsmN4au0mWxZe7WVEedEYxHAROKC9KeFnmsaVy0hiMoy4KTADXRLA34ii5xieIQdfPftsXEDBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpa/bPfNM6JfK8ZP7vD7fY0SBhXjOxJkyD7TI3qjq70=;
 b=0T3IO6Ut3nbN4rr/xlJIzU6F/VRCNbAu5jXGeMIQiTXFVlKrhSeiUlOToLAq0pSWW8tDAcjXHFEDaUaoaAZd3kXEXMkm52XhuMnWjHJTzyH69eUBFH0kxZjkKQUxyasvRuYyqBaEXkOgF7mPEOHoWsPBjIXpIPqLc5GVXZBqaHWftLkKhjx06IBOcR2mt91AeThv4q45566LdQhDj79YQrGE7eetw9Wh5vGfwWdIW4egGfQcsdNL3dPxZZ2rsf0lbmCHKys1o5n/qi77tLK2oDZ4bNV+7KAdnH0cNMptSvCUsivAYHgOAXEQZVnlUVhXkQAmnWeZC0tiexTq5W2aAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB6534.eurprd04.prod.outlook.com (2603:10a6:20b:f9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Tue, 21 Jun
 2022 01:59:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 01:59:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: userspace pm subflow tests"
Date: Tue, 21 Jun 2022 09:59:54 +0800
Message-Id: <0026aa37a548f680a41fa9f1a8a7d30a5f5e6f11.1655776750.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <6f64d72dac256f2dd6449f8e75c14c98c46ca631.1655776730.git.geliang.tang@suse.com>
References: <6f64d72dac256f2dd6449f8e75c14c98c46ca631.1655776730.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0236.apcprd06.prod.outlook.com
 (2603:1096:4:ac::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d68cc6f-12b6-4614-5a79-08da5329bf0c
X-MS-TrafficTypeDiagnostic: AM6PR04MB6534:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB6534661526F0D008F66560B2F8B39@AM6PR04MB6534.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EQOi09KIj0oSK+vGFHrw0K3rUee4sCT7HTp3qSAt7IkONx9d+b7y6GR4kAsGqlBVgEVhXAGacwLrhOPdGu0YHe2hkCn3OSqPwySz1IAqdIvygCQurpAKFP7moj1sGZXdpwShSjJYvVAUIEptdphPot0NDeE+2QvlMaWhMpT0XL5lRpjN6ym4v0XSUPb2BjTf5SiNLvLF8ABzj/rN2/8HoVojFOW1slLQiFxaUnPhCxXFA6tMdLLRLJmWBYLIMMDa+IM6FlOeDuvrhI4aXLJ6YpKZc5qzQMGlTK0XcVI1jZCj/V4A33uzfnXIComEF85uBKrsJQYiFXT36MEuJF8mJizyD5pj1aOPYu1iPr6Mo7SiyGqyVc0oPQqwmzWOfM6IH4Hrv6W+JMmaYA0b2qN+10wdo+FWXkAtC15ppNbWKu2+BUQpGXjTVK9nHrasLipZTbUmGG+xGzf0EtOyc/GOOe24+4E8Y3b4ZsFm0rPL/m1iFHUlUIxdZWzuKv5ecjkT7qqkbobkyuLb+P5hO+QzIzB/N+ytl9NpO6ud46GqOS5fZkmQYj2/llt06czVw0Cpk/u/7B/bgCH6pzPDz/F4U8LwC3bhICI+Eoi4CN5Zt8aNQn+dQleRFzFLQh/JzvoI0xbHJMXWBKzEkPnuJQUtkfVFqZYuGx+V+DxIhgOXXmPSMy6k6OoNQaKsY0nKh3kfhl7fkDqRZwYqPavTcfBMOw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(396003)(136003)(366004)(376002)(44832011)(4744005)(86362001)(6486002)(478600001)(26005)(6512007)(8936002)(5660300002)(6506007)(6666004)(2906002)(38100700002)(6916009)(2616005)(41300700001)(107886003)(186003)(83380400001)(8676002)(66946007)(4326008)(66556008)(66476007)(36756003)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f0OVnyU4iJ1bGK8gF42RNXetOf/Ns9Lgs72hALWBbRoaKdhTtiJ06pGqyeBt?=
 =?us-ascii?Q?aZ8lYRQVPsL5xirv/BL6PwoJ1KFfTvE5T//zYiyO7EZzzrpWh6yxBsoRksbC?=
 =?us-ascii?Q?wIot2GY1NqC0eC3meZCiDxhfG+RwaQOWFxJo5+X9dhRGYbDnUytFnjclA57M?=
 =?us-ascii?Q?AjQFUgKL+2/GZzAZ+kcIjLasCoP+VZp1TevimqvqrF02k8T/s+RfNwJJxF/c?=
 =?us-ascii?Q?u2Z/BWMsEWRoIVOMYalZLMcKvdw8stPc0/Bq3eCV9f53mKwo928bg07SNdaW?=
 =?us-ascii?Q?1ERSS/NIv7RNf2ulZJzdYJDGAuXGRd8vnkAHWBSQlK9oUj3Uj0Ir39mTE/eV?=
 =?us-ascii?Q?4US4v4Tc18x27PtMVd99qozvxOYJN2W/3BDboX01vISE6NBHKAn4Yo+lgUg3?=
 =?us-ascii?Q?jrQpoxxPVuIlMvcVnmR/1iK9Id/VPebNdHrSscn3YBKavWaK1M9HC60V0rf6?=
 =?us-ascii?Q?8C/9rPEy4Q4WqcwMJ3icVVazZqrxnnuUNwyV7FRL/gt4hRM6shQ/wyQYSZWT?=
 =?us-ascii?Q?Th5idBVW3LlzQyfWabZkZGZh2UrwaMFAfdYS+mep5z2ypmw1JQBzC5WuxmVk?=
 =?us-ascii?Q?leQiRU1T474hjZxE/d3vSqw+3V/AjbVbOz4H6hVWN4NRUGTd0tLd4CsqZNPp?=
 =?us-ascii?Q?KEzmqbjOCXYJhzdwwlbzJ0SgKyxOy8PNYvzHc7+q1hHVVsLzi7WSDjCzFOON?=
 =?us-ascii?Q?3QB9vOEPkNJYAcwuOMBG+8eE056r1xSjO+TKsG5g+raVmzdFGA2KVVY4Wmcz?=
 =?us-ascii?Q?zhbc0Q5RvLVkd5oIRpkKkcHo3zSQ3kjwJ1OE/9AMyQqxyrVNFeUFOZTNnWmQ?=
 =?us-ascii?Q?Gfu9zu4/9RHafrbX4wtpJjKlzJn9cGOdy8iA5rDuXzAi/y1tPWHxW8AnWU0/?=
 =?us-ascii?Q?Vlg0lVXmFLY3yOgzNeCpwAJjsN2pqsUUDtkeArBUenualfy8XppRPC8qBdHD?=
 =?us-ascii?Q?dZspopYS51w5U7QPugtaSk72TDtkYyywwojYUjIpvQx0oqn4mEkJewAWEagW?=
 =?us-ascii?Q?CSpWUxd/YD3fFcNUZQsF8erFyFQOZfdieiQytMuLvwX7X7uw9zuIZDXVthzx?=
 =?us-ascii?Q?EkLrXX8O/4d2P+ddffT8NK8mwScCuFbKk3gfi3X6CUuuMkoeERyCB60TYhd/?=
 =?us-ascii?Q?g80LD9b0FKx5dJQ7XFi93JYZJB+jcjRfS6gKcLFIYgucz24Nhu0PFxAdUcC+?=
 =?us-ascii?Q?RJA47XQztd2s1qITUFgeNAU3ZVm9EtTpVWWqojrDDAi41Z+DxzmFY5y6rvlD?=
 =?us-ascii?Q?P51qZO2N+rOIypNpdGmmm3PrXqN2u6YTN+K0NUbFd/cl54HKYKl8TA153Lh9?=
 =?us-ascii?Q?LkVIL8hegywXzNS+bSAMu/uk7mkl2SBo3mA1YBlJBauJp761m/ku6f23xaTT?=
 =?us-ascii?Q?i1gPL9Mx3u1mzVuXggmipASwiRksaJR6kxpRRu4pQyLnnlEJLhTnJH0Hhp57?=
 =?us-ascii?Q?LBUFyu3czXYseOMJGGLIizPeoipQBjvgjqy2R3FwTVn9WTzJImsDnwCskTqU?=
 =?us-ascii?Q?wmxfQCej5v0DL/TTymUCuccgUv9BXDbmghc8RLRVIRyXz6PmCXoeQnaIdmgw?=
 =?us-ascii?Q?IfRZU7oxBrU3YfQE0DXt94lq6oxy7/6a+xaiixCcfLjFHmAW29c6RpwIDE5Y?=
 =?us-ascii?Q?vWWeMKMl48it7KRyNNWA4UZvCQg/HzrDfppHcPVANY0eWqqmG7tdg9LUJAnX?=
 =?us-ascii?Q?ndpajtAsTQP0BvdIMLvC+jDwVsVVh+3MbOkF7PL/8ZpQKVGV+aH+B/ZBDbBI?=
 =?us-ascii?Q?Xzko634DpUjXZQSDxU8IV7yCXu3HpX4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d68cc6f-12b6-4614-5a79-08da5329bf0c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 01:59:59.2087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MN+uTJ5i9WS+QF2hP+TH6XVGkCzAlMvgVdWSv6dmIwPw8QSjjXi/Z6lTsSOt/TZGBjTYfVmOtiyScpPaDBUINg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6534

Use kill_wait() helper as Mat suggested.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 50b6e1ec2f3a..55efe2aafb84 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -949,8 +949,7 @@ do_transfer()
 
 	if [ $userspace_pm -eq 1 ]; then
 		kill_wait $evts_ns1_pid
-		kill $evts_ns2_pid
-		wait $evts_ns2_pid 2>/dev/null
+		kill_wait $evts_ns2_pid
 		rm -rf $evts_ns1 $evts_ns2
 	fi
 
-- 
2.35.3

