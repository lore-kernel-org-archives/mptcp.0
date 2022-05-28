Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EE928E4
	for <mptcp@lists.linux.dev>; Sat, 28 May 2022 15:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653750742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8fugHNwni3NOU/Affik2RF/GMBkxiRr0vkIpdwSvmlY=;
	b=jXLNSXjXWyWPs781F+dxRzqUEqxGaX7n77z6OoJqs7YLDX2adRYwCT/qkJXAsDGpIChG7Y
	N+rIyS87INk/tIgxiHOQrAT84sppJm08z4FpjG6+n1XVd6uWRgJVGRI/gMFxdq487NpUID
	TOeqNL7MCi8FWZvNbPtIRelP1Q0Eo2E=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2171.outbound.protection.outlook.com [104.47.17.171]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-csPvaDwTOZuLYFUatcYWIA-1; Sat, 28 May 2022 17:12:21 +0200
X-MC-Unique: csPvaDwTOZuLYFUatcYWIA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYtDNdSutPpD5fXR6pqApdCy6ATKvHrk5ts23OscU/1lJTEQ5y80xjBEi88fukecjKGMhavQeypwjh5Z6gRydcTdby9AYqGz7/Kkmj3AStu496XqJpQHwPyIVKx/gBYESJdUMroKTMaR6Mjex8jICHrr1cnyttwUEaQ8cnt0n2utRtdDZqEbSpHmIu7OhE8nSx/Vk0/UzOFHbY2xpvMuDkS1u1gL4lZBsB5Ibp5rTbvHkek2Bqm9Eejlekn8NpokNXwRtoPAEpkl0Gvab0YwheMW+d69Ztnby3DrCzrfhtlDjY1ESRzgRVh7305sgAPSdvM2fq8Qki4p/xJawo4cJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daLISJJllPVx6lvlD+NZYITL+4xxARQazMbAM2kbaSo=;
 b=UMHmK1Wbktocbdck+8Nem4Tx7D9Id2l3Y1g0LKUuRHXGmHnJebrb1PThj3wwko1P2OE0ShmeorFAqFcU9nkAnMHmM+wS4zCPTktdf0+V/OXiEPXombrn4KCzycgQgD/780EKUCdM2WZCOdwaHUmWaRGW4IvbFqbSxKNLuJBsqVE/C7kM+8XrrGpFRIAZAKVCtXAgiHoEYfpa1bdr8jre++T0J5qwHk0xATGBLn891op1sEK24IBCpxnn8wsaPv4HgLrGcp+N8/EFrLV5gSEilsrnWCHI9Dbv7NZXdPZvsG+2pbeY7H2w7Urf2JL/4q74zVEQtqUoGdXC76wVz/y01g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8485.eurprd04.prod.outlook.com (2603:10a6:20b:418::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.15; Sat, 28 May
 2022 15:12:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5293.017; Sat, 28 May 2022
 15:12:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 04/10] Squash to "mptcp: add bpf_mptcp_sched_ops"
