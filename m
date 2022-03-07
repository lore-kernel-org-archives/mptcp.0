Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A2A7A
	for <mptcp@lists.linux.dev>; Mon,  7 Mar 2022 13:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646658576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c4oy5HDGQL9BDiiL3Y+YHuJKXwT0+MtNKIqxiK8+HEM=;
	b=OLv6CwvM/J9iFaV1zX7NRYFbkMuc9HC0XL2jDpFEj8dlpvOVIu869vYnmt7V/ckp0+l7Z9
	5QQ0MPK5NWTsP5f6sC41GbLIJKGCx9jJR+cBH3hIrcUYobZkGRWbERqxN+6drgFL/nhS+S
	4tbse+EsnGE6WkDaPzoUoJK5LWO4gqk=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2170.outbound.protection.outlook.com [104.47.17.170]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-32-cE1_CyHcOIOwjMda4G40kw-1; Mon, 07 Mar 2022 14:09:34 +0100
X-MC-Unique: cE1_CyHcOIOwjMda4G40kw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hh0wKavNtvCUZhx3QD3wNUSLCqdCoBytq8GrYR5eOHTFR8pKtavwj3n5FYC6Jf/u1ducAiRT3quX0JQ/QkARV4n5RWMP4YVpPf8GkYC8ikCQrotFQLFYnZ8Mc/V3zDS/aDLlkNnNesEAjVXGHdbMVomY0Tzhjiqw2O20Ien7dOjbU9UFuNXD1FgSEbCTfHfhI+4LdJTuiAbsrUl/4pZynQUaWojM0CHOxo55PHnDflkOCAI+gm4Hs8jB6WnAjVueGomXlDCysIBC/qRAnteDvc9t/5IvW/a2cEVC8BMyxQRzQA+tjXUZy4ZeuyBWnwkIiKBG6ltkljxgJzXq8Titlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7ZEGd7OmT8o0euZqokOgBXq+UExlxroz7m3o0qEo18=;
 b=Hglg5LST5sH/jBhZKpcBGqJsTrPFdsG7oT/qVYf0xb34yi6y7Z/fklW3k+jZQTiSfMVhJnxRppjVKYWBt+b0UuE/scW7HLPGeJWeyxLZ4lOQesJDi8xFhiJsPMHpgPvYQXO5Vl0VPQ85IETC6isd5H3VELjtGBqURn7Q+TOvPfAYyWxioBItOr1NHza/3naHEcnqSEh0ZJxnE1NBArb5/x2hzulnriv17mOiYZuKlKtrbnb11Mhebk9+ako1WtgHwHgNU+bemaM4N0fNbrepe8G2kDH5Jr49Rwsj4Mt1qYCjJSs1C2Zr1IbTQk0aTi3noTo7aIziA8gYDBUVkppsrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6968.eurprd04.prod.outlook.com (2603:10a6:20b:dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Mon, 7 Mar
 2022 13:09:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 13:09:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 1/3] mptcp: add MP_FAIL response support
