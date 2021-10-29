Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8980D72
	for <mptcp@lists.linux.dev>; Fri, 29 Oct 2021 04:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1635482446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hbgZAupiI6gXxTUN23C8pcgsXRBbdwCWsJN0PGRItQ8=;
	b=RQ0tdCNdm46Kfnm8TzVhmCFsbaMuqM0iZiqHUTaASyHu0Tg67ybkZ7kpWdgGa8iQEAGjij
	CS1zEXu4JNM/xIwHFhCXdDZMGc7/yr2kHIcoivREQJnyE7QJzTFqEn7WxPQDDtPTWqdbhZ
	LKBTlOiDiway39k+4sStcmS8bhUGxWA=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2107.outbound.protection.outlook.com [104.47.18.107])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-20-AsgVbEa4N1acJDfTo5nCWQ-1; Fri, 29 Oct 2021 06:40:44 +0200
X-MC-Unique: AsgVbEa4N1acJDfTo5nCWQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvEzfGYEYU8zHYrPnMUMNGF4OO0YlRSNuDFRkaNdbGCOb+Jx3sL6+XQy0gow1kMFoFCeHjs4Rbnng50fUbrUCkSKcEMgtLWN5JhbCouHSGeL9nWLq44tu2tXTl9A0YIguN5eLNtptest3YNlS4mr1g6ySmPh4Z8WA+bEEosOSDohfen33bg7vKfTDrMVMjnofbyXEPYA8t33EMPCpicgy6WbfPitFP86+BECqdRUsRTuc0dystmGRVzV2+TWXOWTQGvoGhr7dnWZBGJSo5eMlFNdpFImnoptq7GpoFEnrTBSZbqmSn821atrYu/ODlAGQIxj5Mv9A9uYkPqJRV2yMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orkUsj0NHZDEWr0ZROtItOCfLtqq+HvXaV6s57mjCe0=;
 b=QWh1VHg7Bu0gnvOOLpInaiVLrDeIj1I9siGUKpcJFGdLu8/0fSkj1hKtzpXXNJUNh3JZIanoOBey7c3MedtfaECHciS/VZmZ1KUkxG9nABueQQ/r66VDgwAVi5TFGpc4zHuCRNUbMgMU93rJj+NXwBjrIkJPx007Yz910tDI0iFE/Wg8+I1YFJyUGBrcUbekGk+8f7mkl1KIfYea0BnlKrC+non8W7/uFE6+WdaVPjMSalhsScvuiiaLBPILoQo8QcBl0vNWyG6edPhU5r9ULE9naRyAeYePoVRaY7pF168YzB4m8B7oK1w/pdUK4HL+mrlHg0frlctpnjG5ZK3v9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2652.eurprd04.prod.outlook.com (2603:10a6:3:83::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Fri, 29 Oct
 2021 04:40:44 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af%6]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 04:40:44 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v8 2/8] mptcp: add the fallback check
