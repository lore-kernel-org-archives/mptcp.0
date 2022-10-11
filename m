Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DAF3207
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 12:02:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJ7CqT2dEPkZqAVGHIHBBha/CzBwPEodvoODBAlEAX81ixZ+DahY3mCtgQ09j/YJQSVUOg7YLA9EFelZpkPunpTS5v6v5Jyxd1ZlyuVPc3hFlmfTPBQEKx+a06RfIX7j/xJjf+GBEMusROByGPi+oFTPWTJUocNCi8FfNu4kHECFMTDNUtpCFHemQmXqtfyIkoDvt9t45334FkJ3wi5dpt2wKJsMPOa0S/AotZEd2APFyS6OKTjsVuOpZXbKnBDU7A+P8ToyFfeGVvWMLicLP55V9rrCHd9pL4b7okOcPYMjEPmjMT4IhdMJMOIJ1kYpODDOQlbIIjnlvlocq4W5LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E61NAzzPt64BclmCiEp0HhBHqgjVIhbDgjaZ/KPzI4g=;
 b=Idkj2yw+NqIgY26Qaw/d26N5TTXT6U6l7B8z2frJ0uxmdXbLBvCytHKEFEDGNv8WPtupkFxkwjCR5BHWhQyZ5X5dgXLbeGYHM9nZ1oiRHdpUHADVJvA+7JoT2JRVphi+xDxpGlUe8kLHXHbL9dL0rdeztJiyKpDLL6vhXRRqLQw4lgNAvgbYQ+csHFfVsujQlbufjmeZHA1R31iErx3I3H0K3wuPdDEuWCKuDCM6h9vDTtJfLoW+dDBvqPIxB65h8qZceN3Y13Hbm22PI11Cb6dccc2gujotnTvMSqhxJvBpdEU2UUuJlJuxwvEUqxXuZA9liNCkKzDLNHOfF2ZpNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E61NAzzPt64BclmCiEp0HhBHqgjVIhbDgjaZ/KPzI4g=;
 b=SjIDVwcgfZni+4ioML2ttAv8Lk11Rh1xgOVwcIIY9bEdUdoNhMhkNlUntPJyx20FvLUexbz7qwO6ajxVC0xBsMt5Jy7ETyuyY50LT1JYu21vRa6jX8wDfWypWqmDvfhPflBw5qjqF9gR1o7+Roe06QOxmHTXYGkhHkrIhoQ1jwlBrRnEFuTxzsKnOZ8kF+RisVT9Ieo0imA8qWPd8k58XYsMPZYOHd8OrR3msMjJqE1LGmrS3gW/zsHiuuAb8mnhap8eKYeCDRVHVbcxDmJTJsVgWWoR3IpZ/yS0pwVmpEvXq55PqA3qRjo6EO5vKtovwq7IpRgYstRkfFWM2R/v0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7557.eurprd04.prod.outlook.com (2603:10a6:20b:294::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.38; Tue, 11 Oct
 2022 12:02:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 12:02:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 09/13] mptcp: refactor subflow_push_pending logic
