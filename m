Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2062.outbound.protection.outlook.com [40.107.105.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141337F
	for <mptcp@lists.linux.dev>; Fri,  3 Feb 2023 07:54:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzL5rA0Opv5z7ButE24nMLgTbCyDy6LbajS+ZVAaXDpVtliWmKrndaYvPNPIIItLlbBoh36z8ejikhENtt4ovBAuhstLOIpqFY/6z4w15uLZNGh6AkEMxwUUQqqGOhoBRF892mSGwF3tHgbmhkx1R7gxMk7moY5382AkXOuyUFXMTayTR4zd6Hu0UuuJVY6eVHKyyblnsEYM3gjplDj/4SGB8Pr3GELjTTbeh2kcRlESSUs4ejsdvpBw3v7p6GhWFT/i593WQDYMJ1ghcs5zuWAnoXtP6pOmSAGafbcEsqDuPRXrKF92O+gJb08Kh6BVhNfMdXt64HryTgRVhrKMXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVRoUa9vksslvYQfJkYyd0KUS2XJKu6IalJug1/eyi4=;
 b=LjBX8jplfmOuqXmcfq/4FEf3uZlD0V3WS3tL2Prcqjydn4cMAi24m7bs/fwtfyTjhOif3iEDpGRiEqKX/G812aJiR7JIyLHtS8lZpKurApUeQR3fDOz/0ExyhAQzdBs5b9Hf5tYx4QhI3kzwWd4MVFqYCe0cDnq62ruQY6ZTz1HP+HQJdKCScr/HmXXM2EbbEBCxWq+ZBU2tsW/ajC3xnE36OJJPlDBKz/uu8CsyeWLFkr8lKH1uyATVLYHD/pBeM384D+2NlL4TT3C3vrXIMDdBly3l9rAy2NPq9RWH4/aOyWj9v1kJdtJFACkkl1+BDt2tW2bJffYJIDKAi16W5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVRoUa9vksslvYQfJkYyd0KUS2XJKu6IalJug1/eyi4=;
 b=BjUfvdVU0+N4ui3xmDul0dg+l/uD6CtHmHIB+eSflywzEbUk6fzjHkiNenTi1BdNHxje4DfV0eIv/NlgkMixx18fvq6QnKZq6b9llahp1ijVxWkfbhMt2Z22MrESAeJdXo4K4hOYUjhG6EUmITyz8VXVyht06PvGY3uDCoQL99Hgs+mpnJa0E3/NtJ2iJPQgaweYhqR7ZFaOF0OgyB1xq3kPstYaV+qp5oNDAc2Bi74yZ1Iubt/YwmlY8y9YzoQty4qjNIqyUZoDSJKjCPi32PZe9fV1qL6GlAc7myNirRut1AzauryNPf/jbgGepW5IJWD2zNsnnYaiH37ljbXZdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB7309.eurprd04.prod.outlook.com (2603:10a6:800:1a8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29; Fri, 3 Feb
 2023 07:54:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e%3]) with mapi id 15.20.6064.027; Fri, 3 Feb 2023
 07:54:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3] mptcp: update userspace pm mptcp_info fields
