Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E69D7E
	for <mptcp@lists.linux.dev>; Thu,  3 Mar 2022 15:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646320972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VvcywR6p2XfTN8FUEU8U7MzYiR8l6ylPuzdmakN+YBQ=;
	b=dDAbEFooFAyuY4Zc1VjImlSBh+Nl3gEiiGE9x1M8oZZS9MRNHO9sOm7Rl4tohgOJaMX6Yn
	+7r4WP9znvw3fODOtE/7/7M5/pOWZ5a4FKcRfNiB2P6Xeqd8HADk0zbuBTXRYDmpIQvQ5Y
	Dy6CncbfuVBnY7JmoJbzfjdfJ6SLtPY=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2050.outbound.protection.outlook.com [104.47.8.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-lTfBLevTOJKgeFeAb7eaQA-1; Thu, 03 Mar 2022 16:22:51 +0100
X-MC-Unique: lTfBLevTOJKgeFeAb7eaQA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TemjVg9uaUdxO3ya0I/Rr0d+eKMUPJaiNQ51R3yVdsZ5Qvuwe7HC7J5Tq7Dh6ZuQqrhJRJ/1baLVISqBuLLTf+oS06oY/qJq08IS5n81AFkiIb0ZTJCGVjdoKQgYukWGCBmnPmAnikqLLHum+sdHXCjciBYPwfb7XQKxfXReO4t7qvPWV2fV8TehdDtJwkgY77jJDp6eYtEjKA7rTDYzowuTTQeajYNadD8Dak4dbSRYrujfA8UCQ3QWDZqQYZFw5HmeAiDf9JfxzU5AT6V8nCF6GaDAaUQsrBTL8bO5lhc8nT0YbCz0AhE8EDICdNPDeeSByReZl24GZgAD1XZ0KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYfVpA3bPFzuMpC4i+zQIWLhsGiIVeksUn/dpHOhKDI=;
 b=YSveAUMzu4BMkA3JnBFnexgy1NL7SBYD4An9pkUnNRUKCET4SLEklJ/2AMv6ggvlVg7juodSLr7Jm/NseSMATNhbPDD4Kcm1ZWsD6BYsIlAUA1UuONfHjPzs5P7Hl0He8W+NypTK5AFhEkAd9GqmGFd8dJ7iSIqGaOn4mhmb3OrOUnyaUXbtG0s11HVp8RMX2GBzlA/1eBtI8noyEP31vBNffM1sfEykiXT7O4D/158lkR9Z+81Fg9hof8zn8epgLRTaKyiHJ2C1uQacpl1L+Nb7g8KVB3LLdYJF291gyBW23KrByIp6kQ21u1fkJaXqQQ9SpYuRZ9qCA9Z7z+EbgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB3213.eurprd04.prod.outlook.com (2603:10a6:802:a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Thu, 3 Mar
 2022 15:22:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%5]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 15:22:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v5 0/3] new bpf_mptcp_sock()
