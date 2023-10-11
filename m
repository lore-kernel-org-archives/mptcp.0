Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6601A711
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DJBi9BgO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CF2zkFokvLEoCN0hQRSluWddrZEu6nEQVzET9tWjc1WEXb75fINNNa8hqvabIw5t+msobZHS41dNAMGVMMEeRdltn7u1m8WFcjFkXA/bcCoCbijVRtthswtD6f4NQItjI4k11qfMo5HMYbYODuEmjgRqlAO4Y7KF2P3QnEYzwCJWhnuxNXtgiAiy8LrYCPzPZYbXie0Q0XFPB+VQjlUlSorGote9QE7OGZuXmp5u+avjF6DvSwwMLhlrUd67FcTjPIfSmMSXEEn2FjSxWFIP2md0F7S9BuTBogb43LiCDDSgz1vJ1sCdsBPHhS9UlcgWv4cTBeVj8qMm67h9Gqmhwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKwRmZQpk2L7ta8GCIugb9Hkq8LQ0ALtI/kVzlPXD/s=;
 b=Qp+w4CtDJfRyl9UwGHm7JHnLyBdiwHeQ4rg8Xbb4vaIy735gO69Omrfqz+lBi1rqWZZWXRiL1cySE2VQvgHOVFmS9FpVl8INBjZOQtD2W9NQZb3VczmsXCjaDucVQiedUHt42j0elgjyR+Us+m8WkiGBSxXOSHdnK+18bV9Z5OQ8wy4tBf2wLsS60C7NY2zyWEiChMsoReW0tX61S5GHpSGA9IXfxt6wthe4XF91OIj7lnqBXPIQLmhnedDrfnLB0nLKieZLupRPV3ti+m85NwwwaakdJGJJN2yjnkeK4FpWitnQMPiIAKxwEQo9lSGtKeEk5yHQWslC4EvXFIqdag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKwRmZQpk2L7ta8GCIugb9Hkq8LQ0ALtI/kVzlPXD/s=;
 b=DJBi9BgOAdEfRYyrKU4roibaEx7uPQfXon4KfE1xx3QH4kW7SglVnLKZ5RtjNZTo59u6KVvPRS5SQRH6Qc0eSrkMjpKNDHlSH2BCVa4KCRPiz4wlLOkgFwC+d/pAzutHZpUuv5TJY84+ANXTmSMBZ8Wwy7eXREw+ZFyzSzZOwUION9UZaJh1WdSyZsqjCklpv9Wnvgs6/VX+6nJ3dvao7IeZUMOPX/1sDKfzy5XShfZnLzWF8csmdE7fE9nwhFczA7bmknQfOjGRFHxPo8ZONfC1ejS1XWcTLJ++klSWe2uftOTl9qCKzHqK1BX19KyqoWRau4Y9NS4Q8jmihXXAbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6960.eurprd04.prod.outlook.com (2603:10a6:803:12d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Wed, 11 Oct
 2023 09:49:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 09:49:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 1/5] mptcp: avoid resetting when another subflow available
