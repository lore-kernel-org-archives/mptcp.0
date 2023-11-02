Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2084.outbound.protection.outlook.com [40.107.15.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3D211CB9
	for <mptcp@lists.linux.dev>; Thu,  2 Nov 2023 09:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dQx27RTg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZPmj+bc/VBsHRSYLnc5PRUXP4pXekce5DrNnltsVd2sPpl5oFk+sKwO2+AfCnajZp8ZL1ufe0pfmw6FjHfASxr5S6NtQw7weDDXN9HA3egEfj9aw5jBV2ndfFaXt+/xb9uizYDSibTGZlCDwWRSezqpfihJql1ZWtw3Wi1bQW7JZbuhrGBlH5WxUpnPjr+LoGbP9y0cbtGKDwWco1j68ikbhoFNdYRab9Anh9D/JBEAYG0f9FITmBui3mvW7MFC1wE3evhs7o2OSl/iZhkzMVpcDmwBovAiNBD5/cz9QNyA98cdHrHn/DX+dOhz3HjzMVtEhMVdkEDpTiDozRZ+SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+2ybYFJqrJyAWcaonBxMuRH9RYoFgiiSUSkM+5Yr1Y=;
 b=VkVugvjV7bhgb/7uJUMtTAMZ6C9kV1Qa9wz2zza2VQYSg6rgerJD+kjpH0KmHzJqxY0SbKSTDOwNWW0bB/YYnjiGBt+1jWBe2tbBHZx+Y6zW1T6C7wbVOHDo5eLPVUPBReO2Fq3eHcIjlvNzuN6xCxYUVYhzES7GnFtxulhpo4miseU+plx4z0Em7nXa2MZiN4HbuTdoeTSCJrEHDKuNFNJbEkbp9241XR92E1VtOR1iYGHywwxL8kYsMM8oYViFwcD6pmzxGnrJzttFSMUsws6jYM/b1ljxE7F7qzZyF299PLpbNTQjR503/EBuUh3fcBMgIbNLUAOezye5VZYeOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+2ybYFJqrJyAWcaonBxMuRH9RYoFgiiSUSkM+5Yr1Y=;
 b=dQx27RTgdbAiju/LHmAvR6JFzPJijPL4maVSctZBMCIpIvyeK8beM/lNCmWVkVu7g4OYJ7L51URSncNfufZ+8hPlYhh+v5DZvrv163sMuKPp52k1FWyO8+2Alt/aklfWgPcRFD2uM4142ugichTDLjaAdQFhNW7LqthKCYoE0Wzf6cI9/9AdgVLX8Y6DXOpTEbEFSWX/YUFR/VQf6O8y4U508fN6sIUslMnwRlMAItvWg+jVESDihFnvbio/OpMCG0WPEuISBg0GD2SxU5yaBWUJNG+0tNrEG+tCN9IUEYkDOSbITZD+trCItmyMooedrvjiD2H9IbxVe1hNerMh5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9345.eurprd04.prod.outlook.com (2603:10a6:10:355::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 09:51:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235%6]) with mapi id 15.20.6933.011; Thu, 2 Nov 2023
 09:51:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 06/10] mptcp: flush userspace pm addrs list
