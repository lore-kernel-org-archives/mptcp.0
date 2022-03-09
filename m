Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DDE7C
	for <mptcp@lists.linux.dev>; Wed,  9 Mar 2022 12:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646829250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/YrbMrOsnM6GIkercnkVm7eW68zKQvfgh+9dhKjKZGI=;
	b=iP73/DoJi+3fkpbj8gDOyFJGJF1aUFEQpQNy/KssaK0fxUC3PAnAuH5EK3R+dD7x8+qEnD
	RWTI11ndav6aH1LTePgP2DSGFSOn/aDiT0cW8cHA6OsxxhDypIFR7F4q/mIQBeoKuG/6CV
	U5LzZjc3Qftp4FPXh4e9koQ8sxLm9ck=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2170.outbound.protection.outlook.com [104.47.17.170]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-LoLPD7IKNe6L8IVsqOCUmg-1; Wed, 09 Mar 2022 13:34:09 +0100
X-MC-Unique: LoLPD7IKNe6L8IVsqOCUmg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2fbuJv7WvVt5BDd6D9dWgBb9JtqjD/c/YtulwOtvtf+J9KKOeZp6Y5WvMhmxfemNQJsuS2CADafHTOCNPYOCIfkzzSNPEM/HiyjdQb+1wg5NImLCqqeCf6IHaIMzs8NYC4/SOkYDoaa5TvHbSi9XqCCUrpEPXd84H1e/cqBv8Tou7KX47WDSxTY0NnrVoO7ZGwbwvJfP5akzyyuYYWqlhC+nakN3BKtb86tM73u0j95Kxlrdw3Dp5RxRiXanHjmG+RlmX4K/BRHZVid3mluhonakgAEG0UdBQVQaUdmADJwwFPuTNmV4ZQ9HPwNbCr5ErMr44k8GfXZuuGzbPMgCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Es89VGLdajrN98rLyg0HuBlxjsevTAbTEeMBou5Jmio=;
 b=ZrwDNGx/pfWAWdPzY8NhaDouJQHvSTbPZCdXExmd4YY+xMVxMQZHRU5ht9rvkRFWypWu1Fv+kMHpLqNa9N/IU/35BHYJusQW2roPFMMNGXBt8fjBsz2JDKEpsappK0M2iPbWsgIma7y4ckNPfQgyj79zo77ygMvYZQ3pyq/FjWBRro3bA74lcxzOl3z3f5brLuDAVOzD1twyKDHcu/nlpAnPZ9AAxNryZghmkJEqjI7nJkob2chi8ohW4mE7Orcg7RAQqFd2i8e++O4MsJEiAlqSo8189Ybm2zhwmB5d9VgYQJH9bqzDEiDaGNkWVRTrTKApa+zexlMlkR/LE6KjzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB5782.eurprd04.prod.outlook.com (2603:10a6:20b:aa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.29; Wed, 9 Mar
 2022 12:34:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 12:34:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 0/3] MP_FAIL echo and retrans
