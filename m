Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2BC622
	for <mptcp@lists.linux.dev>; Thu,  2 Jun 2022 04:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654145671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYVaX0UeBJ1FOaNxs9/R+l5dYJ03UOSS5qXrgVBjLVM=;
	b=f/XUm5+wk0C3GmJJBDP2puW9SkGNMNezrRT0amY9DVEVM7tkebhp2yG5Cc7x+Et6SFXQwS
	irU//PX7w5hOt1aZfx8Lu9yiRQJQfp6cBPHmR82v+r4POcAZOsivyiLYJzEnFT7tqttiyy
	pl8mgAwrfitAQjrCYYs1AaJZYBLlZwU=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2059.outbound.protection.outlook.com [104.47.5.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-19-7aMc2Y0mPdO0mSU-BQUHLw-1; Thu, 02 Jun 2022 06:54:30 +0200
X-MC-Unique: 7aMc2Y0mPdO0mSU-BQUHLw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1RP5EqKeIR3ezU5GkjRfUzkg2nZSotfRgmG3dTopCsPkJ5y9PkPctyuCViR7Ya4V4Wrc9oFC5cHeX1uisL8KTkFpodIGf10BnjOqU8E/sLWe+JtkMptc8sFXXT2Wvw9JgcdU8JXYNDGu+Wa/6mGSAkOlE6bOD7/Zt296yADIN4g9if9UlK6WzItLPepjkzCswkIUC9CwEx30awnm/dgzXkz2oHM0fOXkOoT9oR0BC45G9gSQEHKdKjKryflr+HNr7/fEj3jqqB+XWSgpJhNBPkzNs/GR1SopyjuQ64h6ykqnWsjTB/3+v0Ll7UE9LTmqc/lZFL+BlaxIENqmjDouQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83tqI3r+6uK4ojJo+kMv1/xPq/X7jLcLP7+AGlCbxRE=;
 b=hHdiU8vNRu50AxrnDjjJRFjwK0+guA8wbPdC6fnYo73ggYJY4rhz1zy3D0CedwDGzZazEIIxfU0hHzoWhrJMQdebencmgU5MS5srH0IX3My+reEu77KaFBFrk85004qtLK2o3wKshWrtetXy9rIOqeloMvNgXsnl49pWs6gG1yzbppiyOvf7I+cdID4DX76l/ZtDZz0mq/hmTNFxCAjgaVM0fZYr73I9eerOauRjN1M3kGNLHbFxWQE9n/TH7Wh5Y2+JqUa3ZMQR8BlnBtXi9Cz41XpmsHIjYfYMVtHTJWRAIGtfcO6Mtwicz7ZeE7jlKDOIdBc5zyMvHdTUDcvaQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR0402MB3384.eurprd04.prod.outlook.com (2603:10a6:209:6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 04:54:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 04:54:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 05/13] Squash to "mptcp: add bpf_mptcp_sched_ops"
Date: Thu,  2 Jun 2022 12:53:42 +0800
Message-ID: <77b282be5d838080861e2d4d0b64192f23bb6594.1654143895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654143895.git.geliang.tang@suse.com>
References: <cover.1654143895.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0081.apcprd04.prod.outlook.com
 (2603:1096:202:15::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a96b1b13-16cf-4832-6e55-08da4453fa06
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3384:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR0402MB3384F44B6818C6EA884DE6C5F8DE9@AM6PR0402MB3384.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9hGhCZszvwKkj1K8okgoW6SozO3nPNA+chNaEBqtiSMJ8eKIJe1z20QlBD5jLoSzp4FVdeH/ZpxY7E6jXR0wEdcCWpk77Qxl7ehapkfbgQS3fBdVRr4QaAjKayF7DNtuQ0j+Cjm03XiPAFCtqlBML7FSc+GJd6oCxB6Wi7RQvL8/rMi7gV172QsjiKOwp8yh0aW4qCuWRCKrG6C3cvU6C06sCTR7B8kVap2d0fpg7Zk+boWc2qJtrlHIAB0ekRaV97yAFMoAoiKkcc9SpyriV0/6kRTmPYeoXTgDAahqJDrP9ijNexDhq5Z5GVzQnmcCbIsarfu/K9pXrtviSUoH2fRo3Tv+2WwcS8WDaiIHtOn+zePwk+HHm12rItE3d/diWrMy4mztXpDy6298p+VlmgzcX+HH6PZLDaspTuTUtxTOgIxrboWCLYCy9UR354SaanfvxAASwElkP3O1+wiq5LZdQ8FiL2QHTf5eVxFjv0YSxTyASlkTevrTL/NLFxbwz1aNTZejLwgKxxBoQQVy69MFemeSWYfcqZV6WXS5B7lJQEvoS3TDwNisFqKGvpQ+FZVCGXhsLdxukVGbiaar8PNaZ08Gwx2zcxYKLSJgNo04sw/QuGjFGfzIDZBqZYOPOvxXwz+Dj5mokbadOkdBTtcrZDaSOSoxa4Y9MHLvzSnUfxXtLEe10KjIfUuzQTW1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(86362001)(83380400001)(6666004)(8936002)(36756003)(186003)(4326008)(2616005)(5660300002)(2906002)(107886003)(38100700002)(26005)(316002)(66556008)(66476007)(508600001)(66946007)(8676002)(6512007)(6486002)(6916009)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xbURiZqbx2VCPBRQTwB8/ZtIb5HyUCjwBsPAukN2seXzTk18RpIGzg/oKL/A?=
 =?us-ascii?Q?Ep9LFvi+tpUYrXleBCPAm7phqy9zvkyImCsl9ZPVv2vcKfWP7oQ+0cbeC1d7?=
 =?us-ascii?Q?ZP89ZnDQTW9FWBQfDbxRr9AqoGJxSaqOioJHrOmlT9gpB/AB9lYkzSySPsdN?=
 =?us-ascii?Q?CiUdgLXd0rssDvht4rmnLdfOnm+nI9+Z6EuUbpimFxGkP4hoHs3uH65Sweq/?=
 =?us-ascii?Q?14nFTFfGqQKBY7cxK0TpOtgjuprSuw6JcKbZjoA7a8Ucjyaam8gfEbFLpmXS?=
 =?us-ascii?Q?EPEZ/iO8zSgRDEWW/0I+wIn2SFtA8ggFaJSwEkZVcS9sj88APsqWZyVCoChl?=
 =?us-ascii?Q?kfYnmIDVDTTdt2Wd6rYxRq4WzF797aAZr8n/bLyrOnpQLThoko1v+LVyITdj?=
 =?us-ascii?Q?IdGegNqa/VRZVYSzionskBTBgNRcigPkQYwD+eouZlSUz3sqxxUREO8SqaZy?=
 =?us-ascii?Q?40pN1iwc4OruOOKEvhNsW/XKcNdbzy+PQxT8JICEB/DJgtdf3G1gZXzWY9DJ?=
 =?us-ascii?Q?1BmHWq+cAGKtGdiQrjDjVTc4b6G9tXbkoIAPulM3uyD6sd981NRb9HHXEwJa?=
 =?us-ascii?Q?hw8STbgttwVWMnVLo5rr48UMACVJ2xz9seZLW5WvKZ4Jxdz007tOTeV5Mrz9?=
 =?us-ascii?Q?BwrE3i6DI2pYBKk6lGNoeLVb3d9PLIXzS2LY7uB/qKET7tFgCxf6biQRB+Ph?=
 =?us-ascii?Q?fJNK1etGewMWjXX17eFiOsDrA2q1UTC8X+0Z9Bv0OGjYJwLxjjV2i7JsEVWC?=
 =?us-ascii?Q?eP4G0S8e3oMhHclXkNYo4180CFGK5ZPaXkCcYglwQiock04979iA1g7JGY6g?=
 =?us-ascii?Q?+ZLC6YgBTlKj/s4UC9W+nhEAx7DGaphS51lXPF4N8E/2PS2SQTqABOhTzyYE?=
 =?us-ascii?Q?DMQDcCpbNvgy2/CYWwlYr/MVa1ClB7vCX/kb2mSmAeJs3limtI8guiZ8yAv1?=
 =?us-ascii?Q?i2w4S546VpwIIEflvEUz646C1qU4NO2gP6WKVfxbRUdbAUtNtXFFyg2sUT7M?=
 =?us-ascii?Q?QjEvQvnTQ3PaDR0ssHlsen62lMgfu12eCtxU6Nl/sNKuu39Bs68LDmWOCKo+?=
 =?us-ascii?Q?Tk/O+5X6r3DS3QBWzLNKXx7+wBZxLDyf1BTsWJsHTOa03d4cTAD73sIjsZHo?=
 =?us-ascii?Q?GEPL63Yl0yAskEgjkqYsaJgpvUJaJhjhQDfQmyZfKVB8dd0tI184B6JTLTgA?=
 =?us-ascii?Q?WeZHmsRdPDkb1PK571pXfTCOkegBWvSxK0ouwol7fn8PtPS6vwKMsqiRMQ1g?=
 =?us-ascii?Q?x5XEWtdiZbszdCGfY9l3K3kSsOwZOYZgRJtd0fXvxrYu1z2BI4jZzOv47LWq?=
 =?us-ascii?Q?gDFbnR3IWfiH7deCPGO3Xmr9kl8LgEvTFFAbXv6Fn39H06xv7UqUGADVOrKD?=
 =?us-ascii?Q?YEUmwAvolO4bI8/XSBVeyql8vNKDlsi2dPNWrzJOhO3W8SOg4mfvdRMex/BZ?=
 =?us-ascii?Q?fGfN4Zl08/jXUtfPj53YN1m6iTrCMWrQ2cmmGnb2ANoyIJtXtltmIFnFZXX0?=
 =?us-ascii?Q?9qpNRwpzOp0U3NI8pU7L70zV1zbM8pv6cRqbewKbv804cR7VH4n//MqFfomE?=
 =?us-ascii?Q?vsxpALYbaesUAbD/rw0skUVq9ef1jJmC4CUnZPvFp8pqJ4Ut+M3D5GHOIHtp?=
 =?us-ascii?Q?qBJln+iZ+Rh0vwASU/Ingrxz5Vr333WiUczHW7HPKRoUVLMm3pO+KLbEe7PA?=
 =?us-ascii?Q?AA76HVgwlo/8RFE7H195s4Koi6o0WlXxBFWlfTx298693vqgk5nwg3OdlORx?=
 =?us-ascii?Q?IN1hcfb1zuT7dPJWzVnyiIOV0M/HWRY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a96b1b13-16cf-4832-6e55-08da4453fa06
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 04:54:29.7483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qZCIj7w2DhguSR8ia098Q0jWjZISh0naEGBUT6E64KgHvrsjXmjWIWg12fgfH3xwkPkBiDqi0tohhOJTNDUZTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3384

Please update the subject and commit log:

'''
bpf: Add bpf_mptcp_sched_ops

This patch implements a new struct bpf_struct_ops, bpf_mptcp_sched_ops.
Register and unregister the bpf scheduler in .reg and .unreg.

Add write access for the scheduled flag of struct mptcp_subflow_context
in .btf_struct_access.

This MPTCP BPF scheduler implementation is similar to BPF TCP CC. And
net/ipv4/bpf_tcp_ca.c is a frame of reference for this patch.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 338146d173f4..0529e70d53b1 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -42,29 +42,27 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf=
_verifier_log *log,
 {
 	size_t end;
=20
-	if (atype =3D=3D BPF_READ)
+	if (atype =3D=3D BPF_READ) {
 		return btf_struct_access(log, btf, t, off, size, atype,
 					 next_btf_id, flag);
+	}
=20
 	if (t !=3D mptcp_sched_type) {
-		bpf_log(log, "only access to mptcp_sched_data is supported\n");
+		bpf_log(log, "only access to mptcp_subflow_context is supported\n");
 		return -EACCES;
 	}
=20
 	switch (off) {
-	case offsetof(struct mptcp_sched_data, sock):
-		end =3D offsetofend(struct mptcp_sched_data, sock);
-		break;
-	case offsetof(struct mptcp_sched_data, call_again):
-		end =3D offsetofend(struct mptcp_sched_data, call_again);
+	case offsetof(struct mptcp_subflow_context, scheduled):
+		end =3D offsetofend(struct mptcp_subflow_context, scheduled);
 		break;
 	default:
-		bpf_log(log, "no write support to mptcp_sched_data at off %d\n", off);
+		bpf_log(log, "no write support to mptcp_subflow_context at off %d\n", of=
f);
 		return -EACCES;
 	}
=20
 	if (off + size > end) {
-		bpf_log(log, "access beyond mptcp_sched_data at off %u size %u ended at =
%zu",
+		bpf_log(log, "access beyond mptcp_subflow_context at off %u size %u ende=
d at %zu",
 			off, size, end);
 		return -EACCES;
 	}
@@ -144,7 +142,7 @@ static int bpf_mptcp_sched_init(struct btf *btf)
 {
 	s32 type_id;
=20
-	type_id =3D btf_find_by_name_kind(btf, "mptcp_sched_data",
+	type_id =3D btf_find_by_name_kind(btf, "mptcp_subflow_context",
 					BTF_KIND_STRUCT);
 	if (type_id < 0)
 		return -EINVAL;
--=20
2.34.1

