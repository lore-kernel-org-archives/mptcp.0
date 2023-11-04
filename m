Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2057.outbound.protection.outlook.com [40.107.8.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD582196
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 00:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="yyXTzIBV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XL2Hxz/fHEPgQhXYJCqLut8uE2g0iepgjUOBY+K6dVbu9iaWxN4Mf1yxrMAnZ8SIi5xW7xhF+IDP3rIMGOSD8JHti+8MBean2an6SlpeEDlG9Xq+sZrxFbA4ruQSST7p+IfjA9J6hrLshYZefkXnkpeapN0hi/FNDTVOQsk9yVFzeEHJv9RolkS/aI2DpIvaQ42z4vEMTJpyZTZrLph7TYm2vZ+CMdTQn2Ydz9oZgaRjVzMpryemGtp0qONc9bleyIGRcFn9GQbzGSUJYLh5AidkK6ffTQCdHbpSs/65Sq+gfk6cRO81h32O4r//LnTCfzGLQBO6fkKXVwbOpMzZ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98dBtoZJUDYT89k2qmcjmsITsh80SKagax3LBzUmo+U=;
 b=arlNAmqezfu4gK6nzaDr38kdpaJINOB5KmaE1RD9L2+WKmVmSmOzOroju8HbxtDc+IW8MJjYvAYisGFmR28A4RCd0tCtGUK2g71HY5aQsXSxn9ozEmEXPccwRs1yrUWO06Zu8jhIXSAfghyVKd6ryjkWL5hShlrz5059AGytWZIxQA/V3C+V0r2UF1kekJVQ5J4levuzYjieufymfegaKKi6VJrFKhR2caWH6+Iv+HWmpL0Awsu/6TQNJuuLNEOSxfrLbBvM8bo3QdPs9TGDnvNjWuuTLF+exiSYKLBQil9otkHbWs6fx2XcuIyB0gfYcGznPvdWkkE3JdY/5/VK2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98dBtoZJUDYT89k2qmcjmsITsh80SKagax3LBzUmo+U=;
 b=yyXTzIBVRvpLdU7taQ7okNInigrcyLWKxGpLGuGw2yhBjPNmiejeYkxzbjPkkkflr8EgkE45rXBq+uvbsnFh++CAzwx08QL5MSfAR5aRmOFvrE4nIlBfnyQSLT/Kco8pIIPvDGNxbYiUTahfDCaBqhZ4jEztD29BqIGIA3dEwSjAvBRFNXl/nl2TV3jJEi24Bocgj8+y4320+zLr9VQ4tXuTbcy3rFTQfsd3kpycnt4kB/gpL/AraFkrnnK2+ToiDNu6E6R071bPJ09AltyReSywh8uE8/vdhd0O0MBDoNZ/ljsZ2loEPGEZV/pBG1DUiH2fDAru8NAqE1EgnFUxeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB9174.eurprd04.prod.outlook.com (2603:10a6:20b:449::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 00:28:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 00:28:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 07/10] mptcp: dup an entry when removing it
Date: Sat,  4 Nov 2023 08:26:31 +0800
Message-Id: <2009e4ce47ed0ab5708bc3b1bfe4fed4c7670cd2.1699057401.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699057400.git.geliang.tang@suse.com>
References: <cover.1699057400.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0066.apcprd02.prod.outlook.com
 (2603:1096:4:54::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB9174:EE_
X-MS-Office365-Filtering-Correlation-Id: 50b38380-f53a-47b2-deb4-08dbdccd028d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3DnIcuuRsux+p/tHxM1PV+3iqQfLwdU96h6NuOmq/v2ay0zWxoa/O00ZN2+6z+78w0uK8W/PucmIKRD9pEoq/jX27i1YvqABh5Qzso++kmIhrsFvz8aahZFXtRux9Yvyup/EpNaWX18nGNEPg2NBBVzXEHHugR4M1utYKe+qCHipS8ooXxpvGDuUYJjskxrwuiIyxs1+AdnmX3ehqPc2eTA8fx8To3RGuyiXHRt4CajOCnOSfbGJ3v7honaeI4Ih73A9gVhT1Ln7KZEwaAtpIJ+ybXKmhN6OgBAHF0nBsXarpkufHxyE/OAcrkBJ5WiUDSr8dWiWX4GOr1vKhVF/pzl2hVuBLLLX8lKYT0QAkGH+rDitIrRJqOzCLHFeFblrAW+rtKJxTZJGDe3qeWi9G8TTcpr9IM8vQUisTVeI2dd9RDjmp9Gdla4Xkd7Rwa0WSrJeQ7ujAlpAvHi2ePRe3N1hrgGf6u3WJFQeMAhW0ClUsLo1Mx6HZZF4G1OPe/CyIfyrYdkPrGDDvJbOU+a6fq87Wc95RBiEat+u0C3AHDCzkQjPDFjpLM421lC0yggjD3aWtZz4K/c7pI1aHn4kHn+6kgxXXyUSeTX+uBnHpxQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(39860400002)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(107886003)(6506007)(26005)(2616005)(6512007)(86362001)(36756003)(38100700002)(83380400001)(8676002)(4744005)(316002)(8936002)(6916009)(478600001)(4326008)(5660300002)(2906002)(66476007)(6486002)(66556008)(66946007)(6666004)(44832011)(41300700001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AHg4+BZ0LDCigYthnh5yT6o3Mqq9qcB0WRl1r3UdjL916PfjT3kmqnWNzKPn?=
 =?us-ascii?Q?W+t0Pr1GJWXL/hs1HYb+NZBBRvnHuNCIvmf4iL2hhwy52m7LbTThivkdOAgY?=
 =?us-ascii?Q?lsKg26MPT9Km0TMqUW+LFPJHoovu8q9mKktTYwckqqRzY++/MG2JG4zMKGaV?=
 =?us-ascii?Q?r3N/9PwZrdG4PCBXI4NHrTHLR5vNHs/T76SkrlcPN7iowzjCeCqa91xscKEe?=
 =?us-ascii?Q?LSZJQp/6xHHTNSGxnAXHxTJRTR1uKTEHsNvwBqk5AaOhboMduxFAzootpZUx?=
 =?us-ascii?Q?2Q46Vo//LsztmeGAlQa57RrfEWqkI5qZmviqFm3wY37H6VYk9/86EGmtVFcI?=
 =?us-ascii?Q?Lb6XR9vYlYqBnvcQupWcHvHuEtz/a0wHE77uLfPetdLKnv6FdsmqzQ2CHKDC?=
 =?us-ascii?Q?SoFgCyDDP9LNR4N8831psQ/3uSK26nFM/7DiTpK8Ztjxd4v7P1xsdkwGRtr9?=
 =?us-ascii?Q?FWqqzWVe5mqk2UL3fCrCWE6BqxJRiMHhvMmVW3KL7dIV0c5pilyqvafS+R1C?=
 =?us-ascii?Q?i7hmawbfe7QsOMISOtcnkkFrsVKSUbsVjWdJkouHd0cI3PwN+bHX2jp/KOPF?=
 =?us-ascii?Q?ti1HN501BEh1wDBML6ybdZlqEPcqmjQqwjxAnYHUN1vbJm8L69LxWScO/cKd?=
 =?us-ascii?Q?BzRm+SqQLKj/YBobJaKo0UH3NyXIh7YzKTwu4RxTYS4Xc2JLWpYH9FhOy/of?=
 =?us-ascii?Q?E8TBT581RJZbBInNzYyI5cjak57PIFUJDSHiIy6ojoMMvdipNZgDZjpynUjj?=
 =?us-ascii?Q?P/ypNJTnaP8iBakEA0jNwjmNMmPrTcYjFVyLx97Jari3xEhQ36/y0O2yo2Ed?=
 =?us-ascii?Q?yXYJWMFk5cW9YORygt65gvtn5Pxgvspbieqhbqlg5d/E4Rb1hAy1HjeyfONW?=
 =?us-ascii?Q?BS7DptRl5jqH4A+Z6m4VKbAP3Uo8lAhZDlc+a8b8gMxiFCN3Pxgz0oInUd15?=
 =?us-ascii?Q?m2HFR8fTbQJrQlalIvEpx06x9iowjJHLxNuC+w5f9HkSEceZ2S/rlEaJFjUu?=
 =?us-ascii?Q?OpUph6sZHy2f4pPmyb0ioSULK/v7Hri/nhum1o25U5MkPPX7ACPEMqe9jZon?=
 =?us-ascii?Q?KFwDtNdgW2DvzvyQSy2qnPkKzVrHOZEAgjW9Ei2hdMFVRBd7WDV4kL9mxxf4?=
 =?us-ascii?Q?rSs9kCRmExeZ+VKt1ZDv00PHblHE92CugTux393wU5J5Z7gdjRFEczqbDBrN?=
 =?us-ascii?Q?yIqe+lSJL3OuSv6pq0eFiRuKZ8noRo4ijkvScCH8rfb0uNayr9Is+ELvnH2A?=
 =?us-ascii?Q?Bhl951fehh2uHgJ1lJesORnqdq0blxpTt+qbHx8w7h43WUIPiGi/5omrXnr/?=
 =?us-ascii?Q?S0zVqMCFs7z0nJXDOg8TuLCg1Zl1yqep7mxMIBetWe2nMmt7VwBJBtiovoh5?=
 =?us-ascii?Q?niqSsCkcEZ+h5JnrpN6MdymKXPIU/Ezm1FI2CoVwLkohDlMoKBAUPhI1GQzG?=
 =?us-ascii?Q?z0XWrSAgOzjdYclU8SaVucZRL6T7zA2k6R+pYSXsQQ6MN5eUI+qSmipj8XVi?=
 =?us-ascii?Q?RqJTXGBWluUSiJpkA1SJAXJlv47ih5XWPXAT5Q5ApnrbA7cR7WcCiFrCXCtt?=
 =?us-ascii?Q?YlZfUBRsFWZnrUehDUHLf2hX8bliH6IjDQY0Kd7+z7cCiyoI5NjTKmU7QVWe?=
 =?us-ascii?Q?ag=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b38380-f53a-47b2-deb4-08dbdccd028d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 00:28:48.1932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bb/imQTkMYIxuFNFrMMgixr4biwDnwmPsU8xTTRyxqSxIkKwpZRyou1n5Ig6hbjm9L6maB4xbr8osm4DQLZZZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9174

In some cases, the address entry does not require free. This patch dups
an entry to separate the deleted address from the free address, so that
the refcounts can be added later.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index c27cd4336fef..3ad4e6044a97 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -309,10 +309,18 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
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

