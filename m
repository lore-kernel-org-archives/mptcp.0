Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2083.outbound.protection.outlook.com [40.107.105.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3800C4A24
	for <mptcp@lists.linux.dev>; Tue, 18 Oct 2022 11:43:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZfkpincRfzjDsF8SP6nwREjSGs3E386jNFP3+csf0abtkdgKs/NjrUOITVTauGZpccLhlmb/AK4h5z+yAWWBKMC7aRMjVZuMUwD8trflI7BMTUDazLFIiUIJsiEejcZ/s8OC1lJhNTfjZCn6KAL/rOYQ2iXNchpvdanAbiYoDsI/JVORS0L0z6uv98claUvvZuRMNJ8P8sRBECg81gr9epe4xYb4aMFVXHhnl0/cGaCOFNedMV2mcrlnhSo8yfuOqn0l/jeVg0bltrOepTzuGwmZGKhPSJDVmsBeA/KYCWcFhGP2NmLQzefVc+/ZQ+w4VMQuiA1EoNrIHbbh/4V7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6wlPHT3zTwyc61b5eZvsUdIwWJo1gUFF0IC18iZunk=;
 b=E6VhKKj3Za/pBMTzWuXPbuIF7PHYrVJiGZ+hYBlpST8WMJDfkGkm407jupQrX7bj6Gp8W9byP3KdjDcURItTDTeYzP5IoGuOPbiGxuZSXil4VvRGDLx6TcPMd7l7BmKlT1ylZSNjewQAV2lB9qk//YJIeTdT7bMaMLykoXbDrVA7b+MjdH7YSkCUIY151AwWJCud5x9J9kTMfJGG6s0RCa1Xx9ryItmC8duQh3dDmaaKO4vRDsvg9ur9L+2v7yx7eRPCIVqNHvW7XWQEIOFnFB1+pCVXnBr3kPFHksrCViArfiOGVza60iFdP1qmL5Bu1rsHnFbc+c4kdMaPGcclKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6wlPHT3zTwyc61b5eZvsUdIwWJo1gUFF0IC18iZunk=;
 b=IGmuZulAJXJ/Zujva9Do5bT16out2/NWCNtC8JNMrLfBRRsX6MMuMlXx/RQAIG76ATiZ/2QW4KwVPJW1LYQvnqe6kKcbMLA1Ouwx+J54gTp4n/uS/jWsxCSn4XPTh8KsUC5mvRnrCQxfFTz5h0yCZwDgKKoZMIqe7liwrAuZLk0gTy5DpkwE5jKMN+n/E8hk3s/H0Z+CabZyD+IwhLd+GfkDp8W2NsPwf1R8aejFcRfhPzGmNcC/ugxuVMTzEOQbJEvZb5riMzrJtn6iqKTyofSkUS9KQuKMs/B36y776vaa7/8Oa/gEwVZwVpm3i5sS0J77w/2DzAVFcTnwCD2Ymw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS1PR04MB9237.eurprd04.prod.outlook.com (2603:10a6:20b:4d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 11:43:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.032; Tue, 18 Oct 2022
 11:43:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 1/6] mptcp: use get_send wrapper
Date: Tue, 18 Oct 2022 19:43:13 +0800
Message-Id: <20221018114318.23627-2-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221018114318.23627-1-geliang.tang@suse.com>
References: <20221018114318.23627-1-geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:404:56::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS1PR04MB9237:EE_
X-MS-Office365-Filtering-Correlation-Id: c6a96879-c44c-4761-6321-08dab0fdfd3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YpN8ccxN522A1zzEpKT9XNuv71PEbAG98vjsFizj80OVWPJrPHAaiGL2Qj02qHrjmFaTXpd4laINN08fXkir5AuIACzZNQDj6d+F0gLxfG/49R8lkXTjiyeG6zPdmF3IXL1c6+sgLTkJI/ZsmgpelBK9dhjDf37A5pNHeJGijmstRjufGcBhXM8msLbZW1XXKRvI4nP0R16Pg/jvNMzSg6OLyLiKyfeLg+/xz2/cijE9iDgjJIjav28Z+yR1BjKVaM5WV3TotesqsI2j2kobC95clpqp5dTF6sL90LWdNJPH4W/8boOKgnLC/vxuRXoYfiUOBCmkC/tbpKHSMcM2DBVc2n/jM1sNVO63k5uWnYbWhmYZ7UGEqpB1AkjcctPEGXoyELDvn5IktWVAzuNg/HrS57R5O5exdTHvfHDQQghFub/2xLArJHSy4YqbPoXWGeNB/et6qw+YDeS6GRgIWP+jnRtyxe74MMWIUczXmKy/pPNNsxlKnOGqqTtvHTLnymAzoERSnCcmHSHTKr5X1+hUA9LZYQ6otiv2iQCOeDR+nUvboFyCPGvQB8aricucCmcDkgf3lCn6XibsA7xgcbOukDFKNKsBkWdFVvvcS499xv+Df9BPtuN7C6B+5wyz48yzy02ZRITVdb3ssd1AVAlGNV4nXsq5IbvIemfyeEF3IR4as2xTwgnfkNqlpsfsYgWacriID/inlp9FEO38eYbiaqP0Q49QO8IZizkXNqm2WYOGql2fiAVzjJ1G2g1S
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199015)(8936002)(5660300002)(44832011)(66476007)(4326008)(66946007)(38100700002)(8676002)(41300700001)(66556008)(86362001)(36756003)(186003)(2906002)(2616005)(1076003)(6666004)(478600001)(26005)(6512007)(107886003)(6506007)(6486002)(83380400001)(316002)(6916009)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zszwg3eM1mT/OLsHkqIBygxn2s4IvzdW30O68OcgK010HNRJvz+iTD5+S0qA?=
 =?us-ascii?Q?JUEjRBnPo5VPBR78z9WoqwUgpnkqWfkMmLOGtdqSFGAgw2b6Gp3AI1/6+TU4?=
 =?us-ascii?Q?JW9w/D2e/CcvmfE679p2Qmr+5A6arxG4v4T83ZKDik2AhX770T+BgVwJHzsA?=
 =?us-ascii?Q?+AFkFqgaIh1tj6nb5nBmRxQU4DUAw9d7RebFj5ChKT56//rVNJXErOXBeRUt?=
 =?us-ascii?Q?DUio3b0IGITOj9zonhHiz8Ifgd/IrRPxbzP32tBhnuF/VQ5AzbDAp3VOb8FP?=
 =?us-ascii?Q?15CitQ09mWhRvJapm8n0GL8S5C0cy3+bOnn1dBhrl98JV+lv3++w0lNmlBEF?=
 =?us-ascii?Q?FDl/eJu+O++NqF41Op/7ACuHZtxMb6h5GujzQO1cTnmYs/4REoHsTiOFim8P?=
 =?us-ascii?Q?vANI24O4mf1riX3YplpEXWM32f1iJNFwP7vwMzkAKrMR6P4KhpeFQKaLzcdj?=
 =?us-ascii?Q?HXAUiFXcs7XdLU2AmsI90Qjv2JAqzme7yHUBhLu8oW5KnSX/Awh8GorUDlJs?=
 =?us-ascii?Q?GQCGIbCADNl5expAeEN8tBV/avQx1wAgZT6wS+K+ZtqDopzwrhLTt/uu6Ryj?=
 =?us-ascii?Q?YbJB3HGew+x4pXRvZeGNaYIr1T4bBqvLdiUfbxH1g+JvkrQuEF8siqRYs8MU?=
 =?us-ascii?Q?dFAO+W7OOkTMe+GTd/k6QFm93Zj9K0+n/wcDUqTfbhPGD8MJD4qMg8e5lN8R?=
 =?us-ascii?Q?Iwy38PA5WMR5RicXfZXdjlw96d/iI2lFJQCnFtXFSMD76y0dzEke5N0xLrgY?=
 =?us-ascii?Q?/mBicDcR9qrsprL3S1EqNOb8cPSkUwOPrWn19YOzddxq3b9bQ4UBEUcQoNUz?=
 =?us-ascii?Q?Hq6CJbf0Xj4+NIxktaV/6fkurLUQ2dIxU9YkwhbbDLE6HtaBwW4FTI8HqU8d?=
 =?us-ascii?Q?VPnwOEpnOL5+FBUtnkjnIMhXjOfZpIc5QooBJf6tvKdYg9HAfhWYKWRIPW3Q?=
 =?us-ascii?Q?dJYwDvTtaelkdA6bMwO6RwIEtd8AkeitGmQOwYz36oJlALQQLZ/JvTNtNpXS?=
 =?us-ascii?Q?Jvb5t2xSETcBn4pViDZV8TnMHaPo8MY/nE6Mg1vu+hnHlKF2o+nt9XAlgvxe?=
 =?us-ascii?Q?dRJL85ZR+z7ChUAQ2lUKgWemoQoBK/gLe29t3f73sv6QtE11Mv2IU2T/ueRJ?=
 =?us-ascii?Q?6EPUQgIWffn7NZXen6Iwt7u57pOq3E7YvUdYWoabP6AOOel1agffYl6aADOt?=
 =?us-ascii?Q?CvK3DT1AhpgFIxlnogKDYXQ7BqxTBEzUXfEEs73srdSUc9s4oZvf14HOqkIw?=
 =?us-ascii?Q?JJYVLmQwalTiF+Z/Yp6QOOGBCLFXX1LPKBCvxpG3T9miQko+JPfT3fiUajfI?=
 =?us-ascii?Q?GScpizSVvIeU0ZoD5QswzWGIHksR0x1FCqb+4O+K8ugNAoCzLVvtkJAJko6o?=
 =?us-ascii?Q?KbheaImNqM1NbZDB+5VmwDekFtQnIO2mAFf/wldSTKzz1Ug/V30UCtTBLmx2?=
 =?us-ascii?Q?rlcLG3iBni9giqBhKNoFPKCVsq6V7w4Y1C1D98gYJw5nO96Og266WrmFjvH/?=
 =?us-ascii?Q?JaunhkZBermdjhwcrxtI8/VUMqQdaBIw9/jshGyY1bFJOXPm+eAwcW26u+eX?=
 =?us-ascii?Q?4HSo6OFqQ9vVRdVXw6BumGGMxtlE036uxTjXp9JotlM8wsgLQ7IbR9LfUVGF?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a96879-c44c-4761-6321-08dab0fdfd3e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 11:43:35.3284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWNC+xyzFyOsQ1Cabi3Q6SGQ2zb2MYXZaVI1xnUDaFuR+o7yvZJaGNASDF05EqFou56nzqCdp0HovI9FwrkOJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9237