Date: Thu,  3 Mar 2022 23:22:35 +0800
Message-ID: <cover.1646320786.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0002974a-179a-434e-18d9-08d9fd29aca2
X-MS-TrafficTypeDiagnostic: VI1PR04MB3213:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB321325E9020DCB72ACE044C9F8049@VI1PR04MB3213.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qMiehPc3UEaNaX53yUQHaGFRrjFgfvseMjbmFdwFgP1yfsDSmF4FHx+lbIb58ZV2a9em9dpYvA8SZ0LyuWnkq05OQxdWh3uklxh2KojuVMHD25R923Awnjc5xmIDH169r6QR10S9XLCxYMHxVCWZm0iycw+poBC5tWx5hCdueUY9h5oL36CsfTOb7MPa7l4MOcpMhBnZMF1bP41xcw7qiiqWm6anxLzz0lMzUxrXF8uzWpDXNCDRYuesnnbpbOynvBkh3NZ/WbjQSdhoE0zosZTubZDuyMPNtgN3zBqTBrb8pN6gq1PTYXof5AxMpy4Fav9iU8qQ2FiNozrNgec6BmsZpHP9CLwOVXofMnMApNTdFUSDTDRCkfYvvqssixMO7LTj6mojtGwgz5OxEk0OYgSXdw3hySLunHu90L8ZALRE4JFFgXIBlnM/LQ3aCrQroUAjivAQXuEI+Y03MytfakWi/uEUborlLXhyMhE/BC+UEqIwG8+ycq0Z5r/NdE/76I6XOn2MWogIyb8+LQ8P367+2e6MGCJQ+bn51G1mhssYpmxducWA5B+9Ttghagh737fSTRxdyqyOHTC7GzuwP0XLdXtQrIuZM5wM5a05stSjGg8q9IgxifPRSSIigpQPQvnFP4EwCGnbCD2qp/CSVh8Qm8uo1rnkroPv7JBI8hDrXTzRM27lQj6kTGPunTPL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(4326008)(66946007)(2906002)(66476007)(2616005)(4744005)(107886003)(6666004)(5660300002)(6506007)(8936002)(8676002)(6512007)(44832011)(316002)(86362001)(26005)(186003)(6486002)(6916009)(508600001)(83380400001)(36756003)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MJ4T+qrMwsKmngEY5LGCKBikAT607/llzTc2re/1OELx6mlIhPuhgqILC7rh?=
 =?us-ascii?Q?B0hCjG1uhmuViXquRlW0W9vSP+Z6pRcGap1FZxiJi+hd/4+sVctAJFMqv7uW?=
 =?us-ascii?Q?+5oE4NloND/IeEmRhvuYxE4q+S0gGb+Fo8cGUcXhXNFAVx3sl55vBYm6AjIK?=
 =?us-ascii?Q?egI1YZiwlRwGoVacHjsXeiX7/OCkmtiZtV0aGp2sxeT5VZYTMnKXs4I7Vfrs?=
 =?us-ascii?Q?fVmHJ1CQjI4YjgvQE1CmBlCRGPj5krP0ryQ9fRbPWujWF/jyvnNdkbrEgEZv?=
 =?us-ascii?Q?NXr4wadxX0G7CLAMXIEqh6Bak8w8II6MaC8qbK8NVF66ebuaZxkifdaQzlxo?=
 =?us-ascii?Q?t7zQ2e/5XV5ONvQEhiFbzjvdp2dv9qTifXBIGo5ytYmIFadJH1dqEt1i2lA2?=
 =?us-ascii?Q?W5lY1wLkVwx7Ax08o3JhMdKu/IBuwgYn6/iTKSgoM+5mFZBlUfea2BGnUxzM?=
 =?us-ascii?Q?FOVLWFZ4jAtpgJk6YFuzODhO6Z3kIo5zC3FhaOvz7J22I3s12HdEmMkXjeXS?=
 =?us-ascii?Q?Gk7khT2W/+RsFFvNYg6dM1VxVvExpHpaB4Tte5eXOQhjLpIvhlaQplRw6u8r?=
 =?us-ascii?Q?2Rnc0bgW2q9QdcYXPSKaFFSUjN1UMWYh2Om3OwZTny4EBgHw1TI0R+yPAdD+?=
 =?us-ascii?Q?/bBzhBqgKFc41kdbStYhH46mazCz26v0ZUKtoJiD45i0mp/z7VauzEaV+v4C?=
 =?us-ascii?Q?V563tz4OGqQ1wcZqmgaqPcFa/iwzeMAXFmygOcFL5/2Fj6gT4pSDnW4uX/B0?=
 =?us-ascii?Q?+bK8d0g0RxJ4wCQjx7hC7jVRiGipkcrNl5rwzwKh9oDyw/+MZ1NM1iIEbZrQ?=
 =?us-ascii?Q?ay0dQwADuC+Y0C9V6EI3XF3R4xOQ720ar+2Su+bdlLDFVPkS3dlDpmHUpxQQ?=
 =?us-ascii?Q?5cXMqXrbyY8LNaz9vuNAXBn+hy4i32iPkYQfPAbE1JRZmMc0uws/Y0D7TE95?=
 =?us-ascii?Q?vMwOgxNIYh6BWm7ik9RfnjbHrPx4X8U4qSlkGUhbUFAVhNN/lKsZHJ78Bz4D?=
 =?us-ascii?Q?hal/TIG6rRBq+Ogzn36ibbzq25iSum1jwtNqQUJPn76uFF7l+mZ6KvtLGIM6?=
 =?us-ascii?Q?3wd+GFE7mBC/tXBJezXcMWqhUzp1td3PJ397iQ8BtKlRBcZ94SFmrcLaLzGh?=
 =?us-ascii?Q?dbNr15AIw39URhrNuSOjM9z8J4Dn1LihNH3E4FFFgDGC9eRbgnEpjbmHZ8Dn?=
 =?us-ascii?Q?FIczfqcw5FCgeFVeE/gKcpqyGDobRf8xlMoNQgdClTbRkJ5EP145wfalN4XG?=
 =?us-ascii?Q?dYjTupowLYjEFkKlOlELr4eriLgVIY0nDxPq6AHcgXVktmGHTqeQopO/O2qQ?=
 =?us-ascii?Q?XH7RA2w/Zn0nL6FMmwI8KhIb+W8epoZqAeL4D6WgyuGOsgIT6GE0Ez066ddM?=
 =?us-ascii?Q?eT4XuWr/XIjBJg5HTisFIZhBauQD3QRPdFuWVcdr3hwaCn+m5a95Sh4rQg+g?=
 =?us-ascii?Q?00mEFriRNCHSNRo4lcHytrtXiU6SpvA2IfE054DK9NqO+l5X1cgeqi0lTmVb?=
 =?us-ascii?Q?58IMZl0dNKFyHJcn33L5zrIyH0uQQDDmSYUq/8D8AFGyq0U9QAHu4ycLE2b+?=
 =?us-ascii?Q?lBuFVGGKXaJnQ6v6B1fYp7Y1egX/Sh0t3bc8GqaYzc6QhCj38dO+yTj/lbrx?=
 =?us-ascii?Q?3dpdSxmqZQOSmHSFb4DmOCY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0002974a-179a-434e-18d9-08d9fd29aca2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 15:22:48.2989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7EQClBVUtNZASSu8P5WRew76clBx79S/ZX3Rt0lvhS7KzW3QdF7zKvebR6eYbjVBOZ0f9GcVR86bH0egJDMZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3213

