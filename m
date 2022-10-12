Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959D18F48
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 04:40:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ygj3YKRXd3ka9QGKVaaZq4/ARv9yGszbXtcGOdv7SAPAfhocmlzyBMqZeP0JoHNoue4wPE4j7k6SW7mxoAQwAtHUzpsj/YZTyOmyuD1Y9Xh9H+qU6AvUIMMEY0jCJQ1qKs8IvPm+VFQo8FMNfv1rGQxV9VPCrtvym24cIn5A6ifNd7JvlimTwZ9O0tPMWrVhn0oi/2mKr5VDP1CcKfXA7hio6NheQTJQhoMZ8hAWRNNKGFN2nRPQgnAln+X/7qzwPmy8VCuz49xFP1Zn/x6zHwiiBPrfPQF7Q6ahiQmTkfY9lK21Q1UN9AzkCbS/puYB/IIY5OBcCqD4JyGuAmSx6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBqcC0XH8lE/uvVbkMxs+vy9jz1fzIz72BZrPVV4gs8=;
 b=I7wrtOModWlhJETgG1iNbZC6TUHuDjB4/mqzCkg2g6xnxjwyuyNrEebJktTA7xy6zkKMvg0ChPhnr7LCkt0EMwxeQX0b7pxwmZUmQDNGN4vhU3ciiCjgKk4U0SHr02XCabcHey8LazLSMe3VfkY5UoqVSfglUuEVJbz9eg+n8gmT6V0TyLuxL3UgVazPi0YNMRzQ223qxsc9v8eleiI3VTqhrzG4ebmMsUflA5rGmSAGQtzFDqn30FOBW95F4awqof5EJ9drBBJQgKujTULbPTsP1qJtnpzcBQrnq2yLfCGe16FTTJqLrOxDyiTkqii6lgl+aGPHdC9+yVkTU1FkCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBqcC0XH8lE/uvVbkMxs+vy9jz1fzIz72BZrPVV4gs8=;
 b=V/FYUjeFUeyUmD6y25QOIYIXVxM8wdbnFZ5wzEXcsOTkyPy1X6Uj4VfIkkVRBQ5UyhMZcFNHZpsiV4qirfxkWYk1eHgztoHnnrY/IsskJGpXpVqdg5T4hPqbMo78TbbIG38LUNNo8SGDg4g3T7t0JZ1/NBmvmf9KHmOKDKUdWVi3utwz/DhodOzkmFiLxPF0IJYhlLlaBwS4KgvJL/qcePQt7S2OAghD0piFxJYrRLsbv20moltOfobmZnCvN4HKgLGhR2jWYvyRP+YFvNxzRFPAnWEp6NxTkwrYbCylqJQfibhO3/y/VaM/kS462OMKxkn0lZaUrLD5izTI7xhtzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8814.eurprd04.prod.outlook.com (2603:10a6:102:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 04:40:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 04:40:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 06/12] mptcp: multi subflows push_pending
