Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2042.outbound.protection.outlook.com [40.107.104.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9543F323C
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 06:46:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l71hYcqYU1AT9ca6y5WgRTowrHxbtdDcleGS/kMBAcuZaRERn+EQv1iMQi99X7Htbn3fJc4GCtR9T6+0rxIdYpDGqQ+XDTdkUqkjhGmQoCBKnEh3dvYuYG9/YWScQLvoAGC/qMBPE480+0kIMQz5cJDAcRZdaQRjHhBzd8VMjG15jwKq10Qb3Y3JYCFDtaJbBmrQ5cxaIHXlmTOTblxXWkVJyqRZN9wc4ZcpcEGq8v9/rk6P5ksXX1CqRtnc90nG8NdVeirxOsqjDmQeADrrR7dXHXKLd0MKvtSdWh7lX/DEk2vvSbe/7t9qIlb37pj2MYOtX8Mw9iwEUHzyTUeWyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOdtZ9QebhlDZIVE+PT5jTWX/aFUl8H0HePZ3IqmN6A=;
 b=eZkGVeJWIjWsHViK4+saIU//uEYhRS0qsb5P+vV5Vhzi/Q6MeLtsxPeqVVBD2v2Q08q3Nq65i1B2+/Y3RTlS4uIJ9WqQfKjbO9FFrtBIW1KgkbMJvE/WBohXL7XhADrY930FARiO7hsd5sjk0KbYFqPDEjcSl39J201tZf1nTFdyIFyqlvk7ybo+VCeOHB4VqazhvPPqE8wqpqrrYR3bF11M/NQlOwa24yW7Gtbf2wRTF+XGm91UjG+xd5ypOZzFWlPinEprG6fgiB8as1AjpiQZJ1bNqKdJirL11kPaan5zsVaVBrj6YF/nVLaOKAmnPz+am7bBUFR214yNc1bXjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOdtZ9QebhlDZIVE+PT5jTWX/aFUl8H0HePZ3IqmN6A=;
 b=TlSmLOgcjE9Y0Y+48v3D7SHDbUN/d4i54ZGq+IeuTYwdlbQY6PPoW2dPJeM38PCjvCyJdmx+fLmJBId/9KsRvormgyPNc5OTDNWlh79gUUnsPPZ3jMPm4Nr1h+necotEnkkkqL21W9YRQqLVcBYjm6ElLzs9Ezu7V84yqhhI9FqWXbmUTsJhhrlNzCXb/Ae5x+rW1aTLJxVCIreLwnbNtVbK74SJIQvQG2OV4HWClKPXgeO+foJUau8Tmf9qK/cRZkLWmBscJtfnhIHJ3LmM2JIt1WRPTavICbs9EyLB9sP71ztjNoDS/5Nv6GUWZmFcCe8qGOUqVdMhW1jxhbwt2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7894.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 8 Nov
 2022 06:46:24 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 06:46:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 13/15] mptcp: delay updating already_sent
