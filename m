Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1D1210F
	for <mptcp@lists.linux.dev>; Tue, 31 May 2022 09:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653988212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8RGFk7PKIVFAOWpieckyljWElcFxmCHWWGrIjbRq64=;
	b=g+86Iw8DtLWqHd757BbiNYtAo+HpBmhSSukEWFTwX3U/fkCXARmpDdfyW34igBBE5Wn51C
	ok/7WZRCp2W1Nnqc+ZKdx9Rl1PPBXvK4KEOLRUd+08lV8X6SDsETNOJoKlv+I7JzgWr8yz
	9S+sPLfbpE/X6zI6R83APhtskW6ELSA=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2058.outbound.protection.outlook.com [104.47.9.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-k-opyaP4ObOWEOABk44hBA-1; Tue, 31 May 2022 11:10:11 +0200
X-MC-Unique: k-opyaP4ObOWEOABk44hBA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6wJbDiB0ntcSlgyWnX3bR9Ur2ekydOGLU50R0jaAMxnV2g7jEO+aDlhO/9POQ1dMxj4nIijdw+w5U53QVoAjHaf02L5uN3RdgMSd8jP8sOKjDMZSjhepWOouKWA6B1mHxhMVlw+zO0PANFa6H6UimLuJ9kTWrLLwz1dKYKwoIYVGPY5BEXUcgiueEYz/Yz9UwB/qKiB18i49+yTFL3yZCf7WJ426ElSZb93oPcQfxjWmBd7LV+/whUQ6C+YgFsPaCCNMykGEyKjP95IYsGVTKMGiVypuijEPMslEEKqDXFqjZxYLFkErFoTMPOdAjjm8kDW6UWG0Ikb55DAwC/AsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5gTcWCSYwVYLkFPl84b7uZCgL6ig6uhUNjFSjTkU+Q=;
 b=Benw6U3AE2WfHYQ8Xm7BMwZnC+mw6eyEZ/jVnzeNOk/ZJ5VcdtjohiYZLnI6xTF6EnN+hMO1WmC4hSjTtt/IKj03luCrnFsdoOponwc+/RVziRbqJgZ3oINi+Ia6zEaRJ9mYUCN41PzqHLl3QIV6lY2NbbC9dPAkQZHUjIinJ0NB2xwPsV+VYjKwa3YtdBRA5n1iiY+iz1PjIFnOtL4SVCc4chGDnb/oK6kbmUgkbQK4DiSMgDnQMrsbph8YWZgGFaS/96xRR4JEBrkC2F/nXWlEa5ljlqYIQRbRz/UUxiThoeTfp6bwlllTMMy5rJZ66SECWQBsEQh+vXsm+FWi7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB4356.eurprd04.prod.outlook.com (2603:10a6:208:5c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Tue, 31 May
 2022 09:10:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 09:10:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 04/10] Squash to "mptcp: add bpf_mptcp_sched_ops"
Date: Tue, 31 May 2022 17:09:49 +0800
Message-ID: <c35ee54efd56681f7e632d18d02c6b9e7bf07036.1653987929.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653987929.git.geliang.tang@suse.com>
References: <cover.1653987929.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0241.apcprd06.prod.outlook.com
 (2603:1096:4:ac::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcf60fb9-d4a7-4180-2958-08da42e55cfd
X-MS-TrafficTypeDiagnostic: AM0PR04MB4356:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB4356C6258B40916D7D4B6DB2F8DC9@AM0PR04MB4356.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c84XqLWJ33LKyDxXX3x6LtPRMB3yfO9OA/iNW0oSpdIq08O7pr6WJzWHA/brxqD31XJaRnAbTgsiYWwM5B4V2No7OxEMziRNUJlV4HHombD8cXDTNVk/iez1KcIcUGLCYmfisNSKJlIiUwqwJMUZ/yQl/dyTv1LeiTzPQTcqqYyU3ZyKL6RPfbIE9kkCBLSHc3IrWLEME8BMpjt1fBI+K9qUJoGiEzj/vDA+SmgVqSpcFY+YqF/vATFJkSsoTUvgN3vx1onBKSPGNc0RdcpW7+XIW4Cm4b6NGaMca9J/QR7BAjDdXQWLXofNl2ToYr7Th2ED+WhcIAB5cf6iNEzKxPyDt3lrZ+ps7TwcV7DJ0wnkIBdyUOre0Wf++DzFwhzVIYkdF6weHaU8WwCrFZ+n4AV8DXgLV21Ae5d3bbBuPMb1gtvLOH0ZZv8mQ4fdPaMW5OmFeR4U9F59Jzchxy9dVhKxU90irKE/G+kLzfNHcbjSs8ImXJpN85hbqGobbH/JLiAKTuj6zdCTWT3D910kEz5oTz9dnk6f0P1xNjePOnm+XbS2jg92isIdriiFFl2TGhfwleRVZDnqtRLV4FmOketXMDkMLlpHOsdgz25Kq17/reJXfo6FJIQLJJnYVZF0U+Yeh8cXSCtoyyzqThqGOS7bAaKSJtC0p48mc1+y3z0n5AYDf3A3CWaF0j0xwbM4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(66946007)(8936002)(6666004)(36756003)(66556008)(4326008)(316002)(6916009)(66476007)(8676002)(6506007)(26005)(6486002)(2906002)(6512007)(508600001)(44832011)(186003)(5660300002)(107886003)(2616005)(86362001)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?665667cv83CAISBjDResyJgoE7lFkK6XwamhJHwPx+XIHTQByFL8F3YCfK24?=
 =?us-ascii?Q?OEpP7uOk5B97kK1NJm51Z5wg89PO+uMGxcuQkUIm+c/FGDn2ZMaMdYtcV5D0?=
 =?us-ascii?Q?CFo3I0+8Do1JefufS1z1igyuKdtogMXkXPglkThGTd3JfpnECqr2xKdsyWj5?=
 =?us-ascii?Q?xBqbhBrYtZengAmX+BTHXKeX1kVoskOZRBF6hvwKEKJNR7qx7TtQAuVbHbV6?=
 =?us-ascii?Q?b8a+YUjJOd8hGSOY3cTT91YLHP31Fary8jrTRdRBsULffKV048JXv96VxOw4?=
 =?us-ascii?Q?9QLeFsMzw8UtctoTrcTMhBO1m1J7TdA0rHBNJbKUtjQCcucYluBbwzwQyxi2?=
 =?us-ascii?Q?7cDq1VHwWTGzKWrBiasdE3Z9AwV2fiEUP3B6vekMe4fx5TQ8aAMw9z2rt+8X?=
 =?us-ascii?Q?xfYIerJZvqDyKVtQmMyCV8o8ZZEjYyZ6PBh84YVwHYX7Hp5dBK0c4peyTKMO?=
 =?us-ascii?Q?VV5Pq19lFIw6Gl51xLMTrnEqDmgbcbSp9ow+pITEzQb0Bl035xJwOOvbH/kJ?=
 =?us-ascii?Q?KEH7TswlSfFduXOHujw6jwiZicUGH90YekU3pcANfP0JFmrNDiPS+b2c3Ogb?=
 =?us-ascii?Q?ttbKYDLaZbjOPmTHndu/9UNij21HToZKfyMfBHM9wX7r1vkb5k01vwciZWJ6?=
 =?us-ascii?Q?/pUggjDfV2nI4n9vmjTXk7RtrDeXcEgnJt4WP1n28hTWCvEgMpuZOltHvPP7?=
 =?us-ascii?Q?Ubt2xEtA4MDEhl6IyrzNgxvMu7bwo5zvabkhanY2R+6LOpJ4XyBHzJVCvc6b?=
 =?us-ascii?Q?L6wXQzMHXqoJyhD14LmNvjkovvCKQd1jOzuNrSKF8HhoW8cFiiGTFsu683Ud?=
 =?us-ascii?Q?QKAkBX3PsRQXl/0VvDFztLG4Scg8KcSqrUYxqjh/xsaWyKq7lvhLdesKZjga?=
 =?us-ascii?Q?35oNFIoZk0MYm4GB9up70mzfD6RSeGRtiq6mY7bkU/AlcfECqgl6cc+a5nPm?=
 =?us-ascii?Q?wAzdy4WsOtgqrSaHZr10zMN8IWNNHwxZy3+p7YoaY+gl2d60Rup8E1MKzcXp?=
 =?us-ascii?Q?5AsFPDjhLfoCU7wT1i4yqk0SbY0t+jnnl2xpoLxiTA820cADNCCJGBPOra/m?=
 =?us-ascii?Q?m/Ko0C4uDpQNLQdSbzSqnhPKLQuYOiEHDfOFuCmEzLtQwWs8vfXutTo7aPoz?=
 =?us-ascii?Q?bsqi6gZXRFZfv8s2DA4MZiY1b9ov2rijZYJfW4L4dwAmKXpzOv5NsSTF5hpQ?=
 =?us-ascii?Q?srgdk5pO9e4szwaORevxY3Ptd4egzSzyQVxLhqksVGxwP8fCXpmYDdsmvv/k?=
 =?us-ascii?Q?Cbo7B4oBHFje0tgQxa2AytBcEwbtKJ7r/QU9Y9JbS3LBjogdfiht5j1uOBfZ?=
 =?us-ascii?Q?8Mht4IM0NTL9iF4yJhYP5pkWCmyeZmQIpiczTNWANZhUy74C4064xa6cjP9l?=
 =?us-ascii?Q?H1O52M5Pv3ydcMo8HweygCfr125cXZ12Ky8jHjtRcUKaH/d3a3PU2jmwQFch?=
 =?us-ascii?Q?J/bz3yZxLseJmrZFh/jUGkQ7PRbwH24Sa80s44g0sT/FOS9uFYXKgvabV9ld?=
 =?us-ascii?Q?WM/ed6sDodJD4YCxKsHO50tP28CjbnUZABuw1ew0TU0xdszas6DaM31ztfnh?=
 =?us-ascii?Q?tgotAhQ8yMKAF4KlVyeVe4hdL5fePypbJpmPvrBTtgtDYxv0G84EpdvzBAem?=
 =?us-ascii?Q?92/SHrw3KAFDjtstQYIJAN5MMiTL4fl0yHLKvL7pBi5+ATfaCO2QBLPFzLlM?=
 =?us-ascii?Q?ZKpvTHV5EJ+Mrdu40Zn+yDzXtua8J9BsAgYqPiRt1MWyo47Ss67Gdx/+wtmQ?=
 =?us-ascii?Q?F1Pvo6LS5R+PBmCAHGyye0bBQMhh7FY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf60fb9-d4a7-4180-2958-08da42e55cfd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 09:10:10.4510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTE1DNfEXlYaVqoUPTb5tHOw4swURGsjI6ZfKgSomedk2bH37/0lJlh9ZF8HesHNMqxRH7/l1t/szMcoNLLV5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4356

Drop the access code for mptcp_sched_data.

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

