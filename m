Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2078.outbound.protection.outlook.com [40.107.249.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7928B6ABA
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 09:09:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3osB7t0KzEF/8JYeh5nOm6+MfNYR4GRl/6FMgeywRikNjGk7VywKZAbNmYFMawkw8aGK+ulL3VIWhvtVxl880pHPnZZaLS/GB4SPLziIujI/FS5YZgSHNNd/CCrHuT0/RnPGoCdhZFj+7ao809F6p1021QqAvjk6Cps71Y95vvVUKsydsHlb/Ln28NSRzVOivaN1frwOaJprVIY5YpbhvN8q36//9RBe4dOs1HJY6sOlAJR2ezN/l7vgkHsKM3V3azzi9TeIshjT2kD9XY4bx6kFCKeR2pIe7iBW5bMOMxLWJAdqIlFG824a2mN5eJR9dgGIRTu9g/m9f2mTubkQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fY9QF5iAszTFM/Lu7fkcGRgrUl4rViwkU7dZc8Hf2XA=;
 b=nNzsenIlv0WHe0GJhXWOZhqLcfp1P7Ve5/VJMNdVsVoXwtyf9UsXOCpj6jFWKo0Z6pFVailQh1SDbqnP/RDjWvAqAm+33IOv6af9HROOm+H0ZjaPl6Sve1flfEobpvk6Dnj/MSYDaM2QHIlCFV/IUjXrXsrj0rok4UnIgDvP4lJfY/IFyTfgARPbwuJaT7L5qTRJsnQ5CBsXFmqHLZ1q7MlnTOQj72/HwR9MgMEmrfA18zazrUwtPkOGaYkGB6z0pJVwEv85QDSML3j8vw9Ib5y/vZGDF+jvhgGFNseG7DCv4+I0siCS0tNqhUXhJ3EAljGHxLZRuGD46+El4vysEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fY9QF5iAszTFM/Lu7fkcGRgrUl4rViwkU7dZc8Hf2XA=;
 b=grZKp6LQLyQMJnb4xsGfuumXHSSfaD2oAoDWqkyZcMdLdx4ANk89HCQrjd+fUktjJu5ZLf3Keqs3xcJomTCN1HuAAqi5nUPjrxkPvW+1J9z89TYm4ablJesIEi6oaXvyTDTE/+ryHpZKbmUbnyPT6LMMVHli9osRCV+Z9/GligHNq+evA9otF2cm+HVXso01D9TGmXgEzFNEJE5B2ZHUFf/71xKtrZtSyX1MHG9RGVxZjLkcFAZm7Vs1IWS2sM/CtPXIxfO4xHsOqB5NcIPiHS3qUHr3mfOrPFCwZ6l2Gj+YG8wjmyIGFhJeRMsgzxiySCo1af7QGZ/zji6xpsOA3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7914.eurprd04.prod.outlook.com (2603:10a6:10:1f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Tue, 8 Nov
 2022 09:09:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 09:09:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v18 04/15] Squash to "mptcp: add struct mptcp_sched_ops"
Date: Tue,  8 Nov 2022 17:08:26 +0800
Message-Id: <71e18ce88db8f2a7dbe4163060a5fa38aabcf332.1667897099.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1667897099.git.geliang.tang@suse.com>
References: <cover.1667897099.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: 02382fc4-cc39-4c89-d8b2-08dac168e03e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rZdqgByjgslKPEg2Hvrhp7z9rphLn1dVOIGcjX/ekFZ7vHxzONGfeue9XNjQquW7cfpfe+JpoCZC47A5lrDEdp/HsmPHR+Da+UW4DLAu6UShbktCjYqKPz8T9943I+lWUzBi6nrwtNjpAKeW1f94VUI1cDE0uoHQHQenGljAopSF9/Jt/Q/wXl3KaMutR0wgbYmG8exboJUqVkTOnFuDb31GaZ4TKlJzs5CFmzhCJqFqhFbsxIzR9gkajhVDzc7S8S0MqYVdxT/jsVW/7bVaxWwEMEhUjxlRjHxljjgCWzHBOt/2ExCQaLgJ3ju8ByW+CEWP494mFEVhhrFvvK8+o+ByUtyzdzpu2D6nmP7Ou/fey+KjvK+/S5tcdeMeJ9aYIaVdB8z0j3LDsJGoNzbdjcEPzXJC7fe1xGL465X5Ed6VRaNaMrQ0ckLhktoxUGPewxO9laREyPGQBTml+4fBtoibzJSOqkzmbvgAMJsKy5O4TFvyLbpdOKEpEkNz7THcjbpxFv7hDuIKVXqz77ccrQtIJJV0YSXgqMy+Xoix31AWUmGnycJMXuEccBvhWKfDwLDcjPVKAE/RzEMQ9Lm7vznG8I0u4fhJkofah+X5GMGYs0+Dlmw+6q1OBNL5PzppzDa4+XihcozeCOLAaI7tD7RqheOIi1h2jRgO4z+yhIEthSktWQYrBqLyT2lr8OPlvGeafDDaUkagaI2VL7J53h3Xl211ecG7OdqXvM8nE1pjIDhmBCyPZ4ctnLZM97Br
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199015)(66556008)(66946007)(8676002)(4326008)(66476007)(316002)(6916009)(2616005)(8936002)(186003)(86362001)(38100700002)(6486002)(5660300002)(41300700001)(6666004)(26005)(107886003)(6512007)(6506007)(2906002)(83380400001)(478600001)(44832011)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RDD4phtR6DmJDRJ6hgzG7LZZyrnZrb+rD00vWXO1FLOVnAWeqR68DsYs1fVe?=
 =?us-ascii?Q?IN3EG90kvnxZmli89ZQDWesxELXK5Q++qWYlhb/sqzKQ35RTvnqVB1/nLkKu?=
 =?us-ascii?Q?T6ZwJaQzvvkrvqHklzEjtyADfeITM+mVBWC4+G0QvR3Gn6unggEjLjylADWy?=
 =?us-ascii?Q?ls3LEb4o5Xv9tYgPDTSnUX6h7OM2zJKV1sg9hv42/9zcOWQu3CzSP/GZMEuA?=
 =?us-ascii?Q?X1aMqn7oh+27w1X8IGjW/+kxzw5k9CqJvetdQNJK49wrUuuNtqSvWPYKJjv6?=
 =?us-ascii?Q?cgtZ+7qZEnI6RwTGpuXDPuOSjPrp3RQ+VfhFv6YPK4Z6R7k3c5m+yOawjpUS?=
 =?us-ascii?Q?ugHvO8hlByLxL+OpG9jYHYH6dxcsWv0dexRWdFXTWGaFVKwOU6nIELmVSoTC?=
 =?us-ascii?Q?yDzRpRy3Bzj6z0chw7JV3BEJWer+F+WG8o5vrjjgkX+OoEmX4mO1SStYNoTQ?=
 =?us-ascii?Q?mFd7cZ799guJnf6sA72sKp+qBC4CSY3Oga19f5lYZPWdh8bt5Nf/KfATqCHx?=
 =?us-ascii?Q?RwNQbA/BcZZS4MdsuuQzifRQd30pV2+PqdwSBMy7BGd4gbmd8TCgBUO1qLZ2?=
 =?us-ascii?Q?WdmJ/TWF+9DQJCcjJAh/bb81bctvhmnfZzWQAi50ykw64pNWKqzRXDp0G4xy?=
 =?us-ascii?Q?iAI+vhewEjhyepIqFhuIULxSu9qXU6d3gWjZp1qBf3lfxxh0glQiAv0/GFxz?=
 =?us-ascii?Q?6OM6fT6Hz4VMfMzwLdCHTFFvBrwtFoQYfTeKgEZ9ZqzYJWFL4ukbaW8PJjES?=
 =?us-ascii?Q?t/33RvUYZk8kegwx3Vp9SDutm+Jyl9wvthfrhdHrc0bUV5BbK9qbE47ztm23?=
 =?us-ascii?Q?hPt8s8sI53CD4908hIQWVZgfoX8r+kjfRpC8JcjlSt9T10yMEhJGwUEJitHB?=
 =?us-ascii?Q?8Uc2vmWPPttcheBnZgo8gl8aDnRZl+W2ce4QWBz83P5f9PKNY8H/OeoZdw5w?=
 =?us-ascii?Q?XQWOMwrrGBPLhZxO88jdp2nsc+wBrnW4I5IyW2hWnohK3XGOuv6LvVO6rpX9?=
 =?us-ascii?Q?GvRyqh9YZUx7eEFnx1oJL8IR1AvVTTuEShvItmmRiDofHvIVYIK4X8tRytNe?=
 =?us-ascii?Q?k0laEe+va8daJUnAZRcZrlQ9VI2/iTRXxFK5vAC5EVIkwBp0mRtx3KhVUcjY?=
 =?us-ascii?Q?HKGxPorsGI1P9dUSDPupa8Fs47+iWTI9kZrSskVNnGsOV+v/OxJ7W9dvnNpL?=
 =?us-ascii?Q?lOOszLT8JIXNHEmRyjwUGfF8jQhvAcUM+lajp6yBu6fi6KiyZays5MXAGdWR?=
 =?us-ascii?Q?wXPse1keQDVyCoL7e6pgxBkuvwPe1jO63TvuZq03LiWwckLmdfO9EsWqjZwX?=
 =?us-ascii?Q?9wiYfM+L4uGoHK1/DsqKxyI4obRl6iw1VXpnltWpe3bXjPLHcwPnKv1daeB3?=
 =?us-ascii?Q?vIAwFniMPXmRH6VbkS6qyThMmQt9wFPyUe3yjnBTouUU7nc8+TB9EMI7SDV3?=
 =?us-ascii?Q?v8xeFYr4lvwMEhLvjcb4vKuwGJWsJuEJoM0WMTvQCbOmjcjldIMzZ4LMQfc8?=
 =?us-ascii?Q?yWOWvFIsZ0Tb5IJ0+womkVLTQ2RmRgIpy8T0+TT+qGs8kPf/laek58nT0CvT?=
 =?us-ascii?Q?BuXZis5xRgMOOX7lTRr6ZuQgjBxuiIR5/sjQmBG9?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02382fc4-cc39-4c89-d8b2-08dac168e03e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 09:09:01.0727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fe09u0sWrzCxTqMtmYPChaVBY6q6v784xrTGtmgkRPXli6aZTMrQLXjBDGabJeVWzg/9LzXfA1NQCmm9lIDzng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7914

New api:
 - add new data_init
 - add an int return value for get_subflow

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h | 6 ++++--
 net/mptcp/sched.c   | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index c25939b2af68..0f386d805957 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -105,8 +105,10 @@ struct mptcp_sched_data {
 };
 
 struct mptcp_sched_ops {
-	void (*get_subflow)(const struct mptcp_sock *msk,
-			    struct mptcp_sched_data *data);
+	void (*data_init)(const struct mptcp_sock *msk,
+			  struct mptcp_sched_data *data);
+	int (*get_subflow)(const struct mptcp_sock *msk,
+			   struct mptcp_sched_data *data);
 
 	char			name[MPTCP_SCHED_NAME_MAX];
 	struct module		*owner;
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 5a910da1452b..0d7c73e9562e 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -33,7 +33,7 @@ struct mptcp_sched_ops *mptcp_sched_find(const char *name)
 
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
 {
-	if (!sched->get_subflow)
+	if (!sched->data_init || !sched->get_subflow)
 		return -EINVAL;
 
 	spin_lock(&mptcp_sched_list_lock);
-- 
2.35.3

