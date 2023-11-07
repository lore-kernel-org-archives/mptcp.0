Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2064.outbound.protection.outlook.com [40.107.104.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A362B1FD2
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 06:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="5zCkmC/k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiSDKpA81qxBxpL5axrHI0bh4gZ/FOy1P49vSNNjQywlsHkT57EFRWWgNAQxM3mV4MQBjoNjbLHdcqoeBYX40J8D1xQe8f1qZ8cD7gy3mMYtm3V9pc6ysuJBBeE02bXv/csshS/dDMgpoH0XkeOlOdsE9nYuvUu8qYBxCXKMnWVK7CdEv2nbiPF78l+lA9w7bZQEZhfdrr1SbGtRX8rEtUNmjjquHo2BvWJAZkO2pLrjTKBS4twWog9K3EX+zDNUM1voSQSmb0tpm59WuHbYr9OuuHYQeI0zhHnodIpZtryV1wyV/D95zdkWuok1Gcn7Uvb0icm4sygo3tzR/bN21Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUQd40HfRyC71IKotVEM+O/UYcQI2s9kFoLyew8RFq0=;
 b=He+gRsRXs89P/SZn3vMKbqYb+rQWbMhAfA5AVDzA0yJNKgZcZVrdY+ucausMNvLd+4AEenOXD0ZcOC5vuo2+hu5FxucyJjc6KxN1V6vmKeMiAryqM3qD2dZJ6IX7O1Ad5TndYalJxH63VBcFEfb8SuMs7prX6SY1htGimT+Q7mR2h03zvwChP6Sect84Dq4sMKH5PTmqvdY0jL2l6wgzIbEzAPLQsFFYxNfXFJCJB9lWCK5264Zp9haqHyKEUAcozw1y3+90C7craeQ5Yk1r/1OhxFp7t+kk7zB+agsa/vSn4k7Icpv8ls5+pCAki/9Ry1abBxGgeN4oGuwqC54Dgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUQd40HfRyC71IKotVEM+O/UYcQI2s9kFoLyew8RFq0=;
 b=5zCkmC/kyIMxUQ4fWHRmzbwhdZBi7EB/edHwgBSGj1lNGyhQyGOqccIrlFh+2kN9nkssS5mXm/z8r7UZhTwAB4Cux/AW8xpuLsMur2/7l8pzRgRw0atKJ46+2XSuXtDnskpEQChSP1abDrMoS9oa79QPniTH4v0uXCc9kLeZELg1AvfS9S0AbnglnMC5UaVFp2AaxEd6E/Fy5X+g+7jKchT0On6sLYYb8Xsf8sZR2OOJxlk3uNrIc//kmLiekVphNo0yysK4SsFteC3lC/12CqPMwL/lkAupw3YDeFg1OUfYdUzPPzuNmPLbVw0ZRQ6bK8KBU29ct7c42tJJoHqu/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9669.eurprd04.prod.outlook.com (2603:10a6:10:316::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.16; Tue, 7 Nov
 2023 06:02:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 06:02:38 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 05/21] mptcp: flush userspace pm addrs list
