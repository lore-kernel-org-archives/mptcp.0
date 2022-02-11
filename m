Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3A67F
	for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 22:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644619548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=142JlwDF984NLX9DaeW+ikTUExhbQpD3Yga5FNiy+3A=;
	b=OaLQ14Lfbwok7vmkOC5b465AYWe6kDZRSYQy7/AFGR3ivdZjJR69iDy23C0yjvZgPqHACC
	ki64PW8avrt2rze5ujES/dthMCtLfFAG9UBJOVgUn435udCW6aqKpmpf7Ok186hroGDYln
	BwMLP8cjKcXExiDFli3v1P6TPViJ9bs=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2108.outbound.protection.outlook.com [104.47.18.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-ptvzPH3XMjSW0ourmP95Ag-1; Fri, 11 Feb 2022 23:45:47 +0100
X-MC-Unique: ptvzPH3XMjSW0ourmP95Ag-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7lc5hz0ooKlqwWvsYkM6tM65nA7nOz19U8zud13XFLn2u5VLPKd1kjLo6J35XvTqTefzIgp6gMbmLyICLmvfJhLaTw4Wk+XhDEv1GV12ISVVex3pJ0PUDvxw3VcL875n2crVVfJkXL0W4XDQddTps3N5pqhDUtvECrQt516ZoGkUij/COyzM5VyTAsjjNpEepcciiAOTly9YGNjERyHnah08kOIIb7mf814A7mavKM+9O2K9JQrDQVpmdJevza9m/U+BN7t7V210h8qUsgfhwwoDl75K4NZttUSvNQOWnsU85EQEy8JmLc8nYQEPAOj+JANQ/68cjm2zw+tcRraAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGaoM56vjX7shkLushBf1ccp3c6iKVqfDEgpyRVt7Bg=;
 b=ElqiAlcEqT+4hIHztQNq/SCnx0dtokpEWakQ/UHOtWuuFmmenBvWjZKiwdIVVFvsjjTOxG/TU9nhOMZa7pILlH9po8yOrdc/0hNOgOYneI3qmMaNDHhgFNajP3YWweiDPRRSytEDDBYw+5kAf8kmQhVB3xAQ1s3US2M9UFw6UFWd1awxV0EpEopQoRcn4dwGimNShfat382QYDk6IJzu18G6fuxpc3lI1w7fOhwz8YzIURBrytDpXr6bCAeQR4upmHicFsNI0hR1yyefvauxUyIK2YUZB98038ZovUvvGztI33XYU8mL3oM5opmY3iTvD5XoXA2FWgGqS+ANJbQMYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5652.eurprd04.prod.outlook.com (2603:10a6:208:12b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 11 Feb
 2022 22:45:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 22:45:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v7 3/7] mptcp: add the mibs for MP_RST
Date: Sat, 12 Feb 2022 06:45:39 +0800
Message-ID: <04a577c1d75955de893b17911b0876e68d27d579.1644618926.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644618926.git.geliang.tang@suse.com>
References: <cover.1644618926.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0191.apcprd02.prod.outlook.com
 (2603:1096:201:21::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51b9dbe5-b078-4145-41db-08d9edb03e06
X-MS-TrafficTypeDiagnostic: AM0PR04MB5652:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB5652885602FC32A5C0718CC5F8309@AM0PR04MB5652.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Fmd6muMqAgzZU57xFMov6s7X+9Ov74xZkvI134kj8LXgJgfjuuJ6wZUqp05/uEccUU7q5SuD9JBJ+usHZJ4dIqiUiXpbxIhPwsQHhRhojvmvxosxGeNPPQtsRPEDbQoMS3+lAj6soPrIcVU6ktjU5sAbLhhOtsVwYTe1d1YCsNbGNLNrysAO9UFlCYQXJpkyW5skOvD/hoX5yPU79OFxS72K+CrbhiNNRVi9tcmtr/ES0RzgkpLtZuFInUhZ2iUwLzpSfyz61hjAujGBFdhknMl67BEA/3o1vsQb6oatvYfPtzZBw2U3lrBrWsDMV+YQtmkC9A4xWElD8HP7BJWZOsdeh5EDBdvsoxsQbnJ4y4NJpP+XFR9OiCDDaiLT5DokiagarVfmLWAFoivwhI87SyOrRAV7niHCx0GTaZsoQuljZxr569oixiJF6JcxzkxIrPjkqjuLhHybWWxIgHnTkz9W4+34SuQXm87l10NvNOEw5L+5b+u6w/TdnmYvCsaPmUb8O7Q9Ew6WuZqqnXZLYbSYsfezViLzn3X8iBAo1AHfZoHXnUe7stB5jrk6wlFjYqwLzTkQpGwzN1l5ziV2Tv6fShZ/19yw40Sayc2vW6Butuqz+QhXMmz1P4x8VbA31+pdvJqBZOA4djZ+ynDGdA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(6512007)(316002)(66556008)(66946007)(66476007)(86362001)(2616005)(38100700002)(4326008)(8676002)(36756003)(6486002)(508600001)(6506007)(8936002)(44832011)(186003)(6916009)(6666004)(83380400001)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TbjyJfOQmJfbHjbNK89O+kRLOMWZ+M16Toqo4WykaSq2h8bm4YMkbKRLOqkE?=
 =?us-ascii?Q?rTC9CNLRE1rV2QawOiXB72ccxTzyecDWzsYkeGidfhJau0e6HzZDBqjXVeGy?=
 =?us-ascii?Q?gez962qB43W5pbineABiIDYsEbYKakv95/PRxbGEHwrV6mh/G1hohBuojV+i?=
 =?us-ascii?Q?T0BKLI3qv491OMrsIV5e0JnE5Toppt010O+DF/czMQvNIWuXsxIyA9UlB+NA?=
 =?us-ascii?Q?KeVGsrXBcRIyKSaF25Sc3nY9PuxSgPdfBOQCmdrQM0dpgMYdZm9SA4NBPDTL?=
 =?us-ascii?Q?VEGS9P7X/FhPC/Ao/HUsnW7nc4YbuPM6Qb/VAy4VaxkhhNpx7TisUbmbn50Z?=
 =?us-ascii?Q?icHPq6OSrFoUDlrQfW9F85p0jdL2E/GD7N8eGurmRmhB9RiBh60ISeJ96UPu?=
 =?us-ascii?Q?awo0lVqiVUQgORGgNUnCvgNq4ATlocIPkLogu2MYoff33X85+3nbS1GjInLd?=
 =?us-ascii?Q?f6lYfRc7xHZBYoRp2kK1QDI4fbxqw73CpXaTtS4bc2LmB5OD5vWiM2Ze74KP?=
 =?us-ascii?Q?xq1MWP582Y1T6LBu2p1dndV3O1Ht4FQA7ymapFB2OZpAeFUusc3OweCng/SD?=
 =?us-ascii?Q?lxEClHEwo0rk5j88iTPTmLvG1NCvuBEP/1Xf4C4r3jJsgbOgYCfd288zt2R3?=
 =?us-ascii?Q?gmsZuFs4Xjr+FkfUWTPfFRcr8PRPfYqx3x5KO3HxHdWCI28nmCb0mUHR6uoG?=
 =?us-ascii?Q?/qMPCVl85Kn9hy7RfjZPHvMpED231cP6d0WP+7tInzaK8rj2GSSGJ5NaOXsV?=
 =?us-ascii?Q?tPxV4+X7/juE0NejTTT9QNbd8UKlwEI6JRsreBBAVTY5UL6/EeTSb/9+cuPJ?=
 =?us-ascii?Q?zC2Wl0sMqdMKbx+iy0OrzcrPKlNFlZaDc4VlH9veNUsWKt7WyfLKUZQflpWP?=
 =?us-ascii?Q?Y0Wa48aSFFjIHjDzt8abLSgTasuc54LIRwPw1jg2K4ZZd7yEHL9l6ZmxYc1D?=
 =?us-ascii?Q?XjplKKzoq3K/b4/kC4hODKCKoNY/JKwgVYYfVSEhD4jUVQEAE3gD+UN9Sufe?=
 =?us-ascii?Q?3gY4tGzypw/QM5uUAVDPmC4tRl+oXkB/ZOmoWEHNEzJnQH1CFajJWWaqwto2?=
 =?us-ascii?Q?UXTX+gHyHk2mB1Uo7GRYvuV57weRY0s8YkxRiIE6R9VjD8Vc3tMeyLPN0a+N?=
 =?us-ascii?Q?I1PmUxGoAao5I/klKabxXCp1t0edNuidhqyichdTwGJfaMg3GEy3pXwJQmLV?=
 =?us-ascii?Q?nFsPLcmc3Zoj65d6aO22Y77bccB4fzpApUFqltJYa6dLNZnx2hnF5z/WhLH6?=
 =?us-ascii?Q?DYRX9ytwcgFWbSwo4Hcx2HdcBvirJ7GJOcrmGsrilqGLaRZnE3L+v+7qLlDZ?=
 =?us-ascii?Q?Hqjqmyi8wzPo7qpUzkXj5oO8lEl87LedWX5CmGpdU13Enk6ivA9mkjQlG22G?=
 =?us-ascii?Q?Upj9AW+CfX2iWOK6cQXcIUHQaMflKStTUHq0JZ+22I0MsCMEYB177OIW/0OM?=
 =?us-ascii?Q?OlJ3Eq/twPgNu8FTXcbCwZEWBFYOH1HJH11JeixSF6ZzNizkG6FpO9vW+K+s?=
 =?us-ascii?Q?aGwgi3YIz5fqJ8myeNkKNnCZ4eng6HrqDSLBZePuKV/UECyeov1w6YGgX6a4?=
 =?us-ascii?Q?IYiL89O1ND8ym9OdKCng/JSJ7G5nqFcUXepmaeH+tpDyWlPZ4BPvhS7NWdPV?=
 =?us-ascii?Q?HEAibMLpLhwBCrouVA8UPosU2KBuGrT6CpNUEdgLRKgdsWH9LT160bntJFnV?=
 =?us-ascii?Q?ARXGXFHBEUE8NHI9XSRskvAY5KY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b9dbe5-b078-4145-41db-08d9edb03e06
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 22:45:46.3228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ruLWWqg142ajhan2AK8293XJUS+gMp6/h0QEBRwTDddy14iAbjPWpPKizI/ihMdyLGm4OU4DHUOSXpmcmRtlxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5652

This patch added two more mibs for MP_RST, MPTCP_MIB_MPRSTTX for
the MP_RST sending and MPTCP_MIB_MPRSTRX for the MP_RST receiving.

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

