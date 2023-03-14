Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2085.outbound.protection.outlook.com [40.107.7.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263CC17C6
	for <mptcp@lists.linux.dev>; Tue, 14 Mar 2023 03:00:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APpFWRvQulmuVjEQ2aLnhby78yfya3yRWCAMMNkPAH9+9+O1reBTAsh67hw5QXsxFl6BnYz7cOfEErMIJ74YTKNbxMYJB7FsJBuiPbnipAy9JXjB+l1jB7PEokFSCXizJ9Qx0WNHvqN4enqfhrQOpSe7kW16kpELJv/YaPBckaz/lu92YHUYxe4/feKEPX0esouPY6R8pssndsokkmMFFIUFdSbpBE61RZAD76NDXA4CPeqIvUuut3ctHu82ojRhjxtQvyZYcmW4pGp6gxk4Bs9Ud2JHFL30/UNXr5juH5rp/pplEhhcP2W9E9+DInp2DS2R5J2IBhEBuqQcXaiQ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfbLZTFiqOkBqcxJoKTlYnlgnvSn1rdOlgqqUK3b76w=;
 b=i59Xk6PNgwOWRlHGK16k6zUDJHxyGAeTjxPxWVpxM+FRe7bqtnAlpzvSwaFCmddhdlc02vAZBEYAnL7Zv3ZpjnpKKgGtddwIwusOad5B3io8EzTgTyfZ2KunwkzylHAtrSPwMv2MdZOZ47jkKMGLM2BXdVZKTH8YtojaLqdiIJiwSWQXGIkToyUfF+WeWckEfcckJrycW5ZdhI+ibQsX0XfLTMrpvSu2uRsj3Tniu8dxts/1MaNu2JFxOGiOoOX8uPOLl6rmxKda/KNTXnDfpZmTkEjahyLrFuxhWx9qOlFwPf0h3Q5qMDvHeu/ZMiiSr5afMRRbkT60/KRVa+dtVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfbLZTFiqOkBqcxJoKTlYnlgnvSn1rdOlgqqUK3b76w=;
 b=PXIaMeWAH6gvVw+eACkiuSY0UELCJ6To9png1n8Qo4+h7lLY3n8k713On0sSVsV/kTUrJA6g3F5+f44F5ATZFwtEoeneyb52OCQ1KUeZX1G3tG4EYxsQ1zDgSOT/giPeXdxQGetuLFzChobQe9OiNkd8TXifWs4vPTb7QC2H3/K8rZhO5lT9XMjQvJqtb2jbbL1kuRE3GcMuEeQXbPBry0WYHlvFmJtEJEImrmsJLbdssD4O249EjE3YIUavOJdN1SwS265w6YQN7IX5MGe6ZyaiS3Q+ZceP6OR7ka3UNp3mNQFOldZR7w+tBr4gx3pWr5hmkQfTjBHuAsxjBUNPDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8838.eurprd04.prod.outlook.com (2603:10a6:10:2e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 03:00:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e%4]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 03:00:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 0/7] mptcp: update userspace pm mptcp_info fields
