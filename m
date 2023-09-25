Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B9212B61
	for <mptcp@lists.linux.dev>; Mon, 25 Sep 2023 08:41:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHjbixKFVSobswvMacCR2u0f9bv0ugy72/hiKnRyw7Tec21nucn8Y42X6koQ8W7koXHrMNe94dmOxUWvedkIXPyiGxciXC9t1Ts9ffvA2RtXrV52jHqLvB4l6ZiHSeeyhwbvBzMdvrFarQb3IT5SFTBFRfOCmMUoe3U7agPkwkmeGnpcc7k9cbEMJAowiVe2e7Sw+t+6LFeYwObidutLjvGT9uV5SC4VmFrGvXU+uI7lXYreMMCxgai77GAQu2/Vir1umcym1WWGX124rK9rxzVx195qeEBb65tEIZ9znvkKy35dntounj/sfbS8KbDeAFhObZmBRcTmFxJ23Nt4Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GO/5NY/XIkfBTbl3hkSzH8YRJ9Psih89JcxSNvoJLMk=;
 b=VNwDEYsPxsfQY/P/7mFulkwyx0ZhYmJVWBLXzgjmwHSPSStBdWcE0cZw/+Ld6IU0xJrBe0SZO34EQagpZGzbWzF1/JFmGpwm52kgoYd7QcQ+hqOozRtEHAIcwbVprGXOmMRbHNOxNngDmvI857dnM8qGb/OL2ZBZXNmBZ44AAPiL6DVZA+JKt0jTXqF6FX6iWjXcu+7NjfAgL9gOrGJPSSQnl0gBKyUgpOon7fCSTZfmviQvhg5OOFIsKZR+RYz06T631U4+qluKecvKiv049c75ru4BxstEUKh9a/TQGaVESEQ+4jKssNFCrH3wezsGkW4f5c0wa2746Px2NF7IiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GO/5NY/XIkfBTbl3hkSzH8YRJ9Psih89JcxSNvoJLMk=;
 b=mTteDEydz+mkWmnM8owyE0IZ+4EOLza7oXZD4N+4Q45tuBPcu77Pj1D+CByIkIF+lPZEXFKj5fMevSQVra0ffIFmiI1JqoFKycYzL9b0GxJA7VUBAMG5JkJ1u16fbB4SDQaOPVNQfi912kg/1GZtjAgfuqcU6H6L+YQeJP196ZDxYDuG/3Mp5b9sR1tvLF5GKzGjFch3LBZ4bt0mvCCWrZBZaMw0kK/gMEhEswDQCTGz0DT0ge9eqPabQXwhvuIV83wCg9qXLKEXQ5CQRWMqblCesg6I/U0iZI+pXMpgMerRZMiH7ZjFzvbrLtn7E52ePmBa7gty9AclaJSkvoDkQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB8048.eurprd04.prod.outlook.com (2603:10a6:102:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Mon, 25 Sep
 2023 08:41:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:41:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 05/29] mptcp: define more local variables sk
