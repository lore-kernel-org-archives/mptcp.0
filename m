Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB0948B5
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 09:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645177196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wtBEWWflBqhObtpnzWvSR18TU2/D4BRdTPcu7vD8Usc=;
	b=AnHgGrtf0WCdLlv4OmIwJUFzBKkPrSKS7wEBocAsklkSPtpPOfQ9aMmEME/uaiIfjtFIaa
	O8Zx9FkNxrTHKmt471ExMheRvLN2LcKBuaTbiWhIMhhzLR94f/2cF0dL4ZMEcakD9x1EB9
	D6To+MiH28DSyMwpoBsfyqUpFOQfGsQ=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2055.outbound.protection.outlook.com [104.47.13.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-K9-SC0cpMRCEgxk64Uc5rA-1; Fri, 18 Feb 2022 10:39:55 +0100
X-MC-Unique: K9-SC0cpMRCEgxk64Uc5rA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLFpjd2+ObP6bM3PqgwDd8w8TSZ9DTKlHOWCFG6tEyqvdkv8EcE3f98aDsokglXnR0Fi1wmAVWq4Txx/w+QPvSEHEt9//d9FWaI8B5UiSXbR9HBrROsJOXWDAEHddbb42Nv0EXvGlo9lwodTKgumnL3jDeAfTquWeGB2n/Gqg97Sy2s6N4KE/1IGbWfuheSYjJqWoZUYacyCUFF0wYU+fjxelevXvyaBQ6DvzeXQ64IdQ0b8+U4ZWNoFGlsfcYvwk7xb/CyF1bmXH8joMTqkqOXh06T0HJyElyRtSHK0fYo5nS2B9/btUetg4l3us+CVa1E7G7N129FNOKBSCRDHWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtBEWWflBqhObtpnzWvSR18TU2/D4BRdTPcu7vD8Usc=;
 b=grvv97XG/hnrzGZmMIKKoptkIB81afv24G8t0Fv9t2kaLBZ0nXPI2ivVABVnPvFGItRAm3yFtRRQWMIqsRzYoKruM8cfdmqk9uim7KTSefOdVuOFoSTkcY0gNs1zDrwSLItHveLhHHxjduEHjoAhc3k+nXJF+Z0IW02jsndSifGb99zi3vXtTpa+a7guOASZisPUn+FJxGPv2rfy021krQ+MO4ChKNCJ7QgGwmW8Md/e5Mx+zv7Jy0jWK1HFTa315YkbKzRyLMrFcxgdJdzmno5NpbVHkIOnPz92eNoLL0RYCfue6ncPFiFLTgge3QQcE9qdmxt4N0Gt7c5N3f345Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8310.eurprd04.prod.outlook.com (2603:10a6:20b:3b2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.20; Fri, 18 Feb
 2022 09:39:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Fri, 18 Feb 2022
 09:39:53 +0000
Date: Fri, 18 Feb 2022 17:40:21 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3 0/7] add fastclose testcases
Message-ID: <20220218094021.GA19741@dhcp-10-157-36-190>
References: <cover.1644923074.git.geliang.tang@suse.com>
 <4267dfb9-224b-228a-83c0-6d2da77fd8e1@linux.intel.com>
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <4267dfb9-224b-228a-83c0-6d2da77fd8e1@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR02CA0178.apcprd02.prod.outlook.com
 (2603:1096:201:21::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2f01be8-1690-4b3b-39c7-08d9f2c29da7
X-MS-TrafficTypeDiagnostic: AS8PR04MB8310:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB83103CA040E6EEEDF6206804F8379@AS8PR04MB8310.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:188;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K9rtnh6ADX3W4NkJnbXOwPCxan3kAkylyE54/uEY0W5feUoGWfWHN/4W5ML7M0D5mAFAxnuukYZGsMTugew70b7oY1zUxTNhTY9/pimp//Uzx41c7rXaVgsadfG1KjFg2TlAboZ6i+46Et0WRqrdAK8DC2Mn4OcoJ2SDoafvYgjgVT21PA4DnXBAN8tYXvbpcuxTEeY9ZuGql4WlmQKn/ms0CD0fYpMKe6EMNtNjWeZSSxvv/BStkuZstxRy7FwmxXHF4cjA+2guYl3m5OEFkQUKV5C6iMTIasVMP+TNHVsch8j1sw1t4/qxViNxS8buxQY0Lliule7pbt/RHEMeyXXsKZ2OXzVmcoUSFeQloGYi+VQm9ksvJpA2ijn3j7FdZrzJ5d7AbeoIh/rzZTnCvI4wi1x6IvMhQuHm5+T5S0axyTdfUyZzdNdTcFaruC2vOa7Rhu0gXdGRuQaFHhALOfPWZM0H+XDSUV4ihK25Irf/GZKxxdlyrCAAJlr/ORnYYlqVaJrMKr+0RFkcE8S4ETVFSjivg0C7RSXgFLz1N/W+lpQgyMZC0Y5JpvS62CWGok7+zQZtu08PW++KiNfXTwwWqXFqCUqXW0Sw4Ulrc0CA7RlTeEKlWSehyWONFZxtuU6/NoKBVZTt9Nz1l29mbODSjD9WU2Kdt/W8nSDbMnfPRDvLJUSMqtqLOZeIifEhzO2od5NSSra+n5FiJ79zQw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(83380400001)(316002)(38100700002)(33716001)(55236004)(9686003)(6512007)(44144004)(6916009)(6506007)(1076003)(6486002)(508600001)(6666004)(2906002)(44832011)(66556008)(86362001)(235185007)(8676002)(4326008)(66476007)(66946007)(8936002)(186003)(5660300002)(26005)(33656002)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?byLBcuPF2HQReprAqVAOcj89T7oXahmyPJ0NdlGm8hXweKKRhuSUUJOPMU+2?=
 =?us-ascii?Q?ZFKDCLKTVf3wUBdYKSCF5mPNMWXnx/qhKIo1TCPmzoy+G77ya0BfmxRCBARt?=
 =?us-ascii?Q?kRRBNXOOQzteZugKbFXpvyZ65yc12FlCjffyuHnyMzZVRSZ902ZIgUQicJms?=
 =?us-ascii?Q?WDmdTzDbJs8bppxBgtIX6IMWIWiD1/GInKnQGg9r0h8FPT9pHvIrS2HHmNWe?=
 =?us-ascii?Q?aeCgnjjvSew3XMXzo+Vb0sRRCWT8ARo1QOZvEoI+CsYF8fBf4qC/JxbQ5fL+?=
 =?us-ascii?Q?sG1jtmJ3avNznZl3UVAR5BYcdJfEbVnBa/N8GiuDtmpRs7TfaIowvVh/9/uP?=
 =?us-ascii?Q?yk46rTCLgl1zoHI5vGknmGR2wC54HDplz00jqCcmHtnuvhYg+rsLUXISfucN?=
 =?us-ascii?Q?b3mh3hMwihxeWdCgYrC8gwvQ+UpTe3oNUtU5Tw/fuY9+2ciyaBsgX08ZcDmk?=
 =?us-ascii?Q?NBUVjfSaY9FZMZVZAbTd8NSEUuV34oK8CNQyjMrnPgCOrleI2CQrSiFzWm8C?=
 =?us-ascii?Q?5PUsjxKmhg0IBQg79T2rGvRDHlwuKduenVgmIJXTQnxWBGeP7/SjYqieyjGT?=
 =?us-ascii?Q?RP0EDE/76lLLLsz5fY5bs6cDX9oPdB4dTzGCBAViZaFevG/+QfMhIOaT1Xk8?=
 =?us-ascii?Q?RFnVZuXUlgPoSK6YMxgecu20UoMb4GbHxaE/lHz26IrIAdjD+VsjHZlBXTfP?=
 =?us-ascii?Q?+fLgqWZL8Po4cszo+wM8Ux3lBaoj589r5hCvzoZkqPw75aOkRfNvDKJz0T6x?=
 =?us-ascii?Q?sVWhXMBOewh84Hx904bLNvTRNqPjJfkpiljiIsQIbqCppkOt01x6b0lcC43R?=
 =?us-ascii?Q?L0KYPg5s7U0a5368al2sj4U1cSDW2qSO1ATokd82L7K6wbRZjBw4xDYl5+bD?=
 =?us-ascii?Q?Jes49JUGIXzjeAGehi6UCI793f8zHWz/iHhkLJgljkWNar+F8s6fN342f83A?=
 =?us-ascii?Q?OoDzkdg06eIdCVVdnb7wbJfOkBwm9ihrY4eVwhrmOzRoA2aF3ap7JT8Pd0jh?=
 =?us-ascii?Q?4zHqjyP2vOL43KcSbJVk5iGp4Akfac4Xyq4PBg5KkTXJPOGXQ8iayWKC1/We?=
 =?us-ascii?Q?s6tbsMRii5l6U3APyBQnLjyO64y5yCQ0Oeg3IpCqhRHObu6NAhthAXktUEus?=
 =?us-ascii?Q?rBJKUjGiAqEgs47KTYdroxuZ/I3LFRBbgbK69gDmo0zyw42IF+rD8mQnXrZd?=
 =?us-ascii?Q?LnHHi1xwXfl8xJSeCo3/U77r5WStiDSvGWrcPSYYF3aAu/G7i+3hpnLqkfs8?=
 =?us-ascii?Q?q8UDZKyaEQlWjHWSvyL2nqjBcvpjtITjqRXGKUHSJK0lqJy0uCzUmy8wcyXk?=
 =?us-ascii?Q?dMLPMmJ2b9ppnr1d5aaPKlRNzUjscGVYBOUZgCk5timXdrksURULLk+yB5a8?=
 =?us-ascii?Q?0F/UEMf0SdCFd3cbffwyEeCpKEfwplbELuaek6NgRPtL5tvB0CEfoRGQexs5?=
 =?us-ascii?Q?wbtrKikbR79qIcsuWSX9MAgxwDXS6kAIhpcYJ+8rz58dBhn4XVO+vWp7yoP9?=
 =?us-ascii?Q?bSvPqpa3K4dg61rvOHXx6lwsw9o6HB2MxskvIVv+U5E4MX9ZXr58z1kNyzW/?=
 =?us-ascii?Q?SxKe+LM7okgg8K4pXtT5w1SlD6QFnknZ5s2YyaxogE55iSatY9bAiETTvPJh?=
 =?us-ascii?Q?5SJ6CeAd1+RiOLl9fdbOMag=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f01be8-1690-4b3b-39c7-08d9f2c29da7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 09:39:53.6101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qJKBX9Lm/Jhl7ExMBfM9BZX61Qs+tRTtxpud/IsSJdTWfVpY2Z+Z6wBo4zof1PwNkYQv8pyP562Cdmgc0w0dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8310

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 15, 2022 at 05:17:16PM -0800, Mat Martineau wrote:
> On Tue, 15 Feb 2022, Geliang Tang wrote:
> 
> > v3:
> > - merge the squash-to patch ("Squash to "selftests: mptcp: add
> > fastclose testcases v2") into v3.
> > - add a new patch to check fastclose in mptcp_connect.sh
> > 
> > base-commit: 9dff76d953f7a0fe2b27818f2aa93031c9a617cf
> > 
> > v2:
> > - merge the squash-to patch ("Squash to "selftests: mptcp: add the
> > MP_RST mibs check") into v2.
> > - update the commit logs.
> > 
> > This patchset is related to issue #48 and issue #197. The two MP_RST
> > patches are moved from the "add mp_fail testcases" series.
> > 
> 
> Hi Geliang -
> 
> The code changes and the squash-to patch look good in terms of code review.
> When I run the 'mptcp_join.sh -z' test I get intermittent failures with
> "fastclose test 2":
> 
> 002 fastclose test 2                     syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                          ctx[ ok ] - fclzrx[fail] got 1 MP_FASTCLOSE[s] RX expected 2
>                                          rtx[ ok ] - rstrx [fail] got 1 MP_RST[s] RX expected 2   invert
> 
> (removed MIB dump)
> 
> I was able to reproduce while capturing, and the capture in the failed test
> does have 2 MP_FASTCLOSE and 2 MP_RST. Maybe there's a timing issue reading
> the MIBs?
> 
> I attached the pcaps, one for passing and one for failing.

Hi Mat,

I read the pcap file mp_join-02-ns1-fail.pcap. It seems all right. The 2
MP_FASTCLOSE (fast-close in it) are on the outgoing path, not the incoming
path. It seems like one MP_FASTCLOSE is lost since the peer is closed.

I added some debug code and ran the "fastclose test 1". I got this log:

214 [   89.363021] MPTCP: data_fin=0 dsn64=0 use_map=0 ack64=1 use_ack=1
215 [   89.363027] MPTCP: data_ack=1461774226565990555
216 [   89.363045] MPTCP: msk=00000000f4a5f8ae snd_data_fin_enable=0 pending=0 snd_nxt=1461774226565990555 write_seq=1461774226565990555
217 [   89.363069] MPTCP: msk=0000000056c1787c state=8 flags=0
218 [   89.363083] MPTCP: msk=0000000056c1787c empty=1
219 [   89.363092] MPTCP: msk=0000000056c1787c rx queue empty=1:1 copied=952
220 [   89.363101] MPTCP: msk=00000000f4a5f8ae state=5 flags=0
221 [   89.363134] MPTCP: sk=0000000056c1787c, how=2
222 [   89.363142] MPTCP: msk=0000000056c1787c snd_data_fin_enable=0 shutdown=3 state=9 pending=0
223 [   89.363150] MPTCP: msk=0000000056c1787c snd_data_fin_enable=1 pending=0 snd_nxt=7107993104720368768 write_seq=7107993104720368769
224 [   89.363160] MPTCP: Sending DATA_FIN on subflow 00000000739073ba
225 [   89.363180] MPTCP: mptcp_incoming_options msk=00000000f4a5f8ae call mptcp_get_options
226 [   89.363186] MPTCP: mptcp_parse_option subtype=2
227 [   89.363193] MPTCP: DSS
228 [   89.363196] MPTCP: data_fin=1 dsn64=1 use_map=1 ack64=1 use_ack=1
229 [   89.363203] MPTCP: data_ack=1461774226565990555
230 [   89.363207] MPTCP: data_seq=7107993104720368768 subflow_seq=0 data_len=1 csum=0:0
231 [   89.363225] MPTCP: mptcp_subflow_shutdown call mptcp_reset_timer
232 [   89.363230] MPTCP: mptcp_reset_timer msk=0000000056c1787c tout=0 timer_ival=0
233 [   89.363249] MPTCP: msk=00000000f4a5f8ae snd_data_fin_enable=0 pending=0 snd_nxt=1461774226565990555 write_seq=1461774226565990555
234 [   89.363271] MPTCP: mptcp_incoming_options msk=0000000056c1787c call mptcp_get_options
235 [   89.363278] MPTCP: mptcp_parse_option subtype=2
236 [   89.363283] MPTCP: DSS
237 [   89.363288] MPTCP: data_fin=0 dsn64=0 use_map=0 ack64=1 use_ack=1
238 [   89.363296] MPTCP: data_ack=7107993104720368769
239 [   89.363332] MPTCP: msk=0000000056c1787c snd_data_fin_enable=0 pending=0 snd_nxt=7107993104720368769 write_seq=7107993104720368769
240 [   89.363334] MPTCP: msk=00000000f4a5f8ae state=7 flags=0
241 [   89.363355] MPTCP: msk=0000000056c1787c state=7 flags=0
242 [   89.363357] MPTCP: msk=00000000f4a5f8ae rx queue empty=1:1 copied=0
243 [   89.363371] MPTCP: msk=0000000056c1787c rx queue empty=1:1 copied=0
244 [   89.363373] MPTCP: mptcp_close msk=00000000f4a5f8ae state=7
245 [   89.363381] MPTCP: __mptcp_destroy_sock msk=00000000f4a5f8ae
246 [   89.363385] MPTCP: sk=0000000056c1787c, how=2
247 [   89.363415] MPTCP: FASTCLOSE key=3915243080113293332
248 [   89.363422] MPTCP: mptcp_write_options msk=0000000056c1787c write FASTCLOSE
249 [   89.363428] MPTCP: mptcp_write_options msk=0000000056c1787c write RST
250 [   89.363445] MPTCP: mptcp_incoming_options msk=00000000f4a5f8ae call mptcp_get_options
251 [   89.363452] MPTCP: msk=0000000056c1787c
252 [   89.363472] MPTCP: msk=00000000f4a5f8ae
253 [   89.363480] MPTCP: msk=00000000f4a5f8ae
254 [   89.363480] MPTCP: ssk=00000000739073ba, local_key=14043904268449196188, token=858690305, idsn=15279878249843479917
255 [   89.363501] MPTCP: msk=0000000088cbb197 state=10 flags=0
256 [   89.363528] MPTCP: subflow=000000001745e5dc
257 [   89.363540] MPTCP: subflow_req=000000008e77b85e, listener=000000001745e5dc
258 [   89.363548] MPTCP: mptcp_parse_option subtype=0

In this log, side A (msk=0000000056c1787c) sent DATA_FIN, side B
(msk=00000000f4a5f8ae) closed the msk. Then side A sent FASTCLOSE and RST,
side B didn't got them since msk was closed.

The full log is attatched.

It seems that the transmission process is over and there is no chance to
send FASTCLOSE. This may be the reason why increasing the test files sizes
can fix this issue.

Thanks,
-Geliang

> 
> -Mat
> 
> 
> > Geliang Tang (7):
> >  mptcp: add the mibs for MP_FASTCLOSE
> >  selftests: mptcp: add the MP_FASTCLOSE mibs check
> >  mptcp: add the mibs for MP_RST
> >  selftests: mptcp: add the MP_RST mibs check
> >  selftests: mptcp: add extra_args in do_transfer
> >  selftests: mptcp: add fastclose testcases
> >  selftests: mptcp: fastclose check in mptcp_connect
> > 
> > net/mptcp/mib.c                               |   4 +
> > net/mptcp/mib.h                               |   4 +
> > net/mptcp/options.c                           |   5 +
> > .../selftests/net/mptcp/mptcp_connect.sh      |  37 +++++
> > .../testing/selftests/net/mptcp/mptcp_join.sh | 134 ++++++++++++++++--
> > 5 files changed, 171 insertions(+), 13 deletions(-)
> > 
> > -- 
> > 2.34.1
> 
> --
> Mat Martineau
> Intel



--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="repeat-log-9321-98.dmesg"

[   88.982651] MPTCP: msk=00000000d55b3f70
[   89.120551] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth1: link becomes ready
[   89.130229] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth2: link becomes ready
[   89.139917] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth3: link becomes ready
[   89.149511] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth4: link becomes ready
[   89.157548] MPTCP: __mptcp_init_sock msk=0000000088cbb197 timer_ival=200
[   89.157561] MPTCP: subflow=000000001745e5dc
[   89.157562] MPTCP: subflow=000000001745e5dc, family=2
[   89.157563] MPTCP: subflow=000000001745e5dc
[   89.157567] MPTCP: msk=0000000088cbb197
[   89.157570] MPTCP: msk=0000000088cbb197
[   89.157571] MPTCP: msk=0000000088cbb197
[   89.157572] MPTCP: msk=0000000088cbb197
[   89.157577] MPTCP: msk=0000000088cbb197
[   89.157578] MPTCP: msk=0000000088cbb197
[   89.157579] MPTCP: msk=0000000088cbb197
[   89.157580] MPTCP: mptcp_listen msk=0000000088cbb197
[   89.157583] MPTCP: msk=0000000088cbb197
[   89.157584] MPTCP: msk=0000000088cbb197
[   89.157585] MPTCP: msk=0000000088cbb197
[   89.157588] MPTCP: msk=0000000088cbb197 state=10 flags=0
[   89.161547] MPTCP: __mptcp_init_sock msk=0000000056c1787c timer_ival=200
[   89.161556] MPTCP: subflow=00000000eec4e902
[   89.161557] MPTCP: subflow=00000000eec4e902, family=2
[   89.161558] MPTCP: subflow=00000000eec4e902
[   89.161562] MPTCP: msk=0000000056c1787c
[   89.161565] MPTCP: msk=0000000056c1787c
[   89.161566] MPTCP: msk=0000000056c1787c
[   89.161570] MPTCP: ssk=00000000739073ba, local_key=2049035318763103480, token=3643451371, idsn=7107993104720367715
[   89.161611] MPTCP: subflow=000000001745e5dc
[   89.161614] MPTCP: subflow_req=00000000aebd1c1e, listener=000000001745e5dc
[   89.161615] MPTCP: mptcp_parse_option subtype=0
[   89.161617] MPTCP: MP_CAPABLE version=1, flags=1, optlen=4 sndr=18446625988191902912, rcvr=18446645706075802224 len=65535 csum=65535
[   89.161620] MPTCP: req=00000000aebd1c1e local_key=3915243080113293332, token=86110708, idsn=1461774226565989501
[   89.161623] MPTCP: subflow_req=00000000aebd1c1e, local_key=3915243080113293332
[   89.161632] MPTCP: subflow=00000000eec4e902 synack seq=6af39b7d
[   89.161633] MPTCP: mptcp_parse_option subtype=0
[   89.161633] MPTCP: MP_CAPABLE version=1, flags=1, optlen=12 sndr=3915243080113293332, rcvr=89153004 len=0 csum=0
[   89.161635] MPTCP: subflow=00000000eec4e902, remote_key=3915243080113293332
[   89.161636] MPTCP: msk=0000000056c1787c, token=3643451371
[   89.161638] MPTCP: msk=0000000056c1787c, token=3643451371 side=0
[   89.161642] MPTCP: subflow=00000000eec4e902, local_key=2049035318763103480, remote_key=3915243080113293332 map_len=0
[   89.161645] MPTCP: listener=000000001745e5dc, req=00000000aebd1c1e, conn=0000000088cbb197
[   89.161647] MPTCP: mptcp_parse_option subtype=0
[   89.161647] MPTCP: MP_CAPABLE version=1, flags=1, optlen=20 sndr=2049035318763103480, rcvr=3915243080113293332 len=38042 csum=65535
[   89.161650] MPTCP: __mptcp_init_sock msk=00000000f4a5f8ae timer_ival=200
[   89.161653] MPTCP: subflow=0000000076d765d6
[   89.161655] MPTCP: msk=00000000f4a5f8ae, token=86110708 side=1
[   89.161658] MPTCP: mptcp_incoming_options msk=00000000f4a5f8ae call mptcp_get_options
[   89.161659] MPTCP: mptcp_parse_option subtype=0
[   89.161660] MPTCP: MP_CAPABLE version=1, flags=1, optlen=20 sndr=2049035318763103480, rcvr=3915243080113293332 len=0 csum=0
[   89.161666] MPTCP: msk=0000000056c1787c
[   89.161668] MPTCP: msk=0000000056c1787c
[   89.161669] MPTCP: msk=0000000056c1787c
[   89.161681] MPTCP: msk=0000000056c1787c
[   89.161682] MPTCP: msk=0000000056c1787c
[   89.161683] MPTCP: msk=0000000056c1787c
[   89.161690] MPTCP: msk=0000000056c1787c state=1 flags=0
[   89.161699] MPTCP: msk=0000000056c1787c dfrag at seq=7107993104720367716 len=100 sent=0 new=1
[   89.161701] MPTCP: __mptcp_set_timeout msk=0000000056c1787c timer_ival=200 tout=0
[   89.161701] MPTCP: msk=0000000088cbb197 state=10 flags=0
[   89.161702] MPTCP: msk=0000000056c1787c ssk=00000000739073ba sending dfrag at seq=7107993104720367716 len=100 already sent=0
[   89.161706] MPTCP: data_seq=7107993104720367716 subflow_seq=1 data_len=100 dsn64=1
[   89.161708] MPTCP: subflow=00000000eec4e902, local_key=2049035318763103480, remote_key=3915243080113293332 map_len=100
[   89.161712] MPTCP: mptcp_incoming_options msk=00000000f4a5f8ae call mptcp_get_options
[   89.161713] MPTCP: mptcp_parse_option subtype=0
[   89.161713] MPTCP: mptcp_stream_accept msk=0000000088cbb197
[   89.161714] MPTCP: MP_CAPABLE version=1, flags=1, optlen=22 sndr=2049035318763103480, rcvr=3915243080113293332 len=100 csum=0
[   89.161714] MPTCP: msk=0000000088cbb197, listener=000000001745e5dc
[   89.161716] MPTCP: subflow_req=00000000aebd1c1e
[   89.161717] MPTCP: new map seq=7107993104720367716 subflow_seq=1 data_len=100 csum=0:0
[   89.161718] MPTCP: msk=0000000088cbb197, subflow is mptcp=1
[   89.161719] MPTCP: msk ack_seq=62a4aa11a8c89064 subflow ack_seq=62a4aa11a8c89064
[   89.161720] MPTCP: msk=00000000f4a5f8ae
[   89.161721] MPTCP: msk=00000000f4a5f8ae ssk=0000000007fddbb0
[   89.161723] MPTCP: Done with mapping: seq=1 data_len=100
[   89.161724] MPTCP: msk=00000000f4a5f8ae empty=1
[   89.161728] MPTCP: msk=00000000f4a5f8ae
[   89.161729] MPTCP: mptcp_incoming_options msk=0000000056c1787c call mptcp_get_options
[   89.161730] MPTCP: mptcp_parse_option subtype=2
[   89.161730] MPTCP: msk=00000000f4a5f8ae
[   89.161731] MPTCP: DSS
[   89.161731] MPTCP: data_fin=0 dsn64=0 use_map=0 ack64=1 use_ack=1
[   89.161732] MPTCP: msk=00000000f4a5f8ae
[   89.161733] MPTCP: data_ack=7107993104720367816
[   89.161733] MPTCP: msk=0000000056c1787c
[   89.161735] MPTCP: mptcp_reset_timer msk=0000000056c1787c tout=200 timer_ival=200
[   89.161736] MPTCP: msk=0000000056c1787c snd_data_fin_enable=0 pending=0 snd_nxt=7107993104720367816 write_seq=7107993104720367816
[   89.161738] MPTCP: mptcp_stop_timer msk=0000000056c1787c timer_ival=0
[   89.161739] MPTCP: msk=00000000f4a5f8ae state=1 flags=0
[   89.161743] MPTCP: msk=00000000f4a5f8ae empty=1
[   89.161746] MPTCP: msk=00000000f4a5f8ae rx queue empty=1:1 copied=100
[   89.161765] MPTCP: msk=00000000f4a5f8ae dfrag at seq=1461774226565989502 len=100 sent=0 new=1
[   89.161767] MPTCP: __mptcp_set_timeout msk=00000000f4a5f8ae timer_ival=200 tout=0
[   89.161769] MPTCP: msk=00000000f4a5f8ae ssk=0000000007fddbb0 sending dfrag at seq=1461774226565989502 len=100 already sent=0
[   89.161772] MPTCP: data_seq=1461774226565989502 subflow_seq=1 data_len=100 dsn64=1
[   89.161778] MPTCP: mptcp_incoming_options msk=0000000056c1787c call mptcp_get_options
[   89.161779] MPTCP: mptcp_parse_option subtype=2
[   89.161780] MPTCP: DSS
[   89.161781] MPTCP: data_fin=0 dsn64=1 use_map=1 ack64=1 use_ack=1
[   89.161782] MPTCP: data_ack=7107993104720367816
[   89.161782] MPTCP: data_seq=1461774226565989502 subflow_seq=1 data_len=100 csum=0:0
[   89.161784] MPTCP: new map seq=1461774226565989502 subflow_seq=1 data_len=100 csum=0:0
[   89.161785] MPTCP: msk ack_seq=144943ea0c49847e subflow ack_seq=144943ea0c49847e
[   89.161786] MPTCP: msk=0000000056c1787c ssk=00000000739073ba
[   89.161787] MPTCP: Done with mapping: seq=1 data_len=100
[   89.161788] MPTCP: msk=0000000056c1787c empty=1
[   89.161793] MPTCP: mptcp_incoming_options msk=00000000f4a5f8ae call mptcp_get_options
[   89.161794] MPTCP: mptcp_parse_option subtype=2
[   89.161795] MPTCP: DSS
[   89.161796] MPTCP: data_fin=0 dsn64=0 use_map=0 ack64=1 use_ack=1
[   89.161797] MPTCP: data_ack=1461774226565989602
[   89.161797] MPTCP: msk=00000000f4a5f8ae
[   89.161799] MPTCP: mptcp_reset_timer msk=00000000f4a5f8ae tout=200 timer_ival=200
[   89.161800] MPTCP: msk=00000000f4a5f8ae snd_data_fin_enable=0 pending=0 snd_nxt=1461774226565989602 write_seq=1461774226565989602
[   89.161801] MPTCP: mptcp_stop_timer msk=00000000f4a5f8ae timer_ival=0
[   89.362253] MPTCP: msk=00000000f4a5f8ae state=1 flags=0
[   89.362253] MPTCP: msk=0000000056c1787c state=1 flags=0
[   89.362285] MPTCP: msk=00000000f4a5f8ae dfrag at seq=1461774226565989602 len=422 sent=0 new=1
[   89.362295] MPTCP: __mptcp_set_timeout msk=00000000f4a5f8ae timer_ival=200 tout=0
[   89.362301] MPTCP: mptcp_set_timeout msk=00000000f4a5f8ae timer_ival=200 tout=0
[   89.362303] MPTCP: msk=0000000056c1787c empty=1
[   89.362350] MPTCP: msk=00000000f4a5f8ae ssk=0000000007fddbb0 sending dfrag at seq=1461774226565989602 len=422 already sent=0
[   89.362359] MPTCP: msk=0000000056c1787c rx queue empty=1:1 copied=100
[   89.362367] MPTCP: data_seq=1461774226565989602 subflow_seq=101 data_len=422 dsn64=1
[   89.362419] MPTCP: mptcp_incoming_options msk=0000000056c1787c call mptcp_get_options
[   89.362425] MPTCP: mptcp_parse_option subtype=2
[   89.362430] MPTCP: DSS
[   89.362432] MPTCP: data_fin=0 dsn64=1 use_map=1 ack64=1 use_ack=1
[   89.362439] MPTCP: data_ack=7107993104720367816
[   89.362443] MPTCP: data_seq=1461774226565989602 subflow_seq=101 data_len=422 csum=0:0
[   89.362450] MPTCP: msk=0000000056c1787c dfrag at seq=7107993104720367816 len=952 sent=0 new=1
[   89.362455] MPTCP: new map seq=1461774226565989602 subflow_seq=101 data_len=422 csum=0:0
[   89.362462] MPTCP: msk ack_seq=144943ea0c4984e2 subflow ack_seq=144943ea0c4984e2
[   89.362461] MPTCP: __mptcp_set_timeout msk=0000000056c1787c timer_ival=200 tout=0
[   89.362470] MPTCP: msk=0000000056c1787c ssk=00000000739073ba
[   89.362469] MPTCP: mptcp_set_timeout msk=0000000056c1787c timer_ival=200 tout=0
[   89.362477] MPTCP: Done with mapping: seq=101 data_len=422
[   89.362482] MPTCP: msk=0000000056c1787c empty=1
[   89.362494] MPTCP: msk=0000000056c1787c ssk=00000000739073ba sending dfrag at seq=7107993104720367816 len=952 already sent=0
[   89.362511] MPTCP: mptcp_incoming_options msk=00000000f4a5f8ae call mptcp_get_options
[   89.362514] MPTCP: data_seq=7107993104720367816 subflow_seq=101 data_len=952 dsn64=1
[   89.362517] MPTCP: mptcp_parse_option subtype=2
[   89.362523] MPTCP: DSS
[   89.362527] MPTCP: data_fin=0 dsn64=0 use_map=0 ack64=1 use_ack=1
[   89.362532] MPTCP: data_ack=1461774226565990024
[   89.362539] MPTCP: mptcp_reset_timer msk=00000000f4a5f8ae tout=200 timer_ival=200
[   89.362545] MPTCP: msk=00000000f4a5f8ae snd_data_fin_enable=0 pending=0 snd_nxt=1461774226565990024 write_seq=1461774226565990024
[   89.362553] MPTCP: mptcp_stop_timer msk=00000000f4a5f8ae timer_ival=0
[   89.362552] MPTCP: mptcp_incoming_options msk=00000000f4a5f8ae call mptcp_get_options
[   89.362561] MPTCP: mptcp_parse_option subtype=2
[   89.362566] MPTCP: msk=00000000f4a5f8ae state=1 flags=0
[   89.362569] MPTCP: DSS
[   89.362574] MPTCP: data_fin=0 dsn64=1 use_map=1 ack64=1 use_ack=1
[   89.362577] MPTCP: msk=00000000f4a5f8ae dfrag at seq=1461774226565990024 len=530 sent=0 new=1
[   89.362583] MPTCP: data_ack=1461774226565990024
[   89.362584] MPTCP: __mptcp_set_timeout msk=00000000f4a5f8ae timer_ival=200 tout=0
[   89.362590] MPTCP: mptcp_set_timeout msk=00000000f4a5f8ae timer_ival=200 tout=0
[   89.362591] MPTCP: data_seq=7107993104720367816 subflow_seq=101 data_len=952 csum=0:0
[   89.362605] MPTCP: new map seq=7107993104720367816 subflow_seq=101 data_len=952 csum=0:0
[   89.362612] MPTCP: msk ack_seq=62a4aa11a8c890c8 subflow ack_seq=62a4aa11a8c890c8
[   89.362619] MPTCP: msk=00000000f4a5f8ae ssk=0000000007fddbb0
[   89.362628] MPTCP: Done with mapping: seq=101 data_len=952
[   89.362634] MPTCP: msk=00000000f4a5f8ae empty=1
[   89.362651] MPTCP: msk=00000000f4a5f8ae ssk=0000000007fddbb0 sending dfrag at seq=1461774226565990024 len=530 already sent=0
[   89.362660] MPTCP: data_seq=1461774226565990024 subflow_seq=523 data_len=530 dsn64=1
[   89.362670] MPTCP: mptcp_incoming_options msk=0000000056c1787c call mptcp_get_options
[   89.362674] MPTCP: mptcp_reset_timer msk=00000000f4a5f8ae tout=200 timer_ival=200
[   89.362680] MPTCP: msk=00000000f4a5f8ae snd_data_fin_enable=0 pending=0 snd_nxt=1461774226565990554 write_seq=1461774226565990554
[   89.362682] MPTCP: mptcp_parse_option subtype=2
[   89.362688] MPTCP: DSS
[   89.362692] MPTCP: msk=00000000f4a5f8ae state=1 flags=0
[   89.362692] MPTCP: data_fin=0 dsn64=0 use_map=0 ack64=1 use_ack=1
[   89.362700] MPTCP: data_ack=7107993104720368768
[   89.362703] MPTCP: msk=00000000f4a5f8ae empty=1
[   89.362712] MPTCP: msk=00000000f4a5f8ae rx queue empty=1:1 copied=952
[   89.362712] MPTCP: mptcp_incoming_options msk=0000000056c1787c call mptcp_get_options
[   89.362718] MPTCP: mptcp_parse_option subtype=2
[   89.362724] MPTCP: DSS
[   89.362726] MPTCP: data_fin=0 dsn64=1 use_map=1 ack64=1 use_ack=1
[   89.362733] MPTCP: data_ack=7107993104720368768
[   89.362738] MPTCP: data_seq=1461774226565990024 subflow_seq=523 data_len=530 csum=0:0
[   89.362750] MPTCP: new map seq=1461774226565990024 subflow_seq=523 data_len=530 csum=0:0
[   89.362759] MPTCP: msk ack_seq=144943ea0c498688 subflow ack_seq=144943ea0c498688
[   89.362762] MPTCP: sk=00000000f4a5f8ae, how=2
[   89.362767] MPTCP: msk=0000000056c1787c ssk=00000000739073ba
[   89.362768] MPTCP: msk=00000000f4a5f8ae snd_data_fin_enable=0 shutdown=2 state=4 pending=0
[   89.362774] MPTCP: msk=00000000f4a5f8ae snd_data_fin_enable=1 pending=0 snd_nxt=1461774226565990554 write_seq=1461774226565990555
[   89.362778] MPTCP: colesced seq 144943ea0c498688 into 144943ea0c4984e2 new len 952 new end seq 144943ea0c49889a
[   89.362781] MPTCP: Sending DATA_FIN on subflow 0000000007fddbb0
[   89.362790] MPTCP: Done with mapping: seq=523 data_len=530
[   89.362797] MPTCP: msk=0000000056c1787c empty=1
[   89.362799] MPTCP: msk=00000000f4a5f8ae state=4 flags=0
[   89.362826] MPTCP: mptcp_incoming_options msk=00000000f4a5f8ae call mptcp_get_options
[   89.362835] MPTCP: mptcp_parse_option subtype=2
[   89.362840] MPTCP: DSS
[   89.362843] MPTCP: data_fin=0 dsn64=0 use_map=0 ack64=1 use_ack=1
[   89.362850] MPTCP: data_ack=1461774226565990554
[   89.362857] MPTCP: __mptcp_clean_una call mptcp_reset_timer
[   89.362862] MPTCP: mptcp_reset_timer msk=00000000f4a5f8ae tout=200 timer_ival=200
[   89.362877] MPTCP: mptcp_incoming_options msk=0000000056c1787c call mptcp_get_options
[   89.362883] MPTCP: mptcp_parse_option subtype=2
[   89.362888] MPTCP: DSS
[   89.362892] MPTCP: data_fin=1 dsn64=1 use_map=1 ack64=1 use_ack=1
[   89.362899] MPTCP: data_ack=7107993104720368768
[   89.362903] MPTCP: data_seq=1461774226565990554 subflow_seq=0 data_len=1 csum=0:0
[   89.362941] MPTCP: mptcp_reset_timer msk=0000000056c1787c tout=200 timer_ival=200
[   89.362950] MPTCP: msk=0000000056c1787c snd_data_fin_enable=0 pending=0 snd_nxt=7107993104720368768 write_seq=7107993104720368768
[   89.362962] MPTCP: mptcp_stop_timer msk=0000000056c1787c timer_ival=0
[   89.362978] MPTCP: msk=0000000056c1787c snd_data_fin_enable=0 pending=0 snd_nxt=7107993104720368768 write_seq=7107993104720368768
[   89.363006] MPTCP: mptcp_incoming_options msk=00000000f4a5f8ae call mptcp_get_options
[   89.363012] MPTCP: mptcp_parse_option subtype=2
[   89.363017] MPTCP: DSS
[   89.363021] MPTCP: data_fin=0 dsn64=0 use_map=0 ack64=1 use_ack=1
[   89.363027] MPTCP: data_ack=1461774226565990555
[   89.363045] MPTCP: msk=00000000f4a5f8ae snd_data_fin_enable=0 pending=0 snd_nxt=1461774226565990555 write_seq=1461774226565990555
[   89.363069] MPTCP: msk=0000000056c1787c state=8 flags=0
[   89.363083] MPTCP: msk=0000000056c1787c empty=1
[   89.363092] MPTCP: msk=0000000056c1787c rx queue empty=1:1 copied=952
[   89.363101] MPTCP: msk=00000000f4a5f8ae state=5 flags=0
[   89.363134] MPTCP: sk=0000000056c1787c, how=2
[   89.363142] MPTCP: msk=0000000056c1787c snd_data_fin_enable=0 shutdown=3 state=9 pending=0
[   89.363150] MPTCP: msk=0000000056c1787c snd_data_fin_enable=1 pending=0 snd_nxt=7107993104720368768 write_seq=7107993104720368769
[   89.363160] MPTCP: Sending DATA_FIN on subflow 00000000739073ba
[   89.363180] MPTCP: mptcp_incoming_options msk=00000000f4a5f8ae call mptcp_get_options
[   89.363186] MPTCP: mptcp_parse_option subtype=2
[   89.363193] MPTCP: DSS
[   89.363196] MPTCP: data_fin=1 dsn64=1 use_map=1 ack64=1 use_ack=1
[   89.363203] MPTCP: data_ack=1461774226565990555
[   89.363207] MPTCP: data_seq=7107993104720368768 subflow_seq=0 data_len=1 csum=0:0
[   89.363225] MPTCP: mptcp_subflow_shutdown call mptcp_reset_timer
[   89.363230] MPTCP: mptcp_reset_timer msk=0000000056c1787c tout=0 timer_ival=0
[   89.363249] MPTCP: msk=00000000f4a5f8ae snd_data_fin_enable=0 pending=0 snd_nxt=1461774226565990555 write_seq=1461774226565990555
[   89.363271] MPTCP: mptcp_incoming_options msk=0000000056c1787c call mptcp_get_options
[   89.363278] MPTCP: mptcp_parse_option subtype=2
[   89.363283] MPTCP: DSS
[   89.363288] MPTCP: data_fin=0 dsn64=0 use_map=0 ack64=1 use_ack=1
[   89.363296] MPTCP: data_ack=7107993104720368769
[   89.363332] MPTCP: msk=0000000056c1787c snd_data_fin_enable=0 pending=0 snd_nxt=7107993104720368769 write_seq=7107993104720368769
[   89.363334] MPTCP: msk=00000000f4a5f8ae state=7 flags=0
[   89.363355] MPTCP: msk=0000000056c1787c state=7 flags=0
[   89.363357] MPTCP: msk=00000000f4a5f8ae rx queue empty=1:1 copied=0
[   89.363371] MPTCP: msk=0000000056c1787c rx queue empty=1:1 copied=0
[   89.363373] MPTCP: mptcp_close msk=00000000f4a5f8ae state=7
[   89.363381] MPTCP: __mptcp_destroy_sock msk=00000000f4a5f8ae
[   89.363385] MPTCP: sk=0000000056c1787c, how=2
[   89.363415] MPTCP: FASTCLOSE key=3915243080113293332
[   89.363422] MPTCP: mptcp_write_options msk=0000000056c1787c write FASTCLOSE
[   89.363428] MPTCP: mptcp_write_options msk=0000000056c1787c write RST
[   89.363445] MPTCP: mptcp_incoming_options msk=00000000f4a5f8ae call mptcp_get_options
[   89.363452] MPTCP: msk=0000000056c1787c
[   89.363472] MPTCP: msk=00000000f4a5f8ae
[   89.363480] MPTCP: msk=00000000f4a5f8ae
[   89.363480] MPTCP: ssk=00000000739073ba, local_key=14043904268449196188, token=858690305, idsn=15279878249843479917
[   89.363501] MPTCP: msk=0000000088cbb197 state=10 flags=0
[   89.363528] MPTCP: subflow=000000001745e5dc
[   89.363540] MPTCP: subflow_req=000000008e77b85e, listener=000000001745e5dc
[   89.363548] MPTCP: mptcp_parse_option subtype=0
[   89.363554] MPTCP: MP_CAPABLE version=1, flags=1, optlen=4 sndr=18446625988191902912, rcvr=18446645706075802224 len=65535 csum=65535
[   89.363572] MPTCP: req=000000008e77b85e local_key=4646237471059683850, token=2450339804, idsn=15893755681837120179
[   89.363591] MPTCP: subflow_req=000000008e77b85e, local_key=4646237471059683850
[   89.363620] MPTCP: subflow=00000000eec4e902 synack seq=cb6c4dab
[   89.363627] MPTCP: mptcp_parse_option subtype=0
[   89.363632] MPTCP: MP_CAPABLE version=1, flags=1, optlen=12 sndr=4646237471059683850, rcvr=89354934 len=0 csum=0
[   89.363642] MPTCP: subflow=00000000eec4e902, remote_key=4646237471059683850
[   89.363648] MPTCP: msk=0000000056c1787c, token=858690305
[   89.363657] MPTCP: msk=0000000056c1787c, token=858690305 side=0
[   89.363673] MPTCP: subflow=00000000eec4e902, local_key=14043904268449196188, remote_key=4646237471059683850 map_len=0
[   89.363695] MPTCP: listener=000000001745e5dc, req=000000008e77b85e, conn=0000000088cbb197
[   89.363704] MPTCP: mptcp_parse_option subtype=0
[   89.363709] MPTCP: MP_CAPABLE version=1, flags=1, optlen=20 sndr=14043904268449196188, rcvr=4646237471059683850 len=38042 csum=65535
[   89.363725] MPTCP: __mptcp_init_sock msk=000000007d71e874 timer_ival=200
[   89.363741] MPTCP: subflow=00000000d1e2661a
[   89.363753] MPTCP: msk=000000007d71e874, token=2450339804 side=1
[   89.363770] MPTCP: mptcp_incoming_options msk=000000007d71e874 call mptcp_get_options
[   89.363777] MPTCP: mptcp_parse_option subtype=0
[   89.363782] MPTCP: MP_CAPABLE version=1, flags=1, optlen=20 sndr=14043904268449196188, rcvr=4646237471059683850 len=0 csum=0
[   89.363831] MPTCP: msk=0000000056c1787c
[   89.363842] MPTCP: msk=0000000056c1787c
[   89.363848] MPTCP: msk=0000000056c1787c
[   89.363850] MPTCP: msk=0000000088cbb197 state=10 flags=0
[   89.363861] MPTCP: msk=0000000056c1787c state=1 flags=0
[   89.363876] MPTCP: sk=0000000056c1787c, how=2
[   89.363882] MPTCP: mptcp_stream_accept msk=0000000088cbb197
[   89.363882] MPTCP: msk=0000000056c1787c snd_data_fin_enable=0 shutdown=2 state=4 pending=0
[   89.363890] MPTCP: msk=0000000088cbb197, listener=000000001745e5dc
[   89.363892] MPTCP: msk=0000000056c1787c snd_data_fin_enable=1 pending=0 snd_nxt=15279878249843479918 write_seq=15279878249843479919
[   89.363898] MPTCP: subflow_req=000000008e77b85e
[   89.363903] MPTCP: Sending DATA_FIN on subflow 00000000739073ba
[   89.363904] MPTCP: msk=0000000088cbb197, subflow is mptcp=1
[   89.363912] MPTCP: msk=000000007d71e874
[   89.363926] MPTCP: msk=000000007d71e874
[   89.363926] MPTCP: mptcp_incoming_options msk=000000007d71e874 call mptcp_get_options
[   89.363932] MPTCP: msk=000000007d71e874
[   89.363934] MPTCP: mptcp_parse_option subtype=2
[   89.363938] MPTCP: msk=000000007d71e874
[   89.363939] MPTCP: DSS
[   89.363943] MPTCP: data_fin=1 dsn64=1 use_map=1 ack64=0 use_ack=1
[   89.363950] MPTCP: msk=000000007d71e874 state=1 flags=0
[   89.363951] MPTCP: data_ack=2059369140
[   89.363956] MPTCP: data_seq=15279878249843479918 subflow_seq=0 data_len=1 csum=0:0
[   89.363964] MPTCP: sk=000000007d71e874, how=2
[   89.363964] MPTCP: msk=000000007d71e874
[   89.363969] MPTCP: msk=000000007d71e874 snd_data_fin_enable=0 shutdown=2 state=4 pending=0
[   89.363976] MPTCP: msk=000000007d71e874 snd_data_fin_enable=1 pending=0 snd_nxt=15893755681837120180 write_seq=15893755681837120181
[   89.363981] MPTCP: mptcp_subflow_shutdown call mptcp_reset_timer
[   89.363985] MPTCP: mptcp_reset_timer msk=0000000056c1787c tout=0 timer_ival=0
[   89.363986] MPTCP: Sending DATA_FIN on subflow 000000002623eb0f
[   89.364008] MPTCP: msk=0000000056c1787c state=4 flags=0
[   89.364019] MPTCP: mptcp_incoming_options msk=0000000056c1787c call mptcp_get_options
[   89.364026] MPTCP: mptcp_parse_option subtype=2
[   89.364030] MPTCP: DSS
[   89.364032] MPTCP: data_fin=1 dsn64=1 use_map=1 ack64=0 use_ack=1
[   89.364037] MPTCP: data_ack=3710080366
[   89.364040] MPTCP: data_seq=15893755681837120180 subflow_seq=0 data_len=1 csum=0:0
[   89.364045] MPTCP: msk=0000000056c1787c
[   89.364060] MPTCP: mptcp_subflow_shutdown call mptcp_reset_timer
[   89.364064] MPTCP: mptcp_reset_timer msk=000000007d71e874 tout=200 timer_ival=200
[   89.364083] MPTCP: msk=0000000056c1787c snd_data_fin_enable=1 pending=0 snd_nxt=15279878249843479919 write_seq=15279878249843479919
[   89.364097] MPTCP: mptcp_incoming_options msk=000000007d71e874 call mptcp_get_options
[   89.364101] MPTCP: mptcp_parse_option subtype=2
[   89.364104] MPTCP: DSS
[   89.364106] MPTCP: data_fin=1 dsn64=1 use_map=1 ack64=0 use_ack=1
[   89.364111] MPTCP: data_ack=2059369141
[   89.364113] MPTCP: data_seq=15279878249843479918 subflow_seq=0 data_len=1 csum=0:0
[   89.364126] MPTCP: msk=000000007d71e874 snd_data_fin_enable=0 pending=0 snd_nxt=15893755681837120181 write_seq=15893755681837120181
[   89.364142] MPTCP: msk=000000007d71e874 state=7 flags=0
[   89.364166] MPTCP: mptcp_incoming_options msk=0000000056c1787c call mptcp_get_options
[   89.364172] MPTCP: mptcp_parse_option subtype=2
[   89.364176] MPTCP: DSS
[   89.364179] MPTCP: data_fin=0 dsn64=0 use_map=0 ack64=0 use_ack=1
[   89.364183] MPTCP: data_ack=3710080367
[   89.364198] MPTCP: msk=0000000056c1787c state=11 flags=0
[   89.364206] MPTCP: msk=0000000056c1787c snd_data_fin_enable=0 pending=0 snd_nxt=15279878249843479919 write_seq=15279878249843479919
[   89.364208] MPTCP: msk=000000007d71e874 rx queue empty=1:1 copied=0
[   89.364222] MPTCP: mptcp_close msk=000000007d71e874 state=7
[   89.364227] MPTCP: __mptcp_destroy_sock msk=000000007d71e874
[   89.364228] MPTCP: msk=0000000056c1787c rx queue empty=1:1 copied=0
[   89.364242] MPTCP: mptcp_close msk=0000000056c1787c state=7
[   89.364244] MPTCP: mptcp_incoming_options msk=0000000056c1787c call mptcp_get_options
[   89.364249] MPTCP: mptcp_parse_option subtype=2
[   89.364249] MPTCP: __mptcp_destroy_sock msk=0000000056c1787c
[   89.364253] MPTCP: DSS
[   89.364256] MPTCP: data_fin=0 dsn64=0 use_map=0 ack64=0 use_ack=1
[   89.364260] MPTCP: data_ack=3710080367
[   89.364273] MPTCP: msk=000000007d71e874
[   89.364328] MPTCP: mptcp_incoming_options msk=000000007d71e874 call mptcp_get_options
[   89.364337] MPTCP: mptcp_parse_option subtype=2
[   89.364343] MPTCP: DSS
[   89.364347] MPTCP: data_fin=0 dsn64=0 use_map=0 ack64=0 use_ack=1
[   89.364355] MPTCP: data_ack=2059369141
[   89.364380] MPTCP: msk=000000007d71e874
[   89.364434] MPTCP: msk=0000000056c1787c
[   89.364649] MPTCP: mptcp_close msk=0000000088cbb197 state=7
[   89.364658] MPTCP: __mptcp_destroy_sock msk=0000000088cbb197

--NzB8fVQJ5HfG6fxh--

