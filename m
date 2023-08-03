Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2043.outbound.protection.outlook.com [40.107.13.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2889450
	for <mptcp@lists.linux.dev>; Thu,  3 Aug 2023 07:36:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqpO+xCuy864HYsqBq5wv5A7l8tIhKSUZfXi8vxXr9OQngnt68eqfAjbvPCCxugph++efUjXXpgGBM/aAKgz9MIeEBfvD0S86DIX+d+CC32bmdj77eaWwbh0X5uC9y5/ZDMxUW87XxcE0vHkw+BrdE2EWgYBT9GnH0qen1h8d0deZnHg0b+XctmfKHDlUdxQi2RCblmfaQ4TxjoSey2aW9TmpmfTOhRqj6tDdTL4fg899q2q8t68k7wz3LTaKapsGqLhq0WMZipnBJGVgAAr4EOsigG4cdmT1UL1vndmFxvS/LWdIo0Dbx2NuyOdPBdK9ucAR/TwmZZKbhni3BAwNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMCrkXp9vFC+4hVP+x9kNY3PIEvISxm0i0dRfu1rk4M=;
 b=VqbplIsJ8E+kmIR7wY1WwHB6MLra7Ok9r9k7i3/gmuVHL3BqYRCoHxReP/2m+DVK4XVsqRBmfU+rsN10Gij5liulR9aDO3Sg+vf6JE+pl+AXOimC04uXvjT6l9kQPmtxQCDR9a33pJTKZc5GSa1E/dRYRjREo71xVGQhpL3mmCsgO6NpJMXtjlhD8JnZYZzPOCiu8nKW4YJ4Tcf/Y/ugCVzUr91Y5O0voFbhMoKHQdETOhco1p4797sAf2XB4hWxeUNehamvnZL5Zw9LkKJxA8jrBbfuDoEtqFAgLqGxJKSYSuZH6BAVRm1C6Io+8qHtTOPq7VtdAuBF/QusqF8PVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMCrkXp9vFC+4hVP+x9kNY3PIEvISxm0i0dRfu1rk4M=;
 b=JkP/BUETAsdRMTolFk4915lbSBtdAspd7J4L9ioloh4nbca7G5PXz4/qbZ7Bgi80U98/ShYYu7ivzAV/jN5he8UgBN9Ek8EFgFtIeq3q9xNceiWdNotocWrpv6q5uzqJcvpo4KgX35FXzUd6gi+X4XfvYsvWxPTWWi/ryuRMHKelBpwkVJS2kdtmv772k8n3p55TK/4y6jKHGSGUNITVHqf8xw8aS7XQn1wLh/ECadRmybaqu0bclHcFBBeE/ZpETyru92jf7Crn8GTEDo7UDVxwPiItXMrVYmr0a0E7CJL16BmZkXr6eCfFxSKXdH6MRn5K356eCtIUOyliMkz6tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8571.eurprd04.prod.outlook.com (2603:10a6:20b:436::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 07:36:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.045; Thu, 3 Aug 2023
 07:36:10 +0000
Date: Thu, 3 Aug 2023 15:36:24 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 1/3] Squash to "bpf: Add bpf_mptcp_sched_ops"
Message-ID: <20230803073624.GA6125@bogon>
References: <cover.1690952908.git.geliang.tang@suse.com>
 <aaebf8f891475fb3b946be734aff714530af09e4.1690952908.git.geliang.tang@suse.com>
 <1bf9dba1-095a-41ae-ac25-6dc05918806f@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bf9dba1-095a-41ae-ac25-6dc05918806f@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TYAPR01CA0173.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: eb0cfca3-28fc-4a5a-c5f2-08db93f44ed0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pEwgn4B67gNrwlRkitT2ELZla00orVfvjnoyTxaPeU0erJD4pm8Iaq4nhZmoAzinEZ/NgJ4NObGKyc1h0+FS/7UZsdGSjjpHSxvMXqcHkQqdllGy1+FDOdemG4FoDCMgcWACvEvTily3zlKecgEMWOId3tSrTGfPehR7jJbYwxZ5Wy5cMDs7qFGjhpNIgy5VMJAzlLA6e9ypgo18DF0Zq7HogGDMdJ9EJrVE8c9qEENJDfHF52M3bKmzjmcXDet0SubZAlMqxP0W+CHm9ENSvcuR/TKbFi94mzEkGuyzPQo7ARk1v69f6Q0SlbnVEDl9rk5gRqrHkINZ9NJ747493k6nB+Es8H24cWZ2jYkfSEflcODu9N5CAMIJwf+14kfpJ5LG+/1wE1KCQPh6c9JkDfwPmQ6hLJgAcs1lIcUG9USJDk2ib5hUhqSbu69EW84RB7N4xO0W2dnVXtIu8md4WdlYyZ+EaYpgDIOMECmLlolaRjRDTERMljKSB3HlKD3L3MNRfqkNEMM7ynDVgbsOj+ZQxIH0FIU+8fqkrEU9y81dosGZjSZKMjvwd+Mynm7YFLJ1YqgpqI4ogVM4bpA2pr2wr3TciLjocb5cCAtXUyIhD4sMxUJ1hBvFecLPxDKhcYxcyeVvhMXng53cyJXsHmybVjzWt5fIJV0IVG9R59FRKE+FpPxmpLf0OYGEh8Zk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199021)(6666004)(6486002)(41300700001)(478600001)(53546011)(5660300002)(8936002)(8676002)(186003)(4326008)(6916009)(9686003)(6512007)(316002)(66476007)(26005)(1076003)(6506007)(66556008)(66946007)(2906002)(83380400001)(44832011)(38100700002)(33656002)(33716001)(15974865002)(86362001)(13296009)(18886075002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vMG7x6Y+8TtJhx8AdLozfSRBgxRxZwFPf41/bIK3vsHgdO+GhHDRwlmgcQwm?=
 =?us-ascii?Q?3ZMaX49/aqZy/gapo0eHmDSe8zDXeqPITZDsA7OE8fi7/lFf0wF55r5QnI0L?=
 =?us-ascii?Q?CD+LFDuZZfrpuS0CZrETqARvjO9A6wxR8luAPdHX6OzzCztgux/nL2ZoE6EZ?=
 =?us-ascii?Q?3JBvRSbx/1Ryy7+BOIBNaAOSxrDGniyZYLzWzxHt+q5Q026Jz5A+BsORMLjj?=
 =?us-ascii?Q?NOdgxzQYHDX0Q3b/SBvbwpSY9ixK06bQX1ZYBfdUFVkwOfK7rx/tbU58d97C?=
 =?us-ascii?Q?EVeRcIHxy53/yEOy3sLEZUSpjSN4leY5DDhpUll0ySZ09L0DBa/ITVigsdZD?=
 =?us-ascii?Q?OCb0r1iwDV1BqOGlDMw/4MnRtdqKckjuKI06SYgdh7LqjuL0X+hasGcvkcGR?=
 =?us-ascii?Q?9hQnBAPDvA/9V+h/znXb9RwVMR1rtLo8vRnIImsToSFWWYFSNMRSCdM6Laxv?=
 =?us-ascii?Q?yPQJphsDeo0qTIRRHHoB3K3i9sMfcVxDyUCRziOI9MJIiA+MvH4K3oHTPptt?=
 =?us-ascii?Q?8Ok226yL4BFncd324vfejqPxqgB4cKnv/FQrTCOxttiF6oAa1gogUaoQZQNE?=
 =?us-ascii?Q?vTRUO1XwO/m4lM6ZcoRmE1LZYX7coioZsc1xegi4h8c6fhw7h9wEh1PjquBG?=
 =?us-ascii?Q?MoknUB+LVH4UwwvHIjMjtZrG2ukmCRC0o6F2lbHMkbiJcGI/qZh45EtqsxHn?=
 =?us-ascii?Q?boze8fm4+Qb/JfQqX8GQyGt25ijrUS1zejPKKJnDnqyzW5OkdNj3KevNbeiS?=
 =?us-ascii?Q?TUVCBraAIWZXpjoewNw0na/QEZ/mleSTqNAQEkzUewuouE+1Id9W9IN52Fj/?=
 =?us-ascii?Q?vgYGzAPgCQvkG3Lesdr81Vr7zOeSoINiePRfHaozN1i6ndH1tyPolr5Bxjn4?=
 =?us-ascii?Q?MirjX9G1ptfykxTQ4NdNtl2gQxgdibZtVpUn47kQC4AAnTuEqJazVW7fkzJY?=
 =?us-ascii?Q?Hvkmxj3Rri+myhNYc2Xayr2ix/wM2zhH9u8RK6tE+P1vxTVtOFzpBc3+QZgf?=
 =?us-ascii?Q?MEp8rT4g1ZiTsuYP52J5V3M5PXV1XzlM9/Pd9Mvy/EuoZgcVr3n7uK+leYuu?=
 =?us-ascii?Q?CBZhKWRrX8yW9vWL4T4gyCqImNEqzCLKoN81vyzlJvTzG/bPjFIJ0rX4XHcD?=
 =?us-ascii?Q?G/d4UFeXLyGY5fEegt9JF2H73pL2nKwgDAylvh+0z6pFk/Ffcv9HqlIL+YU9?=
 =?us-ascii?Q?N0eIC5wHku+CaaWgWZ7huvCyTXpbmGm+9IaocGfPO5MftrVF54qnCtdYOxrq?=
 =?us-ascii?Q?XKPXVT7ZOHXZ5pRX9HF+Tcaiq+3xBqOVZ2BJgADLk9l1OaJ4oneQJnGzYg/f?=
 =?us-ascii?Q?vOVtvrUOq+DACBtP0012ztFsfasnaebfSYU3eWS3Tv1v5xY011cP7fVFxnP4?=
 =?us-ascii?Q?hF4pRfFWw4KhS05jqBoaekZKy4bXfTK7G6tRtbR8kzhGPIlFXE5Iw/sz35Bz?=
 =?us-ascii?Q?uUDwIPsJgUSnW2bOdpVcCRB+bQCfdn3adceheSY1l9utp5LLBN3Rw8n7gM93?=
 =?us-ascii?Q?qX6bWp50fQRIu00Ukqa5UVt4v+Kv4a0X5ezrE2cbQFukrYkca7sxkL2AaSfi?=
 =?us-ascii?Q?kQc9jxEhySmjkf6cb/wl/URhJtB7SCPW8XlS0rmr?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0cfca3-28fc-4a5a-c5f2-08db93f44ed0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 07:36:10.7745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HiXCTUx8BbrrYtKlxCEpimJTZO+5kL3rIxB2YoLEEXHp+dLxM4DhqDT92Obc7kRFsKtwrMqcMNx+eNYvW3kAOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8571

On Thu, Aug 03, 2023 at 09:25:42AM +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 02/08/2023 07:10, Geliang Tang wrote:
> > No need to change subflow->stale bit-filed now, so drop the writing
> > access of it.
> 
> Just to be sure, do I still need to apply this patch that is no longer
> part of the v2 series?

Yes, this patch is still needed. Please apply it to the export branch.

Thanks,
-Geliang
> 
> Cheers,
> Matt
> 
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> >  net/mptcp/bpf.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> > index 51634efe4741..5c82cc35bfe0 100644
> > --- a/net/mptcp/bpf.c
> > +++ b/net/mptcp/bpf.c
> > @@ -52,9 +52,6 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
> >  	case offsetof(struct mptcp_subflow_context, scheduled):
> >  		end = offsetofend(struct mptcp_subflow_context, scheduled);
> >  		break;
> > -	case offsetofend(struct mptcp_subflow_context, map_csum_len):
> > -		end = offsetof(struct mptcp_subflow_context, data_avail);
> > -		break;
> >  	case offsetof(struct mptcp_subflow_context, avg_pacing_rate):
> >  		end = offsetofend(struct mptcp_subflow_context, avg_pacing_rate);
> >  		break;
> 
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
