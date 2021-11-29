Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916EA72
	for <mptcp@lists.linux.dev>; Mon, 29 Nov 2021 04:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1638159336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IwuqwnJNy+wL9JV0nWkfqBGhXLLDlODQNsS/4rLFFvk=;
	b=QRu9Xm40XZmggl+15fUmqXVsFk3ITnHmrxZ2QpJODxlKGRd9iAjKuPuxH+e24wH5hVefkf
	f0YVCFTkzX75TzsJTMJoHnX4u5ZCk8qQcJQuKMrfKpdZKdGz69ssN/HMEW1YKbWQAuKOUj
	2PLHCuxVcbxD4n2TJL1uhKHJ1vd1X4A=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2056.outbound.protection.outlook.com [104.47.5.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-26-_JgZGti6N7e3K7nELu0-xA-1; Mon, 29 Nov 2021 05:15:35 +0100
X-MC-Unique: _JgZGti6N7e3K7nELu0-xA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMhCpjDDRnGDZXrnbxtKglfNDIagA4yj3gyNxCKSNAqLeLvzWssB7QVFB6/HrkoGF6cxSzQ/Wtx0e5/7q4O5noKtdtorHoYb072IznPDQqZhxleTB4+NjEovBJ+aI5zV/3wLpsGvsdGaIEu3U4ZKXpvDCZYaC3IIdjZfMcRiZJtRtYDLSKqXlIWMKghCCcmC5c98I7H3cTUOsM8wTGZebQk61sxBdbEhKHga4kn3y7d/XnwH9nCJXUN4vY/hOGNsanrSNtdpp0QP+YWhOLLI256cx1dORX8HgCDbVsH+mJfgpxxyKoKZC1svJ2nmDnc2BTxaw8kUvb5hGsw2ISbLuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwuqwnJNy+wL9JV0nWkfqBGhXLLDlODQNsS/4rLFFvk=;
 b=VQZIkXKGrHTIXdRWfE390x/7LeBvbJO0m6R+H3V3+x4aLBRG6bS6F21eB1HB+C8vn7kBGcgtpFCvIwkieyisEmhr7D1Reag1BF0AgKyt9M71Hhhh1X2Xmsij0o8wn6odnwreSuIHXjsHz5ro3iQ+D8YgCp0cpEhATeya0HkgBZJ+w7qrXN95YSFpRi3bEtIZKMB6YSGNcf61B4cR8TLrEUBFSWLvRwJxwErnpLcOKhQ7rxk2mO/SQxKlLcpCvtkeYJK1uMmyNVFbU1oIEkr6cxkwd09CBcJaYZ9LQCtfmFy+ZwTSA1jgvyTAirbd1ruBTYGMcYybgNRkVZKKfFTh6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2537.eurprd04.prod.outlook.com (2603:10a6:3:83::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.21; Mon, 29 Nov
 2021 04:15:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366%6]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 04:15:34 +0000
Date: Mon, 29 Nov 2021 12:15:25 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 2/2] mptcp: print out reset_reason of MP_RST
Message-ID: <20211129041525.GB23777@dhcp-10-157-36-190>
References: <cover.1637630218.git.geliang.tang@suse.com>
 <f7d8547fa832c5d20c13ca950966d6a5222f0e72.1637630218.git.geliang.tang@suse.com>
 <ae2602ea-3851-cd63-2760-77d74d019006@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae2602ea-3851-cd63-2760-77d74d019006@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR06CA0151.apcprd06.prod.outlook.com
 (2603:1096:1:1f::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by SG2PR06CA0151.apcprd06.prod.outlook.com (2603:1096:1:1f::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Mon, 29 Nov 2021 04:15:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0317e504-28ed-46b6-7ed2-08d9b2eee3e7
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2537:
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB25373957EE395D7BC577ED95F8669@HE1PR0401MB2537.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	57V+y5FFZ6BzGjQoI6GEEx/a/ROT34ZQIzSVHGS5fGwSl48xIyl2fJyhOIuMmLXiz6yJljSLycNIiLRQt6RzJyL3KYY53CxDaGQmTQarIbmIPbC8OdxQIAI0fPVf2Www3j9EBEhQvOhQfF3gT0uCW2/4kn/GKvQFxaR0Wk8jGi06Mr79PcjmeekoWJVHDxuHIjkFUXkwjBTzmcbSnR83Jq/UU2pCXNL1OoCMd/FqidwO6ViU+jm/ye1cVQijI+Br+z940Ok0JLp3w1zl8x10C+4LTbKJDHh80hFLUMACmZCGTF+hoDSyD/7m406eyBUXzv96/CjV3fbL/GsMNzj0c0hj4a8H5xGG6hotA0yXDyiulw0bXKam4TIJAPh+QDZsGVF7TfM9/Jw8i3cTm3pjWRDqEIiXxYRKV5xPXD3sBm28kpy/wVvmidmjTwVmU45PJ3Q9cfQAaAK9/iARyAOXNZ5Gc8VvuTPxt2+VTmKIaJ1LrpwG84ES9jWdgv+qoH1ahCw0aEtQ3YxXOAA21kqvckfB0Y0KZnP8vIAf4jNtitYbfltR1O1Uk8nwQ9MoRm51fH6QqHNSwvFT4WqcVMrhNhymYDYBeBa1Y+3TEZN/gzUD/fE/Mea+6WIqFNCVvqL0SrG/jy3b0AYOgpcscxXqcyOZd0hORt07TgQrwOr78ON1ICGJD5QRlbKTHfq0r5x7FDQXDv/T7m3M+UlmggnlKHtXrZlqdAUG5nCKjI+ZSO4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6486002)(66946007)(4326008)(6666004)(83380400001)(316002)(44832011)(38100700002)(9686003)(15974865002)(86362001)(8676002)(55236004)(8936002)(53546011)(6496006)(33656002)(66556008)(66476007)(26005)(186003)(33716001)(1076003)(508600001)(5660300002)(6916009)(956004)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YqxM0kGDTqMq6f8HHHgZht9oKeg+6EB0eYho6DyjTLEjRmuv7Vvdk/cr163P?=
 =?us-ascii?Q?3KV5KKftJH2E65n8qZBk85pJV/7wTToHvH1K+IDLdC9F8y+NfbiC6izMtdnt?=
 =?us-ascii?Q?u7Wl24j7iEcj91m65qpYnjmOXtPhlmpl73knumN/tKBzTDsSj17LSzG75fNU?=
 =?us-ascii?Q?H7gYtLhBiTFsxbDt3ruw9v4z72w0GS3MbNktgslRPM7P6X6Vdic3BAaSmIWo?=
 =?us-ascii?Q?03/3DM+qmGL6ROVc+l38GQBKiiAnIeScrPun+/odPwkIpdYHicDOXk+FfL++?=
 =?us-ascii?Q?uK0O2xN9JDHi9KXrdae137haVfFS362ykfu86mkT3MTSa0SV8fBzQ3RQY9oF?=
 =?us-ascii?Q?Ao6ZwmLQmwIPByiUyEfNVp/BccR2drKBKsg7lLuZGRvphPvvLmXSNmG3CoPg?=
 =?us-ascii?Q?BexlQGFUOlJeFgj6PlfxAwhXTjX23WAr3yuWS3PEnsxZp3qN8CUmqJmbbYxX?=
 =?us-ascii?Q?Jvc8eISLx62Ap36PBrV0X2e6PoRGUhy03zUCMfts9GKPuNA5LKyBDPbX95Kn?=
 =?us-ascii?Q?PeM6iCjZ58jZUME8HaIIq3D8iVGpsqMnQrxEmSJwmmItX6F6cDpp34QVzwHf?=
 =?us-ascii?Q?qaiwW+X49VmHY4NWY09uv+5o/ACRKI85HOtkcmwb9T5OFUDm4t4OfZmvcNaz?=
 =?us-ascii?Q?WtV5AQcG/ABFMe79TuJPQ/nX/ja/B01ZEUGLq3dlR88N44nPuyD72e5MR6K0?=
 =?us-ascii?Q?wEbMrFGikvrz86tQF1RnOkMT1Tysp6N6pmOyza2DqoPQ/1huOo2CyUJMHJJG?=
 =?us-ascii?Q?iHKu7pdhwzGpgLOaVsMdxCasTEag8Ru3d0Ta4eUeaCzooWnznzpMm+MfvcMn?=
 =?us-ascii?Q?bu4iH+D98DI5iegn8gG7TpdW7T2X/CNdQfk4ewFOoi2TdMqb/BrBzQlrEOCI?=
 =?us-ascii?Q?AEEA0wPlt3mZZW2dNvXkvwv1EEzyhHM/CZVvmK/MVwUsUF2h83+7fZ/7DDT0?=
 =?us-ascii?Q?VwQLCWnNF2w11PUucXyHmiomI/MtjtnZXfFUtS4M/JVKztjdhiEj+377MQNe?=
 =?us-ascii?Q?5qKo918FhAJMVDvyA4B5aBE6BDinpY9qXDURggfcC8jcJLsQIdcaV/anE0Lz?=
 =?us-ascii?Q?n5aHH7rSt29fF8dsW6cJOgioKPR8D8++bZmq5qEXYUhtp35t3JMC2kbK2prP?=
 =?us-ascii?Q?7lnIoMIJgw/Qf7FjLzHzguB5nD4ZCcfB1kXw3ThIIT+Ub/6tm+csLGuryjUH?=
 =?us-ascii?Q?E2IH5mCeNO3G4Qc3tG2387q9J0ltqK28Gtu1ru4CKltkCzcyhGoUoyniejRL?=
 =?us-ascii?Q?QNFDBFFOW3RwK8fDROHAXY+HJXT913tnRtiCgS5gQfULffW58F3q5EEhfzet?=
 =?us-ascii?Q?1veNkQaguK4yR3OvgBBnGZPfgHwhtsgMEvHvVDXfzM57CcyLN3vZPlWEBFNL?=
 =?us-ascii?Q?WwRudY4j20kbaFX274R89RJ8jpWfGj45DstOkeY+iEGpyt/YC6j+RWaYag7J?=
 =?us-ascii?Q?DBBjwFrVOcJkysZkaF0dSOLJysk5VaDOZvTyWj5MnVDmEY75n56xkRYAksoF?=
 =?us-ascii?Q?lWHGozXN7iRY/loCqUc0k7kwcYtpqBNaUdZM3YRWv07zS47+0SAPxuGc8mdE?=
 =?us-ascii?Q?YkJzlccS6yA8zH9ec2ajLgJiY90O8PBdbeSD56Glh23S1C1krrV52ylrgJfd?=
 =?us-ascii?Q?ks0hDlSpjwW84MGNEUkGv5M=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0317e504-28ed-46b6-7ed2-08d9b2eee3e7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 04:15:34.6015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75VmUP/QfX0CCiF/4SsNWaUT02SSwtENzkev8t9ATbsLo4Qbwq16wgOVPORL/CrBtTjKJPXO+C0IyfDAlJzzFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2537

Hi Matt,

Thanks for your review.

On Sat, Nov 27, 2021 at 11:04:38AM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 23/11/2021 02:23, Geliang Tang wrote:
> > This patch printed out the reset_reason of MP_RST in mptcp_parse_option()
> > to show that MP_RST is received.
> 
> Thank you for looking at that!
> 
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> >  net/mptcp/options.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index dc998a14f4cb..085d11666fd6 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -336,6 +336,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
> >  		flags = *ptr++;
> >  		mp_opt->reset_transient = flags & MPTCP_RST_TRANSIENT;
> >  		mp_opt->reset_reason = *ptr;
> > +		pr_debug("MP_RST: reset_reason=%u", mp_opt->reset_reason);
> 
> Should we also print the "transient" bit?
> 

Updated in v2.

> And should we also squash this in "mptcp: implement fastclose xmit path"
> patch?

No, I think it's better to keep it as a standalone patch.

Thanks,
-Geliang

> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
> 

