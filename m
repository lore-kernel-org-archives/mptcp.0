Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36D82CA0
	for <mptcp@lists.linux.dev>; Fri, 17 Dec 2021 06:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1639723119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5L11vOTist2G5/+bkQSH6UqzETNLdHwgItJO+at59BE=;
	b=Pe/DWwGgwrcs0VyjVs6OL6/AIDOB50vCaw2Zyqbuqpka9hx0w5sSIPfAYFEjd7/i/RSnlH
	aV+4yMxSg83w86dofrNi5q/wNFk0XjyVUUN12xomouVMjfV7md8yO5I1+tVmzq7eLvOxwt
	jjQcmdvQuuSoUZGVvex2sOqhqH5fpmw=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2112.outbound.protection.outlook.com [104.47.18.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-7y8EDQpNOAOFdc4zyb3fZg-1; Fri, 17 Dec 2021 07:38:38 +0100
X-MC-Unique: 7y8EDQpNOAOFdc4zyb3fZg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Akb1M61zF/vLTuMfAIAq3U6NcauhSXsQAyK5IS3Oa+hgjT0QSM8xns/FT/gLGvwfGKo1EuxIvLzI6RsnSw0b1P0nXb6VnFJgJohfKPbXKCXIBOwT78+wOTInuDXP5rVyRshPCPCOJ+/RNaXuF95RMmrOF7wYjtCk/gTsB9sdO3UTCZvlCNMLyGzoFpOs8w0YDdXEMJkfonV9xChZZLCsjowQcC62fQy5cttkqlJ1U37TV0YEZV5cA6nQJnppeSIQVuxDPD0Xoucn/8nCFmHazlpJkIh4XrhHS3cehRQZupy+oaudEixh2QVBeoGTvDecCDlTKE5tM+M1c//5G93tGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcVlRKIkXcurcLTThT6Pt9KwywJt2DTP6QpfzWEbEMo=;
 b=iN7tXasUytxde3j0a4F8rOSqid/FC7XstNAIjGi6QCncJjWciGrbRzd7IjyFw3mDAhH7TMTUUGsf5ZzJyjKaKb9eYJqaRxAgKor0h+KmFF3O16veiJ/ut5Blx8/jriF/kk94GT7TiP3rfcEEiHqjK+2oOkbACskbuVUVBMB3xI4wPw+y6oztJJREkQa66oC0sfGC3j/Ed5pvTqG63gWLJOyophjX67zavAGg2ZEwhDbytAOgYoiTycD0x/NpnU6SzFzVzS1NCYKmx1Kd9IHWJs845Yew10iHkHc1lvoOAmO99q/EGCegoXHXo63VWPpf/4xYZuFM2oEybKMfSl0G3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2444.eurprd04.prod.outlook.com (2603:10a6:3:83::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Fri, 17 Dec
 2021 06:38:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366%7]) with mapi id 15.20.4778.019; Fri, 17 Dec 2021
 06:38:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/2] mptcp: reuse __mptcp_make_csum in validate_data_csum
