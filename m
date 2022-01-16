Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DE02CA0
	for <mptcp@lists.linux.dev>; Sun, 16 Jan 2022 08:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642321083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9xzRZ5Ju775pwgMtrQsKSXPn80z2XMlI8UMv0Y0OzJk=;
	b=bINIXUvokYQ6W3qPgC/UBpOZj1De6mlHg+SnJvcnjg37IsKuGdfPJ+HI+1sZAX8JHiwZkD
	QjpK24y0ESqJmiyvbenm04B0RORJPxeXytWnnEv8LO1Ul3QyQtZS5aYb0FK4qO9PyZjSv+
	0Ma+DEEc9AxkYur6fgOuTntyXdFsiBo=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2058.outbound.protection.outlook.com [104.47.14.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-yK3QEqFBMPGLmZrtojvjew-1; Sun, 16 Jan 2022 09:18:02 +0100
X-MC-Unique: yK3QEqFBMPGLmZrtojvjew-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frGRff+p3oJuQ+WkuggTaAGk2xdels4RLJPjVljshuKQFwGU6/gZuOEisnZeH1F0PtwMrdkZgmVRTKvrzBR/S7R6uMXCI0EhkK209tPi7JwpusipiSOf6/WTbugub/G4Xv9R+8goso85KbaMQB86wcY0YHzaBzJFCgOs1CUvyJem1lkLrzf13d7jMxpq1r1qHFsW3WBINomfvpsuWlEpG6Lpk5npVAecXSplOKILDQf+vgGfKd3idyL6a600b1UX+WoyjlKQZPP2bDIo1Ad1gtJWDwCztJRNXmylJBYgGZHscvEA3hEAX/MzHmtE8v1pDb0yCynBHLviEgMaURp+CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0YsZQnzkYI5YgpY2tTKc1guMc6z3BIvtD0mFgYXKCE=;
 b=iWbY7OVhJ9q2tEPmqWs/WjNjorEFzx88/dmT9s8UQZC0aX/c42UajdB4YivmMXYMnvMcDChPgun9j40tnCdh1zNrEgLeAxtLaIodwWqAhE+dDtkf4+0+4HTM+z277lZ4Tk6//VGlddsn7kOOVvQzC1t4Wqi8hDIiQh04u0KqTZTClwwv45z/OiGV8Nv4OHpFzwtlVh/qvZXrTRWuASnGUuf/wx7cfD2p61WCTtD1MN7CeXIAoK64yCI7P2tOdM1Wzd74Jqk9uUPp2/K4DbYJYQoyHiwVZEJQ9P2cgdkFUUdEwshuEES9undDjtZnHIMbCeSfL4REP4T7XIby3jvxVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB7472.eurprd04.prod.outlook.com (2603:10a6:800:1b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Sun, 16 Jan
 2022 08:18:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3837:57a2:45dc:e879]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3837:57a2:45dc:e879%3]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 08:18:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 01/10] mptcp: set fullmesh flag in pm_netlink