Date: Mon, 25 Sep 2023 16:41:44 +0800
Message-Id: <15854a8d8fb6eb0f827f2024241de68f95feb29e.1695631132.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695631132.git.geliang.tang@suse.com>
References: <cover.1695631132.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:195::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 045ecceb-a191-41e9-e07e-08dbbda345ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2rbfMOcMQUTrI7HfUvJcPZHvEAlxMaOSxIzewmXnPpMSvcx64t1c9e+ahdBSosU0csFx/FZpNGMi/xDOcfOk62pPIhCKl/UIzDxgj6bMZPPv7ine1TbQTeHsaI425m+ADrwA/PtCGHhRLJpbnn2gt39yfQ+OpDcZYCdl+3CAxgQMR6/YC9GazN04cJKxx4fle7zSRULSGESIT051ZyvvdeFODINsXXc8FW8l46WXCBEGGWO+Gw3ZQyrr6jMaWQ0Qxbrm3gyReSD7XRvjYjilHgEdLg18/Vcq96ePG6JC+eE+isbEko13x/DeytcrNsdGU8eCLzWN4I6+Nop5jSb9T6C6+DuOxhSvfmcgBoGFLiBBaUnS1Rff9vp41CoV/Gq9kkh7ZTLkib3MxL5+RV+XBL4ffHzi7ThFM6/Hi5UOwbeXN/Z40tEwPmNfpd88afvCjOKuH9+fhFLcXhC0Th7rXSHJzxHBb4L4PDGGV0JibKaNtF7XL+Q0622Tc4SLsQt9TRakvi8l38UycGdFHztAXIFx5BCkFErYjE56kMGdniGhk6MfXzerHb05NEYrZV6+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(186009)(451199024)(1800799009)(36756003)(38100700002)(86362001)(2906002)(6666004)(6486002)(5660300002)(6512007)(478600001)(44832011)(66946007)(41300700001)(4326008)(8936002)(6506007)(66476007)(8676002)(6916009)(2616005)(83380400001)(66556008)(316002)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/8hSwpVn/BF8TMCxpPSSgSMZ2C87tLILc/hECsTduDIxybnEVqzFbJY3PWMw?=
 =?us-ascii?Q?3jTNdJvtHBJrLXW9BzHRx5+pTrdXaLaIMFux5noMIIfK/3Kd5QOssy+0dXsW?=
 =?us-ascii?Q?IgGcPsdK53Edw8e3kU373Jt2eCatz+cIBhhEmMz+A3ssZUZGp4l+HYdh30vM?=
 =?us-ascii?Q?A6nZn25mROAvldk0bzWH/KL0WCMTGytaIt3jYMQjH7au2wzWEAOQ0eYtRXRF?=
 =?us-ascii?Q?+CGW/iuJwIYu4wyf0yHhMXWNep43EzChQpZaOm4zI0zWZNjw0UVMCooOWHvl?=
 =?us-ascii?Q?7JXcxhb7FkKoOhQOxtZXawnG+5M4J2Wc7RoT68S8dvta5w7LFulmn94zp/0O?=
 =?us-ascii?Q?sU0IkB2xazEgq8at7gKwS6HvRUD2t01MFaEs19B3RGFeRZSGMufwpbpm3Sek?=
 =?us-ascii?Q?ZsVoaVcYmniQFR9q3UrjR5eL2E8Pc734+xengnCAp+NMx0fgWF3xxHthqUzu?=
 =?us-ascii?Q?vUWDQno5u5r2FORIeYset78CNncGZfeSXYdE2x5pEfF/OQ3hu+ZEgDiUpPeJ?=
 =?us-ascii?Q?xaaAhdWrbXNGd8f1Q3JFcnV6d31kXTgpn+UE2MDY4U1hvHEXKrmfQyljelw/?=
 =?us-ascii?Q?ZW/CBG5FIWsoKsyoCraQ9aZOGtwMxBn9ZaR7KlxbRYVQfPWwxzINrWZMojir?=
 =?us-ascii?Q?fkeoEdNQ0phszjHCCXL0SNTLEH5oCzPUiMBx77XxNr2JVCsADwGSr0Acay0b?=
 =?us-ascii?Q?caXM1D+A5RiMfR+vSPwfjZ7fUiR+q9dWrlgPsx4ZTgjYwYsX03WSwyw/5zPO?=
 =?us-ascii?Q?HEarEv/br0qOVUWNVswQogM9oiMzOagQfMKZ+3ZhKB3kNU9uSNdfFHhoRoBh?=
 =?us-ascii?Q?KXWbAVpD5iED6LIJsk2ZkK7a1PIghY82rDdtzH40xEvFPTKZ5h37fTKbL+Pg?=
 =?us-ascii?Q?hAsxXXYByBWlB5/v9B1aU4cSOEh4F/FllOXbHw+26FxUQs6J4RjJYQWs5XNI?=
 =?us-ascii?Q?cK4HWRkinK0hTCqDpmJuG0Ha24dBRlbnC8E1XmOOx5uSEZOi+rGnFQIzDnHg?=
 =?us-ascii?Q?knYlcyXdv7xhszUVIvHYGDvkV1qRN4hujbVlDrt3IAIbFQRaC8ZqpScU83OS?=
 =?us-ascii?Q?V9jSIU/4xHzbqLbYszEGdgBOEYYH7gsJvRLYP0isbAQJ0HZ8SQDNyYmTzXvk?=
 =?us-ascii?Q?NN4SFO5AA+8qKH4zxz0pmUL2UHg7A+Z/JoujlbC9xBqGzZ4hFsfRgtb6nYw0?=
 =?us-ascii?Q?85RCY3u9kXb9rPEHZcEe7E0D4Rpy1gqweoG73XJMVoPxjSg2+WFORGcrc22D?=
 =?us-ascii?Q?QwzF3cBs8shnDwz4wfa+w4LCL2AvUa/Is1dim233enrgmkd68amqRjnK5nvU?=
 =?us-ascii?Q?ImydEGSJf1xUBcoYeI/hLzWCohV2RdGMIIgaVBKj4HKBHDUYPJh97qfiM/VJ?=
 =?us-ascii?Q?vRJO0wBT8vwIr5tzOqXNfnBOzwbJbui6hOQSOkJdzHIltQmP7kxf386gKG+h?=
 =?us-ascii?Q?FdOg1p5OpzBPRkyAMjq0QdfxaJMIyjBh2ecaUtOjGjNcP5UDbjLtDUnIv1fr?=
 =?us-ascii?Q?+Fo6Y+ii+kASOwdoIplwUMvYmy84WJ//Wn8WOdgesNWmm82Ba+kvlIgaupsx?=
 =?us-ascii?Q?iBU2pUHK8dICKhMUiATYUVvsiif3s5UaG4ZuC6RS?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 045ecceb-a191-41e9-e07e-08dbbda345ce
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:41:55.4859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FYtWhov4lyaQXX2XKNSZurf3dGX7dFWVDwPCbT3BUJVY7t+xYgr/RXNv4LV42hGyBZBjF830smP6B+9XDEzDjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8048

