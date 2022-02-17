Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2D91FD3
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 11:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645097010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c6QJO0m7rGSGvwH2/M59Hlv/0phJ9qEZbayk7S21UZc=;
	b=lFCxL6/BOLPtiu96S4er4P62ott4jM7W+9v8k8Tzf1HBLzt2FPdyW8VlIb1Jn0XnuKDX98
	fwi0f+1NF3XlmezTGE7/A9asDpwCSYaWmgBn95ThHVscWJrRgrnMfQbSaemMxoO1v60nZa
	ihxisHvq2A56Et3xAa+bEptZUaf+bg4=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2108.outbound.protection.outlook.com [104.47.17.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-42qHqG-KNpKduy0lMi-bAQ-1; Thu, 17 Feb 2022 12:23:29 +0100
X-MC-Unique: 42qHqG-KNpKduy0lMi-bAQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbBrPskZvOMNcAsDLuHER+w9vt6etBq5zJzYfaxcAktAOdH+6YlAB/Dj02E0WbXWP5RSqAvrRP0Wu4B6m8t2Y04G0toK4TbMe8kaulPlE2Axv0ioJO/e6S50/YyOaXt1qjOqoNyODek4HdOMToLWzzKCrOeKC9TwZIRs7DEL2R4haUpVFspJ8lbmLrCH8OH0yLsePaMJMeXarsspQgLC+Az90DUQ+bAtI1bLw8Fg1Z+K4LIQ2iK9kBXvg/c7LsGUJl28q3No5y+Je/aD8kIpKwmLykEb3ViEYmwzzrPsd6DwUKksa2bNqtwKNdqAiVEmRd8MRijQCBBILvmXzPlHiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCCV5+dpiCM0uZd1rYs2yvYqGilrDMus5szPv8/yLzA=;
 b=iWQags6Mylch5hFY4Ob9oaBDa2EufCi2Y623PcS9kAIbxMjtOn5ntY7/f96InE72RQn80GDKWvzPsx8JynnBJU9KfUsTpVS6ZP4Z5B8l9V+uqh0S1/OlCY6Da71P+AKj2XO3NsDph2GoWPgAdqYAc0qi465G86M1CJ3XzpN+jc+PpUjkll/tlxstgYr0EtUi5fmh1CIpM/HIFboUYvrbJlAlDyDI06CH8CPkhCHg15l83MpZOx9C9xxcjP9h6aEHulSuvJk35fosuO0VVI92oYTt53J5Z/7pITJz4+f+RhsAYP47KggD58QvBGuAZaGEpaNhj0pW3bYnSUi8BZzRxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB9413.eurprd04.prod.outlook.com (2603:10a6:102:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Thu, 17 Feb
 2022 11:23:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Thu, 17 Feb 2022
 11:23:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [RFC mptcp-next v2 1/6] mptcp: add MP_FAIL echo support
Date: Thu, 17 Feb 2022 19:23:39 +0800
Message-ID: <0abcf65bfd7c913a99d1027b865e5f087e31672c.1645096378.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645096378.git.geliang.tang@suse.com>
References: <cover.1645096378.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ae6b09d-9ff4-446a-e489-08d9f207ebbb
X-MS-TrafficTypeDiagnostic: PA4PR04MB9413:EE_
X-Microsoft-Antispam-PRVS:
	<PA4PR04MB941309000A560FF99D8CF032F8369@PA4PR04MB9413.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:163;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f1XxW7ujw1TfzntIcIlYGVP9fZYxmEVRMey9ykKEo5NV7fJbiNV9KtQdNaqoruRYuFVoAVZOGHgb5KhMW+UEtpQ1VGvseMWNGscH5stQP7mif4Her4A2FfEgxJzyv8HReinlpIbLH5TnAxQgQr8nJ7xErkydbRxlAIyghOm0ntcn30OqORQfKlb+knOU20u9UWVkTuZwYcjlES0S3GNk2bIfxq601jOwZsANYNT2o8sSNMWfMh205mh26zGx35jnciKjb5u4J2JwS2XCGaAfNbbG2pTLTozEKfaVYaZpJ2K3zlTTfKm8iWYbGp3nT1UpjjrGPKDsPEJyldWXX7grRMYet/wS9fF15e2dhs62mWnLcBVG5yARqDgoUBrBA05cW479J4c0ZL3tuTLj4kyX92QD2gsBKKfWpzflfvMZP6eiPix5qGTIoMDE5dT+HuJJvAy4+tp5ZS+EY+kMi4rpfDYiyP2W2z1pe22o/zVH0wgkKgSbc1pNp+52Msi+kmK0msMeE312RCiEyeBthYqZ4ygD0ErbTszwc3vkEydZC+2XdSmHtyHg3IUCO93b1fWtzMEj4W10yLV+id5Mf8uXDT1mpgggOyADRdW7P1pmhxDueDoLl3rsdAxtX6SogZHbh6bkaijuEn0G0NQHj9QUCg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(2906002)(44832011)(6916009)(107886003)(316002)(6506007)(38100700002)(508600001)(8676002)(4326008)(66556008)(66476007)(66946007)(6486002)(6512007)(86362001)(2616005)(8936002)(6666004)(186003)(36756003)(26005)(83380400001)(55236004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jzb/cDrFJ5Lf9O8eY8s6d5eAiyu0lfXNl6VEDJhjJbVktSpRr0zFaBCxJyWa?=
 =?us-ascii?Q?BIdxyKp/bYBpfmFd5KyS5TjuxKLaDY0lOZzaXxE3FfEaLG6IEQhr/M11q6kO?=
 =?us-ascii?Q?Ij06+4zFCXjYrMcjF1O2YKpmJWEZEFr6BtUUbl47QBSgh9ICfbIVVdQo05bq?=
 =?us-ascii?Q?b4ZBOsS3RQwLSO/7oUyQ6DBt7zcW24BbVg8gSm0UB4No2/uDWprnNM1zcNJy?=
 =?us-ascii?Q?r1NUVi6zfZWNIzMS466P94idJtm4H4bfC5Yc0cFu9xnaDdSFnW/28euoZW6o?=
 =?us-ascii?Q?s1/k0iEw7w+moCyJkjMTdwDzKCZZIe0vT23eIbcO66H+fzkqNOlsv/VOCLzJ?=
 =?us-ascii?Q?bBGdusNSXdMrW9AiM+Gwm5cP2uNdE87KarkNPv6Wgpij9DQh0erF8X4swiIx?=
 =?us-ascii?Q?BmJj6yb1luiU84HkTtaKSd1PiOWTpPwjBHu0yTOL9jBaZ6jA/17Gf3EYc+N+?=
 =?us-ascii?Q?aUp5E4pZVVv1P/vSbj9ELJ+eKx9C6BE+lmjokcAkrUIMmrE9wvfqbleVSKfB?=
 =?us-ascii?Q?fOdM1iEr//tDvkrKYIAgNF9rF3myKoNl2E1xx3CgpABd/a1h9GqzBxUZulwi?=
 =?us-ascii?Q?8BMSuPTTxulJLui8T8UVejvQDD1H6E8AU5BEmYoNmLfeKfKjOVQuCS4I1RM1?=
 =?us-ascii?Q?L7gx+S3ytXySghywH2Vqllf6dh4Ug73+OM2CBjhEp4GNDUx5n0CHLtFix/Rf?=
 =?us-ascii?Q?W3wI23tiIPGI7iCi92YpQ9Nysq4DwYhIB3eul3qwNh/vxYz7N/Ig2wlwuzBy?=
 =?us-ascii?Q?K/LYIlMXKNpNkM2Vnv6XzErDBQB/Ma+KVxhRBZ9neB4Zf2sBqvXLfyrPWT1h?=
 =?us-ascii?Q?Xhr0is6A4FLMBZSkp6eO2VzyosWpXkoTMUi4D+0hsKrWXv204Nw3tvdhiIBF?=
 =?us-ascii?Q?4TgJPYxDSA6CJqlOabkBG3hxlo3oSoVrdbEAYWGzd+aIGM1QiOeescn8HNOt?=
 =?us-ascii?Q?/X7w6eCefmXIzvibCffusXuJ/g9rtul04JhNTBfzeJcD9LDGq+OxUwBzGTPs?=
 =?us-ascii?Q?NfddkLGG49vsj1ErRIKosChkBu3MS2K7goc/zHfliWi3WvYt1FQ1Qo3EvBxb?=
 =?us-ascii?Q?Fj6vZkD/72oM0RUQMXc/C5HtuZuYOMK36EzW0bcisd/CAGkeitm2tvfTcCHn?=
 =?us-ascii?Q?XI7kkEMQQicpD9wH60GoOSTnWW6jV4xR9ujklI+shW3067ksH3ERDYQFM/uq?=
 =?us-ascii?Q?P1H2txrzd63A65N/MaiPAmoVuSc62dECxIi93rPsJKdKI8V/H6OjCaWquFkV?=
 =?us-ascii?Q?uYBwHgY7AfknJzueorbYbs1gM0g2j8ajg+x+CHlRuuXzhfJYQVwti3mwMW7g?=
 =?us-ascii?Q?yLk9Oo/F2hIhxmryHbwd/u393eVMIl69R77C2O4Je9VZnx2vwkU149aZ7/PS?=
 =?us-ascii?Q?r2gWbDkaCYz3/U56KIplZcKSYWZ5kWd8MdBvOvGDO586dk6lXTSVcmNmCcS7?=
 =?us-ascii?Q?VdDsWModcGMRGJG735WYuK3or8XgJW7L+YFVcRG4teMN8Y68RaC453OHEYiH?=
 =?us-ascii?Q?4YQIX49C9HzKYZ+zrGMKZ7Oobm4ZqEpn7brQsA+EGh621+vZxt/XDOWOF51o?=
 =?us-ascii?Q?eQDtQAHE+6dnMWTCkp/pzJNdfEK3w/uRufWaSffV2BCT5wwpdnRb8YlWOQ2a?=
 =?us-ascii?Q?xLxHGlT6kIyrr/NY80GEGfg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae6b09d-9ff4-446a-e489-08d9f207ebbb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 11:23:28.4225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pznClOWy5QE2ZAZPFWExx3pzHuGPAcRYWdFEtKP85Q4RKsdrz7+Pqwj3DwE8woTsTc/RGClVirWaiTj5Z9PYdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9413

Add MP_FAIL echo support.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c       | 10 ++++++++--
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  |  2 ++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d0d31d5c198a..dc0dffc1b6b5 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -279,8 +279,14 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fa=
il_seq)
=20
 	pr_debug("fail_seq=3D%llu", fail_seq);
=20
-	if (!mptcp_has_another_subflow(sk) && READ_ONCE(msk->allow_infinite_fallb=
ack))
-		subflow->send_infinite_map =3D 1;
+	if (!mptcp_has_another_subflow(sk) && READ_ONCE(msk->allow_infinite_fallb=
ack)) {
+		if (!subflow->mp_fail_response_expect) {
+			subflow->send_mp_fail =3D 1;
+			subflow->send_infinite_map =3D 1;
+		} else {
+			subflow->mp_fail_response_expect =3D 0;
+		}
+	}
 }
=20
 /* path manager helpers */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 18ca0248c084..3c74b04fba6c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -448,6 +448,7 @@ struct mptcp_subflow_context {
 		backup : 1,
 		send_mp_prio : 1,
 		send_mp_fail : 1,
+		mp_fail_response_expect : 1,
 		send_fastclose : 1,
 		send_infinite_map : 1,
 		rx_eof : 1,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8d086641bdc5..f06d93fce1bb 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1172,6 +1172,8 @@ static bool subflow_check_data_avail(struct sock *ssk=
)
 				tcp_send_active_reset(ssk, GFP_ATOMIC);
 				while ((skb =3D skb_peek(&ssk->sk_receive_queue)))
 					sk_eat_skb(ssk, skb);
+			} else {
+				subflow->mp_fail_response_expect =3D 1;
 			}
 			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
 			return true;
--=20
2.34.1

