Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60081.outbound.protection.outlook.com [40.107.6.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766C417CA
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 04:52:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JC/+pXFEkapsy0ygfU4aaeoO7Y8KomlHRz1xGX01jDloS7NDS/a8kPJ4NqTOLQGgjGYr3WhNbCHHiOBvZsGyNlspoP0qhgHDA1KPSFIocr8vsGFu/zW3M6RlpWVIxQY5lZCW6P8ViLBUXp/ALRA4qkLixbuDCJummGhDDC2ZVT2laCLZoSccCMB1JM/k84kscWheWupQ9PUv2HlKBNgZFTxP5Oqmtu7fxm18ioXtMwPNrV1noQOO7Z+EHm0vfyhTuZ7Ro6v4o9KpMJSb/HuuBwPROeuFtPuEEUVBR4bft8J1P1T+BEhW2DR27u8YPlH6DrfjoFq+iAmIGE/fdq0BJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJjowJ4690G2NdLtiQ+Je2I0ckCnZXEC/DGaQQoUNmE=;
 b=Iz1VgZIrjsWV9DQsfeEJ2DYcCZ9n24qq71DIsOYpKlApBFgKQVV2Qr+x6w83tjagSkGEwvfb/g8R/IvBLcrHXVHqLQx43LV/FjETtZsLV797mbCi+lNtrSuHwQftWel+Jre9GN5mpcjmb9AJ0yR8qUTBha3F6R6xJceDrI42Vjq74Ih+4uGEKXnCthrdgV2zTOeXHFX9ELJjR2ZJ2Sm13WDRzz1EOqPRGWmutJGFP/WQEBukJC6c4bc9WI8kg6ebqJgEQwM/TNa3qMPfjczxympYS+BQzPkWzs18xuoEQEY/gCE6D6CD0KnYgjee1XdDl+pcri9UjPEa25dWXak9Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJjowJ4690G2NdLtiQ+Je2I0ckCnZXEC/DGaQQoUNmE=;
 b=roTSvyOv6mwBne2hJHXCR12BJl1AkRw2eVCSH4SCbytzeNSDNkHyWfXYjwLLolzaSfCZNF2VLb7+tVhQinadKv/AeIvZDU3KOgrv6M/q20N4vdW6SNBSfvvppxT6Nd2XDuoiT59HHeMsI9rP4nz5QyRtRZ9O0mTK6yKvvd4UOHq2gLaBMEuwArIiM5qe2OvNF+uT6YauQ7l4v/cCcl7dVpY4PmQaT/QLj2rjRPj0cMQtMcJLSGW0obgpb7ucWaIYlRqEy2d743/8obfXhiTHeBCPRQSaExiY5LHEh7vTlOiJl8cm53ME0wMLdwuT8oWbbusWJPdizdrrjQet0N4Ydg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7722.eurprd04.prod.outlook.com (2603:10a6:10:207::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 04:52:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 04:52:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 13/16] Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
Date: Wed, 12 Oct 2022 12:50:34 +0800
Message-Id: <f00f5f70d8fcbb75125daf861d2536b744371f4a.1665549881.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665549881.git.geliang.tang@suse.com>
References: <cover.1665549881.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0167.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cf2b631-5cdc-468f-102c-08daac0d875f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sWkdhYZFwr7dZ0IRj3oik0GioLFOBzq/J9aocm4RE6+lixq5+sKoo+FVh5LvvWcrFZDVFKcU2DEFRcmVZjN1DAtsJkCSvQke3H6Nv3gfrxMCbUcXaoWqn6Yfl/QYnG7IsqhMc6yI/mSWi4Pc/u4whGkedE0w51Kfyg3RdGToCjUgM92XOW9C+n3X3MjqUZ3JzIBw6RvEuIsBDrT7eV5YnNM+E+LGdZAAWrxsi38eFU2JD02qYlEGOnzpBRPgM91fd1LvNI/qXrkH0Kb9fdCa8xGcYUd9Ev4Pq3arecaRGFNpguNo6TfP9g5+uilsP1YLVtT6WDeCbeb2gpwlBaDd2YiLv3almn1B7Wf1NBBC59c8yCSLalKOMKZGWKxVO+jDU9XhIHj4ET9qc4BDaz+x7Hgrkn/4HozEcXqVJQjMQDPduHFtdoMBJBBiM6Cr+b2jUtqp7uh9KGbAmJfcuyusY96scvUCr50SG2otsIN55qyZrDj2N1Ib6EvQ7UeV23MWWyi7oS++wYvAz7ZQ03OCIicNW0Rh7w9Cg2TqxHSoRkcAxjwpQpirip8EwBw23D4W5RdqCivD7P6rlSN5j8ChcBfQFKL8hXAnd7XnpGX28W9G6WulusVM/UBx0OnrB4HtrAULtyDjFLbFiOT7oYGKw4hwFoHdiDFBMOrj5Vs+ls1/iAV7KEIWsWwQ0S9/bDO8X0C+zoY3eTghhlH7Mqixs7TMQkrdrHkTfvinbT578MXsrSxP67T4qefP1EhNauqa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199015)(6486002)(478600001)(38100700002)(316002)(6916009)(186003)(66556008)(66946007)(66476007)(8676002)(6666004)(107886003)(4326008)(44832011)(5660300002)(26005)(41300700001)(4744005)(36756003)(8936002)(6506007)(2616005)(2906002)(86362001)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6BpVduc0vvylOgCffIMBg2V9b4O1b05+M+iBmX24vgOmVUthfdnNSRoOZFOi?=
 =?us-ascii?Q?YpA78f1lAhgymK9F+d6GADuN5KKp4EenLrl7rPR9uanCko659lNw5o71Ywr6?=
 =?us-ascii?Q?0AlFlihl3v50J6HbOnzwCt/aduO/FNPWyrxnnjF2Oy14tXfgG664qNJfUSkJ?=
 =?us-ascii?Q?5fybxkTofNjH289Qd2xQX7LMzd7pTMitXn5NmHqENyvoOHcq8tQ3XrEqeeib?=
 =?us-ascii?Q?SGFW+rx7ij9AyMhPVllRxDlC2PPd13LMFqq9M5PBM5pmlW/bFT7wRVezeeGA?=
 =?us-ascii?Q?4rI86ECLnhU312gcbni3ONVv+nSbi1981XlH+XkcRn4HRPJvOz8RXtkl9ZcW?=
 =?us-ascii?Q?KqUO+re8IfmAnSoj9Ttndxc7da6DNjNYVUguuMH7qH4nwwsMmtyzPoFyqeR+?=
 =?us-ascii?Q?T/qS4iHbMb2ZONpNAA855G+0k7lG0OIm6N25oZm/8oZGRXmyy7X+oFxF6q+y?=
 =?us-ascii?Q?SHcYCfqqyqyR55JI2yuB1xePrm6jQtdZY1icXbnEdcBet7LVPI4Q4rvToegi?=
 =?us-ascii?Q?n4AbEa+M2k76BsiTEcjdJm8Umcp3nWx6tNfPQKfjdaehwy/9GYMvoA5eZ2oh?=
 =?us-ascii?Q?amZrqJdwXv1RFvs1EYNg44gIdQamL0uIMM1SJbZAWTXHotRxVY1NSFOAFIhL?=
 =?us-ascii?Q?ckQF0FVNAqGNnFXd0sQ5cibZmWFiK2DdkGunN/gDzKBejOKBMIuD8yUuSD82?=
 =?us-ascii?Q?tyirWZvCn2fBYPg9odaxWsY/RZsl34oGLFdV4TDc2RCTjBAPnnpoyzDbHuWS?=
 =?us-ascii?Q?GMBoeRUh8yFwQ8Ze9596JE4+9L9cXihWldH7gytORO85ESzHLoMom9aLhjCV?=
 =?us-ascii?Q?Adr/4Lb9D2R2LfgehzjSMiTKBr6Ig7DKtk2a2SPr+AtQeGxepPpT5YPCoBnV?=
 =?us-ascii?Q?kIWD2LbtvTXiO/vgSk5ijKKwf5+ZTeOshdYJL9wjtQPyPF75QSwOmbZDZfhl?=
 =?us-ascii?Q?SfSvDl7bSYi+1HC+P/4ltuDdE1qW1iELqyIESi1+1iGKApFSUbMlBeyD3wqH?=
 =?us-ascii?Q?Of6cioqmpHF/5jsNX4ROWqzuobMY5r0bFLsb6mdmOSn+PuqH7ugfRKco3rpE?=
 =?us-ascii?Q?tnuxgO/iJi9Ih4GdBJA3U6ZlARqOI6Mwncr5GYBxAqQJwZt7c9BCUVSjI96j?=
 =?us-ascii?Q?r9k3C9sxSJ5yq8lHFyrLBQY7PGqfAiaPaoT9UqePHg/ki0eX0AOVLvN/jANp?=
 =?us-ascii?Q?PwXMreJYq+P1onNOjFWdRm7qFwza7fCzUbWvZzPX/BOe1lJp4KW3/+pAmscc?=
 =?us-ascii?Q?qclNyKtibXhHYIlwOrRTTyihvohgJq7ZnSzdWV1qw1rodjHWKNOGwK+83pvu?=
 =?us-ascii?Q?7eLgz0op6vbzscKrwvae/0DvZPERqYHqprhwctfn3Ynfmcsu6mvbnLEjT/BT?=
 =?us-ascii?Q?ZBbZbkmhGcTRXyQ8ZALosRCGJ3LdMQxn9yP3JwT5WvXDTF7mQ15kQjicdAaT?=
 =?us-ascii?Q?l6TqJbQkeTh7Ne8BE+zEDcq/avAINBPsnB/efL4yhvk2OlNv96qPYjJgVoZR?=
 =?us-ascii?Q?2tAQWJVWQlxrAEy9VoB4O9NxCOxtaTliLLyz/RfRS68fiCB47NhXq17KcAPK?=
 =?us-ascii?Q?WjW3ABdATTmdMcwzQmGsmeADhaMxoeCGNTjKAVVeAKecD7ld6OkQrU16Pt8j?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf2b631-5cdc-468f-102c-08daac0d875f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 04:52:13.3146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k8hWdesWPoHvqM1NyXl+j5F+gFWUm/0QNfc/2cMDFLiItMgMxZS74NMklRdcLQI6bjgfSaovkKHGiCv9YCOJPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7722

Add mptcp_sched_data_set_contexts in kfunc_set.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 0a768898990f..03decb05755f 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -164,6 +164,7 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
 
 BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
+BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
 BTF_SET8_END(bpf_mptcp_sched_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
-- 
2.35.3

