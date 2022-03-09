Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570C07C
	for <mptcp@lists.linux.dev>; Wed,  9 Mar 2022 12:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646829266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mP3ekeobvWVOFgqh1JSFldxE7EFObrKVsDgJzobob8E=;
	b=Q8teHr7qTyxsR6gKEeEwGkfNHGb6vrACeRzmarrP8tQdbuBImw1b//GJPKMNqhq7iW0Nz3
	KKEdou4kmDlgfV24oeYch3240wUCdEb8Wk7x+FfSiJThVKsz8LU2DVyPtg/FrymQ+xApaX
	1Fk5PAGT7IN0VHrfwsB6y8WuMjAjRLI=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-5DkL3SEbM1SKpLNsUDaCEg-1; Wed, 09 Mar 2022 13:34:25 +0100
X-MC-Unique: 5DkL3SEbM1SKpLNsUDaCEg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIQleq9ibB0pVfDwKaLX6er7fjXscSPAO6NMFYZgIjJaTt9EXEp0sporwyu2JlBI8eY1Ugr2/l9Jy9zVP4UFwsqxDadS78XJYCeOM3LS2I0IMsvdMPqy42hZTJE36MDiiSTwGBynA5Neb03tqJQi38/OdsrD0Mi4ibK9MIRd4KyXu48GbH0bo/rbfPTLJ1/DeHbGp1tdFF3lltoBVoCY1vbwjd3xz4MZPGLR+9uOXJpe1IUA7/wXzmlHNPjVhKhrZ4+PeZekEMPd8qEF85fz3NVdzIycIcnky4IyqTccS7Dk8xMnqyFZpTZxx6h2Ij6cfZ85btsNKx0U2Mh/uwtdwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qaOAglvagMJadARG9TrsJgjXr96/8La6UT6+0lJ8q4=;
 b=kC0o6oHZchgAVUZMK2kmT/bkAtz0z1IMtUa+6dcvYG88Q0241k2/qmyu3prxnpomWPTNNgyE3LPzPMrvWMoB/dRXVHvGrmzWu1EAznksUZ9As8mqxUyuYiid6VIOx/UVG3BFy3Ipw4x1ysjvpAx6r7Ikn8iNwgnPy4e+UucWznqEr6cUK/zI4HJHWT7fQkd09LbK+lH+VMWbxEAYODdFi5WVrw/19byLXem1ekebGVRN295fm8r60UTF/89mq1JM3/0cPwNt7JUiTseh7GvDZHofIK932et0TMbj0UdYub7U6ANrqX3Fx/4BMXteUOvHbGKQovLRU86O/PEtNhaj1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB5782.eurprd04.prod.outlook.com (2603:10a6:20b:aa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.29; Wed, 9 Mar
 2022 12:34:24 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 12:34:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 2/3] mptcp: reset subflow when MP_FAIL doesn't respond