Date: Wed,  9 Mar 2022 20:33:56 +0800
Message-ID: <cover.1646829006.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:203:d0::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31b30bbb-a534-4e06-f502-08da01c91b3c
X-MS-TrafficTypeDiagnostic: AM6PR04MB5782:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB5782A8AD3D2C1B0F6A8538FAF80A9@AM6PR04MB5782.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cTCK33EaEl4wRvbdJxhmOc9MjVv67y4Zh/AKmSGwESyUh7GagqoQxT+CBPVabk/nKljTcXP5MbaNBFDaFvTrprTTdMHMyer+SLdFIL2d9lqJRtGxvJ9HG7wQ5BawxogUiilMNM4qRF9b+rABc5mDsatJDrNXwEjhTrxvGtWp6b+t9O6QhNGmJRZ5YtEr1bFps4pn6eeGKT9m8amZFnMTBI1zvdsm/iaav7MVkxVYkc9Ux24slBR+Kp7t3pzFtB1x6PBNDdpvwSx8y7MXbNrGO9RVLy4nMNxw4JTUbvXFhS2BsbYjlKtTeavIMwCsZ5Fh2/da7oYaMIiNXEZGHsof6rmfvemJ3cKDTgoXghwvBy8F/G91EjjljDzDLjTU8aW77/9Qnwvai8ZOQrfGzKH+vyCy2wpEILrKFdFcoIBoHs15ojMD2e9iodmpfPvZ3sOSuyC2T11ake1WYSzA24xU6idyOfvfjNpPwixsu4NXgWud92VwbGLbd8BhGaVYN9YXgD+XYO+r2WU+EV8PEIrkCJmcl/+UgItFmqxH2Fj3QAu2e+6cskhC1U/PGmpXesmHGY8WZloLZSCnKw+fCIdzkw4ce34xe75r8h1tTbzX1dhUu5nzWsIEc9K6z4VXG0ZeF53POLgdqu7V6WEau/1LrLkid48BSYO8Gsh2wD+CYlKbdRpwpIHv/oox58Cun8IO8WCaqKpyL4Dd8Vy5UCOYM+Js9GlYNLUrLE7hSXDg+nPpUA/fdFhd3cZZ0hJCcXisf6p7fZZ4KitYcZOUlm2WVA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(83380400001)(36756003)(44832011)(6512007)(6666004)(8676002)(5660300002)(6506007)(4744005)(186003)(26005)(2616005)(2906002)(86362001)(107886003)(38100700002)(316002)(966005)(508600001)(6486002)(6916009)(4326008)(66556008)(66946007)(66476007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JGdqVrDu9HYBC0aMiDu5uo/ucGj9uQdgXY9tut/KK5TPtjmb1YTV80DJ+DNQ?=
 =?us-ascii?Q?7pTpyAkOGN68P8vX4jStrvcAbLlTHEtbNTSZWL6e/j7Mm1YAVx3LtnCssmM/?=
 =?us-ascii?Q?zt3+43QTriJRPhy1tYfzPwsPERm3vf6jcJx7+CGNXSZRjC2g7yoES9jDzGRF?=
 =?us-ascii?Q?ojOjD77bTlmWRZoIYX1teL5XBBY2BcrFSqQ0i87zJQiY/amG6+HkQZl9WJLb?=
 =?us-ascii?Q?4H5jjiItf69Fg2eoKompenPMrmcDjCImUcrXYgV1+8fGZXB9Oa80tgs6P/2w?=
 =?us-ascii?Q?oN/VCqU9yIkmxPQZso2FE4W3GNjiJIeZOrZ+NcfYzPYkw7Nsi2idNSbLmk07?=
 =?us-ascii?Q?LQ+tFj0eWCOWBHQK7jLhkIL7OTvMkIHZPHmS8VLgR1liEx6k5Tc5+cyXrh5e?=
 =?us-ascii?Q?MSJLRzNEjmMxpo4v7DjGxRLhT3v1VRqTV2UnK9ZRV41KypuRtwNXK7wC5zIl?=
 =?us-ascii?Q?05dtzTjS42FxJdK/7Bn/XohduAqZxpHdzZQ3i+MgDKmh6Z07knOIbBoSMiCZ?=
 =?us-ascii?Q?meOSGxhXOeb29LNjvQ4wQBeIu6zl5GuZERbCFn48kmlfCyOtqKiuBVzfSQN+?=
 =?us-ascii?Q?QEstYsTZMGI6T/zUehYe/IjtKqtC+wYhD7VP30OlKL/IBKtSexA4snXOgIEy?=
 =?us-ascii?Q?eLtI2a5/896pDhKxs6bsuZazhuvqp2qV6A6sNmIQ0w0P1SFFXpJkq80NZ2IA?=
 =?us-ascii?Q?n8safLwnb0enb4pREAO3ZZ3TpfDvks6mly4BY2Hb1+axNqlx7TZF+8z2x5h/?=
 =?us-ascii?Q?0pKIpMuMPEogj6kwOoUcuViruuG5933N27jCSqOvlLQrUfhMgjuZ60/doK8I?=
 =?us-ascii?Q?A8au7knGOqH6CWNmRzaoG6bLELNdaSN4baAXT3VdowwcHSb6PqmDP4wCutkV?=
 =?us-ascii?Q?fJL1kAg6Nl4D6zI6T26Ei0isMPKDiNP4ErxEdhm5iW3cGVrvVADWRr0fJ2/u?=
 =?us-ascii?Q?tjCj+RW/zgwMEhMadbBT7cjZ4mej1M/K3vw+Q3z1swqV/yYBqRzvmKgtP3+z?=
 =?us-ascii?Q?rU3fbsYMRBBvDmkSbJOlxBPqOe8Uk0Ow427PFeF5b6tPBPFNs7YRIoNdBwCH?=
 =?us-ascii?Q?5SBXuTUTe+E+iBiVVtZrLYS3TjKteUlS7eIgfQrLdHygxm8ESYy8GekMUKca?=
 =?us-ascii?Q?xyX26L3bOvoDL2E/+7nZu/l4DDlYsHMHcUPVufTivyuzDtCyumGpGfu8aGtU?=
 =?us-ascii?Q?dskhielx2Q0opdXa5dHoDtUrCJ/DKTSwqcmxyWvxrMkSN5TARZpsRbRJIgzD?=
 =?us-ascii?Q?3mBi5wdRuKUb8xzNcMiaqTf46N3SovS6Cc8lZqpzgyK21yQA6TVW/y1lQwif?=
 =?us-ascii?Q?J78IEGjUO0SgkcezYxsk+4dyrAXlmhupOyRHWWKrhbohzA6XxSAhKxBgYOUM?=
 =?us-ascii?Q?l5xgwSUNilrsjuLySl1nsvVjB3cvprwqJlViuTuR0AuLT2xL731zvkoKiAt6?=
 =?us-ascii?Q?fMI/mChgYMOOtFRFIqepVG1qLSIGMPtfnxbF0HCHlU3rHf6zwiS61s17XMEy?=
 =?us-ascii?Q?t017HFT418e/eTvjYEOgqH5EhAICDe3LBzWP0KNosiZfGsg18iEnFTGtOYBt?=
 =?us-ascii?Q?0BG8WVyCDzwnlezNqtbOte1gmP4EF/YLgqM/hQkb0t5lkPFIQIExN0vb+AN5?=
 =?us-ascii?Q?3aEi3lJkZB/0WT/PW/XzNKI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b30bbb-a534-4e06-f502-08da01c91b3c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 12:34:08.6348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KXXuVuwI6nlP0gB66sWwbZ21ZOr4WrvzLwMZ38elE+ugxo5bt38sIuukM7cDqj2lCw71zohV+8oYJk3L1/v4YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5782

v3:
 - use msk->sk_timer and a msk->flags bit.
 - use READ_ONCE/WRITE_ONCE for subflow->mp_fail_response_expect.
 - update selftest.

v2:
 - don't clear mp_fail_response_expect flag.
 - add a helper mp_fail_response_expect_subflow to get the subflow,
   instead of using msk->first.
 - add locks as Mat suggested.
 - add a selftest.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/261

Geliang Tang (3):
  mptcp: add MP_FAIL response support
  mptcp: reset subflow when MP_FAIL doesn't respond
  selftests: mptcp: check MP_FAIL response mibs

 net/mptcp/pm.c                                | 11 ++++--
 net/mptcp/protocol.c                          | 21 +++++++++++
 net/mptcp/protocol.h                          |  2 ++
 net/mptcp/subflow.c                           |  4 +++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 36 ++++++++++++++++---
 5 files changed, 67 insertions(+), 7 deletions(-)

--=20
2.34.1

