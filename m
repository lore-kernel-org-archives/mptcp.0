Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B0935888
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q0rd5J8r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJiShoKnKSuqS3cxQAXjJ82uPrsL86YvWWkSsC2023S5c4cUaLSV4JPn3xLE7IS6bshHys/ZHufpH+NK+KUtKk95L2NEunpdS5583UCtvdfq43hymS/Ba8L0V0LNxTFTTq4dMfSB43zsu6uXQPxqKD6qL84mKjD9XGPYmuNThhxrTNrVOyDSZLgfmO7IIIGzdEHFBEjUw3A6bJjpPN21lO5tAQU4jpgO9O5ibviaO7JQrOvdOn8gEqE/cnQEjpUvsytLkVpr/ZiT5jmZWDtQU4Ve2qeQ9T8MUqvLAEVJal6mJMnLHgwi4pEd+hiQ4WKCR9TwQmiAEuVuEWec3k44MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSjB0p8eF+L9rLQzSCrjmuOvxEFcgy8tIgNP4m0pVvc=;
 b=LFIgL8di5ASHHO4i8NB2T8KdqShuEbwERCSwUpaTprn5X7IrFf5+HxCI30IdyWzyXabExXSYjp/6dDC9xqJ9OxqwvqT+/2ENMwm7f/3EhVl/5P5KfFGO5O6HGZ5WWDOgdKT52Z2p/Uu31c8d8R0+6Vgo4zhUwYoIesH02mpN+ypQ2OwDfmgqzc2j+6rkExsdzosWdZbgCa2WAlUWPD/SF1dql2yBLuH07r3KzbFpw6Mtq9xupP55xTYT+FcUbsalXOAO/zbXUbSfuYwwA6KiTs2C6IiiyeCxvGqTLC5aaYA5IVhzLqn/eeQNr0Y6aQnQAqOqGctRli1Ew5tglsv8pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSjB0p8eF+L9rLQzSCrjmuOvxEFcgy8tIgNP4m0pVvc=;
 b=Q0rd5J8rykMHOrjE7IH6uA9MTfIiEylXofhRLUrNbjoq/5X/AF2SQDrLO4kmWYKNoKO9XAIi4fQSNobiHCwge9KglG0yFnSg3aNsO3u53hXIEuX1GL/UKBQfKH2s7iNVaiaCpbnheTuLtQWP9OTbc2XURDNZ/bQB1JGUtr3unmemOw+1kUcHDYqJJ7KkoCHoS8m4X9wyhPBZy9b4g45mc9xDZ32vpFii0y7prqqDg+BDc6hHVL3OEPRHEBqQ/qh+yBwYUPz+aCQVd1Fegnrn0ENi/p21Kocw93HAJoleCYeCGo/Gx/+l4KTAk3oB6icyIPlEV0Tq7GRp02+r2YYYqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB9952.eurprd04.prod.outlook.com (2603:10a6:150:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Tue, 28 Nov
 2023 14:13:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:13:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/4] mptcp: add mib counter dec helper
