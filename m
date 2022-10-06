Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2061.outbound.protection.outlook.com [40.107.104.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D237F6
	for <mptcp@lists.linux.dev>; Thu,  6 Oct 2022 12:18:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HN0wDG684yyDzCzgY58qd5OZG9Jw5gxesszX0ieYmbssRP9j9G57aQd0PCJgdDH/Ye9G5sZp42W2yA9RkfD3SP8zceInxsxAF9F8V1MQ8VqrkDXmqVQfkYTXqsgbLUIuyeRClpIthXDHNbcxQHlvqkBLzXSk23xGNdFFYCuVBhVfnWYnhac4O/nQPyn3qkauiDGt5ASg37l3bwM4h3kCkv0QAr54qV/v8vec2I7kYhvYlICnXN7+etWJnXP9rVvGO2UCRZ/iZfhlj/zwFIjTTBEI1dPov3NKNIS89neFNt/2X5TFoc4/Kgs57GdqNDJI8lKPecf5p/xjvjzfGr3WxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVSFbNahCOk6FQmZ/2cmsaGQVC9uSgZgrZn/E1yunDo=;
 b=ixJSU+3NvncYlrKEJlzT9hxgTYlDRA0ev4kj1OM5J2QDbWwBM05TTnfYSGHgGHsTBUcBd5qxmnn9VHbT1cxxepW9jyyLtX6DfS+UtO19x2qoMloTAEV99B7G43x5FZwDXvPtWJJY4vxUntlahJ2k/wrY2fFWtS4XNfA+5K3pN4CcvqIjEOVzofi0YeKUSPF++1jNHbyZJm1RHTqA5hPpwUsrlab8zdx8fPEDl/RDTXDp0G2Ql5Q4GEuGNFkgICCk2C342OlXqgVvwxAWjZiHTAD+BfOFEwdrjDNhV7wJooM5cUrBzucLprFXwMFKIuPb15HqeloqRBnMpcIkNm0QuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVSFbNahCOk6FQmZ/2cmsaGQVC9uSgZgrZn/E1yunDo=;
 b=Bjnm51mNcJ0edTnubWEO/9BDb/05t+zf7esn+BdX/MJ+ixC3y5l0COVLUI1dvGgcbPPNu7EJIS8fT7WbhpyQ0lF6dm2wighQaEpBg+oNOXytlGErbC4shayRrZZigBBMEOMI6UZ7sYOykHFukvZbAjwuYGGtA+j7in8n4NCIyVPiKPebE6IINoeo9NfOpUQOJNvM2sZ8P4YeEnc9pfuoOg749ejedhodGAqZd5+328KB8Hw/mowqY/svB7gIt+LTd2cn1NotiWpYFnqZX6cMwj4JHGuHctTqVH1ddqXL5sY+zg5JoIR+1/pPRm0usW1bgRxwLR/g+2+ltQTl3ysMwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8450.eurprd04.prod.outlook.com (2603:10a6:20b:346::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Thu, 6 Oct
 2022 12:18:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770%4]) with mapi id 15.20.5676.034; Thu, 6 Oct 2022
 12:18:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 08/11] mptcp: refactor subflow_push_pending logic
