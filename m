Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2043.outbound.protection.outlook.com [40.107.7.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C71717CD
	for <mptcp@lists.linux.dev>; Sat, 28 Jan 2023 02:44:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0EmjLBmMyBR8iyGYiSoQ3MuiKiIBEId3ktXH92d6WcHjTQjRi4qMcVoyh/ORG/gjRRj87d854GxP/1tDlkYRg/T79S31s5mwSxzLugWHduvcP0BkVhUq/L9nQpwJ99bUPJuTlmUKPNRzL+KwaTSuSdnjbF3JTbj3hsBmrap52DNRxPbgDhICKekvO8p9aow45cIRxQM3nL4doI7FaXplcCTP9Iigp5Zh+9QD8zbHWX6OV8n8dMDmSj4HSm/lSHQf4YZ5nAp5Tx03I9O/mvx5+3VMpHzPm1Iv0olF9/1b2IJ3au/AtW6GqQUEZJn1YLboMSoHURsgxJ55V6mjqrLRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdv7rRFmkeJc6FGpFqkxN9+qeBSxSH6lmnE7Qu6BumQ=;
 b=bI5zF0t3SyJ2D2kVzx5/Rui5R965SaNHTeZQJPk/0DbN3yofFlhbZKSALe5z/RbMlacQY+baTND+BQ8rHn8VR3jPd06jhlNyq7p0s+PEYbvS8AMJyxea9jQAW+lGYXEJG/XpX6ef5m25ynrvRhz4ltXIoHQOX7l6GpfodR3ytJCX8n31Bq/3yp2BsUBNG991EV+qN3dutSKob4YLxSFE2n2nOmL5GiT85zdGRKVgermfwbXsdMnQN05q7YvVf/Omzk3WpTWQ7qAcNag/IojfXC9/QiSm/tnpavIJrBUrfriSD+HEHgCOdnvH4NE4m/19IWe8s4IvNLbi3znIEG6m/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdv7rRFmkeJc6FGpFqkxN9+qeBSxSH6lmnE7Qu6BumQ=;
 b=w5hha2exu0pt1o9+w9MF7F1lnuNjjFL1j5hj4neX4rw3UtNZRjCATBZDZ00c5PwKhh3ClZscBIY8Rt92eEt6RyVW5AuJqzigOveJSiZLNUPzaYrUF6+Fv+69UhMPX5OV3o8S5Dnaxmom+NhohubzCUVg5Rof13MScm2jfz6TklwGlYRqvMYbG/GtJrEZsC+U+ybakgSscmrMQN0DfAn6FDPplKt4ZXNvpALu/114KIaiYAvdOG2WMVa3bRWTydcHUiKkNuJ3+yMybX9820Wju7+TD/+Tx1P2X56XnQHXo9Ts4ySyEHM9r+yoPPwKUkz0LSKZb3XhbD5DPmkM2Id9ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7561.eurprd04.prod.outlook.com (2603:10a6:10:209::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.28; Sat, 28 Jan
 2023 02:44:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e%3]) with mapi id 15.20.6043.028; Sat, 28 Jan 2023
 02:44:25 +0000
