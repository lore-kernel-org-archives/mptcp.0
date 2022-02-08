Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1C629CA
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 06:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644300256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oe1uop05NCXDzlVhz6AEqRR+fzGkkN3CXDJ7p07wUpU=;
	b=AbpPetKXrubXSSwSc3MsO+55Hm9+LdCf8fUePI2TSLtDG/I4ao+fR/E2sNLJB69SJ0jDWb
	UmJ00cDt/eJ/45zZ+YuhL17Fi/8Kq4lMdjFu20zBRsR4ZcjXfBVxalynR7tdJol2gj4Lpm
	BPHSkCTHw1PS73MAj2Q+vwbjh1VUgbc=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2058.outbound.protection.outlook.com [104.47.8.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-vEsH4Z5WPFqMNJ7101Lt5A-1; Tue, 08 Feb 2022 07:04:15 +0100
X-MC-Unique: vEsH4Z5WPFqMNJ7101Lt5A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrEgzbvUuBe28JkrvI+XhjXKY8OO2cp2kn/hzmWFXNPgegZck4YV/a4c6soAq4PFFITV/a1M7BJMZPAkdLbsgnHvYVDv5I24SxN2bGxiSbTZoVb3SzsmblFNNtGm+pHVp6rdmoffxnL/gA2KXlJjJ4yyLS+BjpChXrztkWrFVqZ3pkhLkHlr4LYcAIJkdhTDM3ooAdclnozmElFOSaRhndtwWdi8pai2yK6IODm4zHg+On2zwogcjLwas9M5VW8KTexTSM8rmpuT6o0t+tYE3Eovt/O+6WP3Guo8XhT7uslP3mbD/sGadgevMsfV2/eoFAK0NAPI69H01Ss79NayRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VadzUj67r//MaqRxVG+ISbYOZnfc+YjJdj6WrJ/iITo=;
 b=ajIjBhPT3v8pclgI4U4WdiKT13Oik62lBZQfzbAAbXA5YySDQQdyIZSKu6SwwYRvnyZonYcP+0AfEXnkzCDgPTcOM856LKIBjQAdoyjIDLzpMXrwjymsLC1eMQJEyG8njbXR/K+CLNQaoWPbIKAt6H5FYbqLI//N6Anx6YdHKypm0h7sjjXZm2TX709k6kxLMd3X988TbUHMvFc3Ra9hOkeJ7tMdG29om+qSptEH/bsfvJ1gcx6pSIzXRuyc1oAIY3jRU6UDbrcfcaJnUDRMKka16040Tjkp8/2f20atkGSDXjxPuiWxz13gOJGU01/zgG9P9Aw1Y3GjvZYz4kpHkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5569.eurprd04.prod.outlook.com (2603:10a6:208:115::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Tue, 8 Feb
 2022 06:04:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 06:04:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/2] Squash to "bpf:selftests: add MPTCP test base"