Date: Wed, 12 Oct 2022 12:40:01 +0800
Message-Id: <7db864f376047671f93a1902d0ec1e0cdaaf9278.1665549148.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665549148.git.geliang.tang@suse.com>
References: <cover.1665549148.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:4:188::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: 54024d6d-8fe0-451d-a0e2-08daac0bf1ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	85Cav+R6qr7dM6QsE8YjfPcQD91+BlyRCDZrLkLDVyG88HML1byHmLbIukk8X7t3ADU8PPr7RTwxg2Kk1bccrxsSqcI92gOcTAEZYely5AwpH8RnfbJPGJVG8NubeM2+teQ43gqHR9xko2nsQInbO+5Q/NrZLzX9WSQTy91tymTWcL0mZ3h8CaH+UpT5Z0KGpVMHdx+2P0jmJ6u4ZFZQlKGivbgIhXvGpZJH7lgBa7i+lY/wzp6ooL5mA5fP7FfGEszhX5mSyNQ3g5Ugm8rQaS+gsBeoMR2s5deLVBe/T8kH7IWTZxt6pXyucwXMvS8xZ608R1cIWrI3oHzbitZYOO4XzKWxQ2hfLsS7rexNMPVV392fZpzUv00J+0+DTnspUuvJrk/IZfet3Vr7A624tcN6YjmyobvY6o0woqrO8DpU6S4FfqZovqHMl20fP+n1/6eI/6w4OXQ540g7vPTq1IVm8kFkA6oGI2GY8LBLGtIO76vc1+w8X/h8GTIPNOhROiRbwHL9UH38R1NKVJSYgtP3MGSanwiAX2W6rA6ibY0Q30YjqIoB5bmHRugsSd9S3D2b3GmGWqbEMHxmhDOMa/yaKzAfvpAy52Yk9lZzPdNFmR+j8Sd653oJLIsBrg4rx+vMGmO2oL2omdQlTDJerrBS8jGoyDlSGdWmv1+rAFeUVQBTNlLwzm9n9yC0czFze/FSmjvixEjLgK8sKA7TQIWkBW313jf35UFpXv790+uitJBZTMFmIagD0jbpnNQ0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(107886003)(83380400001)(8936002)(2906002)(36756003)(8676002)(5660300002)(86362001)(41300700001)(66556008)(66946007)(316002)(44832011)(6916009)(4326008)(66476007)(26005)(6486002)(478600001)(38100700002)(186003)(2616005)(6512007)(6666004)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pDeu6c6oHYJMLU8I62XYI4SpDjGLUTBfC8ehw+sqNNtS4feKdyirkQC6yAcd?=
 =?us-ascii?Q?fuqk7kpW0Sh8bo9vRdzcdu7KmJMhrGWR1k15sqmV3Sa8nNOnldwmq2z1J+ve?=
 =?us-ascii?Q?ufpi64K3HqgGFHnF1jL381w2mmLl1pCYBk2na9qhGPpuJUrC3CIFQYTggH+r?=
 =?us-ascii?Q?isDNVJhHKfpGklxP9usu8PeAXp/INA5Qzhfk0XJrfcKi7D3h9Z5ZnyK4bM3b?=
 =?us-ascii?Q?3Hm6LMuxA7P5IVBkm4a6T/ntkrWx4cbBGv+hMLJoFoDCUKYhy2MCkHLaCZGo?=
 =?us-ascii?Q?w3LGK2LavLhjU2tWXvZg59iyQuH2y8L6nGA+HmrefvUnM8YUEsy5INTVPL6w?=
 =?us-ascii?Q?vChzPwR03fQUHeDHQdtWtnYUZo6oB03W+lRZqkHFU8jxA+h4911M49u+9Qsm?=
 =?us-ascii?Q?sIMznq7gW/UB5VW4x0aDnyl9D9+KyrQvLYllmeEVQA2IINRoI7NsWaWPcTG1?=
 =?us-ascii?Q?o48FjCEPbNk45TDT4uQoqQsC3V5Zd+VfHAekoVFRoo6LvJDAUULbs2g4Uilj?=
 =?us-ascii?Q?+xkzRZ0qGELmmH7uJLAOYarOhfWKdHM0ZMwOUAX5yI2W2Mk/EDkrGybd7Zk6?=
 =?us-ascii?Q?/QnA0UGYFNJZhokz4wSrROvWCveQoow2fLe64ZHJWIcMmg9NGJTC3pkDqIjB?=
 =?us-ascii?Q?F9qhpPSaS7DXIYNMwmQOimCd5IEhGtk4glkQO1YzWisnt2vYnYSY8O+okdxv?=
 =?us-ascii?Q?ay/gt2CQ+Dktz2Yd3Tf3uWENP8oEa1mQnwP2fij1T+bc+F2ztKKm5iWOIY5j?=
 =?us-ascii?Q?5iXksKXT+/htXujy4Nimlt5X249k0jz31CNvcebkbALKDCXAaVBpVNKAetW9?=
 =?us-ascii?Q?mPXMz49tulZBAKyGBpSIn+MgmUb+/GEjRx0f/teeOHY3l/CsMh7W9oXQ9JOS?=
 =?us-ascii?Q?GTvEe/eLE71F8TiIG2LsTF4pReRVSU9eVKT+dpQQmWfOM2bR1cmrIBGmaIqZ?=
 =?us-ascii?Q?yzNI2RSFX9eLt6YwOoNHXenjWwud/QlHaW0hSY/BnA8fsphLhTxaCjkmJtyW?=
 =?us-ascii?Q?GhXyR2pLxTTVtlHOBFWSlMhM6GTg3UKC9mq0LYdL29r1mAfmDKXwVHgQMymY?=
 =?us-ascii?Q?ylD4CKlvEphXZh0PRXEuH/g2hQ+0yEqDbzswylL06kahQWYe7ouoT51Wtoga?=
 =?us-ascii?Q?iQTBa46QFOXmdN0lMBAjvNWFIAnxeFPFzXNtX9SjVIVsVhE9dZFcpwh/J0tT?=
 =?us-ascii?Q?YWd/gCow0x01ePE1voyw3BUcv28BOfdgErHRIhtjjBF0jQnfqzMuYfWJMxPt?=
 =?us-ascii?Q?+2s5EVKL3wpTtxPqzica2YCnyDEV0UI983ghvt8nqCEiPPLgO7iLa0KLP8hm?=
 =?us-ascii?Q?QgTBi3p0ngp0LYe0WtgkKP78kLabwBEuoi3zgWNHtb/+qcAKM+Wz+QCEXtQx?=
 =?us-ascii?Q?Mn2wvO7+0TnQMMlj7y6Qe6WYBehZw1ow8AIkQRbalPWcRpJqSO/l3xNBd2Rq?=
 =?us-ascii?Q?H0brK84yeF/C9CRC0tEpK45oWowgHVFL0oLjsSZUR8PaSI88MPF8SvNqUK2s?=
 =?us-ascii?Q?ZeuvlIESimrJ7vQGyzs6rahfIl8M0TByfV1DmdSdnM1IYUWepqHXsUt5B8eQ?=
 =?us-ascii?Q?WYj6uMA6/VEvtQa2Bv4lMj/U4vz8OeT7FERbaTy72A6hUcAa0dOsZY9MIFQF?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54024d6d-8fe0-451d-a0e2-08daac0bf1ec
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 04:40:53.0874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJRiWsF+yVc4PyBd5e1nJCV7LI3MYkwtN0Med5QQKQRYSRMhPiVPfTgp5tkZQ8JbJQKqHxM++yFPUM+xWh4yNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8814

This patch adds the multiple subflows support for __mptcp_push_pending().
Use mptcp_sched_get_send() wrapper instead of mptcp_subflow_get_send() in
it.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 817e539d1d12..86ac38d10bc4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1561,22 +1561,30 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct mptcp_sendmsg_info info = {
-				.flags = flags,
-	};
-	struct sock *ssk;
 	int ret = 0;
 
 again:
-	while (mptcp_send_head(sk) && (ssk = mptcp_subflow_get_send(msk))) {
-		lock_sock(ssk);
-		ret = __subflow_push_pending(sk, ssk, &info);
-		release_sock(ssk);
+	while (mptcp_send_head(sk) && !mptcp_sched_get_send(msk)) {
+		struct mptcp_subflow_context *subflow;
+		struct mptcp_sendmsg_info info = {
+			.flags = flags,
+		};
 
-		if (ret <= 0) {
-			if (ret == -EAGAIN)
-				goto again;
-			goto out;
+		mptcp_for_each_subflow(msk, subflow) {
+			if (READ_ONCE(subflow->scheduled)) {
+				struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+				lock_sock(ssk);
+				ret = __subflow_push_pending(sk, ssk, &info);
+				release_sock(ssk);
+
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