Date: Sat, 28 May 2022 23:11:46 +0800
Message-ID: <06689b47277ef838b21128fc4a03644a79e78f29.1653750351.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653750351.git.geliang.tang@suse.com>
References: <cover.1653750351.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0053.apcprd04.prod.outlook.com
 (2603:1096:202:14::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45f20c83-684a-49cf-8f01-08da40bc75da
X-MS-TrafficTypeDiagnostic: AM9PR04MB8485:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB8485E257EB23F1C94D723757F8DB9@AM9PR04MB8485.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rsx5IkLvHBgeFETVLX/08Hjg18IQ6T4u9VwaFPY6eGfa/kxHAevcCXn6JNSQFLhB5QBiK2BWGWYDVJ3OcnwtfbbyocW5deNiKURxV4BM0eG/mwgCGN3qzsbJaJwFa881AZwlcuqqFZABBf348CbnyJhgaryb+0x/CgXBLCPTFy/pxHig9vSwZahIcqM0LfkK2tVwhnycOTk/Z3ILnS7UwkjrziYI354uRSWruaCISaNa1JzggcU4GDDV56THYDWMp08GnLK3ysIux0jW4A8UY6IPtH9jDc/moUUvisEmhcsv7yPP6Ki2WBnU9cnaQoZYugCkGRc7sBA46zopyW+vJFx+dIyBUZUx90+u5WJSsxUDP/N7V3AZWVBrev7bmRs4LnNNeLWd/44Ja2wR45BZwaVAQf6YsGShR7C72+QjOhJnzmMfhD2oOKPMoetejdaRhgaKl1niPm/DAcVblgjGfTa5fiXmUo309ob1+CNiJ4NtBxmBt+J8rusW245Vh8RNFOLJKPYifQ4QzQamwRLvwJbrHhGN52UxYgzhnkU7jIEEK1fd9UnOKLUpGrjNp/AyzV3T/ABMRwYc4nGTJDjqtKoZBfvikfRRE6pt9BeRTji0E/nh7uB8gWbfRDpXZBo9GkZGeRpYsWJBlSsCKP6t+1X/qAzyIMc2ZR0J9zHRYnBpVuoh5KxdGlKBT67A94sTIQ/0oRBPKMkU30rszuPPhQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(83380400001)(66476007)(38100700002)(4326008)(66556008)(8676002)(86362001)(186003)(107886003)(2616005)(66946007)(6486002)(5660300002)(2906002)(6916009)(44832011)(6512007)(316002)(8936002)(6506007)(6666004)(26005)(508600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KERxXnsJD7y3NMMKAf4wUtSPVb3J0zqtsWgDr3LiaLapQLCyJp2gsEunofvl?=
 =?us-ascii?Q?1uKkxDQn5qwJF5Ybm8p9WpJxZwqGvMPSReBgrlNKa0Cr00QyDihTfut5aUVw?=
 =?us-ascii?Q?D4iwkll1PuLthfKS0ln3i1qDGqFN6D42lOy43kAyHmQoSbTYK0vZgEBep9oy?=
 =?us-ascii?Q?D4KIPnjetvC7MRbkI+SRmsV4vlf2mqVHiM2eRcqWh0vsqhJqhtG0/7DaOYzR?=
 =?us-ascii?Q?EDko8+VTxPlHvl8bRhsHXaHCZiQPwTdhQlAt+tHsgReAQFqvmyIxwZ1+7kVr?=
 =?us-ascii?Q?4F1oMP5BNVK1cOx/reFHeiXp1cu85iqFLfgsfnvnH0YL1cMIq934Nst2FZ2R?=
 =?us-ascii?Q?GpJqE2kd7qchLAEAuBp2pB4JcgzDZ3v7bb1fKpIYJEzbjIkskhlwibDl1B6Q?=
 =?us-ascii?Q?hzASFAIwpaIuIB9smgD3WKoQsYAgtDALDC8RS3DrdaU9Ex1cGt04IBzxxMSG?=
 =?us-ascii?Q?oJBbJJWIdbqtaRPUCRWdW5UGqbNCGmeR+uhumJH1VHnnel9nIO7b/5y7+mD7?=
 =?us-ascii?Q?oFUg08ofFZwKCJb+OmsvhX2w2WtpYZ5ABDDHjb88HKs4rkw/cRNeXOSLghwA?=
 =?us-ascii?Q?3udjfNsPGXF1MqxWG8CRsfTTFYeWKsZ0ZzUhcWq48dydmnHt0B61KaZhxEsA?=
 =?us-ascii?Q?smvD2f8iKeSwlbHuMbzyMbm8aYhs7e/MDgoz1NxhgCi7mEsqBEstjcbBcJVD?=
 =?us-ascii?Q?3/ukIiRfuXo7dOt9SK+ZvNpbQ/HfRD5LsEBPRpiTlMetVJ/qKEuXN900BDze?=
 =?us-ascii?Q?gMpqYx74LBPWxvBexA/31mDYgFI+jTcKbnR4VY3XMDAIYEBUWpKGxyIZFOHF?=
 =?us-ascii?Q?Y/WsAprtI2IMNo6fsamPD7x/edhRKVWwJnU55BPsWZnpQnKVEJJlEQ6jjxQi?=
 =?us-ascii?Q?Gi/AjZYfnUu+p2WMjL3FIVdXFmaaaU58gYReViMoiKibhPjS1TVKmDSNjgPq?=
 =?us-ascii?Q?cUqLwDp6hXU9abG4m/jfQtPZVQ4ghIh2sbR6YS0sAVfA2yDRIV1lHJ0R7wPG?=
 =?us-ascii?Q?Z8gIFSEKTjtQhBN5iDT8gDnV1pwMoaEQSjIRDzTK8m7T9F1+qNN02ZD0pza3?=
 =?us-ascii?Q?tGaj8WThSiudpBAo+gcV9OBuR65mrq21GLXkH0CjoQBZiYelb0r4XdGyMIfW?=
 =?us-ascii?Q?CMBGgTmvMKPLBbpz4oMEeh0iQk5y0xYokgwvmMtlQCIbQQMiRxYE0XuYEjXz?=
 =?us-ascii?Q?X36C3ON9BPzKu5hC31hZdY180G8xXRTEqurGCQoRNIYphBtpxuVYUrLzXUNa?=
 =?us-ascii?Q?O2avyweWtRhstj55VHa5cD/6xUWu0ZSdl2fejJnjFP+UWkjiE0W2jOLwtMRH?=
 =?us-ascii?Q?LzE7pd9nhNR8kvsi9o5b1g67u/EbTp+eIJ+daAs2prMPNYsTUvHED2za0at3?=
 =?us-ascii?Q?/0Y+0HODyqhuOHUc5XSwoAfKwUtlWC1ULghKyElG9ePft4z0/Ba30U0w61DQ?=
 =?us-ascii?Q?09fi7b15P2gS2AeGjtIlMg9uJio43BXxcWYOH033DSGaEKPknY2ubOO/xADP?=
 =?us-ascii?Q?iCQCjLiDSlPi+JdEazfAF5nptxDEYLUwKcz9Z/gRrT19uiZVrODp9VzXbc9O?=
 =?us-ascii?Q?5B1zRc8uJueznn8czGFomd6OpsnQbjzxUPlN+1A/T6OKq7PVRYyTyIiBkBL3?=
 =?us-ascii?Q?7lTCv8hoOfqnxn+XCD2vKRz88DWkGAaKD0eu9Ws3CUGGBe7Mmjv2rH9VE3A8?=
 =?us-ascii?Q?4SB8gerdTSLdE+TTevNf/yIErN7GfuXfV1mLC5ADadm1eB4QLvlFdeCWEE/1?=
 =?us-ascii?Q?/lvVI0h3kkvOmvHGlN3VlWJj6ZQXbkQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f20c83-684a-49cf-8f01-08da40bc75da
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2022 15:12:20.4289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OdajongX0Wn/bDofmn7SQhOxH3kbS9XjPrXjwkIZ5qBzarL9Or8fiGtdZ3nwkgBT0Ez1kcfMRD2CvA6Ov6A+Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8485

Drop the access code for mptcp_sched_data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 338146d173f4..4f4559d37f9e 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -33,6 +33,12 @@ bpf_mptcp_sched_get_func_proto(enum bpf_func_id func_id,
 	return bpf_base_func_proto(func_id);
 }
=20
+static size_t subflow_offset(int i)
+{
+	return offsetof(struct mptcp_sched_data, subflows) +
+	       i * sizeof(struct mptcp_sched_subflow);
+}
+
 static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 					     const struct btf *btf,
 					     const struct btf_type *t, int off,
@@ -40,36 +46,30 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf=
_verifier_log *log,
 					     u32 *next_btf_id,
 					     enum bpf_type_flag *flag)
 {
-	size_t end;
+	size_t start, end, soff;
+	int i;
=20
-	if (atype =3D=3D BPF_READ)
+	if (atype =3D=3D BPF_READ) {
 		return btf_struct_access(log, btf, t, off, size, atype,
 					 next_btf_id, flag);
+	}
=20
 	if (t !=3D mptcp_sched_type) {
 		bpf_log(log, "only access to mptcp_sched_data is supported\n");
 		return -EACCES;
 	}
=20
-	switch (off) {
-	case offsetof(struct mptcp_sched_data, sock):
-		end =3D offsetofend(struct mptcp_sched_data, sock);
-		break;
-	case offsetof(struct mptcp_sched_data, call_again):
-		end =3D offsetofend(struct mptcp_sched_data, call_again);
-		break;
-	default:
-		bpf_log(log, "no write support to mptcp_sched_data at off %d\n", off);
-		return -EACCES;
-	}
+	start =3D offsetof(struct mptcp_sched_subflow, is_scheduled);
+	end =3D offsetofend(struct mptcp_sched_subflow, is_scheduled);
=20
-	if (off + size > end) {
-		bpf_log(log, "access beyond mptcp_sched_data at off %u size %u ended at =
%zu",
-			off, size, end);
-		return -EACCES;
+	for (i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		soff =3D subflow_offset(i);
+		if (off =3D=3D soff + start && off + size <=3D soff + end)
+			return NOT_INIT; /* offsets match up with is_scheduled */
 	}
=20
-	return NOT_INIT;
+	bpf_log(log, "no write support to mptcp_sched_data at off %d\n", off);
+	return -EACCES;
 }
=20
 static const struct bpf_verifier_ops bpf_mptcp_sched_verifier_ops =3D {
--=20
2.34.1

