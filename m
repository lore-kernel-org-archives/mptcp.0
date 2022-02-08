Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C392C9C
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 11:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644318987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4vMfaXzonIWPJebAmGRZvS0uXy3nyg6f/m+LkAtP1rI=;
	b=RiLZTx7oLKfOYQ7pvDaYZzj74D0ByeoKcPTo8tS4ljyTEb4gsLJqR9DK2uMOr6UpWoLt5B
	7fXFdWkjCQVDKAFfnheuV7CbR5yBuJcHxlyiMffeuguHfJCi8BnGjtLL5ycvRL1G65Bgoi
	3Z3NZ9OXJUxA9/2PaObtajnAIobRCDw=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2171.outbound.protection.outlook.com [104.47.17.171]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16-5VlTHI5YP8OUNsSBaak_pA-1; Tue, 08 Feb 2022 12:16:26 +0100
X-MC-Unique: 5VlTHI5YP8OUNsSBaak_pA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4bAIWVp7xA+5K6TRuAi5ywP0c6Z6mdu7YVSzwHQEkmbZMnb3LZ8gg8wrd+pR5s0J18a1eRk8PKtrdqQiEAEbDKloS9YCARgjIpLDx51Nn+pstRQle9L5vOUOxSgtDvqZQ0rhDOfOqmmdUBAkHugOpjNwQriKQ5Ri5fDHbYiSJyZRlLJH+kK8TpV8YFb/cgL9USIHvbl93DGaGD1Xup1AW78c7R9vPidHZMHfTWe8QPl6Uj1LHp9Ru3qj6ElMPRmEuKU4UsgRNq4zG84n49kJveCW9GzZn6SLQHZlNDRuvgxLrtjOdNQRS2ekqjneMV3tminnCnvjBrsJp3xTpbFjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mqcXfg9RkCMsblTnazRDULSbtxwLkOtWC5hGBe1pbw=;
 b=Qw89xTNuHwHdIHEDDQr7iQ+bksyshf914PoNNDaxEBMWo8MvRVv2DXgAQUpQLausVXtzzFxvzrW0L28nnZRV0KjNwVcrTPV54aAsBtX5ZPJBFTA7JaesEhuLXGTRjU+qwQAex+vYcPHVdhHKbJHcwbnbJmKe9q/xru8SrBXdTA1BjdOU884ESdwFaUrs9ZuerjJkr2jEZ5ILArsC/RwqwSUfo0vjzV87k/GLcstr9XhxG2odLo7jrURJm6KiJhRPe8tTqw4c0wvWr+kkx3RycR/PtFp+murr/I3Voo0ZgDDJNd35RuivQKSGoadMv+CIb1wTvfUOEZjk8on2s03Ktw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9103.eurprd04.prod.outlook.com (2603:10a6:150:22::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Tue, 8 Feb
 2022 11:16:25 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 11:16:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/4] mptcp: add echo bit in mptcp_addr_info
