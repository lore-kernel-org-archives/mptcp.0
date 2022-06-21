Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50068.outbound.protection.outlook.com [40.107.5.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD727EA4
	for <mptcp@lists.linux.dev>; Tue, 21 Jun 2022 09:54:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUEVVLoNAGR8CWkL3uXcxhLaWJmJerYRpTRPAzRL5ij27/F/jnso5wZbmOZNGVOcF1QIMJ2H5xYxLMz2ds/Xxx8ewSKGyCUmY1RkDqaIabC4staebdWoJldzuJKGnIQJijQMxHcWb+OFMAs74bWNf6gztuqDpviKix8Wslw10IHCy7WQHYGgKqOwqWXiuxiogIRKxZUsb+RVowmQPzYQaxQ45kfrIuMtAp8qk6pDiurUK6WJmCQRmjuknxZGbaZAwMTi6a1IKhoDcl8CHZg1+SwDieVku4AZ9VNAnJZm4emgLYJz2qcsCeLsNoTeHzDSeqaBKDCu/NTRwudrVJz+DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7bvuMxuyvOw/+tFumzP+kct/Bhl5HWt69qW/4mlhak=;
 b=Smbihu00RC2wENXX0MgK+nLnw69lItJbggDnOxygFaoH6G8ETKZI+KLlINAG6MI1pvyR9MheYLIftxf8lt71IfaGHPBLIBSwOiQqIUsQ7mz0KwYxhvQaRDUnfNwnUwIaGwFFKbAOghmeuEMYhgc9bIUp5VMip6lBSEdM1ucJlJ0lY2PHhCWn0Z+loQ4KMtdaR/zA0loSA3bQtlQ4gs25y+afd4bGAhfIyK7r9BcTo9BeQ4Kstn3WmztK5SydF/TjGQIjtRzMJxIXgKbEl1XrpErCoZo1xktH09Pzg6WsGKQtMUwzAOMd3tJhp307XRdyQQ4VajUqHqNOMZmE9uIlpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7bvuMxuyvOw/+tFumzP+kct/Bhl5HWt69qW/4mlhak=;
 b=LKvCj6nWtFzh+EJLJOw7wo5uzpKiMo8IHQc1AGzDSPzvi/oa1D4KGwMI0UzMeIr1Y0djb2aeLyF4+uPZnYkY2QCkRNYJNfKEwA5Xw21k5b9PBSjI3A7s4Bj7wJL/0v4h9uHhiR91cnRJ9EdONFRYWw+1EuB/FKXqNpDYS0iX6PrkoCEBy7Vga4YJf7YuCqUPZTgmI2gQz8BPFbSg7m3UmwFhd6eu11XbiKzXQEpzjGmPsZuoEL703gic9J4lwKx/3XRPkMX0vycg0bTD+LY9aVDT6qHnJHLqOXqEfaMQ54nNShnL5kKYM3NJ0oko+rSMjmE34ZK7GZbMFWlO41qYiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9427.eurprd04.prod.outlook.com (2603:10a6:10:369::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Tue, 21 Jun
 2022 09:54:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 09:54:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 2/5] mptcp: redundant subflows push pending
Date: Tue, 21 Jun 2022 17:54:16 +0800
Message-Id: <f793d9828fcb5f698f577b75597ab8a378035e68.1655804700.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1655804700.git.geliang.tang@suse.com>
References: <cover.1655804700.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0123.apcprd02.prod.outlook.com
 (2603:1096:4:188::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f2d333f-bce6-4166-d865-08da536c086b
X-MS-TrafficTypeDiagnostic: DB9PR04MB9427:EE_
X-Microsoft-Antispam-PRVS:
	<DB9PR04MB942713E60D11D29AD34E9B20F8B39@DB9PR04MB9427.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gL7RgYrufAdEJxduhf5F3pI1+uNg3aRjH0f66u18N5M+Rz0nDmLE+5/WVhUmabIROYouvUcPmjdaFt3Pigv8PqLnwJJpjPPfucBAwe+xLQQ5MdXNRf1YnPYRQjIJmgrWmADLsZWaJHjSgxiMuif3hg5RF4ZjEuibuGfhfsv1fgVljLx2Ntmu2OrVVYup2RvnNSOJmpDYA3CUUpsPSNy7UG3VzsgbtlUVUr/YIMmOueHITuJv5Y16v2O8Aa2LAnqVWYW2+igbNV5btSAWUoDwhY2vaYnvmDxj5ihXm1XdjNLFb6gahpFp1pRDkoUejpnYn/3u9ro9JO3hMi2bacexcjh0KdZZ8iDc2wmwxS/IykA8qJehFvk41PqGHceeRxbf0uB1yQvqaB7rQmM7mDUxUrMUoqqn0LyzpeeueQLXngYr1FxfcZ2wig8/2uyTxnbEJiTYeR+V8hL1NHMyIw8HoNMllOBLkB2Y9nJO6SVjJsXtiHumjGaqZmmsEFGOWKX51B4nHAku5vZkwQlT0Q7qSvFIb80PoqfEgd/Om2g3cFHHnegkMZSs688qVOLb0CdCK+0qradYG9shIjYwSzIRO3X67L/lh1L3xvp3er20QDdSYfg5t327INwHsNMeG2lN0Apu5G+kBd51wYQqz3a9GJI+9wXXCXQAggZvNpinLEQiXpxBnY/ZcZR1C+ZPrqKWtrMBUcaa2iQidMMFxZE3xA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(39860400002)(346002)(366004)(396003)(2906002)(6486002)(83380400001)(6506007)(5660300002)(6666004)(44832011)(478600001)(8936002)(36756003)(38100700002)(186003)(86362001)(41300700001)(316002)(107886003)(6916009)(66556008)(66476007)(66946007)(2616005)(8676002)(6512007)(4326008)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ceYW+8lPDpLvByC9yvrOFbq6gHvibijAGBh1+4gHRAkW6WkUumfHEO4SXxxc?=
 =?us-ascii?Q?XBIrIbQeVTKrjEd3zWZ6hlJkiUrFin30UzjtXkavMqFsK5xkl91EHOC6ydDs?=
 =?us-ascii?Q?/9KZmYv05HeJ9R+5tAA4Mjv4zexGJMlNaNjCqylQ2FLnaE4j5o4t952tvJ0d?=
 =?us-ascii?Q?vSmHLZ5bKCrYRfNoSSHpUAc+/Ibr1jQFsSC9/bIpIFlPhDtdzUTVtxwCWJul?=
 =?us-ascii?Q?Vdetve5uih1x0yei11T2YvBmdecir2KrHU6BVXkBwzVUFz4uEm+NpC1jqX2S?=
 =?us-ascii?Q?S3AS3jer5s/2mx950+k8oxCIy4ThWl589TJLX3BcHbJw3sWMqJFzhjz+Ycoh?=
 =?us-ascii?Q?/JuDspfBqDIcmwdlPCUWdxoAVLFYEe/YNd0UQUY0f8MXy54rmkHBo9AJSCdM?=
 =?us-ascii?Q?1CEOgQFm/0Mg0AE1RZt/Zuz7/RNgCt1QXmL6A0SroGgHQHlFt2OLKKxqyGoL?=
 =?us-ascii?Q?iQaOpn0GVwPAl2sPMikik0sFuaXfsETaKA/f+oPI0cPhyWkBOTuoJueJAzTc?=
 =?us-ascii?Q?7clvmhN3DmJppwzcXTSzjoieUJtIwBJCBWAqo1jbYmmdWjWjBpKcEQu5bm9x?=
 =?us-ascii?Q?FJibU5vnMwHWZm8vlAdk2C3T/Irr+9ysunZiE/FhXg6+fWFU3wxEAxAxP8h7?=
 =?us-ascii?Q?0fJG2orVJ+vFo8j2k4pKd++KZLbzmVIdW15A01De/V/8yF3ZLYKcMvdcTWiN?=
 =?us-ascii?Q?5ynabBWaarEnMVKx6+4nZKdZ+LPsdldhqQetu2ZY37N4d6wz+KC5JPoWvvVG?=
 =?us-ascii?Q?ZJ9zuZU2vXcYiWJokp/VLGG6J7SDjv9Ys+RQuCDPs9qVU8e1IDqRgo23x8fW?=
 =?us-ascii?Q?++LVkB1afDTWzIYz3GnxtQNVlBVQavXGbt8m9/AxJw+pK+E9ECltIcMDBOZA?=
 =?us-ascii?Q?Iymj5f6ZkIE08e4jqn3Kxt4ZwPJ/dMTOagZfGVl5wGWA0ldLjOuXby5uT4iN?=
 =?us-ascii?Q?l0T6khCKpDaPBvG8xBF00i4VMhYfXdsV8qQMILfqI+DRf/uHD19wz0ZYHhgC?=
 =?us-ascii?Q?Y0JMN1JgiBz35GtXTCAVlQH3t4KWQ6VjJwCOiavvXzFoo1K+CTHpgRSwnjTd?=
 =?us-ascii?Q?EaDAdShWo09EmpROgbYpikR23qLegEprQr8l/reSv6R9vk/1Zpw+M2OAadvA?=
 =?us-ascii?Q?OCJQ369OdgqvufFPrPkI/ENSd4wk0jqy1MN2Inx9PC2F56vUpu86pOrPKQky?=
 =?us-ascii?Q?2XJOX8E/fqRXZoBYbHjQHWsHST8Eu+8EF2/ssz7m/osZzgWAlfkL7MhXNsvw?=
 =?us-ascii?Q?DMw2ACL/SXMD0gcq5IR4xhfTDA3n14zuLTIpgBK/o2pPG8U0EMoBt/FyFpHK?=
 =?us-ascii?Q?WR9dVkmTaS+OAfCYPDR3B0JJXSm/rPhkxJqiBey8ltqW6DvcMvrJMV8l2AFv?=
 =?us-ascii?Q?gcDPgVbokPRtxIqT2pVVigE6xP2kGA3Z3JnZJRrR9G7nuYO2JyaoLHQzNWko?=
 =?us-ascii?Q?5g93Hl1Gzg/HJtnQJykJockVAXkCDrrs4Hrb90U2xF00lZkuc5sITK68P3di?=
 =?us-ascii?Q?NvotKxbJxRUwnS6VrqqvvKYJp8/C3dLqH6C2049XK+dWr+rQtmyIlT13nj4M?=
 =?us-ascii?Q?GLaeVfV6aNHMJzxmkJ9lC4G5o3SzDaoLO37RWC9fD5X2tZBuxOMVi6h8PlDu?=
 =?us-ascii?Q?IrTpgM9pfU2eqHKGPOrZXG8uIaobuaXStBgPo2887EvtMA0abtPULloK8Xi2?=
 =?us-ascii?Q?q1OmX9FkyQRMqdonl937YFM/ebejbT/v50Vr02Qs4I0MzMLp1tuumfdxtW9H?=
 =?us-ascii?Q?Pv4HE4xUEoaDThjzn8NeIeLLqarw1yU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2d333f-bce6-4166-d865-08da536c086b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 09:54:29.1080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5Ei7C3jENtHCpRB9t4OketCQCPQ++VTTRvb71m4J4kWy1iiNtJslA9KqgpfqEqpUmeOkLkCjsSvrsLJ6D5fXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9427

This patch adds the redundant subflows support for __mptcp_push_pending().
Use mptcp_sched_get_send() wrapper instead of mptcp_subflow_get_send()
in it.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 96 +++++++++++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 41 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 043ac3f222ed..4f5e7f7fa6aa 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1551,58 +1551,72 @@ void mptcp_check_and_set_pending(struct sock *sk)
 
 void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
-	struct sock *prev_ssk = NULL, *ssk = NULL;
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct mptcp_sendmsg_info info = {
-				.flags = flags,
-	};
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_data_frag *dfrag;
 	int len, copied = 0;
+	int err = 0;
 
-	while ((dfrag = mptcp_send_head(sk))) {
-		info.sent = dfrag->already_sent;
-		info.limit = dfrag->data_len;
-		len = dfrag->data_len - dfrag->already_sent;
-		while (len > 0) {
-			int ret = 0;
-
-			prev_ssk = ssk;
-			ssk = mptcp_subflow_get_send(msk);
-
-			/* First check. If the ssk has changed since
-			 * the last round, release prev_ssk
-			 */
-			if (ssk != prev_ssk && prev_ssk)
-				mptcp_push_release(prev_ssk, &info);
-			if (!ssk)
-				goto out;
+	mptcp_sched_get_send(msk, &err);
+	if (err)
+		goto out;
 
-			/* Need to lock the new subflow only if different
-			 * from the previous one, otherwise we are still
-			 * helding the relevant lock
-			 */
-			if (ssk != prev_ssk)
-				lock_sock(ssk);
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled)) {
+			struct sock *prev_ssk = NULL, *ssk = NULL;
+			struct mptcp_sendmsg_info info = {
+				.flags = flags,
+			};
+
+			while ((dfrag = mptcp_send_head(sk))) {
+				info.sent = dfrag->already_sent;
+				info.limit = dfrag->data_len;
+				len = dfrag->data_len - dfrag->already_sent;
+				while (len > 0) {
+					int ret = 0;
+
+					prev_ssk = ssk;
+					ssk = mptcp_subflow_tcp_sock(subflow);
+
+					/* First check. If the ssk has changed since
+					 * the last round, release prev_ssk
+					 */
+					if (ssk != prev_ssk && prev_ssk)
+						mptcp_push_release(prev_ssk, &info);
+					if (!ssk)
+						goto out;
+
+					/* Need to lock the new subflow only if different
+					 * from the previous one, otherwise we are still
+					 * helding the relevant lock
+					 */
+					if (ssk != prev_ssk)
+						lock_sock(ssk);
+
+					ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+					if (ret <= 0) {
+						mptcp_push_release(ssk, &info);
+						goto out;
+					}
+
+					info.sent += ret;
+					copied += ret;
+					len -= ret;
+
+					mptcp_update_post_push(msk, dfrag, ret);
+				}
+				WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+			}
 
-			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-			if (ret <= 0) {
+			/* at this point we held the socket lock for the last subflow we used */
+			if (ssk) {
 				mptcp_push_release(ssk, &info);
-				goto out;
+				msk->last_snd = ssk;
+				mptcp_subflow_set_scheduled(subflow, false);
 			}
-
-			info.sent += ret;
-			copied += ret;
-			len -= ret;
-
-			mptcp_update_post_push(msk, dfrag, ret);
 		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 	}
 
-	/* at this point we held the socket lock for the last subflow we used */
-	if (ssk)
-		mptcp_push_release(ssk, &info);
-
 out:
 	/* ensure the rtx timer is running */
 	if (!mptcp_timer_pending(sk))
-- 
2.35.3