Date: Wed,  9 Mar 2022 20:33:58 +0800
Message-ID: <0bb6b99ffb4ec3c59fa747f5d79e04d6393ffe47.1646829006.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646829006.git.geliang.tang@suse.com>
References: <cover.1646829006.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0060.apcprd04.prod.outlook.com
 (2603:1096:202:14::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e66c46c6-f5a8-477d-ef81-08da01c924ca
X-MS-TrafficTypeDiagnostic: AM6PR04MB5782:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB5782888DB6F8FABB822ECDEFF80A9@AM6PR04MB5782.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9SsrwwmNnxQUx+4+PWhuZCLmSceGmzU+0v/Z/vC/k3HFWwPU4+8F6CfDzIY9t3L6wQhfA8sNsdXo7SFugQEB5Wh1+PFBTYKLj2/O4v7VqeP2Pm3PtlaHtZEh+aoUkE7mgqX3+R6dpxtItBEclD97yIpF2glGn9BhmnxHVf8UE7+cBaWLVXRgiQRmPYQm4mcGnZxTV775SP59kKdgJqh38VF91NAhG5Vzx3lGTOe5DXg/z4BkmJrXP7G6qu2xEpkUgxeSqPV4NkLhXmG+fWXKKEPf8OG394gQ9VzdWD1sEzgds/oW3YKp+mn0WV6sWxymdpHECUHtsqYBvJnMIo6R/bHnFOwGdwMzk2o8IzmQM+1CjNvfv47hMkqy1fNuQN53lvFT8CDH+89UiIZDSYPnt6vgvhyqqJq/DHFyCaKhCUKVpoC/MaGN6k8fiKpRf2Wzcj0pbeAS9ZfE9L+gYy7Tn29rLmY8KVY0aMrwwi2gLR67XwaoLXVyRFsF/hrMoXRp5HnN2sfNihTDJGLRr59pCdwpc/Mo0PFoyrlAHIFOqZldgDhyUFheqrn2iPadDT/fKk4Gea65/ql878Nv8r+XXOReTJ8H0vUD4MGFoWUp9n1yHMWEFUsDgbb/4rTo5L3iPr2kn3VZM2lbUtgrpY0jI8CKdlAGFGsSKYCJIr4/gFUmGbjFk+5aaoGd+8chAoHV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(83380400001)(36756003)(44832011)(6512007)(6666004)(8676002)(5660300002)(6506007)(186003)(26005)(2616005)(2906002)(86362001)(107886003)(38100700002)(316002)(508600001)(6486002)(6916009)(4326008)(66556008)(66946007)(66476007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PPZglmsbUbz8AXcVNS9yPJs8PLTxDQF2jdtJQa0FCDGanIlsEscCF7HVmLRL?=
 =?us-ascii?Q?t3z7vIVdYnlB6jDwd+NCaLXAGMIAcxbyd3pVtJZQ8UsAEwPUeBXNZwtSWsIZ?=
 =?us-ascii?Q?ceKu/Vvr4veK4PI1Rup90F1Igib+jzJDPKtg32UuD2eL+1HSuy456snx2ny1?=
 =?us-ascii?Q?uBozgMFl9i1ghvU+6YuGNN8J1IFltEf93/WR9OQrRb51DCpedZZUla86Uhln?=
 =?us-ascii?Q?m+4pEQoqt1iOipE3FSYDXXvY5b8FYF7ZaXBAXcD1skApiX+2RuLh3M5vOQXQ?=
 =?us-ascii?Q?RCcT7GW+5Mh7FiTmnqKIOI6jqHSlrMiyXUfeL88SDBaYb694bujhv4abN3FG?=
 =?us-ascii?Q?KQsIhIZt6jUkGnKGp84VpAdIvulwr1hw2UwP0J9vu70Kb/0uVAn6jH8ughfz?=
 =?us-ascii?Q?EJvt3l9F6U0arbi6tQmTQR8B8DjrzLZ8j1EDgkPmUrQBAgdd/5pz4d9gye3z?=
 =?us-ascii?Q?+hTC82804tm+CBD1F39TTdgA0gJ5+FHDF/jJJRE5WA2RzL7gkdkbJEUpcQHZ?=
 =?us-ascii?Q?g+1pKCJV45QPQCQ5VCYBLhg4vFnBuWQEFctboW6O2NjxYjwF6q9rJUsjzPDe?=
 =?us-ascii?Q?8vVQKxp9Ycm8yPBXQFFbzGiyvGCttW5fWZCp7QPcvB08o534cCEs9C/miGtY?=
 =?us-ascii?Q?GqAIPj4L+OYuVnVIIix/779ffyJgyPu+AEZll9z+gyMaGXDCqSde1xxPJCkq?=
 =?us-ascii?Q?6ld9pci1tfbcuDHHY2RRV0/X13N0F/brACSWR311HL6SPweYkCN37ofwpNZW?=
 =?us-ascii?Q?EtL3A7RpjZ1ghJxtlvpH5ILWGmh9rVz0HWSKtCdSHTNmSr6A8yIbQz8gLJIJ?=
 =?us-ascii?Q?ptAn/WAr/SE/9Rx9yykuPo5O/zNraQGwfpeJX+0BWrO5bT2iR5TwwmhPUGrk?=
 =?us-ascii?Q?1XKSJNmqqGecXgKy+lesiPi3EPsIe4qtBOm7DS8oiwrg5+E6f2hlTnUHYsQg?=
 =?us-ascii?Q?PfgMvV9LaOy1/D8raPsDv6WFpyow8+jX9t2rfT/MdhzLO2+wfgEFosGCUvMD?=
 =?us-ascii?Q?7fP9zgD1d/TaFbiI+CeSPw4bSghzOTA2/0jDxtlIhaIxixxuAqflFr3CyoQG?=
 =?us-ascii?Q?iwQiteqJRu+5evm+4eeq8UfeVEAldFHtxAmYlpLx6GpIY1Gode0r8o4lD05R?=
 =?us-ascii?Q?h8JKAG8AbuNIKK6PtdCMjJu8Hl4sjo58807xy8N8du2hZmkQHAQW92iBPO8z?=
 =?us-ascii?Q?GDB1k8ZPzToKldsaQZKFGA0DaFxSPXQ2XQoO+tqs+ZZQM2rg4vUv2ynszkdR?=
 =?us-ascii?Q?Bm1QH6G3h59ovwjOICIkB0MLaY5/SqbbyPt+iqEluAAqqB/Jas5sbDngXKJl?=
 =?us-ascii?Q?JNPrUnRuI9YKtw8TP9yTO//NdH0qnNF3BLijs+KOnt2APIl+xarbkEsZev5W?=
 =?us-ascii?Q?RSRhAzchGsqnd/j7ex88Gd7wOeeukaoVPdmzJfQKZY/9URH6GmDqPVpTDaen?=
 =?us-ascii?Q?e1FI7mR++BCZihrnz6hF5oYJoL4nyQm74h3Td1sFxoSuUShKNmmKr5TGLS7p?=
 =?us-ascii?Q?lw4uOUMNKDpDhJK8b8q9zUObz27pZX0fzuUdIJy4NFFVl93XCXT1sNkCLqlz?=
 =?us-ascii?Q?Bl0vcXrCTViYeS7MrOchULawnozWH3Xd+reb7FTzQBDwEqgaV2zmiLepinuP?=
 =?us-ascii?Q?3uLGOdeR0J27o4iW8L8v5ko=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e66c46c6-f5a8-477d-ef81-08da01c924ca
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 12:34:24.6961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gup45CTcDOfkjzeeNEPwMbhrbzKeUruNZkkgy5/GG0/emMQr7lfx2+sFrwSM/bibBYw36oRuKQTQxkam5dtUAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5782

This patch added a new msk->flags bit MPTCP_FAIL_NO_RESPONSE, then reused
sk_timer to trigger a check if we have not received a response from the
peer after sending MP_FAIL. If the peer doesn't respond properly, reset
the subflow.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c       |  2 ++
 net/mptcp/protocol.c | 21 +++++++++++++++++++++
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  |  2 ++
 4 files changed, 26 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index c4622b07b7f5..c41aca97ba36 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -284,6 +284,8 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fai=
l_seq)
 			subflow->send_mp_fail =3D 1;
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
 			subflow->send_infinite_map =3D 1;
+		} else {
+			clear_bit(MPTCP_FAIL_NO_RESPONSE, &msk->flags);
 		}
 	}
 }
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3cb975227d12..6ff7e6eb44ee 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2494,6 +2494,24 @@ static void __mptcp_retrans(struct sock *sk)
 		mptcp_reset_timer(sk);
 }
