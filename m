Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54B8125A0
	for <mptcp@lists.linux.dev>; Mon, 25 Sep 2023 08:43:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9owgREkPL8viotLGLokifSivs6dvsh9xwavpvtOO9E/jlgHqqfXweNcNvp6jcIjb2j7EC4qPxo1fQZvnt48rdQORwivU9hu9y4fP7NGF76NUsMj0/1y0+YmW7w5Ar1hycmOTULZ3Xg3LihQ63wwrHC0ECwLI6r9ClXEm4nkKuvPOxqXMWpV6VG4sixuvDUYhYvPB60a6D7SGwrqp1y0U1kKS6c/KOp7JyJ0a4F3jWe7tTqbi/sXqio07iC2gbQoqgjkVJj1T2/C7pESjjospqWIn+nTGUW+SMTRcItOdgKHYgsIZpZwsofsHUeT765I/NbM6RdF5naLdK43hguxxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zl+6MeeyS89BDRn7Z2wrcLqCo6kMdFpoxsWT9/2stog=;
 b=YMrZNDkWOcY6Yxvm1rAkD6Or0/qvis//Lmr2/yMCcB91gfnwA9zykXdbOoLL6XhY/DsFUJ5QiONlnUKsnpKwrt/nH+hG7YtaMazhM96OuBtS9j+16kQCmjQ9NkIpHmoRUJJdGgDZgrfkz+pSuTqChiyFMJ6ASfTPoySHyOy/Nssb3eUCVsxbGOja+Dh61LEwfXJIeVavK3xgtHPf79BxYBdyVn0CZSzSm2p48kZ/AQJSqbvMM7jjCGeaHHyLdLmHgrFd6+YNG0WgQMY5VeC3IXBQgxh3AItxsDsJPZOefETRlPcL9lRxPnl4IZJr+VkdYP8+HwWDNYKRn72SbuKDVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zl+6MeeyS89BDRn7Z2wrcLqCo6kMdFpoxsWT9/2stog=;
 b=tZhwiTp2sEdYaRnAc+nrEvqLEhglJuL8fQ9H/pH9CQ/YqqiG6hpb1uC4cX9tY3owvS6kwsYCEzKbmD9C5ZdZh+eG6IRWi74zXcZvqXNwZp/vLujTQ2OESBRRyD2Wi2STTFvFb+mKepkm2rbbZ+lNNYyQc1NxxTKyRpFufuJ1PR0ixInJRIEQrICZhBKyCwJ8jl46gLw4ECC4klJxXHXJJFkHqBQY0U5T4GuBVcUU7JZMmbKs2/7hxaH+TJptWzR5ARyf8yf1MQvb7VZVsgrY5PGAjcTetpI9NsW2HixPR87R8LEip8NxCiOSN/UtGPt0bci5N4fTdW16v3TvJtOnGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:43:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:43:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 15/29] mptcp: userspace pm remove id 0 address
