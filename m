Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35692568
	for <mptcp@lists.linux.dev>; Mon, 21 Feb 2022 08:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645433663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dP2GUz9TZsUDSf+rYkDb3vV8RcZTMlyN0KiXGNh8bD0=;
	b=hVGV1r54sxWT0GpeZGBZ1h73J6zD9r+l+lE9cwVd5OBcvXV+OPIvBvFbEeDaNWiEupn8ye
	ZubMMpygQILHFNmhQ3xk04ouKFJg1YNOleB5FWazwqK2tsS3a3Pr5C91jHXkeqZxFitdQc
	kjKjDlQ/8gC4dtXRQpsN8aZTt+cdjyc=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2109.outbound.protection.outlook.com [104.47.17.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-zrvHM9zSPUSoFpTYVtW3zA-1; Mon, 21 Feb 2022 09:54:22 +0100
X-MC-Unique: zrvHM9zSPUSoFpTYVtW3zA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGJ0kn+EiNRiJXqB1lHSJI6Sd5XRVnZJdDUJmxh/JuMydSd8x82ZZAJQRpa6fh/qcMwCd6qWBdVMPIV00oFEnXqBV2EyqgVA1T457kIvLpvOfqpfCh4T+meevxsNanAobeh/BwPH4CgiHhcsAqs7w1VNFiCeKuwU3X7unP8rpWcne0JVC8GrCV7BR7tSyrlQ7lQFoyFwipc3tfFayOnNBT5pq8ZDVHcBi9gsPNetRtWsSFAodw6us52rOWOaZ9ZMZwyLYHqa9BfScI29Mf6f4DbtINb7KJmz0SoPjn1SJ+h2vswcT6V5KhgI2iw23WZw9Utt/kTUx170/D4ZAD4RAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ju2PAL53eM4RgL3uWvwzy4moNzzz8oY5nDFmZ7DTW14=;
 b=SA4wcFI5lPPRbuACdL7fsmTZg2ImLzesIYdR3Gq4CHBM6VKbrUrdWibX9zmt0CakFYYOxo8+/oj3vj/2exl9bgemPG8dDq04kjWwvjsN2v6VMgafSA0C1xb9sN4endceiy03/KPsW5bie6UIwXmAX8OPkIJPT4//SMAGmC+fhHKsO/BuzRiTprf+326F5uacyHKYgJqgVsTAMsOvzFfM2SJmMfZcnis21fn0i/jDf1QYP/Tf5T7zvbV99n6eD7eu7d9r0baXCoyAUId/tg7ggDG6XOHWdmUdU52F4GSSjdERCr5YMBePNWqXcS+ORO9sTNHJ71ANzouZiYiFUuFXlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB6151.eurprd04.prod.outlook.com (2603:10a6:20b:ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Mon, 21 Feb
 2022 08:54:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Mon, 21 Feb 2022
 08:54:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2] Squash to "bpf: add 'bpf_mptcp_sock' structure and helper"
