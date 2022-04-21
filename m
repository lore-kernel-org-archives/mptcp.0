Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563137A
	for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 06:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650522377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p8dFFjQ3H96rhTYRj32eoeXwvxUXXKu85ydzY5peelo=;
	b=TKeZHhLwWJibU6BDCBnbkE2dPegl55tjxJve8silXhZTfEg0xk+jlQ/x/O7TYhHRSzDbQP
	sx4HbOe70rboTTVtMB4P1DH9s3Z/3Pl+07emhCK5siSeiXzOM78EnpVjU20dVtnAm9GcEa
	7C+5IeKOQ4FcHE7mOcaybmryfG7NWn0=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2054.outbound.protection.outlook.com [104.47.14.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-oX8XdZ31NYGp6auSAr3-lw-1; Thu, 21 Apr 2022 08:26:16 +0200
X-MC-Unique: oX8XdZ31NYGp6auSAr3-lw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXPKvBEPIdK8PxUnIIQn/7sT1XS73F9QeRj9NxzizwI7MRWWpk3bmx9mAkD4Qw7kVsKv9PwZYoLDgC4G0eG5o1E4HvgmycPLG1pB5HD89qFwWjvIPPFh0J6ZKugpDWl6E6llXsoDf8Acu48DBMFrzv1uTr6QYa19DFxWMh8wRudzXKvcM2gGGQpSN8J4TaWyEmMHCAh4oA9LTUEVb0fN6EC8ff4nAKxYKVDA4P98/Lq4tE3xMRVRNS6cLKWyOmaPKQopmvKv0CF52znrNWyH+Yhn8KY3HDvVtZJtWcqtC2rzFdQU5/MwANaWnSoQwercb6FJl6EikFHay3P+SD3ltQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7K3VvZ+GJTbOhUb4LIKxN+XfWg2PylqKwUNA03jRsIM=;
 b=M2OHAtMuKVXf8nsi/S2IXO2dLElkl0ZFQA9a9Y3Z18XXTQYFwC1kTTZx1cmAbTGGfEJI9TDNhgOQrNCEqdiPMgywnIY+hcR5A+juhtVIFa2fDe2QjB8ydw6rTXlKE/LQP/BcxP7On+QBlaqVo8vLv1HZBAMF7w37j+Wv/pLgV1oMlYnGeh+nYKnPJ8MSQcHpEJeYsL07kKPbmcu9owS8jRRSoxINo6gdIVXqlLmmpXLdUvJNLg9RKhicIY6nhwhvhcqpclxFHMyrHrUMa7BlsZ7QjlnYUpvIAIzKdbpWXilDRhEbmedxlgI4W1tXYpm/5GSP+0+CQ6Vd8WAar5GOXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0401MB2247.eurprd04.prod.outlook.com (2603:10a6:4:49::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 06:26:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 06:26:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 0/3] BPF round-robin scheduler
Date: Thu, 21 Apr 2022 14:26:31 +0800
Message-ID: <cover.1650522297.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0083.apcprd04.prod.outlook.com
 (2603:1096:202:15::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39a799df-ee7f-46c9-e1ae-08da235fd634
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2247:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0401MB22474A2B734382E3F8386647F8F49@DB6PR0401MB2247.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t+ShXMbWl2ttcHUZsz92vgBcjeH5dn5DwdiNDURdfP0PE8NgdcxHlW9GT4HbM8otbU3alIhubjNjdVjGnewHCoIytFf1Pez7td6KLpzfAoUQowM16O+m3zJ6kEQi/z4rNhnUXAlPbBsf08hOmK1pmpLYfaDsCtu0A+54yMDJLTyJxZivGtqUN2uQadp9VRW7SvxRUSaNt3GSct1qapvJIp+cO3bphKjiV5B2Z0ktxK9b5oAPXDlEscw+g6wD44fdE+ffYRva2UIjgU2uO4iB5/hdwd4M2Lw07OQG8WtBda3xZ3YGAXxSi9o9Yl34cCpmRR7qQ2efmCOPM86XjAYdEypB+gkwTB6hVvLuT6/3XN6e4CWsl0jO5U76hKYvdk8ZS0+eGqnmX0WpduwNGaoKPGkK/R61htIRZRD1Ctm2u4nIHl+MWWLSSHOU4ygyAUkVQKHyi9cyfUqvzEHoUYdXItd34b5a9Qibm8zbwjzR8hKy+cUePy7mHxeEwKO7spR0n9dKgNboc/909TIdBTcUkxj1BF1FWcvjg16a4OQf7Rg/xv7ilOH12c/26IMPhFer3uPy6B6U9YuqvhCbTW+dAStYv/m/+GLPhPfObnJILqEoeVzerynhBkLifC2olRepQi1QNAJB6u15LjULY/eiq6EAXpWYd+yWHT4HCUF5OdHFqkmTFYLa211dYA4Eqbjq0Zkgy34uyVv8823JQO483Apq/n1f2xHd13sUSNuHBjvJkXuoezC2THV0kMOOz/5XDdMHE+X6wRIv5crKh20T2APjMgaOKtFv+ujH83EPHCMG86UTiUJBc5XVRHVhadem
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(86362001)(6506007)(8936002)(6666004)(316002)(966005)(508600001)(6486002)(66946007)(6916009)(66476007)(66556008)(38100700002)(4326008)(8676002)(186003)(107886003)(2616005)(26005)(6512007)(2906002)(44832011)(36756003)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ez6KEmnozZ2ucwBpSWL8xycHQgncYVec7nrPLC8er/1uI0EJZwhZ+T3+W5U/?=
 =?us-ascii?Q?JYKJq0/X2WNuQBV/7ecVPltQmXGYqam0AIdq5bwAdQ4qgoEKwXR7dt7YWT1v?=
 =?us-ascii?Q?lTH/hwoNznbwn1y2pAi980TRTbZhZ38/cDLjrTyaHMugrMSgwZTDaPAliM+n?=
 =?us-ascii?Q?phMUcCQsg3na4y6xuCun+9pK9vRZvToi+D6N+nGiVv2Tr6yDr+jvoZH/y/5j?=
 =?us-ascii?Q?BrJwAMgT2KuOKDNSTxaSn5wu5ji6KJNbkTjNhZvNq5xplVquePn5HIsRLMX0?=
 =?us-ascii?Q?hMUpL7g8SNTqVU7Ts+guePiHhC4iLa5IBKEAY1VKFenXnrZ5+XTgvXnobB1O?=
 =?us-ascii?Q?7ig1avESwtv1gbcQUgrSbf/b1HLbPrWXHshY5EwmEk5LoNWsBiAEpAa2oOBq?=
 =?us-ascii?Q?Fivn6eJV3MhFFcdb98PXDO5XJsROQtPQSJmnrhUGfFIxxBBCB19Z3qa9QgBb?=
 =?us-ascii?Q?09vLAxYrbKabEMnl3xmj3p4xzp0LochxZG//jq8iMIVLhd7C96UYmADqQx0O?=
 =?us-ascii?Q?63Wmo3Dx1TKtrvmBgY8VI7CKodzXxgaW6+ddcY0mG5/3mHJSIiu26asA6cLW?=
 =?us-ascii?Q?C+JzYQaMsLKvGxVmqaMszDrriDaXdZu/QIufr3Ynndq9cBlUbY733iBv3Cjo?=
 =?us-ascii?Q?hwiKIZbanrBd2uvFIeXPaSGAO6GKwoTiNNBNheXR0SzOoM1vSseKk1egrfw9?=
 =?us-ascii?Q?HrOeUlOZ1YJJ6yXSZDcGydlxaYQPzbbhZxkM/P8O2mc3MKHCUuPAkM9odoxm?=
 =?us-ascii?Q?FWbJVk/TSancsqb7gJ3u6+pUKxMVNMdVAjO75nnvlGz9PvJHNqTR6fhow+wk?=
 =?us-ascii?Q?dSpSzz1wJhFGuveKAOH4UEsTOxe2Xn4IHpiXlHulOEJqVZV7QivZr5X8nVCl?=
 =?us-ascii?Q?tI91m5X0+QQwQpZOQlzyWQP7dUL8Q5EF0dmmhHJc9NGGOWGNBfAIBuF1vtA/?=
 =?us-ascii?Q?87XKQV3R96GvqvdCQ+UMGpQnN+8TXE4Pwt3OBToExG31OvtrTZ+m3tVuF3G4?=
 =?us-ascii?Q?v+ycJJjyiXQspuDeUIiluL8EnXcw2+XLSJQcm9pJg4pIE5UozxsdX4CO1rwJ?=
 =?us-ascii?Q?ZDwXOXAtYwM2/FqJNy8qLt7MQt1yNKNaA7IKM3bU/ScJKltwrk+pqQKbvcvM?=
 =?us-ascii?Q?mpIsKnVJnsUlvquceguIOSbbWGiMprMuvcvcJzP426jrE6n+DjU3H/j5bssM?=
 =?us-ascii?Q?LNW4NqcLyr4BYm9QpRynxIBR9ogm/GLKfCEHYqq+sjT629deMOLoc6KaGAON?=
 =?us-ascii?Q?RaFBpEIY19OvkzyUyxlM7t7DUDqxfeDyTXihUzURBRIPUomsETCq1Lg3u5Mp?=
 =?us-ascii?Q?JrSnJFqLcRCb8tzPAFpl/16e5KzNzigg08p/zY+UHS7r9Y32d5waalVq9JMF?=
 =?us-ascii?Q?41p3gQ40EzoQLn1/ftf6XqQYW4RHMReuk2O97uVWr0o7ds2PzzcZcRBrUfC1?=
 =?us-ascii?Q?mWIgz3h5/ZxgpzCnIRozEh4RPR7tnj86OUAQYetIaZ1lbgrzQxkUuAr4D/aA?=
 =?us-ascii?Q?BgLrnNvDMkFqBdmhzpwW7GwoSNo3j6WUTJXZIUbSCm0xnfPPbUjjN5BgWbyx?=
 =?us-ascii?Q?8CdeE5tJI6KUasJqMVKzsFUPgGWHPvwPtcO84Xd3e7s1KSqR0og1m70phCkB?=
 =?us-ascii?Q?LHhkElDXust9WnOzeCvDru+uzaiES8H14H9l+rV9OqDp/KttcHIk/bvqx9BV?=
 =?us-ascii?Q?GVkM15GgZUMkZ67ElqQEN1sUh8sPc+FmADvjYkqJ+/UpCCRI0GSZ6t+AfcTA?=
 =?us-ascii?Q?TVLOJNRNpdx8QX26Dan6f5Ed89ZM4KI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a799df-ee7f-46c9-e1ae-08da235fd634
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 06:26:15.0095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOsNou/JCsJmKwHCZJS66OSwt1Q+/dVZk6tEQdowTuZbBpCHPO3icupsHV2AgSG2uraSgMQKJbd8YXa4sGsBYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2247

v7:
 - rename retrans to reinject.
 - drop last_snd setting.
 - deponds on: "BPF packet scheduler" series v13.

v6:
 - set call_me_again flag.
 - deponds on: "BPF packet scheduler" series v12.

v5:
 - update patch 2, use temporary storage instead.
 - update patch 3, use new helpers.
 - deponds on: "BPF packet scheduler" series v11.

v4:
 - add retrans argment for get_subflow()

v3:
 - add last_snd write access.
 - keep msk->last_snd setting in get_subflow().
 - deponds on: "BPF packet scheduler" series v10.

v2:
 - merge the squash-to patch.
 - implement bpf_mptcp_get_subflows helper, instead of
   bpf_mptcp_get_next_subflow.
 - deponds on: "BPF packet scheduler v9".

This patchset implements round-robin scheduler using BPF. Address to
some commends for the RFC version:

https://patchwork.kernel.org/project/mptcp/cover/cover.1631011068.git.gelia=
ngtang@xiaomi.com/

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/75

Geliang Tang (3):
  mptcp: add bpf get_subflows helper
  selftests: bpf: add bpf_rr scheduler
  selftests: bpf: add bpf_rr test

 net/mptcp/bpf.c                               | 44 +++++++++++++++
 net/mptcp/protocol.h                          |  7 +++
 .../testing/selftests/bpf/bpf_mptcp_helpers.h | 12 +++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 37 +++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 54 +++++++++++++++++++
 5 files changed, 154 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

--=20
2.34.1