Date: Mon, 25 Sep 2023 16:41:54 +0800
Message-Id: <1119bff10cfc3c6b3fe4afc410f7803f27f49f1b.1695631132.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695631132.git.geliang.tang@suse.com>
References: <cover.1695631132.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::30)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 76f9896d-4c22-4693-f4b3-08dbbda372ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rdwyp0D6qAcf5LjTqB1ArpDDwXhaeR4kIfJJ6zcXaZxE1cWTY0PRptr5T8BDAnXQwgXs9iQWeRmmt7wRqyVl4EEd4ABluYImCeEEod4+TvrTqkqe2D3AYl6MvAdMX8fQ/BNtYwBMmyYhkeRxBNC0rpsirSG5MhDmL/RDKKNOj4X0k01I14AknvrCr/HG05nbOn7zAFLqywyiRMTS83T0dBs60XKM5FjhwkEKoaFLZDlNsdZ7Xi1Jh1uYBzaCwfn4yrXEOUtEPRhbyBuXkPbWE3uzddKbmKMcopBIDrMTauu+Ig+DdC/f4Z8UvMFt42xFqZsa+Bf98yF9gxmKrudYx98qIFXrhRqtKUZ9xBriWaPbDll/5s8K22REKHHFexGtHEtAE/utXF6bxoQx4hx9oHvjJSz3zu8dRaANo8PxSLXtvx/sNNQ7MkWzhKtfNkfhnvh3MgSV8P5xtZQ9C6maHLDG0rPOt7k/8J6pUK+FkbLEL+lIfw7LdZNzXTbjfEw90ZcuksdjBMt5qpQU4X2lAuY3Qgk5YGALc+t9qz5uS7U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(1800799009)(186009)(451199024)(6512007)(6486002)(6666004)(6506007)(83380400001)(86362001)(38100700002)(36756003)(107886003)(2616005)(26005)(44832011)(2906002)(8936002)(8676002)(4326008)(41300700001)(66556008)(66946007)(6916009)(316002)(66476007)(5660300002)(478600001)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CSmkzFI+NMo4yymStnk6kX1tpVBPu9RZ+1ewNfDjXIHuQPf04hmGfuETkRP3?=
 =?us-ascii?Q?5Q87KpLFuQhknQwyFqccxIDlWpQYWxTyKmswtDGExX7VJXmde1RJoJXn10Ju?=
 =?us-ascii?Q?QmeCWp3dlo05coyJSQOTBLVOblTF2T+CWboNk+gNKaDV+d3OWXFq4sw4vqZ3?=
 =?us-ascii?Q?D/gRwtDBJTWC7nFDI1ef8/LazpN1X9VXnPcn0z6WtJcgqQW23ZWeaIB9QJDX?=
 =?us-ascii?Q?JokFmtyfM2Xtb3hAxCCqg4HrZRvLNf2wnKAFi7JXMwBwf4tWc7FzBlEoxJcK?=
 =?us-ascii?Q?sw6wvwTZaBZol7TdXhgcCIZ3fz4rs00ETFh4CnjsPZz8MeL9Q791oOrNUm2Z?=
 =?us-ascii?Q?WkTVhnHe1wApLW4A4msKaZGFPaeVMFFJA7d+KDLO6V6RZKfIn7oCBOptkbS3?=
 =?us-ascii?Q?S8bgo4X/HRQtXG35g0d7ydFrQbKVS4apUXsQ/rCJpPKmtsDrXkdpd4eh5+h5?=
 =?us-ascii?Q?M2qT1bdqmAM6RqkLIgdJJLk2hycrbAHptJVmqIegVauRq8PjhbeyV3psjzcj?=
 =?us-ascii?Q?jcIXXGAHu3OBIzFj0Y5MiWpE730T43M0jpOUFky82WCqXUHjqt9qy0NUD6m7?=
 =?us-ascii?Q?BeKiGnz+uGHf6OywuUP1Z9puoCGWaoy44HOZY7ym5xl93N14mJsAzd6TFxf6?=
 =?us-ascii?Q?StQEAFJ0+sBjaiiE2cJHjBP9U6gQAwcps6TDIJKIiY45/wPdhAVV/9baB7SI?=
 =?us-ascii?Q?NcpXoFEjQDDqvszHsqVyOsNZom4sE1IULp1ZzT41dTC79Rza4mv0H/JkN7vX?=
 =?us-ascii?Q?T55ONkt8t8u046yxAg8SITtjkaGud4PbiZYEp+FcdvG2+PJV4mU7CgaqOfhi?=
 =?us-ascii?Q?mlI/F1EGFHX37EBYxz/NapjkCCM8YyUiAbbPiTfn3H7a736PLw56Y1qNeJg8?=
 =?us-ascii?Q?43TKyNuTNXtllUSelX6y6rUhmzKNRcrO1jp7J8uMkSqYIHva7BvLh5aM8y1F?=
 =?us-ascii?Q?AhfMuFhCYYoibLF9MfJsFVvVaYOb8E9Qif8UJTaJDv/Ei6ll5+D7aEeDE1e7?=
 =?us-ascii?Q?JNgSRXWfFVRJGofksRC0RwsE2piskhd2jz4os7Q+ARSEcNjMWZyYnArqti+w?=
 =?us-ascii?Q?tW3PbtmD1z+ILNIlqs81dgCpCDIoEANyGMcqQ6Ww3Jk6mOpbnpTwiJjYKbvu?=
 =?us-ascii?Q?K5yX+XrJCKoLxR+iVeNvs6XI0kFVwcE0fau17XY7E4cpHL46trb6Fm1KZgoQ?=
 =?us-ascii?Q?MmqSIQPEtLNPrUXka5NEgDVNjhVK2AHlyA5lITvB9OyEPNu39o+a/ZpD06PK?=
 =?us-ascii?Q?VAPRBffCeOXGutF9u7SHuLNrRaTDLfCc1F2GaOVI8ngdhRENMEi7qgM6lKTW?=
 =?us-ascii?Q?O1isuFy05WCfGj9Kq0YCVlYX0dJvU7MYZ3Bj2q2ULwy16/ctkewglUPDdyau?=
 =?us-ascii?Q?WonYx6mvGhANTtrC3kXfneTfcxV/J4T1BOfWqmVi6oK+pxMsyrMM+e3wczbX?=
 =?us-ascii?Q?yYRGiAzZgfnwABZjRgsXFtD282C/m4XhQKL5083eFNN8KLjunXkmaUAEkBTS?=
 =?us-ascii?Q?fSo9tfWt7NboADpPPl26knMlMIziFN9NBed3LxLY9DweD4YYrAZAZeW8JhxI?=
 =?us-ascii?Q?td/1K635DLP8//9damls1TZ/M2HSO/eG/kbYa/y6?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f9896d-4c22-4693-f4b3-08dbbda372ea
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:43:11.1417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvfaD9/j/mm+9RVrHS11hH7MSV16wuDBt37/8TYoXQCxBkQ4KYp673Yh9RE4KxxhIz9uQpOHH+Gl12vuaCmvTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8510