Date: Wed, 11 Oct 2023 17:50:25 +0800
Message-Id: <a5b41fa72a3de75a8b39471601c6fdf080c177e6.1697017655.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1697017655.git.geliang.tang@suse.com>
References: <cover.1697017655.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0248.apcprd06.prod.outlook.com
 (2603:1096:4:ac::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: 26ae2367-eb4e-40b5-0dff-08dbca3f5c27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fHrAORl1wNOPKDEGLvj0tHDeJc5xsJUcVZwc9HOjFzJCiTb9IB79txosvM1HPvk/d55hVcKop+mkTkKr2w4zDSgwz9P+Tj/ZPJeksiszZANPsVnrDPbic7wPW4ZjZcB8S0Vicd1ho4j0BvdrRTliqZdvn6zloIJGYgx1UfQzktV0JWRoiyjKG3hGXcz2rnRv/cVDhvzBm3jRYaF27b67/RmdU9yXil6DYAgBAb/6ZJt1BRoTPI3y5j8pDUs4KnIyxQtK4qhOdZjdNwXdKwyh6XXlbKRWd6udjaAn8tLOPLubIVGk/ddlojh4sn+EN7isk6pl1VZnIkYXJpjyPN3rhMNBDfE41kPMbf+GaNFxpqF26VnHhajH3v8oJUKquN7rZD1ssgHLuHTLE/8oNYyWsw7M7lyMQXVdDH4/Oi0N1gGmo/ptqeCPNntBzmLED3bengQsl9eQketo/v5ApFnhuLT2Y2Tx4A+I3pLyVl68p6uFMV49aD2LDpW9ELc+IMWRX01pGZx9AXStDpPsc1sEX3eD85zXhEgMCEm6Sp504rUNMQZFQ+HbliK4V4wy4RBoeKx4gvJO3d2fJg1edDIQifddxceiLoZNhYs+4fiBDUU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2616005)(107886003)(478600001)(26005)(6486002)(38100700002)(6512007)(66476007)(316002)(66556008)(6916009)(66946007)(6506007)(5660300002)(44832011)(83380400001)(4326008)(8936002)(41300700001)(8676002)(36756003)(6666004)(86362001)(4744005)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S3/Xc4pq/s8mF+Uiu96XQPeHjIOYMbgvcxKVHTM3BH7v6ZoJrYnQcu1RiwPB?=
 =?us-ascii?Q?03ECvR9ZvLC3kXGSz0rYCqULMR3yoM4fJ4knxZKlbJUGvRKKXb5Fr1MkzsTl?=
 =?us-ascii?Q?9C4zm50g70duOLL/XzcgQFVgzvEW8rSy7+Qth5PW7zOsblGqTqIB9hmAItlr?=
 =?us-ascii?Q?0o3Znpc9XV3sjclnuOH5XkAbtV0iZx48X2QZJJG+W734MKudbASzkaDdhXw8?=
 =?us-ascii?Q?6Eq/koiuOVGuE3CsIfsMxP2CtWmp1DnwYCCSaWJxqko6K1LGl5F/QgsMng8d?=
 =?us-ascii?Q?Vhh5kP2euB4WjcQ2VPW/oVRVpHKZjexNjHfLRs6o+hTo4S6HewGyTiWrb3Lc?=
 =?us-ascii?Q?I3JgJkB0J+6dp4oPfxr+A21pVLL63yE1kGb8tPWOIRztq/px3cFxvzb889jh?=
 =?us-ascii?Q?E/AuzeW33ngvC+6xA55yJtHqKFsSoakEewDe7Snis5rbY0aoaJX2ubuhHozK?=
 =?us-ascii?Q?etrSDjWodQYp4ln7aWPUQE9eZUD1JWbQZkw1O4svU671EGDGycuHG5i+1iFi?=
 =?us-ascii?Q?aj8ABbbib8cxNlXFc6Dy5bY77AgrfY2ajaOx/Z9XXoh6iESqzBAcsNTzczsA?=
 =?us-ascii?Q?8Z6x0ZoSuuNzkkOPorE+SoDqpeRyUVlVBjNFkfHfS8clV2haQra7bJKkMZ/o?=
 =?us-ascii?Q?3FdB85QgmomF0E/MU8O3iT0QIl0v6+z0638t1sS0DRznPD8ollSaLE3ZvC7W?=
 =?us-ascii?Q?TdEHGhsXJvYCu5ruyDWQ/ijCQjvzmTlagZBQD/TN29XQ97L6oNHjNtMiaH39?=
 =?us-ascii?Q?e4ze2fJtGIfS9Au8xJn6E20TTcVWA/KiPh3I7q6ntrcGFJ8mKeYOKLAubGaf?=
 =?us-ascii?Q?/5FhkBHaPejyI8SYMjuMoU36ZhAJFwkIKcPFIM6FyQjhywMMwgAdtGISSrdu?=
 =?us-ascii?Q?izJo6XfUlRDjY+qgBymaYwjHb18L+PwoEnV1PoRK5jg+B8O6S99Qytapx9Jp?=
 =?us-ascii?Q?oU7WYbXHkAhVUvazqGYo5AHosJHXG2QuaYplMEpxpoMii77XgQMEEV9tvnua?=
 =?us-ascii?Q?5GzUhFJv5LiLlV31l32vUUi8wG8N7zom3P/GdYfO9wslagH2NDQWgWpGjMh2?=
 =?us-ascii?Q?AcW49s6CYKcDFbV0hU+0BmcsMwxPDwJ1Bv0Puw7m4fNH4ZkqfLlmGfNH/31+?=
 =?us-ascii?Q?ug7YW+axjPqvE70MAe86ILHvtzOhmT/zWe7+itNglHg6j+OZ8Qmtoa7ukrIX?=
 =?us-ascii?Q?EKvwROcXVPtHDfCdZFPYXEyb0X+29Mt/HrNUzflg+847oMAiryT8xcuRtNir?=
 =?us-ascii?Q?Qt2Va9UM41rsfumxi8RoaFAApIm2hVc6CO51aLOGHGc2jCBr/eYbrZSWlPiF?=
 =?us-ascii?Q?a3FmtN5gSGMAHo2oS0hjCbWXGu9SLxMVhgRowAP2avncI9f576PETDo0mreY?=
 =?us-ascii?Q?dpXwypNeVSM5yqNcx7AMvOcpyvZ+n7Aoka9elMiMJSSytV5/lJfcH1L+bEWQ?=
 =?us-ascii?Q?pD2jQA/LAN6ix4iSrdMpS1cui8zBQfX1RVgHwmDdb3wBg4fKP5wHD9htC86D?=
 =?us-ascii?Q?cptGpNJZV7JPwHkYqdhlAY+Blvc8SZMpuCE95NoyjkL+aGq/vy5YXFOHeXEV?=
 =?us-ascii?Q?e9JzcGPCoa1lmdEGA4iADqzAATLCm++WCdSMnkQg?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ae2367-eb4e-40b5-0dff-08dbca3f5c27
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 09:49:28.1846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1HEYqMLHUJueADxhQXq2dVMRAYg11EKgstWE+Zb//2dZe9k6z5NcNnt5ZBp1/ndZ5NI4ug4h2xwbxctX60yc3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6960

When closing the msk->first socket in __mptcp_close_ssk(), if there's
another subflow available, it's better to avoid resetting it, just shut
down it.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 30e0c29ae0a4..977bae817e62 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2400,6 +2400,13 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	if (dispose_it)
 		list_del(&subflow->node);
 
+	if (!dispose_it &&
+	    !list_empty(&msk->conn_list) &&
+	    !list_is_singular(&msk->conn_list)) {
+		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
+		goto out;
+	}
+
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 
 	if ((flags & MPTCP_CF_FASTCLOSE) && !__mptcp_check_fallback(msk)) {
-- 
2.35.3

