Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80083.outbound.protection.outlook.com [40.107.8.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07F37F6
	for <mptcp@lists.linux.dev>; Thu,  6 Oct 2022 12:17:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4ZoFvRdY9/jApwHu7L2qWxDvwh34kNbJ02eFx5zG2Ud/INmYFtREtUYJ3w/Yj/5cF4Ns8I1+Is3yPzp/Se457c04tLP7ml9CGgDe1ci7z+h0kCmXbI9HTgTV4hW9aPkJ4tuguCKHbZtgxVRHO/6b5Z3RQ9wg/Vw6JuFj/c99viHlFeFQO7HEQ3mnZwOZu408BuqWTGkQUT33x/LtbutBOUBCZXhWtEHyitcK5Em3KF3vkYEab3JlRFibd1ALelZg4lcEM60GVFWHO7AdM6gtLzNxGZicyLxXt8ixePNOoDF+3Gs23VDpzdJjO0C60BMZE3/1cMw8PqJh3L0u5KNcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snPSMc/WxxctTtHWzJHq+ZL2ifJ8X4DF5foKJvwRX5w=;
 b=HID6NdmQrDKc6yBcr0O5e6Vi2n3huqkxXWsf32vMCFEYYF7B/siw0oXJGX4lOlmDSkfjWEstEkxBbNIfzrYyxr+2xKHSbtsK3YYC6A/i2RsdDxZBv7HcznEwE9mqlV6DN0uiP30aThConOTg1XvuDdgzcR1SuQ5tsT4zDaroCyZxNozqS2/7e2L6DuBAWrNHJJaq3Cn6DcJ99M9AyDdRsh8e1ljaf6BXUTcsG/yM/atyjNkZoSp4T6/Nv4oVF89ez53N8YTBqoc8B8cyj2hgh4AfU1R8i/4FY2Fi9Ejg8jLACnfgpXllsdqYaa9j33jymUKQT8HP6j+P1xfXWDaSKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snPSMc/WxxctTtHWzJHq+ZL2ifJ8X4DF5foKJvwRX5w=;
 b=Fd6/137CUVoTq1n4VMGzY0GA+IaJ9c02MTfx1Zyru0JPAR3d5F0ckf2Q5o3JMTXiVdl46+6tVLXubWTfpm9RHyvE863an3Qll5CIpc2yAWCFBfU4f9UWi+krgsrClGLicD0J7ArhHpMYew6A5nZLmE95VTjOy7ERgDXfLBp7R8BGR37IHDOxda02FWh8xmmW1NU9aUxKH/rxFANglqConrQaDxcwop4eEKf4dihimTzUmWtTHKrOD/5WdbS3jZc8a5jDCmYqvGw4YMMVv4Udsfr9ShrnK1XoyRK29FzqykLuMZ/Tk015GuPgBeLnsVSrG27hxBHNOr7Dfmjf9oLUxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8276.eurprd04.prod.outlook.com (2603:10a6:20b:3e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Thu, 6 Oct
 2022 12:17:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770%4]) with mapi id 15.20.5676.034; Thu, 6 Oct 2022
 12:17:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 02/11] mptcp: 'first' argument for subflow_push_pending