Date: Fri, 29 Oct 2021 12:40:12 +0800
Message-ID: <2d98fa076735e23e41c5220450ea5ed5813c3ed9.1635481641.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1635481641.git.geliang.tang@suse.com>
References: <cover.1635481641.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0198.apcprd02.prod.outlook.com
 (2603:1096:201:21::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by HK2PR02CA0198.apcprd02.prod.outlook.com (2603:1096:201:21::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Fri, 29 Oct 2021 04:40:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac2654f9-d819-4644-0021-08d99a9644b5
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2652:
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB2652068168B8E49C29CB44E6F8879@HE1PR0401MB2652.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E55xDpaA2ggBhPlpOL8ctet1/o/+BYbP4Z/D4X7w0KvQre9pHyUEMkEVpwlRMeewCMBRROER4VS4/g6Tm0LoOvtcYH/84TmV05YJ3y7oeb93GMa+JoWSe+PhTCAOzFDni9gY+4QMpc499vfyHsEl9Ay841hTsCXJgKeB8hcwglyGe2+/19iZNe3Y9GJySO4xN6vbxLusH2q035QG0t27jOQtPtKF0dMFhp4VBWzEM000qUBaUzBsKdGYKxLiFSAgrEWkEzslLLPT+k8ApFQQPwsf38O/Mss8DkWiBAJGitGJ+cWjYWO+vwWhrKLYNuP8B51qAY9IvAVrkVZGrDbNK1LaGFPeCV1eVPQb2F4yWoj3/u9t7wyMEO8twrQMr7BReD/BpK7IabH8RtV+4EcHCIl0U9WoQMPgQsuyrPBa7kYh2HQ4WcmGfESzTS9Prb3T4Be56J2GxVuAQBdrm23Cv9itCLK+G+HEFWrE3E2AhQNii85ujFOcLBZAt6/kbDKkP665Ddxwxr4XJZDyblXA8irwbkKaObxtCz3AyMxTQy0QKNTDO76tSnjOZKpkDGrT8fmv31HxewDTpPpVdANXEZW3U+uw3U8wEX87PIZD3JxRsl6rfjTdQfvuTOefYI48B48EDlb4XkiRJHhrVfO8Hg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(508600001)(4326008)(66946007)(316002)(6496006)(83380400001)(55236004)(8676002)(66556008)(6916009)(6666004)(2906002)(44832011)(66476007)(86362001)(956004)(6486002)(8936002)(2616005)(26005)(36756003)(5660300002)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nKbNYGj2GWyrXKnvjl/NST3/ptU05Q5qIJE/u65MAi/LpZe0het3E8TZ6aY9?=
 =?us-ascii?Q?aXcLqaBbONdrMgOQzv3QoPqOpHciEawmqeddQ32EphetNfmhxsadqU0kxfqG?=
 =?us-ascii?Q?WOj0gdZrAMS5IdR77A7npwmx90kjzulejzcyL1Bhix6bBHT4NymwS4WIgGLn?=
 =?us-ascii?Q?whj3iZf8cHrwPL6Or3IxJxMOxJN2uGCupgW61n5IwNJ9vQXAHHL3+oEoYwiP?=
 =?us-ascii?Q?avq47hgg9+Yvap5XAbAp6bWbhrDbVuJwAhdrUKA9S0YewxRywkkud/3HUwbP?=
 =?us-ascii?Q?71xmQuykSzqjnXHwlO1hvoI9kZlLoreO0ebtk5PFwOtzNrgF7IwLP0xcCikv?=
 =?us-ascii?Q?v3P9t356PU2mCWEU01QrfDuWQgf/mvkcWtZ2xT6Je2qEku4ekvdabsGYNi/6?=
 =?us-ascii?Q?c7gfFf2JpwdX23xxuBgiIrBQb21MCpX0EOl5ncM4DoxKM9y76q/59pO836do?=
 =?us-ascii?Q?FToWBtWFaO4aXJZIfLe6xtgEhi5oX8u7K3cyicy7bqAkliThwJyI9a4qGev+?=
 =?us-ascii?Q?PDLSEWwtuBzmR3pF1y1VESSshjf3UDTpNGscpV8VsJ1iM55m0UZ0TMoN3C5u?=
 =?us-ascii?Q?WPIoR6Rw9Q76CUhum+GXpSiu5VT4mX6WFYqzRPaPpIcfI0xmGk9nsicM7JzZ?=
 =?us-ascii?Q?6VVq8pJG1jWch3tvlyobaf+NqhuFoQxUUKW2/N0KxUWjF/kQkWXXiSobj9iL?=
 =?us-ascii?Q?knkSkzCjjsPOcsqVVl1twFTy/+W3J6h0YutSOJWxZtCQfygXQgNDnG0maYpI?=
 =?us-ascii?Q?ZdfT4S4c3y5w5d6pMhaPdiMt7TG1PqLpbFHsuZQkAk9x7WzMsSZPpH/kXgbl?=
 =?us-ascii?Q?2d6bFIejkWaU0HoMmM6KiHaG41TTZ4fsHwLVtUgTRkhP4a1atXtYf8UO31iT?=
 =?us-ascii?Q?F+6kEYEGPkj6m+349WtyziIQwAye+mhx70J6FK16fO1v56yWJ5HEmBQi3FW5?=
 =?us-ascii?Q?3dRCUYfIY19teXzLorWQnYjvEk37V8NCu8/Su7+eJpdEe4bMzpIn3SrVLcYA?=
 =?us-ascii?Q?3jq1YUWaS8AbHYXLe3SsWU7gl3x2rvfPEqHIhNjTk0qrB/Yfz0N72r7JOBby?=
 =?us-ascii?Q?UYYLr1FjYk0H6rqiZcZNGKHf40J4IhJQe0ev48PqMuXqmEdVgr5XzQZKNfci?=
 =?us-ascii?Q?xydkxI1TYj6bbzg7QoawPiBWN0KeQk+qj6K5t8aoVqfXTgit5nmyYoEcCIcv?=
 =?us-ascii?Q?S0eCSatfqcU+4jbxEOg+DFi//FCE8alFHGR2uyrFKTUy672BfXt1wdUgSQD+?=
 =?us-ascii?Q?IHDAIhJsyueoLMuzxH5EMAxSV/24i4QVQo8eomKOsIj1GTIhY+v/M7InVdp7?=
 =?us-ascii?Q?nlfWasQ5P75aQvL7LYBjmjlIBMJBLgEtrUie10sPwywdpM7Mggb7C+7Hsiw8?=
 =?us-ascii?Q?mIS5vsObije9lm2Y+uTTy6tiQNAoeG4sqGXW9lejzNtPArnBsLMxSFL+Su6M?=
 =?us-ascii?Q?t2u5osjTpUgyWsBe/3znfnPBTTe+jbpVlwLLsiBfWHuPNfrrwfxzG/vWIft5?=
 =?us-ascii?Q?5fSLVwfPXS6YS5LIgn+TtYN5xKtp4Lv1W86HN91EzX/nWditOQUO0nz2DWRY?=
 =?us-ascii?Q?bSCvHy3ZoHHvZQGVmJ2IBqZXzM33M6wF3bQZpY9J396wrI46mH7gsRcIV2pS?=
 =?us-ascii?Q?lf9vqWYq07RDZoa1AohbIW0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2654f9-d819-4644-0021-08d99a9644b5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 04:40:44.1234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7lHT4vpL5ejMVrQYhQ02y8/5FTo/7WxlddjjK0NheF+vwxRYuvbWiPXgntvvyoh7ndlHAifkRrYdO4+osgodA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2652

This patch added the fallback check in subflow_check_data_avail(). Only
do the fallback when the msk isn't fallen back yet.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/subflow.c | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 92b45a7c997e..87a9ffebcc42 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1164,35 +1164,38 @@ static bool subflow_check_data_avail(struct sock *s=
sk)
 	return false;
=20
 fallback:
-	/* RFC 8684 section 3.7. */
-	if (subflow->send_mp_fail) {
-		if (mptcp_has_another_subflow(ssk)) {
+	if (!__mptcp_check_fallback(msk)) {
+		/* RFC 8684 section 3.7. */
+		if (subflow->send_mp_fail) {
+			if (mptcp_has_another_subflow(ssk)) {
+				ssk->sk_err =3D EBADMSG;
+				tcp_set_state(ssk, TCP_CLOSE);
+				subflow->reset_transient =3D 0;
+				subflow->reset_reason =3D MPTCP_RST_EMIDDLEBOX;
+				tcp_send_active_reset(ssk, GFP_ATOMIC);
+				while ((skb =3D skb_peek(&ssk->sk_receive_queue)))
+					sk_eat_skb(ssk, skb);
+			}
+			WRITE_ONCE(subflow->data_avail, 0);
+			return true;
+		}
+
+		if (subflow->mp_join || subflow->fully_established) {
+			/* fatal protocol error, close the socket.
+			 * subflow_error_report() will introduce the appropriate barriers
+			 */
 			ssk->sk_err =3D EBADMSG;
 			tcp_set_state(ssk, TCP_CLOSE);
 			subflow->reset_transient =3D 0;
-			subflow->reset_reason =3D MPTCP_RST_EMIDDLEBOX;
+			subflow->reset_reason =3D MPTCP_RST_EMPTCP;
 			tcp_send_active_reset(ssk, GFP_ATOMIC);
-			while ((skb =3D skb_peek(&ssk->sk_receive_queue)))
-				sk_eat_skb(ssk, skb);
+			WRITE_ONCE(subflow->data_avail, 0);
+			return false;
 		}
-		WRITE_ONCE(subflow->data_avail, 0);
-		return true;
-	}
=20
-	if (subflow->mp_join || subflow->fully_established) {
-		/* fatal protocol error, close the socket.
-		 * subflow_error_report() will introduce the appropriate barriers
-		 */
-		ssk->sk_err =3D EBADMSG;
-		tcp_set_state(ssk, TCP_CLOSE);
-		subflow->reset_transient =3D 0;
-		subflow->reset_reason =3D MPTCP_RST_EMPTCP;
-		tcp_send_active_reset(ssk, GFP_ATOMIC);
-		WRITE_ONCE(subflow->data_avail, 0);
-		return false;
+		__mptcp_do_fallback(msk);
 	}
=20
-	__mptcp_do_fallback(msk);
 	skb =3D skb_peek(&ssk->sk_receive_queue);
 	subflow->map_valid =3D 1;
 	subflow->map_seq =3D READ_ONCE(msk->ack_seq);
--=20
2.26.2

