Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AD57472
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="qjueYDUs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWGFzwt1QLQvG05E6XJFoBMFmVE2G3xf2tKQaX08Vlix7o9MaJgxtOGmT0YAPTRfDhpjjmDQNpMlgx/XLNMSbhedMxp7/Kl+Qko+E0zesS6reajdpjMuAEXIkWTGCGR+rbIaqalk3iREiNyykQqFuDa5J+41L1xr3M+ntTO3BIobagmd930Fu2a2oLN5HP6AAl65hLdtmwTqsZYC90WuSf3czIRMQ2SMfw5c1HjyiLGx+GwP39+QfR8jzt+P72tqNrne4u6JqZTd57tG6w48a4Ufsxlnl+Q9yJ9CIt0Wp97iq6n3lsavaxJdFnDzsEd0Jcgk/XTeqqXrwaowKsNI1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5O43D9ijb9BIKPHzYDtIYZdhGtMjEN+dhlKgpEMYVs=;
 b=nDmEj/NCMVUKgBvjOp0AWEri9rt+29jTgiZn2UwAzhConHRX7DDMJHg9foLTufE5zzDZQ0trArC+7dH/1gsYkWGGgRk2M15GZB0AfoVGkCO+iPS7qJ5GkZ3dQJfD9GsJCs1l4ZBSzwmMwgI1lfNbgb3Jk5ZZ7m4VxKkLfF1cc8eeZEjdPSN0/owLh0zVFkrQPot3z1g6KbpyUC3nSB+QKTv77WbPo/VehY97Ti4kEWJqHwt9a/DXwfFgXQYaIFXJ8cYi0hy5jr+BIo4+UA9GdN92PJPq8C2dWzh0PI096EuVCN6ogdCkvkGqyzvh3AZLM+VDCmmAv85a8Z7dPEQD/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5O43D9ijb9BIKPHzYDtIYZdhGtMjEN+dhlKgpEMYVs=;
 b=qjueYDUsHenlLmlwvycR2UENXmY9Lr3DNRkOV3vvXOUX9gYBwFFKTjHSLH0DsGY1KXXXF49HSwSISF8mFYoEYdBfQgsf2NZdWdZiewJOZ/zx2GRMb8MBJ9RfwD5PhLGI0XjfDFP7DLFTwLVGqXYPgANVDQyc7gLdBDrtBd8I3R15OMiCXxvyFHYXh/o88tR52OALmlOdaCWOr6M0fTv7/nG4IXPq0tJ1KGtKk0j/sBvOHGidhOhUBFrak38BDHNC78JCTnb5U05PxKCk5qb0J80mKIMyMhrEyH7mApRFTO1dYLdCogD5E7t187LEiNMCuJeZUc/Us5iO2d+ZavydIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8874.eurprd04.prod.outlook.com (2603:10a6:20b:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 08:36:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 08:36:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 08/12] selftests: mptcp: add userspace pm subflow flag
