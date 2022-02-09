Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56BE2C80
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 06:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644387790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kPfbix199UfI8EqROV14g/AFkug1WGV2Jytwxxrk7w8=;
	b=OvT+oPcHWMWz7mAM7Ak9HGzUaDVy/TZt2pdpNAgtyHkmqAC3TIXhKSWM3yZsCrnHraDFFI
	rAYYp1uS05Hhsw/ynGx3+I4eqc30upKQwxMU0JfqtXujheUbXV3YrdZM2NK1jvOwSi1QID
	mD0J7OHGs01xVy8HyLeAvFAoA5Y0fa0=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2053.outbound.protection.outlook.com [104.47.14.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-26-yPdPwDj4NtOCmcsjW4Xy6w-1; Wed, 09 Feb 2022 07:23:09 +0100
X-MC-Unique: yPdPwDj4NtOCmcsjW4Xy6w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5KLBx33lQNfhqnwOXjlWu5m2xMQrDHDyYH7gfdOu+LIfQIw5QEgmh+kbPOXkGGxFIt7DL6ixfrBOki+HgcL4jWd/QKAAvxigmNHFRSeis9g+z9JHpNDb/3J0B/tdA4K/zYhfiEpM6/U2FfmINNYx5BEX7bSXH3PHwErpqJZw8/NhFWoIUMv1Prj3FDpMuohEnAgSRMXxbvz/Gwt6eGJzT6AQtBTcgHefhBcl+ee/7h7N2r5QghTiMN0t+Q6sa2brHxGARwpLSLlJstotXEGMBe0lTp4KRtVk6Vc89Ac2UWNYXvOWL2Aj22zFYrTJb31lxGY9ZuKwYwt+IM5gVts8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bh8+EdrWwXt5QfBGTgENhc1V+9bUy5WHkHCMCa/1E3I=;
 b=CPyYWrUzZuSqmeKqNRKsTKpiZXKZaebU32O+YK4xOSsq8SfeZOJqq0wKa9nqMQkjvOcacd+D33LuVHyr11YmqGlahiqWpOOpPJ27wXDfmcnx3vWfsV6ieSVjMFAhFsrzxz0Eup3wJL8R8RADCryhgYJK9jO/G6F4RcCUVXVMnSiEVf0TZ/pVxT+2qLPN4XiW757vWMvqZ1M0eqIVqOnTTYU27BnnSG1GkNnSi9L7I6d0om1fi/pr6JEd7Qj1QX0lQYDq/6W+67McJ282h38Ry0dBDjuS6NjY4RYTmfCgOtUqw+tEbbZ/nfORXimQ/y5qipD2yWM8q0f9FhNweWrgSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6997.eurprd04.prod.outlook.com (2603:10a6:20b:10d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 06:23:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 06:23:08 +0000
Date: Wed, 9 Feb 2022 14:23:33 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
CC: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 3/3] selftests: mptcp: add mp_fail testcases
Message-ID: <20220209062333.GA24258@dhcp-10-157-36-190>
References: <064cfe306debc535413c1d39fcf3b8d24a959eeb.1643110285.git.geliang.tang@suse.com>
 <b4708d63-29aa-da51-f536-3b5bf5399221@linux.intel.com>
 <a5500825-43a0-93c4-ba92-f3a24d4a202c@tessares.net>
 <CA+WQbwtY-qKu+_yNGcq3g5wDu7ZD0WwpSDbT7n1SLdw0ZtxwrA@mail.gmail.com>
 <eb33b5d3-a6e8-55d0-a149-c045ec2ecab5@tessares.net>
 <20220207140854.GA2916@localhost>
 <63c6dc9c-fa32-cf8b-2f5d-4fc5c51447b2@tessares.net>
 <20220208154110.GA28531@localhost>
 <20746295-b038-b485-ea6f-4f14dc7bf1cd@tessares.net>
 <924ab674-30b0-790e-32cc-fe33f0c8ca85@tessares.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <924ab674-30b0-790e-32cc-fe33f0c8ca85@tessares.net>
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
X-MS-Office365-Filtering-Correlation-Id: 0aac2448-5e0d-4344-d20a-08d9eb94a33f
X-MS-TrafficTypeDiagnostic: AM7PR04MB6997:EE_
X-Microsoft-Antispam-PRVS:
	<AM7PR04MB6997D49A7FDCF9D48EC5FE85F82E9@AM7PR04MB6997.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YNHWq9ayM4RZkasJLQlnB5eF/bxR9tWMbQGDPJb+OZ/n3MWgFoLNIrBv0uwiaNVEIYKpyKcg29lrSyf9Eg5g5kNLSuV/E+daHsNqGcRFSXDQmzVH89+NJVHWqDO+XWm2lQHKOsjTXNdb8sOJuyb7BlpIIryyTFBI53+Qx+l9vxZHAIcOsWLdW7Wh6e2UXS4tSK3gH/z9yMI5XNPxniTiljhNA5J79TF/KNA7Nl/1B0EosWtr8LgerXMu7zMDyF9GBKt/LE/xISKfdYMRNXG98DjMWmCDPXrBbEuC6DD0AlrRO4sKQeHGFPKTjWYjzD0uZGI5OWcD+ld+QpFJWbR20epkC1AJWkZ51C17TWWXsDvlrySWuT6NoDEzls9hqFBDxG5emvwoWHEBTosuS17tz1IApLuYAqzg20oui4NYgetMu3DPF70pKhn7Hbe8XyN8ZTCmmgbKNk8ggm4o6oXvC2qA5g0A8IKkFvdjfLlX+4H+TRfUcNGdCbSdyNPeksDr1k6LykCo8k6PkWMBWYhmjq9tJUzd1GU0gJ3abUZsgM/4XFBOpoFXJZbhLcof1swyJmHIFMOxCGIKKGVkmcOf4r65YzMIt/CZ+enH7oviQxcmS2XolKwN185lbGjW8j/4XuPNoX7+vBcbeeje9LAOJ0w7R01GbjzhobPA6xNvRAtBwhkkv5ZZ0AYE8SFnr+8Yy2s4Z57PkfjF7Qo7D9wX5qfRNktP5kccnQ7ddSqjiCQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(84040400005)(66946007)(66556008)(9686003)(8936002)(508600001)(2906002)(5660300002)(966005)(86362001)(6486002)(186003)(30864003)(55236004)(6512007)(66476007)(4326008)(8676002)(53546011)(38100700002)(44832011)(83380400001)(6666004)(316002)(19627235002)(1076003)(6506007)(33716001)(33656002)(26005)(15974865002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hmlic5jjmT6s80QcGyqWr17u136NAcsx1lOMuCuie9RB0sbOlB5iQuiIcdax?=
 =?us-ascii?Q?qE/AMvPoZBIgeeQ+I3Jl9TjqL0bQcg/f/qBin10zUzT5A/uPI8E8ExuF+cQF?=
 =?us-ascii?Q?1EEi7EAPmo7+6J5FxasbIHgEXvsENsSad8Ep3RZjvxgBe6C05gAGNrRzo2o9?=
 =?us-ascii?Q?doUy6hLb0zPYKOkNTMJsh+YVJBYKYJKpggWSR4azn0CPE4D7kOnt9UYp6/AP?=
 =?us-ascii?Q?tU8fFNht1x8df4FKD649I0ACMgyg0F0XuB01F9WBzfTXteSFXpNi78h4iKS1?=
 =?us-ascii?Q?Y8LMtAP7EBihmw7LPter2xv2HEe8xqrYmvhhdk7R3sXh54e/1eTqPdynC5dD?=
 =?us-ascii?Q?7fm6BswbRhoH48izZlY2e76SXws38TOgbq9zf32H4zRpsVyDLNcSX49y4cOk?=
 =?us-ascii?Q?Nbb8U0dl8IoqcPC3ZhjGopT3ixaXRc1QFKUfgrUUAMiBCnMWVP284RiqPe2n?=
 =?us-ascii?Q?0TH8dRaKi5Uj8hIUiUPxdvH12PZp2U/3fK0fi+E/3JLKkfI1ZcrLlX8juHy3?=
 =?us-ascii?Q?WMFLiiwgQG7iF4ITYmaZ0uRMv0Qh1WJPHP4jG/NR+4uvvzTIxO7UiUc7pa3s?=
 =?us-ascii?Q?L1+GxPhYkljQc4GzXCv8cl55MrCeeZ9B7coqAMvylHwpJHzxY1PSEDf/tAEU?=
 =?us-ascii?Q?EkvEECHKbW13sybU7b95Sc6brWuvjvbZDYLXFmJskHZzTuJ4gH320BeaDcnp?=
 =?us-ascii?Q?3e4PYyu0kqPp+nED2lEks/yt5EczIT7I2CwxvOW2/IP6loBLghTQ+0HWC0b3?=
 =?us-ascii?Q?57P/xOTA51R1qQ+KsN6gwN17ktRQEK0BbGNdKGwFyBppxP6xqcwE0R9jOqcK?=
 =?us-ascii?Q?NxRVyNhTvJuJ36EPRwmIWoZ3XMWJCmpIMayxWmqj6VWUsL54rOEeWJd7p7zz?=
 =?us-ascii?Q?6MJXBq3JW4uilS0oEj1hmp7+qUyQnQjAYaDhI1ouO2A7IK/EBrp6NZm9492t?=
 =?us-ascii?Q?fMhbHRugV01Bd8rzJGenVUY7YztIaEXZ+fsG+Z2c4wLGKt2k7MRyAku4C7qz?=
 =?us-ascii?Q?QbHxScQxMaxeJaXskG2LX+hgEOmECD+sdSgcr8j0+pE29HFXfmQbydHD2Fbf?=
 =?us-ascii?Q?ximNQgsXKq8DkYKnuMXxG5w2dONulpF5CH4YkK4fqYVuRtrMry1BlEWXO0k/?=
 =?us-ascii?Q?/OliHNGxSlg7ZYMXB1RreyURQMhihq6SmY0lgVgfKjzMXg8yWqZgcgg6xY8a?=
 =?us-ascii?Q?mTFLPr3kWs0JIXUn6nXHROdVR7thvwGUfrFxTXu18Sa58SCpEx30+BQWZSJ+?=
 =?us-ascii?Q?p9GXL8wadPWYNsmbHQrza68hfp50cyqWyHdqlaspbSJI34NRG2Xls4PtQ1m+?=
 =?us-ascii?Q?qgydFeHVMRrJtBjcdrJQdMMfDwceLy+ms8o0F4f3mQ/0to0Wk1EkR7wMreOf?=
 =?us-ascii?Q?0VIITWGvc5mTVme60meaFilEpXc77JmCpDK3ZmsSsM+baU6zapLRvoX8iWgh?=
 =?us-ascii?Q?0Pzh/K7lpSpmuimJQQoxuu9ZAw44OtUJl0LWWCv+CIvv0LX9Wq/gOIh821BK?=
 =?us-ascii?Q?VB5grYCUQj3CW1sNmUAMulH5KNtZfu7nI4E6ce99zQMGHa0l6UP/WgWXNuMA?=
 =?us-ascii?Q?YZYMFfqhhndfQpzpZOQCIAXH6M6CyVmsI2LtxtZkz+J1l7Ajg5bygo/ncXAv?=
 =?us-ascii?Q?N2/lnbzeuE1L18gD1hsOrfE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aac2448-5e0d-4344-d20a-08d9eb94a33f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 06:23:07.9628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vqQy2nFtrk85iLV7/5/tcjRHJvPVtGCQnoegnGEMkRniWSOIUD3LLh/D3L96bWsxC3K3M+NrPkEBfcdXqMR2HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6997

On Tue, Feb 08, 2022 at 08:40:13PM +0100, Matthieu Baerts wrote:
> Hi Geliang,
>=20
> On 08/02/2022 17:24, Matthieu Baerts wrote:
> > Hi Geliang,
> >=20
> > On 08/02/2022 16:41, Geliang Tang wrote:
> >> Hi Matt, Mat,
> >>
> >> On Tue, Feb 08, 2022 at 01:26:10PM +0100, Matthieu Baerts wrote:
> >>> Hi Geliang,
> >>>
> >>> On 07/02/2022 15:08, Geliang Tang wrote:
> >>>> On Mon, Feb 07, 2022 at 11:32:05AM +0100, Matthieu Baerts wrote:
> >>>>> Hi Geliang,
> >>>>>
> >>>>> On 07/02/2022 05:13, Geliang Tang wrote:
> >>>>>> Hi Matt,
> >>>>>>
> >>>>>> Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2022=E5=B9=
=B41=E6=9C=8829=E6=97=A5=E5=91=A8=E5=85=AD 01:04=E5=86=99=E9=81=93=EF=BC=9A
> >>>>>>>
> >>>>>>> Hi Mat, Geliang,
> >>>>>>>
> >>>>>>> On 27/01/2022 01:07, Mat Martineau wrote:
> >>>>>>>> On Tue, 25 Jan 2022, Geliang Tang wrote:
> >>>>>>>>
> >>>>>>>>> Added the test cases for MP_FAIL, use 'tc' commands to trigger =
the
> >>>>>>>>> checksum failures.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> This patch is working well with the inverted byte detection, tha=
nks!
> >>>>>>>
> >>>>>>> The public CI seems quite happy with the new version, good work :=
)
> >>>>>>>
> >>>>>>> Here is its report:
> >>>>>>>
> >>>>>>> =3D=3D=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D=3D
> >>>>>>> Our CI did some validations and here is its report:
> >>>>>>>
> >>>>>>> - KVM Validation: normal:
> >>>>>>>   - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
> >>>>>>>   - Task: https://cirrus-ci.com/task/4993794666921984
> >>>>>>>   - Summary:
> >>>>>>> https://api.cirrus-ci.com/v1/artifact/task/4993794666921984/summa=
ry/summary.txt
> >>>>>>>
> >>>>>>> - KVM Validation: debug:
> >>>>>>>   - Unstable: 2 failed test(s): selftest_diag selftest_mptcp_join=
 =F0=9F=94=B4:
> >>>>>>>   - Task: https://cirrus-ci.com/task/4682233209421824
> >>>>>>>   - Summary:
> >>>>>>> https://api.cirrus-ci.com/v1/artifact/task/4682233209421824/summa=
ry/summary.txt
> >>>>>>>
> >>>>>>> Initiator: Patchew Applier
> >>>>>>> Commits:
> >>>>>>> https://github.com/multipath-tcp/mptcp_net-next/commits/c52e51136=
372
> >>>>>>> =3D=3D=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D=3D
> >>>>>>>
> >>>>>>> But if you look at the logs [1], there are probably 3 last things=
 to
> >>>>>>> improve:
> >>>>>>>
> >>>>>>> [1] https://api.cirrus-ci.com/v1/task/4993794666921984/logs/test.=
log
> >>>>>>>
> >>>>>>> This line is repeated 90+ times:
> >>>>>>>
> >>>>>>>   tc action pedit offset 162 out of bounds
> >>>>>>>
> >>>>>>> (we talked about this one at the last meeting with ideas on how t=
o
> >>>>>>> reduce/get rid of them)
> >>>>>>>
> >>>>>>
> >>>>>> Dose 'tc + iptables' work for our case?
> >>>>>>
> >>>>>> Use iptables to select the packets with enough data. Then use tc t=
o
> >>>>>> edit the selected packets only. (I don't know how to do it yet.)
> >>>>>>
> >>>>>> Here's a link about this:
> >>>>>>
> >>>>>> https://wiki.archlinux.org/title/advanced_traffic_control#Using_tc=
_+_iptables
> >>>>>> .
> >>>>>> '''
> >>>>>> Using tc + iptables
> >>>>>>
> >>>>>> Iptables has a method called fwmark that can be used to mark packe=
ts
> >>>>>> across interfaces.
> >>>>>>
> >>>>>> First, this makes packets marked with 6, to be processed by the 1:=
30 class
> >>>>>>
> >>>>>> # tc filter add dev eth0 protocol ip parent 1: prio 1 handle 6 fw =
flowid 1:30
> >>>>>>
> >>>>>> This sets that mark 6, using iptables
> >>>>>>
> >>>>>> # iptables -A PREROUTING -t mangle -i eth0 -j MARK --set-mark 6
> >>>>>>
> >>>>>> You can then use iptables normally to match packets and then mark =
them
> >>>>>> with fwmark.
> >>>>>> '''
> >>>>>
> >>>>> Good idea, probably simpler!
> >>>>>
> >>>>> I guess we can mark some packets in POSTROUTING and modify the egre=
ss TC
> >>>>> rule.
> >>>>>
> >>>>> Do you need a hand for that?
> >>>>>
> >>>>
> >>>> Thanks, Matt, I really need your help :)
> >>>
> >>> Sure.
> >>> May you try the attached patch if you don't mind?
> >>
> >> Great! Thanks Matt. I just tested your patch, the single subflow test
> >> ("002 1 MP_FAIL, single subflow") works well. And very stable. The two
> >> issues that I mentioned in the cover letter of this series didn't happ=
en
> >> when running this new selftest. So the first two squash-to patches in
> >> this series can be dropped.
> >=20
> > That's nice! Thank you for having tested, I'm glad it helped!
> >=20
> >> Mat, it looks like no need to analyse my attached pcaps any more. Than=
ks
> >> for your help.
> >>
> >>>
> >>> I now have this output:
> >>>
> >>> 001 0 MP_FAIL, multiple subflows         syn[ ok ] - synack[ ok ] - a=
ck[
> >>> ok ]
> >>>                                          sum[ ok ] - csum  [ ok ]
> >>>                                          ftx[ ok ] - frx   [ ok ]
> >>>                                          itx[ ok ] - irx   [ ok ]
> >>
> >> But the multiple subflows test ("001 0 MP_FAIL, multiple subflows") do=
esn't
> >> work. I'll try to fix it tomorrow. I think it's easy to fix.
>=20
> Yes, we need to restrict the 'iptables' command to the same interface as
> the one used with the TC command. Otherwise we will mark a flow for
> another interface and TC will never see a marked packet for this interfac=
e.
>=20
> > Yes, it looked strange to me. I guess the test should fail if 'nr_fail'
> > is set to 0, no?
> > Or probably we should no longer use 'get_nr_fail' as we expect to have
> > only one MP_FAIL, no?
> >=20
> > In the IPTables rule I added, I asked to mark the first packet that is
> > over 150 bytes. We can change "--packet" if we want to mark the Xth one=
.
> > And "--every" if we have more packets but worst case, that's not an
> > issue to corrupt another one I think: on this path, either we have no
> > more subflow (multiple subflows case) or no more MPTCP connection (1
> > subflow case).
> >=20
> >>
> >> Thanks,
> >> -Geliang
> >>
> >>> Created /tmp/tmp.SNhvH7ucj9 (size 512 KB) containing data sent by cli=
ent
> >>> Created /tmp/tmp.RFEqEXi0bl (size 512 KB) containing data sent by ser=
ver
> >>> file received by server has inverted byte at 69
> >>> file received by server has inverted byte at 70
> >>> file received by server has inverted byte at 71
> >>> file received by server has inverted byte at 72
> >=20
> > We can also modify the TC command to invert only a u8 instead of a u32
> > to reduce the log entries here.
>=20
> While at it, I also applied the suggestions I made here and above,
> please see the attached patch. You can see a diff with the previous
> version I sent here: https://paste.opendev.org/show/812608/

Thanks Matt, I merged your patch in v2, and sent it to ML this morning.
And iterated a v3 according to Mat's suggestion.

The only difference is I kept nr_fail (now renamed to pedit_action) in
v3. It's useful for the cases that the pedit action did't happen.

Thanks,
-Geliang

>=20
> Cheers,
> Matt
> --=20
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net

> diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/sel=
ftests/net/mptcp/config
> index 26955abe49f0..38021a0dd527 100644
> --- a/tools/testing/selftests/net/mptcp/config
> +++ b/tools/testing/selftests/net/mptcp/config
> @@ -12,6 +12,9 @@ CONFIG_NF_TABLES=3Dm
>  CONFIG_NFT_COMPAT=3Dm
>  CONFIG_NETFILTER_XTABLES=3Dm
>  CONFIG_NETFILTER_XT_MATCH_BPF=3Dm
> +CONFIG_NETFILTER_XT_MATCH_LENGTH=3Dm
> +CONFIG_NETFILTER_XT_MATCH_STATISTIC=3Dm
> +CONFIG_NETFILTER_XT_TARGET_MARK=3Dm
>  CONFIG_NF_TABLES_INET=3Dy
>  CONFIG_NFT_TPROXY=3Dm
>  CONFIG_NFT_SOCKET=3Dm
> @@ -22,5 +25,5 @@ CONFIG_IPV6_MULTIPLE_TABLES=3Dy
>  CONFIG_NET_ACT_CSUM=3Dm
>  CONFIG_NET_ACT_PEDIT=3Dm
>  CONFIG_NET_CLS_ACT=3Dy
> -CONFIG_NET_CLS_FLOWER=3Dm
> +CONFIG_NET_CLS_FW=3Dm
>  CONFIG_NET_SCH_INGRESS=3Dm
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index a51b0915b7b1..ae50d64186c2 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -18,7 +18,6 @@ checksum=3D0
>  ip_mptcp=3D0
>  check_invert=3D0
>  validate_checksum=3D0
> -nr_fail=3D0
>  do_all_tests=3D1
> =20
>  TEST_COUNT=3D0
> @@ -172,23 +171,20 @@ reset_with_allow_join_id0()
> =20
>  # Modify TCP payload without corrupting the TCP packet
>  #
> -# This rule inverts a 32-bit word at byte offset 148 for all TCP ACK
> -# packets carrying enough data.
> -# Once it is done, the TCP Checksum field is updated so the packet
> -# is still considered as valid at the TCP level.
> -# But because the MPTCP checksum, covering the TCP options and data,
> -# has not been updated, we will detect the modification and emit an
> -# MP_FAIL: what we want to validate here.
> +# This rule inverts a 8-bit word at byte offset 148 for the 2nd TCP ACK =
packets
> +# carrying enough data.
> +# Once it is done, the TCP Checksum field is updated so the packet is st=
ill
> +# considered as valid at the TCP level.
> +# Because the MPTCP checksum, covering the TCP options and data, has not=
 been
> +# updated, the modification will be detected and an MP_FAIL will be emit=
ted:
> +# what we want to validate here without corrupting "random" MPTCP option=
s.
>  #
> -# Please note that this rule will produce this pr_info() message for
> -# each TCP ACK packets not carrying enough data:
> +# To avoid having tc producing this pr_info() message for each TCP ACK p=
ackets
> +# not carrying enough data:
>  #
>  #     tc action pedit offset 162 out of bounds
>  #
> -# But this should be limited to a very few numbers of packets as we
> -# restrict this rule to outgoing TCP traffic with only the ACK flag
> -# + except the 3rd ACK, only packets carrying data should be seen in
> -# this direction.
> +# Netfilter is used to mark packets with enough data.
>  reset_with_fail()
>  {
>  	reset
> @@ -198,14 +194,22 @@ reset_with_fail()
> =20
>  	check_invert=3D1
>  	validate_checksum=3D1
> -	nr_fail=3D0
> -	i=3D"$1"
> +	local i=3D"$1"
> +
> +	ip netns exec $ns2 iptables \
> +		-t mangle \
> +		-A OUTPUT \
> +		-o ns2eth$i \
> +		-p tcp \
> +		-m length --length 150:9999 \
> +		-m statistic --mode nth --packet 1 --every 99999 \
> +		-j MARK --set-mark 42
> =20
>  	tc -n $ns2 qdisc add dev ns2eth$i clsact
>  	tc -n $ns2 filter add dev ns2eth$i egress \
>  		protocol ip prio 1000 \
> -		flower ip_proto tcp tcp_flags 0x10/0xff \
> -		action pedit munge offset 148 u32 invert \
> +		handle 42 fw \
> +		action pedit munge offset 148 u8 invert \
>  		pipe csum tcp \
>  		index 100
>  }
> @@ -228,12 +232,6 @@ if [ $? -ne 0 ];then
>  	exit $ksft_skip
>  fi
> =20
> -jq -V > /dev/null 2>&1
> -if [ $? -ne 0 ];then
> -	echo "SKIP: Could not run all tests without jq tool"
> -	exit $ksft_skip
> -fi
> -
>  print_file_err()
>  {
>  	ls -l "$1" 1>&2
> @@ -294,21 +292,6 @@ link_failure()
>  	done
>  }
> =20
> -get_nr_fail()
> -{
> -	i=3D"$1"
> -
> -	local action=3D$(tc -n $ns2 -j -s action show action pedit index 100)
> -	local packets=3D$(echo $action | jq '.[1].actions[0].stats.packets')
> -	local overlimits=3D$(echo $action | jq '.[1].actions[0].stats.overlimit=
s')
> -
> -	let pkt=3D$packets-$overlimits
> -	if [ $pkt -gt 0 ]; then
> -		nr_fail=3D1
> -	fi
> -	tc -n $ns2 qdisc del dev ns2eth$i clsact
> -}
> -
>  # $1: IP address
>  is_v6()
>  {
> @@ -2259,16 +2242,14 @@ fail_tests()
>  	pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
>  	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
>  	run_tests $ns1 $ns2 10.0.1.1 3
> -	get_nr_fail 2
> -	chk_join_nr "$nr_fail MP_FAIL, multiple subflows" 2 2 2 $nr_fail
> +	chk_join_nr "MP_FAIL, multiple subflows" 2 2 2 1
> =20
>  	# single subflow
>  	reset_with_fail 1
>  	pm_nl_set_limits $ns1 0 2
>  	pm_nl_set_limits $ns2 0 2
>  	run_tests $ns1 $ns2 10.0.1.1 4
> -	get_nr_fail 1
> -	chk_join_nr "$nr_fail MP_FAIL, single subflow" 0 0 0 $nr_fail 0
> +	chk_join_nr "MP_FAIL, single subflow" 0 0 0 1 0
>  }
> =20
>  all_tests()