Date: Sat, 28 Jan 2023 10:44:49 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2] mptcp: update userspace pm subflows info
Message-ID: <20230128024449.GA3720@bogon>
References: <d262f6beb6899f0a79acbeb1d3c8c855e95e098a.1673599496.git.geliang.tang@suse.com>
 <5d756f95-0a7e-fd18-ccf8-4c206b5621d6@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d756f95-0a7e-fd18-ccf8-4c206b5621d6@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TYCP301CA0058.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: fefe4edd-fe64-451b-3960-08db00d99165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IQdmoZ/cKPdHfQXQWQKwhceJTVBRTHMnt30sWkh6eq5Em9S17CRE2pQ45XA9WySsNan42xLuwmFoRSMAA3fPbWcPL7eLaQQr0Ke6GLu8Fj6FgOs0Qr1XK+8y/WfJ6+bRWdm5eGF2AnP/I4EMgX4HC+B66beEIlm2cV88RIc+3bxpLJj+X9/nolJ0zjrREEr7bwkITDiWjAuIUGzpjUIrqVRHST8i3zU+alXnqHZL5imcQpkhaTB2E/e4vgHBqHY8+BluD4+lPJHXCXMm74uBZD+F6kj1JOkkUoZ1S54BcidSpolSCvhDBgTuJowkzXk2rlArXzKZK2mWxVSgnIbZTM6Lx6ETNvlQRgEgNbI4OO3HgXLu6iMYJMDPPJUs/x7bpbuJiBcjVqwHSf4JO6lT/zjE/U2k0foVFqxm7ZfiTwCCFUD5ft/grP/aQCY+TdZamCwYn3f+SEJrK/OKEwA6F9zhjeEjVLcMUiU3ZEs3cHJZR2BhLJoy4oEOpE2NZWXWYHun/wmjFGYYboWEB+NsxqSd7Fj/mNKkgCqfBI3GOIutwY/4vZZy9/SytBAccIx7bxk0bRqMlAc4ad1kx96beij4yoMHMHJbYjLSEhMSVBosVo3w9D8LCk7sqpyD8LgaQhhmA/IBNpfe73veYIvCXgXYRloZSjpKkL6aRnc47xz2oBWXjHj9DIN0+9bbMSm6BOqEuGrSrp5YYoLrizsNZ7vk3F+1kWlM+wHxy8yU1c/xZbINwjLFHb15EVWP/nDM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199018)(41300700001)(8936002)(44832011)(86362001)(5660300002)(83380400001)(38100700002)(33656002)(15974865002)(316002)(66556008)(66476007)(6916009)(66946007)(4326008)(8676002)(6666004)(26005)(6512007)(1076003)(9686003)(186003)(6506007)(53546011)(966005)(6486002)(478600001)(33716001)(15650500001)(2906002)(13296009)(18886075002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xJ7kDlb7G8+l9poZ5pNB77JM7NcEeLiNKbTJO2VbdSehYFdnEDG98miNkNEi?=
 =?us-ascii?Q?RBi0e9mmLT3AFeGCVDeO50EE/MrQGYFsXJer1TUp6EsQue/cVBE25YFCH2I3?=
 =?us-ascii?Q?V7L9bH37yL8UAjTmYQkcJWzcj7ELFNdqqVIfTkX80f9A7DmvZQKzDCiLteOX?=
 =?us-ascii?Q?xvhXzxu8fEzPahBJYBK8R/7ePddS+klK68TOyHLlz0h6jcKHjQPr6VpTtArZ?=
 =?us-ascii?Q?ESd6E+YYZESLJuhKyPYjkz1KQO+cZnm9V+cJ2rcq4NMg6YVcoeqK8lCHyRdr?=
 =?us-ascii?Q?E0nUg8fy6asSftjW0oStTfW7jJwhPQ3TMs3bJxWy/IzdYeCz4P+8wFHUm6/I?=
 =?us-ascii?Q?WWaPXKbWTNbH3jNz8IFiukKYF4YIfFtpvOEn4nKVVmhLtSOlvlKjTYuGZdFG?=
 =?us-ascii?Q?b0U/64jxodT8rGO8ae9s1peIIwd6CiugqO7o1QI2f43pzIr2DGdwUv0WB8uk?=
 =?us-ascii?Q?lgQiw6nY+y7pCObzzAY0T1v32zOsC2vzecW9kL9Fayc8AjMxm/4oqk/JiBRK?=
 =?us-ascii?Q?5AqTOHAQ1WwV24WvaV8PCnRPVp3UuOztX46IZllAvH5AwuIXxS6G2Jg3kXdQ?=
 =?us-ascii?Q?VWTW8HHUStZQ/vHj39AWL3HzlbIb279Dhi74nYA0sBVl+3dIFxB0io7BcXI7?=
 =?us-ascii?Q?gFa36eiR6Df+DggXf/iNvM80+BkY+86dTvhmZGqImoveVhelmDKgCDH61+mn?=
 =?us-ascii?Q?Rek5naPy/rWRfYOiPcV7eDVBitXt6YC36qNb+JvTwVx+ny7ZLWSl/v+ULTa9?=
 =?us-ascii?Q?PHqF2AmZ8wiudak3Dpqdre5+ZNZP8VQ9G7Ot8dnHWphkvSmYBrbkFXr/6611?=
 =?us-ascii?Q?qEe1IOr50HPJ58UXOh4T+TiaytUpI9D1WjN0a7TSkJHoISCks8Q7/FQsxuxx?=
 =?us-ascii?Q?KQGwnjJ42Z72iD748w9RUugBAQzWYIlVGcXNWQnD5Lzv/rZdx6F7aRsZsY9b?=
 =?us-ascii?Q?zF/CKcadVG+SZqOkvCCaNcpJVimZzyEAbyKSkWPFbaZUjRtn7fM8P1UvAq+P?=
 =?us-ascii?Q?/4QMePixHylaJglGYrtsH/wboRelPKqUrTCUraZ8ksYlvw6l76AUiEUAQX0m?=
 =?us-ascii?Q?onXHjMTpFj71V5R+TFsgh2VKnBDmcFl32uRvsWya434TeVFs9pfwWa7WJNZH?=
 =?us-ascii?Q?MmwNW0o2a0U1Zzqiqyjf5gDsyzniRmSDwJC1E9B612NR9MRkdghjU3tr8Klv?=
 =?us-ascii?Q?miA4thSX5YE7kUv56Ah+qhMmSVWcg4KDRLQIkxxfrjYZ6ls64FC/HKlpPwWT?=
 =?us-ascii?Q?l1rut5HPXl0l+nS2NXZP2Taa24GwxetPAqDPNlEAEEHhW5kUNSHy8iHL3RVz?=
 =?us-ascii?Q?CKTXi9IyO9itcqk3JqsE4gyaKw6RHFDdZCRmglTuaSofgMqAM7hX7KOIj2JW?=
 =?us-ascii?Q?EiRW2XQ3JsFwGRo6uOyN0xfZHLtE+bbfUok4vfu+ARYWr0/TcSj+6nbHZ6hk?=
 =?us-ascii?Q?1WV8BuFeOogDXy9sTqJMwfBj9FKia0sdUrrJhzKbMDvLjOrSMR+dvHugye3j?=
 =?us-ascii?Q?e/k5/fpV3bhD27H5N2kPa1ZiMwyIA7Q7NkR2yoflde1IEH2C0eRAGN1ZeDDG?=
 =?us-ascii?Q?5YgqHUImlZFmZekyTN4LI8LAHG6L2aqDPIj1WGJpG26TVB2PEJE61Xzxv3Dl?=
 =?us-ascii?Q?pA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fefe4edd-fe64-451b-3960-08db00d99165
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2023 02:44:25.5602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nkIKRpCJ/itydP7xPSSVT76lyqg1K/QFTAx4K7BmgemdB2t7AHavvbtDE/+aFiRpP0JscfZcCoI6vwvFAWqEPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7561

On Wed, Jan 25, 2023 at 07:13:31PM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 13/01/2023 09:45, Geliang Tang wrote:
> > Increase pm subflows counter when userspace pm creates a new subflow,
> > and decrease the counter when it closes a subflow.
> > 
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/329
> 
> (sorry for the delay)
> 
> Thank you, the patch looks good to me! But I don't think it is enough to
> close the ticket 329.
> 
> I think there are other fields visible in `MPTCP_INFO` but only updated
> by the in-kernel PM. e.g.
> 
> - add_addr_signaled
> - add_addr_accepted
> - local_addr_used
> 
> I guess these counters should be modified as well (in different
> commits), no?

Yes, I'll modify these counters in v3.

> 
> Also, I don't know if we should consider this as a "new feature" for
> net-next: to me, it looks like we forgot to update the counters and it
> is not really a new feature to update them but more a bug-fix. So maybe
> we can target -net? I'm open to suggestions on that point :)

Sure. I'll update this in v3.

> 
> Not directly related but for the issue #330 -- 'subflows' counters not
> incremented for the server side -- it could be considered as a bug fix
> as well depending on how it is implemented: if it is backported, we
> would have the same behaviour with all kernels. Or we add new field(s)
> in MPTCP_INFO but this is maybe not needed.

OK, I'll address #330 in v3 too.

Thanks,
-Geliang

> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