Date: Tue,  8 Feb 2022 14:04:23 +0800
Message-ID: <1f84676cdd56fc04ca33a2a62ab2fa2328987746.1644300192.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644300192.git.geliang.tang@suse.com>
References: <cover.1644300192.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HK2PR03CA0054.apcprd03.prod.outlook.com
 (2603:1096:202:17::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7fb5272-9b99-4945-774b-08d9eac8d512
X-MS-TrafficTypeDiagnostic: AM0PR04MB5569:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB5569CAD9800A3C56C3418636F82D9@AM0PR04MB5569.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:459;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jDBdyBP8RkVpGqghkGczTy8cbnvPXKIZMbqMc0iYv5KrNyhtYyd6eLV10G02HsgFcl414ywzYGYcnREuP/is4UkhhNDwpoWxyfApg55Usozz1bHN6YN+uJoF1X7tYhKHEVDSCvBsE24/Y/jNx1aoH20KeN4s7+wfC06xyLPXRLjvG3uGPjveWaHIrGPrgE+J6B+5hb1lYiCEe7ll8rpXenARZoscoET2GgTESv7S1WsmE0ewgkT+jinlFE0hTSy/tN2C81DA4TpFV3C5wys8iSCBNuxJ/I8Z1463XqUX4nEGP+1r4d8I6eg/zaBUa+rtZkhz5wRu4de2hfYa9bmHVMacorqO9Yu7RhPKS3v4VZg10CoX+uwrP1PH1jAjwpqzVxTMvZA3YCoJuBfATh/I6cE6imMxuSrrbpkXI/mV0aFfcTUlvpGIOgiUJV78A+h8lGMMFCb7PdlEPBy56ADpsCWK5chVMh7H8/ahOTRLUxxj9YA4YjrjouZCdciPMagM4BRtb/aBCDa4fz7MbLwedDRVSgjN/ifWqpYuoeFpalvwjipEQavMv2uzNvmYTUVlErD6fwPnR4S+VBmwTT9EaWsPnqeolxvmkMDWiIbBPDrF8La4RhhcU6wo2+O31lcoUXI5NbNEy6pKOWTSoU55lg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(83380400001)(5660300002)(6486002)(44832011)(55236004)(2616005)(186003)(26005)(36756003)(6512007)(6506007)(6666004)(508600001)(2906002)(86362001)(66556008)(6916009)(316002)(66476007)(66946007)(38100700002)(8936002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fusIrOyBY3wG5gvX55/ScHxrKvt6+G91AiblWScbVpC+Zfs2TOvavrbAcOeS?=
 =?us-ascii?Q?DY8of//XUThOXLe/B7TywhbFk/Ty9F2OGsmJDC4ITlpLW5fsczr8McNMOGri?=
 =?us-ascii?Q?xZIiswhZBmEQlr88/vwEjtrEwdywprIKwyvQZ+/Sfqjjf1pDMf8FfWTCzUdO?=
 =?us-ascii?Q?2ckLr/qPWHGWICKdTwdACSxzwBpUcJSzh207iv8tjy/Ib+bVpv6T7wzf9dUx?=
 =?us-ascii?Q?j2Iz6+IGoakZnOWnR74s8HcJp2ApIL/qi4xOh83/RR4HIQonGYf978345xNC?=
 =?us-ascii?Q?iFkHod6C0x9M5TtF9PMi4otYncXL5sk12Oo2t2vSMWAukNkP5umREfHkje+w?=
 =?us-ascii?Q?hoyMVPCvFCLSIGRTtNFhOUDA62CU5G+tdyx1P874nwP2OtFnVTcEnLF8JCBV?=
 =?us-ascii?Q?a6PUr5A5EhQIIVB5/CjohjD33R9DJJU6ZiMXKb2A5bPNheWp8UC53geuuvS9?=
 =?us-ascii?Q?AeX1YVc6tBUorx4MgYcC5u1PaHAIIaPwHZ4cSI9Wdge5maX71hcWyIBj5w6C?=
 =?us-ascii?Q?zufuAUpOkiUVL3dwT6j47Jr6GD5Yyxiu/l1yMfOBZ73IT830x2waH3MLnojL?=
 =?us-ascii?Q?2APMfxnx3H98OdP7QXQsh0EGcuvG2CqPGngkgkR90LsaLXBOQKQP5RzdGk24?=
 =?us-ascii?Q?imKICrs/Fm0I9rXc0fGj8yOWD+AncrCFPMabepzITGJiuOY7RmX/AEeP2G6V?=
 =?us-ascii?Q?P5IJ42e34xpqbUuXnVR6B34V/g8EJhJ0geUjgeK4hryEPVH7MZguHdTOYzhg?=
 =?us-ascii?Q?txLphr0sRKmszLQVM402kMY4bWkOfrIZEfnQJ3QfVGoSGDH3Jr6ITUjhfTzH?=
 =?us-ascii?Q?cGA/T+O5sV4/hu+A86V5bthQdsHjNGP9JNf/vhT7HSMTvV3juVXgDTBrVqY6?=
 =?us-ascii?Q?BlQBBnuvxaJ31/2dcPk1MWgLelmi4Zhte1kW/dMRGMNO/m5Zy7TNBC2DhaFG?=
 =?us-ascii?Q?Xiob7ev4zHhzXGkeozM2w+qg/LtIYKEiHBZMStx7ZNisngKiio/LRS0YHg05?=
 =?us-ascii?Q?Bp1pD6JBfX19rul5bNhIDPdIMR+llk1+f0MWz1TwiuPtQbXrJgoFjx3d5G0S?=
 =?us-ascii?Q?U4UOyy3M2O+eDsVaXdBoONSsUGWNxQOHSmkulo3Xt1E66/nCyHlcYfTtdYHQ?=
 =?us-ascii?Q?ATo32DExl4Lg1pj31R3IKzanJCJGK2Vaf1whzFmPCAxW+vdkwv/1QEZ65CQ+?=
 =?us-ascii?Q?qPvJ3fGIFwaYhezs61TKVoT8Rbyce7eEJs4fNcZDNQlnDByUevywpSXxY6zi?=
 =?us-ascii?Q?cmOQ+C9WmnNcg7L9BBFx+ktn+/6le8xphOa9OCcpmLSW0jGJMrKVQaUOziSU?=
 =?us-ascii?Q?1JD/bnWV6KNPXCEq55kfFm588oWPwej76tkBnrk17Jz1FWNMO11/mtePWFAq?=
 =?us-ascii?Q?jiwKksAPBcY6bFspUxkyqpCShLCgOosI5sHOYjvMT+CjEKPqCu5ARbeZIBxs?=
 =?us-ascii?Q?uFPYszaZYd8v53Ol2Yok5wkP3Oi6T4+fDZG/ZzLXNXxahMIrV2lN/B4MR59F?=
 =?us-ascii?Q?Gz8jSj3asdUOSQkcv1xLXQdxqWMUM/i/xE3W5YNYYxwlFqoaKyVUvHgPvt/9?=
 =?us-ascii?Q?voQn6srC2dKwvrUCzDSxMJbr0UHpgP7vNLNvEa6gTNGtE3sV6AsQhb42tNKe?=
 =?us-ascii?Q?WIEO0ess5A3f5Wt2B1SyQvw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7fb5272-9b99-4945-774b-08d9eac8d512
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 06:04:14.1407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fY/dueDGeoe8qpfdSvBtN4pAJbszkkcLEuxJLlTbs4frFRCKB4PlEUZRIGEUfIe0z9btwln4mlTnQBwR5apxZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5569

Fix this compiling error:

   TEST-OBJ [test_progs] mptcp.test.o
 /home/tgl/mptcp_net-next/tools/testing/selftests/bpf/prog_tests/mptcp.c: I=
n function =E2=80=98run_test=E2=80=99:
 /home/tgl/mptcp_net-next/tools/testing/selftests/bpf/prog_tests/mptcp.c:63=
:2: error: =E2=80=98bpf_map__next=E2=80=99 is deprecated: libbpf v0.7+: use=
 bpf_object__next_map() instead [-Werror=3Ddeprecated-declarations]
   map =3D bpf_map__next(NULL, obj);
   ^~~
 In file included from ./test_progs.h:33:0,
                  from /home/tgl/mptcp_net-next/tools/testing/selftests/bpf=
/prog_tests/mptcp.c:2:
 /home/tgl/mptcp_net-next/tools/testing/selftests/bpf/tools/include/bpf/lib=
bpf.h:685:17: note: declared here
  struct bpf_map *bpf_map__next(const struct bpf_map *map, const struct bpf=
_object *obj);
                  ^~~~~~~~~~~~~
 cc1: all warnings being treated as errors
 make: *** [Makefile:488: /home/tgl/mptcp_net-next/tools/testing/selftests/=
bpf/mptcp.test.o] Error 1

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 0e65d64868e9..04aef0f147dc 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -60,7 +60,7 @@ static int run_test(int cgroup_fd, int server_fd, bool is=
_mptcp)
 		return -1;
 	}
=20
-	map =3D bpf_map__next(NULL, obj);
+	map =3D bpf_object__next_map(obj, NULL);
 	map_fd =3D bpf_map__fd(map);
=20
 	err =3D bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_SOCK_OPS, 0);
--=20
2.34.1

