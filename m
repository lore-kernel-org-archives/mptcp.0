Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F1D28E0
	for <mptcp@lists.linux.dev>; Fri, 25 Mar 2022 16:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648224762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5v62knDhEK/DGQfCMvQ+4MitGuU0hrsCwBJbqoiVi1Y=;
	b=jx/TCUIp1jLXmN4nr7AsjouvNPnFpMOcAOBdH9qiyIiLrZewdPXliwkPoH8knSo3FaRLYh
	KyjxmgPn+ljtqeqPP5oAq+1RYmYaUJjJbUj7E5ENb28XeVuhD9uqh/H0ggAbrALybIp24f
	1EJk0UhwHngLTrC+Fcxi96OH9o6bqm0=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2058.outbound.protection.outlook.com [104.47.6.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-4-akPH2JjNPcimR08zkgYP-w-1; Fri, 25 Mar 2022 17:12:41 +0100
X-MC-Unique: akPH2JjNPcimR08zkgYP-w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q88J167+suLWV6rX7C5RK0sBBWq71HC6MZLXd9pqdjlLP6UAwL0WhMQaxtltFSZYDxrctFZ1p2MCIJL1D7lkb9Jx9GnOMPsZLeuHjCXSwqDAkmaLZgDJugrUg3/VheLaPOHiHF4fhhgMKLMB+ePESiGGxIA1dWqz1/a8nknxLcurzLwMTEZ/VUB8ELVoPZSDEbwojMfpvIzoPoQ0D5F6Qk89UMO5f72Ar84NtNZrnJl3IZHsC4sQ+zGDKCj+5TG6kVkG8ngT60kCvlDCmEephHqpjGKfs/TNfIo3B+05BWhid3APbAmGpgMFMVnXH9cJhY3Aj9Vjgzvnfcd2NAP7uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BypE4TaoXPNrVsBUXrFtkOjjjVm9vH+fGsxgmkfESRg=;
 b=CQGTY7Tw8D1WOjjfVJnWH5GEXGwO6w4aiO93j6WKUn0MdqzIVszK/wGPn77qhToymkGwEAcCFaCBkWyPonoL6vh23WBcpYzqp3/qbG92Ey0FX88948sOXH3xySpyzSFqcqS/VXj51TYjlN5lvhrRdpHiZvh2dpHKzTTQoFTML3o/L76R7wMfSlGie1RjJJx0vOLm/scDPZXUaPF5agpOJkp4FivFVHFjXXO00BjAcqnElo89kAdlvyv6Dn+Fx27y4zVJUA36LIAcliB3jQoKvzh3b8ooMrHRqhr9XVcOLkLn6uEgQF7UK5KqmmtoqqpO6o8Qavh5brbLYoEeP8/E2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR0402MB3938.eurprd04.prod.outlook.com (2603:10a6:208:7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 16:12:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Fri, 25 Mar 2022
 16:12:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 2/8] mptcp: register default scheduler
Date: Sat, 26 Mar 2022 00:11:58 +0800
Message-ID: <ba211e4ff22a8761dbf0ab0c28400eba94898b60.1648223504.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648223504.git.geliang.tang@suse.com>
References: <cover.1648223504.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0120.apcprd03.prod.outlook.com
 (2603:1096:203:b0::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52062ea8-4ce7-4494-8d11-08da0e7a4947
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3938:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR0402MB393879347D2B4270E467BA9DF81A9@AM0PR0402MB3938.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PpNLptfVTeTmtF2AMbwmO2cD+ZAUBFHsv1ahm7WaFvnzuTYWxIvoY0hcatfNqVBmjw5UJ07Tb7uOl8jY6LYOwYOvc3Of3/19LRXyJQSx/KOYMs5AXO1Oe3grBt7BnOJ9Egt9l4AZ43aAdCGOHcaG+slJpJBj17NJBFe5maTy1ZNvnZIQlpuIg01zj5sAon8H0y2aNQOMlh80Qn0oGXQ7ErWe7tWlxEKJxlLJQoNvJtx4dimr+7r1W7jsNp+EpNUdd/xZg6HiKXfjoRlC//e3rPt0ANE6AH6wtmKNzUGlHxZam13n2vIT1jYN3havJGA6tb0XjSSsuXH62QfXfCmw+EZe2uQaKEuOdPEybdJiPUoGWWJalwA5SADvF9009chse2aZCHRNg5YJzjzJoeNbn+3zsq322Pgvd3Q+sWArPzzTmeYLoTBOeFR8Dsh5c4Q5v1UJqEax9Wej9URg5vz64c2Kql33uPz5pM1PvvcwTeK02jbJnoPrF/+9tg2NjyfBxm/Ety6MRSThkpIteSIyJOp8Flbg9UVell/BqcKCtkykzV50Kp40m1G2vZ+yVMbAAAGgeJkIhLUjO9eW6Zk5n787dl1r4dv/E5tiDRO+s+Imi3oDEHSzeK9gaTjsiXbRV3PD1PpfZgwGZrOK73pZXpQKHbc7KzfNKzedH0d7xCv8SXB5/fPCQ4KToAADH78Y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(4326008)(508600001)(8936002)(186003)(26005)(8676002)(66476007)(66946007)(2906002)(38100700002)(44832011)(5660300002)(66556008)(83380400001)(2616005)(86362001)(6486002)(6512007)(6666004)(6506007)(107886003)(6916009)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RnNTJUuXmTmabH+Ac9AtTeBnBV1JjPRI4QNFmg6oXBCifoLn2inDsG5MQPx7?=
 =?us-ascii?Q?21t8luU2YGcvsgkTVHksudNzvOeVfbycEx71fhvbdTrL3f0dbVif9kDpiTtD?=
 =?us-ascii?Q?Hj6ImnaNp/qRg1YRohgUOUqh9HSQYWt3E7Lk2HFKD5l8whfynkRS00CleaMX?=
 =?us-ascii?Q?e4BtsVpZzD3kFz3RjCjaq2Qg8/hPESQedHWiwA8tGZm+XlGGzZ7OY8PE9PAk?=
 =?us-ascii?Q?p6chUW66siGiz8wmWwQXgvttk5Bvaw9BGtfxBP2Pcp8UsYX2mCkB1zcHfrGp?=
 =?us-ascii?Q?65d/N3BXWzpyvx5xcFVaoG+xM7vgkfiP9voGBh7TNeTMwCLkiE8Dji79fV/Y?=
 =?us-ascii?Q?3OC44gzW9kzZYcMlYSSrcK7jV/En2EYN186zsYN3YuCTzWP4yHgamSZBjqZ0?=
 =?us-ascii?Q?M7p9EeSNeqWfOZsK37f5hLSWdPIrq8OUB3JroQcLWnjg4UcTx9EeEDcFk+13?=
 =?us-ascii?Q?6Yj/dCftF7mdnzpXA5SROq02dmRFoVKW1scT5dxQJ6ub2ZGIOt8kHGYRg8fj?=
 =?us-ascii?Q?cSQ7YYr4hui+PXcvkK0ui0Jk7NXqYLTvX6UX4rbKpR14KJ2Gr1vXGKjLj/iO?=
 =?us-ascii?Q?I3TiGiGvd++FwfrpE+x6xVo2LFqKe07uwrwppfjt7HOxxH/vwUzhZi3fTAHo?=
 =?us-ascii?Q?RE1RtXsglh0rAAw3YmN74BshCTilS/u/zkrhaicfNr3uoVoBvWO4muPP5g8l?=
 =?us-ascii?Q?Dl3q2+IJHO6/EjDZqxL4DoYUJSlFwObHKNPvQ5yfl7sULhTd1mADExEtqkUL?=
 =?us-ascii?Q?saS6Tks7YlnyFF/OfoNglBirkqOv+nQZz1v+G69MNLWnRzf3ZgGvKVALwd61?=
 =?us-ascii?Q?BjUqQEzc6Nllt9sfdF+A12hco/GKwfuowjRRv7Qj9pgQlbr2jzKz48GxoO0y?=
 =?us-ascii?Q?NF39MgpALtYkUuegeRigKEWx16Kjaj0PZP/9DtwYhkD6Lxm52VM/qJUFUd7v?=
 =?us-ascii?Q?OeldcRhSQBLZBI0Q5sRaqBvkJqL//lwrSvQbWM9kIOda/kKWyL9QdtaxAvDD?=
 =?us-ascii?Q?eU5FcdkqSd59+YeSRa1vrvN1oKtRX3tVYYrjznvleSt7GGigYFkd3ZJ6qN9Q?=
 =?us-ascii?Q?nDbB6zBCKnJMIsPwrl5xbNNGGbiPXYvyiI0lsiE6H0/wS9ZuoBwWAmXNDXNJ?=
 =?us-ascii?Q?B9I0F5JqCp8fYR9Lpi5aB64TReTKPhSwR8UiiD4byfjGsykjHYzy4v+kgLSy?=
 =?us-ascii?Q?m6BgkvA6cOa2XDrh4bAn4QbDe/2nHFeMb28mq6QHN20QWTWtfw16cRRh0Uw8?=
 =?us-ascii?Q?6A2GHrW7WHwZibySLbDKTlxbYtw9kaYPTsX0EVEI7IzVO9IYlesqUlcWAtZt?=
 =?us-ascii?Q?12ZL7/HZLXyo9LMwrOi/UQG58D8Y/hfptq4mkOCp8+0WH6gQx4pW6Xm5F397?=
 =?us-ascii?Q?lAr8A1P7aMmjoSGaQNpAluprZHK0odUhvUgjA7lorMuKqk6IUsDnpT/48n14?=
 =?us-ascii?Q?NKqMv/0rGq4r3Xevhl3meD55weuZRXQW2t5iTVQm4jPnHjWRTj/3F2ecrwDU?=
 =?us-ascii?Q?V0QA2LEuAz3gugPPab6lM4Jr8gVXbRysAZskaZxWW7WPjvO67W2tlPKZdGe+?=
 =?us-ascii?Q?nSBBtLwwZicBWajVm3+DyB3MLmJ4dZa2BL60x9xEq+LrokxaWkYk30DVgkM4?=
 =?us-ascii?Q?/rWSUSi4jPrCD2HmUjDv8sYrf28Q5YuglIMp7RPgv/8AZgCbDJ5Bn7BMKXIG?=
 =?us-ascii?Q?i1zilv8ObUE6/Dd6XEK64CpgrecNYcHaWDP5uyX4H/jMEyrUoDpfL0+Z5cAj?=
 =?us-ascii?Q?RdrP6Jdm+vKoCcOPioVdnmT2layjFaw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52062ea8-4ce7-4494-8d11-08da0e7a4947
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 16:12:40.7071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVzy9JAg6E9M8hfdgEdM2cXLpP/yim/MxuBpuOlrQPPC5hWtQA+QveLlBT95zVc338ipBa7ylNI4aQuwho37Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3938

This patch defined the default packet scheduler mptcp_sched_default,
registered it in mptcp_sched_init().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  3 ++-
 net/mptcp/protocol.h |  2 ++
 net/mptcp/sched.c    | 14 ++++++++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b1d7c8b0c112..2c684034fe7a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1424,7 +1424,7 @@ bool mptcp_subflow_active(struct mptcp_subflow_contex=
t *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -2614,6 +2614,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	msk->recovery =3D false;
=20
 	mptcp_pm_data_init(msk);
+	mptcp_sched_data_init(sk);
=20
 	/* re-use the csk retrans timer for MPTCP-level retrans */
 	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3258b740c8ee..0a409b28e237 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -614,7 +614,9 @@ int mptcp_register_scheduler(const struct net *net,
 			     struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(const struct net *net,
 				struct mptcp_sched_ops *sched);
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 void mptcp_sched_init(void);
+void mptcp_sched_data_init(struct sock *sk);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index ae1956b6de92..1fb3dd24d6ff 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -23,6 +23,12 @@ struct sched_pernet {
 	struct list_head	sched_list;
 };
=20
+static struct mptcp_sched_ops mptcp_sched_default =3D {
+	.get_subflow    =3D mptcp_subflow_get_send,
+	.name           =3D "default",
+	.owner          =3D THIS_MODULE,
+};
+
 static struct sched_pernet *sched_get_pernet(const struct net *net)
 {
 	return net_generic(net, sched_pernet_id);
@@ -70,6 +76,9 @@ void mptcp_unregister_scheduler(const struct net *net,
 {
 	struct sched_pernet *pernet =3D sched_get_pernet(net);
=20
+	if (sched =3D=3D &mptcp_sched_default)
+		return;
+
 	spin_lock(&pernet->lock);
 	list_del_rcu(&sched->list);
 	spin_unlock(&pernet->lock);
@@ -111,3 +120,8 @@ void mptcp_sched_init(void)
 	if (register_pernet_subsys(&mptcp_sched_pernet_ops) < 0)
 		panic("Failed to register MPTCP sched pernet subsystem.\n");
 }
+
+void mptcp_sched_data_init(struct sock *sk)
+{
+	mptcp_register_scheduler(sock_net(sk), &mptcp_sched_default);
+}
--=20
2.34.1

