Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC152F28
	for <mptcp@lists.linux.dev>; Thu,  9 Mar 2023 12:56:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYQt7qSKALl8AFHnV8b11rO73LtcYkL22+XghuiVpNiq8a2uITZCzD5PN+2oB4cZwEQzZicdYGVoWtL+i4foWf1W45ea6t6c38bGXaTqRypXtYcW9Guls/xzVhwawIPxFdEbhB9AWrewyP0cD2zYe8HwSCVhXreHelO7wAaOvZCEFcbbnEgL0boUT7AN5J8zWE8G1ij/DRXjJdFPNU1qOfZkp1jFDy27r9O2yeIkfba3nLg6nPviplle4no3DDupjIqbK55gAR5jEMb5FS61BKCshwphLRprgi++ngxitDH/Jc/PP/bX5IhRT765swOV1JD3j/XxWfO0ydBg6y7QvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2MkPEynqetT8DXjTOBhGU1qztBldT4XT0/UB5e9kic=;
 b=gcmjE88GIRp9ixN2zSPpxuX9FwqTwEHZgybFd8Hsd4EK7uDjWQR40m5mxW2eoHAJR4n9ANDvBNMnAycjFtMgc4cyRuJRjYjyofREZ/vihPTDkHYhbR3jIjmp7pGdOnXKGKBZ21OKTMhOymbnwEtNoFTKS/tBUibEYp3q9Ls/fsbsDlBvKSz8V8wDRwwiGsr2FEcFkpuhRPGAkAnJ5E/F2zmFe24zkqxZXm29JwwewN2pV2OizMe5gFcN0n/xXgO2Ny8GTOwmRe4A77hraEGxTaNrLYQocbTZo+NrA47NPGNEalF2fU3yPxzSYy07TnauGaHWNixDTAfkWZo3up122A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2MkPEynqetT8DXjTOBhGU1qztBldT4XT0/UB5e9kic=;
 b=CdpQ/OFA0FW/KL9Rg/KJPhtlo2DAVYoLt7H6bvgZuXErRS8sudjoBOoMk6x8bbYI844/fAdNwGz6lXKu38Dy2puSU9ywTBX1aG3rVEHG7O4xbG1XyEd2POqDyHdhVDyTTo00oqrRGbPMHqhgfuzjpU4+p4tchfWKrJGX6+BeauefE6rXxYwtS2H72gXxwJKWpKlY5rRN0BznVVX03CnNUZP5F/w/06ZaZVwoyeyrDaIMXb7z4jU87cxbIS4m7TX5zeCLsIV1wSJSxrCzDV1qpVSNWshmO4HUOtkKg6nH2aG6N+MBQr8t0i5sfbVWZJ7eIbudhd6D7/GCTWxgYC/5qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8369.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 12:56:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e%4]) with mapi id 15.20.6178.016; Thu, 9 Mar 2023
 12:56:57 +0000
