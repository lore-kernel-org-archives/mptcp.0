Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130082.outbound.protection.outlook.com [40.107.13.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65D13207
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 12:01:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxUGPHkmZ9N5IpnaAxuey0XI+U+Qx2QKK5Mwf+PzRj3f4+Aqroq1wiw2NVaiLKPNH/0OR7fskGS1IovMZ/IQqLKc08ruyaukXTsyr/uhSN39DHX+i3ABuvX1a7KmDR9WVaBtc1tzjqSdE6WIJktK12QABUqDv0gU2ov3rQtFmlJzEX37GQkc0N79AApxBy8UIJ3kuHlG7BCoCaYm9HTqFpVQ9/PuTl0JDGMgiROUCgZEstwHT6E8nqWc068cpExvKy0ZkhZWcH3++3dPZwYEhdpaRyaBCXuE7bidAQVV8kLYYTBtakJg7BFNHXShk6KkXjw2itzoPXWjMw2cvNvowQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=womHxEQqr+muOUDWWuHI57fTytEHfNTMM41UpogoXiQ=;
 b=EG/9A3DztaRw3Viqu56QONrSZVKbIXtQR4SqSNVv+roffoMgvwGckWKPSA1rKvtdQt0Xytg+tCQB3aKyYSexGue7dLUgWhWq304/zxy+YluP3/B6M2Aj95hsAC3Ov0a4lbHr0VhGZiO6VjDYMLQvpYCmdb74rMY1Mdcj6U9wEdVZ8LaYtcO8iZ7FGJEK7GtFIqe244dpzYL+touKHkcP9ceYTiSmCgPPGf/dGhGM24U6ThlDzypFo9u2HG1OqUEMdYO6nLGysf8UKIzg0E1sDwSLzcche1QXyo8hv6F4pmoFErjrIGu1ooVQTD/4SABAnfkXedoGqsl++qP8vmI3Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=womHxEQqr+muOUDWWuHI57fTytEHfNTMM41UpogoXiQ=;
 b=OzE6vGZXi8V7d+PELmUv+ID5nWyBMrZDqfdS+ZipSvHbnhAjqFyv67tLtbWzPsXOPMlsZxGeeh9m3fytQPk820FDZqq6HFGnG5FjtP0HfmkDQj75/sOD/PSOys3JAUH/LI+LlxkGtF2m33uWwvpWDm2c5O4uOiFyN704evDVC5t7lVdCgZXmfEaIdQB2rL7W55CJt3ttOtfg6WCjFRMZN49DJr2ekzbhIkwO05F6wwY2s6Kv2iCp4jC78cMGOWdKQLC4yzGsOdGgU2Ztn046nehlVAp8pa3cokoUKahLCeZFva/zwQiPYRxgTBI+KzBJJO5H3UKiLB9Ynh9iL9kmRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7557.eurprd04.prod.outlook.com (2603:10a6:20b:294::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.38; Tue, 11 Oct
 2022 12:01:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 12:01:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 05/13] mptcp: simplify push_pending
Date: Tue, 11 Oct 2022 20:01:29 +0800
Message-Id: <20221011120137.5475-6-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221011120137.5475-1-geliang.tang@suse.com>
References: <20221011120137.5475-1-geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYXPR01CA0045.jpnprd01.prod.outlook.com
 (2603:1096:403:a::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b49bd18-e9c5-4ec7-25c7-08daab805f2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vU2GgDOroYRT4P9sK4kzy4s3TYHJwXOk9gS49dykMft2TBlyYWidivVK8/eTNuwfyFOd4EWBSfMXFB1aQ9koBVHIKZdpcZtLnOv6rNt/XWi61ebbQBQo8SVh6d6cv3lQKeK/h9+KCv+pp0z57HzdHLDrRZLXGSb83+Mc+SmtDdq5vVqo8zJLn4KpGI9sL8cWZwdiCa6WPusl5FFHW6b+a7P/bgQQJW6145/6Jc/S1Z2K8v9/ql12L0xPVLWcdHbwm3+FUzCAoRn+ToZMX+sRmNK5TdKvJMIKM2IqOJl/NOhg1L5sWxRpUSFwCJhEsqjvTf4quBqSWk7gb+BXKd1e1TZM3wZiNDcgZpSkN7s7R0aYHdcqqojjNMNJFsdvaVq/qATr1/C2LdrBU4E+dEd2/GnQ9R2j95ZF52p6tBcPIZgwlmddAAQz4QPII7wgKlDOIP3yiMeFNp/ZuW2mvU/u9G0xS5lax72pRJxZvFGp1HlUMpg9MjHbbMlprrbBX5QL5weUffekFF0pPVdczb66l46WQ1CDcEf3jYpMJknMStTF2IAdEUvmqFJk1VRnnywI0krLKGhUPZNxBzF2/EaDVfCtHn1ad0eyM3hgbDN9VixInmxOeAWK1ZjzDK4qY8oQGgHgEsJ1zzVl3yOCnQF4KVNMWXYVAMqCODBkYCRRR5yZ23D0vvlmAawOcwNey07Xs7KhSz8QJs6bWNDhcQF34PKcMnmkCittciGuOPZObkqfSYxdMRWSkCibc3ZO2322
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199015)(83380400001)(44832011)(5660300002)(8936002)(316002)(41300700001)(66946007)(66476007)(8676002)(66556008)(6916009)(4326008)(36756003)(2906002)(107886003)(1076003)(6506007)(6486002)(86362001)(2616005)(478600001)(38100700002)(6666004)(26005)(186003)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sKmvQ/x2YuZz+6FnCvrodCW7jeIwecyTJsqoo1YMidDF6VsQypFuFLDG252z?=
 =?us-ascii?Q?BpQ7NcBZY3Q1WKmDtftDn4LGj34gbtngHdprUXKmMiCOqIU3/r2Y8gvUt/f1?=
 =?us-ascii?Q?/7mGfdGd1PHkWIfroyb/r8QC3d5EkgCMLVOr9NEiC89CQlyR9P16cwIXpeSe?=
 =?us-ascii?Q?Fn31G2TeGxzN8j1hfrivmAoHOTLS3Mz901Q28yNdJUvSzTe+4LkXwCRaU3GU?=
 =?us-ascii?Q?B2WOe0EYx1nRxB1IKvWQ+o9utAbQzZgEJtOEAVyhQ7ZMSlOx7iarftr6LuWt?=
 =?us-ascii?Q?axPsLx/o0IpUv0/BCfuSlL+Y+eFZ5kvHtNfmWxrkqKytPydnfQMEGwQsQbLY?=
 =?us-ascii?Q?2abbsePojshmozhL18qg7RbJbiDLJDzlHmMUr59MhCdTCvsR9vbx0ciIOzcH?=
 =?us-ascii?Q?M+x+38FLZW2djJlp7K8aZkKqFxfSyZmkB5nvomBqgjqV760Mz3nYGjro3aib?=
 =?us-ascii?Q?dDasu5+Utf9EOLtp2MbQF9mkt8Squ5+uw5QEl/jtA9/Ut/PlPJIZwBlbCYSm?=
 =?us-ascii?Q?glApObabRres0Tj+xO4phvr5qCE1A5+k5CY0nlqRuS3qb+woJEgR2KZ6ohPv?=
 =?us-ascii?Q?/SVXkxzuQ4keK2jhMI/wDEnhlILw4h9kVJjkj/0HybOr5J/QfEQIvsxahwdc?=
 =?us-ascii?Q?t+JGEyOeH/fsuMU4tD3e2foaycg+u4ZKAUFSOjWF7P4gJx+rW0L0xpk9m63A?=
 =?us-ascii?Q?LUeOQXDT/Iel2WwsSQ6TWDHZkY4QJyJSNUj5KWDU/wBhA6Ouy1HS3be+YBC7?=
 =?us-ascii?Q?dRFs5ffLOpvaZFRjToOZF3ZY1jNjmsgLn805D3BYtWAV69GuX+1XFgdZJhC+?=
 =?us-ascii?Q?d7w23OZrU8t4PMHd9t32ze9mc4CbIuaYSV86xG54WkqJMmbIV3zxRxlbcvNR?=
 =?us-ascii?Q?sy0k0UyvwQ8qu7FRzc3Ger4Mw5cNRahBE8IzIYDiZtZ7HgxJ1BLQbwJKBQqD?=
 =?us-ascii?Q?QIZgnWMjLqAaigjC/2gl60ie56gSoS7mXa4R/5oOGSYX6/sRJiMnG0p73Vgl?=
 =?us-ascii?Q?puw6+A1UxHG1pjdA1yFRdw9N2l6nnUe2TSrDOBjpCb4Ts6Z9rHbc/AJNFmgE?=
 =?us-ascii?Q?dJlPW1jZdVDW5CTUPBL+cmFfAALSFw218UZ78MXvRhuHcLf36Kg2FBJAnlCi?=
 =?us-ascii?Q?a+AFClh/SGOBA7WFEoIoU3bsMZBiojf33QKP2a16BQDW6gpBRiDQ81daKJs8?=
 =?us-ascii?Q?qY/zD2z7DslBowRmKoqrQu7C1mByLJt15QovjlR81hoqnjbwDKuNLVwRHfvV?=
 =?us-ascii?Q?o5NkPVwBrNGJmAEP+cfUnJOiqZy3ZuhDJsF2BUx8O44p70mae08kwAB1Fg4R?=
 =?us-ascii?Q?F3Z52NVYTCtcdgFe6T7glNLTgBEtKSKnuwtM7Aur/WrCReeNFp+QuR0gT19M?=
 =?us-ascii?Q?+21KbRrRITOR1ufKc3lx1uAxeTktWTwex4r+Kor0GpHKlKj2SFT+M0T6cPzU?=
 =?us-ascii?Q?ZqEWWtZZK08GEUSm6VUfSRnVmraADq4031+TY453aMXNEqguH3SITv7M8efX?=
 =?us-ascii?Q?XA9tmE05O2vGZADmVDW4DQ/HywdhHZ0DbB5ROycdGxzwEXE/QYP4/Imf1o9S?=
 =?us-ascii?Q?aQJdj1LZlQIe6zVXoYtMMLlFdj6YqGDaAC6tEdRUryLOachagSGNePYq2i3U?=
 =?us-ascii?Q?5A=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b49bd18-e9c5-4ec7-25c7-08daab805f2b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 12:01:46.8891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+k6trMV5HJmpaKOCo3B3LTw5HPBesrpSPdrHOy/C7zPLSU5jjnZCX7ri2gMAQXfh8/M/e7lNdACJyWPetHoYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7557

This patch moves the duplicate code from __mptcp_push_pending() and
__mptcp_subflow_push_pending() into a new helper function, named
__subflow_push_pending(). And simplify __mptcp_push_pending() by
invoking this helper.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 95 +++++++++++++++++++++++++-------------------
 1 file changed, 54 insertions(+), 41 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7d5f89799c9a..817e539d1d12 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1480,12 +1480,6 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	return ssk;
 }
 
