Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0B51FA0
	for <mptcp@lists.linux.dev>; Mon,  9 May 2022 14:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652108219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JqJ+yJ21UAgg5CPdteNZ35KXhzVuokO2ATtIVVszC9I=;
	b=ELkzb/fhIweBVPAkyUvKutPCcM0d23QBF1SwWaqnNlFPpOTqHU/HVHHgLr6dKgIBaGlWAI
	3ZoBIT21pTHqGHdK1BqVrxH1QS7QNYSw80oNHgai1GAAvfJHWvvzufIlIHHyL82aodgshy
	tvzCSUxlyIt7IB9RdiSsGxwC51z68Z8=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2057.outbound.protection.outlook.com [104.47.2.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-24-3vdzZbNDOU-bIfP0KTHrjQ-1; Mon, 09 May 2022 16:56:58 +0200
X-MC-Unique: 3vdzZbNDOU-bIfP0KTHrjQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHib0eqr5qpZpwMRHDTtOVONqAdyYh2D8R8lkOVEq77aiTBJkOI4godDy39d5Agm/spBDgLPnn/ugoyYHu5d/2cp2+Cj5S0YIB/Qk5s7NZarc7wHdP5vywilXnzWIM/A9CtKEyuewh9LILXHschbT9IG7D2FxqRb1qIpucHoZsu/HFiB6T0PLyh4INErd2OpIxwDmzHcWRpkfTFKvoqCNk++kWm264N66ryt8ODFEShuk9mqsjsq3KppVX0fzW+7FvBupUxiazxqfcNOMtVQykfo+V1RHqD8tPVKpFNwffwFeFjhBO1MHsguDnUfA4tRsVpF5IoVXxcd4tWTVyjf3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9Q+Dygnfh2Zz8ctcZMFJjhhQ6gh0xqb4/jIKcVu2Ig=;
 b=KNuIZE3muU0VbF+1N/kvs51kc0u7/MfjHgkQ/bZvavJ4rgfFiDaZX0ARk5uaRzQXxAM+pof5NywJJqQbIa6AWsNcrruYmTc/auofVAtsN/Iq39jQHACEZyy6EbQBakvje3LSVKEtYvkewZBGS7wm/sDvh2MM0LOkylPRyhWLak0i3TleyN7RgQI/abkVSzLIF7wyijB1CX+Zi0rBSJ7qKmrJPo9qpwg0cQIJUoJEZJ8/hNyBua329sp+9e7iHrHw+350NzrI+GzPNXxFENKwy0bVRkjDovPro32++g/Cyzv37MwIPvDTujUBgpVg0Sl74YpoR5BTG7gjA3hyoBxYvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7975.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 14:56:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5227.022; Mon, 9 May 2022
 14:56:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 0/3] BPF round-robin scheduler
