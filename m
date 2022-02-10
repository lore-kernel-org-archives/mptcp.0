Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278462F20
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 15:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644505793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p44POOTy3F3u2o7uAOH53/9c8L2eCMIMjfUt4sGEIxs=;
	b=XJJrLTtslBehp5cDalrGpEMTG0X8qg/5oVVkpQDzxLdBp9Eoc2N40lWWwtI3iKr4XSPt/T
	wdtmcdARmP2d62cRS2+AoUy5cSCHRN9QcOkeoDoWOqQdx9XqpQKd1RiybVYH7ejovMEbAb
	xi87KS84jQu8bzysQIdVMWIvPvM6utg=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2106.outbound.protection.outlook.com [104.47.18.106]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-8-PXxkzdcuOVqBvgiUPFY1vw-1; Thu, 10 Feb 2022 16:09:52 +0100
X-MC-Unique: PXxkzdcuOVqBvgiUPFY1vw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEa2lxxUjlUud5eXssVOnPB8jOWL+sU8SkxgXNDXXuec4A6IcEAIgtWGyTAc6o41AhdMgzZ1fkIPrpxk8zfR/zDAt3dWZf51dbHBZhgHMumiESjC9bW22T+AkyyTLSw76sbZDzAMtI8LcXfDosKv9vHGnt0jAB9llCM7uPASlUBJCWt6grwDuuRDlSHjJqi98NurUBd/YMIEIe4ZupCgfMooRCKOELJ0yq+lt7f6a7XvGKVr4/mxCfybFRyo0No0zocxcmLRuIEznefytN1/+7UkpQf8C+fbZlH35l10RttYPdM6Xc11OcQsMOpFs1FOvrbVLPlIsEFFyZdfCwoc8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p44POOTy3F3u2o7uAOH53/9c8L2eCMIMjfUt4sGEIxs=;
 b=mhgRhlwyHeacgGnyY1sc2Ic5TfyB9oe7zXNuTpewVCwoGSWrX5u7pyGx9tsJMOTbe1bVqQojg8uUo9g/u2yAiukcJwmbcx+mSi8WACNFCVJjeeH0ERZS/LNxc5KQVc4R2q/OwJ3GqWiFhbhQLZSMocV7BshKB5fNvnCVIx8l4Hqf6zgo/n7WxaG8K+7vwXdqWQy6BnUQrEBpDBdsooq2eM9KabiRJDhv75mtCSwaqBEFKVVPEwMCimWaRcClUzPzb/k/nRIA8O03cgT/jCX32MxTOyD3O28oLfBuiykIdYoqoH1dY3UqvKr6RJri54pTM2FMulKbOvFXYlGWnTSeow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB4257.eurprd04.prod.outlook.com (2603:10a6:208:63::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 15:09:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 15:09:51 +0000
Date: Thu, 10 Feb 2022 23:10:19 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v6 0/7] add mp_fail testcases
Message-ID: <20220210151019.GA6079@bogon>
References: <cover.1644466570.git.geliang.tang@suse.com>
 <a9425ee2-27f8-1e9a-0780-a8f5bd4fa194@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9425ee2-27f8-1e9a-0780-a8f5bd4fa194@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK0PR03CA0106.apcprd03.prod.outlook.com
 (2603:1096:203:b0::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5850644b-9776-4eee-b93b-08d9eca7629d
X-MS-TrafficTypeDiagnostic: AM0PR04MB4257:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB425741C69DC64744F3E8F9E0F82F9@AM0PR04MB4257.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hT48UJ+U3okoVA2WHrgfMfepTmLxPq7IYiTKQnN/DFzMC/8dEUo0FNsAHQ9II0Lh1tPfCUypghfF7sMWDrfCFzoXdapm3n0Y0JOFqRoJeUfUMuhR3IUI2gz9MvSMOz8cM4mpBBiZAdOvU7jryHMnCWpdu54TrPEDDqwHEgRw0IdLLl9UosjXWy/9ASLMIiM37RJZNqLmNU7SJYa29NT8LzcnarLQC6sy1T52kEcUu4L7Hi0ps+l/fekLofVBrqtHKp026PVrOK4E8Ho5s/7CSu8P6Ok6abWuRHRqzg0NM/CnOZwx8DveNFqLqikA1JMnnwBOHP3MoFP1JR4d4JU6xXMvogq2m+KJFgsZ6n9iL1ohNNH9bJr1Qgc2+/xMoaczAXFfmxvYMe6YVTYCu19xvA7fEo3MgR1Uftb49WzmW0tCDqpJOVyKZ3ybUSXJqswBX/hXbBDa/r6adgQMwnbT0zOaWCKR0vbDYWDRX7EKR6GuGnRGeCmdiBSVQuul/RjCKeDf6AaHX6Fgc2pZ8tEY1TksDqNhw6081FfK7PiKXSr3c1NvzjEBHlBS20zw35jQOC/Oix9Zp+ZfCCG+f7xvH/6x6+bfMe/5Jr1ZE4nNr4wf2kGv0XLMMusM5u0rbZwZxhA9U3ewMx4peHi5Sqv1Ou2hYUP/QH+RYh6/e1C1qZ3Z2zho/RttcO6lniwJI3j2fKTwQZgzG1oJ9q7yi8IGNkRXa/9XKpcVed2mjeNn3f0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(1076003)(316002)(15974865002)(6666004)(33656002)(186003)(6486002)(19627235002)(508600001)(86362001)(66946007)(66556008)(66476007)(4326008)(6916009)(8676002)(33716001)(5660300002)(53546011)(38100700002)(8936002)(2906002)(6512007)(9686003)(44832011)(83380400001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mt8cu2Inigwj1aJozfLqWHlTwkpJkteJNJGLaj7+hjcYccbXdNH7e2JRdxw0?=
 =?us-ascii?Q?gjYMtJPdSK+UXhcpvERbN1TA0+n6PLJ14J62C3g+dPOTecW2c85eVqt9pOmc?=
 =?us-ascii?Q?70bamKbtQY7EOXIOftpz4gTbjJ2xKyRJ9GM9KRuVPsvYZve/ptvWYCnrMfmi?=
 =?us-ascii?Q?A0oAYp+tNhbS5YwBQElkBfVRnDaQ2UPo/bg1mfMZxXsRhkVdi5TLhQACncq5?=
 =?us-ascii?Q?JZqShjEiGbQYymGc//8AjTeqgo1v+8N+jhn7B7f1RMfZ8xph3F93yJSZaPEN?=
 =?us-ascii?Q?oZEMaC2NB6uDLF067/mXyPue5XnwpzEFYxrIcyjHS1ZYlQOMhS8PROfK6MiT?=
 =?us-ascii?Q?h4KvDmhi6Zwnr/U/Q+wOEsoah+BU98ZMYVf5waUHJRz8iE+KE1w3aMfDHahh?=
 =?us-ascii?Q?/ubZnclDhCgt31QcnLiZr2M4ConZgVOMLWf6iSIRuZuIjcmh+6f2t1qMesou?=
 =?us-ascii?Q?hWA3BvJ7ynGaBk4INsZgVdoazzZo/RC1f06wZ88eNWouAh4iQwNCWhP2Oxiu?=
 =?us-ascii?Q?wNVR1gU81XU8KR1b/uhDTvQWEkZ10OrTyOx6HsUbk+ako+uGjjV0WnmBHxV9?=
 =?us-ascii?Q?yilgbjTNOgcbABb0sZxZalgN1owWm2RVlKMbKA+zDWTp+bjteRhWD73KgpY7?=
 =?us-ascii?Q?jks6+3cA7tz48ZsS/AvfTY35R3jC1WEhWBR0VLy9TdlC0e997NR9foJctUAs?=
 =?us-ascii?Q?PnJXZV1Y1lx3HRrkh36Ff+ak9XivfceisdpWWZoR1l/+3QcMKJhTEmnr9jzR?=
 =?us-ascii?Q?klv1hT76WKKOOsRyUPUPtRnHOAt1ulk7uh8kSIaQ08tnxFnyZPTXXHWosyaM?=
 =?us-ascii?Q?ireIZ+u9/s7k8uRB6K2+cuibpOrOT3mPPBjsUE96vcn0gY7ePPiFwiYI1byq?=
 =?us-ascii?Q?wn433yKq5NCtmKZaSlI7H4YTZfy/S13jHEPcWF3r2oUiOQCbViMlciPFARib?=
 =?us-ascii?Q?wbqRqocZg25QS99MEku/X90QTpVZjuoDYLLRxKAetPNoZFEVOhADFM0B/n7+?=
 =?us-ascii?Q?eeW7DKphCiYfEy0AXF5R8jtp1RB7H9mgdFkjbRLQHzyB4J8EpOIhbkqXqVYG?=
 =?us-ascii?Q?lb8K+YlXC4wTfYJOfDy3LFEor3QVhrStuYbuFjin/LVDi7gCw8iWbJ9HNI6b?=
 =?us-ascii?Q?o4AtCu/VRj0pBTLcYjs3XisWLDkZr7yymY4DwPtdoRKqPml4ovEVsGIYatJn?=
 =?us-ascii?Q?7fGjoqozPwyHLdAUg5ne2nsCF8GvWEXld40zKs69x3dKeYWH0fTXbfXchyOi?=
 =?us-ascii?Q?82sSiQbq7U+vkPhCX4vgJF4XM9ReKTohXIID1t9gB64qHpoQ+cd2UtOdW42j?=
 =?us-ascii?Q?tdwFpTI/fTdhWSDD/RZc3UzombCarft7bdC6senqmkLvzneZ8mXUGUIPHx7y?=
 =?us-ascii?Q?0LhoEvoyMNR4Zc+SG8mwnTnibU777fij2HWTRtUp/sBmwehEE/Kql5/nNGU+?=
 =?us-ascii?Q?FXwTdUv5Skqo7oYefGQOyaygvWQ4Nj4GWlQfn12e65H6zlNPthmVU8zizbOL?=
 =?us-ascii?Q?We1QhMqmCKroODwRae4d4qJjPV0x09K6CQa/14pZtaUM7ZU3aRIJ4lVUA0D7?=
 =?us-ascii?Q?yOxHKBnlX7o5bwPUvw2QiuzET+I8qDJYH5BMKqHbLTgrvPtp2fbDkd3FjMpH?=
 =?us-ascii?Q?pByO5xGZKFcBCALT9EawwDGk87QFhihJzI0KvKoU7oLcRo2ZVpd0S1sfm+np?=
 =?us-ascii?Q?hCuNTJcNGaYbZ3nfq24U4r7LtEM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5850644b-9776-4eee-b93b-08d9eca7629d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 15:09:51.0957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7iIKS1BQ3J2pJgNdfQpzwAzZLXrXpgQlpZun9CjAjOHcIVmHp9K7dWL40tPG2lE+RFIT4oedCSwZn2Fkf6JZqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4257

On Thu, Feb 10, 2022 at 02:00:31PM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 10/02/2022 07:00, Geliang Tang wrote:
> > v6:
> >  - Split two patches from the last one.
> >  - Retry the multiple subflows test three times to fix this
> > "MP_FAIL MP_RST: 0 corrupted pkts" failure reported by me in v5:
> > 
> > Created /tmp/tmp.e4nE5Q14mj (size 1024 KB) containing data sent by client
> > Created /tmp/tmp.QwpQYClFnm (size 1024 KB) containing data sent by server
> > 001 MP_FAIL MP_RST: 0 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
> >                                          sum[fail] got 0 data checksum error[s] expected 1
> >                                          ftx[fail] got 0 MP_FAIL[s] TX expected 1
> >                                          rtx[fail] got 0 MP_RST[s] TX expected 1
> >                                          itx[ ok ] - infirx[ ok ]
> > 
> > A test log of running v6 500 times is attached, named v6-loop-500-times.log,
> > in it, we can see retry happend 8 times (116, 136, 236, 295, 297, 402, 444,
> > 457), and no "0 corrupted pkts" any more.
> 
> I'm still not sure I understand what happened. Could it be because the
> subflow was never used to carry (enough) data and we never corrupt anything?
> 
> If that's the source of the issue, we can probably fix it by adding more
> delay on the other paths or something similar, no?

Matt, you're right! Adding more delay seems work on my test.

I changed the code like this:

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index dbc73e28cc06..e27f668b0134 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -219,6 +219,11 @@ reset_with_fail()
                action pedit munge offset 148 u8 invert \
                pipe csum tcp \
                index 100 || exit 1
+
+       if [ $i -eq 2 ]; then
+               tc -n $ns2 qdisc add dev ns2eth1 root netem rate 20mbit delay 1
+               tc -n $ns2 qdisc add dev ns2eth3 root netem rate 20mbit delay 1
+       fi
 }

Is this the right way to add delay?

Thanks,
-Geliang

> 
> If not and if you can reproduce it, may you also check IPTables and
> counters if you don't mind?
> 
>   ip netns exec $ns2 iptables -t mangle -L OUTPUT -v
>   ip -s -s link
> 
> Or because packets are dropped before MPTCP processing? We can also
> corrupt more packets or even all the ones carrying enough data.
> 
> I think we should really avoid retrying except if we have a very good
> reason to, e.g. something "normal" we cannot control, happening ~10% of
> the time and we retry only if we confirmed before it was due to that.
> 
> >  - Reduce the single subflow test files size from 1024KB to 128KB to fix
> > this "file received by client does not match" failure reported by CI and
> > Matt in v5:
> 
> As long as we don't hide another bug :)
> 
> > # Created /tmp/tmp.crkOA4p7hr (size 1024 KB) containing data sent by client
> > # Created /tmp/tmp.jFbZEAnYZa (size 1024 KB) containing data sent by server
> > # file received by server has inverted byte at 195585
> > # 100 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
> > #                                          sum[ ok ] - csum  [ ok ]
> > #                                          ftx[ ok ] - failrx[ ok ]
> > #                                          rtx[ ok ] - rstrx [ ok ]
> > #                                          itx[ ok ] - infirx[ ok ]
> > # Created /tmp/tmp.crkOA4p7hr (size 1024 KB) containing data sent by client
> > # Created /tmp/tmp.jFbZEAnYZa (size 1024 KB) containing data sent by server
> > # [ FAIL ] file received by client does not match (in, out):
> > # -rw------- 1 root root 1048604 Feb  9 11:37 /tmp/tmp.jFbZEAnYZa
> > # Trailing bytes are:
> > # MPTCP_TEST_FILE_END_MARKER
> > # -rw------- 1 root root 1048606 Feb  9 11:37 /tmp/tmp.ghV0iWPhu5
> > # Trailing bytes are:
> > # MPTCP_TEST_FILE_END_MARKER
> > # file received by server has inverted byte at 169
> > # 101 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
> > #                                          sum[ ok ] - csum  [ ok ]
> > #                                          ftx[ ok ] - failrx[ ok ]
> > #                                          rtx[ ok ] - rstrx [ ok ]
> > #                                          itx[ ok ] - infirx[ ok ]
> > 
> > In the attached v6-loop-500-times.log, no "file received by client does
> > not match" any more.
> > 
> > I think this v6 is very stable, but there are still 6 tests failed in the
> > 500 time tests log (68 77 97 112 161 243). These failures are all due to
> > get one more unexpected checksum failure:
> 
> OK so probably at the end, we didn't have issues because we had a hash
> collision (no MP_FAIL while there were corrupted packets), that's good.
> 
> >  > cat v6-loop-500-times.log  | grep "\[fail"
> >                                          sum[fail] got 2 data checksum error[s] expected 1
> >                                          ftx[fail] got 2 MP_FAIL[s] TX expected 1
> >  - failrx[fail] got 2 MP_FAIL[s] RX expected 1
> >                                          rtx[fail] got 2 MP_RST[s] TX expected 1
> >  - rstrx [fail] got 2 MP_RST[s] RX expected 1
> >                                          sum[ ok ] - csum  [fail] got 1 data checksum error[s] expected 0
> >                                          sum[fail] got 2 data checksum error[s] expected 1
> >                                          ftx[fail] got 2 MP_FAIL[s] TX expected 1
> >  - failrx[fail] got 2 MP_FAIL[s] RX expected 1
> >                                          rtx[fail] got 2 MP_RST[s] TX expected 1
> >  - rstrx [fail] got 2 MP_RST[s] RX expected 1
> >                                          sum[ ok ] - csum  [fail] got 1 data checksum error[s] expected 0
> >                                          rtx[fail] got 2 MP_RST[s] TX expected 1
> >  - rstrx [fail] got 2 MP_RST[s] RX expected 1
> >                                          sum[fail] got 2 data checksum error[s] expected 1
> >                                          ftx[fail] got 2 MP_FAIL[s] TX expected 1
> >  - failrx[fail] got 2 MP_FAIL[s] RX expected 1
> >                                          rtx[fail] got 2 MP_RST[s] TX expected 1
> >  - rstrx [fail] got 2 MP_RST[s] RX expected 1
> 
> I see it is also happening when only one packet has been corrupted. So
> it is not because a few packets in a row have been corrupted I suppose.
> 
> I guess we don't have retransmitted MP_FAIL/RST here, right?
> 
> > These failures are related the checksum bug reported by me, issue #255.
> > When transferring a larger file, the checksum sometimes fails. Running
> > "./mptcp_connect.sh -C" in 10 times, we will the MP_FAILs. If we solve
> > issue #255 in the future, this mp_fail testcases will be more stable.
> 
> Indeed, maybe linked.
> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
> 