This patch adds the multiple subflows support for __mptcp_push_pending()
and __mptcp_subflow_push_pending(). Use mptcp_sched_get_send() wrapper
instead of mptcp_subflow_get_send() in them.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 78 +++++++++++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 26 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9b73297f6543..e3def2cd5660 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1564,22 +1564,30 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct mptcp_sendmsg_info info = {
-				.flags = flags,
-	};
-	struct sock *ssk;
 	int ret = 0;
 
 again:
-	while (mptcp_send_head(sk) && (ssk = mptcp_subflow_get_send(msk))) {
-		lock_sock(ssk);
-		ret = __subflow_push_pending(sk, ssk, &info);
-		release_sock(ssk);
+	while (mptcp_send_head(sk) && !mptcp_sched_get_send(msk)) {
+		struct mptcp_subflow_context *subflow;
+		struct mptcp_sendmsg_info info = {
+			.flags = flags,
+		};
 
-		if (ret <= 0) {
-			if (ret == -EAGAIN)
-				goto again;
-			goto out;
+		mptcp_for_each_subflow(msk, subflow) {
+			if (READ_ONCE(subflow->scheduled)) {
+				struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+				lock_sock(ssk);
+				ret = __subflow_push_pending(sk, ssk, &info);
+				release_sock(ssk);
+
+				if (ret <= 0) {
+					if (ret == -EAGAIN)
+						goto again;
+					goto out;
+				}
+				mptcp_subflow_set_scheduled(subflow, false);
+			}
 		}
 	}
 
@@ -1593,11 +1601,11 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 
 static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool first)
 {
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_sendmsg_info info = {
 		.data_lock_held = true,
 	};
-	struct sock *xmit_ssk;
 	int ret = 0;
 
 	info.flags = 0;
@@ -1606,21 +1614,39 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 		/* check for a different subflow usage only after
 		 * spooling the first chunk of data
 		 */
-		xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
-		if (!xmit_ssk)
-			goto out;
-		if (xmit_ssk != ssk) {
-			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
-					       MPTCP_DELEGATE_SEND);
-			goto out;
+		if (first) {
+			ret = __subflow_push_pending(sk, ssk, &info);
+			first = false;
+			if (ret <= 0) {
+				if (ret == -EAGAIN)
+					goto again;
+				break;
+			}
+			continue;
 		}
 
-		ret = __subflow_push_pending(sk, ssk, &info);
-		first = false;
-		if (ret <= 0) {
-			if (ret == -EAGAIN)
-				goto again;
-			break;
+		if (mptcp_sched_get_send(msk))
+			goto out;
+
+		mptcp_for_each_subflow(msk, subflow) {
+			if (READ_ONCE(subflow->scheduled)) {
+				struct sock *xmit_ssk = mptcp_subflow_tcp_sock(subflow);
+
+				if (xmit_ssk != ssk) {
+					mptcp_subflow_delegate(subflow,
+							       MPTCP_DELEGATE_SEND);
+					mptcp_subflow_set_scheduled(subflow, false);
+					goto out;
+				}
+
+				ret = __subflow_push_pending(sk, ssk, &info);
+				if (ret <= 0) {
+					if (ret == -EAGAIN)
+						goto again;
+					goto out;
+				}
+				mptcp_subflow_set_scheduled(subflow, false);
+			}
 		}
 	}
 
-- 
2.35.3