Date: Tue,  8 Nov 2022 14:45:12 +0800
Message-Id: <de623a58d19ee2bbad8533133033f5b356e42c89.1667889809.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1667889809.git.geliang.tang@suse.com>
References: <cover.1667889809.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::14)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: 887c6798-cf74-4796-fd36-08dac154f3ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	drPlDUEMfNFI4SnhSJ6iiBCDxtcyNqt7A5iPQis+5ZKnA+AxSo2cheqpytjjEBH5zR7UGxNaK4kr1Uv85RA098EvI7awE1uNdeZyMhI6HggIHlMbZSud3qFLme7ReLodt1Sk9rZbtU+VujxpIrETjBcpOQmev8DCozRc61KNYVHzBrtLZ0Zj5LnygmjWWdxPN8JNo6YAKxDHl+vlztGo147/CFityvmROrE3Me8jNhWuPUQAA3ZtYG4rnqPmgBlquQCd56/oVaKhgVnqFeax6Vksq3dsPWwmD+rfLiF2d5Rl38EdI9NqG+dm2NwUlXtY1bJ6Svom+Zhf35nBm+1MoletUdf/SfNOKfEUCQGn4P2lTHIbBI7TTxdfrn6CY5RJ9ISALCie7A7lwHb73OgiT9igx2FTvalhaFCxsune4Sgz4tP0Tpob+lQrSUIgqVp/XUqKYtMsOobQgKFkoEbw7Bf4Ig/HX6UY+HzTLLwDRaoP+ekEH7W0Fj5nGLElC2JQBosRevMjKIUFKXlhFsou2o89YhwBi/YWAJbdln49PFNMw/nBhR9X9Dx0ltKWXbhQ0d3eDTqcZA2HEHI6J7MprFJKdjPlV4jJCMaF52Is6Lv8p16tDvSN+xi9j+QRpOjQkbpPUxdQzywbVgkhghya0KCoZxWhX6zgDFXZwl09VLsFdaLzLVzbQSfxeglrWyYa4e0ePBGOE5Fk4eDS5NX4YPBjpC4F2gqwQziUNM8XUCo86yikjz/ekBeOK4tLinQ9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199015)(44832011)(41300700001)(2906002)(5660300002)(8936002)(86362001)(4326008)(186003)(38100700002)(2616005)(83380400001)(8676002)(6916009)(316002)(66476007)(66556008)(66946007)(6506007)(6512007)(478600001)(6486002)(107886003)(6666004)(36756003)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XZAl+mJcr13WeonJv2T//Mvlqn+ShOKLAIOkYseITSJnyEpoDd1yn2Y85XBH?=
 =?us-ascii?Q?mDgIIqgvzqXGIoDU1Vn9gknum7Km97vEFktJNjy9Na1AuYz0kowsQ0Tqy3lY?=
 =?us-ascii?Q?K3QG4bjJO6oL9oD0v04sF+YXOyJW3aMnVmTCzyzi0vIGRo3VB7ZWIxk5ULjy?=
 =?us-ascii?Q?nZON/1RWQce0LOYIjg19CyJzJMcpZKf8Zs4IvdXWto+Oz+cRltr3BlBSTgRh?=
 =?us-ascii?Q?OJ6cB569c8AxuJyC6zeTpYOgKkJS6k/A7kWK855gkiahrL5gCOGdtfxgP8OB?=
 =?us-ascii?Q?8Mo/hX6+rgWC3WNBaJEkUmZLv3vuU7t9QT0Z3aKTqSq+n1TmnRz2VCPka3tf?=
 =?us-ascii?Q?sVu0CaZdk6vsTsyVrtkqitq82KKgHdOsP1QnwUwmHkRf8Trmetmkn6nFG1X9?=
 =?us-ascii?Q?hvfBArwNZlwuBLy8RhVU0yoDd9OGMS75L759WJoTh8GfLN/e5ByAbDn7HPuo?=
 =?us-ascii?Q?6OrgmHsuwmCe0RclZZkpkt18cAIXi1cciK2I8KKeI+CEpg4/HJz6wdthR+8Q?=
 =?us-ascii?Q?tGdQLCkVBJpGOHpFbD+Bw3cjoEdumKB8ZqkYpKCFPffSZuuA3HCY9jm+jSUh?=
 =?us-ascii?Q?mKinkWLT4bkKwhoTxYxRceCqkyKLG0dAtidDpVqe6b/IDaXapbCvFqj9MDVP?=
 =?us-ascii?Q?Y8cZqpJMVvi5Plttal0pf4erkstnSnrNc9Ge9lZ67FevkRZZ6YAZvkiPS7cM?=
 =?us-ascii?Q?MLg4AqqDZHY4wJTiSzWm1/2c6UcXfdTEdMA/nqETEZJH1s87FtS/BVqPc2bY?=
 =?us-ascii?Q?bA7rEE2IknyXcxN3O3r49N6K0K/eCgXTuanQYtmpnIXKehIV/7YMpTxEVofu?=
 =?us-ascii?Q?qu7682pVl8ebTpQsQQrSkEryW8WTmXyo3fZ0K2/rbRdAeyXe415M5PA2B3ob?=
 =?us-ascii?Q?NtSirffMinzwq4kbqoMEkPky+DN/B7I0I87C/ZX7rLvd9C5ZLmGQ4Maiil6z?=
 =?us-ascii?Q?q8PNHRFhlBHqRQFYVgM7YD1ENjXIO1qbk7s4qRZTBaG76F6gKFE/TBDDva/V?=
 =?us-ascii?Q?mW0aV5M8M3W+FMTQe9LOdnUm6j0B2Ik+d4INt0DuSOZKk4UEd3hT8ic19MKW?=
 =?us-ascii?Q?kjO5Daynw0vJAoyXQmbA+nScy+MfWEVjaGNu0RfCulDb7hIVjnjeXUeanbsH?=
 =?us-ascii?Q?W+33r2N7kB6+cHE1WSLoI7SiX8QoQaS6kvn9kw+S2cbyESFZxuKTfSF8uGQM?=
 =?us-ascii?Q?aG2p+F96o5/l8jlmmrHd9uCaiEddv1iuJ+llZmuD2PQfGZUT5Cm1pvCZs/Zg?=
 =?us-ascii?Q?uF3H6t7ps3+Jqp+2aKlcQ0VQPm9PqWSyrJWKNwkNzmP+rcbVk3Q5vQkBJV3J?=
 =?us-ascii?Q?KqwkL99AuHPCrfvWPJGpGRp7+zbLYAHZtg8bbd9iwZYByn1zjlA/Y7uj6Nkw?=
 =?us-ascii?Q?uSfLpndgshASfVmD9VcJX8uve3ZMUSWfyw8UO0c/Dxky1lmnhkeMg007rYr1?=
 =?us-ascii?Q?V86lQdJv7r59fSNdUPZSqDAC+3hvqCYNBNrXomC2Pqpksl+wIKr1TjWD+jPw?=
 =?us-ascii?Q?/UnqlFLMaEgyBRmJ/pdmHKs9Oc9AiscRQcYy8sFD9qmiEO90Cdv1DlSSDMzn?=
 =?us-ascii?Q?GITwCl8O3qPpCTPN2jeZoEbSGi3/Q4Owq1pnQd49?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 887c6798-cf74-4796-fd36-08dac154f3ef
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 06:46:24.1757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cS5tY3morzJtdx6cIORQn2fWRkhl0aTvv7a2ea6o87hXsKqGNWyRjhXgz6kDdBBE8WSkqgsOiIlZAABOCiJkEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7894

