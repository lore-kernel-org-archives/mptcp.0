Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249B22F28
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 13:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644414725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k7dRfBv9/IyybDysaSXEBVtEO9V4V+YBF9LC0tWY140=;
	b=by7hgqB4Zma3kp9PJdzoWVjoreJsvbbSbSq7lA1LjBmZ61ZmQWOxPHhNSKXopIluXg4Wnc
	OxXou5taFNq5I6RxzU5JTcMhSRtdDD4sWCQWeN+27I4JUtNpI/f0afZyDUuMlK8gkh+V86
	ZDs6A+Wd8MlaejJ112TreYia1J0sCIw=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-_trbk6kvPE69M-o2BG7RYA-1; Wed, 09 Feb 2022 14:52:04 +0100
X-MC-Unique: _trbk6kvPE69M-o2BG7RYA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVln0RV4Nug+t1hJPzqPQUe1lBBDF3i6eVX2KqDGmoFilE/VaOIxmkxg0h1ZJIBpr8P6x/kfRodbAtb/M5ocoqF6PFJ4VFg12IrIqBJ5klyo5fGAq+6zaNKwbPauw6xa5VEPKhQx01IQaUilhcxPJU3ebvfRMfehBa5C/cPxKjtrkNTs6boCH3IPbo/bCpnXMOSNJu+Cu6Pd57Cai/eKxZHucL1vNQZ5QHn6PllL51cOCaLqnJq5GUPXCyivwfaslBvD/xXKkcQFP+Wu71gu2cgXjXRnCqowOnJV4AVpyD7zRJPKvJb5TwAVQoThmIgySzR2u9vox0cI3DQkReenRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7dRfBv9/IyybDysaSXEBVtEO9V4V+YBF9LC0tWY140=;
 b=mYj5CVsm6zmp5tF/Nz3q+ksszAIQeSGhj7O9xDWFl2nbcU2A4S2MXDyZu5ztmCRhjA4CSZV+AqapEZMM/UZWeutdzwZRc+9v55MR5APp2k5F6ZyOaq5j/6M7WMlP+MwQV6zS+MSf86AVz0FbZb2ehXyzvSmVIyE1cLZgFxJgzij7ON44kIgTQ5tnA1Gt8ZEAdAXOYi6Zh0iIS+SIkAkPS6lrim/x4lWBvcj5Lx5gGVm6LK8i/idb6GTKAhPCyo/YY2ZJG9OGtG1faMgbhVrD5WDDgkhwe2f/8KHQw/svkbMFxavkGWu+WV39q6E8Kc4uEVCqmh469ZSMG/hp2Ob5Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB5766.eurprd04.prod.outlook.com (2603:10a6:20b:ab::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 13:52:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 13:52:03 +0000
Date: Wed, 9 Feb 2022 21:52:31 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4 5/5] selftests: mptcp: add mp_fail testcases
Message-ID: <20220209135231.GA9987@bogon>
References: <cover.1644396927.git.geliang.tang@suse.com>
 <7b3e19b0e0b8c3b651320897b25464e0f76806ff.1644396927.git.geliang.tang@suse.com>
 <55e50da5-25ec-3a66-6264-10d712c5ba6e@tessares.net>
 <20220209105521.GA26714@dhcp-10-157-36-190>
 <79b19fe9-e576-c4fe-82bb-cb2ca88e1e4e@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79b19fe9-e576-c4fe-82bb-cb2ca88e1e4e@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR04CA0050.apcprd04.prod.outlook.com
 (2603:1096:202:14::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d48b266-98d2-4e6b-4113-08d9ebd35a25
X-MS-TrafficTypeDiagnostic: AM6PR04MB5766:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB5766D59C44D9A098E5C5582EF82E9@AM6PR04MB5766.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cglkjUqlalqKuD4jH1b3KTVAnKc/y/DZ5YYj0afYy+ZxV0lODm+h4J7A27iYr0rMLvasLduj45mS/fWKYCTmVurls02Y2kORhW5IDo5jrAivG7F3kkLeS/UWmESmLGbqDUUCJ7J5WbcHZ0tz8mt87AATBPRWTcR1u3x1ha9DO4zABU+0CsJHSB7ZasE9HJ0hyrVUeKbjGdDRvQ4wezuC/dvouWHspNO5ffBNaAAM+MctLFIoVwD67NTHsaygMVPdR8dvKATgxzBgyY0Zdwif0C+gP+I7kgpGtR38mQCiXkP2fB2tXIr2iHQ1g3cyOdEZmxkTaKU7TNq5MB2oeXebWJznpgravuNdJmX/nRUtZxiKjZZJVf4dejdhCqtgKYV8AqHYa8qj2i7AxRh+lclC1Ew0BcoWiVH520Ok+l89dz/dstITrw3v1zixKSSwrnPiPiSKR41TU9EYga3N+y123CRNdEB3u/rnbmrA9OAt3giGZkvhFvqw70xKeuHyw6ivsdWT3Ty0bD0LYpq8FySWGHO5nlIs5H1YzrjIKcw57PiMvm87Pxfh1zrRCWqvFDNR6fIhKn41meZwgju3lxu9sYON59IrsgYtXAE0t9Fa+zN1g62F2MqZO4M5lCaS42UEg1hIZM4XzGs8Pq2Czb4asvw5nBdP5EtMYIi5sXDhShAZv9uFID+YpqiUG50HG//kk92EZC9ywzq+vHGRo3joZh581d3eAmkrm4ryY3bUe1UdRfmc1mT1fqcbMNtTQIW/QhW224jsHZS4qiY0jNwrlg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8936002)(5660300002)(6916009)(6506007)(33656002)(316002)(53546011)(9686003)(6512007)(6666004)(86362001)(15974865002)(8676002)(66946007)(66556008)(4326008)(66476007)(83380400001)(2906002)(508600001)(6486002)(26005)(186003)(1076003)(44832011)(33716001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fq9QMluTqfjjdZk7rDEFkHt/Pj3oSOSvr3Hwjgy9H1geYv/F7jVW+frYm1uI?=
 =?us-ascii?Q?Xud9E32BklJ4n8ATObp9OSPm9tkfcsSzlF0IaaCPpWbXUdbA25pPlVMmvHwo?=
 =?us-ascii?Q?PlQDTqE274TLeyySZ1vJtaiSuxLrMlXiyUfAEM/DcRL2DFl/6qIqoEJhPGIv?=
 =?us-ascii?Q?RnBzfH/Yn40vf4wrbeS4wcDNlVSwrk4uy5SkZqsJE5gr8Y+9CR+n7+X+LfcW?=
 =?us-ascii?Q?lWJvSFumX//W2z7OZyqqR+iyfN01Ny9IoLazkHW2ky4fa6L0Z6R0BwYF/R6R?=
 =?us-ascii?Q?Gvb0hDqs0mxhmycRsigW7gobtZZQXHHDHBEjFJr2g+wDSWpr0+EXCBV+egQQ?=
 =?us-ascii?Q?7jKFKOLxF5SyEGKV07mCxhVqBlYCGhArvJCLPoNP7c/H4RdsARO2gXqr0Lq2?=
 =?us-ascii?Q?czv26sIvvOpELDGcQ5h0RNxqrULmDjjOFKDz1uacq3iyNvzwjqT78qaydd31?=
 =?us-ascii?Q?Mh8m1U+kJRBgC+FPE+HXpzw8v0EzbLyxq/YWSLVPrm9UNLI+sGRIU4jQogFK?=
 =?us-ascii?Q?7R7gluoeSmwr1Sd5qxf9ZEetPlRLIhW3P4J8gl5xuIRbY9x9iVt0OzGGUsAT?=
 =?us-ascii?Q?4XC6xnKoVvXdB8N1P1UUEH1KJeG2C6S3DdaoyGpShvpM9U4sDuSZfFMDt47K?=
 =?us-ascii?Q?H5qYct3aTYUDNRGWPthGOJtMwNxBWFtnqK19Eqhoo/Twn7cq7/zmNTh3Fs/e?=
 =?us-ascii?Q?JcpPkBMRMIytrAIvnIbSJLkwBbu2VKSlJu7POketHuhvoPCQmfVRyNMkpWqS?=
 =?us-ascii?Q?NCnbD3j1i5MsKnzujhbP03yiIWJqASTUHkQSgmICvj13pJ4S2bWzVAmN4PxP?=
 =?us-ascii?Q?8bZ9O8niTMslaYld/gtlTBWlqJ+/0E7yIGCWUR/XoW8aUdZLNJl2w07ujInO?=
 =?us-ascii?Q?eVahgJ3+NC/K641gT+jixMdZsVOcQdRPZe0UVrpXrbF6q+gVX9F1Zivzs9eS?=
 =?us-ascii?Q?bSqAdt1o1SI3i8W5wTqJgK4+XDr3hgvVp7QTmkRiBiveRAgy7WoJ6ndIUonV?=
 =?us-ascii?Q?OrDWF2dfq9TkUS99j4xq/G5SqWDfe9xlIkbM0jBXZw5nbbFq4t7c9CotYeNm?=
 =?us-ascii?Q?s5XsIKQukLBksjEjo88JWXckPWNQhBnPmii1KWiO1L+o731nDxfYH7HnjCFc?=
 =?us-ascii?Q?PiLff1D4pEsk2rCA4JBl2jZxSpLTK1RXLNZHtHxanCaPnPj12T9Qdkh5+w5o?=
 =?us-ascii?Q?rSbnGx4EL8uJ0ZMs4Q4o+eZLW3wwxt/7QKHZtVb9Olyye7+d9SWTQtf4pls6?=
 =?us-ascii?Q?vGMclorkLlntdrVO0p3RtGAZWpgFVV9SowRFYbdsZPoI3vd/NvchRFKwBbE+?=
 =?us-ascii?Q?wITDrA7gGbsn2q1ZSNnCHQV5eWPiAypu4F02LX1nLigU/ZlTC1xeMZ/28blx?=
 =?us-ascii?Q?HSMZISyf7rPuCmqZpYukFraRFOAy0J56zK08VgikDV878RgGG2rXMDg2TSID?=
 =?us-ascii?Q?ZKNNHv4ihkUL13Z+eOGsafYcnCU3BMkf4WT0SRgP0Uyuhzcfy8D6U2a9TcfL?=
 =?us-ascii?Q?e6Ev2YZ6idbv4piJTbsyjb+frn7MHYWhGFP9xx8pk3Tqj1a1qLvavbMtuinM?=
 =?us-ascii?Q?0dptVzJvrC8C6tWpKf75KheMkcvqAWU8d0P2DQ8N0iZH22n9piL58qshLddl?=
 =?us-ascii?Q?TXZXSrg5i3xfq9DXaxQ0Xvc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d48b266-98d2-4e6b-4113-08d9ebd35a25
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 13:52:03.5309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sad/krX40MB7QX83wejLbajojXffKr92MZ3QosjD3EWxz8IoIC4eR1zhryl2h4bBtoGO6sCW/X5rgz0Penwedw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5766

Hi Matt,

On Wed, Feb 09, 2022 at 12:13:00PM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 09/02/2022 11:55, Geliang Tang wrote:
> > On Wed, Feb 09, 2022 at 10:23:52AM +0100, Matthieu Baerts wrote:
> >> On 09/02/2022 09:57, Geliang Tang wrote:
> >>> +fail_tests()
> >>> +{
> >>> +	# multiple subflows
> >>> +	reset_with_fail 2
> >>> +	pm_nl_set_limits $ns1 0 2
> >>> +	pm_nl_set_limits $ns2 0 2
> >>> +	pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
> >>> +	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
> >>> +	run_tests $ns1 $ns2 10.0.1.1 3
> >>> +	pedit_action_happened 2
> >>> +	chk_join_nr "MP_FAIL MP_RST: $pedit_action pedit action" 2 2 2 \
> >>> +		$pedit_action $pedit_action
> >>
> >> Related to my comment in the v2: we should not use $pedit_action in the
> >> args we need to verify I think. Instead we should probably then have:
> >>
> >>   chk_join_nr "(...)" 2 2 2 1 1
> > 
> > Thanks for your review and suggestions. I updated them in v5.
> > 
> > We will get this failure in v5 in rare cases, about one percent
> > probability
> 
> Do you know why?
> 
> We invert a byte so it should always cause an issue, no? (we can always
> have 2 same hashes for two different sources but it is a very very rare
> case we don't have to consider I think, especially when the content is
> so close, no?)
> 
> Or maybe we need to improve the IPTables and TC rules?
> 

I think we should go back to the old version of this patch. We shouldn't
always expect getting 1 MP_FAIL. If no checksum failure occur, we should
expect no MP_FAIL. I just sent a squash-to patch to fix this.

Thanks,
-Geliang

> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
> 