This patch adds the ability to send RM_ADDR for local ID 0. Check
whether id 0 address is removed, if not, put id 0 into a removing
list, pass it to mptcp_pm_remove_addr() to remove id 0 address.

There is no reason not to allow the userspace to remove the initial
address (ID 0). This special case was not taken into account not
letting the userspace to delete all addresses as announced.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 6b8083650bc1..8d97cf475cac 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -211,6 +211,38 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+static int mptcp_userspace_remove_id_zero_address(struct mptcp_sock *msk,
+						  struct genl_info *info)
+{
+	struct mptcp_rm_list list = { .nr = 0 };
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	bool has_id_0 = false;
+	int err = -EINVAL;
+
+	lock_sock(sk);
+	spin_lock_bh(&msk->pm.lock);
+	mptcp_for_each_subflow(msk, subflow) {
+		if (subflow->remote_id == 0) {
+			has_id_0 = true;
+			break;
+		}
+	}
+	if (!has_id_0) {
+		GENL_SET_ERR_MSG(info, "address with id 0 not found");
+		goto out;
+	}
+
+	list.ids[list.nr++] = 0;
+	mptcp_pm_remove_addr(msk, &list);
+	err = 0;
+out:
+	spin_unlock_bh(&msk->pm.lock);
+	release_sock(sk);
+	sock_put(sk);
+	return err;
+}
+
 int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
@@ -245,6 +277,9 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 		goto remove_err;
 	}
 
+	if (id_val == 0)
+		return mptcp_userspace_remove_id_zero_address(msk, info);
+
 	lock_sock(sk);
 
 	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-- 
2.35.3

