Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4A0196
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 00:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LNUuOOye"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwsuyJTQIT7JFYbE5YCgAvErUjiXibgjpCsK9sDwcDc69q9GfV8rKHHV9RC5nJMCwaxtsGkauFD9hDXYufpUr6frMQ3PFKum78dO/qv1Zj8u9as81ntm0lpE1yXDWgzoHGQOu/y5WW1S1Hf6rsBKrK9cdqiYDiDDGEZo+M9+440LJn6stOYVloZqJ3SdXSk4weNJc0mVoCM11G3i5KjIv1d8L6U0xDVug/ym1Wvj2Ig4ffNV+JT1LPB3hUJ7ieK7z+9Rc4pQ9uLB1rUF/Is920rhFIjY46IH9TMJyTsq/Ddson2E7rTx3y+Zq8ICIUc4trzaKx5lR3ASi6HQzOTBpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0sIRYvz6eBFH+Rdr+CJiflwJREtepwUqYXG+R3Qj0k=;
 b=CtcfpfF1Y1pcuADEA5vB+VxiJabaGQvpilNl5QLpzudeywOsMSLIGbtLfp9voc1t390YqGVL7Q9UP0sf91uJ8ehPaxU8suZKW1nDNqSmbFWpGVWk2sfEf/3CxHravWLrHgXGpJU0oYoYVcZNv3OtSAqynCHvb1ECpSIwnYoc+z/bK/ROi4g2s3dan+01Zig4aDObbJ2oB5VQzKG/tLpRVPglNydZS8DhbPePOHuYaH3LzqNoeZ8RlVbd2xwNGKoGTiBlaAACby1Qd53SyC/VXYW/kChUuKf/ixyAHm9xyFOd9L6thm42uCW3bOcVV0kWhKbE7PJxLiOBqPl26frjDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0sIRYvz6eBFH+Rdr+CJiflwJREtepwUqYXG+R3Qj0k=;
 b=LNUuOOyeoAA6L/L0hxgCNK4S5xvAIHlAF5F7p7mnj/5WL7rj0eBj88KhFruy7G5fm3YcZSbjSfTaTt1+8f2PW5PUj3jMRuO2ekPdeD8lHiBJep2/6OF8pujvuwOr9Qurvb4pVhuxWUB7VxHRhZNhveflUBSUfVkm2rlZyn8n+JMxYXM4HKCzLPYhtG8nGVjVR2NZfz9cnL2S8PZrUIcXhrirYAmlKEXQ3NgXakosdZm2T+6bQvPFxpfA/gZqmlzDLLEukryzDZrtwaSXMbKln5fR33nfxyYJnd8cf8TUFg+ltZ60rYfTylxo0X4ZYPQIj/AjESMR+SR7Rm2jCrDaDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6989.eurprd04.prod.outlook.com (2603:10a6:803:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 00:26:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 00:26:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 00/12] add flush and dump for userspace pm
