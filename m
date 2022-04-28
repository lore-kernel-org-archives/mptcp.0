Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F168A31
	for <mptcp@lists.linux.dev>; Thu, 28 Apr 2022 03:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651115208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tEsdy5j0DyQODmvPlD9vn6/6M+HRiPnC4blqOmteHgU=;
	b=X3JzRtFv1lH2/rXGXBFLznxEIiJdzwoGJEWbnOBfnkfTMrYf5+tQYpowThXWIt1shDMpjp
	ncempAtqD/TrVBd/Izg5f1ToBwT67tgLgbKiXAySZ55yI4fV1hZTnEZ9R/9rNJKLBiz4hh
	kXQ7goYClABoItpH7zLtYukoeaffwGk=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2052.outbound.protection.outlook.com [104.47.6.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-E2qS1YlUM46XtPhp1Gg4uQ-1; Thu, 28 Apr 2022 05:06:46 +0200
X-MC-Unique: E2qS1YlUM46XtPhp1Gg4uQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltnkNOs/4QSprumzZiv7zsVTtWcjpKNIQNNEw9++fyi67cPDKyzEwVTLWMkXWG0RoBVy+4Dn8amuRAEAvLULQINDaZW24lo0eqHT9pU0vjRilY8QFSSRJimQsl0aam0eLseyKPOGAPbj2UKEmamOA4tT8Lw0x8PVOuj87ONVDKu4JljTaoRYWZ1++d9z4KSYp7vyZZrfF+B7NkxlK1GxWhl727u8c3XmoCJjahIPKh4qohyHyjUp3ZtU7QW2a6ICp2SX0Vs6mB04hQAPCsj/mOvnh41+LVszl51/CFrn+Ts9OkMZvfWPEKoCp7Sn0l5opyHEtQNpPkC72oDPnr1Q8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tR1AGtZLH5ghjrArAJDYNohXsL7lS/+G4YX+3z7yiLQ=;
 b=eyxFLjJeWv9unk5pKLz9DzSHgQ3p9puj9cvvAKogcr6XyvBfbbVunmbWQ1rVreJ1XT0DEzIOvA236rq73rBLXcltG7E8wPkGfeUWzSv9SR92CwHIPngn7IwO3FT26iNeIiNUOvysVN3Ypx5DtoHbcwLnQlazMq5BpbJ95SVdV+6Ip8PelBq8obBxM7fIdOYn4uOPMicDk7BFLI5lo/GNmcRurjjDkNV7OV+6ZGj0O6wG0Fkwq54uw0HTsg/0cmRAVi8UUNOBnTQf12fDTbh1RbzV0laM8c6hojMf2eE3eh4Uu3aKwoaLUNXCp8tqqCbKHJoJTaSV0+4F2HMX5eMVLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB7PR04MB4763.eurprd04.prod.outlook.com (2603:10a6:10:1c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Thu, 28 Apr
 2022 03:06:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 03:06:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v2] selftests/bpf: Enable CONFIG_IKCONFIG_PROC in config
Date: Thu, 28 Apr 2022 11:07:02 +0800
Message-ID: <f14787485262a8dd8c439e01cd5651f10d5eb63d.1651114997.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:203:d0::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59422428-a18d-4268-ec58-08da28c41f5a
X-MS-TrafficTypeDiagnostic: DB7PR04MB4763:EE_
X-Microsoft-Antispam-PRVS:
	<DB7PR04MB4763338906B350D33EE936B0F8FD9@DB7PR04MB4763.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y1QBpk27FuE9mAA7FU1lq2Yw+HNJ3nG8SqyYSTyl9mdv27UKlZBZpVgZbsJkbDbF7IPdICY0wwV7VnQqESovMyoToxVzGQVTp1ZU17bpSFD7GBYn7nb7QOaPHtqhoR0d5ZHePJ1W0ehfU+5yYqeJzSlpnG98efEusPeAT8e82qAFqwe6adMbND9Pbc3qN+hXSHyuIWKegMbHAVE+NPL4p9A7E3tq42qqv2Y4Gt7DpFD2Oz7xeegsLgcOFt8tZxZPKFJZfH7aEwwgRbYI1UEYok1qezpnb1QewC0bom6RmAqMWfnaYa4ItGnKAxhyaFZdawUK41ueMjsZks92biPo11svA/tYvdZh5vA2scvkyw92kZFPtuYgp+y0wCMlFaecRQTCVl8Wap+Y9JfZLGAbUf7y3IDTg0zf5kQH5NgBauIRHy91Zjl3geFx0C1XNEsRPIlE9uz9l0/FEeN1q3qw8BH2fjpIdFCfBRsN34vJXFLMDUhAZo7JCKQwI6GDzEnt7CjmP7l9zm++GJo9pzoYazBrc68awnIk8V4O01IYzQM+WLL3jY/oQ+3zViN5EY8trU92jU5/BlfnvL8RYjC+i95ZXalMVnCIycCjGFAvNhc4YpEqpCQlCIW2tdsLOQSho9ztEaE3I3ujhsMMzvnThhJWL9bT9+1S+llgs2+0hSzq+mAVYo+sVe2+zmmoAFF7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(38100700002)(6506007)(316002)(6512007)(6666004)(26005)(54906003)(508600001)(6486002)(6916009)(186003)(44832011)(2906002)(8936002)(2616005)(4326008)(8676002)(66946007)(66556008)(66476007)(36756003)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kQbh5orLp78myEe/4XW78b9rzV/OQYzygxqUY/AC28MpPbfiTsS+ZqEFmo9s?=
 =?us-ascii?Q?hsukiLOazRPEzBiKLrcrUDQydC66LQ4jSXM4itWHNFGIilruQOehcdsC/Ic1?=
 =?us-ascii?Q?cbTNRYG9WGPMJAHPF02c4Qy7rS+FF3rouY4G5CNpDWKuVSnxH7JqfkahdnyW?=
 =?us-ascii?Q?WLFgTokouDrxncfN+/lncCqhGwrRsyuHQ5f2VpghY9E61f2ZtTEOT9q2bOhQ?=
 =?us-ascii?Q?+IE/6mgwkMrNOKiIQIc5TGzDrE6TVGtQ2s20ogpOYRDepGCfZ1eXhHdmDBWQ?=
 =?us-ascii?Q?lNIBnRzUXZGUfnG/6odMpluSN6AR2rI/ileS8YAPnTjwJ7EMuH0u94qUvxVF?=
 =?us-ascii?Q?4mK+ud7YE5LjLrvsiCuzGngMnEZANLjTqL2WCCtIaPVLTYI/anFgbz4wGD16?=
 =?us-ascii?Q?+KXJrOfHX+1OJrEY0x05s4XQrtIso+Y6f93gl44A+tKaojw1FUKnY4hhXxmO?=
 =?us-ascii?Q?uGo8Fyo3H52TdIPfAQ+vcDOtAGYdPTdAKQ2BhBsrKgRUwde8lZ7OHPlTfk7i?=
 =?us-ascii?Q?UfOUOjVPzAU00ggAYdetKUQiSozRQvb3d2KkS6SQkUJABYbXNI/nTtceVZu3?=
 =?us-ascii?Q?Mtkm34MiGWH7UdhvstD8AueaVY3k0ViBJ07GbjKXykSp7LV3rrbcjJJ4p8le?=
 =?us-ascii?Q?3g7EFaP2+Jr+XgbcYTGlJVW/y8S/CbysvErp7cMBhTeAQCHqNVQqZhdkrdTp?=
 =?us-ascii?Q?psdP1drLnMiC+xp2w20hP4qMnZ9xh+IJUcikTtXiywfXVxcOZ3pB2SsqGCwe?=
 =?us-ascii?Q?BGtGnEA1H1NACE6fCK1mKHJeNfu/kLJXg5gsbSUuFC7/SSEgtg1pKNsF3YMt?=
 =?us-ascii?Q?zINoLcVm4d7SAn4cnSrzB4OF0w2X4a/mn9l1LIIDFURiYTeCcTA+68IlA459?=
 =?us-ascii?Q?e+1PUb4sUMkbGBLY8W4pzl5xHDi8HZShBTfNbdDvoQlSIcDdtDDr/VR3VEZ8?=
 =?us-ascii?Q?NVkKAP1ljGKiuZ5W08kIEZrz2bgZfzH6NCgWI7jUbJoAu2j1Uf7AApU7Rytg?=
 =?us-ascii?Q?ibuvv4tLS+pdEvkB3Y7SJnxwSxdVSmSBZ+mXyFpzMLYbl0TNEHnxk0mC/s5E?=
 =?us-ascii?Q?BU1Wt8kbwb4ulJpWn0+kQPeYQ+UBkHtmsvwTiFEG/dJHu3bmia0CIUq67kP3?=
 =?us-ascii?Q?3WRJheFHCHb3Oz6o2lYRF3FBIIYjzP3nNKc2GDSRQlJKVK8QJ8AbsENURKNw?=
 =?us-ascii?Q?MnDOMsdI4ZYRRZRNDwyCAmx6UaGglOK3DvJNUlmPyyHSpuXKXNusUP49i6OC?=
 =?us-ascii?Q?0L6PgFk0jYy5CbmWxMXI79VE6pEO2oyubMECm4jhgQR28VXijU0pPqL48i8/?=
 =?us-ascii?Q?9TMIDcMLXZoJ1H+XF24AC9C7hczgowrPHBnEjmGBTlnOqkZgxfdShEadUtY3?=
 =?us-ascii?Q?mxl2A7Lkij0XYjlZtvvogW+LYpfMxnH5KnfOr5BJkRAQAr3OprqcJ+C0Us9f?=
 =?us-ascii?Q?loaN7f9pwNjoF1hloaWCZsxo74wEBEZEAKLFkG+hWNGEn8xIrKxCrt6EEB0K?=
 =?us-ascii?Q?ZRTzZPmvZ4v9w3OV6JfDbm0uXaC0hozYdOq6U4EruYzbMITZFum8jlEcuzmg?=
 =?us-ascii?Q?w4gVwtcDJ3itt4nURT9is+xAzKZ9eZX08zIzZWdB7gpGsfipxmA8PNTS3cFh?=
 =?us-ascii?Q?vtGn7P/Dfxf7rk8jwmgsiNN5VzNgFrvt+zNMcnSR/XEgOKtjrZPuqnw4p1h6?=
 =?us-ascii?Q?LpypZfd2NzLoz2RYBCG/pttKSBVYsPxYFJkQIsFhWMSlFYSLFoftrx+fO84Q?=
 =?us-ascii?Q?GpTqO7YsvVOhMwC5mTqrDvOoyfNael0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59422428-a18d-4268-ec58-08da28c41f5a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 03:06:43.2818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pgV/ovwIZNpk7wimBxTrzYPwGG/pc/3CflFxm0VeRVIFf5vZ5rFXB9ajNrkgUCB9ijSFIGkaxYWH4GAC061cSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4763

CONFIG_IKCONFIG_PROC is required by BPF selftests, otherwise we get
errors like this:

 libbpf: failed to open system Kconfig
 libbpf: failed to load object 'kprobe_multi'
 libbpf: failed to load BPF skeleton 'kprobe_multi': -22

It's because /proc/config.gz is opened in bpf_object__read_kconfig_file()
in tools/lib/bpf/libbpf.c:

        file =3D gzopen("/proc/config.gz", "r");

So this patch enables CONFIG_IKCONFIG and CONFIG_IKCONFIG_PROC in
tools/testing/selftests/bpf/config.

Suggested-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
v2:
 - as a dedicated patch, not a squash-to one.
 - apply this patch before "bpf: expose is_mptcp flag to bpf_tcp_sock"
---
 tools/testing/selftests/bpf/config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/b=
pf/config
index 763db63a3890..8d7faff33c54 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -53,3 +53,5 @@ CONFIG_NF_DEFRAG_IPV4=3Dy
 CONFIG_NF_DEFRAG_IPV6=3Dy
 CONFIG_NF_CONNTRACK=3Dy
 CONFIG_USERFAULTFD=3Dy
+CONFIG_IKCONFIG=3Dy
+CONFIG_IKCONFIG_PROC=3Dy
--=20
2.34.1