Date: Fri, 17 Dec 2021 14:38:20 +0800
Message-ID: <3c3b0897957f5106683bc8d84de9682b9cab0e1c.1639722883.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1639722883.git.geliang.tang@suse.com>
References: <cover.1639722883.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0065.apcprd03.prod.outlook.com
 (2603:1096:202:17::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bd050e0-8600-4107-77d7-08d9c127db2d
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2444:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB24443A45EED2D54D62007FA8F8789@HE1PR0401MB2444.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	67XAGFshxTTF4JLs9UHcfMItSo9eY5fspeTyO8cp2ue/62yC9iqrMPxCQ4Xwqzn96HWEeE/ilXqVb/U6V3u139EdfvOBxQfVZGDUDN5EjJR4LYJBwZWPaD+cCMSXSG+HhlQTbhUdefMKyc6Jm72+ePvFwaDKb2wJ3gv7pB6JWOUoiMqyqhhD8Yt08Wj/JGHr+ne1+rqXj+onokMnMbOSqBzTHxehXShaE/4ABu6iws7zJma165a1e7jpN42OOevjeUAUVKuEWXmVp9JF6XJr4XfLYTXuNpop3cyj8fVsOZAzrwBbZ5d/J4DjVvG6eX7lsV+FZWPtWVGp4BlDKNslC6hd5SSo/+o4SyUhYr0HBUKh3QLVhoo3Go2CifMk8bK/KZWLJv0zVi/scvd9EhleTxGFJI8eoVGGiuuxyHtxMo0UcgRaPqIgfOiojum6Xfdb7//hABjU/JjC8hskd/elvpsVtCHLzFrnGeIynab35sbp8rM2o9Kkh5Tbcq3ojP/TIzk96GgppFfZXM3jXoS0bamtObaActF+RBgI7HZmzjYv2FSwzs/fJm1WwsH9IMgoOrQHTTP3fe25YPXViOeaLSAIy1yy/wIBB3m1vMvC1HO1xU0X0wl1UjepF9xMyt+hD3VgmKmIVFgQpe5sDXXX6g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(316002)(5660300002)(2616005)(55236004)(8936002)(44832011)(6486002)(26005)(6506007)(186003)(86362001)(38100700002)(36756003)(6666004)(6512007)(6916009)(107886003)(66946007)(8676002)(83380400001)(66556008)(66476007)(2906002)(15650500001)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fROWAIcO/cZMQ+VPZY4mqIlCwQLeaaG97QDKnyI2t+H3g7gg1dPX1hMSPtqG?=
 =?us-ascii?Q?3KOESOT568lCzYkUkltw1slNvKm8gikSK2l6i7UadMu1hc1Yc2SC4cXUW98R?=
 =?us-ascii?Q?nk3rU5N7KE2lxkrLWq/K7SC6buqr5BUvNQd/aLJSI0rdLceil0IKFAnS1uzF?=
 =?us-ascii?Q?5F010NFUzukwbXOWum1sKq3d3sZnxDDWpQBZS3lfY8JMDlz7B0qbDKmDEXbc?=
 =?us-ascii?Q?884uKHrQmeCcLaFzL8tMZ6tVg3+ONEkYEPR2OWhMKNEqixMVC++x2GJ6aBPr?=
 =?us-ascii?Q?vPsLMkADohtyIMZSzgYbMSPa5wMK0knKcE1aHhR72AWVXMNJWIPmgd9Wx2oX?=
 =?us-ascii?Q?GAKt54x7+obZ2+ktZXdHgoKWK17KZg/ZVBs7psNyXLfqydDFQwId3D4DbHgB?=
 =?us-ascii?Q?sS/yUThWd3m12Kfkiix/D/AP1FSUFu4niBy5BiCZuH99fZkVWyVZ5FszMoTv?=
 =?us-ascii?Q?CvP+WXkVdXKWKOKTQ2oLdFDNbp06LIWzdBbPEtofSfV9kGSSrQc9WcGLr0pI?=
 =?us-ascii?Q?TSRW1gZC/aKKV5huF30E57nOEyaIF84abnCk4z/kuq1j8PM/dK9ZWaUiY5sE?=
 =?us-ascii?Q?5UsAJvVVLc4/JW9ORUdnubF6nPAQqvp5qEdnsjU4lF181YUCr8fwGyf6Qf3J?=
 =?us-ascii?Q?FFk4zLgbwStV6dLiitw9l7+qfn7uhPzajJTo4RHqJ7OWP0VNlB3NjFLwQTYF?=
 =?us-ascii?Q?ZFLaGRKBBcSymsyeM6vJfb2uqeVBkXBbjDOOHdX/326PJbRrPrrLwULyfjdK?=
 =?us-ascii?Q?vNLPt5k3p8uBYItkk1cOKhzdTuFkqLXuNSBbm487QIap3678q0M/R2jSg1mf?=
 =?us-ascii?Q?dYvNqwOawOO3B1KllFTEf9IysvpXEXcq7ZCFJ10vMdENDvJFa6XySrzABsNq?=
 =?us-ascii?Q?rHwbxih3oBsXqdJawZ4J10i4GtCpAdyDDu1Zl+aSCX2LxxuVTIwsYcVnk2//?=
 =?us-ascii?Q?RvD/2AUU4Fhxlvbp48/z1wBOfYVafzjWWONiagi64EAqhlAHndPPQjkej5nA?=
 =?us-ascii?Q?0K7pDz53BlV4Xzls9uEkxdXGAl9S0zOmmBgHbRmtIL4yFu0ZmzN6iFweHYaj?=
 =?us-ascii?Q?S31uWMvojkcwvEvY5peE0NInKbgBkSxynsFz04W1bP6kARzY8UPdQswNSpg7?=
 =?us-ascii?Q?PQRMBVBgK9s4tlR6l3ZRM7CiOVM1YGrnEH5tUc2qREsnuhJlFUipztoUc0kl?=
 =?us-ascii?Q?8Zc0vWaxM3HEekoE1odKZTRNFRCaaAsLKut8iJjkukJObMjQJDVnyU1gNNW2?=
 =?us-ascii?Q?RHAOKEWO6JeQSIObEbvgq7cUP2rI6GMOIX9IXv8BwP07JR9VtyeGGya3YeYu?=
 =?us-ascii?Q?idx2ELMhbiE598X2AAelKDjWpe5r/zRgo3Bp2pXTq2bLFbsDo66Y+XboNfd2?=
 =?us-ascii?Q?auLyvaJzhtyYtJ2rgB2PwDB8CGNDoTv6EyabfF/OHeco6Vs6f7TJIg4Is3Vn?=
 =?us-ascii?Q?uFI2SWB8xMdncLK1wl+NhVSJNDcENxaR+Sxh2kwAS1yI88pj24S6lcpvi0Ru?=
 =?us-ascii?Q?ruiDSMmodWx6icYAkNxRKUpcBrTtyWWdbJMEBSEAAjsjFjPmdTpLIS1AX9ZB?=
 =?us-ascii?Q?BH6dgqWeBNK9XgiA8Srov0IzPaW3Jecwg1jgQJcZFXKNxao1F4aKSZahBPnH?=
 =?us-ascii?Q?EtkmL5s/2n0s8DGW9GhIZr4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd050e0-8600-4107-77d7-08d9c127db2d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 06:38:37.5840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6LW8Q6T4+vU0h6RnjEoWw7a6P7IkWL+L+0ycDBH+SxmGFNACW95VGpNtxjCbnL3wPHTOpST/SY4vYH8x5wNtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2444

This patch reused __mptcp_make_csum() in validate_data_csum() instead of
open-coding.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/subflow.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index fd5fdb639088..c8126986793e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -845,9 +845,8 @@ static enum mapping_status validate_data_csum(struct so=
ck *ssk, struct sk_buff *
 					      bool csum_reqd)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
-	struct csum_pseudo_header header;
 	u32 offset, seq, delta;
-	__wsum csum;
+	u16 csum;
 	int len;
=20
 	if (!csum_reqd)
@@ -908,13 +907,11 @@ static enum mapping_status validate_data_csum(struct =
sock *ssk, struct sk_buff *
 	 * while the pseudo header requires the original DSS data len,
 	 * including that
 	 */
-	header.data_seq =3D cpu_to_be64(subflow->map_seq);
-	header.subflow_seq =3D htonl(subflow->map_subflow_seq);
-	header.data_len =3D htons(subflow->map_data_len + subflow->map_data_fin);
-	header.csum =3D 0;
-
-	csum =3D csum_partial(&header, sizeof(header), subflow->map_data_csum);
-	if (unlikely(csum_fold(csum))) {
+	csum =3D __mptcp_make_csum(subflow->map_seq,
+				 subflow->map_subflow_seq,
+				 subflow->map_data_len + subflow->map_data_fin,
+				 subflow->map_data_csum);
+	if (unlikely(csum)) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
 		subflow->send_mp_fail =3D 1;
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPFAILTX);
--=20
2.31.1

