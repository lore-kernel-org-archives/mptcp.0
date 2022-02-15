Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F90A1388
	for <mptcp@lists.linux.dev>; Tue, 15 Feb 2022 11:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644923545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4jf7ggTN1LT6SG/cNOvhxwM28cRgV+Hw8XKFdOc1RVc=;
	b=M9XrPmK1D5X8VtD/X0YkSEpeiazurUXek8OrlNgxKzNpxmAVtyu5pPHMUX0sEYVgDP60Tj
	hfOggytXDvQTnz0rvazlCKkmk0JLvGdvHof1LMw3UfMA8b/u1mcZV2K5+Qsi48s++aHEj4
	Iwc7YGtuFbwyBT92C++wSYkUHtvjiCM=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2056.outbound.protection.outlook.com [104.47.10.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-32-aO267zdKNvitDeZREUyuQA-1; Tue, 15 Feb 2022 12:12:24 +0100
X-MC-Unique: aO267zdKNvitDeZREUyuQA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4+Q63qHvibdvpUWr2HBuFMNdioUjZ4zTlofZsU5Z5F9kdYMaq+AgWbwLb3c3hIVBTwfm7Jipdze7kynqShxlIbDx+G2HwgbyW5Ukf9wEKmzHnNpqOWdruzmRQEdG0xqSpWRQEzNypMQS8wmjG5fEL3wBcZ0y4jKiZQkHJWbxPDEhxVC09VJuDPMnYgVNLmJpkPyascS2uC+d9lAbOJZ13jI38YlDKnUftG9AYvMqAj62fsg7oIAhSx0NVf6SK2ZgT1VpdZg8g0eza3MhqTEIjIybMWvfFyK+ztjyRm7lyzLBumX74NI0wO/+gqHvAITbdt8EVVxWsvc8AeZ7Gp2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShXKQr5iHgn2fGCuFb4q6GNG7TfB+X12RBs6VH66If8=;
 b=jaHXkH4NdYUiQ+0dvk+WZ/KW8jH7KZNC95PM/iU5Huo2jdEtLJH26YfPTptbcyRLsbjeURDHO2+SKEcaWyS2nW7INxtjOtvpfAEVOBmEMESNrcrj8awBePdXWX2HmrRJZFNzWBiPR7fXZn54X6G+6IKvVw9KuCQjP+hjcu4BZXKoFxYaWEK2eE3kD/4daM2NZ0QiNkATdu1cqTudpW/V4Yr8sJVi3dJNq8s+rc4gsWP8MIshtU9JjDOrHVD2TBJDlfwLC3osaM+OWeqGEKmNtxpRLRYrp8kNZA54qql+7orQjAjOCSD97oWYdFBTfkYHi0bfx3tvjop2kXWzoMroxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB2921.eurprd04.prod.outlook.com (2603:10a6:3:d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Tue, 15 Feb
 2022 11:12:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 15 Feb 2022
 11:12:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 3/7] mptcp: add the mibs for MP_RST
Date: Tue, 15 Feb 2022 19:12:19 +0800
Message-ID: <12ae36a6ccc18bee81db5ac8f10f6727167bc5e7.1644923074.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644923074.git.geliang.tang@suse.com>
References: <cover.1644923074.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0146.apcprd02.prod.outlook.com
 (2603:1096:202:16::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 019696a0-d110-4847-5eaa-08d9f0740a67
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2921:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB2921AB9F80A4764204E98710F8349@HE1PR0402MB2921.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t6K9v2ZNASDn7TGupU10Vg0VNNJ9aTYCR2TKt67IWOJCruzGDCk/jLruy4dX/vBNu2vp8wSnSJ6Ux2gONbH5sZPnUytMyDFVo82ae8VAcQEgWA+K+dhWjdxpS9Kfq43YOEawlblh1Eo6YSL2IIiFa3Q+7knxw5nT2gPMoZ8oUks/woxvrMM0bIlys2A+KoacunEvXcdKWIzA2QpbJ4vQb+NwaqNP8UnRWDjRI/FBdxEkP0biEZAB3tPrXUoG5njDokJrlcmQ21pFgXSKqgc349K/KN4DVzhp15q3jprdoHA60HlXTvMH3JWZjfp3jCsINRSiJc3sbLjK7o+4EVJAnMVRvtFN860eJx2pgBfYpFP3KB41qWWR9iIf5sXRzEqxQe0oGKveJaDR5X0IrlpKdsPrcQbCDS77U7vbYsD4200Afwr1LhNRz9FZ4TvIFiKWADEdkSVnkZ0jZ36erZ2jjJaPfZYOAYbZw5qTmvCfJn7MbgzdRP/Nb+xK5TjZZl8I/Enp1a8qKJvTwDpwp8wfqYfX2V1Jj9xVntDpFxQramNcBfB7xY/xMBoL8qNcj5x28s36PuCA1KfAKYRsCyGpgweouwMaaXaQOwTwE+t2ySqbdA6D5xU57kfOA6aWysOOQiweE76Dcue6djqZpzPDlA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(86362001)(38100700002)(5660300002)(55236004)(8936002)(8676002)(66476007)(66556008)(66946007)(508600001)(6666004)(6506007)(6512007)(316002)(6486002)(36756003)(83380400001)(44832011)(2616005)(107886003)(6916009)(4326008)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kPBlzDRTHIDvN1RDXUd28UVojsk348up7QbzJmmVQe34vumNID1hH+mQ8bR8?=
 =?us-ascii?Q?JR3KapRtLkQAqj1uo4J/F4DAJcqhVki3RueKwri9ZG6sNL/+4aWn2iaMPOG+?=
 =?us-ascii?Q?gEIBOSoMLIHEaEp23w623TmF8ciS/VX5IGpCJM/rV5WNKsVNQbwlqA1dj9l6?=
 =?us-ascii?Q?DOybqV93S42E8rZGjiCHsQU7nd0vNhEDuAk97k1tz62QtjilSi7iKHCwxvU0?=
 =?us-ascii?Q?jX+3M2IsoCXSFoBvQFi7LlK8wbNRZmajqYSXTCLf9lq/07slvGOMTed/nER9?=
 =?us-ascii?Q?OOzjdRn7CWjNmtZQQQ31l7Q+muFvJrOvYIvMPvgXG8NR3wC1WPPH+o41kMdm?=
 =?us-ascii?Q?s5KSr5AzawnpB34t91diy8AjKlIDvGBNEMxRatifDcS22FjvCOOmJ1hLxy1Z?=
 =?us-ascii?Q?C4aTMOoPR34gMJ7LH5Y0z221Lx5l2s8Bg5wWrGZWn9j8MNhgyVfaJ3KcARaE?=
 =?us-ascii?Q?YLnioRYKnVscO7TOcUrbaWBTwuaVxLQ9qZc/5ryr8OiXC1wwnhZCVm35BprA?=
 =?us-ascii?Q?8cihs4b+TxHtWp/Qcequ9hEMlcKoFVXnhkWPjCKwg3B1DiO5QL1O4gHyzvp8?=
 =?us-ascii?Q?AFuogdRogiPksLPyLULE4q3PqwbvGdFfWSGEksXNEjveBrjZX4cISfC7XGi5?=
 =?us-ascii?Q?nxnmVGYwremYFV2NYf+Lebu8cvDRZaQ+S79RCj+jvt1fhLZGFhAs8Xhf9V18?=
 =?us-ascii?Q?rH6Ki6udQfsZwWEYkWElycnzc/pVG8QGIHRAHBWqK89woJAqYCQPFBYoYhzw?=
 =?us-ascii?Q?+LyzDtZC7zPYey6H/NOTDpBYEtfjldIh2Tm6n5pJyhtEdqRlWA1L8iPbNxWI?=
 =?us-ascii?Q?lchpswbWV+DUNF4yQVxJoAOtsRxGMdgRH+ijBs8xDNB1y9xCaRbUMUfR7s8q?=
 =?us-ascii?Q?AjG84/Cjk2W7nrbtr4NwXeuMbCTfPOo/pCqIsKjY8onFa4D9HEsLV36826L0?=
 =?us-ascii?Q?Q/JtYv6xfiKj0go/gma8nGW2ze/S43Pg17/1PTuR3NyI4MwWEskCsQ7NUZX+?=
 =?us-ascii?Q?cbXdqYbGnZCDUXcKA67wr6l5oMyjcbO/An25//dNsGjd7tzyDa2QlJch0k8K?=
 =?us-ascii?Q?qLRSvlAiDFKxh3zvydETzFxos2z5HS2Jddej3Az2VW6ODSR5YDDfyTo46Mwi?=
 =?us-ascii?Q?kcxJkjB4AX76TOMJ91l+2B8MClq1fBiUDaKHterPBrcIGnx32Y4pw+HcJGg2?=
 =?us-ascii?Q?nZkj4JAElQXZNuu6jsnCCqHCtYxwUOwEPm9aHmeLaVSoU05ql8ZEl0qcBiMK?=
 =?us-ascii?Q?lsOubbZHcc+DnZ6nJiFffJWL00Re2hIkKPuEDGuxqaUhVcndNE506JJyunyX?=
 =?us-ascii?Q?QJpUY+Azzk59dAiN5n9EcbACh7ewHlnMnFoT8rHsGxo5eiWdKp3Vy8dlisXg?=
 =?us-ascii?Q?a2E0JIMJ/DrqBYar7bG8M/ioibYJiCZCun/OoHf+XuwAPliS/0eo4tMlm7jj?=
 =?us-ascii?Q?ygxBrGWPHgG1jCFcynrZLPhoVPVOV19EnVTX5Kq6oN1wMoJIgfQWIFYPUmPx?=
 =?us-ascii?Q?qn6YUZl2hEzFz2at405TyPfKP3tS2s3SlNzCOL3zd4fsXf0tqMXpDcxMPcfV?=
 =?us-ascii?Q?vqGHGbyrSYGjOuVUlPpLpEv0tVNvwkPwQq3PnT8M8dGMsV5VfugdM+Yb2zih?=
 =?us-ascii?Q?wRfKgLDanxGppqQt+SG0RL8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 019696a0-d110-4847-5eaa-08d9f0740a67
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 11:12:23.3867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j3B175bcBZNuO2abtw1TM26tzwOKHaNi55rMJ8mOEhlvdiJKbTgnUJ4rMRhjuq5Wf64EfONQqFw1TpuxvUbT+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2921

This patch added two more mibs for MP_RST, MPTCP_MIB_MPRSTTX for
the MP_RST sending and MPTCP_MIB_MPRSTRX for the MP_RST receiving.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/mib.c     | 2 ++
 net/mptcp/mib.h     | 2 ++
 net/mptcp/options.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 684643f8af53..d93a8c9996fd 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -51,6 +51,8 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
 	SNMP_MIB_ITEM("MPFailRx", MPTCP_MIB_MPFAILRX),
 	SNMP_MIB_ITEM("MPFastcloseTx", MPTCP_MIB_MPFASTCLOSETX),
 	SNMP_MIB_ITEM("MPFastcloseRx", MPTCP_MIB_MPFASTCLOSERX),
+	SNMP_MIB_ITEM("MPRstTx", MPTCP_MIB_MPRSTTX),
+	SNMP_MIB_ITEM("MPRstRx", MPTCP_MIB_MPRSTRX),
 	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
 	SNMP_MIB_ITEM("SubflowStale", MPTCP_MIB_SUBFLOWSTALE),
 	SNMP_MIB_ITEM("SubflowRecover", MPTCP_MIB_SUBFLOWRECOVER),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 93dd5176fd5e..529d07af9e14 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -44,6 +44,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_MPFAILRX,		/* Received a MP_FAIL */
 	MPTCP_MIB_MPFASTCLOSETX,	/* Transmit a MP_FASTCLOSE */
 	MPTCP_MIB_MPFASTCLOSERX,	/* Received a MP_FASTCLOSE */
+	MPTCP_MIB_MPRSTTX,		/* Transmit a MP_RST */
+	MPTCP_MIB_MPRSTRX,		/* Received a MP_RST */
 	MPTCP_MIB_RCVPRUNED,		/* Incoming packet dropped due to memory limit */
 	MPTCP_MIB_SUBFLOWSTALE,		/* Subflows entered 'stale' status */
 	MPTCP_MIB_SUBFLOWRECOVER,	/* Subflows returned to active status after bei=
ng stale */
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index e775d75807fd..88f4ebbd6515 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -839,6 +839,7 @@ bool mptcp_established_options(struct sock *sk, struct =
sk_buff *skb,
 		if (mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) =
{
 			*size +=3D opt_size;
 			remaining -=3D opt_size;
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPRSTTX);
 		}
 		return true;
 	}
@@ -1161,6 +1162,7 @@ bool mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb)
 			subflow->reset_seen =3D 1;
 			subflow->reset_reason =3D mp_opt.reset_reason;
 			subflow->reset_transient =3D mp_opt.reset_transient;
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPRSTRX);
 		}
=20
 		if (!(mp_opt.suboptions & OPTION_MPTCP_DSS))
--=20
2.34.1

