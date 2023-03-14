Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2040.outbound.protection.outlook.com [40.107.14.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C1B2565
	for <mptcp@lists.linux.dev>; Tue, 14 Mar 2023 07:30:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Py6T7RIFiV8yZm+pnYNAwkUd1F4MysnsbTUWgyxCJdOGKBkhHhn2zff1P3EtJ/RF2B04ODPhMnZQFQIcbCkZqJJBnqqR5M+kZpQEem5kZBAvW8O+BLReWcRf6U5bOfUX7vygTZQUpmmIiQ/ghtg6Sr3eRMY44Z7Bkd3KFj29gutqoHWM1KTqh0YohvHDVQoA+rohoGQaaeg7VdjBvsOLP+sy56240lKo+qTQC0fZX2KPhpJgu2mK4L5kWLZKu0HLWsD9AZly8ZmosROtM8SUYoSdF4yDkikrsGSTB7tVPuce8xe4v8MFoKe8XoE/EZmg1vpVAJUEQ/iLh+lRIJthGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fSywRaXhuWf6kRGvl82m1IGStj6/Sbc7/5nkPYxg88=;
 b=HqTo4VNANBk1jPcaCwKEEpsK+/MhDljnikymBU7yO3jrGKsm81Z5vuaDWsbSFQ3w174cCiIafYGQ14tOIf/8TZcJmKHUh52fxgMeL1iHUOGPMHEZCTBnb5xsAdpGh1I+66nip+WBG1VTuKCdRxu3a8vz0hI3QKc+n9Ao9S0fJvEvWUI2qYZqckFwc6XCen7GTbs51gozMCgW4nu538dstV9CVNsABrZuk6ZYPf+dPo6yeph385J/lr4PH8/HBfe39G2vmE84IyE4IlqmVvFOY0xExPRRpVvlzF27+Wz9z95t7zoV7Vce/+VXn60eMaSZNNBj2DByo6r8puqZgjKZiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fSywRaXhuWf6kRGvl82m1IGStj6/Sbc7/5nkPYxg88=;
 b=sQAmOZB4F+9UDb5QpzewevLzHHegoh8OaTseSFs8EmYlBOB3S/zghnvVwzTaWX65yRsBBoThtrlf/9vuYST2aymZf2tNZSFh7z/esLpDPB2SatWs86Yr5DhY6TGX6noX2VG8aWilRKi/0wFWDa96RELuRIgCUlzNE7d5gM4W3AZFfDBHW+DUHq9k0i7vMMzuMrYp/jXG6s+6pkZ6HkiMWt5AMcpuLlA2vUikw2bQAYd5LF7NENzMQyukT79Dyx5l+jEEFAWcTTt7Zo0gJzy3FRUgNqSeNRuNJ8r9R2Bc4jGQBIDaxtTLpUj59PHjvue5qUzpqtPVtSxkn3Gb3t4fOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8759.eurprd04.prod.outlook.com (2603:10a6:10:2e2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 07:30:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e%4]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 07:30:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 0/7] mptcp: update userspace pm mptcp_info fields