Date: Thu,  6 Oct 2022 20:17:50 +0800
Message-Id: <1d5861f38dcb25e8fc9f870e4920177585c28da9.1665058388.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665058388.git.geliang.tang@suse.com>
References: <cover.1665058388.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0082.apcprd02.prod.outlook.com
 (2603:1096:4:90::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: d9299c5e-65e6-4dc1-b16c-08daa794cbb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fyU3OoZA/5Y7D1dR7V9leuBbeIK2plS3vgxyzwsU5XwDjr5Khee8xsf/5QFQXcsqhijaOdQg++4hiWKuU7xh6jIDjTtMURW2DLRQ4nsmZDX4AJSfng+AMwgO5bXELeceDxzzOFJEVHJn69HThlEg1ce9+lESLLNLYaLuhtF0UlAOm3Hbsad+h8l8vLvoR9AmTr04uw+oip0lC7NGJI4CT+Tc85JbxZKclIoTeD8OowF25qF6GuQfo9tj5NLIqjnzl5G+s1YILRLdZkZqKWEsM2uE23xQCLLRosRTpToAYk9mUPBH9TtVcpmMfoYRk0yQCGQ/9SVybzopyHpmiuBiRucA6INW5QZ1ZQ56vj2H05po/V776Wh12O4AXOj0YteJjFXLaAH2lpXHgRFKma3qcDtlLAAZ3r8M39ZM2H0mKenYeDQyC9OpJNjvLMjx+79fl9i0aafUj2c9xslVHvvBrgOdXOy376kBdQYvxq7NCekdP55KB3i81QBFoOIkeDu15DCRk8qjnk4+CWQ9AMtCL+P/cByOsg/fJ+/cir3SNUgOqEWDWzU5lIHn8s4wBhna08OUVY6+Ph/haB5kiXNx3QRhL8mflq6ObkoH4Jj4IqG7Bwi2UlC3l9X7WV1oHA0zNgBY2oS3aks3CrRz0fX+gFD5uf3G3gQX5jS6VmzAEKo6AwAvIQg0iF/TIDt4pNRInyVU8WM9T2pXeYVfrimL6TApJtvwB2wblRVyj/BCV7txe4TRELwie7xNn16sVDU6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199015)(6512007)(26005)(6486002)(66899015)(8676002)(4326008)(316002)(2616005)(86362001)(36756003)(38100700002)(107886003)(186003)(83380400001)(6666004)(66476007)(478600001)(6506007)(6916009)(2906002)(44832011)(8936002)(66946007)(66556008)(5660300002)(41300700001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GVxOZcrwvoqLECOw+IO5NMVWhmX0gSuvZ1YMkYUf/IM/WQBd/jCTkVC87DwW?=
 =?us-ascii?Q?OsN4OtNkz7lDm+7meyKhaFiTfwQIWnwHoEU4RxXsjcA871FCwLoyRTgFUE+/?=
 =?us-ascii?Q?g2BTIaRNj3FRzCQ56smuOUyabLnuzFbOCLn8Oz80ERNdJjb0fQdRMxJJc6wC?=
 =?us-ascii?Q?dp+9p0dZYdrhdlHz8t6DjWAsMTDflFyY0DHNrmy8a3Agzbu0VOBr2oYCPD37?=
 =?us-ascii?Q?z9DSImTNDDUopSikRavHZyPfYYQsMAwz11hAIG1CfoysNZLz6dumKyvjkAzj?=
 =?us-ascii?Q?IVLhsEpDGr6LJiNGQyaOKUQ5Bd1o0NzI8trUmTnPaQ3z8tDJs4jcwZX5ZCLQ?=
 =?us-ascii?Q?j32wy0kAvfOEi9B1g1tJS5WlRKRWTUEQPpgeXA+qWab7sZgpL1Gpl//xkMu1?=
 =?us-ascii?Q?Ql3m729XpjvZZ3kVVrd47xkLlLPQ8somcSVdM0JQ9H07qPh+pD/yNGPfy1cA?=
 =?us-ascii?Q?VIFLCPRLNnDMfLO7ApsCQHIB19V1C+aWfakk5M+b+2+Fwzz9nxt/lTll644M?=
 =?us-ascii?Q?MpsJxM/gUcpYw3dmHzuueNZPRWRVz5mBw1LlAglpp446FfjtAtyyxCRUWS7N?=
 =?us-ascii?Q?7E2e/o9clfhxx9Ccd8uhqS4lJtKz3jd6rfP/sGo0YCzSzQujZLsrcCA/jzUJ?=
 =?us-ascii?Q?ldHgjSgmylcCLYMamRcBjazBZu8pu+NBCu1JNjAdSfoDbs9nftkgXp7VDNUC?=
 =?us-ascii?Q?tH/LRwBQtl3NDbfx1ovQc0sj1MURFIubG488LlWTV5YkBIFvxGdeY4nCEePD?=
 =?us-ascii?Q?WpTv/N/NYg2sHL3hEZ2vnEbQbT40cNGf/CVS8zzz0Kr+nvvdfm2POjKtw84T?=
 =?us-ascii?Q?PYjlEKFsjrLzXurXAm3UBBckcUrB9Eq+y9gEH/moRyMR7pMdPiKzKaVeIjRF?=
 =?us-ascii?Q?uohDc9oQa6LWeYFnV4HCQMtBwdcUMigLWk6nY9kTpQYcokQXT9KQDW/7D4+e?=
 =?us-ascii?Q?c6lbxqujeIJzcmF+WgnEXJUuqOMuWovBWhkDKw5p9w9oOCBcW99IuGLlAOPY?=
 =?us-ascii?Q?YQA/R63WCJocJp4zNryQZ7MqyCuk76OS2xV8GGqqN8PO9dVKUDW2/Im1ivfQ?=
 =?us-ascii?Q?sZ/Vc1j63sTwBiIYv8WGf39TSnHunDoH2Jlq54x4/Kkq2wRBLEPabyCjXGmV?=
 =?us-ascii?Q?Igrk5up6oB+YB3d8CyWPyFYYKfXhBzOAxJp/ukAhOeNomqw3A5vpmlfTMS+u?=
 =?us-ascii?Q?ZCmVOF2IGPIfO4SYhfzz2FC9lkIPxGkwwo6xoo8S6cvBqB59dPS+B8JdlvP6?=
 =?us-ascii?Q?bWHl71KQ8e1cbySzWVrLMlhkGe/FsEmMgcaDNeen0Gjy1A6wvTVPMslHNAEc?=
 =?us-ascii?Q?3PfWGiSJXUq/xEZj+V9W9pySTncSz2ZU+tvoLxAeG9X4SYJpVoD4OGgonOlO?=
 =?us-ascii?Q?ENLHomTQ3Fb4I7Gjg3YlGRT4mjsegiJytU+PSfrCsXXLqfkKTYhG6ltAapQp?=
 =?us-ascii?Q?HNnlHTEEEIU/8z5t5bM0uIHqQ+AEd7AnPq/VXnlzDE6+CD2Yiv2QxSXF6Avp?=
 =?us-ascii?Q?LzMMfgMtLR826uXyFXP9SbkDqS55nBHKoMzZf4IXh1liLuDW0Ps4hz7KY1Ow?=
 =?us-ascii?Q?Ln9cCVszbaZQtyAM776Uqtuf9USrXXseN77eoRhCfvoUrMFprHUGVcrTJI2t?=
 =?us-ascii?Q?8w=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9299c5e-65e6-4dc1-b16c-08daa794cbb8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 12:17:54.4036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ws2Pqp+NnFvlbbZ+n28FJd0NskgsRkmrnM3MKP31Txk9i2tue/Oih35JTMSLjHsnrsijL/dJBvpwVwNresQduA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8276

The function mptcp_subflow_process_delegated() uses the input ssk first,
while __mptcp_check_push() invokes the packet scheduler first.

So this patch adds a new argument named first for the function
__mptcp_subflow_push_pending() to deal with these two cases separately.

With this change, the code that invokes the packet scheduler in the
fuction __mptcp_check_push() can be removed, and replaced by invoking
__mptcp_subflow_push_pending() directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d500a00fa778..84d33393d24e 100644
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
@@ -3195,16 +3194,10 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
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
@@ -3295,7 +3288,7 @@ void mptcp_subflow_process_delegated(struct sock *ssk)
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