Date: Sat,  4 Nov 2023 08:26:11 +0800
Message-Id: <cover.1699057244.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 012f40aa-3c4f-4dca-b5f9-08dbdcccb97b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/9eb0EoCgYw9FXUD0y19ANXkx/jHiMkoYl6YicfDFyfksZOkQpLLuiDssTB3SX8x3Ug+X8Q0WgD1BILaijcLyEgpntV0YpitUdXlclhM9XPA52mw5BATDydQcHS/M5bnafbu797DrK0oJvUTnai5XzXzTM37jrUfFZgrQenD0PigSVZWBuk8lQNcds6b5DxERdCeBymDAuvuBVm/uih2YV0bss45x6G9l6Aq15yennotJfxz7ygnXUiKJOgFA08C21CKjVgeVuw9CRm5QRJ+UhPdZk11b8ZzS/BBhsY8TMm1ZXHzxg4Cdl5a/eRlVB0UbmkpoIS7rLv85snasmR56AEKXhg/H38rOMVxjewVPPshsqIloFtqpq2GxUKj1ud4iOxUYYD5At8FgRMDZp6EMPs8/Pq1S+tOlWSW8yf50lt8XKCWx6Y1VFTQQesXJC+FTU7it+24MdOXdGa23K4zsE17dfCYSeNjuVNnUlt6Dl4lDcYAPSYnE0+AfpXGCX4udo8yNjc7xKaZIH74QmpuM/Z7fADbnTP/myXaZoylgPnXwaYQSkRsN+IYnevgkJcAXZC+15JV3xByPG7SZRshDAM+2Lk7/rmT+ytQ040rtyo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6486002)(5660300002)(66476007)(66556008)(6916009)(8676002)(316002)(4326008)(2906002)(8936002)(66946007)(6666004)(478600001)(44832011)(6512007)(107886003)(41300700001)(26005)(2616005)(6506007)(83380400001)(36756003)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sJ0eLOJJuOpY9/1luiBYLRorEsvO+QqTDhs4NAdRpm8Ds9BWIXEvZpvL2KZV?=
 =?us-ascii?Q?1W1oL1RqyBapyAK0bY3TuhiZIeamYJx9GuD8Tkn+0ZEzMK1/X1i5gNyBZLMW?=
 =?us-ascii?Q?B7LBYc33wDcuiCkJPnDREheAtdPskofeytjXyBHin3lZQ47v6JoHqm6oFGj/?=
 =?us-ascii?Q?BJKHzhMFQi4fB5SXm7/pDd8jOnM3bi5QDABAl39qN4a62Udv7DzuX6v1ymFU?=
 =?us-ascii?Q?4QYmBb9LezENZlqHYSBWzC2cnxOoj3MeYJEPyaTyqrPGZJ9yhrSa4rNUuagT?=
 =?us-ascii?Q?XzB/C19ssYB+vkU5doG22eI0//YIj3URTleVPzrzc3kdMumKCDuwmozN7xbI?=
 =?us-ascii?Q?VsUgEAEmA9XQaa5GF4K2oOLt5fYhYwK5DDTeB9lgUk4YIE/4wWtavXv8uGCd?=
 =?us-ascii?Q?a5DBhTAHUU+cQ4iDA7q00TDB3pamaYnqUDqepF22Qkhxio6s1VFqwc5vAYt+?=
 =?us-ascii?Q?HjxhTklwVWDf5bSLg38sva73QzjQgig8pfxDZMEYyYqp5kqHCXq1Vgxcj8b/?=
 =?us-ascii?Q?1Ih5TrLIaTInnkE0ShdJAQo5gdW2SS31zGzdZJfN5dnC2zyr9EDsvBlgziEC?=
 =?us-ascii?Q?cjusmR2BxSau9mN+fdmLf4fwYe0ZHxGkNdJ0tdE9gl0K74Up/85oZQpXNPGO?=
 =?us-ascii?Q?yq4FzymllSk0TmKfaec/A8gUxyGp+Tci6t1er6UNGOZS9Z99dh/NzKfMwQXN?=
 =?us-ascii?Q?IOy+yvPQotT1LurYQUifAB/8+wOJC8mYHRs6qOnF30Y4/fX6nHF88GsIcu9A?=
 =?us-ascii?Q?EVjlKZoq/jC/M0Gb+3KvpLq7Im46BsLshFps5x2uyhEFMjxZhZAOYE6wQuWn?=
 =?us-ascii?Q?Kgf7LyS7mhHnkpE5yyoqVg3IvYh1yKJZ+u1/er2nAjx4Dn4U1SHfoY7J5BVJ?=
 =?us-ascii?Q?eH9zfGrzqJMko1h5siXKSSXei2gco6TXJVv/8TyJfeVl33+crneKNbJtbEES?=
 =?us-ascii?Q?Bd2pvsAjz6jvaxw7kT1oiSPxobVrcEt2NR2QgnDV07B5m2aerg7eLGl67uUB?=
 =?us-ascii?Q?eJfQA/I78cters4Ht+YIkv9ePVO+L0S0a54/NCS6EOJufAEF0dq+T4xINczw?=
 =?us-ascii?Q?z2QV+r00UtdT43OAvU2OIiW9SjPW8Kaz6SW8mFjnvdEaSMUwQPPSH3v0L9/l?=
 =?us-ascii?Q?4OR9bsztZcqcziwRV6UMX9SHyJWnhjPRUVLxNASkd9Ls7hr5k8nf290hkZZe?=
 =?us-ascii?Q?PiSfN8qXNuR3k1kxwJyVwWEGRAi5EzcDGdaLA0hvId0bJ3I1dI4LW/Z1lvAh?=
 =?us-ascii?Q?4qult6SBWzdsq91dRDDBQvGcn/2V6jpefaMHU3TvOAht0dKuSxrcdVJZSFgH?=
 =?us-ascii?Q?HK5KcWQlaN2vHmrYr4+QGeNm4LI0WMcQbQoV3dO1vmPqawSiLeqyx9FZOwvH?=
 =?us-ascii?Q?Rgm/IipbT5Ukl43l5s/PdbFnEpW0sghMEjP/2d9ptNB5Lx7WTSA59eoP3BKT?=
 =?us-ascii?Q?G+lZLtJBwpaOaGnz3VDhN7/3/nFwCSF0HASOxMyqOmeUKSae31u3NxMV8vlK?=
 =?us-ascii?Q?PXEH7DpsKQhND7XPCvL/3UWSop3/3/CwUsmWEor827A5NNg685AsZR1SqrWR?=
 =?us-ascii?Q?uneSaAJAilmLsn4cWnOuixEx1gf+8Uk3GEL1Ik6/?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 012f40aa-3c4f-4dca-b5f9-08dbdcccb97b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 00:26:45.9196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+wttTnDY8W8aflxY2lMRPWzmAVzZ0Wm2/k5UKupJJXSjQPm38xxBdJMruLXP3oka9cxgM2KEYTs5kibxeG/rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6989

v2:
 - add two patches: "mptcp: check userspace pm subflow flag"
                    "selftests: mptcp: add userspace pm subflow flag"

This series adds flush and dump commands support for userspace pm.

Geliang Tang (12):
  mptcp: add userspace_pm_get_entry helper
  mptcp: lookup_addr_by_id helper in userspace pm
  mptcp: use pernet id_bitmap in userspace pm
  mptcp: drop addr_match and id_match
  mptcp: rename free_local_addr_list with prefix
  mptcp: flush userspace pm addrs list
  mptcp: dump userspace pm addrs
  mptcp: check userspace pm subflow flag
  selftests: mptcp: add userspace pm subflow flag
  selftests: mptcp: flush and dump userspace addrs list
  mptcp: add addresses_identically_equal helper
  mptcp: drop lookup_by_id parameter in lookup_addr

 net/mptcp/pm.c                                |   2 +-
 net/mptcp/pm_netlink.c                        |  70 ++++++--
 net/mptcp/pm_userspace.c                      | 161 ++++++++++++------
 net/mptcp/protocol.c                          |   2 +-
 net/mptcp/protocol.h                          |  11 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh |   5 +
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |   8 +
 7 files changed, 192 insertions(+), 67 deletions(-)

-- 
2.35.3

