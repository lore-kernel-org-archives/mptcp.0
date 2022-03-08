Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F259C48D0
	for <mptcp@lists.linux.dev>; Tue,  8 Mar 2022 13:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646745428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SY37tEFn/EJovIwIoJMb3VCYef487yar+NB+8eGdZAE=;
	b=IukD+P7hk+fFUOOxR8+hE4IDiBckEz8yC9B+MQaxkcJu5y0KU+jcBLgAhzATa6Qhs9dvW7
	ywnxkwnQYYbLPBxEYGKcqqhMXBQABPm1BiKcIVQgz7mlzEOuL0eirhucYICfHvC74nFo6X
	GG3sevZL7FKjbeWWyt/OKjRHZvUXs0w=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2052.outbound.protection.outlook.com [104.47.9.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-Oh8OLv-5NhWwVvrZ9yFMmA-1; Tue, 08 Mar 2022 14:17:07 +0100
X-MC-Unique: Oh8OLv-5NhWwVvrZ9yFMmA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLLkSOvlPeFskTQjWaLWyFzHujlxbZo40Zd4evbUDMdbu73HYCcg8keCCBRkQyUH82+PyNvPlKfwQ7mDvPFnVG/YmbTFo2VNnm6vnvR7UEM0KPwoglkhQgFFduLZCAFgf0ro49O72nPYBj2/vRMWEbwCTCoD5oVE8Xp80aTyInO+3Ev/TZ0Xq2HvtfFrQNrWCk8qyv0UYFrg47ZSMm/2a3Oz7B5nGAuswDRtH9BLBASe+1wDKuDNBnqznXsCvOMfCCD7z4lx1Xhuc4IiZ82fk87gFoyveCEL1vEPuTrm5ppUp/55xwgn2TkPwPubyn8OsjcmTyIub0ep8yETCkTeNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AlxNZnOouaStUrBcgl5K6TYtTCP73yOur5BA4KsmWM=;
 b=YfNnUCcmRJcxczWlQElBqxNNdXnrIgU0Beii9QK55IxECwqbla98Vp85A0gBcxw+lGbyoQFRtNjyZcywjy3B/3Wou0Lj1LEX+KfUtcUnUTndWxEBCc0+2JV8wSZaZobj9QRGlrsImpYcjRSIi24p1aeg/JPQzekY5dyLp/EaRY2EPNtoNCElgOEixqfYJJV7ln/S2lB/i5jV/JtP3KlU/djwSJTJHUuLZ4RM3UaOv/Qi7rZCM9EgJ4GKCrb/2Oxe2tW5ZvU9/+BXgKnoAbvm93OE5CxJneEjygjqAWuKUECWojmuSFKcFfLRlmHjDMSPpDLQoUQxPlVhOlUJq8tv5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8142.eurprd04.prod.outlook.com (2603:10a6:102:1ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Tue, 8 Mar
 2022 13:17:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 13:17:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 0/5] add skc_to_mptcp_sock
Date: Tue,  8 Mar 2022 21:16:53 +0800
Message-ID: <cover.1646745228.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0018.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d975d291-7548-4b29-26f5-08da0105f08d
X-MS-TrafficTypeDiagnostic: PAXPR04MB8142:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB8142B78BBF5E32BA793FBC64F8099@PAXPR04MB8142.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wDwYfxKIvyCaLX2LJUJxGjMDL/AwxKOhBz3hr9JwcU5v3XWNjL6tnPsWqIoGY028hQwrUNCleY2zboaxiL7wBM9vMtNJiclXFYm/azLzVuiQUHbBwUHx+m8v4xBkgNgT//4v0cRLeOoQOqCEjKeHMfpQO4ssdOpyOfNxFhNnpX9Ns1u3YW8Y/jexzb+PsvJUKCbmRRG5HNVHPaUZKlhx+0LpO/IvF6ToW+b9vGM0AIsc0iyBPu6Nfw6/uw2uQWkUAIaeuhEAK9mov6g6I59SuDKbeHA0Gjuizq94txIyXH/HAa/PwvuviKtuLA2p2Ezq8PIS0TuuOmsvDQPACHp+v2Dx+8vFdpfz0Ny1PhdGNtSDdK3SqqOXw+kKlBM13AyZq/CO1B+DYFe8p2TiFtOgEZuV/KhFyo14hzJdx0LgB0x45FOTn7qCw4cPm0JodjuJcuCOu1kWLUsptMJdKin8XbxcofSd/RlpHbVuqMWoIz45qs2WhZBy7zcDE7d3hi7zlcD0DTtdjxvvYiSHWrlZojKRKhOvP9nNSQ++6UwARTWkmKzzhO9pW58coNdk7Tb/F3HeW4AKgciZOUvrhyl+cknOFFtn3/oOmS1/bPemeQkxIi8gu0LIBxqFbrQZz2bdRElPwDBVYUwFd7d5UdemEywETHmsLhbxC7B30FXli9OmcoC13YvjGcql7o5Tmzol
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(316002)(6916009)(2616005)(6512007)(107886003)(44832011)(36756003)(2906002)(8936002)(5660300002)(26005)(4326008)(66476007)(66556008)(508600001)(6666004)(66946007)(38100700002)(86362001)(6506007)(6486002)(83380400001)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UyNYIkmn1Ge76p7Ghh3unLolQTgkTqFm6aWQgahKRZlUWdr70wW0APTobmmy?=
 =?us-ascii?Q?y0zCsayi5ZwsmEZguTQwAXUaHiRih6r9AtiUA4vWWatrfLSrBnQ54PFB2k92?=
 =?us-ascii?Q?K/Do5NoGdB/yYyGl49Wu5GN3VDKq6vxxtRIo9sdV+wNlVHOrWGC2ghI5vY/r?=
 =?us-ascii?Q?l5X4ukOJZG9ZQjhOlbVYnDU8OD+13KUCQ97L0pHAjrAKnr9HMcA8yzkQnzpy?=
 =?us-ascii?Q?N3XOsaIhMXjZMBLpqhDRHJOyq8da7rEsp2EVJ0PDD+QUmSjClpipnlFmqxHV?=
 =?us-ascii?Q?d6PT73xsdpSgcN4iyx07pMOnKia+EFYU9+UnjcbgTSoAIQ8IFhShAGlwqtZx?=
 =?us-ascii?Q?W5Cp3l1uPhHoCmyqoNgBEGcNTpGH7qoSI9X78KRNOwwEdvyS8spnDXUuGIXd?=
 =?us-ascii?Q?8gyAFkh8V5yponfLzAIpboQ+F+r4RQ/gAv8wzdyDCi2O0I9h4XJELot2veea?=
 =?us-ascii?Q?gtAwuAwoP1gVVTm5ObQx+AvTScBYSq7BwfXSErC0YIoyOufQsluOSJ94p/dU?=
 =?us-ascii?Q?cDQYrvpJN22YtDdOIwjmoVMqR1FUd88bi1QJLN63+IUOG+hpN8LI3z6fJCIX?=
 =?us-ascii?Q?1oz2BLYyerWwoZszDZH2XY6yFh6PK9eyEMoENaWAFCuITbILOKKUrCN4IcJg?=
 =?us-ascii?Q?pctLXsQsDcjpR6+rYubPRrJkzBw1TtSbAzoktahtPxdkNNEaSuoHRrSSmYmM?=
 =?us-ascii?Q?sYvvpU4+9yMDSvpAFphfRlSiGSDKwVPFG/6+KT/CGJAgYpoiSk2bxbf0cmPP?=
 =?us-ascii?Q?/0szqseBpmG/ktl7HEcNX4bYDzlD13Te+Zq+v2ypL6AwA2L9+Zbit0872RWc?=
 =?us-ascii?Q?vzMREEM0ZNdYwuORpoGJkxQzsJXIxBZTkbwEG4QrsbV387tGuQKeniBOqAC1?=
 =?us-ascii?Q?QNhEcfsf1JMp9qvzHv8s2XoYUOGWUUR1yRb0fLuED+ZTcBzUqIjTpsDkcOhz?=
 =?us-ascii?Q?PFKguPoZDLhdzscaie6ybbMPh+9TwCSwYrZp94CA3j5N+kD43mmCo+0fBg5p?=
 =?us-ascii?Q?YWTBRkbwsUMLeKmqr+pBbob0z7/AlzKxkBio9pFFM+t/q92YT95XifcFxcFV?=
 =?us-ascii?Q?FVLMitoVOoJKcTNjkI4ssT67iE3/dA9bpCumJqlaPFHf6wQx6MM+jhGzAkND?=
 =?us-ascii?Q?JdQDu5GP/faF8udns+pMW0MUKhj9pHiJ4TyJ+JMhjabxsIMSVCPXAeUEiOm3?=
 =?us-ascii?Q?jAR5ZWadVT1Ig2hXGBB2+MN1RS3crW1nrMfJb0fxuwR/BQQDxS+8kNQh4rFr?=
 =?us-ascii?Q?njzL3cTmH9JEPbjsNeO+S/ocRPBEqhP2tYDGeWXu2MGUDtce4G1im5uU7v2W?=
 =?us-ascii?Q?5mzgJWLalVtCAjBl7dI6Ef6K3kqojxczsJZpKv8BqerOJr/pFLWBTwCODx6W?=
 =?us-ascii?Q?g/H78luUkgDfrpCf1OEUME6pxXa0iwnt/tKIUf9Tk1xdHmTp5sN4Pz9nChw7?=
 =?us-ascii?Q?8X1N9ZUQb0ssWJKxY29KPcmO8CDrkL79a4kqgUfv4qF9vpvm/WWq7RZcfB/P?=
 =?us-ascii?Q?2j+GAUxJxfElmuS27qb1+v4HKYi8hkg85TC7lrPu244HbtR19Q5ycfYxmfkg?=
 =?us-ascii?Q?/TF5B2Qf6rKjqFpWsyL9A4qsVH0D/TWHeeXfIkaYeSBmbUF0c0nmT/NNH0pK?=
 =?us-ascii?Q?UULPrW4F2u27gtWXi9cV8cU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d975d291-7548-4b29-26f5-08da0105f08d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 13:17:05.3905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4C4/YeNVk1gTm/ski6+ylp+u8g43j9Ah+uFExR6l1Fy3Ap62B5XyViDHBb820NN/du+9jHXDcZX+AL9Uocm3AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8142

v9:
 - update progs/mptcp.c in patch 4 and 5

v8:
 - update as Matt suggested.

v7:
 - parse msk token from the output of 'ip mptcp monitor'.
 - add Nicolas and Matt's SoB tags.

v6:
 - add skc_to_mptcp_sock helper and test

RESEND:
 - fix the CI Build Failure.
v5:
 - fix incorrect token value
 - verify the token in selftest

v4:
 - define bpf_mptcp_sock_proto as a static function, no longer export
   it in linux/bpf.h

v3:
 - use RET_PTR_TO_BTF_ID_OR_NULL instead of RET_PTR_TO_MPTCP_SOCK_OR_NULL
 - add a new bpf_id BTF_SOCK_TYPE_MPTCP

v2:
 - keep RET_PTR_TO_MPTCP_SOCK_OR_NULL. If we use RET_PTR_TO_BTF_ID_OR_NULL
instead of RET_PTR_TO_MPTCP_SOCK_OR_NULL as Alexei suggested, the
"userspace" tests developed by Nicolas will break.

Geliang Tang (5):
  Revert "selftests: bpf: add bpf_mptcp_sock() verifier tests"
  Revert "bpf: add 'bpf_mptcp_sock' structure and helper"
  bpf: add skc_to_mptcp_sock helper
  Squash to "selftests: bpf: add MPTCP test base"
  selftests: bpf: add skc_to_mptcp_sock test

 include/linux/bpf.h                           |  31 +----
 include/linux/btf_ids.h                       |   3 +-
 include/uapi/linux/bpf.h                      |  14 +--
 kernel/bpf/verifier.c                         |  20 ----
 net/core/filter.c                             |  21 +++-
 net/mptcp/bpf.c                               |  62 +---------
 scripts/bpf_doc.py                            |   4 +-
 tools/include/uapi/linux/bpf.h                |  14 +--
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |   6 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 108 +++++++++++++++---
 tools/testing/selftests/bpf/progs/mptcp.c     |  36 ++++--
 tools/testing/selftests/bpf/verifier/sock.c   |  63 ----------
 12 files changed, 163 insertions(+), 219 deletions(-)

--=20
2.34.1

