Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2082.outbound.protection.outlook.com [40.107.7.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DCA17C6
	for <mptcp@lists.linux.dev>; Tue, 14 Mar 2023 03:00:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lP+WR18SsLujnxp1OxyoFg0ucm5z+tZUFQ1bpfGsxXPL1f1FtUyueP7NLwPxLnIRf4PxrJYQ6IVbqg3TqZePFkOx7v95qWtF5JQwJVg2qqHYc8+2GcFw2dO3twQS93eZrE9lTy9x/oamzPl+ljTfHRlokOhQHxPcAek8nr3dmhR5Wt9VikGsKtWmtFD4ajKA3BcE3W/lu//FcqLIkXBE7IwkPJs+85IkkbGyIeva/2jTZ3gkwIkqofusPIRB33ZiwK8XacabFPHG+90jOs09oiyNhRpgFlVrBjl0LL0CcXjLAVkVngVxOWWsFC4zEPTw3BvRDK75A0rvRbNPSbajCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBhtd/ANFziG0QmGj3k4rTed5mTyRh/ckWhW4PnSemU=;
 b=i3twxzKgjwF7chVy47ItPziQ/usOzCIkbyxXjK1vjbdVPI1wGfywGBTlQHwnzUrTDhrqrQAQpR10UEzQqYGgUtFbDEWRQmbNPVKDfu5Pw/kHGxWEPPRq1VRxTbVb6P0wHqKgMB5h+e+5zmj/nk2W3ddZ+jvWYLrG7GYN6pDFkdfvML+yIurTeIjK1nFnIf/r8KscXuXvKJTZyZspK6olWqELSUmK90SZhhFQYgXnCd/+cdA8AknnwRqFwgTAl7tuJFws02WQkOhtoOiXyxHCJOXDkorRcWEfu8e2zWIZrv55qLI7Snbq4MEJfrQckmApswNiBSh42fGrJE5EXZ1AVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBhtd/ANFziG0QmGj3k4rTed5mTyRh/ckWhW4PnSemU=;
 b=IoS8rDNONWDgXawxZnPGdpQ1TJFCUBUH+JHp3C9QODwmgnfH6HYQo83qe1IP8te9Hfj3gfOgO68AnN6pUPTn7JzM0hRC7JaTvKh+Rr2fJXAoqFq8zwpsqsRFWixEfxTYipy2bmg4fNiKKmgN9gdtWdRXCju1G2QZMbG4eUpxtC970hoFU5HMIGmaou6BsiZN2622xDgVsbKKMPF5O5UA3v0UlvDWbRvKnywF61e5PumY7vbHVnNv1NpZim2E2IweU5tbNqvwL9s6oAhKMD95zWRDNp1pHKeHgGEdOqFsap6z5juSuGoPfwlSdT85GwAoOVyvFSyUzEs/m6EyTLqN1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8838.eurprd04.prod.outlook.com (2603:10a6:10:2e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 03:00:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e%4]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 03:00:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 2/7] mptcp: add addr into userspace pm list
