Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2058.outbound.protection.outlook.com [40.107.15.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728FB18B16
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 13:57:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYxMRw+BY03JOv2yYA+Te8QJq4wpAVRxlgtzZOWaCq4hwNC80CHd3bm2LqqaBcNXA3BoBrfZuwckiBhDeKfPv1FsepRnBRJWke1Xg1Zh4+GMvCeqwXm4/vWbW75oH1dnDTxYTZe1ohk+VcN8NyMCC+jYIG2q3Neog5V2HoBKcH4BS4MJt2F9omm5YhAHyA6qn7jtntN3mfJc9B+kbARncWf6o6V/BWNxKZTRiIlTaqNTDYNn9hv1oAhHeA/QpRmYu0tfbhzFwAsWBJoKbugSKfKLTKy54mkFw7Gcwmdxf8+NYaGhBJg3re5tdZdQyDU1hcqDo3Tb1d1rkgyumWMLTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TFo0ZdPtw4LsNRk3zK8ixdvVZrKZ28hrDDyPag541k=;
 b=atC8WxuI2Vh616EjexVSQuJaVc9DF/apvsttI8zDdnyzbjrnOUghxkoZsBmc3PNyZ6oHiVykX6rUYlqJlOG2FlM7EUXzr5CnEjgw9qyBB6ZLI6EuDXb0Es0ToZXsgvQhnquy2iNwIlm0hJZh4ElLIEVrQP/yoNZZt/ETDX0RWynHnggM8U19DkJw+RfkrGi8QfC2CLrh+ib3MMtbiz+R9Ef80h1dwP90XiAohQkJppyS97L3dO/h3p76tdrkCQ4wxakfRjFUne5EXW+Xcy0XDoj3P7qZhbEn+MwgYXuFBYTdBBFCaMhLg+zYUohaY5EJP/WgJ1jAur2NIHEv20XgBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TFo0ZdPtw4LsNRk3zK8ixdvVZrKZ28hrDDyPag541k=;
 b=xFGyakckzRSPIzQStSgO6sPtZZ5iOpM9wmlIJJJyk8vVvOO7arOHW8NM/r9banmWLQFVOa8+Byamj7Gycd+6olaqHh3KxeOsV3KUkdkUnwfuMLVwyP/lR2UYksYZgBHazSh0tm5oc4scC0MpBw4oK6pu45AkNk8zmbHtOn8SmndKWXet6OmDOVuEDNCBL/EeH4AHPF/Rpo0MkT6bU7pKAk5hcRaErRVuhF2B6XiVsETank0QhMvJplpmqljYVTyrdvhiQS4y85igizByU0k7/hBNQ6KrL7d/L8f4QddynVHfi21FtS4ytaV3JIP64sAMQL9zqv7HeBQo/n63L7WJgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8836.eurprd04.prod.outlook.com (2603:10a6:20b:42f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 13:57:52 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6387.027; Wed, 17 May 2023
 13:57:52 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 4/6] Squash to "selftests/bpf: Add bpf_bkup test"
Date: Wed, 17 May 2023 21:57:12 +0800
Message-Id: <369b06a0d128e4a4cb289929870a29643ab01484.1684331602.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684331602.git.geliang.tang@suse.com>
References: <cover.1684331602.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: c312045d-4185-4133-1a83-08db56deb4e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3ZuIsKCx8H0CaHhpvEkz0VpeWOKKJxZ2C6OgnlbHZK8k/pNqWXQl1GY44/8/W3S2W/k1IGkPjISJqqnpHaNQMo45NM8fIvMFhzrUmnDSGDCqsSsqe/F89pOtstMziofeWPtBIgOFRm1O8QqF9k853KIEc9qwA8MWV8akSkOisxn1qDz/xs38tiZcdqPKjMV5dm93Ycuse1sIl/+uk1dbdFPnsx69cC9+F+ckCRU2rpN/y1G4GEq0x7URnQG8Z0ggpltmlgbD/rquQs0NxmhkhPIzjupW++ygS7SpvvWWhzJRC91CxRYJ27fx4fCGN+AN9r+LK063eZChPacblAJjSXGRNuZFLevUhlVFoCpcy1tfwMvEb23EkiHquc55oqX3ejG5smLAVY2v618y1XAVK6xSAzP7iMGs4KDKXtfp0MXr4g3AHBq2zf8bA9piONdelQIzOx/eurgDvP9JQhmY5r9L05cWQ2XA8f9Y+VlYk7v8S6gVwv5DVBy/kkMDC1pH0Idq9B6pzsyYdXeOlyi0+MUcO7fitssA5Cz9FDA236QBkujxmIxcwFW2sHM6wvQ4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199021)(36756003)(316002)(6486002)(66946007)(6916009)(66556008)(4326008)(66476007)(86362001)(478600001)(8676002)(5660300002)(44832011)(6666004)(8936002)(2906002)(38100700002)(6512007)(6506007)(2616005)(186003)(107886003)(26005)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jRZ0A3+aZyqIeb9JvBEtd9mRS4jhcBhD7UAb40jUWv94TIUhyT8doiJUFZt9?=
 =?us-ascii?Q?g8tI+hNOIeELKSczUN+vp/N6nKzXAcKkpoD6ww4SaM6hzTzMmkqx9F6qvTiZ?=
 =?us-ascii?Q?pe42mk+i+ph7udfvmEfrOSREwAgVsSor1BVDqC6vaGiyDBedhCdTPSqhQlit?=
 =?us-ascii?Q?zFDA/BT1FTjMtpJ0T2liNtcIFu4/0ETXu21zs61KTVZ9g0aOUuyBCy44GfyJ?=
 =?us-ascii?Q?bhkvXMIhAmnFhr8CB7i1G0KPHRLQT/OwrW9D4XmoAtOzuHhw3yqBu31VOyXo?=
 =?us-ascii?Q?I9x5truYxt9jtFxemuEDhy1s8+pBSxiZ5HQGczr1zrfoSGIiH5tkO2x00pwu?=
 =?us-ascii?Q?sVrn6Xmo0t9Mcgpqii2t0jhCgL8QiwUTjYf8QVEIJiJNxFzIQ3e7kpNqlGsW?=
 =?us-ascii?Q?XTTrGUst+4iE2Kea2N9JkeCo7XRP153Kkq27SPynx0K4b2XUndYALkzrE2E+?=
 =?us-ascii?Q?a4C4ln3wHJfPIeam0uZwdOmUhprlCagM7frIhEzqu7liN+iFiaxgNEEqnMiZ?=
 =?us-ascii?Q?AmUWnTjx1u9c4wVmN1mevVX+5hejC7Kvqs4m2lZcinEpd03fog/hEE0E2JKT?=
 =?us-ascii?Q?XtLeHVkzS6wWBrKS9B+n0pupoCuU4o/h50sZYD+py0yjwDa9PTOmOv1yKvtw?=
 =?us-ascii?Q?XHEGQe34CPlMYXyjYCeWJkDCpBMto75iTL3GPTfwccbgZZT3tSroMELwHtRD?=
 =?us-ascii?Q?fo8auJKMp2FkCr4SZbqLSuWdx0+YDH8Ct5wBzGscdHoQplP77JOjK+98laNF?=
 =?us-ascii?Q?B3VXzOj4PzxNuJiYqjSIiUhiMqkgbRszsLkV2Kg4B3y+Irwe6N5bWnIjxjuN?=
 =?us-ascii?Q?hfD6iiwYg2wXk8eGBYZdxi2gJyN5n7XRgQ8mv+hMuFOjwKPyAXia9t5FcibO?=
 =?us-ascii?Q?H0QObSOUJHltGBK46EmZKTutn3xzGgKNGTHIILgg8ElNHTaHPiaQiiCRX4YZ?=
 =?us-ascii?Q?8RZ3MdFqGgQLyucNUxors8TxmAPzI8M/A7KXQHPdqJUNR894qq5JVV9IADqY?=
 =?us-ascii?Q?W27q4/X+5zO1qBQD6C484/0Ucd18undb6qHRSTmnp5MeDieJVKiUMIVXKOXE?=
 =?us-ascii?Q?HeIxmpEwSZ8LgYP6CN9BCHO7f1YCs9WlorhZ4cwvRp8yuyY5fHzBsM2EF54f?=
 =?us-ascii?Q?p2rRHXx7WgILCOfmVdL4Ifm3Ugh1+YGscD+SKWOg+mFO1nBl5+3jsmLxR3/3?=
 =?us-ascii?Q?xpTJR0Us9oAowR0MRIwhtzH0v6CtGhbJzSeqaSOpl9rPLYhDxAw3LE/itUnq?=
 =?us-ascii?Q?u6gI5dhaJKW5BBLemCSvWe2rIDzEF4Hr9rME2G6zl4AMKnJAn9V6ux3NNBG2?=
 =?us-ascii?Q?hmin1R7WWYTQF8BOsI5P+n2WCYNnfUcaPhK+2t1H0vUO8wmYAC+mMlYJAkjT?=
 =?us-ascii?Q?JYNqn3eyczwLSEkx4w/yzXWNxFXdQIkJw1jRDj374hEXB/aJ3Rkcdoz47n0n?=
 =?us-ascii?Q?j/CD29sxliowCvqV1oeQ9UBJTPn9wQQMPMvW/SM7qY8LBlBK9z+G991UrpDL?=
 =?us-ascii?Q?8HD8dnDJFRIGoZ/UzFhn8/jgC2EmYA63FzBCFJt9dUEeacWbTBaV0Yen8wPw?=
 =?us-ascii?Q?0ew+pfzbdlQZf5uz8rIu+FqD1oGi7ZiKNm/pErqf?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c312045d-4185-4133-1a83-08db56deb4e8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 13:57:52.2684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uY5xlkFpAIAhLN54qcUYnhA8JLDJuthvwrHqxTD6cB5yY3wEY2muUIbhIC276bSdsOoCTmc6R/shRD7I17aTGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8836

Run mptcp sched test in a dedicated netns.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 210ab5c30962..88bef3dff24e 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -351,6 +351,7 @@ static void test_first(void)
 static void test_bkup(void)
 {
 	struct mptcp_bpf_bkup *bkup_skel;
+	struct nstoken *nstoken = NULL;
 	int server_fd, client_fd;
 	struct bpf_link *link;
 
@@ -364,7 +365,9 @@ static void test_bkup(void)
 		return;
 	}
 
-	sched_init("subflow backup", "bpf_bkup");
+	nstoken = sched_init("subflow backup", "bpf_bkup");
+	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_bkup"))
+		goto fail;
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
@@ -374,7 +377,8 @@ static void test_bkup(void)
 
 	close(client_fd);
 	close(server_fd);
-	sched_cleanup();
+fail:
+	cleanup_netns(nstoken);
 	bpf_link__destroy(link);
 	mptcp_bpf_bkup__destroy(bkup_skel);
 }
-- 
2.35.3

