Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13E37C
	for <mptcp@lists.linux.dev>; Thu,  3 Mar 2022 07:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646292729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pbef2X86rScK3+cdlkFnOgkBBhcNhgCNywOLp1jcXTo=;
	b=O+jgtuTnj2dOg4pq3U5OUGULyflSRN9tc01GTr5WAhMsET3q8rZM1g6oNiFg1PImc44hbU
	0atvBvkFSr7zCgP2K5c/2iykB8oysIXS6OUcXMdWeSpjP+X2Iqjd4TIqC9LzQdQzAewlOW
	1a8qi6xGby0t5SzuQPZdcxCkkZmwSoE=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2056.outbound.protection.outlook.com [104.47.12.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-26-geAwNX_hOnaMOA19TpWJjg-1; Thu, 03 Mar 2022 08:32:08 +0100
X-MC-Unique: geAwNX_hOnaMOA19TpWJjg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6SgNSmWbnvbdvFB02eHxKxDqravrW6O8md4bsBwJ4vvCFd6d2wu53HYYgqxKI+zfJ7GPKy/wRAGQ8yL/6a0mkoYZyuOmljxcSlzsow5DOapEz9ZMvsfvjhETaYf8K8kPXfb1EbQexxkBAH1/vMa14OHSAFtUX0BTJ3Rj6+m74qekJtfvPe7Q0qvnqD9isG2fRM4lKM4KZz03n1qx/RqljwLGzw1wgBRO2kKjmSxYC2OPm4V1KAkbDU9WcXX7jmeWBqFhVgQZUY1LE5S+rn1KG1WUpaOuWoq7Fq37LtEquPdjW976a1sdJQlJWRtm5BIzX9Bxsvzc9/tAONw6Wosag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pbef2X86rScK3+cdlkFnOgkBBhcNhgCNywOLp1jcXTo=;
 b=KFwRQxUGRP2Eg8nhc/rpO0UVl+ZP/PoMJwWfye+4OHovL5i6kOwVmbu10BQTFpErAQzOzpALmXPO3h3tqwMSXq5sxOwcyK6Qe3Nfo1XxmcxOU+Qusx/Hv8mHCbipKBf1sQWHZAtbji1wQ7ykBK1MOfN+Q299JSNwpfPAwiZNTmW706p7euvU43YOIJdCte3ex3OSiA5F7FGpgTV7pVfOiysuvEHclaAXtyB1qM6rkHCJnnLobt8GGPvXRtXSrhNKtXXaMdflGA+6lG2WPbEKahSC/0cqMduWbv41R2m5pH7C7YqI08gD+6iwOWtQl+Kqst5ynqR0af4uGFrxRJcNuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS4PR04MB9290.eurprd04.prod.outlook.com (2603:10a6:20b:4e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Thu, 3 Mar
 2022 07:32:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%5]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 07:32:07 +0000
Date: Thu, 3 Mar 2022 15:31:59 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] selftests: bpf: exercise bpf_mptcp_sock()
Message-ID: <20220303073159.GA17123@bogon>
References: <4561ea0907db7c1db98a7c6d90f831ee337da5c5.1645716043.git.geliang.tang@suse.com>
 <16274837-34e1-f382-91cd-6f646722c7c8@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16274837-34e1-f382-91cd-6f646722c7c8@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR03CA0093.apcprd03.prod.outlook.com
 (2603:1096:4:7c::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c66e3cbf-89fb-4aa5-23a9-08d9fce7ebc0
X-MS-TrafficTypeDiagnostic: AS4PR04MB9290:EE_
X-Microsoft-Antispam-PRVS:
	<AS4PR04MB9290E7C326E76600F279DD86F8049@AS4PR04MB9290.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6nD4/1BxWtFDg+5ipydz78Lp5uDZH34IXNyHrejPzE1RryrdcIfuQyYF/wso6C6Kq/lgQ5sRZA3Lwn/trVJvxyQvX60mdkc9NKgCRL8FHHwtUrqqCSGc1cFfAPNbJTho0lgSGwtzb+vgtkx5wYJb2/bU88frHEZnFJ5pWfnnOpyXzLTzkUo6WCoAlaWklK7YHSmq3/1D8s0D0HZY2+VAZ3cYM92eeWg2cRke6fYyjmIbcp2FZLD6ANW8cKMsJ9PXWTaPglC6u3BBUP+iXX08Ak8oyYv5OlmpMJpiu4Oil0qrpoeemCf+u2TrTql4EwTKjoV88PaAGX597HOWgMJtD6OZdYD9i+rICMq91jGDDR6Q91cUjPOb7PLBDQws+SJIhL8Icm7GrsfbPSS72fIjNnwToYbP2ndDWrg5fIFGrGVIa1iC8qzr0Oh5SVvVH2BM8GtZsbvIIQgZ+EUJH2HP5e0D7qWTpPQO+37qm0khbKI9MhroG3vEyU0S+Dyb8T95f4PKqys4Htzkm0VSYbHdRNSf0dtNneesHRmYid3AUHJhcCjjr3KGdEeFl/S/ZvuCKMB7eEk9VDiTRYc+lPNQ4TIBl6S9zsmh/X3+LoynZ1oSkznSZZXB+hI+7uFZVnoGqKjC0Y15zfYm1RmWnNABa4XWT1H55bPWt9XuRZPchqOierRm4CDlJHIDk9Nvq/C4S9S5E1LKJflxQOHqpI6t38KI7Zjvj2LMj0e9pWb4f+2t6G1YHVbjF9o6iy0KYzgjAFSXwn6Gt//EgxnfxPjW6GeGuD6tirSN+spGUmByH3Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(38100700002)(6916009)(9686003)(44832011)(33716001)(316002)(33656002)(66946007)(15974865002)(4326008)(6506007)(8676002)(66556008)(66476007)(8936002)(86362001)(508600001)(83380400001)(53546011)(5660300002)(26005)(1076003)(6666004)(186003)(6486002)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vWCbS1ghzDGuX9+fXCOmu27HhD7EILozX+CtqsKxW1Be9qq72eE63K+zesq5?=
 =?us-ascii?Q?lJu4iMpO/a8EqHBDAwbhR74cFRcx9zB1yNQ4QW+eazyWhSzwxFXJNdBBzgR7?=
 =?us-ascii?Q?/LbmO//mIx3rGsdyE195oFsE8O00wwrF4nBtIiQoNNvPb2JXvKzkIGUQ0uNg?=
 =?us-ascii?Q?06vurkatln29qVzYNi9zO1w0KE0Pcel0A2iLeb4RnIMG/6hmamrAEsgVaNTW?=
 =?us-ascii?Q?b8GxO3fWHs/M/SQgN30dUQvWVeqgxhxBoVm3Lg3cBziuho5lATdRdsWCPFMR?=
 =?us-ascii?Q?+UJNjMiq2eZqDIuEShWshLylPE8bOqzei8dV7fAWsQQQSbX5iNicgXAJ65/X?=
 =?us-ascii?Q?FWYyqedXcbOp9rfNdV4ogAoKrnv5nB2H+QQLdZN8rUg7uOpxg1m0SgvNmDF5?=
 =?us-ascii?Q?1WwSg8dHxCqZRb1tJlPQXvSXW/dhLDvA5LdQKOp58FdiM0eVSUfPVcWKo5V4?=
 =?us-ascii?Q?4+CA3A9F9xplUQELdkA1QhUNO59CMCM9xJv6R+/XOh2VNEMgKuq3XdMd1eoF?=
 =?us-ascii?Q?f/NEh5Dfb7iLGian/D2JLE+o9pHNGPfwsWdh5E4XgnUonNMvkHen+OuCIreo?=
 =?us-ascii?Q?Lk4Vp3YPzFPX8dB/zNwg0DWeE05Nd2Rn6H22jD49WowFX1En+75CIAKfBQG0?=
 =?us-ascii?Q?VUnhi2pw+jDL+QqU+Xcwo+Hn2RRdyajYrClvu+Qdt+0XX22vqLzfKKhypczM?=
 =?us-ascii?Q?CYCJkEDPsjlVDGTUTJmyK80vh4NREZYDDBcaKTKKtscXDTA0Rod4w8d5TjP2?=
 =?us-ascii?Q?+H/ZKxXKuwgUPVamr5rqkDyaeB9OZ8YeH/AH+ZQhFjwstkqziCWbrRY6bYTv?=
 =?us-ascii?Q?OV+E1F4VN0LiJ9o2tsBiL44gg7Ijh58PdURwd+Kt5C44jeLq1HqffzuhHV43?=
 =?us-ascii?Q?4D10KfmxnHR2RIXsRcKR/mBLzScyEAGsbhjovRRr98dZI6yptQFGcpy4ol6q?=
 =?us-ascii?Q?lO70CmfOPY1XpGKSkoFVOyaRfFp6s1WRdfJkC16jFxtG8hDLUNcKp/99aRK0?=
 =?us-ascii?Q?2ZoMxoZNjbVRgkZDwaW4ny3yrAamm4YkvWVeEkU9LMayzK8SK2TlOOhe5oJE?=
 =?us-ascii?Q?oqa5NZ4b8ifbXikL5E4a/Nh5NeC/DRayBnVRf4NOGiIlmFNGcp0xZ2n1pp5S?=
 =?us-ascii?Q?3SqMprp4iPHHocZPBFJcFGyjYCrVFkV6Chf02JxbwQ+dozl/+9TrMt8B16Df?=
 =?us-ascii?Q?bASlmqWqyvLHSwuZJw8Yfs+FQgKxhI6iNfyW8f1uKVYQe/GYdd0/llmCm7cz?=
 =?us-ascii?Q?/lhHAAXY7jC3t8tdZiOxAL/xvSlHmVeWyvbyQ30Xb1Kk7JAHBNdyy+1L3Xzw?=
 =?us-ascii?Q?dTxYJlRkce6FnKMiLRdLG8ufEfd1tv/RbowSQtUitBHTxAM19PhQB306Qw9p?=
 =?us-ascii?Q?k9H/78FRwu564HRraFsyxxANg4Fo0pQPUnJkCTlUDNGXBDK5D33DTxi+Lm2x?=
 =?us-ascii?Q?iMzp1jkWsuKz0ptmnctjen6sbWrTOXRivuQjU8JeWDTXS7x8m9VW4VDGmP8y?=
 =?us-ascii?Q?SwjWY5lNMr5RsWOOwCdR4YNGaq5tAE44yIslkb0hOCThHBf5gYWp1hMvmayk?=
 =?us-ascii?Q?K0AhHSgZPmhRqRyTrsKAPFPuB6AEyNHwQ8P7quG/Mv2W6WxhWeYMlvPVZGOX?=
 =?us-ascii?Q?2fbZfAo31aZFLGBX4jwjTxU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c66e3cbf-89fb-4aa5-23a9-08d9fce7ebc0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 07:32:07.5487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: evwkqzFlh+mp/ki5tfEhOTGkapFmR7kYE1z5DY7vOLOpRIm3rwYKlyLvYGVx03ArD9CyK7jdCNbViLI5R3c02A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9290

Hi Matt,

On Tue, Mar 01, 2022 at 12:56:08PM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 24/02/2022 16:21, Geliang Tang wrote:
> > This patch extended the MPTCP test base, to exercise bpf_mptcp_sock() from
> > C test as Alexei suggested in [1].
> 
> Thank you for this patch!
> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > index 04aef0f147dc..eba1b6d12a8c 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > @@ -6,6 +6,7 @@
> >  struct mptcp_storage {
> >  	__u32 invoked;
> >  	__u32 is_mptcp;
> > +	__u32 token;
> >  };
> >  
> >  static int verify_sk(int map_fd, int client_fd, const char *msg, __u32 is_mptcp)
> 
> Do you think we could verify that the token has been properly read and
> stored here? I know there were some limitations but probably we can work
> around them, no? We could store items on the msk and not the ssk for
> MPTCP connections, would that not help?

Yes, we should verify the token. Could you please give me more details
about how to store items on the msk? I don't know how the items are stored
on the ssk either, please show me which code is used to implement this.

Thanks,
-Geliang

> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
> 

