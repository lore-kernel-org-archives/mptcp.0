Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2071.outbound.protection.outlook.com [40.107.14.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC278466
	for <mptcp@lists.linux.dev>; Mon, 13 Nov 2023 02:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TA5pVJmQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aK1fHlKjoPfALXhvlPHHHss2K3c1DDTnIYECqzxaTEN6vkF9JD+5r903FlGupb+iNQ3pExSC2pg4RiKOJf5qRw0ADosm7n7+0JZBfVeL6ti+JEgLGVuxV8HRP2FBj3C5WlAsR8rUvVJxck5AcKSpZNe/qrh3LvERaXLJL2ckMF3ulgmhiAY4DyDpWcWsP2pdieKh6EXqQ9nyft+YT082eFnGlYN0rmmJXY37QFdhPgt83ysg8inyaPMvTf2PZ1OVSFcNzw7tfSnoTtZhFB8pgERr5FUPG/0wtq6Sez+73Z4mQE093ij1fqSdDm4hzPNdRQCXwefo80AhyrLiJ8gB+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FRJW596KuE3kK6nsuBea0qCL2kAKwvASr4MD+Yxncs=;
 b=lZlS0NysH7XZ7kiZvLCMdlYh4JzQtw6uw09Sa0qu9pZBe5RmI5xR6mctCl+lE+ufuAxyTLVXT4NUW9MfJY+cuNaKSF/u9wL0RDzvH0ALAaSRWW9QYdSEZ9IoRlz9R1kgsx7xkkyh8z2iFscIQ+pPWrJidu1nh2dqxDCof70OZROJ819fqiAQe1Vqzt/ApK8RiTspYt5H623P+3WwYeqjyFN10WNUHn3qes6Da4UqclNrgWHo/JX3AU9ufvXejzmbUYHKskZW8pZ68+09zerA62ZK3yPwzY9bDsw/SWQAxJV0GwxFj6taWgBzTTjG/zVColHopU0BekYloXVfiwcB/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FRJW596KuE3kK6nsuBea0qCL2kAKwvASr4MD+Yxncs=;
 b=TA5pVJmQosAc51HocFTK+DI9QltGepG9RXOmZ0/1PCfBi5qzNQ55wbp79Grq7fzy2Ty018rMP+zczibpHhAjnCLfcVJTomVgKIi4UjuascFAN4kLunDmeWAl6ainzym4nG4XzKlr8LbnThlxPLIFNyyzJtBpm8pgN2YMpPDxk+VEsGUfnJ9PMLKEpcEWZwjBZVoXAohzhua1a5HHFSDBBM6scbXk09zllO5qJgESPshhv+PXd2iKPh5I+wUxsELxpZJG6OM+q0IYwOpWiAI+2BE4YZNbt6NOCG7p+7dU/T8j4lkTpQK6vvKnCVa/OK+aHGS5yozrAVhIO0LpwjYNKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8895.eurprd04.prod.outlook.com (2603:10a6:102:20e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.15; Mon, 13 Nov
 2023 02:50:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Mon, 13 Nov 2023
 02:50:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 20/22] mptcp: dup an entry when removing it
Date: Mon, 13 Nov 2023 10:49:04 +0800
Message-Id: <2bd2573d6229fe85c4d92d5dea33c415ede2246f.1699843617.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699843617.git.geliang.tang@suse.com>
References: <cover.1699843617.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0021.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::8)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: 898d0058-7f04-492b-72f8-08dbe3f3593f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oxtqqh6HY5rloOZmunFUawyYDcavy9g80FwGd24N3gMbaWnmQpKcA0NzRd956M0h7cPhs3iJLzAeKaLjp8Eq4vZAKl3TP1c+hqN7Po9cxT1dpczsh+g+s58Dz6J3Sj6Q8nSr4Wczkst/0UZVyzABZirl7pZAzkP9rJMw0Fb8rDwNfFIucUp67dI0MRIirZsDVx3QRCtk6L++ePs/LlpUC5VGXPabl31Ye0n6M2AELB6v1/SSy5LMrLW4cj3vZiaw8y9c2qi45Z23bgyxTji0KUjYBOc8UR2j5Cabx9pnnWc75D7OITAqrmG39dDsRe5ldoUpblP00mtwFXM9KK7ceqiROwjsTUAl6zEBf/4yRA9GXjAwMSIyF8MlMBK0BTWpIDnXhDasOFBHJlFhpxGCKq6ocHKUY/ENvIqJlYVcpn/7AlxDTyGHqld5Y5/0bsBsi1ZR6kEHa4eU/gwhzPv8wACI5U8kfySscy6qXIb4PZvU9NQosBcIb8DHgEzLdQCyBX/n+kXHSCwa9f1nZqVvZpo1IBE9web/dGes1DHT+7v8xTSc+g1moPeV1SREE7Ti
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(4326008)(8936002)(8676002)(44832011)(38100700002)(66946007)(6506007)(6666004)(66556008)(66476007)(478600001)(6486002)(26005)(83380400001)(6512007)(6916009)(316002)(107886003)(2616005)(36756003)(41300700001)(5660300002)(86362001)(4744005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oe3Do0bk/dt1huCJTWjchw3JC5jwCZFiuFSRW3tQZsgZmfA7qglkaIHp8VNM?=
 =?us-ascii?Q?BzyOeGlSbykPi5AsR9bBTPrHkLtT9lT6aE6j/95YIybchVSrxLIVsVuHutY1?=
 =?us-ascii?Q?5n7SOLaw3UdYgmlqOvRvFPRMSyFl8rOJGgv95PPuDfJUuGC3647cn35+vciJ?=
 =?us-ascii?Q?vLhv7g3Qms7h42mHv4xm7l+pBYZhMZbrH5PDPm6noVZp5ohqMzwFdeulfbxn?=
 =?us-ascii?Q?ia8G/z0Cuf4OKpScwc4/tRXAKp3oABXl6jVG89mlgSewI7GCbT0pRI/gpN+q?=
 =?us-ascii?Q?XIYiqZV9Lwgxv7VBvofQTk563TV3A3tOc6vEMb2JjnMACmkx2GSYmafNe/h5?=
 =?us-ascii?Q?/otO6TuanF316xNXCJ1g56GvbdSLGRQxVA288QpwVFATTePf+eqmgoyRZTAg?=
 =?us-ascii?Q?Uj/l3levss4Qm+UhvJq2k9yPb6+3eKDa2ydgHwri15HRICPLOkPTPJvAtdHc?=
 =?us-ascii?Q?jOS7Hy9cAa9jG7zYxnJmSu3U3M8/eibnd375fTBLaJlS3s39geNf/Mx6tTOQ?=
 =?us-ascii?Q?5CiTXAjCE3SVOdTQ7GCWBV1j1zxEKKoR6HPo+mlkYSOZ1uFOLg4nM0bOOsBZ?=
 =?us-ascii?Q?xt/1gqxDE9SyS8vw9KxHAGgaUamWQHsy+9qD6Lckk4P61ZPmL2j0A6kQabqd?=
 =?us-ascii?Q?nvh0KxRC3XsZ1o8U0Yk8bKdjSoV9TBBLG3gkx0oAI5OQckV1bSO0iqd36lcv?=
 =?us-ascii?Q?J8UhOXw5BZtf4z+Aum7xs59ooQdKodC7utS7Otxu8NIeqpa54fvwfiD8sq7N?=
 =?us-ascii?Q?Z/Ev1UNXooUqf8pKiby1BvVn5W390NCGPnVWq+u6h4SXTwJDf7hXcuof21mT?=
 =?us-ascii?Q?WLXGmxGBiX0KFQR7ss1aKb9WKuYkx5S+UUloB6+xeI6AXRao5moJAF1jHWmt?=
 =?us-ascii?Q?F6pbjzWFsx4V+jrN1N2DdknbiY0z0pG0ku+SbhjwmFYpCS1nLpt9XKqbn8Lc?=
 =?us-ascii?Q?YoXmCzuT3lHqEw3RdlSxa6c1JoXpB0k0dmkhYg0OJAbQvivz18SGptAGJY0Z?=
 =?us-ascii?Q?GepmELnuA77eEDdY0wNdotTvIXhwSrruIGWPvdnDpa9Zc3VKGkx5dkIlO8IM?=
 =?us-ascii?Q?AFylLv7sG3EQJa+/qWPeUxWMRd4qRd2ztIzHqkwXiu5NvTJabyxsblbzps4d?=
 =?us-ascii?Q?0CcsejEZhJvDQBw7MNxcZnnPURC3pKwUqsd2VfHksYHd4kefQzx2H9FAFQ3w?=
 =?us-ascii?Q?ZMWqs8LknFyQdxi4IXIOT5ZjTpCNJvk4IH+ALCSa1JzSByi+VpcX/iTiG7fU?=
 =?us-ascii?Q?1Fkr6auWFxvarbzkij5zXXDVGoueqYRS4K0dzPS7Ro2NUBofVD1Q0dCqE9zS?=
 =?us-ascii?Q?fW8wb/v3Bl2Pt2EdNEf7jbb/P9kfb9nAVsjZzio8T3WhiCqdgtmIlsWbNsVY?=
 =?us-ascii?Q?/yhn2fKIDxJ3IKdv1yz3y5gILJS3g6ttq84uV8/UTAD7jqfZy+0RyNefkxe6?=
 =?us-ascii?Q?HA73idhoCv0gOSn4WGTvllATset2vxXQ/z1bIL+hxiOXQ6lSOvVQXUFFpeCJ?=
 =?us-ascii?Q?O8I7PSFsENNcd3JtztUveOEgfZQhk56+7KVf9VAbqZBU/oZpkOtCos2LGnoD?=
 =?us-ascii?Q?bX+IsZOFIOK7TcjXiCiixN5Pj+m6P7NOBnRCsTi+?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 898d0058-7f04-492b-72f8-08dbe3f3593f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 02:50:51.7811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XKXJNH9XxEiIdWN7zStD/ta/AOQpA1vrmGNP7AZfLX7Zd6Cr4824MMZr8HOhl7GEKwNeoih/VoCOUlKIFhnvRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8895

In some cases, the address entry doesn't need to be freed. This patch dups
an entry into the free_list to separate removing an address from freeing
an entry, so that the refcount of address entry can be added later.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 994f2bfd74be..e2f11e821214 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -303,10 +303,18 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
-	list_move(&match->list, &free_list);
+	entry = kmemdup(match, sizeof(*match), GFP_ATOMIC);
+	if (!entry) {
+		err = -ENOMEM;
+		goto out;
+	}
+	list_add(&entry->list, &free_list);
 
 	mptcp_pm_remove_addrs(msk, &free_list);
 
+	list_del_rcu(&match->list);
+	kfree(match);
+
 	release_sock(sk);
 
 	list_for_each_entry_safe(match, entry, &free_list, list) {
-- 
2.35.3

