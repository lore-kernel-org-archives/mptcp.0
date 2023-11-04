Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFBF846B
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 08:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="m6ml7Zh4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWbcUNGGfy+kX4C7PiUsnzhj5aLSwss7x5gI7kU+ifDcYoVd9ptyZmex+mEUuoyJCYXMDqVAZi4QBRJ2cmwqiwluxFqnXKwVKmJYc24x3WSSCzJFdox6dimqpzL1jWgaBbTkKcXdSxpuWm4SzjMQV9RYiPWzTb66HD4DIJM2++02KS/A3zeuPR9ZL+ygg1yVCnp0kukUCEppi+LboGfY3mxOMFZWTjks4H1pdZJfd6Z7URYafA/H9NS1s7Bh0cj7ymdd14vtTWDmFdpXFS+SYm/gHiMmrHwe35Zp1htFmXz8AnEGvtpyO+LuNUovcs7y46GUhv3i01I14z6dZMMH9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+cL6YcaW0M9kaI4y+uvCXHWXHMp8Hh8bkyb8ODhb0w=;
 b=lbOAdioLlU66yqDr4xApV1DjMLxVgMh5M5WPo2UVnYW6F03F5a1cbNoaGv6jznodN6FKKl2pi4Kz9jeh/4JpBYCxLeFLRIDVKrDugMUg12uF/fvlsWIIdGhDClDZrv7QGg1lThBsKaMIgtRWfRYIPdp3GKs3GXvE8p5r6KQL7DH9SOB91ah+pV64VptKjvKG5Fj/Ue1kDuQ0T1P2/50nc5XfjnsD1L/+w3pznUTMDYWhZLX22HxELVUB3PrIZeS54JToZ2wLE5rBCT+CTgOLD4SiXwmJZEXPddDtrpw6yL9Gdeuiwhe/xmCQ+Fok6wbNVxOsu+FyFifVSgx/XTcp1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+cL6YcaW0M9kaI4y+uvCXHWXHMp8Hh8bkyb8ODhb0w=;
 b=m6ml7Zh4LISmmAToNbE9Cn52BPwQLcoaCPAK+qhFmU/c0pI3VJ6sPVLXoN4SrK4eXjED1GpxTRKN3do+oWWmh/ic+tNSRHCPvruFrs/xQQDo5O7gV2Ju55OxOnkxcnzVL+NGTYjw8PywW/pqiOKHezHzpofAMcXSkM9XtsJW7r+5+1TgisL6GjgKKOqOqm5cTZRFzBJbgz0H0a86SiKPbcutFmq9Q7o54Ao67oOVbpYrlY9u3sk9gdlBzsSEaoqCYv9UQ/yDnTvWRlmj0DZOINjGc0QYV6L5GrH7QdDeEUJdFbbpE3P10BSYUY3mTQUlGdF6cPuyAnIRJJ4YziwO8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8874.eurprd04.prod.outlook.com (2603:10a6:20b:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 08:36:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 08:36:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 02/12] mptcp: use pernet id_bitmap in userspace pm
