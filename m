Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA3A362
	for <mptcp@lists.linux.dev>; Wed,  1 Jun 2022 06:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654065976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8XVEh+4oohQt0XUMdIgg5ktNgzeix+uZ6ytucP5wyv4=;
	b=fDHrm0qzTEl4kooqJ7rhf+1YY9V3DULv7tYtCZdabgidXTeKq3W38Xj8eukOGJz1WNVZU8
	LquV0FkLXhNS16rXEq7lodnzReynaz8SXBgRGJ9iCZg5oMLIJ1ChScuD+qysV+M3wzUbfu
	x5qSGQvOEqm3szotH08IyGTeLk4FM28=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2056.outbound.protection.outlook.com [104.47.2.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-yl3cy-C1Mb6-KKRdK5vFeA-1; Wed, 01 Jun 2022 08:46:15 +0200
X-MC-Unique: yl3cy-C1Mb6-KKRdK5vFeA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h992yLCehjkSWBj4Tg1zPTImx547k4pU4RCOX32278VyDAQx81hxmcCBdQagPt+BWlRiXZaHNDzb233QcEdKijOCEmGk9JpivDnNo6V2mmLIv6CUm8bgihlOPEWPUZWbuUg3hyjqFT4M0cZ8Y3SJF1Udfam4Vjniy1oKNUQgUjQ9c04oc0PGixVCdXNtTXmzU/OGqn/5LN7s+64efVw6v6czbRNSDqjfLXqH2kg4iKV2NaclF47W3oYq5JGBu57XukxyRwPH/UPowIT0fu61NKZ7vbnHmc5TJ+2SUz0cFILQI/d/BP9BApr0XDSh9CK5VAanKlrA+XyCb+H44QBngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTZx3ll2k3q1OqI0daXsEaVA8G+mDbxRVrj43jBmfsA=;
 b=fKc2AqHHPNOB25FufOsyqPK2D+SWDdIB4QNClkm8Mgsfz/k51wb0glttHB+KpHzvmijfvQ1wyJqxMteA3RASV0eHTQkCi9QwGc6y/tPXT5ZNawtw8gm1LZu89poZUO2HxHBgIesWMzcn2CZzUpses+QGQQCUvyr4RJ3E5udBvq4R/tDkmOX9OeMM3I+3j1pPkXhj9/TmwnJYdph5yIsJzJBdo93kq31B2trdx4qRF6vhgt8Sov1dZIj8vTGWX5nnjpw0HJmGVufvB3NMoxKpv/Llb3kf2pSF3kobFGcsFU+TepcorU0+Fo4GThrGG5kyVGajcJHV92EEUdePnt2Ahw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR0401MB2434.eurprd04.prod.outlook.com (2603:10a6:203:35::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 06:46:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 06:46:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 02/11] Squash to "mptcp: add sched in mptcp_sock"
Date: Wed,  1 Jun 2022 14:45:51 +0800
Message-ID: <4032935cf852a5ba37ccdbe925f063967cb30402.1654065674.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654065674.git.geliang.tang@suse.com>
References: <cover.1654065674.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0070.apcprd04.prod.outlook.com
 (2603:1096:202:15::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18e6160b-e9fd-4ec7-1e1c-08da439a6c0e
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2434:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR0401MB2434E4DC58A98D72492FF63EF8DF9@AM5PR0401MB2434.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VwZ3QxeWfVqLRYDfeD0Uhk/1KDiq5R9XhErO5QEmu/rXqnjg8tCPe5hhbEviROAEQ4Wff3pwyqEF6eCf5ylnRiHO2pMe4KFqflBTz4e1cpa8s40Ni+71QMz4e0tbHO9UrPTbH/LBCZ8SGS5rk0u1BRaG3rULcKL/AwjKWx84vCSc37Y0VntuIfYdLut6Ql8EzQsTtfZYwIlZQUQ86BovOQAKuK7dKoPKHZmVrg5dSnve/z5x0M9TyEvaOLJjk35298Z1Oq0CQJyPUPdWkRu20uFKY2QwE40kHfQRy1DY10L/tK/4gPIHtEkn2AqwcvedJQUVwQPeSAiaFkV7pI+Sf8EGRBDM/5Xd0JbKtoNySx8jlLhwIZFVKgu0E5FIKQlbZnUaPNkLUxcJDxUosE3O6F1WpqWB8UBdjlHTyCtgDA+Q5BXDwsZi3i58UDkYJzqOBBLNuIKjSuDW9uj9tQGd85U846/tJ/RN38aXlasPydZjATsUUYzle2QKV3xf98tNlSGsE3SxQkBpktWoKbt3bsG1nCWkMqidIYahXNSi890EFtMiEL2DGvNooBrfcruvwMdE+IjEtYYPB/ujPxtoIa7NVX1V7mkqkS2TD6RnK1QNvTBQr5NH4hVVKwp77gY6v8dU3hWckpp29TRH0m2jy/sJuYa7yzK8Q8w3htdnW8KjESJmboxXtEVEndppia3CQQYxgSX8HoZaK+auO7zIUw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(6506007)(44832011)(508600001)(6666004)(186003)(4744005)(6512007)(2616005)(107886003)(26005)(38100700002)(2906002)(83380400001)(66476007)(66556008)(66946007)(36756003)(5660300002)(8676002)(4326008)(6916009)(316002)(8936002)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OsgMbqe0wokKAavJLUW4UYMey7iuEz6/Ghkb5Go2RKMq8MBX9C8G+o9X0fUa?=
 =?us-ascii?Q?8KlJlnTF0SQTxmRYIVizoenpJ/KzFZJSqwPX0UFMGJgVrvcWaFTH/txIo/uE?=
 =?us-ascii?Q?KSNM/ySs7Fdcc9I497f6txXFIgAeRSdXFB/4EsvjdgW/ZnWIQsfv/oMWjU+c?=
 =?us-ascii?Q?oSvCFySlhj0z3CmiEu2/I8S52NQNnDox/FTvntsIN07x5ecsxJvxeS9Qd9MK?=
 =?us-ascii?Q?SSGJlCp3ekPZTxpoqNlllfMUpK2liW50NJYU00A8ViHvYUwCc6+fpsYGzyIv?=
 =?us-ascii?Q?eh4Xpck6cFBxpgnxfZLvSZnu/k9WPOSaxcKraynd9bf7HudlttfxSZPBK2Tz?=
 =?us-ascii?Q?ubwPY3eLpvwJaP8wwjQLudK6Zvtc1xuWcgLJwGzbVSCd4o1VCyCVwfwYwdxX?=
 =?us-ascii?Q?9uoqtYWsGYHopJYx56hcvCwO620DOBz49Y1o1WRY9k8QjJRIyVBdOmFvVrqO?=
 =?us-ascii?Q?6/gNLqgasYFop2k98PPN8A01AuI/bjwnYNnnGTRtLelF+Y0Ma1R5w2dlQ38W?=
 =?us-ascii?Q?U/W2P2/pNMUxJTA5qn1E1+pzyMPT9QJQ1ZXle5MnWQJhGpW8hydI3CYzNPjB?=
 =?us-ascii?Q?q+dIONXXSrUJ82NeExLuLW3/262bmWU+PHwldc9tKbm5Fgx7hshlneE17uvK?=
 =?us-ascii?Q?Ibd4gYvaqxZkG8qnnlQ+DAbQm8qI7fZbFU6WO+lQMOX5ch4aUAv2EsFNNCqI?=
 =?us-ascii?Q?+aZiyRDsjNLz3zt5YTNHknBMf8q7N3saao/vJsb8xg3jWmQ9rgnZfYcRYXqF?=
 =?us-ascii?Q?pBV5WHahbNySXEsk0HgOpN25gDr9ATRP8VENEr6qbidjjSPYuQKBPySaCHe1?=
 =?us-ascii?Q?sQS4tFC401qQzhhi4XMsRlmqB/LazaA9HGusipO7qobwkt6uq6rNofrgVKWB?=
 =?us-ascii?Q?sJyFRD9ocv1pgv5+6SVt1Hp4g3Tx26pU1qtxel66uyHy/WEvs4jVg2Ur7cKq?=
 =?us-ascii?Q?PQCmYt56g6W63s+u6jbKtZEghMh3scdDjafYsJcXhfrVVMTXSwpr/6CEwEez?=
 =?us-ascii?Q?6/+XycAZ9FWmVS30SRAu3ljsqp7mzpoOl/mPgW4QmnRtjGbxcqJTYbCn/2zu?=
 =?us-ascii?Q?ziCSD26VO7y2WYCgjXT/1aAY1+X5v9kzXXs2+RYNjoYBKnSqzsRodW1IOn/B?=
 =?us-ascii?Q?eLv0UXZhbVkTelGsrbEaYzEICDZoIznNXCaadKLRxlpa/pLUGBJqBrVx6Y2e?=
 =?us-ascii?Q?04wjhKGoGTzO32ReM4Kter/CcfG+8q47pO9MFHS8W8oK+pPbwik6E6J0HMdz?=
 =?us-ascii?Q?2paAaxU7wCPf3f9tDMiRRzN+K+RvvmLdb1Mbe529DNLwLQv9Igxg6j4M+HE+?=
 =?us-ascii?Q?OD6sIMGFUSQh64dou5XvwBowmT3PXozX2aSnAe+HUgTcam/wZj1DAHvGUaxn?=
 =?us-ascii?Q?qToL3hm8mj8BmMux0EhmDwpiy1+J1QTHypmy+kMY73ysEha72XVX+qB20pTj?=
 =?us-ascii?Q?cmpaNbwi7Tb+zxoio4umJrkM75gPGSMzK0WMNDMPtkm+no+Z7CKwFCfS1DAR?=
 =?us-ascii?Q?GpD5ZUuP69sEA/i5/XogmQNxBBhC2EEGg37pyna7taqh0TEx44fFaBMgqBIN?=
 =?us-ascii?Q?m44NsuZaRzrueKP0Gx0uufweF4ILyneswyVeGQzvKDKEC13QmA9cXwvnqEx2?=
 =?us-ascii?Q?u7mw5YNh8eiAIFeCG+zs2u+chsgCEpBQSSzYYH8+AFw4Qq/sU4dUL0qtjFGh?=
 =?us-ascii?Q?ml6eQ5IWTf4SsX4oE50w4ZyBYHLPMMVlTYsgwuP5P5KHtToP72pKo931d1/X?=
 =?us-ascii?Q?GqoY+abOmuMV8ftCaw8k/5a2sVrPBbE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e6160b-e9fd-4ec7-1e1c-08da439a6c0e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 06:46:14.7141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /NS6GFPai+6zEzf7s568kBa5ZwP7T1gdJWEdWqSh8GDQacrYoBgPeZ7afBzDgc7EJ83h+OAUVr5MBTZrvFHqoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2434

No need to export sched in bpf_tcp_helpers.h, drop it.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index 8338c7b31f87..5f6a7fa2269b 100644
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