Date: Tue, 14 Mar 2023 15:31:37 +0800
Message-Id: <cover.1678778977.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0107.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8759:EE_
X-MS-Office365-Filtering-Correlation-Id: 023b1ee8-7528-481b-bbf1-08db245df85d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gyEAqlfPNaFS+N53OwPdg2oFFnK3l9KBJwrEe7D5NO1i/o1GLTi490E0WbOrPq16z8AUjLcYqvgp+qCbkHMAH/omE5TLyOlXoCAvpJ6fgU4VizxSquI8CUGqjgIYLg9KOOW4C7ipdjRxu2sdwIoxPMgkc6j2gNc2juwM0t1Ev4T74EU6H33ZM2boUEdR6UWXDq+T1ctkconUJmPuX/rNF2sD+Yq4FGTN4rZ+BkqkI6ri0o7qZYnieOcMMPlHjpv/BtK96t6RvC7y9QYSriyPTaRJXL+h0xLqIaw0p6z52pqoWj6T+U9IFvFh03r3391d4adgHOOXAHPn2Q9GtGVFLkySgRMDK/lAXW+dtPibN6DXoJr/oEagNDEheDwf8Po1ZqZt8yOOZlDXQC8Auh68VtIiAqhU6Bd0RaooMYHOM/x9D1qTp2TpnGO59hV3ZY9XQXFAk8iDM/aUuyi54kDfCn+nVi0ZPy6mgIzHBd4+2+WCAAx2uEs+yDt/i4QtAW1xq++1S86zJ3A5rP0wyKkg0U5MJjOI19VTRHuqqaxTzXxxXJJS4QXLmT5LDxXJAsciX+agfC4QK/8lFF1yMZoXjNy+Jfv8H08Fy1Me5PMOAbEJGJeajSwfeI4uYVsQDMrEtbPxM8HKVLzr6q6fcpA37e04DZ7oEAk1Jsprjc1ClHXtuN4hFrM3ne9zu5VpirTV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199018)(36756003)(186003)(8936002)(2616005)(41300700001)(478600001)(26005)(5660300002)(38100700002)(15650500001)(6506007)(6512007)(86362001)(6666004)(107886003)(4744005)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(83380400001)(44832011)(2906002)(6486002)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bFz6nsAfSOBgX8GNXvAN2dHasdErM3Ex4rUyrjMSCT0M5odNnAl3qwpOCUNx?=
 =?us-ascii?Q?NyebrQCnM9qcTQUAbxzGxbTNmC+wV1HuhIoZ3mws+jHA3CVG15xgHjc+bMof?=
 =?us-ascii?Q?NLj5xBEeZhnO78+leFkBAZrzkaUcKwCCM++B+G+kW/9LcnKGYwiQ1AvMWzFC?=
 =?us-ascii?Q?esRZjLN6Q21KkTP2YymqJSYCsutlzCwREe7OaQUTijZHHq8vkZd4cU8VmrHW?=
 =?us-ascii?Q?LJfhudBTHbE+IM7/Y+lFHWLpNSaTlf9mnfWGEBb/8LfMEVizSONTPA3IlJNi?=
 =?us-ascii?Q?ioeBsNFRN4bzhJ06aAarFM/VBNTOtwmpmkCZhdLy0QoQ8wNtYl1fchrbEq7d?=
 =?us-ascii?Q?RHhCMPVky2nPXrpGvV6SWE/siUQY8QVrj8j/9KxMbRka6nFd0rL3yQZXP1DL?=
 =?us-ascii?Q?qAYF2ieksV7qYTJ8BRvv1WAQYlix1AH0mhMOexLTMcmbeCl8jbfhM9925iRy?=
 =?us-ascii?Q?mCgLnwL3i3PCZ1CI6d44lenaoJQ7cib7BfR+X0d0vcopewlLyP3RN28VUP1g?=
 =?us-ascii?Q?dEVx6yA5iFVO3+jCa1d0WaT6jQuOakPUPMLnQt5/wQVbW1dJ2SA7PPrIOr3p?=
 =?us-ascii?Q?d6xFhXV/iexvVmB9etCT1+JJB6LUGzCTkOt+pHFqvWYu7WbUUkpSYzSfeJH3?=
 =?us-ascii?Q?vw3C/zdwAxe/P9SNdcTxSYsk61HBB6jDLRgLLuQZH4n9HD1f4s2T3PxlSFLp?=
 =?us-ascii?Q?9PjW7xZ84oWW3gWa2AUuMGvMHlTyaYZcsun5601y8Cupuaq7d9gmpMBf6JOl?=
 =?us-ascii?Q?BclzDCfCLg58pX1DGff6eHLgC6r+OaZkeBQjP1BHJqbqgk/5oQmTemz6K8O0?=
 =?us-ascii?Q?OTkH6J8hez0DI50KTl0nAjBcpwBZ99+abYkI6/8fmT1ObcL9Bo/NAMeVJYTo?=
 =?us-ascii?Q?pnLfSHvvnCLtX5dJx7Nlmq+aj5KsHoqCBxe+0vwbqa39PjllgV5tHE6J/YwX?=
 =?us-ascii?Q?QPAApLcDKnFsBeNJRygwt91L7nD2EexkxQnsOxB3Ew0Poc137634QiOx9MDy?=
 =?us-ascii?Q?agjUWl9WAP2bLomA1AALQR0ZKtH+my+9HMfrVRTuaYe0WeUWZlbU7TGTHm9t?=
 =?us-ascii?Q?Hfby5Y7PjFttNqtTen44c06gWnIyKXbXbr1m3+uYH6+lk2B9Di8dgyjaM0Gr?=
 =?us-ascii?Q?s6yFcwdDVDCcb75d8A92aBp0MJKlrGxucqX9T5hBi/CwwY9wPEzO6eaOKatv?=
 =?us-ascii?Q?5OPBxjZ7tcHOdk5MwsvVI2fTGFN8RlX4WxexCyMdNKDeP7YNpSQpg4hBiYeE?=
 =?us-ascii?Q?uN2951hfnkTKgodujSdKfUyVxZa00kQ4Uf4DDRdfRaeWCoFo532197AQOBqV?=
 =?us-ascii?Q?lvcCPJkQC41HuBtwGKsmBT0O2DAyJ3xp8AbbXS0hbYXCQYBeXTUxZE6OtFOO?=
 =?us-ascii?Q?eu6JKr8bi7zBdVu37s+QR2q9osqCwvW3XRApY0vZ3KrncVYNhl7TFgKF3mqM?=
 =?us-ascii?Q?7ECtMoMZBN/KadIHYdCin33K2HjSS11mlhZnFW+6ZbSiL3oNTT/xlsaxYksP?=
 =?us-ascii?Q?CMMEmCjfUwHvDsfTpLmjEuTLsQPEuVg77TggJXIARACWHJ98EJ1z5gPuu9Ti?=
 =?us-ascii?Q?GXDNHZ+VKnb3cIhTM309GN6M6Wjifz8l4FDVMUBP0ysB5NE7hO4/gC0kLJpb?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 023b1ee8-7528-481b-bbf1-08db245df85d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 07:30:22.4414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RzJ+DJ9dONdwV/HwOPaTfjfsnpzve1kVsegJy0N3BUtB3LUWPj/gnOJZD6ikvKkEefe3H2FR4dpaXKINldA/PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8759

v5:
 - fix a memleak error reported by CI.
 - add more delay for userspace pm tests.

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
 net/mptcp/pm_userspace.c                      | 33 +++++++++++++++++--
 net/mptcp/protocol.h                          |  2 --
 .../testing/selftests/net/mptcp/mptcp_join.sh | 12 ++++++-
 5 files changed, 59 insertions(+), 11 deletions(-)

-- 
2.35.3