'(struct sock *)msk' is used several times in mptcp_nl_cmd_announce(),
mptcp_nl_cmd_remove() or mptcp_userspace_pm_set_flags() in pm_userspace.c,
it's worth adding a local variable sk to point it.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index bc1824a56dea..04e26eb01ba8 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -152,6 +152,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	struct mptcp_pm_addr_entry addr_val;
 	struct mptcp_sock *msk;
 	int err = -EINVAL;
+	struct sock *sk;
 	u32 token_val;
 
 	if (!addr || !token) {
@@ -167,6 +168,8 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 		return err;
 	}
 
+	sk = (struct sock *)msk;
+
 	if (!mptcp_pm_is_userspace(msk)) {
 		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
 		goto announce_err;
@@ -190,7 +193,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 		goto announce_err;
 	}
 
-	lock_sock((struct sock *)msk);
+	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
 
 	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
@@ -200,11 +203,11 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	spin_unlock_bh(&msk->pm.lock);
-	release_sock((struct sock *)msk);
+	release_sock(sk);
 
 	err = 0;
  announce_err:
-	sock_put((struct sock *)msk);
+	sock_put(sk);
 	return err;
 }
 
@@ -217,6 +220,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	struct mptcp_sock *msk;
 	LIST_HEAD(free_list);
 	int err = -EINVAL;
+	struct sock *sk;
 	u32 token_val;
 	u8 id_val;
 
@@ -234,12 +238,14 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 		return err;
 	}
 
+	sk = (struct sock *)msk;
+
 	if (!mptcp_pm_is_userspace(msk)) {
 		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
 		goto remove_err;
 	}
 
-	lock_sock((struct sock *)msk);
+	lock_sock(sk);
 
 	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
 		if (entry->addr.id == id_val) {
@@ -250,7 +256,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
-		release_sock((struct sock *)msk);
+		release_sock(sk);
 		goto remove_err;
 	}
 
@@ -258,15 +264,15 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	mptcp_pm_remove_addrs(msk, &free_list);
 
-	release_sock((struct sock *)msk);
+	release_sock(sk);
 
 	list_for_each_entry_safe(match, entry, &free_list, list) {
-		sock_kfree_s((struct sock *)msk, match, sizeof(*match));
+		sock_kfree_s(sk, match, sizeof(*match));
 	}
 
 	err = 0;
  remove_err:
-	sock_put((struct sock *)msk);
+	sock_put(sk);
 	return err;
 }
 
@@ -485,6 +491,7 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 {
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
+	struct sock *sk;
 	u32 token_val;
 
 	token_val = nla_get_u32(token);
@@ -493,6 +500,8 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 	if (!msk)
 		return ret;
 
+	sk = (struct sock *)msk;
+
 	if (!mptcp_pm_is_userspace(msk))
 		goto set_flags_err;
 
@@ -500,11 +509,11 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 	    rem->addr.family == AF_UNSPEC)
 		goto set_flags_err;
 
-	lock_sock((struct sock *)msk);
+	lock_sock(sk);
 	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc->addr, &rem->addr, bkup);
-	release_sock((struct sock *)msk);
+	release_sock(sk);
 
 set_flags_err:
-	sock_put((struct sock *)msk);
+	sock_put(sk);
 	return ret;
 }
-- 
2.35.3

