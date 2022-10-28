Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130075.outbound.protection.outlook.com [40.107.13.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3949623A3
	for <mptcp@lists.linux.dev>; Fri, 28 Oct 2022 11:12:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S15LoxdoaMN56S9UbkBx5+u2wIZ9dvwNAlNm7CugzcRdQrP/ME4/FDvNk/RzU0knIWi4MQi8Jd4Bnx8OTzpvIVgOrHrcYQZL/up3nT5Q565Gr1wBMd/tHgKPPJKrplKIKeyx3jj839s05Ngkr/CwH/EylI/87p2URK2f14TfhKSGsPuycaULnjYHtjnRaSlxB9WD1vomv9kW1ZX+XYE4i9o8jY6wniTh6R9ElyRVVzsVHgXQGlec8E7J4UmIgkdn7nc5camXJzCbkGSUeghy752Raf0V0dKEQ0bpRIoLm1SMM9+52FIMxUMPMpG+7KgXKM62MGQa9to6u9fc3/9iSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+V/SNQ4uCcfGgH6MYuNZt6gOzSKt+tCP1st2YNj64+E=;
 b=kRwt2iC9s3YhQmJzRuq5ZRQJ4ZsuQHHckLe1C1eKqafEFbX9SKKDmP3go5JZTYDBX/6v7pjvGaxT9hQKGDqXLRGSg4RcSFK7BSLqeo+AKDHGltJyjwCVgDn7kCM6vgF8H2+S/q3h7l7x/oiZQcFCF0sF24isNIK9Dlyatch7Vviuq45MX2J8SRoXXE/rCunF2ZIRuFjV2gsQ1i4mgek2exV/MVd6zXbavWguFzVR4Kuq+7EqD4mAQxZnuUsG4tmO5HJogjx7D8RdKKmi37mYWmYagCDTpPefP1qtkvCm7bE5pKqtHKOKy1LGtC6sxcmHFca/HHSrkiNYSWRkcrDnVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+V/SNQ4uCcfGgH6MYuNZt6gOzSKt+tCP1st2YNj64+E=;
 b=vh3nCGlvNpYkErGs42Vgs+UkUwH82R/c1I1wLnFbADEbe6gn6LvjpJVoc14mMJ8aaDnDkpO8FZAWlMN4dABdNt4raC8jBfFFNhD3lk6yxd0QCHooqKdJE6TDxmZeRZTmxqLV8AaQBdzJkAms9KoDx7oyCJZ8ipHpour/bQFdFL9CltyFog8EXRQtfC84krtne/9/neVY7KOwdx5QKaBZGfPI9AWa0+P78sJ2tznHU9ujqrNzx87RxqGFzAezvH32g1/hcV5qrXj401+D6eNNpjhdxVfetbrZvNTzTW3j8LqLZiUNqfo4Bz9Ca3h4df6OtJCvlPqe7UFWYAC5jtAsIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8662.eurprd04.prod.outlook.com (2603:10a6:10:2dd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Fri, 28 Oct
 2022 11:12:52 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4314:bee:9bd1:afd1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4314:bee:9bd1:afd1%7]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 11:12:52 +0000
Date: Fri, 28 Oct 2022 19:12:56 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 1/2] mptcp: use entry->lsk directly
Message-ID: <20221028111256.GA2511@localhost>
References: <cover.1666780919.git.geliang.tang@suse.com>
 <6c8c57c5a419395f8f4a23aa8e3f76c830f0c12f.1666780919.git.geliang.tang@suse.com>
 <673ea417-59a7-bc9f-9e09-d290417ceae9@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <673ea417-59a7-bc9f-9e09-d290417ceae9@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR02CA0067.apcprd02.prod.outlook.com
 (2603:1096:4:54::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: 73d6c838-a083-4e41-d52f-08dab8d55b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mc9RBD6QvjTYJYYu4qd1BRR59dApnyw4GYphcK6OJXA1UXFujR1RN77pR8fjGZNAwS6HcjIJsuePojOoH1DzFyLJsgTZhZMQsQX2cpIPp+0egE9HwOVfmuUe2TUyCelOOpEHuLtShZi8FeFRcqO/gYryDESDVBpDXZooin1C1ElJiouUzZuq4Xq42OgDD8g+0/tmikXXpPGBvTOGyXg+BJGIXkCfAXrnsYUSvgGwuMSoNSU4yT13g8V4rLN4pg6laYoi4ITFcHRtt4k2YMsdKtyUTzU6xjG3w2+bqAwSiHD2gFbs4+Y+OGB6RrRbPQAlKUGPBWgSUpZ22ZGeVqBN2CdG3ZtUUeo4J7mw2jUwzGRunfPBhAvWEp++FSlLv6Ci8OWZS5GFaP18Oiv2C+aygvL0HGy1lS9jb5SbgpdS9Z3w8Xro+s9VUZmxUEgQFOquo0HdysdCT1D6r17Mm8tQA2jLIeMtcGTd5qbFz4VIBMLV3vJTvwRa3Pc3WwJgGdV07Gnc8lxqvWxlB+7hWKF772CmzbieY7W738XI3l+5N2rN7h7BuVk/AzbJ5fd1MN2IoXFimvfY1v8XHC6Hh4hIcM8W1ChKwMW3Ur7ErsRBFxr3SQEYQgz+mh77PXuhtBLoVQYd5itHWOiQH2xsZ0a+5xeVNv3hEmWu1Xdz4B0vEHYwRsEg1rJQAm7T86An4JaFkg0g7EEkRMZ4sdIs9fhMJYFzKbUwWyc+n0LZTep2hFlIuHKC3ZqyDSfT+EKg3422
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199015)(66556008)(33656002)(66946007)(86362001)(6916009)(316002)(6486002)(5660300002)(8936002)(2906002)(44832011)(4326008)(66476007)(8676002)(38100700002)(41300700001)(6512007)(186003)(26005)(1076003)(478600001)(9686003)(6506007)(83380400001)(33716001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c4ADmbztkynPi6o8h31aiL+/pqtFXCgqeDmeuD9dskSpwO/+evkJMSsM8dwd?=
 =?us-ascii?Q?AASHs/ZEA2y3pVOGXb1CGz9RKiaLddxMjzUvJHJ8QxGNFtaXnXR+Zl3JUdZs?=
 =?us-ascii?Q?+/0LEgECWCAPfITpQnYyoqQxdSwcnFFPJvLps2R7rEWU363lKLTLDSo05nVh?=
 =?us-ascii?Q?jAry8EaeGj4oAEo1FGyxCY3mdTix+g8fYIYUeCMDNH8haYR7R0/cpvD6CLx9?=
 =?us-ascii?Q?0EEpNq1KAHWVvXASp844kVXx0weM4ZcS5ILI2LzGr3Sxu5v1Ugk4TciyZXh9?=
 =?us-ascii?Q?nsktt2G2kD9xPVaV0nZvXGyyYhZdL/iS0qSgP7VDMgAhyegVzyDEGQp4I5QG?=
 =?us-ascii?Q?+/Z+SG8Xn1LxECqcrq4MMY1/F/l48hFdirTVWIAunIWvoevCcgxq83BKx8Q4?=
 =?us-ascii?Q?NqsjXks+2IuHqwpmDeME/Bk5aWAAAjAc1vaRtwobSuaEhd0PMu4djXYTWA5A?=
 =?us-ascii?Q?GJhBIBc7hhX+X6HR0a+7our4nAVu3Oegrk4MJdbKA46CcMcX/A4az829+R/W?=
 =?us-ascii?Q?Q0+axeBpmFJJqh5lF+i8dCH23LnSMGjWgGiMJN8DGTUUusPqlqunxeUORhq7?=
 =?us-ascii?Q?wUGct9Y+rzQCZPemKQjTYcHAFcnkWSAhPJImGIOnLhHJAvAINr5W7FK9IUPU?=
 =?us-ascii?Q?h60zZWyvxyNQ5wd3BCPZClEOX/FlO0IMTC7Mw+piWuabTXLLOpMuNQCYr0RS?=
 =?us-ascii?Q?KFbK17yKR6TyT/Zflb8fPODbTLGpBprJlGEGzJZ+99ws6HwrgMtZUppRhDc+?=
 =?us-ascii?Q?EsNN7dJLy+gjAyo2xt/JoytKIwv23Pv6BZdmOVPdHexx+kLfjNBKtTz9yRUF?=
 =?us-ascii?Q?CZ6l0QjYaIeDY0dp/csso2UmIrVWPEk1gBA/xnAhukAngampL+2PA993dmv/?=
 =?us-ascii?Q?2k/C7iaxH0+a50C1lThqVVFm3I/TTEZF3/tw2rKGsWp6bJBPZK2S8LAtxSHX?=
 =?us-ascii?Q?Ncro8seuGV0/ooSQWP11CkfoqbEpKMt7DT8kO0XgTosUzwpTReJ5035v55A1?=
 =?us-ascii?Q?b62f+WIVIa3i3gKf2w8/dhdXRCtoCadGbsCuh2DsmpXiO9mdQ4VDe+aMZZiT?=
 =?us-ascii?Q?gw0146zxMbO/x744Cpw+Zbu34ZEUbYVxYyBlbVke2eFkaG+oLAkWokovqGeL?=
 =?us-ascii?Q?6/dI//93cdlrQfYGu+TJOp3yV2YXfdjCt5HER7qQ10813kWrAoS8k4NFn7jJ?=
 =?us-ascii?Q?TMS0j+M3oNORSKDZ9PQfEAo5DSUfDNWggxdXpq2L6iixZVz/iiLKEEow8WT6?=
 =?us-ascii?Q?7Ylcp6ZKJIwRyiFWn53xnRFj0MWaeVpPiRZcIj5WjDUAqqQ+Is+cwTGnWwGP?=
 =?us-ascii?Q?FcIOnEUQIHk2HWd2nv7uZnhAr2RWbpU9IUejWqa6G1pISscTZ13ZIeZLoV0n?=
 =?us-ascii?Q?dZgN0NEJWLhr1HZiPW7LTLkXcjfeS9pHzN4o5uPpu+QPEIKJOX0Tbn7AmmAh?=
 =?us-ascii?Q?SYl/AE/+33yFispHnD5u+idtXiILkqjOi6FQM7K2B1BUL5ihyUqUf2B/kT75?=
 =?us-ascii?Q?OBhAWpYh2xrkMmHJJLmwiZEKHXW8iiu1tzKg9y4LbY/DyruZA2+s/oe5s9aE?=
 =?us-ascii?Q?yG1JSoMAqA1CJ4k2YVxSVKEEeaIJ/3OGiS2fgT6D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d6c838-a083-4e41-d52f-08dab8d55b47
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 11:12:52.7825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jzZJkzBjN/U2LlRSfO2rgu60UK7k/SYb0adEqUKV/YwPEnE9k+CGT4KFrNQex9Z4fosgKdwTkkZZROaxRHblw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8662

On Thu, Oct 27, 2022 at 12:50:03PM -0700, Mat Martineau wrote:
> On Wed, 26 Oct 2022, Geliang Tang wrote:
> 
> > This patch drops msk and ssock in mptcp_pm_nl_create_listen_socket(),
> > use entry->lsk directly instead of ssock.
> > 
> 
> Hi Geliang -
> 
> The change looks good, but the old code looks buggy. Seems like it would be
> trying to re-bind the nmpc socket each time a listener socket was created.
> Is this a fix for mptcp-net in your opinion?

Yes, this should be a fix. Please add this into the -net section when
merging it.

Thanks,
-Geliang

> 
> 
> Thanks,
> 
> Mat
> 
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> > net/mptcp/pm_netlink.c | 18 ++----------------
> > 1 file changed, 2 insertions(+), 16 deletions(-)
> > 
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index 9813ed0fde9b..52a5847b9d74 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -992,8 +992,6 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
> > {
> > 	int addrlen = sizeof(struct sockaddr_in);
> > 	struct sockaddr_storage addr;
> > -	struct mptcp_sock *msk;
> > -	struct socket *ssock;
> > 	int backlog = 1024;
> > 	int err;
> > 
> > @@ -1002,30 +1000,18 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
> > 	if (err)
> > 		return err;
> > 
> > -	msk = mptcp_sk(entry->lsk->sk);
> > -	if (!msk) {
> > -		err = -EINVAL;
> > -		goto out;
> > -	}
> > -
> > -	ssock = __mptcp_nmpc_socket(msk);
> > -	if (!ssock) {
> > -		err = -EINVAL;
> > -		goto out;
> > -	}
> > -
> > 	mptcp_info2sockaddr(&entry->addr, &addr, entry->addr.family);
> > #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> > 	if (entry->addr.family == AF_INET6)
> > 		addrlen = sizeof(struct sockaddr_in6);
> > #endif
> > -	err = kernel_bind(ssock, (struct sockaddr *)&addr, addrlen);
> > +	err = kernel_bind(entry->lsk, (struct sockaddr *)&addr, addrlen);
> > 	if (err) {
> > 		pr_warn("kernel_bind error, err=%d", err);
> > 		goto out;
> > 	}
> > 
> > -	err = kernel_listen(ssock, backlog);
> > +	err = kernel_listen(entry->lsk, backlog);
> > 	if (err) {
> > 		pr_warn("kernel_listen error, err=%d", err);
> > 		goto out;
> > -- 
> > 2.35.3
> > 
> > 
> > 
> 
> --
> Mat Martineau
> Intel
