Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5953210B
	for <mptcp@lists.linux.dev>; Tue, 31 May 2022 09:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653988199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lD3YpcL/yzVcOCLcNB8pHFjVzjgYhkAYPu2g0JB+GoQ=;
	b=YmLe5rcQ03Gf1nzhzVtTlNgSaPPNBk70EY8TK2+Zc8OQQE6o9uwS8lsUBSjZpyQ9Eyy5yS
	tSAbpbRQ6wSJ+dIZugO/n8VbQYr8ImpwWLiyI+S381Ct5/juWVPBIONLRz9jZkJykTU6y8
	rFVGX4aL3O/eHUOOWs7A1Z2vOFMkYh0=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2053.outbound.protection.outlook.com [104.47.8.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-7-0Lb5VufSN2-CGjI_sC6EbA-1; Tue, 31 May 2022 11:09:58 +0200
X-MC-Unique: 0Lb5VufSN2-CGjI_sC6EbA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKdNz6kGma6Wgumoan/57DPPDPyKynYYwVbtdzo5cLHOcP4LdZS8Ee3ZAibsp05Awq5k+n48rHPAxr55gknY8j/7WPaxbOXjiFI1nGTBsF4VmvA92XBzemrMntwZpxFcgLJb9D8U4AD1VxhKNUtb+n1v85N3wu3Hgmcqb6PlAWq5FqN6/6OzSFqlwgNK48jyo6mKY4QW0UE7fkK+PG/a/i64veJtrpSby9rcGWs9+D+2wgkBPJ3yVVERdFjl/Cf7nruyyNOhV7hx3w/HGmv1YbuF9NyFdxSnurgvhdro1SOXME4u3AlyN3c7GY4kFRW5m+DGkrnG11RafiWLnSHSxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yqfZNBp2WMEMf2q4QaPVcmDw/WsWp+7euI9Q+2M5Ys=;
 b=bxfruuMrRHjL0HrwyPwc3Ic6KsnQ15ADyVrT0xhqIpuqWMfC2aJIIvr6pjuntezMxf9s8LCCxYtjZ1e+cbPArCUdI+b1fLIFtEFHP+WJZJIY7QA3n5BAElDCeT7gZHW/7izrJdHpRR2IFqYRWkRO9oZvVrqOdu5V5AFWSSiqb7b8LT/oFTyFSniINJd9OE0s/LQ1CQPFQoAhq66eS3DS1gko2EgJGKrZ9bGYKN68PEFhqaNSV8bYhNddZXe6usggWxW6LNQ/+ZFWSZKTlN6P0rEI2xOx9lRnlLAr279vnAdMP2Aalba02JXqPgXcJwWiREGva9ZryVzcAKvx78sCsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB4356.eurprd04.prod.outlook.com (2603:10a6:208:5c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Tue, 31 May
 2022 09:09:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 09:09:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 02/10] Squash to "mptcp: add sched in mptcp_sock"
Date: Tue, 31 May 2022 17:09:47 +0800
Message-ID: <0fde90d3ffd3f3a32f97714a1e608314baa5531b.1653987929.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653987929.git.geliang.tang@suse.com>
References: <cover.1653987929.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0026.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::13)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c63ce8ff-4323-4ae9-fd25-08da42e5552c
X-MS-TrafficTypeDiagnostic: AM0PR04MB4356:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB435671C924CA80239EAB1E22F8DC9@AM0PR04MB4356.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NC3qc88pTsCnJapDMUQFLYM3i/RdWudZ4wTND4B4+c/upeo6NnNCB0H2L4aQ1tktwejOzSrwQxREgQ9LSah5jLgM8QeysYQ9uDLUmQNUQhUR6WHqWe6mm6yflk9IqBJc1xAaOI1+fAHKRR8XVEbxIU2KrmK29LYFiSDZoy2j4nBBBTDRWJC7wWfaPcwPvGTO+C31Mots+6oD4OdV7dtZVRrtMZtla/jdk345hGDLHnI0xDUSqRuT2X1Vh8RfrSfMfLKl0rnAu+huXCzOIIIP7mWhzbeFCGL8Rf0nNeTOFIFIdhqZhN5Fb4vmvTKlTaLN4cy3QCY6Ob8u05sujbv+Ybqq2gVY/JJSpL894slp5I0Dflw8S8EO7BsmWEsdvH99QhDhPrSdl4DFG2V9nhwESh/Pp8kUbCKlLGltmQfPPsqN9G2n+OjtUI66ZLbCkqI/7KEf2XHQHNANoPIlrdlojim/vtx5KOrEpMpd/T23RN7HMpidYcvoAPJ33yePV2HjLl973DIoiI57jPIToqznJLTvPiW+prn5dJsqlvzX21Vx/VIo5hUAW5A3vF9/m/C6wZLky3IIxdwpYaLtyiBmZDlFh8Mx2adceIneQDb/PRUprD+QDzBRL7Xbow05K3xxFUcGkRL632rRd2x5ziPtl+Ib9txzW21EXUarGbaXMPFINzT3YRFhmfto3QeaYGSoUgxkc/CP6efeubslbodJJw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(66946007)(8936002)(6666004)(36756003)(66556008)(4326008)(316002)(6916009)(66476007)(8676002)(6506007)(26005)(6486002)(2906002)(4744005)(6512007)(508600001)(44832011)(186003)(5660300002)(107886003)(2616005)(86362001)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D+jl33I2MFO9eO6TpxkBfv8IujBAq5mamIQU/Kr1acTIlYCskaMgjRRmzGTM?=
 =?us-ascii?Q?ygV0PVbWh0T2pwWVLCqXxEmxmSdStb+XYE4ehe1ferBqJk6lzLDTSExZcBD2?=
 =?us-ascii?Q?fUAr8aem7cGFEhMWpW5yeg8XQ/JAL0Ra5sHHtaW9OBOiCu9xD/TB8rpetaJW?=
 =?us-ascii?Q?/gVGKU4+SXyoPLXH87jDauYArMIU2k7/ddqVjQkY+egK49nRBi0SkGew+Ka6?=
 =?us-ascii?Q?Ac1ODcKgEaCGjP9nImbt3cnM/FFtrJyROyEr0mhM6h/gSbb6UyJr89AY43WY?=
 =?us-ascii?Q?PqDib22VEQmsUbrbj5ek54c6HqeXjdSULjwcAwy7kAUxoIB/vpZmYjorwaUs?=
 =?us-ascii?Q?9MUJ5ccr299xyfojCrNoWe5NORynoz7QSRPkzN4m1GMaTmP4uzknK8zmHt0W?=
 =?us-ascii?Q?2owa+N1y88alIv5Bru1B0K+1p6P5YO+YvS/OpO/prYAW7VLPmlhKNUtFt2CD?=
 =?us-ascii?Q?0TIVL5OIWzzdVUyTKUMXhF7M2myK9Q0R8ZxgbVE2YEzMh9BLsDpAfYgcdu/1?=
 =?us-ascii?Q?YbWNiqJDw6oxK3Ds0jYX6PxE+94umVnLl5Jdb2Blpr2HMqP+VqTr5U4pD6cR?=
 =?us-ascii?Q?31PdnVOqggBamlwN/vBNo4+CJibHghEv/iog40jEUyWfWfV4FSSWqFnuvxNR?=
 =?us-ascii?Q?k5iD+9UilavSy+qKwzlgL/9wLy4jUz//NX8pPpBCWjjTG6eMSdzDZZBXrsjA?=
 =?us-ascii?Q?LWyh+S5L2TGZBRRwYhdyvHmU0MCk+TDYHZTSCgFzspQCCy7FkpZ2iD3Be+lu?=
 =?us-ascii?Q?ILpcg+bL332bYTszeyArx/XUbrF2IiGAXXPIeSnOP7L/pAWD8Vts3nDQntCU?=
 =?us-ascii?Q?85OXtUXh9CTmuLP6jourRpZspcudqFJUpGDmaiSoz+d3PFh/APdDHVL2CgwT?=
 =?us-ascii?Q?GL6h/OtnQ7su/4WTzVtlv3PBe8fJ+hqTyeOA4O5nkCau6X0/pDq7bUgDd0KE?=
 =?us-ascii?Q?7EGfOjh0F5gCS5YCd88bEVgMDRNixmbAUa6yN1lgWl34DG65ZCEZwvPHCdgb?=
 =?us-ascii?Q?AiJpXR6koLzqcLcqyyXX0/o/Xz/kuIp8X6nfyTfccu7L5uRC8eCAP+g6OtnQ?=
 =?us-ascii?Q?AB+1VjINcdw0R89Gvugrjix6oxXPNqdR2vGubnWfJAfJwDsvucL5P8xsmkwY?=
 =?us-ascii?Q?djKqd0OZ4UUCU3dlkTH3tbGVH31nPkgap+C01JNTHyVqGdsdVRtTFs5E0NSf?=
 =?us-ascii?Q?kzIbWEALSc3B8vejOUwDdY/QlmLQGJpnKTBDSP18PxZPKUiTHUMe/v8NnuhT?=
 =?us-ascii?Q?H0vRQNaILh1KLmFHYXc6cSfKfYMVrtrvbPjywDO8EXx0myXtNlq1tmKsLdIg?=
 =?us-ascii?Q?ujnBiNLekpCcvt7JN3ypVaVDAsANXpjGMTen6Uv8Kh7SOnzVSq+m1T0yrfP/?=
 =?us-ascii?Q?YxQ+SxQiRdj7CwfSXwE3oPLavSl999+TYyOgBxPoh6wN9KdNcv2m+lTsdewa?=
 =?us-ascii?Q?vnfDHxSzcvY7YT4c/TXBEJc9Y0/yuXkWpuigZ7TEr8n2BhKxmusbLs6+ybc4?=
 =?us-ascii?Q?wxd0anPgWvHVU7C1pjRH5d74IoayLXM6HjZysHM/gVxZ7ubjZgMF9o8pRXSb?=
 =?us-ascii?Q?gMxCJf+VH0qdBkGQSN2Gmo38GuMpyomf/Qra5IWuDTWCLx96tjd3sli64iTx?=
 =?us-ascii?Q?tNNeqNY7ZG3w0e6DMKbBI/IymcO1Yxk/T48gPBYhW8xXFM7HOyGpwQXjgI5L?=
 =?us-ascii?Q?DDotLfKIcMD8oN5gyGS8xI4/dC1EYZIwqMe5APy2zuG98Jagm+c2p2BkQbXO?=
 =?us-ascii?Q?HgneKkQyOwMA79dDPa75kuH4luHV1ZY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c63ce8ff-4323-4ae9-fd25-08da42e5552c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 09:09:57.1864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUurDdMB7iAMB8/V9EEamgY+rLp8dgJ8qXk+O8ALRoDNyxusBGmdU3QTLvcNJKfYKPnSKbB5pRTNISVBVovJpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4356

No need to export sched in bpf_tcp_helpers.h, drop it.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index a705054f38c5..870deb5cf5ed 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -258,7 +258,6 @@ struct mptcp_sock {
=20
 	__u32		token;
 	struct sock	*first;
-	struct mptcp_sched_ops	*sched;
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
=20
--=20
2.34.1

