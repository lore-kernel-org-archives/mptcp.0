Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70059.outbound.protection.outlook.com [40.107.7.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111AA4A03
	for <mptcp@lists.linux.dev>; Fri, 30 Sep 2022 14:17:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jb5GP7u/XeNQMiowYyanrdepE1aL4Fjf34TDiALw8BqO+rTG8PbhUYJoXluJnOn3EQLOY7Q6Sf8wE6cTj8YeIGdTYHkFrb5Zm2I3cx5R1VgxqD1XYI67UfyX8sSVNrt0uhd3iVFnPskRteEaLsrtDMUQvJ1cIguBWYDhaDOh3mNlQvDisjkddKnmVBju0B23bbPUgNoV/Y4K0h1S6iKL2i77qieUyJDJw5abZMFR/jeeDCjZgRyYETnm914sIyqNzeEHW4s13aWVs+br2Y4EnzpBck2siiDaj1Dler7PlftLXaeFnvokVWwDh3HOKToaE0u/RkB+GetadB5m4rBgZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqOij31a+8TfhX60DuFQx3qyfM9oUlreGvOr8mwF3dw=;
 b=nFLLjV3ochtPp2XVIPCJgzxXReD9F06hqEdqYLY/sMsxkXlYx4pBhP2X9c7npd0NKMOCm2WXsEoIDAJevTB1lAR243CPmZs1czzh/rOqp0/K4sDlQKEeGZPT3TZ6Mq4pcpHDkklQZNCPjTTi7ory8GLbe2TNTSHqeS5meaQmbdUfIBNpieRr8R5CSq8m2BhffW1ts0ZCbT//cNxZmMKfkJ5vsKcYgVJXpx1AUb/mw4RXsNOl2JezC2y0NnEOtTAmCnvH1kly2WnEpbmZck4+6TbOWb3B0msxt+oQN1r881Z+LAvdvbhC+XG4340vUHrJbijS6etA9QVC4EESNUcR7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqOij31a+8TfhX60DuFQx3qyfM9oUlreGvOr8mwF3dw=;
 b=WpYqfP7C66NiAIJR9/6Dz1hboDxet4p06TwV1rckwKfkg0p2nHjxinurP/HCepIIl709Ce86gl+mP6OtKn0QdioqEwvCTQfR1Vdc1bcrL4SWMu1Jsiha5yVAOn8jpDgcrWL7SVvO9mPUgRL6xiejNqYvoBZ6Mr8ICDSuatiGSrU6sl/JxDcmZYis7t/xjDF6yoyXVx9XyBWOjlgsVAAzFINMK3K3QCzAXiCBMinoVhafzHEYZ6iKT+Q94zZK2LG0FvCzJo2bQsCEYgifJ5AJ5Wr2+YoYDXaxLPhaEjQYDXnYhSSG4DybKsD7caM6iBTN0cP6zHA+FGu89wCr3faMQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7882.eurprd04.prod.outlook.com (2603:10a6:10:1e7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Fri, 30 Sep
 2022 14:17:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5676.020; Fri, 30 Sep 2022
 14:17:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 4/5] mptcp: update __mptcp_subflow_push_pending
Date: Fri, 30 Sep 2022 22:17:34 +0800
Message-Id: <37356025b64f3a1efc6e2726a51840c4fb80a177.1664547250.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1664547250.git.geliang.tang@suse.com>
References: <cover.1664547250.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7882:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ce421ec-763b-45bf-e83f-08daa2ee7db5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nbBm/f8AwQbdGdhiBCmC28I/ZnzsUQ5MTYbG2kiXGIFk2J5i4B4KzJruHK/SOLjrvOsu+DiUeEFfqpvQCr9/ZAsbBmv0NjDnCccgwCNNW185TLb54qgp/0VMqWnUkU9TlvL/4+OWwCajNF32LjQHT+Ab/qnmPbNX7HEch36w8lXQB+N3nQXYzDDWqL7IjI+Yda7C6MTZVxEnNomSlXOQmF0DNWt/vk7br7osbFBWBr231R759BZtPyQeKspZBJLl3LSzg8+VO+CHCYLqsIRqF8B65Rt+GtnJ2O/roYopvbWHmAuglTZ/VAHst2K6ZQ92nqvoqxMJhqkDxXldRsROX1Bbbin2yqpSkBMRmHFCfXHZMKOE2BkluZhbaJ5Q1j6BFyziasvfv95UBidFOhOeKFTpY82bcx8lNAIE/6J3K/iULMaYLaSzIK4820Yqi0wlP9FYqQPynbj07Fnwj68dlKeyUZbQmvSPZUU8IWSLtvcuve5TLMOBdG+rRQ1kk1dKjUp2sj4cFciA81PnSrQJwiu9ovJ+Vnff1YW9yOFh3ygBI5I4j/+5BdlErJ/GpUxqqtTyg6+PxuhQgoJnPhiZqQwIdWqy8mNdPtnmsg71jsQ3mc1XPb9QvgPA8jkfUrDpJz26fKxrrCUC1U+UBkWsMUMV2au54m1URI+UqDVTvwR+8YZjB9hTro2i3S5S6oCqQ2QycK1I/fXyJGIzdDk67HR1rhxSVHaZCZmxoSO9eip3mX2GMIELRJQfwSJ5aYml
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199015)(478600001)(6486002)(66556008)(4326008)(186003)(2616005)(316002)(66946007)(8676002)(5660300002)(2906002)(26005)(6916009)(6506007)(6512007)(6666004)(107886003)(36756003)(8936002)(83380400001)(44832011)(41300700001)(66476007)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rmcGIeb0iMvtR7AlDu4NgT4YXbHQjTrIommnNDlq9EZAceTN3iQtSokVnKig?=
 =?us-ascii?Q?ziVNd4YjW0XkvleoO2DAKvOS1bVYUSKSG30zvisu+Wl5CNvg6KRW/S6p+4bX?=
 =?us-ascii?Q?nzf5+3M1ZyriGzZOnYJf7fpxNuy3C/aA1YC0r7JxAA/iAJQA2d44ng+EXIWL?=
 =?us-ascii?Q?hOgVH5H9VTtbijkNTFzvbpXLALaS11c+eK/i6bp9Zr7A1/qoVYeQBZ7W1pP6?=
 =?us-ascii?Q?oAE5qkTKso42pRTulf+cVogfap0BH1Vr2cz5kO1OBTrNx/k+WjwJiDXU6BrT?=
 =?us-ascii?Q?bQK+zvzH9cIEW57/eJBSgt+3PODY/wzWXmlsbQzJ8bDzKfZp4+kLrViPn1AM?=
 =?us-ascii?Q?QNsshbm11gMIkzTxE/GCBZ6CPY6H9G87H2v7qxOiinhzENM9FlHm9ITTD+je?=
 =?us-ascii?Q?TU57344tYs2ygfG+OKfQ0PDWeKx/PL7OZlr1NEh7DcR/KjooPLXodO0Kix28?=
 =?us-ascii?Q?6n5/WEqLP9Ty5VwCM1+GOlCv+9ty+2lXC1SodcKaHJiKpm8VP2WvxlB66xEm?=
 =?us-ascii?Q?UZXyVnwLZXABlwJhznz3L+7V97pUMKDKGUINN0B40+TZjabcqq8WPXdzmnnr?=
 =?us-ascii?Q?3VWf3C/abnHXJnw5TGEsx1iC7x3IzSAlCIMPD3OGCirKwDDvIJ34ir5VAXyR?=
 =?us-ascii?Q?MO5Xs/EX9kAUsXAx/PvI2vZD+coHcPBwWRz65XYfX/RwjSvRQPI01xs4rpNR?=
 =?us-ascii?Q?ZqQT6K7SVPFu88iXd0Ez3y9wETcLIB0/c9e8vtLmCBpWJckmkkG7ocyzMKjm?=
 =?us-ascii?Q?c+p8BqAqdXL+tT2YDJwYAaWejr0psaaZIMwF0BEgdY8yA7Sz3q1Z5kv80XTW?=
 =?us-ascii?Q?vvsk/pNPfjGTfehyuv6j9ibKr4dOpNyYSZzaO4hHhvbxofPAo1Fy6lV9IFjc?=
 =?us-ascii?Q?P8Ql9X50C4EzjxV2+g1Z8m2OOHiqPtALMTXJ6aV6Cu2S+5gDqL/FIOfv4uOx?=
 =?us-ascii?Q?wYcP977EFYT/6v4VAi9pUIDCPpuAsbJwBCcGX7FbcawK8+SiSdKjPMrgUZ2U?=
 =?us-ascii?Q?uK7pRwccXPJaO/pwPY6LhSbIx+YNZgywDTobkjstzYexPiKrnYvmofT8J45d?=
 =?us-ascii?Q?4A4uqG34dExiEoLcQFrs2gLEEHVE8z25Rw+3gDyixqRskYMFl9VoIy+CHoNu?=
 =?us-ascii?Q?H+AF5eWZdZ7Uhs37QnDsFkEApQf30XfEExtBDUkDvATZ8sR07osdaD+gK7eE?=
 =?us-ascii?Q?xm9WhMUx1tMe5GBzvw88yT3YKXA0OvxOFTtDgCVw2chHu9aKBCul2YV4Mc3U?=
 =?us-ascii?Q?JXydrrkyJjHKIGIAYPCaRbKRHGlvf2J4lzAqIgAipJwLdSmzA7NSb+X/recr?=
 =?us-ascii?Q?cdNOr/Gglzc0kPXnsD5I/+h15s9hDSb8iZYdTW6vOhEOi8DgNRa7Hnsjr1YD?=
 =?us-ascii?Q?8xhTdfJQSh00iWLuIzrupFcdJQ/8Nh8vKDIOf4U2hmD/f4iLlAkbrANnTng5?=
 =?us-ascii?Q?g0122BiS+62zePHz9tA2OgJLbTo0GslEY982OQcZxOR6TVJ+CHd6vzHopU2f?=
 =?us-ascii?Q?WZcgoe4/nF6K9F4crJeNq75wa7TYknUSIAQXy89W0Gbi8F8TBEzCy3b3joGF?=
 =?us-ascii?Q?ZRRTgNYW623v4CWUo32JRc3aD9hIMn2CezX04HNU?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce421ec-763b-45bf-e83f-08daa2ee7db5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 14:17:22.4304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vENPuqU6kJ9bcLp7EiofqjIaVCTwBTNdjITguK3hh4agkMEj8JeWb2AlSux27Jf0hN3D889zPAv61l1XLO8FAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7882