Date: Mon,  7 Mar 2022 21:09:15 +0800
Message-ID: <bb51dfaf5aa620f417f1212f4319edf78e04b487.1646657963.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646657963.git.geliang.tang@suse.com>
References: <cover.1646657963.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0063.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d4dc2d8-2087-4c21-2a24-08da003bb957
X-MS-TrafficTypeDiagnostic: AM7PR04MB6968:EE_
X-Microsoft-Antispam-PRVS:
	<AM7PR04MB69686D9BB99E39734E45CF53F8089@AM7PR04MB6968.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3AY7mgqJTvdVldzkR9jtx473hRL2AHZz3/hA2USoRaBqwlv5uo0gQYYzB9WPClyLDdkpaQwQwfTfhNhXtk1K1i2wUXJpjtc2qJ1cWx0d5uGcUOZGzNizZFqnOyzfjjWa8+OnAPflr7GCmvwM3QieMsiGeY6x6Ups31fyDQf/nHb40l3sLFHJZ0dkO7RqZkLxtMKxLsNwmp1woeoRmAWf/yazMDQw3AFh5lN9vsfb3vkcp+lyqtDb09Tlw77XI/0Oyy5RALAdZljADG5zVdz29PyaD8ebeI9FIFVPeAbbOWqME+t5xRosQrrX1PCSkn8Ozcr8+TdyX41hKBvyHmqXDdHxofEH3Xy4Yer7jgUtGSD3UVv3xA4jbgVR4JHtL8hsIhjJ+mW9VEYlH6dJbgdr377xIfBellY3M20FXV0onodzf79OamtNjo09oUyiIB1NmX/PkbHTTfvKV8bR948Q1hEweTejvEk/7YRsIJVDv+PHtIHTXi4oPskxP5BUM80NLi6RcqW2VoC/VEkskTKFfpsixKVH8ZJLIg1WVLQ4q8fMobcnRyoAqsDI2q00YIO0O1eC5mw1DFP7XsCdRqJMfsDn6TTG7iqwRfs8hd2PxZuajH4OEcZkGl5V3QUb8jCbTk4ULH4raVKN5lNcnn0UgdjGQnJ2KXUIx6ygVtq1MV5vkBBdPNU+CGPaQTSSy+SA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(66946007)(66476007)(36756003)(66556008)(4326008)(316002)(6486002)(6916009)(86362001)(8936002)(44832011)(5660300002)(2906002)(508600001)(2616005)(107886003)(83380400001)(38100700002)(186003)(6512007)(6506007)(26005)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FvgGC6F3/ugHq2yeYZ598UbflY3N7iYCuckezpzoVGji9usVUZH469owZCcX?=
 =?us-ascii?Q?hj7vorBezDIMYFjuLNfPXBQwtoIg5X/9kMX27NtzLVREcqiVcPo3e7m+UTGz?=
 =?us-ascii?Q?l+Y7qHzR0y1Q7qFCvGS1Tmka+ImBT22BoM6KGx4jqxZVJ7mOYN6K0cqylcTy?=
 =?us-ascii?Q?75ZNswd1ZKqxMv5qTZVc6rQpEupzbgHdNfn5nXIOM5F1q3bsH8V3Bkk2zyIN?=
 =?us-ascii?Q?Qp6uj0SAR6A5FFV5DDbsGLoy1NpSugDQvlUWDJulVfvOG7eLwiGVG0oVLHZ6?=
 =?us-ascii?Q?WVrReIwx6hMGl0n11FhwO9Toyyv/D33IWGYiKBrEk+pIzh5ZDwy6Mu2YIMjH?=
 =?us-ascii?Q?lS4uW3yH+vri3JXk/wVXYkNtxkzKxelQX6hSDrdRvp+nJiUUZrjUF2/gugxz?=
 =?us-ascii?Q?hmeklv2Tt+XJXH5u+W7+g0JdMMLu5qYAh0N2C+O2Upx1N8EY/XPm7tA/MvbX?=
 =?us-ascii?Q?jfJ3uewc5jghYCWrNs4i104X9qOq80+EX808p1Tt5Ek2eY8nR2lCy+i6LBqi?=
 =?us-ascii?Q?Y4UXfu1308RaFG9CxC/iz8GtCzoGRTu/yzf6id3kiGYialnTQq18PakNZ3PV?=
 =?us-ascii?Q?9M7sIcRlWYJXQzP16yef8yn79gW4+TUYScWOKQSCyxlHYzhEGgb0ETCZ+dvJ?=
 =?us-ascii?Q?O9wb5myVpCGGsZnCOrmhz6AYq/YYIg5ozZlVEFVN+RnPYdEbaf3UUkrtln0r?=
 =?us-ascii?Q?Ew+A8OJOb0vrPdrPFfJqiz3WEjrXFsrtOwr3OvdOdVky5sW+IVZxbzmptFZ+?=
 =?us-ascii?Q?zQjRazOnzlngqxVTW7lbSRekAtZpy4P3lbUPNJd6H9iKvg4rwjRGJWDJWBKr?=
 =?us-ascii?Q?4De0vDlcwCro6FTfRvXbsZ1r5a8ffjP8ZGHNXt3B4Dr4J6nGbMph2g2IcvPZ?=
 =?us-ascii?Q?F0O2fN4wiyUvDvlCsb2Wi3c+KQPHzKGJirjvueINKdW6woTJUiCmVJWVP/57?=
 =?us-ascii?Q?RzfFKsZFjh7R90ux+uST/N15vE65rRwWOmy2V6naXJ+zruEB7k7RoEcWSIXt?=
 =?us-ascii?Q?2eSADyuk9c4hsUOvAGubULYU6Ln8cbZ9z+1CekiZsEcRcObkNUnWzBAycgg9?=
 =?us-ascii?Q?VXB/AJ2JiI1Q18vLUnpvb30v7hqMj8HlNJaz9RPuP0kWcOIy5MYApeuF79Nt?=
 =?us-ascii?Q?SOHAbbf8rzRPsu7NIKHn8aFehmwPziEoZ9a/8FBC91YebsANvmsSFchPWFc7?=
 =?us-ascii?Q?w6rZ+4AcV/f+tBrzPnM4rZyw93F2ZBRyt666FdxNYSnBYklDg6bv4vJHHepH?=
 =?us-ascii?Q?9Jn7Ug8/28IjBCOj5VKOyxI3Tw/qjpAurU6LpdtgloyqDsy5nNSbHKcCTk/p?=
 =?us-ascii?Q?yMwRwLW7bMyd8ZZwAHdxNGilKrPVKNKw1T7prW9VTHS5heD1PBCAfjsGELKE?=
 =?us-ascii?Q?eMiOQcZTxOkTQSLh48kpT2dCHO//LJSZfntVWm8jlDBrSBIL811Srd/rXj+i?=
 =?us-ascii?Q?gMxfuG27BlwH2PrctJMciymFUYfOrGG+Pdjm3I/Kyv0uGuhsWDeZiGL2PlkF?=
 =?us-ascii?Q?NAcmWX4YSUZjtDLPUyDOcCNrrEIKsAToosj5tVyT0ASKy3EDSAWKVXjvVdRn?=
 =?us-ascii?Q?/Jbe2v2E9xmrF97nGYk62C6/RIfVjkspeAwZRD/HEHq63StfI3FmBJ9BpOir?=
 =?us-ascii?Q?zxwED8C1cfAg8AQ/53msbkI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4dc2d8-2087-4c21-2a24-08da003bb957
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 13:09:34.0320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oINg2EYNVNEN6XG2D415jxKMvQ4jfgPEp05KgE9BihiRDkx1AqBbv32vJquX4SWRLhkM5DV1e0eHTZy0HsasPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6968