Date: Sun, 16 Jan 2022 16:17:31 +0800
Message-ID: <d409cf20cf8b089246ee4218804b32a876a74e94.1642320655.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642320655.git.geliang.tang@suse.com>
References: <cover.1642320655.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 611cd918-ff73-4533-6e9f-08d9d8c8b660
X-MS-TrafficTypeDiagnostic: VE1PR04MB7472:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR04MB7472D3F7AFDEF2F169817216F8569@VE1PR04MB7472.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:392;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/AmG5aROj0/LxAJvYIZ2IGwR3P4CVhQrUaragai0s4GHU0cpKFc9yyksFV89cEGrtQ0ab2BPayIq90OUZBDjGsPZK8rmhcEeYgNns5+OujBH3qggYNGen5ooVz5OGPm7QT8R7UUW2pADvM7ubA0WqOWBJux32hF7ZZ94TiD0t28WDBg8JiRi8fhGCi64ZZpCMKdMICwBbtKm3487haglXeHqvejC/c/2ZuBYfwBjGIt5NfuldZfsdL4J8gBDh5w+4VK35qNFLVu0NF1NKmUnuR5uemRvGzJE73T1wkhGrtW1R5MydTXjG4/AU6NBsYu+4OpvvebtxJZszoxurJ5+8gvDjlvH7VvdiO8zNTRD/w+GJU6FT5fLUkxeOd28iAKLKXI4NclX+ecRt+fecor18kakDJF7MiQe6bAGIwTyhsFB/lL1hqt9ZYzC5q43HrjphVgJUZi51LUoF9zo/jawfDXCQXK6N7dpS0Rk5K54WQY3YAWGIDSKp6RmuI4FFjaH8BcqCMex1p7D8g9dmxIpO/mjB6JjVt+TnW1ACShC/ZYFtxK10JorbuapnpzsdGUGjRQdOXov2EcSzobKyZbTxJmKqYd6rQ4T/HWgMdU3gsXphIPGJ9+ksDLtefId2ZRv4SlGrYW0SWzr0BYczMq9K5a49o8xd4BM5XxPXCTohBZ05z6Tv4EAjQ50Bc/izMoS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(5660300002)(107886003)(6666004)(38100700002)(2616005)(44832011)(6512007)(316002)(186003)(508600001)(66946007)(6916009)(66476007)(4326008)(6486002)(36756003)(83380400001)(8936002)(2906002)(86362001)(26005)(6506007)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8/Z8EAzNsejYBX4tYxYSfNrR1QHflY/6/f2LgZxHdSOeuDYNSFxni6NP2Lb8?=
 =?us-ascii?Q?OcjwWDFr/2B3mKkaBZt6cU/6g6y/Ce6Su6jty9sM8slTfCDMPQEHm2R+B8OK?=
 =?us-ascii?Q?Dgfp283kXm4uz9+ZpsEAKJFWqa8rYgKFTfgJcKeRKQe2Aal3pbW4YwhjUYs1?=
 =?us-ascii?Q?S95xrrkkx3cZauH4qxvEPnYCLg40IaTv7kltTmX8hdu+koEhyIKffv+3Hz4Y?=
 =?us-ascii?Q?iLwMagFguoc5CYvUsb/ETgFaD5uiVW+6wx2mv0spiug703h2jHgNxA4RDopH?=
 =?us-ascii?Q?AeRYyaJ2JYzJpGZh/fbPy0ZE5YLuHU8+EvOgkIxHNZXCkjrypnN/zeN61HwY?=
 =?us-ascii?Q?o1nq1ARrPoM8lDqPm07TFu0lNsbttaS9FCfnIyp0idQFT5eDO+25//46zNzG?=
 =?us-ascii?Q?sWNb+33CpbfvmNCBJrZSA0mHdQ3QcNMsH5RtSuFqjzQ7NlQwb9zr1wKos5fC?=
 =?us-ascii?Q?re4mi6skw5IIg1egR0JAiSxLHyxLYjfUoLP3NhnPF9/gRYlhwsXoZYcaDiJF?=
 =?us-ascii?Q?xJYbyMQ2tlFob4/p0OGfNy+XplCh28cJ1C7bzN+Mu59XUQBqCl8O034qZHzv?=
 =?us-ascii?Q?tJ6mi1OQwZ/b1Y5KpidURi+uXArtOBAejyBcCerNxdbFzOjd6g9L1nYo9txo?=
 =?us-ascii?Q?gxrfBW8Toh9zcKsRFjj1qfePoqZ0EModKvuPc3IrRTdPJ1L97STigiZKG1Ik?=
 =?us-ascii?Q?zNaL/64zSdtm2X4SXyfGZ8rJzmicrNA0ZvH/oDD7LSfQu7J1wCCHBP+xK7/1?=
 =?us-ascii?Q?y3DmDZq5CRjwaLNAnRZHjT1rItQ8ji1AFoPUV22V5CKhmxB5w3zGqe6371Bs?=
 =?us-ascii?Q?c44SKNHp8fvxLnVZ0RKMfphZBgTROqJGE7d40kr9T0puFVAzhBCmkahC2APv?=
 =?us-ascii?Q?NoP2F3qsl4/MyQdSkYEO/pgh7KrERiHQsagBdxI9Ex6dH0cW5F83eUycUgeO?=
 =?us-ascii?Q?l8/lTl5/GfolkyatHxoqPKd/qdcucMrH3oa0BmUYLd+7R2B6hhfgsESrCKpx?=
 =?us-ascii?Q?mCHwZfapSmE9ZAC08Hs1Io6/4vmC8HEP9bzHDfEBBC55AQlAxjciHuwsQS0+?=
 =?us-ascii?Q?WNzIkxFwI3hlUWD/XxaAvhAxslbXzH5ds2qt89yy+AD12CJ9TmOI4wfod6w/?=
 =?us-ascii?Q?py0m7UQqcrvaU3lRLk6W0Sj3T02Bpycz1InrD9ZNXW+KbCpOk/2MpB3CsvEc?=
 =?us-ascii?Q?aoK8DsrdMDec5DjqMS0SGgIYBpyEoQ3wuhVv94RPs0knwZWy0LecRkFOPv89?=
 =?us-ascii?Q?OhrkUQKHNXrEWaR4VZg3EVZoYsgChK0cqyT668g7tJtIrr5wIjkojCeggfJC?=
 =?us-ascii?Q?FhUqHBvuT13B+9c2F4cQjHs5nSIaY72fnfF4L8SgVhSVaf+AhBRl1pi7B6fy?=
 =?us-ascii?Q?kyhr6sCpA0B11Cu8uPHHohlySdnvv6Wm0c3Sn5jUr/4YJ7JDTQf1tTCo1wH1?=
 =?us-ascii?Q?vSCADDXBX1mzUda0T9LDwPbgXSpHZ2EMb2F9w4kDbQl366/2rfBsxd1A/ftu?=
 =?us-ascii?Q?Th932uaSsT4IFWL3c+BhcO1hODTP/4PpZefJFWEmZLin+h5ydn3lwbnThB0k?=
 =?us-ascii?Q?/wEOs/g4s4DpcbLMW/RP5kpWkoOL7lWc2EVy8e9ClzJTTVQ/Go9rErNeVDiT?=
 =?us-ascii?Q?h2LQBmOvCuhUSPmCYyts/Tk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 611cd918-ff73-4533-6e9f-08d9d8c8b660
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 08:18:01.7280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3n4XjEfZpOLIKBSNkzncavMugM+zn3Da6UQxk+A79V9ybOyQGadi82ISrrVNQJc+xq3yBraCYZ9jnlnM0A1dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7472