Date: Tue, 14 Mar 2023 11:01:39 +0800
Message-Id: <cover.1678762832.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: ee897985-16a5-4558-4bdc-08db243842f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YQuiw3KiafecXCuAV+dT5UUUn7mREOVEkUOYfhqyHmA98VzAQRQNBiAIq6Z7+LCy/d8dHugcOkcxF3dqn2Du0rzLCExEGuUSYHwjCDZm4mG/WBX+2Au35NehzN8opyfT6bu185GG2/Pm29NzTm+Ox/ImGTv87t/P6moyuWBfmrRbC/6lHajOsZW6SNiL9TcCDlTqvrtqUKGMLGnONgmv9sFI5xBW0D+vSoz/QkDIBjut/93iYqPW4AKsKnbksK2uW5OoTtqZ7MDpYc2vuHEO/ElIsrOBgtRTv/elerRNErlxAgPPT/SRrAk/iPqcS2BjgdCIJeD8MURiAqn7p+65kVPEK5YOKa1j+8pxXvahYCQYOF4sWl+oKm+j9LV4EG/LzcrhxiM85+S2cVgO0nVyGe3oDAU6fnhjy4T0eXSHJIFKwZQ6dX/1pG+LJs0xwS3aP7VlEziwQz/pAyNleVZXXGGN44tl4lqDbUjzrn1WO6/AjLIN+IGHYRCPUJXVaUHGpaCEQEX9gBMyTr6H+nmGBNQyi7VmTGsnR4PjcmPuLdlMvMAyfpp0z1o+YOpJfkuT98mp7qymCAMxYQRIIJPjQSVfQrEuEHAhjXa558EvwT+OEQggBFHI26ZcCoAC13YKNvxfrFiAoWcpL+wChuJ8p0ap12RABtHPkvdP5tOfqPl1rdYJAiFxS9RECLqWwdSF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199018)(36756003)(44832011)(5660300002)(4744005)(83380400001)(186003)(478600001)(6666004)(107886003)(6506007)(6486002)(6512007)(26005)(2616005)(6916009)(4326008)(66946007)(8936002)(8676002)(66556008)(66476007)(41300700001)(316002)(86362001)(38100700002)(15650500001)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JHgjoExX0qCifrYsTIh5wZj8wZ7PGwlC7EMgNMftASG1MDh63fEce7jDANfj?=
 =?us-ascii?Q?NTPPmHJyTjNXt2YP2T/U+HC5dTIrn0TzNRwtHQ83lOHk29ZuxbzgaBnOmAt0?=
 =?us-ascii?Q?u26xH5X5zjVI53wGxW2kBikRjrPjeTqbN132yvpePM0ZSGmWiLSz0botONuW?=
 =?us-ascii?Q?uiVlKRRF/phzJoivAWJJJJYSn4yM2Xu6zUjwX0HusvAQ4j1b2EjWeoyADTjz?=
 =?us-ascii?Q?fH96advbej8QBsy2h/2j4n9/TtWA2cvTmt70c36V+AXAiueCK2nwrXgclb54?=
 =?us-ascii?Q?PW67AAE8Fh1M1a5+mucGyk6Nm6U6SN9MYErEDOxJluueB8xsUVwEXkc9+bDT?=
 =?us-ascii?Q?JvhyZq9dDKEAhlyHkup3kV5KHHjZGodi0NRGLORCPRNglHyyad9SgVi28CTJ?=
 =?us-ascii?Q?shQYbOvUFn/sF9ErE/Kaj6g59JTsKA7Tw6+i6BHuxkNamEhKyTts9I799HED?=
 =?us-ascii?Q?YK87/z/9xHOT94WrxQ0+P29u3W+wKI/d+mvc6sjtzd5GSkX1j8GsdQQeJEK5?=
 =?us-ascii?Q?AndmJ+9t8NI1Kg56FNtm/bopGXb9LN7MIjA6RS5iFb5ouAhtNX5vMCX/mJH7?=
 =?us-ascii?Q?ZvLWm0lgycPwKfnO0Xsrygqq1J8C4t9VqzrR1HoMDSampZO86XTIaXyMOQp9?=
 =?us-ascii?Q?xYuALtj6Wkj+wIF8Dt2CTgQVwfEngiq+4PhW1+R3hDQ/734jNICDeDY8bQFr?=
 =?us-ascii?Q?sAzPid4fZCGfucl70CgkExRV6c1GqBhR+ZyH1F+jOVMTCZ5ODHoPiWdOSQKB?=
 =?us-ascii?Q?3jC/zDgrgz7tJWUUTtXMVOXla7PIfPWsv4zPhM1zbUqmyEeI9iIF47HpHWrR?=
 =?us-ascii?Q?y67mlNhO9+3EwYjvhBX012tqMyK3hIpegjC5A2IhYO1aHTTfJeOE7kfqhEcD?=
 =?us-ascii?Q?D9CvRjaUyuC5sx9WrKLXaK/em/wJJZn4JUFnQpjapgShbfFfaoinT/qrS88+?=
 =?us-ascii?Q?cOXMEHQehCDy4ujl7OUha34OxsuPzX8yQTrhLzIE/IXbX6PDQOMrunGyfPHp?=
 =?us-ascii?Q?RlyI/I9wAZbCVTfCmIGH+E9rerFmAAFvJfWyJpydLA4NNJpOh3rfSX4T0Idi?=
 =?us-ascii?Q?vurrvRA0X5in58NxrXpFx8GTU2YLtVFw+FaPfZ1Hq88V3Kyl4bmv+fyzkLjQ?=
 =?us-ascii?Q?Aki5mmSqtCXzjCLSJglCwAusjc/n356HvbdJHEqUhwUiYlzgJhLZilnen0bZ?=
 =?us-ascii?Q?2Qs95vi3H2HHHM/T5kSehJhZzYzBBKwVc/jZn1kGn3II40njiLKvokUrjtc3?=
 =?us-ascii?Q?/7AueJVM7JCYDiEDFiECVRVhsNQLsdqkIVcyKBfxf5gXHz4SAW9+saEIFAsY?=
 =?us-ascii?Q?i5yJrGZhKIMpX9iqXQdCTTaPMtnyBK5fIjzNAwMqC2IRhXQftP4NFNHE69gt?=
 =?us-ascii?Q?ZO29w+ul+PSh1b6eIsfS8MNLLpNI6x/WU6dZukGn3MEgOM0xIndY7LcVFqb0?=
 =?us-ascii?Q?NIczoU/nNPE+PSD4bZI68n32t4GGQ2HZiDsZZPvES3Q8XKt460KOA1pxes6P?=
 =?us-ascii?Q?mLZJZVRAyu3y4fgJJ+8zQenF4k0Fp0Xx3bDw2PPnZRwNudtx8dreajJEbOhl?=
 =?us-ascii?Q?8/tP7egg2tiRZZAf9NcQDlCP+k3jcehGQ/dpdRci1tJtpPuJGP+UIL1Xl3O5?=
 =?us-ascii?Q?2g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee897985-16a5-4558-4bdc-08db243842f4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 03:00:26.5006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D85WoyiKeeH9kjAIw5f0U6Ofqj665Id1LlPKHKYz6HsvtcBk+nr6eI+6EMYz00DQeWUGbmg478Q4RDORs/f9Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8838

v4:
 - add more patches
 - add selftests

v3:
 - update local_addr_used and add_addr_signaled

v2:
 - hold pm locks

Geliang Tang (7):
  mptcp: don't clear userspace pm addr id
  mptcp: add addr into userspace pm list
  mptcp: close remote subflow when destroying it
  mptcp: increase userspace pm add_addr_signaled
  mptcp: update userspace pm subflows
  mptcp: make userspace_pm_append_new_local_addr static
  selftests: mptcp: check userspace mptcp_info

 net/mptcp/pm.c                                | 21 +++++++++---
 net/mptcp/pm_netlink.c                        |  2 +-
 net/mptcp/pm_userspace.c                      | 32 +++++++++++++++++--
 net/mptcp/protocol.h                          |  2 --
 .../testing/selftests/net/mptcp/mptcp_join.sh | 10 +++++-
 5 files changed, 56 insertions(+), 11 deletions(-)

-- 
2.35.3

