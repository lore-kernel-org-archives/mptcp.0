Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650647D
	for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 09:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644573193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I62cFlbIMSz3fhyzmam8ApIailQ2EUNCaK0NwtlWxjM=;
	b=LThJP9P7cIZqi7fCVKG6J97XHQefKHav9FiFPQWrNlpEpRm+SWuIaIWpoTKuM9NtImgul2
	NxnurnZ4QOeAYEPsh+gjJHUv8tk60/QU/N8ywMPb3zkx/qkX5KWDpRP4qGo2M7qCzvZVTv
	TGkyJKx8eO9ncN0A19b7aHL0TakBBcw=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2110.outbound.protection.outlook.com [104.47.17.110]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-9Zz7p8NMO0289JTsmOBU4g-1; Fri, 11 Feb 2022 10:53:12 +0100
X-MC-Unique: 9Zz7p8NMO0289JTsmOBU4g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csZl7VGU0BrkMzdNezW/GAycXig0Z7ZIO9mKSDTveRvbCsz1TE3j71JB4arRPIIUmncq0JNkxd6siSeXJzq34WbOCQkTO4H7jpDi1FhXVbFlw8vPFiGM7SN8OrdFdTdiwlhCN59rilt5/mBwRRcRMs1nQplLcmXEV8qMkNoOpG+624trS0k205lOpJbWLQzgMBPp3at1vKCqFQd5HIx8iYwLQsgXFkjvsBnQD4NZVtdsJXhfj0F9IZ4KnUOGD4OVxo9XKotlwJHNJoMb8+M2HbbQSjdk6NgA8NfK+V9kH+WTVoQRgOjgQgFIeUhCcJG4iegSPk90LR7+rErqEQeCfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aI9z4bjoXx379+prboId0KU+beZbnXhdV062qpuTo0M=;
 b=Y8sIfUr4xcppjdMbP4DWTQF4reamlJ80w5BMQWy9/0/HaodxpMlK5mfPTDmEqrVx/dZ8rJXIvgKwgryR1qKrb7cSXQy0r+w1nGlqMa+6EuO254hgJ2kH0m43SfCnC71ln7Sd3kOUvTWyCLvH7n1zQZgXNeGVVJRsOvkEKAoFKPA0uksfsCClarE9U5H2v18DxuVoijpk3Zi361I4Eh1tht6LXL6qZaDWXbKLSwzzxsW5hf2iok91GUuW4znleqteo35Vz61lp41T8RJHZ5XjIWWaWgXgwnjxPb3Isl0T7NpDBj6bUi3mDy1jk0pIGGPIlJqPNJSHloiw/jOHr37TyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7878.eurprd04.prod.outlook.com (2603:10a6:20b:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Fri, 11 Feb
 2022 09:53:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 09:53:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 3/7] mptcp: add the mibs for MP_RST
