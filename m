Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2262F28
	for <mptcp@lists.linux.dev>; Mon,  7 Feb 2022 14:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644242910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vySmNc+WNetm3FLzz8GLxPPSv63okgRmG8X37E56sDM=;
	b=CV5ztaTvSgIUwsAf55DmIhrSDUAZjaXAjHDqdwRAFd6su1XeiHhGUUxHDPAq6dvMllao2F
	eGuLvCgibtJ42Cm8cuVLU599FlXLV4sBomCGDxW6W09FF3MjzuQjIsyR5PCtTcm9+XGzkQ
	VZBz4RC1bgLDN0sRQ5NC7krg8DH/fAM=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2058.outbound.protection.outlook.com [104.47.8.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-5-XnI6AmGsONm8shOzneJspA-1; Mon, 07 Feb 2022 15:08:29 +0100
X-MC-Unique: XnI6AmGsONm8shOzneJspA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqRZ777ab5Crftx0h4KX3JaY/IYmBSKazexo0P181R2CplWh+Z9aPqvlg5a8ADpzTnDIaSn1VroWHxGZFfTZOrm9G1RfZuMQe+Kav1NgzpAt0gAs6OA+WAxaUCkXI/KaVWldeKhj2TTtDx7yG3MQgExd6k918PaJapJY0wMe3JjNV7VPBH2ap5erSiOcmDciKqujkAPn0jlLPf7eIAuBE0TsR8Ej+fIuj1jnXLg0v+/U/ThLklpTD8D0U6VZh/6Jh8BopwcjHDEErVXKB+JyFZO1M68TwNueb3lk3/NluTBD7W7tSRreHnqgj2JQpHobLhYRl7ZcLrUSLN+pNf9DiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jSkHMY6zjSnwC7BzBS1/MxTX/kYTTG0hneDezf5MIo=;
 b=Sg4SV/mPjo/QuS+DgV1BWXymWUMgUPkBdv4yvRepRKqI7Fy5A8SA6JYIYsDYgHL+Z8/urt1LhWakE870iOwuArDsyqHgj94aOhnjZjVJUY8RLVjSaxXAxNEBy1Ib1hZPbf2ZYi6GG+t7FaznNF6+mn4YbEAT+LSqIsU+C4M6xh3EOdkY1u8cFk/Mw9UyJDRTmBwMPU6p/xuRIlqk2fweW8gSlbn0uTlyLua2mGqlZO3mrUCgzNl3ixZYSbXQRAg88Gwt0XyMAs2QpIFWx4+0KP42+TLx1aZK9h0pQFkGjIkzsb/3MkK59pjuondsQrzh953669LRysUIWixDSW2Fpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5233.eurprd04.prod.outlook.com (2603:10a6:208:c9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 14:08:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 14:08:28 +0000
Date: Mon, 7 Feb 2022 22:08:54 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
CC: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 3/3] selftests: mptcp: add mp_fail testcases
Message-ID: <20220207140854.GA2916@localhost>
References: <cover.1643110285.git.geliang.tang@suse.com>
 <064cfe306debc535413c1d39fcf3b8d24a959eeb.1643110285.git.geliang.tang@suse.com>
 <b4708d63-29aa-da51-f536-3b5bf5399221@linux.intel.com>
 <a5500825-43a0-93c4-ba92-f3a24d4a202c@tessares.net>
 <CA+WQbwtY-qKu+_yNGcq3g5wDu7ZD0WwpSDbT7n1SLdw0ZtxwrA@mail.gmail.com>
 <eb33b5d3-a6e8-55d0-a149-c045ec2ecab5@tessares.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <eb33b5d3-a6e8-55d0-a149-c045ec2ecab5@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK0PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:203:b0::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e75c237e-f6e2-461c-bf77-08d9ea435047
X-MS-TrafficTypeDiagnostic: AM0PR04MB5233:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB5233CE4B29A4F8582F590120F82C9@AM0PR04MB5233.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	91ctFLSbkA7kllFVai8XpqxDFtZg2SadgmkVNMNdBSfJAMZ7uIKL0BjlWn7mVDO4p/Xq8HC/nyKlM6j2qzMJBvnhhjFWaW8Br+OU23rrvV1DH+6aww1XmfTIVKJlT7nOCAAxlCye1Hh+QiSBIAIdevVbLZHSYsWiI8J3tEUiT54kT/tWf1cBmy8OQgs6mifd9aqSbgZhgM6FMz6f+YPWlK6oBhJoammo5OsPYmJkTZ+4RqgiDWBplgnlqL3iiG3V7nIFWgNV5/wcSDTJ4hGnOmzT+RP7TKyP4pdc1yfOngYw9HIIi9rw0OKFAAgf27eBzMtSNOvLE1tjS8ClUdwZuvEW+kaqGZ944qiIyRbASk5VcyQcKnsRQAi5jXepi0xxTIKdn79Rs7iAe61IjE2dSrDgv+FmXzuw4wif3lCEl7nR9d6jGeO7rAi4A36KoAY2ghWv06TMX3mvGHOyvyT5BXEXv9c6svHDO6fsmLNvW0TYyMBG1IbJNbw3MG23Ax4VpPcPcVBwVg4wOZbQ8AXZw4BwWr0I2NuA2UkwGxG0nwo9B47iQCZyIrBCpbgxo98I/llxyrKSZkgddz3Sl8qNtqkufJatOSQUWZXschfEwny3dT2o90ShJnIIg8IiVXcUbZ0273+vzOfeMeZV6IdxgCbJfVY7SoeWa66ntEQHmXVl415zGvIWqoQACybCkU6xQ1gQ7gjwZFgox5T++XBXM0J0Vyf9B6R+AgAHSZpudJ0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(84040400005)(8936002)(83380400001)(4326008)(66556008)(66476007)(8676002)(33656002)(1076003)(508600001)(966005)(6486002)(38100700002)(6506007)(86362001)(53546011)(44832011)(9686003)(6512007)(33716001)(5660300002)(66946007)(2906002)(15974865002)(6666004)(316002)(6916009)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K25ILFhXWk1Q0oy5z9ilMMjqoBvCwimDXv5tvZn/0Uegv8vPDr7QiIjhy2sq?=
 =?us-ascii?Q?D0K4g3ZI8+EsgkXFfwEFVmkglY7hHanSuC7HcWWErZfKuXhc6WXF2Qvi61YQ?=
 =?us-ascii?Q?4aFWt4pG+yaPxkIsuRwQWMvJmdCvveTNwYSVwI/TtTXlZGv4hRvaTBrSrEtw?=
 =?us-ascii?Q?CmZf8Ty+/TwknJ+o+o9MgpCq5j1VJJaZYqYgtAJjz7H3LLojFnEKSpA/ozSk?=
 =?us-ascii?Q?6pbUNtSiB0cXjBulxvgesIPeHXDS1AWl5Y/zY8w6d6YqmZ1+JNFqwCjb0Ue5?=
 =?us-ascii?Q?VB/513YzQwnuVtt1zFy3L89Ef6K0WjHM0TUx2PqOWPoNZvme2kmFIAODoZX+?=
 =?us-ascii?Q?IO62pAmHuu7Muwc68E7aqUxI5FFmMU6tb+hedM68byC20tFp3wfrGP7cN1Cj?=
 =?us-ascii?Q?oH94musWLxuqdiRXRl/VX+AKgiw3M3SOojyJhS8Q+IXjNzuvQHFyuTGJCT9h?=
 =?us-ascii?Q?uszYSh0tv7Ny1E5BL8w1F723PNTDSL0Pg1jdleOhFiHJc7UVFUJI6GY6P5jA?=
 =?us-ascii?Q?5nUVaq+aqtYe+h2yhvAWfaVoV9sZsQ9NHe0fgKsA85sA+2ykZ8/C8H7ZORK6?=
 =?us-ascii?Q?S1NI63RS5P4eidggpth4fYMgPWbfAR6mI7B2qi+s7PwepiCNmtIqQmbOxESL?=
 =?us-ascii?Q?5D7NHZHUR6NzhfT6sCPOCvXydr/bfHLdT6AxNOq069b1WYw9W1S7n4dU+Ct2?=
 =?us-ascii?Q?5wDhVQ1ehXIM5zhv30xo/0ZKW8EwflVD80NSabpBLY7a5Ukt/hI4fGwd0Whg?=
 =?us-ascii?Q?pT0lmRqJaDWjSsd12JBV2BRaD1w1OwyTkHA/DO902tAvZuPAZ89shiIKoCRL?=
 =?us-ascii?Q?+QI47/ZoPNH32NCIkeLkTzGyQvZrL7aKYZhj49cpuwy/PD9kCUkdau0gHG76?=
 =?us-ascii?Q?pr771QfVciStOdbVts5LhCIpDLm6ng8V/rtVrLx6T8VUgirlW5619muTROBb?=
 =?us-ascii?Q?/8u20IUTa88uBD9DTS4o2LUUdTnBTvOvn0s7hFgqvXzplotUlTSz+gya9xRO?=
 =?us-ascii?Q?Ks6HO3HGFf52xSkNUpzJVukI2SnfcKuJoArL34hGacE6tmxKBb8Z76U7tsLD?=
 =?us-ascii?Q?yH6xVyciwxdYIIt4moZ1Dztu2s44VQU+oOOZH/Zp4COvWejp6SpitsGwxaq8?=
 =?us-ascii?Q?63nVghxBNqhKD2QScxw6j1n7kRdsCa5FpAChx4QNBCAxiccInihSE4bcvuM6?=
 =?us-ascii?Q?Vbk+mDlLXJToREtqF7fLajLB2iOcC8V5/Si90PYkNCnhaAzw8fkOX7JyHM4X?=
 =?us-ascii?Q?b2sKbrPTEOdo7ZLGU7KJ+GDR5/7HbGayOy6bbG+vL6ShRpq1Z4hDv7pI+bBx?=
 =?us-ascii?Q?dAivaJfOCkRkDeZFC20gLLvWdFZHb8pjqpCOmdby29EbUg4rndaM2RmZpSXl?=
 =?us-ascii?Q?WJDOC71G0UIrF3tA8RYVbV+eKLtU2XN2juTJpz29FvIxzI4rF150tWGOENOE?=
 =?us-ascii?Q?GkCaDj0lYRMFcUsHFOSvow40BA0TOuP7Tjt337HR4CnpYJSdjWW3Ja21DU91?=
 =?us-ascii?Q?1d132bTmjzdN0rY+r1Oa/MnTj2VwI5IT/N4+9nUcxzBQ+nOLOJN+W0wS+LR8?=
 =?us-ascii?Q?SmhdJaOrR+n1/NSmRXijfsxTqGM3KcPiE7rByXguyCaQ4hxx/JVA6RflWTmd?=
 =?us-ascii?Q?NIjMUbftp4zbos4744R6XoEyc4rBo7j72URuV4qCCpHWZkD2bhmfJkauRcz0?=
 =?us-ascii?Q?LfR0hrfkXGPtTHplSUirTMlyrY4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e75c237e-f6e2-461c-bf77-08d9ea435047
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 14:08:28.4598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AW+seWYmALJCHuPzF8sq7bTgCyRiXh9KRy8k9XTV4kqvBDw4A50ew3SuWKosQ/2WlGvzm6feYLyTY2J9uCwfvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5233

On Mon, Feb 07, 2022 at 11:32:05AM +0100, Matthieu Baerts wrote:
> Hi Geliang,
>=20
> On 07/02/2022 05:13, Geliang Tang wrote:
> > Hi Matt,
> >=20
> > Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2022=E5=B9=B41=
=E6=9C=8829=E6=97=A5=E5=91=A8=E5=85=AD 01:04=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> Hi Mat, Geliang,
> >>
> >> On 27/01/2022 01:07, Mat Martineau wrote:
> >>> On Tue, 25 Jan 2022, Geliang Tang wrote:
> >>>
> >>>> Added the test cases for MP_FAIL, use 'tc' commands to trigger the
> >>>> checksum failures.
> >>>>
> >>>
> >>> This patch is working well with the inverted byte detection, thanks!
> >>
> >> The public CI seems quite happy with the new version, good work :)
> >>
> >> Here is its report:
> >>
> >> =3D=3D=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D=3D
> >> Our CI did some validations and here is its report:
> >>
> >> - KVM Validation: normal:
> >>   - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
> >>   - Task: https://cirrus-ci.com/task/4993794666921984
> >>   - Summary:
> >> https://api.cirrus-ci.com/v1/artifact/task/4993794666921984/summary/su=
mmary.txt
> >>
> >> - KVM Validation: debug:
> >>   - Unstable: 2 failed test(s): selftest_diag selftest_mptcp_join =F0=
=9F=94=B4:
> >>   - Task: https://cirrus-ci.com/task/4682233209421824
> >>   - Summary:
> >> https://api.cirrus-ci.com/v1/artifact/task/4682233209421824/summary/su=
mmary.txt
> >>
> >> Initiator: Patchew Applier
> >> Commits:
> >> https://github.com/multipath-tcp/mptcp_net-next/commits/c52e51136372
> >> =3D=3D=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D=3D
> >>
> >> But if you look at the logs [1], there are probably 3 last things to
> >> improve:
> >>
> >> [1] https://api.cirrus-ci.com/v1/task/4993794666921984/logs/test.log
> >>
> >> This line is repeated 90+ times:
> >>
> >>   tc action pedit offset 162 out of bounds
> >>
> >> (we talked about this one at the last meeting with ideas on how to
> >> reduce/get rid of them)
> >>
> >=20
> > Dose 'tc + iptables' work for our case?
> >=20
> > Use iptables to select the packets with enough data. Then use tc to
> > edit the selected packets only. (I don't know how to do it yet.)
> >=20
> > Here's a link about this:
> >=20
> > https://wiki.archlinux.org/title/advanced_traffic_control#Using_tc_+_ip=
tables
> > .
> > '''
> > Using tc + iptables
> >=20
> > Iptables has a method called fwmark that can be used to mark packets
> > across interfaces.
> >=20
> > First, this makes packets marked with 6, to be processed by the 1:30 cl=
ass
> >=20
> > # tc filter add dev eth0 protocol ip parent 1: prio 1 handle 6 fw flowi=
d 1:30
> >=20
> > This sets that mark 6, using iptables
> >=20
> > # iptables -A PREROUTING -t mangle -i eth0 -j MARK --set-mark 6
> >=20
> > You can then use iptables normally to match packets and then mark them
> > with fwmark.
> > '''
>=20
> Good idea, probably simpler!
>=20
> I guess we can mark some packets in POSTROUTING and modify the egress TC
> rule.
>=20
> Do you need a hand for that?
>=20

Thanks, Matt, I really need your help :)

> >> But also this one now, repeated 40+ times with different offsets:
> >>
> >>   file received by server has inverted byte at 106565
> >>
> >=20
> > These inverted byte logs will not be there if we add the code to drop
> > the bad data in future. (I haven't figured out how to implement this
> > yet.) Right now, just let them be there.
>=20
> I see. I guess later, when the code to drop the bad data in the future
> will be ready, this "warning" will become an "error" we will no longer
> ignore.
>=20
> >> And one last thing, we can see that now we have more than 99 tests, th=
e
> >> alignement is no longer OK :)
> >>
> >>
> >>   # 101 1 MP_FAIL, single subflow            syn[ ok ] - synack[ ok ].=
..
> >>   #                                         sum[ ok ] - csum  [ ok ]
> >>   #                                         ftx[ ok ] - frx   [ ok ]
> >>   #                                         itx[ ok ] - irx   [ ok ]
> >>
> >> A very small detail, up to you to fix it or not ;)
> >>
> >=20
> > I'll update this in the next version.
>=20
> Thanks!
>=20
> Cheers,
> Matt
> --=20
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>=20