This patch added the fullmesh flag setting support in pm_netlink.

If the fullmesh flag of the address is changed, remove all the related
subflows, update the fullmesh flag and create subflows again.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 4c06cd6381ef..51df0b478ef0 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1722,9 +1722,20 @@ mptcp_nl_cmd_get_limits(struct sk_buff *skb, struct =
genl_info *info)
 	return -EMSGSIZE;
 }
=20
-static int mptcp_nl_addr_backup(struct net *net,
-				struct mptcp_addr_info *addr,
-				u8 bkup)
+static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
+				 struct mptcp_addr_info *addr)
+{
+	struct mptcp_rm_list list =3D { .nr =3D 0 };
+
+	list.ids[list.nr++] =3D addr->id;
+
+	mptcp_pm_nl_rm_subflow_received(msk, &list);
+	mptcp_pm_create_subflow_or_signal_addr(msk);
+}
+
+static int mptcp_nl_set_flags(struct net *net,
+			      struct mptcp_addr_info *addr,
+			      u8 bkup, u8 changed)
 {
 	long s_slot =3D 0, s_num =3D 0;
 	struct mptcp_sock *msk;
@@ -1738,7 +1749,10 @@ static int mptcp_nl_addr_backup(struct net *net,
=20
 		lock_sock(sk);
 		spin_lock_bh(&msk->pm.lock);
-		ret =3D mptcp_pm_nl_mp_prio_send_ack(msk, addr, bkup);
+		if (changed & MPTCP_PM_ADDR_FLAG_BACKUP)
+			ret =3D mptcp_pm_nl_mp_prio_send_ack(msk, addr, bkup);
+		if (changed & MPTCP_PM_ADDR_FLAG_FULLMESH)
+			mptcp_pm_nl_fullmesh(msk, addr);
 		spin_unlock_bh(&msk->pm.lock);
 		release_sock(sk);
=20
@@ -1755,6 +1769,8 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb=
, struct genl_info *info)
 	struct mptcp_pm_addr_entry addr =3D { .addr =3D { .family =3D AF_UNSPEC }=
, }, *entry;
 	struct nlattr *attr =3D info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct pm_nl_pernet *pernet =3D genl_info_pm_nl(info);
+	u8 changed, mask =3D MPTCP_PM_ADDR_FLAG_BACKUP |
+			   MPTCP_PM_ADDR_FLAG_FULLMESH;
 	struct net *net =3D sock_net(skb->sk);
 	u8 bkup =3D 0, lookup_by_id =3D 0;
 	int ret;
@@ -1777,15 +1793,18 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *s=
kb, struct genl_info *info)
 		spin_unlock_bh(&pernet->lock);
 		return -EINVAL;
 	}
+	if ((addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
+	    (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
+		spin_unlock_bh(&pernet->lock);
+		return -EINVAL;
+	}
=20
-	if (bkup)
-		entry->flags |=3D MPTCP_PM_ADDR_FLAG_BACKUP;
-	else
-		entry->flags &=3D ~MPTCP_PM_ADDR_FLAG_BACKUP;
+	changed =3D (addr.flags ^ entry->flags) & mask;
+	entry->flags =3D (entry->flags & ~mask) | (addr.flags & mask);
 	addr =3D *entry;
 	spin_unlock_bh(&pernet->lock);
=20
-	mptcp_nl_addr_backup(net, &addr.addr, bkup);
+	mptcp_nl_set_flags(net, &addr.addr, bkup, changed);
 	return 0;
 }
=20
--=20
2.31.1

