Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AEF15EA1
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 06:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Cd9EJUkW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbDgA59yeJoUJhOIpt6xl5Rvvxl28GGLN5jCewvguWyvVpCdf//ixdQMhomsxIKfhswIof3gO570oDSkTeOf4ujYdgxOZ4r29ufQrd6p1A3GkeVwwHimx0Fp6ahbRWi11WLT6WHvTWr+icEOw55sTFMnX7vZbdF8vwjKSGJigKn0Q4QOITaaU7SGZvOtsrniLY1HLBq5o0qNm9cRDUaxKSX4MSFBd1iX06c6mZ1SbuElbQ79ywDXjt8mGJDg2FnvJ4AJ7Xx753eWBskaeeI2k8ggGGyLCz6TS9VasMPtDfwUCnnENqC5/5uUPrtpg8bnRdNkFegkof9BAgLzfefmVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJBYBk3wnuU9EEsdwNxpmAOoIlbBcw7lgsb1TUecMlk=;
 b=S/eYhR4MVZO974/uUYAK4MjxLuYWCgSPJCBUkeJkMzlU12tlZvs584bQtIWCtnDWUD3tMOWbtb3CBRz79af52aZO8HeG2DDoOcz9Wj+pLu94By6XBh56hCF9pwtpCpWTMUFyyeunYlUAQJCzalcxKOL0w1gnFn254q5XQ1oTK3ndb6WtgD4aCwhTdjjqpv8+dkO5solGccSMdRNUvcKaTVQNyjl3lKehtvvHUOChoOP91eE6R2fQ+f/0Uwlqj9vvdV8NnhwKIsMg2vPAkQrRXVXdE6vTdIonIJMdZDAbiEZ1aNJiRfu9D8ggv79+maCGxTbhrzXBtiCsjp2pOGMzZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJBYBk3wnuU9EEsdwNxpmAOoIlbBcw7lgsb1TUecMlk=;
 b=Cd9EJUkW4Cmk6O6dJ/e2pIZYZuYVtIEapR1CQTW58SPMQMrz445V3/R0LOIl//0ZrrDGxfgEP4230C7UeZ70dfZRa2gSmXdyPZMKctG1GNr92s98Eu7dGuIh+RP4YriQz0oaycs7EoqtfzBmhJ0WlhKFSRbCeUkFeOp6KotaTlUVUr7+GLORmXEwO0VFtKLaqgTi4Quwn/o2evura9DC0nrLWeWc3leSLndSnuKijiKmymFO6flTrFCcdsVq8JFnsgxkzb+YyUa39URBs5sp8hHPIOqrYtqYEbppo+mA1AMpiu9XwIWMDGmTiK6KiVrOcZa/k6lhllR3YHSMwvvf0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6983.eurprd04.prod.outlook.com (2603:10a6:20b:102::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.43; Wed, 11 Oct
 2023 06:37:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 06:37:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "mptcp: avoid resetting when another subflow available"