Date: Thu, 9 Mar 2023 20:58:16 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3] selftests: mptcp: add mptcp_info tests
Message-ID: <20230309125816.GA8814@bogon>
References: <9b5a84ef14899800a8a0036cceae0406e016596f.1678327360.git.geliang.tang@suse.com>
 <91a93914-4bd0-12f2-0eee-684ca8215fc1@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91a93914-4bd0-12f2-0eee-684ca8215fc1@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TY2PR06CA0023.apcprd06.prod.outlook.com
 (2603:1096:404:42::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8369:EE_
X-MS-Office365-Filtering-Correlation-Id: f18eeac1-6a3f-4ff4-c7b7-08db209dc38a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cij8FLSEa9GD1fMaM65YZS2n9MS+nario2JbjRVljhPgU4waYBJzu7mn5gG/9KHttZANYU8n3SjvvcLXBnRpTjMfG3ffReunrHeoVaYbTy3+P9pNlwo7pTlBGZnn1sQ2GSobK+nEOQy0ApmWL+PUsi0AEcbhLg/aXPAKieKONEHRaYi0d6sOqi/qVEA1MqLny64yxkiHnAHCMEi3lkruyL5A8ghiWbrQnCtZ2TciuTJnQrj0a6/rLPcSeM5Rb7WocU7CpaXN126yr5xJw0S5j2k8atWuOWGbKJ5GPq/u+p6a5BIz1Tqqj+zFLPaH9xyvKxxZEqPNi0LSzKjWDGfqNuulisTOA7Rx/Uq6gRu6688AyfJWUzivYtCxOI6Z1hYHSaQ8ui20xCnX01b771IDKM8J4dk5ExavgNmo07x4dqNYGPl+she6Y8V4GOFCf0ayGU1I6OYxlT/d6QLuX7BskPJ4ECFmmSiZKyFjfKmVUAOre+BoS+bS6eN3ssjb/t/DZgmnpSJfS+S0ibMaEcOvYwByjz0SLrx77cVq2irTJfXjANUsOegGWu7eMWh4kVaOcKdGYqzSzfLT4lG0XjJwB/+MZHGE7kynxsi0Pd04aN1yrjO76plArnwpGZN42MGwHNNxsZgCyH/Cv7vlGzJwdgv8An3wG1MuB0fL4jmApE6/RErgoV9Z0knbinPetoqYvQE1tdosNTC7dDgLwhL4ow==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199018)(86362001)(316002)(33656002)(15974865002)(38100700002)(1076003)(26005)(6506007)(53546011)(9686003)(6512007)(6666004)(83380400001)(186003)(33716001)(8936002)(5660300002)(966005)(478600001)(6486002)(41300700001)(66556008)(44832011)(6916009)(2906002)(8676002)(66946007)(66476007)(4326008)(13296009)(18886075002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MWNcImn4XmGHRKNeKWWruD+oVKF08XMWvobo6h4V/aHCrl5LFdEZAl1D7nKe?=
 =?us-ascii?Q?4QRrQHrIJSCBdomQ2dT7E9o/qIjUG6tBs0M+jBZm5QqTyPUMdfTFDK8hTwmE?=
 =?us-ascii?Q?WD4v8fMfpapGPectR+FOxMPwCx8wXPScb/DaWfYnh/VOxdXWXhtngcQU6rxj?=
 =?us-ascii?Q?gbfsU+Ekwx4YOKqhlLJJZg5zxiXnPOLTy0TUhdz8dp7pDvourB7CJyqWN/Iz?=
 =?us-ascii?Q?s51hrxe3tvs58pITtoHwBl43mhL/CqFN4bGK+g7hTC0S3uBP9WN4/m7NvDH8?=
 =?us-ascii?Q?suKxKiJqjVa0FkS8ZdkvJEI/Zl9sWW9FcNxnDFBRjdZFwytBmP8miCMBbipj?=
 =?us-ascii?Q?RgAGI3chkc6AS0FzfijJxpI+UYTHILRVhDDpRJcqeJBThu05Kx16GSH8Fid5?=
 =?us-ascii?Q?0LAztUw5gU/0/GTp6sHLPDCQ+f8vZgCjTQ+ffwCTJlMaVvTurvCk/C4MIRia?=
 =?us-ascii?Q?lkZdLbbxi5ZTCmghNNbtCboaXrykhT0c4Lxwm7aCekNVZY6VbyKfQk+6VLEB?=
 =?us-ascii?Q?mqGAZvEwGnpMTHv6KDbUlnrcstVckNRn0Lt/t2P6zGqiTrCvdwQsPI7wgcN/?=
 =?us-ascii?Q?F06+XzZzsWkrHIpQjQ0lqTbcx3SwbTGyFmHoFS+jKkON+m1Xt5F26keW6HH3?=
 =?us-ascii?Q?DwSgC/YN+/7ADEBoxkjLiAzPAzIfpWXWe8d6JXgsW8ihcXuFcB+eXtLVGOBB?=
 =?us-ascii?Q?xTe9XAqOszlVRcC4sCvUYrMUWSesnvxzWUlx7whNbUTLdy7CaSydUAyK/wI6?=
 =?us-ascii?Q?qsPrzFdUaPCiuOqcAIgP+ZXTb0qAV1P7Wxpw+m7FABiowcxvcaolAvWOfv/v?=
 =?us-ascii?Q?MBsWoxcGwKypAcbrQoKJS4CXoXUv6xriDyINyYtHMxab3P7b0QOwX0QELS7w?=
 =?us-ascii?Q?wPfovePVcLnbqFxelnFlFYAR+ckjjl4PwTzUvMdXG/jHYcXpk9rh+qPNWn9g?=
 =?us-ascii?Q?+BVeGHhCpf3bfj5sGRy9+wXRSd6aBw8f0IIIkYUHn+i7YxGJ9MaH+UgoFPRk?=
 =?us-ascii?Q?uldU7nCoXSwQlT2RI0jJkxniXRAE/1gPhHjbeo2IEDXbYxQpcFVdgI5V8GJf?=
 =?us-ascii?Q?xxyvVqN5bSu33tLsL4gacNS1XD3qMqndAHY/+AEFd4ZfceVFVzKnJij4xEGg?=
 =?us-ascii?Q?x9NzHbmj6JvPjaMdBGsoq1cBBGVSF4O8KTRgyCshqDZyvFIICbI4aB8shC8P?=
 =?us-ascii?Q?5NzYFZXOmdREyM94ZQ/ZN4vC1roo/c4OMhce2Pkg80vh5Y8SX+f8BPpZp0q7?=
 =?us-ascii?Q?VrbO0mjMDezmrF4Y8DlFlc2ZxELYUOuP4Gxk9+uxnHO0WBohkRwa0JqMuuq1?=
 =?us-ascii?Q?e35C+pKFGQqN4ve1M21mjLbKOGv463iTsdSpD/ZCIJd9UrSjaN0RBe+FL4BB?=
 =?us-ascii?Q?DV933CbxBU64xG6YFgLmZmQYOdqo3L5/7B5tI46O1kJnHuWCbEcTT3CzL2Lk?=
 =?us-ascii?Q?0oif0Prql1pllGlFRSLhlN5yt7DXS7ogFsbQTnbwVxme3wO8lDlrprwfrbl8?=
 =?us-ascii?Q?Elxf5DBhlmeD0ULY4BlMoan27OKau7nBRh2ey4hjbucM+//fgNCxuil2uVwf?=
 =?us-ascii?Q?YYdCPAYwY6XcgAYJmCY2umLV4rMFZHy4KMuRHJorzsH4S9HOxHeD9y3ZCFIZ?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18eeac1-6a3f-4ff4-c7b7-08db209dc38a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 12:56:56.8632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+qI4a6cmNNdiMjoW9sreuenY+fB2vopXmwNcGRM2W0+0ObYxBBg7E5wQom4DiQLbjhdF/LY0ozATk/rlhX7Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8369

On Thu, Mar 09, 2023 at 09:38:34AM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 09/03/2023 03:04, Geliang Tang wrote:
> > This patch adds the mptcp_info fields tests in endpoint_tests(). Add a
> > new function chk_mptcp_info() to check the given number of the given
> > mptcp_info field.
> > 
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/330
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> > v2:
> >  - use '-D' option instead of '-i'.
> > v3:
> >  - add tests in endpoint_tests() instead.
> > ---
> >  .../testing/selftests/net/mptcp/mptcp_join.sh | 43 +++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > index 42e3bd1a05f5..625d24d94576 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -1719,6 +1719,46 @@ chk_subflow_nr()
> >  	fi
> >  }
> >  
> > +chk_mptcp_info()
> > +{
> > +	local nr_info=$1
> > +	local info
> > +	local cnt1
> > +	local cnt2
> > +	local dump_stats
> > +
> > +	if [[ $nr_info = "subflows_"* ]]; then
> > +		info="subflows"
> > +		nr_info=${nr_info:9}
> > +	else
> > +		echo "[fail] $nr_info"
> > +		fail_test
> > +		dump_stats=1
> 
> Do you mind if I replace "dump_stats=1" by a "return 1" when applying
> the patch? No need to do the rest that will probably cause bash errors
> below.
> 
> And while at it, I just change the 'echo' to say:
> 
>   [fail] unsupported argument: $nr_info
> 
> > +	fi
> > +
> > +	printf "%-${nr_blank}s %-30s" " " "mptcp_info $info=$nr_info"
> > +
> > +	cnt1=$(ss -N $ns1 -inmHM | grep "$info:" |
> > +		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
> > +	[ -z $cnt1 ] && cnt1=0
> > +	cnt2=$(ss -N $ns2 -inmHM | grep "$info:" |
> > +		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
> > +	[ -z $cnt2 ] && cnt2=0
> > +	if [ $cnt1 != $nr_info -o $cnt2 != $nr_info ]; then
> 
> While at it, I will also add double quotes around variables just in case
> the parsing fails and return a few words [1] and use "||" instead of
> "-o" [2]
> 
> [1] https://www.shellcheck.net/wiki/SC2086
> [2] https://www.shellcheck.net/wiki/SC2166
> 
> Also, do you plan to add a similar test but with the userspace pm?

Yes, this chk_mptcp_info() will be invoked in the userspace pm tests.

> 
> 
> Apart from that and if you are OK with the suggested modifications, the
> rest looks good to me!
> 
> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