Date: Thu,  2 Nov 2023 17:50:49 +0800
Message-Id: <5d65e8cdfbbbd1a33e78f41d174c9be53e3c4ac2.1698918546.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1698918546.git.geliang.tang@suse.com>
References: <cover.1698918546.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0189.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: d7bbc316-170c-4564-9a7d-08dbdb894f28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H/gsnrjKg+K/axqP7duc86Dudr+RV1AkP4eps4z5oslcoa01cBO8sRCX1+6ZGkRLkDNjg8PAKliFZuR6H9hwMVN26j2rNMKj8PpL12VF1TNU8O43QEbaMQ0JxU+JZlkqAjfRFfteMJLFtznB3ckHh5mAApopZsz1vgO7suvaD2uwsdr5WvFJQUB2wz1ItsksIkNk5akDTS5SuCLMhPKqK04otpPwWuyFbBo01zBybuy/xhLNamteQ1u3zYxFE0swmrA+PK5PILRvCB23E2tV/xpLz0iCd4GN6tDghUr28z++z8E7alFth36Q3iMU+2rmFvdB7UilO4aVUQRK6Dl3iGzmSOuqCHKmf7ooLYEcSi6eCNebMWotMBHD+d2LruQ106G0CpaGOwpHWyDE0hqX3OX1F+lcCTTxR/ppE7AP3P0gDP+7wVcLZQWhORTnr2RktAf5g+s0eftRdexpYwP0MCduqgHJxYiT+QiKvqcDyi5v/SGkOGZrkrnMXPbzTkVLoCkuVA43eBa9/8lrXUR+SfC9wpZ5H2qqUCJzZMIiNGn4/Asgw8UESFcMKIUm1kWE6DBzHNNK77y3chjSm4CiN+p9wrvLHem0UMr9ujYmMvc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(36756003)(83380400001)(6512007)(26005)(6506007)(478600001)(2616005)(44832011)(6486002)(107886003)(6666004)(41300700001)(66556008)(4326008)(316002)(2906002)(5660300002)(38100700002)(86362001)(6916009)(66476007)(8936002)(66946007)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HJV3B04ijiH32gT28I46rNvTlUnrbYITK1+A7wMdXZxjBzveb+CvtG7haKAi?=
 =?us-ascii?Q?sdgzje44g8jLtEASsbFBFcXKLBpVhuDwtxiT7TmvGAv3LDQcScb0HNNNDpWL?=
 =?us-ascii?Q?4RGnGPtBnyn0hi84lnozN274yYG4ZV8DP0619M9lRMNEkM6wo1FWAHCl7pOj?=
 =?us-ascii?Q?41ayFto5UeiVcPQRGAqFK0jznY6I09jgFcMSY2rM+SbOPCWXWrRuANtK0XoE?=
 =?us-ascii?Q?ErI4c0sQgy7sBHfzICvOHsImEgCA5iUsIrVGnL7KQyE+u7i9Yp6r1BCs/yDq?=
 =?us-ascii?Q?hiW0twNlgohuDVXExG4jIVN1ohViF16jl9t70IjOTlOkrZQBmTiwd/1NWjhY?=
 =?us-ascii?Q?IQlGImaGkgBiL2AnA1Z5hTIrsAAI0h0x28O8zrURhxfzpzBu07ZAYX62gdcY?=
 =?us-ascii?Q?iZoSdr1MLSt/Jmzhwk8Isai7/rY/lj7aHN+4e+oZsF0dBoh0LbMWD000j30m?=
 =?us-ascii?Q?MJzrD+MVFyfAXSC2OVWWIh3YwC+8Y5Ii1W2bry6y+3zJiP/gpYJ+31Do68SS?=
 =?us-ascii?Q?87Kc3oY3SgzI6yVY9Oyaq/bDIBz/WvigI3a5NyhhenXdWgI2aK0ZVTyXrxAj?=
 =?us-ascii?Q?EouKVnCEXRytH13JuetbYtXpuOLpsSEW8XnRhWxH36VaWn33Dt4cpw8fcatU?=
 =?us-ascii?Q?vkROZhtr05qliPlI/Rb7L9kbk2b+vX/xd+v22LyVuWP+B3fQhn5unHeKNHYO?=
 =?us-ascii?Q?k4Zxj/0EU6bjcmdkqcKuLFBEq2b02ucHcQGJ0Rw4A+uyhWhRlbXe5HpGE6o3?=
 =?us-ascii?Q?77B/KfW7+uFsL76VVlIxS7p6raDU8QPT+7H+kQGxqnzRQcuMLANjdKwWwEwz?=
 =?us-ascii?Q?Pb/UYUlpBfVTqPCcoOosDXjF7BTM0to1keGInmKVwd7dpT8zqDXgTJwlqiGa?=
 =?us-ascii?Q?hSvlbwZoOlI/jBYq5+A8noCiSPylkeZcE4yFyC44If2yBMyYvzKwC4GwWaEa?=
 =?us-ascii?Q?JTiUDX9nBxqaYynojX52RqsX2WaoJNKZmuPQt7UtKuaK8MrJDY3PMyUUa7fU?=
 =?us-ascii?Q?V/t+euqi8q43uSpxd4YuVdssRaUsqZ74AMUY1Dq0Mx2dT6/Rq3S8lBqe4ZlS?=
 =?us-ascii?Q?u1vzWwDQp/zIrR7I9zksWG1nLZSH2PYULUnJU09d87icpy1mb85NgwKaXkWO?=
 =?us-ascii?Q?DyILOQWnsyD50dtJhqUiRaSqtnslT7szgEYdESklVqza5pD4oxMERTOSiFzE?=
 =?us-ascii?Q?3DVoRIKQ3u2XTEZOAsYDf+uK2/EAlZwQAUv03+6Fq9ggG4zHzChkrtvs8pqe?=
 =?us-ascii?Q?zjxngz/jvyQDy4SffQ8wc1jzA2XxwNRjRS5DoHeZByDEsWH/XdDTXXv+a/0B?=
 =?us-ascii?Q?oSmdZawgULGkx7IEzozfB8ZJhW3t9EBgKWk1poAz53JQHv7C5VMFZarXO1f6?=
 =?us-ascii?Q?CZw3N5pbcFANYO6k06XHbKPL8ZxzbmNsEhOnbY9a92g/RjiKhhe+sbcMKZNf?=
 =?us-ascii?Q?b+ksg791/J/kwMeX3ef3W1SXU1EnJQ2x/eCA4aZG4MIn5TVeEXEbdiiRQk/p?=
 =?us-ascii?Q?nvj0bSvUzXOCfAhWPsnPw8emIsmZLVxQFrK0JyzwQcEBO8VNIPJs2G1zfPbX?=
 =?us-ascii?Q?o3i0g6jIsobcIMG3PYFOiR/jL4BAXYumrzwQAGLc?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7bbc316-170c-4564-9a7d-08dbdb894f28
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 09:51:39.0227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ItlxJ1ni6p5tBT8DVmsY+qGU7cyvOKfWEYtfQiRDlI0UHqEUPrUrs5mOmTXat5rOGHX2n638jvdp/vUCBE7Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9345