Date: Thu,  6 Oct 2022 20:17:56 +0800
Message-Id: <aebd23faf1482cb7f3648eafa4173c5043759f56.1665058389.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665058388.git.geliang.tang@suse.com>
References: <cover.1665058388.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8450:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c4f7196-49ca-4a2d-def7-08daa794e3d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JVJXENgXAEXsWZDsnRJMIYwGcDFIVllsfbg7ZHlQDyz8Qg+hLJ6XJSE7la7zL6FUVNac8S+PZlu4RCaZqI+7x8mpsm40sIDsVTSm5iHvKXVqoE0VMM8oqjJuXZ3FlF8GcC6qHQTXCqvw53iZ7EzVNOF7NiJUOo8LB7ppEfO5I5/btIhQlkVB6/cSLzvhqUg5xWA/oEN208przHiw3rT/ztrtyOm3/CZZzN2ZQhluGhAPV1GrXtb5KyMFe8an1KGsrjS32MwlZUqMEuftz+gwOCl++bx8YjFnKO2KnxlXPtiuLtN/LCYVw08TE+fFv02ka3Z6l7LnrxH9cYeon/YYOLMP0n+iR9Db2IeTQztC2bi++IY++s3rRk/llNagjq64quWwLrd6rCwdvhZhF35cFrBYdn8LeCI2vbrDEWGVz8XRKSFBS+yBCHcQg0vlGstZ/bskozfTKOJCVb+AwGwf7UlF++KA416eG+nPHxrQxxaG9e5quH170KSEITykNZg2borCnZCq9ntNFyYCYQVcPwwYNuuANqhzFPdfbVjIWNWeXmnqikpWaEMrWeeT8w6DdxyC3OoZHSBoO7TySRG8mru770cS2SFj/xntNB/n4ijuUroqLYpx4/s77obDXbuGJpkqg4YnlEuiXFCC/yztFmZ5XTdbZxgUf7ZzrKkZzma1djyoXVcuAas3aEe3xOIUju3btoJJJBOy4nrKyPE3v0wQdDDamb7ZTFgzG0hkHXtR0xLFdevpB3zXuaRzYrMV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199015)(6916009)(41300700001)(316002)(478600001)(6486002)(38100700002)(36756003)(2906002)(8936002)(5660300002)(66946007)(8676002)(66556008)(4326008)(66476007)(44832011)(6512007)(83380400001)(6506007)(26005)(6666004)(2616005)(107886003)(86362001)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jBwyss5arD5viOq0AkKWznr5Kt9FPBkwQWKd7f3idcSU2nVQcna6wFrTgl3I?=
 =?us-ascii?Q?LqJsfcY6OqFq5cDRhF+NKrrBlAEfJRcaGrysFWOGQKhfH6t7HdelTTTeCVN6?=
 =?us-ascii?Q?/uwjwL5baRsGKT1THEqYV+K1uKBHJb0GUN4o80/wbpCcBQEhMFyYVXjN/nDr?=
 =?us-ascii?Q?RLPer1OfGQlda00Y5E2A8H/9e9+eIyNWNchp0CydediVW5FNavy1oDkV9qrO?=
 =?us-ascii?Q?0cMjn8CixEyjAeMwHbaWj66oSh8pu8mMimQQ60hnfXL/08I7eqaSZ8rKex7L?=
 =?us-ascii?Q?MzpEdLfEhK2fm1s/Rqa9DqSM2Hk7xX8RNMPmz8WKM7KWjmPEAy/xgxhL5MgK?=
 =?us-ascii?Q?0WCG/x6+CDhiCWoD51G8u+3aGTJUByEkUzavAJf19a9iN0P7VH0/t2XfgaE9?=
 =?us-ascii?Q?swWjOlW9EmOlH5WqBZFzOCgH/2XVn1jS20HOI3UsQVqDn4dJYbgLmZXOzcWR?=
 =?us-ascii?Q?izaF2OngDw/vXA5EH0kzhyLbTNCVMuToxWGlEGtB1EzWfubJzliuGxt6dDKO?=
 =?us-ascii?Q?fPnKmWcdmcaKz7HcCbTLAeQwwp6+CBaEpf8bQSLHvaG1qN7VJEdCu63DcqL+?=
 =?us-ascii?Q?d9vWtqqgFirUHajTPeyn/opRqu6rLdI/6yTNIp27rWzVyrVmr+e61hvP1erp?=
 =?us-ascii?Q?/1t73C6TQ1ojnO4NDT8JH7zVecBuIN2hvcbf/YgCOQtKIBxsigzFSBxTIOln?=
 =?us-ascii?Q?z6BciTLM9lOgUKuDuLRZfpgjbkhVw8IAQoz0hX13kViH/mVmE9QDBLO3Nfik?=
 =?us-ascii?Q?dnlzxAQArPT00Kw05ewJ2WAH3qFaXCyIZg9yeaGb25twwZys6xfvH14reG2l?=
 =?us-ascii?Q?dwhZIrXlKEa0rAlBFpH7YxrRZsAW/aPkc0rj/F6s4L2Z2ER05BTD2PjHVw9A?=
 =?us-ascii?Q?QqmQ8rzXmKwWb9lhVDh2gCL4V7O0jY9KITywQpGYH7RZ5GiQUuyYS0vV0HeC?=
 =?us-ascii?Q?W5To1z3XS21BgViZwApq1LtPEO23/A80XGSalIkTO9kXIvE5uQLPbZDUpkb2?=
 =?us-ascii?Q?fx5y7oc0rGAHyrZfivr2KNaYLBahY53lIjvjukw+L2VfzqiuPqDTmA59nOpQ?=
 =?us-ascii?Q?40NvIWZrJ0OIXP6e6l5TiKZY/FQoG4F3xkMEejczuCfmtpUYB7FHK2jC6zmO?=
 =?us-ascii?Q?VfWyJMtlQNPFZ4kwrppkWLqcDL9sj+t3/Um8vMz0M51u5Jn4Do9jFPpaD4LR?=
 =?us-ascii?Q?l198d1DPhcjBFyEFIibfdLNZBVHGjeQXR071Rew7RlGmoaLW9Y/7ZSCigSWD?=
 =?us-ascii?Q?tucCuMTz0nD5J4c3K8r1Aaxvl6O5wQuQDDSHxyAHSQpX1APw08r8Jm96sLfx?=
 =?us-ascii?Q?3dBoaq7YZbfDgOX0SvHqzcrZjWcBa/kbFra5ei8G3Ld7CzANgXAZ67JPmRqn?=
 =?us-ascii?Q?Hv1Y2lNyEC/GspvCfEWiZTnAfUMTUcQEX33Flh36ino6vqBIGb8SFbe3n9pF?=
 =?us-ascii?Q?BSVJWDhrIHmmS2+xRR2RwOdesDewRq976Auz1oZXPzVITq+Dj9jz1xYFmHDg?=
 =?us-ascii?Q?ANq+CCpzh067ku/KoAfOVg9144qew5mBTwT14E+N+gUEzC7PPxcUgEfyzbDU?=
 =?us-ascii?Q?Wy7w/Afrn9H8IdwHA0K4/MrfkDozzF8TUVXl8Luc31ba/2AQxcNDQnCbXSux?=
 =?us-ascii?Q?ng=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4f7196-49ca-4a2d-def7-08daa794e3d4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 12:18:34.8692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wTTD+I4GF+nBafhsA+UZcWEcBAn5j4AvgnBgP38GVOm7FYtr4cwWwVRz1fWP6ZGdtLeX9ir9n4Y0U9BYxf/u9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8450