This patch adds a new member info_sent in struct mptcp_data_frag, save
info->sent in it, to support delay updating already_sent of dfrag until
all data are sent.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 18 ++++++++++++++++--
 net/mptcp/protocol.h |  1 +
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 26b08474351e..4ba36c7155e1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1108,6 +1108,7 @@ mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag,
 	dfrag->data_seq = msk->write_seq;
 	dfrag->overhead = offset - orig_offset + sizeof(struct mptcp_data_frag);
 	dfrag->offset = offset + sizeof(struct mptcp_data_frag);
+	dfrag->sent = 0;
 	dfrag->already_sent = 0;
 	dfrag->page = pfrag->page;
 
@@ -1493,11 +1494,11 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 {
 	u64 snd_nxt_new = dfrag->data_seq;
 
-	dfrag->already_sent += sent;
+	dfrag->sent += sent;
 
 	msk->snd_burst -= sent;
 
-	snd_nxt_new += dfrag->already_sent;
+	snd_nxt_new += dfrag->sent;
 
 	/* snd_nxt_new can be smaller than snd_nxt in case mptcp
 	 * is recovering after a failover. In that event, this re-sends
@@ -1522,6 +1523,18 @@ static void mptcp_update_first_pending(struct sock *sk, struct mptcp_sendmsg_inf
 
 static void mptcp_update_dfrags(struct sock *sk, struct mptcp_sendmsg_info *info)
 {
+	struct mptcp_data_frag *dfrag = mptcp_send_head(sk);
+
+	if (!dfrag)
+		return;
+
+	do {
+		if (dfrag->sent) {
+			dfrag->already_sent = max(dfrag->already_sent, dfrag->sent);
+			dfrag->sent = 0;
+		}
+	} while ((dfrag = mptcp_next_frag(sk, dfrag)));
+
 	mptcp_update_first_pending(sk, info);
 }
 
@@ -1548,6 +1561,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 		info->sent = dfrag->already_sent;
 		info->limit = dfrag->data_len;
 		len = dfrag->data_len - dfrag->already_sent;
+		dfrag->sent = info->sent;
 		while (len > 0) {
 			int ret = 0;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4b13ba9df34f..5d85063dd5a2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -241,6 +241,7 @@ struct mptcp_data_frag {
 	u16 data_len;
 	u16 offset;
 	u16 overhead;
+	u16 sent;
 	u16 already_sent;
 	struct page *page;
 };
-- 
2.35.3