Date: Fri, 11 Feb 2022 17:53:01 +0800
Message-ID: <e87d983eeb835db60f22e1963974c04be00613cb.1644572307.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644572307.git.geliang.tang@suse.com>
References: <cover.1644572307.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0183.apcprd02.prod.outlook.com
 (2603:1096:201:21::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bb8f07f-def1-4df8-0105-08d9ed445073
X-MS-TrafficTypeDiagnostic: AS8PR04MB7878:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB7878DCD8434CFBFFC5993904F8309@AS8PR04MB7878.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1rc8EsqUHWyhWg4gXNrH+uaHzrtu/SAL3hynxJsgoMGM2K3wFvieZaJs38GrWz3UmBr7FbYhALG12jLDVw2VnkFM+fnLu2nOzUzu/lIrUoT8YsT82uV5HIFoGb7b5rLRaBEC4ItmNYdtoi1ZVaLdyWmePxA2Fk8fX5EBOgngnMrVd1hngMm9zITffQz0z9c3MYmXH8sC1hoMTBn+gOr/V3z8p9m6GIAUBAeGsT2aP8vDR7+JxF3BWXelXGFExHw0h/82fraB7cL6g7Ga+JuIOydjA3rU2Up0A65eJV+a3K5lQQnL59JNbudCfC5+ud/+J1/HZU2PjdtUIi6oA/KTRmkIWT3bdJYSKU2s5Zned3eTEEOn2I1GLkvkU2LjGPoEAQuDK4P9wAdHb6YACn5yxwnc510y0ulngwTa5PAGJsCEAFSph91KpKoi0Iya5Dvgaevy9zv15DYM85Rbrspbc5aRazzoeGwcTSHGjV70mHgGtzfelEQeAx4alzD8spksBPqTerEhj2V1/By7+KmfXzeHB49i9PGbfvLLiJDiQpjMDHjZshE00yCYz0vgVNMd8+Q5BpDUivIHLrz/NO2pXXGhgxdCAKbO4IsK8mMGmGwBFhL3r+O7CwPOiF85tYqNe4nysYj6iNIqf6gmptSq7g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(44832011)(66476007)(66946007)(6916009)(508600001)(38100700002)(8936002)(66556008)(6486002)(4326008)(6506007)(36756003)(6512007)(2906002)(55236004)(6666004)(86362001)(83380400001)(107886003)(5660300002)(8676002)(26005)(2616005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bFRtHhwR6ZzMvOlB2G17I961A9opz8e15nBGnVbziXSQS9tH54Z6CUqQW908?=
 =?us-ascii?Q?HmnMoo0ED8NYOE4hO22qDoqchonUDWLuozpN9ZiMG93uNhw6AmOpGkhZYSu9?=
 =?us-ascii?Q?M2iGV8ofySKyvgjIth7Zod++qNrodu8BJy90diEQWkDOR4loDdSiu95V9wwk?=
 =?us-ascii?Q?SeOMFZddFpKV8vgLLl6b8NQhabqqj8OnwvMKW4ovtT5Dj4Q3XoXGDi9ueNxD?=
 =?us-ascii?Q?var9kuJfviX3wWU/ayVf1TEiOpLVEZWX+kbp6VgWR4PKWaxlJykVgTsD/HuR?=
 =?us-ascii?Q?ULeMrp7XMMl8ncgTpS6w+bSiXH0ic2ogtje7RQpZFYdHOpzw6cnsAyjbSIQB?=
 =?us-ascii?Q?Tlv8Ty0HgZbCeFfSvbPtPCPklOs0r2SUbbYjUeXcGpU7E/kvIEZIlRqv6+tO?=
 =?us-ascii?Q?pjZzRCotbLYpN+WsqXlFCoDqE1gusnI9LS9rgpzeeiOvSUlWbtdRXMnf3LPt?=
 =?us-ascii?Q?zRWOT1YAu6nCq3b2rz1kVF1O0n1Gy4fZVYlu64PBghJDTzlIZMYztq/nhaMw?=
 =?us-ascii?Q?nvRGZSZF3aKgItOonHlFViVV5d9e8uZG5X0M1IGMeB3C4/KGkXI60GXmXwgW?=
 =?us-ascii?Q?64q0cD9uwWbyP7MGycX9H/H6Q6EubMXtUw26DibJyGTgVfR9H/k96u+CVWGa?=
 =?us-ascii?Q?BdF2lscJ25j3AsSdX2go8DWbtCMBQtIrr+LOdaySJp4gZs9BG8S/3gvLuoFm?=
 =?us-ascii?Q?CsQ++9d2mbTwUFWFkQaCMixFvLZ/ENo8QOUUwXtZqq9hXysFCaPTP6LrSAjY?=
 =?us-ascii?Q?Ph8YU9SyrXCsL+O8pkJDcKPJzyziVIHOGEjHacFQf4thJafoMyA+McQdVlUi?=
 =?us-ascii?Q?V14LIYUp2wyXXb+10oARV4LByf+MZKXfJzzaq+BjR8/Tn5KUjPmM6aa95lbW?=
 =?us-ascii?Q?jW4KPknpISVw7knyRJ56s0cyOMP8BpXMegt/eip5CSwFj6ExQiH2fToioCr0?=
 =?us-ascii?Q?sdm2Ovu02bsIWsTx3ClwLMz9jGCukTE+cTANLNDZ8NhfKDyvsDTv9yp64LY6?=
 =?us-ascii?Q?3hpur4zO2GaD9v+LW8TxqSL1ON5bdrjfYfpzzOgBrSQbahHWvn1in20j6r/m?=
 =?us-ascii?Q?FabJeqjrkTLc85e4l2vMevCds6YhnXnwFVTwwDPPD5E458dgHuVBDHw55wJy?=
 =?us-ascii?Q?MqhyV0Ws8a9i6go6WDOAf+Jhp1Q4Zh3UQN+pF46t9C6gz+6IzsnRRRZQCbcY?=
 =?us-ascii?Q?Pn0ejqhTmJ03a76N90yFVqwNsKi9c7mXsAqSQNiXX/mQZJGiUILK4uQw8/3m?=
 =?us-ascii?Q?B9rJGbMjrgpA4y1lUdfvgA1aFb85QnOvLNYlv/rjb6pCVx4xzSzadg3rtAl5?=
 =?us-ascii?Q?5O+VJf0xuq9sttvPIDhjE1E3CIVXZuBvPeU69E6bVhzODdze9s8LGm3v5bvl?=
 =?us-ascii?Q?TWCGA6Y0wWFSCVsk/6MQbi4nshnUfRSyY/xzcsnxawGYzz6uC0HLurv9emAW?=
 =?us-ascii?Q?hZ9INayxiAytG6FSU9RxwXb0bcRnpDwdhdqtQASenAK2t6KVXm5Ve/dRhJrH?=
 =?us-ascii?Q?6rFrr3JmoxKcODjlObNtBGUj+/6WEpHNknLf0e+o7aTSHe6Sk33MshJQc7BD?=
 =?us-ascii?Q?/UKZTSNpkEGdnwuI9tEz7IuN3LbNg2BNH591ZNH8nh8EokbviVpGO+HiYBXs?=
 =?us-ascii?Q?H6TOcZUdlK8Ul5SRQ8ajqNI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb8f07f-def1-4df8-0105-08d9ed445073
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 09:53:11.4158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oaqg0W/aJ/mnqNO6TwA5ae8dfGqaHfKg87TnXpKrKM0AQ1PNlhzqP21y840D1dtp9DBCe4M2qcIsPCRKhgJnZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7878

This patch added two mibs for MP_RST, MPTCP_MIB_MPRSTTX for the MP_RST
sending and MPTCP_MIB_MPRSTRX for the MP_RST receiving.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/mib.c     | 2 ++
 net/mptcp/mib.h     | 2 ++
 net/mptcp/options.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 7cef7409e300..5ed9a7da3550 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -49,6 +49,8 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
 	SNMP_MIB_ITEM("MPPrioRx", MPTCP_MIB_MPPRIORX),
 	SNMP_MIB_ITEM("MPFailTx", MPTCP_MIB_MPFAILTX),
 	SNMP_MIB_ITEM("MPFailRx", MPTCP_MIB_MPFAILRX),
+	SNMP_MIB_ITEM("MPRstTx", MPTCP_MIB_MPRSTTX),
+	SNMP_MIB_ITEM("MPRstRx", MPTCP_MIB_MPRSTRX),
 	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
 	SNMP_MIB_ITEM("SubflowStale", MPTCP_MIB_SUBFLOWSTALE),
 	SNMP_MIB_ITEM("SubflowRecover", MPTCP_MIB_SUBFLOWRECOVER),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 785cf751e5c0..2f3a07567730 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -42,6 +42,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_MPPRIORX,		/* Received a MP_PRIO */
 	MPTCP_MIB_MPFAILTX,		/* Transmit a MP_FAIL */
 	MPTCP_MIB_MPFAILRX,		/* Received a MP_FAIL */
+	MPTCP_MIB_MPRSTTX,		/* Transmit a MP_RST */
+	MPTCP_MIB_MPRSTRX,		/* Received a MP_RST */
 	MPTCP_MIB_RCVPRUNED,		/* Incoming packet dropped due to memory limit */
 	MPTCP_MIB_SUBFLOWSTALE,		/* Subflows entered 'stale' status */
 	MPTCP_MIB_SUBFLOWRECOVER,	/* Subflows returned to active status after bei=
ng stale */
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 0401b22128c4..935a48cb40d4 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -837,6 +837,7 @@ bool mptcp_established_options(struct sock *sk, struct =
sk_buff *skb,
 		if (mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) =
{
 			*size +=3D opt_size;
 			remaining -=3D opt_size;
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPRSTTX);
 		}
 		return true;
 	}
@@ -1158,6 +1159,7 @@ bool mptcp_incoming_options(struct sock *sk, struct s=
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

