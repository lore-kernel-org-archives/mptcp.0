Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2045.outbound.protection.outlook.com [40.107.241.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24672595
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 08:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eWuIxWYt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJkXeiNQn4b6OQ6olbkure/Ix82Aab5EwiMv82PN9Mj0w4GWuZ+4HfNqjJ8J87yWTpkMzxNXpZqQnWCruAcIa73GbDo7adZlqeC8HApiG11BiMwVijJA2vMUlvYe4Js1W7Xbs+wYblEFx6nBK/3xVWCzMjPu8l6FLDzJ7Kn+X8KT6YjgTJngpQqnwMGhelg4ODTlNUx5iwFPQPK9wM+Gm2G3hxWySdbatqrPLaMP9BmLaiZEQ1Bn5UqUtHnsACMUhHTRXbkWBMhesoW3Pdes743Svbz7770Kla3iBmQTPXLZYszdpNX9D/JrCtttT8crgQFgT32ZtHd7iMaqAOVwCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZwUjDAc+m5T8vrRPL9heZXbcr5c4tkQFHqtSiJX9oA=;
 b=HxQx9d33zhSttgaqFG0GjKN4wwsq+EGwZ6rdx1e6wb+ztYFHw12cztsRBsWk2e0c7FfP5BQIlpjF6YV3G3HFkZpP4dRoUlI4IH/NzlqnFwv/U4TIKiUIqXYy6vVIRMCT+o4lC00rNheO3JtQqmUW/Zq6D/H3VBuLChdPZu1lb9LBZTDUiiQ9NadUnoSJvIRfAn0FYb80+Flw+nkW1ntYypha7F7idNsM+ogs81Yaujp10kAn2cAvoJlqo5oTV7mv3lhg0c+xi0rEu181AyNMDk76x6xX7E3dkd0gLdzPqCulXi8PLPMNJPESyhX0zdgGqOHRSKFxKV+hPeR5+Dkn/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZwUjDAc+m5T8vrRPL9heZXbcr5c4tkQFHqtSiJX9oA=;
 b=eWuIxWYtpVSjvEveI8rT8hvSzH3c3FbB1+aky6oCMgSpCZTmOkjFNAwYTh8fP+rKbP/zykEoFy4PzHWj5AbWVI4EamEZJA0973TvZvII3UDsNPri/lw6xjRpnLn6VspCu4oP47SBOzMoX1MteUG5y+jurB7gqSUif28Yxl4TRFWeLyr1E7sKbzj2QrhceGJf4Vw39PLSplwA+MOLQNz6GPC4y8xgAyy1EhwSenrfIwWAPbhfhiaGo9PVSNAAAB5f6zoQum06A5kS8Lp41xD1QQhh+9RThVE/InIBe+umtKJkxoNJtCyUTRjvUThk7VhxcTb4aSngfgFnMA6y9aQ6mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB10023.eurprd04.prod.outlook.com (2603:10a6:150:118::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Tue, 7 Nov
 2023 08:16:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 08:16:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 17/20] mptcp: dup an entry when removing it
Date: Tue,  7 Nov 2023 16:14:23 +0800
Message-Id: <8118da3b99f46b5e12783018c3c2512e82bec35a.1699344621.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699344621.git.geliang.tang@suse.com>
References: <cover.1699344621.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0202.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB10023:EE_
X-MS-Office365-Filtering-Correlation-Id: a050eb23-cc5c-485f-8071-08dbdf69d2f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9DJBWg/7taXDt/fV7Rf8sk8iMOqM3fFF+ul+wEKOj2YFHT9pTkfYOukD+IKh9AUwxecYvPRciUYZCI9JAbTnREy20OKZt/F/sUDdokw9PZHE5IsnW3HY7l8dQnWXEnXe7BsbekClDJfYH5Z7RCTv6gTkqNiIKvOAn2RNYtcJk8y3+WBb4VQTcRXREM82EQ4slzKdtR9G3fXk+sB/FnfMrcbPYa9svxNw1Z+ZxYsHDMK5JmW38k1PHApi/NlwE7qFARPB7CntCF1e9XnEVcEE4wWZERtZ+reKFtbYQ6NUyNrHLB6Q/ERobvSAtX23/oujUVo3CoTyHZvNQNw274vGhfsHH6banXwJtSWhbyGmfJNWVJsFW/lAziR5OSy5PC01wi6vVKl26wBTEoxJyOJFMrXT4ZiaqobMq9IRfWLjkz4RB7RGzS4eKNT2zohQIl2wKvf4vWrmMYCTzb4r8zPX36gaXMYsBj76oFRlu7cNbS/jSh+pgNc5hEZWJ/LZpETJM/itnI3ICE956qEMAR2LDYtCOr//h+Fd0Zh69+TsxGhHX+9GUHLl5LYd9kVVMRW5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(136003)(346002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6512007)(8936002)(2616005)(107886003)(26005)(6486002)(44832011)(36756003)(8676002)(86362001)(316002)(66476007)(4326008)(2906002)(41300700001)(4744005)(6916009)(5660300002)(66946007)(66556008)(6506007)(478600001)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x03wvQqv9spHfirARnYShOp7aagNedX8v3VApD9glD0m1zKFULRK1VNqgn83?=
 =?us-ascii?Q?2Dk/hWCRiEQlbyRZ50CR8RQDo7WtqMT0RBljDJXOQZd6fktsDZFUvmy0XqA4?=
 =?us-ascii?Q?YM/9L2b2Em/FZTuXqldjD+7UdBwgVO5FMeOoHeYa/34VoN/fIW0Wk2nbRSim?=
 =?us-ascii?Q?b1DUVXXFjemu4c0wD0EffMRWTZnPxX6e3FZKtYa8a+N0+gtQElXFQG5msgS2?=
 =?us-ascii?Q?3MXw+yF2+nIwuClufeJn22+PUFnSRECmsCFlztw+kJ8je0Nyv1XrzQfiJ483?=
 =?us-ascii?Q?V7sF+R3oNNpHH/06D+gsWM0xATJbTr5teKBCaYcGM1x4BoXSZ9CYQUS6lSAG?=
 =?us-ascii?Q?VeMXUQslma1SE+7e+bW7prUiv7Pj8y6mdh6CQVGblQSh3dR2oXrJbeqyaq5M?=
 =?us-ascii?Q?cYKjlcQYPo1NqgxQwFE3y/gCgZAFFoRP+95lp2Ob8AuhxhsLpOgCliS3YtYU?=
 =?us-ascii?Q?8gkNt3emIu/fRiGSAjWitbYkqo2UPVkcff/NI0LjTuy0b+lPa+EhCfjEH8c7?=
 =?us-ascii?Q?2CJGl79sw+PZ1wYkXO/t+shOhiQOIIlbK2F51iOxcbTPk7cEoWXZQyYFqxFD?=
 =?us-ascii?Q?7fuC1PDrEjKKtG2+V8y7WrXbrcWASCnDglouiUp+Nj2/Xqjdux1RSlTF+HQf?=
 =?us-ascii?Q?YKGaP3MjPh2Gx9tOngSJkiaOcmoY8YvgzFT4KH4TRO4hakr33U49ygA9keLF?=
 =?us-ascii?Q?C8v3uLpSf3J1mBDtoI06c6ybknuRjMYOay8Ij6ENXbB99EXZBLAVo4T80FdA?=
 =?us-ascii?Q?3w0avGUHtmZSHwud7OP5dEXjGXmgByP7AmirGQXxJMU1dzatXsB4CGoMvKnl?=
 =?us-ascii?Q?+icg/gE0B6jnF+E+8eMbPY9IcIbB5hg9XLhTldcjEdKeRv/MohiwiOa8f6OU?=
 =?us-ascii?Q?dvvjaCakV/ArQ/u+4S23r+8CxsYgUgwwPKnk4bLiBnztgHwwjrdykKrGfDuN?=
 =?us-ascii?Q?xrev+aH9lDAey2D/eRTAnaeA99Hen0VY8DYc+NNmI3c3vPFqdcHxP60r9cqN?=
 =?us-ascii?Q?DEIAzkEmuOhLR8HTf7wddJGof0XDvufuQyykV6r48IK9css7o6AT8BN/FovQ?=
 =?us-ascii?Q?/hd2sY4Phk1zmFVk7k4rQR6xgCCZJujlh53DHAWMLNwVg5q5L6FI6xknyvZW?=
 =?us-ascii?Q?DaouuyefsNopEEv00yRUQw6v7mUCkFoD/d4TFcE2QKxEQ80r3QLX5Skgjn0/?=
 =?us-ascii?Q?dTG5RHmSgtBlbI5pWZAkgPH/0GBOGj7oyJEypQ1PeSnxF16xA/U5+8YKrfuI?=
 =?us-ascii?Q?Ts/6xOIPmEnHEG/mO0XMFMNgF9i+A7yRi4ryoSrtyVJVA460DLG7dXjVY5Jl?=
 =?us-ascii?Q?G7eKUMGQSQ+M7mUdB4g3il9tKpJT3mCJ8ZO7wMGIJKs+SFa5HUH6vhUblpc2?=
 =?us-ascii?Q?LFbFACEUbtIfWAn/I+NmgSlh7CmMoaRgURX5g31AdwwhEp2uzb7KiswmOORC?=
 =?us-ascii?Q?KO9xQmd1R9/3EwCP8XaCqV8UwHzrHt7r3rkj+RWuo+yYL4/AH2SQdznqozeq?=
 =?us-ascii?Q?/St8+u/Gv8dSAvyrMm7pOXCXSOZCuhbb41M2iURFHltzTN7M+gkUjIagVUUm?=
 =?us-ascii?Q?TC0KMaCApKSJgCQSqY9UNNhMh5ICSzmhK0peetJ4?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a050eb23-cc5c-485f-8071-08dbdf69d2f1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 08:16:20.8042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bpOJvzeVAbdNX4MHWKhPgKbaw8MkPiEUzDtcpKxxfVOC+WEUXVxorP2ewApXWmmmDQJnZA4pvFZgBfbmIt+66g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10023

In some cases, the address entry does not require free. This patch dups
an entry to separate the deleted address from the free address, so that
the refcounts can be added later.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 5d8130581654..7ba872813933 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -303,10 +303,18 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
-	list_move(&match->list, &free_list);
+	entry = kmemdup(match, sizeof(*match), GFP_ATOMIC);
+	if (!entry) {
+		err = -ENOMEM;
+		goto out;
+	}
+	list_add(&entry->list, &free_list);
 
 	mptcp_pm_remove_addrs(msk, &free_list);
 
+	list_del_rcu(&match->list);
+	kfree(match);
+
 	release_sock(sk);
 
 	list_for_each_entry_safe(match, entry, &free_list, list) {
-- 
2.35.3

