Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97BB72
	for <mptcp@lists.linux.dev>; Thu, 21 Oct 2021 06:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1634796436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EgjbJ/MkRKX852qKVVNVTGlvIaNgI4I0gLDFHBoMgdc=;
	b=WR/JXmCdNlhYyj/g7/mSKL/qEt/PaTc4+TTrYykmqUT27hle6dl9uZADzhpofqq6Cgc6tc
	OdDGt2dwba+BYPUI6sUNtC/tp2FFI/nR8vtfBtqtmWffC/b/yoO+myzIu2SalJgoKroWkO
	oqNgSfWOn7nN4QOKP5pKk3Xvxw9MbjA=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2055.outbound.protection.outlook.com [104.47.6.55]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-25-EVGY2LubOj-UBU39v3Da_A-1; Thu, 21 Oct 2021 08:07:15 +0200
X-MC-Unique: EVGY2LubOj-UBU39v3Da_A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9XFOl9KAzlJ+MJtXnvln9wmA3X2JUHgRIxwAkTN8R2RT8mDL+jDygm4rpZ8qxrZXpGaJwXbUNz+X3qj9XjIUYVruccwQXf7vNpC6+4hlDaCQ0qMKqGG84nYMYELkir4+wkyf6wVLkHRGEo/UtatwCKXVN+aoUeezgUAGHww6De82srtIDQfVDiw578cmZzSSwrvbkoWa+jwaY09MnylunRzMOSxI9l642hQ31kEWMNmOOIKC3xdixe+6+IZNG+qAf426YEQl1Vw5fwZGrDi8/RBpF4I2L7KBzbQCNy90gNfKXFl9CeDGFREwWPBHO7PM7nwf52qJ51wYRjzLBPwxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOLRYbScZtBqvUIEHMAmiCpqAe8Ojt8jvU254HwZaCI=;
 b=oIzzpytGR49q8sHv/0IgDVm0kHnCTK8o9Y2/tchgmhJHljdi7FtyF5pYLXcJOiqIuIiyuSpn2iIOzVHa0GdpxrXXkaYVa+KnAlll+HAWBEU6pQq114Jx4B39ojPxtTfnJVuiC066UhVa6x+ewsJZmJsW3nvpX6lQVNB0dg8wVWAlpx1kzZaw8A31nxKxGNEhwxOaYsv4ZkW4ikqDt84NRw3+FpvP8MaUTlQmwnMksCfvyjiBSO9LzBlZCyAR9pj9HZZFJlXoIB/DDfmkMSW9KHelgbqkbbwSgi0EwfZhrwm8dGUrc2t6zyk7QeTC9HL5np08dJVi8j/wMCcuVp+Psw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB3019.eurprd04.prod.outlook.com (2603:10a6:7:1d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Thu, 21 Oct
 2021 06:07:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af%6]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 06:07:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "mptcp: infinite mapping receiving"
