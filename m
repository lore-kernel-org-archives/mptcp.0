Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CF37E
	for <mptcp@lists.linux.dev>; Thu,  3 Mar 2022 14:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646318892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d/+c6tiWogYkkV+cfn5+E+HlK0tSvbDXMlvdFLy6sP0=;
	b=ErkVaHw94r2UdZYV0Xvb3zewkC/DmUxqIWvSxb56YZ0hxxmG4XuMOLOHgUuPaJr5Eq7cNl
	OXhTUGrrpNgRV/m9NqzfCeJJHGkUZHZnBmqWaCPfYxxobSruroQ/TJf8Hlm5SzL94+aUCK
	4A9SZmZDKof3dDUMzumPVQFJsCgjAEM=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2054.outbound.protection.outlook.com [104.47.8.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-23-KudERJrGOdeN9_qdthpb6w-1; Thu, 03 Mar 2022 15:48:11 +0100
X-MC-Unique: KudERJrGOdeN9_qdthpb6w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwYjKvrUtWilq8JWac8eCqYmAZhYRgD/HvoLe+YaRa79T30J3xiR3JzzxssB1J0+0cDbhvLLAkUEcvXIbZYKtmTxq53A6LycQmbKpBnA7NkVcOd0VPlmVXGs7r5AmtVtpuspbQ+J+skWnanv+oam030waxCBnk05VrG+/VQOH3dNE6VxVhYmPuaeKR+XDCCkEE1rIPUsfe4B6nsTqCcHPuNvytkGJsrcMe9ndf2dN1dmULgOE75aLDt/0FliimOCXAkUMTI9aNPYid5pGtjbq9QacgHbiZrZqbQYDYIA35tVZmpg10Z3+YgTheP1mv69uXFsbNSyAW7fOqmaI5BL0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T32KIDoFDz1EJ56ny3H3oEG6NDd3VHdn/i0ALpBPPxo=;
 b=JRfsUrIo9anA46K/tb5wHNpV8qWzgS4Tj1QZPNz0DLm7KUdyi1Ktat81no0cbvC7ZvWEIADrGClY2x+6Oz4zGQPgozaQgVBc961eBZ6S1QKKqUthpzl3rUThJabYsz4vf5ClxOkjmEioD/CKpsQduKnd9t8xiy7G56HbKstuX1E8wdowLuGHRaGSZj7JrHt7hhWnqrXvuwoASzNvjQslaLEgXmFKvHkyLhzeSu5YtU39EsMp4/tTE/XCwkO7YX+THVxTTq0VTf6/SD5ENK5qv9mXQsk9uIrGuOdf8aBj7wZQAnlOS8WwdOPzuitCahuvyT6FCugbf1oY1umAtPBrjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB6218.eurprd04.prod.outlook.com (2603:10a6:10:d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 14:48:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%5]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 14:48:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 0/3] new bpf_mptcp_sock()
