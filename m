Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2041.outbound.protection.outlook.com [40.107.8.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7906B8466
	for <mptcp@lists.linux.dev>; Mon, 13 Nov 2023 02:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VzOZfGUB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wt3qHa82VCPWJa+HLO9f4pDhv6oHUvpfeZCV02Tw1pEcKZk3jzdS4W8vitlJ793KOTg2YzhUAsSizw2L++fMh9u+6p+uDo6ie0m0/0MwBYr0HNlVtTarPXpDei0Kc4iXPuAKKG+0Snfteyz6xInILlGKpLSOmbVg6rgwa9CoVB1Ef5w6GjuN0TH4XOJYzEpTNWOOw9jcH0dYQsbkI8iQ7ANjAQ3rQplCJ41pa1ZWoXU0zqmR/fMCT0sbZfxMByqsLmfGujlmD1e9Alxt4P+93bfG93aBPLpYRMv4dd5DLveCxUEzetd3DLeLCgiBgpINCiUfFcD/JtW0DvYsgKy24A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=im0w7CtP3iX8S7SAEQ/Bujr0mMzfVUiEcCrdAu32FXs=;
 b=ma8wyabwt8mMXNFbfYJG0lHQN5V5VPzKde3wSI7r26hunMTMVSN35yx6v5gA9cawm+jdE6lZ9m5duBJB64l688KkaEaTUg+XJgl1cniEgY9qFEW3e3r9SVCceFGzvNyk7bBjS6zIa+HC61rAsSusdpnyFD4MYH8ueBhXCzshrL1qTB+X7SaBour4NaD4DiEiIr+UCxorkZd32eadqyOKDsWRBRdRGrggGJGGSP5dpq602t9f1LePcmrLp7sAkjnuOes7HBjHpYvNWkDmMIdb3NCz9cBP93sqhJH7bXZKiDOUUTkBZ1Klsmt5RJhHYuM/HCOmVxXKzu6eujil8hBKjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=im0w7CtP3iX8S7SAEQ/Bujr0mMzfVUiEcCrdAu32FXs=;
 b=VzOZfGUB4TJmoOv+hkURjnZTu8PBzQJeeQ5WrRRhDs6HfNmSaZLX7EJRge5sGiT7Yw2PaHKHNjPi/mhufsP5r7rO0b5SmeOBHbBbQHjXxltTwXxHpt4rsX4Nn2qcvXWMUO0TPjIxmnfcmdVRIsqxo5FiTu4/Fypkjy7SwE7zCnxcpy9ZwIbc6XtZx3Nu87+8vPn9udofV7oX6bT83TtOHDlR6O75EdXtgP3pv8OX5q9PaOqVrqVyiq2ie2K9w+B41KGBetXrD+Nh8VJjU7mF/QVMSGJ51Pfy3n3uWsqZ/5OXfAx2FWYGD1JHhI8Qw0hNPKVNrvndT3JXNsU8C/XRxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB10038.eurprd04.prod.outlook.com (2603:10a6:10:4db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.14; Mon, 13 Nov
 2023 02:49:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Mon, 13 Nov 2023
 02:49:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 01/22] mptcp: export pm_nl_get_pernet_from_msk
Date: Mon, 13 Nov 2023 10:48:45 +0800
Message-Id: <71823334a778427da97eeff2211990cb349233d9.1699843617.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699843617.git.geliang.tang@suse.com>
References: <cover.1699843617.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB10038:EE_
X-MS-Office365-Filtering-Correlation-Id: 250a3b04-3274-4de1-a3b4-08dbe3f319c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qaEw2+E8VFO1tlkLQPX+H/akfDEfjFe0RcBgspmeGJQTmusaF8fY+N7inUiU/ZCmnyRB0i55paQ6rIXzlhJh9c4vFevcPaC4/582X7PAPwtQhCQ9AghKHfHdQDztvmyl+HXTs37+HzQWsv8WJ0Ae45MBEeWF9PWm2aTVzl+lbXgYEtrx0t7H6s62PjxvL6QFL4cHgt9B/bXBQVICoVpKoyn7rYDv0/AltYT/c5DojidrwaGRg30PShXqBuxmf+OTr8P9tdt/9SGjpVF1j1VPd4ZheDTx+HU4FCab72KKGtmY2xvzZOpQsqKPw4vfFf16LmueCHbIfke139BVLyIIaNZWnBhny7BE+Vr+YHPdJ6XEB2j/D8JYhlzHTcw0qVlhN2HHd8MCJx83qITqzr4G/R6SPBda8zwM213+n/EwStrSzH+k5QHVhv0WJLLqC0eNptiRM9i4jcINeZDGaVlLokZJEttWIkxOhR4w3MLBKKBhoeSbpA3rFnNc49uySLWXY+cC9BHPhvIAQGeYlss01X52l3CbYjjsHSwvWM0nvuKWRoQ1TampfBQ75gl9587O
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2906002)(5660300002)(41300700001)(38100700002)(36756003)(6666004)(86362001)(2616005)(107886003)(478600001)(26005)(6506007)(6512007)(6486002)(83380400001)(4326008)(8676002)(8936002)(44832011)(6916009)(316002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SJt+ZcwLlT2EDD0pa0EuwcbjiGRZqBUgYpusukloi9W1a68XGArwIF9BkrKm?=
 =?us-ascii?Q?+ATnGQ/2AKOmkPLValpISXtJyputuplZxKBDV4Qj0vbfNu/xlvs6petlnQVW?=
 =?us-ascii?Q?/I8je4/O9Fc2sfHFLpWGL+CrdYCvuOsfaJIiRLxK10AK64pQ2wnvNA9TiD79?=
 =?us-ascii?Q?ZGO4riF6iUiz+Cp+L9OKESJh/NEJvD5CaKzOBtgySZgXq7utzgDTnjLvcM7d?=
 =?us-ascii?Q?J6PdWenxCPknEHqXGl8CLxLrDixZfmplq4LMUJBqfvWQ8imuCttRekJoo38z?=
 =?us-ascii?Q?DxA2Hh9yVrGXDOZ8UZnR314IpkLmPZFKOOH1jvHDXsluAmqO/Rve4+8e+kL5?=
 =?us-ascii?Q?U3wLwdiJIKZbnRD3xzxlbej0zBBlM23qim+r6+BnCu6rSLCS9TFIQbXt+AU8?=
 =?us-ascii?Q?3jHUhB/LX/zc44vknWx4ym9yA34gWIOE1CM5BD94gW8RdBe5IkhIuG9CSN5I?=
 =?us-ascii?Q?7nt+/0PehqxOB18nbcXm3UnTtFEXfHVrj+Pq6y6ZbnwxNG4izaoMQkPRBoZF?=
 =?us-ascii?Q?dRrjxZMDH9ILeB0iULdjHkepDaS4sDHiPNAb89oNYPweQAMcBLeKVhIh8svl?=
 =?us-ascii?Q?Tkhd2ocPnidNKTo1xWikJ4nSnOxeiRTeuXmf2lmgMGbrPxI4vytbovc1orB6?=
 =?us-ascii?Q?G2BhV1m2u+MmsLQV02BCiQwDGmVnZJ2Eq8u5IZZVrLVji/EV9/poDT+BVstj?=
 =?us-ascii?Q?HZvRAGFypH0PQN6ITBn61CGW0LSs8OeN+CZq8CC1hkfp9pTWtiPwUz0HvLQY?=
 =?us-ascii?Q?KhFo0yVb1TpGVAhJ4wJSsGq8eo4VBZGtMTEkRkyP46iAT1o8WG0vyQmqcjYy?=
 =?us-ascii?Q?wJktrNNLleI7MH03i/jtP301bB7kwIFmLK73duqSyrYOv+YrapAUkTMmDvOn?=
 =?us-ascii?Q?hLrbZPqnlURikOkgBEJGcRd7P0vYmwbFEPjJkxrOFM/QCYOyUEoZeyM41ORE?=
 =?us-ascii?Q?kAXagsU3ZL+fMWdriO9nCNHNpUDHonkf8sMn1svjSYlpYxI7VUltoKNcgism?=
 =?us-ascii?Q?MeR/KGOndqTr0hNUU0V8za/y5oCQIwUK/gYKPbDHHLFdxzGgb5B+LoMB8lb/?=
 =?us-ascii?Q?SfZiUVDutpNXGZRP7CWFi1D9BeG5ICbrk+b0fmkCWWAYp3rAaJ4FbBB6vB6x?=
 =?us-ascii?Q?u0c0XE6+A3g8Bj7+z6szlrXJZlb+hPWJX8NTigmX3mYQ6QoDZ+Cq9P/VYM3q?=
 =?us-ascii?Q?6THwcDNuYUGfJfWPTnLHKJNBuy5oE+owj5gJxgaCMsChpUQWopELJ9lQVH7D?=
 =?us-ascii?Q?rToD+3p4oaCy+C8uqUHNvxJ6huKGpGAEZ9SwuAEfnNLmbJW/YseiTHINmI9+?=
 =?us-ascii?Q?h7fJ4gCJGijdkXafkoiejNokETqiN5/Uy2YPEmSdqfZtHDrb0RX8YZJ3MK1Y?=
 =?us-ascii?Q?1CKU6/Ro2gPAlUmK+a712c4LPj8xAdOEOPgDtbfyzN2d8YP1sIqweNM53DFo?=
 =?us-ascii?Q?+sk+WbRXg2CltCj6lX2SSE1I8VSnVXXBG7Ld97DS9tacWjHthPTmsae21O/o?=
 =?us-ascii?Q?t/CsKXWPSOec1U4q4szX1jlvikOEY/jLew7qJvlYmcpRKGW0nryve7WPY3Pc?=
 =?us-ascii?Q?33MGYqV4xcSUggBWd2QO30BwmO+NkAdX9x+OIxxh?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 250a3b04-3274-4de1-a3b4-08dbe3f319c2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 02:49:05.2862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2UKsEvWK/j1mI0e26kqXvYDIKlyJ1wBpvWBSzShxnav2s50nmFONaArmFUsayG0IPPN3UhEUE+eYxbomTuQd4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10038

This patch moves struct pm_nl_pernet from pm_netlink.c to protocol.h,
and export pm_nl_get_pernet_from_msk() helper.

Then every fields of struct pm_nl_pernet can be accessed everywhere,
not only being limited in pm_netlink.c.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 17 ++---------------
 net/mptcp/protocol.h   | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index bf4d96f6f99a..1dcf104d7a01 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -31,20 +31,6 @@ struct mptcp_pm_add_entry {
 	struct mptcp_sock	*sock;
 };
 
-struct pm_nl_pernet {
-	/* protects pernet updates */
-	spinlock_t		lock;
-	struct list_head	local_addr_list;
-	unsigned int		addrs;
-	unsigned int		stale_loss_cnt;
-	unsigned int		add_addr_signal_max;
-	unsigned int		add_addr_accept_max;
-	unsigned int		local_addr_max;
-	unsigned int		subflows_max;
-	unsigned int		next_id;
-	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
-};
-
 #define MPTCP_PM_ADDR_MAX	8
 #define ADD_ADDR_RETRANS_MAX	3
 
@@ -53,11 +39,12 @@ static struct pm_nl_pernet *pm_nl_get_pernet(const struct net *net)
 	return net_generic(net, pm_nl_pernet_id);
 }
 
-static struct pm_nl_pernet *
+struct pm_nl_pernet *
 pm_nl_get_pernet_from_msk(const struct mptcp_sock *msk)
 {
 	return pm_nl_get_pernet(sock_net((struct sock *)msk));
 }
+EXPORT_SYMBOL_GPL(pm_nl_get_pernet_from_msk);
 
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 			   const struct mptcp_addr_info *b, bool use_port)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8529b3ae55e9..c38a2126071b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1026,6 +1026,23 @@ void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
 void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
 				     const struct mptcp_rm_list *rm_list);
+
+struct pm_nl_pernet {
+	/* protects pernet updates */
+	spinlock_t		lock;
+	struct list_head	local_addr_list;
+	unsigned int		addrs;
+	unsigned int		stale_loss_cnt;
+	unsigned int		add_addr_signal_max;
+	unsigned int		add_addr_accept_max;
+	unsigned int		local_addr_max;
+	unsigned int		subflows_max;
+	unsigned int		next_id;
+	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+};
+
+struct pm_nl_pernet *
+pm_nl_get_pernet_from_msk(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);
-- 
2.35.3

