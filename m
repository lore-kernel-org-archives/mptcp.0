Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2592CA4
	for <mptcp@lists.linux.dev>; Tue, 11 Jan 2022 08:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641890275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BaZ4HlAwPyhThWxdwgQBh6blnRkYp2tHsibnC4u1+v0=;
	b=FrTpH5A9QHspqxV7xoWWb+J8/wFFgqugjWd5Mx9JOggupDGHD9/TuGonYSV3eOwWH6vhQO
	8muzUpQU61oijuAo13jRuHqX3nj590RR4WKNebQt8m1O+K49b2vT8Tlw2wKhQjTINmC2Fe
	Ug95y6QxGjKO5iG2S10Xalr2QYOwT3I=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2055.outbound.protection.outlook.com [104.47.5.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-XtkrnoWRPXyGWHlQXMZb0w-1; Tue, 11 Jan 2022 09:37:54 +0100
X-MC-Unique: XtkrnoWRPXyGWHlQXMZb0w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgjSRkjtKqIF2LiBBxOkOyriIte8fwiRYu76R9i89bieVGvWthgmMP/Iv3MsFaLP74z6Vmowaq7r37L6tfxEC+vk5aPUETvDqHQNunniUI0CbHJ1EXlRKo2fL1RCqwE7BxOlxBKh8S/DHcaS5rV5DMi925LgWnaSs8mybtHQKL4khoqJrdw92jbviKioFNiA+WyJDoYDeobZErOfMOgUm59cfb+8cx0Qucfvu1bpYn+eMuL7hF1SlRtf/dGFyY6eMiLrokW65IAPBKV2APC+nTa4p80fVHsbmogwpYXER8cI8Z8um1SaaWGBHbvmtY9iXji1etMxaxuDnRICAxCskA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rf9wy8NJqQ3WvIC8mXl21O6b3O30wQo3u93XGqY4FeQ=;
 b=VFWH0QAmRVIpMn3ztzrVBG1wTD2laLP+MQe8FTs4Ws9oTIJds7AfQ99WUdMCFSXCdkCp7/glBhAPwBTJPN1GjmdvPf8s5kQwOZUM5fBugDCyK5ctBcCvY5QaaA19aO3T9ZOJN4VIJB+yUPHbZLRgqsyFPbRnTASl+Psqhjq5D0WEvJvS3VcrSgkGxJJna8UOaUt0eP7VH1oueahENQY0qwAJW0BZggft0eT1fBt824v9fKfA1WS4+n/0Z1DPxhm9Bb3Eno6MbtkzrEPrvdCrE1WmTO2H4ku3p5JThT1YgJJw4oeZXeCYxwHnNQhHgZwlsdrc8gluC+rKqGr5GOM85w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB3275.eurprd04.prod.outlook.com (2603:10a6:7:1a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 08:37:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 08:37:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/2] Squash to "selftests: mptcp: add fullmesh setting tests"
Date: Tue, 11 Jan 2022 16:37:34 +0800
Message-ID: <30ade54d2fb205878c6a4db5f5f3eaea0dea4b09.1641890078.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <31324a202c23ac880d391f2d38f7c59b3f348ee1.1641890078.git.geliang.tang@suse.com>
References: <31324a202c23ac880d391f2d38f7c59b3f348ee1.1641890078.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM5PR04CA0016.eurprd04.prod.outlook.com
 (2603:10a6:206:1::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d323cd4c-26c4-4cf8-4f14-08d9d4dda8ce
X-MS-TrafficTypeDiagnostic: HE1PR04MB3275:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB32754BB4829AD745167A3F36F8519@HE1PR04MB3275.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ju5zJUbQQsk/Lkj03hZNG5Tep3VHFqeEUFQ8TLFFaS6yMnFaopBlZ3vPGrlfTZUZQ7QJcCC7Z+/5awP6nXYGlnNuNZPJFlTgBk/qgMteMdw4u4R3JYitzWOuS0vjbu2ESOBu8xzzEA/JdwXuvjQvp1EztGXlstOq6vwtL0v/bcgjQJOoHp9d2HEyrTiLuGsUAXg5VDg5j1hlNLEySEuUzgUB+XwTBHyp90vihifmE5Q52nXbdM6Gaf1N28Z83mT9DxtQ/zjiV2Uc40CSLIrmoEFhQbkuYGA04nFDSUKdB/O42XrEik5mbxjw9abYoDmHKmY3KETsM6FLltXvuusBcYBibT36/HmGzZHiB7op09x0Dv6RQDDd3DFeDiayH6wG28EQTqLB4zYbcjqMvDPKksByE96buEVuC3HqcyHiuRp8gUiS9lcKsd+fTmnkc2TQ7/OEQCZDKoKIzYIFOV2q0HOqSjidXfELOxyf2NvDQo1NW2elvYv/hKi6VafLOCatbAgDmJa03ZyC3J/A+qsv0HrPNTn5NyEnbz2B58QvjNrsDhv/2wqEA0TRaHQ3AOy80jlhx6j18rcgvNsk8OSMRgbMEIZJjeFldN40+BxR5EQ8+Rp/pOezxUuLaSedC0D9B2PBA9+F8NlTVovNdz4PqA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(36756003)(26005)(2616005)(6512007)(55236004)(86362001)(66556008)(66476007)(83380400001)(5660300002)(4326008)(6486002)(6506007)(107886003)(6916009)(8936002)(44832011)(66946007)(186003)(6666004)(316002)(508600001)(4744005)(8676002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OIe8tRPrm1XGdfcjySFWIjD4b1mrJ13+SyQHkSaa7YRFnZNcS+cYwucewArD?=
 =?us-ascii?Q?dAW/I2bRVkXrMJb8DvPxMSg0qbZmCr26tKl1CAq5M6onvm6CGadExOXKxkAY?=
 =?us-ascii?Q?A/nYNwbMALKW6BnkbhfD5OWLImAJzvkdtVZfiHTia5Os25kgDGSJwj3qV7uB?=
 =?us-ascii?Q?wqrWkT8QQuliG4r/YyT0qtd3xPi2kv1ideMp3gMwRzG8Ugl6nlUlXIWxhulO?=
 =?us-ascii?Q?9UEaF0MKHsKsaDSx2nYJu6iR9MtWyCejNfg22b0ZgTjmMg42lBOlTAZ+9zPA?=
 =?us-ascii?Q?kB7JfMnyEPxK8AR5FmKYm77v0s8CUROYhz6kYkJRp3vvpS63Syos5T0WBMwb?=
 =?us-ascii?Q?p0P5dUxgEj/hhFPjg+aHQ75wF8cDO68H5UrDs1Fqt4EPXJhijK7pT66RLXKb?=
 =?us-ascii?Q?hGZO/4XZ6pAMHC3djeKcq9xyPdfE69wvK+EBnIBt1ryW9CuLons04ZneDHM9?=
 =?us-ascii?Q?1lBsoM616AEd0Phf4NLiSSjadZP5Uq/CbTO6RKTuk+s8ixq+HPJXFxD5Y5ym?=
 =?us-ascii?Q?E8XKB5uvdBZVUGvNb5eh4G0JNMoZOk0bisoaCSA6UwATCrdr4ogNO//kg3Fm?=
 =?us-ascii?Q?yNyJhz7bhv5OaBSSV95e81pKN0ssStzkGlhLVhlo55+3EOcuVDZMJYIzgxWz?=
 =?us-ascii?Q?PdmNRqWrn5sRNKv51chDvSgx6Xjhc7PKp1vYAJabPF5bwiwEslxBxWqfOBRc?=
 =?us-ascii?Q?JNgx7Mw7675x035Md//bMwXUKt668vNCLP3Ad+zSSjf8IpzXNYazUzKHE0kA?=
 =?us-ascii?Q?e2hzajjEZae/TuYVOZb7kMsGvQQhZNSNGWxItN3ontV23G3dmoQUVol8On36?=
 =?us-ascii?Q?sDTvxSYQe9/Ax15YhM99YpbVQGPLuQTwVZr6L9F2mFFLXmvACvNlaxInNx15?=
 =?us-ascii?Q?6COI+lLwJc3DSaHbKdyJQGRPb62UPdEFjdDmevmrrLflk6zIA3GUQwEJzzj6?=
 =?us-ascii?Q?NlJYvWjZfamsvOtiIxZ1nWME/+TSnMfQuPuAOKVHhV5Q0Dx/EqaAX9zcuzWU?=
 =?us-ascii?Q?3Bz2zqoNFAbF4ROAjHliG3zn3v3qH5wRogHZuna1IS8n3FOYknHGtPfk6O6c?=
 =?us-ascii?Q?cyOy0T9KluD0sIZSYpIWEVEx9+02RadyJ/aUC+BkXrnb6sy/CUiHtN/QBOnv?=
 =?us-ascii?Q?2I8MQbt9XfCVUky1RKpUwzp3W//RZ/xz/5nFF1wdcFZxpO63gSrZG2tba4nu?=
 =?us-ascii?Q?Fob8AB5EBT+4VSLoR64nbDy31aEdWnfL7vu6OslTXW+CY8i/QjhnUZ1uBCIl?=
 =?us-ascii?Q?LQYCFlrsePkwQK9KOI/EESgbIOrJWSP5lXwgc/9pHL9Ztu8sH1gPoG4LLfti?=
 =?us-ascii?Q?Jf7urHbIK16SICM9A03AeBpnSYunalNvqiM3h9kH5Wsadgklu99NWkSsGZdj?=
 =?us-ascii?Q?jwYq7N01jFJGBKqlZJNC3n+nzvGg+P0swqvofOsJikhRFOlY+YZQV4tYwg4E?=
 =?us-ascii?Q?AFB4lg2kkK7LO8BuW38GVZKOsqHreBbboEWLJZ+yzQtohYbozA1Rt3PMuNhl?=
 =?us-ascii?Q?TvqQeWMb7unEpzXUXxd4k66xh7LH3OiFkgwh5dQlUjS9Z1giCaPXwtQbNqp7?=
 =?us-ascii?Q?4y1+wAf2i8frsxrbHAmV5zzy9Kqd9YsOePoGe0EnUYWNLSSXquVNT7+A0nZg?=
 =?us-ascii?Q?N0ehmn69PjByiGVp0NKZ7iM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d323cd4c-26c4-4cf8-4f14-08d9d4dda8ce
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 08:37:53.5527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HKTxLFvHn41U0yvRmjdZCtmLigHf/+WAqfbRtXO719fUhxOYvZjEkVo8tRZVbYu+GvylVxTpfot7hxnbAHkvsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3275

Now we can set both backup and fullmesh flags, so avoid using the words
'backup' and 'bkup'.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 2868e2657ca1..13be3cd142ef 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -467,8 +467,7 @@ do_transfer()
 			dump=3D(`ip netns exec $netns ./pm_nl_ctl dump`)
 			if [ ${#dump[@]} -gt 0 ]; then
 				addr=3D${dump[${#dump[@]} - 1]}
-				backup=3D"ip netns exec $netns ./pm_nl_ctl set $addr flags $sflags"
-				$backup
+				ip netns exec $netns ./pm_nl_ctl set $addr flags $sflags
 			fi
 		done
 	fi
--=20
2.31.1

