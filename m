Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B653A15A5
	for <mptcp@lists.linux.dev>; Tue,  5 Apr 2022 07:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649145192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NI2SRTc6lD5WaNdewLNNzV24dBmxhyLkSZSABtCdIpY=;
	b=ia4BDHY5y9/AblsldtzebFmmx6LiEUQDkWABRCJ9Iqw38ICoJv5KR+c87+NbtQnDFuSKLz
	RdpcreFQwtlHyEfaz+2Gi7vYVqbWztFx+CXQ99NM6b3vodSoP5c2/nkGpCJ9tUbfBai7V/
	Q04ZIZZWQ5cFxBYhLGB8PaSKDfo7qvY=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2056.outbound.protection.outlook.com [104.47.4.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-rD10GT1hNt2UhKODfcx6CQ-1; Tue, 05 Apr 2022 09:53:11 +0200
X-MC-Unique: rD10GT1hNt2UhKODfcx6CQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ns1u1+53eLiIcbC+LggQwQi3MY24DObDhY+f+ilLDAvxRYp3sZa/DOS/DY+00nMQSZR3E4hUqsXF0DTp4GkOqDDqYByUljtV5lp+jcUMzdgO/tfNf1w3cC2Ns3Hm71WE5Zy4+tScpvk5YnUe04BS9cRhB43KMREHIJr395wpowN0PiEw5vu0s2NuhlllNuXzaDl+d7v3aQouUJ8LCybjFPyrgG1tMuToUVCjCjVqGos6VEvOF1f+/sx9b4/PfVzvLuF/ASInC61zw4YAykmKB04zAX8QflOqa390wT3OezdyLx5wnak+27xgCiQek9gp3Y58pRan5er2RfyxDxUvRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvn6iII26TUdzzOIvmZrxsnkyXqeYx3KJhY5KgsZI48=;
 b=fvgovQWpNP6hktCwfjlU3ExjMy4eRgFR4XdW9H3sHueuaayI+ncbArluTLB/p8l1oguV8Zi2knXX1uSD3X9l0v0NINZWF853zQhtqri7pD1UyHO0S+aGqsCWQhuGrPJslefz/BTu/nfrvFrF46KTYMEo68rj6Ci/ZwBwMFi7i/7NQvu0VeJJNP5YywXewKU8eVMUFziBrNrAVIyLpHNL4xd+DZv8KYnBrhOkbkDN1jJ7DnJbftRZHrbtwmX8FWXs8hhmqa9/djRY5U6hlOZZuFjGSAHd5XgRyiuk56K6BFYIDqHVXrQokaSXdsper0Trhfs+S0LnZdan1RAeqQKIow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB4950.eurprd04.prod.outlook.com (2603:10a6:20b:2::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 07:53:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 07:53:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 0/3] BPF round-robin scheduler
Date: Tue,  5 Apr 2022 15:53:18 +0800
Message-ID: <cover.1649144853.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0109.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1769ace0-26e5-48e7-a947-08da16d95406
X-MS-TrafficTypeDiagnostic: AM6PR04MB4950:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB4950E8FFA1A2ECFD8A7439AAF8E49@AM6PR04MB4950.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HwVsziI3c8K0EW/NFmI3zopK2n9FFL6/D5guYNV4NsYyHYFJMF4yo4yUN6e1Ep4y42dm6WOt/q+pYiZrg1dBM86JjvIYtr7VQLOhr1q+Q20glgPnP3LO1S9CyOFhvoshp6r0iXWuxKDC8+i3PtxX5Z4ncBLSQ7BbzWF29pu/5qr47i2ss2XnjPzlUBGeSkuS2IVAVuIoMTWx5Ep2TYXUFIJDsPgxSZodNv2q9lqbWpSx+nisQCMG3OH2GLBtnPsyac5VE2pTFXEeTavdAr+FmPwOJiKapHSfYGt1QjXjFsOcKMBkxHDNfthnOlo9z2Pir2+l5CAMvpDeKFf5jysRg7trvjrHTKfPts3nmvIpCUOe9tCEQffj0hVm/YUybIWaZHlUaAEo1dfp8fN4xgtatXF/wxtfKDRv27vwTb6QbfwYwxcq2UdIwkbdsiQXcYwucWPWrr96z4Zk8uEgW/R0f4bsanJGYhm1I64xcWWsdgZEedTtFW0I8WmC6vnWLfAXf3RbZorLz8TdS0t+kbJfdXK86JAjvyRbVORpGdMOISU3a0x5W+T/sM0VgAs5cbT+wekIGafna9vY4MRguX5haXihf+SgSvU5JefdkJ0OHBU0xwI+FPDDZK6f00q/a+IgryYYxiYF1IjlrS63Yu+wq5Cxt77Gs63MCXGFDpveNriMMfTo7Q4DEenhvTKxjiaTmOSgfsd2r9KvF/YYEeKMZWylTPn2O0isyk2eKSN2CWCOsZ20f8g8inrv5qb9W+g4dC8N0ua2CS3iULS992mi74qw81TnGHpnogM/s34hTCqPxVBH7+zeJ2Q37ynilLsV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4744005)(6512007)(107886003)(6506007)(2616005)(4326008)(66476007)(8936002)(86362001)(66946007)(66556008)(8676002)(2906002)(5660300002)(186003)(6916009)(26005)(966005)(6486002)(44832011)(83380400001)(508600001)(316002)(38100700002)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C3pDALJFnhGRQqsZnCNRc3HoiLd1/Z5jJnVM7RQX2wKW+mOKPghrDSf4ds16?=
 =?us-ascii?Q?ENWrHkaXJhiKns87BxnsxLa+FkenDsJwa3iB9P3T+TDRYlWZ1MvfIMhmiAZL?=
 =?us-ascii?Q?XGvgIe1Z68xhF08NnnbtRPm9slLyn0qAdoBKLnzEoddoTAEssnsCe0xHm5jF?=
 =?us-ascii?Q?l/ah00Fia1xcyF60jxUaeXng8w2y857qkv6TJ6nJAh7cO81PlwjxN6/Z7BRJ?=
 =?us-ascii?Q?Ha+hQOjXsctXobcfQLPmVtjwxbsebpI2GFAn8BJw6o1Wg8l4u0gjEiRwJx0s?=
 =?us-ascii?Q?54AXko1ZSc9TYtGgVbHr5RbgiDr726N4ncUpe/kfScIF2FayG1h9oOtGSiFQ?=
 =?us-ascii?Q?tXEjai2gUAKe2vsp+vd3OMhadPga20iDQN7D6ct7rKnaq3EGhbHzezDeMOos?=
 =?us-ascii?Q?AdGU2jYAjExkpSI/sLt82SHzZOb8rjW30m6rFuRBTjOSWNlMu4hkbsmDaq5g?=
 =?us-ascii?Q?8hFoQcmw7/HL7cuGTdgJtJdpgI6fhnfA9E3BNeSNReKKj2qUjhckD7wfoz5g?=
 =?us-ascii?Q?WneHVLz42m03hEP1obLGh75YjxeBD96YoZ0o19z9DNgKH1X4co+2AA0KdqCs?=
 =?us-ascii?Q?8j0FQJMWt/epGgK9GKy2iVAqeAWIbwvr0jVVxVSlojfU72vKQVm27l37GyjX?=
 =?us-ascii?Q?z4nLf07R8WabBPJmpLAjfWbVFxDMSJ6IyB/z9KvtCpY6APinnLDx0lYvojXv?=
 =?us-ascii?Q?r3+SFqJ0FkjYiPmGuVWRXroSOK6J54exHbduHg3fz+XA3nvAU/jGYdsL38Yz?=
 =?us-ascii?Q?K2h1lbPwF2om0bxpmFNblP4M1pKDARV6DhEo5QMenmzl6RZnvcbPptv2tKQe?=
 =?us-ascii?Q?cYRWUyujeXmC7e6my3l1vwJH11os75xw/rIn+1iii3IsIXBwA5ctdTLGlyDB?=
 =?us-ascii?Q?S6WjM6hGabhNNuoQtRWhJbSCP/EhwN1xn1lmGms6oVUO2MO7vue2nuCfXj37?=
 =?us-ascii?Q?/jPHn7/I9zg12EbbKFBQb9FAKDecn2TtDRzmzaQAtvmgw59AW1sw3jrjFMXo?=
 =?us-ascii?Q?CkmdxGjjzhTDYSHgXxZrCwcyd+Upn4pExGztXwD3VGTUrFbgr0UUKky5hH6F?=
 =?us-ascii?Q?0Wis4zWaSPpIzcPa61jIKSZ1SJSB+h5QTDQgUlYLRxzo4V/Ba9iqgFXoTqv4?=
 =?us-ascii?Q?Hj14dVTzOi/heweIFUBuT1mc2aP5Rl1plrTsGia8Fcm7HXYpfWeXxYoEqMew?=
 =?us-ascii?Q?qBCvvp4EmDyLNp2yqDoMQ5M26EJRjrMssGHQWTWEyLCmmD+OhmpdADR0Q2up?=
 =?us-ascii?Q?bZ4lg7PZWKmvyeNG+7FleghSPoC1bNnQdFE6DSKd1/nLomPBJEUMOw+h6e7c?=
 =?us-ascii?Q?kGXCWSIK6tm9GKzD2j5WXBJllrzi5lBD7mrVGavoM2Iatms46yaGiLohLHkJ?=
 =?us-ascii?Q?jj6AyJpBfVToSJOMso1UB1U/vD2pCes6szjmtze6V9knfObGQRpCBVb9Youn?=
 =?us-ascii?Q?ZNNl12TIv/JI/JV/WpqqWntImWe37zWFFdf9LTSVA/UGJcfudFfc1buDRLCy?=
 =?us-ascii?Q?Aqp5+khY0Vidmi8C4tYivFRiz+mUxPR243W0EdnwTJPV2adTn/MwCdNBJEg4?=
 =?us-ascii?Q?nowOi6q60i7j9JTQJEzYjqXPEbW9jnOJgc2tX/hgli8cvg8OpL2fO8mgYl3b?=
 =?us-ascii?Q?nbalPlXOJyIJF5+b6O14zbdHJvYg4++txgimyVy3mVxrpHILNYTlfYoFwHnB?=
 =?us-ascii?Q?+7gjRai+nqNsoucLK+M/M1ipYSOTniTMbYgeHLcy0aqGF24JCdVtepm9HjEF?=
 =?us-ascii?Q?GQcEOmmWTN+/TtU5kpwq8HdkiOHPMbs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1769ace0-26e5-48e7-a947-08da16d95406
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 07:53:10.3220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hi4ryhMT2zrlmZTp0RA1ZwE5BwVgjNvRCaREatGGctOt8JJwYYxhQfMhy8vrdRNvbuogDoC78MmANOeaVs8Cjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4950

This patchset implements round-robin scheduler using BPF. Address to
some commends for the RFC version:

https://patchwork.kernel.org/project/mptcp/cover/cover.1631011068.git.gelia=
ngtang@xiaomi.com/

deponds on: "BPF packet scheduler v9"

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/75

Geliang Tang (3):
  mptcp: add get_next_subflow helper
  selftests: bpf: add bpf_rr scheduler
  selftests: bpf: add bpf_rr test

 net/mptcp/bpf.c                               | 34 +++++++++++++++
 .../testing/selftests/bpf/bpf_mptcp_helpers.h | 27 ++++++++++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 31 ++++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 42 +++++++++++++++++++
 4 files changed, 134 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

--=20
2.34.1

