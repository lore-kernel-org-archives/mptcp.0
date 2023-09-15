Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2068.outbound.protection.outlook.com [40.107.105.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460183FEF
	for <mptcp@lists.linux.dev>; Fri, 15 Sep 2023 07:45:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEtMfBv7iR+IqefjriyfbHHLQxqbPeIJwSUS5e9NyqUk6eXYqSvrN+PCme7LyaPQTVEKpwaPkeF3yw5Nsv0wIkZCCjmBuhzfp3LBENgqD0wQ87ogcpdwTOQqRjS3/dVIcIx1YqyI4qqCDbDwnJZxUW3A3Kzj67oFp+mn7udkUnOzGZnJe5DXWkK9LjAu9Hht3CT8zVc76ojookTQ6VfqHeTtNu6+ufQK+M4l6HdAXSAiqNUed7zvEWKffOQUClXEQcaVnBlJh/YliEgBjo29xQOUvPn2hEck/15uXb1oVYj7yh+ULHxVpeQJs3gZgLNWTHUOBvXQuF5R5ASKhE+68Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4jRpiI0jVho3tp+txq+97yEpHB0GlYcB05QEGS3g5U=;
 b=T1GSfSiFzwxCt01EyIvwZRx5EaDbPSMH2/4A4GNawxhkLGxO7VqQgirG4YGWRt4d4t4Q8JdV8lwcJN3eGVlTseVttB/15FEA5paMVou/yNYpe2h3PCUpSy+CrQaFJnO4a//fAMmMtDRZ5WoKdTCVKxfuEw5VTYiL4RGV6Iscn6C2YkBcivfNkIG9gRrYdCRBcnLCDvq3a2kTvRRxpOD7fb0AI5EEkHn7DI4VHnrDVV1MIu471YKBXHKwv0aQu5kUsB3cYddzYesQj9mpguH48+Wvo9YWPoSQgM6nl1VSGjrlPErVKRHVSKWh9wly5f1qYzyvUCTKgcitAa4hfys/kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4jRpiI0jVho3tp+txq+97yEpHB0GlYcB05QEGS3g5U=;
 b=sJvk7RjD2UOJJc3eu4QFdTDBDuHm+rrwjjH+WGqdB7deyFQRczlg4AsSRu1e3zFyOc85sXEEE26moyyqWZWYIcTaR8/4f9BxBp6ouTvOvh3A6qznq4PgFDhmuELRTgyyDR5tJxp8IcU/GxDK7NHklPcE7lq1CihANmGOe7heoox6ZEFmSrJXCk8T1pdKiByhveM8DaqqxrRiUCbgyoq7o+v2Gb1wQpteYCIotJdtzUi92kwW4FY+7G2oPNzf1nLmu/Jdpc+OnXLVLZLesILkIkYh6YIBzWCINVQ+Z5FSQ+lt9GkHnVul5sqSrc7MawwppwlmjCTXoYXr+hfretELig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7524.eurprd04.prod.outlook.com (2603:10a6:20b:286::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Fri, 15 Sep
 2023 07:45:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 07:45:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 7/8] mptcp: userspace pm remove id 0 address
Date: Fri, 15 Sep 2023 15:45:17 +0800
Message-Id: <9b4409f27299b8bb82016d777ea759ff326a7393.1694763508.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694763508.git.geliang.tang@suse.com>
References: <cover.1694763508.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d133c58-e29e-4ca4-b26b-08dbb5bfbb9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P8C4G3OYmdZf4Q0QAHi2MtGHl04Y+IA0UMhNBahT3a3Q9Jy7C4wyk73EGb0hSuAnsCTP9e85is7BMyAJe8i+saJkcXvOMW5+RF21/LyHDMgfOpH1IGjM/kN7ImO5BtnwIOjDnYILI8CJSwNNx8TMyCM8eoxyf2rrqcbQB7wSeu85aaQxdwNGZoZeIeSqx3QNU4D2ZuYP533Nd6SGuav0cvkNjZta7QSywGMLD8XGWfrIU+616sdaz4zBY9B/3c/ygsfDgoSRZomKURI+nnk4iN1lYWqVWGkEedkAoiNLcgJ+6bVwdQ5PH1BAxURLb6JA8Ld1LbLVT8ibvZzg2rHR0O31OeaxeX7xidfwCZohVzj69WHynC7hTV5l9pWUHADdMUFTjhJltQ4pPtVi4ZoYJQJbpKKJq8SIOiUnRjF8GGPaN6HVSAeiZTS+aT8DF5jnugG1lCdHBfWp8t0ubbWY+ZCQMzGJ41i5ZcV8ab4g8Hu7cwNXZoxNK5J1wPnpobOLrt21fsYPuek2RY6WH6LsDjesQKTJ9okITtJyZPnCWBPDHLNejUWw+AY6xE4u0AcbC3peg2ml7n06oVVNRMXh9fU1HujnVMOSBRMZv2/vN9c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199024)(1800799009)(186009)(6512007)(6486002)(6666004)(2616005)(26005)(6506007)(38100700002)(86362001)(966005)(478600001)(107886003)(8676002)(66946007)(5660300002)(8936002)(66476007)(44832011)(4326008)(316002)(66556008)(2906002)(6916009)(36756003)(41300700001)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nw1TgG3+Pvd+BG0PbfZ5YTt6zBz6X/3HusJ5upZNawAhcYCUmADzhcQfMe1l?=
 =?us-ascii?Q?psHB/zEoTRlIGE3ExNqHuwp9fHgoLkhyyGXT/yLEgtbJb3tZtZaBaNjhi3qs?=
 =?us-ascii?Q?Ds/djgvJIw+aKjx+e3hwS+HS3QJWiOAqt0rzV74P+ylqxDlt/mHudtbOMXNO?=
 =?us-ascii?Q?WkzHu9foAOOOWMp7SSK1yxNzqQxmG8ARfkMQSmrhODfAkih/bm4fgzMth9It?=
 =?us-ascii?Q?qiebYCtdp5xC80OoAuD7nPEEIzaj4H9cbrBAar8KvO3ZyM3RLwUNqwHfpbVP?=
 =?us-ascii?Q?yXHBPsQSFM5YFMWPSiND1XvlJwRHvVfMud3Q8h0opFxKjWThN70bLkncCuBs?=
 =?us-ascii?Q?lchp8WbC45sI2scjKQkNjwBUlVARi6Qj1uTG+5LuvgEUjHE4qUAcprFo0ozE?=
 =?us-ascii?Q?gasyocC330oq0cfTwZ1gDgmWbMCHxRrdWriUVprhnBsorqLfKEHKrxWCiakh?=
 =?us-ascii?Q?VNdHxczPTYCmNbs5uDPcSFolrrKFrv2WL5aQA0tfOn6CIPka1trbcOLuEQIj?=
 =?us-ascii?Q?qB5ax2M2Jfunr5x1Zrt+6zMnr9t3/yhS0gmgiz7LpwntTMEbWyQREa3unN4E?=
 =?us-ascii?Q?yiDWaZZJEGOmQVN8BcRC+aiPWDrM0jRGFNv0VY7GIKlDES8xVx+6Q2jmhu6x?=
 =?us-ascii?Q?gVuq1GkJK2t3bSo9YKycrQKI97d7L92ednS4yRmnYGrYZqKy/xMhJNBfwU8D?=
 =?us-ascii?Q?sMSm7b2s6DVisvlomQH6y1oihdiJIZ6aEABg9G10IytE41Xz7XUtc5rVAE9G?=
 =?us-ascii?Q?mcj8I8lumiGQkCh+9ZLrCCB1qIPJsPGtqLsHwLst6lhZ6nDYUzsYbwTaWhtY?=
 =?us-ascii?Q?aWjmugn18c3Uai2/685JHDk3bBkUgqG0IbKZlTXna8rGPzingL4JhYgDIvOI?=
 =?us-ascii?Q?fyVOV8DpgLDWPAt2ASCfXHNw/XGuiJgq/w6QhC3+tlC/tQRJLaQnVC11VkyS?=
 =?us-ascii?Q?oY4KpJGsjC+0R69zyZg6NJYQPTxa4lMMpUwi6++b/8KaswDphRYeuLjLuVqy?=
 =?us-ascii?Q?OS7jxPg6VnoGbNpuyS6xIhFQFa2ikBV3vxeYWqx0twpgUL/6HInA62KEeBmc?=
 =?us-ascii?Q?L986KUBjNm1qEo6QqcH2W/uQdgmNhYQQLNfFHBVdrMOwX15lpw79y6vuwV4c?=
 =?us-ascii?Q?30ZFvZbRh3XMqEXNVHfvEwZDZT/ldrbn8At1j4uECKO0VaT8KYnmMfzlPdpx?=
 =?us-ascii?Q?zvhEPVOsT0ZljwXpFQVq6QbcTuwbUDrI58kDmA2NHpqvDsQpLHMS5cIgxREQ?=
 =?us-ascii?Q?LjjaHt8I4VnpcGI3ETmT2kSgkPNI9irY8SDTBcpXIphUmeSdq1nB8ZLh0XB4?=
 =?us-ascii?Q?3YrJHK3FBpO0x0iBF9KtPwEl0Wo6XqHvv4j1075EEk7qweKJwdRnUKwsfG8K?=
 =?us-ascii?Q?y7zloNY/80HZ+zNXRE9gqP+kJXmWaqdBa2nB1QXdDDIoTgBzmUEhOtsLbfyR?=
 =?us-ascii?Q?jzTlZO50JyrY1rOl58rhlXwUWGZK9jGdLNIhiFol5BrAlFArtec819g1zU+D?=
 =?us-ascii?Q?tL5N0Rk4tHHU++ofH0kXeHDrzfoy0CBp5XmwllWYzVj1zoO187cyEpCO53p0?=
 =?us-ascii?Q?NhnC60FAJPubiDff99eRqwA5n/uoen8vhPSUVJ5ONkVxwYEDlLhqARv2gc6I?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d133c58-e29e-4ca4-b26b-08dbb5bfbb9e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 07:45:29.7455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Rpl7cvkGGk9gNTOGMrOYFtJvk89MMSN29V6lwY4Kwq2E3lXlPNGhh3uD6//zYjeOLCGD5Pqm7sLMCtK2fEKYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7524

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
index d042d32beb4d..b0fd7440016d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -208,6 +208,38 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
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
 int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
@@ -239,6 +271,9 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 		goto remove_err;
 	}
 
+	if (id_val == 0)
+		return mptcp_userspace_remove_id_zero_address(msk, info);
+
 	lock_sock((struct sock *)msk);
 
 	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-- 
2.35.3