Date: Sat,  4 Nov 2023 16:35:37 +0800
Message-Id: <45f88df1563575ef4bf5f38c0f5937e14e30aa13.1699086244.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699086244.git.geliang.tang@suse.com>
References: <cover.1699086244.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:195::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: ecfb9d56-5330-4c6f-735d-08dbdd11167a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F45G/7ZXNXXWDQt88eMHBpUk720RM08oy8S/eHCgKOEyn9M1wciElJvR7KcUICTSg+PrQdr1S2o5+KcjMiNF6XAh+lHszu/xTbX4Nfm3t99V1uW8g3a/YR63SIsqKzLicNp5J3z2NzEXlziT5v7JZ5rjaNvPR8t4y8TqFHQ+DEQ4dkLU2Jr1weYoMoMCo8dZqS/W9ohE2E4ZlzoBM/t32mhL5SRQQowrR8CHbD6zjbQCyWy084+KY58LUeqmwPp/c9HGqHfGNRcH6ExwbhmsX4E/925eWDglOgFrAVW3haXR2uphbmfXdkznvSclhxAqweVzsKb/XM31ssZoeU6l7mibqMWiQNgf07GxRIQZ38fDfAVODuz5VZVj5z23vjGO65eS4r+nuDFhgsrx2ZA37KN8Bsd1Pq6J83MSXi4dhF0lt8g3dja9X125hqL8XIRhHgW94fex7TdjTaIdlXmZ7TPJFw59Lk4BtIIQTMtsqixHQtxWuSNrWRYfXr/2X2svFeUWiXtc/eIcVRok6WsiBX8SnNs9OlRLBx2lZduURj5XU15zoq1QESr+7FfCtYgOS0q8sucyC/AH6VC+hPgnhnRujDo1Xl3d7HcNm4ZYBvI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(316002)(86362001)(83380400001)(107886003)(6486002)(8936002)(44832011)(4326008)(478600001)(66476007)(66556008)(41300700001)(66946007)(6916009)(8676002)(36756003)(26005)(5660300002)(2616005)(2906002)(6506007)(6512007)(38100700002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RursJARbgT3T2wn46eUGm3wsAe5LO4hveb27ZYKDG2MgwvhoBAqzpEPX+nVO?=
 =?us-ascii?Q?ZDU3QEscoA97LqOozGe/P4YCIbcwCgBzlG5BnDlovWATXO8hwPnD/SPdgfXm?=
 =?us-ascii?Q?j1I7Q/46mGixNrqVvYwn5eWIf5SmyEZadC3onG41I8UUI4YlvcUvxrydjM91?=
 =?us-ascii?Q?bDop4YYCQjCl+8RIS0WlDRJ7poiuqNBXdNvsDlBG8gH5UK5Q4RUG2KHrt+kE?=
 =?us-ascii?Q?eJ6PByAh3QWYTcp5hYh1RF/9/5erD3qPnLmrr8prRmhOXD9MLeuWiUHIYtWY?=
 =?us-ascii?Q?PaiK14MawTB56z1H/mNrwLT6GsJmNY0KbjDPHD6uHdOAXdetio7wdMn3xRSk?=
 =?us-ascii?Q?SdzHBbMPyae/ev3dbv6GWxBZgBczMhCVvbu7V2HkXWSrBR+2Ba0DPh1S09Ud?=
 =?us-ascii?Q?2rmlt2vdJhOJMhwEFiob1tHMX0VCKaaaRP/qow1TX62FW4KCH7j9Q67CdboE?=
 =?us-ascii?Q?wZ7crNfMu8lYojyttxIGPQ96V5ofsv6nuXREazqZd2KJY0AAdM/W7icvfq/x?=
 =?us-ascii?Q?xOktIT/lWBQnOOM+h44mjAmG1LBeJC31j6a+bQkZl4C4LiNLBzg+f53muFq7?=
 =?us-ascii?Q?lIkCsUJLMcgmy68MIKT0t9M+i7p905nKXlVTXDJgfFAC8pc1HwFc231tnR0B?=
 =?us-ascii?Q?D8yLr3tFgnVPLrTZzBNQQ1jmCN/q2tlIybRfih3xOHKEdo+METr77t9OGqCJ?=
 =?us-ascii?Q?bCtxYxx9c1Q4sf8im0XKuke09HlKUSwpYjlbEhkgUa6UD9HwOlPIYYzErvwf?=
 =?us-ascii?Q?K+R7vncm4Ox5wR447OBou36MjG1TCCI5k76we8WylpkaFwYEwUXCkwHVKI7D?=
 =?us-ascii?Q?rJnJOhKeYdDt6N/WKcKkfZa4+iorshk93vUidpiapvOGkiYGnqiov1xsvkrM?=
 =?us-ascii?Q?/KX39FdAvMIovqRzlLBVtp+Sy6AeuZmGgHmZvFVNGUjtB6SqvcWYHbKJws8N?=
 =?us-ascii?Q?aS62JlSNKt9uKjSP1D8QrwfRv/kzLAdUccm652BwpGIt4mfNPabNveSvtx7Y?=
 =?us-ascii?Q?6B5gx3VhzDNhX7h9hhYzncoJO4SJuUI9ZjD7g7x/S0SeSz1xFaTwUB842+tv?=
 =?us-ascii?Q?YFUBR88B6F1g6sTC6aZUG2iTwifBllwWLGo368xjtm5TRlUZBIwjihzeyckw?=
 =?us-ascii?Q?dzNPbUQtOn+Ub8DdtJfmQ5X7w7fEzORh3pVM6+2w3c3kRt8S2lJMbZeP10Kg?=
 =?us-ascii?Q?8zZJBN/syIwOeHHyEAP2eBvYO3QiC+2IsXUwQiDeBPDG7aRlDZfeo+ULhY0I?=
 =?us-ascii?Q?hRRGjxwRMUNipvFtGoYAIBa8hor1QzIxdkQMj3S5Q9wdXINUca3cydi9nZRC?=
 =?us-ascii?Q?I19+f3cv/p7Nlq7RA3F7h+Rs+iLvklP6pptyxU+9kJW75Bo+GbORaoOr+FCd?=
 =?us-ascii?Q?47cX3nc4OGGhMt1aR7rAN89GwNTvNHrBVTWSuD9SLlpwdExQDXr7LuhwBCqk?=
 =?us-ascii?Q?5W8T6wo6RVq3V/87wPmv4JY0XIc/X7zxvvZOxcmBG3R858idKFppIgAdoRRq?=
 =?us-ascii?Q?o3mYJ6PZoBmXdpDKo5pRwkgl7YTHWSV1lHUMIj0xydSp/AEZu/vrhFmWAs82?=
 =?us-ascii?Q?IDYRGIFv2nyAqzxyI3XJbEZzGwwfZ5aBx6Ht9HnOaYNOlUdi8ETqEMm/NiAV?=
 =?us-ascii?Q?pQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecfb9d56-5330-4c6f-735d-08dbdd11167a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 08:36:06.5474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fb1YZMxXZXBEmNkZA4yk+v5vVFqZhRohd+6J5vp0E2L+5dcyBqGP50USlrn6BT3k/+gJufZ+BPU4nS0q6uJwtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8874

This patch uses pm_nl_get_pernet_from_msk() to get the pernet id_bitmap
instead of using a local bitmap when appending a new local address into
the userspace PM local address list.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index efecbe3cf415..ab953eed7aac 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -28,7 +28,7 @@ void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    struct mptcp_pm_addr_entry *entry)
 {
-	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct mptcp_pm_addr_entry *match = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *e;
@@ -36,9 +36,8 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	bool id_match = false;
 	int ret = -EINVAL;
 
-	bitmap_zero(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
-
 	spin_lock_bh(&msk->pm.lock);
+
 	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
 		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
 		if (addr_match && entry->addr.id == 0)
@@ -50,7 +49,6 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		} else if (addr_match || id_match) {
 			break;
 		}
-		__set_bit(e->addr.id, id_bitmap);
 	}
 
 	if (!match && !addr_match && !id_match) {
@@ -64,10 +62,13 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		}
 
 		*e = *entry;
+		spin_lock_bh(&pernet->lock);
 		if (!e->addr.id)
-			e->addr.id = find_next_zero_bit(id_bitmap,
+			e->addr.id = find_next_zero_bit(pernet->id_bitmap,
 							MPTCP_PM_MAX_ADDR_ID + 1,
 							1);
+		__set_bit(e->addr.id, pernet->id_bitmap);
+		spin_unlock_bh(&pernet->lock);
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
 		ret = e->addr.id;
-- 
2.35.3