Date: Thu, 21 Oct 2021 14:06:51 +0800
Message-ID: <39044f0b1da24b4228ed186a751b893a94e9d56b.1634796076.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0020.apcprd03.prod.outlook.com
 (2603:1096:202::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by HK2PR0302CA0020.apcprd03.prod.outlook.com (2603:1096:202::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.12 via Frontend Transport; Thu, 21 Oct 2021 06:07:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acc8cf7b-dd70-48ea-c87b-08d9945905d6
X-MS-TrafficTypeDiagnostic: HE1PR04MB3019:
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB3019016FACAFDCDCFFB1EA72F8BF9@HE1PR04MB3019.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d4vKU/3kjmdgVcuzOHKFdQ2NlamUzCJYeLkp5oka38b0pd4S1/mQO/9ON99o1mibhrbnf5zOqJxlkZNnKHTjs3jtHnBo7QaVDeIsNfT/zcvsOSDpwHL3z8fNZhdIf99CBf9zh0n9NULebndeyCldYpMl5JoxdWtDeiLv2td2Yh6hskWdsF5AMlsCfRQ9YQiESlAJcM0OxL62pMa/FD5NNvwXx0PQROFhw5IErrwPoFvqqtu+PxwhGlGXPOVJUUM0Kg7bmYcwGiXJ0cjz3fS6GuJvtOf+Yd9ASOssXkmggmp4E2pz4j4DVSCw8+6PwY4Rakln3ApUyqsqcHprM76qpDRJ43ujLPYQYDJ0dBII/w/Wt9INjsbDYKe0mkylwmFy4fpp+qLIvy4b7qW2M4q2RLub6Nj1IBf74wK4cUCXToZmrKxOEtZS5m6P0sZOpv+mb0aDDgnOwRG8d4iL/vyM9nW8xgqbpqLxX15nhVGi8u3S4e/eSTqrGkdo2rY8sYjZLQrFMnC3gL9lUYaJsP9E5i4lK7KGZvm8c80/NUPKu3STni91iCQhDQLwzfnSDnDxA9GLYa7Kvnxt+V7ImsA3+Zo+auSaIwwNX9sb23jCsr1HWG8OkICSxX3O7uUq8EE0bGC/T3ZA1bM/u+qmBpD/lg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(956004)(8936002)(2616005)(44832011)(8676002)(38100700002)(6496006)(83380400001)(2906002)(508600001)(4326008)(6666004)(26005)(6916009)(5660300002)(186003)(36756003)(55236004)(6486002)(86362001)(66476007)(66946007)(107886003)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G/GQDhnSgmeOGUcpJA9RChLB6ySQdRjS9a6MP7ALd0WmXWjB/cxhY1ST2W9I?=
 =?us-ascii?Q?/MakwfvU0ABiUKldTFnK566HXtgRza77x9t3sci49lbm5Vt9PSDzqV+HSWcJ?=
 =?us-ascii?Q?RLRM7bzCwh6amM5B5coKeQWT+SnFfrDuFI/XKcvRcsIrYaXpEK8rOsNoZWvU?=
 =?us-ascii?Q?WOB1td5Y0wsuIht6K9/ISnv4GkIyTwb8tidovY6R2s5CEdcARdJJjWF5E/Mg?=
 =?us-ascii?Q?OcbEz6hAkLTlMgd8gVeDOc76KTRsBa1zGp+FEGQ28N4lRROff8ZcoleGLvV+?=
 =?us-ascii?Q?V2c8sX1JK504ruD0D8GRozJdwPrNDUxCnfSNHrxRZIkBnz5uthfqVGxgMlSO?=
 =?us-ascii?Q?cABnEpWK8XbiDvP5hYPfFU0CukiaFe7Td9qGSOqsCv/pzrshiirsPLOBl5DU?=
 =?us-ascii?Q?g4eutsQZ8byCvBMuyNwpfLns6sGS88qT040DeEFT/buqJZANKCN3RZ2beR4F?=
 =?us-ascii?Q?yLbHmxqVwckLAllsoWHzLmlWVfP7LrqIxoUHJTPs2e6z2MXLwAase/DZAkUy?=
 =?us-ascii?Q?RumzydR+WSS7nbeGuEAl8OpCfhNolJPqEZDqxGKQ0/kvDz1y+h1xMa0VOFiz?=
 =?us-ascii?Q?nY139Ib9xyX71l+CXHlFeEsnmaiLFU3xSEK1DSIP6cg0g+d1GE+yTL7UxQ8j?=
 =?us-ascii?Q?76tadR71AZWtexJRFK6lOOfiKndThUBM2rRRRU3gODiS/QXniR8AL9PEd/Mj?=
 =?us-ascii?Q?zfat8tZcIKwQ7kN0mYrewvMRwb0Nn/VFrxe1ndJDFxcgMLcAObpGgtwF6jUz?=
 =?us-ascii?Q?5ETPA+B8pgDM/cwNgrXW8QloIxOZchHrzgXfa32aI/0VtDzCMJX0DembRGK/?=
 =?us-ascii?Q?avvfMEdSAle9auWhnMFO0rERoehuj9JqjNhIBf0bVQVH86mKRPLuwnmk4knw?=
 =?us-ascii?Q?R2LhtfpGcvmN6N+zMfmg4PZFdc9i0JF0JO014Jl7VCB8FhbC2jzfq2YwSsgz?=
 =?us-ascii?Q?V6qw4tgC8acqcJJSJosTBmnMXMXFJuinSzwwSVnM0wDwwZHG5VGeCL+5i1Bh?=
 =?us-ascii?Q?evW8VTNn41tcNLsKVrPQlrAFXM5+hzFearRntClPeYizTazchPVo4/lZyrz5?=
 =?us-ascii?Q?YM8a1NOlF+yaJsryLKjcYwwyuxTfTuyxUataD4V4eqY0uSfYHLK4fua/DuEt?=
 =?us-ascii?Q?J3isnfbvGuwixtgma5+x2G/zEyXkpy/taYV+1oGOu4zFFK2fFNjDXORuSapw?=
 =?us-ascii?Q?FtQuGUWZ7V3QROcAOM15DZ+8hAvl3aLwLJnv5CT7XLPOVEGL3KYfVIOGAPx8?=
 =?us-ascii?Q?F+NkmHL/4msDIQCa+27fP9AEE9zIjJZoo62iC7ZGqMUydUTM4g1/dCS5IPNl?=
 =?us-ascii?Q?jSaGRfbZCBqRHKnU5VDc07XM?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc8cf7b-dd70-48ea-c87b-08d9945905d6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 06:07:12.3986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: geliang.tang@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3019

Please update the commit log too:

'''
This patch added the infinite mapping receiving logic.

In mptcp_incoming_options(), invoke the new helper function
mptcp_infinite_map_received() to check whether the infinite mapping
is received. If it is, set the infinite_map flag of struct mptcp_ext.

In get_mapping_status(), if the infinite mapping is received, set the
map_data_len of the subflow to 0.

In subflow_check_data_avail(), only reset the subflow when the map_data_len
of the subflow is non-zero.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/options.c | 16 +++++++++++++---
 net/mptcp/subflow.c |  2 +-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index f4591421ed22..0144cc97a123 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1077,6 +1077,14 @@ static bool add_addr_hmac_valid(struct mptcp_sock *m=
sk,
 	return hmac =3D=3D mp_opt->ahmac;
 }
=20
+static bool mptcp_infinite_map_received(struct mptcp_options_received *mp_=
opt)
+{
+	if (mp_opt->use_map && !mp_opt->data_len)
+		return true;
+
+	return false;
+}
+
 /* Return false if a subflow has been reset, else return true */
 bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 {
@@ -1085,7 +1093,9 @@ bool mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb)
 	struct mptcp_options_received mp_opt;
 	struct mptcp_ext *mpext;
=20
-	if (__mptcp_check_fallback(msk)) {
+	mptcp_get_options(sk, skb, &mp_opt);
+
+	if (__mptcp_check_fallback(msk) && !mptcp_infinite_map_received(&mp_opt))=
 {
 		/* Keep it simple and unconditionally trigger send data cleanup and
 		 * pending queue spooling. We will need to acquire the data lock
 		 * for more accurate checks, and once the lock is acquired, such
@@ -1099,8 +1109,6 @@ bool mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb)
 		return true;
 	}
=20
-	mptcp_get_options(sk, skb, &mp_opt);
-
 	/* The subflow can be in close state only if check_fully_established()
 	 * just sent a reset. If so, tell the caller to ignore the current packet=
.
 	 */
@@ -1202,6 +1210,8 @@ bool mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb)
=20
 		if (mpext->csum_reqd)
 			mpext->csum =3D mp_opt.csum;
+		if (mptcp_infinite_map_received(&mp_opt))
+			mpext->infinite_map =3D 1;
 	}
=20
 	return true;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 9e54122f18f4..bb7d8685ffd4 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -938,7 +938,7 @@ static enum mapping_status get_mapping_status(struct so=
ck *ssk,
 	if (!skb)
 		return MAPPING_EMPTY;
=20
-	if (mptcp_check_fallback(ssk))
+	if (mptcp_check_fallback(ssk) && !mptcp_check_infinite_map(skb))
 		return MAPPING_DUMMY;
=20
 	mpext =3D mptcp_get_ext(skb);
--=20
2.26.2