Date: Tue,  8 Feb 2022 19:16:06 +0800
Message-ID: <e3236d76eae1f61afd43bcb1ad08f79f859bddb4.1644318561.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644318561.git.geliang.tang@suse.com>
References: <cover.1644318561.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0070.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10d17f01-e008-4050-636c-08d9eaf471de
X-MS-TrafficTypeDiagnostic: GV1PR04MB9103:EE_
X-Microsoft-Antispam-PRVS:
	<GV1PR04MB910383542C4CF8B195C02C5EF82D9@GV1PR04MB9103.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NKud4VDY3Q/JjnFrnK7FHzHtaRJ61mrl4Dyj75+KsufbWFnwVDgn3Id9nOMGnakF7LWfdEDUGS+l7gZtrB+PjBzmpOkCdqwgdPD/rdrmFo3MGoZwv9hIH2sld+VJ5JbPH/CYUkfq8F5SLXZOKnnwgJX2CC8fLI7FVOaCEVzU/ERKXXFr0+ItwzZPsXX0KV92ns39uwXa09SZTZi25TrHeno4rFnK744FMw2IPCFVSEYpNWBTZr94t5eY5sgdYq3TMfF4YbN6eSF1I5U26sp9/sGFP7DjrRgPKgH3GmNgc+GgBOwiiRyM1krX2khxTid5dKExZtf09/4g8e7L4CZ4XlK39cdGpSvimbbkRhNAYqU0mtlkyPOrrXFtqxlsSof68bGSkDQJYJobo2NdZzwDTLS22eMvxhrYDcirG6dpgAnoqJ26GFrx296c/++EaxysiH/3I2zSXVvBQ81jbOKogCZP3EU3UJjkeAJtJb40np3q+/eZuBe9NhVleGdUuKlpCPL5iwDVJn/slPGBi0ZboXS5SyX+DR0CQCMSVMrqAsrXzOCpeMv20tyMCYzksUFT7DCxHIL0RlWC4wR9tQW2mHpzHqf9TZ4msWdNuQIsqHMy7uKNkBoX3KFaVtXWkE+4AzRwMDjygrAzqY7e28lR2g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(66946007)(316002)(186003)(4326008)(86362001)(8936002)(66476007)(2906002)(508600001)(5660300002)(83380400001)(8676002)(38100700002)(6486002)(6916009)(36756003)(26005)(6666004)(6512007)(2616005)(6506007)(55236004)(107886003)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bPJSkwHgO2fyL74kspghBxN9LogG5gn8O41xVri/r42gIqiWLVDMey00ZnnG?=
 =?us-ascii?Q?SU+j91NNW9fSIm31dDoFgSSGaTYtVkgCnSaqRDovBnfZ5JCssVOV7HXLV3Y0?=
 =?us-ascii?Q?+zIIGlIz9GTkk+vCJJGh28eFpBvGFfRg/zb+Cbp3g5JoCNVc3o0w/F9W0wYW?=
 =?us-ascii?Q?hy5Bxci3c1J5jCz5GFTXHanWY7DobOmw/0e+o/Sv/3YITLg+1ux8d0PlVlXW?=
 =?us-ascii?Q?u6K/IN6HjsftvU5MeBOZ+vuwnBCyZ/zLDt0Z/WVAhSDnhWUrTdtuBI7N8dxT?=
 =?us-ascii?Q?u9iRsVSh/7TREEx/jvQU7g6lk0jbPHSW8vGrhaVIfSd8cYaL3sV8A0f210Z8?=
 =?us-ascii?Q?8z0chSTCUYEeBb+MHHRPRzMTC8F9PclNJdtEcMnFcyQmmLucEmi0aoGn46Gf?=
 =?us-ascii?Q?zL5rBnXr31w5kcyk3eRQO9+YpeZbyJbpCVd3p00ij2E/llPlxkfhF4JBZ1hq?=
 =?us-ascii?Q?SZI32rZQavYXDkCfWE47xp2k8FpBMYrCezyoH1feXDoI1oq7BRB+Pg7FN0ju?=
 =?us-ascii?Q?YLy5FUehSVR+hgm3jpYnqTLo6ghSFjJMhYCJ0b84esQw1l0JEZdfQUkMA5jS?=
 =?us-ascii?Q?NY0Yzb79g7XDHCB/1eED2Rvsq8AfjRSKerwGaqn8sL50Ei2D6uZSOXvDcgbM?=
 =?us-ascii?Q?QAQuZbdALHD/UgvxJDCFGU4tg9VMqSFRFusEEM3JM9RPiSZDHnk6/fhhTPgn?=
 =?us-ascii?Q?ls9jPGDpOAUUKOhgOuEvB+9zGsN5kDpwrQ5ClSGzpvccD8f67A2U2QywLYVa?=
 =?us-ascii?Q?AgIK4HjA87+o+bkJfqc4izM9hvwfce59zquIU1yrO86T069rBVV+DemnpFfs?=
 =?us-ascii?Q?3vfbwH2cjsLehUo5iDkGO4/Ux4jmAynkJ3BRfxyYrvZdfdWT8xgHo62xOern?=
 =?us-ascii?Q?8tKr70V3CuiwuRcOHhFbfjWAZ1jpNtP1WTJFEZc0feYLlT345oqtjLiGdATA?=
 =?us-ascii?Q?M9nMtwrbXPvwW52w3pFyPMIvXQRC6d05fdWMqFcKWRm0etFJvs+g6QUOk8Pv?=
 =?us-ascii?Q?ASF0x0NuuEgU90WFjeq0wdhxQVUhEPrrfvxdcsJrPdYwm8axEfA8sq268FbP?=
 =?us-ascii?Q?FtfvWlFTKsIh1/7LCoqCUCQyHimLfRs1nglynqC6S8jXkmItvMTSzJVAJIUR?=
 =?us-ascii?Q?U5zA963GOsZ4D/nc/4vMbY/eHWxQq+8W5gtnkqqdrkhKQiZsaNx1GwPC8xz9?=
 =?us-ascii?Q?F6nM2EAdJ989Yaoooyg1Qa79/2Dxt39F5usc+PYm0AxgIIxPT6nGRmM9rvtC?=
 =?us-ascii?Q?NXf8l7ReebdVrmNTRpIlzCQmKEbZV1W7OtzBvRqJPFEVxGOK3nS1FOsSVlR2?=
 =?us-ascii?Q?jBOgehV0zyspJmz18ARUd9ONbf7g5SuC12lTDk5nZPFmayJiaGoYsmovQGTK?=
 =?us-ascii?Q?Au6LBm+Gf5ydfNrubyPfti/FR/xfG6M6TuPi/PQclQzaPatoZq1lqJtmK1cA?=
 =?us-ascii?Q?iWvrecNXc1Hk8G+Mq2YEuTYCJGZycKV8GvDkQkZ3GD3Z14Kmx4R3ToGNZ8wh?=
 =?us-ascii?Q?k0KOG7eRspQPg8XUieFEu7dWE/PjmQ7mvuTDcjQ8jnvYuzJagSuK+PSTQu8Y?=
 =?us-ascii?Q?2IwPIvMqgx33xsViuE5IOsrGvWSN3wD+OuGahyuaPIGKOAHsRYkITHrFBZA2?=
 =?us-ascii?Q?DrE232/OyVIl/zUdvY0Izag=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d17f01-e008-4050-636c-08d9eaf471de
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 11:16:25.5611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5aDccB4aP1/ZnWjSXJ8s+feGNcaAi/7H+av0p3m2TVE5GyzFU6W84XWg9HaGa1pL/04rd5xbu07xiI34cEMHug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9103

