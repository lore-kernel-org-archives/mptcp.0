Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D33173
	for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 09:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642066157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+LUZoThSc8nS3m0WJ7nkUzb60deFvPEtwc8zfHKj3hI=;
	b=jTcXdq/waVZOIxm2Q8hLT+nm3dTaDrKu7LEuzkk//E23g/KUsQbNksbEGqxSZumJRqL6Ea
	wXGquiRm8YZHvzDjQfBDeJufGjtWZY49Yl2B07fejdZcKWfBNjMoOoPETYsDfHbqIpEF9D
	yqOiJM7MmzSxQxpVRX/iqmSnPDKHFZA=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2053.outbound.protection.outlook.com [104.47.14.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-5-04i1v9h8MLWUUyqcmM--BA-1; Thu, 13 Jan 2022 10:29:16 +0100
X-MC-Unique: 04i1v9h8MLWUUyqcmM--BA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVsWNE1Go/WHH0+rRF75S0QkeA3M3RrudAfcZ/JkpmwuEWpg/NzakpIj5DOPEhGmAtYvF+hoD29/GZxzFZN4yLhshXeoaWcvPGMTtbyGnuKGLi1c6LKX3Iu9z7afbJDq4DJtUfSvhXTLFmR/iLXRORcZ/cDR+lhHEXhPNg98V4x57gZtvukPDYkGFb+Tdr3JVPUi/Vjpy0SxsJHPXf9cnYsS0hFYM9UqWUTqz3CWZDV+p8OlL3d0+JjYjB94d/s6TfOez3jd5QUUEMZM14vqR89hsCoeY8rLuvgQLhwznZpQWxXOVHO1kbAwiQqSDWuVJt5M8FepBbPrHOGU50nTJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsEMQEAFx7vd6ksMy5SjW8yMyyqM4G8eSaEGpboKsaU=;
 b=Um68ogC8fT5XRBLdSlWFCrRmMEe3CQ51V6UZwJ5DxsnneO+h2pcg2az4+kj+maKiAamS2jlLKqPDobjU+biT3mSISobmHzYtJ67+cQg/lRVWYaECxe527ZCudmvJvOxTmqTj7H/uGBTGSv2TJu/Bg7p8vlnH9kNPRKuTa3aSMgqliMsmv+KqXLS8mGphq7qqgC4h629wETs3YTfWrsaBTFLBEFxR/gqWIZHQkeGmrtmPokjSlf1JwOJiCmR3XJPk0HIP8KPY8v1t9lbM5D0KkSa6SxyJJPF4hlHbzKsk/M65CwRlG8JzVEuHEFHtxwIY7QGWui5np+rFMXBm4cOvMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9446.eurprd04.prod.outlook.com (2603:10a6:102:2b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Thu, 13 Jan
 2022 09:29:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Thu, 13 Jan 2022
 09:29:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 0/5] use 'ip mptcp' in selftests
Date: Thu, 13 Jan 2022 17:29:01 +0800
Message-ID: <cover.1642065488.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:202:2e::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c45857da-5788-4f74-854f-08d9d67729ed
X-MS-TrafficTypeDiagnostic: PAXPR04MB9446:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB94460B47C97308898D14F080F8539@PAXPR04MB9446.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SC34y/mcAissEHMeo1Wlp1tgHDddSG2mMXGx2yDfVwiFNZPEIrosJdJFdLFW+ngWUWbgeOsJrznfbIzt1hitixvVfhmzoNrU4fp6wpqNLsQYVGDlxz8Y5gjpY9kWHLAVScgviNrPHxPTV531vhvvcwzK4ZTO/3SHXeIq6fHjozexRC8HclJ2C5PeC/pR+DVXQyAxwhyFDuqc+AgV3U+fGPR+d8iCFm1sZA+8xRcatwW25mAxZcHtag5mXCiU9lV7b6tv1HFNDB3aBkXiEvgb2dpTA0t8A2SY1fCtA61uc5Q1zb6h9CdcO6lpnO7nYC5EJt7zzfvGOxo/tZdrZGEsVBN/kgvOElge1QYkm+/D4YDCD/EvlYoNw9b9dc5XNycD9xPZH+s1jOiARbvts96M25Kmi3t1PnbRx9mEBTtjnQFGLhK1SSLRwOWNJNVWFpedmuSc5F7vCImHTRiYnU2gkbsqN9cZPnplBz3XBLkm78ytXSEmDxjdP0WghsVUK+pDKEB/piNAGcBhv8prRUtVhCsI3UCGSDMQlHs11V7l15nSl5wSXaXsI5aITE9JNB5iMaIDTs161t7Leiu/4vYx3Dj4iSluMWCdSAnmADJFapAlaauYR+OGnhnrbaDhfjn/a7E7PoA8CCsYCWjQ2XRnDg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(508600001)(83380400001)(26005)(38100700002)(86362001)(6666004)(55236004)(2616005)(186003)(66476007)(316002)(66946007)(44832011)(6506007)(36756003)(8676002)(107886003)(8936002)(6512007)(2906002)(66556008)(5660300002)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RROYjOt4wL0Oh/0gI/F0Y3tvlpLOprIEzktguqfZoznpkR/+xFs7oZadmDhX?=
 =?us-ascii?Q?zRcTtBlGFQSusio9GV7meW7WF7qgAzrxhpqB8Q54U01jJltcgtKSzk7DALYH?=
 =?us-ascii?Q?ICSXyn4GXj5vcXxbo0cLZRjqB/L7ibjjrRFppJWb6aQZ19o5KPVG55Mzatxx?=
 =?us-ascii?Q?rOkESnE/ErSGoIGz0S2Lx5t0eCXrVDM54Hi+pY4v1/1aUc1/tAzDXxwWGLkG?=
 =?us-ascii?Q?s2f/1lncVmg4RtdwFI3KZGesTygdoeEsE0llcXN3xRTwLE+hRZXfSAKJCQBp?=
 =?us-ascii?Q?siQLrtWV6ihX0qNsSBRgDWIEulKAAwSh6ZXExNvydp5HfAy6/V7YTt1Q+Yc4?=
 =?us-ascii?Q?UV/u8zK3ib6dWNoHxOju4A4SR+EmVkJji2g0M/5ESWiMAMODvDayYvK4o1VF?=
 =?us-ascii?Q?NpUMIzwmVvIBQmsR+2nDwjVrVnah21ZJQQocYSjGmAFkK5j9SM2/VJizG4Gv?=
 =?us-ascii?Q?v8siJe6FW6GwKF+ZbmTWHb9vmlHYm40pH9bCksG9Z/TJXtO9mkTPHwUaN0eV?=
 =?us-ascii?Q?Wj0JM4edtj796gcsmNbMRiOCPepxyOznQWyv6YGRc75OLIJarB7eAOECnhKQ?=
 =?us-ascii?Q?/aSvup3yVsiCwbZi0TkO+w0zZUvYjIPZVivFUCJ2f3WcBKnBmP+qIhF9en8V?=
 =?us-ascii?Q?KWBZbaJ+UKDY5M7AO0u8MrocKWNGRmfCX9zi9/hr9+bpuG5NNz6NGJ7RCmlI?=
 =?us-ascii?Q?xKLNXZ46vPfWyHagiSaoDZ/XjkRjR6YC02jBHbANHqqat3cnKNR6kny+X5wb?=
 =?us-ascii?Q?Dr6HrwVYN7twRldf+JIs5XJPMg5mj7dHlIpgsRfYlU2WHfR3uhbtN+P+A40x?=
 =?us-ascii?Q?a+XWTk2mlF9zjGfkGDMAG8xtDIg7x7Qn0s+K68WjR1ZNvyge78LVlWzyOQ0N?=
 =?us-ascii?Q?TwUvmejDzsBemewYyIRnyjPUhHqJOwqqpZILVSckX96uW2EyquTze1n+A5Rl?=
 =?us-ascii?Q?mFJWnarudpCGyTT9xPg/YQ3b4G3t5zW++IlSHrs3WO9joiHneekC0kc2+9Z+?=
 =?us-ascii?Q?g8KqmcEV311GLXeyOGAH9h9rurSNdUFTRY5EXL1Dmn3vnXjkCCyOvFqTNZKQ?=
 =?us-ascii?Q?IlPaA2tKayVO57Cf7GFb9Zn6vgERMyQVy7QO361YDHJElcwjaI7ETwZW/iAX?=
 =?us-ascii?Q?Oq6v+N2iieFCcwK3K5n5G8aTDiJ6pwStHzEU8eYzO9t5yk2hRy1cloNcDDrv?=
 =?us-ascii?Q?lFtR3zXBMFFeE1TiW4fk6bvZH7cdcL0l0o9vdHpJsL1BpNNIO/6dyFhBw83U?=
 =?us-ascii?Q?seTMwRxI7rzwFNt5+DKTnrOsTiXZ4/o84LRN98qf5VN7u12rSKwt8G9f6NX8?=
 =?us-ascii?Q?dYKRu2UdekbtNXUmrjIAtp/ZK5lOQW98qRgWiMbSN8tcChl5E1WkM5eW6H0M?=
 =?us-ascii?Q?/6ZT08L0Vh7XbZo57/CHasZIOMTfwl+XfLrLrOLbX+1zc0PFVbytZHBVX6sh?=
 =?us-ascii?Q?y1QRelrMXHnipIC6nfJWdvTI5pOdhISuboQ9p7mIB2n6y+0gn2eo9EFTV7gO?=
 =?us-ascii?Q?VWg8bvCmYYJcr6z7eMQ1Cfk1BYtoTg/b89C5pEBi/LLY5vH5tVJfUANIKTQ+?=
 =?us-ascii?Q?RwDVE8gNCBwx3BTWptF+xdOcIXzmQkpP9vOLO2CySIdPNSvCloGDlC5JJfwW?=
 =?us-ascii?Q?3Tw2H37l+7WC+BDaBKlB7kg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c45857da-5788-4f74-854f-08d9d67729ed
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 09:29:14.3457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdWUyYNdZuI2hH66lD1cwrcXaPApJeKr8vIlJkmsVvpJE5q3PbiKtxEg62nFMucbRyOZs8v7p7PbUl7+5htzTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9446

v4:
 - move the patch "new approach of getting addr" into "set_flags port
 support" series.
 - rebased with "set_flags port support" series.
 - depends on:
 the "set_flags port support" series.

RESEND:
 - update subjects and commit messages.
 - rename pm_nl_show_endpoint to pm_nl_show_endpoints.
v3:
 - use new approach of getting addr.
 - squash four patches, pm_nl_set_limits, pm_nl_add_endpoint,
 pm_nl_del_endpoint and pm_nl_flush_endpoint, into one.
 - rebased, fix conflicts.
 - depends on:
 the "fullmesh flag setting support" series.

RESEND:
 - fix typos and checkpatch.pl warnings.
v2:
 - use both ip_mptcp and pm_nl_ctl in mptcp_join.sh, instead of
   replaceing pm_nl_ctl in v1.
 - drop last three patches in v1, keep using pm_nl_ctl in
   mptcp_sockopt.sh, pm_netlink.sh and simult_flows.sh

v1:
 This patchset replaced all the pm_nl_ctl commands in selftests with the
 'ip mptcp' commands.

Geliang Tang (5):
  selftests: mptcp: add ip mptcp wrappers
  selftests: mptcp: new approach of getting ID
  selftests: mptcp: add wrapper for showing addrs
  selftests: mptcp: add wrapper for setting flags
  selftests: mptcp: set ip_mptcp in command line

 .../testing/selftests/net/mptcp/mptcp_join.sh | 876 ++++++++++--------
 1 file changed, 501 insertions(+), 375 deletions(-)

--=20
2.31.1

