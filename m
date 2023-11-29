Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E046D1C2AE
	for <mptcp@lists.linux.dev>; Wed, 29 Nov 2023 11:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IjyXvYDg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVwVU1ZcoKy6vjDZ1BH/xNawFyWN+rcEaIZpHzZ2DdosA7IovKE42X4lJMPOax/9Ft3bvm+8Bqxlk3Weh7k7Jw4tzw6ePjANrUVPe/laKGZagDyHF23Y0cpY8Z3ueQmUYzs4Xetp2QlGrFnhE23Q5HGu2WsfLb7wGJCTPppjT3oBSOahV/pgn8C9kuuksWvmIPmdMjJxgAjJVuLth90lBABEn+T1UFomRWd2y/xwb2p6a5/ytJ/RsEUyltOdsU7htsSuh954yhgeE7Hd2/R5XuTvqoKW+D7t3OrDfjT40v6Agnyq6VmoZyKTWo/iC7IaK/HRBUWpiA/p/qyaf7238w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJAk8dg6gU0u9mClrfebSdE1UMczyeSf8LWMrUrVkho=;
 b=UiTZx2S139jM16lKYbmbayh9s2pWbE8Fs0IrQJ4dSz3tk02NjRFBGBap9P9ik1sxcZHqA1dOOJqhIBSIk9cTS3YFzMHe7fy5AH0NCgfXi8nkxvlTWrxFVgA3oCclVKsGpyjm+nM8ZXClBeL/CwicOQCvuEZ4XSCHXH7UpSVfM8BpIdKpSpd39n9ffuq02DrwY8dEZ2fuiuxOVwYluxnMrVU+b663d15zIl2GbsTTeYKlpQmVMu+MqYp7jvz8OvGCoSVKrXPD+H+wObh50QGXGZeY50ai4yBD/rRIZ14biHR1oGuPSeCjBvBIkETJY69SaxoE0dt/MUy6xGNqPQCz5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJAk8dg6gU0u9mClrfebSdE1UMczyeSf8LWMrUrVkho=;
 b=IjyXvYDg/VnsqDjWCKwVgWxQnqvo5J8U6dmepaB+SVI6Mw6FLWFb4UzuCvBaMmJHFtjBVQxH3B9ifcpVj5ZuGGVpwDiFJq22LkfnIr7jbprL8okC/eIKlojfftULdcgHTfvYNOuMl573bavcmdGnLrVvMCBpb+aKCFF8wK/r6o5VLqKMHV+DiC/ZjcavWsDRG9B8HrW/RU+4hxU243bOXeOhSQRRzAZ/qh7WgGNfMQZApjEsROqdQNylAQ3as4XPqd2m2+u6wOjj81Ugg/4JAxKZr2ZlpeezyF+7L3R1/KvDV+ZsGCJ/QQxGMZoVh7CE0rPYhs5i2Y7Ld5C3Ag7dCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS1PR04MB9333.eurprd04.prod.outlook.com (2603:10a6:20b:4df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 11:10:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 11:10:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 2/5] mptcp: add a current established counter
