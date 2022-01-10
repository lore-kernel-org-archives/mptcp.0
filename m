Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AB42C80
	for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 06:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641797191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AyJIUl4u5TVkrPZxhWcd5ID0ardcVOXWW2uIPv46RxE=;
	b=Em05n1lXE+PZsY1Vt0fKaodntT1cZHt8bzaMXYonTmeZH9Re5SHbXPEPlw7WKUM+WIQA5v
	Swx+Si4BFzZiR3U5Fj47TRhjshwu60FQc4qnzJDb3+RfWYONofx0Y1W8b6xLzTAgtd4N8e
	EoxJXfqZSacrGUzUkK8sjBvXtSDZnQA=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2108.outbound.protection.outlook.com [104.47.17.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-EbMJKz_2O0uBKwNVPPRaOw-1; Mon, 10 Jan 2022 07:46:30 +0100
X-MC-Unique: EbMJKz_2O0uBKwNVPPRaOw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVmJBH2tccnmhO5VDH7Fw/ZAk//5KJiESkewPN6uoDBcs9esHK/I7vnoHP/63B/f59fQS5TJk81GGcEpyvkYnqS5Tnin62xb16F1A4/yC7LtoQnD1/L+t8G37nUFSFLWDMpIJS9EI0c49E0tvjICHYa6eE3M1BT6f0vSYmxH2qoGksVQazATEKWWpI2/XqDXU+IqHo4P03Tjdl6rWfAMh5/qVFJZA6K8zWWVtBHRuagzL8Vp+IJLyIRzsrd9zyEgFzQDOsYI+uuRYMcWEsf9OViMqWdI0hrRBF/DpyIPeSS9TsKnkZgnwuWS4fHDj7pg0UrZKy9s0J47fxx301Oy+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyJIUl4u5TVkrPZxhWcd5ID0ardcVOXWW2uIPv46RxE=;
 b=GZMhKuuetkTXu+pE/0N2SlpsYY+SJKdps3/wtVo2HRf28ZBkqaFYBPJdTj5cslxwEFVXGoEckbPRk1Z2AAzm7Wf/JrXU1wNrOZPtkjdiCobp/UbTtbdf2f7VbqokdgVD9YVsR4nfb5P0J8yKc/XK+0Pzw2615qRdjAIqC88O8eCyFq886l/bNEl9904inoDZ1bs9pHu2rpsScWLRhh9wWniS83fDbGLO6QRhH+0pwtkK/ka28iG5nwrr1VMKDj45SLVM0ceF020oX+G4xvUxF/dM4Wx/TPEphcfxTa8e9V6dH5CSLgI4HLG+SAD4Z6Gx+/HCLtxVjcSDxXD/cMrMfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2634.eurprd04.prod.outlook.com (2603:10a6:3:87::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 06:46:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 06:46:28 +0000
Date: Mon, 10 Jan 2022 14:46:24 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH iproute2-next 0/3] more patches from pm_nl_ctl
Message-ID: <20220110064624.GA21902@dhcp-10-157-36-190>
References: <cover.1641289518.git.geliang.tang@suse.com>
 <8de28feb-42ef-76d6-663c-32596eba1bc@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8de28feb-42ef-76d6-663c-32596eba1bc@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR04CA0053.apcprd04.prod.outlook.com
 (2603:1096:202:14::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c7ed734-ed63-49e7-85d5-08d9d404ed75
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2634:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB26341BD773B81D41ED73A132F8509@HE1PR0401MB2634.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BtaDYZDYVZ/b1JlPvHjQuUegUNDVmMdMAOVO9s6W8DcS480+URljcQmGuT65SAbZ6ShzI5hNrXLNTF7pmECXSbNCqUlC5blky0OsyKJ9G20RcXtUtmqu/E9XufrFsnA/UeliRN1l3b56ILSXFcw4vTSjbRtgjGLVpA69vcXY+PGW2qfG+cgIpRK8qrx02HzVQ7tilikFhTWyhq1SnxmY2dmIN0hcLjXF1l5KgHDp7mLO1f3ijJEJkJeaOWBN1nK5m2Nrk5TbTK5BzcFsDlOJ67lLar/8Jz7UsuqjS5lj3iBAH4a9ymO4lf+AONvPjgGllu4G/57rpO7HgzB3jzbOnCX/KKMnTbaAm0deDjVm36r5h+oL13DCPfZl6GQrncjmThY1HFPjjjM2nWtZs6P8EZGS6WywgHBfK3q7cWzEZQEKdmcoZwbzgXbfNJRfVu364A9okOwa3D5Rba2iEwgng29LZEgG7rMWijGZu9xtox02oeuVmOpRPz+JLyiKE0ALMA5ayLzRLdD1YK73aB4ZMXbAM5BvcD3c1GpNlN5xyUEUxfRLCL4kYH4/bcEC/Q02ROXOeH8oTiSgAfs2ofMTDwbrf/a6qTCpR9AmVRXvEojnNOOV4UKfLAEXfRcAAH2H++wrmt501D+269TbtbbFYJ9VModzrXwgAv1q7g7lFIgkyTnZc+A9LiVvpAkGypbKM7dcwCW9gCn5p9a+GYde6J3CS5I+xC8TE+yNrOhSWh8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6506007)(55236004)(1076003)(33656002)(4326008)(86362001)(33716001)(6512007)(83380400001)(6916009)(9686003)(966005)(2906002)(316002)(44832011)(66476007)(66556008)(508600001)(6486002)(5660300002)(38100700002)(8676002)(8936002)(6666004)(66946007)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LfvqZATRH99ailJ8aWmOY+Ksg4OtZWU2xNLXZM81R83aYq2aiQFdaBHokX7m?=
 =?us-ascii?Q?yDiWqV2qfI17OcmDAbeX4L1mND8LUtFSkSL8Plk9t1LhrYzh2WBriApo91Wj?=
 =?us-ascii?Q?8nyyLSovXVTuFTBJxlqDpEODw0bo2D5RCvU2zOn6Ywmd2szT+jDdpN4FEv1T?=
 =?us-ascii?Q?qNoBJBou0lTUJFtS3g3bGzkp6psPE6C2g8oOAo7Sz0P5pbQTTHJu53/d1SdE?=
 =?us-ascii?Q?P6x/H6fR7QCtlCXw2iyUK1rfJZa6gPJXIbk0IoHs+IraqmqTB+7LQGjgcf3O?=
 =?us-ascii?Q?63QJGaiIK2vukRJdwwZy9Ai9NNj9g0ZXpkbLXBp5lDSlfXnaXWSSUZ648YHv?=
 =?us-ascii?Q?h99j57BAuNScqIkRBWRGKBvZEvIW0DiEfZ0EUhUZQuPmDWJqhdc+eox/MEWb?=
 =?us-ascii?Q?h6OOtPlNJ0myp5xhmfzIaCLKPVD/xXkCwrX9K7KbU84p4jolpP5uX2+Dvkf7?=
 =?us-ascii?Q?LvVUTMLMr/Lja9kw4X8ry3tiIkUiE5GgJq3QD56PaQYAAldm9Hfnt2hNG7jo?=
 =?us-ascii?Q?pEpkoVVAEjx/jn6Jgg/0m2x7drZgu76IJnYecQmmpkZDf1gQ/hota4bL6rUa?=
 =?us-ascii?Q?/tTntsFeYY9ec1/x78SshZ+4lA31sPKQO3avwDOy1V5AZHL1ywjV8unnOYse?=
 =?us-ascii?Q?GMktNtWj02JRelLXI5QwOKh7YONxKX5HvEwuHdzCgOdM3R2KYpa1ijkjHWRE?=
 =?us-ascii?Q?n17VfHwGoSgSAPUud2es4u8inkLPT/zF5AKQiJqkzQz9+P+/yn/wOEqP+uEf?=
 =?us-ascii?Q?3Etpjz6QA0t0Sw/QVNpNS4XkNRye7ZXs9Yq0qyjiB0wJNODdhLfAMqmQoV7r?=
 =?us-ascii?Q?CnSfTOxskUSlmeuXIc3/a1+VoGEwzBxnLAReJmeum2ywueYJCjwZsddKZPzZ?=
 =?us-ascii?Q?pu3h96Cw+PicfqIj9uRmaJV3pNMpWD0mtrMGXysjxMnVikcLrJiyGBcWEWe9?=
 =?us-ascii?Q?IaQ1elFkb3sMuzXxu2vOciCCLavaDfAxp/LAxx3dyUyqzTmQ3PeeLNRAEx8t?=
 =?us-ascii?Q?R02tm6YhZXJrU87CKwaMWSzKIPXoG2aDriNv7VrpxR7tbJagBX5HsVouhT9W?=
 =?us-ascii?Q?vquMIayZvvBQ59HcHtPQJwClGc7rfQScT5VLaluAalkTIbEOnYEhHqyt+jHh?=
 =?us-ascii?Q?N2APm3YgQd3oNs6a3YIfDGddoAcmfpidkdHABSnbJTGbY8Okhihpe+tRpTsg?=
 =?us-ascii?Q?TubEBeplxR4ApC4WdRg11oOHwSzPHylOrEurOTCatmdOC/hBdjaYU1k6LCSO?=
 =?us-ascii?Q?qI/RH1EABucz9dAbc4rm4FXEkXRVl60IgGL/+AxuqmZTjBz1Cz46I49kKcjX?=
 =?us-ascii?Q?IKoggceb0XeGY+8KvWQEexgZJEz4RDY7Lg2xUyKRI3MnciGwvM3G3ugXqJLD?=
 =?us-ascii?Q?/2RpGIqk44JN/m0KxYO75aR1vYij0t0e6vDOrT431KjNk+U5ZKp3r7sdkR+5?=
 =?us-ascii?Q?F4uVar7YZfLtDzARDotAZvraIkDSsyJgnDbYcz1zqCQs45f+6UaKFmaLc66v?=
 =?us-ascii?Q?EK4LryRvD4XndCQXXrBPyjBuU/DSdG0WaeU9KleY0YyGA3NLj7GwnEJt0/Hu?=
 =?us-ascii?Q?VM8Myc5EkIs0m9FVm4qx77QkL3aB07x3HqMvqEmDPgj3rs1mD9aZ95szl661?=
 =?us-ascii?Q?htTKucehyvV2rx80wvf4HZk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c7ed734-ed63-49e7-85d5-08d9d404ed75
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 06:46:27.9433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EjuwvEYThqgAn+ICEFusJoYXbWARbnKwEX7dgcOS4um0dand7b36d+OUBTgTBUjvoZYVIqiDZ+cN6kSebZ31ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2634

Hi Mat,

Thanks for your review.

On Fri, Jan 07, 2022 at 04:11:43PM -0800, Mat Martineau wrote:
> On Tue, 4 Jan 2022, Geliang Tang wrote:
> 
> > This patched added id 0 address deleting, fullmesh flag and backup setting
> > from pm_nl_ctl. With these patches, we can replace all pm_nl_ctl in the
> > selftests with 'ip mptcp' command.
> > 
> > Geliang Tang (3):
> >  mptcp: add id check for deleting address
> >  mptcp: add the addr flag fullmesh
> >  mptcp: add the backup flag setting
> > 
> > include/uapi/linux/mptcp.h |  2 ++
> > ip/ipmptcp.c               | 31 +++++++++++++++++++++++++------
> > 2 files changed, 27 insertions(+), 6 deletions(-)
> > 
> > -- 
> > 2.31.1
> 
> Hi Geliang -
> 
> I found that this doesn't apply to
> https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git, but it
> does apply to iproute2.git
> 
> If you check iproute2-next, there's already a patch in there from Paolo that
> adds the fullmesh flag.

Yes, v1 was against the wrong repo, not iproute2-next.git.

I just noticed there's already a patch in iproute2-next from Davide that
adds the backup flag setting too:
 "mptcp: add support for changing the backup flag"

So patch 2 and 3 in this series should be dropped.

> 
> Can you rebase the other two patches on iproute2-next for v2?

I only updated patch 1 for v2.

Thanks,
-Geliang

> 
> 
> Thanks,
> 
> 
> --
> Mat Martineau
> Intel
> 