-static void mptcp_push_release(struct sock *ssk, struct mptcp_sendmsg_info *info)
-{
-	tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
-	release_sock(ssk);
-}
-
 static void mptcp_update_post_push(struct mptcp_sock *msk,
 				   struct mptcp_data_frag *dfrag,
 				   u32 sent)
@@ -1517,61 +1511,80 @@ void mptcp_check_and_set_pending(struct sock *sk)
 		mptcp_sk(sk)->push_pending |= BIT(MPTCP_PUSH_PENDING);
 }
 
+static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
+				  struct mptcp_sendmsg_info *info)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_data_frag *dfrag;
+	int len, copied = 0, err = 0;
+
+	while ((dfrag = mptcp_send_head(sk))) {
+		info->sent = dfrag->already_sent;
+		info->limit = dfrag->data_len;
+		len = dfrag->data_len - dfrag->already_sent;
+		while (len > 0) {
+			int ret = 0;
+
+			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, info);
+			if (ret <= 0) {
+				err = copied ? : ret;
+				goto out;
+			}
+
+			info->sent += ret;
+			copied += ret;
+			len -= ret;
+
+			mptcp_update_post_push(msk, dfrag, ret);
+		}
+		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+
+		if (msk->snd_burst <= 0 ||
+		    !sk_stream_memory_free(ssk) ||
+		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
+			err = copied ? : -EAGAIN;
+			goto out;
+		}
+		mptcp_set_timeout(sk);
+	}
+	err = copied;
+
+out:
+	if (copied) {
+		tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle,
+			 info->size_goal);
+	}
+
+	return err;
+}
+
 void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_sendmsg_info info = {
 				.flags = flags,
 	};
