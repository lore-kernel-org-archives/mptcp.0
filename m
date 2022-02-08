Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0202C9C
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 11:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644318994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=avijuwv4MHhBO/kdomxL/T1ROgeN2qBmsBupAil1A/g=;
	b=IjNb1Rf7REmi5Qg0FyjPalICfMRcBI4rldrXEn1qcS+BWS2c/VEOdAnqy6QjF8Z7/+rwOS
	oavdxvj3aM0s/AJhOjseTQPx4ICCYbFPN5X5WqdkO/ICmzunyB7awWwIqKtfTC81n527Uh
	1i0vv2bb90qeYvZuTpQTo5VU8HLFhHs=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-5-dbF9xo2tPQKp61Ct_LcS5Q-1; Tue, 08 Feb 2022 12:16:33 +0100
X-MC-Unique: dbF9xo2tPQKp61Ct_LcS5Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpg3K3yEpU3hEM7f8wFV87fiJtHLDL5wCsSGuVd1mjRVQ6+/+aZBhpRp/yQc5jXgFIVMwWFFccXGXB/hzKId1VMEJTdgrig5Mvbz4PYnKSBTtGU/KuRkz9tjld/hoH32PNxtQwKThCSQ5mO6c0hh1tbkSdXzAAy7Zl9E4JMCqQAWRYnbupb+chOZFkqwZ9N08e2ZVizj24TMx8xPsnkIsLeK0VwFzdUDWYBsEYg+4Jvpactw8gr2SitMnE5C7aLkOM6OgYZG5FdKOt/bCgF/Ku88Vz4+AVUNCVl2bdm6/HiHxjQjdKkFeU+pefO6BdNWbM+RmrpNZqda+D7yYMQbbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cdY0pshSrxE4NM7U2au9CEgOzsggCw92fZKlwl/9iU=;
 b=il3C2hKKXuMOlLn5KBa0lLVaeN8QKgt4BwZ3hPwRIxoIPP40aFSFGr0Jb9ybkDAqT1UTC4h2KJBdzn63uzg4tCzylE9kXb3K4Wuu+ioTjSD3LX9/CVifIsjBNTT+w3koPn7PkIfC7u53Q7Z2gv/PJs8Ikn3NsadBg4gfgxDwuvRIXUaTjnEudf62SeVF6Ms3W96hN8xJDTSmEgS2tSgbELoaidMgLC41xo8q62Mc2G6OS+pGfkU+j83qF8UDZXop8s8xaCiiw/HY2okEBdx47Ftbx8Q2oEE+Ct1vedd0M9JlCVNqtTEISXRXy05rOIXDq5nXr2jFhFXUA3Ic1xI90Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9103.eurprd04.prod.outlook.com (2603:10a6:150:22::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Tue, 8 Feb
 2022 11:16:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 11:16:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 3/4] mptcp: drop echo parameter of mptcp_pm_add_addr_signal