This patch refactors __mptcp_subflow_push_pending logic from:

For each dfrag:
	While sends succeed:
		Call the scheduler (selects subflow and msk->snd_burst)
		Send the dfrag data with mptcp_subflow_delegate(), break
		Send the dfrag data with mptcp_sendmsg_frag()
		Update dfrag->already_sent, msk->snd_nxt, msk->snd_burst
	Update msk->first_pending

to:

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
 net/mptcp/protocol.c | 66 +++++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 32 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b15b97e8cbf7..e2f47e8ca63e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1609,44 +1609,46 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 	int len, copied = 0;
 
 	info.flags = 0;
-	while ((dfrag = mptcp_send_head(sk))) {
-		info.sent = dfrag->already_sent;
-		info.limit = dfrag->data_len;
-		len = dfrag->data_len - dfrag->already_sent;
-		while (len > 0) {
-			int ret = 0;
+	while (mptcp_send_head(sk)) {
+		/* check for a different subflow usage only after
+		 * spooling the first chunk of data
+		 */
+		xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
+		if (!xmit_ssk)
+			goto out;
+		if (xmit_ssk != ssk) {
+			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
+					       MPTCP_DELEGATE_SEND);
+			goto out;
+		}
 
-			/* check for a different subflow usage only after
-			 * spooling the first chunk of data
-			 */
-			xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
-			if (!xmit_ssk)
-				goto out;
-			if (xmit_ssk != ssk) {
-				mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
-						       MPTCP_DELEGATE_SEND);
-				goto out;
-			}
+		while ((dfrag = mptcp_send_head(sk))) {
+			info.sent = dfrag->already_sent;
+			info.limit = dfrag->data_len;
+			len = dfrag->data_len - dfrag->already_sent;
+			while (len > 0) {
+				int ret = 0;
 
-			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-			if (ret <= 0)
-				goto out;
+				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+				if (ret <= 0)
+					goto out;
 
-			info.sent += ret;
-			copied += ret;
-			len -= ret;
-			first = false;
+				info.sent += ret;
+				copied += ret;
+				len -= ret;
+				first = false;
 
-			mptcp_update_post_push(msk, dfrag, ret);
-		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+				mptcp_update_post_push(msk, dfrag, ret);
+			}
+			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 
-		if (msk->snd_burst <= 0 ||
-		    !sk_stream_memory_free(ssk) ||
-		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
-			goto out;
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

