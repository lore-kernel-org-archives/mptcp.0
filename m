Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B06172
	for <mptcp@lists.linux.dev>; Mon, 18 Oct 2021 12:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1634560424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tsW/o/Lwd8J0ymFpFgQfqtgsFP+XJ0gez+6Rtz7j1jM=;
	b=PfBlmHMnqV0T9V8g+ED/YswW9YsF4nLO1xvJFTd5Slzn6fuSgHHkqFSdyMNzxTp/vIkcgD
	bxpkduC6UQG9GW456q2+iEbSqob3ePZXTuwAPjfw7V+dI005F+ssZQ45aCiaVJVAOp+ykd
	Tq3F09OftoORS35aMZSWOO0QUXr92jw=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2058.outbound.protection.outlook.com [104.47.13.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-5-BHVKvmOAPgycsRzJz7LrHg-1;
 Mon, 18 Oct 2021 14:33:43 +0200
X-MC-Unique: BHVKvmOAPgycsRzJz7LrHg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuyacM4VPJnR9c5rJNb5/zbgXZappi0OqOn8NHyW0NImpzeT24lEXQevRmypRpeWmGNbKLCpwQZq1OBfEk0QdPbFFYdLEL7gPjfh7TSEWIFNKJwi6NhxWqzx3W/XedvFJCCfXwdk6CNjpOVY4J+/lmvMn5JPaFNheP+ZYLX21tRTNp819w40Sv9Mrme6J4/10EPp4bCRCxqaPJl0HoNTWmpGLcfwNzKW8T1cNb3drsiIZJBgab9PyjkXR/qYqa1L24hkMRsdzI3ADWiJPvsQ+eRmGnT2ABDfUISdBWwU+W2+2MB13yFOshrQo0RkDB0vk4b4m+fdPingbyxusn4MiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9dBpnsEoGASybv7Eqc/Oz0UVkuVeItPtC/W2D8bn1M=;
 b=hSohdjLsRzks5V9Ich7AJgpz/N4vmpxG7mINr3T2pHl276JPA85aGs+Lzq0JbXM/H1lY7fNXPd1WScl6L61fgO70HFyngWc1mOMyzmZTSrtQuB+qFKjmGWImAYe/cagPChuBIhQqK2ROlAm7XBjMkIeGLrpdHXCFpbuzPGnVw6A5dN1ZSBqq2/PAL/faB8JMrJFhGW11fiudrs2WfR28vuOKiJC7LEi7YzTu+jwIf6Q7bp1Fno6EH4wJRqd60QfhR5PQmWt53BkgklQO5t3PYxumO2xqxGvaWav6pApDYfbkKQ4Ozuk69PYOIyGzSvzBKp7IB1D2qTqhCCaKI2GgKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB2825.eurprd04.prod.outlook.com (2603:10a6:3:d4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Mon, 18 Oct
 2021 12:33:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af%6]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 12:33:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 1/8] mptcp: don't send RST for single subflow
