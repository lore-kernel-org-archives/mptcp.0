Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2050.outbound.protection.outlook.com [40.107.13.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182F17EC
	for <mptcp@lists.linux.dev>; Fri, 13 Jan 2023 08:45:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXzuk7PuVdeDTZ6mPjjyNF5p4YYwdfzy0jkyci2xx7Oot8cRQ3AWAeijeytlxzbZgiSS1T7aDC3icbhGpmwWWqTXBsHqHK0fQ2sd3zJnL+zsjjUCWLyiioVsb48RbI7bx5jMNDogjh9Emv9Y4eTc/Z8hGLcQzutubYoO8UMXi36O1kvmPYV1rseOB6MQk9XMzeKQAyCLAcGqQZtmxx9kqmoM7I4xUtDuvUzWgeNCq2mfyejSm4fkhNV3z3pNl8g/brBjv+7iSg7xfC5eERJf1micmRxP5Vj0e0fgmdgxfqzhs8KXm8L8siFXHRjtds6s7GIDEakmGtJTunPGvatMmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hv7y33FdtPucT3S1mlFhVvwR7hpMuwKyj6mVKFFi+Z4=;
 b=irMkIebiHa+UAS7EnPkxvdeDjaTlWEJiCdQ/yqv9F/ntVYC5P+jQcEz6kPlHzs96skCYFCe2nKAmffZ4MvF81cX6wFytWSZ3epck1SCPTorXSWSdMldaxw/firSkqBulxOWHWTjdjd4gSgXkQfRdHabFegCytq3jD/kvSM5zo80ENobdAQR6Ah0YUhC4vCYKfCRdn3n+RrcfpjcLKMA/tuGWzh0Q3fCuSrlC/xEOrRaXUOwaQM/V86f8B+glb1Kcrjfb9TcVzQJq7w0rf1xKA3YsbDC010qAZCAPYg3CKs9QyY/6CHmyUmdmvMaApZfef1BJXWX1G/26/CURp1Qa+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hv7y33FdtPucT3S1mlFhVvwR7hpMuwKyj6mVKFFi+Z4=;
 b=t2W7fsZsGrsuepS6vPPppTG8UxPjnrBfP4m5xU7pYNBCjWgGkMIl3mWBn/O/V177lHIMUGQV2+E0/J2D/4Qa6dVKvMgwxicImvYmlkHJ2gza9HsHwsGolD+UCRC1PfPdePl47qgN4PL3RNsaGJGzri7STsEYw/xzrqcKHL6fuD+g0KA5r5RCVDWEjT0FsU8ZCoR/FQbRoBvSS1Us1qGi5Dc2i4jtw/AY1QF618Il/SE/ZPoNwj0Dz60UR07//GutCns57XMukU1fUP336Pj15K8E1eKk2Z9OB+92J2yvsiiTF57QV0pD66ihtTl+dpBq/jn6JEGvBaAtHveISpTFXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7054.eurprd04.prod.outlook.com (2603:10a6:800:12d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 08:45:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5%6]) with mapi id 15.20.6002.013; Fri, 13 Jan 2023
 08:45:44 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2] mptcp: update userspace pm subflows info