Date: Mon, 21 Feb 2022 16:54:51 +0800
Message-ID: <1d22e521c59d2d6c6b9205326bfc47c0cabfe424.1645433392.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0109.apcprd03.prod.outlook.com
 (2603:1096:203:b0::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56dad014-c53d-4bb6-1bfb-08d9f517c0a9
X-MS-TrafficTypeDiagnostic: AM6PR04MB6151:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB6151839D30A34A267F27E07EF83A9@AM6PR04MB6151.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6WV9AaIL3CFSYrPck3s9ukUmC5TzflFPMooFnyX3/nRVKlcgNFPwfnP8iPsgChO689lFz74J+OeqFTcFkMOy4sofz4PtHPulFu0zZOVwH6nL0UtFb2gX8ZcIyY9zwSvtfEiSVG4yEnD8vu/1x1LbXGO+VI8cZJeVw1hXlxw3BFfIBz3QInk8VsuAaW0ZKHvWO5ftJHERaKPWVb2/rqnNU0PqzDnlTHo7/Es9qFoi2onzZsHwe9ZKY3lfLGyto6GTalsNd9hoxmMx3C45yzm2AOWsrrauVh6aQtGQJXYOPJDzjGtY4BU6PSC2rF9RvAiQQa32bHY0NI6tpFszEubPKU6seOpJiOqCFTiJlA8IP3+oPZWvOVBQHZ/KdetI8rNKYkv5ojYxjXw9fFTt0G6vs6gHpKSszsgZEsu7tiqIUDW2g0grJf/IaXyPkJSHKWtpA6m60UMXv4CGcX6/0S2mKLmd1THwyJ6LMdmbR4J3Wq/RXWrRqujcgK+JUsl8nlR15YEm5WUesH/cxwFyg3Re/IJ4974LP1QIgkUs/r5FOkhwQpytwOrimWG5PbbvVtfCv0o400NRwZDTfdvJMDW8qrFycCYEAiIohCyW4ZGmSKAWBHOMaAN7xjjsCAnzgrOj797FJKMEDOupYXETgqdHDChlktKbMGJ8TqoSf1G4ou5Qdf6muNkltFBxA2cFJb6SDT/3vBBpggKyK95MzsmYuEBKCOHjX5WZSzEp5BlaJVw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(5660300002)(2616005)(8936002)(316002)(508600001)(107886003)(6916009)(86362001)(966005)(6486002)(6512007)(6666004)(6506007)(4326008)(8676002)(55236004)(66946007)(66556008)(66476007)(83380400001)(36756003)(2906002)(186003)(26005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0O9r6uK7luBMFoVovNa4CZ5snx7LbfNRv99oD136mDkLmUIDtQNHvrKxbMpI?=
 =?us-ascii?Q?hLkpcigFMTL/Yh8FreU61ELqvGKPC4NzqmMxIqjMLAnyjG0IYaRdRKqNtRrJ?=
 =?us-ascii?Q?dOLA3x50rWruvS+1Y7fcWviXq+ANNsqnV9tjdQg8/g/ijaZ0Zl1rg/tJIaTN?=
 =?us-ascii?Q?gYkQSmJZjSQYcmI0C0ejunK9IFA0qQWVoeUXc+SF7QbnE8XrMdHCpO+xqHg0?=
 =?us-ascii?Q?nof8MdNoICeVB0O+gY1m6GnFmSVQVICYVFC2cfL5HcMFidILpM1m+exKWnFe?=
 =?us-ascii?Q?E+IzskXxqUW5GPAZZOODTVBQxqn+v1YEHzpEvp3L9kXjukJLI8RZ5WKpx8wy?=
 =?us-ascii?Q?iJycsIy94qJE/culUJBOyy7pWbfjre9USuAJ/gFDe6BzCtn3ZjlJ+Dg1yThr?=
 =?us-ascii?Q?gBhL/uUDGvj92BmSXRP6cmeK7A6OPAr9TJk+x5JGhJ9vkTQIxrD8SGqwme+d?=
 =?us-ascii?Q?1fnE9xG8aWM/iA0dNXQIlDQHGVtIOQ2SEXs518OL/CHCcvMbkYdONRXrNOWo?=
 =?us-ascii?Q?92oe7teysMPO0A7SdsRyLZ+i7DkHs26KpqaPV9x/0w1AHgTjyh8A3N/Ga1UB?=
 =?us-ascii?Q?XVMjhZyFRCta4/2lB66jjTGuftddxZla8Qus0uUAoq5aguUXvmYTPAVWLvi4?=
 =?us-ascii?Q?la3hlaI/A48FX5VWb6SAztExe1iBdn74CjFKmfxDgKbFxzHLHiW0L5ivJtQJ?=
 =?us-ascii?Q?0lSMF5GhWTZECLHhoXsisT+TYtAPHskeTiYv3VLwN7HB/xG+1UmeMFCyvwEM?=
 =?us-ascii?Q?jGD/edLvQp37d8RwYyDjYJYbNTqDuB6MlF8jORPgsCDEpzEnL2J7wrOB1UtN?=
 =?us-ascii?Q?VuTu8thLQ11Ey6kMm8m55jW5+nNiVZq7hou8QDmmH48v6RSVoC3x0Z9J2hvi?=
 =?us-ascii?Q?AZRLGn2GN7yw3TkoKbuHEf7jdmdXFq1P+zsehLrfVL7UEBbUSD0+VNj33ULT?=
 =?us-ascii?Q?WpVQRcksnoTCId9UGxyofsgikVGERXBZN4bXCBzyMCcBI3PuF13sVJCM/3WN?=
 =?us-ascii?Q?L8kre4eXNhhlFf8WajPq73zNOOqh+BkEBSldJ/B4YAmvGchNICUc1AfCvAH1?=
 =?us-ascii?Q?vQdK+h+/GPEu45htBZlokjG62+Q4VWD3WagSlPMP6dedpREGO4vEFbR/tkfu?=
 =?us-ascii?Q?SPTXGDMobKR8M18dZfif5dYR/OoZPEGRLnYqGhKOokPDd3xxUJwX9aq4m8fO?=
 =?us-ascii?Q?k+BfuuS5on26W2ypBbhLivBUSszrPa6T2o8fC8ic3Pj+AMd+WinfLDIYVPCc?=
 =?us-ascii?Q?owxU7Ct0ayeWDjmWAxw0tRSllhXlzWC7vlC9a6uiakpE4ezATy98JxdeuTa6?=
 =?us-ascii?Q?rWrfl2r+TJYMK+KfssZWIbT2IxhuTAv3Rds8neP1ymVyqFZtJ22L/Hqv3jiF?=
 =?us-ascii?Q?BMhBGMvzN7m8vq/i4HGA21ayNPmzNTU11PK2EaCS+FV/8rtDBY7w3WjTNORP?=
 =?us-ascii?Q?7N/LFJY4kQ67CIpC0XwchsBUXHqatahxdXLm1IsG9DcKM85ASli+RTJn3Zth?=
 =?us-ascii?Q?Y8032ph3xc/K4B/ECV2aeO/7aGtgsgM6UcdL2nIF9KmOgADltoIic9IoP6U+?=
 =?us-ascii?Q?VCHX7tM5JnJqzVHJQS9hm8Xhnxj5uzk1rVRgCuKPESFBOu61VUoHO2b5UuRk?=
 =?us-ascii?Q?fuEU5TMA/8D1xzAdAybPrY0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56dad014-c53d-4bb6-1bfb-08d9f517c0a9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 08:54:21.7184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MI8xlBdmPWAQcepH6HWhzxbuSPxGRoIivEGMQ53IGLZk9smn2UErbfxlqgn6iwMZ929jN1DFPzb1XuMnfe/yDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6151

This patch addressed to the comments in [1] from BPF maintainer Alexei
Starovoitov:

'''
On Fri, Sep 18, 2020 at 02:10:42PM +0200, Nicolas Rybowski wrote:
> +
> +BPF_CALL_1(bpf_mptcp_sock, struct sock *, sk)
> +{
> +	if (sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP && sk_is_mptc=
p(sk)) {
> +		struct mptcp_subflow_context *mptcp_sfc =3D mptcp_subflow_ctx(sk);

Could you add !sk check here as well?
See commit 8c33dadc3e0e ("bpf: Bpf_skc_to_* casting helpers require a NULL =
check on sk")
It's not strictly necessary yet, but see below.
'''

I added this !sk check as he suggested.

[1]
https://lore.kernel.org/netdev/20200922040830.3iis6xiavhvpfq3v@ast-mbp.dhcp=
.thefacebook.com/

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
v2:
 - keep RET_PTR_TO_MPTCP_SOCK_OR_NULL. If we use RET_PTR_TO_BTF_ID_OR_NULL
instead of RET_PTR_TO_MPTCP_SOCK_OR_NULL as Alexei suggested, the
"userspace" tests developed by Nicolas will break.
---
 net/mptcp/bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 5332469fbb28..165edec3b276 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -56,7 +56,7 @@ u32 bpf_mptcp_sock_convert_ctx_access(enum bpf_access_typ=
e type,
=20
 BPF_CALL_1(bpf_mptcp_sock, struct sock *, sk)
 {
-	if (sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP && sk_is_mptcp(=
sk)) {
+	if (sk && sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP && sk_is_=
mptcp(sk)) {
 		struct mptcp_subflow_context *mptcp_sfc =3D mptcp_subflow_ctx(sk);
=20
 		return (unsigned long)mptcp_sfc->conn;
--=20
2.34.1