This patch added a new struct member mp_fail_response_expect in struct
mptcp_subflow_context to support MP_FAIL response. In the single subflow
with checksum error and contiguous data special case, a MP_FAIL sent in
response to another MP_FAIL.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c       | 9 +++++++--
 net/mptcp/protocol.h | 1 +
 net/mptcp/subflow.c  | 2 ++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d0d31d5c198a..7aae8c2e845b 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -279,8 +279,13 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fa=
il_seq)
=20
 	pr_debug("fail_seq=3D%llu", fail_seq);
=20
-	if (!mptcp_has_another_subflow(sk) && READ_ONCE(msk->allow_infinite_fallb=
ack))
-		subflow->send_infinite_map =3D 1;
+	if (!mptcp_has_another_subflow(sk) && READ_ONCE(msk->allow_infinite_fallb=
ack)) {
+		if (!subflow->mp_fail_response_expect) {
+			subflow->send_mp_fail =3D 1;
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
+			subflow->send_infinite_map =3D 1;
+		}
+	}
 }
=20
 /* path manager helpers */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c8bada4537e2..39aa22595add 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -448,6 +448,7 @@ struct mptcp_subflow_context {
 		backup : 1,
 		send_mp_prio : 1,
 		send_mp_fail : 1,
+		mp_fail_response_expect : 1,
 		send_fastclose : 1,
 		send_infinite_map : 1,
 		rx_eof : 1,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 30ffb00661bb..63a256a94b65 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1217,6 +1217,8 @@ static bool subflow_check_data_avail(struct sock *ssk=
)
 				tcp_send_active_reset(ssk, GFP_ATOMIC);
 				while ((skb =3D skb_peek(&ssk->sk_receive_queue)))
 					sk_eat_skb(ssk, skb);
+			} else {
+				subflow->mp_fail_response_expect =3D 1;
 			}
 			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
 			return true;
--=20
2.34.1