Date: Fri,  3 Feb 2023 15:55:09 +0800
Message-Id: <7f695489e0ecba3f0951193be81a1620b1f8e6e7.1675410794.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0172.apcprd04.prod.outlook.com (2603:1096:4::34)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VE1PR04MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: 46bb72d1-ac4e-4985-2598-08db05bbe59e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iuyZwKk3fmWZeFRDU3TznvhkP8iw/MPAqB5dRgHdgJ/DpfRID52lSg84KWDGKAAb69ANJ+j5fdAH5NByLgHCYx3AH8A2TSQUBOhhTjyEKOpZJJXOJjJYhLLa8NVeu5+a48GOaCqEkb2Q7GEjbWBM1t3wt85+LfHfdNV8cO2+48MbB0rGYHm6t61Rva53cnhTNAQW2Jr7YUUD34tgJWJTMGO9/KKaTY6AnLCbhUkMN6iwylSpi+uVk1V8hPeN1vMgcjCKBx3OfwyMcNcZHDesd8g11bqMBieRkXOpRmyLXGDxiRa4UoT3/Vas9Gbur3W537gsm32gb3EHKveAmSyXZIrZgzfDFzKrwrXgA+0QbZdB8t1RSQojf7Kq2eFYnpWcRB446QKViIXv56uW5sWXIMbnN11KvggYV/xqGj79oCltBb+hNJ2U7ZB21rfH+bWPj1NeLFNlgfG8nD8RYUZ9MO+ocm8IWbbPh2ZcDAqd7ixTHTyBqHzAYigmRw3p9Edqgk2bHGI6LHgHn1ahasQbsgDcmOJYVCz55Ae4BanX6xoeC4nFn4kB85O8hnWf61lFubOLra7WvyZqCh1DWRDGyDRWYPkRdxEY9Ia27N/pTPJxBos4CE5oF+7bUxgynynTVLFsKU0dhOdw6pyggLZlvHLK9DVVLZYHK9Py2m8eayM2mBTO5chsv+bu/7kQ6ma95zGvE8F9ezsdzWsFwOk2DA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(39860400002)(346002)(366004)(136003)(451199018)(38100700002)(316002)(15650500001)(5660300002)(2616005)(83380400001)(36756003)(86362001)(186003)(6512007)(26005)(2906002)(6486002)(478600001)(966005)(66946007)(66556008)(66476007)(6916009)(44832011)(4326008)(6506007)(107886003)(6666004)(8676002)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+ZkejSmGT9czn6+I9ZGrVNKr9yHwi+ZEbauveBDzFn0cnti5BEE/gfsgdOJR?=
 =?us-ascii?Q?K6wqrbyK9wFuNbtlAchPSOqwCbIPADAKPw4Bm5H2R4pUeKyZg614tz35/lxR?=
 =?us-ascii?Q?jD0ntzympbUaq0o7p72SgbCE/pBFlKBmHT81l3oK5OknX7p/pTJgLO2PdPbg?=
 =?us-ascii?Q?EwRNuX6oLqZuxwAguPUlCKzWiQnAQl6UnEmfZWxXVzkcJq2fqjrd1Mj0ZsMh?=
 =?us-ascii?Q?f7i12DYZhGODp5wzUBEecsppgSFb3nOf7B6rxiJRm+Wy9KggKQa83wAAtcku?=
 =?us-ascii?Q?Nai8nfcs8mjqipkEH16TFoLtIKQqSqpajRCnLGxrChjVR+/XVom32ucLd/1u?=
 =?us-ascii?Q?Jv/GwpJFXn5PT79oRz/uiULN2PLZY4OczFzdU5+41E4WVq68n56qX5PgTZR8?=
 =?us-ascii?Q?1mnfAGcNABGDtiHCPRDiqNS3x0AI84PyvEWe8QrLKAqJyX2yOLoEuJUz6Uxt?=
 =?us-ascii?Q?2YOaO1Vbf9VnomADj+s3aMVZ/DAtb3N/61Nd88oO+OAw6lXKTgHC7Bpv8nnH?=
 =?us-ascii?Q?ng93ALJ7gLkT9gxv1D5OSbanT3bORZEqI17iZ5BReRRVsU3QbyZb0IZtUWbJ?=
 =?us-ascii?Q?EaKltRr+TgZivEncQsVj2awol+u1ThyOjkC9WRbSlwUFwxzma6mzA9fvOj3s?=
 =?us-ascii?Q?BuMBcLq5sRoK5yPEgxBQya35Wwt8wRDlWCEfbfGgFV6wuinl96AJHSpUkitE?=
 =?us-ascii?Q?9XCKsdu5IqVwo5Y1TApxMuoSPi6B+nUrSVFiNp2Fhp4Gw0gR7WMKZnwB6om9?=
 =?us-ascii?Q?Nq7gO6WHbgl4N/x9JGoCAhZyW+nVkrWu7CGGHFphiyWqFySMnpP3BsssL6Cp?=
 =?us-ascii?Q?6JpVhtpMzyh5Zdq7k0C4ln+Rm3FXXeT7Co4ue7TOC8+6SZN1p+yeukCYiWzk?=
 =?us-ascii?Q?s+oHQQu39bGDNYQJKDJsxw1MiJo1IA2xcpf2BHZYu8+dRmbhJ4uLxJBCL16i?=
 =?us-ascii?Q?f7yta1AcntUegmXG5ycy5X560gTZnwjvRhAGTRov+eE/3JWF+zFr2OxZ2zdz?=
 =?us-ascii?Q?1oqPYMbcvGcsDo0SGfjguNoDhNH9fL5XLy3aqcgg7WqwvRnJalU8d8JU4hIz?=
 =?us-ascii?Q?eM4sKj1RAKEYqe0+9EGrfOAgmX+LRKcs/Tjg3vT4TK36/R7xW96XUtip/avq?=
 =?us-ascii?Q?eHx1hFHDtjlJ/qxX/Tm5nlDr/E7rsZg7e4e6lG0A5OAPJaK1ZseTnnqmLeW3?=
 =?us-ascii?Q?v5qDhF3dI6AL15ErAY1hjuGVnJg//VK5AHN6FuCoF7+dwt1k2RkkLTT8sn8u?=
 =?us-ascii?Q?8hjo5LmfjYKEzTF6diP0G3GJZivh1H/xFHc5wAxnEsH3hxjKJ0VN8y/jqJYG?=
 =?us-ascii?Q?t7n1rSB+edTwFowxg5PwodY1fzx41ckANsSG6UuOEth7E/2e8KHT2GDqtGoq?=
 =?us-ascii?Q?eErQbhZFb4gvoqSh2EYee8+HwZThqmcRZXD3Yn+SrUOiNpRQ54boQJGFNIe+?=
 =?us-ascii?Q?g5ORSu7brUZ5Z0zoZGdwu34BlOqtgBWhuIV0opepsjNs0H0+HxU3jqr5nfxV?=
 =?us-ascii?Q?N6UfnuNz4vfoYPaNt5RdWR87qf2r1uB0YqUV8sdR1UTyUWMRQav+q9C1CFdH?=
 =?us-ascii?Q?lW6b+PR2ii19FlMzzq4UpL6chH5x6SnHxtcQi+T251ei9pLc4AlCkV1rEvDE?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46bb72d1-ac4e-4985-2598-08db05bbe59e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 07:54:37.4145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OjAm286T/K3bSgvrf5EAbgclyzwAE0jOAxdHpCQMHWjeEI083GbY6FPAh5j+zpOS7U02CoX/IUc/MQujo7kqrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7309

