Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE2C622
	for <mptcp@lists.linux.dev>; Thu,  2 Jun 2022 04:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654145655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0qAbiJzoDVGXW2pY9Y9mwHd7G0XZLA2nSMbXIG9Dwck=;
	b=LdHdB2INVyJeMU+dJ6b6EpOubgkrXzbvSbZ82SvnvrwTlouH9m56BaTLBSsrOFYu0z2Hxv
	OyYamLowJvddX8ay9P2AGb+H5VOsEi2FkJQixLsFaHjEWAXa9sf0HZeYQjrSo++LSN/XuX
	pm6p+dUY7zMnoE6yjp+FqakXLhmFxUI=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2055.outbound.protection.outlook.com [104.47.5.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-EjZz_cmDPMqdZEBqH2ZWfw-1; Thu, 02 Jun 2022 06:54:14 +0200
X-MC-Unique: EjZz_cmDPMqdZEBqH2ZWfw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxQnBLWEcBFwAdvSAH1WNFdSFHEx2W5PBjrXyfaZo0+GZZBIDmNhp7knJ/Stvi7FmVmnRxSdYyZMFiQUzXYizwL4Jz+P4t8Fxv5gQo3kPTvGjPbVdiRececaOnZqPxe67U2IN758Cc/W4tDiNWo3t0Uk9eKkmjwWUd1qj38jQ739YM1hlvOZ8saOmRFKh/6P8Gi6K/nMMV+JUpzqzSsqGtVRUP9xFGcPKa5sW1QQTbuPhehsFRzYrXLkvgyUgMzxhBOtAEB9KvX14FJTSbIs8Dc1JjzoVhAJsgGjMZTTSiikTvdJlwXZJTdX/4+jeR8NmMenniEP5fkqlZXagEm6Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnG83sEL5c9IwGCfTZodBrwe2P34J8rb6VUWt+A2M8Q=;
 b=CnNX9uRuDvwV810EGyJA/VRPXKt4ENiO4wpqEpWAH9dCiGjWWUyVSfIcEXABiVStpAEFwjKUaMut2aWH/oxOWFpUuEW1jSYCKq2e86s1P/aUZaMc23d/TpGsw0j4QLtJjH5/dk0PGflULZYxBqnHU8f/TCQmZGkZ0Okk7u2aVYvV+ldHWD2vZVkdP08OiDQ8kgHcml3tO23YNqGjDh6v6slk8wQ5DUNyGfJDe54cYCkpam1hhgcU3lnY1Phh51PvkCCLoOGzf0/+Ewwd4JQ4jl4v1hhwRZjb3As6EQtQse6UupHxSPZdX3ixoMzFezDFYmpdajgHl7vMlujEXKWVlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR0402MB3384.eurprd04.prod.outlook.com (2603:10a6:209:6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 04:54:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 04:54:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 03/13] mptcp: add scheduled in mptcp_subflow_context
Date: Thu,  2 Jun 2022 12:53:40 +0800
Message-ID: <1995c630ad493fb5f0f909e68372a3c92af684f9.1654143895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654143895.git.geliang.tang@suse.com>
References: <cover.1654143895.git.geliang.tang@suse.com>
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
X-MS-Office365-Filtering-Correlation-Id: 107870f4-4ff2-406e-8f6a-08da4453eff0
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3384:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR0402MB33842DDD6BCEBBBC39A08EA8F8DE9@AM6PR0402MB3384.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aP4w5MOw5hyVqWUlIF/mfiN1JnbQWCkMEbd+xbgzYN5xIbuEJv48VrqWrG5c6kS4Ugz8lq0V1ghek3MSdzvF9q+Pz2b4SH2PhkPRwMD6yNZAznJGPJbZZINVFY800yCcdR9WPZ18WTPzRMKcWSG3hVY9XOPyAyqsw5agNXWk1XMzIZnNwq83uKSVXlOnelF3npNhTtYb1x+LvmQ22a9pQ85XE0VPO+e+HGE5782tL3BT1a/0mMawtl2LocvEcQMy9j34bw7c+JBFXVSX0v7xtkAwG1oW6EkMXXzN04mCI6dCu5v3pQ4y+jLXJvDaV3DHCaf41zNwai8nW8sNk1h2zyM6zJAH7FhA4Vy7WFjXpPKl3vYd3znChZJRYHQ4GK68uUe2ffH4riJJqcUdi+CbAxsYXrfirHwpOd7XSy/0/Tw4B2a5Krxe397XN0U/AnLh03j5E56zV+29yOF2YAWZdL+03N1497IRiLLEV8HRN0iJALd6z4tB8AroVwnrIdECEipFziQSFVtzE/lMBkqmCV4foMXZQe3HLLYLAByVSidFDgAffq/DJNJfVMEWAh6qamOWBeGu99yAwcmvR9Qpj+qKN0omJmuOTZ9LFVhhsYm60fZ0OaHJBWIGSuV6/zWOGWr8apMbdY/GLWVj+XRAu5CLjI0XreHs8Mn0I+zAIp1t7gWcF80QLjn7um739zQX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(86362001)(83380400001)(6666004)(8936002)(36756003)(186003)(4326008)(2616005)(5660300002)(2906002)(107886003)(38100700002)(26005)(316002)(66556008)(66476007)(508600001)(66946007)(8676002)(6512007)(6486002)(6916009)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?46qsTWbnbKjQIAjUahH/EhoIrQB4TALkd7m75gpSq5R6tObxc0Hc0hG9HmDO?=
 =?us-ascii?Q?eawx3wYSRNHPBSdixAGqLhVT4jP4hwxSnhD2DD4vsS8OvEz15Np/r0qfChLV?=
 =?us-ascii?Q?ziAtWlssrkWujKgEPtXuMc0noIFDyIMDVdoFmgn3y1WE/ZfmuGVO765Z4YSU?=
 =?us-ascii?Q?n1m1uY8ZflsqjLJv4kz5400S9VqA2NkhZp6/93uwYv9AIIAcweN+dkIBATgc?=
 =?us-ascii?Q?Lto2G8t1fXKXVBhRBHsG/vSVWmHgrgCNOUQg+T6eaQrybvTjlRNAEqKhtiiB?=
 =?us-ascii?Q?N4VhIfEn+ZZl2/zOGYnD+lS3gdzGMYE0h+EScakALL0RKNVUXV5+tnvvsZ4f?=
 =?us-ascii?Q?jl0c7RiIfQRaz5QLqAdZsMvoZdsbZK7OiOK7qMHT8hwKxMkoUqCDT0y7HBFm?=
 =?us-ascii?Q?z2wxqU6OYhzuZ41KxLbbKxnEzkpC8rCYDCffGBmZUEop8UHSne9f2ifT7KZ2?=
 =?us-ascii?Q?bvj6XGBf90UtYgPvTcmSz2sNMtaOj5uOnXFA1y9NuPDc7NnG5HKPW2iZLW0z?=
 =?us-ascii?Q?5NZdkY3GS69dIh6CsdoLJvb5MsUjg6n5nHHH73+VXRS5W5YKCYcowiP3Xu2g?=
 =?us-ascii?Q?02UDA4R2LumIrcoRFbwV+DeCSkbJu5H/ivx7kYxVZkLmYoBHXTlwd9dORpM0?=
 =?us-ascii?Q?g3RFZ0FjhuiYrDpuuBQEZtjVj4mflNjbx2Q26LtJPWN0JBhompNCG9xoTBIg?=
 =?us-ascii?Q?8GXKcuaeiNAfb8eOa7w2Lde54IwFJ9QCE1EFqrRotti1IuvK7caXr/44m9w6?=
 =?us-ascii?Q?3hXWSawLuMKx0zmi8PixrUAUHXrMFlNdbVLbNkO/N349/3+snBNr2zqp56Xn?=
 =?us-ascii?Q?go0dPRxApPQJjuWayz9STheh6ohr1fcx3RPEZa/O6edyvEa8c8wMoctpL15E?=
 =?us-ascii?Q?jaf9iLE4PSG9M6fqkYiQ6L5ry80CXrlg1BvU4rn9P5HvHJp2yMLMZFsX0nKf?=
 =?us-ascii?Q?bWeqJMEIJU3y/amXIAkL9CXf3YAU6IOx78EjWD4p/AoW+0n1HzKkOpYJbpS8?=
 =?us-ascii?Q?OUPOwW39My2kKVQ+GUOTObvW5O+LR/HeJPqUN4kPNwZa4tv8huXrBV7KKnnp?=
 =?us-ascii?Q?r23vude5gl9tc4fTuKE83ZZdsk0yakeYmb4qUAOIGk8ymZ3EqE4/E0rZoOHg?=
 =?us-ascii?Q?3IHquQ1w9joKC+qDAgNSiSekIxPkW9eK+/kwjJWdtJ2AGaxQtxEYdpJUu7KO?=
 =?us-ascii?Q?XBHQfYYa85PuAzf8pJ3BDLwOdjQRbyrUZ0UV1c4ZB0iv94v76H6a6+PBmCyL?=
 =?us-ascii?Q?nykPdYE3k1hmUmDZIhx1+nHuH3C4k7fao0cQuVcgi0ibDf3MECZ+STsD9j8d?=
 =?us-ascii?Q?j/7YuHfjgOPgSYgTK9L9F2Hrsb2kxD04S0ZKCRVbz1qGSmFGCHcApbW3w+4q?=
 =?us-ascii?Q?/6T1eXfFaugaBdpbEwXObgreXPnkcEmYKHjridWzMhveTAVQghCPSK6qbYxc?=
 =?us-ascii?Q?+s1/As+nmU7pIz369NYqKN0vGyNdFWG1ml/irPbHDMpsEWzXv3o59PJ7INEb?=
 =?us-ascii?Q?EOvXe9k32/8irx3BsvW7Fri5zqcnFmXufgPEttYb/MtHz9pymE5IpoS3SQP/?=
 =?us-ascii?Q?WUNbukQByy+nngfdyuL/GuLUxmV+9Smh32LFTohmPzDXt6bY5IJTiBUnajUR?=
 =?us-ascii?Q?wd9qF5NB3mUrG9YQ+HWchmMuZnwJ3vKnaaeStKqSfEOGO/a1tpgRmqYyAIKt?=
 =?us-ascii?Q?F1AY9fDrr5EkHUVHgQ0aiYojfXaGSl24hvXb6YwA7FC8BfNMgzo1NR+rTr7G?=
 =?us-ascii?Q?skIjjRAhyvmhoGNY90nvqDNnoXlPFwE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 107870f4-4ff2-406e-8f6a-08da4453eff0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 04:54:13.1559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KsKKnYerIqbN6Hiaa8sX38j2NljJoRL1GD2olSOzznEPHBznU5UIgfr1PxOfIjJo5dC3MCOR6U9H/FtQzmCGuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3384

This patch adds a new member scheduled in struct mptcp_subflow_context,
which will be set in the MPTCP scheduler context when the scheduler
picks this subflow to send data.

Add a new helper mptcp_subflow_set_scheduled() to set this flag using
WRITE_ONCE().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.h | 3 +++
 net/mptcp/sched.c    | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8739794166d8..d406b5afbee4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -469,6 +469,7 @@ struct mptcp_subflow_context {
 		valid_csum_seen : 1;        /* at least one csum validated */
 	enum mptcp_data_avail data_avail;
 	bool	mp_fail_response_expect;
+	bool	scheduled;
 	u32	remote_nonce;
 	u64	thmac;
 	u32	local_nonce;
@@ -628,6 +629,8 @@ void mptcp_unregister_scheduler(struct mptcp_sched_ops =
*sched);
 int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched);
 void mptcp_release_sched(struct mptcp_sock *msk);
+void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
+				 bool scheduled);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 struct sock *mptcp_sched_get_send(struct mptcp_sock *msk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 3ceb721e6489..5a6f289ad985 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -88,6 +88,12 @@ void mptcp_release_sched(struct mptcp_sock *msk)
 	bpf_module_put(sched, sched->owner);
 }
=20
+void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
+				 bool scheduled)
+{
+	WRITE_ONCE(subflow->scheduled, scheduled);
+}
+
 static int mptcp_sched_data_init(struct mptcp_sock *msk,
 				 struct mptcp_sched_data *data)
 {
--=20
2.34.1

