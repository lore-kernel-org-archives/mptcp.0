Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2842CA7
	for <mptcp@lists.linux.dev>; Tue, 25 Jan 2022 11:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1643111356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=reI4tnZRXSsgAB59FMDBEaQbAAqIQ/13seX5rfOU410=;
	b=ZATShzmH/r6POLWSJP9UAj4hBpjUlpUTXmRYVK+Gu3IA7rKczEd03gg+YEs45aXrDzU6yC
	EhGpoxSQv0OHKFe2pt9w9ciwgVuQjN3hqvzC2BHvFTCsUXww91l/NzlfJBSt5C+xUbe2sE
	Im/O/E4dpNqTdLTEiBFauNFn2x3k67c=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2056.outbound.protection.outlook.com [104.47.8.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-rcEiKR4sN4CSAC7MkOauYA-1; Tue, 25 Jan 2022 12:49:15 +0100
X-MC-Unique: rcEiKR4sN4CSAC7MkOauYA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gc3Z2QTMd/+V+SkRycdG+lxHaUXYkPMLapmz4x4PscmOjxpHoJYxO7QEm9u4S6aW80boXCSBkh5A5NdgUkLx0aD7e6yZgyj7wfNTwsOlBr1qnFB2fCJuj+VuaA5hHwOBsu4vpsKMubkx10iENwngeVSCpTJ1rhPQd4FgVOypsBvL+338Xqfkmjd727xtfhdpH5t87hN7RGxqN8x3oyVjio1JRSd/qnbLSk4pSGfgzgyyq4VqeRp/hFsY1DpU1DHSBxX6HWfexzDY4onH1RCPI6ZY9Lgt6eOllRwkfu7Bd5pgDhBK1BBEsvdkqwxeBGgRxi8IwY50Vqf3DMnrpKlJrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfWz/LVO+TIUVYcPTzMkoUp2vLqFKcmHfI5buXjaN40=;
 b=jva7EcbS0sRkqmKN+DeuDPKu2yrHKRpdvOkcjWJ5J7D9uLAlXmf7stWTD9C5WF0EGgpSWlo4Dkjouk08jTf6EP5M9duJZOJolivXvrd9RqKY0F3f3FLup+Rz8pC4gFuF4Ocy30ZaoDTDNleMj0cCrjYYpfDgc6CARt49kWm+6hTwGYehf0i+NK/zzZX+Ck+1udN02wA0U+hJ8FOuamR0swpGWKLQtWmLxQG8rvisyw6gJxanC2n/Gnl6ogPsfVoXrSSkTD5tLapCJqKoxaEQSvqdomxi9dqKJOae+UvgqVmDbyb3DsMMWDlfTYiHPFCD/3T9MdtX8EVuLDya+jSoxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB4775.eurprd04.prod.outlook.com (2603:10a6:20b:3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.19; Tue, 25 Jan
 2022 11:49:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c%7]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 11:49:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/3] Squash to "mptcp: infinite mapping receiving"