Move the packet scheduler out of the dfrags loop, invoke it only once in
__mptcp_subflow_push_pending().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 44 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index dc5e03a616b3..8e67c149bbab 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1589,7 +1589,15 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 	struct mptcp_data_frag *dfrag;
 	struct sock *xmit_ssk;
 	int len, copied = 0;
-	bool first = true;
+
+	xmit_ssk = mptcp_sched_get_send(msk);
+	if (!xmit_ssk)
+		goto out;
+	if (xmit_ssk != ssk) {
+		mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
+				       MPTCP_DELEGATE_SEND);
+		goto out;
+	}
 
 	info.flags = 0;
 	while ((dfrag = mptcp_send_head(sk))) {
@@ -1599,19 +1607,6 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 		while (len > 0) {
 			int ret = 0;
 
-			/* the caller already invoked the packet scheduler,
-			 * check for a different subflow usage only after
-			 * spooling the first chunk of data
-			 */
-			xmit_ssk = first ? ssk : mptcp_sched_get_send(msk);
-			if (!xmit_ssk)
-				goto out;
-			if (xmit_ssk != ssk) {
-				mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
-						       MPTCP_DELEGATE_SEND);
-				goto out;
-			}
-
 			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
 			if (ret <= 0)
 				goto out;
@@ -1619,11 +1614,18 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 			info.sent += ret;
 			copied += ret;
 			len -= ret;
-			first = false;
 
 			mptcp_update_post_push(msk, dfrag, ret);
 		}
 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+
+		if (msk->snd_burst > 0 &&
+		    sk_stream_memory_free(ssk) &&
+		    mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
+			mptcp_set_timeout(sk);
+		} else {
+			break;
+		}
 	}
 
 out:
@@ -3182,16 +3184,10 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 	if (!mptcp_send_head(sk))
 		return;
 
-	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk = mptcp_sched_get_send(mptcp_sk(sk));
-
-		if (xmit_ssk == ssk)
-			__mptcp_subflow_push_pending(sk, ssk);
-		else if (xmit_ssk)
-			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk), MPTCP_DELEGATE_SEND);
-	} else {
+	if (!sock_owned_by_user(sk))
+		__mptcp_subflow_push_pending(sk, ssk);
+	else
 		__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
-	}
 }
 
 #define MPTCP_FLAGS_PROCESS_CTX_NEED (BIT(MPTCP_PUSH_PENDING) | \
-- 
2.35.3

