Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F1A48D0
	for <mptcp@lists.linux.dev>; Tue,  8 Mar 2022 13:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646745948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zsDogvSq3EWew6moMNNHUz1kjidAKeXGVXU13loJeRM=;
	b=lfY0Xvxz5LDGCZIHrsaeJUDeWH6eDSkO38gV/imVGNXl0fIekTB0eeVGa5dgwoB9RU7Nqm
	fdCLtcVutMzPbW9LZuY7iCHjsWHbPUju7ph4sDQL8IapgoxWwg3WJCii0n3x/b0jfaFFy+
	ZboxPL5aZZXq+n1YOrZ9LnrAj8wHajY=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2059.outbound.protection.outlook.com [104.47.13.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-10-3-PyU_NWOdqiF-uOondPGw-1; Tue, 08 Mar 2022 14:25:47 +0100
X-MC-Unique: 3-PyU_NWOdqiF-uOondPGw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clwVW0HbE6YQ3TCQkfWYpGbfNjGW2BrDt6riqraaOMFIv/YKi1OLDMrEa/nvPtp16FJ2mFeuXEel0rqjlTM2QuuXgC5Dw6M8Z19kegWSo1o4xG+fjiYSy/FI5dbfS6YeuITfnoOSKhheYSySxiZ0zFkPlUjByUZ+KafhnH/i+YCelBEIOiW1WVz0SDguYUoLJ1gGH4tlwEWnJCrRhJyy8+1kjE3oaTZ9mi4U/TQYUtNZbrgSCRY0QZ5JMWFsvcx8AmS+b2kB1zdJY4/C7MZ/lu4rMvFrxKxsQi1ZxyUhKldmgMdxaUTgPZd1ts+f1gKxFZF/ZCFWVWKKqWDMLiU7yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uf3ADHCE5PAVcshxqbzaX/INh8wU1Bu4igZ6RLCOYE=;
 b=hkv18v8Xf2gUPbXQHNil3YVZ6zYGkswRqeEahLWmcWDXW/BDdH7UKVMAgy/XmWiEDsbH+7S/JDo3MViCnxyEBQge7NFs1X3aXPrJW9Fgg5mOy2ky0TczoOQQxPTwjAxx0ed2SiHP0c+K/HMYnKZTOEhRDqabjV0fOhbAv28d5sZZtacDxmkQSyHafBPMk1m0ZO4npDM8tUkYPrU031yzvkb7XvSyLdumVeSHwxW7IeU0RT9Ht0PyAjHZYJyuuHBQs2IVkINeeMTu9YQZDztoF8NnqVpSgsAC/bfBenMqUfbY7M76n6tQxM6fBroFY6QIHTEl/14CwhF0hBkv7Llo3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7777.eurprd04.prod.outlook.com (2603:10a6:20b:236::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 13:25:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 13:25:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH] Squash to "selftests: bpf: add skc_to_mptcp_sock test v9"
Date: Tue,  8 Mar 2022 21:25:41 +0800
Message-ID: <b4ca2a54297c51adf274f3cdf90933c2ca13764f.1646745892.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0053.apcprd03.prod.outlook.com
 (2603:1096:202:17::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0041f117-b753-44ed-76cb-08da01072713
X-MS-TrafficTypeDiagnostic: AM8PR04MB7777:EE_
X-Microsoft-Antispam-PRVS:
	<AM8PR04MB7777542AC33BEA1EF1EC81E4F8099@AM8PR04MB7777.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2ExOamm7NvtMr/dEI1Fhf9fLuO8SrkWk/BvdQJQZl255ocXB4fSHNjTdvFKzleMO4Ign4U2ZnujwAqg32/CM+nXTwNsaEtetzugQjkSHv0Y3Dkm6jikNkKFTdp3sWrlE1sCS98QLHSJqxtBO2o4IZbKFXWrkSRr5/ih5S3l/HVyzQbm1ab9jwRUF31jIUqsGXZj/QaG6R9KxLGe5PshYJW87n9PTohe5GEsM1gLsFdeOz4/+NtHH72DqCZu4HPjumfWj8A1Pi0rVYFCHxs0YTkM6MVIifL/OMWAhxkutZZsguy6/USDsh6/NFZJ8bmOFNFHPKm90xQ/ehhdxw4fXwAr6MUHrlC5VWvJdqTfsTgC51hECi4yuGf/z9Dcv8N1OvAO/65KjsuILxDQiLBSHrwqafBKBQDD31Pcf85bkgYu+UYgdu1H2m3dgQ03iqH0bym0rE1dJKtGpkmTe8R/BfxLxVZ/lZgdi5O1l5ibtTjxtTukcWvNHEBLW/nanzbmOUoacsO1Ug4etpAwZHXGWt8zIaQ7V7rkpCDSKSzeoVPPpcCFxLAYlKziMWaSCI5IeSUJCVVHEZTcXZciQMeXvO9riRzKQf53i10CSG6Su+M3dlkexrxMLGb5OghcAIsqgSM2SYhXUaIX78F/wbqFHQPGRJKCji9whp/AjzsADRoMvqfgOpun6Xb+fHuS0N/HqA228wEkJLAyFfzpr7wfS+w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(4326008)(66946007)(6506007)(38100700002)(66476007)(66556008)(508600001)(44832011)(4744005)(8936002)(6486002)(5660300002)(107886003)(6916009)(6666004)(2616005)(186003)(26005)(83380400001)(2906002)(6512007)(316002)(36756003)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u7FbV3djruH0x82I/g98Wt6/DWNziF01ozCkVHQYcn6ifZDjUOoFoLibq/cd?=
 =?us-ascii?Q?WercSekfzIUv3R3KPjmH3qJI29lhqbHYB5jP1cF31sjnwQhm/T/dMiDNwBFj?=
 =?us-ascii?Q?YbjBe83+7yc1GzORRgQCIsr3fHfKMMa25s6sKfoW3n3fuGml10YeJJ1o880u?=
 =?us-ascii?Q?fEuSSuZJXaUWxF7+3I2gt+4T5+MeXdjrzqoS7TDez5Qe7pkYoca2lcvvsfgK?=
 =?us-ascii?Q?bH3p4dWV8d7ADHV75loGqkBdwJ40W4MhjVh8eAnDSb6UcuCTr+3rcxb5dZL8?=
 =?us-ascii?Q?M0edZBJJablNdSon/cyBy0b0D/IdGTGP3/ejvRq7kspyaH4hoiNTMAUYIcx+?=
 =?us-ascii?Q?jsxmOq2V+TaEtuq9dunhJajHZc5i7bf+lrGGh7uxHeMEw2tB6d8bnGFnWYnd?=
 =?us-ascii?Q?npwQyVakR3bwFTfkYChrl2wo4jX/7IFXdNwBXHDQPcow3547xMdya+EFh/U5?=
 =?us-ascii?Q?Bgjb/F7QxbcBrbXvB418YJx3wgcuvSGc5IxO69N23Pbw+BDTGFgqq4fyxSW9?=
 =?us-ascii?Q?iGfBAZ2rWf7zxY2n02yVs1kwLGy9jH1QyVUitpXnAxlVOwKpxWuH6YkTWkkA?=
 =?us-ascii?Q?+EXReV/x3zzhYxqsRekHVlIk6M/1SJJ/OhlSBg6CW3yJ5jywDL0JedtkNudh?=
 =?us-ascii?Q?4M+JYSaYhK46ewK7Oa3+ejVFo5Ittctk4TonZ8QcYQ+KVHJPUDk0LqeTF45T?=
 =?us-ascii?Q?UaINQ67a04s3nVjneNR2/KUJfHrkl+gdi6XoFEiC2h40ZUxKhsAxKH0F1eXm?=
 =?us-ascii?Q?X2KWk4SyLwbSl0E7rK2VqTiihviPJhBbIjSOjTKfuKltY4wvNPTUywP1r4kv?=
 =?us-ascii?Q?rQ/WqieDi9OHsVr9NVWpysXYj+SnbgFZBPY1lpLVYu5QVXFGNbQOB9QMOEFX?=
 =?us-ascii?Q?SE3MIWIcY5+Tjh20YRbq2X/ErQM+jqUoA/ZTWngbZ+qVPZItHe5w1nhuD4MH?=
 =?us-ascii?Q?SDzTqSOGf+Fzl2UxsJ/dY/7Vjj6QbXna1jM9K1ojG3Ish4Hz8fJE4uWZeH/q?=
 =?us-ascii?Q?CjPkkSu1+udGg3pJxNGpd8iH5wmRsFzIw0T3ivxH4TfAWxqC3m1MSmwD0fRT?=
 =?us-ascii?Q?zAuZqeWlAbhaoP6/06XN3b9AlcrIp06RF5vETfaN92kbx4jbnHFb25orSp/o?=
 =?us-ascii?Q?eXsNKeffv92/qJ+qIYQlY50ZkyQDz9Fq8URD7yzCb8TbAqRUUCw+Fgj7EC9g?=
 =?us-ascii?Q?r4pijIk+KdO9vhFeUYmmeyYnaTp6dggXOk9Q/vUHNCCANGWZhhbt15P4eXOe?=
 =?us-ascii?Q?3GIeviSYETCiDiHwAOfThmKO8yI9X3yKH+H210T20IGS4uIdjGRhHE4ergHC?=
 =?us-ascii?Q?/SHjIanItO2fBc0ePR5LkgYZ/+o9BA0ji6YMkljaU5KuQ5wY553c2q8gZgsG?=
 =?us-ascii?Q?S4eahHKSVtY2Db7A1/FfqHrn4hhchv3zBw2qvhposWgQwE+eyEbDbw3l4K+k?=
 =?us-ascii?Q?ag8YegVX1RaAdS8Gn24G7Wgw4bfdRD9fH74c9/ZdzXReLCBHuifjVF059RZV?=
 =?us-ascii?Q?MGjBiznk91O3MhA5auwDRBEvZlNzrDvjPsc05q+axw5Fy1nH37DiA21z4leM?=
 =?us-ascii?Q?xgIXkNgMQxyi4hvEKvulAHyeVmfcIyZFED0zkYzKL0JowlA3mq5u0pGM17e4?=
 =?us-ascii?Q?9dkd3p1mqfwGcNPDYPzliWQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0041f117-b753-44ed-76cb-08da01072713
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 13:25:45.9269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FjzxQLK5QHXkTof3J02FYxyK+xOxvyYs1hCavYHciizqTkMCeGYfsmHUF7aEb9imz/boOBhzhwGPZi6Hz+ruUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7777

No need to add '\n' into bpf_trace_printk.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp.c b/tools/testing/self=
tests/bpf/progs/mptcp.c
index c429b6088832..b08448a12c02 100644
--- a/tools/testing/selftests/bpf/progs/mptcp.c
+++ b/tools/testing/selftests/bpf/progs/mptcp.c
@@ -22,7 +22,7 @@ struct {
 SEC("sockops")
 int _sockops(struct bpf_sock_ops *ctx)
 {
-	char fmt[] =3D "invoked=3D%u is_mptcp=3D%u token=3D%x\n";
+	char fmt[] =3D "invoked=3D%u is_mptcp=3D%u token=3D%x";
 	struct mptcp_storage *storage;
 	struct bpf_tcp_sock *tcp_sk;
 	struct mptcp_sock *msk;
--=20
2.34.1