Date: Sat,  4 Nov 2023 16:35:43 +0800
Message-Id: <4e4793c4b76a44ba47e5cfe28048121d502c309a.1699086244.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699086244.git.geliang.tang@suse.com>
References: <cover.1699086244.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:194::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: a06e156c-06e5-4baa-9dd4-08dbdd112932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OdyTJzXeZy1ekTZMixVyL1viV6AS9uywjS5fZr5QVwE1N9iDaBrsMvD1PIyzTFsINo0KbSai8N7f43S6ONkV0y/4bWs9G1T/ITgGH7DZKZfb6E4XiNqh/o9OshpJrY1NAZScLqZv6mdiYrzX6hjcMCw6oaCrVXB1ozXCJUjlwqBf8WgzeidKPkya0c1xchrdhLcooeOieJKhdzuU/oIc1vRrYEShnEvZVIVFF81h2tIpPfHGrZYRvytwSkqq5O093b2KIM3gD2K5t7GW/wQ/G7+s+jxg0cniBfhzVwR03mVB3mTKgTMsN+pfNmF7IJ7MBfFtdOqUFrHs9Kru5L9dX19KnEQbwv9SHNNAUCJxXSrWIvRWoTwnxv8SxXI/uTL+rJZK9gHHQOU14lS2SMylFc83JC/wtX+/8PP83hWXzD0lYJVzk/EBinfG9YjVOCalURabvXi/csDw9qM9aw/AiK2P2LgD3qUqihuqo0BeB7CBGWR1mH4Qo/8AZUKF2xKL303O5cIRq1W+v/MiVfgcpjwaa38AgueG3Hh25Qc38XWqMnF9qNBxOUTtFCeoJ+NIlEQxsTNNWjrLdVRYJLnoGCEMN+q93mfgsJs8CoAO7qE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(316002)(86362001)(107886003)(6486002)(8936002)(44832011)(4326008)(478600001)(66476007)(66556008)(41300700001)(66946007)(6916009)(8676002)(36756003)(26005)(5660300002)(2616005)(2906002)(6506007)(6512007)(38100700002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gLdYVwO+nAV7+RYwQQeU40XNo175TYu7XdA1PgXrFPJJj4hKDhf6EU5chlpu?=
 =?us-ascii?Q?ao0u9c6FpCqkc4YvipbPCX7Xxee+WkUD4UWbvVDZUY/q75Z6RGfAQJrpUT4Y?=
 =?us-ascii?Q?cpq4ZUkDdxDi5sxcUe4iw+6GhZmXNOmT601fuzEe6rCi6Yhkv9SHBrN3g3jP?=
 =?us-ascii?Q?ErepJ3ozq3Fxezv0JecGKZApF3S1iE0gORNHtuPjn6ReUnYtBpyStXvm80DB?=
 =?us-ascii?Q?ODzLyM7qtwSLN+r6+KtL0eV++qG7BuVa/eQzvno9qFmpNfNpKZzcG8Uvl4eg?=
 =?us-ascii?Q?qC9HeTl3LVS2nkODoUnt+KFNTVz5S4bZ2VReS2lfMmO0NzHD3YHHY5OMYg17?=
 =?us-ascii?Q?1OVCk7h7qqpOlhY9n4uPVz2o+3kYMK+RQiBDINIvegEtMBV40QxtsiydAv2v?=
 =?us-ascii?Q?PIB8UZGVZAMc4QiLI5BgYt+TLporwwFYFp52rlqQCITRbu5v68KTMzKsh44F?=
 =?us-ascii?Q?mO04LI6DcPCwLkurhxPqT3HmvjKJmhMCgfYDiT4Fo5zBWO14ompoTQdXBIH+?=
 =?us-ascii?Q?m5aSh3aZ1JYqfDIV5Rz08/lUbyJfYC/tB/QPW0VHRr3YY0urrq5deD0qTlb+?=
 =?us-ascii?Q?s0iGJb+CFGUaJu245y9uakjF8DUYYSMGplp28l3DjgwAF/ezp/Kp3uC1GEpt?=
 =?us-ascii?Q?qDqhfAVxLJNy9qePHVrQ0dLMw9gdgHMvYnapVAPw3svt3KKvnBiS+rxAF5Gh?=
 =?us-ascii?Q?oBJZU5/Q/vEy3gn+YPKyitRjotI5LVPb44Bqf3umKr6SI3tXga5RtSVK9fNU?=
 =?us-ascii?Q?YjGfyxARiF0Tb8siFaRfbWMsc08Ly/1THsqR2wRj9RHI2bHZknqez0XrNXPA?=
 =?us-ascii?Q?Guc01nwGxNDY9sSKSd5PaR423DOodnaFHTVR/N5V491Jg/E0T7Eg18eqL34O?=
 =?us-ascii?Q?2oylkIg0bSU7pTltRQN7SFPtHjoTEPb+NCnG97XIL6OPAVLe0738gvGxE40M?=
 =?us-ascii?Q?Juz8MbcJjglvh9T8cOZT9/O42vlGloqUevbq4nsfJt7Dk99gqS/Rfo7W1fYr?=
 =?us-ascii?Q?moTqzihVyZTche4NV1RI4tpW3jWk9hSQ/8KxWcxlXgOo/1+uHQez5X5eb0F/?=
 =?us-ascii?Q?9NNTdK4uZoMImD4GY4QYJ6DvXQ4Sg3eZ/uGX8RriIHba8YNSP1ohLghGs5az?=
 =?us-ascii?Q?mJOmxsxGTKPuav/tffiSfIRa7qBPjWGH6Pv8NgH9DJ9WcPaW92IduIfPOGJR?=
 =?us-ascii?Q?h6aDLo49Bfhgs2mC3erNGsFcdJwAazkacOhTl8Ic0Ttq/74ihEsYq/BQ5hbs?=
 =?us-ascii?Q?JNH6/9yqXzHTweJ+47k/+i+KLM4w1mscdl3glg2IF6zvBLw6t7ZqyxdFOWw+?=
 =?us-ascii?Q?64BO8/EbqT0XWsovJQ5xOHl7uh8N8pK22SIt4Cfss/ppV4i3lh3OAjeqzA/V?=
 =?us-ascii?Q?YSaX62NHdkCW8XpPuXuONSAGnpIaFoXFATBD13Imsxnt9JGR5goZM+0LkRW/?=
 =?us-ascii?Q?sNT4iIBG6dkKMPngDQf0JOCl1f3KfemcG/Acqot1W83gw38IhAxeQ9u6rMpb?=
 =?us-ascii?Q?tlr60iEqJYxq9RkvqrXu8hGW/w/qPX6b4c+i6oVpBImmkvOMh/gQL76+aiXL?=
 =?us-ascii?Q?O//I7lNyNQUOHLmNvGiZ6Uwo06icRMOQh1mUtPuEwYJH7SXEfbRl/zOX3y35?=
 =?us-ascii?Q?bw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a06e156c-06e5-4baa-9dd4-08dbdd112932
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 08:36:37.9597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0KrTs0dkVYgw4E2BqJYMztfpA9ZEHS2LOxoWPUWIoSsdMUlPWRdBHg0mpqCZaumno+kV7J0wrAZTgL/U3YIWLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8874

This patch adds the address flag MPTCP_PM_ADDR_FLAG_SUBFLOW in csf()
when subflow is created by a userspace PM.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 49369c4a5f26..e97856323ec3 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -453,6 +453,7 @@ int csf(int fd, int pm_family, int argc, char *argv[])
 	char data[NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
 		  NLMSG_ALIGN(sizeof(struct genlmsghdr)) +
 		  1024];
+	u_int32_t flags = MPTCP_PM_ADDR_FLAG_SUBFLOW;
 	const char *params[5];
 	struct nlmsghdr *nh;
 	struct rtattr *addr;
@@ -558,6 +559,13 @@ int csf(int fd, int pm_family, int argc, char *argv[])
 			off += NLMSG_ALIGN(rta->rta_len);
 		}
 
+		/* addr flags */
+		rta = (void *)(data + off);
+		rta->rta_type = MPTCP_PM_ADDR_ATTR_FLAGS;
+		rta->rta_len = RTA_LENGTH(4);
+		memcpy(RTA_DATA(rta), &flags, 4);
+		off += NLMSG_ALIGN(rta->rta_len);
+
 		addr->rta_len = off - addr_start;
 	}
 
-- 
2.35.3