Date: Mon,  9 May 2022 22:56:46 +0800
Message-ID: <cover.1652107942.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:203:d0::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78d91aef-fe55-4e38-f813-08da31cc29c3
X-MS-TrafficTypeDiagnostic: AS8PR04MB7975:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB7975FD8C31487BB0C0BE592CF8C69@AS8PR04MB7975.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AvnFLuMdQF49boNx4h0NmIzAkBhe0ncqkSbMIfn4hxWwYZpGTpEeXSScw9V6ATHLs3NatXZPEix/jCom8BtJTtw3kOdb9D0fy0bzFvkxyqgN29GPW2Dq0IozBLkivU+KXLL3g5tfZZzmWuKutxwiCyW+ve1oc6xxrnP8PcK32gQ3FmMuNWhoO/P47zxc5YUUbpY1986QKDwYBN7CsPP3jwuq/Q2PSnL11mfQKQU2jdG+Ehgl+VqrG1N+j4+hylz4oDj3ORE3uSGfajzJdbVdsYqNb1E+AaHMtq00IzUrnb5kGzelNAyJ/BOaJzU0eabD9TGIf8scE5qU1guofPoJVn869b0tIgoIPVixewCz99WeyfWB0rZM1YJ/aq4M3+a+1hc/g4SgLx/0nlEPQa2KaFh9bHMVHAtVlApoDS9xvlBNXEyaoDcux3YdrXvuqy03HewMGaKuu75YS9Se+T/fnhn5A6dk1RvElNoEV3urMR8v+Xlbi2hBrbbvNe8SZtIVPnzkVs9twrRZEtK6JCvWA55XNqTJ6/Zn+huU/mi+kOGiCMBXVZGEfaoYpeHNSDXyANxnKwXoQt1hgWcIi7we5aHtLr3/vbPTNEZe5qfdb2tZ3/2t3aQTv/AFgUF6uLkjvsZto4ejPDyXvL5ho2NKactphxmPkPKgrC4AspXIWL54SCcm6FIP6dt7lfhZPdptBQVWgJfU+8nqoEWq1ykZoo/imSBHP55c8vtvnEzR8f2IkLkUBRoztoOp+rmJCKGxwd7h/nm7GTp4FcLnkB8LixaN6q1eIme8yPWN4dPBs/Brg1nLRcceQTmFPKTjY3tr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(966005)(6486002)(66476007)(66556008)(8676002)(66946007)(86362001)(4326008)(316002)(2616005)(26005)(6916009)(6666004)(38100700002)(6512007)(5660300002)(6506007)(107886003)(2906002)(186003)(83380400001)(44832011)(36756003)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L8p+zkvZelHwutkZ3WXu8XoXw4yLmuKYJFRxJDluXhA+6tfzIE8X6Ri6wcKu?=
 =?us-ascii?Q?ogks1R6u9+alKjaTcUlBPJ/AbK7couFyMVrBIVd7bLDK0URcl9+ZYY3JEdV9?=
 =?us-ascii?Q?oLI/QD0Hpj2NSEUUlSJFdfbk25WggiFHD0oNM8//Boh/wStiWoE+iqsiVB4g?=
 =?us-ascii?Q?SGRK4TsNCGHmfvN5wguIDZEyFnesyZd1GI7Rtpsfv/D2tWPdPaxVefFmsPGp?=
 =?us-ascii?Q?L+w4oqdgn3PQw6vDjnxV+B9/KgZtjDy2S8WtSAhLE+vjTyRCih3608rPNjFm?=
 =?us-ascii?Q?7prjqvvcysYDUElBN3b7Q4sTmlKOAhYykaaSltqvkaez1ds1h0B1mY70iWEW?=
 =?us-ascii?Q?Z/Ls3YkaEVKWTRd/h/WdFarAWnHyzAom4vfOpNHFN1k/cHf3HeBa7h5wSJla?=
 =?us-ascii?Q?TTs9R9ux8840MnQ5lRsJ3cwQ+btPH/b2uOJRnUMuSlucd0i9BEEElkPioD+H?=
 =?us-ascii?Q?ZGcYNFRQoI729v4V5acqxf/LG4Oa0FJg8zHLz1sHA4CO20HhePDpbk6WtzPw?=
 =?us-ascii?Q?1RrasgbbQN1in2t5o6M7RP8dOgwP3uGADfTdJMJKhaQl5EZd4NsPMEcX2MQm?=
 =?us-ascii?Q?TxgXl7x557czQxelsrL/MVyiC97paQ2VDGPw1V+dawwqbxVZ9Qvqk1rqPEQF?=
 =?us-ascii?Q?1v4tXgqzaYHIMFGwFXKaGJ4LXpWLNE6Xyx0/mXfiNV26NhSzfQ2DvkXy6Vog?=
 =?us-ascii?Q?XqWK2X6WAb+4zqRyl8jnkEL+VsWKS1IrTluxDDz/2JMbGWv7TFDuxLFA5ubb?=
 =?us-ascii?Q?YenPbcqdN3PpFFFTJanDN32JgjtkIYq3kIbpK44rkZFfC4bkgEqbcK7WkkMH?=
 =?us-ascii?Q?YBWgFau4zfJBNW97XyJcB16AedE2PS5SbBois4xKtiB7kEv34KbFRwYK6/3t?=
 =?us-ascii?Q?89K+PIR9tKAi+VeP/9Tv7D8jfsrZSb7RWUagcaLXb3BYgJm+ZToYE35RBae6?=
 =?us-ascii?Q?7wCBY1tVNYWG14xfNL0BsTSuMyBxS+erxlNXoILciyJyV1KuTjFkr3QnMoJd?=
 =?us-ascii?Q?AmKrD/UCQViBxtdi5RiV8RQqt5DiFUC1NhMp+m4v8Ckvnes89MsFJV0RpAJU?=
 =?us-ascii?Q?4Kzfj4P6DGdYserKpc/Pm+8ch6Kjlbt+Hy/iVsL4m4NJsFBY6xtqsgWY149R?=
 =?us-ascii?Q?UsdP/FHT6pzigGcLLMl2hyCVggkvI7jabKVVXCAbQdUsGmgUb/1aroEVuPaB?=
 =?us-ascii?Q?dBzOQNttr9M+iKlKCn+Vi9x+rivfGRip6oFahoa6kPan9XaZ/eFuzpYmQiQI?=
 =?us-ascii?Q?j/4fGfnxVPQLsnEuqUDBoW9fS9TG7BKe9MC52e43UUkb14qHozgMCZxs14Tw?=
 =?us-ascii?Q?U553BLqnctgkFlZ2hM86o76Zs3XCqqTQ29aHNC/nyUcaOmTSEjDUsDWpccEi?=
 =?us-ascii?Q?go3ykrwRPtrgrOMYM8xO61EEZo7vCGaR4zILQu2/tcvaXEq5/Uspq8+6yfJy?=
 =?us-ascii?Q?3yUW7m5iSxksru77vhHv2Udz7UumohQjSfXAnS0pJUKPkCvUcM3sgFPWaMU3?=
 =?us-ascii?Q?YNqBgzGRtZo2MlEthoPzTXDFCpxslLDEdnfCf8S5UC8lRHfRjRYxq+PMh9lx?=
 =?us-ascii?Q?EVPN9PnfDFdx3cKRiDxsgX30DQfJNflsk5hbTLdSSzXF9sRhppPOtofnM143?=
 =?us-ascii?Q?zlUkI8sRkL0cnt8mVdoPy4mfqgWLS4qgmE1qZutQf71EFE8wAT3AGN5Z/5Hp?=
 =?us-ascii?Q?8mbB+E/zS93Esi7zp+lBn3FfAagAm247Qx8Z8K2e4NnnTqBhhe5GLZf8A6iA?=
 =?us-ascii?Q?56t4phm8186Sa8InRdJtLQYT98Zv8nc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d91aef-fe55-4e38-f813-08da31cc29c3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 14:56:57.3894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTbcy05Gmdws4BcQTC29E3lhPRrzdkw8EDbqU6/eqYOfrdDxD2UYntUEAjojFLejRazMeMChsu8TiCslL8uxxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7975

