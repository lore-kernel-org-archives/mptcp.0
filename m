Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130043.outbound.protection.outlook.com [40.107.13.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E84C17CA
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 04:40:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2M96j9m9ecn2JqnO2nIbRSFYJF1oCjF56f97/QtNRf37ZjwuLbGTnAksWDo/tRVdcj3bxA+85AS+V5pSnHRx7P71FY9//fikO/I7ChxMOf8KtSDRyuTqhJAzOcRM+XFRwhkWk47ewNs+YeyMBrnM/PoEkJd73P5qbHlBjdnwnB83ezizBly6JAgc40vBWgFmEW2G+165/1emWBEgpAJ8DExfuLn9Pby1gA1sBpbJQwJJA6nxHEk48q5iSNAzHRJliYnPFuEiTtdiWD23s8RHB9N2C/1qBPTTSjrbftHMX+3+KgMBjfg0Gs3O+R/ZrKlwPl9pn4E5J5AS9Kn3pQ7+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsOnjSqrgkbfkTE6pmyRUwRcDmt/XKW+i4Pe7JdDcAo=;
 b=SVR7WZ/GihP3QJBWKi6qZMDMjtZj8KsH6ILGsF3oUl2iJieF3F6he/2BIyCvE1C7yblpWtzRkJOqaKKBii5hKUmXeRzO9c4KAST58HGetTa1sLjm/k95iccz+ad8BRcEQ91AZkgKgQ0nPkdT4qJ+iLUCTZzijgMP1aoI61w2ODqJKL385/TVqm3Wmqu8vWrABgOoOhOnOKPO27K+Xrwf3MxLB1m5OATjl0OjlPvfMmRGc8Tec3cGS75b66FjUMZ5q0zIWbbrcjcCTjb7HZTMsOFGwmaphyaUe8FBwSZL3o8pXKTZdZwENZuLKIIVCC4G297Dzna34rmeGMXDXVOHuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsOnjSqrgkbfkTE6pmyRUwRcDmt/XKW+i4Pe7JdDcAo=;
 b=4ZjjGaWg/7Pd7lXCxGkcBAd3HFV73XCCAGJncZkEAQKdFeDlRmhQSA2bSzTC03/owtQDnzPWz0eIL9ZYPFj8AeUTaJSM9cXLMDwn5XU8vGHsblU/QlS6AEb39WJ7M0gxPK/kwD+dWPVpdwy5Of6KRk7Ro7F9pUM/+C6JvK6Qk8Fh+ZLAm8b1kiXS/D1IICXFi2jtOjJq7oEdfFHx09mNmQCe1qxvrC7B/MCiPsSMXc2m1FQ1zpH3jM/zPAGp0Rz0SS0M+EABZVx0uvY/tL0JKvPZ0izniKLt0SqrbE3c/jg7wXU2tQ6Km5cGEpIbiBYqJrkxbutbM+vbqMnzmO4jGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8814.eurprd04.prod.outlook.com (2603:10a6:102:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 04:40:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 04:40:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 02/12] mptcp: change 'first' as a parameter
Date: Wed, 12 Oct 2022 12:39:57 +0800
Message-Id: <028884c75c55908908f82bfda1133c0f9981f119.1665549148.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665549148.git.geliang.tang@suse.com>
References: <cover.1665549148.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::8)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: c11cc46e-dab2-4005-b580-08daac0be2fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gf8gijKulD1zdpQLM//DKS0EgtZI3jAzGFd6yCcQYstjVLW0edAsNX2efA0q1b+lu5RCV18kSMzWtkldUm49Pt7Zme6/5Vns3hYdx+cq3eW2Sa7t/ewvRBXbCFfzpdNxqJSITTaSIOqSJcrBGLEaSLqPkhDLuxNY4dMZjOKdTyJrPTS3e/BVkJm1AXWnBl3apCOPV67VJlU2vAS+C433QC2tmvYUYIJQvL7NPB7IsPJzsw3zQKocZt3OW/ZOsl6T7cbJXN8d6k5jt0ShppvhB99ifkn3YXVVoTY7OFg+mr9m3N8p8/sL7e3pQtYkYEUQYNMxf+Yro7vUpJNFePr9pIUtDTYxn2h0KOuNupBurRwRG3xEkmo22nNEJ1wZakaUinHNfA7ykRft+Ko5OiI0A5SrFU2B8paREgX+blAfAzXGYfx1Qe36XW1uDujfuzpq1mEJ36PnIFnznHBVvuRnq9ZO6qLiQx35uE95yVLDRmqTodl6Uq23UwBMTjiKQBEi8aX9gvQ0jFilx6iOKnF4187SN4p2o6QiIbcclLrQhixZsVNiaEVUDSNLQ3fhD85yTAhFx8K5+hFqYkD4bDXqPFbxcsFV/cDHR8VeLhoqiVb1nftaplOyZRDs2IejBmkncYcgiZSjAq/MoeAWuqn2IC3XIB/9qt4n+0q/3MsbeULrsNoAdPg5iRuYw/+Q4JLZ1xI+rYBXRg9r6+uwX+8kRSPL4db5MSDsYWE35e9cnuu8kcnakmtP5Qlrnwzeql4v
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(107886003)(66899015)(83380400001)(8936002)(2906002)(36756003)(8676002)(5660300002)(86362001)(41300700001)(66556008)(66946007)(316002)(44832011)(6916009)(4326008)(66476007)(26005)(6486002)(478600001)(38100700002)(186003)(2616005)(6512007)(6666004)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fe9pUvq2kWxnqQwSfcjVT3LaAKlnJyIViYE7xblmsf4eCvb9vGYL7Sgyxv2v?=
 =?us-ascii?Q?T+7cL0GI1BCZZdsWOJbzoV4zTzsYVsbnlX1Pm7SufFtbMTkma4PFDbtEGS/p?=
 =?us-ascii?Q?C49xUGHvkn8gyNIGeWm/QweF1kiJ8XMLDU7ecGn0ho/ZeE5sV0f2jGc3b90q?=
 =?us-ascii?Q?RTrTTdcw1Rwuxu+MrfbX1ldBxpZ6guVEJGNd1voinVj76BajHglvDw7zViFJ?=
 =?us-ascii?Q?UsH3dRFu3Exz6tZPEwfYmtOI8aaOHjCGCGvugq/prcgFvy5gSoc2SgvOCclv?=
 =?us-ascii?Q?uiGtqrIYWGmKwyvQrukdUPWdewwtayh1gmJ9Nfl5btuguEDXsOaTTBI71gdJ?=
 =?us-ascii?Q?3Ra8LulZrboSLxzMLOkQKe/VOUOEICYz0u+b8oq+88pADAF6byz5uI18MjcO?=
 =?us-ascii?Q?Dh/As98IPoN1vlFZ4qE4le+VShIsO235G+gttfZS2OXMCWxUu4XoQqbvjUH+?=
 =?us-ascii?Q?vIFFOInwU2GRQSgKhlirtbDNp7kqwAVRgHbEmWa4Y0Qk4FUhOJdMdeWozf5t?=
 =?us-ascii?Q?KWVomWraRFjGJUGNO5le2tfKrdcwNunGzDOd/rWP4kialC5lWOVWQn3jJdlv?=
 =?us-ascii?Q?maOS19tKF02aBr+7CS/apAO9EbQkfsGsezFOaOchrawMhY/m82Aq9ix26wJc?=
 =?us-ascii?Q?jkUcn5xNmgl+aVR0uZ8J9LBa9m8Zsw+RE/JH96oXAnEtXa0C+pwfFfx35Khx?=
 =?us-ascii?Q?ZQG0QQE6XP3SIxM4ktpAGv0z27q+KHJ5UI35ci2LQyc1QtN3br5/kCPjOwTF?=
 =?us-ascii?Q?nZXN8VrZnbJlT4T6MQz4v1c4vfU703SYzUfNOr/nCarowO8eCxB5mSag2fZC?=
 =?us-ascii?Q?+pXigUle9+EoCxjTLuScqFuYY9GeiDLT4e44+IjdNi6NlI0GiYJmd6W6vtzw?=
 =?us-ascii?Q?qWGb/VNCrx5BRvG1pupha73qRi2LBwl3pTiEf7T8qcKctLmpJXjBdV/mHuHB?=
 =?us-ascii?Q?jK88rf8L0vubecgo2eZ4g8IoU5YHAzea5ZoZuQobjDd6Mrwk+yNxNEAin3nr?=
 =?us-ascii?Q?wLwYu+RQcz1wG/FEskBpyveb8gnX+38VXE3upLbsmFiwnoQ/gRsQQW++Nwuz?=
 =?us-ascii?Q?RzTcQu7TGxT9nyHaN2qyA71HOuTNTWmTJtDr9igsEbFznKjEZ5DblBqYqWys?=
 =?us-ascii?Q?Uk312gmjhn//Oe7YXWfG3eXbmgrT0Irr2vWlcgsHNou5/mdzYJ1H1EpCISZ1?=
 =?us-ascii?Q?UspybAD0JGZ3qzouHi7GhUjDX2F+vrU41cbydiMiYCjpEa/5CQqIofsI4bS4?=
 =?us-ascii?Q?3j4hscXZ02aHOwQk09MMJKm9pZaT3XRQjakYZ9FTUjL8beb2uK9VGs+B9JXp?=
 =?us-ascii?Q?MWAyAQirqY/rtV21lVtgot1yRzI7hiQnkMYVgGVeihTLjS+WCrhTu2oOyVdf?=
 =?us-ascii?Q?5lIHmTgE7NtCQCZRUJDrXQaIc/ySznxfJvit1wjXdS0yTTDu3gRcWo0eX6VE?=
 =?us-ascii?Q?xCU4OQJjF5qzS/sFqlQd8XdxgQ6LgidFWGnLHK/5FUM7JxDGQvr+ETYARf2j?=
 =?us-ascii?Q?DVnQNwR5Vlh6OUd2bB7dPhPCTQxw2+GLJ0wOUSaWvTwKZPYgnb926BiFFPZH?=
 =?us-ascii?Q?iesRNhneIZk/br9Xg8KyGpfdhEQeaIfQesJcpfB/5YyBfCuXQTbXQSuQz1dn?=
 =?us-ascii?Q?HA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c11cc46e-dab2-4005-b580-08daac0be2fc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 04:40:27.9957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCCm6p5ALeB5wd10bG1DffrPVrjzb7eAUykNb6b1DDK7T4/7FiJhSkHjO0W45jiGxvfW9mS7UnJSeCIhGBQoaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8814

