Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2052.outbound.protection.outlook.com [40.107.241.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A870F634
	for <mptcp@lists.linux.dev>; Mon, 28 Aug 2023 04:35:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7hXzNVQ44TdBGkq7VRUPy+1ERo2oWELcr/LsSci2/e8TMdqtW6b3cbkchY419vKJUsnf2iet7LQidTiFSPUZicJZkj+OxcWWsvHg5lIwrR42dvRqIzYhRubp022TSrdmddCkJz/MqpO+dyumRN6KHSYdNa12CTcNLcvmXbsBDrWO8HHbtDw+SERKdVolpSK21Vd0cqNRAwWfMo0zFziALSP+2idP13nK4oLQa5gBkIexJ/otH2FpB7pVi7Ej+szXouRQQd1It+iqwJrHPJfNJeBNAaTswyJH1vmfOCM3I4pBPJoVuQnPeZijr02hXN5xmF/8IPkMF/r1ADOOA/Bgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nY3KkLZPk+F4v7KqwlI2WItnLhXYX2VxEj0mBBuS4G0=;
 b=XtBh28ED8btxH3aIucJdjKyT5ZCPsjb1mAbUcflMfAF1SYrRuCM2FKhlLFjXrnCgtlmr2PCDrxKsLuHzZYK506FnyZ6/CBId/f3WS3POprJo3/9wHJfYPr4FnNR6NhmSrF6G8xKOkAigCzuGCqeDc/ybkvw4kQSaZy9d3PlRNNI1IByjgB0MZHA3OkFdprTSrcPx53+Ho2cOXjpXiDsBaG6UqHIm+T9qPpXyMMHoRfC4zkP1C/2QBQtTWZtdMQre3Coz4l1k09S899S46rNuiZYIeVC/7WaVV4AD/OzOqgB0tYFpdBEiRLgmCeO3Ia5t384FHydeYdzN6vVRj8iyMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nY3KkLZPk+F4v7KqwlI2WItnLhXYX2VxEj0mBBuS4G0=;
 b=2rzKD9Lkd33ycY3+OZgUDxz56AKHbuk+ybVHqDbW2gWYQ2zf8BBSMpdNDdfxhHh4rlrmv09oqcOTfii6dV8BW7+gK7hDw7cYSSIg5SZ1iWel5L70Exe6dDrQFNx85AJg8HRI2wP/xcpmznulLvUtmnW6E4D/BUgupFhnjXhYsbuUeF9ahlubdFdqj1+frTHmRrNlIIKgdtr+h8Co95pZjlKcTvHuKthaKAnPp7SzlulsMHE0CH9M+ZjQq3Ha7ac0P4e5sAp9kugG7UqeXIggzf9jPw8PGg+YvtMHg9a9PYh6Isc06LCU+YQbfGJTHWb4NTxZGbbZzqAFjhexAXWUuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9554.eurprd04.prod.outlook.com (2603:10a6:10:302::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 04:35:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 04:35:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 0/7] userspace pm remove id 0 subflow & address
Date: Mon, 28 Aug 2023 12:35:22 +0800
Message-Id: <cover.1693197152.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0136.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: e019f74c-8b7c-4841-2787-08dba7802804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kzeISmc7urPkdQbv8naKIlEXOTEq+Ng4vDEk2TeizR+rh+Srqq1nvUgHOwENop/hZOqI7WkrP/dxMxz24qa0xscnp3QZdCyblIaX90WVNklaUyX/5Hf7yj6FEcgA6C6+BaF04L6K0nci8ahKbpyNIpmrD9QvGh70b0KJQZSllPnvpxgt8BT8IQ04bwlZAIdndk+R/GX86UqKdViZERETaU0G4V5izSkC+tvmVGL+dOLl3s3+SWTsSyr2dJzkphgfZHXOrgQe83PPCqOsb/mNcEjGv39s2NZGX5CwXP5INutwwVHWwN7nAFXzDLmyC3nHRbTNtAFT/9qY5jdlPZowBKoA4J+yR+1q5JyrVLVNEwTuKw75xJrdUZ0MO32NePnJIferYU/lrLfeJOQzWWYYmz/HqZXiCO2rLe+QHoH6JM+/8EKikye7AO+DS0lx1S4JcMWQpVqNrTDS2rXiPwXEu1dAqu/8dJf58QC3h1Zvr76Ww1k17VXsKXHkRH8PBweP5W5Ec91CjKAlunFVwCUOXP0PMViesr5VX+cyQ1utRXA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39850400004)(346002)(186009)(1800799009)(451199024)(41300700001)(38100700002)(6666004)(86362001)(966005)(83380400001)(478600001)(2616005)(26005)(107886003)(6512007)(6506007)(6486002)(36756003)(2906002)(6916009)(316002)(66476007)(66556008)(66946007)(5660300002)(8676002)(8936002)(4326008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?risTZdypet0L6rqUu8OskkUo7eJNH727Hx2qh89+fbG++eHzYcYXYZaWidVs?=
 =?us-ascii?Q?stUnJhqt3O7BuPxIrQBCl5pAD45/FoZxnj9azcrbS3gl+08TtWB0wJX6taBc?=
 =?us-ascii?Q?LfUBm+hYoXNNP1laazF4fkp0vmLxCdoNwGc5cHNcEu24ZT65Dwj8WfnWf/ex?=
 =?us-ascii?Q?cSlHer32ERnVXFTpnhddtlhvEYqMdkbEBKOf45V7aDe1o2FMFWZvqku2q18S?=
 =?us-ascii?Q?m/lTcqZ5Gwnwt8ii75uO4sp7mcV8lP/NQbF82skjkI7eMPuu5Uy7FhVGZTLN?=
 =?us-ascii?Q?ppXXuhhvuBQRkTVaHWAyyZTR15TkcOy54mnQVxZjac6hUv3m6qLIzn89G9ad?=
 =?us-ascii?Q?pJ+8VeqH4fEAB9n+n/+XWJJvXxbr/nQrcbpFZH8T5XZxhK7c8RR4OrBjMduI?=
 =?us-ascii?Q?6vzTGHLFyrVnUkg+k/119hGMQl8Me9KO8+rmkuVcc/2AxTTazXUkKLQx7e6V?=
 =?us-ascii?Q?lDiwoZ+O+TVksdLEqO7Gv0hgYh6sKdEho1Xi+lNTphwqNFs+2ZB1BcAL2tKv?=
 =?us-ascii?Q?9fMzykukbcefY9AEeb2upW6jh2nnZnr39N5OmnUgezfk44fTLGg49LjemAAk?=
 =?us-ascii?Q?XuqM0X7xUTcwpWeRved27O/wQlnIUjtI3Rh6dSxnxBzUGRvDLB/hFohmLcY6?=
 =?us-ascii?Q?oSh8q+UlevI5cI112DBjaALTZiWRX0C8QWpxAQUZc1WJWlPQ247iPn2bDypI?=
 =?us-ascii?Q?OAv7o2WyBKPkg30PfZ722KU9r6/roD7luEXuNz1MK/RQIKvdO+ORmXqRdaqM?=
 =?us-ascii?Q?hNPXNbNYVDyXGnlJrwzqGiobjeIXXMtCLlBbDVLJ8w9lImCXpPbEGGTZDZXD?=
 =?us-ascii?Q?FhqqyRIBqaVT6CMRb/LaGVwuxb642MgRHp6N+bMIezZvbeyHgcVrYjoSlQSQ?=
 =?us-ascii?Q?h+DKvxeEuCM3Wlzh6eyKRsojQiWIQCkoT2TYHqYU+kvhN+Qd/C0ezlSkNplD?=
 =?us-ascii?Q?6Z2ofe8J342npTHnfpgIz6PRY2q88QYmVWGEsLD3LgFXWQxUoO2cWGRgUnj/?=
 =?us-ascii?Q?f5X9z2rtMip85XlxAIqZeJomAN3PhiG4zeAXFqV9pa/ua7ufZ316xGNrUJlS?=
 =?us-ascii?Q?Vw23L5J56uNUfFebbxgM6HJrKKtvA6YSnViGQ0qv0igA5PbbFMVPPeNYpn9k?=
 =?us-ascii?Q?n03n3wVE6csBBfN6UibNyt3Esmb0R7zo6FnMlsm/4hbS15TXiq+EOsPJNthh?=
 =?us-ascii?Q?EXxJTlIVk25hEkL2gRCR4zJ77nipU2RqNIeQQoEfgGqmrgVR1573cD9L+Qc4?=
 =?us-ascii?Q?tqjg+gwFMyBQJnyDan8wau2kvcFFTAXJT2Ng1soJ7n8qMd8QkbKdi1R6y+re?=
 =?us-ascii?Q?POA4djfBUs5QlYJUz1qjABYMxN8RQwe1UtfOE9V/A+wu3odlkXoVPvS6cl6h?=
 =?us-ascii?Q?X2BDYtrQouogRZMoTl9dmnsF4lNmByeOoHSeAlm4vbEWUP8ym2wZzVI+p0Y9?=
 =?us-ascii?Q?oUDCnI9P6LeMuOHgUm0GqjOrceRfepRUt5/NgXNSuORbLiJZVYcJcoBPUZT4?=
 =?us-ascii?Q?xaaMoKA1TL2i0i+qF5sCkng3Lq+ohxxo3PhypIpaBo0E/uHTCGA/Uysa/7zO?=
 =?us-ascii?Q?GHcVsYOgthUx4P65ZmZ1sdXvyOQsT2clmE3hUKqq?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e019f74c-8b7c-4841-2787-08dba7802804
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 04:35:07.9418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y8M+a3otdQ2CEWfwWahGc6PelSGIdPwoI4zWvO3YzI/MCUqTZN/u8lC5JcPJvIISeSjkzVQDTrYzMYMOCvSTtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9554

v7:
 - move evts_get_info into mptcp_lib.sh, update userspace_pm.sh with
   this helper too.
 - drop the last two cleanup patches, they'll be sent in another series.

v6:
 - add a new helper get_info_value, update chk_mptcp_info(),
   verify_listener_events() and pedit_action_pkts() too.
 - only patch 1, 2, 4 are changed, other patches are the same as v5.

v5:
 - update userspace_pm_add_addr/sf helpers.
 - add userspace_pm_rm_addr/sf helpers.
 - remove id 0 subflow or address will send MP_RST, add chk_rst_nr for
   them.
 - add two selftests cleanups using for-loop.

v4:
 - add evts_get_info and chk_subflows helpers.
 - split the selftests patch into three.

v3:
 - address Matt's comments in v2.

v2:
 - fix CI errors.

This patchset addresses #379 and #391, add the abilities to remove id 0
subflow and address for userspace PM. And a selftest.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/391

Geliang Tang (7):
  selftests: mptcp: add evts_get_info helper
  selftests: mptcp: update userspace pm test helpers
  selftests: mptcp: userspace pm remove id 0 subflow
  mptcp: userspace pm allow creating id 0 subflow
  selftests: mptcp: userspace pm create id 0 subflow
  mptcp: userspace pm remove id 0 address
  selftests: mptcp: userspace pm remove id 0 address

 net/mptcp/pm_userspace.c                      |  40 +++-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 204 ++++++++++++------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  20 ++
 .../selftests/net/mptcp/userspace_pm.sh       |  96 ++++-----
 4 files changed, 235 insertions(+), 125 deletions(-)

-- 
2.35.3