Date: Tue,  7 Nov 2023 14:01:49 +0800
Message-Id: <f638094577d4742cf99e79d296ff779880e39b52.1699336526.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699336526.git.geliang.tang@suse.com>
References: <cover.1699336526.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0128.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9669:EE_
X-MS-Office365-Filtering-Correlation-Id: 7130eb99-5fd0-4d01-4f4c-08dbdf5724f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C0lvcI5WypWu9Ii7652Cw7sJCv9uR52b7eW6WBj5pPokIoN+eobfbbWYMj2iBPhK2696qQoaqY2dKo55B6Sb1rM2Ylw8ol7COERf7p0EVWYyJecHWDoOEkj0CNMQnPyqna1FhfFo/XiPRHzL3gKdjf5y/6Juh2n5Lakba03m2kqhWXhZYgG0SbcmFhoGxSKqUb8GzVqeOxYQgMEZbguw66yGqcwJolrtrxteTr20PzS86+PpOHMw9gevxddxc8lrHAzRwqLF0XLdaEWXqvoLlvnRx8Yd+nAKLtWPeJp2F2i86AN6U/XV0cAQruhAgduogGM4x/eP/b0pyaqCrxuFBN4dI4UwXPvQUD44XkSv+gvxErmLOTE7cjXxlfqjlwTe347ndhHWPwB/59qpRhlykaH7/6Yo0JQLkZ+Fk0yasp09O3cLHxrTbnovCCDWfwn4fW5J1bdQFJC/cLPguCGotEWtbTUs5XlTQds7xOCi928zZgoN4iXRjS0xJ7L2Y4rhyVo584hwRdjja339luhGoNKFffpsIHyxiSmbclhJVtUHH47U0dKAYLYa3yXsgVG/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(376002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(478600001)(107886003)(41300700001)(6506007)(2616005)(6486002)(6512007)(6666004)(44832011)(316002)(4326008)(8936002)(83380400001)(8676002)(5660300002)(66556008)(6916009)(26005)(66476007)(66946007)(38100700002)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uTycd2TZfBANdIjPYYg8TOAPwUr1HMk5pAQvH2iy32qNjDEs1HQBUVhZdpUw?=
 =?us-ascii?Q?45tAW9ccYzTfzF8PyZYHQreI/RLCal/oDQjjTjquABqclKDJiWIChm/Rua9G?=
 =?us-ascii?Q?/vz+xMSsWX0XlfJ/Gjsc+xwREQt+TpIANvhSHg8nZGbn4tY67QXOQnhOOWG0?=
 =?us-ascii?Q?CdRyyiT+T6Fr6ZU/Fo584QTUvQO0cOB/Smc4H98x2hW2esZrCqrW7EgaKY/5?=
 =?us-ascii?Q?UrQ95Kb24H4WBVUiLVj+aaEk8MC1j/7cS7mz2cBpoghGj0lf207NguONkNKc?=
 =?us-ascii?Q?C8gH7Korxika0oZj2zbP+tErl6pYgyI7iUVqUMSduquXiR2iV3Ro85oxjeaV?=
 =?us-ascii?Q?+C+Y41Vz5DuxVLef8ceyNLGxkf+07PwKDz6+kh2KtR6NYEi2H/0TdLTMwg3j?=
 =?us-ascii?Q?gA89vUsxLhjZSeKrkcr5tUPg6v8vB7AG6KxkFIjWzi22+f90xAs+Rk/Uxwvc?=
 =?us-ascii?Q?3+KFXrbgKz0bZMcSuta7tDjcLaRrsVju/el1ZMuihfnVw1HhdrXkQjcE2fTw?=
 =?us-ascii?Q?NypdxkEmsyzrrwBx9+tEXpSg/9VJyOuKrD6tszDL2J7JMB0X50bFbuzPeJnQ?=
 =?us-ascii?Q?4Dos+mDWvdBZ5a6pidQyOqTXW4O6jGX2OLrrw3v4TLtw7lRGx0h1Nb24sGNZ?=
 =?us-ascii?Q?R+fKB9BduB4cZMbJJudWrX+fHw2CIawCIb+eoN7s33s1ORvfAGTt5UMEIfvx?=
 =?us-ascii?Q?EngG09JgSTyqhYv9HjkdqEVgEOnAso4VrVKmSxfmxW9HunPkhl9Lznf+8tqJ?=
 =?us-ascii?Q?6VcA1uIoY0Naph5aYZTgQyiZpk5KjzULwKIAN7RFXlsKMWUexWJS4tJKANOr?=
 =?us-ascii?Q?p9vbSvD/G6X/6EhBiag8ZvpPWyCPIQjBQCvce5pkHtaAqx0zvkv7jcBRqTjy?=
 =?us-ascii?Q?tqkMCFmU0cOSHIgsnf8EBSnf+pupui+ejSVmtkV2GFYbNs2LxSOnScOCGfFA?=
 =?us-ascii?Q?gNyITYuTK73rfojnVGZw60lwzbqPqrU6YNHDKZwD2eU0mxG+cvgtIZKgQDsQ?=
 =?us-ascii?Q?6vTkMiQu9ONI1sGvBqIUuX+/2KDcXzODoyOStWyBVMQr8QcR9LZ9boObhzOS?=
 =?us-ascii?Q?4xXYp38YRx5gzffEBL4gxuUE9VAoFyE25vXAs7GIJilpviP/qYyAQ0W8CalB?=
 =?us-ascii?Q?Qs/CEqmOxteb/Tw4XTC+A5SlGuUH1ubHlvN2ehKwP2geIm/CI1guffZYzQyQ?=
 =?us-ascii?Q?8+Ahpm/Ny6ypj/iKOHWrAbTKYe/lXfD13/8+MVCx0CaPQW3ZMv4rMMmI8ww/?=
 =?us-ascii?Q?7FgZPiUKOTddN8wR1thkN+rh3qqGbKTiZtsKDne4sdjkk7DYpvhxAKhGahsV?=
 =?us-ascii?Q?dSaWFsf5emBQJ3G1suFdlfrHZxYJYycZr1Rhm1M0KUatSSm7u/TXCGa9NYSB?=
 =?us-ascii?Q?vPmWj2u1MPfP9wg/Oqy3kxjsjUU6O+tSajUFqreSXZKq5W3+LXkmrLVE7sbA?=
 =?us-ascii?Q?x0tQs+mSQ/9laVLKFIqBweUVcLxTtY+TDQ2J1nkc/KGGmBa2U3HNK+OYtEqt?=
 =?us-ascii?Q?Q+vhXGaEjrpdE841dleIIxZ/KlxUX+Vey8QQ+G4cbGsfmYS4OjYw39bfNtjK?=
 =?us-ascii?Q?/gSdeSeYgYWT1xPa4z+kVLgBE6SEpmCvnUiOg+xY?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7130eb99-5fd0-4d01-4f4c-08dbdf5724f1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 06:02:37.9485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97bADyvaXp2uOTo2RGg+SHclHgDC2LTA7uk3Sg/YHKi1re3wdaRn0sFrUT5C42T8XF7+G8n8cfMURG3VddxJ4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9669

This patch adds a new function mptcp_userspace_pm_flush_addrs_list() to
free the userspace local addresses list. Invoke it when flushing addresses
from netlink commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   |  2 ++
 net/mptcp/pm_userspace.c | 25 +++++++++++++++++++++++++
 net/mptcp/protocol.h     |  1 +
 3 files changed, 28 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index dbf040e39af4..95a793c6702a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1568,6 +1568,8 @@ int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
 	mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
 	synchronize_rcu();
 	__flush_addrs(&free_list);
+
+	mptcp_userspace_pm_flush_addrs_list(sock_net(skb->sk));
 	return 0;
 }
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 321224e09d40..fd74c0092039 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -20,6 +20,8 @@ void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk)
 	list_splice_init(&msk->pm.userspace_pm_local_addr_list, &free_list);
 	spin_unlock_bh(&msk->pm.lock);
 
+	mptcp_pm_remove_addrs_and_subflows(msk, &free_list);
+
 	list_for_each_entry_safe(entry, tmp, &free_list, list) {
 		sock_kfree_s(sk, entry, sizeof(*entry));
 	}
@@ -548,3 +550,26 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
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
+		struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+		struct sock *sk = (struct sock *)msk;
+
+		if (mptcp_pm_is_userspace(msk)) {
+			lock_sock(sk);
+			spin_lock_bh(&pernet->lock);
+			bitmap_zero(pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+			spin_unlock_bh(&pernet->lock);
+			mptcp_userspace_pm_free_local_addr_list(msk);
+			release_sock(sk);
+		}
+
+		sock_put(sk);
+		cond_resched();
+	}
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c38350abac1d..54f96e7f7603 100644
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

