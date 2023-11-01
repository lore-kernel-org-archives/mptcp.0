Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28167F
	for <mptcp@lists.linux.dev>; Wed,  1 Nov 2023 04:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="23+aLkUx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTq4GTIURuN8Iv5nlz7W2l6qmhTRU6MMkKa2qEaTC/HEsaHXBTT5qFysE1gaTG3Avn3swCqjgSg5vHS8ivyCHtvCVcAf05OYR70l40KpdKbnVVd8soHRZBhStAwqf5bdvNUqM2nHTbNoxSq4mQ1HKnm3Lm4QvZgDu6Sd7o0I1JwYvBvYqQF9bAZCEcAdoWkQLlB7+fkNn35MKbQWE8wp43ubWGo8Amp6+dLz1mBbXFO5h0s4eVByqss6IUSgmy6TVvFu+a+W1b/3lCKWkjJAFHKb8fRu8pBVXDWYGHE7Iuyc5B7CJ0PhGIUodScg/spb0GI7XGOWJimz3514axOYGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Mgvz9YeA+KP6cJlIK4hGAGG2PpwHNntvTpfNDo1ASw=;
 b=FdwPWBumOZqhg/Tmsj4Fa0TNiJEf1fuk5bhGB4ei3hqUn68IEKYrPNc4sUyE0x5sHwqrLxyliDeZniWrJ+rpI/i+CTU+0+rWf8ABsDZ9jJKpeLNI8bxqxJ69f6y01iO+LWwT/Gojvsy9QFXfUYbtsKDfgTBdF/xE/iWVbO9kTLxjINzbe4uAmtwpEoyPuVZyXuR9JwnTVeYYiA7Fs4/IFgVpQ6bxo9cJGT3XVxVNnwEuPr5y4rgkOOnOiyjkxKMCamGwB88rLxvSetqEPdvsIK+qdcO6YM9IWYNdgE+VI7blABTPREETD0g7STn4xwKCsKpOz0JSiKgTr3lSavC11g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Mgvz9YeA+KP6cJlIK4hGAGG2PpwHNntvTpfNDo1ASw=;
 b=23+aLkUxwHRCUchfI5/AwjKfOOLQOFN0nQwhvw+tMxVuX9+uX9bNPGn8UhRZUPwIMGRXMGJlnWm3aEMUnENWG+76wQgtBqD3V9cuK+BkKygTISlsPnXPk3IY28lsaBIQS3QvjGchJ57dzPX0IfDf3VCJQYKfsYUrfq7O5HD3MkXgi5IXfpYnruxww6C4uT6wNO0JhPyu2XxlC4H6spWuPFZ3j0ySeiVSmkU5SiEFYR+1V6ydPyAgz48yM2Z+ZXct9rp84V1QRhYtnsbkYXZpMp8O+a9o+xF9HDsP2w0JoGLHjJVrY6UhHHXrBnMMZsdfadNsDSg+2A5mNSJtdN8mhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7070.eurprd04.prod.outlook.com (2603:10a6:800:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.18; Wed, 1 Nov
 2023 04:38:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235%6]) with mapi id 15.20.6933.011; Wed, 1 Nov 2023
 04:38:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 0/9] add refcount for address entry