-	bool do_check_data_fin = false;
-	struct mptcp_data_frag *dfrag;
 	struct sock *ssk;
-	int len;
+	int ret = 0;
 
 again:
 	while (mptcp_send_head(sk) && (ssk = mptcp_subflow_get_send(msk))) {
 		lock_sock(ssk);
+		ret = __subflow_push_pending(sk, ssk, &info);
+		release_sock(ssk);
 
-		while ((dfrag = mptcp_send_head(sk))) {
-			info.sent = dfrag->already_sent;
-			info.limit = dfrag->data_len;
-			len = dfrag->data_len - dfrag->already_sent;
-			while (len > 0) {
-				int ret = 0;
-
-				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-				if (ret <= 0) {
-					mptcp_push_release(ssk, &info);
-					if (ret == -EAGAIN)
-						goto again;
-					goto out;
-				}
-
-				do_check_data_fin = true;
-				info.sent += ret;
-				len -= ret;
-
-				mptcp_update_post_push(msk, dfrag, ret);
-			}
-			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
-
-			if (msk->snd_burst <= 0 ||
-			    !sk_stream_memory_free(ssk) ||
-			    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
-				mptcp_push_release(ssk, &info);
+		if (ret <= 0) {
+			if (ret == -EAGAIN)
 				goto again;
-			}
-			mptcp_set_timeout(sk);
+			goto out;
 		}
-
-		mptcp_push_release(ssk, &info);
 	}
 
 out:
 	/* ensure the rtx timer is running */
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
-	if (do_check_data_fin)
+	if (ret > 0)
 		__mptcp_check_send_data_fin(sk);
 }
 
-- 
2.35.3