Date: Mon, 18 Oct 2021 12:33:08 +0800
Message-ID: <62d6361bb33d11d34f61c826d115de9cf6fdd24d.1634531093.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634531093.git.geliang.tang@suse.com>
References: <cover.1634531093.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0023.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (2408:8207:2546:b4d0:1867:9999:db2f:de88) by HK2P15301CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.1 via Frontend Transport; Mon, 18 Oct 2021 12:33:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7be45185-3a9d-440c-a7c0-08d99233857b
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2825:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB2825909E6DE3976C52D2E15EF8BC9@HE1PR0402MB2825.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:363;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	poVNdhVQ0QMZckU/yVZSoDlMU0OQ4lby6idPuF5+y8GHE3Zdu/T0UxyxN+Taxl8BQAilhNWX2mX7Rhc5Z9SnKPT0grKbBMtk+U5l7hXlRS1//xtrD33y+9n2rae50qWI8S8UZzNzWFHaTg6sAbGvlm8UtGvpstAz+FKlwVI4dV5b2FdMImRBU8i3FRr7e4FLflfPKRQFdO0/twVoyf+6rnLLnh1nXrHWgqhp+jtyTBGyH1crsPFwesY/56nS+cceWB+0cCI7YfWDkVFLDiIIOEJFTVX3LVxFKxXJ39ItiHzdK/mgFkC8U4Ou3M3BHPdnmXDv37mABRBBM1YZpSzT3TaY9bhkReFBd4RvjJrJSY5CWL3cbMIw8mWnG0WTezCWVKWe7RDkgSUJs5XTMrPfWEwLhqgDcu0HFZNSPaIQEOwZT4DENbtzw3HvIUoXelR6cAWbjiXjTUKGJOVb4pOS19RqMRCwuZMTms3BwqknoN3dytwjE/x6bUmoKK9rXznfuP90FmGoQMI6nbyoMTBRR6ExAQG8jY/iCnb1eM5oIIWv1juWGQaZ39eTjWBbJma2kgTURJoxt1E5N3l4MD4IB3VGWiPPWCE88k91Zn4EkQyLrkHbsJxNvhc4DT9SnMmPEYY8k0u7H38d96KT5ItwTw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(36756003)(2906002)(6496006)(66556008)(38100700002)(8676002)(107886003)(83380400001)(66476007)(2616005)(44832011)(316002)(5660300002)(186003)(6666004)(86362001)(8936002)(6916009)(508600001)(6486002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DBN8zu6pX8daDlD89+LpkpkeIkilj7TJf3tNfW+NjpgYTn9yspo9imLJCAVf?=
 =?us-ascii?Q?QZenGLpyjIrKKdpJ3W15BR/jbzQA3rCleKNZpZV8rc5HgqIdGKs2PsXzsRip?=
 =?us-ascii?Q?1ixvVR55hLuSPfU+CxWbRIe+rO+NGVJTLubimJjf45WGETZNkf/WeqeKagoZ?=
 =?us-ascii?Q?HXVL/BlkM2tXHLbmhL3jE+EGgEsViHCdFlj4M47R19x8RVVhCcp/GgpLd9tF?=
 =?us-ascii?Q?gE2XKzsjaLYKBTegruHRDAgDtIEJoKRXd8APnhrlnX5OWAyXlWIaQahbB0Uo?=
 =?us-ascii?Q?vrqSTPTfK2ust31hqiFpp2+fe+4w95KjfZIT2+v9+DrKVFlj7GsvUX+QQb+5?=
 =?us-ascii?Q?AOYXYi6exmJGLlcT0eYbSKvvGbaQq8pGG2oDlRajPznJtVakpLUXyN3KF090?=
 =?us-ascii?Q?D6ag647oV/lakjMO2tr0olrtomNRp+AmQl0fcTGxoI0ojGUw9HksQSCK/14O?=
 =?us-ascii?Q?NgtBT2qMcv2RTWACEuMniyhV5KadUxEoEYc+iP0OqVhYbf+P/FDSCQF2rsyh?=
 =?us-ascii?Q?D9v+7aNQCd9rKtbC/Mna8sTXMXe7NK8lKDsErv5/LE4PhhNbwQB4MAafumlD?=
 =?us-ascii?Q?KI6Wc8aQTwtrbNKXNAyrMIigkOQqfqtM2vuwNn7MsDMvcqabXigQ7sM/rnaY?=
 =?us-ascii?Q?PIM31HVyYvm7WJwzke6tFBdGkZup+jJZm0LqfOGDj7Oe1XOmAP8IQag9fRhl?=
 =?us-ascii?Q?hN1TezmtFQbL0hPBsrCVrhdqOERbJglXu3XpQ+bv4WhpU45jwtF7A+2VSttP?=
 =?us-ascii?Q?jX/5CzAJVEedXANG9qPXpLz7eMP4UtFLaQmwa9E6cX/K5GKqA/A5ijlt2njh?=
 =?us-ascii?Q?bJSj1vJbHkoWCtH3RYOssPts8RzqGJmS1aC7yyDPsOZJBKyoSGoZHF3v/Dgm?=
 =?us-ascii?Q?jt91BohhuJgM68tOokENpTtVOObamdYFCULji392rfDBG3b7Ma6KNQkOkMbm?=
 =?us-ascii?Q?z6xr+M/LFhOsfh7n5phIKlafHuP84OfMi0rZFM6QwVgtAM3D4E84tQ0/04Wh?=
 =?us-ascii?Q?V6JMC259CalOR4Xdw8+BVj0iCT6Qgz6xCiOWWRYyGQqSicLI2dsp3Hq59CVx?=
 =?us-ascii?Q?O3A9Nm4v6Fwk6tNXoZLpEr79L3zK8QzZARXAkF5zeCeAA/4HYYcx4/xyh79S?=
 =?us-ascii?Q?BhJ6SjfXe1n22+dnfFmGoPrARR2+nZsuCum47goP8TqbnWqH8OqppWarMRuE?=
 =?us-ascii?Q?yR4fL4zsMnF7lRPLT4VVJnpKaQC1Iwku3wbPq8Y+l1DF8hN5PQqpPFLeVxLN?=
 =?us-ascii?Q?s6DDgAWagZnCEAuelSMeutkNLjgdpuLm8Xbd376V0XAOFhsHjvNPoYpB7pUR?=
 =?us-ascii?Q?YLy5TG5iTHLRr8v7U2rIX2udQATBEHpoSNEzYH3qENSLYnHoXZ8hLt4v8cY9?=
 =?us-ascii?Q?zjeI1touDR8ccH5Ylx0YVlewU19F?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be45185-3a9d-440c-a7c0-08d99233857b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 12:33:43.1236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ze85CH6oqC+khM/OFtoTL1cvszt/KHl/xOIZoI4tHVtqQ0CEhKuWNP8NpVld9d2QWGha3zKEGW61FolV+l0Row==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2825

When a bad checksum is detected and a single subflow is in use, don't
send RST + MP_FAIL, send data_ack + MP_FAIL instead.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/subflow.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6172f380dfb7..92b45a7c997e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1167,14 +1167,14 @@ static bool subflow_check_data_avail(struct sock *s=
sk)
 	/* RFC 8684 section 3.7. */
 	if (subflow->send_mp_fail) {
 		if (mptcp_has_another_subflow(ssk)) {
+			ssk->sk_err =3D EBADMSG;
+			tcp_set_state(ssk, TCP_CLOSE);
+			subflow->reset_transient =3D 0;
+			subflow->reset_reason =3D MPTCP_RST_EMIDDLEBOX;
+			tcp_send_active_reset(ssk, GFP_ATOMIC);
 			while ((skb =3D skb_peek(&ssk->sk_receive_queue)))
 				sk_eat_skb(ssk, skb);
 		}
-		ssk->sk_err =3D EBADMSG;
-		tcp_set_state(ssk, TCP_CLOSE);
-		subflow->reset_transient =3D 0;
-		subflow->reset_reason =3D MPTCP_RST_EMIDDLEBOX;
-		tcp_send_active_reset(ssk, GFP_ATOMIC);
 		WRITE_ONCE(subflow->data_avail, 0);
 		return true;
 	}
--=20
2.31.1