Date: Wed,  1 Nov 2023 12:38:15 +0800
Message-Id: <cover.1698813419.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0118.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: c3d18971-c25c-4d8c-f49d-08dbda94602a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/OdcIf/iqh3kPkz+7D4owjGiH76ZKhVCEZlUHKlOmA2p+Fl5kRdZJbDNyi3vaSVxYhl4Dekius90/FhNpzEV+2/FrBeIApf9WWAroM9we375bvVFsne5wrhBnnpNteZnOEg3NqWTpnh15/j8SsElFauxF1Y6a8XqXtsRWuQfdF0+ffuPjurzsE6HIpJHbCuKozpx6FJFwa/Dtt1TykRUDzkiEmhXKYWbAU3IcFCbM38Kx2GCHXfKrAEtsQcurlHlCitH5aG+dRvH60FUJ5awIixNtyr8kzvx/KU8UN2sJ8tp7f5pHHU/AbJXGtvqAkjMsArK6FSX0/sn8O11fqEPJgbV0gSg18ZuVEgd3y/mX+4xKlZJj8xjvBpl8jZQ5WsFsTALziGOjS2/qJStQvbHQMZts1cI4rTgdz3jfqPAL15M2q5WK0QPHllL0NcmVm1voq40UimN+6M9Uy5UfdwXmfqAqJ7b3MkrxlgXJYt6OSW0kWNyIJ+YmDNdvxhQHH6L6a9CCH8cgsj6ZTwa6RiMPSQrUiKzNTPGwjlgjqaFYK7kQAw+VrDah/8DKB/WdR+fWVGW3OTwK2XwLVmpCOvf6bBdu+HrTQTgnyLOeYeRV9c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(366004)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(44832011)(38100700002)(66556008)(66946007)(66476007)(36756003)(2906002)(6916009)(41300700001)(316002)(8676002)(8936002)(83380400001)(4326008)(6512007)(26005)(86362001)(107886003)(5660300002)(2616005)(4744005)(6666004)(478600001)(6506007)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nhDpeD6KpyBiDrK4N0fopfOzdiqeYli47cNIeh1rOl6gh8j2V3aOZEbMUMkc?=
 =?us-ascii?Q?wcpKq2uJLzcVs9qfzrg7b+DBYG4HsN/WwQxSugJBXvn16vU84lTgw8oEr3A8?=
 =?us-ascii?Q?royqE4rSQdgK6AQ2uI0+k7qjN5/8kfIZJDKpR4nm5Guo+3EgDf2j9JIIJgGH?=
 =?us-ascii?Q?I6qKvv8jHFxaDOB4kP4fBqaUttVuQIooe052CH2aP+07Zpro+LHIRWl5Glc4?=
 =?us-ascii?Q?+knbp0/+4JfzCudfeMdz01V4gUTgw0iMrGEA0vOGTvvkmJ/iuH0Kv2Qeh2v9?=
 =?us-ascii?Q?Ig9SNCIK6DhoOHjqAniT2GWAmNr89UUQe9bCnv0fjO3YpDwRvsVinz1ntS5Q?=
 =?us-ascii?Q?mZR1VraDHLW82zDlmsgEJgBL1XDfHlwslFiwRKda306XWDs9AVCRrZECepsm?=
 =?us-ascii?Q?PHniupzgu2AnitmUAlO86nTvDNZtmo/fTpRS+yq+9fqzqJseLxPtHnOqQb0L?=
 =?us-ascii?Q?p8ZdR+h7fC/DF8U68q02YHS3aeLUMxEXEwBrvMDuh+cuHKu2LaNgcbE7d6FY?=
 =?us-ascii?Q?XZX30wGM+u0nPwLDl1wa+zFU1ri2qgCnv67rUAWmOgP/8lDjiuzPZgP9L0Nf?=
 =?us-ascii?Q?AL89DibJ2Albd4q56puEToNqHu+LjnFqV0CG4JJ2le3RraiIdE8DMsniRpNY?=
 =?us-ascii?Q?OAC07N9qGbUUxdqWY3b0i+Dx/IGmylIkG8Kfqb4N/9j+imYMmWW/qWjhIJQO?=
 =?us-ascii?Q?8CbhLIwtOO4riWOuvUenP0yUt1XfR6cxu0JL2pZHndCRtQEqnMljOdyzEgJo?=
 =?us-ascii?Q?aPeu6N6crGNAxz4dPiTgOy7zJOSRWEtweKaMqNhylUEMhlEkcIgIfQJtjn9I?=
 =?us-ascii?Q?wEx0fHfo6Fa7WORUgiKzdvoqqo6WTI8/Kfwfq2C+FvbnxCL7+dqY4okseU9i?=
 =?us-ascii?Q?sHx+2pg4XFs7d22Bwb1vkH61LPfI5m0HAnmyDuxI2SstoDdOaYqBCEyYeGQz?=
 =?us-ascii?Q?0ettXjHTpbO1PLV83w5jU3eqnsAfB9pInOWJnGB374lHXCokHSiKVinkysCr?=
 =?us-ascii?Q?VLrBKqWBROqw70vqvDNVxZ1autuUhSd/RyKeP+DwcPAy3cDJSB2+9N5eG/KQ?=
 =?us-ascii?Q?x1+8yNXIkGe0ASCbdMXRRkJN6YYyXNohVhY3G+LjZh/mPdYUgyT+ezJI5SrS?=
 =?us-ascii?Q?ro8lu8Sce5DKFmscNONrLwWQM6AdhslTXaHlvxJMwzx7AqDSCrVQUGUo4Vg/?=
 =?us-ascii?Q?xHFcIqB/Wln2WfSNiV3dlm5EjaFXFJH9tBuJjzpytySBbh0B9AAz2SiwY4uM?=
 =?us-ascii?Q?u90fygD4KLKE11+NtN5COQoaD8F7T4Ds9tGC1/kNlpY1a3Ep+SKLooHzsFGy?=
 =?us-ascii?Q?d4qebQjN1J+7xT6NYT7waHVsE44tHvErJAOdNN706Q6ODpHIExLcRUTZMkDb?=
 =?us-ascii?Q?0ZfKlEudfeiEGeq5pTe5Y3cWBugHM5AWPMmly8S3buUSEuw/IQIDNN9T1YDs?=
 =?us-ascii?Q?AsfYXsQzLQ2FO1lQ3QfPVDq9LJeCUuNTz0B25Xk6IwT08nhNv2gSXnOb4Ri8?=
 =?us-ascii?Q?lHMsXgdPqWVS6q1/iRcgw78Ta/1tyos1ukNCKbI8TAWrDQrd3k22u9eeN/TI?=
 =?us-ascii?Q?n8NUpIftkg+ufl2cEuEiPI8W3j/Bm9BMv1+bJY3l?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d18971-c25c-4d8c-f49d-08dbda94602a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 04:38:20.8951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yxlk7vjWsbLaz0aJw5HQomLEW4sSVXFWTM3jtgOgYT33tvb7d2UTThn//vtfyhpaofwiAtRaCoTWMleYyINqlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7070

Add refcount for address entry.

Geliang Tang (9):
  selftests: mptcp: add mptcp_lib_evts_*
  selftests: mptcp: userspace: print colored results
  mptcp: dup an entry when removing it
  mptcp: add userspace_pm_get_entry helper
  mptcp: add userspace pm addr entry refcount
  mptcp: flush userspace addrs list
  selftests: mptcp: flush userspace addrs list
  selftests: mptcp: rm userspace addr with randowly order
  mptcp: add netlink pm addr entry refcount

 net/mptcp/pm_netlink.c                        | 21 ++++--
 net/mptcp/pm_userspace.c                      | 72 ++++++++++++++++---
 net/mptcp/protocol.h                          |  3 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 72 +++++++++----------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 63 ++++++++++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 50 +++++--------
 6 files changed, 193 insertions(+), 88 deletions(-)

-- 
2.35.3

