Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2E77B
	for <mptcp@lists.linux.dev>; Fri,  1 Apr 2022 15:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648827093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CNjHOm2AEcfQ8Pja8Op5/XJYJrG0v7CsMdd6KtzIFqU=;
	b=KcEtC67nNc19UIyEEdBWeT+o3M00iRnKEp9aFWeWesPvOeR5kpbhvXlYiXJ1xXuKJAxsIu
	BtBipmDtHWoaj+LMiPmVHimynZHX549gmv0ORt6HwWLf6jIhBnRi/atXEQczYPDX/QE8c2
	1BJpSUX8IcfzNaaCHivKRBTcUtPs8iM=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2054.outbound.protection.outlook.com [104.47.13.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16-a9A0QI0BPjih5_lVYJw7gA-1; Fri, 01 Apr 2022 17:31:32 +0200
X-MC-Unique: a9A0QI0BPjih5_lVYJw7gA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcRQRlvQNTXMshsVLNtUNZTnwhC3XJvbdGKzIk4w/WG85JrGVsIOS7v/w9gb5HegSwxf6LPOib7eFkYQzAwRKWeUL8tsiXAYMqQlLR6zB9pK3ePcXHhrKNaUOM46pRQfDoQGYO5EdLa6eSfj+BZwRXapXIaySOInPEfIkOZ9mof6FfUjBJzZIWH6FmkpJ/VxA1J0TGXwdQnlErtIEBX8kx0g5JCgvD00wmYxsO2n+LM96reyNabl3iyOalnSFBk5xkuGNSFSKEuaLkuqbEGqO2RAPrcCeUuzzxzXGGedwYAE5yvlM1wtEpI8tCe/hHFxNiJT2TbNpJsJvfzYFlgKqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDUVHZusDRth4Jd0v1SP7slIaeoCT97bNfv8gX9uNgk=;
 b=HFVLk1khFTs+I2YoVjx5HOsRkTkKj5kpgP8CLM6AlSQtJyRsCItmryrhg/moazLlKm9LBlNQ+8IiiMkDVC1ZTY+pkEO9/LLleTjyYvT603eStXaLdWlKJ2eq/xvatybTkqHJCQTpyRHeVKLFQwGGIYuy5liD+QujUP6pEkgdUgcMxckmziCVKU933sPk/1Blth+Df/7Dp59Vjy5qdDs2r8hZ8Fx2K2Zr/gw6TjSQ4Jp09bhP2KeW012QF9RW7ZOUaZrYCp8OojYvX+1q58Qp95Mov5ptgAOJZNnUIjc0djB9XdbMezSQ+7a8Ukt4pztQK37jNK9z3i6HDf+5b9SHsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3418.eurprd04.prod.outlook.com (2603:10a6:7:82::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Fri, 1 Apr
 2022 15:31:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.025; Fri, 1 Apr 2022
 15:31:31 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/2] selftests: mptcp: add MP_FAIL reset testcase
Date: Fri,  1 Apr 2022 23:31:07 +0800
Message-ID: <83cc1b00132bcd16a5dda7a7636aba252aa47b04.1648826372.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648826372.git.geliang.tang@suse.com>
References: <cover.1648826372.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0088.jpnprd01.prod.outlook.com
 (2603:1096:405:3::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70a5d56e-d6c7-4f1b-23f2-08da13f4b294
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3418:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB3418100A120A4DF74CD50A1EF8E09@HE1PR0402MB3418.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fdJGBNFxOIMD4M8xhy1MffqU3vEW/CJLASTCNjnpiBSu3VS0NhbAiXV0V1tFvc2o5xiw9di09IOvOHh8v2bCfKbHV2eeO++bChV90v9XKc21lC/uRlYv8gPoHq1woglfVnzVmaBaCl6XPmk2EtP0LQjxNmeSF1P8Tjs3JmzHNgDGWFKB4KTwKWRVVJkyr7lH5zy8UAcGgajlU6fEa9+kqukrhTOH9By0OubuGBVdIM5IQ3alJUQOy/mQHphmLR4bxeRztqRQblgDOkiQM5zrpm1URKUDrX1sGs97Z9qd82SkqSfU/MJP5ng5F8GdWTDWFiM3ogWIX/ZCemjL8EKKK1Sb0kqkymhTukPq72fobvgXtW89rH58QZI4dKuxX/Te0Bspx4bNYRUwQg1T4D42JObTxsnq/R/Z5a1CWMpsYiGn2pmzkxGUMMne6lmALmvMz01LbFqid+UL4k5/RnkWFkK4ITclwPqom8+FHz1iLRjk5yMVjjim1YGR6awLtBxMIxO1mnzufPdtPE3WtL0Nu6uWbanXap/xbEhJfqhr5TGrEB5t0mxPwmM3SUYd0D9/TlO0WstThtNfQvsPzVCZnx/XTlyO2Sd4u2OlToi1WE2eGPAYk9op1Z8chkXMactqLXvBz2kxzW0sny9Wg4UqVz/kl+XtIW8LMSV7reKWPNi9Hl6sAwwBsbCkuQWZLNyxKqtq3y3x/uj77o1EcUl1Qw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(186003)(8936002)(4326008)(107886003)(44832011)(26005)(5660300002)(508600001)(6486002)(8676002)(66946007)(66556008)(2906002)(86362001)(316002)(6916009)(83380400001)(2616005)(6506007)(38100700002)(6666004)(6512007)(66476007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RSQf4J/G9pxYSr1x3xgiDFRmbz7gXz5bQ4NPGmhq4IndDBvUHM7PUuyXxuv0?=
 =?us-ascii?Q?oD81tnivizSB36f0Ga1EifHywFJ00HhEpL1rBfACJir3bZco/dp5+kwwIfFk?=
 =?us-ascii?Q?G6MClE1+iy7B4vurXL/7Y+HELhjbm1K+VredN3PEXPCkDeseuU46sI58KMkc?=
 =?us-ascii?Q?N11vJ/39m1hLMOaWyS38ZzzmqLRQWNKfhs10Z/eaclnbFWUnCsoMFltJYPk2?=
 =?us-ascii?Q?HLBjevoWnGLGmw45w+HnQVvuMi3shAVmh8PxkpRyc7aOIYPL9BZLp9PzCeDM?=
 =?us-ascii?Q?pWVcS5fca4ws87GNVUxn/s7AvbpNyiPLPWJ78NgdXPvFVPKlchOMVBm+jLgm?=
 =?us-ascii?Q?wwwrz/YjaQiZpTJT69UILQletb/lccAumtki1pqM3Hm+M4WEW6jyyTvZTTh2?=
 =?us-ascii?Q?KKDDOTF9ANNYkrSZX/F5yJlyRWtG0kSyjj+/je/REdlai1XHMzcPOi4NKWfJ?=
 =?us-ascii?Q?KXY/MLecqeyK9QkZGRoxUuC7YNM7wHN0WUQiXxK3JnT7m0lpA4REYiE8Wksg?=
 =?us-ascii?Q?urBTaiSyZjDhIK+6z2N0JYQ51IRp5jXWPFmTJbr0nxsywcd0JdgZNsCcfAh5?=
 =?us-ascii?Q?921y8dAZkTUmEXKCTwwNwurQ/CscnUblIUL1+ib6FGv0gAvM7bkjZDkf5du9?=
 =?us-ascii?Q?t1+wGKMC/T8Ul+BaTAq3mjX7SfoL0tbHX0S99SZAXcFYBlZijFRU2fcEytf6?=
 =?us-ascii?Q?OnOQ2cPAMriUUCfF9XPa+Pn56UwBj+CPq529++5OgB27UpHNlexN0zYd1b3w?=
 =?us-ascii?Q?SyI25+XUnb5I4wo5Wjq0wwAhKIcadhS8XUxr7/UldscnnCkPgnNQk2fzhBWF?=
 =?us-ascii?Q?98Z9XAyGVSH4wHhwFuvzVlFxTd9IWZePICXDT7jZ3u+ksDtNuFzJLkBYNn2S?=
 =?us-ascii?Q?9jNoyOliFPlSMNTg7AzCwrw6WtApjX+URpHbGIcSOeyQkVYY4PJxhpEsoJ5B?=
 =?us-ascii?Q?AEgMSOOubo42w4oHeZ5HbMIeeqGbXrGlOGxVfzHvY1X5ypulZ6xbDhTJCpL8?=
 =?us-ascii?Q?eRYiEs0vTNEiUVuaKHFZ13K4JK7zq6/Bed1vzwuDL65GzoAY63kropP4T59P?=
 =?us-ascii?Q?QHo+TI9BWIS6rsptUfC6SNhLIuAh9m9Vi9e8+h/JiYtbH/bZvSD9VNokbe4d?=
 =?us-ascii?Q?LgBOhWLoi+UunUhmFfnqO1TO9NqMQ5GowQ0DXWV5sbltxo7RQPFwHG7UGLUz?=
 =?us-ascii?Q?vdp0fZl5vxIOtGqDip1XuQ3h2hqiKPUVnK/gxX+GPoKGSMBWmw+wEXTrzvSR?=
 =?us-ascii?Q?tHtbwc9ZSMaKJbOVmzKURNtlqFi5R6e/lnKmFRMF/jnWOdGUGfnHUbnt5jPi?=
 =?us-ascii?Q?y82nv4N2m5JubpFf9uXI9pVCXZwrIj8dz5F8NYAV51V1QMofK4L1w8n9a7gp?=
 =?us-ascii?Q?eT2w2mnPCboU39g9JRoYhgeRtXWTPmb/Ue/Al0kxds2bw56xXxMww/Hk8HNN?=
 =?us-ascii?Q?DcJlotA5zi4efT5gdHAoTjHB/1CfKTuExIIb9VQ8cFohuDNIlqRjoMZcCqq3?=
 =?us-ascii?Q?dx8ItBErcnfNTU38MmWk/BRS5bMGNU/JfaM8oaMEHjTLwOItSZdIJzbBzzqS?=
 =?us-ascii?Q?H+bY1SVVbttTND20q/g1FagJTvhlmgALRrHF+1n3GfUeB1htRW83yuhejaLu?=
 =?us-ascii?Q?3JK6BgohqBTttosxRCKITa5z/xQfeLthT9NqE/V4G8Au7lvJ7xMLkR3kiEfq?=
 =?us-ascii?Q?3oGkRSO4+kBgpx83YwQ1HWEVFUEkH3zpnz1Uz3DQn6hI5fMt+CpEo3Dw8EBY?=
 =?us-ascii?Q?YEskwj35RY7DcW3r2aRKm4WXyiii80c=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a5d56e-d6c7-4f1b-23f2-08da13f4b294
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 15:31:31.6284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uq2NFg3hs+iYpHvwJSe4nsQD0H5Ap84kuT6rZ0eoLkWObl6XtlvzzKN2CsALizkb0t68VFTw544ZUajlstDPrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3418

Add the multiple subflows test case for MP_FAIL, to test the MP_FAIL
reset case. Use the test_linkfail value to make 1024KB test files.

Invoke reset_with_fail() to use 'iptables' and 'tc action pedit' rules
to produce the bit flips to trigger the checksum failures on ns2eth2.
Add delays on ns2eth1 to make sure more data can translate on ns2eth2.

The check_invert flag is enabled in reset_with_fail(), so this test
prints out the inverted bytes, instead of the file mismatch errors.

Invoke pedit_action_pkts() to get the numbers of the packets edited
by the tc pedit actions, and print this numbers to the output.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index c7a26c40663f..14fd24459a5d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2704,6 +2704,16 @@ fail_tests()
 		chk_join_nr 0 0 0 +1 +0 1 0 1 "$(pedit_action_pkts)"
 		chk_fail_nr 1 -1 invert
 	fi
+
+	# multiple subflows
+	if reset_with_fail "MP_FAIL MP_RST" 2; then
+		tc -n $ns2 qdisc add dev ns2eth1 root netem rate 20mbit delay 1
+		pm_nl_set_limits $ns1 0 1
+		pm_nl_set_limits $ns2 0 1
+		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
+		run_tests $ns1 $ns2 10.0.1.1 1024
+		chk_join_nr 1 1 1 +1 +0 1 1 0 "$(pedit_action_pkts)"
+	fi
 }
=20
 userspace_tests()
--=20
2.34.1