v13:
 - add !msk->last_snd check in patch 2
 - use ASSERT_OK_PTR instead of CHECK in patch 3
 - base-commit: export/20220509T115202

v12:
 - init ssk from data->contexts[0], instead of msk->first.
 - cycle through all the subflows, instead of the first two.

v11:
 - rename array to contexts.
 - drop number of subflows in mptcp_sched_data.
 - set unused array elements to NULL.
 - add MPTCP_SUBFLOWS_MAX check in mptcp_sched_data_init.

v10:
 - init subflows array in mptcp_sched_data_init.
 - for (int i =3D 0; i < data->subflows; i++) is not allowed in BPF, using
   this instead:
	for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX && i < data->subflows; i++)
 - deponds on: "BPF packet scheduler" series v18.

v9:
 - add subflows array in mptcp_sched_data
 - deponds on: "BPF packet scheduler" series v17 +
               Squash to "mptcp: add struct mptcp_sched_ops v17".

v8:
 - use struct mptcp_sched_data.
 - deponds on: "BPF packet scheduler" series v14.

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
  mptcp: add subflows array in sched data
  selftests/bpf: add bpf_rr scheduler
  selftests/bpf: add bpf_rr test

 include/net/mptcp.h                           |  2 +
 net/mptcp/sched.c                             | 14 ++++++
 .../testing/selftests/bpf/bpf_mptcp_helpers.h |  8 ++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 38 +++++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 47 +++++++++++++++++++
 5 files changed, 109 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

--=20
2.34.1

