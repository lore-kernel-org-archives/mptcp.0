Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C27C2CA2
	for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 02:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642041030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=urxYiVm6CiEom3BQGi7btWd11XYFQabyblbpt1RvYus=;
	b=R+P+wjcD9PTMzKuR9OPZJGpmGOSUWVrM0Oug0vkixwk0vB27rBvZyzmVpWUs3OcPlU4kbQ
	1XmalSlhsDSVbHAR5K9hgQ06hZ7xHzAnchhkKpwd1PbUFVFwoxBh/ktPBYoFxK/CjV3ru7
	jpn439VKb0kgurSAcg7p4QuzNYgDZvo=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2057.outbound.protection.outlook.com [104.47.8.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-27-Lzra9T-SOCS9V5qHIwH9tQ-1; Thu, 13 Jan 2022 03:30:29 +0100
X-MC-Unique: Lzra9T-SOCS9V5qHIwH9tQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvVbSJHqSzWLF/n2eZ+IyGrCjr3JV6UxuRu4E38HIAwg4/d32yHv9OvXHqKrjusuTKywCPK6KcFvhNxHOhX28TAqdMU8XOP3UURDgBfLQxaQGsPeNheA6lGZAQNBVTc5bIrDuXEML2iq3FTTNAJAgjkJNsflZlkFBImLhTsusoaprPdgvECJ3J9IEq9J/mYw2REdZexzdupiXKYBRyo4qzUMPtJZjzVr9bXgvuX3U1cUf/XLmSxWoAQe2cDWLVuDZxzWb2o8NkLpU/5gIFMDGUqaV7Pc4bRM33kP8i5YN438rmSAbZwpbnFF2+MFR1zp50Q5RSw/lSOcQfXJqhRx4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urxYiVm6CiEom3BQGi7btWd11XYFQabyblbpt1RvYus=;
 b=K04JXrQM2IgW+Xpw697pNdLx13vXeYqWmzYTRe+1YxWrRM9XifJ/CdiFgJZoSse3eRu0y1Z+J/tC3ROiED5GX/WLjnsPckH94CQufjagNuIXQkAfvehdp8CbUx0+sSeBsJZNsN3m8auk2SV9jnJ+Z4Dl/8s7WftaGOgcEc/lLIEnTqXOSXJo2DiyxDMulQzOv8otMg3AjxVltDfUXNFqAZ34R8TqakVv4O4hk2kxwXNEGQ2iZFboCqBO/7QMv4PSSRdRESm94J7Cga8L7PzjnJI2dcKsVlmaCmk6qJPXA7VqYrYQB+sVnJBdjP5jQ7w+KATabB/E9yCJ9CAdHoY2mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB5078.eurprd04.prod.outlook.com (2603:10a6:20b:5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Thu, 13 Jan
 2022 02:30:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Thu, 13 Jan 2022
 02:30:27 +0000
Date: Thu, 13 Jan 2022 10:30:21 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH RESEND mptcp-next v2 7/9] selftests: mptcp: implement
 pm_nl_show_endpoint
Message-ID: <20220113023021.GA3805@dhcp-10-157-36-190>
References: <cover.1641535880.git.geliang.tang@suse.com>
 <47e4e94eda65b9e68ec469fb3e7309405167ec73.1641535880.git.geliang.tang@suse.com>
 <2a75529-5ec1-9532-24-50425f67770@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a75529-5ec1-9532-24-50425f67770@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR0401CA0012.apcprd04.prod.outlook.com
 (2603:1096:202:2::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a693562c-2622-44db-04ff-08d9d63ca8dd
X-MS-TrafficTypeDiagnostic: AM6PR04MB5078:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB5078AF1C05C9B0760344AAC7F8539@AM6PR04MB5078.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2e6bEtmimRKE6Zjlb9E0wunJWu/NkKHW5ANSNUW0uw568+QvOveZiUnarbeTdJsgQmFqKDlfCjtlUJFjsOikyUUssu2jVuTQtM0uNbwExr6/VVLIM+myUBh5EtamJWJ0iOT6CPn1Lnyh5gYBYlJC8xClllIB3A7v+w7fs1M2mQVL/9PyYQeKfGk7zBr0nFOTLxoT6JsJsdW9B72opBWhqM7WKtbvTybPavdsSb3WlTdED1XqazB7PkqvpHKw+cOEejXvhIAboHkpJgI/5CxZzRw7+DRzENtXCeSrDnwXzWn2cHMZRWwkk2iTS2vRtvcbEKw1H/HOMe/bzd74iP0xk+WfwtmtQXw8R01PyFJmDC28X6jO34HeqInJdbh9JUh/l6StMQ+2rRAsZelyWkzBTFEoRCRONpqvMQvfo/i3wwq6C/52eH+cKpPOFBW53N99K6aczFRbEdpBcIDo3Epu3Bo4rCiudkDyuAqiEeOZ2Y12l96h+zHACuQNfpH4aMf9sQgt78Xgdqlj/T0+H18GazTN8CThrN7ZpSMaholxQE5ObR+i/NScPLx7dxbnHbAFFwJojinBF1z/zM92kY2ReKomo98QkmZerAtUb3racrD2RmAj607mHQHaVD5rPq6T/BQXzKtydNVgsQzdx9mAWg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(508600001)(66476007)(2906002)(1076003)(5660300002)(316002)(38100700002)(55236004)(9686003)(6512007)(26005)(66556008)(66946007)(83380400001)(6506007)(86362001)(4326008)(8676002)(33716001)(186003)(6666004)(33656002)(8936002)(6486002)(6916009)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VO4w2KC9bn/OJRBKQ+45CId0kuKjiYqQ2G1dqPQx8Bvq+Xva5JTDcBqYiPDy?=
 =?us-ascii?Q?eZXKa23fkzSVWBYoafr/pEc0gJ4OlPogOgJw4EMPnH3KWlo9L5PSTQv9GxKB?=
 =?us-ascii?Q?f4w4wmCZaqORlm5PxjC9NSHM9VdgpyY8JLfGuugbx4up7D9xFUmXOY4tqvj8?=
 =?us-ascii?Q?7dYfWUaUccyExbgmfsMCjXhvTF9MIG6rVqkhm9xpA4pq+9ZBx4pT/1SHyQfm?=
 =?us-ascii?Q?7RAtSdatEKH2Uk2HLFVup/6znjqmo8b1IFpaINKn8RNora84bwwvrAhAg8//?=
 =?us-ascii?Q?bohNknOcMPh6YQ4QCTW16H8iVKONB29WQc/VKtGg09t4uqbESgfYgQSdq1l5?=
 =?us-ascii?Q?0KcVPxjklEEkflQbnxfsDbZ9bvwcJ9WJNkwhTlkxaNlvlt6ynVE4bm/T1Kb1?=
 =?us-ascii?Q?Yvj2PJTra7NxZpeXkShCtZAm6etjozk5xvhmWax3F9Y2p5IG5t69x03GFdoY?=
 =?us-ascii?Q?d6ZdoMNUCni6PLvAQVh+scA1t1zAiaiVuy/v4Z1YfYVmlxyNij241ibGX2oI?=
 =?us-ascii?Q?RC5tDQisXrbmq+7nNWxG9sIV52pmpRZ6KZDAn5KPt2SosGI96JbUA0i1HzmN?=
 =?us-ascii?Q?9H8w5EoHNDWkFVGADpKlLNFBKdytwChZ8+b7en7FMGDlcFS/U1PNMvO7JIpI?=
 =?us-ascii?Q?VzQ43kbn7Zsnnvdc6jqs9XQybyEeva6n8Boqf4Kwm01kR7NM7rxHdm1zMDZ0?=
 =?us-ascii?Q?Qm4v76MCbpICF63ETkRe1W92zc6g82ItRxp4SY89k8qOXU/Ukjhq5zaJjDd1?=
 =?us-ascii?Q?TqVwQC/m9U4w+oWvHvT4ZtpnDg8TkxM9RJXcyps4ySBA9Zl8FgNRU/WjkUR2?=
 =?us-ascii?Q?EpM5lh7A06vYvuVMj0R+q2NmKYz8yBJvAx8UoPYHhBBKP4OZu/LsU/YA50Nk?=
 =?us-ascii?Q?8JOSB5SNHongTjRMvlVcB+a44qV1rxc1DVmPhkTl/dWZcsUamyTLWN+gsqHF?=
 =?us-ascii?Q?Vo8o9Y/BtSW695ijTzTc5uZVBvwAnahNY3IPqngWUUs6otgPEhjUMg8oJEvM?=
 =?us-ascii?Q?2rpSYyKY+3MS3kRdJ81zIiH/vPLRcLu9TkowUwi18mQBzHFJW9aH2TJ830Fn?=
 =?us-ascii?Q?V0rpcH0KVl4ljTPWrMFv1lZiXRFxDOCiz9hpifzctQ0Gvyf3RHMGLGnNdcHK?=
 =?us-ascii?Q?u06dsfq7Qt+lRvhfTQjAkK1IZg3ZQC6xL8gbFzODkOUOZim1R7s/76MoyH9r?=
 =?us-ascii?Q?DE2ghtUTmTnVb1dVJZt/bxTOjjZyulfBJ4h87xXY7oqbUYxNF6XsMbN4ZSx1?=
 =?us-ascii?Q?iNNTJWneXJV3KFYfOaDnCWwwTiEF5qgQdOu43KMpsN2/zEur3YUfyYRHzZG4?=
 =?us-ascii?Q?u3B+IOh0TvdIZPm4+qfh2JoBTk0S/2iaJydhHcLEtDmtwgX3vW7Upqxro/oi?=
 =?us-ascii?Q?FSeVUArwgpxuN5cbGT57sqniXe7TIqF3921yQPF2QcSnyb+2k3a5kydX9lVV?=
 =?us-ascii?Q?G7568o+zn2KZsHi1gHaSRwO0ClprsrvtAA5Fo4EEZsXJx7cXrBnMlGCynXiL?=
 =?us-ascii?Q?7GuNo5jqPyNlrogSHvPpsw71AUNq8SH/NAmhYdq7MJcPjlsIEhCZGKaQjpve?=
 =?us-ascii?Q?T9/w5A57vXXV5R7DOw9Mn+2BIjBw1Oq/vVP5n3X9IaKj7x0z6oKdrWKdA9oj?=
 =?us-ascii?Q?sdkI1Yxf1t02AaLiG1/zRS8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a693562c-2622-44db-04ff-08d9d63ca8dd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 02:30:27.3449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qanh420TewHk0cyPETy72zI0fib1H91PBXrwUDAdZjuNFkoezMUtGkPwErCVqxQJ5WtF+UWs0SZhuIPya6kwtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5078

Hi Mat,

Thanks for your review.

On Tue, Jan 11, 2022 at 05:15:43PM -0800, Mat Martineau wrote:
> On Fri, 7 Jan 2022, Geliang Tang wrote:
> 
> > This patch implemented a new function named pm_nl_show_endpoint(), wraped
> > the PM netlink commands 'ip mptcp' and 'pm_nl_ctl' in it, and used a new
> > argument 'ip_mptcp' to choose which one to use to show all the PM
> > endpoints.
> > 
> > Used this wrapper in all the selftests in mptcp_join.sh instead of using
> > the pm_nl_ctl commands directly.
> > 
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> > .../testing/selftests/net/mptcp/mptcp_join.sh | 21 ++++++++++++++++---
> > 1 file changed, 18 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > index 475867a01b83..1a92f0526a4a 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -363,6 +363,17 @@ pm_nl_flush_endpoint()
> > 	fi
> > }
> > 
> > +pm_nl_show_endpoint()
> > +{
> > +	local ns=$1
> > +
> > +	if [ $ip_mptcp -eq 1 ]; then
> > +		ip -n $ns mptcp endpoint show
> > +	else
> > +		ip netns exec $ns ./pm_nl_ctl dump
> > +	fi
> > +}
> > +
> > do_transfer()
> > {
> > 	listener_ns="$1"
> > @@ -471,7 +482,7 @@ do_transfer()
> > 		let rm_nr_ns1=-addr_nr_ns1
> > 		if [ $rm_nr_ns1 -lt 8 ]; then
> > 			counter=0
> > -			ip netns exec ${listener_ns} ./pm_nl_ctl dump | while read line; do
> > +			pm_nl_show_endpoint ${listener_ns} | while read line; do
> > 				local arr=($line)
> > 				local nr=0
> > 
> > @@ -524,7 +535,7 @@ do_transfer()
> > 		let rm_nr_ns2=-addr_nr_ns2
> > 		if [ $rm_nr_ns2 -lt 8 ]; then
> > 			counter=0
> > -			ip netns exec ${connector_ns} ./pm_nl_ctl dump | while read line; do
> > +			pm_nl_show_endpoint ${connector_ns} | while read line; do
> > 				local arr=($line)
> > 				local nr=0
> > 
> > @@ -560,11 +571,15 @@ do_transfer()
> > 	if [ ! -z $bkup ]; then
> > 		sleep 1
> > 		for netns in "$ns1" "$ns2"; do
> > -			ip netns exec $netns ./pm_nl_ctl dump | while read line; do
> > +			pm_nl_show_endpoint $netns | while read line; do
> > 				local arr=($line)
> > 				# 'pm_nl_ctl' shows the address at the end
> > 				let pos=${#arr[@]}-1
> > 
> > +				# 'ip mptcp' shows the address at the front
> > +				if [ $ip_mptcp -eq 1 ]; then
> > +					pos=0
> > +				fi
> 
> Hi Geliang,
> 
> What do you think about modifying pm_nl_ctl to have the address in the same
> position as 'ip mptcp' to avoid this special case?

I found it's not easy to modify the position of pm_nl_ctl, so I used
another approach of getting addr in v3 to avoid this special case. Use a
new function is_addr (just like is_v6) to check every possiton to find
out the address.

> 
> Other than that, the series looks good and I was able to run the tests with
> both 'pm_nl_ctl' and 'ip mptcp'.
> 
> There are some other selftest changes pending in patchwork, are there any
> conflicts with this series? If there are conflicts, which series would you
> prefer to merge first?

Done in v3.

---

I just noticed that the backup selftests will fail when we use an address
with a port number:

       # single address with port, backup
       reset
       pm_nl_set_limits $ns1 0 1
       pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
       pm_nl_set_limits $ns2 1 1
       run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
       chk_join_nr "single address with port, backup" 1 1 1
       chk_add_nr 1 1
       chk_prio_nr 1 0
       chk_rm_nr 0 0

To fix this, we need to add the port argument for pm_nl_ctl like:

	pm_nl_ctl set 10.0.2.1 flags backup port 10100

This fix will conflict with this series somehow. It's hard to do it as
a squash-to patch. So I'll put it into this series and send a v4 today.

Thanks,
-Geliang

> 
> Thanks,
> Mat
> 
> > 				addr=${arr[$pos]}
> > 				ip netns exec $netns ./pm_nl_ctl set $addr flags $bkup
> > 			done
> > -- 
> > 2.31.1
> > 
> > 
> > 
> 
> --
> Mat Martineau
> Intel
> 

