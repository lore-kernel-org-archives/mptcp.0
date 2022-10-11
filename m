Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130087.outbound.protection.outlook.com [40.107.13.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408A83207
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 12:02:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjwvXqqjpMk5ccQZcjgZjae71MhdoPAbYNOUx+W/s9x5gggx7DNBJX/3Y1pXX7xrrSqQEal39Y8L0nk26w5omGcedh+Sj8vm9hp0E4bzZ4VSgffEUELQ5WRZlRkfwvfoZDuzsdXm5xkEHvGLIC54cKn0B7XbuXXu0CLdlZ5YtF6TuQ0uL2amZ9ZfVJtl0F1AwQXu1kd4YUS4rV8Ll2Vd1zOKgGfoXaZfuzYhAnGRJpAQW/DCflZcqIlib9m8y6/+gF4O83tffayEhu88wb1asgYfgD1sgp1Oej8fv9T+lQjZb2czgMRAN4dY12YMY8Sg8xae/4bVRWS2c1HMd4s+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxfLyw3WQFHGcHNWFj55B69d+84127O4kGDE7VUb9AM=;
 b=mrkjgDUbAw34Len4CgfPWrAVci9fqV8+vnTODAWoKGbRYcwZs3mduj78R1qaW8SCyJLE5AqpUPr/3p5NFTxdVQRc23pMfTh6Z+p/NxiTPdwAD+jNUwyH9SPKzvQ7yfPWccwxS25tLGhVZQWdZiOMNZ6UMxxvCBJDKP87d1VLWyiVOBLfYwBergydb09z7LwnBuaYknlt1rEOknxD929USUeX4cz67KuNHm6MflNBsCNCUwlvq5t4BD/SjzOFW4+kPV0mMPQrfjXy3U2O72VJR6r1A3r37w1PzYfbJne7Xs5t3a17RKoWmSZfxcYSGvgl2b/gS+D/4WMQIeSW8kjjNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxfLyw3WQFHGcHNWFj55B69d+84127O4kGDE7VUb9AM=;
 b=tbRBzijl0qEFyOXLCuJX5mPvnZo5GnFRVsfTtTbf7X6jfAhneGjUoYvDpWM5qhpshKruns2MeySENPn7hDvxfokv5pY1s1mmh1TdGznmOaWK+iRp7BjQatVr8I2THtAnxhzPwyRK0HBpASJFXo3Ma8K2VEzrM99bKqbAjIh70MYLVmBFh9lF+6NpV1i7aARJOhjBXJMmGmNa6qrPFw2cH9PLzkGSvOxNGc49GR0GipcUA0bFwnF7WtnNqg1vIvBML/0UTsG+vquqUea8B2+NYO2+aDGEVC897HQiTwnBbGbsMynfOMZu+PhQg9qRY7jgDRrbj2CTBGAOgrPm8x+FtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7557.eurprd04.prod.outlook.com (2603:10a6:20b:294::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.38; Tue, 11 Oct
 2022 12:02:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 12:02:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 11/13] mptcp: multi subflows subflow_push_pending
Date: Tue, 11 Oct 2022 20:01:35 +0800
Message-Id: <20221011120137.5475-12-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221011120137.5475-1-geliang.tang@suse.com>
References: <20221011120137.5475-1-geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0134.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: a4fa4c07-e5e1-4528-b49f-08daab807f8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MeH1AxhOtRjzAWrJhFpGFgxi+28khved6X1axadwaRplpsT+GR+gilNSXyN7kmTeNpCnnve5UP/lyUOsduz8uE4CkSAMRQNHUczBbtIav6D7wvf/XwlQBAHi0wl8CdzERvXhnpOGmsgdqGPWVei4BFVAei8mpdOo2XNW7aYMVnxKuVrN9MngOVctrQj5lNCPCJVZhklIXWjDMAYFKtHn9bLNxAx3S6WPnLqc9u4YUQk9MX+bylPv66q7yJf1S9tSD1Z9OMg+03ECCeEgm6GstSLiYc1IhUWpsrXNKbJGdR4Vukmp15NwEQb6L5KrYxB+2uoAVdzoeeCgZtIuW5E75D6CjT1DGW4Osv9x75SStE6vg0Flz8EP9DCr1OyhcdyYV4FxvaNCimwU/naQM9Nx+brf3NIYXhv/vsGUNVVYYM10cynmXZo0DREmsP4lciVYPh+1Lc+ttzGSLL8H6WLCnE83+ubu1p/ralgf46c7MTrJ/QMJSkUe0l4IE5Rqvh549+LpkhBa1vP4fE7x/o4tsbGQW6zV7uKPa2whnYatfMSHrnCoz02UgjPXk7wwS4tPdXo5yvPn5XJ9ji+VA6T+WaDoWtW4RoQse5xtdOkZ1A43J/c1VbcnQ8i+ENAkGWUpwH1emaJcvYyQ8EKqVSzfq4P7pmAjDzOXyaGVAWQZ9efbDDNzCaQXNK8K675YO16dZOa/KRswqf0VsFaPEd1BKO1xEzfemd2ZX1yfENxSsDr2GTWuOLtHHaIgJg0ui1Kb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199015)(83380400001)(44832011)(5660300002)(8936002)(316002)(41300700001)(66946007)(66476007)(8676002)(66556008)(6916009)(4326008)(36756003)(2906002)(107886003)(1076003)(6506007)(6486002)(86362001)(2616005)(478600001)(38100700002)(6666004)(26005)(186003)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OMlslWbfqwbn/Ipvha9/Sgbd8jPYlRh8SC1mKeTkEFP+1YHG7LqR8xPKLR+/?=
 =?us-ascii?Q?fpZM5L4IrhDeqjIky/YWMjWRbnREmasrBRTwsfZImXdLEXAxtFfEehVgq9eI?=
 =?us-ascii?Q?wmfcdakTMysdzfYikFe56rifW+Sac0xFXkHPCD4gRmP2bal4pehRnetfgt4x?=
 =?us-ascii?Q?8GBs+rNvzV8Wi8cbVb/Y0y1VGeQpo97enmH1MMiCuBuRacOKXB0jfazwUBqJ?=
 =?us-ascii?Q?FTQprO7sOwCBSyLwBbI/LF0vJtIZ/5SwhX6s8Y0NgitlsPBTqFCggdehuEY3?=
 =?us-ascii?Q?h1lHONV55yxwn8e/cQ15XDA1afwwoPZQwNTE2XTjfpJOKnnrgcR76KWTmpDs?=
 =?us-ascii?Q?ougKsK6bAHZWiBVTCMfoOsj+5g0/8GydCSARxbV2XMHODI04lM65AHwRism2?=
 =?us-ascii?Q?zdB1/3fXH4KIz+80GJYSRfzVTZL/g3rux9szUMTZpklDIwR6NWWQlMXuqDQ7?=
 =?us-ascii?Q?Evdj/UCE7k0f5Gpugbusx9gDJmh9A/mBEI6qddcJzDe5lKupQDoBlbo14Cfi?=
 =?us-ascii?Q?wie9ycdW7VkqQpfMwZZCMHyddxFdOyLfDGXh9nryY5alauZYHXhexFA8z3WP?=
 =?us-ascii?Q?SE8QN7Z9xzGA0zJkATHfxnS7QxjrAsyZIXQT658dE5s6nDIB1Encwe/+lQ1l?=
 =?us-ascii?Q?CB+PohgSFZL71a2C8aYqV1MQv5OCagaK37xpWdxt8yFGgX8JjhsoW7ueqrhs?=
 =?us-ascii?Q?lL3cZklxEGigH+AQzXWuHTzH0FMZ2GonT/inGUGI/jH10HzRJSIvinUVYoDX?=
 =?us-ascii?Q?00ALpjPTP+nqHrsNlpM6nOmSljyrOILAd7DgiQuZaM+L0Z3A4BSqr2/6YTQw?=
 =?us-ascii?Q?OL4FR2Mc0t8wMLc4Wx7NqVD9yKpeurf7QfN8eTtpDh5pY2XzZH7UFheSMYLo?=
 =?us-ascii?Q?1f1si+7cavfWZv2XdIp5Dlu5kGeJ7Pxv1UdezTtC/vEX/H9tyf050kQGIQa8?=
 =?us-ascii?Q?Yomh/sA19m6Kn8Mrz9UwOVqRqiGFnrFyj/ZF3xpklLjLtHQKkamrZQ13WWhU?=
 =?us-ascii?Q?T0NbGhQ4i/GEOn9aIvB1C2uWa3CWZGzIaxsrn0cP/g5klTJn9wzVIcI6A50h?=
 =?us-ascii?Q?1R/LJUWzqqpHTeU1A7YDyCUnXvJlvL+WAg/rOXZzBvvoaMO66nYx5tJeOTj+?=
 =?us-ascii?Q?kJgXxHA7/1wmGyI317QZG0txnM+GqUsvOa5Q4tXBXQ7KQyX9Tw6zXnE9JZWq?=
 =?us-ascii?Q?J26zxctN90KS0Zf5j75eOrbjY3bx9FSXvndenFPE/YBz/4nLxlZqmTIxChE+?=
 =?us-ascii?Q?5D6rQQNQ89RTM2fHNmsOL3Mo3odySn38AJUHiEDghYY8XgEqYOC16vbM3Q91?=
 =?us-ascii?Q?CGLws65z3+lEGoWwXqKK+6J783HUR0VUs8725JH6m+Dgtd3dl+dwxxmz4YXv?=
 =?us-ascii?Q?BZCCPQhEtz0yBEPf27WY5lHqLgA8gGzg8rOzPbhGJTJlhsbzZyE7yx3B4fnP?=
 =?us-ascii?Q?ZFeGzbhDsmg/oIMQiSmg6BTOIPH/09pkZuNLa4jv7jpFNmEfnTAGp2jeSUdD?=
 =?us-ascii?Q?C4CZE2cZKc4nQeIbiT0Yu+vcQ3uNmwj/Uf6L7nSv4vFzV2QuMSrUue4wGW9n?=
 =?us-ascii?Q?9xibP7XbsUpgBtsLLL4geWUVf3ZDOSJ3GVdVWfNNK8V2B5edXo8uvfZgFb4W?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4fa4c07-e5e1-4528-b49f-08daab807f8e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 12:02:41.3849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LnqDxoH+SCEXC4M/eyUkCmQvOADPjo18etyRXtI+92uuWB3VQDPUOuFMDE0PkjRLD0QEcTmlmDydfnAsNVMaCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7557