Date: Tue,  8 Feb 2022 19:16:07 +0800
Message-ID: <c5e5fc786affd646055c53d7ce5ead26cd8ea8f6.1644318561.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644318561.git.geliang.tang@suse.com>
References: <cover.1644318561.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0046.apcprd04.prod.outlook.com
 (2603:1096:202:14::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc4391d7-b9ae-4098-f67d-08d9eaf475f4
X-MS-TrafficTypeDiagnostic: GV1PR04MB9103:EE_
X-Microsoft-Antispam-PRVS:
	<GV1PR04MB91035D0E2B5731CDA520B762F82D9@GV1PR04MB9103.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k8yjWqS6jYzxGx/mponsZFG0BujBkBCzKDf27O3WD9zj2uMkqwqYuGCfwKkpAG8GusRDObmw0bOy1d0QSDXFKAscPGLhskrxYCuNFwN2bwdoMQbZ/pEdOqiuxsvQtr81qSwJ+mA4KwyRbkz39Gn7IyPkpSiswHNZXl4LLL6rWn3f8QEI0o/jr9MsRBD4qj0sRI0guftddepVg6T9yLtYQ5gNBscyUsAPPDa8BebzzWIwjLQMoTNVeYzCqX0k78brHL9ec3A80QHRiwc30IxLl25PHpJCx6MghceYgWUQCmeCD80iyBgNpYaPC1+G44QZXxVkJmHTVKKWxUkSseWUG7824RzWBlVvxxV7BTfu8bZWWIdH4ysQqWqL70nl3L5tWavEIwAS8gGzRQuW3VyLOkrXfFFPfuOvBI7gi6sAHMQjwem3jXFeXz1wHl86bCXmBdYDK+/o27lO8zonKNQTxSL+N+39c3wZXqw5OLLKDwSSLm1p9Dm9xyUNtDfogyFRh4OpLtj5E1oD/vzv7d5kniHY7/ZVdOClUXOKqvXRKmw5tFODY3YIrZTkWRV29606iffVdA4iOwy1CaNDUtT2TyFCmNLsLzjTbSbDUcG0ula5nyEeAD+/WUOCDvgJfmMDqrQTPB2JqzoQLnJakxrY8mafwAQB0Z0ZSNXeq0iGnymWH805qROuxgkxX+sZQlPSL07ZgFw6VKXF71DAu58vZg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(66946007)(316002)(186003)(4326008)(86362001)(8936002)(66476007)(2906002)(508600001)(5660300002)(83380400001)(8676002)(38100700002)(6486002)(6916009)(36756003)(26005)(6666004)(6512007)(2616005)(6506007)(55236004)(107886003)(66556008)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9qt16R6CIJ6dx5PaZRCcTYz8DEvkeqkb7UMEYuR/3rwLCGTBRtBgeWDAnXoA?=
 =?us-ascii?Q?jVPWFXfR2RI7+nOxJv/fsD65oBPFAanq5euhSfs2w2eQCZvB9Z9GrZ3n+ZEC?=
 =?us-ascii?Q?iq5QIzqAwNHAg6bR0Hgd6n8OAN8z6Air7nh+ULRrDk9pkbNjjyZm61pWEaBp?=
 =?us-ascii?Q?AZENDkGftVmtyqPJFhJHqyeIYFvknf0kcXsLxFrMu7vyd0gb/CeVer6J0HVj?=
 =?us-ascii?Q?aWJZf1G+Ml0ceokusYin/QpEhEX4slLPBGeELkL+Xlym70nv6mU+x/X3KM/t?=
 =?us-ascii?Q?Ag1UtOmh0+j+KVeXwLi5yt0dbsq6JdvwwFJU/HrDzZZ9kimVFC1IbWNOZH/A?=
 =?us-ascii?Q?Z/Zelm/6lINdVmK0npnhnVjJwkI8EPwN5YR2EPy5YHUESmWeOokVthgXFWXV?=
 =?us-ascii?Q?MJJPcnZfAkcait20lmJZdp7KcU2UB6T6ptZJfHfiDM5gWsT3RHihYTtnzeTE?=
 =?us-ascii?Q?6kfjg0u3wqcUNndutrpLV+NtCTTxxnxGTHMYGlOiOIKwx78GibmFI7Qoooz9?=
 =?us-ascii?Q?IaEwGBd7CF7Iy5r7cVhYnLfbzEIjTgBKW6nyy8W8bPxRlPwg40bcj4qOuETj?=
 =?us-ascii?Q?t2/8vDIqnxRv1a094OKokt6zGA+PjOggd9gD8L6VLuxdPHWd73avMKNdobsE?=
 =?us-ascii?Q?onLocNpfX4XGikGsJlXcIaOA1px8HJE7622PXBd4K9kud36KGjLkR+vgwwlf?=
 =?us-ascii?Q?1pzGSoY5+m2EmE4cBmgTUEF7O29whXk//A/n2EAqVwrQj4APZ4aFsICpSCCz?=
 =?us-ascii?Q?+7Ey5ansCCWSpIFVZw7qn2ogSlD80kWOIqIiO8yrldf2SeMOkHgokdOCO0Bm?=
 =?us-ascii?Q?/yd4L65SqgczWuqaBWKCddzB61cM39aiRxLcU3mNiyMlIcx3fk9WYOm6Y8ki?=
 =?us-ascii?Q?zIPjRVE3I9CFf9xR5N/OAEmnp2f3FRa7PH0yqdUGnr0hC3FmGTfaesEnrH96?=
 =?us-ascii?Q?h1UTXk20ywGRGPkfi064a644vzZb3lgEBqYBJABgw7Is8yNGY1DUpZXnHtz6?=
 =?us-ascii?Q?rKsSu8GDQL4ZugCwvRzJWNoueYJbgzJ9cm74p7IoRyVo1Hy/nj/Y7Vzv1Jn4?=
 =?us-ascii?Q?Z9KuCzZ5FQFsW4UqBgmIkBuBZi1wi4tP6A/UOfPCDfEftEvSdlMP0FiIaS22?=
 =?us-ascii?Q?svM9KGvrduF+rE5+6G/feztnY3IbKVcxM9eMR/6j7/Tg+UuFkUDFzk8ovm7u?=
 =?us-ascii?Q?2O5L9I7z0XXYev4wMd9ZnujTq3VeF9CNDD2IRaZZ+zLsvzkSEwVy3rZvB98H?=
 =?us-ascii?Q?bdFS0CfA1JvA0Tv+PCS2est4IkoQxt5o5AZa2g1D4/ea+iI9wCxQ5MbxbPK6?=
 =?us-ascii?Q?v0yAqmUgQ0x3q7XxFB20xg1LeJiNT2Gu3CypiAq44+CQ4a1DTY6KDa6+sYHJ?=
 =?us-ascii?Q?BoOsC3AqN49GDGXByxdoE+jNHvTTkdXNAy9UgTH7N6lrSPWjO52WYMoxmEEL?=
 =?us-ascii?Q?iDLvFynch2BQkbYW0kUlcb6RnnRzqUv2w9PguWbqrE4H4kpJPkJAPuDbo+QV?=
 =?us-ascii?Q?aOX3t1NR3g/op9vyUcT/Yg4glabiY1WWJzGlxuOOYZeJFdDeb4muZSB1C0NX?=
 =?us-ascii?Q?TRktiChKW3KY7xm3hkR0YTtYDAzyHbs8VeR4bAoLbx4ivKd6rxokXtbM0iUH?=
 =?us-ascii?Q?WVUxll94Pt3RL9GMz1jInUo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc4391d7-b9ae-4098-f67d-08d9eaf475f4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 11:16:32.4356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zWMO0haLsIhaO72n3vz1KoLVDSlBfWEyBirA1OjKQrrBdDfw0O+Bb4GdiFYwaYelbT6bRsdVglwXN1Bsbid6VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9103

Drop the echo parameter of mptcp_pm_add_addr_signal() and reflect it to
avoid passing too many parameters.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/options.c  |  9 ++++-----
 net/mptcp/pm.c       | 13 +++++++------
 net/mptcp/protocol.h |  2 +-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 4070a9104386..9d7228f12473 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -652,7 +652,6 @@ static bool mptcp_established_options_add_addr(struct s=
ock *sk, struct sk_buff *
 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
 	bool drop_other_suboptions =3D false;
 	unsigned int opt_size =3D *size;
-	bool echo;
 	int len;
=20
 	/* add addr will strip the existing options, be sure to avoid breaking
@@ -661,12 +660,12 @@ static bool mptcp_established_options_add_addr(struct=
 sock *sk, struct sk_buff *
 	if (!mptcp_pm_should_add_signal(msk) ||
 	    (opts->suboptions & (OPTION_MPTCP_MPJ_ACK | OPTION_MPTCP_MPC_ACK)) ||
 	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, &opts->addr,
-		    &echo, &drop_other_suboptions))
+		    &drop_other_suboptions))
 		return false;
=20
 	if (drop_other_suboptions)
 		remaining +=3D opt_size;
-	len =3D mptcp_add_addr_len(opts->addr.family, echo, !!opts->addr.port);
+	len =3D mptcp_add_addr_len(opts->addr.family, opts->addr.echo, !!opts->ad=
dr.port);
 	if (remaining < len)
 		return false;
=20
@@ -684,13 +683,13 @@ static bool mptcp_established_options_add_addr(struct=
 sock *sk, struct sk_buff *
 		*size -=3D opt_size;
 	}
 	opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
-	if (!echo) {
+	if (!opts->addr.echo) {
 		opts->ahmac =3D add_addr_generate_hmac(msk->local_key,
 						     msk->remote_key,
 						     &opts->addr);
 	}
 	pr_debug("addr_id=3D%d, ahmac=3D%llu, echo=3D%d, port=3D%d",
-		 opts->addr.id, opts->ahmac, echo, ntohs(opts->addr.port));
+		 opts->addr.id, opts->ahmac, opts->addr.echo, ntohs(opts->addr.port));
=20
 	return true;
 }
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 99db7270e461..8dd78424f86e 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -283,13 +283,14 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 f=
ail_seq)
=20
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
 			      unsigned int opt_size, unsigned int remaining,
-			      struct mptcp_addr_info *addr, bool *echo,
+			      struct mptcp_addr_info *addr,
 			      bool *drop_other_suboptions)
 {
 	int ret =3D false;
 	u8 add_addr;
 	u8 family;
 	bool port;
+	bool echo;
=20
 	spin_lock_bh(&msk->pm.lock);
=20
@@ -306,14 +307,14 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk,=
 struct sk_buff *skb,
 		*drop_other_suboptions =3D true;
 	}
=20
-	*echo =3D mptcp_pm_should_add_signal_echo(msk);
-	port =3D !!(*echo ? msk->pm.remote.port : msk->pm.local.port);
+	echo =3D mptcp_pm_should_add_signal_echo(msk);
+	port =3D !!(echo ? msk->pm.remote.port : msk->pm.local.port);
=20
-	family =3D *echo ? msk->pm.remote.family : msk->pm.local.family;
-	if (remaining < mptcp_add_addr_len(family, *echo, port))
+	family =3D echo ? msk->pm.remote.family : msk->pm.local.family;
+	if (remaining < mptcp_add_addr_len(family, echo, port))
 		goto out_unlock;
=20
-	if (*echo) {
+	if (echo) {
 		*addr =3D msk->pm.remote;
 		add_addr =3D msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_ECHO);
 	} else {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4becac89a4a6..7ee6a39a7ff9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -833,7 +833,7 @@ static inline int mptcp_rm_addr_len(const struct mptcp_=
rm_list *rm_list)
=20
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
 			      unsigned int opt_size, unsigned int remaining,
-			      struct mptcp_addr_info *addr, bool *echo,
+			      struct mptcp_addr_info *addr,
 			      bool *drop_other_suboptions);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remainin=
g,
 			     struct mptcp_rm_list *rm_list);
--=20
2.34.1

