Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF75C7F
	for <mptcp@lists.linux.dev>; Tue, 17 May 2022 07:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652773455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CGXlku9TCoIhVOnlqJkyFT0idmTJTsys+2Qm5n7IenE=;
	b=M3Yqf6dYHe044BTmVA4K8N9GyFnKALebluw8kdyn75VISiLjhc8T6a5YxI+FplAkSIpIrQ
	RiqsfJJbIffdBCJIdQ7vATH31UenJncIRgR+kbEoQhLO+OUoZMVafuW8A5ZYnBS6G8FwAt
	4jXqmM8/Gx0dzJ95e0qLRuATxUYrZuU=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2057.outbound.protection.outlook.com [104.47.14.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-4-7STZMkCNOWqTrcukp3A81A-1; Tue, 17 May 2022 09:44:14 +0200
X-MC-Unique: 7STZMkCNOWqTrcukp3A81A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkSAzR8N8dlWUNPM8qOL+3J2+yF880otTm0UgvFUJo17boxp1Brv4Ci3Etwbf7lKh9ETNAzQn1FIp3jOSjiWVbSvUkzqGwx7AX46KTe64D+vkr/5l5dObvvJQLGjXqPPxGR76pyN999U6nC9Dhm+KykmX8krmksU9br4L043AJL7JeSNllyVGFfrQFRpAGXb2QNBovCgfdTRO/eWnJ8D+yHOpzwZuYeaQs+7ynIh/5Bp3wcVWJEgPYgBcPAxrnaJuEjEqyBEJfRgnH3hx82GoV3nDPBizGqUqU9avWTVX2UEfJSBku/F2KgZjVmQgOj8IWT0yWcpmLAbcd+QVmfq3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUEl3K/GzLx79mf6InhXNUEO3xr4etrbdQ+qmUG99Gw=;
 b=jbbwuGqKj+L1kLDi1kWa0FSVCyO9KL+XrzKpv0fmnZmeRjcjntd9MWDf6++0WRax4Xvb3OSC3/T7Wbn5DHcynMLTmXYgZJRqAhrjWikK3TFyoWC7peuUooH/+RYvJqkJUxk4Ea0tfBrXwzx9Rh8EcdbJVqwxVqhbQXACwWAs8d3y2auRHkAq3SE+DNCrUJN/Z+bJj+M3R0yPOm7ZHRmdkIsaqgp48uYktgFX61fVp4+y5tw8Zj5rqsX4jVPCbMH9bwaF/R6lW2p9WPc9sM1ZA0SLGVGvwaDt9cQjX3507uOzdmCZWMW0vAHdtjOBxAovc7YsG2shkqXHOH8cL2VqWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB2732.eurprd04.prod.outlook.com (2603:10a6:3:d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 07:44:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 07:44:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests/bpf: add bpf_first test"
Date: Tue, 17 May 2022 15:43:25 +0800
Message-ID: <4ec9eedaed38a5ae4b5bf04320ab5b6bcab8dba9.1652773325.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cc055f923d6d3014e9a0e3273e6d01c8a528bba1.1652773238.git.geliang.tang@suse.com>
References: <cc055f923d6d3014e9a0e3273e6d01c8a528bba1.1652773238.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0108.apcprd03.prod.outlook.com
 (2603:1096:203:b0::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08b32410-0087-42b0-5c4e-08da37d90984
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2732:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB27329423B692B38F60E10CB9F8CE9@HE1PR0402MB2732.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ti2E/ku9kwqYAKphFvM3eoFezCq5rvK1fmeFb1VzFGPn+QpmGWQqMAydjsEKPgfBmHwKn016Do5oNy5Z/QlGBTdPcc7df0Tt3ZN+cAx4M7XschNvU7CmdYRbz0LQyjO8mlFcuG76xkZQ1teBQezlz682LQzGJWce80j5w/65OFr+JiLF6dCPVp9FA2EsSOH8ZwlCk+tcKJok9tuRErt9PU6wsfiov9UDUnwibHvcWSNznlzYkZnFtYX3UPrhgjaEG2Y7mAaWv6hWXnQsHdMuhnzDJXJ0vjfK3/cmYUt/3Z7ZmE9GcgJHC5ROZUndxpDVoYvpe+eS+GS62MNYdbLVz0kNWKCIeE8rszi3oXg6+yrVWGaPaHzdTXTJcW2U9FkBl1XA62OBuiKIcvi6wTSFFadspfpczlKMleOck8hjpGcUpxmSf1Pjms973PEzxFRLGBumpSfVqvHisMnCMwwS7YdSEIymBkM0YHHPgQHDZVz4ANMIlOCSQl2OqxDcjxjYwO3iU1O8795NP0L8NUScYRHSE1eSAEpN93grsDYQJuRD8Cm2Bh04/Al5D+QoDQSnLf15DSe9DKQKBlPaZMrhm4BXCjX9TVd7ZttgKEEdJq2t0KUMzpJeqXPZAqCuHLudtbjIBw6zLVl+FsTJsF4CeU/ji2E94aRYrqDIyD4XevpW7G/4FtuloUizyDtQ1UL3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66556008)(66476007)(4326008)(2906002)(316002)(8676002)(44832011)(6666004)(36756003)(6486002)(4744005)(6506007)(186003)(26005)(5660300002)(38100700002)(8936002)(508600001)(6916009)(83380400001)(2616005)(86362001)(107886003)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P+dA6Yl189KZhQPSxpeuGeR1eez9zWb05PTCujuf5mKTPfOWpfAyaQRCh/ii?=
 =?us-ascii?Q?e4x37VIDzdLPedbc/AhyNBmdAQ6TUg0Vs1CRNBRKRNbeOhVcAmdIa6GCbqZV?=
 =?us-ascii?Q?rZCa7v/r9aquKNOmcHm7XMXAqmqSsxJip26Fee17Bbt3XHu6+GrXuqoGgyEb?=
 =?us-ascii?Q?zJqPcm2A9w/buoy748TgqxaLDdqVy0tuY4fVjZdvfIhK86rjyt5no6JEQ7Cn?=
 =?us-ascii?Q?l3ZnoipcXH5jqkSAIJCxaGiLutf5nId0ZdkCE9wMBtvtuizjusXYOkcL+JOu?=
 =?us-ascii?Q?t69alxe1YBMh7pZD0hPchfxYuV8Rg7NtiKIzUgypLeyoZiOtBIRnVSAkS/Mo?=
 =?us-ascii?Q?wrQvID29mpMOVDbh+AKN00lJ461E6PenVGABi6GSluVBu5QCDIyuw5W9WReQ?=
 =?us-ascii?Q?oiaRSVv4QB6tLQyRwLKGO7Ryamsi8TKEOlAujcUa4QxS4FPIt5C55R7fj4JC?=
 =?us-ascii?Q?7DtKy03O4i++HHFtJk+NAP4utPaKrBgK1vrsHWHKThRTcjiLV4omd0AGCZbh?=
 =?us-ascii?Q?E+kAQazS46pzBP2UMwA1ucmvhbcQpgXZT4Df4ZD3hp1lJxCx7DdPx3BWNK7a?=
 =?us-ascii?Q?WMFNhRhmMRr6deZrHQW+v2nxAO/B5Gka7SErlcqQg1AZADCN1uCnh6J9AJww?=
 =?us-ascii?Q?mc16vPJYT+JSzRew9IWgx0w5H3RmXOe4GxPFAONN4bd7/kq8Y1G69l0UZxWj?=
 =?us-ascii?Q?XW1SuI3WRDGxb0Zqij8mHz3inCJn9GfAq9xoCwhvIogegZDNAsPfWsETYqp1?=
 =?us-ascii?Q?Opl4AS+7C5aJELBCK1Vb6OEt0rMQ8WpDus1ITjc/DjxzVv5neRXIqb7hPQDq?=
 =?us-ascii?Q?jloHK4yJuQA7tRhCxd0BViE3Ndfa8S+HyTwh3xihfUfA4Sdi4XZRVXWqzMkb?=
 =?us-ascii?Q?SzL2xQRrp46bFHtse/cAaIOCCVi5KL70GzpoTGoGq9X/U9Z3V4IQqkYbMzGf?=
 =?us-ascii?Q?CVpkHtuW3o4A1+cE2MpKpMRH+EHQGjjH0X8kBzkgtf456iKbh0cie4ohgoUk?=
 =?us-ascii?Q?b3UGb+xst+FobNj9G/aoQ3PSHyepyjCFf/oLcYVOwsQFJjlnq52Zvye2Cg/c?=
 =?us-ascii?Q?LKnb3nmBv8X7mqavmv/6EFREWNPsbYWK5JohsZ+McLcuGSkMwUUUhBFzHB6w?=
 =?us-ascii?Q?x80JvbzL6l5R/5OUzdbhtHM4Nq64O+LrACdB8VCuGvwlXBbsU5LVE9N8N4sJ?=
 =?us-ascii?Q?DlB2fZvtqurYkptqZG03Hl9Dfg+vS5nbus9xBY7T1QU8QVXr82eMOCx/detl?=
 =?us-ascii?Q?1Z1BtXAnUzpR9+ZihkVUNpoX7RNTXNkpiXBKhQ7KRGrOgfEcIMobGB4RwZyD?=
 =?us-ascii?Q?7l6ywW4xXJon7FaGt0PXmnaDF/IKd1bBelqYcYuy3otI6w1DsiU8xDGHJ3EG?=
 =?us-ascii?Q?1M1wlZDHDJE0eq+AY/J+VpZFip2d4Z9RV63vT8vNVPRn3nOTI5Ey0syrGPzn?=
 =?us-ascii?Q?MMU3qHmyPsgtqgpcrhYMO1w3OS9/z9R/pWA5qtFs4IJlD8erXIy/OVGgCgOX?=
 =?us-ascii?Q?KePMKYjWI7mICDS4tqOOj6zcpccOpFDR0yYuAX35mDgB6cOzDEr6KD481vvf?=
 =?us-ascii?Q?in+wOzm6L58XRSxDgGM+vDPzRlmV4Bnq86chXAvaXVkjo2jfgCAc+l9cSqDl?=
 =?us-ascii?Q?v2Fymeut2RTXD+50ORLdrkXFL2vZ1iNiqLWXCZYenPMA+ITsh62cKTW+QZJr?=
 =?us-ascii?Q?lK0KGoY7Rmk8yPQWDnez8p9gatpIh2m/DJXHaE9sPsythfFJ7M/UrVBmNQ+k?=
 =?us-ascii?Q?wLmwmoapOPG9upTbjbRDU5hDpuvYwKE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b32410-0087-42b0-5c4e-08da37d90984
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 07:44:13.4852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3WVLvEQqaC9yatZyV+9Y3kDUnIm1zPC4UgHcNuuI6T6z5+gjvMxn7IvG203mKrZKMY1z2cU3g6tOKHD1FlUBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2732

Drop connect_to_mptcp_fd

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index d9e6dec32bfe..fd42e22d5e7d 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -315,7 +315,7 @@ static void test_first(void)
=20
 	system("sysctl -qw net.mptcp.scheduler=3Dbpf_first");
 	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
-	client_fd =3D connect_to_mptcp_fd(server_fd, 0);
+	client_fd =3D connect_to_fd(server_fd, 0);
=20
 	send_data(server_fd, client_fd);
=20
--=20
2.34.1

