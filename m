Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2059.outbound.protection.outlook.com [40.107.105.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEE435888
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="beYpvJwf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRTEW4REPW6XMZ38bz20mT3oT9iqVsCRAOAZSzi5AupIGCvD1w5CnlCOQ9YUZsgyoKflS9ly0OZKYwKy1OaJjHvdXGJjtXpYnYS/EZ7VW92SwN61pNZpTY56WCjus0moesWy7kMFBMj8ZJnWfclcl9URRH+mRr8Q/Sw3PZWeBrl8n+px0j2eEGVqn4DdV1q0nwpQyVxIa9HGhypBaD7VfpqRX6x+cglrfkOnJrlu8GQG15ziIyz2AwIcBck7qFo8OYkcT6+izrEbpi2kb4oj5j6axPkem69S89yTVPTRjwxN1qb5uTpDFuMJTx6A4o4qxHJIZK2+4R4P8MLyn03uyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFHe7S+Hy0deBz2+JZd2T4avlxaVx0U1hIAvevaw8cs=;
 b=bo0wyHVkUFeDSRMWOsN24GyQ1pRBUEYlwfOjJjf5VvXwXoGzj98WoTcOG7kBaTx84yvswgeZ0L8u8SD4ubUT/y0IXCGuBfVcIh0Z3n7d5J10t7D7shiHkBK11Pm0JMPTM7bwpXNSzW3/amA5i1PNcOiUlqEL9bpTQWoici2q/TcDlEP4tPnLEKzAr9xxPUr5odaQb0bevNYXEm59xB5ChX7Pq9PGjHoWGpJlh+BiNWp6wUyh4IB6xVEgFe1UX4Qxtv6htyiSrkOsws32rE1KPHH5zZPzr2SM4tQG8IRj9uBE9239ddHfBb3AympKT2ur33f2edyRCyYVQCuldo6k9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFHe7S+Hy0deBz2+JZd2T4avlxaVx0U1hIAvevaw8cs=;
 b=beYpvJwft0P/viUjDhQH8D3bLyHKwtt743ooj/XRiJPOAeT1q0fcInf8VUWj2beps+tmgjVA9spYFS3XxuTOV6VpVh6yU6PIXN82LubGOVNPX74MGaqjZOClRrhce3bAUnm3Tx2t6Oldx3gJkAjD99IYUFQwjpItA8uhaHGx+Ckg2T7SvnD+TIOIxtS1/fRyJMhBDG77QaqRvtQXMWMLIJLuAx1mbmI64SqTWWMdl2X3vcGwrvsDJ3EwRYoN5bX3caHl56O+QihNMAiYAycAL4IKwiSLt1P4tQMEcWwO2853Hc5nZv5eMp8jq9SnGH01PP7Mw8qNxBBfhRYfYSFwsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAWPR04MB9837.eurprd04.prod.outlook.com (2603:10a6:102:385::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19; Tue, 28 Nov
 2023 14:24:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:24:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 21/32] mptcp: rm addrs and subflows before free local list
Date: Tue, 28 Nov 2023 22:22:14 +0800
Message-Id: <3ae3b61c487a73f3ed7f9b677a6278c401ad710f.1701180969.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180969.git.geliang.tang@suse.com>
References: <cover.1701180969.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0184.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAWPR04MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e88ed19-854e-4bdf-1439-08dbf01db5db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+ivohtmYzLUXnf422fv1SrVn5Wjqo+wejUbE3LXKyf4dCqU1V/SljlBDfq/uGjF71lpnGWkUeGA4oQYZJFadIj0CfYVwGwOjnj4BWlSmgNQKYdRyZwuDn0vp5isJIBZZZ03cMjGQPwfOHGKgCTX+DfCgYdwLmmJbnwazYhrMTiBKc55dZ7XkSDA1gwi4M+q6JKINdTARbf20zDlEbXa4FyziVkA6nTSQnPMHK0V1PV5fwOkGYoVO5ZhIe7/3PErSc+j6ssErJuj40JiUElptvWC1r9vF92vB6e9QQxve2aDDrimgCj+OPxBGrrkgw9WLcvU8xRr/680N2JRre9H0SCnQalVY/s9RZtiYAKBiAB2KCE+ojicM8QpwlQ+4m0earWs6peIOVxPjhPh3rHKbEThCvxp6XoQDuzNbZ5eYujuw6bpQ22b9W4fPMuh9OkT1OxZihWRSYvJ52pmektX1EiuTaLw+na+rRqK7hpPC0j5+mhdPptD3Vzm7SGhvJIfJp6RWZrnoOnsDLZOJ+8/zZU98kXc2xZ5LbdVy/w+sa5FkBVhzWPytLJjzYPzRuZC3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(44832011)(8676002)(5660300002)(4326008)(41300700001)(26005)(8936002)(2906002)(478600001)(6666004)(6506007)(6512007)(107886003)(2616005)(36756003)(83380400001)(86362001)(316002)(66946007)(6916009)(66556008)(6486002)(66476007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BTaV01kxuUGKtQuBExLTzEfP7oXT8biWejzm2OBG2jvlAp4h7monnxkoPlvE?=
 =?us-ascii?Q?R06m2jauYaZW+YmgQJfu+LWiD1iQWMepir7xzvrxnYZFb0xI1jH/emKVEAIy?=
 =?us-ascii?Q?hImoEbzvMueA1WlS328A5rWGI9Qh5Og/Kwi/Vqzx+UklpV8st9ZeEkMagcdT?=
 =?us-ascii?Q?HBHLEONxP1ZOJMEBTqO/3EatXkbbxH+t55+OiLoMfUvIg6FS1RH0eGpBWymZ?=
 =?us-ascii?Q?DUrcMls0U6ZJVhbFBD9PSnA7cVXW2eB/DXtfNXSt1/L01CQh0ri4M0n1lBAS?=
 =?us-ascii?Q?CJXSdHp8O4OQ5GoiGTFsyOQBrSEtx+KbtIdOj/ZycDY5lPSyl6K4HRhK1ikR?=
 =?us-ascii?Q?ZihQkU8gnytmymwyDPbv0BIz9ios+3qtVUmli8D+CEkiTsWx84Gm84cPRiF2?=
 =?us-ascii?Q?RPZBlU4phWTINjAy0NRN4DIvKOGj4XazlI/hqe1Hd81+wqk8J6T7Yo44h1LW?=
 =?us-ascii?Q?fYjcmxZF/YguA04nhIXyz7htJ4BDzPjtwjQzCSYv/w89KaoJg5Eg9y4qtBpL?=
 =?us-ascii?Q?3MTYCrxPT8nmEAqH6YsHacG25w1gX4b6yks2xOCd3X5w68RrWeW3lPuPh5Dk?=
 =?us-ascii?Q?b9j4YwcCdEMAyBnwd2LGID+39z8t0iY9jqTWb8kVfw7M5qTk/7C1NDiJYo42?=
 =?us-ascii?Q?XqDYjE/texYAlJufU8GPVxHKFwoV+MEGVNNAZY4BtPHu9tev19TTEoLGa2XX?=
 =?us-ascii?Q?IVcQ/h8QO1dNVQjRqWvWBAMlt9CJXI00aOEE9UIZjVjoe9HmQ5QSpI/xfAcT?=
 =?us-ascii?Q?mdoLc8czN+4hK+cG36O8GK7C8nNdUJZAXLN6AFIEeEoJTfjDtkH4g7KjcPBK?=
 =?us-ascii?Q?oU/1AImK43wI4eAbNnoe+/I8vEIB854cwME5srtkiH5y2th9kddrHL1xqi+/?=
 =?us-ascii?Q?nF0uO5iBRuThd4LWsfnYFB8JaEbW1NRGf9UHvTsnDYPQbHlJXNKuh0mE06lI?=
 =?us-ascii?Q?AFlMlufrdic55SRfHGIpwZ0EbZr4A3uGDTJQQnB3xOqTpyKsj6ScQdGtwIbB?=
 =?us-ascii?Q?0l9JP+7MglBV554pgs1pMVeqBl7Iid5cU/esudg2Z38SOgNx6P/cmkxbDtPw?=
 =?us-ascii?Q?OsaRfsEqJsrZXzj79Xi0gFdCX3Yozw/YYamc/4eYpJnuyxlVHvF3Z2eze9Dz?=
 =?us-ascii?Q?80Ewcbs27TRiq9QQJ43r5QIziclrsxo+B6PBpkd0hGlDy4wkAq+62DGbZqC6?=
 =?us-ascii?Q?pgv1udsz1zJybZTT0dwHWBQxCX8KVtlSe5UkWCGBQ1pLhTf4vmJRqn/bF2N3?=
 =?us-ascii?Q?zkxdvGzCd351WHpYK6CMohGytcZPabCGZyDxAxT/OxSYx0FsbjH8Cz2c4zh4?=
 =?us-ascii?Q?hkDZLgQOdvs1Xy92BqbcNn8L4CxtpqlRTUN8nS3Eh1pzz+663vFkySlDPlJF?=
 =?us-ascii?Q?v42S5GFE3IYG1GqIGQleTjs0/pgmGDnJFWdbcLrTO5R/6fSVai0ywaboyWXe?=
 =?us-ascii?Q?Cym2usupVYoeFkKb2wWQOSrEl+oMIsFazwAj4uKKwNR33wo9W69DC0TstDqi?=
 =?us-ascii?Q?Lu48ST5drFanbc2s/VJHdUhRzOCgOqRrmYSCc1WKNBY795BXkK5vr5lPdVIP?=
 =?us-ascii?Q?7mVYIX6dvkAwo/PsGqgKMKMew0cpQgeP1zlrxvCr?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e88ed19-854e-4bdf-1439-08dbf01db5db
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:24:20.1199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Brr4Xg5+ffbsWYZTuSyBvrETVlbJ63y28f1QvbmUAnazyH1qhMlOqDNtlJ5BbgSfJJaj3UE7/aGY7bMhNB1B+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9837

Before freeing addresses in userspace_pm_local_addr_list(), RM_ADDRs for
the addresses should be sent and the subflows established with these
addresses should be deleted.

This patch invokes mptcp_pm_remove_addrs() and mptcp_pm_remove_subflows()
in mptcp_userspace_pm_free_local_addr_list() to remove the related
addresses and subflows.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 87cf27dc1d0a..674262face65 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -20,6 +20,9 @@ void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk)
 	list_splice_init(&msk->pm.userspace_pm_local_addr_list, &free_list);
 	spin_unlock_bh(&msk->pm.lock);
 
+	mptcp_pm_remove_addrs(msk, &free_list);
+	mptcp_pm_remove_subflows(msk, &free_list);
+
 	list_for_each_entry_safe(entry, tmp, &free_list, list) {
 		sock_kfree_s(sk, entry, sizeof(*entry));
 	}
-- 
2.35.3

