Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2050.outbound.protection.outlook.com [40.107.13.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364CB63BA
	for <mptcp@lists.linux.dev>; Wed, 29 Nov 2023 04:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VSBsqeQk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvQJT6jQGAfm3WCrIz7CZUdjZy4DncQmNU9vsk1SXqh2DUBEdrM0JYK2IxEFjcHsMiawI3xcOyJ5jwvpivJl5Wl6bLvd4L39gTNEhRoVUDZ9sTI2Inp09v4pX+/SQRijBZSw5fVFxd4h3eaz8Uk/YY1wTQTzmFQZOWZb6U2kygVV3es071KQb+DZwJOMLa8L796YELSp667/XvABnj9HKrg2H8q8Rq46y7Mex6JKIiJAAAVOLLmvroLQSH2fKBRBgOHy9UT4sguTcuWfKFLAoe4MZ9n5bv+MkCtuX9idWZYqKkKqGYU86iXuNQtELyG/gJCoyNycJDjhtjL3zfQOJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJAk8dg6gU0u9mClrfebSdE1UMczyeSf8LWMrUrVkho=;
 b=UB5hKey/vuUVvG1rKSCXoByyscEhPQUuJdAjmCvf+44m2PEoYur+HIxl9ssgm8NaYPsAknNpuoykutsh4+OmYz1b13QqkNDwRIFwbwoVMCsF2eaM5TSDVDktDtqrTNCRvrAayegVm+XzKN85blwQT50rn+8kRxWOVikqwidQwWqhpDGlZFHEUuo2WN6+vIuEe8YR0ZqaAdhNjTXlNFkslv2779jY+7qczsgFb3gIKG8hT5KDK1fzlWENjR5/oGZxilUBX1rgazH4zH42xffXqtg4hn1ZKXohhCiG6Xf/EZn8Meh8TRpWnJJhZCANK7qy+iX67OmKqiwdRCLMxCsGJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJAk8dg6gU0u9mClrfebSdE1UMczyeSf8LWMrUrVkho=;
 b=VSBsqeQkVAhCZ5Hc0D9x/WoIQWfHiNsYmYehUIxfvM4JqDDvpeImdZ/2g96N7KJm+j0Ut39BEyFLKTLMHov9IYxdAdlojh4RDeG2Sw8+iovPjBvvDuo1Efh+RxQOCx/V6Xf2uRnI9M8BqdGoO0PXwPif4r1YV/gDN+NnalA5116bMfIgKcsJIkYyKFqJYjJvamTcG3j2dlBXpVCMEA5iXkgST64BLcNKhDHfEYhyajYEmjk8zZVlXpRpovMMsN3up4eQkCQU52b93xBWmVWWgOuEs0Tl0CEz83JqAvvBu9D9w8YTh1eIZFxkZmz7q+Jlwk5IkDUqjsvTZ4b5nwCenQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9118.eurprd04.prod.outlook.com (2603:10a6:150:25::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 04:08:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 04:08:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 2/4] mptcp: add a current established counter
Date: Wed, 29 Nov 2023 12:08:52 +0800
Message-Id: <08a899096030f74978b31add1a822f439f7127ba.1701230012.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701230012.git.geliang.tang@suse.com>
References: <cover.1701230012.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9118:EE_
X-MS-Office365-Filtering-Correlation-Id: 63021c35-5155-45f6-7237-08dbf090e008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EFrEAeQ38GJrrC2e5RZlys6UOr40+j+3/R86yJ8iAIAxEs9yW2XMBh4kbBnGFQJihKuhN7pvmLCeQpG2Vr2WRXcv5M+5p/J/is0xIwRvIzWj+6EROxnJNtwSrJIyfp1zqbEBnyQPQd6f0stEQWOwfUHwHIfLO+yw8QdK96YUf/OFlBDyy9ib/HYSfkK0l86soXU0kK5LH766rjqXk7Dnb9LTnTTgXqywE8CBW4j6gAio/H8ntetOxJ40haLcBp1F7mTo8ejxtd8UywaED8WnlksmeVvOGVR09owDykXzL7Q/RBnHam3yyQp9KR0WIDkQWcvHJbXHnaDptJNk+9T4JYD4Y0EVQjsIVVjJFIWp4ym1mUze7bKhdb1CIHIGxx9QBU3l8X0QDcirFNV2J09cXHGwo5zbIx+iuW1Gn3Cs4RSDV1qWZNDr/z9xS0O9bivFZD/9lXBC3a+v01hiuIjaZXWU1yK7UHIedM/L6V6Zb8SVaQsheB+bTlL7m/xBh019VCAcV0/b+vPAkPEc6qLWPPshkkj5j/qJFN3fptMNM89KRpu3hGLLspbml6oV4vnflhblb6iy37ImwFT/DyT9BEibRwVrWSkE205haGGYMjA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2616005)(107886003)(26005)(6512007)(41300700001)(83380400001)(44832011)(36756003)(6916009)(316002)(66946007)(66556008)(66476007)(6486002)(5660300002)(4326008)(8676002)(8936002)(86362001)(6666004)(38100700002)(6506007)(2906002)(478600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JaCU40BPe0nZ3T4kik2fnumwAOw69EynN5BkW0HmsXdkYHi2rnF8y4E78Iv8?=
 =?us-ascii?Q?RnIOWSQowaemtKHBbdKntlQsaiWCTMAg9j03JosIbUHf+zfxYgKML/IM4tHK?=
 =?us-ascii?Q?u8q33zA36i8vei7AESe9IOswK4wMhWEkVz3zdC9Cj14v/p+kphrcGKsUJgNC?=
 =?us-ascii?Q?9Tf5w66PnKQXJZhe6EEUxchP0B9wSgOqnSkZqky73EgPBSOoc/pkv0SM/o+G?=
 =?us-ascii?Q?+cL6tXZdzVLqkzL3GhH6wrnyNps/ZwPxftfUBmDPZ/ioyUS+xEqLo/LztxGT?=
 =?us-ascii?Q?+1zbBlo6+WQ+/VtjV19gWSzI43sJmvojT+fxY+nuEabAdi5eAeGWuViaDDRS?=
 =?us-ascii?Q?vN6zKWN0aiYJ3PK6woQEbzuykxXQTlyqaLZ1GULNWnyPHc0YgNDOKJ4FJfKL?=
 =?us-ascii?Q?5ybZHaSupLzdULaO16T4mcgxr7abFkxs14QrC4tALg7Op9Z0RnsCVyTMSn+F?=
 =?us-ascii?Q?4zRAPaOAquURxjxS9H4tquNSTCLb6ZBInynTVhQMOXB6vn8mqbpvtnqFFwC7?=
 =?us-ascii?Q?S11cMAeK2u5Nrxsbc6qCucPnz5Hz3sh0cIxfRLZ3z/2MQJgTS8aIu/L8ziNY?=
 =?us-ascii?Q?jnZn+5jiWBCwUMl4kugsH0U51b8QKPzsPqB90wHNjNeyyISYfqwhWVRcfDdv?=
 =?us-ascii?Q?gVMYLhuVWr7v/h2VHdPaaFcPeD4lhVhxhhz6BMnfNW2a/dJ6vOVchxi1Cj5d?=
 =?us-ascii?Q?MVX8Y9U1nIP65ir0GgQlW9ONQHh+F0zeJoitRFs3D65TsMOLKIDzF/JEvpI2?=
 =?us-ascii?Q?c2ziS2faIBX/awc6K4kwAGJe8eAVhoCWImJ14P3udqkuRaF1EgEtyvduswv2?=
 =?us-ascii?Q?vN5Vhf+eA8+jtr8aOxjYKNnFI0M7P/wIKnTEsJyl8OG1gc0bnj1WOLI6GJoK?=
 =?us-ascii?Q?pmzYL5y8Ix01Ot1X9W5HiS3CNDcFGFBVnxtvaqfnk922phNUtu8srWpDsQHI?=
 =?us-ascii?Q?Pv4iJEv7yIJ69ZayFe0VzunllsWdBJmiPUcJWoiCImBP5iGQ2GxDwxjYw+gp?=
 =?us-ascii?Q?P0dixtCIxJMiDSk5dr1VhDMXj7Y1+JqLM2ZKgExiq8snNfGUo01iL/cheqBm?=
 =?us-ascii?Q?XL2y46eHKdIHy625y2aIp/GWDr0xnyFIrErHzloDImZ3td6wp81GO3hoyfCn?=
 =?us-ascii?Q?wma72IQcCyK8wHcat9CCUEhc/8TvSu9gKZutN+2TjMy4rhjP3BuMlLQgmq5o?=
 =?us-ascii?Q?9GRziUVpbylJpBZcS5BxdGXaruXpdrU3oHxy1TxIwL6+0RvKuXQqse5Uyihy?=
 =?us-ascii?Q?PmysIlH9gClF0yqq5L0sQYitweEBEeot5P/8PaOy518MLqZ+zNqrZpbCV+SV?=
 =?us-ascii?Q?pPP9Ksro+rhKtcDuoi4zrXeOnsG42tHyNWtwzUTMPNjMNnmUIcBzc8JHZUYG?=
 =?us-ascii?Q?WicgxY62XkzmWHLs549EJGAZ/dHizEzWjvR34mz/gAXNrUYGxiaCs+iamQVN?=
 =?us-ascii?Q?1ViIZu1BMDls6HcQbvt4ABot9wzHywEVbDcF0onOa+EXCfXNkKkgnjd+lJA5?=
 =?us-ascii?Q?jj1rR4VDVa33cpGcMIUGjjqd3qb/5W/Ua0hV50rAcls63MrIW2eenpRFbOhT?=
 =?us-ascii?Q?kcAouDZcg1CieTymgF+mZpb2bYQuJeRmU4i7fD2hsHqGu9ZtHWjVcdZMwaNs?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63021c35-5155-45f6-7237-08dbf090e008
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 04:08:43.0761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7XOmHjjKQhPzWG0LsxK+bVeEI2lfuFSquEQeJXBaT9ixI/askyyy57anOVb+XDG3iWLZ32q3vGjD3CxkbVoUdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9118

This patch adds a new MIB counter named MPTCP_MIB_CURRESTAB to count
current established MPTCP connections.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/mib.c | 1 +
 net/mptcp/mib.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index a0990c365a2e..c30405e76833 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -66,6 +66,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("RcvWndShared", MPTCP_MIB_RCVWNDSHARED),
 	SNMP_MIB_ITEM("RcvWndConflictUpdate", MPTCP_MIB_RCVWNDCONFLICTUPDATE),
 	SNMP_MIB_ITEM("RcvWndConflict", MPTCP_MIB_RCVWNDCONFLICT),
+	SNMP_MIB_ITEM("MPCurrEstab", MPTCP_MIB_CURRESTAB),
 	SNMP_MIB_SENTINEL
 };
 
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 9b7c366675ec..dd7fd1f246b5 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -65,6 +65,7 @@ enum linux_mptcp_mib_field {
 					 * conflict with another subflow while updating msk rcv wnd
 					 */
 	MPTCP_MIB_RCVWNDCONFLICT,	/* Conflict with while updating msk rcv wnd */
+	MPTCP_MIB_CURRESTAB,		/* Current established MPTCP connections */
 	__MPTCP_MIB_MAX
 };
 
-- 
2.35.3