RESEND:
 - fix the CI Build Failure.
v5:
 - fix incorrect token value
 - verify the token in selftest

v4:
 - define bpf_mptcp_sock_proto as a static function, no longer export
   it in linux/bpf.h

v3:
 - use RET_PTR_TO_BTF_ID_OR_NULL instead of RET_PTR_TO_MPTCP_SOCK_OR_NULL
 - add a new bpf_id BTF_SOCK_TYPE_MPTCP

v2:
 - keep RET_PTR_TO_MPTCP_SOCK_OR_NULL. If we use RET_PTR_TO_BTF_ID_OR_NULL
instead of RET_PTR_TO_MPTCP_SOCK_OR_NULL as Alexei suggested, the
"userspace" tests developed by Nicolas will break.

Geliang Tang (3):
  Squash to "bpf: add 'bpf_mptcp_sock' structure and helper"
  bpf: implement bpf_mptcp_sock()
  selftests: bpf: exercise bpf_mptcp_sock()

 include/linux/bpf.h                           | 20 ++-----
 include/linux/btf_ids.h                       |  3 +-
 kernel/bpf/verifier.c                         | 20 -------
 net/core/filter.c                             | 13 +++++
 net/mptcp/bpf.c                               | 52 ++++---------------
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 27 ++++++++--
 tools/testing/selftests/bpf/progs/mptcp.c     | 22 ++++++++
 7 files changed, 73 insertions(+), 84 deletions(-)

--=20
2.34.1