Date: Tue, 11 Oct 2022 20:01:33 +0800
Message-Id: <20221011120137.5475-10-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221011120137.5475-1-geliang.tang@suse.com>
References: <20221011120137.5475-1-geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0232.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce813b0-efbd-4d3f-9554-08daab807491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Tztz9TdjhoDpaz/jcmhJEdyFY96g50UevwI9qPqhC76/kHcd0UDeJjbcjoFCgjCV7QR0O2/pXCyLrbVKV38sVLSEusrAqW7pePqwI4XPBw/SxSTQ5AxFcDzlxNouHJeOzwgDtPtcyYOpkK0bMZdy/d2VFTpnsZyNHRAOQIX+OyBMPnzMj0V0zBjLH5gSl46qjGAuzNpy7H0RU7xorhO1iXNqdHzrlB0MXKrYLF0h1Sj+Btwt5EpbddsJPEWNp5Pjt41TaQd+/NUIpFmxpGEmHMRk4VAVlya9SJ3rSFpX2X28K0idLBXHXxRxTXgUayJY7Bi3kuwg8JTNtWYTrxOrWqxM8Z0u1iwRIluU/sf1hiXe40DQji7st5KR+3nbKd3NAE+enwrwWPmLtGSA16JjTCuLgE8d2D9i/PRz5qDV1TVp5816uHmpzxOhjckTsqmzruR+znoBT4QcNH1Rh6CG259a2ycc6onbDaGs1o2qwYFiimijsqLyhWiWt2r6buBA4sEGaHODv5pEz+dgJoLFX5/CMFWF9JG6krHYD+uj7sJC57W0CimFy5yVWko3SirrZeC8qA5/b26jiPOB1za9iGPkCyTAaFr8sKPDA3hWcQKD3bdgSM1lOzDhjWI9a5ZXz5GtVrRfV0y6FiePQ8PA8BsC0n6XU4xCTzfnPSiAxgebZvjEqbr3SciVqtYaJyZFSs3nq0RuWGTaQbF7DWDXnwIEkom//z/UBKiy1bBNvk4oUUoUqfBij3bCFavBEOvl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199015)(83380400001)(44832011)(5660300002)(8936002)(316002)(41300700001)(66946007)(66476007)(8676002)(66556008)(6916009)(4326008)(36756003)(2906002)(107886003)(1076003)(6506007)(6486002)(86362001)(2616005)(478600001)(38100700002)(6666004)(26005)(186003)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qvLJNlMUk4ajSoFSk4RWhQubcEPCVLYXBGs4MyfGrFcjNHWK2eKpcR+a9wOq?=
 =?us-ascii?Q?F+vqsUCqz6IVNuEetCuQlqo0EiY/Z8PUS+8+C4AmFRakL3Jf2/yGLuVnG3hS?=
 =?us-ascii?Q?gQQ8qKYLHqOBX524mqde/VH8s1AU1HaxnTNZb5uiUe7LQ0f6ZtMQtkI1/oT5?=
 =?us-ascii?Q?IfqAgiCz3fIrK9Ahtm1qJWQXU/l0CbUSi3L2XCTyWeXKAmKuQN9zMrELTPhc?=
 =?us-ascii?Q?yNVV7pvlLrBzRFHeQ7MWmhc1iy00Vn4F63XWqhPKkB+12NOx8sXBRUexT/5G?=
 =?us-ascii?Q?BRWudvrViN5luLAKA4etbDx/BYIa12eSH7C0dC9j+1aVximT/RHpwZQq4dUg?=
 =?us-ascii?Q?nrPISqm3J/mgxesjyfgq6gMNS3qYMKs9M55OLQgrXdzF+gTAj1HPoAO3KZ/b?=
 =?us-ascii?Q?CSLnkkSQaEMYTmxo+416G8WokD8aSLUaqALYWbE9os9qa9WAugoWkyC9sciO?=
 =?us-ascii?Q?L3fvoI3HMHoXZvMtMSvE3UsCWPUmCjOPGrVNDayzEft12Es/TmoGiG8taq05?=
 =?us-ascii?Q?onDg5X/fp4ZxnCcYKE3wbZVEg67gOUOVA3ES88rAQsScfqfzeui6veHHQC4/?=
 =?us-ascii?Q?jTyIZMHZTrVysmx6+NB6Us4zCYPeJCWb0KPPbvRNdMfOt6bFUGSi9Ax/Arld?=
 =?us-ascii?Q?z1jjXhFBxf0dFzHc3A2llxiy4AQ3XxXFMWBodZhSgx84Q3jLJp0YSJfcyaCZ?=
 =?us-ascii?Q?DCeZ3qH7U0kQ3Wr+7CId4KvTH8t/l4QsTl272z7zh819iB27lZrSEUT7Rnu5?=
 =?us-ascii?Q?clKk+ipvNGXuNhUq6TwtvkbVEo0IYVZRfFLx0oT1Q6OoshkyVjLPbSC2XMxm?=
 =?us-ascii?Q?eQEWmFNQbDUF8TtfPTZhV8rZ/59c6MgoBVlPYCuJc2BYEYpDZlX9QCr9PBiV?=
 =?us-ascii?Q?EXoDxNUBce5pTejmT5PUsOyKbUGOoNSheybfNg06YDl7zuMNL5ToMKcY1gmf?=
 =?us-ascii?Q?NHcF1Vz/Kjya+l1T5wnIfpwK0Uw38MByPOR6Wm84VgDufvbXgBdCnyUgaFsD?=
 =?us-ascii?Q?opgWSv/n3Z/HBL7mQD45etpLvh3h++Q8DJQ1OqtKDI7Ur53wnSOjvxz74zp1?=
 =?us-ascii?Q?44pbH7oTNaTUgjpnVOjHo/uvwGmLBW89XwzGSrLBUbGDJNgc2/CPn633bg0/?=
 =?us-ascii?Q?THlqn/+6e/9bIUIcFEG6qgKtw/6rMEtJS+lbHiRV3AeGhUmXWxWgG2fhbc7d?=
 =?us-ascii?Q?/HeVRnMyAoVNdKT1z8U+c53ftifWa52fMWDfNfJ6Kg8oxVeL8NHGdGYpXpvU?=
 =?us-ascii?Q?PPZCClcZAk/Wg+SapObhiQot4BNeZ9d4u60rX9h0UDqpFD4HiUUEe8w8Ylbd?=
 =?us-ascii?Q?g97xBCnttAWN6mM8k7nKLU9V36UDxdohIRfEsEkb83dT7GCaCIVieMq/XfuJ?=
 =?us-ascii?Q?Uu9NrGXMczdEt8XB5zttsiE8qz5Kwv9ewZEPQ4uea5aFdZxVUIsifbNBLm+e?=
 =?us-ascii?Q?W0edyCFErCv7rut/327nf57xL6CtUhOr8DyqrgIbdsVMlVtQBJLdw4IR4elH?=
 =?us-ascii?Q?eNgN/Wj6YnzLb/lGsN3xMBfkL3u6Dk3+TeQ9v8K4yhukwsT1UNRvO/tfDl4O?=
 =?us-ascii?Q?SYpEgNKp3jBBQBDj+sEAgbisxFPXPEH/2mm53zHgYfZr2g1zgvnmE1Avc7Qz?=
 =?us-ascii?Q?Fw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce813b0-efbd-4d3f-9554-08daab807491
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 12:02:22.9332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jiSa64XsjEyPSptXluVkC/vjSgbSmek9jq7xSLc/rXm1cWgazREyzoQ0B5247F2hBdHrUVaWphzMtVUfoqmng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7557

