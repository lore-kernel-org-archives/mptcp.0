Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2065.outbound.protection.outlook.com [40.107.104.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637D6B663
	for <mptcp@lists.linux.dev>; Fri, 17 Nov 2023 08:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DVgDcSoB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xa8jPYJVJkcxexbtHQEU6rgXwNLux/SUCamupUH6bMHiHYL8mcp1PBdFkonefobKD2DMugo9hUhmLFiuFaGIgjiuyFfYW7DhoT9bs0e2+hfkQN6CBGLiyCWM0V/e7Of9nSb6B4BuFxYuRuQAJL3B5lXqJtF2suVK+cP8dpwxe0qsAYrc0Mk4qpGlh2e7kCDm2Udug59EOkz865mXqIJMBAney1USj1E7k/SkVeJXxVIGLCd7zKlbNMHvL9VhDWYx0Pu3X2Vono3t8rUSkbYD4PA0o8hrxYl0Sce3leCua+fl5ZLfAzxc4f4ruLF8IDbE5pGK8/JFVB8uw1UPJzxlmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQNAp5J3G/Q4AYPSbSIqAc6tXYNaKq0BizhzQXW2FyQ=;
 b=TAc5gROrLM6iAuuc3xxEge6w7ZW1nooPjgsOp2RWwdrkBTiCoaMBnvN2fs6rxraCO1J0OGUjGyceovukjRHtVdnNSYdw2l6eJ+pifNgm+imD6S44GqT+wvS41AHBaXhHD24TS5/ndKI/vGN/AQo/o4xdRUH3OqzTa1UNfxoc9GRVIqmMPD+S5/m9JvJlTohHc8hH7FxxD+uhUqHBAGOf7zImLqoTgH2V+QXOLAbNuNShGO4BlXJL2mtHMQJmT8KDOsJUTYSf7T3h0doCtTxQk7hIpbqa1DvHd9wpct4yU2m9hy2AHTulcXIBcscrpytqiEIvb+vmRtm96srLcpH2fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQNAp5J3G/Q4AYPSbSIqAc6tXYNaKq0BizhzQXW2FyQ=;
 b=DVgDcSoBKYW7pYtFxBB/jEIbHwSShP9uvGU+v4alMv4B01+++AIWZOxqzPhogmEKMqnYoPh7sbR2WXVR0827+1nBkcadSRE9p4nktsMga2eAUEoHxDAYW7Ai+yEdJ6HBpoWG/1QigEVWtqB40Q6Gpg2mw1V1psVCJp/AWt/mJ7DaQOVrAUoCsCEE8cxMMh2sfa8bC+OIL03oYh7zp2O46Q4moHM4MItBb32SAwLbRFyprOe0yvZGkN+A7PT5oL5ZgZdiWX/brfK+azE26ENGRXunJUMSqKgniNnTLvvp4htZvGc27BCSbwPd+jOcSerhO+JpmzUbr13XsjtvfPKvpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB9975.eurprd04.prod.outlook.com (2603:10a6:150:118::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Fri, 17 Nov
 2023 08:58:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Fri, 17 Nov 2023
 08:58:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 21/26] mptcp: add check_id for lookup_anno_list_by_saddr
Date: Fri, 17 Nov 2023 16:56:14 +0800
Message-Id: <74bd066312df311c6d3479189289285a33542763.1700210966.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700210966.git.geliang.tang@suse.com>
References: <cover.1700210966.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB9975:EE_
X-MS-Office365-Filtering-Correlation-Id: 81422154-33de-4dff-8e38-08dbe74b5dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WLCgD1P8QaUYpDVGK4g1d/I5MQo5lqVuh6UzzapHnVlZicSOvQNEpiOnx4KR70T/bUgp8ZLU4VcwUD+3f2F9L6VrHrJ5OkaneYVup2TZZF+kAnTMufyiBcPXMfkRdPCYp6QBWMdDSiJYzb7A3s6N2vGqX28ekmBH1/T2x8YL58MgyxJaM63TRwLbkj2Ln+Zphtd0FpD9+uJvYPDSbE4LpoXixEIVkQqm4lhX/YBTYk9OCkV7Y5BkrppcuFHHIcepfHWK7MF0l6PIyBV5VQbQqplwcE0o6Pj0lON1evQBQV6C6OYLbp8GCJXZZhINW77VCz1qa0drxUyOyvv60zDPQxLxYmhsbaqmlNqvYSL99bM7+hQ4ttBSzJaRPzA0/VpIzBwnODoRBMRrCrkc7Ec0OzBZOsz/RNhWp5OvEzX1CpEzQ2QS0DqmfxM9Blw0OLdT1wBpdY2obPmXh2kBEym7VOn+qGPwHByGSJF8lHADqaygenDT+IWUtgDhQucx28eEF11OHcx55KBdrkDBcP49aHXJXcToJ23y0VjY6/o7Eb8+t+0BoArp5N4z/IH3xm+Z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(5660300002)(2906002)(36756003)(86362001)(6666004)(41300700001)(316002)(6486002)(26005)(66556008)(6916009)(107886003)(66946007)(66476007)(4326008)(8676002)(8936002)(83380400001)(6506007)(6512007)(478600001)(2616005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d7ZP2ljW7thOUQDs9NOfvxCn6qKAN+HAoRoxZ9T0w10vU2WXgmkYhhRaFRyM?=
 =?us-ascii?Q?GXw85jF5ZtYRhLOB6YD06r+BGCn3cERwoC41mtg3boZ+HiJQ9djD+2OAleh+?=
 =?us-ascii?Q?gCTbSYKn7RcQ8PhxU4aKOpB/xhsIpKDXn+KKisheHRznzIXmeZvraAAdOXf5?=
 =?us-ascii?Q?OScB8CAtqJZ1QbQT0A+m26l5V42XnfGYHd0Porw0MiQd9tqape2Stg2w149S?=
 =?us-ascii?Q?k5Isvx8oP9UvZUOxyp54Nw45a+ANK3kz01z67kU0TqbBwn2ddD7k+y5FBYPs?=
 =?us-ascii?Q?A0RFYp4c5olsl+KRq0MkZseQTEit+FnCnWC88bSlRzYQ5XK/KOd+lUulA7i5?=
 =?us-ascii?Q?uY80qESKR0l7h3IIw1rNwdsgglrkkvrPuNBK19FsA6KwxgMj93D2FE1z66Es?=
 =?us-ascii?Q?0M5cnUZQyW/8czOEUlEPNoXiayqWKLbAgWzZ1VtDzHLTU98+SL1P5iloe0rZ?=
 =?us-ascii?Q?AierWbgYu1B5qllX6wC7CWMXDZNSmw4XXQ0OoolIKkJHOTEdQUoamn1v0ptT?=
 =?us-ascii?Q?BI4ICxVldXyX7UDR7IBonI2avR55vMjtUFUkR8P5ajYylTvzwQjsKjH6wtuY?=
 =?us-ascii?Q?tWMwbhEj24+QkeaaJRSU92pHYFWSDTISq8Kt2937Ntl44A5hX5wcH6QDUHq3?=
 =?us-ascii?Q?Uieq0/3q27OdgshfSxZxli2YWvinmac6ibCczY1ycB7Y8E6NkEpoQ0jAwXCT?=
 =?us-ascii?Q?xZYOzJlnCSe9T4u4H8uK24M3XYQnSlikNvkpIAFTm4VwWA7Cf6u/dBLGTBUa?=
 =?us-ascii?Q?5n17mapqd1DbwdHcaWK8N/cblxiMd7FHnfVwYyl3GwnNZrMqdlw4H8DX7hwb?=
 =?us-ascii?Q?kW7HZCh09fvZGO7/obltvr09n++0YGKqabXxpJZ6HgqKToreKqL8ssy1VnP8?=
 =?us-ascii?Q?kLnrU6yUIseDhlmC9rH8psYWIIDtD+L3jROpB40OwnZG0z696CzmMrESDSqQ?=
 =?us-ascii?Q?NrO9QD8P7eCjDhOufB56ABkVzPyI2htiB9L8MmzY1oSlSOxESIMtefwg1Nwl?=
 =?us-ascii?Q?TjuGMut65+UWu/Bb1dCiMO7TFpwXArfC2Q/b92cJaYU6ZuIZvyV8w6W0LOSm?=
 =?us-ascii?Q?16ay2FRMwtXHeagzVpdyuhEjEJF47YreRvhqDjg2Tgn4/FH2hpHztdusAZSX?=
 =?us-ascii?Q?BOob/lEXeXiTYmkapU89SBFqqauAgqMNwfkYYTOvaVrOmV1Ahx6t1eTNs0SB?=
 =?us-ascii?Q?qajaFPrZt304AHAeEvDJwvmi1frgdQPyct33lz2kI0XFCPLMdH3QCB+VDpnz?=
 =?us-ascii?Q?xHKfIba32KsJUr0HVLbbn091YZd6eXAHwO14bt7anouh5+HB5yYF0qkZsVOq?=
 =?us-ascii?Q?nVSOJt3upWhG5VR7WtdMgZhts26CGVvjbiGS1tTMFz/JCZwER+c01xmeZDyN?=
 =?us-ascii?Q?tpuBIgTVmSu/eJLzgOmRHooKWeEUU4nQOFj6X+4GbHGIBSTgd8IjEdzorDX0?=
 =?us-ascii?Q?Vao0tdmpFyGmO0qxtwHByggOPPvt0uymWpNmBR4W/mWWlUTk06Va4kn80mKA?=
 =?us-ascii?Q?geYVNyN5nZqAG8uLXA4G6LPzIpVSd0sWxACqUplnDFYkS1Lfynfn7ob+tCl7?=
 =?us-ascii?Q?VOg9mZLlAmYhOKdnKMHO/QR+/uxccMze9taARbOOexbSx557vHKnipnrpfH7?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81422154-33de-4dff-8e38-08dbe74b5dd8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 08:58:28.9070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4KEVehrYEY4j45SVHj06Z6xOPLqq2/l+/VQXoNVJw7IeIIrN/uizdHUq3/zDFJ9FtpAwbBZMpUBjDXNuGGELQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9975

Add a new parameter check_id for mptcp_lookup_anno_list_by_saddr(), and
pass it to mptcp_addresses_equal(). Then in mptcp_pm_del_add_timer(),
the input parameter check_id can be passed as the new parameter into
mptcp_lookup_anno_list_by_saddr(). After this, this condition:

        (!check_id || entry->addr.id == addr->id)

can be dropped, only test if 'entry' is NULL is enough.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c         |  2 +-
 net/mptcp/pm_netlink.c | 13 +++++++------
 net/mptcp/protocol.h   |  3 ++-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 77a0e859076c..d5ae2e775059 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -259,7 +259,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 
 	spin_lock_bh(&pm->lock);
 
-	if (mptcp_lookup_anno_list_by_saddr(msk, addr) && READ_ONCE(pm->work_pending))
+	if (mptcp_lookup_anno_list_by_saddr(msk, addr, false) && READ_ONCE(pm->work_pending))
 		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
 
 	spin_unlock_bh(&pm->lock);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d82e9456a772..70177c5f9483 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -203,14 +203,15 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
-				const struct mptcp_addr_info *addr)
+				const struct mptcp_addr_info *addr,
+				bool check_id)
 {
 	struct mptcp_pm_add_entry *entry;
 
 	lockdep_assert_held(&msk->pm.lock);
 
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, addr, true, false))
+		if (mptcp_addresses_equal(&entry->addr, addr, true, check_id))
 			return entry;
 	}
 
@@ -290,12 +291,12 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	struct sock *sk = (struct sock *)msk;
 
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
-	if (entry && (!check_id || entry->addr.id == addr->id))
+	entry = mptcp_lookup_anno_list_by_saddr(msk, addr, check_id);
+	if (entry)
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
 	spin_unlock_bh(&msk->pm.lock);
 
-	if (entry && (!check_id || entry->addr.id == addr->id))
+	if (entry)
 		sk_stop_timer_sync(sk, &entry->add_timer);
 
 	return entry;
@@ -310,7 +311,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
+	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr, false);
 
 	if (add_entry) {
 		if (mptcp_pm_is_kernel(msk))
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4a004eea9c38..02ae42135072 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -920,7 +920,8 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr, bool check_id);
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
-				const struct mptcp_addr_info *addr);
+				const struct mptcp_addr_info *addr,
+				bool check_id);
 int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 					 unsigned int id,
 					 u8 *flags, int *ifindex);
-- 
2.35.3