This patch adds the multiple subflows support for
__mptcp_subflow_push_pending(). Use mptcp_sched_get_send() wrapper
instead of mptcp_subflow_get_send() in it.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 49 +++++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e9eb1da42418..6a2d9972dec1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1604,7 +1604,6 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 	struct mptcp_sendmsg_info info = {
 		.data_lock_held = true,
 	};
-	struct sock *xmit_ssk;
 	int ret = 0;
 
 	info.flags = 0;
@@ -1613,23 +1612,41 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 		/* check for a different subflow usage only after
 		 * spooling the first chunk of data
 		 */
-		xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
-		if (!xmit_ssk)
-			goto out;
-		if (xmit_ssk != ssk) {
-			subflow = mptcp_subflow_ctx(xmit_ssk);
-			if (mptcp_subflow_has_delegated_action(subflow))
-				goto out;
-			mptcp_subflow_delegate(subflow,
-					       MPTCP_DELEGATE_SEND);
-			goto out;
+		if (first) {
+			ret = __subflow_push_pending(sk, ssk, &info);
+			if (ret <= 0) {
+				if (ret == -EAGAIN)
+					goto again;
+				break;
+			}
+			first = false;
+			continue;
 		}
 
-		ret = __subflow_push_pending(sk, ssk, &info);
-		if (ret <= 0) {
-			if (ret == -EAGAIN)
-				goto again;
-			break;
+		if (mptcp_sched_get_send(msk))
+			goto out;
+
+		mptcp_for_each_subflow(msk, subflow) {
+			if (READ_ONCE(subflow->scheduled)) {
+				struct sock *xmit_ssk = mptcp_subflow_tcp_sock(subflow);
+
+				if (xmit_ssk != ssk) {
+					if (mptcp_subflow_has_delegated_action(subflow))
+						goto out;
+					mptcp_subflow_delegate(subflow,
+							       MPTCP_DELEGATE_SEND);
+					mptcp_subflow_set_scheduled(subflow, false);
+					continue;
+				}
+
+				ret = __subflow_push_pending(sk, ssk, &info);
+				if (ret <= 0) {
+					if (ret == -EAGAIN)
+						goto again;
+					goto out;
+				}
+				mptcp_subflow_set_scheduled(subflow, false);
+			}
 		}
 	}
 
-- 
2.35.3