This patch refactors __mptcp_subflow_push_pending logic from:

For each dfrag:
	While sends succeed:
		Call the scheduler (selects subflow and msk->snd_burst)
		Send the dfrag data with mptcp_subflow_delegate(), break
		Send the dfrag data with mptcp_sendmsg_frag()
		Update dfrag->already_sent, msk->snd_nxt, msk->snd_burst
	Update msk->first_pending

->

While first_pending isn't empty:
	Call the scheduler (selects subflow and msk->snd_burst)
	Send the dfrag data with mptcp_subflow_delegate(), break
	Send the dfrag data with mptcp_sendmsg_frag()
	For each pending dfrag:
		While sends succeed:
			Send the dfrag data with mptcp_sendmsg_frag()
			Update already_sent, snd_nxt, snd_burst
		Update msk->first_pending
		Break if required by msk->snd_burst / etc

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 72 +++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 35 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e3a5936df0fc..676f3bff988b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1609,47 +1609,49 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 	int len, copied = 0;
 
 	info.flags = 0;
-	while ((dfrag = mptcp_send_head(sk))) {
-		info.sent = dfrag->already_sent;
-		info.limit = dfrag->data_len;
-		len = dfrag->data_len - dfrag->already_sent;
-		while (len > 0) {
-			int ret = 0;
-
-			/* check for a different subflow usage only after
-			 * spooling the first chunk of data
-			 */
-			xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
-			if (!xmit_ssk)
-				goto out;
-			if (xmit_ssk != ssk) {
-				subflow = mptcp_subflow_ctx(xmit_ssk);
-				if (mptcp_subflow_has_delegated_action(subflow))
-					goto out;
-				mptcp_subflow_delegate(subflow,
-						       MPTCP_DELEGATE_SEND);
+	while (mptcp_send_head(sk)) {
+		/* check for a different subflow usage only after
+		 * spooling the first chunk of data
+		 */
+		xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
+		if (!xmit_ssk)
+			goto out;
+		if (xmit_ssk != ssk) {
+			subflow = mptcp_subflow_ctx(xmit_ssk);
+			if (mptcp_subflow_has_delegated_action(subflow))
 				goto out;
-			}
+			mptcp_subflow_delegate(subflow,
+					       MPTCP_DELEGATE_SEND);
+			goto out;
+		}
 
-			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-			if (ret <= 0)
-				goto out;
+		while ((dfrag = mptcp_send_head(sk))) {
+			info.sent = dfrag->already_sent;
+			info.limit = dfrag->data_len;
+			len = dfrag->data_len - dfrag->already_sent;
+			while (len > 0) {
+				int ret = 0;
 
-			info.sent += ret;
-			copied += ret;
-			len -= ret;
-			first = false;
+				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+				if (ret <= 0)
+					goto out;
 
-			mptcp_update_post_push(msk, dfrag, ret);
-		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+				info.sent += ret;
+				copied += ret;
+				len -= ret;
+				first = false;
 
-		if (msk->snd_burst <= 0 ||
-		    !sk_stream_memory_free(ssk) ||
-		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
-			goto out;
+				mptcp_update_post_push(msk, dfrag, ret);
+			}
+			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+
+			if (msk->snd_burst <= 0 ||
+			    !sk_stream_memory_free(ssk) ||
+			    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
+				goto out;
+			}
+			mptcp_set_timeout(sk);
 		}
-		mptcp_set_timeout(sk);
 	}
 
 out:
-- 
2.35.3

