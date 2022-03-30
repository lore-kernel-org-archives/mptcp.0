Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2322576
	for <mptcp@lists.linux.dev>; Wed, 30 Mar 2022 15:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648655860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/WxbMNC6u20WwrMK8/CLBzgKOrPXTwTrmRI8MWiiljA=;
	b=aVSk7x57tA/3g9tEcKO9v/bu2pZX0cA1cOxkW1Gg0YbGx1OHQ+EBJ4G6aA36mpX3/LEtCq
	LURMnFEcZnygqexKiVfjwXQvu9598dNklQ66tZPIlPkZ/gPbrGb43bJCI1f4NAxTucWeBk
	Fl3ztw5N9OdK8iIZSIl+4rXd+yZQNbE=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2174.outbound.protection.outlook.com [104.47.17.174]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-30-uFaRtJ0UNGu8Wie-mRExBw-1; Wed, 30 Mar 2022 17:57:39 +0200
X-MC-Unique: uFaRtJ0UNGu8Wie-mRExBw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZUTQVYEQWBdOpeILt5TKSpprgDxvk4bZEx7eh84GzewLC65a3V1DLLwQmAhr7asFdJ0NqSQ2ECpAV6+QUt+OdfCZP7klwqbE/6mCmPxF30bGLSESkVyvFUBEyiDpx4YKD6GTio1FmpDfOSJ2OixFG/PEW9Zx9drOCJR/Cgxvf/2370126FY8yJ0sfrxZS/KlYA46QMhxCXKndbVruMKeKHQBulpbwLnOo0WIPIAs2cCg02yoA8SF38Zc9F5uolhGTFac9KleNh7s2JBBhMRUZkT95w1jC6Ovw0R+att7cjbgn0dtHFR4LUSnlbpau47jw+jXpaVIwEwMNiCJ3Ca+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBFWMzkzlXgzbjKMWrxPoLubDddnuX/JP4tUbOpJ5tA=;
 b=QK8fYpo32oN0MkeCQz0P8sj2tE1Mc4FbM3vn5owPhKpSxzkRWs9UzOOfVp6OuEnBNehz/kZkWsraUeos6dniw+A/PdbQ4vG3E5LBLB9FhhEytZha6QrjMIlU0WBPDl5j8HlvkgYhs9djGjydkLGU9mmbV2cjh+zlhr13upwWVIWMKk7sKi3QMvX425xgh08KoOIpr563W4csUWqmumyD9PJfySDUYZeRzX2L/tzde7sSC5FCAb+CT3MtinLOh5hKnGnR1gJvbNCPbKNvgrdPFLPNvE+qrarkIimJ6MLFb3w9yFlFCCUyqbD6O3xaALQM2hF5JerPDEtPo9Wa/mNjoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB6300.eurprd04.prod.outlook.com (2603:10a6:10:c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16; Wed, 30 Mar
 2022 15:57:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 15:57:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "bpf: add bpf_skc_to_mptcp_sock_proto" part 2
Date: Wed, 30 Mar 2022 23:57:42 +0800
Message-ID: <cd7338125a956912da5a431eef68b6849e44c0ae.1648655695.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TY1PR01CA0174.jpnprd01.prod.outlook.com (2603:1096:402::26)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d9eb602-789c-4d3b-ade1-08da126602e9
X-MS-TrafficTypeDiagnostic: DBBPR04MB6300:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB6300A933F093E6F319C27DA5F81F9@DBBPR04MB6300.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q8ujrABAE5eSPgP+4or2cKxm51Hq9LODVJQXl17fm9xjoJIEAoLKVV6rOcAWtyeNCn12kvn2+1qRtfSa7X8USkkuaLDaEIMP9OhdarqMrjr1kWDtrg09A4PzUa20p6QJlVC2tEj76EZV7iJtZShffCFxKZpE+PjERgpPJYBhgnQgbxc3dxR8fJKRVT36lYe6IPD7ewP9BdEn4izy+xbxNIwoJdeGaZoVGaA5YRAMu37ILIARRaPRTu7cfiHkYjv/Mg5UwDw4/npkQtjVg9EFw17MhO0Eyrkohm/BVFBSqz3FNKxhsnM60uAXAtNYoykQ7TAyizrv2Jl5KkVEbmBPMR0BN3rNJcw1xgeDDW0aDn2sJEqJZ95VcDdYCXpmfw9daosGdTvJuj0e4jx5eGRVjJLn2nSJARLFY3fsUmjiGTHX+37JJEfRx24ZT7j2KcU0vZaYsnSpoXHyyhu5XqUuD76jqvjwaGgjzsLRh57oGPJ60uMiNugRUhvKTUAPFtRucb7pJwX+L4l5NnngfC/QulcS9qoJImq6Yk2nRw3Zr9qktpwCg4tqBMDhNxarIKDCOZKdGaReeDOM6gp5f+jqc94TLp95614saKmAClunOwV0EKrV4VHODRnASDzvQ3lUM3vh4VgB8WYDCLm6Wb3ylQGm3Ef2wT6TcZxDWSszSdboMV3i94BdRGaSNYRgUamg8UaaiaCdlDtTPwb2r/0lBQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(107886003)(2616005)(38100700002)(8676002)(66476007)(6666004)(186003)(4326008)(66946007)(26005)(316002)(86362001)(66556008)(6506007)(508600001)(6486002)(44832011)(6512007)(2906002)(8936002)(36756003)(4744005)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rj4rVfVZdKTbc1HHndjEcUBzoFEoekQ05RhLML4KKCaHNDw4P6fWToTuASGM?=
 =?us-ascii?Q?5Xe80vd0EEXHPkfJw7Vr8QxfWLlDlAxtCxK1x0dZ3+NTiyjL3zuxRNHPUo6M?=
 =?us-ascii?Q?6at9epceqHNoncebWk51fTfx7p7f4Qdh8RGcBC/26+wWNwa0t/hr/avg3oU1?=
 =?us-ascii?Q?jgjZxKtN/Q8fyew5fJEt7GchR6Ut6xENb4XnOy1R/gVrQjW0hsvLLYd72fwY?=
 =?us-ascii?Q?ODaNATSCwRuAfEp4D0WnrpsJNEozGc0AEuWuPcTwf0Bdd2OGPJbKINSoMJSH?=
 =?us-ascii?Q?Nf8HHagWXhJ/LlRqZPn2Mp2AWR317lioHa/5DCrftfPbyI8ka1VNghloO6Uu?=
 =?us-ascii?Q?xwkzh3pQNpi3P+XfCuElgR6+JZjrpAHdQ8aM3nBDbNInY77Imu0JorhWp5tf?=
 =?us-ascii?Q?tyyM641hcNd/7R2VQlOIFOQJJfJbm/TeWEAPdm2MFNFvkZsa/5QBOzRqSWfV?=
 =?us-ascii?Q?bT7HdLzUroF1Yt+xvLTyF3YSfN3JoaBnnA+EhqpzAcw5UHLQTM157tS3x8Jw?=
 =?us-ascii?Q?deuTGUg1uWlAx8lNDWNQxK/Ren8NxVRfRDnxrLQ5pSGcTcpXriYJqYcdzQNO?=
 =?us-ascii?Q?bI1kABFzohdnHOm6WBx33YOomBALnX6azuVLdKo/2EfcgPS9hP8qH4e2BRaE?=
 =?us-ascii?Q?AzeSi5hbc6aTdAEFNQMdrjr1nrBofWb4qXOnwmRLjBYYxNUmD+lnolb+RPMN?=
 =?us-ascii?Q?zojTTPA6yhj5jz1hcGQyPVcncUbT2avcasyT3wz0IhJ+Tg4jdZQnF14MiP6Q?=
 =?us-ascii?Q?tQ+4ieHATJOh3BTeNH5g61EY880C61fl32Kkc5BvY1S31h2k3cf+Y9sko1he?=
 =?us-ascii?Q?DVvb8w+e9YAEVoah6dEh+EIZyDm8SriAOU6pjDDWQ6xfx98DCtmKSlDcbwEe?=
 =?us-ascii?Q?JsSh/aiMV1C98IQ5uXwYA2R5FbnDfos6ovrUHOkZIDVTZbiFkezODo1jWa2K?=
 =?us-ascii?Q?mNtnCsILbrlh1FQ3ugH8hkFbKepR7jkGpyKVHSwbwMk0rPnyM0sk3y9m5FnV?=
 =?us-ascii?Q?2N96kfNApXBLxHCiAFPV6j69IPaolF1hsuacujQBqszLy8Qj0M/iqrLJwLCn?=
 =?us-ascii?Q?i/ZYoQqHkf/BuBxwDwbd/GkX9grCfFP5jaSwbWfGfBrBf9oIKOoSW4xHJ1VI?=
 =?us-ascii?Q?hrC/PQtgBVKsvyf58uEEsnmMxiR6oVnCn1LCMrTM/pCsaukIAo/Nfxpi2n28?=
 =?us-ascii?Q?PN1RmZx11/MsRJu1ViBxVMNFL1mQjFckJ7pfhBXqM1yFH9AIqtSfAbTARSkU?=
 =?us-ascii?Q?jgcmPba7KSeArMf3tiy7V/SJ+4sSurMVFV2AeUaGYEJHueVQ/4rBrbGwbczd?=
 =?us-ascii?Q?zskpADaYKUQl1SqdJgfr4kFl+0Q6tuYwNqP2hPziIoGxtNJAUpsKSPsySQ2+?=
 =?us-ascii?Q?P499BjSew3DWlRQjbSMjd6wiRZxt1Sw/bB0tBxx2nGDFzWDkt2J0deQy+N2Y?=
 =?us-ascii?Q?DwojaYmdt7UXYJE/R+0iGeDpd31r1/8yjJ3gB9uowPlDZIqZJKG3+LYhkqKp?=
 =?us-ascii?Q?I3meS+hF2jZr4IP8Bs7ri3VsDI3Ly6J74Ho74qtU5sN53cjqlLHUTdz5eEpw?=
 =?us-ascii?Q?fF0N8OLlRBWKMDcAOSyYO/OhrxFDYbpfgS44hkBehBHOTFC0MwE8P7VKPodF?=
 =?us-ascii?Q?f4Rcrqz5nHlS0BsN9IT0Sf5n+McZPViqlXuO0sUAdr3AI99t6X2/+jHzcDHS?=
 =?us-ascii?Q?sj86NhfYGcDNrUnqWN6VX94TSYcKwKbeTqtLt9JUh97KDqzXocyEsSLHdCmP?=
 =?us-ascii?Q?jE571oyQiThbtGv24348winA+Vw5S0U=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9eb602-789c-4d3b-ade1-08da126602e9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 15:57:37.3210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyT5GMFB8dhdA2bD3CcS7oh57+hFLo/5hDKui1fhg1mfKha00P6uhp4rJ6yzWa+Cm62Ekn79O2K8ILbHzEo66Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6300

Include net/mptcp.h explicitly.

base-commit: export/20220330T150002

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/core/filter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 53f353b81a1f..fb507c13f57f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -78,6 +78,7 @@
 #include <linux/btf_ids.h>
 #include <net/tls.h>
 #include <net/xdp.h>
+#include <net/mptcp.h>
=20
 static const struct bpf_func_proto *
 bpf_sk_base_func_proto(enum bpf_func_id func_id);
--=20
2.34.1

