Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D8B68
	for <mptcp@lists.linux.dev>; Thu,  4 Nov 2021 10:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1636021804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QT6d81PZStOqXJxIhaABezkFKs+O61xFwKIfTcXV/Lw=;
	b=K+ekFyikP6vUJm69D/xZN7KgiJQuUBRAewVugEMMJnu6r+ORvUADiPiPKHq9x0W+HLhZYZ
	KoASiZO5aevu80GQqQ6AnGjdra4GPfTEDgwJIo1szGSq+E7Os6rCY3RkSd8f8ALK9bbMs8
	WH30TUUCAr/2p3ueWAbumC2G8xNvIoQ=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2059.outbound.protection.outlook.com [104.47.2.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-17-cUihOk6zPoOz4SuemMaM9g-1; Thu, 04 Nov 2021 11:30:03 +0100
X-MC-Unique: cUihOk6zPoOz4SuemMaM9g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDr8CJ5rLID3bn5JgNehDqjAlzqmIr57tT4w9q3szAOib81cqGwpM7l+wL2weL2yyWBAyMyJZP6F+iP7NB6DPWFa93CSWSS79SvZGpse4Oe+tF6pwgcVsmODoTmsOcfn2pz0KWYPFZSiCKofT9XMrZGA2hvoeF9vwUhChbMYQ4fyAukjlRC4i3PiKSsLfMzI01vCETGRFzIiRW8dOd8n88Iw1zRgwuNvAp7fSIYqulC4vSBhRspgIRshLH3vwtcWJxpmXMDALpzyO9b0yAyKXjOw1cG0PevEXVTOixL+83N4vxrNDR2QEmx5Trgy1SAw7G6q0Y99vFpQ2dR7brmE3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7B017VBRz2ynbQoUwHKbTmCRi9jed/cdcTXTbrOPrY4=;
 b=Gva/KQPGKQn8Rk9TCSVXH7z7bOqz1n+wGOkdIp+i6iQdmOiUcn5THkwiXweul6lQ57TjqBy14OIrPC+78SH0/X5P0WH0BrJ53/1VP5r7yWNhXEOSnxjttBU3LPvLccWdlo7XHVHwZ5GcSoIQ3JxNzQljMhFzXD4U+9540d2+/HnBN9YYZnfews2Ki6LpK1CwauDL5FLvgn8hKICRTQO06KLt2FPnbVx58F8e/4GgtFpQG1abhy1WF9jI1/BnoNVENkM7tSCkEnNs1Phgs6oz0Le/BmM+s4N3utSAZdoeQkkFM1GjSmNZAaLcixjMniEfMCpwhSgKnGVIAsYmEaYeww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB2715.eurprd04.prod.outlook.com (2603:10a6:3:d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 4 Nov
 2021 10:30:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af%6]) with mapi id 15.20.4669.013; Thu, 4 Nov 2021
 10:30:00 +0000
