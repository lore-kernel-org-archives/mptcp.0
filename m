Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BD22C9C
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 11:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644318980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=91OKDAyXdL5jehb8cYgDCVCTG9iLXM1RPm9Dv30CYUU=;
	b=gBAGniJLnHQ0yHpL1nsBZW+MfhwDxpYvsUneCtnJv7S8tuPT2y4Ch9HT4HmegXWdFOk4+9
	ncv2J3BdMA3tmSKkhN7lbpLxBKWsqKV3SMMCboYMK+ai9/KDGoVSlkTSvB9ab4dyToaCyk
	W4Mg3sbhdR/al6JHtvuafeJ7ikl8zoA=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2109.outbound.protection.outlook.com [104.47.17.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-11-hkxzvQqzMmKafl6D4od7_w-1; Tue, 08 Feb 2022 12:16:19 +0100
X-MC-Unique: hkxzvQqzMmKafl6D4od7_w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Teef9oX3macXW/+TkrAqY1fUfKINtqZNS/zKqgrAaH8fNrbsg1AQsTxuZilUruVrZyBuhbiTrmeyRoTq370zuacwRevdcGNqD29NamY5B+PigGoZgklTEOVFDqgjdKgIAvx3zAC5iLqWT6JbSRrtW8nNowGtywDVeFNEVznfeGBn45d9e4EGXX2iDzCriBnWSq/RFm/iJLD4uhlYvuQzMsE390f71muyZzq3Q1l/GZoSdDEfe7hhnNpyB3U81XNg2/QKHW0p/dvA60RH83Mjd9C7Rv8zwv4suIMRUvX/Z4pz5wqvd/yugPRGZYijYY1AfghHV+BQDi1u4HfIvJifVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kpyTirRczD+rLyX7/K1jZ6za+90k0nrCbtfPwN5LZ4=;
 b=XpVRRhbox9mdL1QRhUwqMavzQvity3005wD5g0ERoaugktwGCTFT4o1b8LdLfGiD4P61m0GbJK7tL0uSzU3TqowsNJyhQNLnEXwcp0oJ/88GB0szdlMJREFrgS3y4/nz8VpnM/fNv8UdCt+QIg6uH0+sAtReCjjV8K+4y0shBhr4VTleov5DePh63ZX1wJHIje9TkhJbQL8ZyOElBZLzJHfhC0EU4WqK7BQ4YHN79NvQge7UF6OXXtEmvnuaGQDTIjtyiqpeu39NJYYH+yRlGvOO2JHeb7+AKiDr3EEy+4kT6Rwe4LCw2X2LuVn59frH2+v41YcJy70ejKD6UuCxbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9005.eurprd04.prod.outlook.com (2603:10a6:102:210::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Tue, 8 Feb
 2022 11:16:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 11:16:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/4] mptcp: drop port parameter of mptcp_pm_add_addr_signal
Date: Tue,  8 Feb 2022 19:16:05 +0800
Message-ID: <d34da01837f0f01060a0240c00870df9372c2e39.1644318561.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644318561.git.geliang.tang@suse.com>
References: <cover.1644318561.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0075.apcprd04.prod.outlook.com
 (2603:1096:202:15::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b4567e4-c144-4c96-224d-08d9eaf46d98
X-MS-TrafficTypeDiagnostic: PAXPR04MB9005:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB9005C2106774DCA83631C71DF82D9@PAXPR04MB9005.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jfAH9eyEOz+JNI+RRq2z8Tj7iFrSiSeTYoqKQvxYWEUJk2CEWY2xLt3UwsMDP0ZVWGc1q7L7jMFNczV6v8wWaoAiUISS5EjOHAt/wxIEULNBfBY5LmU/7ODC1PZzZu+4T/BGmlFsAOxYeWFOMQD2/RPTEIkK7zSrUPQePAy04LJbjGoszj0eLg4YKyDbQNbHjVLT54GoEVl7KVx/GkELAQrn5pos30Wmq5bSewE5F90UMQIyqf53Ml0EAnqlhz8YmJBCXq9kR0z7F3xk6iDxhUBXSL9aT7/bo1itYfcuCzRwI9EeFKd/1O6cj24Oo7uRq/+eU5YTirc1px93dXf59LCw4W7jHZ1vsSguf0x+X5hs9EpPdHK70yMEa5PFo1w8+/ALVbzuCt2SZshd3RsRNuzMHcWE0qe9jM0UWEgUXQOKi6Su2rXA2hSvhUkmm64aefGC9NS1wdp60ak3CG3HjX2rK8gc5EA9wEHWku50aZM+Xs++UFAxlWUtkh8lwD/x4Li4q3DJ8EzOdJotwYD2I/6wuAriGjdWgr1MPG2Qiqz/yYPkp+ECoDJrmXf1VtLS7bpTAim7YIBWVggSUzjuOq629r1KoOrKCT6EI83/xhhSM0hENBejuGA2E2PBBb5Bsvdwc0TA2Dsr6fhP3aPBtlMUoa9cVVJrgl8NeK125P3G+BsVzNPjVMjpr50cTNoL6WhsX55X7xOszY+4K3L76g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(55236004)(6666004)(66556008)(66946007)(508600001)(6506007)(6486002)(6916009)(66476007)(316002)(26005)(36756003)(8936002)(4326008)(83380400001)(8676002)(6512007)(2616005)(186003)(107886003)(5660300002)(38100700002)(2906002)(44832011)(86362001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bkIHyRTU21Ct2f5O68+0tIoWYB+0vSIou5ZZ7KQvtWczsajx7p8A4464VIUH?=
 =?us-ascii?Q?4N1iQ1TPu7nANL7LY+5eW42u7YazgGh08o/4YIL29z7iinGTWNZWwxqsXxll?=
 =?us-ascii?Q?RG2EhYB5jjrDFaF84JlnqAoigIKJTmRCZCfWuCMmqKGCmMvGpJkOy8krPom6?=
 =?us-ascii?Q?FG0p9e/bX0uHM+LOxiMgBab5/NBCksVqkgLQOQQXJUE+Yxv2bHxjQCovrenW?=
 =?us-ascii?Q?n7Fo1RS7Z9dUBAKiF+B5Vo5/KRnbkoqAVlZyjHnrmCyTAFCAI6qvQf0r6OBJ?=
 =?us-ascii?Q?47j76ja/OKJ96YKWX6Xse6pJn3NPPpTfzKEOeZeAdNP6BhoIQRmYyntsSjzI?=
 =?us-ascii?Q?iAXmGjRFcuAYF/aEinC1/ueDFZP5FWulRDxfkdpdVAOHNr6AIoYHieFxtVJW?=
 =?us-ascii?Q?YUG1LmLh+JudZaCUhyFOqTRadLP56KnHeYYmvrbSrLgsA//z6nsTJJBXyKHI?=
 =?us-ascii?Q?JDaeiMMXiD+FgNNx8yiIIlvTFGbJQzyJHOti2KcUApHwVPnkWNv08Kw3An6f?=
 =?us-ascii?Q?DffdxoNDUEEwmHclYB/0g9E6fb4KeJ9ea7waP5qGfbn6bzHNCLLGR/smWWbf?=
 =?us-ascii?Q?TAM81zhPUSHwa5etO9ox+aV5M85gx7S40cu3E0FO7skruU5qwsa8r14GdyYT?=
 =?us-ascii?Q?uOEmcJJA3J8CgkRROBYdOrktuUhMKSUWuiPbdcxUKx6oG5nLEffFAyRB9VE/?=
 =?us-ascii?Q?IAJ5rSiGEdSn3St8hiwE9ESrh/V9LbK2sGeCjvwMTlQl+OCGYC9XIVI69BGZ?=
 =?us-ascii?Q?bqcf/ya7WNivztSVJqlySjbI9XucnEmooGiaGzDRwcKJgYgbrPYYpwHA5Tqf?=
 =?us-ascii?Q?/k10NF5+0pWuIH63/Zff0S3UYdsoHiNNmyoTy4LWf7hEK+ewDjzc1A06QCa0?=
 =?us-ascii?Q?AoPOf2mf1+92T1Wa+DaWHrkqS/myopyWNH6jiVPu2P45GgVDWgcrolhd5c5w?=
 =?us-ascii?Q?O4edJeoqPPIgLWNyejfkdipZVPe8u5Y9K6AyIOrNefcTbT1oYrWpM2/YEW3l?=
 =?us-ascii?Q?wcJiLQTkW/uwoaBCo5psMmpvuJzNPPH0oyhY+Lz8E9YV+F+bHBSNVZbC2b6S?=
 =?us-ascii?Q?pcYPT3BWP5/fxjj/U8J5Ey7jMu43ioEZi34TXs50L2udmCpFsm4wPcKyZeeW?=
 =?us-ascii?Q?M62B1PotYZAXDEOQL6ra06vhhKQAWo+3nr+SXUjVLeKM720PDQOoo3gHhkwZ?=
 =?us-ascii?Q?tk4aub4iPcOAS6re6CIaRN/hOIHHz42IaGCry5HAjR7iGtcJI06gogBODLr/?=
 =?us-ascii?Q?OOrHwHKjv4FOnwcj5CgecYlIbawIfqHbBvSs+KbpdvEkVvSs6dsljt5cYHMW?=
 =?us-ascii?Q?rVGjv+GWhH5VXOwbUY10LlyoVSp5pX+SfIdojlxAKiH/mR/EAosf9gOu9w8u?=
 =?us-ascii?Q?foKiwO6Yy5MuTey1OOxbJwDoXCwAP9ZxP4W1BCy1yiM/7YVAI0NWFnTvFh/a?=
 =?us-ascii?Q?+LlL5mCVnVeDr47RyKccVz2lYanE4LGqH5hqtCH/EEcpFQSSZAiU+33nspsO?=
 =?us-ascii?Q?xg+20/lJ5To/RM4J/A69ceSFYHo6ZUImTXU2uj6leH4EFXSiQsSfMVf4MSaK?=
 =?us-ascii?Q?2PfSGuPgTL0gI9JKA4zeNy6MdOtVK5Ygxf42VC9SdFVH3fm+wzwrzo0ddmfM?=
 =?us-ascii?Q?EtH6cZrZ9OrcwaLhUXq2Rds=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4567e4-c144-4c96-224d-08d9eaf46d98
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 11:16:18.3742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0a7IfiiuSsy0BLEBLAw2ClYUPZ5FwBEutP7fPKmc+fAQhSc82Ar8RX0cZS6DWo5xBbvN0o5qyud9D3L3ylFsSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9005

Drop the port parameter of mptcp_pm_add_addr_signal() and reflect it to
avoid passing too many parameters.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/options.c  | 5 ++---
 net/mptcp/pm.c       | 7 ++++---
 net/mptcp/protocol.h | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 7b615dc10897..4e516e88ab88 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -652,7 +652,6 @@ static bool mptcp_established_options_add_addr(struct s=
ock *sk, struct sk_buff *
 	bool drop_other_suboptions =3D false;
 	unsigned int opt_size =3D *size;
 	bool echo;
-	bool port;
 	int len;
=20
 	/* add addr will strip the existing options, be sure to avoid breaking
@@ -661,12 +660,12 @@ static bool mptcp_established_options_add_addr(struct=
 sock *sk, struct sk_buff *
 	if (!mptcp_pm_should_add_signal(msk) ||
 	    (opts->suboptions & (OPTION_MPTCP_MPJ_ACK | OPTION_MPTCP_MPC_ACK)) ||
 	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, &opts->addr,
-		    &echo, &port, &drop_other_suboptions))
+		    &echo, &drop_other_suboptions))
 		return false;
=20
 	if (drop_other_suboptions)
 		remaining +=3D opt_size;
-	len =3D mptcp_add_addr_len(opts->addr.family, echo, port);
+	len =3D mptcp_add_addr_len(opts->addr.family, echo, !!opts->addr.port);
 	if (remaining < len)
 		return false;
=20
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 1f8878cc29e3..99db7270e461 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -284,11 +284,12 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 f=
ail_seq)
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
 			      unsigned int opt_size, unsigned int remaining,
 			      struct mptcp_addr_info *addr, bool *echo,
-			      bool *port, bool *drop_other_suboptions)
+			      bool *drop_other_suboptions)
 {
 	int ret =3D false;
 	u8 add_addr;
 	u8 family;
+	bool port;
=20
 	spin_lock_bh(&msk->pm.lock);
=20
@@ -306,10 +307,10 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk,=
 struct sk_buff *skb,
 	}
=20
 	*echo =3D mptcp_pm_should_add_signal_echo(msk);
-	*port =3D !!(*echo ? msk->pm.remote.port : msk->pm.local.port);
+	port =3D !!(*echo ? msk->pm.remote.port : msk->pm.local.port);
=20
 	family =3D *echo ? msk->pm.remote.family : msk->pm.local.family;
-	if (remaining < mptcp_add_addr_len(family, *echo, *port))
+	if (remaining < mptcp_add_addr_len(family, *echo, port))
 		goto out_unlock;
=20
 	if (*echo) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f37f087caab3..0eebfc9f39bc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -835,7 +835,7 @@ static inline int mptcp_rm_addr_len(const struct mptcp_=
rm_list *rm_list)
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
 			      unsigned int opt_size, unsigned int remaining,
 			      struct mptcp_addr_info *addr, bool *echo,
-			      bool *port, bool *drop_other_suboptions);
+			      bool *drop_other_suboptions);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remainin=
g,
 			     struct mptcp_rm_list *rm_list);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)=
;
--=20
2.34.1

