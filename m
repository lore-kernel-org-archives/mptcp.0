Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AA5256F
	for <mptcp@lists.linux.dev>; Wed,  1 Jun 2022 14:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654092532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n87uVikxLM9PVAOI6fbnJ4VkYhT7/s+g9vGn/W3uAHQ=;
	b=PGcMf9Gdo7aCzMm/CXVj8VZAiODVwt1o+Xxxi9er3LiEnWrcSIua4zZUr2W/ctO9RoXqIc
	/MorPG13yo67DAv60U6qiaNUtOkPTJ/OCY7zgyqRnwQ4bIYjtQ6WPA1EMvAxacr0Yjq1aM
	ukSHsGpTnzS8SjSYWT8FC/R+LereLuE=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2051.outbound.protection.outlook.com [104.47.13.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-8-JBHxG3SGNPCF4DHAF1ubhQ-1; Wed, 01 Jun 2022 16:08:51 +0200
X-MC-Unique: JBHxG3SGNPCF4DHAF1ubhQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiJ6ygfEsOT6VPphvjabJvCEqRJhV262kIzyPg3prNigHhrbjOGUUg1N9hVFzXkMsLJmMkjEYPI85Wi9H9xJ0sXZJbyHLoRov/HoVaBVMLpMPGht9L4MBl1FA0wFzavQM1NxeCzTiGwVX4ZIOJetnaD8GKzSbotmYhz9KtCxad27etxnYjxFEfSYJcBIDuNBgozAa6O9D+d8HEXKmt7ebI6wI6WwNr2VHiWAZNrnmfOT2OtHWSDhxG//CQU4Qn3puTUnSed2otsH8EDSHiIJAa1hpkpNGFryhzItaKgA6jXIyvLwTcNffoYYuG/C4OezlEkUlqQcNmDQ4DAAPBpB7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MwvdLP6jdtrIelNnF219KvplBm75aWyGRbrx/cmC/k=;
 b=lz7ahFakadGODI0Pr/2YFfLvGHFs/b5J+Pg17wqMu3VQGzMuPkjoikB/BnnVZnA1WjyWszWmCY034eOqZRLXklfPz/PVX7yaOBDPohRh8thDp8lEhueqUKm73l1jTV3XdkUL2vjeSW5fwoa6p6rVkU6OIYXgA0GYwPnVK6Jq6nd6kZ57hSUPX+XYTbOZnaZC192ROvu3HtSNRxAk0ahjyx+DIIu90P8i2zVyTBToCETjyhkPI9MkKpY2h6Q08abcbZkbSQUOUGYhaDPPvkDpsYG7vf1f1BXkpKLGdryCVEBIl4ogCyvpqYj5g/2KcNpl2CmYPBfnNt9bxVI4nyj55Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB4805.eurprd04.prod.outlook.com (2603:10a6:20b:d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 14:08:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 14:08:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 03/11] Squash to "mptcp: add get_subflow wrappers"
Date: Wed,  1 Jun 2022 22:08:16 +0800
Message-ID: <90326a439805a044a8e9d0e2903dc527935363db.1654092153.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654092153.git.geliang.tang@suse.com>
References: <cover.1654092153.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0051.apcprd03.prod.outlook.com
 (2603:1096:202:17::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0001ae4-a7ca-4269-f55e-08da43d8403a
X-MS-TrafficTypeDiagnostic: AM6PR04MB4805:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB480594A7C9D1CDEA7F00C0DBF8DF9@AM6PR04MB4805.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IUTUoBJN0pikwJ7OpYXG2wL5gUqgaNOUTcLg5uaO3a3qRA67R10Iwrpjqr9lyCy/y02tobQmy0i66MrHic8fqYvXI6ruLA+KPPLIT8JMdk/q/QbX4do0QeZr2YYTzYZCXVok+e3GupFHGhaGNQTeTt5//p3VNj7/AzNd/0x8cFd+j2yjTFHdaio4Z1RWzdh77Vd2rW/6Mw6oPaEIwf7Uc4kAeX5IZP4N6GN3IU8dY7QasbGGtmUDSJhpSqRFEio3Biq78BWxStczvrl1zwujUGlXww77PyUT7B6i+JGF2SkP8PP+yr36hh/zY02VX+wzv1EU4zQnakSMCe04T3s9W6AA832o8LjxSdwPYFZoqPAVIXNpz+KLpRXaa0TzhCtuqyw6QnGzQ/YGiV4K0c4e04gcsbr4VQMnSqH9SaYLfJZ0SRlV1tT/69qz5qQPpGKt08/EdPnTxZFzeSOnk1C98wLV1yj7Q9ZUVvoJRPzmUxvx0oLISgQ3O9F+gr2nKSOR4vwEy/s7HUzFx/eW61gIBn7SlElE0/tWZZV5IPWsx6QXsOEK6Od093OPamHXFJZHLN+leZkRfbJ8k+bOp895WaP5EBRPzk6XaEdSNpGcu1GP5q+vutgJWd+312PaAVBzWShfOdWskPW6YPVy5WbcuvT3ev6RUo/1YjyQhLCoProUxPPjL6kv7fs5c2zwQGcZIqZeu7Qi3rJCMZXBYGgXlQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(26005)(6506007)(86362001)(2906002)(66556008)(36756003)(4326008)(38100700002)(8676002)(66946007)(66476007)(316002)(6916009)(6666004)(44832011)(83380400001)(6512007)(186003)(107886003)(5660300002)(8936002)(508600001)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AucjWxnggrOrphrMyrPH9ss7ZUVd+gKtVB3YABAoltew/HbcX1nsh0u0K0DJ?=
 =?us-ascii?Q?uJLe325ILE/oCxcVrxq9mpqZqZhByLqltZf7TZYRXfzJi87IYei+Huq93bTJ?=
 =?us-ascii?Q?LROiFrrNjUKuSkgN52Ic/ePfDSwdxjWP2jhCjRhWFtdjW/KVhpawYZFML8hq?=
 =?us-ascii?Q?5w24XSzupC6o010+3gPvgvGF0bmvDUeAXSk/EoCEMTyJwSAowrnZesfe9I3h?=
 =?us-ascii?Q?M4jlPQc5QR8cYG2/8Y5+oYI180AiKnhD8+yHunn6/TM4m5cf/mPfKYiQvuUb?=
 =?us-ascii?Q?5RufpYI/VwwQDOppszas7oitRfAGAn0Dkb+VLnndNisdUtKGLprktLNWrhOk?=
 =?us-ascii?Q?gqCC9uxCEFd0pI8jbamCyJc7ItPOr2pbEAagBd65NfV6bAz5cVueb6GNorFD?=
 =?us-ascii?Q?4NuTe2Om+0RZbCuzdPCOXVCdPUowbOMwgq/hyWiJo9KWZHS5N4dQz/pWUApb?=
 =?us-ascii?Q?SsiBeSYVxil1f6mxe1yt3nNm632GjFxOlE1S/dEqLlc2/r7CfNRrQhS8pzYN?=
 =?us-ascii?Q?DTmk5cvKvBhojPXqAzwi/lS0y55BcBt6NlANKhABv/zeM1LdF1y+FqPcTrJl?=
 =?us-ascii?Q?egEDcdhNOC/JuTKrLhAH4Pj+jvEVFpDxnrSnktixDRC4eTYnfnotyFMkjpQj?=
 =?us-ascii?Q?zBOYIUwhz34AkKjVoBk5AWopmiUBpw3bajGkMq1HaD7tq29j7Kq5cq58dI6Y?=
 =?us-ascii?Q?t6pJlT8oIYrPL8PGowooH+d68vQwh1cItoN40vzop6Hmw7Tx3WWjlD5U8Cxf?=
 =?us-ascii?Q?aDTIarQYZG1ZXHdUXrfC+F7ws8r5hmTfiXUh5IZXp89qC8QLBhD0Ap51WtLY?=
 =?us-ascii?Q?ronQhSyUQ/gCF9wUWfG9crkwC3mESyln5sMQyVj73vEMPJrz63O1w3IQB4HH?=
 =?us-ascii?Q?kkfJVxPlB3c4n6KTqc3goUUSx1l5MOxbQTeqeQX9ms4bIrtUNHLT4dFEYylF?=
 =?us-ascii?Q?t4+GwBC3qkxyj6jxsAx12iFKurDaMLGX42NoANp15EpGMIe49hXyOpNbnVq3?=
 =?us-ascii?Q?f9WkJiL4cgMtDVdGQHyLUet7DDHFaetZOA9XtdNc/aEGPr+LdozrSP70JUF5?=
 =?us-ascii?Q?IWbrHNmRvoO1+cnPMaP8H9WKZaDiMlafUvjt5CFoD7bjsS8HBqDFv721n9MV?=
 =?us-ascii?Q?355r8L3qHX6qrFP174LPa7SA7UZOy0mPvfa/sxzTdGcX8gYcT4kOzUJL+WoH?=
 =?us-ascii?Q?r0BnaN1NcJCzBf3T2lrbTC/UZV/cCDePnsWQBo7vte+YyAFfgANw1gi4Gojv?=
 =?us-ascii?Q?HtWjoaGitbLMrGlYV60NKMomqfZc7kvJ/zqVoS5odaZVMEUgO6+bdGUMsscL?=
 =?us-ascii?Q?uiubetfgwUeVTFqKEQoZjjXNMFMvES/MASR9lfqX8CWXCC3vd4vtjsgZJ9NH?=
 =?us-ascii?Q?hWjQwwj2YsAgKG6IiOihGjTt3JxcqumsS3or8jetGhdHo8GKk77XuO3KpCNH?=
 =?us-ascii?Q?yXm0vtFO1EfnPEkz0jwRpu+JY2MIJkwzdi6ODYAFTnsuRSpCMf+nZP91hZDG?=
 =?us-ascii?Q?IXKLeNB9wZ1vK7/RVSpRBBvcW2wJQwB/wKhzL3odQCWiHQjJ2uJGzhp6QwTl?=
 =?us-ascii?Q?OiuS0yX9uvWJhMkbPzssXPkxGTUEIwCty8lZGAQEqP6m7Sicr1ucG0xcMWjo?=
 =?us-ascii?Q?/PAKPGl9KHuOflX7oFKxd4tA/+TdOyu/+QbIe6dgacvaAkWcsVmfjj71ALBh?=
 =?us-ascii?Q?K3PWiNwBVSVsdksGbKZoz2dUIVRBulS5LWABAyZDsWDwV7kdv+b1hr8lffw7?=
 =?us-ascii?Q?/a+ojKudqdsDW+vgsA4yjpKkJIkTQVI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0001ae4-a7ca-4269-f55e-08da43d8403a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 14:08:49.8761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gn8icl78xgeBTGSRhfXEXyvZvfBkzz47+Coyw/sgTMgTKFaLoW64GyCRNzLs2EKV98SALwjmDyWYYzk0/npDsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4805

Please update the commit log:

'''
This patch defines two new wrappers mptcp_sched_get_send() and
mptcp_sched_get_retrans(), invoke get_subflow() of msk->sched in them.
Use them instead of using mptcp_subflow_get_send() or
mptcp_subflow_get_retrans() directly.

Set the subflow pointers array in struct mptcp_sched_data before invoking
get_subflow(), then it can be used in get_subflow() in the BPF contexts.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/sched.c | 53 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 3ceb721e6489..6815654fc6f4 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -88,11 +88,24 @@ void mptcp_release_sched(struct mptcp_sock *msk)
 	bpf_module_put(sched, sched->owner);
 }
=20
-static int mptcp_sched_data_init(struct mptcp_sock *msk,
+static int mptcp_sched_data_init(struct mptcp_sock *msk, bool reinject,
 				 struct mptcp_sched_data *data)
 {
-	data->sock =3D NULL;
-	data->call_again =3D 0;
+	struct mptcp_subflow_context *subflow;
+	int i =3D 0;
+
+	data->reinject =3D reinject;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (i =3D=3D MPTCP_SUBFLOWS_MAX) {
+			pr_warn_once("too many subflows");
+			break;
+		}
+		data->contexts[i++] =3D subflow;
+	}
+
+	for (; i < MPTCP_SUBFLOWS_MAX; i++)
+		data->contexts[i] =3D NULL;
=20
 	return 0;
 }
@@ -100,6 +113,8 @@ static int mptcp_sched_data_init(struct mptcp_sock *msk=
,
 struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_sched_data data;
+	struct sock *ssk =3D NULL;
+	int i;
=20
 	sock_owned_by_me((struct sock *)msk);
=20
@@ -113,16 +128,25 @@ struct sock *mptcp_sched_get_send(struct mptcp_sock *=
msk)
 	if (!msk->sched)
 		return mptcp_subflow_get_send(msk);
=20
-	mptcp_sched_data_init(msk, &data);
-	msk->sched->get_subflow(msk, false, &data);
+	mptcp_sched_data_init(msk, false, &data);
+	msk->sched->get_subflow(msk, &data);
+
+	for (i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
+			ssk =3D data.contexts[i]->tcp_sock;
+			msk->last_snd =3D ssk;
+			break;
+		}
+	}
=20
-	msk->last_snd =3D data.sock;
-	return data.sock;
+	return ssk;
 }
=20
 struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	struct mptcp_sched_data data;
+	struct sock *ssk =3D NULL;
+	int i;
=20
 	sock_owned_by_me((const struct sock *)msk);
=20
@@ -133,9 +157,16 @@ struct sock *mptcp_sched_get_retrans(struct mptcp_sock=
 *msk)
 	if (!msk->sched)
 		return mptcp_subflow_get_retrans(msk);
=20
-	mptcp_sched_data_init(msk, &data);
-	msk->sched->get_subflow(msk, true, &data);
+	mptcp_sched_data_init(msk, true, &data);
+	msk->sched->get_subflow(msk, &data);
+
+	for (i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
+			ssk =3D data.contexts[i]->tcp_sock;
+			msk->last_snd =3D ssk;
+			break;
+		}
+	}
=20
-	msk->last_snd =3D data.sock;
-	return data.sock;
+	return ssk;
 }
--=20
2.34.1