=20
+static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->mp_fail_response_expect)) {
+			struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+			bool slow;
+
+			pr_debug("MP_FAIL doesn't respond, reset the subflow");
+			slow =3D lock_sock_fast(ssk);
+			mptcp_subflow_reset(ssk);
+			unlock_sock_fast(ssk, slow);
+			break;
+		}
+	}
+}
+
 static void mptcp_worker(struct work_struct *work)
 {
 	struct mptcp_sock *msk =3D container_of(work, struct mptcp_sock, work);
@@ -2534,6 +2552,9 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 		__mptcp_retrans(sk);
=20
+	if (test_and_clear_bit(MPTCP_FAIL_NO_RESPONSE, &msk->flags))
+		mptcp_mp_fail_no_response(msk);
+
 unlock:
 	release_sock(sk);
 	sock_put(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 83f0205f0d95..bf58d3c886f5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -116,6 +116,7 @@
 #define MPTCP_WORK_EOF		3
 #define MPTCP_FALLBACK_DONE	4
 #define MPTCP_WORK_CLOSE_SUBFLOW 5
+#define MPTCP_FAIL_NO_RESPONSE	6
=20
 /* MPTCP socket release cb flags */
 #define MPTCP_PUSH_PENDING	1
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ca2352ad20d4..5a7aa6e37ca6 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1009,6 +1009,7 @@ static enum mapping_status get_mapping_status(struct =
sock *ssk,
 		pr_debug("infinite mapping received");
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
 		subflow->map_data_len =3D 0;
+		clear_bit(MPTCP_FAIL_NO_RESPONSE, &msk->flags);
 		return MAPPING_INVALID;
 	}
=20
@@ -1219,6 +1220,7 @@ static bool subflow_check_data_avail(struct sock *ssk=
)
 					sk_eat_skb(ssk, skb);
 			} else {
 				WRITE_ONCE(subflow->mp_fail_response_expect, true);
+				set_bit(MPTCP_FAIL_NO_RESPONSE, &msk->flags);
 			}
 			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
 			return true;
--=20
2.34.1