Date: Fri, 13 Jan 2023 16:45:49 +0800
Message-Id: <d262f6beb6899f0a79acbeb1d3c8c855e95e098a.1673599496.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7054:EE_
X-MS-Office365-Filtering-Correlation-Id: 43f07fa0-529c-47c6-af32-08daf5428f30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B9su3HjReGA+inPiFsnhBRkr3a83C7xg0tN4F7xqlo0EsABGUbj8E18dtJOMVcb9IJtoxM2jvfYHRwBLhAs0hv4ReYBHDXWu0UGo4wMXgNfFxkwhpZqAuUrPOaNyrw53jtNWBVKPca2jkxVT2mSPRaFwy1mQ3Q640qqLGDEIAhPRwg/TwDhm+ulRd4xWECISjZARV2P/Br9ocObaIKkTAX0A3OU8fDLN2+x33h4/W0PX6hy4WEFouaXryPJi0lSMw6czqrVorOLZM8lAtdhvMixQLi0cdBnQZEfMNtYFRqbTnQKi/pcbmSBHD2LNkH/RwzDb1u+2i87Xyr9v25LAIu4yDuZp1AAPRdokY2cNh4/SSlDbgrHrrgGeappkW1o5Dx2kXtO4C9qnaJ8umd/VjJRyhk2uroPNKbfTbO4kJi+2L4zK3YdqfHbdoP06WgJyfHZP1zYQHF36VSenFmeNHgyBwegoHM2bmoGFIrj0B8UltmPQY6W4mrRSWut+wCBE1+zL4du65oVN0WdudXqvSOCMYSuucOxCRQ2g7jV85TFLYwf6GiCbEt2EwhDbGk/4Hq98g7Qkqd9qcGxwcGmcglVcjQ1ISl5HDCGyW7WNJvCEGvSy5UVbqWjxtQZj8P1pwAYTwVaG7tIeveBbdrbDtJIGaz/Nir6tsqw7L6y2t/0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199015)(6512007)(6486002)(966005)(186003)(26005)(66476007)(107886003)(66946007)(2616005)(316002)(66556008)(478600001)(6506007)(4326008)(6916009)(8676002)(38100700002)(8936002)(83380400001)(41300700001)(5660300002)(44832011)(86362001)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VuccQTpTwYKz8Rn/xvjB5fd8dQwJFCkgEjHXeS9hej2ztzp7QzZq/J7JVFfe?=
 =?us-ascii?Q?XiP/f2W63E929sQEV0nMI53nbE4cMuWAxEwOItkw0s/lf3vYWMF4vZGt8bnL?=
 =?us-ascii?Q?eI+s0CyziYnyTTwHHQOcg+D6UwjvpUypthIMSx8gy5Sm35ry7tQ/l/Sc9sq3?=
 =?us-ascii?Q?jHsLQJwakcwvyYLKsF4SQrtp8ZSI2F4gq6uQHOYnkBBNM/Fr3xt7w4cvNFa/?=
 =?us-ascii?Q?YhTOk2YdRmzYpyVQLRWd4ud+uUKkG9MHUAqNNu7K+DFgXB3Bs39PWj+pBrE7?=
 =?us-ascii?Q?nK9gZQ5+pOJ2pM5uxBeMbA442oU2o2PtOvHLvhXO8RQyI+IEJqKIhVTF4FlW?=
 =?us-ascii?Q?1HDsKd2ObvBSyOtsK0zieIoxze3wrJdx/18HxyDIvrCY3uOTQxQ/0tuoTY+o?=
 =?us-ascii?Q?83AjxScCpTpwrl7yn+kaKiqZJeiWHfdSFk/rH1IUGGMUk2I2O77OvehQlcsI?=
 =?us-ascii?Q?pqB3e1eHLGUzAASWSMHaPs+tkluma5GoM/5V1KLpXqP6/wq2cBErFxPr1mQ5?=
 =?us-ascii?Q?JpeU5xi0/rpIG4Wezhx0s20AYLWPkXnM9SAI5lr9JcSisN2Yat/Vkrbsx90a?=
 =?us-ascii?Q?Vm32F/GJhAHg/oXOaMU2csWu47S5yqi0+rcauWibcrkaoLUOqyFoKgfrrI9K?=
 =?us-ascii?Q?9mrU8TVunIt0UU7HUoJNz1FyboClY8RFxinBwBlhhJbV+ksqQ4UbaqVVqjib?=
 =?us-ascii?Q?k/jfLosGp0wOOeXbAL0xmGKooTbeIBQYN1M7xytfT3kobpqDzwj4eVqVaXwq?=
 =?us-ascii?Q?7ThEwzuu3e+Bxex8E//56N9zcXr0iC5qyI6MmWOC9HlMqwtDIrW0o/HfL8go?=
 =?us-ascii?Q?8WLP72taswOEziEKp1mSR4iQjaC0Q3lCTs07zQnSklZtUb3k37Eehs/4EnXV?=
 =?us-ascii?Q?/eRfBF7U8TUAfc2/SHXwsOCANQzPmLhFgWs9OrsctEB6wweSQVblTA3gADTS?=
 =?us-ascii?Q?oD+eCPr2FF4YREho6qeotpwg3OinObenpLU8XUTlUGID4P6UMhKFRWtBmCdL?=
 =?us-ascii?Q?VxvnbJqbJTOoBMRCDYRp0tm5lLjSx5+Rlxb6zAaIZjPVTD0p0oD/vE+oHp60?=
 =?us-ascii?Q?A4GuU7TZifupWx6e4B2npTo6/bbXSxBdH6I5/Ddk6WGBd0XMmU7Jz6OrtuBt?=
 =?us-ascii?Q?KkW2L4llEL6wGDF0D+lfWaD3IRaWFOwWOPIRDkrlONDKNTJE9yRWRSHPe7g7?=
 =?us-ascii?Q?P5/JJ1DegD2jBHdE3Knf3Wd2f24u2YdKtEzFRODk75UgENpwTPGFB1WJhMxj?=
 =?us-ascii?Q?iOdloFd6Hru1hIYJ1jvRQs6u9Z/iuAtKt7ol55jzaBD5pfU3mHbjXsXhFmbD?=
 =?us-ascii?Q?fxLjVke5b6S/D6AMoOJiiGQbDBH57MHA3IPUVMPLruVc0bpZuhDgsMpbQeKr?=
 =?us-ascii?Q?agm4aXhoVLWra1sj1y4KkNZSZvndoNLmpv1Deh1xfOzpaRPMYox18h4lH9I5?=
 =?us-ascii?Q?k767q0SRyjQ0e9woldOJG26X/UgrS6ddy3AP2bnFmhxjdt3m+1uWgMrYDuUr?=
 =?us-ascii?Q?Z6Ej0jMpSyivP2mJVBDfrd7swyzISPEN2hqPMOQ2p+xLn9sY5c2bWFOk3PBK?=
 =?us-ascii?Q?jUCJAD2e2G8cijnATPpZ1o7rML95/2+DnUzwmS2UUmzXVXNj1IeE396dDP4S?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f07fa0-529c-47c6-af32-08daf5428f30
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 08:45:44.8294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/rv8aDKs0C2aLI8l7xD/f8CnedOYuNJtu+hJsX086GIWtRxyMoa4yvBdx3GbrGuya0kZpizhLEEqdf0qHm3KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7054

Increase pm subflows counter when userspace pm creates a new subflow,
and decrease the counter when it closes a subflow.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/329
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
v2:
 - hold pm locks.
---
 net/mptcp/pm_userspace.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index a02d3cbf2a1b..9f7fc0b0d960 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -302,6 +302,10 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
+	spin_lock_bh(&msk->pm.lock);
+	msk->pm.subflows++;
+	spin_unlock_bh(&msk->pm.lock);
+
 	lock_sock(sk);
 
 	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
@@ -424,6 +428,9 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
 		mptcp_close_ssk(sk, ssk, subflow);
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
+		spin_lock_bh(&msk->pm.lock);
+		msk->pm.subflows--;
+		spin_unlock_bh(&msk->pm.lock);
 		err = 0;
 	} else {
 		err = -ESRCH;
-- 
2.35.3

