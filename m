Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2057.outbound.protection.outlook.com [40.107.8.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8CE8F50
	for <mptcp@lists.linux.dev>; Tue, 15 Aug 2023 06:29:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1JpS7vDWxOO7s3p6V55rCIAOcX+a4cySTTCNOCyTbICYtfCrTACiy74uXjEHBczuDje3nbsN1t78QZarjTbmCmwrHQ/crA8+enZFMNiG/S40LguUyKh0vYKAJSpRGObcrgfzBok1XfTZ1KN43p1fRQ1ZgIABY6orHz8yN7OEfQ5psr21ni6yzfC6/eP1xikzhT+DoB5bbD+ajjIGdPzs8S5xrJPW4xt45MpK8ZCkgkV9vGO+gmdHnuFz/M+vftGGFegxT3fvVjf7PQbxyprr06jn7IfdPxEpS8zpwm7dYGvSAcvzSyx/+es88rUCuwblA8Sv/HfgT7WlLTtJ7Xp5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLf8q6SCzIzRDq5ukQRsaSS8bWSp0sz+B1omeJCaeqc=;
 b=HoLOg0NLv6PhgD1hZRKuqI29bNA0ou5sD4qIHBbABrTk0DsDGX+KFi7HngbhFd5UmTKk+HFzV7+3RfKvaKifDlxIXz4OgUOHnwDaptCrJaoasVFvDtp+rrFwqZLHnm/8+yT/NMEXPNg+ygjK6uozET0rNkJAmU30xcBjbaxazFkKtcql9y0j0C4f1mUH97hbrnciMUMB3Lrbw+6jp2Y13Cg5gfm1/jBMF6RR8hpi44BH+PopIrjl5EpZD28Lztu+LGBcz8D+VRNqAE3qLZBUvlpldQx4JukMssCQUZfHbAI4shticKEgLWwyTgiNdafeY658Ptw4Tm2McyIr/RrMrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLf8q6SCzIzRDq5ukQRsaSS8bWSp0sz+B1omeJCaeqc=;
 b=LLujYPDk1iokKpNJCieBMqXUQifECzvVVnPAfv4UB5CFzRu62+OdkI7axYHCVnRMFranuUO6cWysAM6Gwm4K0Tu1g0vPCplNT3p5CrFMLWKTaG0odZlOA7Nsz5XpMsQHlI5om4YhZmbo3VDcEVvH0V76Br6vWJPwo7ZfuaazTqEeo3Z5sqOjvnyo49DSW5qRNffL1NlNEmQz3PO3zLvip4lRt2t2AKZJp/ookW1N3B6/gQfzZ4FPFoYxj8G3Wd+hSCjrFC+CoKmkHuXka8tSS9pKrA4As0taW1jW9zvgQgHr5IXKjqihX2MYrqluZwVHkVdPIh/uKn4w5da185fa2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8686.eurprd04.prod.outlook.com (2603:10a6:102:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 06:29:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 06:29:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/9] Squash to "mptcp: add scheduler wrappers"
Date: Tue, 15 Aug 2023 14:29:22 +0800
Message-Id: <76d36be7ca5f426b84597d38a3c413bcb87ff7cd.1692080803.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692080803.git.geliang.tang@suse.com>
References: <cover.1692080803.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0266.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8686:EE_
X-MS-Office365-Filtering-Correlation-Id: bdd84776-f547-43be-d32e-08db9d590172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y+TiZ5Qmk96Iv1vCSqmRf66h/E/MnFIZAia7y4I9lf3abgHX+FHiOI2R2MYjEqE9b7kKEMR5FLEGsnNbdpRhtfq67CUWTUVM/XzN/LKb33ONvvci1NI5dHBMFoZvaVBDx29R7S7kdzdpd4RvIq8feNnGkFPRrDj4RvHWM5k/dJcfpaDnHKJghk2ORnTh/WhGllguXmX323STbusDLcYrQDU+pnY9Ev+G0BSAEh/R6jVCKAdftiH51kaA0SWZSm4W7KZ3umPCZrmyCe66TvJEvcZlF5FsxM+Ys4Obi5VycX34cnCjLGLCp/LhlErptsrqaBO3TBgE7GGq2HWcLMFNjhdMCfxzRRNwHHSoYE0li2HF5pYkRd8L8LqHs01KWtPjTEpi6b5+YrvrPMKc2ywyPlSd7Tqn0YIhDShP3RmKmHVM1Kj2JRAygjlSpPUXiQ9VreAoHcKCpbxElp/oml8SS1Ef8O2ZQVm7RdCmVMvTgrgbTI9tsy+ZSFXIjs9G/czmdMAfLSuXxaJrk7z7fsJH6GnKGTEBMzZWeZQkYmRR+ZBpbkYlbOymjiifNu+eLhfg45kCbH+oHhsSFytx0ZLTNEK0pSaD6GygVPfX3jHvbqw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199021)(186006)(1800799006)(26005)(107886003)(6512007)(2616005)(83380400001)(6506007)(41300700001)(66476007)(66556008)(66946007)(6916009)(2906002)(316002)(5660300002)(44832011)(8936002)(8676002)(4326008)(478600001)(6666004)(6486002)(86362001)(36756003)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LMbRU7chE6GCKsvJwZTy7qXgy+uWjTbFWgX7f6tS2PxBJGMKY9J5IqdVJyKr?=
 =?us-ascii?Q?9u2Cp7ouRNAOsKqOOE2E8BlKeoogJ/tmsVR1920oOSoSULmNyA1ljVYu0cKF?=
 =?us-ascii?Q?L60JR51lgWOhTDcBbVEJO8tf9F1QAqaFG1raQAMRfWSQaEhPWipYWw6uRbon?=
 =?us-ascii?Q?BissAFv+cyyZdZA0myDJ+r3O4N2BDKL8CSqxMF6JufDhSNjsCu8HRXrGDc7l?=
 =?us-ascii?Q?tnvZGHwomq9VqGjanoRKH1h5PQg3b+3yB5UKPiaBnEyPlijQqv7qHZvw9TT/?=
 =?us-ascii?Q?KvZ5rNKIAhnvaa/Is3YcTwv8xTgs4QT6UZr2dMiQv8Y/QhMKz1o9GR1B7v0D?=
 =?us-ascii?Q?j5QPuIhqOhF+Cy261h5zn89IXHSe/iYQFrN7xrTjPiGPekyKaOo5TO1LH82z?=
 =?us-ascii?Q?sbchA6mEaoRGmR+gkX3MTJKw9qLDPQILvy8ZGspZJVNqiAz+p/jnRLMgMqUx?=
 =?us-ascii?Q?RV5XFunLLWu+643bVN5BseZD3Linunra3nQYFbB6nzyOLMLcCuL0Ja5dNOkL?=
 =?us-ascii?Q?RimNnwVApjgLZncd9C5/Gr1YbMB1xCLDBBDqwM6K9Z2M/RKwOCWYeK9q/ChF?=
 =?us-ascii?Q?pI1+FZyBLmhC+a3X3U/h4Fh1m2Nv837QBGiGdhJDJJ4KWCSNd26bXAsKVxi+?=
 =?us-ascii?Q?UDaLwi0X3jE6H8N5qPmYYVDCNRk9Cl4PjF68UtPI43lr/C6+0DuJUe04My15?=
 =?us-ascii?Q?4TBIRerfkHssBthK88UrplsdJpr2KYwGKWevOa7u0ZpxTYcWZI/fRhOvJyHP?=
 =?us-ascii?Q?jBa0s12eYJkmJGxnMQ3aAnKKA/c21lrXPzZIJ914aJ4Z20E3+ld0RboGDeP4?=
 =?us-ascii?Q?ooix05JXjV7KmvI94aMqs55kgpz5ZByPRgUJPosUOs96SLr4tYtO3NKHXyIg?=
 =?us-ascii?Q?T3YRaboze6Rcp8Mq3IR/0fjtNpfChI2eY+oyHejlN1nHpWrIK/Q7xOUjFOt2?=
 =?us-ascii?Q?Q5PfpwhR66u99VaHWqF7YPAEFK+5hDDn6MxmoazPQVR4QTPXwYcXfCKAuTbd?=
 =?us-ascii?Q?qI8JrAQNSDbjNX5P/PCAmA6si+/YN/w30X/pmXxyT1oh/ZJxpcZmRyZUP3KU?=
 =?us-ascii?Q?wXzCa4BkZTVYOzDIQ6PUehFatmv9GUpY+2MJA+KM/Gi442WpyyqWmIm5SRH/?=
 =?us-ascii?Q?7Zj39chhOLbW+iAhplL99ZgQ5ZiSZ51efBj7wvU4zEjaZttUpwL1jxDMERlW?=
 =?us-ascii?Q?solbORyMlfe1cXYG+7n2VW2xg97GXXEsM1nvwYReNzVp/05JWQi4hZPHeELA?=
 =?us-ascii?Q?sXoa2mlz7yV5jyoacm+D1S1E0Q6NHrD6en457AlW1WMYa3oZpTMpKmRyKG/I?=
 =?us-ascii?Q?gUClzvtuXSgs5Dy5Sr+wO2siC9QdVBXChxks7yVIuz49PLOhEhMtXbsLAslJ?=
 =?us-ascii?Q?4EaQ9pv4ZMyWKASNAogVFNvJab+/dfyN8g0kaX0qBPGZayixWOH1fRjQkMks?=
 =?us-ascii?Q?tuDO8jywe9kU/0SWV/IPNRR4PK9376tu6TKaY9dIPdREx41b926U+DVJuF4T?=
 =?us-ascii?Q?h/3m6bDFUgzhjoZnC1pWM8BA9fdclG5/A9/f5B1nkZKWPpFmHA/QazSGmL+H?=
 =?us-ascii?Q?+FZyC0r5R4hOW3RFH7aLff7F2HiwLVvA8yxQm/EC?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd84776-f547-43be-d32e-08db9d590172
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 06:29:40.6108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LfaIFqyuW8ugNddclIMdFIPc/ghJO/AvKhx+usqQXyXitGoGdW5cHVKeUtDRv3z3yrdVdUjZSKH0WWaOlBHb6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8686

Please update the commit log:

'''
This patch defines two packet scheduler wrappers mptcp_sched_get_send()
and mptcp_sched_get_retrans(), invoke get_subflow() of msk->sched in
them.

Set data->reinject to true in mptcp_sched_get_retrans(), set it false in
mptcp_sched_get_send().

If msk->sched is NULL, use default functions mptcp_subflow_get_send()
and mptcp_subflow_get_retrans() to send data.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/sched.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 049c94678d9b..31defb8c4e30 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -161,7 +161,6 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	}
 
 	data.reinject = false;
-	msk->sched->data_init(msk, &data);
 	return msk->sched->get_subflow(msk, &data);
 }
 
@@ -192,7 +191,6 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 	}
 
 	data.reinject = true;
-	msk->sched->data_init(msk, &data);
 	return msk->sched->get_subflow(msk, &data);
 }
 
-- 
2.35.3