Date: Wed, 29 Nov 2023 19:10:49 +0800
Message-Id: <08a899096030f74978b31add1a822f439f7127ba.1701256112.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701256112.git.geliang.tang@suse.com>
References: <cover.1701256112.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0070.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS1PR04MB9333:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b6dd968-5cad-4cee-292a-08dbf0cbd871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BSpREDW8mvS6KO9YqZ13lmOX4Fwx1DdDdkA7qWe64eRP0rq1N4at379yBWq3cbR5wfvE3h6S9/jUcZVWS5pBN30ESRzMbIEuDJBK1/Mfz+B73e0u4YWp/ziyO3gnyKdtimnhKp7uRK0jFQObAfQMFqIhhiUSauNQJipslWms7m8/vGsb+PUC1+wGIRxL4Q00WpmauOGz8k29clOQ0KwgFdY0NpAsWbigRYGjZ0b15XX+wIoy4s7QyMxrVlJmepdV6+kDIJJ/YfRlEsazk7R/D+QtJjXLEwTZLzavL5IuHVVxdNZVsDMHdOls2j6eUY9lF+EpdHhAnL6bEhlYYjui6+pjZrrfiyFK56/xZIuIhLXb4CV/yIqH0OeuO3nfUOZET+HzlafxSkxlUciG84D0zeLp2J7Uy5cnkf32AsaHLOindAxIkvGXQ1S8VT71S2WJsFlIMXqMEug5MLSBpIgFjQS0ACRe3Lldg5bMuw/GTuC6Eosr/oxaDcMnCL4CGBPNHdqFLUwr3Gh4rHh0oOac6kKko1iOTMsYBOCplSY42sMxBDfKAp9/UribyxH+sVC2r1EJyPOVBrE4aUWnu0UrZMTy/Xy/QdLJ29sTW8BozU8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(107886003)(6512007)(2616005)(26005)(6506007)(478600001)(83380400001)(2906002)(5660300002)(41300700001)(6486002)(66946007)(44832011)(8676002)(8936002)(6916009)(66556008)(316002)(66476007)(4326008)(38100700002)(86362001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QxaNFgWZawAUUo59RzQSGPo/BAxEnphgsR8TfA1HiU8u9idE6qT3f2qBaRIC?=
 =?us-ascii?Q?FUSqz7Y/KCupLTUOHEvbhAXa/8eaJACRIhca96sEMO+cw5sTPIdVzglTtlDu?=
 =?us-ascii?Q?1DqPRutKrh/XE31EAY3e1m8/cHubrEPGinvXoC2rL8o84MaZm/FZWXBS1VWO?=
 =?us-ascii?Q?na3yG1IWromiumMUZywL20fHY5hlH3enrVknVHjesrhXwqqsTwtbSXkH5aWc?=
 =?us-ascii?Q?MXnRV1BS7ncDCYv1/5AFKRseLuTaw+c9L4WiPDro4DUCE3/NnG48sHW7hCXJ?=
 =?us-ascii?Q?FNvAG9pcBt/fEfGxU0gD0zHw6Z/eo2g9UYB95bgG7Svv8XBnm6cou7yPJmd6?=
 =?us-ascii?Q?u6Ne34usDy4rf+xSd+zyBzwa04NwkYsXOo+r/IfXe0oNHVVMlI7AjDWkK0rU?=
 =?us-ascii?Q?6cehbSFTK2DLuQFOLhACuhYW2mm6UzQ4JIQjYoJUdUfLAg6P1/mc5O18YBz0?=
 =?us-ascii?Q?RyFxwqyAoEzni6NWWDM4NmB69YYA21znETrAhLXGUDPOSOggn/fB+OUPGv0F?=
 =?us-ascii?Q?xtvUBalXo1BeCmwiWu3IW+4MqJKTf8VU41rAVfATpqddD6IZdSwF109p22HQ?=
 =?us-ascii?Q?FI5p3uBkZTDzL2chmGcDSDw1/dpp8O0wpJTHdb7Cia4bYRurDMp40/+TEhTh?=
 =?us-ascii?Q?KoP6uHW4glMQhCMpu++10cwPdXAexlbIQkuaWTv7PbtbWVKSZcUmzwlPam5H?=
 =?us-ascii?Q?YtunuY3mFYaQTEmfsdCtngrHGSu05iY96taMBln5YHHRUchBUf+JhEHPSG78?=
 =?us-ascii?Q?QzP2QX8Z011FpQBtPjvDQZLYGB7r8rNhKYIQ5mZ0E1wkSuv5QMOvZtUZHnXr?=
 =?us-ascii?Q?hqp5EQVavOrRI8xM9seqUprXoNNh6LM0FiuyKUXNCquTjNfXDRGxwmwBNFvZ?=
 =?us-ascii?Q?yN5KiEcHBM9I2Ecc1V++tsgETSfI7/noxgsWmkRO8lY/vIrOVEobrcU8vxsz?=
 =?us-ascii?Q?IZVmH7G8ZNoA//WzLQxSLK8FsZANwj+CvH4LBoxPdOwepV+f+Fer/255b3mb?=
 =?us-ascii?Q?o5GFStL9Xb4J5j92NnxrNhdpck8hD0uPxe7gubNK7foZStRtNOjPHf4jzJhZ?=
 =?us-ascii?Q?+yrGt/1hq3W7BZhmuLq0stMlN2Cyb3I/cXNgHYnf8Zyyk8d0Iffi9Z5BdE9W?=
 =?us-ascii?Q?8euC4o0tpNydflqLkkRBBU4HKQvoje81Sct4abl2OrrNif29KqNnYm2VTP5z?=
 =?us-ascii?Q?fPYt2CpNf7sdM1A74ztwuYdSpYkHIKgz95+Pf4yqa5pfYstd6Rx2Ktq9hfxT?=
 =?us-ascii?Q?2EhS8o6H96VQ8/IoMcA6wIHkj43wuc+p6G8PMg3rcRLRA/mWhfUpwxcI+1K0?=
 =?us-ascii?Q?KOInizeX1lZbp5s7xOOe5PuJlHSQKZ8YAiW9vzjWLNtYgWkmBErdUd7ikuX3?=
 =?us-ascii?Q?5vOfAliGDM3/9qxL4aNvSqgk5rV4WaPko4yjViYF2Yxfe+goFMNhvundc0Au?=
 =?us-ascii?Q?Yk7dcLWo2Td7ysn06WmV4RTMwIT5Zxj8eX6nfAB73n4dcyCqwQ94mSbx3JyN?=
 =?us-ascii?Q?WEH+fwYsUBmjb2X9sKNQ1vzms7uzm5n523oPpipuU51sh0ggUiug4G1IWuFK?=
 =?us-ascii?Q?fRLkIP6HtD5Pu9tytRj9ScmkLQw00IezTT0jjjr1qih2zGu6fORZRpZyCOtW?=
 =?us-ascii?Q?pQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b6dd968-5cad-4cee-292a-08dbf0cbd871
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 11:10:50.6470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ksGRgY29q7I0kn5uCswQk89Medt2ynEb3MrSkJcsSmO7sXWnYYJ5u7ACTs9VLUS2KdtC1ul9Q+BNCkitAWoqCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9333

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