This patch adds a new function mptcp_userspace_pm_flush_addrs_list() to
free the userspace local addresses list. Invoke it when flushing addresses
from netlink commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   |  2 ++
 net/mptcp/pm_userspace.c | 24 ++++++++++++++++++++++++
 net/mptcp/protocol.h     |  1 +
 3 files changed, 27 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 75be7182181b..de2026f10cd3 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1634,6 +1634,8 @@ int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
 	mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
 	synchronize_rcu();
 	__flush_addrs(&free_list);
+
+	mptcp_userspace_pm_flush_addrs_list(sock_net(skb->sk));
 	return 0;
 }
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 86f3809c0b28..f5676fd3eb55 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -558,3 +558,27 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 	sock_put(sk);
 	return ret;
 }
+
+void mptcp_userspace_pm_flush_addrs_list(struct net *net)
+{
+	long s_slot = 0, s_num = 0;
+	struct mptcp_sock *msk;
+
+	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
+		struct sock *sk = (struct sock *)msk;
+		unsigned long *id_bitmap;
+
+		if (mptcp_pm_is_userspace(msk)) {
+			lock_sock(sk);
+			mptcp_pm_pernet_lock(msk);
+			id_bitmap = mptcp_pm_get_id_bitmap(msk);
+			bitmap_zero(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+			mptcp_pm_pernet_unlock(msk);
+			mptcp_userspace_pm_free_local_addr_list(msk);
+			release_sock(sk);
+		}
+
+		sock_put(sk);
+		cond_resched();
+	}
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2d9e8a78625c..9b00eb38b2c8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -944,6 +944,7 @@ void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list);
 
 void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk);
+void mptcp_userspace_pm_flush_addrs_list(struct net *net);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
-- 
2.35.3