Date: Thu, 4 Nov 2021 18:30:03 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
CC: Davide Caratti <dcaratti@redhat.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v8 8/8] selftests: mptcp: add mp_fail testcases
Message-ID: <20211104103003.GA5555@dhcp-10-157-36-190>
References: <cover.1635481641.git.geliang.tang@suse.com>
 <ff613391540609e31cf4aff5abefaa03fbd63278.1635481641.git.geliang.tang@suse.com>
 <32bda041-3193-ac47-3d4e-5a7a7e5371c0@linux.intel.com>
 <f4467f1a-ddae-92b6-48f5-30ab03dfc77f@tessares.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f4467f1a-ddae-92b6-48f5-30ab03dfc77f@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR02CA0220.apcprd02.prod.outlook.com
 (2603:1096:201:20::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by HK2PR02CA0220.apcprd02.prod.outlook.com (2603:1096:201:20::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 10:29:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62a5689d-6ee4-43b4-beef-08d99f7e0ddc
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2715:
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB2715DC66A11FB6E9A314A09AF88D9@HE1PR0402MB2715.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bTh2VTvU4oSDv4TZaqk/WfyIUSNSKQm7KYXhZbYqDUdJCCwuykjKdnDUBygcv0SrfKHaqr1MEMavpAUHWlijxsrgaF2y2LspZ/dfjCy0Wl6N0g7y9XSg6iqB+TVd1Pf1WKVYLQErdhXRYLKgl4qSaceaMg8NOER9iatzeHsdaHbk96YxtyuLqXOmCChxzIInEhJLQMnA8TmpwS2ExinpyjI11dvAaP8ZhrIV+abeDwRoOA0MXBteiwt8Q2F3S5UnDoolUY+CnzZaxzqgyrboYfsrZxBOEjqsbocXpjFmxrvanD0iuQO+1OPeVAYCowal++JPBPiOZOOaZXHDkcBiu+8dsU7pO1Z5GOgU3UKf3oWjgcFvujVtpenoQp2MLLs7BwpXQ4hrY+ytRKiuw/jXhIiwWKy2tkTYb3VuQwLbWmxOY+sMWSPFydpXk/Zr+lSKe3Z3ppa1k0D3DQx0/Dp81VHYhtm1o1zxCrgVFVcvB+CZBaprSdAzH9cq1e4BW3o3oFIQbZ8pPVgIaAhK3amzPyAYq//HWwtQ+EN9rlg+4JicdLbWlVFTRpqThm7S9ZKNdRFD74Bz3S+6p9uiWNRds6g1FVV/F7pigvF7Hf7bg9LbcRLgQZdiX+TDqwMgznaMQ9p/DGf3y2g2ljs2FoDzSR1zn+5fCZZIixRH6+ZczqL39OXFZvLSMwaz2PbdnJuo61luEwt4zo7heCi9aF/bbGA6hS3i2Wjq62ExJa8Y/34=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(55236004)(33716001)(316002)(2906002)(4326008)(33656002)(15974865002)(6496006)(1076003)(86362001)(66946007)(8676002)(66556008)(186003)(66476007)(26005)(83380400001)(6486002)(30864003)(53546011)(8936002)(19627235002)(44832011)(38100700002)(5660300002)(9686003)(956004)(6666004)(508600001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E1QLel+c8Sob3p7njcymp3DMJrV5LtCIJclFgrt6vTnfBlPpI4ACMKwWf5eI?=
 =?us-ascii?Q?2KHb/LLX+DaJxdlSThGywk79dTilRQHUBOfqLF3N0F12sWjhz/IgGY1G/mu0?=
 =?us-ascii?Q?qFK9lVi5mILk76u7b3gkfyYzLEbnqUElMnsiQlYSKX1Ov+O0MUjWNhvNJE5e?=
 =?us-ascii?Q?9gIl3gQyz5nAhy6YXcN9ABR010KbA23ZL7PRr0Jis97gorr87yROaNuTKFgR?=
 =?us-ascii?Q?fuNBkAdBYJtQC9w6RThjoJbtlUxFud3idyhZXQ/rv4qIAmkTAxPQWbLmOMXe?=
 =?us-ascii?Q?QVOn1mJyXEcWXC/LQdZNX6rNb+UZGb/zmEXo/SkElxxZGzXxEeEMucjWJFj8?=
 =?us-ascii?Q?jo4rb4WOOjgVX1nKhRzp897sAuPvCmhBltIw1/nuuTA6QqlGTT3TmZaFSirl?=
 =?us-ascii?Q?dukXryL1wfVrTq+/EUiflKu7dSi1cDpY8OKOWKoUuFhWXAGrTaIuH5AAnp9H?=
 =?us-ascii?Q?613MjoSBqurfotmE1mK6MajTh+0uE0yyTsiRfD184uyBo5dDhm03MlgO1jpS?=
 =?us-ascii?Q?MQT+vQwi4QrZXAWxW0pn/IGN/Kv8nJEmltT0u46sM8C9GVTZvv5A4p/Sfk1N?=
 =?us-ascii?Q?nnydXnOokdBOqphDmq+S6IQnu4b0c1N/ePgtUsLkinr0WWw1txxQbw9826jb?=
 =?us-ascii?Q?/wGjApbMKdrzD+qfLs6kerCIKjbup6bK7kEadioVq7stZ1JcKws1WEi+VlQ/?=
 =?us-ascii?Q?OGRai4WKosVQgR5tlaqX5fkoGoOKk5wmhv4ahXXVubpGv14z/rQV8NhTYjrZ?=
 =?us-ascii?Q?+yVtt/mOUWiuBoUsX6eK54BLswwkGQwFyHasRq5Lj7wll4+ggLTGwjF87sCg?=
 =?us-ascii?Q?c/4SjEJu55s38Q1NpAw6V2neF2eNSLSZcRumqJklltBqyyb315oFkd2MF3MQ?=
 =?us-ascii?Q?GfkesL0yndW/pNtwUwx90aC/njb75ldy65S0lnj/rhkp/yoTiC7mPmOXxvrz?=
 =?us-ascii?Q?0z+p64vHPvwZ5bmPBdcJJRIZ4nKf0TgyC77AtHTaaZtFGc042VIYz3t+7Qzn?=
 =?us-ascii?Q?E0Wl8+697yKotX+qRVYV/Mg7paDlTYxOVI38ef/7hZrvI29XzAdQ9KKoY1pE?=
 =?us-ascii?Q?5G+X/8Mn1NbYgViNiC2Pivjv48v5fc5M7B4xFUcCtNSxE62q8YiaRQP44F0R?=
 =?us-ascii?Q?P3m2B2Zjt3ROjoJD9+p+t7WG6JicIf4b4vMnDM86K7yeWTGa7KDtXRm8fNDZ?=
 =?us-ascii?Q?VUhm95pCeChlJqTKGnc/okEtp7Z0nWBwVbXg/LArPJA2fXi/A74p8kk2HWTL?=
 =?us-ascii?Q?VdlyTf9LR6PTYF2ocXDSBnaPpKa/XICHBkvVMANbh+W5O058K6TRK291LOlj?=
 =?us-ascii?Q?+o6By9UxqhQmzTt4S883yZ63hZezU+LtBKLTudpy4qDcgYIgMftTDxaSJdNA?=
 =?us-ascii?Q?XPv2PJYJJq9/hEeit4qYeN8aV599TTEmOLgCW4o0JccNAkWhibu5g8Tb2Hgd?=
 =?us-ascii?Q?dPjOib5vbRsW01wvi98/DT7NYIqHX+edMAWqV4sUBD0RV/5X+2mRGGJHZSAI?=
 =?us-ascii?Q?qLCgTB2jppWw9q4Hr13dVN3kZx7X+gxTt9DvkR4F/DuHhaHYRxEpq4Ksxf0e?=
 =?us-ascii?Q?zysg5v2KwDXRB0DevrTIduyAxfabCuig1PxiyUGUK2dE2XvRPv/pc1sa2WF6?=
 =?us-ascii?Q?SCO8WIPQgD+vNUE45dol6Q8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a5689d-6ee4-43b4-beef-08d99f7e0ddc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 10:30:00.0470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mN/25GIEyY2EMlr+r1t2pC+84leTtOMsv8Cuq1oPrTMxKWoiLd4iZgShJ1qiUynj8E0HBYv8zoQo7qHxopFzzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2715

Hi Matt, Davide,

On Thu, Nov 04, 2021 at 10:14:35AM +0100, Matthieu Baerts wrote:
> Hi Geliang,
>=20
> On 04/11/2021 01:43, Mat Martineau wrote:
> > On Fri, 29 Oct 2021, Geliang Tang wrote:
> >=20
> >> Added the test cases for MP_FAIL, use 'tc' command to trigger the
> >> checksum failure.
> >>
> >> Suggested-by: Davide Caratti <dcaratti@redhat.com>
> >> Suggested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> >> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> >> ---
> >> tools/testing/selftests/net/mptcp/config=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 5 ++
> >> .../testing/selftests/net/mptcp/mptcp_join.sh | 75 +++++++++++++++++--
> >> 2 files changed, 72 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/net/mptcp/config
> >> b/tools/testing/selftests/net/mptcp/config
> >> index 0faaccd21447..f522288b2204 100644
> >> --- a/tools/testing/selftests/net/mptcp/config
> >> +++ b/tools/testing/selftests/net/mptcp/config
> >> @@ -15,3 +15,8 @@ CONFIG_NETFILTER_XTABLES=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_BPF=3Dm
> >> CONFIG_NF_TABLES_IPV4=3Dy
> >> CONFIG_NF_TABLES_IPV6=3Dy
> >> +CONFIG_NET_ACT_CSUM=3Dm
> >> +CONFIG_NET_ACT_PEDIT=3Dm
> >> +CONFIG_NET_CLS_ACT=3Dm
> >> +CONFIG_NET_CLS_FLOWER=3Dm
> >> +CONFIG_NET_SCH_INGRESS=3Dm
> >> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> >> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> >> index 2684ef9c0d42..d33cb5ce0ff3 100755
> >> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> >> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> >> @@ -178,6 +178,12 @@ if [ $? -ne 0 ];then
> >> =C2=A0=C2=A0=C2=A0=C2=A0exit $ksft_skip
> >> fi
> >>
> >> +jq -V > /dev/null 2>&1
> >> +if [ $? -ne 0 ];then
> >> +=C2=A0=C2=A0=C2=A0 echo "SKIP: Could not run all tests without jq too=
l"
> >> +=C2=A0=C2=A0=C2=A0 exit $ksft_skip
> >> +fi
> >> +
> >> print_file_err()
> >> {
> >> =C2=A0=C2=A0=C2=A0=C2=A0ls -l "$1" 1>&2
> >> @@ -232,6 +238,28 @@ link_failure()
> >> =C2=A0=C2=A0=C2=A0=C2=A0done
> >> }
> >>
> >> +checksum_failure()
> >> +{
> >> +=C2=A0=C2=A0=C2=A0 i=3D"$1"
> >> +
> >> +=C2=A0=C2=A0=C2=A0 tc -n $ns2 qdisc add dev ns2eth$i clsact
> >> +=C2=A0=C2=A0=C2=A0 tc -n $ns2 filter add dev ns2eth$i egress \
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 protocol ip prio 1000 \
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flower ip_proto tcp \
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 action pedit munge offset =
148 u32 invert \
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pipe csum tcp \
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 index 100
> >=20
> > Could you add a comment explaining what the filter is doing? While it
> > looks like the idea is to invert the 32-bit word at byte offset 148, I'=
m
> > not tc-literate enough to know if there are other effects (and I didn't
> > watch the email threads closely on this).

Matt, could you please add this comment for me? I didn't understand
these tc commands very well, and I can't explain them very clearly in
English.

>=20
> Yes that's correct. It takes only TCP packets on the egress side that
> are big enough but print a message in dmesg if not. After the
> modification, the TCP checksum is recomputed so the packet is valid.
>=20
> >=20
> >> +
> >> +=C2=A0=C2=A0=C2=A0 while true; do
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 local pkt=3D$(tc -n $ns2 -=
j -s action show action csum index 100 |
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 jq '.[1].actions[0].stats.packets')

Should we show the action 'pedit' here, instead of 'csum'?

The action 'csum' output is like this:

# tc -n $ns2 -j -s action show action csum index 100

[{"total acts":1},{"actions":[{"order":0,"kind":"csum","csum":"tcp","contro=
l_action":{"type":"pass"},"index":100,"ref":1,"bind":1,"installed":29,"last=
_used":2,"stats":{"bytes":11576,"packets":42,"drops":0,"overlimits":0,"requ=
eues":0,"backlog":0,"qlen":0}}]}]

"overlimits" is always 0 in 'csum'.

But the action 'pedit' output is like this:

# tc -n $ns2 -j -s action show action pedit index 100

[{"total acts":1},{"actions":[{"order":0 pedit ,"control_action":{"type":"p=
ipe"}keys 1
 	 index 1 ref 1 bind 1,"installed":29,"last_used":2
	 key #0  at 148: val ffffffff mask ffffffff
 ,"stats":{"bytes":11576,"packets":42,"drops":0,"overlimits":36,"requeues":=
0,"backlog":0,"qlen":0}}]}]

"overlimits" values are all right here, but this output can't be parsed by
'jq'. It looks like something wrong to show 'pedit'.

Is this a bug in act_pedit, or we use pedit incorrectly? How can I fix this=
?

> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ $pkt -gt 0 ]; then
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tc=
 -n $ns2 qdisc del dev ns2eth$i clsact
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>=20
> On my side, I had to add a "sleep .1" to slow things down and have the
> tests a bit more stable.
>=20
> I also used "flower ip_proto tcp tcp_flags 0x10/0xff" and it seems
> working fine.

Could you please share your checksum_failure function here, I'll test it
on my side?

>=20
> But still and probably caused by the "sleep .1" that seems needed, I
> have many messages in dmesg:
>=20
>     tc action pedit offset 162 out of bounds
>=20
> Because everything is shown on the serial, it is a bit annoying.
>=20
> Do you think it would be possible to limit to TCP ACK and also make sure
> data are only sent in one direction or limit incoming traffic to 1 byte
> if it is easier? With this, we should then have a very few pure ACKs
> packets on the egress side and avoid most of the TC warning messages
> printed by the kernel, no?
>=20
> >> +=C2=A0=C2=A0=C2=A0 done
> >> +}
> >> +
> >> # $1: IP address
> >> is_v6()
> >> {
> >> @@ -371,6 +399,9 @@ do_transfer()
> >> =C2=A0=C2=A0=C2=A0=C2=A0if [[ "${addr_nr_ns2}" =3D "fullmesh_"* ]]; th=
en
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags=3D"${flags},fullmesh"
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr_nr_ns2=3D${addr_nr_ns2=
:9}
> >> +=C2=A0=C2=A0=C2=A0 elif [[ "${addr_nr_ns2}" =3D "fail_"* ]]; then
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checksum_failure ${addr_nr=
_ns2:5}
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr_nr_ns2=3D0
> >> =C2=A0=C2=A0=C2=A0=C2=A0fi
> >>
> >> =C2=A0=C2=A0=C2=A0=C2=A0if [ $addr_nr_ns2 -gt 0 ]; then
> >> @@ -542,6 +573,8 @@ run_tests()
> >> chk_csum_nr()
> >> {
> >> =C2=A0=C2=A0=C2=A0=C2=A0local msg=3D${1:-""}
> >> +=C2=A0=C2=A0=C2=A0 local csum_ns1=3D${2:-0}
> >> +=C2=A0=C2=A0=C2=A0 local csum_ns2=3D${3:-0}
> >> =C2=A0=C2=A0=C2=A0=C2=A0local count
> >> =C2=A0=C2=A0=C2=A0=C2=A0local dump_stats
> >>
> >> @@ -553,8 +586,8 @@ chk_csum_nr()
> >> =C2=A0=C2=A0=C2=A0=C2=A0printf " %-36s %s" "$msg" "sum"
> >> =C2=A0=C2=A0=C2=A0=C2=A0count=3D`ip netns exec $ns1 nstat -as | grep M=
PTcpExtDataCsumErr |
> >> awk '{print $2}'`
> >> =C2=A0=C2=A0=C2=A0=C2=A0[ -z "$count" ] && count=3D0
> >> -=C2=A0=C2=A0=C2=A0 if [ "$count" !=3D 0 ]; then
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "[fail] got $count da=
ta checksum error[s] expected 0"
> >> +=C2=A0=C2=A0=C2=A0 if [ "$count" !=3D $csum_ns1 ]; then
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "[fail] got $count da=
ta checksum error[s] expected
> >> $csum_ns1"
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=3D1
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dump_stats=3D1
> >> =C2=A0=C2=A0=C2=A0=C2=A0else
> >> @@ -563,8 +596,8 @@ chk_csum_nr()
> >> =C2=A0=C2=A0=C2=A0=C2=A0echo -n " - csum=C2=A0 "
> >> =C2=A0=C2=A0=C2=A0=C2=A0count=3D`ip netns exec $ns2 nstat -as | grep M=
PTcpExtDataCsumErr |
> >> awk '{print $2}'`
> >> =C2=A0=C2=A0=C2=A0=C2=A0[ -z "$count" ] && count=3D0
> >> -=C2=A0=C2=A0=C2=A0 if [ "$count" !=3D 0 ]; then
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "[fail] got $count da=
ta checksum error[s] expected 0"
> >> +=C2=A0=C2=A0=C2=A0 if [ "$count" !=3D $csum_ns2 ]; then
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "[fail] got $count da=
ta checksum error[s] expected
> >> $csum_ns2"
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=3D1
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dump_stats=3D1
> >> =C2=A0=C2=A0=C2=A0=C2=A0else
> >> @@ -658,6 +691,8 @@ chk_join_nr()
> >> =C2=A0=C2=A0=C2=A0=C2=A0local syn_nr=3D$2
> >> =C2=A0=C2=A0=C2=A0=C2=A0local syn_ack_nr=3D$3
> >> =C2=A0=C2=A0=C2=A0=C2=A0local ack_nr=3D$4
> >> +=C2=A0=C2=A0=C2=A0 local fail_nr=3D${5:-0}
> >> +=C2=A0=C2=A0=C2=A0 local infi_nr=3D${6:-0}
> >> =C2=A0=C2=A0=C2=A0=C2=A0local count
> >> =C2=A0=C2=A0=C2=A0=C2=A0local dump_stats
> >>
> >> @@ -700,9 +735,9 @@ chk_join_nr()
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ip netns exec $ns2 nstat -a=
s | grep MPTcp
> >> =C2=A0=C2=A0=C2=A0=C2=A0fi
> >> =C2=A0=C2=A0=C2=A0=C2=A0if [ $checksum -eq 1 ]; then
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chk_csum_nr
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chk_fail_nr 0 0
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chk_infi_nr 0 0
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chk_csum_nr "" $fail_nr
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chk_fail_nr $fail_nr $fail=
_nr
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chk_infi_nr $infi_nr $infi=
_nr
> >> =C2=A0=C2=A0=C2=A0=C2=A0fi
> >> }
> >>
> >> @@ -1837,6 +1872,25 @@ fullmesh_tests()
> >> =C2=A0=C2=A0=C2=A0=C2=A0chk_add_nr 1 1
> >> }
> >>
> >> +fail_tests()
> >> +{
> >=20
> > Since MP_FAIL is only relevent with checksums enabled, I think it would
> > be good to set $checksum=3D1 here and restore its previous value before
> > returning (in case other tests run after this).
> >=20
> >> +=C2=A0=C2=A0=C2=A0 # 1 subflow
> >> +=C2=A0=C2=A0=C2=A0 reset
> >> +=C2=A0=C2=A0=C2=A0 ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> >> +=C2=A0=C2=A0=C2=A0 ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> >> +=C2=A0=C2=A0=C2=A0 run_tests $ns1 $ns2 10.0.1.1 2 0 "fail_1" fast

Here I passed 2 as the 4th argument of run_tests like the link_failure
tests to create the bigger data files. I don't know why it dosen't work
when passing 0 as the argument?

> >> +=C2=A0=C2=A0=C2=A0 chk_join_nr "MP_FAIL test, 1 subflow" 0 0 0 1 1
> >> +
> >> +=C2=A0=C2=A0=C2=A0 # multiple subflows
> >> +=C2=A0=C2=A0=C2=A0 reset
> >> +=C2=A0=C2=A0=C2=A0 ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> >> +=C2=A0=C2=A0=C2=A0 ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> >> +=C2=A0=C2=A0=C2=A0 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns=
2eth3 flags
> >> subflow
> >> +=C2=A0=C2=A0=C2=A0 ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 dev ns=
2eth2 flags
> >> subflow
> >> +=C2=A0=C2=A0=C2=A0 run_tests $ns1 $ns2 10.0.1.1 2 0 "fail_2" fast
> >> +=C2=A0=C2=A0=C2=A0 chk_join_nr "MP_FAIL test, multiple subflows" 2 2 =
2 1
> >> +}
> >> +
> >> all_tests()
> >> {
> >> =C2=A0=C2=A0=C2=A0=C2=A0subflows_tests
> >> @@ -1853,6 +1907,7 @@ all_tests()
> >> =C2=A0=C2=A0=C2=A0=C2=A0checksum_tests
> >> =C2=A0=C2=A0=C2=A0=C2=A0deny_join_id0_tests
> >> =C2=A0=C2=A0=C2=A0=C2=A0fullmesh_tests
> >> +=C2=A0=C2=A0=C2=A0 fail_tests
> >> }
> >>
> >> usage()
> >> @@ -1872,6 +1927,7 @@ usage()
> >> =C2=A0=C2=A0=C2=A0=C2=A0echo "=C2=A0 -S checksum_tests"
> >> =C2=A0=C2=A0=C2=A0=C2=A0echo "=C2=A0 -d deny_join_id0_tests"
> >> =C2=A0=C2=A0=C2=A0=C2=A0echo "=C2=A0 -m fullmesh_tests"
> >> +=C2=A0=C2=A0=C2=A0 echo "=C2=A0 -F fail_tests"
> >> =C2=A0=C2=A0=C2=A0=C2=A0echo "=C2=A0 -c capture pcap files"
> >> =C2=A0=C2=A0=C2=A0=C2=A0echo "=C2=A0 -C enable data checksum"
> >> =C2=A0=C2=A0=C2=A0=C2=A0echo "=C2=A0 -h help"
> >> @@ -1907,7 +1963,7 @@ if [ $do_all_tests -eq 1 ]; then
> >> =C2=A0=C2=A0=C2=A0=C2=A0exit $ret
> >> fi
> >>
> >> -while getopts 'fsltra64bpkdmchCS' opt; do
> >> +while getopts 'fsltra64bpkdmchCSF' opt; do
> >> =C2=A0=C2=A0=C2=A0=C2=A0case $opt in
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sub=
flows_tests
> >> @@ -1951,6 +2007,9 @@ while getopts 'fsltra64bpkdmchCS' opt; do
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 m)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ful=
lmesh_tests
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 F)
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fa=
il_tests
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C)
> >> --=C2=A0
> >> 2.26.2
> >=20
> > When I run:
> >=20
> > $ sudo ./mptcp_join.sh -FC
> >=20
> > I get:
> >=20
> > """
> > Created /tmp/tmp.UTIlkuhfRW (size 1 KB) containing data sent by client
> > Created /tmp/tmp.pMPhJddNfQ (size 1 KB) containing data sent by server
> > Created /tmp/tmp.OEx5cmVqbp (size 10075 KB) containing data sent by cli=
ent
> > Created /tmp/tmp.RAtBQXOXtR (size 6144 KB) containing data sent by serv=
er
> > [ FAIL ] file received by server does not match (in, out):
> > -rw-------. 1 root root 20633656 Nov=C2=A0 3 17:32 /tmp/tmp.HtyoJjpCOe
> > Trailing bytes are:
> > MPTCP_TEST_FILE_END_MARKER
> > -rw-------. 1 root root 20633656 Nov=C2=A0 3 17:32 /tmp/tmp.j8HYN1PUVh
> > Trailing bytes are:
> > MPTCP_TEST_FILE_END_MARKER
> > 01 MP_FAIL test, 1 subflow=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 syn[ ok ] - synack[ ok ] - ack[
> > ok ]
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sum[ ok ] - csum=C2=A0 [ ok ]
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ftx[ ok ] - frx=C2=A0=C2=A0 [ ok ]
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 itx[ ok ] - irx=C2=A0=C2=A0 [ ok ]
> > [ FAIL ] file received by server does not match (in, out):
> > -rw-------. 1 root root 20633656 Nov=C2=A0 3 17:32 /tmp/tmp.HtyoJjpCOe
> > Trailing bytes are:
> > MPTCP_TEST_FILE_END_MARKER
> > -rw-------. 1 root root 20633656 Nov=C2=A0 3 17:32 /tmp/tmp.j8HYN1PUVh
> > Trailing bytes are:
> > MPTCP_TEST_FILE_END_MARKER
> > 02 MP_FAIL test, multiple subflows=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 syn[ o=
k ] - synack[ ok ] - ack[
> > ok ]
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sum[ ok ] - csum=C2=A0 [ ok ]
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ftx[ ok ] - frx=C2=A0=C2=A0 [ ok ]
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 itx[ ok ] - irx=C2=A0=C2=A0 [ ok ]
> > """
> >=20
> > The chk_join_nr output shows all [ ok ], which is good. But the file
> > mismatches (I assume due to the inverted data) are failures because the
> > checksums are intended to reject the bad data. Am I understanding the
> > file mismatches correctly?
> >=20
> > If MP_FAIL is working, the files should match.
>=20
> I also have the same error on my side but not all the time.

I got these file mismatches errors all the time. Could you please share
your test script and the logs when you get the right output?

The first test "01 MP_FAIL test, 1 subflow" will get the file mismatches
all the time, since the checksum error data can't be retransmitted in
the current codes.

But the second test "02 MP_FAIL test, multiple subflows" shouldn't get
the file mismatches. RST is sent on the checksum error subflow, so this
subflow is closed. The data will be retransmitted on the other subflow.
It works by using the old test case "[PATCH mptcp-next v7 8/8]
DO-NOT-MERGE: mptcp: mp_fail test". Data will be retransmitted, and no
the file mismatches. I don't know why it dosen't work by this new test
case. In this test case, I saw the error data has been dropped, and the
new data has been retransmitted in the log. I'll try to fix this.

Thanks,
-Geliang

>=20
> Cheers,
> Matt
> --=20
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>=20

