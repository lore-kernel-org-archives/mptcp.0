Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2046.outbound.protection.outlook.com [40.107.103.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C8A10F9
	for <mptcp@lists.linux.dev>; Wed, 26 Oct 2022 10:45:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRE/LT3MPotfZw7cmk26hakFRyDDEYtDmapzS8hNB88P+QwI/e71roU6KirFZaIoiPKhfaqcFFGMCzdaFMskn/pV04U6TqGBTzaMUw+qWa5A4zeVWGh8qgSQRHXX+gCXbanYKUpOmEN5bi4inwf+vWKL9N9xAC7jqb8Nq3qqTJrflt47LjJnO7LnKWoUwvi9vk1widSPq7azWVWfAJ86kmiSEmaDPpxUWhk0LqJbtFnbM7n8RaXek6/OF8/kY5ljabsUat+UtwtxZp9PGkuyAJFVYcqdLCJkdUb9odKceU+IyfE9w66+tqhbPpZKAwkeZggOGovEXFkGAqjJcPjBRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDlidw9lYJRbF/P67WYFKS1RG3jK2cpirKE9cpjw3ko=;
 b=J2JjoPlTSrmoCZcfzAJv13qIhQ21zWqUz2LL/oZb+QIf5InBaOMwAB2Xh9LQaP4hmPUbnV5bI4LXr48OvA1MEv083zds+CFHTUxnOVf5/UG8B1A0axw58se5WyNt8Q4pLprCyAWgHxZrH+1dqa2HIsXSA2/5/xZtARQkgWC/VarstaiqjfLdQp1okdUq9k+9/SVC7Ki3S+7QUVQIllINi05HDMmycZ+w59yC1UyO1Z5S0BxrHh9Rq7iPE7F9S9VVgeqNXk8HLoctGlPDbzWE0J5WBqks2HwS+xJLeVWFr9ZdJuRLRs0N/cFT/mUb1fUYZTlhv5jVo7hUs0B361/dgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDlidw9lYJRbF/P67WYFKS1RG3jK2cpirKE9cpjw3ko=;
 b=snamW/vlNu7az5slFP8XahiCZcZShcQX36+uy4jmT3aQ9zyq2H8IipKvogfh3KiX1cyXsLlGbKH7gbYYcOypeF2nAtkTprRXax4abLuellEKG1KBJKAqgJwS3bvDcWvf8FqJYnjy8yfyEXA5Jzj9NcZPlXFMZRGzPGGIwCxr2Hqc/KzWM+4xheGNj3n4LefgXzJcjDo2XDZm2kZtL1lMZBmzPaHtz7TaJHcuejE9VXuLzuumU8kDQzlf3rp0HbOx8Ehp1unxnW5yxJrNN7ws1IlBT5Q4e1oHsjkLe2z7I9kba545zVNcTOCa1Yf5be7AHFut2k+zc5n4EyunyoH4rA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7338.eurprd04.prod.outlook.com (2603:10a6:102:80::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 10:45:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 10:45:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 0/2] add pm listener events
Date: Wed, 26 Oct 2022 18:45:02 +0800
Message-Id: <cover.1666780919.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0191.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e391b58-9f70-4436-eee2-08dab73f2729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+pkkElQjGmClYwFsHpGSVYn4F/+efGvkYcbP67Umyc09ghHaz0MAu02T/6+MkLDJbCLp11MwrXzgq0l/Y61+La8d7h1QKshGnB2x2CcWVnefsY+tGTJlUSsHMmotbGMNo660fCrgqamxIERncnboKRsD3ucUPK92KfTnBdEaAbXcVwHn8/lNylRTRYWL0j6pudiMW9v7lSkLBu46WUVrGFnuFs6ymBqAb/6oejaApUZgJPP1zkzE8Xvgkkasfo8CAnFMT6rVOdc8BLN90dXLExi6JThk7GyVCtiakG4/tezLfd3Pc70j/LQ/AmuEs98IBcQbbKEd8FzQxjl4pnmFCsLhtbr92TuqTWFssxctS/q6nGEEVNQAgRpR0wD1v/1Krc4JCsBkIzShwkmcQjfmUjMlCFTmiVoAAzrkMtgp2HaX9bjuBjOz+FPcyMby1JOHPjBpgwgBnQQdmQcmJES4TCaDxUi8xGzc5jpXoquTsXgBbgWBCP9gMA4Bd0rJaiTgKFaMIXECLb0Ykel0pemx1lGva5VyFp6R219LZZ7Wvf2ug2xrNYocn6zonx3W3ptt2lfR/VaFc5JXW2yByKF9JFiIFXQPy+W9FkWQWwiogqHxnEReoliiMZf/ZTg1W3s7DQDdCiH943s63WrF8LykGQayaQbU6/0s0suY6a+WO59inPI+NnCfg8aTFMmDyaJINWHGSuxBIUw8h+vcksImXDLk7rvfasjC6unigwLQ3Jg88NCb0ZwnAYWzcHFxRu9fjC5tJOcKrV5vqUF1AZaeuQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199015)(41300700001)(38100700002)(6512007)(2906002)(186003)(26005)(83380400001)(2616005)(36756003)(8936002)(4744005)(44832011)(5660300002)(478600001)(6486002)(966005)(107886003)(6666004)(86362001)(6506007)(8676002)(4326008)(66556008)(66946007)(66476007)(316002)(6916009)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5MonOuqOL1NI+/waIjkEC1h9M17+jZf2vD5woNAIgFDED9oMOIRNzeJXyW+a?=
 =?us-ascii?Q?NHC8eEWssE8impIdQ/tT5FMQiuSA1MGUD+pvu3fIzb5PVFZB+Vo06wEMcsuv?=
 =?us-ascii?Q?p8plR4FbMSJ4FccsvvYwSGXpkf2iY9ORXgm/YN9coCKR7D2Wj88svmpqq0Lz?=
 =?us-ascii?Q?26zy2NX6PpzATeTt85Thb9I4C8poIOG/vxPLegtPF7NqHHBmjfKYQCYy3+ip?=
 =?us-ascii?Q?GKF6msiLP4vtkDF9IBAL15EOSiKCKuE5R72fE5UeCeon1dpGRi6AL6CkiA3k?=
 =?us-ascii?Q?Ez5ndlCfOHf0QGJeD6me0xo/kulhfZp1LuGL2dsxAy7gYWpb2xxs/k4sS85P?=
 =?us-ascii?Q?EeYjh9F+WK4a65Wvx2ON8/Fh6CT57/kepmMcylBU4G+1bmgXBI6/xeG4kAnd?=
 =?us-ascii?Q?8meTx8koeUbjYTn2j2FG9orVDPQR5RzKMZDC/uq4grcAHJseeNRhiWbACkcU?=
 =?us-ascii?Q?8gpfigF2DRcxxTxXPIICiqVQQxcnFC5xuHF6XqsteyJs70BTfRogqTIBtzsY?=
 =?us-ascii?Q?7QiNGsEbUF1RhYE2lO0qjw5Yn7i+GW28nqbEp/1Q3HxC3WQJaweHpWLwEgvi?=
 =?us-ascii?Q?EDcHjM/Bh3GrLSM9GCgzrT9ywWuldkMtkxW3PT1ErwN6nprg5Im8AG/LKsZq?=
 =?us-ascii?Q?UNqKtA57cuICEhNG1XMPfe/fExQpUSdRSFYcPfoeRW0JVWqg4FOQboiKlyuv?=
 =?us-ascii?Q?zS559+hUH9HdoA2bklyUWw1VpPITt1Gj5JfsaN5AepjQuAY9MqMR8nOgxS3Y?=
 =?us-ascii?Q?NKFeMOtg+KkpJ8lbHz4TOX4Tml5G4X4/h1A6bMojPHTgKiAoS3ASnzS7LCAi?=
 =?us-ascii?Q?oBoieDLGgH+d7xrfMl8wJHq2EgVbaDvTYoDfk72xiBzRhY68FWm6Phkfw0Lz?=
 =?us-ascii?Q?DY8IeRhHPK8DWj4fx1oUN8brUkRPs3s42yUXF/5lvTITZkTyKCvklnQ2ZDdM?=
 =?us-ascii?Q?e1M7MfFk+40gd0rZSqX2/zaDQuRtQ6q7hapK8IrDDGsrXpapISBDBCDavHWO?=
 =?us-ascii?Q?Z3Wb9uFY8ZVzchd5p4WgMfGLoFaUYIimemr4deLvF8reGauKQt0MjBVPQWaC?=
 =?us-ascii?Q?7h8/cZqX/05+evnjqXMXpfjuCqaURY7j+ZAU8rFhcm9yBPQjAkw8zAPixnSV?=
 =?us-ascii?Q?GSAEAUYOy5afyoy+cCOwR3IyTwEMVsdD75PSkIYbYQA5JWadmledJpq3/9xM?=
 =?us-ascii?Q?NmBi33EwXOD3s2zGr/84qh4IPBlfK8Xq9Z1oMmMPBrAO9x2i0OyQ+YQSVVhT?=
 =?us-ascii?Q?UEqvtQ00c/7g9Am0mTjgvq0vd4mByGjeC1PA8/vN7epoq1hmiNuwfWyikQa5?=
 =?us-ascii?Q?Tcsc9KQukVX4Imx6C2JMenAJTyj/M1F9yR6ZWxoZLWwz9UAqttFU/nAjAaWh?=
 =?us-ascii?Q?UTA4AuOglVinxMZd/qgvEBwEj8ov7EUIpoEQ3uE9QO9qbausmlOENFDw8Fdq?=
 =?us-ascii?Q?oLbQjoS4aBXsd5jEz/wYQDyKQEM+TOXy2vwINdC8RZDEYesv5jmNMVlcpCBY?=
 =?us-ascii?Q?aPNM8zhnjn/pTihmljoTJkNPNWNUhpxp3U/gAOVtY4D+x5pTzbsH5ASw6356?=
 =?us-ascii?Q?yAYAeei3vaav+1u1stMxRE4ERy074iUWmEaYurOYChUEcypnxYnVh6YwvmSB?=
 =?us-ascii?Q?yw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e391b58-9f70-4436-eee2-08dab73f2729
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 10:45:09.5322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OztwKeSefKoSFiwQd6drls5Q1dd3apVpBO/1ZdHlj2kw3EJCfQ4mIs/sqyQjNb7TzRM7MKB4tnpDEk8HawecHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7338

v2:
- send created event from mptcp_listen.
- add a new patch, use entry->lsk directly.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/313

Geliang Tang (2):
  mptcp: use entry->lsk directly
  mptcp: add pm listener events

 include/uapi/linux/mptcp.h |  9 +++++
 net/mptcp/pm_netlink.c     | 73 +++++++++++++++++++++++++++++---------
 net/mptcp/protocol.c       |  3 ++
 net/mptcp/protocol.h       |  2 ++
 4 files changed, 71 insertions(+), 16 deletions(-)

-- 
2.35.3