The function mptcp_subflow_process_delegated() uses the input ssk first,
while __mptcp_check_push() invokes the packet scheduler first.

So this patch adds a new parameter named 'first' for the function
__mptcp_subflow_push_pending() to deal with these two cases separately.

With this change, the code that invokes the packet scheduler in the
function __mptcp_check_push() can be removed, and replaced by invoking
__mptcp_subflow_push_pending() directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9a2253436f50..0285b21ff912 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1593,7 +1593,8 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 		__mptcp_check_send_data_fin(sk);
 }
 
-static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
+static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
+					 bool first)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_sendmsg_info info = {
@@ -1602,7 +1603,6 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 	struct mptcp_data_frag *dfrag;
 	struct sock *xmit_ssk;
 	int len, copied = 0;
-	bool first = true;
 
 	info.flags = 0;
 	while ((dfrag = mptcp_send_head(sk))) {
@@ -1612,8 +1612,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 		while (len > 0) {
 			int ret = 0;
 
-			/* the caller already invoked the packet scheduler,
-			 * check for a different subflow usage only after
+			/* check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
 			xmit_ssk = first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
@@ -3198,16 +3197,10 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 	if (!mptcp_send_head(sk))
 		return;
 
-	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk = mptcp_subflow_get_send(mptcp_sk(sk));
-
-		if (xmit_ssk == ssk)
-			__mptcp_subflow_push_pending(sk, ssk);
-		else if (xmit_ssk)
-			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk), MPTCP_DELEGATE_SEND);
-	} else {
+	if (!sock_owned_by_user(sk))
+		__mptcp_subflow_push_pending(sk, ssk, false);
+	else
 		__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
-	}
 }
 
 #define MPTCP_FLAGS_PROCESS_CTX_NEED (BIT(MPTCP_PUSH_PENDING) | \
@@ -3298,7 +3291,7 @@ void mptcp_subflow_process_delegated(struct sock *ssk)
 	if (test_bit(MPTCP_DELEGATE_SEND, &subflow->delegated_status)) {
 		mptcp_data_lock(sk);
 		if (!sock_owned_by_user(sk))
-			__mptcp_subflow_push_pending(sk, ssk);
+			__mptcp_subflow_push_pending(sk, ssk, true);
 		else
 			__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
 		mptcp_data_unlock(sk);
-- 
2.35.3