Date: Wed, 11 Oct 2023 14:39:03 +0800
Message-Id: <cfa0382eb429ef762c6c862c2cd7c6d4dc6d2441.1697006323.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0062.jpnprd01.prod.outlook.com
 (2603:1096:405:2::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB6983:EE_
X-MS-Office365-Filtering-Correlation-Id: c9fb320f-ca8a-4ff9-d033-08dbca24989c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BY8y17iE8jPNt/aSmClEmxYqkTVben6+UL1mDDCaq2t4dL5E3I958UbZ/KjG+fbUaVAlHg5jOWd3xfa5CthEUZBfPiQJ20fClj6HBV9IGpLs3bs4anM0ZceGgAZjH4pa2VVvp13NmFZofpsHBn+rnDyYA2qFDORiN4Q7sKjop/LkvQyXcnKTsE/APSSmK5A+fLu7XDlDc1Xw51wAzut+SY0tCBCtc2UQ8qEHmvqkFIvSdStfhcMDSUVkhG5iVfv80ifbU0kKHwW8PODN2RWYQixiYA0f3X1elNGDcfyCSQtl68b3qqtrxKkQ9kor8/DfQmTO/lovE2Wg9uYI2cSzQFjrltAUPXnxk9Sy4kd56hI83LUIEdNB/3EEK+iAG+4xQjdVIcZHEY6me/gRkParJ9yWzA3iX4PSfhvSpeHfGDRVmtiEUtJEtxWLykpg9nbQYeGiMWQisSoz+Kpu1OxqroNuDbNIqBs0CZw1GoEy0DJMhjQfyoyRa9tCB6wV83NCDn6V7ELyLQD7GwiMgZ4RSC12UsIMNHVNdIWJPlOmORdSrIlXcIsES6QxMm7jdru+CubIMPGFd1cMNbgtfDyCHBzBycKa6k2m/5tfmKvRGAs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(36756003)(86362001)(44832011)(5660300002)(2906002)(2616005)(26005)(107886003)(478600001)(6486002)(6506007)(83380400001)(6512007)(6666004)(8676002)(66946007)(38100700002)(66476007)(66556008)(316002)(8936002)(6916009)(4326008)(41300700001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aSCq7uhzEvjCnJgP9lj5C2M5bRytdbz1vRYEJQ/U5lbCayhyhC6J7X92ey1Q?=
 =?us-ascii?Q?RUHh/fk2Z2xX0+4ZBmv44wfEQeAe9Q2/rRg03L8xYq+MHjaLMA1RrB8vaM0p?=
 =?us-ascii?Q?sqeE71tA0g2NdzlYn+IWkJTF98DxOnySISVaEfnnhWXwKSYtT/bWtLthFcjU?=
 =?us-ascii?Q?SSt8sLBnqn/chaOUa9lxKQxAhujkesf4DabYLxLkp9MvFMgDQqw6BIUfWQHJ?=
 =?us-ascii?Q?MsyjvT+Zaaf1XothN491xmYSOi+i8xtL4uY0y3FNdh6Wk0DfwdSi5cFf0jpc?=
 =?us-ascii?Q?8AbS+9sSX2Sf60MhvI83FYHSq2Fui+8amPXQFXySBjPgHD1KuUZhLwN4JfuQ?=
 =?us-ascii?Q?5AFlv+IGYl4Kloqdtiddt38/DFhRXnolGsR35sNhwn1c6aLPtP1gBvCUA0OD?=
 =?us-ascii?Q?HeJi3L7zyUcgbi4+9djxjDLcNSquOmHN5k8RPgtykF4C2/WBS3Z/Asw24yBf?=
 =?us-ascii?Q?eP3cLjwabLS5soocv+6UnQrq7n6UJIv7jlh7DgJCboU6jIB4XRp5fqU0qxj3?=
 =?us-ascii?Q?37Cp5aXGmbBb4zeO5KulJGWrFX6AjQCOUMONvP60CBul6QBn6P0pfJrmmusG?=
 =?us-ascii?Q?XkyhL5xVEFTtWNE0uVSxYh8NgLVU4R09YXI2BMhVPng5FwK4eRa0TAv9Es2q?=
 =?us-ascii?Q?JymXheRBoaj0+sZAY2stioXzhXwfzf24z1UEo7W1FRfXFXzc90dj/3elNfKn?=
 =?us-ascii?Q?JsXkXIP8CiD+8Q98DUCLfKNNQUUxWtnkFklJBbOywu8j48GDG1zezyF6HPeO?=
 =?us-ascii?Q?EIuoQasJm7FyAqRahEOXEq2TcbtswjelCdH6OxL/8q9gszh2iafnUUDIPydN?=
 =?us-ascii?Q?Zl5bmQuXlzL+vVSwqdYwxzE9bTKrZxmsxrPvPxfF0QW61+PxnwkGvy5QNrbQ?=
 =?us-ascii?Q?CTHOQueXOKYtP+FHVe1ufsZRkIECgEnvsDfqr0uH5gV15OcIeC9Vo0beXCwE?=
 =?us-ascii?Q?hbW8F/zZI8uyoEh0IdiNCfDbxex0QHnfKXmQIq18IK2GVlEsHnaH1TfFTP+F?=
 =?us-ascii?Q?jC8snglcrJzYASrkBC0ihsI0j/0PtyOply2fnjudAmWKZv0x/swVWXEZAjVx?=
 =?us-ascii?Q?nG+RsluA/MWw/vPJYdQCC2mEVX5A1JnfZao50dZYfX0v2R+Nksyk8Y1dIU4+?=
 =?us-ascii?Q?2NkaQmQsP7MQsfL+teopMS2B5+aNbCOwaC/CByOtv8H4HHhz5LAbWiZ3AVAq?=
 =?us-ascii?Q?LBZhs169In225zn6bLxZJqoVrU4ya0NfL4yVEI5LqlbRXbBZCToryC2r56h+?=
 =?us-ascii?Q?mlKYrEnboS8kR/fzJ2beWfqwg9hwx4uVUWdP6mWxUT0lEpivHwrKtXDdN+bw?=
 =?us-ascii?Q?tCCnyWueVH3Nh2frtc22O/7X0f44VXNtfumLHTRHHQxhGXg46mLCuk2lBJ7u?=
 =?us-ascii?Q?NLAjV2RGVEjFMQwY2E5P5eo1Wwieni+KIVGrrgBtTfADGNN2UD3/gcsjQ7jr?=
 =?us-ascii?Q?qJXDuCAdQpRDmLCYlCH2LC2YhUC/NK6KjUe2k2Eykyhm6wfxOsfbLUjXjLt6?=
 =?us-ascii?Q?RqZp93gzvs3KfsY6WD/MRKeRfj8sM5DUHKE28LVlwXN36UAKcXXT6P/ssw9c?=
 =?us-ascii?Q?u8vgn6XTfWSA61xC6fu/dMXaZfI65JyeUqDdzY0P?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9fb320f-ca8a-4ff9-d033-08dbca24989c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 06:37:53.3821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54hMt41M+MyoYvrXsQZXTH555duYqe3LIOkPGaBAtTO23IVyqo3PYDYWgMB2132YuOEZPuxXbddwfbOGX+tGZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6983

Invoke mptcp_subflow_shutdown() as Paolo suggested.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a94e1f519788..977bae817e62 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2396,11 +2396,17 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		goto out_release;
 	}
 
-	dispose_it = msk->free_first || ssk != msk->first ||
-		     !list_is_singular(&msk->conn_list);
+	dispose_it = msk->free_first || ssk != msk->first;
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
@@ -2447,7 +2453,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 
 	sock_put(ssk);
 
-	if (ssk == msk->first && list_is_singular(&msk->conn_list))
+	if (ssk == msk->first)
 		WRITE_ONCE(msk->first, NULL);
 
 out:
-- 
2.35.3

