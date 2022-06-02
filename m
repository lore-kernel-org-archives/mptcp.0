Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EA4622
	for <mptcp@lists.linux.dev>; Thu,  2 Jun 2022 04:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654145647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZTDU3pJZuBJPBMD34vhy3je0t96MMoQttyBTfr9h9pM=;
	b=UIlpZjVJrKt/YOaX6yFxsi5I9i9btFpzo/TpHvJQSOZbKahzkxBidm+twQU63+ThUMukR9
	+z0pNRWxmlv2+UAVGSmb2FtL8wUiPexiSiGy6sxxAKhRoMWGYiFDJkuytQRisFfL9apc8B
	G32Ho6p9j9At480dkWOvbMmoATEp8DY=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2051.outbound.protection.outlook.com [104.47.5.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-OFX5vuLpNqqx7_9vPjdOAA-1; Thu, 02 Jun 2022 06:54:06 +0200
X-MC-Unique: OFX5vuLpNqqx7_9vPjdOAA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CptT1palNcdnb6sOOfdLdkBx7tMPU7ZRk0LdrNYdE/Jb6X2hBJwwOa5GtKnWUybAH+Xz/7Qw3xZ25rwKb3czTeArYxt6JZatYLb4BMrP0h0lhjHjQ+lCDwEh6UfmnszYMnt2JOIA2ME2E4iBpeFrXXKopvQtEVjD3sUbXc3zBXK2NPr9oalDJaFlHZKI5jeuqYxVXukFj5aLzQdlyhxEHZifDkF80cerfxjebH9PlMMTuIcAn6YJ130t5SG4XER+OI6nBOhViOE1CredwLG4GoetjrApb9GeAuHRWVJyakXR+XXgJcdoG89hi3H35d2ieVcaxffvs05RC5PPn+qc8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saTEpiYuGlsohQICBKTIJXmaDO6umunA3SFBmrZpKXc=;
 b=YHHUF/BEkvG7JfsNeNhuu5VVPMhAuD+mngz3CuNnMH9z0zrPeaLLl3dsqdzGz25IYppQ6mbFntqgR85HU2RZPSOUdXF7/L/zqOtfLaVP3AxhuWp53c6zhHRuCxP25yXo3Xsj16MO8isa/RmEwzbGhhlp8LNYDS141Q3GvE2Wcmb+7c3xXErzci8Rq44sKKY6oObc+BzBjNkQQ3oPsyBb69+c2634yyaPwZNilpvnbV5/F4sNG92+kd03N0PsdHANE93T5OQ+OUSvgs/xwSjtF6IaLBk55LBTEZtGV3F6/bLYXWaqTW7fn/Atu1GAnIupkJ+sSoF6oAUSd5lTrvbteQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR0402MB3384.eurprd04.prod.outlook.com (2603:10a6:209:6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 04:54:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 04:54:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 02/13] Squash to "mptcp: add sched in mptcp_sock"
Date: Thu,  2 Jun 2022 12:53:39 +0800
Message-ID: <a254a9891930589d355569147e30045eecb07585.1654143895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654143895.git.geliang.tang@suse.com>
References: <cover.1654143895.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f814b8c-c5f1-4c27-2f52-08da4453eb27
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3384:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR0402MB33842D4FF70EBD2C2156BF82F8DE9@AM6PR0402MB3384.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m7UKSZT5eLGJRs7whyNoZKKlCUn0iNTa2njJ85N+J1NDyw3VZYO930EcbCxPMWImeQQujh5lCCxn4xrxVVj//99qs0swKVS5ABD2Cz+f0ITzn6HDlqCWl4/5NwzRleqGtPctO5DTNbAd1byx+mL5x05NtxyIpyH0WBduXeaTizfhy6aiyorsHwHtouzvF6pL5sIUOgeLmwo+X8KR+yv3YrO+v78fBHJHrjtJHcZaKvO2eXC7iqHvPw6derFLmxZgtbdD43QOKoeylkBAKB6j9eaDw6o0dUIrpKE3xF0zahbgIsC1Z4pwV9ZxFBaZkOkyI01PYFtnB2RtLGvBIlyhMK21M78GSvJjPT9Tm9H14MZUj58c14o7Kde2/ihyQqZ1yhI3OVqU/HJAQoWtu3Mq9AV+z4LlsJMrbjQbTfADUkjIksafivlb+inRp3AWA5s+E4AY/0Bf0deW9WzcGoyWkrLf1qmvyCY87O525TckBNwxdDKAIUk7cuJOkznuHcCJ15WDqYG+KBKUP1yTX4Nwdza8jyOO08yc3fwCrdNMHXc5vAURakUXq+1RG9xHTjQ1FSEbikP6MHT3MKLg6R7UQ6c91D6hedE6CbwDxRhB6meSAAtklOSJZIwCEpsZSTIaP+XTmd3RPpJ8tw4nrD6lMFwETymL2hmvuFpOYfqpNPxCmkm38km0zLNoL4o780f0/0jaAOb6mAN+BAY/DPtvFw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4744005)(44832011)(86362001)(83380400001)(6666004)(8936002)(36756003)(186003)(4326008)(2616005)(5660300002)(2906002)(107886003)(38100700002)(26005)(316002)(66556008)(66476007)(508600001)(66946007)(8676002)(6512007)(6486002)(6916009)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KGkR7qVpqfci7NWcI5MfcW2qJd3CxT2DlwMGGoSAfq//TQdDMtvhwo0SFKyA?=
 =?us-ascii?Q?ZhstUj9EvMZVPz1/7BXis7zef3jESi54e6jG/By1aUhX3TSOiuN7EqxAFehX?=
 =?us-ascii?Q?3lyxT5YSHnxcobLJ0KJYX4nyhIqe1EGXHTyM+zIskNflYTDA/eF7AYYVlc49?=
 =?us-ascii?Q?QJWLa5RzbhJvnaVQDl1pNkKp9QZ28VK0jIxDYYAeinBA9DihQWb1Z8LxYrgM?=
 =?us-ascii?Q?gBT/PK6ZuXvrw+Mgz1c/oAHjnSWwgvE/EUTafK2t/HEYVRZaoXZ1ce11P7Ow?=
 =?us-ascii?Q?kObYtbHllJXonHgpGkjV6xdgTpFh3Uf5NIx6AZdelNL9eWq/SefTh/wfTYxP?=
 =?us-ascii?Q?n+Z6kccB/qg6XIiPRchD3YRdWyMgGhp6wY2nDq9NW2ZffVbGTcwMoEvEIIzb?=
 =?us-ascii?Q?S07QxlecRMLl5/cPoYDOVYLLZcGdjFzOw1IlM/G9bMmyo9xtBKUJFKXJPN3c?=
 =?us-ascii?Q?7HItskdN5AOYQqjkHIzvGRC94kp36SSnTCDu3UdjZo09e471f8PuQWfnBdkx?=
 =?us-ascii?Q?viXK7UmoFL1EIUWHs69r1SIBWZQPZgDG1BmfkVgeeNpzZPwToHdY+rxB9v/R?=
 =?us-ascii?Q?VCOnAAaPMN/+JhyjWbhqvs6E/to3FxNRJ2fhLcNoQDU12Gxy3TQOGRVxVxOq?=
 =?us-ascii?Q?/JYmAy8FnW//6hSTF/2wx51RJ2XngZNU8xzMoJetaDi/7kJimbf7cXHIoQMc?=
 =?us-ascii?Q?fqlorHGHnYf030mAdupc0fjnqV1Zw+V44MP3/uCpRgsQlqgnBskY5yiGURR+?=
 =?us-ascii?Q?mkMnjf33Aq21ktBo0RBDIh1PoxKCFPq+7ZoiAU1SisxLvAAGjE5yYAkZzpSw?=
 =?us-ascii?Q?lx7rzAEZnBu3jObUCBl3OxvxIlVH4QQpX6cf6YOXR4iEEWz9Q6G0g8bVUBHW?=
 =?us-ascii?Q?yK5B8TZqint3neoZcWH7iIfsoGuJaOPwr0IO6M4rrG/+JXfaP4tNZI2n9eXS?=
 =?us-ascii?Q?OtFNvROlGgvC2284JFYa4X4jumBNg8V0EGjsbOfraG65eifIn7/ubQXzHb+r?=
 =?us-ascii?Q?FFfmdFtZczbD28pvFLpAitBhLlgvt6qXwX7nvf4s6tshazOYO3Gi804TLOGB?=
 =?us-ascii?Q?AIhTRCtO+tmyz8iymYMzmwhcEWDWe6nmbmt8Loa+R7zymQzDrT6tB6eVWFg8?=
 =?us-ascii?Q?yEFBjcZIO2blYhwd8CohCfTx0Ddm7pAdX4dyrxJ8e7EOHqwYJ93Z9f5EGncJ?=
 =?us-ascii?Q?YQuCiQUU1PVZ3mgJv1caZ4mS7vO20RBtB6xZCOdo74+uLEPiVsgKLr+Yd8AL?=
 =?us-ascii?Q?MpKR93dsxfCHOoO7Ebb5wD7YSk39bVDxNuCQGTylZqkb1gdYDRg+6h5S01kM?=
 =?us-ascii?Q?5bERErtBAp6A5JMCDZVXs5P26AakaoCllvuZtuj1hoqFlyV3Rqgzxv2x4CmT?=
 =?us-ascii?Q?LJGHDjKhHw2HB9pZE09QFrn37iYm15/kqEYWCwUmflTW6V++SifB18AbSzxd?=
 =?us-ascii?Q?xLMzCHd452dgzMUqca+j9J2SNi8ksCnKzN0sWpvZUb+/GEN0zNrU/Es+Xoad?=
 =?us-ascii?Q?M2esiLVESQBniqB4PF+/K06PPdmS/l+9c8mLuMfPl2L85D/AN8D7PPAZmYNN?=
 =?us-ascii?Q?3OdqTjlDREcluvQ0AK0XWtoyoP6dzBKgyDIfhxwv5Yxd4yymBZT66UsjHugj?=
 =?us-ascii?Q?AZ4+vIOgxPhfmAcv3UpeHbqoQj8DdePfYAi7HZAFjh+6J/0RhMloK+3dZkfg?=
 =?us-ascii?Q?0PvWg1dfQmokkMQr5sjiPp13Gs0NGmb6hocBSRey4dDBIg1kbO54b2PEOmXQ?=
 =?us-ascii?Q?uq8QwRc4yCpk5KDrPiC0qww0wnS4RGk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f814b8c-c5f1-4c27-2f52-08da4453eb27
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 04:54:04.8284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgUQDe49tSrD93wGKDccsjbUOlD4SE4hm9iceC3YiQ+C0UokN1KNqxg/eb1QFhlbsMDNw48AI/nPX4jkVtX2kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3384

No need to export sched in bpf_tcp_helpers.h, drop it.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index 65bd2c6ab1d2..82a7c9de95f9 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -235,7 +235,6 @@ struct mptcp_sock {
=20
 	__u32		token;
 	struct sock	*first;
-	struct mptcp_sched_ops	*sched;
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
=20
--=20
2.34.1

