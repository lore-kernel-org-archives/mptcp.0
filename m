Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2082.outbound.protection.outlook.com [40.107.15.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FF718B16
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 13:57:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=losWQ04NiZocOwJAcZ5145W5/UpFue7f8pceMcfVBALi9AvAu8/k4t5McjQfltIoMPb5nZMFwLHw6ZuJ0qZA28IUnDdYTxslyvAXXIaLXLJJQ3IZhptnJ6J3POAszyXD9vFBB3CQMMBL22aaTeeoR+HNNcdJ/HjrUEye1FafERwc5gLNwNKxpCMvYGgvdS3NEiAf4EAaDMzyQyfkyywhpVoe4mT3mXr5swqOT5KHE4tQgiKaqg+Exy/6QIQKKDC3u59xke4PeL0LcP38Uoa8USmgqTRL7U1tgFIRSHI2ooeTLhMpaRYL3qS5leYNsxgjUQoT4mCLiEi7LAbENqLQlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wsrSFADbAXiwpDtU3boCyB5oH9ppyKy3c54um9Zc08=;
 b=XdbhUhIAxs0NXttm+zOMrzK10QUOtnfT8iaYrnCX8CrzFcxcjz0/oSPrsr1gsSepa8W1gludIwmIPhQRbBJlcw24CKDIiDKQ5I2TvoiDLl2uHPJOipZUx+IG2zuyZHHK4zPN6ebANb6fQW/2x+mU69tV+4kxcngeIkB88hO/9tJOjfcPYq+1XuW8UxAcdRkpMzc5owzfvbhODiL5zLLh9Xu0cqlesPgEduFTNcVuT8LeqTf9mAlfwByoTI3WpsbwQsXBlpdntWX6UKOgcjOY6IYyXcpiAQSvIU6pumVUfwRv0EJHwFFmyawJPq8PIZ/PnZeym1/VcXjD9xlsBUdoUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wsrSFADbAXiwpDtU3boCyB5oH9ppyKy3c54um9Zc08=;
 b=vuPsG+nBi0e5/IcTke2WtF1zvooGuLTY35QaiJiOy3WFULqKPJiXG2pp1oZ5ZuDTB9bRCms3c3JYPBdJP0QHFCh+VBefHYPHeRUxu54PuxqHjvY6BOH9xn89ikXJCPZ6t52vURer4lwvZiuNvY9b1s5QqE21ohVMrat+PjIRzch4CCpBRkaLpdlSevniQaLyA6bt5/kNXbdneRGEOq1fiM+2EU1Kzg8xFv3LyLUbjBv3ZdZNbYTeyovo2LXBv5i2xZsK+Gj/jCmGOKpYEe5W+bICE92KNHA0mPnjJiXRaKCjE4z90HEDWaM3/TAAY9kohnDDXHSrEmbFuOQhtQ/sfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8836.eurprd04.prod.outlook.com (2603:10a6:20b:42f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 13:57:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6387.027; Wed, 17 May 2023
 13:57:38 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 2/6] selftests/bpf: use random netns name for mptcp
Date: Wed, 17 May 2023 21:57:10 +0800
Message-Id: <7ef4a997949d40bbe4497ac6b0f7546a6e89659a.1684331602.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684331602.git.geliang.tang@suse.com>
References: <cover.1684331602.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: 141401a0-b913-4b71-7f86-08db56deaca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Wv58zKXndXYaEDxUk1seZhhw/QLVwpYN625uByaYHpXDX8tb5l6hNsNZyFxRRrqLv0tO/+eQ3EY6AH8hG5sfuYjDMFsOVodYbCprH5fxlgznLoDu3txKJb7BCCTRrPCCUcNsh/n0nwu91Wd7iz2pExvE3y8ZrV7VfFOdHOa5+DSB7UoCaqVSPwUKAvVVn54aX0HIzO35IsOb4D4EVIGXG5b7i4SGt/McA84IirgyKPyi88uF7jRJ5DIUzOGtnheXct5FlZAjIAQbtSIXCBijhNx6BggCiQHmXIVzTxnsEVTzOsjoJp/B4F/AkSIIaUwt4DcAUHRQ8T6XusvCCjpILMP+VVY/xAs6rs+5Pls+zRrbfQyKBLHCKtrUrnPtgjp1S46vlz8k9y+HL42KqdhqUBJKFe105MtWyGpstoDuryxG2qAcuYn4/8dGmKBkvdVAoOQmoRTYzWB9ZNF9LVfqKIOOaYymcinU+u7yGwhUDxmp5JlRUMQtx3EhsPILc0Rix/0S8+wIrWedsNeLhAuAk2UP3L+H5L7lBl0LT04wU9jvVIDdDVX3EUL6QjRBoGAPZaS0/5NeiOiOZ+3tTKF73CLcBS25h66kNll9Xb7uLUY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199021)(36756003)(316002)(6486002)(66946007)(6916009)(66556008)(4326008)(66476007)(86362001)(478600001)(8676002)(5660300002)(44832011)(6666004)(8936002)(2906002)(38100700002)(6512007)(6506007)(2616005)(186003)(107886003)(26005)(83380400001)(41300700001)(17423001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZAH8KFwAq49+lKHUIM/nLnCfMtPrOObEaYjrukBno1324ECF3FsvGUgCF+xX?=
 =?us-ascii?Q?KyEUU1h6q8YFnl0oZRKGXM6jm3rDkUWhQ32D5ukj7KeLW76xhGhHobZklhI/?=
 =?us-ascii?Q?xXm2XMQvhtpgyFFn6ku9olhBDSzPf1nzgyQQShoIG2TQf9YgOdD+IUn/T9CZ?=
 =?us-ascii?Q?G6E1bXfomsTHjMD/2ALcj/YBE7wnxIOv9dkGE4dDL3uSEQ/FRBBjSUafULJH?=
 =?us-ascii?Q?vwY61X439DuYQJVF/Iti2qzvqVd91b/bCgj7xaEB2ltBLc5oj6+ImxP5y9n5?=
 =?us-ascii?Q?ikMAcydU22g9tftNAZiMt03jbT67Pr5TJBnt6HgNIiWIt9KKDRD25cKenidL?=
 =?us-ascii?Q?mAv9EzEuiq7iKns5kEMAsHbKArCIcjL9ZW7bdUA7wwdmXrgTkhBagHtbqw8R?=
 =?us-ascii?Q?VGJ04tMNm261Og2ohEdp+nlUFbYXj/vGzpu7cifnoyMm2tThh61HI8rJvLl5?=
 =?us-ascii?Q?EO+oTW7mLn5XvGfmiAzYWk15Qv9wBjS05k4GBZH4VhTqBK+vlXZEowxjaxQx?=
 =?us-ascii?Q?RFQ+S+awfImJKqZWdrRA8l2jkk18Da6zY4tSmZNqmEvq+EuXzc3jk5wIAzpU?=
 =?us-ascii?Q?kbHajRIGrNv/RkeSbboYuu4+XFt/uTv9sP8VYE5dOlLCwhRT5YziUMe4ZaPF?=
 =?us-ascii?Q?27Ir37R3UJ+m/2c4fxMEBT2omImHY8Gc7TVw8QRMPuJKSp8SVSVNXqjRsK9h?=
 =?us-ascii?Q?VFnjLup0+d4dTjQCzzHwnMYzqlQ5ckAe7l//m9RYx4AmTrc0tORujNdqBmwo?=
 =?us-ascii?Q?p2ZueWuGOyYO33qpAKq0e4v9Sh5Y++KPMynW1TBHHRjGUhr1wvfiVGNEV5iZ?=
 =?us-ascii?Q?bDwSxLMEuCXFJOlnruXW25a6brdLYr0Vf+ECDIEYUn5l/mlHadREDDRSkrXQ?=
 =?us-ascii?Q?9Qs0r/i6GkQwEtTqNDQbYkWRUwKjOFXY5dnMcSBxwiyKHWFF2L99FL7Fuh+a?=
 =?us-ascii?Q?wKKk2vix90gDrUVmSiaqWqBvQT/AXpxNws2P3/P+4P6776zolfqzaP9a/sDM?=
 =?us-ascii?Q?IxwZPgOAH7ZZssec+FPeUTpkGA03akHRRT5Pe8iMC/rSy4XIIFdn+SXqYf+d?=
 =?us-ascii?Q?wYseaCP5dj7QzLJbW6oTf+1ZMZ18oWJE0NTM7h+1XkmGTOcSE+U7o6fXJ8Ec?=
 =?us-ascii?Q?eDFm3tsHTyVVocoJju/PZfgZ1TynppRqaQK0JAoXjCAN43kT2yz9pRtvzagn?=
 =?us-ascii?Q?/zaJA7FxP+SsvljLVqp+0NVkBWplHXKUroXEQKG4AR1FC3jKATeqg+Y/aGG2?=
 =?us-ascii?Q?jsuSlmCb/iXaErBeyU3Dzcnj2b2OINWQxpDh+MlghvakTRIyWX3UvR5c3K//?=
 =?us-ascii?Q?hSV//EWOsBr7ZausI4uy+we5utyaXbaEd23Sev+X9It0ntxhyKLS5r+QXu5R?=
 =?us-ascii?Q?YVmTSkk7NP8Fpn2QyMhONP/Nwz/ANq6YIyHaFkta0Au6yVlzuwct7Ya69cc+?=
 =?us-ascii?Q?oJz1G7YkyGlkBCbZ/NKTnbNXbO+CtfGbpr5fIHvto+40EiBkdI9boqCWkoMK?=
 =?us-ascii?Q?X9njKv2Mau2Qp+o9UZT7F16jSyzJ4bJ8u5bdlS6eAdnCp5xmRG7TVXNTi0VB?=
 =?us-ascii?Q?6+cKt0W3XUoVvTJ02TQJJdjB/+yFKUxecUYdK2RZ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 141401a0-b913-4b71-7f86-08db56deaca5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 13:57:38.4479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IwhWT0hTA3gz8yFfhYjrg2kwh8Gt1TFeGjCg3+wxoxxPdl1EG5YaAZpi1JEWQxKQxzsyIkibpyfxQAZpjEqmKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8836

Use rand() to generate a random netns name instead of using the fixed
name "mptcp_ns" for every test.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index d008388554de..ca348bab0afe 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -11,7 +11,7 @@
 #include "mptcp_bpf_rr.skel.h"
 #include "mptcp_bpf_red.skel.h"
 
-#define NS_TEST "mptcp_ns"
+char NS_TEST[32];
 
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -144,6 +144,8 @@ static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
 
 static struct nstoken *create_netns(void)
 {
+	srand(time(NULL));
+	snprintf(NS_TEST, sizeof(NS_TEST), "mptcp_ns_%d", rand());
 	SYS(fail, "ip netns add %s", NS_TEST);
 	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
 
-- 
2.35.3

