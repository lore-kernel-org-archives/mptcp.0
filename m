Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDB82C85
	for <mptcp@lists.linux.dev>; Thu,  4 Nov 2021 13:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1636031645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H0XZ+hLDoArZvP1TQZqgEjXjQpLa2gwzQL2MjuBVMjE=;
	b=Of/52T6bV59jUePKTsrhGgb7VJEArgjAq8cVUw+ibEkcI6mENJ0idLtZ0guGSDJs5MnaL5
	2da/tYDcVGKXgm8NVXJYAUIKEWSnpHk5siGFkJsJNaXQ7rKBXPubzZaIOtMULQ7rgeQDDy
	sJ3Wm8of4RTrqB4/sa0KWEsbBg8UVZA=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2059.outbound.protection.outlook.com [104.47.2.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-18-1tXqaXVkOzCdbMeXD4epTA-1; Thu, 04 Nov 2021 14:14:04 +0100
X-MC-Unique: 1tXqaXVkOzCdbMeXD4epTA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mG6PjQwGZHLZ0hQCHdafnL2pLbXv3HlIVYRkbzeOz1uEq7U9kP1P3t+41xOHVsXOoTxAncVpwQmvRVMJAE7ii3mpF51LxLQUhwuK7ymBoEmPHM750ihxL//DuOe5ePcktZtsvcW1N9v6jZ7sNDrlg63ED8CjYUppqOxEtkAsLa5pxw/K1ab8hb+UHeiG+RWhiDEQogvo+kZwtu5RegkA1lLjG1ETnqkDYG+vhyvwdjoidc3RDXKBtlZhmsnD1vWbq+JKTojMl6WBjwuYtErp51cjV8y3nUyoUVZwyOiYE5GTP583hhfw2PxTeEgPiEita95fPp6JkMj9bgqppeFMQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNAM+w940WMgHM73YBzMv9tUxPBqg8UDvljRsEEHPRY=;
 b=lmZ9rESpbGVRkOPhbqZWOPQaIuGvQJEMg//dz4x1nIfom3BSsYguHFlrVBAE5/wdiVfTDvwY2Jdm0YGaurYxaWpnYvBBBEOAKqdiGAhyBIF2M9rbSd9x8Pw+J5Qaar7aDLUua8HvoHlWQTacS+E2g3wxSzvEW7HMT/WNhKhrV9fSM/KbdPItXLoy9bECk6vHAoWAmRPrE/LqOJWEDhc7fwXUga9oIUD0T47ccJqHchZkUEhdptOBwiBeYuFaHzcbglnBEl1d4REyuMPg3oURnLa8OKmvJsRNu2LAwsHF94rYopCtJ9p972W5G7GqWtw5gX9ZTTn8qHyRmyq8/+VLXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2427.eurprd04.prod.outlook.com (2603:10a6:3:25::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.18; Thu, 4 Nov
 2021 13:14:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af%6]) with mapi id 15.20.4669.013; Thu, 4 Nov 2021
 13:14:01 +0000
Date: Thu, 4 Nov 2021 21:13:52 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
CC: dcaratti@redhat.com, mathew.j.martineau@linux.intel.com,
	mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v8 8/8] selftests: mptcp: add mp_fail testcases
