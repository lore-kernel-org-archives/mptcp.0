Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2077.outbound.protection.outlook.com [40.107.22.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4608C182DA
	for <mptcp@lists.linux.dev>; Sat, 18 Nov 2023 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="m/M7v8q0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyEEyG+bB97ym5er9j4zWzUDSCgKqYnktOb4Ufdob7K2AdqZsxlccvmsiE/ZSHnzO7xRtHRrE5z30B2tYnZHUruKGyWkfHrpHnl2R8c1AA0aQTjVBg2UD/y873EhOk1747xAPj/KH80zRg2HrNw93nbnC4EM0A0VMYKosI3ZcKTPDn/IAz7xKpTbmyGpkCNvFs7tMFExsdZ1j9DZRSo0PQJ9RJdcq5poEjKgDUK4cvCPm7qpXwDDaKl+7fapgbTCgxYx+r57dlJB8232lWAdqoyTxh2n/AqJ1emJ400axvqHGN5OvG5q1bY8Bu9a555Y/efoQbAqH2OlyAFPzOKg4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pRRG/uzx20UZku1L2KN/kSoExoO4ddINXf4XvewjAA=;
 b=h9sVUbc7egGzqcshYbyrknBPDfqTjWQeiHqYkYW2k1OTjaul/Qf7+ZuZ2EStt1HG4VOCsEpENxGaRW9kjucLnGpUSLFPOaVAAMcemmErSa7D4zjMkx1Qhk88iHTl7/yaPrerrYcUXdUiNMkDFRn95eEZ0cQS9yY7T1pzkAfTKsu9lXS9LyGkAwWbPjvC+u9Qk9dMaGOCkZMPvqOPZYFZOKxLBsDNv1cogNvIxFNeVLE8oJHQHNRXCB9R/a1idrRr0ASqtqjmBoPQmii48tS8tCRpK72NeJzUtF4GS9QnzIKS5D4h5vfCv8v5DLE1Odod5bsBfOKbbKLH19YGXBBgHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pRRG/uzx20UZku1L2KN/kSoExoO4ddINXf4XvewjAA=;
 b=m/M7v8q0Oa9NF+casVHV5JkZs7aEdW31P+8KF8cl6fk50g3esgUM68HDYbh+HO63/l9JueV0TyPVTJhoV0tcxOo/WQG29XPhVccNbmtiu9qHCkzdDh2F5amjzK5UK+qP+gOtgbSZgu77xojDfAFnV8GFuk5VOKQ64aSfTk6S2lzOQpERrGItxPTXuKTuSaPzACNAb+Q+Wg/iZIa6tYeisnsV5uqNgy06ngsHlsaXPHRiGr0bMdkydO6ENxfVc0BhGxA3IZusqeS4JRGmT5pJIphGSIQzQkHJyLIr+gmuT3Y8pxCOx+/UKqORsCGzk5hG5rGt+ziF+vaVjAfyHtKmhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9104.eurprd04.prod.outlook.com (2603:10a6:150:23::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.13; Sat, 18 Nov
 2023 14:32:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Sat, 18 Nov 2023
 14:32:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 25/27] mptcp: dup an entry when removing it
Date: Sat, 18 Nov 2023 22:28:40 +0800
Message-Id: <7a4bfaa988b15f4552c26a249adde55ce56b523a.1700312872.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700312872.git.geliang.tang@suse.com>
References: <cover.1700312872.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0182.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: 2698c7b0-d21d-4233-e940-08dbe84320d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LODL31hlX+KVsZU0zd3W5d9NPNpBnkm2j22FjRTGuLPL8WgMO/LKlJ8xyiejzy15aMi3bM5BbqwXPyOfmQVUnubCaeo05wO2yvoK5httTKdnrPqB/krtNW2npfW1yZvWDJhhYOqOjnVo6B/l0KpFUCSIYTnsKJeh/Oa0CPeTG/tGY7m+5wPhSKa6UQ6S0CoZYAnlSSPHKfbChS5tUxpoFaOzVI3Vo2Bf2X/kL0lVPGTehVklWf54w6Lb/AOequtANC0+Orbs2lJfzwelEVZhRQRZiq2hgjp9MX/QTTafznmADCiOuH/rX1AurWjFWifRpp3t1RmxdqTyBxEPhwdhyC2E6yiL7oS08zE83MBhfe+DlfvYNuKqnCTXeqRI4PcOR7115fXeRcJLuaX6UB5jmYcDNI8UHqhoh3Ef6vR2dKu+6fEjjM9ZsfYYZxhoy0Ca0cv3u6J1XoQZG0qO67U6lHN+ezX34HkLHSn62RXrcj0xeMYCjgiBYyyJaQ7QLL/2trEkfWAJhVx2ihrhhaDs7yJFt24nvjJjinQIPCaTfoiR8MyWAAtqBnpznLcTam0f7CwAyUT0igKdxy0UP5E97a9RDeSSewLWhNsv9+xM/hA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(4744005)(66556008)(66946007)(6916009)(316002)(4326008)(66476007)(8936002)(8676002)(6666004)(478600001)(6486002)(41300700001)(36756003)(5660300002)(86362001)(44832011)(2906002)(38100700002)(2616005)(107886003)(26005)(6506007)(6512007)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5gql+U+KW2oTYvF70EP7UNrJpzK2p6OExWCCD3EkXD9Ek03M36NCnG1Wqv2w?=
 =?us-ascii?Q?tbrLMYuvJ6dFHpO6pGaTqbwEktCooMXzq31wT2TVDQzdorTTTgRmmxOoYJXE?=
 =?us-ascii?Q?ahq1JheZXC2KgEWuR6QDc6juspz9db9m1gatrfpo65OAw550UOuCFVMp9kx7?=
 =?us-ascii?Q?uATA0j/QFL1xgkNMC93wneRDkRXTSzD1JFzJwKdtETM/Rx+LeZkDFbBG+hX3?=
 =?us-ascii?Q?0ZMpzoWM0a+wHnLSYorXaG1TwN8XosBoXfXX8hdE/rUjJm4qE6orzrBjdBBK?=
 =?us-ascii?Q?NOlBmHihPwZFmQ5MjTHRzpp5abyWpREusXvCYXRBqkDsk90Temaybb4EteCp?=
 =?us-ascii?Q?/gRExodHWX2Jen+IULH93R86+7oAc65VzExoiHeBU2GEr8IlMtS6FmMk2ZHP?=
 =?us-ascii?Q?HSYySiH3dhpoAqWWmUZyBFDJkwAvhGQzRbfn5nXCagG0YL/XkDK1jkAsiCV+?=
 =?us-ascii?Q?3RRZKPSBgdNfsZF5JVdZCf+hhqUYKkv3TqAMVLVeCL1+nbFKWKhozDXlMvVQ?=
 =?us-ascii?Q?KoiCbmW6Rprha6EIZB+SR9AjjXb3FAsHXI0VUvUz4aRdji9/G+RSDi5wCn6g?=
 =?us-ascii?Q?kOVS2bbrY3SIqlX5u0mGn23Um4QbcHUZlBHYUsLpQ2lul1Xsbv7REH6Q2NBK?=
 =?us-ascii?Q?DpvEIh+m1k8YvGIC3Qhrbnb6KyryvI2SbigR7Ndr1l6xQXNeI+zgqS38isxb?=
 =?us-ascii?Q?wmwIngLc0W4NNwHf9G3/2z30UM6iMNXguS39ZxQcOgh7JLBQ3918YoxcV7Ik?=
 =?us-ascii?Q?K6A2Dli8rpx5k0ej+1874bo7vMg1bZT2VwQm7HORF/B7EYdkqxnxOCpUyOJk?=
 =?us-ascii?Q?2o9ohxr3ZvjOMxnmoL0UqPmuz3Gml5DIg/5IJzv7gNeWaOzhq0dCaZ2VMaFT?=
 =?us-ascii?Q?UCykmIk9GqPmCkcdv4BcwgQpctp7IEchpHJtPLBZy7HtypKRrFwE/dHYWIsc?=
 =?us-ascii?Q?JiedNX21nDh+MQrFkc2b6WEXQo/gtcWrGt1/sTZ6Hvp3qhCcwVLGg2D8GpFM?=
 =?us-ascii?Q?wna5ajT701NI967NNPXCwD0gNiVwvNEPlnhOsFLu4yu/jXkcA/5byjx4o1JO?=
 =?us-ascii?Q?5//DNU2yP9uME4FGEsMujTmrN7bTkC/9JQxDPuBC7qae5x0BzFcVuG9Qc8eZ?=
 =?us-ascii?Q?DcNLLAdhds/OpuFbCWo5gpDf6QfonZX5JwqgwdzKhkeW9xBNDTYoaZXeY/6q?=
 =?us-ascii?Q?3tKkmK141K5N9DzCb9u7Bf4BMwV6cdeCDhFtLPuUpF225immsk8slVJ445JY?=
 =?us-ascii?Q?yPqw00H4oQDOoAIxgO2scaDl4sEdzrSoppEBCisINJDq9X4H8V9q5g8ItPPa?=
 =?us-ascii?Q?Fhv9tk+ish7VX2bevrVB3iVUbdejEQ9PsbXUfnNs/5CasfnWmWZafjl2Fu8Z?=
 =?us-ascii?Q?RC4/SmqlFRV4XNnQzylsop6fk0bFBeZz91B2M0T1aX1TkNNdfuXZ2iG6S3HW?=
 =?us-ascii?Q?hWlzyN5GRDOY3RocPYpL+V24wDmqqSB780sEBLzjIt6wZCY84kO5uSOdBmIJ?=
 =?us-ascii?Q?/X2uVMZ83vch8ojFvkHky309z2tyOwm1o+lqTHDmB2cDJAGwwdcBdBsuPYlz?=
 =?us-ascii?Q?GKrrpBY/kVsO78dDZEiVn1eXX0rWDzmf4zHMZbz7o4ZTT3s5HymcynCLO1L/?=
 =?us-ascii?Q?pg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2698c7b0-d21d-4233-e940-08dbe84320d4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 14:32:01.6852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8cW2apu2UseJqcEzk9WUXQWunJTDbzEmpMQbVUV4YIFnTv6xiR1tSqsSLMlI4OzQLTZKaabUg2zUhymzpfdgKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9104

In some cases, the address entry doesn't need to be freed. This patch dups
an entry into the free_list to separate removing an address from freeing
an entry, so that the refcount of address entry can be added later.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index af9bd7950fa9..8879792ffa7a 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -311,10 +311,18 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
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