Date: Tue, 28 Nov 2023 22:14:03 +0800
Message-Id: <2ff0f06295f79c55aef4bca0ca67d112a09f60e0.1701180777.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180777.git.geliang.tang@suse.com>
References: <cover.1701180777.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB9952:EE_
X-MS-Office365-Filtering-Correlation-Id: 923fca3b-dc9a-40fe-f251-08dbf01c4074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2APSFEoKwnzi2GYX/3/io7F30vQfJKikwxvpkmMHHC2NY5y8ZxyyFyl2uXLAUKH+hhuisY8qOrYY/dbHiDdafyDnfhg1MEoNR5VYAwL9XvO6octts1FvBiyLeLt8625KHfvUkOQMLCmhy+CEPhkHN4EtpiA07M+I/aVxTNSZq+aHxT2u8j52QqafGeF9y+T9VWdbmFZ0MxJ0PC5RAqG10wwJemuplkox45Nk8ft/J+B8SRD6U7mt4ZOgl2MV6HZyybAUcmhHyGsivC1oppa8uJsZ/e7xc9niPiTuIpWjSKzcl/3T8Cg9Q1t+NjXneDkdkBkjgdTEupdykF0xSaGCGIyQK21Q7H2TwX7RQ50H7jqa80P7DPzirj1HzFeIlmhh1D0y8SN0Xtf0q9I2SmIyk/BvQ/L6Cp3GCZDFTRPBc0x/Gu7zYH2VDdYrzozbDPqp4Dbb5xDY55qRifoIakPV8WPTgz36agd9F4sCAHDqvpkBoO8RTTwZmSxRQamllyELr9O10LuMLQG74KWsG4UB+hpZy/busHSBDOhifvAM7INDT2f3z6ryFG2sJYqnoD5f
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6486002)(38100700002)(478600001)(41300700001)(4326008)(8936002)(36756003)(8676002)(86362001)(6916009)(66556008)(66476007)(66946007)(107886003)(26005)(316002)(2616005)(6506007)(6666004)(6512007)(44832011)(4744005)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7XjcQ0miSBtGNeKRFl5VmIV6cPeoGyejDDH6wTfmXVaNi3UbMFTnrdBx3w1/?=
 =?us-ascii?Q?QG+ZTcTPFsI8RhkCnROUtHSDTBUETsCRe0XmmrMtha8q0TmTV7ickcwq7Gep?=
 =?us-ascii?Q?2R5itJmA9x7hpIMP4VwL5dp86dcJhpW2JccqvKOVvjyeVu/yfbLHYy6qm+IK?=
 =?us-ascii?Q?dHOG2sJFfF3NbBbvsMmytLxIePadvurMEkjLKfjlSdTGYhjK8UdXP8ihNEvt?=
 =?us-ascii?Q?GteR0jsubviPJy7nMqP/YHRQkOSH7YNKHVvCMcmRTmYw7JcUfH6lu685+upU?=
 =?us-ascii?Q?SZ7GXB7fyvU1Ban5gG5eFXQUFiRZ/jXE6WQNKB0fdhflKeCLmwiES55d5oa4?=
 =?us-ascii?Q?QSRhvkkf4mVVWAWZ86+zdvd/F0sxHckr+HsuGbLQx5ov4x75SK6su4I4/R2I?=
 =?us-ascii?Q?+CiYWNNOGPsCCDiNh10tKGwH559RSepTNXdXZ1Gl0Qq/WGYFcwCVtiKpwCeB?=
 =?us-ascii?Q?48un8SbUElG8qU+4ur0Sv5DQ3vIZhlcBpd6wXEWAXAHi4D2oXGzJebb8S/Df?=
 =?us-ascii?Q?AoSKVrjAElmalua7gRsiEnNnyk8ZSNKE5TztoatjxUsuE7pgACfu4p6EiSjf?=
 =?us-ascii?Q?gnd663UjLX2ul9oa0PSVhgh6RgCiZDgmxIZ8eBo/AfP6nP5tmBYu5ic+vcyZ?=
 =?us-ascii?Q?26s0YGAg6PL3GFA5moOPz0L5tbK6gk7Zgeg6ImTfr1DDLO+xbjNXdAc9RWrG?=
 =?us-ascii?Q?zGI2i8KN1SeJDtZ090PUzVnwPWH1IP6h3+BFEXosDn6gr0VZe8V7jn9zQIkb?=
 =?us-ascii?Q?mdIxqmfAC5CMEMxoi4A+r+2b1M0OYwqcgbPXMSaV8arzIAMJ70sAWgm/yGdV?=
 =?us-ascii?Q?9+ZwsiEYCXwmMHUZcuH5NlWQ6SwOehYBOU0kSwAVU7sk2fheOI0kq1cDVp7P?=
 =?us-ascii?Q?YFwiGQaDiTyNZST4ZJoP9N4Tlgd33ubM7+XQDJvo0VEljc+k6J1D1+YhUzHS?=
 =?us-ascii?Q?QLznhlRFgxA8Yanwlh8FgCEdw1JWB5Rk3Tdwey+XFdJ12AU80bdKXOsvqSP+?=
 =?us-ascii?Q?a0jXvqZ71+t779GUyOIFt5ONmyUB+5hDKPlugFNvS+6Ah+HxICAKx82+1neb?=
 =?us-ascii?Q?vgdxnvO7Ob5ufHb1e9o1sNiWEK4v4n/uelf7lsegiLTVzZuu8Q/LM2o4fFuU?=
 =?us-ascii?Q?pNK7BL5sihDFcEcYL892iCMq3B+htMval8vzRRWq/bH0R1flfUg+6C25N1Ea?=
 =?us-ascii?Q?likhkvAokRsWoY1SC98b6QM8JcyUgJsukL6M+wrVkc/XFr/dIAUSAZsZIHs5?=
 =?us-ascii?Q?8axCKg96wSV50fXFYfFHQcn37n6do2Es4hMVNNEQukTXICKCgOt6MQr0mdPc?=
 =?us-ascii?Q?EJ5qFxclyQXXgwfD/EXxr7JBcNo7e6pseTEri8dT+pNoxiRkEteFaFiNHtKp?=
 =?us-ascii?Q?tIucBNoi4swtsHVo4e87NklmDHQL5sCdMmDHz0UXxpdw7O6i2p0d0Dx+GKG2?=
 =?us-ascii?Q?Ou7rYyci1Qyz9i7d6t2a8fQlXfTkfnqHImUTliHqQvv1dw+JIWcDFpdEbDKR?=
 =?us-ascii?Q?z1viWetlJqpkGeRnbzaclno0gGAfy16saonu9TZqPR+bLrwx+d2AUjfWj57U?=
 =?us-ascii?Q?/dYaQ7GAbifvAig6eXcGXg0SeJ9jlpoiQj2fwktI?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 923fca3b-dc9a-40fe-f251-08dbf01c4074
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:13:53.5641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urrGKw9NWNGDj6K1se3Td1oDV4f2+cFXXxAR7Wz97ORR1HS7wXDsAppBKtZ5S9sbBWVO7fXe3pn0L/6tvbPjKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9952

Similar to MPTCP_INC_STATS() helper, this patch adds a new helper named
MPTCP_DEC_STATS() to decrement a MIB counter.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/mib.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index cae71d947252..9b7c366675ec 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -95,4 +95,11 @@ static inline void __MPTCP_INC_STATS(struct net *net,
 		__SNMP_INC_STATS(net->mib.mptcp_statistics, field);
 }
 
+static inline void MPTCP_DEC_STATS(struct net *net,
+				   enum linux_mptcp_mib_field field)
+{
+	if (likely(net->mib.mptcp_statistics))
+		SNMP_DEC_STATS(net->mib.mptcp_statistics, field);
+}
+
 bool mptcp_mib_alloc(struct net *net);
-- 
2.35.3