Date: Tue, 14 Mar 2023 11:01:41 +0800
Message-Id: <7f59cf86d68c27fb9785d4a8d84cbf9ae1437d3d.1678762832.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1678762832.git.geliang.tang@suse.com>
References: <cover.1678762832.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: cf629521-cd88-47a9-54bb-08db24384bc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fjFEyBg1q0YwolMV/pB+6rvqzAxys6I9zz+PJmJb0HPQoi5XrwkkdfGORCcn8FYS1GLrEgBY2QTQiEoTMIQOhdGZZUqv5Pj7naAznKMFMN9CYqPC2IAdKk1/TbcUyt3PQjiqpZs5UQvnF6GF/y01lAfoVwUihEvgIAUSA+Gkm95vaXEKq8KZURmo23bdG9CDX0eE2PDyVXi1EFa6G/3nwJbwEYCJB+V9i0tMpexfwnOuFxXu9fTvMTksjn91MgVWv3e/1ITpltECJf55E8wQrl5Hs/aJaFS4btAW3Vm7LVJtZhQRVbIoIxaksXmy6plQFfL/Lty62/+KMW6SPgo7t6k088hFrC2x9Wvm4olinZQlRXNhWSR+c0x0BNcjjuogQQ8xItHYxCzFJ0r5LuA3OvbUJ1LrQHsypW3T9m+VKcXerUj1dbs/CFdep2dG9UNU3VhFPoBdtz28stCNtI/ZzVAiVKr/ve9cr9D4FDpom94U1lxiP1/CE8vymrLHGFX3hIBkqGvlNuuF+YQ9xqyoctRnX0RstpFLAdNpn+2MAjZHlhxZRNNGEgy/qHzKBoXv3lwhRhdC40grbZuh9T7S0b7+HGb3BMT7zlMXNWNY6mxBLx2krGUGuY8sMlPInw/P7VQRArTola5UQpTjB0xJj2oxoeChz6eaLiGKv3twOt6jJCPOBzZPEQH8sPgAYchj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199018)(36756003)(44832011)(5660300002)(4744005)(83380400001)(186003)(478600001)(107886003)(6506007)(6486002)(6512007)(26005)(2616005)(6916009)(4326008)(66946007)(8936002)(8676002)(66556008)(66476007)(41300700001)(316002)(86362001)(38100700002)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3tp0Z/1poGzFKVkfprgUviJrqDyTUj71MSIYJOj3Y9qBymRN35akOTwQJ25W?=
 =?us-ascii?Q?eQb7sCuylXCpg5SN7H3D/njTzXs2+M9PTOBnnhjIJirwezkcW437hCwLHoIr?=
 =?us-ascii?Q?cMwxoMDitolkcICJRmxrGmB2ZuwkdEsBR84fdHAjpV3PpxNAhHnhG5D70CMC?=
 =?us-ascii?Q?KtGG64kCaopznpgYhrKuQO0HfrPN3sFx1xMlm7EMWRFnxiJsnM3xw8a7dqfp?=
 =?us-ascii?Q?V7+XRM8iDqylrgvR8Lc56Q9R4q+jR7WvYiEITtG81hPFfPSk9vy63eMHkd7l?=
 =?us-ascii?Q?ii1eqqU8egDOgQ8itz9TSUU4h8PRec4ymWqEF+cU1u9KyJUmg+keoYVB/lit?=
 =?us-ascii?Q?xRL3xtYh/x66pucTbFwmqtG7zBe7vIcvTpgmM4faqlskxS33R1tqrhcjSu+c?=
 =?us-ascii?Q?335fkh88SL6DwE4pmGNPj2uTdXDyU06UbeT86uoWnzXC8RqlXu0Op2HygZOo?=
 =?us-ascii?Q?jUnHsYFmHzZUakBfBk1PROexc80zltOGcOJ8UQ5RO2PYE/umn/iCgAbE9tAU?=
 =?us-ascii?Q?iFTtJ2Ac4TOzIEaQO7PoogV1v1xKhk6+/6t+m28HAB9ADIjdfsqcdrC8euWg?=
 =?us-ascii?Q?rw5ydUE1cXfI7f3NyixZUk74Uj+AwtzKlJ3kS6kETmUMfC6mZBqfCi5k7VlY?=
 =?us-ascii?Q?VbPz4rEMSb7RNfkVp/mBaqs+nhoJoSNwFkBX3pElCMo/SLuR+s9CU7QVshiE?=
 =?us-ascii?Q?Gm8TzT+rqR+AXhddyb0c5T1+6qB1sdQMLhh33gqAuO7ooH3FlWqMGUwB7DlW?=
 =?us-ascii?Q?oVXu3YxznEj72bNZAq7v8NRHXID5eGoUwrQTZqHxA4TgtjuuXVlfIF4B3voJ?=
 =?us-ascii?Q?D6/yhkbwd+76MvsZE2INv7CyDxk7GbNqcGavYdxYhZsCpVMUBwhOGxkkomjC?=
 =?us-ascii?Q?4ZskIkO31rpGixMdE4xEH8Y/fY004k5o3QfevcnQ6nQoDRIIAAjxQUxgB9Fe?=
 =?us-ascii?Q?LeGI0M6GLUmJTdfiBJ43iKixsEJ/lZqPiG5h1Fjni9I9WGKSLXzEpbdZWs1X?=
 =?us-ascii?Q?HiFFHFLHfYE+XZ1+FW6q6uGS2T1dFL/d5VPJzBnsvWygks3Lg0JYm+npoHwX?=
 =?us-ascii?Q?mOXK/QFUbNPU+wGRorWwEcXDrKmh1I0oahQO5Xt0vpMragmYFlYqlIT9y6yc?=
 =?us-ascii?Q?un10tJaCyYDZeh6RdhdedF6fP4LmwACoytpZEziomngbzfTsJhV8obDa7GGo?=
 =?us-ascii?Q?nTqtI3n+RTA4DROBeE9zmZLdvZTT9DMfkmxlWbAM8wVRQL1xK/0u0cc2Cmcy?=
 =?us-ascii?Q?7Cz0CEcl285w1Qr7Zf3ejkUwVIfx9CskGcVeCgkvHlN80qXx0OWtrM/0qLVX?=
 =?us-ascii?Q?iy4rhnR9T9Iqgdmt1GgmEdaIUGg0ZFtxqR7snxq7veKQKzRtEhvXS0MG2zCg?=
 =?us-ascii?Q?gprY8PeJ9KnAokoVTm4gHn7lOYZATxOSNXFWzT1ktgvW+DSpEqg4jsljil0m?=
 =?us-ascii?Q?893lZA/3/HaT8u809U3VWf/bpzeF3QojUgWGus2L16DwkJoPNJEM2pQ4g3r4?=
 =?us-ascii?Q?JdG0wuqSIIRRW1PVLpSf6kJIwqVFSPSR0jzzgicgLsCOJLYwTSMb5nWXFHkI?=
 =?us-ascii?Q?ZMx+bSbvkFOW/Rsxa/0nZFRu22HutnONznr/ioCpb874gBApoT32GmDHKsu9?=
 =?us-ascii?Q?3A=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf629521-cd88-47a9-54bb-08db24384bc8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 03:00:41.2808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/zAbkyfixlucfnLHy5pFznKUHcUbOXPs3qqBICC69rX1y9oqgvz+rbNc33Z4Ayvlnu9QwMWfWJs2aM0L8QVng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8838

Add the address into userspace_pm_local_addr_list when the subflow is
created.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index fe4c29a17466..49f41a040485 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -301,6 +301,16 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
+	err = mptcp_userspace_pm_get_local_id(msk, &addr_l);
+	if (err < 0) {
+		GENL_SET_ERR_MSG(info, "did not match address and id");
+		goto create_err;
+	}
+
+	spin_lock_bh(&msk->pm.lock);
+	msk->pm.local_addr_used++;
+	spin_unlock_bh(&msk->pm.lock);
+
 	lock_sock(sk);
 
 	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
-- 
2.35.3