Increase pm subflows counter when userspace pm creates a new subflow,
and decrease the counter when it closes a subflow.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/329
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/330
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
v3:
 - update local_addr_used and add_addr_signaled

v2:
 - hold pm locks
---
 net/mptcp/pm_userspace.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index a02d3cbf2a1b..ba8ad500993c 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -171,6 +171,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (mptcp_pm_alloc_anno_list(msk, &addr_val)) {
+		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
 	}
@@ -240,6 +241,10 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 		sock_kfree_s((struct sock *)msk, match, sizeof(*match));
 	}
 
+	spin_lock_bh(&msk->pm.lock);
+	msk->pm.subflows--;
+	spin_unlock_bh(&msk->pm.lock);
+
 	err = 0;
  remove_err:
 	sock_put((struct sock *)msk);
@@ -302,6 +307,11 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
+	spin_lock_bh(&msk->pm.lock);
+	msk->pm.local_addr_used++;
+	msk->pm.subflows++;
+	spin_unlock_bh(&msk->pm.lock);
+
 	lock_sock(sk);
 
 	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
@@ -424,6 +434,10 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
 		mptcp_close_ssk(sk, ssk, subflow);
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
+		spin_lock_bh(&msk->pm.lock);
+		msk->pm.local_addr_used--;
+		msk->pm.subflows--;
+		spin_unlock_bh(&msk->pm.lock);
 		err = 0;
 	} else {
 		err = -ESRCH;
-- 
2.35.3

