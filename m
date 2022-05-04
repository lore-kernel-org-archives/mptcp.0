Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B7417C9
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 00:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651625282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=upj+gBOgRuW7OXDLuW7nBUuoCyVPtm5VH8INMQQu6dI=;
	b=KwkcLIelpaqVnFpNyko3AJQiWLIklLipEU7K6ljlidJK8ApvWeVxpu1R2ci+JYjYrR5Ul7
	WVhQi2BdrTUUAjuxfhLMtLPI5gPwAaKbQxACcBDE5IYC0oMitkU+QyQf61p3FKeLiyRpqG
	i1ohzmlEKyVogj0v1HqEr4+hfnRidUA=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2051.outbound.protection.outlook.com [104.47.0.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-38-v6JQm0AROTOQkhFidSGcgQ-1; Wed, 04 May 2022 02:48:01 +0200
X-MC-Unique: v6JQm0AROTOQkhFidSGcgQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNoO/os/+hoI4aWMyD7rKjHZy6+rj5VHhzwW4JvfS4x4CfKm4OHQhCk3Er7UrAcoPWQeXf2nw7qWeLmDFhORo03c6pTcmY84Kz1w0JGkkRZfW2bZCsuIlU3t2AOig7maSZO8d6sHgpfEOH93gvKa9LdiMYYfDuRxgZZ9rVF1YI5vUBS/wgndb3b40plTPQI4I1CQ0b3KsOuSmXysb7n6Tzeh6jizZIJBQKCOEn66Ta1A+0JXbGPXtDk9SU0j+y86mo55J8lqNOAMwGpQ57ps19zVzCa5WklmM+pF6blbo+okF4bOvdmznjLpEUcBHtp9BdT4FCRBSI9j2ZELSzFDvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjGCK30b2r2UlXrmB3CdSU2JkupQv/a2EgZyYu6viqM=;
 b=MtUhBnbGoRemJXq+vrlNQa8M2lNiRAi1w+tKR8dC1mGdFtQK3bjZ+61JfLCO8yezeONtOQQ1dZJty7/e6o2xmVfLCKgSmJ7X8ITImGmB0bSBeeI+ZuDy1Pv4EBhoSqJD/Xh5rBZWpUicA11ios+1BzV7JDc9oH7aoiacTwOuFi5Vv6F3r5TEr1+o1w3h4z8r+gI2/A5BL1HaT8ch6BnYkB6VW1x4hZAXHReyg4cmmicoC6WSxt9yt1VmtFky6hZMWSrQK9h2Ns3GrLHTB2bk3cMePZjqjRs57PXUxCQS4+4CsLQGds/rh6TT6FxypO3J9/x9zzWITVWjmohkfK+ROw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8384.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 00:47:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 00:47:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: bpf: add bpf_first test"
Date: Wed,  4 May 2022 08:47:52 +0800
Message-ID: <3efc49e473d2fbb03c9577aea5959b35d29d2c9e.1651625191.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 7cfe8448-c316-4c2e-2866-08da2d67bc03
X-MS-TrafficTypeDiagnostic: AM9PR04MB8384:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB83844D35B3398B599A9353C2F8C39@AM9PR04MB8384.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nH7+d7/JotjvHo32COkU4NIClKMvSghR/dvh6mJXHtRlLkCkaVOgS/zK9ntl+gxnE0dn2cGix3qZ1/0S3OxxdUCedkjHX3O0I8vhZbd+I1yBQQQBCY40AH8RdvMQFlZk6Wz9IwUYgE1HDPmc2Boxx2HouwWMi2kiLRqg5g976CFRC7awEFNIQ6oBYL/PUpGUSfL7ajf0KlJgiSBdLiFwxyfbePjNXsjt7BoJrgNKUES5PFHMBc0C2LYO1AewHMqjY19nwIIYBb3oEno5aneMF3H1qQwnfqbK5An7XYEZmgLZLPhmzpE02O+qm6D6ytDEc0z2jnelwYnSEyuNmwGGrwIMi/Aa4mk2rzCsn5WvtJKhNfvWzHbIeSSEuF758Qf/rq18Bfen4dmV93TwcuB30KF9nZppTWxVQgSN6nZuDqwp+Vyz26rk1lCywJ9MtFhw26s091F43mt1wYICe9YkPX6ZGiUWlFx7Wg3JzIPI5qMhNGUOC8k6k8rE81n5OWQff7AcDp2+TH6sEmcNiKNKDS7StGvcIRMAvHzKEgw5uvU1fDTPO9S58+XJlNpBnWXYxgkzYO/PHPxnpQxfINjrkNnvPdS/iTAKTuiYF2TZm8dR33BrrmwCoyOgzvswp3OHJTlihLC7MPHyeUBQHFTb+x6ytzNKBIIMbszLoiq9ghDVX/4XZKyzo9jA9mHF3Dyc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(316002)(8676002)(4326008)(44832011)(4744005)(36756003)(6486002)(86362001)(66476007)(2906002)(6666004)(66556008)(66946007)(5660300002)(8936002)(508600001)(2616005)(186003)(6506007)(26005)(107886003)(83380400001)(6512007)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rsNVwVnkIVoFCE2zOWVsMEsR8fwOccH01eGNUh7IHgrFEsU8wyYR5cSGjvHc?=
 =?us-ascii?Q?20pfXntU/6i0c1L+pWzId1RTIMURUVlTIHkxUl00wBEL7M1tFJE8DHX0ihMP?=
 =?us-ascii?Q?NYTnv/fxR+raEcoXLtfBC48Gta/8YUsmWb4PrTkAZhLXKhcoCQ8PwlazQZi9?=
 =?us-ascii?Q?Woax2rK3OmhBIEHy609zg14i1SBkiDMCxuTFznE0osDURh9JxXhG6UzzF2su?=
 =?us-ascii?Q?ObuUC2Zqq+qxlZmjdg3gfkNGZSYZTNSojuI5DsD7MW9FpNWpQdDMHj3O1NUk?=
 =?us-ascii?Q?msxaPBFjGa7QN1Jhz95OFW9gyhaoiYKvnfaqL1jw0iHYgzfEkvJRB0dMPH8f?=
 =?us-ascii?Q?Nq2w4J78DFJ8J2JmRD7Pv7UAczT60yLAQVCfdErSSfKoqny3R8gKL2XclVAK?=
 =?us-ascii?Q?TCSMiHjH4oE+phshty2NVMlbv6TgW8F1BckOUOvdMrXK5zB5NeusS261aG0+?=
 =?us-ascii?Q?WkVxyTNKZTSvi0uQTwl9gSXBW2hGDMy7aQKGgUmkEtLf1PtfhwoGWAfOg5go?=
 =?us-ascii?Q?Tqs4lUcQZdhIYIvYNAfi18WCoPu9wIFDYKcJog5JaxpG5EkRi6Ha0pengXaB?=
 =?us-ascii?Q?ruCIxc794rRmB5DfDZim60oPgdPwPgeGCOWOSklIc8QBs9jGPQVLow/JnG1P?=
 =?us-ascii?Q?AoFe3AusQprnfmjzistHftO/RdKLkDA0BBCocMwui2qIpRiJHJhke6r/NJdN?=
 =?us-ascii?Q?SZuelVzXCv83VTpj7xsNAG0dnsj7YTx+eF0gH48OdsWU+g69BoJkEqcywXx9?=
 =?us-ascii?Q?gmw9sB3avJzcDpjuWMvseG6jxggmjeRD7mOhAbgXMVjRXM2FPmcOGU/a/OGv?=
 =?us-ascii?Q?gVr7oxymqBhtX9PPF1ZyJIVYxoauz1eu8D/c3654WCrY6F28W8ZUx3wtii5V?=
 =?us-ascii?Q?44wEinnOzaFy4IAU5rDaC2t8vYd7nw3T5gVzp2AV41j3H0mV/RZIilLkJZI6?=
 =?us-ascii?Q?RpSqeL/kWMYiT2oPrni6Pm+pZWa9eqGRHxo5Fpmv/MA71lQGOekDNlY5IX6t?=
 =?us-ascii?Q?w1NFWcUEBRP6ItA95Y+m3PyevU/kLLLuCk3OiLzK3ZJSUQEhWqT9Dc9+1sFy?=
 =?us-ascii?Q?EOI2YIcD8QalPCDYplX3f1IIsLt5DjxA90NMAP/jyhY5hgdRZbue+7lXou/S?=
 =?us-ascii?Q?0Y5q5ydnB8MUJPr6inEPF6qsTEvbMp3VXsfs/LaWLYhTCqxtviW/wFTWJ6NP?=
 =?us-ascii?Q?oMgds7TL66WlZSEXampAgKJmMsvd2NKySRwiU23ruwIXv5CEl6jrKrzY60CX?=
 =?us-ascii?Q?qKfyfm3fEjsNCvotgSBUXeRCD9RvaHjjFkHfEAIby2UNYD7NEgiufVpoIGaP?=
 =?us-ascii?Q?HRl81B+Hmxg0lMgIYVx/Wbh1gUWJhlXXecz3QWhkyIUD6HP20U0HvH9o3SsE?=
 =?us-ascii?Q?8JNmz5HbFLEZCWOopjn07wrHZW+E8Ed2D2Bm6orFPA47VVq7VY1ULfjPaXjp?=
 =?us-ascii?Q?86RPFlZzCw8zSm4rw1AUsDxVty5jwXSd3RylBd4wf86D9tBsydCfFFK4sSOG?=
 =?us-ascii?Q?wit0MI8r5yuS2weTONhUC8I56CO0zVSu+Su+IJBnBxpB9qgXaVVun0hOWnKj?=
 =?us-ascii?Q?Sri9X5Jo19TypgC8Q9uw1oSvlSOLr8oRXf4efsIvctPkfTcc0rlP63vTCGzu?=
 =?us-ascii?Q?P5xRn4fLGXHPZnglJD7LNUA818d0EOtP7mSIjNuNQJUaGPIF9c/xggc4yi50?=
 =?us-ascii?Q?eiCeO2jp10UuB+jH6gWQp7mR0qIuwPCLBhVNztSvRfar5NbBe4GJeiIqXQiP?=
 =?us-ascii?Q?enQENuho+NBQPHtFWbBvbeNY4qovLVE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cfe8448-c316-4c2e-2866-08da2d67bc03
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 00:47:58.8051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ykfqiP/+of3u23xMBIPJwHwKe1E/tvP0Dce2sxtO0Bd0otXyEXNahAh8sAOjcgJs32w5sG1yEf3+zSbhfLMuGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8384

Set scheduler to default after test.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 925858d63a9c..3106e013b9ca 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -371,6 +371,7 @@ static void test_first(void)
=20
 	close(client_fd);
 	close(server_fd);
+	system("sysctl -qw net.mptcp.scheduler=3Ddefault");
 	bpf_link__destroy(link);
 	mptcp_bpf_first__destroy(first_skel);
 }
--=20
2.34.1

