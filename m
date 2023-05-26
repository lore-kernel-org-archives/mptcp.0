Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2065.outbound.protection.outlook.com [40.107.22.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAB017C9
	for <mptcp@lists.linux.dev>; Fri, 26 May 2023 02:16:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n00WIQBfJZ9nBSwkvUp9f7SfosbOyXzTmdNdWIPIa2jwxBii8ac1zu29D2GyHi+dSlx48/ndKqegmkpk1Ye7tQiHpi424V4DmbexN/a+fM//jTwRfwAJ9ocv9WpIawjCePiNjaOSX7THcVSgM9qIg5W+Fd4QDST6GMOcQaaIAzDyReRQkVPRqxbxlw0MjXHErXzTy99c44SPi3hiuU5bgU286mnH3Di8hrfDrE56gQE55CuHUBuUEf+fFrge2dxsCmjdonfg+cX0MDeaA0uz3sMm6IBYLy03emPJ42KZKJ3pLEmYCtT1OKs8ZVZd6X2nPMIpAChqZeLuQLj2yamscA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBrglG9VeUxhCUfCS+GjLHy57BAw5uO5Vkk+O1PUAUI=;
 b=FFvXm8zEYsK/9vCeGaBi91Tr1Gri5ByaIMXhVlYyqmtk81mwmKca97BRCUDgXPrkgwBNFFTiKgurlSdbwvWFOqfy++ofxU+lxsnRZw847vdMgTviMUneype0cXCVdnutXPGXdR01rY4XqA1VnqcE4ogHPvZI2dB3ZKFgEqjvR+rOe6GxolH3uf1mNwdzFCrMAbzBB2erIO1EnK/ZsiBWQkQGRpjY7tDdb98ZNrpxn/SP/Um53S2kcSfKnyFdR/cGcBHtZ8sZWuhSMHza9x4sU7aBpaXQFmS2PR1Yz6UbIK+b35rGGQ15E5H+3+whejRhDZxzYB8Njrqhp4tQeSjSvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBrglG9VeUxhCUfCS+GjLHy57BAw5uO5Vkk+O1PUAUI=;
 b=iU0UZDRxDG9cW0ofGIoQ5h5jndDdXvq2+BgTz4iD8kCxTCOUngwggO/zGzqg3e7gnhkDoaSKqo8brpwmzmzfIMQs5roXf/Z02VnPDLfwTpYNLY1qUDvAuGJPt16CzxLWKGNYML5PwUrv/7kXuACKT+pnLtVUk1jfI6UhEUkdt9uJYWgUevVtJkCezkJsGQZY+g5vf+mFRkvYe4BBVG4jeCFoSSytO70Hz2Vc7iJT8Ne1GrN+HdvfkLs1cgq6dAckjHnlMg/WdcynmVLwjZckBtZtEWfPXqiSvur06Uxi/YR7RqfzHSBcW7pYTuCVqxfaF62vc2K7taV8VqKXVsa3ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7466.eurprd04.prod.outlook.com (2603:10a6:102:87::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Fri, 26 May
 2023 02:16:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Fri, 26 May 2023
 02:16:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 0/4] unify PM interfaces
Date: Fri, 26 May 2023 10:16:07 +0800
Message-Id: <cover.1685067241.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0249.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: eeb1434f-a75c-4522-b533-08db5d8f32f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Np5RhyZscgkGmNg2nO19D1lDX2wTrWOd3WnK1jndSuEt3G0n4Z3EBcOYDjvwSaiGRO2UZPBBxSBkkjc/d3BeFRBtaMRciUvnkaTVstiNtX+wSbRr5pM4eP/OeSiME4mxT5zu2iL9SB+DQSe37xKvSm2fZJv107nPLR+LSorSUUObh6MCr4OyO0jupg6tfTPhz1wvog1mEQve4y0MS02Rd6kIrq2PFWS0kYcJZzfXDZHH/7+KekXzYiH9Z/rjC+nzX0l/K2X/8xDFA0Ih0Iaayf/ARyRilrd/FBerzVLlUUtIya8Qb1QVjUPLpiTdbbfIDKXceBZ+QiPMNXSdLSunetgeY9YXU/ieQzDCMYVvwyi/ttdvD/qEHlv7pPKny7hxG0b5Rd8ntWn7i721W9BEBnYZxR/CmAA83rDHW6Vu6rNlvXQrdnvvLcACwl0oRjqPuc5XcGSE9ejkU0UDcW/+7M/e+YvsRPAZUDnQeZ3Ae6dBdUj5n/7KWGD93tEM5GHUPvesbb9jhJVABsXQxxzMWs837i87COrNh+RbzEzoe64/QT/w0E05zCgrVay/F7PO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199021)(2616005)(4326008)(6916009)(5660300002)(8936002)(36756003)(86362001)(4744005)(38100700002)(2906002)(83380400001)(8676002)(44832011)(316002)(41300700001)(6666004)(478600001)(6506007)(6486002)(186003)(66946007)(66476007)(66556008)(107886003)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IGtWSnsjlqrEGm5pb5KGsgBYkWqZKvz6TedotnBMPMV697lwhs811+sfga0H?=
 =?us-ascii?Q?OYz+rMjWh3pkHztWadB4RCIfMfSqO+QtKzL9c4grck6zKUcuv55+dSXpZNx9?=
 =?us-ascii?Q?czKCGxSuTyqi5w3kt63MwZrkeVZ0YF15Krow3fUkhVewbWg6saX9ZVI01Ya1?=
 =?us-ascii?Q?kSqXzQb1Cqt4iiZyYeTKIU9Pzmj1VOuRc/DkLAD4k1XmYbJ7/iAf8eZ9xQw5?=
 =?us-ascii?Q?BvQf8GYn2t1cbWjvWotb/oqexjoR9UGY5R3+Vi7t66XCbOM2rtvR86a/hqYr?=
 =?us-ascii?Q?saU3tmX/593ikWNT7kKdz0nUpIEi3+0t+uaHTheydCtdH99LB75+l4o5rQWP?=
 =?us-ascii?Q?LLqGmrNmiQkF8Z2PVNFJbRfnznq42+P1TEYNVZAjIrO+tTaURDatW/2Bvamd?=
 =?us-ascii?Q?8oyoFznKOnrNiXHBksMyrpb3bVoQG5NzC6+SN8Cp9PqGf3LlcEyXd01cx3YD?=
 =?us-ascii?Q?WiNY9+lxk4kAswmaap9LMkybKkTtbffZ4pHIUEGrEYyw4gdayibaydnk/Lpt?=
 =?us-ascii?Q?d8iLwE5eA0F01oJE/gA5lxBGKGo4OCUmN/J9Siv909fqSS/tXr2KsZ3dsVwK?=
 =?us-ascii?Q?EJferowY82Zm4RTDenIbrpmNUsWL2mGnwGUsUWT27oKFFtR6r7baX2oZjmnS?=
 =?us-ascii?Q?jxRm9dLWY4BoZQNs3FL28pbx0KZc8KmkpGG4UkT0RcQzhMdW+hkrewN0FNrj?=
 =?us-ascii?Q?7ssWB0hrZ69YW8mzg7vbdKY9TLMIQrM8vC++1EpdTYqGX6Sw7Il5toe90fXT?=
 =?us-ascii?Q?v3hOqFJkWBIe+nN5pbgEhIrs9nUIOHWn/D5qaQp4VHvTO0XtsXjDYk4FEZWq?=
 =?us-ascii?Q?FhHg2DSyKyfCOOITfyiT6083Sz+7Ys9jNVYmPbbJ6QatdKWMiFP4/B99NtN+?=
 =?us-ascii?Q?ITrteVyqtk4UoMMruxrjJhoOj/FQoSQEIPx5bueLMnsE+mfmGOB2BEUtDa8H?=
 =?us-ascii?Q?90Cg43l2d5DRoDdmZn3K5abD4q1KeQzgsWjnAtf6ZrJXv0tYIeBwIo6hAuu7?=
 =?us-ascii?Q?vFLh7H8p1sOOA38+fDmn0T9j+vPJXnUzBMTrScP6WqT1YTZxje9J/qZryRMi?=
 =?us-ascii?Q?ZAC4OxlnOJZGQzWfT5S4WL0kbozDsoiKvPtIejwqAswdkeXXtti/j/KZnbrB?=
 =?us-ascii?Q?LAJASbyDMJRwhYZtsZPajVHpcnGXzFO4cjlaEQiD5ErhRNbW9sfSoUDeZy3y?=
 =?us-ascii?Q?EGEaNJF9pEZ1DItMfM8zlLFR9JOYWhMacnXiXaLlJnBcANFIKRDzez2H519G?=
 =?us-ascii?Q?DNS6EbBIGR5UFn1Xetu4bFtyKVMpMVvBP/hlPltHjaRrUxvzGviARu0944p8?=
 =?us-ascii?Q?nik74wk1suf8DL5METj4rJefevJswLJxp2BL2YzuS+rhr3H5oNCf5ZxNqCzR?=
 =?us-ascii?Q?HN70jITEMTId29R+UUqFXXaMZc1bISGgri0EUCopqlIa92tN34/Rhm/Ia+vc?=
 =?us-ascii?Q?ZqLwuj5WY4tdO5ht0XTXlB3kzinB1xs/RhGou9KIP3W8H5n42TaXm3tX01RI?=
 =?us-ascii?Q?WGjIqMZkulmV2TFtplzfSZh41oZucqQJ8M7ed0nVSRUmVX73ZzJsxZyIrcT+?=
 =?us-ascii?Q?YHmS6qy7XNzZ1CtGet/y1UHTuR+vlhb7QQi6yDCi?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb1434f-a75c-4522-b533-08db5d8f32f5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 02:16:22.3679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33R3DsHMgQQ5vp65G1G81Az2qVhKeGwoE4SpFR+bQGKv/uxoFwOvK+1JIIzwaL5iUM9/SbkidKeeijoyLApxKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7466

v2:
 - address Matt's comments in v1.

Unify the three PM interfaces: get_local_id(),
get_flags_and_ifindex_by_id() and set_flags().

Geliang Tang (4):
  mptcp: export local_address
  mptcp: unify pm get_local_id interfaces
  mptcp: unify pm get_flags_and_ifindex_by_id
  mptcp: unify pm set_flags interfaces

 net/mptcp/pm.c           |  41 +++++++++++-
 net/mptcp/pm_netlink.c   | 132 ++++++++++++++++-----------------------
 net/mptcp/pm_userspace.c |   3 -
 net/mptcp/protocol.h     |   9 ++-
 4 files changed, 103 insertions(+), 82 deletions(-)

-- 
2.35.3