Date: Tue, 25 Jan 2022 19:49:00 +0800
Message-ID: <a73dc6f3911c83cc292f4caa6f94675af2e06364.1643110285.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1643110285.git.geliang.tang@suse.com>
References: <cover.1643110285.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0190.apcprd02.prod.outlook.com
 (2603:1096:201:21::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02c2038d-389d-4a2a-5349-08d9dff8b538
X-MS-TrafficTypeDiagnostic: AM6PR04MB4775:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB47756AD96DE4286FF472F496F85F9@AM6PR04MB4775.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uwKdioB8HDIFG2n9s7Qi79/xpHwxG/WtAn/cscDZP0g4l3eV8aRVdiH9mwjJExgt9bQDH8xpJKUJFST1rjr0ps+TPLPrLihOynL/oxQG/hzL6w6q72CPlhRnupMysKddIlLU0KeVOsZrjBi5KcwYKb2wmiUc/HjYZ9tkP+fREpFa1eCkFjhuYUAoiUcysAcGxeuY8vSZP8lylZg5Qyve0MSVN48glyQjvX0Sh2h5dQDwHdtwp2/AfCP0qBbqID1KdJFyJbW9pSxdwpAPJqM5CBjoFZwOtzlknHcCf83LYM5QGrqy2/bD72IFRS68sWeaJahxQu8C7tTG8GQ9OIP5uYrSUEoTo8u8VD5w5t9N1/86V9A3d3gT5+jMG+O4CCjbO7lR6snNWWKKIHtoLOb0kKnqZKYt1UJVsDImoqZsU/1mfOQep+OTyAppr02wOXk4FZfhwoUN3rG4nZlOhZkqtNWabJ51Lnsje0QUAXqLTjjMZBQqtDysCSQKj7SZ/AZcOGxq1Mylp8gwWauaawSf4yniDnFZbvOOxRZZ6000ZrK/AWUaTBHcK3yQT2j1FXoJrI6ETpe60aQdVHryEgcowbPsVAu0kiwqbAfkyXRorp/p8Q17/IjzamiAAUG4668GA+qKWQSk90G6ssei7SXkpg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(44832011)(316002)(186003)(5660300002)(38100700002)(107886003)(6916009)(2616005)(36756003)(66556008)(8676002)(8936002)(508600001)(6486002)(66946007)(2906002)(66476007)(6512007)(4326008)(26005)(6666004)(55236004)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/5o4kHp84xgT1MB0lz1Qte9o3scJ+VsF26IolgRyTs8m37m6EGru0hofy7rw?=
 =?us-ascii?Q?mAYG7+YOSh28mqJtUYwbwlFyCDhJjgFOnjJ/KN+D86HNvYICeIRu8siMppmp?=
 =?us-ascii?Q?vjliN0aOiFcrWcUWj/KW/beJ22jgT8JAp7yrAmwFcb6NhyiKWG9Zp5O6iBio?=
 =?us-ascii?Q?ubA4IEQ0BTjsLSHBIOZ8g2rHphwWWUMjZCOnYZqfkarjAoFd/xn1QKX+s6zi?=
 =?us-ascii?Q?0DEXadFHnRPgPkd54HY8Jcd/HFZNkzsSjPI6617x/+DQI2Df6UuwtzzG0xHc?=
 =?us-ascii?Q?IlO3Cs4QWWzqI5XbEHrRIDGf+KajE6r5vhogV4Domzo7Um7KuD8UsSle73tS?=
 =?us-ascii?Q?3CLFJm5eNhzlRyK7y06P5Wk2LfPXyw65Y49ETN+s3X+s9BZBTweoZ6iGuqaQ?=
 =?us-ascii?Q?NYwdm2PrYqGnIH5Q/HM7APXLkw8K96mksIZ6GMq+sVqWfKzzkEPEgOZl2GNf?=
 =?us-ascii?Q?pLoJREjDW2K04wUIH5EfRhephMIDZWPUU6i8HTbtGxHqNfjxkxqJEhYfaQr5?=
 =?us-ascii?Q?H5KurNuQl2ITGpWaXmmVBLfGTpRSopr2yM/FzMaGmMomx8JrrhO0wr7F6eXd?=
 =?us-ascii?Q?BtjaTsHeo4qGwnvu7oGx8p9UcIdOKQ9CETEW1qFwwiF0M7dogKeR61V7G5CF?=
 =?us-ascii?Q?g71pm778gci7OkX9ZpCeKHeZ92ONYuW3YSND5ClpsEER9J6vgnDNp1GCeVvd?=
 =?us-ascii?Q?atW8fECl7iEDJ7JtbLqiJ9CRT4IUsiHofIUSLB4HU0qZ4/4gT7D5JY6cpo8X?=
 =?us-ascii?Q?8s+irSB5s9vOYxVFqmnaxcoHaEPvNo0k4r9z88vAZp/Dn4o1i55By0659bDt?=
 =?us-ascii?Q?x5TQII/7xd/e3/nyx1dtxFn7YTIXIxshGoN9kEe4MD1dFdEIjmEO4iRiB9Mn?=
 =?us-ascii?Q?UI8PF0380XKgM62Z9AGGtzsyVEgKlbXJMWoj88qGIvyhU/UHAyuaKyGHnOgb?=
 =?us-ascii?Q?oIu3jvRspNogAbuZLFNV0D1TbENi3eHqqazAg2mzsi4haEnUiADpd0PfQpNL?=
 =?us-ascii?Q?Iy6w9qwSx1BdhdamVjaMoiYXgBiCU5d5a3JYNoNnr1iBDOhqOlZInMLoBDGo?=
 =?us-ascii?Q?B0DH7srP7++wGBPPvJvXtbo6sWDm+6fFUwI5QYvAO4XtfdXH9j4nIHBjmxxr?=
 =?us-ascii?Q?U5ufnfwt0XOiGC/e0YbQr5GzZjJK0VHfy76tiO4CsapR0ru6fchDqNGM0RpS?=
 =?us-ascii?Q?W6PtR+rJjKamN8lCUDy3Owxecq0Sv2PbV62FNawDT8Liwe/XYED3MQTnH9dO?=
 =?us-ascii?Q?Rgjen7Tga3UsHW5spdV8YhTyTRPRdI/rOJHllCER6xji57gFKV/SkxXm3ZZa?=
 =?us-ascii?Q?aZl5KF0HdwDKxQ1bxZRneMm4ywRH9+cbkQNF4/nD2RYJFAGunLaBqjq6m6Qg?=
 =?us-ascii?Q?5KQ+rLBpouEYHnBe+JuI2T6zBKvGon36LhHUBC2MA+zBs8OIMy6r9gxxRIpY?=
 =?us-ascii?Q?HXX0f04feTbV93gDl+GrXf3Kc8mShAgLnpVti6e8ReUmxYfGnq1g8gdtpgLJ?=
 =?us-ascii?Q?e293tF/DNQxgGj6WYr1wXmW6cAX5DqUBIlg7c6xtIzu+JMKAEaOwh3M9f4lt?=
 =?us-ascii?Q?dZuEyYNGDuNZEDbZvjtYBinBtRpBGwQbYVTvms8U95q8bKUIxhopUuWeLV5B?=
 =?us-ascii?Q?6W3g61xoG35lrBzhiZ4xqkk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c2038d-389d-4a2a-5349-08d9dff8b538
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 11:49:13.5980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vHq3a16vWxIGY0ZzixFdUUY5k7RrOkANZzhj/mjwmvtGx04TOgJ4Wo7RhosW1G/nAvL6+Z1Y4qEWjBM4lqaK5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4775

Add a flag infinite_expect in struct mptcp_subflow_context, to avoid
resetting the subflow when the infinite map wasn't received.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.h | 1 +
 net/mptcp/subflow.c  | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6bcf6cbded45..ddaa86acadce 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -451,6 +451,7 @@ struct mptcp_subflow_context {
 		send_fastclose : 1,
 		send_infinite_map : 1,
 		infinite_sent : 1,
+		infinite_expect : 1,
 		rx_eof : 1,
 		can_ack : 1,        /* only after processing the remote a key */
 		disposable : 1,	    /* ctx can be free at ulp release time */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c8126986793e..e41161048498 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -964,7 +964,9 @@ static enum mapping_status get_mapping_status(struct so=
ck *ssk,
=20
 	data_len =3D mpext->data_len;
 	if (data_len =3D=3D 0) {
+		pr_debug("infinite mapping received");
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
+		subflow->infinite_expect =3D 0;
 		subflow->map_data_len =3D 0;
 		return MAPPING_INVALID;
 	}
@@ -1174,12 +1176,15 @@ static bool subflow_check_data_avail(struct sock *s=
sk)
 				tcp_send_active_reset(ssk, GFP_ATOMIC);
 				while ((skb =3D skb_peek(&ssk->sk_receive_queue)))
 					sk_eat_skb(ssk, skb);
+			} else {
+				subflow->infinite_expect =3D 1;
 			}
 			WRITE_ONCE(subflow->data_avail, 0);
 			return true;
 		}
=20
-		if ((subflow->mp_join || subflow->fully_established) && subflow->map_dat=
a_len) {
+		if ((subflow->mp_join || subflow->fully_established) &&
+		    !subflow->infinite_expect && subflow->map_data_len) {
 			/* fatal protocol error, close the socket.
 			 * subflow_error_report() will introduce the appropriate barriers
 			 */
--=20
2.31.1