Date: Thu,  3 Mar 2022 22:47:57 +0800
Message-ID: <cover.1646318613.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:203:d0::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a942b92b-8e63-4ad5-cef2-08d9fd24d5b5
X-MS-TrafficTypeDiagnostic: DBBPR04MB6218:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB621885ABD5AD83DBC8046813F8049@DBBPR04MB6218.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tFxBVZZOV/l5I7R2TEFG7lbatSqMHdW4HldG5WLyU8Hj/TFFfZZneQZGlMPhhenIt9zHXcyeaWMrkyD1d5PZsQTip9j8GGlC2DdbUnmdnTR9jjsjH22P0ztNlD30kgSE+OJJxOUy7ACnTvOjRVs2MwhOuJyOeCz44B+v7slbtGqnCi9bUNZ1lkbZTCxEEv0SljjFWomySli9b3GCRcsOZLgm168ZcD5/g6fwTyprqeUdr72VfnaIdgEAg4ruUFvz4Qi21GwFejLu6ns+ZIgT9ZwTXPxYiVW/ZGdJOlnRYabB1uKvWCmOb2Jn/XKVt0huJYwiynOwZhST/S8Q5No6OSoBOkBDqFRIcPPPGRXScfMTUMopQ5RK94K6mcy5ufhDyh2B4qIk9QKLPtsvP6Hz1aAypA31lO+7dzjWQks2Qlgr8bLm12VcAbYajf5LHNC/NIL82MN454qohq+4xCpOT7saq0r3Rl0mMYrmYE49tQ87862tPnwH53DjYZJ2Qz1Atbnvt2d4LSKtfQlW4hJqoiGW/NWlsZWw8ORNakC62QLwXte8/SbaaPC39EVp/wAA3+Udlzkzn57//yUC1pqxEexlrnLh5tiPCxY0JHP8amm6YSLuaIaqasrjJ9BmMn/S8nqwREcNQXkdW+hzwOwDVPDRNmuhdYITpnK5Qs0ZZ2tMIZ7Zxxd3dEKqBKh7DPcl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(86362001)(8936002)(5660300002)(38100700002)(26005)(44832011)(4744005)(186003)(2616005)(107886003)(6916009)(6506007)(6512007)(6666004)(508600001)(6486002)(36756003)(66476007)(66556008)(66946007)(4326008)(8676002)(83380400001)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DwPDJZmZNlc+pxDy2tqn5P9Cc/c/ESXsfzqwfY4noZbnpXWFvWald1yRJbnX?=
 =?us-ascii?Q?NmzebHlGfFCmCV2S7JjzF4v4EEd+z07nBVBGYlTfqNP8hD/4MWC4qdFJCuUt?=
 =?us-ascii?Q?id5q5umEwd0R1jjutuyy1OPQb/9QzMo3TMmjYnnVawg9aZBmxLUxplEaulB8?=
 =?us-ascii?Q?2oJC5/eyE/rGhByOGcIyUX8lhVCx0w0to/bnSdPDHLFnRSvzjQBBrinw8xyn?=
 =?us-ascii?Q?J2SPsgOr8y4Vh9ZpuoD2NrHgF/O3cVIJAUEzZQvpXDxdL4/E3MLR3qcuHAr+?=
 =?us-ascii?Q?Uhsq+bSIZEb9hEbsLxT5P2qxHNvYwfgUHlnt4xxTG8PNhHFJg/954LmOzLV3?=
 =?us-ascii?Q?GFe/SMZeI46Oo5zmsR4VwDBtL8DlFXbE+iAn3b8zQ7DUwRDRgu3Pcciezz7Y?=
 =?us-ascii?Q?vTBXWxutpdlDFOZARrQh05ykgLJSb/Xwqkw3+muXwHOT/bhQAaP62ZnM5ytv?=
 =?us-ascii?Q?2TMI/N8cIBW6ttGey2d7N01SdhTMROH4tUJodq8OWH2RLzi0oQlHjaZ7SOBu?=
 =?us-ascii?Q?4eDbKSh5u93deQvMCT0v1dpLHgxDneBKHnEUk5kJhhsUdkW4l4/sVw7/9vLS?=
 =?us-ascii?Q?OJ4w1gy/0kj8WGtulQo0c/SylL+hfCzRazAnF9PCvohjFcTGURljlGX4yJqg?=
 =?us-ascii?Q?wAcU15jcorrP88Sbw5jATyf9r4+J3vZpFcs1Di3FKKHuTdZSbATrTU3QrRWj?=
 =?us-ascii?Q?6incPBMv3sFu3ORzm/f4WI9EFFh5TS+xQg1nHwP3wkJN62PEsylwSOQxCFNr?=
 =?us-ascii?Q?P2hdnUm38WvY6QMSSmxSKscz7HojZX2epnRQXCcvReaX7BRyg8NUMrOITevx?=
 =?us-ascii?Q?19mjq/4g5FUMn+kEj/+pLSu/9NNxXrpj5gOuLICQyaZBPVo02iojp2FXX/0f?=
 =?us-ascii?Q?b7Qm34Ija/y2KEG7NWLFJnBjxw9GpuX2VVErHkj7Wbq3NCXrX3lT+hCLi8AP?=
 =?us-ascii?Q?rhQZZ9+yFsSGM+2OMEIHgFQ2tjHnzXya1sV9ZfidxjeDhBSiK1mr9qedc3z2?=
 =?us-ascii?Q?iR8We8Do/DfVLRVR0ZU+6OMh3d30yuhTjPMRk5ILq5MJhtSOZolegBgBFumD?=
 =?us-ascii?Q?ePayNT5aqofgccF99myDoryzwQv0NkennLFG7NUPuUHogg/h18qWXMPH6IOg?=
 =?us-ascii?Q?/5RkKGhq6t7UeTzpCAazTZPZgE429ugNxSGU0nDQ2fhW3fUl9JVt67+Ge/jW?=
 =?us-ascii?Q?M56ZeekzfYwZzn9eDqoO5j6t/IuefEjeeWBLAjpyFV9jz8kWDWGjW5nVP/gc?=
 =?us-ascii?Q?sDRIlGxFjRnLgCo9UQ49pgP9ah0I8/e2XKqbgXFo+6p3xrsVODTSd3Ph3O8e?=
 =?us-ascii?Q?FTGiNx+EuMXmmts3XQfrYsXitiVoP5qAzkYDQKQ/dTv8byW+Tm6nfQC4C3T9?=
 =?us-ascii?Q?JB5CxmHczcbEoFCgZA4EWFcce2IeWIUtrqmbOJ06xlIZ3My9NCErHAkbvf/3?=
 =?us-ascii?Q?baNfsvhhWJHTCpxDA2rzvWa6E9g3eJ5HZFXMjyAvUhYthiGMUrJorifYNW7q?=
 =?us-ascii?Q?WGo9/H6ZazCHTVkHMxW+mLKdZdrTZm9alADsaED8/1Cumq6jPaXmsM4oWKju?=
 =?us-ascii?Q?6BcHdohcuYbk/h+QPXF8YIiFXl7Ud5hNqelyTkw5RTSbjagYBi3EZ9eA0LNh?=
 =?us-ascii?Q?YHC7/MwCGoGzL1U4srJ9Q74=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a942b92b-8e63-4ad5-cef2-08d9fd24d5b5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 14:48:10.0278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CmAAt1yqxk9BZNyALIae2Xr6jUVR0XTfMOgtphjsIK8Gf4eiCS9bSy5esnflFIK6tRpEjmtKhDCYGZv/bs1tpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6218

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
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 25 +++++++--
 tools/testing/selftests/bpf/progs/mptcp.c     | 22 ++++++++
 7 files changed, 72 insertions(+), 83 deletions(-)

--=20
2.34.1