The echo bit is one of the important properties of a MPTCP address. It
makes sense to put it into struct mptcp_addr_info with others properties
like the address family, the id number and the port number too.

This patch added the echo bit in struct mptcp_addr_info. Use this instead
of using the struct member echo in struct mptcp_options_received.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h  |  3 ++-
 net/mptcp/options.c  | 16 +++++++++-------
 net/mptcp/protocol.h |  1 -
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 8b1afd6f5cc4..53f66e1ca4fc 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -48,7 +48,8 @@ struct mptcp_rm_list {
=20
 struct mptcp_addr_info {
 	u8			id;
-	sa_family_t		family;
+	u8			echo:1,
+				family:4;
 	__be16			port;
 	union {
 		struct in_addr	addr;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 4e516e88ab88..4070a9104386 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -234,8 +234,8 @@ static void mptcp_parse_option(const struct sk_buff *sk=
b,
 		break;
=20
 	case MPTCPOPT_ADD_ADDR:
-		mp_opt->echo =3D (*ptr++) & MPTCP_ADDR_ECHO;
-		if (!mp_opt->echo) {
+		mp_opt->addr.echo =3D (*ptr++) & MPTCP_ADDR_ECHO;
+		if (!mp_opt->addr.echo) {
 			if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR ||
 			    opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR_PORT)
 				mp_opt->addr.family =3D AF_INET;
@@ -283,13 +283,14 @@ static void mptcp_parse_option(const struct sk_buff *=
skb,
 			}
 		}
 #endif
-		if (!mp_opt->echo) {
+		if (!mp_opt->addr.echo) {
 			mp_opt->ahmac =3D get_unaligned_be64(ptr);
 			ptr +=3D 8;
 		}
 		pr_debug("ADD_ADDR%s: id=3D%d, ahmac=3D%llu, echo=3D%d, port=3D%d",
 			 (mp_opt->addr.family =3D=3D AF_INET6) ? "6" : "",
-			 mp_opt->addr.id, mp_opt->ahmac, mp_opt->echo, ntohs(mp_opt->addr.port)=
);
+			 mp_opt->addr.id, mp_opt->ahmac,
+			 mp_opt->addr.echo, ntohs(mp_opt->addr.port));
 		break;
=20
 	case MPTCPOPT_RM_ADDR:
@@ -945,7 +946,7 @@ static bool check_fully_established(struct mptcp_sock *=
msk, struct sock *ssk,
 	}
=20
 	if (((mp_opt->suboptions & OPTION_MPTCP_DSS) && mp_opt->use_ack) ||
-	    ((mp_opt->suboptions & OPTION_MPTCP_ADD_ADDR) && !mp_opt->echo)) {
+	    ((mp_opt->suboptions & OPTION_MPTCP_ADD_ADDR) && !mp_opt->addr.echo))=
 {
 		/* subflows are fully established as soon as we get any
 		 * additional ack, including ADD_ADDR.
 		 */
@@ -1076,7 +1077,7 @@ static bool add_addr_hmac_valid(struct mptcp_sock *ms=
k,
 {
 	u64 hmac =3D 0;
=20
-	if (mp_opt->echo)
+	if (mp_opt->addr.echo)
 		return true;
=20
 	hmac =3D add_addr_generate_hmac(msk->remote_key,
@@ -1129,7 +1130,8 @@ bool mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb)
=20
 		if ((mp_opt.suboptions & OPTION_MPTCP_ADD_ADDR) &&
 		    add_addr_hmac_valid(msk, &mp_opt)) {
-			if (!mp_opt.echo) {
+			if (!mp_opt.addr.echo) {
+				mp_opt.addr.echo =3D 1;
 				mptcp_pm_add_addr_received(msk, &mp_opt.addr);
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
 			} else {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0eebfc9f39bc..4becac89a4a6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -151,7 +151,6 @@ struct mptcp_options_received {
 		mpc_map:1,
 		reset_reason:4,
 		reset_transient:1,
-		echo:1,
 		backup:1,
 		deny_join_id0:1,
 		__unused:2;
--=20
2.34.1