Message-ID: <20211104131352.GA8866@bogon>
References: <cover.1635481641.git.geliang.tang@suse.com>
 <ff613391540609e31cf4aff5abefaa03fbd63278.1635481641.git.geliang.tang@suse.com>
 <32bda041-3193-ac47-3d4e-5a7a7e5371c0@linux.intel.com>
 <f4467f1a-ddae-92b6-48f5-30ab03dfc77f@tessares.net>
 <20211104103003.GA5555@dhcp-10-157-36-190>
 <a59a3e4c-c4ca-c50c-6ed9-ab6a5a3a1c58@tessares.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a59a3e4c-c4ca-c50c-6ed9-ab6a5a3a1c58@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR02CA0204.apcprd02.prod.outlook.com
 (2603:1096:201:20::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (2408:8207:2546:b4d0:c652:b659:7170:192c) by HK2PR02CA0204.apcprd02.prod.outlook.com (2603:1096:201:20::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Thu, 4 Nov 2021 13:14:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4429b3e3-7c56-42fa-d583-08d99f94f79e
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2427:
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB2427D978837C2D9FAD638961F88D9@HE1PR0401MB2427.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	X37tboy692iLwIrozNv23XvVh+fAILuWgGuWeJ1zPDpZofQxknwLY7MxDietHQ3f9zQT4L/iXAHc0V8DYEKzQJ9wHB4h5E6LP6Pd+wuflSIqVT259oLjqJPgrh7EhobmT0s2xZZgU+kXLa+375JVRDDpDYAoQJaCCbrp9z2Y0Vv/uP+WPQVUGnPAphkb4jMveNtgBm+viwpPFVWgSzt+31vB8BeTXfErNpfSDs3pqJNoTV8Ou9IRt7eL3nEbZ+U3sMHl6RuScbsUEPOL+FhnOMLZ/x1iWF+Uj0s9NWidhOufEo0GS6yCQALr2Snjtt2EK0AWB4LL8uL4W9h11VvkTbvl+aq8X0c4EXyrRVvotGre79egRCRScwrQFRslA+jsd1LiY00Dfe7/Pd2UHbiVcoTEX3vrKuHJWA8rqQzSgJW+RVx5qUQiWJmoGm9suxApEePxO028wYa/eDCVV8r7W6bHSvbeu8OjpDT83UOf2ItqY30IL+LsFS5m+Y/dIviKh1XYnZoH77orjn0mbgbXqmUreS5VxP2HWa3Pu9jSnRawz/Vez9lC/FiKACgmS1jH9usp63wygy51uLroxtO6C8T3Oj1iBFicS4intrZDAUecx4ZkJ/9SbLnUNhbVnYIE4Xe6QYitxE8M39xPURQx1GLtQxyO6xe427WRYY2b9lu1vfWRhdI/Zv5tosaHuKdw6sbNFdDh0+uiQwE5p/Cb6wGMtJWmnazTHy3hd6aJkKw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6916009)(186003)(15974865002)(966005)(8676002)(508600001)(5660300002)(4326008)(8936002)(53546011)(6496006)(2906002)(6666004)(9686003)(30864003)(1076003)(66946007)(66476007)(66556008)(19627235002)(44832011)(6486002)(316002)(33716001)(38100700002)(33656002)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aUPR9zZ1rYu1Bfcxidm9CPcgpQiXGCJYm8uQT58BRWuQHMzGNnNoOyTTr1xQ?=
 =?us-ascii?Q?vWTqDkHWKENs4CmOd7wcCCBTcntMn8CWR50Hv7cVZ6zhzdH/dk6Tu2x+VcAW?=
 =?us-ascii?Q?5GuI4/ygD/xFFdR1IjhzZW13M0InoJ9iORmIyk9a/B0JuHLd1QTrN1qHkPva?=
 =?us-ascii?Q?GlQJMwScjgZdTrbTYS0Z8C5ge5w4MB1an/uo6DwVaxhkAr1vZp17tXq5omQo?=
 =?us-ascii?Q?TYXw8dEgYszLZ7buLGAAGi1dLnKOsir/Wpd1LTvWectiJB9GnTt4oBspXhOC?=
 =?us-ascii?Q?SG2rji91JXGvrgDo4yK3fTGT64CGYhxFFQz/isG4DKU4xy731qXBwjGk3Qep?=
 =?us-ascii?Q?cSU6UCK61RxKSRd8pepv/QPW6VeomzsJluJqGfhUIJA3WJyqx6oeMedzmZCJ?=
 =?us-ascii?Q?Jcb/GvfV+hW2/ClLJmr00ONrZ1Lg3qtRX9CfUcv5xtdO9s9ioXf6dN8bWVfO?=
 =?us-ascii?Q?hiu3pV3vgniaXWD7KUhV6gZ/HA2r+vVW5R/PfOx8zIAT2RHLnmDtJd20deuE?=
 =?us-ascii?Q?f1ji7j6TWVR8r5wwoUzO704dTmDpP5pweRn7q6x1SaYDiepxtirCmm1qp855?=
 =?us-ascii?Q?ntw8aKdtLwnEVlJCJp4/XnT6su/B8eBnmbRGgTzcPmN8FaZvn39UDlMawEuc?=
 =?us-ascii?Q?zy7FkDIcoZhrGefar2wBGV0OTUSpdU2+vBQsJTyyD7BkJUUdeE12X1ikaPSU?=
 =?us-ascii?Q?yQzthgGIM+25FWgyxXnw5zU9jjHM21ND6RRu+BAxK5FZFoQf/KPE7UMlba9E?=
 =?us-ascii?Q?NBJqosWsKHpnpOYyxz2uiid9MTFHNpstzFJwJQysx5ymusVmc0JjncqxPdZ7?=
 =?us-ascii?Q?L7aCH7BuJBTvqwj6gcmUNO/+tiHqPp/Ozfh1GMgoONZAM6U1hZ5N7IRggHDb?=
 =?us-ascii?Q?sNeoeBhvaCeKqfd4U0sBiBE1lwYEO2WVTAL5MaEPFPgz0uh02p/ZmlFw3TMJ?=
 =?us-ascii?Q?E750EyqR/9JeY/bhiJBCv353Gvnt9cnw+0kC/0oXv37VQ0ex8DKrmz3PLKt5?=
 =?us-ascii?Q?GtsztnMCNUJHpugEoWqV2FLe4Lq4M69Cs3URns1my9DAI1XAKLgssP4fHN3v?=
 =?us-ascii?Q?AUAnqRmhygy6ARI/V/f5n3+HnvRoTIoFhWPVjXTt3tgCS3KHJjq24DkmagkX?=
 =?us-ascii?Q?gPd20t4idU6HatUzl3kApj/jn+bFPxjSwcpJqzqteQdnFm7YgF9gPqNyo8JV?=
 =?us-ascii?Q?rcxU6FH1g1ZF0/Cw35xT1NAQKa2ptVupDzqSWVha/J1JqRfr4qYeyhVbu0Wq?=
 =?us-ascii?Q?XgE21i1xQgcDWQ0/S75SzL7QwPpvzHA8TEO9LIvVdFi7GLYgGUWHJ+2aJ5v1?=
 =?us-ascii?Q?mqZq0l65KB6+g56vTSKrSPWkPniE8iRB+ciMoZpPbctavRR1zkBpYTEBiamU?=
 =?us-ascii?Q?f5SCuf0Qi1dZwEITeOvnWGAmeoZz3WHzOIIePiQoemyO3qTcHeCucEWa4wdr?=
 =?us-ascii?Q?yRNs/GK9FvVGC1aYxWpGGlDPaAQZRz5IVllrsHa/mnqBnKYjvcP4U8pbn0Du?=
 =?us-ascii?Q?7P9ymWdiDZr/qH33fEfozY4S0DVf7exK30FecJTKDljI9S8atbdXkiOcU3dx?=
 =?us-ascii?Q?yvrh67fwSvUrCEZzQ0Vm8V3tYcVo4WLafqIjh2IK1453fA9cLU9ExGCa5Rxm?=
 =?us-ascii?Q?uol6JZ20PmdbZR3F0i6NxG6nxBufDWFb2QCVXt7sQrOU3cneTOqvBfSkcwzd?=
 =?us-ascii?Q?45F9ISXTBhWOCGjkoawksqqAQ/4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4429b3e3-7c56-42fa-d583-08d99f94f79e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 13:14:01.1351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMVDKYiKPr8n+XjWK0GH+ePv7G8nm5uZqfezVCnyu0QIN7nW4jIW04xh51IGi0srdb5Rp5om8Wt5GqLwyBJWMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2427

Hi Matt,

On Thu, Nov 04, 2021 at 12:48:38PM +0100, Matthieu Baerts wrote:
> Hi Geliang,
>=20
> On 04/11/2021 11:30, Geliang Tang wrote:
> > Hi Matt, Davide,
> >=20
> > On Thu, Nov 04, 2021 at 10:14:35AM +0100, Matthieu Baerts wrote:
> >> Hi Geliang,
> >>
> >> On 04/11/2021 01:43, Mat Martineau wrote:
> >>> On Fri, 29 Oct 2021, Geliang Tang wrote:
> >>>
> >>>> Added the test cases for MP_FAIL, use 'tc' command to trigger the
> >>>> checksum failure.
> >>>>
> >>>> Suggested-by: Davide Caratti <dcaratti@redhat.com>
> >>>> Suggested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> >>>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> >>>> ---
> >>>> tools/testing/selftests/net/mptcp/config=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 5 ++
> >>>> .../testing/selftests/net/mptcp/mptcp_join.sh | 75 +++++++++++++++++=
--
> >>>> 2 files changed, 72 insertions(+), 8 deletions(-)
> >>>>
> >>>> diff --git a/tools/testing/selftests/net/mptcp/config
> >>>> b/tools/testing/selftests/net/mptcp/config
> >>>> index 0faaccd21447..f522288b2204 100644
> >>>> --- a/tools/testing/selftests/net/mptcp/config
> >>>> +++ b/tools/testing/selftests/net/mptcp/config
> >>>> @@ -15,3 +15,8 @@ CONFIG_NETFILTER_XTABLES=3Dm
> >>>> CONFIG_NETFILTER_XT_MATCH_BPF=3Dm
> >>>> CONFIG_NF_TABLES_IPV4=3Dy
> >>>> CONFIG_NF_TABLES_IPV6=3Dy
> >>>> +CONFIG_NET_ACT_CSUM=3Dm
> >>>> +CONFIG_NET_ACT_PEDIT=3Dm
> >>>> +CONFIG_NET_CLS_ACT=3Dm
> >>>> +CONFIG_NET_CLS_FLOWER=3Dm
> >>>> +CONFIG_NET_SCH_INGRESS=3Dm
> >>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> >>>> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> >>>> index 2684ef9c0d42..d33cb5ce0ff3 100755
> >>>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> >>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> >>>> @@ -178,6 +178,12 @@ if [ $? -ne 0 ];then
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0exit $ksft_skip
> >>>> fi
> >>>>
> >>>> +jq -V > /dev/null 2>&1
> >>>> +if [ $? -ne 0 ];then
> >>>> +=C2=A0=C2=A0=C2=A0 echo "SKIP: Could not run all tests without jq t=
ool"
> >>>> +=C2=A0=C2=A0=C2=A0 exit $ksft_skip
> >>>> +fi
> >>>> +
> >>>> print_file_err()
> >>>> {
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0ls -l "$1" 1>&2
> >>>> @@ -232,6 +238,28 @@ link_failure()
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0done
> >>>> }
> >>>>
> >>>> +checksum_failure()
> >>>> +{
> >>>> +=C2=A0=C2=A0=C2=A0 i=3D"$1"
> >>>> +
> >>>> +=C2=A0=C2=A0=C2=A0 tc -n $ns2 qdisc add dev ns2eth$i clsact
> >>>> +=C2=A0=C2=A0=C2=A0 tc -n $ns2 filter add dev ns2eth$i egress \
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 protocol ip prio 1000 \
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flower ip_proto tcp \
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 action pedit munge offse=
t 148 u32 invert \
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pipe csum tcp \
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 index 100
> >>>
> >>> Could you add a comment explaining what the filter is doing? While it
> >>> looks like the idea is to invert the 32-bit word at byte offset 148, =
I'm
> >>> not tc-literate enough to know if there are other effects (and I didn=
't
> >>> watch the email threads closely on this).
> >=20
> > Matt, could you please add this comment for me? I didn't understand
> > these tc commands very well, and I can't explain them very clearly in
> > English.
>=20
> Sure. Here is my proposition:
>=20
>     # Modify TCP payload without corrupting the TCP packet
>     #
>     # This rule inverts a 32-bit word at byte offset 148 for all TCP ACK
>     # packets carrying enough data.
>     # Once it is done, the TCP Checksum field is updated so the packet
>     # is still considered as valid at the TCP level.
>     # But because the MPTCP checksum, covering the TCP options and data,
>     # has not been updated, we will detect the modification and emit an
>     # MP_FAIL: what we want to validate here.
>     #
>     # Please note that this rule will produce this pr_info() message for
>     # each TCP ACK packets not carrying enough data:
>     #
>     #     tc action pedit offset 162 out of bounds
>     #
>     # But this should be limited to a very few numbers of packets as we
>     # restrict this rule to outgoing TCP traffic with only the ACK flag
>     # + except the 3rd ACK, only packets carrying data should be seen in
>     # this direction.
>=20
> This comment makes sense if you use "flower ip_proto tcp tcp_flags
> 0x10/0xff" and reduce incoming traffic. Otherwise, we need to remove
> "ACK" and/or the last sentence but I don't think we should make this
> test printing a lot of pr_info().

Thanks very much, I'll add this comment in the next version and your
Co-developed-by tag.

>=20
> >=20
> >>
> >> Yes that's correct. It takes only TCP packets on the egress side that
> >> are big enough but print a message in dmesg if not. After the
> >> modification, the TCP checksum is recomputed so the packet is valid.
> >>
> >>>
> >>>> +
> >>>> +=C2=A0=C2=A0=C2=A0 while true; do
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 local pkt=3D$(tc -n $ns2=
 -j -s action show action csum index 100 |
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 jq '.[1].actions[0].stats.packets')
> >=20
> > Should we show the action 'pedit' here, instead of 'csum'?
> >=20
> > The action 'csum' output is like this:
> >=20
> > # tc -n $ns2 -j -s action show action csum index 100
> >=20
> > [{"total acts":1},{"actions":[{"order":0,"kind":"csum","csum":"tcp","co=
ntrol_action":{"type":"pass"},"index":100,"ref":1,"bind":1,"installed":29,"=
last_used":2,"stats":{"bytes":11576,"packets":42,"drops":0,"overlimits":0,"=
requeues":0,"backlog":0,"qlen":0}}]}]
> >=20
> > "overlimits" is always 0 in 'csum'.
>=20
> Good point. I thought 'pedit' would not let the packet passing to csum
> if it was over the limits but I guess it does if we see the same values
> for packets/bytes counters in 'csum' and 'pedit' actions.
>=20
> > But the action 'pedit' output is like this:
> >=20
> > # tc -n $ns2 -j -s action show action pedit index 100
> >=20
> > [{"total acts":1},{"actions":[{"order":0 pedit ,"control_action":{"type=
":"pipe"}keys 1
> >  	 index 1 ref 1 bind 1,"installed":29,"last_used":2
> > 	 key #0  at 148: val ffffffff mask ffffffff
> >  ,"stats":{"bytes":11576,"packets":42,"drops":0,"overlimits":36,"requeu=
es":0,"backlog":0,"qlen":0}}]}]
>=20
> (When you will get the right output, may you add this in a comment in
> the script as an example to explain what you have and what you try to
> parse please?)
>=20
> >=20
> > "overlimits" values are all right here
>=20
> From what I see in the code, if the packet was not carrying enough data
> 'act_pedit' will increase the 'overlimits' counter and the other ones --
> bytes and packets I guess -- as well:
>=20
>=20
> https://elixir.bootlin.com/linux/latest/source/net/sched/act_pedit.c#L368
>=20
> So good point, we should look at 'pedit' counters and more precisely at:
>=20
>   "packets" - "overlimits" > 0

Exactly!

>=20
> here.
>=20
> > but this output can't be parsed by
> > 'jq'. It looks like something wrong to show 'pedit'.
> >> Is this a bug in act_pedit, or we use pedit incorrectly? How can I fix
> this?
>=20
> Do you mean you have this error?
>=20
>   parse error: Invalid numeric literal at line 1, column 47
>=20
> To me, it looks like a bug on printing data, so on 'tc' side.
> Which version of 'tc' are you using? May you try to upgrade to a more
> recent one? e.g. IPRoute2 5.15.0? Maybe it has already been fixed.

You're right, it's a tc bug. And fixed already in IPRoute2 5.15.0.

>=20
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ $pkt -gt 0 ]; then
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
tc -n $ns2 qdisc del dev ns2eth$i clsact
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
break
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
> >>
> >> On my side, I had to add a "sleep .1" to slow things down and have the
> >> tests a bit more stable.
> >>
> >> I also used "flower ip_proto tcp tcp_flags 0x10/0xff" and it seems
> >> working fine.
> >=20
> > Could you please share your checksum_failure function here, I'll test i=
t
> > on my side?
>=20
> I did that to have the test finishing on my side:
>=20
> --------------- 8< ---------------
> diff --git a/tools/testing/selftests/net/mptcp/config
> b/tools/testing/selftests/net/mptcp/config
> index f522288b2204..2aff41754c8f 100644
> --- a/tools/testing/selftests/net/mptcp/config
> +++ b/tools/testing/selftests/net/mptcp/config
> @@ -17,6 +17,6 @@ CONFIG_NF_TABLES_IPV4=3Dy
>  CONFIG_NF_TABLES_IPV6=3Dy
>  CONFIG_NET_ACT_CSUM=3Dm
>  CONFIG_NET_ACT_PEDIT=3Dm
> -CONFIG_NET_CLS_ACT=3Dm
> +CONFIG_NET_CLS_ACT=3Dy
>  CONFIG_NET_CLS_FLOWER=3Dm
>  CONFIG_NET_SCH_INGRESS=3Dm
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index d33cb5ce0ff3..8dcd445b1532 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -245,7 +245,7 @@ checksum_failure()
>         tc -n $ns2 qdisc add dev ns2eth$i clsact
>         tc -n $ns2 filter add dev ns2eth$i egress \
>                 protocol ip prio 1000 \
> -               flower ip_proto tcp \
> +               flower ip_proto tcp tcp_flags 0x10/0xff \
>                 action pedit munge offset 148 u32 invert \
>                 pipe csum tcp \
>                 index 100
> @@ -257,6 +257,7 @@ checksum_failure()
>                         tc -n $ns2 qdisc del dev ns2eth$i clsact
>                         break
>                 fi
> +               sleep .1
>         done
>  }
>=20
> --------------- 8< ---------------

Thanks, this works on my side too. I'll add this 'tcp_flags 0x10/0xff'
in the next version.

>=20
> >=20
> >>
> >> But still and probably caused by the "sleep .1" that seems needed, I
> >> have many messages in dmesg:
> >>
> >>     tc action pedit offset 162 out of bounds
> >>
> >> Because everything is shown on the serial, it is a bit annoying.
> >>
> >> Do you think it would be possible to limit to TCP ACK and also make su=
re
> >> data are only sent in one direction or limit incoming traffic to 1 byt=
e
> >> if it is easier? With this, we should then have a very few pure ACKs
> >> packets on the egress side and avoid most of the TC warning messages
> >> printed by the kernel, no?
> >>
> >>>> +=C2=A0=C2=A0=C2=A0 done
> >>>> +}
> >>>> +
> >>>> # $1: IP address
> >>>> is_v6()
> >>>> {
> >>>> @@ -371,6 +399,9 @@ do_transfer()
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0if [[ "${addr_nr_ns2}" =3D "fullmesh_"* ]]; =
then
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags=3D"${flags},fullmes=
h"
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr_nr_ns2=3D${addr_nr_n=
s2:9}
> >>>> +=C2=A0=C2=A0=C2=A0 elif [[ "${addr_nr_ns2}" =3D "fail_"* ]]; then
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checksum_failure ${addr_=
nr_ns2:5}
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr_nr_ns2=3D0
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0fi
> >>>>
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0if [ $addr_nr_ns2 -gt 0 ]; then
> >>>> @@ -542,6 +573,8 @@ run_tests()
> >>>> chk_csum_nr()
> >>>> {
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0local msg=3D${1:-""}
> >>>> +=C2=A0=C2=A0=C2=A0 local csum_ns1=3D${2:-0}
> >>>> +=C2=A0=C2=A0=C2=A0 local csum_ns2=3D${3:-0}
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0local count
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0local dump_stats
> >>>>
> >>>> @@ -553,8 +586,8 @@ chk_csum_nr()
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0printf " %-36s %s" "$msg" "sum"
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0count=3D`ip netns exec $ns1 nstat -as | grep=
 MPTcpExtDataCsumErr |
> >>>> awk '{print $2}'`
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0[ -z "$count" ] && count=3D0
> >>>> -=C2=A0=C2=A0=C2=A0 if [ "$count" !=3D 0 ]; then
> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "[fail] got $count =
data checksum error[s] expected 0"
> >>>> +=C2=A0=C2=A0=C2=A0 if [ "$count" !=3D $csum_ns1 ]; then
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "[fail] got $count =
data checksum error[s] expected
> >>>> $csum_ns1"
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=3D1
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dump_stats=3D1
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0else
> >>>> @@ -563,8 +596,8 @@ chk_csum_nr()
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0echo -n " - csum=C2=A0 "
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0count=3D`ip netns exec $ns2 nstat -as | grep=
 MPTcpExtDataCsumErr |
> >>>> awk '{print $2}'`
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0[ -z "$count" ] && count=3D0
> >>>> -=C2=A0=C2=A0=C2=A0 if [ "$count" !=3D 0 ]; then
> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "[fail] got $count =
data checksum error[s] expected 0"
> >>>> +=C2=A0=C2=A0=C2=A0 if [ "$count" !=3D $csum_ns2 ]; then
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "[fail] got $count =
data checksum error[s] expected
> >>>> $csum_ns2"
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=3D1
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dump_stats=3D1
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0else
> >>>> @@ -658,6 +691,8 @@ chk_join_nr()
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0local syn_nr=3D$2
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0local syn_ack_nr=3D$3
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0local ack_nr=3D$4
> >>>> +=C2=A0=C2=A0=C2=A0 local fail_nr=3D${5:-0}
> >>>> +=C2=A0=C2=A0=C2=A0 local infi_nr=3D${6:-0}
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0local count
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0local dump_stats
> >>>>
> >>>> @@ -700,9 +735,9 @@ chk_join_nr()
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ip netns exec $ns2 nstat =
-as | grep MPTcp
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0fi
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0if [ $checksum -eq 1 ]; then
> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chk_csum_nr
> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chk_fail_nr 0 0
> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chk_infi_nr 0 0
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chk_csum_nr "" $fail_nr
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chk_fail_nr $fail_nr $fa=
il_nr
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chk_infi_nr $infi_nr $in=
fi_nr
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0fi
> >>>> }
> >>>>
> >>>> @@ -1837,6 +1872,25 @@ fullmesh_tests()
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0chk_add_nr 1 1
> >>>> }
> >>>>
> >>>> +fail_tests()
> >>>> +{
> >>>
> >>> Since MP_FAIL is only relevent with checksums enabled, I think it wou=
ld
> >>> be good to set $checksum=3D1 here and restore its previous value befo=
re
> >>> returning (in case other tests run after this).
> >>>
> >>>> +=C2=A0=C2=A0=C2=A0 # 1 subflow
> >>>> +=C2=A0=C2=A0=C2=A0 reset
> >>>> +=C2=A0=C2=A0=C2=A0 ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> >>>> +=C2=A0=C2=A0=C2=A0 ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> >>>> +=C2=A0=C2=A0=C2=A0 run_tests $ns1 $ns2 10.0.1.1 2 0 "fail_1" fast
> >=20
> > Here I passed 2 as the 4th argument of run_tests like the link_failure
> > tests to create the bigger data files. I don't know why it dosen't work
> > when passing 0 as the argument?
>=20
> Should we first insert the TC rule, then start the test, then look at
> counters?
> It would be "safer" because we would not need need to make sure we have
> enough data to transfer. WDYT?

Good point, I'll try it.

>=20
> >>>> +=C2=A0=C2=A0=C2=A0 chk_join_nr "MP_FAIL test, 1 subflow" 0 0 0 1 1
> >>>> +
> >>>> +=C2=A0=C2=A0=C2=A0 # multiple subflows
> >>>> +=C2=A0=C2=A0=C2=A0 reset
> >>>> +=C2=A0=C2=A0=C2=A0 ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> >>>> +=C2=A0=C2=A0=C2=A0 ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> >>>> +=C2=A0=C2=A0=C2=A0 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev =
ns2eth3 flags
> >>>> subflow
> >>>> +=C2=A0=C2=A0=C2=A0 ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 dev =
ns2eth2 flags
> >>>> subflow
> >>>> +=C2=A0=C2=A0=C2=A0 run_tests $ns1 $ns2 10.0.1.1 2 0 "fail_2" fast
> >>>> +=C2=A0=C2=A0=C2=A0 chk_join_nr "MP_FAIL test, multiple subflows" 2 =
2 2 1
> >>>> +}
> >>>> +
> >>>> all_tests()
> >>>> {
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0subflows_tests
> >>>> @@ -1853,6 +1907,7 @@ all_tests()
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0checksum_tests
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0deny_join_id0_tests
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0fullmesh_tests
> >>>> +=C2=A0=C2=A0=C2=A0 fail_tests
> >>>> }
> >>>>
> >>>> usage()
> >>>> @@ -1872,6 +1927,7 @@ usage()
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0echo "=C2=A0 -S checksum_tests"
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0echo "=C2=A0 -d deny_join_id0_tests"
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0echo "=C2=A0 -m fullmesh_tests"
> >>>> +=C2=A0=C2=A0=C2=A0 echo "=C2=A0 -F fail_tests"
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0echo "=C2=A0 -c capture pcap files"
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0echo "=C2=A0 -C enable data checksum"
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0echo "=C2=A0 -h help"
> >>>> @@ -1907,7 +1963,7 @@ if [ $do_all_tests -eq 1 ]; then
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0exit $ret
> >>>> fi
> >>>>
> >>>> -while getopts 'fsltra64bpkdmchCS' opt; do
> >>>> +while getopts 'fsltra64bpkdmchCSF' opt; do
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0case $opt in
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f)
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
ubflows_tests
> >>>> @@ -1951,6 +2007,9 @@ while getopts 'fsltra64bpkdmchCS' opt; do
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 m)
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f=
ullmesh_tests
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;=
;
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 F)
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
fail_tests
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
;;
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c)
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;=
;
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C)
> >>>> --=C2=A0
> >>>> 2.26.2
> >>>
> >>> When I run:
> >>>
> >>> $ sudo ./mptcp_join.sh -FC
> >>>
> >>> I get:
> >>>
> >>> """
> >>> Created /tmp/tmp.UTIlkuhfRW (size 1 KB) containing data sent by clien=
t
> >>> Created /tmp/tmp.pMPhJddNfQ (size 1 KB) containing data sent by serve=
r
> >>> Created /tmp/tmp.OEx5cmVqbp (size 10075 KB) containing data sent by c=
lient
> >>> Created /tmp/tmp.RAtBQXOXtR (size 6144 KB) containing data sent by se=
rver
> >>> [ FAIL ] file received by server does not match (in, out):
> >>> -rw-------. 1 root root 20633656 Nov=C2=A0 3 17:32 /tmp/tmp.HtyoJjpCO=
e
> >>> Trailing bytes are:
> >>> MPTCP_TEST_FILE_END_MARKER
> >>> -rw-------. 1 root root 20633656 Nov=C2=A0 3 17:32 /tmp/tmp.j8HYN1PUV=
h
> >>> Trailing bytes are:
> >>> MPTCP_TEST_FILE_END_MARKER
> >>> 01 MP_FAIL test, 1 subflow=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 syn[ ok ] - synack[ ok ] - ack[
> >>> ok ]
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sum[ ok ] - csum=C2=A0 [ ok ]
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ftx[ ok ] - frx=C2=A0=C2=A0 [ ok ]
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 itx[ ok ] - irx=C2=A0=C2=A0 [ ok ]
> >>> [ FAIL ] file received by server does not match (in, out):
> >>> -rw-------. 1 root root 20633656 Nov=C2=A0 3 17:32 /tmp/tmp.HtyoJjpCO=
e
> >>> Trailing bytes are:
> >>> MPTCP_TEST_FILE_END_MARKER
> >>> -rw-------. 1 root root 20633656 Nov=C2=A0 3 17:32 /tmp/tmp.j8HYN1PUV=
h
> >>> Trailing bytes are:
> >>> MPTCP_TEST_FILE_END_MARKER
> >>> 02 MP_FAIL test, multiple subflows=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 syn[=
 ok ] - synack[ ok ] - ack[
> >>> ok ]
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sum[ ok ] - csum=C2=A0 [ ok ]
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ftx[ ok ] - frx=C2=A0=C2=A0 [ ok ]
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 itx[ ok ] - irx=C2=A0=C2=A0 [ ok ]
> >>> """
> >>>
> >>> The chk_join_nr output shows all [ ok ], which is good. But the file
> >>> mismatches (I assume due to the inverted data) are failures because t=
he
> >>> checksums are intended to reject the bad data. Am I understanding the
> >>> file mismatches correctly?
> >>>
> >>> If MP_FAIL is working, the files should match.
> >>
> >> I also have the same error on my side but not all the time.
> >=20
> > I got these file mismatches errors all the time. Could you please share
> > your test script and the logs when you get the right output?
>=20
> I don't think I saw them for both tests all the time but it is possible
> it was always there for the 1st one and not for the second one. I will
> look at that next time.
>=20
> > The first test "01 MP_FAIL test, 1 subflow" will get the file mismatche=
s
> > all the time, since the checksum error data can't be retransmitted in
> > the current codes.
>=20
> Should we disable this test then?

We should keep this test. It's useful for testing sending and receiving
of the infinite mapping. The infinite mapping is only sent in this single
subflow case.

>=20
> > But the second test "02 MP_FAIL test, multiple subflows" shouldn't get
> > the file mismatches. RST is sent on the checksum error subflow, so this
> > subflow is closed. The data will be retransmitted on the other subflow.
> > It works by using the old test case "[PATCH mptcp-next v7 8/8]
> > DO-NOT-MERGE: mptcp: mp_fail test". Data will be retransmitted, and no
> > the file mismatches. I don't know why it dosen't work by this new test
> > case. In this test case, I saw the error data has been dropped, and the
> > new data has been retransmitted in the log. I'll try to fix this.
>

Could we merge patches 1-7 of this patchset into the export branch? Then
I'll just iterate a new version of this test case patch. And if there's
something I need to fix next week, I'll send the squash-to patch. Please
discuss this with Mat in today's weekly meeting.

Thanks,
-Geliang

> Thanks!
>=20
> Cheers,
> Matt
> --=20
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>=20

