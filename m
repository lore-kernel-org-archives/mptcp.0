Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5BD7D
	for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 10:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644573667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tabkX4XqnLOeFp/Y4iX58qGTZzKY4SXhMSBdespS5KU=;
	b=G3j6be34qpmhHBADpbQlD/POuvLtAXQryqlJs1O/JFd4cjQpuDxM3Umf6xPCl06Is17P1r
	xPIoMIP/SpJxWuUBsJS2ALsaNLdxTFtQUfVfIhzvQISfahF/diN8CumKntdIts3l92didH
	OdXWeUdYwAVgB6mggAHnnX86DY+lwmI=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2175.outbound.protection.outlook.com [104.47.17.175]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-In9YEguvPfaa0zSh1-K-fw-1; Fri, 11 Feb 2022 11:01:05 +0100
X-MC-Unique: In9YEguvPfaa0zSh1-K-fw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xm9IXvmWvEs+/sE1XJ0lcd47SkT5/xsmGSdvXmo6xYQadFnJs/MbADuDJvLY2w9r+Q8DhmCX85oTajpWlfN7ARpti+3VotYUzmi5dnzUeFxXsQ9xiUakCaukE5dc+8gA6GkFIqu7q6ghdgSjgohUXMmerAaCVwd4CPXywpa87yw740fmt8Z+t8LJdW/W8wK7D5wG+Usj0FU5BOFAZTd5UJuV+fQpF2XCJukxhhOKH98nOm6gPrJdY+qAA/jzotOhwDmKvlgAauBwEk3W/3ujwSjEuWuo+8xk3wYjAmq9gzefJQe+jN1Kfc0l5d3rztxGeC/tATU8vRQhZXDgXbJDdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tabkX4XqnLOeFp/Y4iX58qGTZzKY4SXhMSBdespS5KU=;
 b=ECSfOCpsuTWUZwTwtt4sK+dqOPqfhLwiiUkJdTKkntCWPtM5uohpsYU7yak+70niOLb3hvxgSL+R/79oqgbPrJXhS5SJhNrFVw1V+aU+y929J6vUQwJMg2DsBbqXH28cOMCGy+pT4nyoMRgc1OsnQoTm7WVggbklfxRxLP+cjC3nPglIb+Bi8f107uHDGv6vPqeQ8ts4S3lrGIKyubg5nimE/C7iL5bGHfekjlRl57Yy2/8cRSTjErTymCj3Mvz4iPhC5u9Nk7eFTNIYgqaXFrXNb7qbwVfbrARBiyQBld0YyS/7QA6y0gD2yBhzaJGKeR5U+unZHo9D20G2ykPK8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB5813.eurprd04.prod.outlook.com (2603:10a6:20b:ab::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.13; Fri, 11 Feb
 2022 10:01:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 10:01:02 +0000
Date: Fri, 11 Feb 2022 18:01:28 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v7 0/7] add mp_fail testcases
Message-ID: <20220211100128.GA17077@dhcp-10-157-36-190>
References: <cover.1644572307.git.geliang.tang@suse.com>
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <cover.1644572307.git.geliang.tang@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2P15301CA0007.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fea8aa9f-21ce-4da9-85c5-08d9ed456840
X-MS-TrafficTypeDiagnostic: AM6PR04MB5813:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB5813CA2EEF3FF047132B0086F8309@AM6PR04MB5813.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MUTFpgmgGQC5kxa+D1mnDdn+N6SOg0gTkMfGLWu9ZEm+jk7X2BbO8A4jlBY6emIJ3yQJ9ZTCKnRBvzm1Cn/w6Q/Fd0z5MS5qqkz0YXuYrlGlWdbUKbGDRSXVoecQ75thrA0njPev/MRU62GIRzEm79n9ox6d8rUjbdgDmziM7srYhOhRYuPiv8x2MvkhF9Vpe/WaQ3Cch5sMA8/pEWo19nkKJ3d/YG8kIuCfKSb4Ca6qmnDDbepxfg0JDKgNnMz/9MjPTjNj4IBUAPpBeElAF7h13kaCuF0icRktXpzX6AEHttdycY0lPFR7h5uDOJ0Qvwh82U55p+y/++pRiMVQYPEXExGL0eDfL3iCXViGm0ImP30qrt9KHsb986GXe8G5VMIsPnNZkUnT4T9/hAYm2bp6aBDWfhlqdk16tCtqdEzw22UiQoLkkBJWjFdkTrzdagSSWVayT1DWRDpfhZw8/KI/Bnx4AuMvkd0oCFHUvi9O2LRrzB66xD/v95V7vVdsw66lrXoAPLzwblZMn9HDK475teEUD3ZSpm/zxfCiT1+hhR9pY3BFO+RwD17C+iFCk9rOliHUuqpiTRdVZ8bSsP4N5gRZKa+LNM44YCXpl2sDUGIaX4XKvrsuWoVhUWQYP7pWe4AiGPTk1u0rCx2kloxowlxmSsB0iTfILHCaj6vWFO6SaAdnxMRY0JCzanfSjdvAxrwQmFGwrMewn8zk2w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(508600001)(316002)(8936002)(38100700002)(66946007)(33656002)(19627235002)(55236004)(66556008)(44144004)(6506007)(6666004)(6916009)(5660300002)(235185007)(6486002)(66476007)(8676002)(33716001)(9686003)(6512007)(2906002)(44832011)(21480400003)(1076003)(86362001)(26005)(186003)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i5hWmucW+mpTSMj8XdRrk01ZVyqkDsrW7xVtW9IHllkAXo7pXprEB2M2ksNP?=
 =?us-ascii?Q?QfIo2++2gOiZMgb1ehxV1VeBH5TjJhULFlNSyLmCOFrw3ZHlH/t/fsBjxx2+?=
 =?us-ascii?Q?n6IWTRwI9D+VZN7IRVHblxK4X9fUZdbfBf3vM/+Toqxq3Q55HbNakwgHCe8v?=
 =?us-ascii?Q?kDkWfwhKaOvKTcqdaHiEBnBBL5EYtlYCqiRRGzllIHq2E66TxDG5lfO3XFgJ?=
 =?us-ascii?Q?eTaF/TnGB3jeMSQoWfokZB7pbbK8xt+kKUg55F1kaPtZuiElq/de2Bxjxjy5?=
 =?us-ascii?Q?AhMFSib3G7K/ll6YaeFnUzcZHCqh27SPcwhw2SeAz5lvE241F9k2tteyxi/3?=
 =?us-ascii?Q?rkpXLq5ohxBqI0q1LYkIiCX9xULmIR6uRrxIzuiXMZTAE0yDM3ZtuvCy3ClK?=
 =?us-ascii?Q?9yKWVd8SvLSO1N6UUHOegam8Rt97up6zR6q2ZX977NRSfrjmoOALsYMR3gnU?=
 =?us-ascii?Q?QdKq1Otl6j1ZBytNAbzhFNvYir3nP0iUZKsaK/SW7CkXCKHtzG9Im5p7YULt?=
 =?us-ascii?Q?s0JbdqjRCmmEyuxvJ//YaWS1OTiHuyQ3PT5XALcwuosBGiYb6qsJO7+U9eWN?=
 =?us-ascii?Q?GUnHzXyc6ND/OtAW2z0uLGavoMAmocKVqHrBSVy6n5cz2V4/dXSyTrQ7qNV9?=
 =?us-ascii?Q?0PBaqBa0+DRxXpv7epbiWtmRf38Fk8dVnzsKkF7Oh3tw0f3+4wrIWjUwenS7?=
 =?us-ascii?Q?c6oGssNIGlexiiCbdSA/hax3Wm7zYVKk9cFbvj+q/ss1pd9YeNYdTKhUCxyF?=
 =?us-ascii?Q?eQIeqF6SufXOUFC7T41BzubbKp7pU3hry8LEBWynw8oqXTEpwWjn2wX46G7F?=
 =?us-ascii?Q?KTqD/5PFYyGjiStDY8ITgJZrfYiB5kKYik7ymqYcYI+jKxvGvkdkuqXzrubx?=
 =?us-ascii?Q?HvJPfh5NJJWuhlE0p+0OFgADDWegNraaiWOMiBlknS4eK/FvG2lerQjQhU2m?=
 =?us-ascii?Q?2CY/yx3+X5f3J5UCgbVbugQ9xJ34vCn6t5Zko3/m79xtmUNiZBV0X/AklV0u?=
 =?us-ascii?Q?xNM0Wr0Rr5lYfS3Md+J+RS5AcRfNyFeALwVcF7YkH4DoaLiWCZwemevAN7EW?=
 =?us-ascii?Q?Yec1QhdodGiNspf7KDpOlY5Oxipln09RPfgGzfGVPj459DRfMVT4eNsicR06?=
 =?us-ascii?Q?NfM42Ei9sYcnKNODqzqJHhoZQOzRw/6Ug2qv6SwG67zCHBjEhVykAD73H4Ze?=
 =?us-ascii?Q?x35yNYC4Ugj2TCZUXTMzHVhbP7NHCRSvEchur8SJxDtc4bg9+b0tfBz9wywF?=
 =?us-ascii?Q?naCxpcK4hGHm/hjGnFKHCfOqiNeI27w+WerXUYiSPr9fy6nXDJgFXLe2NTOb?=
 =?us-ascii?Q?/13bw/812t0MoDdsIUn2deh4cZ/RlkzOv150s7ZkavNEx/hIW1Bb1l6tXQjC?=
 =?us-ascii?Q?4b5w3YKmtVAJmORyCRjGCDRvWnrSfpiAP2b7QjblPD31UuQYCy/NBU80vd1U?=
 =?us-ascii?Q?9dDj6CT3+fZmm8gDnmzdOGGwA7K/50HPZTR4zT074RpBPh0fbWY+sJFzhcx9?=
 =?us-ascii?Q?sfLIVbU6Je8rjSlWylRVYrGy//tmTK1bn+LCC6lH73fHvDwzDc7MTLCw44Kn?=
 =?us-ascii?Q?vh6mQorL3CnyEnXqLRmc2EmgpwAlpLbIHVVhUqQ3FSHk81KLdO9CUPmT1HmM?=
 =?us-ascii?Q?b5UXiBAaKyJG/fQt3sTNUHA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea8aa9f-21ce-4da9-85c5-08d9ed456840
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 10:01:02.0657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fhgE8kKYH/Au4ottafIt74q7qeqNo6ngu2Pl/+6XyUpXDGFvq0ZOPZR3j4wMTFtSSjkXP0TMkHnScIvKcbRdUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5813

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

v7-500-times-loop-test.log is attached.

In it, only one test (344) failed:

344

Created /tmp/tmp.xYePU8reYj (size 1 KB) containing data sent by client
Created /tmp/tmp.zsBmV99HHE (size 1 KB) containing data sent by server
Created /tmp/tmp.9xNm6SuSep (size 1024 KB) containing data sent by client
Created /tmp/tmp.Fyflpaabuj (size 1024 KB) containing data sent by server
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[fail] got 2 data checksum error[s] expected 1
 - csum  [ ok ]
                                         ftx[fail] got 2 MP_FAIL[s] TX expected 1
 - failrx[fail] got 2 MP_FAIL[s] RX expected 1
                                         rtx[fail] got 2 MP_RST[s] TX expected 1
 - rstrx [fail] got 2 MP_RST[s] RX expected 1
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.9xNm6SuSep (size 128 KB) containing data sent by client
Created /tmp/tmp.Fyflpaabuj (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
344 FAILED

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="v7-500-times-loop-test.log"


1

Created /tmp/tmp.pkpDUNPOBQ (size 1 KB) containing data sent by client
Created /tmp/tmp.Xpp6u3MiP6 (size 1 KB) containing data sent by server
Created /tmp/tmp.ej7wgxgYlh (size 1024 KB) containing data sent by client
Created /tmp/tmp.koTlFiYrTj (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ej7wgxgYlh (size 128 KB) containing data sent by client
Created /tmp/tmp.koTlFiYrTj (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

2

Created /tmp/tmp.kJrmL3PpIo (size 1 KB) containing data sent by client
Created /tmp/tmp.YWNQcwVziA (size 1 KB) containing data sent by server
Created /tmp/tmp.z3Yl2y5BWw (size 1024 KB) containing data sent by client
Created /tmp/tmp.yqkH4CuGnf (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.z3Yl2y5BWw (size 128 KB) containing data sent by client
Created /tmp/tmp.yqkH4CuGnf (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

3

Created /tmp/tmp.Suj6lAUloL (size 1 KB) containing data sent by client
Created /tmp/tmp.NqDAsI9WYH (size 1 KB) containing data sent by server
Created /tmp/tmp.RfOGjgsmHJ (size 1024 KB) containing data sent by client
Created /tmp/tmp.YPxSBXDzEx (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.RfOGjgsmHJ (size 128 KB) containing data sent by client
Created /tmp/tmp.YPxSBXDzEx (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

4

Created /tmp/tmp.tRZvE7tiau (size 1 KB) containing data sent by client
Created /tmp/tmp.HAKJdYe1eD (size 1 KB) containing data sent by server
Created /tmp/tmp.qlHw5YmckK (size 1024 KB) containing data sent by client
Created /tmp/tmp.0mvhc4ev3t (size 1024 KB) containing data sent by server
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.qlHw5YmckK (size 128 KB) containing data sent by client
Created /tmp/tmp.0mvhc4ev3t (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

5

Created /tmp/tmp.goh2jGC1ol (size 1 KB) containing data sent by client
Created /tmp/tmp.SDJE2zO3Xm (size 1 KB) containing data sent by server
Created /tmp/tmp.79lh2FOovk (size 1024 KB) containing data sent by client
Created /tmp/tmp.EavxUINvvb (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.79lh2FOovk (size 128 KB) containing data sent by client
Created /tmp/tmp.EavxUINvvb (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

6

Created /tmp/tmp.l1jnjp3v1j (size 1 KB) containing data sent by client
Created /tmp/tmp.Vjzy2ZEz0H (size 1 KB) containing data sent by server
Created /tmp/tmp.eFB3iPrYrE (size 1024 KB) containing data sent by client
Created /tmp/tmp.72DUNNhCHx (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.eFB3iPrYrE (size 128 KB) containing data sent by client
Created /tmp/tmp.72DUNNhCHx (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

7

Created /tmp/tmp.p7RVd301Ky (size 1 KB) containing data sent by client
Created /tmp/tmp.PpqGPjbPS4 (size 1 KB) containing data sent by server
Created /tmp/tmp.eX7GySq2oT (size 1024 KB) containing data sent by client
Created /tmp/tmp.stke5aXuHy (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.eX7GySq2oT (size 128 KB) containing data sent by client
Created /tmp/tmp.stke5aXuHy (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

8

Created /tmp/tmp.YcTfQIhdgM (size 1 KB) containing data sent by client
Created /tmp/tmp.6bkzRSO7gc (size 1 KB) containing data sent by server
Created /tmp/tmp.6ZR1e2C2W6 (size 1024 KB) containing data sent by client
Created /tmp/tmp.rbqKsr04uN (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.6ZR1e2C2W6 (size 128 KB) containing data sent by client
Created /tmp/tmp.rbqKsr04uN (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

9

Created /tmp/tmp.6ecnLSgCrx (size 1 KB) containing data sent by client
Created /tmp/tmp.KC0PM5rnRS (size 1 KB) containing data sent by server
Created /tmp/tmp.6GqqKC8wJZ (size 1024 KB) containing data sent by client
Created /tmp/tmp.BZa27i6J2n (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.6GqqKC8wJZ (size 128 KB) containing data sent by client
Created /tmp/tmp.BZa27i6J2n (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

10

Created /tmp/tmp.qkHWtLiLIn (size 1 KB) containing data sent by client
Created /tmp/tmp.9Wp0xLx010 (size 1 KB) containing data sent by server
Created /tmp/tmp.lkuly72xFN (size 1024 KB) containing data sent by client
Created /tmp/tmp.KHk7RH9TpI (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.lkuly72xFN (size 128 KB) containing data sent by client
Created /tmp/tmp.KHk7RH9TpI (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

11

Created /tmp/tmp.WFOZBHZaLA (size 1 KB) containing data sent by client
Created /tmp/tmp.95DZ8Xj7D0 (size 1 KB) containing data sent by server
Created /tmp/tmp.Qt4Q0FCMmd (size 1024 KB) containing data sent by client
Created /tmp/tmp.buinYLk77O (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Qt4Q0FCMmd (size 128 KB) containing data sent by client
Created /tmp/tmp.buinYLk77O (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

12

Created /tmp/tmp.xXhN67FRum (size 1 KB) containing data sent by client
Created /tmp/tmp.4dP1jpoJPE (size 1 KB) containing data sent by server
Created /tmp/tmp.GuVb4piEQy (size 1024 KB) containing data sent by client
Created /tmp/tmp.jo6ErDSjNL (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.GuVb4piEQy (size 128 KB) containing data sent by client
Created /tmp/tmp.jo6ErDSjNL (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

13

Created /tmp/tmp.oUDlY03zC6 (size 1 KB) containing data sent by client
Created /tmp/tmp.2yAkzpSZ0h (size 1 KB) containing data sent by server
Created /tmp/tmp.T4mCvxnTg0 (size 1024 KB) containing data sent by client
Created /tmp/tmp.z9msoUi2OM (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.T4mCvxnTg0 (size 128 KB) containing data sent by client
Created /tmp/tmp.z9msoUi2OM (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

14

Created /tmp/tmp.fPNDMlL6mG (size 1 KB) containing data sent by client
Created /tmp/tmp.xLSN99Sjzz (size 1 KB) containing data sent by server
Created /tmp/tmp.z5lNKzvh28 (size 1024 KB) containing data sent by client
Created /tmp/tmp.SrDzuUu959 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.z5lNKzvh28 (size 128 KB) containing data sent by client
Created /tmp/tmp.SrDzuUu959 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

15

Created /tmp/tmp.vUh40Ca0rH (size 1 KB) containing data sent by client
Created /tmp/tmp.DuQAqql2is (size 1 KB) containing data sent by server
Created /tmp/tmp.artLsvu6zC (size 1024 KB) containing data sent by client
Created /tmp/tmp.hW75dRj84g (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.artLsvu6zC (size 128 KB) containing data sent by client
Created /tmp/tmp.hW75dRj84g (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

16

Created /tmp/tmp.BqCsadtxl6 (size 1 KB) containing data sent by client
Created /tmp/tmp.bN08DzxdB5 (size 1 KB) containing data sent by server
Created /tmp/tmp.cZTFB5RAZk (size 1024 KB) containing data sent by client
Created /tmp/tmp.cV5yaqBrgy (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.cZTFB5RAZk (size 128 KB) containing data sent by client
Created /tmp/tmp.cV5yaqBrgy (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

17

Created /tmp/tmp.YKNFLKCOzr (size 1 KB) containing data sent by client
Created /tmp/tmp.PowkBi9NIg (size 1 KB) containing data sent by server
Created /tmp/tmp.K1xqGXKDtR (size 1024 KB) containing data sent by client
Created /tmp/tmp.FoFUgrcQ9y (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.K1xqGXKDtR (size 128 KB) containing data sent by client
Created /tmp/tmp.FoFUgrcQ9y (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

18

Created /tmp/tmp.gU3TAmmbYx (size 1 KB) containing data sent by client
Created /tmp/tmp.yMIgxJKgpm (size 1 KB) containing data sent by server
Created /tmp/tmp.yuRb0fsNHe (size 1024 KB) containing data sent by client
Created /tmp/tmp.1SR8jiBJr8 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.yuRb0fsNHe (size 128 KB) containing data sent by client
Created /tmp/tmp.1SR8jiBJr8 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

19

Created /tmp/tmp.uwwOc0A5Zk (size 1 KB) containing data sent by client
Created /tmp/tmp.0Y0xDTXl3u (size 1 KB) containing data sent by server
Created /tmp/tmp.bkgdlTrt6Z (size 1024 KB) containing data sent by client
Created /tmp/tmp.nRGeOi8Spl (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.bkgdlTrt6Z (size 128 KB) containing data sent by client
Created /tmp/tmp.nRGeOi8Spl (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

20

Created /tmp/tmp.0uNZynmaHe (size 1 KB) containing data sent by client
Created /tmp/tmp.JX98Xplnav (size 1 KB) containing data sent by server
Created /tmp/tmp.OvXOgnQszX (size 1024 KB) containing data sent by client
Created /tmp/tmp.QwtkU5IryR (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.OvXOgnQszX (size 128 KB) containing data sent by client
Created /tmp/tmp.QwtkU5IryR (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

21

Created /tmp/tmp.kPsj4EZ9V8 (size 1 KB) containing data sent by client
Created /tmp/tmp.fBH2vU20Ry (size 1 KB) containing data sent by server
Created /tmp/tmp.L7SboamGxu (size 1024 KB) containing data sent by client
Created /tmp/tmp.Esy9uhj4oN (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.L7SboamGxu (size 128 KB) containing data sent by client
Created /tmp/tmp.Esy9uhj4oN (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 3 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

22

Created /tmp/tmp.3lsHFu58s3 (size 1 KB) containing data sent by client
Created /tmp/tmp.DgQxcTq5MV (size 1 KB) containing data sent by server
Created /tmp/tmp.J6BJKbUsSy (size 1024 KB) containing data sent by client
Created /tmp/tmp.ZKcV8Nwr64 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.J6BJKbUsSy (size 128 KB) containing data sent by client
Created /tmp/tmp.ZKcV8Nwr64 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 2 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

23

Created /tmp/tmp.bdFImqlpQn (size 1 KB) containing data sent by client
Created /tmp/tmp.AQTC78FbFw (size 1 KB) containing data sent by server
Created /tmp/tmp.kLzfcJYIjd (size 1024 KB) containing data sent by client
Created /tmp/tmp.TXqytm8zBN (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.kLzfcJYIjd (size 128 KB) containing data sent by client
Created /tmp/tmp.TXqytm8zBN (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

24

Created /tmp/tmp.uRd2IdCscC (size 1 KB) containing data sent by client
Created /tmp/tmp.hJsIylh6wh (size 1 KB) containing data sent by server
Created /tmp/tmp.PwPSewQkDc (size 1024 KB) containing data sent by client
Created /tmp/tmp.YC0HAZfLpb (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.PwPSewQkDc (size 128 KB) containing data sent by client
Created /tmp/tmp.YC0HAZfLpb (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

25

Created /tmp/tmp.jTiksZSS55 (size 1 KB) containing data sent by client
Created /tmp/tmp.p0wraMUkp1 (size 1 KB) containing data sent by server
Created /tmp/tmp.VYiQRLgqEy (size 1024 KB) containing data sent by client
Created /tmp/tmp.nzPL8v4Ukc (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.VYiQRLgqEy (size 128 KB) containing data sent by client
Created /tmp/tmp.nzPL8v4Ukc (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

26

Created /tmp/tmp.KhjMMAORyG (size 1 KB) containing data sent by client
Created /tmp/tmp.JxBmO68lpZ (size 1 KB) containing data sent by server
Created /tmp/tmp.PkRnWkoePd (size 1024 KB) containing data sent by client
Created /tmp/tmp.fvyklKvrfb (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.PkRnWkoePd (size 128 KB) containing data sent by client
Created /tmp/tmp.fvyklKvrfb (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

27

Created /tmp/tmp.TCkWF2BjkU (size 1 KB) containing data sent by client
Created /tmp/tmp.GapB19nE7G (size 1 KB) containing data sent by server
Created /tmp/tmp.csDQOhJQuP (size 1024 KB) containing data sent by client
Created /tmp/tmp.deVWmsfpaJ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71422
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.csDQOhJQuP (size 128 KB) containing data sent by client
Created /tmp/tmp.deVWmsfpaJ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

28

Created /tmp/tmp.gjNw4hRUPa (size 1 KB) containing data sent by client
Created /tmp/tmp.bEjjGyRn8D (size 1 KB) containing data sent by server
Created /tmp/tmp.VKs5pEfXLt (size 1024 KB) containing data sent by client
Created /tmp/tmp.yrCcv1Ug81 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.VKs5pEfXLt (size 128 KB) containing data sent by client
Created /tmp/tmp.yrCcv1Ug81 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

29

Created /tmp/tmp.adck4g6DKc (size 1 KB) containing data sent by client
Created /tmp/tmp.oVW3eSwhT3 (size 1 KB) containing data sent by server
Created /tmp/tmp.voZRgbK0BM (size 1024 KB) containing data sent by client
Created /tmp/tmp.wUcNgF1IFo (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.voZRgbK0BM (size 128 KB) containing data sent by client
Created /tmp/tmp.wUcNgF1IFo (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

30

Created /tmp/tmp.oezZhWfGsv (size 1 KB) containing data sent by client
Created /tmp/tmp.68oyozdfNj (size 1 KB) containing data sent by server
Created /tmp/tmp.qQh1G8jpT3 (size 1024 KB) containing data sent by client
Created /tmp/tmp.AOqOVjH306 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 66594
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.qQh1G8jpT3 (size 128 KB) containing data sent by client
Created /tmp/tmp.AOqOVjH306 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

31

Created /tmp/tmp.50qO6TOtxU (size 1 KB) containing data sent by client
Created /tmp/tmp.eeSmJlpCQ7 (size 1 KB) containing data sent by server
Created /tmp/tmp.jTyS2YDHAW (size 1024 KB) containing data sent by client
Created /tmp/tmp.Dt7lHdnfNJ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.jTyS2YDHAW (size 128 KB) containing data sent by client
Created /tmp/tmp.Dt7lHdnfNJ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

32

Created /tmp/tmp.yr4NryW6pu (size 1 KB) containing data sent by client
Created /tmp/tmp.6AFljhHWVc (size 1 KB) containing data sent by server
Created /tmp/tmp.64DvBsBphi (size 1024 KB) containing data sent by client
Created /tmp/tmp.D4PFjQp1Oy (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.64DvBsBphi (size 128 KB) containing data sent by client
Created /tmp/tmp.D4PFjQp1Oy (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 2 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

33

Created /tmp/tmp.wW3ydeeZ9r (size 1 KB) containing data sent by client
Created /tmp/tmp.WS3pASzJXx (size 1 KB) containing data sent by server
Created /tmp/tmp.sPQ2mRhaNs (size 1024 KB) containing data sent by client
Created /tmp/tmp.ejbPqSZFgk (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.sPQ2mRhaNs (size 128 KB) containing data sent by client
Created /tmp/tmp.ejbPqSZFgk (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 4 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

34

Created /tmp/tmp.xoseL4Pe3a (size 1 KB) containing data sent by client
Created /tmp/tmp.Et5FD9syR1 (size 1 KB) containing data sent by server
Created /tmp/tmp.6HCvXF0Pvd (size 1024 KB) containing data sent by client
Created /tmp/tmp.x2pSSVAIEY (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.6HCvXF0Pvd (size 128 KB) containing data sent by client
Created /tmp/tmp.x2pSSVAIEY (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

35

Created /tmp/tmp.qaN3wIrELI (size 1 KB) containing data sent by client
Created /tmp/tmp.fGN937h7VM (size 1 KB) containing data sent by server
Created /tmp/tmp.60e1alatFQ (size 1024 KB) containing data sent by client
Created /tmp/tmp.dJxLVmmAkY (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.60e1alatFQ (size 128 KB) containing data sent by client
Created /tmp/tmp.dJxLVmmAkY (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

36

Created /tmp/tmp.mMfHUxh9aA (size 1 KB) containing data sent by client
Created /tmp/tmp.KiUAq7bjeL (size 1 KB) containing data sent by server
Created /tmp/tmp.Y25lXugBLQ (size 1024 KB) containing data sent by client
Created /tmp/tmp.s3UCeeBIh7 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Y25lXugBLQ (size 128 KB) containing data sent by client
Created /tmp/tmp.s3UCeeBIh7 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

37

Created /tmp/tmp.2ntKCqXja6 (size 1 KB) containing data sent by client
Created /tmp/tmp.18Pj68LxNX (size 1 KB) containing data sent by server
Created /tmp/tmp.KGXeHYUM2w (size 1024 KB) containing data sent by client
Created /tmp/tmp.NnTTTxbOcU (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.KGXeHYUM2w (size 128 KB) containing data sent by client
Created /tmp/tmp.NnTTTxbOcU (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

38

Created /tmp/tmp.3tHnnNCM9p (size 1 KB) containing data sent by client
Created /tmp/tmp.5xWBjLNwP5 (size 1 KB) containing data sent by server
Created /tmp/tmp.SBr3Qt3OBp (size 1024 KB) containing data sent by client
Created /tmp/tmp.VVKBT5k2RZ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.SBr3Qt3OBp (size 128 KB) containing data sent by client
Created /tmp/tmp.VVKBT5k2RZ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

39

Created /tmp/tmp.N4D46NJnRF (size 1 KB) containing data sent by client
Created /tmp/tmp.s98c1b4v4j (size 1 KB) containing data sent by server
Created /tmp/tmp.jMFnSzAbHZ (size 1024 KB) containing data sent by client
Created /tmp/tmp.eJalxL6Bz1 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.jMFnSzAbHZ (size 128 KB) containing data sent by client
Created /tmp/tmp.eJalxL6Bz1 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

40

Created /tmp/tmp.azlE4EqCA3 (size 1 KB) containing data sent by client
Created /tmp/tmp.nOi6XdWKqW (size 1 KB) containing data sent by server
Created /tmp/tmp.GZlGFZSuwL (size 1024 KB) containing data sent by client
Created /tmp/tmp.yBSDHQ9oxf (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.GZlGFZSuwL (size 128 KB) containing data sent by client
Created /tmp/tmp.yBSDHQ9oxf (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

41

Created /tmp/tmp.MV3uAuvbLq (size 1 KB) containing data sent by client
Created /tmp/tmp.3KF2sfy32V (size 1 KB) containing data sent by server
Created /tmp/tmp.P5Ynft4gQH (size 1024 KB) containing data sent by client
Created /tmp/tmp.VDm8dRCTzA (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.P5Ynft4gQH (size 128 KB) containing data sent by client
Created /tmp/tmp.VDm8dRCTzA (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 2 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

42

Created /tmp/tmp.gELsJ4uRrK (size 1 KB) containing data sent by client
Created /tmp/tmp.Lj0WkiLUbf (size 1 KB) containing data sent by server
Created /tmp/tmp.kGFKyNO3cD (size 1024 KB) containing data sent by client
Created /tmp/tmp.AVtvhhskMm (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.kGFKyNO3cD (size 128 KB) containing data sent by client
Created /tmp/tmp.AVtvhhskMm (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

43

Created /tmp/tmp.s1RmxLVvuh (size 1 KB) containing data sent by client
Created /tmp/tmp.lqB5dncSMA (size 1 KB) containing data sent by server
Created /tmp/tmp.H31ThDalXs (size 1024 KB) containing data sent by client
Created /tmp/tmp.o8uDtLV8fk (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.H31ThDalXs (size 128 KB) containing data sent by client
Created /tmp/tmp.o8uDtLV8fk (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

44

Created /tmp/tmp.OStRPeQp59 (size 1 KB) containing data sent by client
Created /tmp/tmp.fMGFlM0iGE (size 1 KB) containing data sent by server
Created /tmp/tmp.SG7agWlpTc (size 1024 KB) containing data sent by client
Created /tmp/tmp.zZBZSDx6wO (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.SG7agWlpTc (size 128 KB) containing data sent by client
Created /tmp/tmp.zZBZSDx6wO (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

45

Created /tmp/tmp.3v4pQJnYhY (size 1 KB) containing data sent by client
Created /tmp/tmp.1F3GYlPfGb (size 1 KB) containing data sent by server
Created /tmp/tmp.h2hGRg8Stm (size 1024 KB) containing data sent by client
Created /tmp/tmp.NCxZT1JJqz (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.h2hGRg8Stm (size 128 KB) containing data sent by client
Created /tmp/tmp.NCxZT1JJqz (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

46

Created /tmp/tmp.Sutv87sKtF (size 1 KB) containing data sent by client
Created /tmp/tmp.XcwNEbi4d3 (size 1 KB) containing data sent by server
Created /tmp/tmp.gd6yTpBs1A (size 1024 KB) containing data sent by client
Created /tmp/tmp.aOgbATl4GV (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.gd6yTpBs1A (size 128 KB) containing data sent by client
Created /tmp/tmp.aOgbATl4GV (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

47

Created /tmp/tmp.T70lkce1vw (size 1 KB) containing data sent by client
Created /tmp/tmp.4rEhBpJbvo (size 1 KB) containing data sent by server
Created /tmp/tmp.ZSyugJ3Kpq (size 1024 KB) containing data sent by client
Created /tmp/tmp.JK8Zo9iDTm (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ZSyugJ3Kpq (size 128 KB) containing data sent by client
Created /tmp/tmp.JK8Zo9iDTm (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 3 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

48

Created /tmp/tmp.AJaAzCAWlK (size 1 KB) containing data sent by client
Created /tmp/tmp.t5FF1oj1Y8 (size 1 KB) containing data sent by server
Created /tmp/tmp.qBSmgMCW76 (size 1024 KB) containing data sent by client
Created /tmp/tmp.dc14ypdqUq (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.qBSmgMCW76 (size 128 KB) containing data sent by client
Created /tmp/tmp.dc14ypdqUq (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

49

Created /tmp/tmp.iaeiYQ3IVD (size 1 KB) containing data sent by client
Created /tmp/tmp.WXWMDu8IpD (size 1 KB) containing data sent by server
Created /tmp/tmp.HmodB1PMwS (size 1024 KB) containing data sent by client
Created /tmp/tmp.BQcBXIs7aS (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.HmodB1PMwS (size 128 KB) containing data sent by client
Created /tmp/tmp.BQcBXIs7aS (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

50

Created /tmp/tmp.5vO3yvrulY (size 1 KB) containing data sent by client
Created /tmp/tmp.Or7KJQogkH (size 1 KB) containing data sent by server
Created /tmp/tmp.Mi27uw3I8X (size 1024 KB) containing data sent by client
Created /tmp/tmp.FYRyC3a6QI (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Mi27uw3I8X (size 128 KB) containing data sent by client
Created /tmp/tmp.FYRyC3a6QI (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

51

Created /tmp/tmp.qt4HSn558l (size 1 KB) containing data sent by client
Created /tmp/tmp.gg2XEcakj9 (size 1 KB) containing data sent by server
Created /tmp/tmp.eXVS00ZBdK (size 1024 KB) containing data sent by client
Created /tmp/tmp.pdnGHltji7 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.eXVS00ZBdK (size 128 KB) containing data sent by client
Created /tmp/tmp.pdnGHltji7 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

52

Created /tmp/tmp.3UVDiavOLa (size 1 KB) containing data sent by client
Created /tmp/tmp.tB4Fb8aEJo (size 1 KB) containing data sent by server
Created /tmp/tmp.gHrSxQj5rF (size 1024 KB) containing data sent by client
Created /tmp/tmp.dBS5plwUe4 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.gHrSxQj5rF (size 128 KB) containing data sent by client
Created /tmp/tmp.dBS5plwUe4 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 1 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

53

Created /tmp/tmp.R8kpxjkr77 (size 1 KB) containing data sent by client
Created /tmp/tmp.8CyWEB7zrc (size 1 KB) containing data sent by server
Created /tmp/tmp.n1wY2FQBuv (size 1024 KB) containing data sent by client
Created /tmp/tmp.gocXlxNKCF (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.n1wY2FQBuv (size 128 KB) containing data sent by client
Created /tmp/tmp.gocXlxNKCF (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

54

Created /tmp/tmp.BGttN8Z0cE (size 1 KB) containing data sent by client
Created /tmp/tmp.KW5GF9C4VV (size 1 KB) containing data sent by server
Created /tmp/tmp.MPhPclAs8e (size 1024 KB) containing data sent by client
Created /tmp/tmp.NIiaOeAPKa (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.MPhPclAs8e (size 128 KB) containing data sent by client
Created /tmp/tmp.NIiaOeAPKa (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

55

Created /tmp/tmp.ank7A2PMFW (size 1 KB) containing data sent by client
Created /tmp/tmp.NvkZX6YYvw (size 1 KB) containing data sent by server
Created /tmp/tmp.QcUPMAMuGA (size 1024 KB) containing data sent by client
Created /tmp/tmp.EV58WJFglw (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.QcUPMAMuGA (size 128 KB) containing data sent by client
Created /tmp/tmp.EV58WJFglw (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

56

Created /tmp/tmp.iUkfA5oiuO (size 1 KB) containing data sent by client
Created /tmp/tmp.x6tbMQedHi (size 1 KB) containing data sent by server
Created /tmp/tmp.aqL4FEPopH (size 1024 KB) containing data sent by client
Created /tmp/tmp.aDyrIiBc2P (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.aqL4FEPopH (size 128 KB) containing data sent by client
Created /tmp/tmp.aDyrIiBc2P (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

57

Created /tmp/tmp.CaRbjUTzdN (size 1 KB) containing data sent by client
Created /tmp/tmp.FGfIiSTLYV (size 1 KB) containing data sent by server
Created /tmp/tmp.NxrxfWPabf (size 1024 KB) containing data sent by client
Created /tmp/tmp.JyVyW79C0d (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.NxrxfWPabf (size 128 KB) containing data sent by client
Created /tmp/tmp.JyVyW79C0d (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

58

Created /tmp/tmp.LJW6LvhbeE (size 1 KB) containing data sent by client
Created /tmp/tmp.4JwfrAuqNf (size 1 KB) containing data sent by server
Created /tmp/tmp.rmqzyTfduy (size 1024 KB) containing data sent by client
Created /tmp/tmp.hRLjIhaWRH (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.rmqzyTfduy (size 128 KB) containing data sent by client
Created /tmp/tmp.hRLjIhaWRH (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

59

Created /tmp/tmp.fMzthqvniC (size 1 KB) containing data sent by client
Created /tmp/tmp.02fWRugjP6 (size 1 KB) containing data sent by server
Created /tmp/tmp.dJT4RHa44S (size 1024 KB) containing data sent by client
Created /tmp/tmp.k3rBpnB3em (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.dJT4RHa44S (size 128 KB) containing data sent by client
Created /tmp/tmp.k3rBpnB3em (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

60

Created /tmp/tmp.150s23Bvyg (size 1 KB) containing data sent by client
Created /tmp/tmp.TMAbSXIVnl (size 1 KB) containing data sent by server
Created /tmp/tmp.BPLxK20G8n (size 1024 KB) containing data sent by client
Created /tmp/tmp.b6sQcC1zQN (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.BPLxK20G8n (size 128 KB) containing data sent by client
Created /tmp/tmp.b6sQcC1zQN (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

61

Created /tmp/tmp.nOdPmbOJd8 (size 1 KB) containing data sent by client
Created /tmp/tmp.y9z7u0IR3e (size 1 KB) containing data sent by server
Created /tmp/tmp.06qlk4ywvg (size 1024 KB) containing data sent by client
Created /tmp/tmp.zTXJ8tByUw (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.06qlk4ywvg (size 128 KB) containing data sent by client
Created /tmp/tmp.zTXJ8tByUw (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

62

Created /tmp/tmp.bnBAcqPbcq (size 1 KB) containing data sent by client
Created /tmp/tmp.Cp5HLbcUC5 (size 1 KB) containing data sent by server
Created /tmp/tmp.TUpwtogICD (size 1024 KB) containing data sent by client
Created /tmp/tmp.f01ZERFdIQ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.TUpwtogICD (size 128 KB) containing data sent by client
Created /tmp/tmp.f01ZERFdIQ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

63

Created /tmp/tmp.9a0psnE6MF (size 1 KB) containing data sent by client
Created /tmp/tmp.iLQRN1egFn (size 1 KB) containing data sent by server
Created /tmp/tmp.glVSTi2dBR (size 1024 KB) containing data sent by client
Created /tmp/tmp.CsZKLrffpj (size 1024 KB) containing data sent by server
file received by server has inverted byte at 68475
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.glVSTi2dBR (size 128 KB) containing data sent by client
Created /tmp/tmp.CsZKLrffpj (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

64

Created /tmp/tmp.AKS6oD7pIA (size 1 KB) containing data sent by client
Created /tmp/tmp.b3lyE6plaG (size 1 KB) containing data sent by server
Created /tmp/tmp.waqHbg14on (size 1024 KB) containing data sent by client
Created /tmp/tmp.ZICTa2MpX5 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.waqHbg14on (size 128 KB) containing data sent by client
Created /tmp/tmp.ZICTa2MpX5 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

65

Created /tmp/tmp.4x52NAALwR (size 1 KB) containing data sent by client
Created /tmp/tmp.XNnAUBi7V8 (size 1 KB) containing data sent by server
Created /tmp/tmp.Fvdooz9NDY (size 1024 KB) containing data sent by client
Created /tmp/tmp.Zc7QY2k8wL (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Fvdooz9NDY (size 128 KB) containing data sent by client
Created /tmp/tmp.Zc7QY2k8wL (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

66

Created /tmp/tmp.aFguZmG6FN (size 1 KB) containing data sent by client
Created /tmp/tmp.vzMYMtmmtu (size 1 KB) containing data sent by server
Created /tmp/tmp.7I8OCtaUo4 (size 1024 KB) containing data sent by client
Created /tmp/tmp.pVJvvLkBPE (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.7I8OCtaUo4 (size 128 KB) containing data sent by client
Created /tmp/tmp.pVJvvLkBPE (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

67

Created /tmp/tmp.tqixlTwuth (size 1 KB) containing data sent by client
Created /tmp/tmp.pKMDeqhnXV (size 1 KB) containing data sent by server
Created /tmp/tmp.QYCHqKhh7X (size 1024 KB) containing data sent by client
Created /tmp/tmp.a7Oy88IlCz (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.QYCHqKhh7X (size 128 KB) containing data sent by client
Created /tmp/tmp.a7Oy88IlCz (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

68

Created /tmp/tmp.oYyjXsxdN1 (size 1 KB) containing data sent by client
Created /tmp/tmp.YXa0BSVosy (size 1 KB) containing data sent by server
Created /tmp/tmp.frqKKl7JtK (size 1024 KB) containing data sent by client
Created /tmp/tmp.pa3UWsaJxD (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.frqKKl7JtK (size 128 KB) containing data sent by client
Created /tmp/tmp.pa3UWsaJxD (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

69

Created /tmp/tmp.tED8ZS1vrK (size 1 KB) containing data sent by client
Created /tmp/tmp.Gp0riLbjp4 (size 1 KB) containing data sent by server
Created /tmp/tmp.9kMJy6uIlE (size 1024 KB) containing data sent by client
Created /tmp/tmp.ERrlxlqulv (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.9kMJy6uIlE (size 128 KB) containing data sent by client
Created /tmp/tmp.ERrlxlqulv (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

70

Created /tmp/tmp.p3JDEGBWJX (size 1 KB) containing data sent by client
Created /tmp/tmp.fDhS6IPj5U (size 1 KB) containing data sent by server
Created /tmp/tmp.4883v1G2mt (size 1024 KB) containing data sent by client
Created /tmp/tmp.iZiE7Sa8XG (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.4883v1G2mt (size 128 KB) containing data sent by client
Created /tmp/tmp.iZiE7Sa8XG (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

71

Created /tmp/tmp.11wmQ5BT3u (size 1 KB) containing data sent by client
Created /tmp/tmp.ZV08mFBSxO (size 1 KB) containing data sent by server
Created /tmp/tmp.CxCD10XMjA (size 1024 KB) containing data sent by client
Created /tmp/tmp.dcof7XdSdU (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.CxCD10XMjA (size 128 KB) containing data sent by client
Created /tmp/tmp.dcof7XdSdU (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

72

Created /tmp/tmp.l4OgKvoQJj (size 1 KB) containing data sent by client
Created /tmp/tmp.Wh4tGQAPeg (size 1 KB) containing data sent by server
Created /tmp/tmp.unAdEbTgyL (size 1024 KB) containing data sent by client
Created /tmp/tmp.hxZgv0Xr1x (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.unAdEbTgyL (size 128 KB) containing data sent by client
Created /tmp/tmp.hxZgv0Xr1x (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

73

Created /tmp/tmp.oxyPPrODKH (size 1 KB) containing data sent by client
Created /tmp/tmp.Y0c6WpEAWr (size 1 KB) containing data sent by server
Created /tmp/tmp.8sunxXltmx (size 1024 KB) containing data sent by client
Created /tmp/tmp.8fUhKnMMIh (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.8sunxXltmx (size 128 KB) containing data sent by client
Created /tmp/tmp.8fUhKnMMIh (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

74

Created /tmp/tmp.VX6gQekF4b (size 1 KB) containing data sent by client
Created /tmp/tmp.W617dILTtk (size 1 KB) containing data sent by server
Created /tmp/tmp.yZOWbHz4HM (size 1024 KB) containing data sent by client
Created /tmp/tmp.xunQWN5jVS (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.yZOWbHz4HM (size 128 KB) containing data sent by client
Created /tmp/tmp.xunQWN5jVS (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

75

Created /tmp/tmp.LmoLajbZp1 (size 1 KB) containing data sent by client
Created /tmp/tmp.3QIEXHsCDl (size 1 KB) containing data sent by server
Created /tmp/tmp.UjPYAxfJsy (size 1024 KB) containing data sent by client
Created /tmp/tmp.G2OGyfvWhE (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.UjPYAxfJsy (size 128 KB) containing data sent by client
Created /tmp/tmp.G2OGyfvWhE (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

76

Created /tmp/tmp.ZmNpglpoVv (size 1 KB) containing data sent by client
Created /tmp/tmp.Umm8lDvE5Y (size 1 KB) containing data sent by server
Created /tmp/tmp.Sy6R3wkzcF (size 1024 KB) containing data sent by client
Created /tmp/tmp.YSbdTVwds8 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Sy6R3wkzcF (size 128 KB) containing data sent by client
Created /tmp/tmp.YSbdTVwds8 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

77

Created /tmp/tmp.n0XA8z5vQB (size 1 KB) containing data sent by client
Created /tmp/tmp.nGKGnxKG33 (size 1 KB) containing data sent by server
Created /tmp/tmp.iSzH7DpRaw (size 1024 KB) containing data sent by client
Created /tmp/tmp.G09uAKp8yL (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.iSzH7DpRaw (size 128 KB) containing data sent by client
Created /tmp/tmp.G09uAKp8yL (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

78

Created /tmp/tmp.SAfMagLG1W (size 1 KB) containing data sent by client
Created /tmp/tmp.FqkxpVCpFp (size 1 KB) containing data sent by server
Created /tmp/tmp.UcACu6kzkk (size 1024 KB) containing data sent by client
Created /tmp/tmp.pd8swXISSx (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.UcACu6kzkk (size 128 KB) containing data sent by client
Created /tmp/tmp.pd8swXISSx (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

79

Created /tmp/tmp.OqCDQcZlvT (size 1 KB) containing data sent by client
Created /tmp/tmp.RL5TbwSwDM (size 1 KB) containing data sent by server
Created /tmp/tmp.rvR5YtEW0W (size 1024 KB) containing data sent by client
Created /tmp/tmp.bQ1P6DkS5J (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.rvR5YtEW0W (size 128 KB) containing data sent by client
Created /tmp/tmp.bQ1P6DkS5J (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

80

Created /tmp/tmp.RN0XJj67OC (size 1 KB) containing data sent by client
Created /tmp/tmp.SWVBxfiGXH (size 1 KB) containing data sent by server
Created /tmp/tmp.NzGQDV2TAc (size 1024 KB) containing data sent by client
Created /tmp/tmp.O0TVNDdPma (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.NzGQDV2TAc (size 128 KB) containing data sent by client
Created /tmp/tmp.O0TVNDdPma (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

81

Created /tmp/tmp.EBK9kAMEkE (size 1 KB) containing data sent by client
Created /tmp/tmp.BRBwo9zlZY (size 1 KB) containing data sent by server
Created /tmp/tmp.LqqcDXqGWZ (size 1024 KB) containing data sent by client
Created /tmp/tmp.dgYge5CmgQ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.LqqcDXqGWZ (size 128 KB) containing data sent by client
Created /tmp/tmp.dgYge5CmgQ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

82

Created /tmp/tmp.Pafq7LEed9 (size 1 KB) containing data sent by client
Created /tmp/tmp.Ncpc704mQY (size 1 KB) containing data sent by server
Created /tmp/tmp.A4ummNNigS (size 1024 KB) containing data sent by client
Created /tmp/tmp.SM4qYCsQ34 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.A4ummNNigS (size 128 KB) containing data sent by client
Created /tmp/tmp.SM4qYCsQ34 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

83

Created /tmp/tmp.Hmce7dLIzT (size 1 KB) containing data sent by client
Created /tmp/tmp.jPpfMqrpRM (size 1 KB) containing data sent by server
Created /tmp/tmp.hWd5IM1VgJ (size 1024 KB) containing data sent by client
Created /tmp/tmp.OLspfNNDNa (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.hWd5IM1VgJ (size 128 KB) containing data sent by client
Created /tmp/tmp.OLspfNNDNa (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

84

Created /tmp/tmp.g8japUAYQt (size 1 KB) containing data sent by client
Created /tmp/tmp.04u9AzDcUM (size 1 KB) containing data sent by server
Created /tmp/tmp.AflvdCKiL7 (size 1024 KB) containing data sent by client
Created /tmp/tmp.2IPgdEfUTJ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.AflvdCKiL7 (size 128 KB) containing data sent by client
Created /tmp/tmp.2IPgdEfUTJ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

85

Created /tmp/tmp.06KMqTe0Q8 (size 1 KB) containing data sent by client
Created /tmp/tmp.fCrNK7sfKH (size 1 KB) containing data sent by server
Created /tmp/tmp.V6U8A2BfEA (size 1024 KB) containing data sent by client
Created /tmp/tmp.r0cqtVxQzD (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.V6U8A2BfEA (size 128 KB) containing data sent by client
Created /tmp/tmp.r0cqtVxQzD (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

86

Created /tmp/tmp.3lPABzOQeM (size 1 KB) containing data sent by client
Created /tmp/tmp.gGN0XM453y (size 1 KB) containing data sent by server
Created /tmp/tmp.MGM8V8s6SG (size 1024 KB) containing data sent by client
Created /tmp/tmp.ADGSfGkkym (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.MGM8V8s6SG (size 128 KB) containing data sent by client
Created /tmp/tmp.ADGSfGkkym (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

87

Created /tmp/tmp.8rpkuK7Djg (size 1 KB) containing data sent by client
Created /tmp/tmp.9HD8Gm3915 (size 1 KB) containing data sent by server
Created /tmp/tmp.j9kimeoaOw (size 1024 KB) containing data sent by client
Created /tmp/tmp.aFpOaowXQH (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.j9kimeoaOw (size 128 KB) containing data sent by client
Created /tmp/tmp.aFpOaowXQH (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

88

Created /tmp/tmp.1mSFdI1mwE (size 1 KB) containing data sent by client
Created /tmp/tmp.RSIgxzK2ZE (size 1 KB) containing data sent by server
Created /tmp/tmp.MQJnAYQNEG (size 1024 KB) containing data sent by client
Created /tmp/tmp.2pHpPuMtM8 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.MQJnAYQNEG (size 128 KB) containing data sent by client
Created /tmp/tmp.2pHpPuMtM8 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

89

Created /tmp/tmp.yXrIHuIMEL (size 1 KB) containing data sent by client
Created /tmp/tmp.SkUl5cjbUW (size 1 KB) containing data sent by server
Created /tmp/tmp.Uxn06wxBye (size 1024 KB) containing data sent by client
Created /tmp/tmp.cqY6vOcigl (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Uxn06wxBye (size 128 KB) containing data sent by client
Created /tmp/tmp.cqY6vOcigl (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

90

Created /tmp/tmp.oq0tG4G9Oe (size 1 KB) containing data sent by client
Created /tmp/tmp.LPdL3UPF5j (size 1 KB) containing data sent by server
Created /tmp/tmp.B7kofSZz49 (size 1024 KB) containing data sent by client
Created /tmp/tmp.n0rXUaw0A3 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.B7kofSZz49 (size 128 KB) containing data sent by client
Created /tmp/tmp.n0rXUaw0A3 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

91

Created /tmp/tmp.VtCSKdrRu5 (size 1 KB) containing data sent by client
Created /tmp/tmp.QCrZyhKEXF (size 1 KB) containing data sent by server
Created /tmp/tmp.HWR54IaaQ3 (size 1024 KB) containing data sent by client
Created /tmp/tmp.JGvIJR6FkF (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.HWR54IaaQ3 (size 128 KB) containing data sent by client
Created /tmp/tmp.JGvIJR6FkF (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

92

Created /tmp/tmp.bxnVf1E88u (size 1 KB) containing data sent by client
Created /tmp/tmp.bYdiLeZZaz (size 1 KB) containing data sent by server
Created /tmp/tmp.tAAgLf9aS9 (size 1024 KB) containing data sent by client
Created /tmp/tmp.flTV2yFmjx (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.tAAgLf9aS9 (size 128 KB) containing data sent by client
Created /tmp/tmp.flTV2yFmjx (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

93

Created /tmp/tmp.ox9CkyYZ7B (size 1 KB) containing data sent by client
Created /tmp/tmp.MoG1xOcxUE (size 1 KB) containing data sent by server
Created /tmp/tmp.vDMDcPvdDZ (size 1024 KB) containing data sent by client
Created /tmp/tmp.WnrOXwKyk1 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.vDMDcPvdDZ (size 128 KB) containing data sent by client
Created /tmp/tmp.WnrOXwKyk1 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

94

Created /tmp/tmp.veUenQQ7m0 (size 1 KB) containing data sent by client
Created /tmp/tmp.qXZcYKdt2t (size 1 KB) containing data sent by server
Created /tmp/tmp.RRsGE4C6Ew (size 1024 KB) containing data sent by client
Created /tmp/tmp.2cDZW4cHa2 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 66825
001 MP_FAIL MP_RST: 3 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.RRsGE4C6Ew (size 128 KB) containing data sent by client
Created /tmp/tmp.2cDZW4cHa2 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 2 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

95

Created /tmp/tmp.zuHJkTf6yk (size 1 KB) containing data sent by client
Created /tmp/tmp.mCyWfTkmox (size 1 KB) containing data sent by server
Created /tmp/tmp.roQJaf1EdI (size 1024 KB) containing data sent by client
Created /tmp/tmp.6OLmRNFHNd (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.roQJaf1EdI (size 128 KB) containing data sent by client
Created /tmp/tmp.6OLmRNFHNd (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

96

Created /tmp/tmp.kHNrmPIeqA (size 1 KB) containing data sent by client
Created /tmp/tmp.USyM2WXWke (size 1 KB) containing data sent by server
Created /tmp/tmp.2BF3JYQ4KM (size 1024 KB) containing data sent by client
Created /tmp/tmp.xl5bzDKaih (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.2BF3JYQ4KM (size 128 KB) containing data sent by client
Created /tmp/tmp.xl5bzDKaih (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

97

Created /tmp/tmp.C2pKZrJD8D (size 1 KB) containing data sent by client
Created /tmp/tmp.QTqm5QucZP (size 1 KB) containing data sent by server
Created /tmp/tmp.xmPnqnR2cK (size 1024 KB) containing data sent by client
Created /tmp/tmp.fa45ZONpDj (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.xmPnqnR2cK (size 128 KB) containing data sent by client
Created /tmp/tmp.fa45ZONpDj (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

98

Created /tmp/tmp.sF6lQJblQd (size 1 KB) containing data sent by client
Created /tmp/tmp.ncjaoffcxR (size 1 KB) containing data sent by server
Created /tmp/tmp.i2twbDnMUR (size 1024 KB) containing data sent by client
Created /tmp/tmp.OryS4lN7lE (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.i2twbDnMUR (size 128 KB) containing data sent by client
Created /tmp/tmp.OryS4lN7lE (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

99

Created /tmp/tmp.PN6tga24AL (size 1 KB) containing data sent by client
Created /tmp/tmp.E8fQyzjWid (size 1 KB) containing data sent by server
Created /tmp/tmp.PcLtJvQzzH (size 1024 KB) containing data sent by client
Created /tmp/tmp.uA3fTtXpzT (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.PcLtJvQzzH (size 128 KB) containing data sent by client
Created /tmp/tmp.uA3fTtXpzT (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

100

Created /tmp/tmp.BLgNQpncJ2 (size 1 KB) containing data sent by client
Created /tmp/tmp.VF8XAGEs0y (size 1 KB) containing data sent by server
Created /tmp/tmp.ofzNQJKd8o (size 1024 KB) containing data sent by client
Created /tmp/tmp.6Whg6ZJVUk (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ofzNQJKd8o (size 128 KB) containing data sent by client
Created /tmp/tmp.6Whg6ZJVUk (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

101

Created /tmp/tmp.ziWYRF5Ohr (size 1 KB) containing data sent by client
Created /tmp/tmp.eh2R6LMBUj (size 1 KB) containing data sent by server
Created /tmp/tmp.QXviz5JDlv (size 1024 KB) containing data sent by client
Created /tmp/tmp.iUyey7nCQw (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.QXviz5JDlv (size 128 KB) containing data sent by client
Created /tmp/tmp.iUyey7nCQw (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

102

Created /tmp/tmp.wO60QFfuwk (size 1 KB) containing data sent by client
Created /tmp/tmp.4Mh0SkMHfH (size 1 KB) containing data sent by server
Created /tmp/tmp.rXqACliYVl (size 1024 KB) containing data sent by client
Created /tmp/tmp.E4WcNBdiAl (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.rXqACliYVl (size 128 KB) containing data sent by client
Created /tmp/tmp.E4WcNBdiAl (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

103

Created /tmp/tmp.NdAMQlwY4m (size 1 KB) containing data sent by client
Created /tmp/tmp.s8xsYJLwPy (size 1 KB) containing data sent by server
Created /tmp/tmp.4rkbslFWvC (size 1024 KB) containing data sent by client
Created /tmp/tmp.hIr1qhsPS6 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 66920
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.4rkbslFWvC (size 128 KB) containing data sent by client
Created /tmp/tmp.hIr1qhsPS6 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

104

Created /tmp/tmp.Pvw1kr7egp (size 1 KB) containing data sent by client
Created /tmp/tmp.6zMyhvPn0n (size 1 KB) containing data sent by server
Created /tmp/tmp.44r9ysKdlc (size 1024 KB) containing data sent by client
Created /tmp/tmp.ggGuH5SreH (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.44r9ysKdlc (size 128 KB) containing data sent by client
Created /tmp/tmp.ggGuH5SreH (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

105

Created /tmp/tmp.aDdZGgr6LI (size 1 KB) containing data sent by client
Created /tmp/tmp.vxS9auxDvr (size 1 KB) containing data sent by server
Created /tmp/tmp.Z2aQGeeisz (size 1024 KB) containing data sent by client
Created /tmp/tmp.gNfHxXlqEy (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Z2aQGeeisz (size 128 KB) containing data sent by client
Created /tmp/tmp.gNfHxXlqEy (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

106

Created /tmp/tmp.moG90kbLiJ (size 1 KB) containing data sent by client
Created /tmp/tmp.jY2h8sCYhK (size 1 KB) containing data sent by server
Created /tmp/tmp.1wJ8jtFyDC (size 1024 KB) containing data sent by client
Created /tmp/tmp.sFz4RHIzGA (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.1wJ8jtFyDC (size 128 KB) containing data sent by client
Created /tmp/tmp.sFz4RHIzGA (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

107

Created /tmp/tmp.ubzl9UvN3Q (size 1 KB) containing data sent by client
Created /tmp/tmp.OBGeI20Fi0 (size 1 KB) containing data sent by server
Created /tmp/tmp.qEtgUYKYDz (size 1024 KB) containing data sent by client
Created /tmp/tmp.Vaafz8OIKl (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.qEtgUYKYDz (size 128 KB) containing data sent by client
Created /tmp/tmp.Vaafz8OIKl (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

108

Created /tmp/tmp.wUDkKWqWNn (size 1 KB) containing data sent by client
Created /tmp/tmp.JsjLa9VXCq (size 1 KB) containing data sent by server
Created /tmp/tmp.mt65o4qi3C (size 1024 KB) containing data sent by client
Created /tmp/tmp.ntjvswtxY9 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.mt65o4qi3C (size 128 KB) containing data sent by client
Created /tmp/tmp.ntjvswtxY9 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

109

Created /tmp/tmp.QyQ7ntvDUF (size 1 KB) containing data sent by client
Created /tmp/tmp.LFgdHvTBr4 (size 1 KB) containing data sent by server
Created /tmp/tmp.phjCN1h9U4 (size 1024 KB) containing data sent by client
Created /tmp/tmp.plDzlsnSgM (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.phjCN1h9U4 (size 128 KB) containing data sent by client
Created /tmp/tmp.plDzlsnSgM (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

110

Created /tmp/tmp.8GjSfsrtdd (size 1 KB) containing data sent by client
Created /tmp/tmp.rvNQzXuPKZ (size 1 KB) containing data sent by server
Created /tmp/tmp.SeCDn9H8Cq (size 1024 KB) containing data sent by client
Created /tmp/tmp.2QoPdcK6Hp (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.SeCDn9H8Cq (size 128 KB) containing data sent by client
Created /tmp/tmp.2QoPdcK6Hp (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

111

Created /tmp/tmp.w04gJXiBdS (size 1 KB) containing data sent by client
Created /tmp/tmp.RIpmoXeOHo (size 1 KB) containing data sent by server
Created /tmp/tmp.1ftDNoQOB8 (size 1024 KB) containing data sent by client
Created /tmp/tmp.PMaGcFXxVH (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.1ftDNoQOB8 (size 128 KB) containing data sent by client
Created /tmp/tmp.PMaGcFXxVH (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

112

Created /tmp/tmp.eZJB6hNUaf (size 1 KB) containing data sent by client
Created /tmp/tmp.dvs3YZzWIJ (size 1 KB) containing data sent by server
Created /tmp/tmp.44UpTMgiL7 (size 1024 KB) containing data sent by client
Created /tmp/tmp.UjvXUjUFn4 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.44UpTMgiL7 (size 128 KB) containing data sent by client
Created /tmp/tmp.UjvXUjUFn4 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 1 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

113

Created /tmp/tmp.KroXruy5Eh (size 1 KB) containing data sent by client
Created /tmp/tmp.hc6MK1ciiX (size 1 KB) containing data sent by server
Created /tmp/tmp.huwVjUAH8Z (size 1024 KB) containing data sent by client
Created /tmp/tmp.DNdnHddEWd (size 1024 KB) containing data sent by server
file received by server has inverted byte at 70225
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.huwVjUAH8Z (size 128 KB) containing data sent by client
Created /tmp/tmp.DNdnHddEWd (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

114

Created /tmp/tmp.gMN7ngvvSb (size 1 KB) containing data sent by client
Created /tmp/tmp.wQSfn9dXh6 (size 1 KB) containing data sent by server
Created /tmp/tmp.9vZzgfO6aN (size 1024 KB) containing data sent by client
Created /tmp/tmp.ea9P3RGKZd (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.9vZzgfO6aN (size 128 KB) containing data sent by client
Created /tmp/tmp.ea9P3RGKZd (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

115

Created /tmp/tmp.jBqQB1jr3j (size 1 KB) containing data sent by client
Created /tmp/tmp.PrCCgDRDVt (size 1 KB) containing data sent by server
Created /tmp/tmp.qk8xVS4qQ0 (size 1024 KB) containing data sent by client
Created /tmp/tmp.8lQ4guxsaW (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.qk8xVS4qQ0 (size 128 KB) containing data sent by client
Created /tmp/tmp.8lQ4guxsaW (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

116

Created /tmp/tmp.7BF5855FRQ (size 1 KB) containing data sent by client
Created /tmp/tmp.lUkDR5QqJp (size 1 KB) containing data sent by server
Created /tmp/tmp.cY3MOcc8s5 (size 1024 KB) containing data sent by client
Created /tmp/tmp.uMQEx4pg6n (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.cY3MOcc8s5 (size 128 KB) containing data sent by client
Created /tmp/tmp.uMQEx4pg6n (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

117

Created /tmp/tmp.HckH4YtBos (size 1 KB) containing data sent by client
Created /tmp/tmp.xUZjBsjMRG (size 1 KB) containing data sent by server
Created /tmp/tmp.TLmAyodiiJ (size 1024 KB) containing data sent by client
Created /tmp/tmp.vdqq93Ckvk (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.TLmAyodiiJ (size 128 KB) containing data sent by client
Created /tmp/tmp.vdqq93Ckvk (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

118

Created /tmp/tmp.lRJbRAdmoC (size 1 KB) containing data sent by client
Created /tmp/tmp.rGXZDFjgxx (size 1 KB) containing data sent by server
Created /tmp/tmp.jtqoYMWLdj (size 1024 KB) containing data sent by client
Created /tmp/tmp.5P6rvcSSSf (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.jtqoYMWLdj (size 128 KB) containing data sent by client
Created /tmp/tmp.5P6rvcSSSf (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

119

Created /tmp/tmp.rxqnHPQpbA (size 1 KB) containing data sent by client
Created /tmp/tmp.Y8FbcAIHbk (size 1 KB) containing data sent by server
Created /tmp/tmp.Tn360KJIY2 (size 1024 KB) containing data sent by client
Created /tmp/tmp.7yJUbJTIAo (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Tn360KJIY2 (size 128 KB) containing data sent by client
Created /tmp/tmp.7yJUbJTIAo (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

120

Created /tmp/tmp.dB21AlUxSx (size 1 KB) containing data sent by client
Created /tmp/tmp.iKdGR4XaIu (size 1 KB) containing data sent by server
Created /tmp/tmp.1N28MIvMlD (size 1024 KB) containing data sent by client
Created /tmp/tmp.yTIeYU8D28 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.1N28MIvMlD (size 128 KB) containing data sent by client
Created /tmp/tmp.yTIeYU8D28 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

121

Created /tmp/tmp.h8JE3vRrQR (size 1 KB) containing data sent by client
Created /tmp/tmp.2M68ctggu9 (size 1 KB) containing data sent by server
Created /tmp/tmp.9Tqs7KvOnf (size 1024 KB) containing data sent by client
Created /tmp/tmp.hjYU0PP2Ae (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.9Tqs7KvOnf (size 128 KB) containing data sent by client
Created /tmp/tmp.hjYU0PP2Ae (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

122

Created /tmp/tmp.xfQnm8KJ5f (size 1 KB) containing data sent by client
Created /tmp/tmp.VjefyyWfHq (size 1 KB) containing data sent by server
Created /tmp/tmp.dTZ7KRoqZU (size 1024 KB) containing data sent by client
Created /tmp/tmp.yz6vHMMNDm (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.dTZ7KRoqZU (size 128 KB) containing data sent by client
Created /tmp/tmp.yz6vHMMNDm (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

123

Created /tmp/tmp.iozuACvv1p (size 1 KB) containing data sent by client
Created /tmp/tmp.tuzH3d3Zcp (size 1 KB) containing data sent by server
Created /tmp/tmp.7pKVtrG9O7 (size 1024 KB) containing data sent by client
Created /tmp/tmp.NLBOBJn2A6 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.7pKVtrG9O7 (size 128 KB) containing data sent by client
Created /tmp/tmp.NLBOBJn2A6 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

124

Created /tmp/tmp.vbLbB0WgiU (size 1 KB) containing data sent by client
Created /tmp/tmp.pJN7pe48wd (size 1 KB) containing data sent by server
Created /tmp/tmp.ou4K0bwWiL (size 1024 KB) containing data sent by client
Created /tmp/tmp.oiAqyQ5S1I (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ou4K0bwWiL (size 128 KB) containing data sent by client
Created /tmp/tmp.oiAqyQ5S1I (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

125

Created /tmp/tmp.dNWJD8L3M5 (size 1 KB) containing data sent by client
Created /tmp/tmp.P71ZHodfY3 (size 1 KB) containing data sent by server
Created /tmp/tmp.qyrwFn89Uc (size 1024 KB) containing data sent by client
Created /tmp/tmp.D2ZFjVHA0D (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.qyrwFn89Uc (size 128 KB) containing data sent by client
Created /tmp/tmp.D2ZFjVHA0D (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

126

Created /tmp/tmp.i2UBkrZXYx (size 1 KB) containing data sent by client
Created /tmp/tmp.E18QIPin5z (size 1 KB) containing data sent by server
Created /tmp/tmp.xyHAEgXveA (size 1024 KB) containing data sent by client
Created /tmp/tmp.WuvQADTYcS (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.xyHAEgXveA (size 128 KB) containing data sent by client
Created /tmp/tmp.WuvQADTYcS (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

127

Created /tmp/tmp.G1vQ8QNDWJ (size 1 KB) containing data sent by client
Created /tmp/tmp.8Wj0Eu6i3O (size 1 KB) containing data sent by server
Created /tmp/tmp.Zt172FuFfS (size 1024 KB) containing data sent by client
Created /tmp/tmp.g34Hw7QKhT (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Zt172FuFfS (size 128 KB) containing data sent by client
Created /tmp/tmp.g34Hw7QKhT (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

128

Created /tmp/tmp.wZUsLDEx50 (size 1 KB) containing data sent by client
Created /tmp/tmp.S3nX5Ghoea (size 1 KB) containing data sent by server
Created /tmp/tmp.dtUU6Dcl2W (size 1024 KB) containing data sent by client
Created /tmp/tmp.BTmT1huY5i (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.dtUU6Dcl2W (size 128 KB) containing data sent by client
Created /tmp/tmp.BTmT1huY5i (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

129

Created /tmp/tmp.6o46KtjoDd (size 1 KB) containing data sent by client
Created /tmp/tmp.ZD41fe8ymi (size 1 KB) containing data sent by server
Created /tmp/tmp.Qkl1lHNVVA (size 1024 KB) containing data sent by client
Created /tmp/tmp.PGPHRS8jZQ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Qkl1lHNVVA (size 128 KB) containing data sent by client
Created /tmp/tmp.PGPHRS8jZQ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

130

Created /tmp/tmp.Phpr0nDmWn (size 1 KB) containing data sent by client
Created /tmp/tmp.wCvmFnkciV (size 1 KB) containing data sent by server
Created /tmp/tmp.dZU0yKRZgR (size 1024 KB) containing data sent by client
Created /tmp/tmp.gFo1JiHvn8 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.dZU0yKRZgR (size 128 KB) containing data sent by client
Created /tmp/tmp.gFo1JiHvn8 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

131

Created /tmp/tmp.7MbjQHChbJ (size 1 KB) containing data sent by client
Created /tmp/tmp.8Q73JLoQeD (size 1 KB) containing data sent by server
Created /tmp/tmp.4jncjyDBQ6 (size 1024 KB) containing data sent by client
Created /tmp/tmp.yj6nzjAkR6 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.4jncjyDBQ6 (size 128 KB) containing data sent by client
Created /tmp/tmp.yj6nzjAkR6 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

132

Created /tmp/tmp.srmSq5OYfM (size 1 KB) containing data sent by client
Created /tmp/tmp.iFv3xPO3i0 (size 1 KB) containing data sent by server
Created /tmp/tmp.a8iCRGXY6S (size 1024 KB) containing data sent by client
Created /tmp/tmp.BiQtW4cc0r (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.a8iCRGXY6S (size 128 KB) containing data sent by client
Created /tmp/tmp.BiQtW4cc0r (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

133

Created /tmp/tmp.eAWmaQMAnJ (size 1 KB) containing data sent by client
Created /tmp/tmp.1331doqqFL (size 1 KB) containing data sent by server
Created /tmp/tmp.XXrzm4tILy (size 1024 KB) containing data sent by client
Created /tmp/tmp.KExdBhnWuf (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.XXrzm4tILy (size 128 KB) containing data sent by client
Created /tmp/tmp.KExdBhnWuf (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

134

Created /tmp/tmp.Drl6Jk9fUl (size 1 KB) containing data sent by client
Created /tmp/tmp.en7ZYKnhWx (size 1 KB) containing data sent by server
Created /tmp/tmp.R7gH1pPSDT (size 1024 KB) containing data sent by client
Created /tmp/tmp.e5P2GQ0h32 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.R7gH1pPSDT (size 128 KB) containing data sent by client
Created /tmp/tmp.e5P2GQ0h32 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

135

Created /tmp/tmp.zdGJ0i0wVS (size 1 KB) containing data sent by client
Created /tmp/tmp.gwCsvFPvj1 (size 1 KB) containing data sent by server
Created /tmp/tmp.w6OXuP0QRk (size 1024 KB) containing data sent by client
Created /tmp/tmp.ugeBJcGDw0 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.w6OXuP0QRk (size 128 KB) containing data sent by client
Created /tmp/tmp.ugeBJcGDw0 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

136

Created /tmp/tmp.wFA5N77xFy (size 1 KB) containing data sent by client
Created /tmp/tmp.obNXHM7yaB (size 1 KB) containing data sent by server
Created /tmp/tmp.8SGh8OZzSZ (size 1024 KB) containing data sent by client
Created /tmp/tmp.NmQ2bHU0r0 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.8SGh8OZzSZ (size 128 KB) containing data sent by client
Created /tmp/tmp.NmQ2bHU0r0 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

137

Created /tmp/tmp.EKcY2YSMTN (size 1 KB) containing data sent by client
Created /tmp/tmp.KNMB8Y3fTd (size 1 KB) containing data sent by server
Created /tmp/tmp.rVVcEflYFv (size 1024 KB) containing data sent by client
Created /tmp/tmp.A6FX9Vk22G (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.rVVcEflYFv (size 128 KB) containing data sent by client
Created /tmp/tmp.A6FX9Vk22G (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

138

Created /tmp/tmp.3czJHn5aUC (size 1 KB) containing data sent by client
Created /tmp/tmp.aDOGVwsUxN (size 1 KB) containing data sent by server
Created /tmp/tmp.294Uy8mWvC (size 1024 KB) containing data sent by client
Created /tmp/tmp.EHKV8PvbJr (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.294Uy8mWvC (size 128 KB) containing data sent by client
Created /tmp/tmp.EHKV8PvbJr (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

139

Created /tmp/tmp.gDp5usJzRl (size 1 KB) containing data sent by client
Created /tmp/tmp.ZcWfFes2k0 (size 1 KB) containing data sent by server
Created /tmp/tmp.DEwrjJgBsC (size 1024 KB) containing data sent by client
Created /tmp/tmp.w1MvdNraDo (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.DEwrjJgBsC (size 128 KB) containing data sent by client
Created /tmp/tmp.w1MvdNraDo (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

140

Created /tmp/tmp.KzYNMGg6Yi (size 1 KB) containing data sent by client
Created /tmp/tmp.jBDo1OeyKP (size 1 KB) containing data sent by server
Created /tmp/tmp.QvkIgHZtbu (size 1024 KB) containing data sent by client
Created /tmp/tmp.Npq42BA6Kc (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.QvkIgHZtbu (size 128 KB) containing data sent by client
Created /tmp/tmp.Npq42BA6Kc (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

141

Created /tmp/tmp.kKrsmtZ1zm (size 1 KB) containing data sent by client
Created /tmp/tmp.BbR5JN5sQx (size 1 KB) containing data sent by server
Created /tmp/tmp.Ly50tpcxCr (size 1024 KB) containing data sent by client
Created /tmp/tmp.3gzr85tYBp (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Ly50tpcxCr (size 128 KB) containing data sent by client
Created /tmp/tmp.3gzr85tYBp (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 1 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

142

Created /tmp/tmp.4zHT9pb10s (size 1 KB) containing data sent by client
Created /tmp/tmp.PxjO7hKkHH (size 1 KB) containing data sent by server
Created /tmp/tmp.oTbqrGCUBj (size 1024 KB) containing data sent by client
Created /tmp/tmp.xUBdsPPEcb (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.oTbqrGCUBj (size 128 KB) containing data sent by client
Created /tmp/tmp.xUBdsPPEcb (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

143

Created /tmp/tmp.9empUG6Uyn (size 1 KB) containing data sent by client
Created /tmp/tmp.c5hdBAyqFw (size 1 KB) containing data sent by server
Created /tmp/tmp.m6t0Fjb1kD (size 1024 KB) containing data sent by client
Created /tmp/tmp.pWeQdcfxbo (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.m6t0Fjb1kD (size 128 KB) containing data sent by client
Created /tmp/tmp.pWeQdcfxbo (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

144

Created /tmp/tmp.dsGIpILaue (size 1 KB) containing data sent by client
Created /tmp/tmp.KG3TboVZuO (size 1 KB) containing data sent by server
Created /tmp/tmp.ePSRZAjYoq (size 1024 KB) containing data sent by client
Created /tmp/tmp.LDivocZxI2 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ePSRZAjYoq (size 128 KB) containing data sent by client
Created /tmp/tmp.LDivocZxI2 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

145

Created /tmp/tmp.FzSkFNaEbL (size 1 KB) containing data sent by client
Created /tmp/tmp.n6SpTGuoUy (size 1 KB) containing data sent by server
Created /tmp/tmp.I5YUyMn2NC (size 1024 KB) containing data sent by client
Created /tmp/tmp.uzgBnyBFEG (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.I5YUyMn2NC (size 128 KB) containing data sent by client
Created /tmp/tmp.uzgBnyBFEG (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

146

Created /tmp/tmp.2krDZCx0hy (size 1 KB) containing data sent by client
Created /tmp/tmp.jE1vThAgz1 (size 1 KB) containing data sent by server
Created /tmp/tmp.nkbYJhoBfm (size 1024 KB) containing data sent by client
Created /tmp/tmp.1yDUxfrQw1 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 66882
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.nkbYJhoBfm (size 128 KB) containing data sent by client
Created /tmp/tmp.1yDUxfrQw1 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

147

Created /tmp/tmp.SGaTVKYSIs (size 1 KB) containing data sent by client
Created /tmp/tmp.fgs0q8HyXE (size 1 KB) containing data sent by server
Created /tmp/tmp.Qpyond81ke (size 1024 KB) containing data sent by client
Created /tmp/tmp.IqwTmU2VXw (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Qpyond81ke (size 128 KB) containing data sent by client
Created /tmp/tmp.IqwTmU2VXw (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

148

Created /tmp/tmp.7MVTfKiKgc (size 1 KB) containing data sent by client
Created /tmp/tmp.nsp35veNh9 (size 1 KB) containing data sent by server
Created /tmp/tmp.YD19ONn71C (size 1024 KB) containing data sent by client
Created /tmp/tmp.WL9cYO2Du1 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 69874
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.YD19ONn71C (size 128 KB) containing data sent by client
Created /tmp/tmp.WL9cYO2Du1 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 3 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

149

Created /tmp/tmp.s8TMZcPerx (size 1 KB) containing data sent by client
Created /tmp/tmp.6RsaWe3D1c (size 1 KB) containing data sent by server
Created /tmp/tmp.9mGoocJXuY (size 1024 KB) containing data sent by client
Created /tmp/tmp.29jFAoY6sw (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.9mGoocJXuY (size 128 KB) containing data sent by client
Created /tmp/tmp.29jFAoY6sw (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 2 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

150

Created /tmp/tmp.VIgwIuMItY (size 1 KB) containing data sent by client
Created /tmp/tmp.jn8rR0L10s (size 1 KB) containing data sent by server
Created /tmp/tmp.gzCHUwIJEt (size 1024 KB) containing data sent by client
Created /tmp/tmp.cJeVSDPNWS (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.gzCHUwIJEt (size 128 KB) containing data sent by client
Created /tmp/tmp.cJeVSDPNWS (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

151

Created /tmp/tmp.qiJPb3fWV7 (size 1 KB) containing data sent by client
Created /tmp/tmp.u5hfAXfVvY (size 1 KB) containing data sent by server
Created /tmp/tmp.WsM8uWT0HX (size 1024 KB) containing data sent by client
Created /tmp/tmp.UONCyvE08g (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.WsM8uWT0HX (size 128 KB) containing data sent by client
Created /tmp/tmp.UONCyvE08g (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

152

Created /tmp/tmp.9CwvW8l3Le (size 1 KB) containing data sent by client
Created /tmp/tmp.YnnGeVTxDh (size 1 KB) containing data sent by server
Created /tmp/tmp.yjS1FgW07A (size 1024 KB) containing data sent by client
Created /tmp/tmp.ntiRJ47JPg (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 3 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.yjS1FgW07A (size 128 KB) containing data sent by client
Created /tmp/tmp.ntiRJ47JPg (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

153

Created /tmp/tmp.0duuissmVj (size 1 KB) containing data sent by client
Created /tmp/tmp.HPN7z6DGnX (size 1 KB) containing data sent by server
Created /tmp/tmp.NomaaChBsv (size 1024 KB) containing data sent by client
Created /tmp/tmp.QRc3Lk11ov (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.NomaaChBsv (size 128 KB) containing data sent by client
Created /tmp/tmp.QRc3Lk11ov (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

154

Created /tmp/tmp.BWi4nvHiTs (size 1 KB) containing data sent by client
Created /tmp/tmp.GIigMXcCEJ (size 1 KB) containing data sent by server
Created /tmp/tmp.PMKmwxqeNj (size 1024 KB) containing data sent by client
Created /tmp/tmp.jrLVpPaF3R (size 1024 KB) containing data sent by server
file received by server has inverted byte at 66208
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.PMKmwxqeNj (size 128 KB) containing data sent by client
Created /tmp/tmp.jrLVpPaF3R (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

155

Created /tmp/tmp.dax00fyisi (size 1 KB) containing data sent by client
Created /tmp/tmp.bLQn0dI9vI (size 1 KB) containing data sent by server
Created /tmp/tmp.17lPaGKPP9 (size 1024 KB) containing data sent by client
Created /tmp/tmp.njeaH39rZG (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.17lPaGKPP9 (size 128 KB) containing data sent by client
Created /tmp/tmp.njeaH39rZG (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

156

Created /tmp/tmp.HxeAeNrrSc (size 1 KB) containing data sent by client
Created /tmp/tmp.oVGre6h2Tz (size 1 KB) containing data sent by server
Created /tmp/tmp.xzigdc5HJ3 (size 1024 KB) containing data sent by client
Created /tmp/tmp.o2FIU4JhIS (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.xzigdc5HJ3 (size 128 KB) containing data sent by client
Created /tmp/tmp.o2FIU4JhIS (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

157

Created /tmp/tmp.uhnjiJ9hBN (size 1 KB) containing data sent by client
Created /tmp/tmp.6uhvmpSUTz (size 1 KB) containing data sent by server
Created /tmp/tmp.PdZp5B7LHd (size 1024 KB) containing data sent by client
Created /tmp/tmp.i82wqUiarM (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.PdZp5B7LHd (size 128 KB) containing data sent by client
Created /tmp/tmp.i82wqUiarM (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

158

Created /tmp/tmp.eH5N5ybQOu (size 1 KB) containing data sent by client
Created /tmp/tmp.UFLVcWZd3I (size 1 KB) containing data sent by server
Created /tmp/tmp.FqVyRJ9TIb (size 1024 KB) containing data sent by client
Created /tmp/tmp.XAYvfphXlG (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.FqVyRJ9TIb (size 128 KB) containing data sent by client
Created /tmp/tmp.XAYvfphXlG (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

159

Created /tmp/tmp.9kbN1nsXPn (size 1 KB) containing data sent by client
Created /tmp/tmp.Jf0eSv9y2Z (size 1 KB) containing data sent by server
Created /tmp/tmp.RNFWZVXq4s (size 1024 KB) containing data sent by client
Created /tmp/tmp.tVWAee6hhv (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.RNFWZVXq4s (size 128 KB) containing data sent by client
Created /tmp/tmp.tVWAee6hhv (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

160

Created /tmp/tmp.XAJ7rx0f7d (size 1 KB) containing data sent by client
Created /tmp/tmp.0yT5dAX23m (size 1 KB) containing data sent by server
Created /tmp/tmp.GRTvpASGwo (size 1024 KB) containing data sent by client
Created /tmp/tmp.3FtuJTY2T7 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 66882
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.GRTvpASGwo (size 128 KB) containing data sent by client
Created /tmp/tmp.3FtuJTY2T7 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

161

Created /tmp/tmp.JCoe8M8qkN (size 1 KB) containing data sent by client
Created /tmp/tmp.2Dy6T0DZ8g (size 1 KB) containing data sent by server
Created /tmp/tmp.lHrwAI6hPz (size 1024 KB) containing data sent by client
Created /tmp/tmp.geheDdNMV3 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 3 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.lHrwAI6hPz (size 128 KB) containing data sent by client
Created /tmp/tmp.geheDdNMV3 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

162

Created /tmp/tmp.xRGbh1chtn (size 1 KB) containing data sent by client
Created /tmp/tmp.q5qSIkB99L (size 1 KB) containing data sent by server
Created /tmp/tmp.GZ26cwfFnP (size 1024 KB) containing data sent by client
Created /tmp/tmp.yR4aRwM0IY (size 1024 KB) containing data sent by server
file received by server has inverted byte at 67259
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.GZ26cwfFnP (size 128 KB) containing data sent by client
Created /tmp/tmp.yR4aRwM0IY (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

163

Created /tmp/tmp.s32kYVYY3h (size 1 KB) containing data sent by client
Created /tmp/tmp.VA4ngejMHr (size 1 KB) containing data sent by server
Created /tmp/tmp.11PMaVM49j (size 1024 KB) containing data sent by client
Created /tmp/tmp.cCfxlYfgJp (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.11PMaVM49j (size 128 KB) containing data sent by client
Created /tmp/tmp.cCfxlYfgJp (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

164

Created /tmp/tmp.ynMiTugVET (size 1 KB) containing data sent by client
Created /tmp/tmp.3ZLibibGvJ (size 1 KB) containing data sent by server
Created /tmp/tmp.8WmXRZclqj (size 1024 KB) containing data sent by client
Created /tmp/tmp.HnDySFfWBO (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.8WmXRZclqj (size 128 KB) containing data sent by client
Created /tmp/tmp.HnDySFfWBO (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

165

Created /tmp/tmp.dKZCLEBARO (size 1 KB) containing data sent by client
Created /tmp/tmp.xvRlZQWaY2 (size 1 KB) containing data sent by server
Created /tmp/tmp.cFnlDyA9FN (size 1024 KB) containing data sent by client
Created /tmp/tmp.6ulp0Anc13 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 67371
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.cFnlDyA9FN (size 128 KB) containing data sent by client
Created /tmp/tmp.6ulp0Anc13 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

166

Created /tmp/tmp.ezjcwfSAkY (size 1 KB) containing data sent by client
Created /tmp/tmp.5rQse5UXWk (size 1 KB) containing data sent by server
Created /tmp/tmp.I0iZii3m5Z (size 1024 KB) containing data sent by client
Created /tmp/tmp.Dn8DgfGo2z (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.I0iZii3m5Z (size 128 KB) containing data sent by client
Created /tmp/tmp.Dn8DgfGo2z (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

167

Created /tmp/tmp.j7kwom3kvr (size 1 KB) containing data sent by client
Created /tmp/tmp.Pz79cLiA29 (size 1 KB) containing data sent by server
Created /tmp/tmp.lUg15AruIz (size 1024 KB) containing data sent by client
Created /tmp/tmp.OJLI0IuFva (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.lUg15AruIz (size 128 KB) containing data sent by client
Created /tmp/tmp.OJLI0IuFva (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

168

Created /tmp/tmp.eDPkSzykeS (size 1 KB) containing data sent by client
Created /tmp/tmp.oZ2CUZB7dv (size 1 KB) containing data sent by server
Created /tmp/tmp.XIKVBElUup (size 1024 KB) containing data sent by client
Created /tmp/tmp.XKWkPA5eyW (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.XIKVBElUup (size 128 KB) containing data sent by client
Created /tmp/tmp.XKWkPA5eyW (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

169

Created /tmp/tmp.ZL3r2h57wf (size 1 KB) containing data sent by client
Created /tmp/tmp.EidJkJVv0O (size 1 KB) containing data sent by server
Created /tmp/tmp.YtiqnfvuAD (size 1024 KB) containing data sent by client
Created /tmp/tmp.I9nGhBVqhg (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.YtiqnfvuAD (size 128 KB) containing data sent by client
Created /tmp/tmp.I9nGhBVqhg (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

170

Created /tmp/tmp.i2Bvwuh793 (size 1 KB) containing data sent by client
Created /tmp/tmp.ZfcdzJbiEk (size 1 KB) containing data sent by server
Created /tmp/tmp.Q62WsPuXad (size 1024 KB) containing data sent by client
Created /tmp/tmp.J2O2a46w7S (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Q62WsPuXad (size 128 KB) containing data sent by client
Created /tmp/tmp.J2O2a46w7S (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

171

Created /tmp/tmp.2fMAv4hsmS (size 1 KB) containing data sent by client
Created /tmp/tmp.lAc0xzw7fo (size 1 KB) containing data sent by server
Created /tmp/tmp.FI44i8oHfY (size 1024 KB) containing data sent by client
Created /tmp/tmp.vuLZ9LptP0 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65984
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.FI44i8oHfY (size 128 KB) containing data sent by client
Created /tmp/tmp.vuLZ9LptP0 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

172

Created /tmp/tmp.akvUaD3V1U (size 1 KB) containing data sent by client
Created /tmp/tmp.ZGIPFq67Gh (size 1 KB) containing data sent by server
Created /tmp/tmp.bqANmO0mPY (size 1024 KB) containing data sent by client
Created /tmp/tmp.nJLDdOTbvV (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.bqANmO0mPY (size 128 KB) containing data sent by client
Created /tmp/tmp.nJLDdOTbvV (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

173

Created /tmp/tmp.wjLyUqpWxT (size 1 KB) containing data sent by client
Created /tmp/tmp.TYmpXg5pe7 (size 1 KB) containing data sent by server
Created /tmp/tmp.YVp6jb4eOs (size 1024 KB) containing data sent by client
Created /tmp/tmp.duz8HpsCbj (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.YVp6jb4eOs (size 128 KB) containing data sent by client
Created /tmp/tmp.duz8HpsCbj (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

174

Created /tmp/tmp.ZPKfMZjgdA (size 1 KB) containing data sent by client
Created /tmp/tmp.leFnkQ3OKd (size 1 KB) containing data sent by server
Created /tmp/tmp.uK1hVFEXLH (size 1024 KB) containing data sent by client
Created /tmp/tmp.baCoCHT4wF (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.uK1hVFEXLH (size 128 KB) containing data sent by client
Created /tmp/tmp.baCoCHT4wF (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

175

Created /tmp/tmp.WXj8S99X3V (size 1 KB) containing data sent by client
Created /tmp/tmp.Fo2eQ5HL6P (size 1 KB) containing data sent by server
Created /tmp/tmp.tvxQo1RRsh (size 1024 KB) containing data sent by client
Created /tmp/tmp.2akqLzfk4S (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.tvxQo1RRsh (size 128 KB) containing data sent by client
Created /tmp/tmp.2akqLzfk4S (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

176

Created /tmp/tmp.wsyNc95Rkm (size 1 KB) containing data sent by client
Created /tmp/tmp.IUZh5n9M64 (size 1 KB) containing data sent by server
Created /tmp/tmp.hrtPY6G46i (size 1024 KB) containing data sent by client
Created /tmp/tmp.JEbXzPf8OZ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.hrtPY6G46i (size 128 KB) containing data sent by client
Created /tmp/tmp.JEbXzPf8OZ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

177

Created /tmp/tmp.9Eykppchoj (size 1 KB) containing data sent by client
Created /tmp/tmp.6Yi1U728yT (size 1 KB) containing data sent by server
Created /tmp/tmp.JtGSI1IXmY (size 1024 KB) containing data sent by client
Created /tmp/tmp.86RGEr5Cgr (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.JtGSI1IXmY (size 128 KB) containing data sent by client
Created /tmp/tmp.86RGEr5Cgr (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

178

Created /tmp/tmp.pB4rcqcDom (size 1 KB) containing data sent by client
Created /tmp/tmp.fJ5s41uGw3 (size 1 KB) containing data sent by server
Created /tmp/tmp.ap5tjpsE0D (size 1024 KB) containing data sent by client
Created /tmp/tmp.WgrNx0S9eU (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ap5tjpsE0D (size 128 KB) containing data sent by client
Created /tmp/tmp.WgrNx0S9eU (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

179

Created /tmp/tmp.AFODMpblxG (size 1 KB) containing data sent by client
Created /tmp/tmp.KrYlkt8xlj (size 1 KB) containing data sent by server
Created /tmp/tmp.bamHbx3e6V (size 1024 KB) containing data sent by client
Created /tmp/tmp.v2suU3CWe4 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.bamHbx3e6V (size 128 KB) containing data sent by client
Created /tmp/tmp.v2suU3CWe4 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

180

Created /tmp/tmp.WpVjUfFR3y (size 1 KB) containing data sent by client
Created /tmp/tmp.3S8K7RzjuY (size 1 KB) containing data sent by server
Created /tmp/tmp.QxAzBi9hLy (size 1024 KB) containing data sent by client
Created /tmp/tmp.wWSHT36mhu (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.QxAzBi9hLy (size 128 KB) containing data sent by client
Created /tmp/tmp.wWSHT36mhu (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

181

Created /tmp/tmp.xlNsw3OzBe (size 1 KB) containing data sent by client
Created /tmp/tmp.Xv5brNDwl6 (size 1 KB) containing data sent by server
Created /tmp/tmp.gbCEdCNI7P (size 1024 KB) containing data sent by client
Created /tmp/tmp.u08X2S5QNI (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.gbCEdCNI7P (size 128 KB) containing data sent by client
Created /tmp/tmp.u08X2S5QNI (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

182

Created /tmp/tmp.IVL2XSz6lE (size 1 KB) containing data sent by client
Created /tmp/tmp.oLkba6JlPG (size 1 KB) containing data sent by server
Created /tmp/tmp.Roc0WYsL0O (size 1024 KB) containing data sent by client
Created /tmp/tmp.2JRoYBKboQ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Roc0WYsL0O (size 128 KB) containing data sent by client
Created /tmp/tmp.2JRoYBKboQ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

183

Created /tmp/tmp.S6XpQfH42A (size 1 KB) containing data sent by client
Created /tmp/tmp.wEEHeSYFzG (size 1 KB) containing data sent by server
Created /tmp/tmp.VcfhbdRtnz (size 1024 KB) containing data sent by client
Created /tmp/tmp.vq1etV3415 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.VcfhbdRtnz (size 128 KB) containing data sent by client
Created /tmp/tmp.vq1etV3415 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

184

Created /tmp/tmp.gruo9RQZSG (size 1 KB) containing data sent by client
Created /tmp/tmp.CMNtOL7UsD (size 1 KB) containing data sent by server
Created /tmp/tmp.J4MvDOkVUj (size 1024 KB) containing data sent by client
Created /tmp/tmp.Emh5BTMq1e (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.J4MvDOkVUj (size 128 KB) containing data sent by client
Created /tmp/tmp.Emh5BTMq1e (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 3 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

185

Created /tmp/tmp.ImWPQQlEca (size 1 KB) containing data sent by client
Created /tmp/tmp.Y8V8IPZ2MV (size 1 KB) containing data sent by server
Created /tmp/tmp.bZbCiU2jLk (size 1024 KB) containing data sent by client
Created /tmp/tmp.oSKLuqDo9y (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.bZbCiU2jLk (size 128 KB) containing data sent by client
Created /tmp/tmp.oSKLuqDo9y (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

186

Created /tmp/tmp.hHTuTkOoiB (size 1 KB) containing data sent by client
Created /tmp/tmp.XPD7krzThP (size 1 KB) containing data sent by server
Created /tmp/tmp.a3RLsFOkq3 (size 1024 KB) containing data sent by client
Created /tmp/tmp.fNDyXf0QpO (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.a3RLsFOkq3 (size 128 KB) containing data sent by client
Created /tmp/tmp.fNDyXf0QpO (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

187

Created /tmp/tmp.F9rzw3fUN9 (size 1 KB) containing data sent by client
Created /tmp/tmp.6RBKvEaMnx (size 1 KB) containing data sent by server
Created /tmp/tmp.ENiMqQzjtk (size 1024 KB) containing data sent by client
Created /tmp/tmp.eTAzCWjqGa (size 1024 KB) containing data sent by server
file received by server has inverted byte at 66931
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ENiMqQzjtk (size 128 KB) containing data sent by client
Created /tmp/tmp.eTAzCWjqGa (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

188

Created /tmp/tmp.4U97scrqXa (size 1 KB) containing data sent by client
Created /tmp/tmp.pRr1YZBO6p (size 1 KB) containing data sent by server
Created /tmp/tmp.qWrjOPzonZ (size 1024 KB) containing data sent by client
Created /tmp/tmp.zbKi2rJ2Ab (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.qWrjOPzonZ (size 128 KB) containing data sent by client
Created /tmp/tmp.zbKi2rJ2Ab (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

189

Created /tmp/tmp.6sy9QXjawT (size 1 KB) containing data sent by client
Created /tmp/tmp.HvevInrjLn (size 1 KB) containing data sent by server
Created /tmp/tmp.ycTW7kpsA0 (size 1024 KB) containing data sent by client
Created /tmp/tmp.V3wwp5mkuf (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 3 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ycTW7kpsA0 (size 128 KB) containing data sent by client
Created /tmp/tmp.V3wwp5mkuf (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

190

Created /tmp/tmp.EtaLnHBTHY (size 1 KB) containing data sent by client
Created /tmp/tmp.rD5QCYiD7N (size 1 KB) containing data sent by server
Created /tmp/tmp.k1W9j968k0 (size 1024 KB) containing data sent by client
Created /tmp/tmp.4U6BJlLvOT (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.k1W9j968k0 (size 128 KB) containing data sent by client
Created /tmp/tmp.4U6BJlLvOT (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

191

Created /tmp/tmp.YOPb9zCZ3d (size 1 KB) containing data sent by client
Created /tmp/tmp.LcRJS3VPAC (size 1 KB) containing data sent by server
Created /tmp/tmp.opdi3TrtgG (size 1024 KB) containing data sent by client
Created /tmp/tmp.mhDZ4T7YRb (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.opdi3TrtgG (size 128 KB) containing data sent by client
Created /tmp/tmp.mhDZ4T7YRb (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

192

Created /tmp/tmp.QRlHSuhPUN (size 1 KB) containing data sent by client
Created /tmp/tmp.rQYaNz4G3a (size 1 KB) containing data sent by server
Created /tmp/tmp.LZsLN3bd5f (size 1024 KB) containing data sent by client
Created /tmp/tmp.UqCjKXFR9w (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.LZsLN3bd5f (size 128 KB) containing data sent by client
Created /tmp/tmp.UqCjKXFR9w (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

193

Created /tmp/tmp.YToQDcrGi1 (size 1 KB) containing data sent by client
Created /tmp/tmp.fydS47bH8O (size 1 KB) containing data sent by server
Created /tmp/tmp.SgHRAEmhGH (size 1024 KB) containing data sent by client
Created /tmp/tmp.8ilFIUev79 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.SgHRAEmhGH (size 128 KB) containing data sent by client
Created /tmp/tmp.8ilFIUev79 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

194

Created /tmp/tmp.kcRFtKEh2V (size 1 KB) containing data sent by client
Created /tmp/tmp.pnRARnFvhJ (size 1 KB) containing data sent by server
Created /tmp/tmp.9KY9V4vkXp (size 1024 KB) containing data sent by client
Created /tmp/tmp.SleAFX8ZBg (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.9KY9V4vkXp (size 128 KB) containing data sent by client
Created /tmp/tmp.SleAFX8ZBg (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

195

Created /tmp/tmp.T4nw7zEXcx (size 1 KB) containing data sent by client
Created /tmp/tmp.c8AmF4f2Rj (size 1 KB) containing data sent by server
Created /tmp/tmp.cHT7tXwmV2 (size 1024 KB) containing data sent by client
Created /tmp/tmp.FRfyD2wVzH (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.cHT7tXwmV2 (size 128 KB) containing data sent by client
Created /tmp/tmp.FRfyD2wVzH (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

196

Created /tmp/tmp.Rlih5VAaag (size 1 KB) containing data sent by client
Created /tmp/tmp.7K8WN5owFv (size 1 KB) containing data sent by server
Created /tmp/tmp.qRXcdGBHy2 (size 1024 KB) containing data sent by client
Created /tmp/tmp.sxl3DVelsN (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.qRXcdGBHy2 (size 128 KB) containing data sent by client
Created /tmp/tmp.sxl3DVelsN (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

197

Created /tmp/tmp.rbG54Wmk6R (size 1 KB) containing data sent by client
Created /tmp/tmp.nOBY985PUn (size 1 KB) containing data sent by server
Created /tmp/tmp.BIhLvc69qd (size 1024 KB) containing data sent by client
Created /tmp/tmp.EcUTxZfA21 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.BIhLvc69qd (size 128 KB) containing data sent by client
Created /tmp/tmp.EcUTxZfA21 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

198

Created /tmp/tmp.1LBziTt8aQ (size 1 KB) containing data sent by client
Created /tmp/tmp.TTbEvGNLdg (size 1 KB) containing data sent by server
Created /tmp/tmp.JX2UUis3C1 (size 1024 KB) containing data sent by client
Created /tmp/tmp.xahiwW5ZGY (size 1024 KB) containing data sent by server
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.JX2UUis3C1 (size 128 KB) containing data sent by client
Created /tmp/tmp.xahiwW5ZGY (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

199

Created /tmp/tmp.G9TaF7boFV (size 1 KB) containing data sent by client
Created /tmp/tmp.DKMQXh1hrC (size 1 KB) containing data sent by server
Created /tmp/tmp.EhaE3Xhyrm (size 1024 KB) containing data sent by client
Created /tmp/tmp.gNzNX6se92 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.EhaE3Xhyrm (size 128 KB) containing data sent by client
Created /tmp/tmp.gNzNX6se92 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

200

Created /tmp/tmp.NevjloF5yy (size 1 KB) containing data sent by client
Created /tmp/tmp.yM3VuLztDf (size 1 KB) containing data sent by server
Created /tmp/tmp.KAZZeYb6cr (size 1024 KB) containing data sent by client
Created /tmp/tmp.P3H985G45I (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.KAZZeYb6cr (size 128 KB) containing data sent by client
Created /tmp/tmp.P3H985G45I (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

201

Created /tmp/tmp.TuAfV74QZN (size 1 KB) containing data sent by client
Created /tmp/tmp.RaU5GWNj3b (size 1 KB) containing data sent by server
Created /tmp/tmp.xydZQKKbHM (size 1024 KB) containing data sent by client
Created /tmp/tmp.AyW13WwP28 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.xydZQKKbHM (size 128 KB) containing data sent by client
Created /tmp/tmp.AyW13WwP28 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

202

Created /tmp/tmp.sm7rijm0R1 (size 1 KB) containing data sent by client
Created /tmp/tmp.KFGrLeEa7g (size 1 KB) containing data sent by server
Created /tmp/tmp.WWo4KBAKKi (size 1024 KB) containing data sent by client
Created /tmp/tmp.BDE9UBF018 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.WWo4KBAKKi (size 128 KB) containing data sent by client
Created /tmp/tmp.BDE9UBF018 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

203

Created /tmp/tmp.ZlOD2SQ69C (size 1 KB) containing data sent by client
Created /tmp/tmp.eSeL3pFAlQ (size 1 KB) containing data sent by server
Created /tmp/tmp.jrPCA3P23N (size 1024 KB) containing data sent by client
Created /tmp/tmp.KGuie6cHGN (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.jrPCA3P23N (size 128 KB) containing data sent by client
Created /tmp/tmp.KGuie6cHGN (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

204

Created /tmp/tmp.dAIKRmsYkX (size 1 KB) containing data sent by client
Created /tmp/tmp.QmaCvEaukZ (size 1 KB) containing data sent by server
Created /tmp/tmp.P66fj01tOQ (size 1024 KB) containing data sent by client
Created /tmp/tmp.rMGEwFeKE7 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.P66fj01tOQ (size 128 KB) containing data sent by client
Created /tmp/tmp.rMGEwFeKE7 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

205

Created /tmp/tmp.pROaE3SLNg (size 1 KB) containing data sent by client
Created /tmp/tmp.pizPwmVOJZ (size 1 KB) containing data sent by server
Created /tmp/tmp.TupIzhzgST (size 1024 KB) containing data sent by client
Created /tmp/tmp.XwiPxL6OPb (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.TupIzhzgST (size 128 KB) containing data sent by client
Created /tmp/tmp.XwiPxL6OPb (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

206

Created /tmp/tmp.1VMzs1DvRs (size 1 KB) containing data sent by client
Created /tmp/tmp.BbvkEBN3vn (size 1 KB) containing data sent by server
Created /tmp/tmp.YnCdMEJ9Q3 (size 1024 KB) containing data sent by client
Created /tmp/tmp.zwlbARj1IN (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.YnCdMEJ9Q3 (size 128 KB) containing data sent by client
Created /tmp/tmp.zwlbARj1IN (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

207

Created /tmp/tmp.EgswsNp5BF (size 1 KB) containing data sent by client
Created /tmp/tmp.2hbnhgcyWr (size 1 KB) containing data sent by server
Created /tmp/tmp.4Ai1Hu70Vu (size 1024 KB) containing data sent by client
Created /tmp/tmp.qrhTtQGyKu (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71397
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.4Ai1Hu70Vu (size 128 KB) containing data sent by client
Created /tmp/tmp.qrhTtQGyKu (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

208

Created /tmp/tmp.TMWXk2LYwj (size 1 KB) containing data sent by client
Created /tmp/tmp.Z4H9GEosmc (size 1 KB) containing data sent by server
Created /tmp/tmp.KLqtKLHGeP (size 1024 KB) containing data sent by client
Created /tmp/tmp.SrLs7nbRTz (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.KLqtKLHGeP (size 128 KB) containing data sent by client
Created /tmp/tmp.SrLs7nbRTz (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

209

Created /tmp/tmp.c6uDYqSiNW (size 1 KB) containing data sent by client
Created /tmp/tmp.UglQA3ysXH (size 1 KB) containing data sent by server
Created /tmp/tmp.vet6n8UjYn (size 1024 KB) containing data sent by client
Created /tmp/tmp.3eUN6lDod8 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.vet6n8UjYn (size 128 KB) containing data sent by client
Created /tmp/tmp.3eUN6lDod8 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

210

Created /tmp/tmp.O3T7eYT9D1 (size 1 KB) containing data sent by client
Created /tmp/tmp.38etvrBvda (size 1 KB) containing data sent by server
Created /tmp/tmp.BoYxcBdBD7 (size 1024 KB) containing data sent by client
Created /tmp/tmp.unBGJ090Cu (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72389
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.BoYxcBdBD7 (size 128 KB) containing data sent by client
Created /tmp/tmp.unBGJ090Cu (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

211

Created /tmp/tmp.qKVr07XnBT (size 1 KB) containing data sent by client
Created /tmp/tmp.Go5y4RUvtO (size 1 KB) containing data sent by server
Created /tmp/tmp.ei5kEZwxvn (size 1024 KB) containing data sent by client
Created /tmp/tmp.qA8XEUJur8 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ei5kEZwxvn (size 128 KB) containing data sent by client
Created /tmp/tmp.qA8XEUJur8 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

212

Created /tmp/tmp.YsiDkU9XKl (size 1 KB) containing data sent by client
Created /tmp/tmp.iHt3WnbMtw (size 1 KB) containing data sent by server
Created /tmp/tmp.Uln6D2USi6 (size 1024 KB) containing data sent by client
Created /tmp/tmp.3f7Vh9CME1 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Uln6D2USi6 (size 128 KB) containing data sent by client
Created /tmp/tmp.3f7Vh9CME1 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

213

Created /tmp/tmp.kttofY8NaI (size 1 KB) containing data sent by client
Created /tmp/tmp.JSxBKRue4J (size 1 KB) containing data sent by server
Created /tmp/tmp.GTB9LashA1 (size 1024 KB) containing data sent by client
Created /tmp/tmp.iBMPaqS8bJ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.GTB9LashA1 (size 128 KB) containing data sent by client
Created /tmp/tmp.iBMPaqS8bJ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

214

Created /tmp/tmp.x5QSXqObDc (size 1 KB) containing data sent by client
Created /tmp/tmp.xGWYvkx2em (size 1 KB) containing data sent by server
Created /tmp/tmp.2zg5SJK20G (size 1024 KB) containing data sent by client
Created /tmp/tmp.4dPTxBXr1L (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.2zg5SJK20G (size 128 KB) containing data sent by client
Created /tmp/tmp.4dPTxBXr1L (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

215

Created /tmp/tmp.8Imh0vfTTl (size 1 KB) containing data sent by client
Created /tmp/tmp.0THsqweHXD (size 1 KB) containing data sent by server
Created /tmp/tmp.wnuJhQM5Qv (size 1024 KB) containing data sent by client
Created /tmp/tmp.gXtYaRfJls (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.wnuJhQM5Qv (size 128 KB) containing data sent by client
Created /tmp/tmp.gXtYaRfJls (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

216

Created /tmp/tmp.gErN3EH1aH (size 1 KB) containing data sent by client
Created /tmp/tmp.onGr3NyHNd (size 1 KB) containing data sent by server
Created /tmp/tmp.OEWaHo9a5d (size 1024 KB) containing data sent by client
Created /tmp/tmp.iGrK3TfUAA (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.OEWaHo9a5d (size 128 KB) containing data sent by client
Created /tmp/tmp.iGrK3TfUAA (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

217

Created /tmp/tmp.Z55tMYmbIT (size 1 KB) containing data sent by client
Created /tmp/tmp.94u4VowyQz (size 1 KB) containing data sent by server
Created /tmp/tmp.NqGfEi3lPw (size 1024 KB) containing data sent by client
Created /tmp/tmp.Yq79k0RTxl (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.NqGfEi3lPw (size 128 KB) containing data sent by client
Created /tmp/tmp.Yq79k0RTxl (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

218

Created /tmp/tmp.DVFWrXjZH6 (size 1 KB) containing data sent by client
Created /tmp/tmp.k5P9TEwhdK (size 1 KB) containing data sent by server
Created /tmp/tmp.MwOiZYJHtW (size 1024 KB) containing data sent by client
Created /tmp/tmp.Kg3Esaf9o3 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.MwOiZYJHtW (size 128 KB) containing data sent by client
Created /tmp/tmp.Kg3Esaf9o3 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

219

Created /tmp/tmp.W0qJBivMu5 (size 1 KB) containing data sent by client
Created /tmp/tmp.tsu2OsHBBh (size 1 KB) containing data sent by server
Created /tmp/tmp.AaKKGhSRud (size 1024 KB) containing data sent by client
Created /tmp/tmp.PbXO1SREvx (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.AaKKGhSRud (size 128 KB) containing data sent by client
Created /tmp/tmp.PbXO1SREvx (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

220

Created /tmp/tmp.SZ9PNCh29I (size 1 KB) containing data sent by client
Created /tmp/tmp.VqKk3TBg3e (size 1 KB) containing data sent by server
Created /tmp/tmp.bO3WKsCMtB (size 1024 KB) containing data sent by client
Created /tmp/tmp.tzIA05SPiv (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.bO3WKsCMtB (size 128 KB) containing data sent by client
Created /tmp/tmp.tzIA05SPiv (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

221

Created /tmp/tmp.3A1g9D9UXq (size 1 KB) containing data sent by client
Created /tmp/tmp.xBDj9GhRb4 (size 1 KB) containing data sent by server
Created /tmp/tmp.xbgD8aEMnK (size 1024 KB) containing data sent by client
Created /tmp/tmp.gFxVWdJ0Z3 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.xbgD8aEMnK (size 128 KB) containing data sent by client
Created /tmp/tmp.gFxVWdJ0Z3 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

222

Created /tmp/tmp.J90wThCfUr (size 1 KB) containing data sent by client
Created /tmp/tmp.HEVvQgWmD3 (size 1 KB) containing data sent by server
Created /tmp/tmp.suLn9C4NRu (size 1024 KB) containing data sent by client
Created /tmp/tmp.PTPVLKM99B (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.suLn9C4NRu (size 128 KB) containing data sent by client
Created /tmp/tmp.PTPVLKM99B (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

223

Created /tmp/tmp.pTgC31rd2K (size 1 KB) containing data sent by client
Created /tmp/tmp.VbBFlub9dZ (size 1 KB) containing data sent by server
Created /tmp/tmp.tLti0zou8z (size 1024 KB) containing data sent by client
Created /tmp/tmp.UtCl8LsBLv (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.tLti0zou8z (size 128 KB) containing data sent by client
Created /tmp/tmp.UtCl8LsBLv (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

224

Created /tmp/tmp.ggSg9p92oO (size 1 KB) containing data sent by client
Created /tmp/tmp.hkWkv7k5AE (size 1 KB) containing data sent by server
Created /tmp/tmp.WCeA1u8lbp (size 1024 KB) containing data sent by client
Created /tmp/tmp.vbhZEvSu13 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.WCeA1u8lbp (size 128 KB) containing data sent by client
Created /tmp/tmp.vbhZEvSu13 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

225

Created /tmp/tmp.4Xele1wTN6 (size 1 KB) containing data sent by client
Created /tmp/tmp.DqBiucy7wM (size 1 KB) containing data sent by server
Created /tmp/tmp.qqn4u786NJ (size 1024 KB) containing data sent by client
Created /tmp/tmp.q8y3xUJ4Px (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.qqn4u786NJ (size 128 KB) containing data sent by client
Created /tmp/tmp.q8y3xUJ4Px (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

226

Created /tmp/tmp.NBO64gHNp6 (size 1 KB) containing data sent by client
Created /tmp/tmp.NuXPMlrhV8 (size 1 KB) containing data sent by server
Created /tmp/tmp.tXoHDzwPCh (size 1024 KB) containing data sent by client
Created /tmp/tmp.IGmCPbnFwA (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.tXoHDzwPCh (size 128 KB) containing data sent by client
Created /tmp/tmp.IGmCPbnFwA (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

227

Created /tmp/tmp.UWUwtan41L (size 1 KB) containing data sent by client
Created /tmp/tmp.olRF5AW6hM (size 1 KB) containing data sent by server
Created /tmp/tmp.QjYg0gQzO3 (size 1024 KB) containing data sent by client
Created /tmp/tmp.4m7RLm9ARd (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.QjYg0gQzO3 (size 128 KB) containing data sent by client
Created /tmp/tmp.4m7RLm9ARd (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

228

Created /tmp/tmp.UnAdO3TuoJ (size 1 KB) containing data sent by client
Created /tmp/tmp.ooJDf0f7Ji (size 1 KB) containing data sent by server
Created /tmp/tmp.9lYaYLTTvv (size 1024 KB) containing data sent by client
Created /tmp/tmp.c3DBdGHt85 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.9lYaYLTTvv (size 128 KB) containing data sent by client
Created /tmp/tmp.c3DBdGHt85 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

229

Created /tmp/tmp.afge26dfc1 (size 1 KB) containing data sent by client
Created /tmp/tmp.T5WmAu8HpX (size 1 KB) containing data sent by server
Created /tmp/tmp.RaK2D1AyTv (size 1024 KB) containing data sent by client
Created /tmp/tmp.jaFvulF5Ln (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.RaK2D1AyTv (size 128 KB) containing data sent by client
Created /tmp/tmp.jaFvulF5Ln (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

230

Created /tmp/tmp.Maog8JxQHR (size 1 KB) containing data sent by client
Created /tmp/tmp.GCYDRpLMgZ (size 1 KB) containing data sent by server
Created /tmp/tmp.C0aAidxFn5 (size 1024 KB) containing data sent by client
Created /tmp/tmp.ppKsTys6nN (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.C0aAidxFn5 (size 128 KB) containing data sent by client
Created /tmp/tmp.ppKsTys6nN (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

231

Created /tmp/tmp.oE5NmTeXOI (size 1 KB) containing data sent by client
Created /tmp/tmp.2me2Z1cMON (size 1 KB) containing data sent by server
Created /tmp/tmp.viAN1ET8lI (size 1024 KB) containing data sent by client
Created /tmp/tmp.rsaeLGmIaH (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 3 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.viAN1ET8lI (size 128 KB) containing data sent by client
Created /tmp/tmp.rsaeLGmIaH (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

232

Created /tmp/tmp.tpiuRGmdU8 (size 1 KB) containing data sent by client
Created /tmp/tmp.0ypCow4H6U (size 1 KB) containing data sent by server
Created /tmp/tmp.8gr0wU4L5L (size 1024 KB) containing data sent by client
Created /tmp/tmp.GRQ6mBjIv5 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.8gr0wU4L5L (size 128 KB) containing data sent by client
Created /tmp/tmp.GRQ6mBjIv5 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

233

Created /tmp/tmp.09cEp4yFm6 (size 1 KB) containing data sent by client
Created /tmp/tmp.FCrxKbXZfl (size 1 KB) containing data sent by server
Created /tmp/tmp.uyGKczSNhr (size 1024 KB) containing data sent by client
Created /tmp/tmp.bX2p0Qxlhw (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.uyGKczSNhr (size 128 KB) containing data sent by client
Created /tmp/tmp.bX2p0Qxlhw (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 4 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

234

Created /tmp/tmp.17Q6saKcWE (size 1 KB) containing data sent by client
Created /tmp/tmp.1QGZBdfRbs (size 1 KB) containing data sent by server
Created /tmp/tmp.W2bLwfVdPI (size 1024 KB) containing data sent by client
Created /tmp/tmp.rZlxoCVmVc (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.W2bLwfVdPI (size 128 KB) containing data sent by client
Created /tmp/tmp.rZlxoCVmVc (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

235

Created /tmp/tmp.TSMT02aK1u (size 1 KB) containing data sent by client
Created /tmp/tmp.2BHUNDM8SO (size 1 KB) containing data sent by server
Created /tmp/tmp.gAhToiU8Tg (size 1024 KB) containing data sent by client
Created /tmp/tmp.WU9GSCrNM0 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.gAhToiU8Tg (size 128 KB) containing data sent by client
Created /tmp/tmp.WU9GSCrNM0 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

236

Created /tmp/tmp.Ou6xLVFIQW (size 1 KB) containing data sent by client
Created /tmp/tmp.vJdR1wZgZP (size 1 KB) containing data sent by server
Created /tmp/tmp.kDBWwMn9EE (size 1024 KB) containing data sent by client
Created /tmp/tmp.pZuo7EI8IE (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.kDBWwMn9EE (size 128 KB) containing data sent by client
Created /tmp/tmp.pZuo7EI8IE (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 3 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

237

Created /tmp/tmp.DnbydJnmsr (size 1 KB) containing data sent by client
Created /tmp/tmp.LmBmy2aw3f (size 1 KB) containing data sent by server
Created /tmp/tmp.z9j1TeZM0M (size 1024 KB) containing data sent by client
Created /tmp/tmp.KRE9DW9YOH (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.z9j1TeZM0M (size 128 KB) containing data sent by client
Created /tmp/tmp.KRE9DW9YOH (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

238

Created /tmp/tmp.UgCBPWfFWf (size 1 KB) containing data sent by client
Created /tmp/tmp.nYt4LO0Y7L (size 1 KB) containing data sent by server
Created /tmp/tmp.ayr2hNrSMr (size 1024 KB) containing data sent by client
Created /tmp/tmp.WDoZ0jgqal (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ayr2hNrSMr (size 128 KB) containing data sent by client
Created /tmp/tmp.WDoZ0jgqal (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

239

Created /tmp/tmp.MI10lsLU1U (size 1 KB) containing data sent by client
Created /tmp/tmp.QjeTprT1Fo (size 1 KB) containing data sent by server
Created /tmp/tmp.mbogMG1CiX (size 1024 KB) containing data sent by client
Created /tmp/tmp.wRFUwKC8NW (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.mbogMG1CiX (size 128 KB) containing data sent by client
Created /tmp/tmp.wRFUwKC8NW (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

240

Created /tmp/tmp.eRyt2EQ6zb (size 1 KB) containing data sent by client
Created /tmp/tmp.gFhEWecvBn (size 1 KB) containing data sent by server
Created /tmp/tmp.Vc08FBiCUp (size 1024 KB) containing data sent by client
Created /tmp/tmp.QRuR7Zrhsj (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Vc08FBiCUp (size 128 KB) containing data sent by client
Created /tmp/tmp.QRuR7Zrhsj (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

241

Created /tmp/tmp.yZbjr4sstC (size 1 KB) containing data sent by client
Created /tmp/tmp.7GBrhrmwzA (size 1 KB) containing data sent by server
Created /tmp/tmp.gUAQqBLjdw (size 1024 KB) containing data sent by client
Created /tmp/tmp.P1JsTX8az6 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.gUAQqBLjdw (size 128 KB) containing data sent by client
Created /tmp/tmp.P1JsTX8az6 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 4 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

242

Created /tmp/tmp.g7M326djBo (size 1 KB) containing data sent by client
Created /tmp/tmp.FKsptROd24 (size 1 KB) containing data sent by server
Created /tmp/tmp.73F1TkJ6oq (size 1024 KB) containing data sent by client
Created /tmp/tmp.qWNzW0Ztbo (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.73F1TkJ6oq (size 128 KB) containing data sent by client
Created /tmp/tmp.qWNzW0Ztbo (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

243

Created /tmp/tmp.b72Em7QbSK (size 1 KB) containing data sent by client
Created /tmp/tmp.L0kOT14oZU (size 1 KB) containing data sent by server
Created /tmp/tmp.g3cpowwybb (size 1024 KB) containing data sent by client
Created /tmp/tmp.We1OSpLOJp (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.g3cpowwybb (size 128 KB) containing data sent by client
Created /tmp/tmp.We1OSpLOJp (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

244

Created /tmp/tmp.GHhAlADGu8 (size 1 KB) containing data sent by client
Created /tmp/tmp.H0Czd8KvcV (size 1 KB) containing data sent by server
Created /tmp/tmp.kRzueTyOsD (size 1024 KB) containing data sent by client
Created /tmp/tmp.fs4SYAcnby (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.kRzueTyOsD (size 128 KB) containing data sent by client
Created /tmp/tmp.fs4SYAcnby (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

245

Created /tmp/tmp.30MgL3Tvj1 (size 1 KB) containing data sent by client
Created /tmp/tmp.HLWgljfgOz (size 1 KB) containing data sent by server
Created /tmp/tmp.Kfar9st3JC (size 1024 KB) containing data sent by client
Created /tmp/tmp.KsPUn87I21 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Kfar9st3JC (size 128 KB) containing data sent by client
Created /tmp/tmp.KsPUn87I21 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

246

Created /tmp/tmp.ChGv9UA0Nb (size 1 KB) containing data sent by client
Created /tmp/tmp.lSuskYkBaL (size 1 KB) containing data sent by server
Created /tmp/tmp.pkfbbgYIbm (size 1024 KB) containing data sent by client
Created /tmp/tmp.YJdjHZ6V42 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.pkfbbgYIbm (size 128 KB) containing data sent by client
Created /tmp/tmp.YJdjHZ6V42 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

247

Created /tmp/tmp.w2kzRoMrBp (size 1 KB) containing data sent by client
Created /tmp/tmp.kjnXoVxNNP (size 1 KB) containing data sent by server
Created /tmp/tmp.Ic3P2s8EUs (size 1024 KB) containing data sent by client
Created /tmp/tmp.ApY6ZVmNQE (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Ic3P2s8EUs (size 128 KB) containing data sent by client
Created /tmp/tmp.ApY6ZVmNQE (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

248

Created /tmp/tmp.CRTllpavWb (size 1 KB) containing data sent by client
Created /tmp/tmp.SpHxiVBLd2 (size 1 KB) containing data sent by server
Created /tmp/tmp.U11MgWMEaE (size 1024 KB) containing data sent by client
Created /tmp/tmp.uCDhRZdsCD (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72389
001 MP_FAIL MP_RST: 3 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.U11MgWMEaE (size 128 KB) containing data sent by client
Created /tmp/tmp.uCDhRZdsCD (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

249

Created /tmp/tmp.BLyxNPc0cO (size 1 KB) containing data sent by client
Created /tmp/tmp.r6H3Xja2Mw (size 1 KB) containing data sent by server
Created /tmp/tmp.WK9NahxzVS (size 1024 KB) containing data sent by client
Created /tmp/tmp.syK9DtNtQX (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.WK9NahxzVS (size 128 KB) containing data sent by client
Created /tmp/tmp.syK9DtNtQX (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

250

Created /tmp/tmp.c9n3vIIYVB (size 1 KB) containing data sent by client
Created /tmp/tmp.BC5lmOEHz2 (size 1 KB) containing data sent by server
Created /tmp/tmp.YYbaT0ZOAF (size 1024 KB) containing data sent by client
Created /tmp/tmp.WftY8ok4DV (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.YYbaT0ZOAF (size 128 KB) containing data sent by client
Created /tmp/tmp.WftY8ok4DV (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

251

Created /tmp/tmp.hfXbhTMH8E (size 1 KB) containing data sent by client
Created /tmp/tmp.NTKVQ5QSON (size 1 KB) containing data sent by server
Created /tmp/tmp.faEFsz6XY4 (size 1024 KB) containing data sent by client
Created /tmp/tmp.SUvAvvIYpW (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.faEFsz6XY4 (size 128 KB) containing data sent by client
Created /tmp/tmp.SUvAvvIYpW (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

252

Created /tmp/tmp.dPRgcOYJW8 (size 1 KB) containing data sent by client
Created /tmp/tmp.SP5gNL3xe1 (size 1 KB) containing data sent by server
Created /tmp/tmp.Pdf7w7xlJ5 (size 1024 KB) containing data sent by client
Created /tmp/tmp.DdQbK9YKOK (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Pdf7w7xlJ5 (size 128 KB) containing data sent by client
Created /tmp/tmp.DdQbK9YKOK (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

253

Created /tmp/tmp.e03t1rN2Kd (size 1 KB) containing data sent by client
Created /tmp/tmp.bLJXFkA22z (size 1 KB) containing data sent by server
Created /tmp/tmp.CboEkDUqiM (size 1024 KB) containing data sent by client
Created /tmp/tmp.FhO5h4jYRj (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.CboEkDUqiM (size 128 KB) containing data sent by client
Created /tmp/tmp.FhO5h4jYRj (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

254

Created /tmp/tmp.6HoxWlA6OA (size 1 KB) containing data sent by client
Created /tmp/tmp.usZMvMnnXS (size 1 KB) containing data sent by server
Created /tmp/tmp.qbtTwZaIBk (size 1024 KB) containing data sent by client
Created /tmp/tmp.8qPi9GWmfu (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.qbtTwZaIBk (size 128 KB) containing data sent by client
Created /tmp/tmp.8qPi9GWmfu (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

255

Created /tmp/tmp.dh1hJGlt4C (size 1 KB) containing data sent by client
Created /tmp/tmp.5kqxUPk5FO (size 1 KB) containing data sent by server
Created /tmp/tmp.7931o9yooa (size 1024 KB) containing data sent by client
Created /tmp/tmp.PyEgfqHD2d (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.7931o9yooa (size 128 KB) containing data sent by client
Created /tmp/tmp.PyEgfqHD2d (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

256

Created /tmp/tmp.d9l6aVs9a9 (size 1 KB) containing data sent by client
Created /tmp/tmp.tcPuYqGfJM (size 1 KB) containing data sent by server
Created /tmp/tmp.pXuCXkZNAl (size 1024 KB) containing data sent by client
Created /tmp/tmp.oIf0IDxjn2 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.pXuCXkZNAl (size 128 KB) containing data sent by client
Created /tmp/tmp.oIf0IDxjn2 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

257

Created /tmp/tmp.H36HP1bFnQ (size 1 KB) containing data sent by client
Created /tmp/tmp.xWO9Fp5Xsf (size 1 KB) containing data sent by server
Created /tmp/tmp.q5PPTVCP9t (size 1024 KB) containing data sent by client
Created /tmp/tmp.vVUQZiRF4U (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.q5PPTVCP9t (size 128 KB) containing data sent by client
Created /tmp/tmp.vVUQZiRF4U (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

258

Created /tmp/tmp.lWMki9xn98 (size 1 KB) containing data sent by client
Created /tmp/tmp.Rl5qX1xCuv (size 1 KB) containing data sent by server
Created /tmp/tmp.imwOmCHuEv (size 1024 KB) containing data sent by client
Created /tmp/tmp.qyPRsIKh4Z (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.imwOmCHuEv (size 128 KB) containing data sent by client
Created /tmp/tmp.qyPRsIKh4Z (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 1 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

259

Created /tmp/tmp.5bTZNBIG4L (size 1 KB) containing data sent by client
Created /tmp/tmp.3FO428VW1Z (size 1 KB) containing data sent by server
Created /tmp/tmp.13rtnP2WNe (size 1024 KB) containing data sent by client
Created /tmp/tmp.noPTa4IpNP (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.13rtnP2WNe (size 128 KB) containing data sent by client
Created /tmp/tmp.noPTa4IpNP (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

260

Created /tmp/tmp.4IgYlxq345 (size 1 KB) containing data sent by client
Created /tmp/tmp.oBWW94yYgR (size 1 KB) containing data sent by server
Created /tmp/tmp.VG5MXaEx1I (size 1024 KB) containing data sent by client
Created /tmp/tmp.SYnKO1XgKK (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.VG5MXaEx1I (size 128 KB) containing data sent by client
Created /tmp/tmp.SYnKO1XgKK (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

261

Created /tmp/tmp.S340Wp6kQ1 (size 1 KB) containing data sent by client
Created /tmp/tmp.RpvWdmxLXI (size 1 KB) containing data sent by server
Created /tmp/tmp.jy1uxYLIXV (size 1024 KB) containing data sent by client
Created /tmp/tmp.GgyYOqlDLy (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.jy1uxYLIXV (size 128 KB) containing data sent by client
Created /tmp/tmp.GgyYOqlDLy (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

262

Created /tmp/tmp.xvP3HoJqQu (size 1 KB) containing data sent by client
Created /tmp/tmp.x8R4V8i9o7 (size 1 KB) containing data sent by server
Created /tmp/tmp.e6PIlo1hiZ (size 1024 KB) containing data sent by client
Created /tmp/tmp.WEaSEFE8l9 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.e6PIlo1hiZ (size 128 KB) containing data sent by client
Created /tmp/tmp.WEaSEFE8l9 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

263

Created /tmp/tmp.hYMsZtn8ui (size 1 KB) containing data sent by client
Created /tmp/tmp.uqnqY1kGi8 (size 1 KB) containing data sent by server
Created /tmp/tmp.Y8VFxjuBwK (size 1024 KB) containing data sent by client
Created /tmp/tmp.5W2757yS0d (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Y8VFxjuBwK (size 128 KB) containing data sent by client
Created /tmp/tmp.5W2757yS0d (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

264

Created /tmp/tmp.hcmkilMaTb (size 1 KB) containing data sent by client
Created /tmp/tmp.p1jDjkMGck (size 1 KB) containing data sent by server
Created /tmp/tmp.9nfv0wfYaA (size 1024 KB) containing data sent by client
Created /tmp/tmp.Ommz7CJO6a (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 3 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.9nfv0wfYaA (size 128 KB) containing data sent by client
Created /tmp/tmp.Ommz7CJO6a (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

265

Created /tmp/tmp.1NW9CzgXRF (size 1 KB) containing data sent by client
Created /tmp/tmp.2ShAf9h6Dd (size 1 KB) containing data sent by server
Created /tmp/tmp.ZnoxRGS4qp (size 1024 KB) containing data sent by client
Created /tmp/tmp.1ZmUUcPAGT (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ZnoxRGS4qp (size 128 KB) containing data sent by client
Created /tmp/tmp.1ZmUUcPAGT (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

266

Created /tmp/tmp.FEawmUQ69Z (size 1 KB) containing data sent by client
Created /tmp/tmp.6K2tF4UJsA (size 1 KB) containing data sent by server
Created /tmp/tmp.xke94arE88 (size 1024 KB) containing data sent by client
Created /tmp/tmp.cH6b1UsQz1 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.xke94arE88 (size 128 KB) containing data sent by client
Created /tmp/tmp.cH6b1UsQz1 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

267

Created /tmp/tmp.Fr1Ins3CoJ (size 1 KB) containing data sent by client
Created /tmp/tmp.PqDYPwIZRK (size 1 KB) containing data sent by server
Created /tmp/tmp.QzF4FJX5EL (size 1024 KB) containing data sent by client
Created /tmp/tmp.9QeoD0NODP (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.QzF4FJX5EL (size 128 KB) containing data sent by client
Created /tmp/tmp.9QeoD0NODP (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

268

Created /tmp/tmp.B71XH49M4B (size 1 KB) containing data sent by client
Created /tmp/tmp.CEq3RY3PZE (size 1 KB) containing data sent by server
Created /tmp/tmp.YR0S4eywA8 (size 1024 KB) containing data sent by client
Created /tmp/tmp.7JgHAPuQQv (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.YR0S4eywA8 (size 128 KB) containing data sent by client
Created /tmp/tmp.7JgHAPuQQv (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

269

Created /tmp/tmp.MGTt98m53n (size 1 KB) containing data sent by client
Created /tmp/tmp.kdjE7WqJQH (size 1 KB) containing data sent by server
Created /tmp/tmp.h14EMecLsz (size 1024 KB) containing data sent by client
Created /tmp/tmp.1Sbubr6NRa (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.h14EMecLsz (size 128 KB) containing data sent by client
Created /tmp/tmp.1Sbubr6NRa (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

270

Created /tmp/tmp.mntHuyx8jb (size 1 KB) containing data sent by client
Created /tmp/tmp.niympDQDU6 (size 1 KB) containing data sent by server
Created /tmp/tmp.EIFakDi4uQ (size 1024 KB) containing data sent by client
Created /tmp/tmp.AUjzxwaAMs (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.EIFakDi4uQ (size 128 KB) containing data sent by client
Created /tmp/tmp.AUjzxwaAMs (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

271

Created /tmp/tmp.zdiAfssxqU (size 1 KB) containing data sent by client
Created /tmp/tmp.DJF8wUXGL1 (size 1 KB) containing data sent by server
Created /tmp/tmp.jTxTbdyjq2 (size 1024 KB) containing data sent by client
Created /tmp/tmp.sohgTb6wKM (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.jTxTbdyjq2 (size 128 KB) containing data sent by client
Created /tmp/tmp.sohgTb6wKM (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

272

Created /tmp/tmp.ypLdOn2wJc (size 1 KB) containing data sent by client
Created /tmp/tmp.W3WUXf3sl4 (size 1 KB) containing data sent by server
Created /tmp/tmp.H69yunKwFu (size 1024 KB) containing data sent by client
Created /tmp/tmp.wu9kTDvjcl (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.H69yunKwFu (size 128 KB) containing data sent by client
Created /tmp/tmp.wu9kTDvjcl (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

273

Created /tmp/tmp.qWxD42TVKV (size 1 KB) containing data sent by client
Created /tmp/tmp.yN7qsPg45t (size 1 KB) containing data sent by server
Created /tmp/tmp.zF5v7dHIAz (size 1024 KB) containing data sent by client
Created /tmp/tmp.xI09Q1yojI (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.zF5v7dHIAz (size 128 KB) containing data sent by client
Created /tmp/tmp.xI09Q1yojI (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

274

Created /tmp/tmp.uVqTCI2Xjo (size 1 KB) containing data sent by client
Created /tmp/tmp.GJDKMsBsZk (size 1 KB) containing data sent by server
Created /tmp/tmp.8WSOb4kUaP (size 1024 KB) containing data sent by client
Created /tmp/tmp.spEadOD2fK (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.8WSOb4kUaP (size 128 KB) containing data sent by client
Created /tmp/tmp.spEadOD2fK (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

275

Created /tmp/tmp.UDukaIty4F (size 1 KB) containing data sent by client
Created /tmp/tmp.RjTtkUlUCv (size 1 KB) containing data sent by server
Created /tmp/tmp.dGDOGmFSwn (size 1024 KB) containing data sent by client
Created /tmp/tmp.yRIzLavALs (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.dGDOGmFSwn (size 128 KB) containing data sent by client
Created /tmp/tmp.yRIzLavALs (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

276

Created /tmp/tmp.Xq12Eyseli (size 1 KB) containing data sent by client
Created /tmp/tmp.1LOcWczP91 (size 1 KB) containing data sent by server
Created /tmp/tmp.0HBQgObKlJ (size 1024 KB) containing data sent by client
Created /tmp/tmp.ES5TBnp6OP (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.0HBQgObKlJ (size 128 KB) containing data sent by client
Created /tmp/tmp.ES5TBnp6OP (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

277

Created /tmp/tmp.4VBaHwW9o5 (size 1 KB) containing data sent by client
Created /tmp/tmp.DyQQQKQflo (size 1 KB) containing data sent by server
Created /tmp/tmp.wCHE24Wjjn (size 1024 KB) containing data sent by client
Created /tmp/tmp.kN2oCMpSXa (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.wCHE24Wjjn (size 128 KB) containing data sent by client
Created /tmp/tmp.kN2oCMpSXa (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

278

Created /tmp/tmp.eTc8u009rZ (size 1 KB) containing data sent by client
Created /tmp/tmp.9X29YwMKWf (size 1 KB) containing data sent by server
Created /tmp/tmp.Y51jsR1Kcu (size 1024 KB) containing data sent by client
Created /tmp/tmp.YAXwu9NK9J (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Y51jsR1Kcu (size 128 KB) containing data sent by client
Created /tmp/tmp.YAXwu9NK9J (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

279

Created /tmp/tmp.B10CDjbT5j (size 1 KB) containing data sent by client
Created /tmp/tmp.rGvhW1D5G6 (size 1 KB) containing data sent by server
Created /tmp/tmp.XJ0s22KJtx (size 1024 KB) containing data sent by client
Created /tmp/tmp.RNp0OEY9IE (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.XJ0s22KJtx (size 128 KB) containing data sent by client
Created /tmp/tmp.RNp0OEY9IE (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

280

Created /tmp/tmp.Y5ioFqi67c (size 1 KB) containing data sent by client
Created /tmp/tmp.LJyxAnfS7K (size 1 KB) containing data sent by server
Created /tmp/tmp.eunhbBOMh0 (size 1024 KB) containing data sent by client
Created /tmp/tmp.JzmYL8iuzo (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.eunhbBOMh0 (size 128 KB) containing data sent by client
Created /tmp/tmp.JzmYL8iuzo (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

281

Created /tmp/tmp.fD1yMMt2iq (size 1 KB) containing data sent by client
Created /tmp/tmp.7kfkBBw8yp (size 1 KB) containing data sent by server
Created /tmp/tmp.OHFaHEDVrY (size 1024 KB) containing data sent by client
Created /tmp/tmp.Ce1locGWAN (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.OHFaHEDVrY (size 128 KB) containing data sent by client
Created /tmp/tmp.Ce1locGWAN (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

282

Created /tmp/tmp.vgwVsWRK55 (size 1 KB) containing data sent by client
Created /tmp/tmp.23YjsGXEAQ (size 1 KB) containing data sent by server
Created /tmp/tmp.tHnyaSwsXt (size 1024 KB) containing data sent by client
Created /tmp/tmp.BLTY1a3Oei (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.tHnyaSwsXt (size 128 KB) containing data sent by client
Created /tmp/tmp.BLTY1a3Oei (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

283

Created /tmp/tmp.pe6Bvy0ZoP (size 1 KB) containing data sent by client
Created /tmp/tmp.960nG89dPc (size 1 KB) containing data sent by server
Created /tmp/tmp.HZEuEM0oGK (size 1024 KB) containing data sent by client
Created /tmp/tmp.yecOAyfvOd (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.HZEuEM0oGK (size 128 KB) containing data sent by client
Created /tmp/tmp.yecOAyfvOd (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

284

Created /tmp/tmp.BHEPXgAtMI (size 1 KB) containing data sent by client
Created /tmp/tmp.GfEIGBFCW8 (size 1 KB) containing data sent by server
Created /tmp/tmp.Jn7wu4bFcS (size 1024 KB) containing data sent by client
Created /tmp/tmp.VXyfJ1Nh5g (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Jn7wu4bFcS (size 128 KB) containing data sent by client
Created /tmp/tmp.VXyfJ1Nh5g (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

285

Created /tmp/tmp.PrgSJi3vsY (size 1 KB) containing data sent by client
Created /tmp/tmp.e7O7pTxqEY (size 1 KB) containing data sent by server
Created /tmp/tmp.ny9XjDUhqL (size 1024 KB) containing data sent by client
Created /tmp/tmp.I8EbUVAx6Z (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ny9XjDUhqL (size 128 KB) containing data sent by client
Created /tmp/tmp.I8EbUVAx6Z (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

286

Created /tmp/tmp.e3LSs5t9Hw (size 1 KB) containing data sent by client
Created /tmp/tmp.HIBjiDy0eQ (size 1 KB) containing data sent by server
Created /tmp/tmp.NjOEJiTFJy (size 1024 KB) containing data sent by client
Created /tmp/tmp.Cpvaerpk7k (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.NjOEJiTFJy (size 128 KB) containing data sent by client
Created /tmp/tmp.Cpvaerpk7k (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

287

Created /tmp/tmp.KaLgecfxQh (size 1 KB) containing data sent by client
Created /tmp/tmp.m8VGpZuwjx (size 1 KB) containing data sent by server
Created /tmp/tmp.Rz0jxEPjlf (size 1024 KB) containing data sent by client
Created /tmp/tmp.S2kirmXUJK (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Rz0jxEPjlf (size 128 KB) containing data sent by client
Created /tmp/tmp.S2kirmXUJK (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

288

Created /tmp/tmp.S5RGqpky5I (size 1 KB) containing data sent by client
Created /tmp/tmp.7E0fAVuqmG (size 1 KB) containing data sent by server
Created /tmp/tmp.WCujcF0sOz (size 1024 KB) containing data sent by client
Created /tmp/tmp.noxjAN8tD6 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.WCujcF0sOz (size 128 KB) containing data sent by client
Created /tmp/tmp.noxjAN8tD6 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

289

Created /tmp/tmp.6ygKKtkike (size 1 KB) containing data sent by client
Created /tmp/tmp.IvlRUBssRw (size 1 KB) containing data sent by server
Created /tmp/tmp.IETPcFFymP (size 1024 KB) containing data sent by client
Created /tmp/tmp.HPMqAYhIyz (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.IETPcFFymP (size 128 KB) containing data sent by client
Created /tmp/tmp.HPMqAYhIyz (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

290

Created /tmp/tmp.CDtCFZEGcm (size 1 KB) containing data sent by client
Created /tmp/tmp.tpd6e34cUQ (size 1 KB) containing data sent by server
Created /tmp/tmp.DFyrit22Yo (size 1024 KB) containing data sent by client
Created /tmp/tmp.Fvke0Elgbm (size 1024 KB) containing data sent by server
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.DFyrit22Yo (size 128 KB) containing data sent by client
Created /tmp/tmp.Fvke0Elgbm (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

291

Created /tmp/tmp.YE5O32a2gM (size 1 KB) containing data sent by client
Created /tmp/tmp.zSODnviJZK (size 1 KB) containing data sent by server
Created /tmp/tmp.Wybc40awVB (size 1024 KB) containing data sent by client
Created /tmp/tmp.OEC6CoHBZF (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Wybc40awVB (size 128 KB) containing data sent by client
Created /tmp/tmp.OEC6CoHBZF (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 2 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

292

Created /tmp/tmp.zuqt15WdFL (size 1 KB) containing data sent by client
Created /tmp/tmp.wA2eQhLB1f (size 1 KB) containing data sent by server
Created /tmp/tmp.r4XvyqdC9z (size 1024 KB) containing data sent by client
Created /tmp/tmp.nUXXUhzZOx (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.r4XvyqdC9z (size 128 KB) containing data sent by client
Created /tmp/tmp.nUXXUhzZOx (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

293

Created /tmp/tmp.o9zowDzuCX (size 1 KB) containing data sent by client
Created /tmp/tmp.DwlON19xuc (size 1 KB) containing data sent by server
Created /tmp/tmp.69bhc2oTAs (size 1024 KB) containing data sent by client
Created /tmp/tmp.gue9QJRxUt (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.69bhc2oTAs (size 128 KB) containing data sent by client
Created /tmp/tmp.gue9QJRxUt (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

294

Created /tmp/tmp.C54HIv996G (size 1 KB) containing data sent by client
Created /tmp/tmp.PGDWnuayQ4 (size 1 KB) containing data sent by server
Created /tmp/tmp.ZZBqHWkmJm (size 1024 KB) containing data sent by client
Created /tmp/tmp.jDX0xo8Fkk (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ZZBqHWkmJm (size 128 KB) containing data sent by client
Created /tmp/tmp.jDX0xo8Fkk (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

295

Created /tmp/tmp.zuQiyoXs7E (size 1 KB) containing data sent by client
Created /tmp/tmp.xxmGqdFvke (size 1 KB) containing data sent by server
Created /tmp/tmp.QwcuNCrvrn (size 1024 KB) containing data sent by client
Created /tmp/tmp.LkwRh4g6E2 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.QwcuNCrvrn (size 128 KB) containing data sent by client
Created /tmp/tmp.LkwRh4g6E2 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

296

Created /tmp/tmp.3ZND3XnGLS (size 1 KB) containing data sent by client
Created /tmp/tmp.TUW0Kn8vfh (size 1 KB) containing data sent by server
Created /tmp/tmp.tQ09LVZZ8f (size 1024 KB) containing data sent by client
Created /tmp/tmp.MjG11ChKXR (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.tQ09LVZZ8f (size 128 KB) containing data sent by client
Created /tmp/tmp.MjG11ChKXR (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

297

Created /tmp/tmp.pU5WxKSGWP (size 1 KB) containing data sent by client
Created /tmp/tmp.qQKG5UJBzM (size 1 KB) containing data sent by server
Created /tmp/tmp.GVRSfRDKuU (size 1024 KB) containing data sent by client
Created /tmp/tmp.LOShM3XMAz (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.GVRSfRDKuU (size 128 KB) containing data sent by client
Created /tmp/tmp.LOShM3XMAz (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

298

Created /tmp/tmp.bUOSWth35O (size 1 KB) containing data sent by client
Created /tmp/tmp.vNEwjFzVyo (size 1 KB) containing data sent by server
Created /tmp/tmp.Enih6DL4Jt (size 1024 KB) containing data sent by client
Created /tmp/tmp.822aqQcTnG (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Enih6DL4Jt (size 128 KB) containing data sent by client
Created /tmp/tmp.822aqQcTnG (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

299

Created /tmp/tmp.nFV2em3O4z (size 1 KB) containing data sent by client
Created /tmp/tmp.5AI0PybB8M (size 1 KB) containing data sent by server
Created /tmp/tmp.Be89MG7xa7 (size 1024 KB) containing data sent by client
Created /tmp/tmp.W6OYBVDVtW (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Be89MG7xa7 (size 128 KB) containing data sent by client
Created /tmp/tmp.W6OYBVDVtW (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

300

Created /tmp/tmp.6HTJCgdSFi (size 1 KB) containing data sent by client
Created /tmp/tmp.ZSzzIx6t2e (size 1 KB) containing data sent by server
Created /tmp/tmp.Zdy6eeNvz2 (size 1024 KB) containing data sent by client
Created /tmp/tmp.8uUfvEUOIo (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Zdy6eeNvz2 (size 128 KB) containing data sent by client
Created /tmp/tmp.8uUfvEUOIo (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

301

Created /tmp/tmp.J5SLc5i5wJ (size 1 KB) containing data sent by client
Created /tmp/tmp.hryx3Wqs4V (size 1 KB) containing data sent by server
Created /tmp/tmp.TvQ5LpdZM8 (size 1024 KB) containing data sent by client
Created /tmp/tmp.2qbcCypSni (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.TvQ5LpdZM8 (size 128 KB) containing data sent by client
Created /tmp/tmp.2qbcCypSni (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

302

Created /tmp/tmp.x5f6Cijyrn (size 1 KB) containing data sent by client
Created /tmp/tmp.Go302pktJh (size 1 KB) containing data sent by server
Created /tmp/tmp.Necj2aC9pz (size 1024 KB) containing data sent by client
Created /tmp/tmp.Qln4nrANB4 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Necj2aC9pz (size 128 KB) containing data sent by client
Created /tmp/tmp.Qln4nrANB4 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

303

Created /tmp/tmp.gZrjlOZv2a (size 1 KB) containing data sent by client
Created /tmp/tmp.JY4bVvYd3D (size 1 KB) containing data sent by server
Created /tmp/tmp.D8LE6pk09n (size 1024 KB) containing data sent by client
Created /tmp/tmp.snv2ftmSXj (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.D8LE6pk09n (size 128 KB) containing data sent by client
Created /tmp/tmp.snv2ftmSXj (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 2 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

304

Created /tmp/tmp.v126yfxBZk (size 1 KB) containing data sent by client
Created /tmp/tmp.4e35PXDmkG (size 1 KB) containing data sent by server
Created /tmp/tmp.viVT2bcTOP (size 1024 KB) containing data sent by client
Created /tmp/tmp.bJVRtEK3m3 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.viVT2bcTOP (size 128 KB) containing data sent by client
Created /tmp/tmp.bJVRtEK3m3 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 4 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

305

Created /tmp/tmp.34Xh1E56OS (size 1 KB) containing data sent by client
Created /tmp/tmp.ZFeK31c149 (size 1 KB) containing data sent by server
Created /tmp/tmp.9PXVTa46dI (size 1024 KB) containing data sent by client
Created /tmp/tmp.l1pey3S1FB (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.9PXVTa46dI (size 128 KB) containing data sent by client
Created /tmp/tmp.l1pey3S1FB (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

306

Created /tmp/tmp.RV777pCYO7 (size 1 KB) containing data sent by client
Created /tmp/tmp.gdNY2LBNZi (size 1 KB) containing data sent by server
Created /tmp/tmp.vZ6fqItmDN (size 1024 KB) containing data sent by client
Created /tmp/tmp.hG5pUIP7lX (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.vZ6fqItmDN (size 128 KB) containing data sent by client
Created /tmp/tmp.hG5pUIP7lX (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 2 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

307

Created /tmp/tmp.6fFqsAhqg7 (size 1 KB) containing data sent by client
Created /tmp/tmp.I76kW2FiKa (size 1 KB) containing data sent by server
Created /tmp/tmp.wqC7JUwe3M (size 1024 KB) containing data sent by client
Created /tmp/tmp.p5hanIF2PM (size 1024 KB) containing data sent by server
file received by server has inverted byte at 66665
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.wqC7JUwe3M (size 128 KB) containing data sent by client
Created /tmp/tmp.p5hanIF2PM (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

308

Created /tmp/tmp.P0SF1JkfEi (size 1 KB) containing data sent by client
Created /tmp/tmp.nVKecgtxJZ (size 1 KB) containing data sent by server
Created /tmp/tmp.icaTMOxnao (size 1024 KB) containing data sent by client
Created /tmp/tmp.iZFx9pqXzy (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.icaTMOxnao (size 128 KB) containing data sent by client
Created /tmp/tmp.iZFx9pqXzy (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

309

Created /tmp/tmp.ua4wU9SaLv (size 1 KB) containing data sent by client
Created /tmp/tmp.oPpbjTs3rQ (size 1 KB) containing data sent by server
Created /tmp/tmp.BhZAn05vn7 (size 1024 KB) containing data sent by client
Created /tmp/tmp.WkxWEs9tyV (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.BhZAn05vn7 (size 128 KB) containing data sent by client
Created /tmp/tmp.WkxWEs9tyV (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

310

Created /tmp/tmp.OfMI0uc1Lu (size 1 KB) containing data sent by client
Created /tmp/tmp.S8WaKONYCA (size 1 KB) containing data sent by server
Created /tmp/tmp.FvZLyuEwWD (size 1024 KB) containing data sent by client
Created /tmp/tmp.5mGtgzRR8t (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.FvZLyuEwWD (size 128 KB) containing data sent by client
Created /tmp/tmp.5mGtgzRR8t (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

311

Created /tmp/tmp.X5t5iJAuSR (size 1 KB) containing data sent by client
Created /tmp/tmp.varM7hNTtf (size 1 KB) containing data sent by server
Created /tmp/tmp.8os8bWQjRG (size 1024 KB) containing data sent by client
Created /tmp/tmp.BscCQ98deh (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.8os8bWQjRG (size 128 KB) containing data sent by client
Created /tmp/tmp.BscCQ98deh (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 3 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

312

Created /tmp/tmp.kGkbDezx9R (size 1 KB) containing data sent by client
Created /tmp/tmp.83oSlGNYdY (size 1 KB) containing data sent by server
Created /tmp/tmp.BV0GBam49m (size 1024 KB) containing data sent by client
Created /tmp/tmp.htNId1dChZ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.BV0GBam49m (size 128 KB) containing data sent by client
Created /tmp/tmp.htNId1dChZ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

313

Created /tmp/tmp.bm4oy5uUS3 (size 1 KB) containing data sent by client
Created /tmp/tmp.a5SwA2XbqP (size 1 KB) containing data sent by server
Created /tmp/tmp.S0XaKX5NlE (size 1024 KB) containing data sent by client
Created /tmp/tmp.pbkQBtqJqC (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.S0XaKX5NlE (size 128 KB) containing data sent by client
Created /tmp/tmp.pbkQBtqJqC (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

314

Created /tmp/tmp.OnakinFZJr (size 1 KB) containing data sent by client
Created /tmp/tmp.t7aa35F6KW (size 1 KB) containing data sent by server
Created /tmp/tmp.AiCZumci7u (size 1024 KB) containing data sent by client
Created /tmp/tmp.waB2hJOXAY (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.AiCZumci7u (size 128 KB) containing data sent by client
Created /tmp/tmp.waB2hJOXAY (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

315

Created /tmp/tmp.fPHv9wwTNw (size 1 KB) containing data sent by client
Created /tmp/tmp.gvg1FRAC9v (size 1 KB) containing data sent by server
Created /tmp/tmp.3R6Vij8O1v (size 1024 KB) containing data sent by client
Created /tmp/tmp.0FUwHQfRxn (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.3R6Vij8O1v (size 128 KB) containing data sent by client
Created /tmp/tmp.0FUwHQfRxn (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

316

Created /tmp/tmp.9SsfAFsnPc (size 1 KB) containing data sent by client
Created /tmp/tmp.VDKKHi6ejJ (size 1 KB) containing data sent by server
Created /tmp/tmp.H4GaYn9AYS (size 1024 KB) containing data sent by client
Created /tmp/tmp.PEspQ6HYdO (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.H4GaYn9AYS (size 128 KB) containing data sent by client
Created /tmp/tmp.PEspQ6HYdO (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

317

Created /tmp/tmp.WZaHLxRPyz (size 1 KB) containing data sent by client
Created /tmp/tmp.rxtREhFz9J (size 1 KB) containing data sent by server
Created /tmp/tmp.3VNkRLetlN (size 1024 KB) containing data sent by client
Created /tmp/tmp.4FoJcU9xY6 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.3VNkRLetlN (size 128 KB) containing data sent by client
Created /tmp/tmp.4FoJcU9xY6 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

318

Created /tmp/tmp.qfj8wpXPJE (size 1 KB) containing data sent by client
Created /tmp/tmp.8Jn60kDpl9 (size 1 KB) containing data sent by server
Created /tmp/tmp.YC6LMz2TpO (size 1024 KB) containing data sent by client
Created /tmp/tmp.6AWtXJoXEz (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.YC6LMz2TpO (size 128 KB) containing data sent by client
Created /tmp/tmp.6AWtXJoXEz (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

319

Created /tmp/tmp.uzk734pLs6 (size 1 KB) containing data sent by client
Created /tmp/tmp.8dJyDDVV6E (size 1 KB) containing data sent by server
Created /tmp/tmp.7V4E88N310 (size 1024 KB) containing data sent by client
Created /tmp/tmp.avi0UoidoX (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.7V4E88N310 (size 128 KB) containing data sent by client
Created /tmp/tmp.avi0UoidoX (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

320

Created /tmp/tmp.0hIrieFjkt (size 1 KB) containing data sent by client
Created /tmp/tmp.i6F0ofVnUd (size 1 KB) containing data sent by server
Created /tmp/tmp.Ddz3wHOcC0 (size 1024 KB) containing data sent by client
Created /tmp/tmp.mQcSYwoUw6 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Ddz3wHOcC0 (size 128 KB) containing data sent by client
Created /tmp/tmp.mQcSYwoUw6 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

321

Created /tmp/tmp.F5gsezgj2J (size 1 KB) containing data sent by client
Created /tmp/tmp.OWfdnYcGA4 (size 1 KB) containing data sent by server
Created /tmp/tmp.Rp5OAK5cIv (size 1024 KB) containing data sent by client
Created /tmp/tmp.sUngC9fhEO (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Rp5OAK5cIv (size 128 KB) containing data sent by client
Created /tmp/tmp.sUngC9fhEO (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

322

Created /tmp/tmp.tCTt9k65Zc (size 1 KB) containing data sent by client
Created /tmp/tmp.cfxsMATHPX (size 1 KB) containing data sent by server
Created /tmp/tmp.iKeXkvBWkN (size 1024 KB) containing data sent by client
Created /tmp/tmp.hvzBTxzWaa (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.iKeXkvBWkN (size 128 KB) containing data sent by client
Created /tmp/tmp.hvzBTxzWaa (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

323

Created /tmp/tmp.Xr3YKD5Mqr (size 1 KB) containing data sent by client
Created /tmp/tmp.RT4sqL6KqE (size 1 KB) containing data sent by server
Created /tmp/tmp.w8jP5OmEYG (size 1024 KB) containing data sent by client
Created /tmp/tmp.iRZeiVhgns (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71365
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.w8jP5OmEYG (size 128 KB) containing data sent by client
Created /tmp/tmp.iRZeiVhgns (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

324

Created /tmp/tmp.A9DeLG0ZQc (size 1 KB) containing data sent by client
Created /tmp/tmp.WGOEj1QZJR (size 1 KB) containing data sent by server
Created /tmp/tmp.CMMWSp0Y1P (size 1024 KB) containing data sent by client
Created /tmp/tmp.PZvNWRtuT8 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.CMMWSp0Y1P (size 128 KB) containing data sent by client
Created /tmp/tmp.PZvNWRtuT8 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

325

Created /tmp/tmp.miEZDsQDgQ (size 1 KB) containing data sent by client
Created /tmp/tmp.X6WZo2PdHp (size 1 KB) containing data sent by server
Created /tmp/tmp.VS3vVta9Aq (size 1024 KB) containing data sent by client
Created /tmp/tmp.PgQvnEianE (size 1024 KB) containing data sent by server
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.VS3vVta9Aq (size 128 KB) containing data sent by client
Created /tmp/tmp.PgQvnEianE (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

326

Created /tmp/tmp.jNX9z5XYQs (size 1 KB) containing data sent by client
Created /tmp/tmp.B6L3KAbvT6 (size 1 KB) containing data sent by server
Created /tmp/tmp.ATgSIrG3ht (size 1024 KB) containing data sent by client
Created /tmp/tmp.dIA1K5ZD5E (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ATgSIrG3ht (size 128 KB) containing data sent by client
Created /tmp/tmp.dIA1K5ZD5E (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

327

Created /tmp/tmp.oSHMH9l3bj (size 1 KB) containing data sent by client
Created /tmp/tmp.YaY1kdMb97 (size 1 KB) containing data sent by server
Created /tmp/tmp.cFcZtevMwb (size 1024 KB) containing data sent by client
Created /tmp/tmp.9IhgkTzRU5 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.cFcZtevMwb (size 128 KB) containing data sent by client
Created /tmp/tmp.9IhgkTzRU5 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

328

Created /tmp/tmp.y7Sw447tzH (size 1 KB) containing data sent by client
Created /tmp/tmp.MOD5fpDYez (size 1 KB) containing data sent by server
Created /tmp/tmp.6TFNMMQYmq (size 1024 KB) containing data sent by client
Created /tmp/tmp.0Y6XH7qGCZ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 3 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.6TFNMMQYmq (size 128 KB) containing data sent by client
Created /tmp/tmp.0Y6XH7qGCZ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

329

Created /tmp/tmp.kSPr9f2BWl (size 1 KB) containing data sent by client
Created /tmp/tmp.zfQhChd9v7 (size 1 KB) containing data sent by server
Created /tmp/tmp.BDgcBtlbMq (size 1024 KB) containing data sent by client
Created /tmp/tmp.gYjSfPexaP (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.BDgcBtlbMq (size 128 KB) containing data sent by client
Created /tmp/tmp.gYjSfPexaP (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

330

Created /tmp/tmp.RXnJu8gmCz (size 1 KB) containing data sent by client
Created /tmp/tmp.bEACaX8qSD (size 1 KB) containing data sent by server
Created /tmp/tmp.4jaeykIopp (size 1024 KB) containing data sent by client
Created /tmp/tmp.dR944HGG1h (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.4jaeykIopp (size 128 KB) containing data sent by client
Created /tmp/tmp.dR944HGG1h (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

331

Created /tmp/tmp.j76TIS40UP (size 1 KB) containing data sent by client
Created /tmp/tmp.6Ao62uJ8CI (size 1 KB) containing data sent by server
Created /tmp/tmp.WSOiWFioXd (size 1024 KB) containing data sent by client
Created /tmp/tmp.Un1qg8qHiX (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.WSOiWFioXd (size 128 KB) containing data sent by client
Created /tmp/tmp.Un1qg8qHiX (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

332

Created /tmp/tmp.nSmwwX2VJ0 (size 1 KB) containing data sent by client
Created /tmp/tmp.DnP1Ruz8bc (size 1 KB) containing data sent by server
Created /tmp/tmp.6vVTBuMXca (size 1024 KB) containing data sent by client
Created /tmp/tmp.k3tG0MPysG (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.6vVTBuMXca (size 128 KB) containing data sent by client
Created /tmp/tmp.k3tG0MPysG (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

333

Created /tmp/tmp.JMST3SFnod (size 1 KB) containing data sent by client
Created /tmp/tmp.7mE0ikE5ni (size 1 KB) containing data sent by server
Created /tmp/tmp.uryPVaVsJN (size 1024 KB) containing data sent by client
Created /tmp/tmp.9c2yzRkpZa (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.uryPVaVsJN (size 128 KB) containing data sent by client
Created /tmp/tmp.9c2yzRkpZa (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

334

Created /tmp/tmp.UcMZ1UJtoy (size 1 KB) containing data sent by client
Created /tmp/tmp.MPXdLq6naO (size 1 KB) containing data sent by server
Created /tmp/tmp.rRRX0U6Bz8 (size 1024 KB) containing data sent by client
Created /tmp/tmp.b0CRExK6A5 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.rRRX0U6Bz8 (size 128 KB) containing data sent by client
Created /tmp/tmp.b0CRExK6A5 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

335

Created /tmp/tmp.tNrNcnKkh2 (size 1 KB) containing data sent by client
Created /tmp/tmp.4jbE0aiXGl (size 1 KB) containing data sent by server
Created /tmp/tmp.jrQhoywa6w (size 1024 KB) containing data sent by client
Created /tmp/tmp.uyab2BHmYk (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.jrQhoywa6w (size 128 KB) containing data sent by client
Created /tmp/tmp.uyab2BHmYk (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

336

Created /tmp/tmp.ZDwSfZKjxD (size 1 KB) containing data sent by client
Created /tmp/tmp.SnbOl6U4QS (size 1 KB) containing data sent by server
Created /tmp/tmp.bMZAP31QUk (size 1024 KB) containing data sent by client
Created /tmp/tmp.swkTw2DcuM (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.bMZAP31QUk (size 128 KB) containing data sent by client
Created /tmp/tmp.swkTw2DcuM (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

337

Created /tmp/tmp.6tvyeP1YWi (size 1 KB) containing data sent by client
Created /tmp/tmp.KMpn3pWzFm (size 1 KB) containing data sent by server
Created /tmp/tmp.A9ZdiT8mHq (size 1024 KB) containing data sent by client
Created /tmp/tmp.vrwFObwYHa (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.A9ZdiT8mHq (size 128 KB) containing data sent by client
Created /tmp/tmp.vrwFObwYHa (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 1 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

338

Created /tmp/tmp.NlW8M4hZWM (size 1 KB) containing data sent by client
Created /tmp/tmp.59vW4TZ9Oi (size 1 KB) containing data sent by server
Created /tmp/tmp.14me3ctCXw (size 1024 KB) containing data sent by client
Created /tmp/tmp.Ue9HFW0Kab (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.14me3ctCXw (size 128 KB) containing data sent by client
Created /tmp/tmp.Ue9HFW0Kab (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

339

Created /tmp/tmp.8t0DiapFtN (size 1 KB) containing data sent by client
Created /tmp/tmp.NU8x5QXWMl (size 1 KB) containing data sent by server
Created /tmp/tmp.PFduCWr06W (size 1024 KB) containing data sent by client
Created /tmp/tmp.2L4ou4QjZJ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.PFduCWr06W (size 128 KB) containing data sent by client
Created /tmp/tmp.2L4ou4QjZJ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 3 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

340

Created /tmp/tmp.YEwtOoLO8j (size 1 KB) containing data sent by client
Created /tmp/tmp.WcSWXZ1yt7 (size 1 KB) containing data sent by server
Created /tmp/tmp.XikHwh8cGM (size 1024 KB) containing data sent by client
Created /tmp/tmp.2aZJHc4yni (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.XikHwh8cGM (size 128 KB) containing data sent by client
Created /tmp/tmp.2aZJHc4yni (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 4 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

341

Created /tmp/tmp.a1EqVsL64e (size 1 KB) containing data sent by client
Created /tmp/tmp.95oiX0NFOL (size 1 KB) containing data sent by server
Created /tmp/tmp.krSMSjq90j (size 1024 KB) containing data sent by client
Created /tmp/tmp.wWpa350nO9 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.krSMSjq90j (size 128 KB) containing data sent by client
Created /tmp/tmp.wWpa350nO9 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

342

Created /tmp/tmp.yJK4E3ejLq (size 1 KB) containing data sent by client
Created /tmp/tmp.xb7FsHepE6 (size 1 KB) containing data sent by server
Created /tmp/tmp.tgvMVp2xOH (size 1024 KB) containing data sent by client
Created /tmp/tmp.kvI1haL9mf (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.tgvMVp2xOH (size 128 KB) containing data sent by client
Created /tmp/tmp.kvI1haL9mf (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

343

Created /tmp/tmp.SqwHxXDLHH (size 1 KB) containing data sent by client
Created /tmp/tmp.gUkjSA4MQt (size 1 KB) containing data sent by server
Created /tmp/tmp.8S7Yb3Vavs (size 1024 KB) containing data sent by client
Created /tmp/tmp.kSFwI0Mwte (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.8S7Yb3Vavs (size 128 KB) containing data sent by client
Created /tmp/tmp.kSFwI0Mwte (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 2 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

344

Created /tmp/tmp.xYePU8reYj (size 1 KB) containing data sent by client
Created /tmp/tmp.zsBmV99HHE (size 1 KB) containing data sent by server
Created /tmp/tmp.9xNm6SuSep (size 1024 KB) containing data sent by client
Created /tmp/tmp.Fyflpaabuj (size 1024 KB) containing data sent by server
TcpPassiveOpens                 2                  0.0
TcpEstabResets                  2                  0.0
TcpInSegs                       25                 0.0
TcpOutSegs                      75                 0.0
TcpOutRsts                      8                  0.0
TcpExtTCPPureAcks               7                  0.0
TcpExtTCPLossProbes             1                  0.0
TcpExtTCPRcvCoalesce            1                  0.0
TcpExtTCPAutoCorking            1                  0.0
TcpExtTCPOrigDataSent           58                 0.0
TcpExtTCPDelivered              31                 0.0
MPTcpExtMPCapableSYNRX          1                  0.0
MPTcpExtMPCapableACKRX          1                  0.0
MPTcpExtMPJoinSynRx             1                  0.0
MPTcpExtMPJoinAckRx             1                  0.0
MPTcpExtDataCsumErr             2                  0.0
MPTcpExtMPFailTx                2                  0.0
MPTcpExtMPRstTx                 2                  0.0
TcpActiveOpens                  2                  0.0
TcpEstabResets                  2                  0.0
TcpInSegs                       32                 0.0
TcpOutSegs                      69                 0.0
TcpExtTCPPureAcks               7                  0.0
TcpExtTCPOrigDataSent           55                 0.0
TcpExtTCPDelivered              28                 0.0
MPTcpExtMPCapableSYNTX          1                  0.0
MPTcpExtMPCapableSYNACKRX       1                  0.0
MPTcpExtMPTCPRetrans            1                  0.0
MPTcpExtMPJoinSynAckRx          1                  0.0
MPTcpExtOFOQueueTail            1                  0.0
MPTcpExtOFOQueue                2                  0.0
MPTcpExtMPFailRx                2                  0.0
MPTcpExtMPRstRx                 2                  0.0
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[fail] got 2 data checksum error[s] expected 1
 - csum  [ ok ]
Server ns stats
TcpPassiveOpens                 2                  0.0
TcpEstabResets                  2                  0.0
TcpInSegs                       25                 0.0
TcpOutSegs                      75                 0.0
TcpOutRsts                      8                  0.0
TcpExtTCPPureAcks               7                  0.0
TcpExtTCPLossProbes             1                  0.0
TcpExtTCPRcvCoalesce            1                  0.0
TcpExtTCPAutoCorking            1                  0.0
TcpExtTCPOrigDataSent           58                 0.0
TcpExtTCPDelivered              31                 0.0
MPTcpExtMPCapableSYNRX          1                  0.0
MPTcpExtMPCapableACKRX          1                  0.0
MPTcpExtMPJoinSynRx             1                  0.0
MPTcpExtMPJoinAckRx             1                  0.0
MPTcpExtDataCsumErr             2                  0.0
MPTcpExtMPFailTx                2                  0.0
MPTcpExtMPRstTx                 2                  0.0
Client ns stats
TcpActiveOpens                  2                  0.0
TcpEstabResets                  2                  0.0
TcpInSegs                       32                 0.0
TcpOutSegs                      69                 0.0
TcpExtTCPPureAcks               7                  0.0
TcpExtTCPOrigDataSent           55                 0.0
TcpExtTCPDelivered              28                 0.0
MPTcpExtMPCapableSYNTX          1                  0.0
MPTcpExtMPCapableSYNACKRX       1                  0.0
MPTcpExtMPTCPRetrans            1                  0.0
MPTcpExtMPJoinSynAckRx          1                  0.0
MPTcpExtOFOQueueTail            1                  0.0
MPTcpExtOFOQueue                2                  0.0
MPTcpExtMPFailRx                2                  0.0
MPTcpExtMPRstRx                 2                  0.0
                                         ftx[fail] got 2 MP_FAIL[s] TX expected 1
 - failrx[fail] got 2 MP_FAIL[s] RX expected 1
Server ns stats
TcpPassiveOpens                 2                  0.0
TcpEstabResets                  2                  0.0
TcpInSegs                       25                 0.0
TcpOutSegs                      75                 0.0
TcpOutRsts                      8                  0.0
TcpExtTCPPureAcks               7                  0.0
TcpExtTCPLossProbes             1                  0.0
TcpExtTCPRcvCoalesce            1                  0.0
TcpExtTCPAutoCorking            1                  0.0
TcpExtTCPOrigDataSent           58                 0.0
TcpExtTCPDelivered              31                 0.0
MPTcpExtMPCapableSYNRX          1                  0.0
MPTcpExtMPCapableACKRX          1                  0.0
MPTcpExtMPJoinSynRx             1                  0.0
MPTcpExtMPJoinAckRx             1                  0.0
MPTcpExtDataCsumErr             2                  0.0
MPTcpExtMPFailTx                2                  0.0
MPTcpExtMPRstTx                 2                  0.0
Client ns stats
TcpActiveOpens                  2                  0.0
TcpEstabResets                  2                  0.0
TcpInSegs                       32                 0.0
TcpOutSegs                      69                 0.0
TcpExtTCPPureAcks               7                  0.0
TcpExtTCPOrigDataSent           55                 0.0
TcpExtTCPDelivered              28                 0.0
MPTcpExtMPCapableSYNTX          1                  0.0
MPTcpExtMPCapableSYNACKRX       1                  0.0
MPTcpExtMPTCPRetrans            1                  0.0
MPTcpExtMPJoinSynAckRx          1                  0.0
MPTcpExtOFOQueueTail            1                  0.0
MPTcpExtOFOQueue                2                  0.0
MPTcpExtMPFailRx                2                  0.0
MPTcpExtMPRstRx                 2                  0.0
                                         rtx[fail] got 2 MP_RST[s] TX expected 1
 - rstrx [fail] got 2 MP_RST[s] RX expected 1
Server ns stats
TcpPassiveOpens                 2                  0.0
TcpEstabResets                  2                  0.0
TcpInSegs                       25                 0.0
TcpOutSegs                      75                 0.0
TcpOutRsts                      8                  0.0
TcpExtTCPPureAcks               7                  0.0
TcpExtTCPLossProbes             1                  0.0
TcpExtTCPRcvCoalesce            1                  0.0
TcpExtTCPAutoCorking            1                  0.0
TcpExtTCPOrigDataSent           58                 0.0
TcpExtTCPDelivered              31                 0.0
MPTcpExtMPCapableSYNRX          1                  0.0
MPTcpExtMPCapableACKRX          1                  0.0
MPTcpExtMPJoinSynRx             1                  0.0
MPTcpExtMPJoinAckRx             1                  0.0
MPTcpExtDataCsumErr             2                  0.0
MPTcpExtMPFailTx                2                  0.0
MPTcpExtMPRstTx                 2                  0.0
Client ns stats
TcpActiveOpens                  2                  0.0
TcpEstabResets                  2                  0.0
TcpInSegs                       32                 0.0
TcpOutSegs                      69                 0.0
TcpExtTCPPureAcks               7                  0.0
TcpExtTCPOrigDataSent           55                 0.0
TcpExtTCPDelivered              28                 0.0
MPTcpExtMPCapableSYNTX          1                  0.0
MPTcpExtMPCapableSYNACKRX       1                  0.0
MPTcpExtMPTCPRetrans            1                  0.0
MPTcpExtMPJoinSynAckRx          1                  0.0
MPTcpExtOFOQueueTail            1                  0.0
MPTcpExtOFOQueue                2                  0.0
MPTcpExtMPFailRx                2                  0.0
MPTcpExtMPRstRx                 2                  0.0
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.9xNm6SuSep (size 128 KB) containing data sent by client
Created /tmp/tmp.Fyflpaabuj (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
344 FAILED

345

Created /tmp/tmp.snSNTUTcvE (size 1 KB) containing data sent by client
Created /tmp/tmp.sOrTtar4Ze (size 1 KB) containing data sent by server
Created /tmp/tmp.SCMIC77HSR (size 1024 KB) containing data sent by client
Created /tmp/tmp.pI7FYvXFhp (size 1024 KB) containing data sent by server
file received by server has inverted byte at 66488
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.SCMIC77HSR (size 128 KB) containing data sent by client
Created /tmp/tmp.pI7FYvXFhp (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

346

Created /tmp/tmp.Y9kfWULJiz (size 1 KB) containing data sent by client
Created /tmp/tmp.PtucnxkTM3 (size 1 KB) containing data sent by server
Created /tmp/tmp.jXYePdddbP (size 1024 KB) containing data sent by client
Created /tmp/tmp.xtzz5ASPqq (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72389
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.jXYePdddbP (size 128 KB) containing data sent by client
Created /tmp/tmp.xtzz5ASPqq (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

347

Created /tmp/tmp.Ra7Ep2lTUI (size 1 KB) containing data sent by client
Created /tmp/tmp.Zusq2nmtYF (size 1 KB) containing data sent by server
Created /tmp/tmp.LAesUFEUEr (size 1024 KB) containing data sent by client
Created /tmp/tmp.9BAiTq2wMv (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.LAesUFEUEr (size 128 KB) containing data sent by client
Created /tmp/tmp.9BAiTq2wMv (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

348

Created /tmp/tmp.rhBWPS0oVG (size 1 KB) containing data sent by client
Created /tmp/tmp.TWCml5s1pB (size 1 KB) containing data sent by server
Created /tmp/tmp.0TPXMxXUjD (size 1024 KB) containing data sent by client
Created /tmp/tmp.2jhTtrFw2c (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.0TPXMxXUjD (size 128 KB) containing data sent by client
Created /tmp/tmp.2jhTtrFw2c (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

349

Created /tmp/tmp.5cAfMJ9aI9 (size 1 KB) containing data sent by client
Created /tmp/tmp.voaj5Zao8B (size 1 KB) containing data sent by server
Created /tmp/tmp.5HxRiYfL8Z (size 1024 KB) containing data sent by client
Created /tmp/tmp.3UvlXJDG0u (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.5HxRiYfL8Z (size 128 KB) containing data sent by client
Created /tmp/tmp.3UvlXJDG0u (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

350

Created /tmp/tmp.h7HCu6Lz9z (size 1 KB) containing data sent by client
Created /tmp/tmp.L24u8dLMUa (size 1 KB) containing data sent by server
Created /tmp/tmp.HMAIIJvd1X (size 1024 KB) containing data sent by client
Created /tmp/tmp.MhRxcJUqzu (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.HMAIIJvd1X (size 128 KB) containing data sent by client
Created /tmp/tmp.MhRxcJUqzu (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

351

Created /tmp/tmp.2ojY9wlKxp (size 1 KB) containing data sent by client
Created /tmp/tmp.xEd5heHrbO (size 1 KB) containing data sent by server
Created /tmp/tmp.gwgnvBaXF6 (size 1024 KB) containing data sent by client
Created /tmp/tmp.APTFKaWVP1 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.gwgnvBaXF6 (size 128 KB) containing data sent by client
Created /tmp/tmp.APTFKaWVP1 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

352

Created /tmp/tmp.UXRXhfXP2g (size 1 KB) containing data sent by client
Created /tmp/tmp.4mkyoYzvBk (size 1 KB) containing data sent by server
Created /tmp/tmp.X30PBF0Obt (size 1024 KB) containing data sent by client
Created /tmp/tmp.gAtcLy2IzW (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72389
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.X30PBF0Obt (size 128 KB) containing data sent by client
Created /tmp/tmp.gAtcLy2IzW (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

353

Created /tmp/tmp.oCZSHXiW6J (size 1 KB) containing data sent by client
Created /tmp/tmp.w0Xe5CgqkR (size 1 KB) containing data sent by server
Created /tmp/tmp.ajBJFH8q7J (size 1024 KB) containing data sent by client
Created /tmp/tmp.bBECc5kfmT (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ajBJFH8q7J (size 128 KB) containing data sent by client
Created /tmp/tmp.bBECc5kfmT (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

354

Created /tmp/tmp.XzoEnxb99c (size 1 KB) containing data sent by client
Created /tmp/tmp.VgWNv5cKoi (size 1 KB) containing data sent by server
Created /tmp/tmp.LyyuxpxN7u (size 1024 KB) containing data sent by client
Created /tmp/tmp.917AehLENl (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.LyyuxpxN7u (size 128 KB) containing data sent by client
Created /tmp/tmp.917AehLENl (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

355

Created /tmp/tmp.Ko3JAeZTzP (size 1 KB) containing data sent by client
Created /tmp/tmp.MfCVf9wgu8 (size 1 KB) containing data sent by server
Created /tmp/tmp.ifthkk0yuf (size 1024 KB) containing data sent by client
Created /tmp/tmp.Dz6r0rE4qn (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ifthkk0yuf (size 128 KB) containing data sent by client
Created /tmp/tmp.Dz6r0rE4qn (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

356

Created /tmp/tmp.Ku3qgzG2bw (size 1 KB) containing data sent by client
Created /tmp/tmp.5viNkRk8dn (size 1 KB) containing data sent by server
Created /tmp/tmp.d6GGQVa18W (size 1024 KB) containing data sent by client
Created /tmp/tmp.jSAuStAtsP (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.d6GGQVa18W (size 128 KB) containing data sent by client
Created /tmp/tmp.jSAuStAtsP (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

357

Created /tmp/tmp.WCdjVvqBzo (size 1 KB) containing data sent by client
Created /tmp/tmp.SDFSa4leD4 (size 1 KB) containing data sent by server
Created /tmp/tmp.plb6Y8KFmt (size 1024 KB) containing data sent by client
Created /tmp/tmp.wqm63n9NVq (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.plb6Y8KFmt (size 128 KB) containing data sent by client
Created /tmp/tmp.wqm63n9NVq (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

358

Created /tmp/tmp.ZX33kYfNhQ (size 1 KB) containing data sent by client
Created /tmp/tmp.95VE712eG0 (size 1 KB) containing data sent by server
Created /tmp/tmp.2dj4ZKiVM0 (size 1024 KB) containing data sent by client
Created /tmp/tmp.Ti66DenAJR (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72389
001 MP_FAIL MP_RST: 3 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.2dj4ZKiVM0 (size 128 KB) containing data sent by client
Created /tmp/tmp.Ti66DenAJR (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

359

Created /tmp/tmp.i7tJyL2gxZ (size 1 KB) containing data sent by client
Created /tmp/tmp.lXM5qVr106 (size 1 KB) containing data sent by server
Created /tmp/tmp.1j0ApK8AVJ (size 1024 KB) containing data sent by client
Created /tmp/tmp.fUR51fiaBM (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.1j0ApK8AVJ (size 128 KB) containing data sent by client
Created /tmp/tmp.fUR51fiaBM (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

360

Created /tmp/tmp.02IVkmUw3u (size 1 KB) containing data sent by client
Created /tmp/tmp.aohpX42LtO (size 1 KB) containing data sent by server
Created /tmp/tmp.sNawb1lXqr (size 1024 KB) containing data sent by client
Created /tmp/tmp.YU5vq5OKzs (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.sNawb1lXqr (size 128 KB) containing data sent by client
Created /tmp/tmp.YU5vq5OKzs (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

361

Created /tmp/tmp.FOp7G4LrAe (size 1 KB) containing data sent by client
Created /tmp/tmp.z5oUQ5PbWU (size 1 KB) containing data sent by server
Created /tmp/tmp.tOz5qRHDPe (size 1024 KB) containing data sent by client
Created /tmp/tmp.3SY6tXQvKY (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.tOz5qRHDPe (size 128 KB) containing data sent by client
Created /tmp/tmp.3SY6tXQvKY (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

362

Created /tmp/tmp.NNaBzEjKd6 (size 1 KB) containing data sent by client
Created /tmp/tmp.L6W7fx01Tt (size 1 KB) containing data sent by server
Created /tmp/tmp.CCJle1i6Fc (size 1024 KB) containing data sent by client
Created /tmp/tmp.TnlN2rgPzT (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.CCJle1i6Fc (size 128 KB) containing data sent by client
Created /tmp/tmp.TnlN2rgPzT (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

363

Created /tmp/tmp.vknaXoTysW (size 1 KB) containing data sent by client
Created /tmp/tmp.SicPMdb7pE (size 1 KB) containing data sent by server
Created /tmp/tmp.Ao56DtaT7S (size 1024 KB) containing data sent by client
Created /tmp/tmp.kQBzyIFIQv (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Ao56DtaT7S (size 128 KB) containing data sent by client
Created /tmp/tmp.kQBzyIFIQv (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

364

Created /tmp/tmp.9fiz5RspTn (size 1 KB) containing data sent by client
Created /tmp/tmp.yCr0uQIjWv (size 1 KB) containing data sent by server
Created /tmp/tmp.R1xcoUVOTO (size 1024 KB) containing data sent by client
Created /tmp/tmp.6loyguZ8EY (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.R1xcoUVOTO (size 128 KB) containing data sent by client
Created /tmp/tmp.6loyguZ8EY (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

365

Created /tmp/tmp.YunXl8o2hW (size 1 KB) containing data sent by client
Created /tmp/tmp.HOnt4DjvF5 (size 1 KB) containing data sent by server
Created /tmp/tmp.jr7Vyrngsk (size 1024 KB) containing data sent by client
Created /tmp/tmp.zd2nRZC7rQ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.jr7Vyrngsk (size 128 KB) containing data sent by client
Created /tmp/tmp.zd2nRZC7rQ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

366

Created /tmp/tmp.RYNeOhMQgT (size 1 KB) containing data sent by client
Created /tmp/tmp.Wf2uPQNbKd (size 1 KB) containing data sent by server
Created /tmp/tmp.Z0nNf2i8Ap (size 1024 KB) containing data sent by client
Created /tmp/tmp.xTEM0VeFzm (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Z0nNf2i8Ap (size 128 KB) containing data sent by client
Created /tmp/tmp.xTEM0VeFzm (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

367

Created /tmp/tmp.HbLhIFA1aV (size 1 KB) containing data sent by client
Created /tmp/tmp.mZxSJ8NVLO (size 1 KB) containing data sent by server
Created /tmp/tmp.cenMjyPDgo (size 1024 KB) containing data sent by client
Created /tmp/tmp.nhzNvLHfKT (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.cenMjyPDgo (size 128 KB) containing data sent by client
Created /tmp/tmp.nhzNvLHfKT (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

368

Created /tmp/tmp.PKYiUWxHgn (size 1 KB) containing data sent by client
Created /tmp/tmp.zaUtYkfNMU (size 1 KB) containing data sent by server
Created /tmp/tmp.QMCBej77s3 (size 1024 KB) containing data sent by client
Created /tmp/tmp.uhx9RaFRKc (size 1024 KB) containing data sent by server
file received by server has inverted byte at 66228
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.QMCBej77s3 (size 128 KB) containing data sent by client
Created /tmp/tmp.uhx9RaFRKc (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

369

Created /tmp/tmp.C9dJRiRyr5 (size 1 KB) containing data sent by client
Created /tmp/tmp.0KINMadVzN (size 1 KB) containing data sent by server
Created /tmp/tmp.OZ1f7mrB8l (size 1024 KB) containing data sent by client
Created /tmp/tmp.0am3ME73jw (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.OZ1f7mrB8l (size 128 KB) containing data sent by client
Created /tmp/tmp.0am3ME73jw (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

370

Created /tmp/tmp.jhez1RQQHM (size 1 KB) containing data sent by client
Created /tmp/tmp.F2sIG8Eh0g (size 1 KB) containing data sent by server
Created /tmp/tmp.CWulUIsQvC (size 1024 KB) containing data sent by client
Created /tmp/tmp.HNt2Eknqi8 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.CWulUIsQvC (size 128 KB) containing data sent by client
Created /tmp/tmp.HNt2Eknqi8 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

371

Created /tmp/tmp.kU8CYWcC19 (size 1 KB) containing data sent by client
Created /tmp/tmp.lSj3t3wN7k (size 1 KB) containing data sent by server
Created /tmp/tmp.KmwRIGmN8C (size 1024 KB) containing data sent by client
Created /tmp/tmp.28AmSnT3NH (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.KmwRIGmN8C (size 128 KB) containing data sent by client
Created /tmp/tmp.28AmSnT3NH (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

372

Created /tmp/tmp.2GfkkD3gk8 (size 1 KB) containing data sent by client
Created /tmp/tmp.DLKxmB4rbM (size 1 KB) containing data sent by server
Created /tmp/tmp.ICUPBhLXPy (size 1024 KB) containing data sent by client
Created /tmp/tmp.T4y8krULrk (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ICUPBhLXPy (size 128 KB) containing data sent by client
Created /tmp/tmp.T4y8krULrk (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

373

Created /tmp/tmp.RcFMYfPJfX (size 1 KB) containing data sent by client
Created /tmp/tmp.1657h7nTu1 (size 1 KB) containing data sent by server
Created /tmp/tmp.2QStdae0wy (size 1024 KB) containing data sent by client
Created /tmp/tmp.12hz0VFCIC (size 1024 KB) containing data sent by server
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.2QStdae0wy (size 128 KB) containing data sent by client
Created /tmp/tmp.12hz0VFCIC (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

374

Created /tmp/tmp.j8CZDtuBvG (size 1 KB) containing data sent by client
Created /tmp/tmp.ZowkfzTr98 (size 1 KB) containing data sent by server
Created /tmp/tmp.pIPi19D2I9 (size 1024 KB) containing data sent by client
Created /tmp/tmp.aIylEEsxSm (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.pIPi19D2I9 (size 128 KB) containing data sent by client
Created /tmp/tmp.aIylEEsxSm (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

375

Created /tmp/tmp.bNYEPGcyTN (size 1 KB) containing data sent by client
Created /tmp/tmp.5f9ZOKOQMA (size 1 KB) containing data sent by server
Created /tmp/tmp.r3mNDUaKa6 (size 1024 KB) containing data sent by client
Created /tmp/tmp.ROK9vCT9Xh (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 3 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.r3mNDUaKa6 (size 128 KB) containing data sent by client
Created /tmp/tmp.ROK9vCT9Xh (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

376

Created /tmp/tmp.lEXFZRmqNU (size 1 KB) containing data sent by client
Created /tmp/tmp.9XI7cHCNO5 (size 1 KB) containing data sent by server
Created /tmp/tmp.3xdwN7xCbJ (size 1024 KB) containing data sent by client
Created /tmp/tmp.envEihJtQv (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.3xdwN7xCbJ (size 128 KB) containing data sent by client
Created /tmp/tmp.envEihJtQv (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

377

Created /tmp/tmp.TXSw13fsNI (size 1 KB) containing data sent by client
Created /tmp/tmp.nIqoO2nlre (size 1 KB) containing data sent by server
Created /tmp/tmp.4aWtWULRJO (size 1024 KB) containing data sent by client
Created /tmp/tmp.5dIlpjS6L3 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.4aWtWULRJO (size 128 KB) containing data sent by client
Created /tmp/tmp.5dIlpjS6L3 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

378

Created /tmp/tmp.WHrudcnki2 (size 1 KB) containing data sent by client
Created /tmp/tmp.t8A85rduE9 (size 1 KB) containing data sent by server
Created /tmp/tmp.wPzmAjRjEW (size 1024 KB) containing data sent by client
Created /tmp/tmp.upBXq9W8lA (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.wPzmAjRjEW (size 128 KB) containing data sent by client
Created /tmp/tmp.upBXq9W8lA (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

379

Created /tmp/tmp.ZiOxppqFyg (size 1 KB) containing data sent by client
Created /tmp/tmp.CCOf6cHyUI (size 1 KB) containing data sent by server
Created /tmp/tmp.N8KEeDvSjq (size 1024 KB) containing data sent by client
Created /tmp/tmp.6SMmr6AyWV (size 1024 KB) containing data sent by server
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.N8KEeDvSjq (size 128 KB) containing data sent by client
Created /tmp/tmp.6SMmr6AyWV (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

380

Created /tmp/tmp.jFyyPeEe0W (size 1 KB) containing data sent by client
Created /tmp/tmp.Qxj5X5Nh8n (size 1 KB) containing data sent by server
Created /tmp/tmp.4flYKXDXyj (size 1024 KB) containing data sent by client
Created /tmp/tmp.nG79EPwuQK (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.4flYKXDXyj (size 128 KB) containing data sent by client
Created /tmp/tmp.nG79EPwuQK (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

381

Created /tmp/tmp.QyTsK9hUkv (size 1 KB) containing data sent by client
Created /tmp/tmp.I8R7rd9k0z (size 1 KB) containing data sent by server
Created /tmp/tmp.fgB67ZF9H8 (size 1024 KB) containing data sent by client
Created /tmp/tmp.QL8mRMzK0x (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.fgB67ZF9H8 (size 128 KB) containing data sent by client
Created /tmp/tmp.QL8mRMzK0x (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

382

Created /tmp/tmp.mZ7xV0TClm (size 1 KB) containing data sent by client
Created /tmp/tmp.xY3MQuB3gr (size 1 KB) containing data sent by server
Created /tmp/tmp.PTDNOPxeNJ (size 1024 KB) containing data sent by client
Created /tmp/tmp.yYfhtN92Ih (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.PTDNOPxeNJ (size 128 KB) containing data sent by client
Created /tmp/tmp.yYfhtN92Ih (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

383

Created /tmp/tmp.2hU7mX6X70 (size 1 KB) containing data sent by client
Created /tmp/tmp.eoWi7scsBY (size 1 KB) containing data sent by server
Created /tmp/tmp.XhwaOZejdU (size 1024 KB) containing data sent by client
Created /tmp/tmp.GVUmbJBP0g (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.XhwaOZejdU (size 128 KB) containing data sent by client
Created /tmp/tmp.GVUmbJBP0g (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

384

Created /tmp/tmp.Y5nn3wwpFH (size 1 KB) containing data sent by client
Created /tmp/tmp.zIwiLN0iv9 (size 1 KB) containing data sent by server
Created /tmp/tmp.jRq2vOjZSx (size 1024 KB) containing data sent by client
Created /tmp/tmp.ZdEcv1F2cb (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.jRq2vOjZSx (size 128 KB) containing data sent by client
Created /tmp/tmp.ZdEcv1F2cb (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

385

Created /tmp/tmp.WOQqVfWy6p (size 1 KB) containing data sent by client
Created /tmp/tmp.YM2X4wyQkN (size 1 KB) containing data sent by server
Created /tmp/tmp.kuFlpPZzyS (size 1024 KB) containing data sent by client
Created /tmp/tmp.lzH7B2tXoQ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.kuFlpPZzyS (size 128 KB) containing data sent by client
Created /tmp/tmp.lzH7B2tXoQ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

386

Created /tmp/tmp.8X9OjLkDgs (size 1 KB) containing data sent by client
Created /tmp/tmp.yczMRayffI (size 1 KB) containing data sent by server
Created /tmp/tmp.2bZsj7nUvs (size 1024 KB) containing data sent by client
Created /tmp/tmp.QsDI5Ma20J (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.2bZsj7nUvs (size 128 KB) containing data sent by client
Created /tmp/tmp.QsDI5Ma20J (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

387

Created /tmp/tmp.ZGPOkFL7wY (size 1 KB) containing data sent by client
Created /tmp/tmp.At6kE8WTzN (size 1 KB) containing data sent by server
Created /tmp/tmp.TduyJkBp1U (size 1024 KB) containing data sent by client
Created /tmp/tmp.DTVQQQBcH6 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.TduyJkBp1U (size 128 KB) containing data sent by client
Created /tmp/tmp.DTVQQQBcH6 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

388

Created /tmp/tmp.jLigp4fFpe (size 1 KB) containing data sent by client
Created /tmp/tmp.EQGEmczc7U (size 1 KB) containing data sent by server
Created /tmp/tmp.E4XRVaQwLF (size 1024 KB) containing data sent by client
Created /tmp/tmp.gnxZ7NaMtU (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.E4XRVaQwLF (size 128 KB) containing data sent by client
Created /tmp/tmp.gnxZ7NaMtU (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

389

Created /tmp/tmp.Om1VcKmNn4 (size 1 KB) containing data sent by client
Created /tmp/tmp.ATHlOdz5oe (size 1 KB) containing data sent by server
Created /tmp/tmp.VABpoBEH3c (size 1024 KB) containing data sent by client
Created /tmp/tmp.1kTT2cnWTb (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.VABpoBEH3c (size 128 KB) containing data sent by client
Created /tmp/tmp.1kTT2cnWTb (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

390

Created /tmp/tmp.mHES68gPop (size 1 KB) containing data sent by client
Created /tmp/tmp.i1WPWlj92L (size 1 KB) containing data sent by server
Created /tmp/tmp.lMTN5FjO0j (size 1024 KB) containing data sent by client
Created /tmp/tmp.EwCCCTUeeb (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.lMTN5FjO0j (size 128 KB) containing data sent by client
Created /tmp/tmp.EwCCCTUeeb (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 2 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

391

Created /tmp/tmp.K4VyWkpOHU (size 1 KB) containing data sent by client
Created /tmp/tmp.o6xOPOtFc2 (size 1 KB) containing data sent by server
Created /tmp/tmp.o3xNsyWkEj (size 1024 KB) containing data sent by client
Created /tmp/tmp.dnuFexRS8P (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.o3xNsyWkEj (size 128 KB) containing data sent by client
Created /tmp/tmp.dnuFexRS8P (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

392

Created /tmp/tmp.Yds2y5BExW (size 1 KB) containing data sent by client
Created /tmp/tmp.WMcOdkiXCM (size 1 KB) containing data sent by server
Created /tmp/tmp.kZMgduQBI4 (size 1024 KB) containing data sent by client
Created /tmp/tmp.Z4vxLolVO9 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.kZMgduQBI4 (size 128 KB) containing data sent by client
Created /tmp/tmp.Z4vxLolVO9 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

393

Created /tmp/tmp.ZGPi2j1Dw9 (size 1 KB) containing data sent by client
Created /tmp/tmp.B3pfkHNMGK (size 1 KB) containing data sent by server
Created /tmp/tmp.dkY9JJ8oRV (size 1024 KB) containing data sent by client
Created /tmp/tmp.yJj8jsVEP1 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 8261
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.dkY9JJ8oRV (size 128 KB) containing data sent by client
Created /tmp/tmp.yJj8jsVEP1 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

394

Created /tmp/tmp.RBNTLWrIzt (size 1 KB) containing data sent by client
Created /tmp/tmp.qGdfoU6tSt (size 1 KB) containing data sent by server
Created /tmp/tmp.W2ZPeyQfH7 (size 1024 KB) containing data sent by client
Created /tmp/tmp.KETTMJBWYV (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.W2ZPeyQfH7 (size 128 KB) containing data sent by client
Created /tmp/tmp.KETTMJBWYV (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

395

Created /tmp/tmp.z17f1FxAGM (size 1 KB) containing data sent by client
Created /tmp/tmp.cqQhp4Pczn (size 1 KB) containing data sent by server
Created /tmp/tmp.MR2RqVKOFK (size 1024 KB) containing data sent by client
Created /tmp/tmp.E82H55ZJgj (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.MR2RqVKOFK (size 128 KB) containing data sent by client
Created /tmp/tmp.E82H55ZJgj (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

396

Created /tmp/tmp.O2xyi4skn9 (size 1 KB) containing data sent by client
Created /tmp/tmp.tsK5K3Kwy5 (size 1 KB) containing data sent by server
Created /tmp/tmp.LA4JIRKvy6 (size 1024 KB) containing data sent by client
Created /tmp/tmp.x2zVdXapAQ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.LA4JIRKvy6 (size 128 KB) containing data sent by client
Created /tmp/tmp.x2zVdXapAQ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

397

Created /tmp/tmp.cDa6NwAbGQ (size 1 KB) containing data sent by client
Created /tmp/tmp.leQQkzNdCg (size 1 KB) containing data sent by server
Created /tmp/tmp.GL46jZ0OYJ (size 1024 KB) containing data sent by client
Created /tmp/tmp.csc8JgljEN (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.GL46jZ0OYJ (size 128 KB) containing data sent by client
Created /tmp/tmp.csc8JgljEN (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

398

Created /tmp/tmp.SigP4YJ2GY (size 1 KB) containing data sent by client
Created /tmp/tmp.itlzhcAFwE (size 1 KB) containing data sent by server
Created /tmp/tmp.AIPM4lNnR1 (size 1024 KB) containing data sent by client
Created /tmp/tmp.1y5Qnt5CFW (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.AIPM4lNnR1 (size 128 KB) containing data sent by client
Created /tmp/tmp.1y5Qnt5CFW (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

399

Created /tmp/tmp.9d8YO1rYc6 (size 1 KB) containing data sent by client
Created /tmp/tmp.myGbbxhBrb (size 1 KB) containing data sent by server
Created /tmp/tmp.HlmDO6fpYr (size 1024 KB) containing data sent by client
Created /tmp/tmp.doepWBr7zk (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.HlmDO6fpYr (size 128 KB) containing data sent by client
Created /tmp/tmp.doepWBr7zk (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

400

Created /tmp/tmp.dNmIcz9ogJ (size 1 KB) containing data sent by client
Created /tmp/tmp.b0FW4jTVSD (size 1 KB) containing data sent by server
Created /tmp/tmp.FJIVJ7fD3R (size 1024 KB) containing data sent by client
Created /tmp/tmp.P0IokUsxlE (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.FJIVJ7fD3R (size 128 KB) containing data sent by client
Created /tmp/tmp.P0IokUsxlE (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

401

Created /tmp/tmp.miTxLuYeVH (size 1 KB) containing data sent by client
Created /tmp/tmp.4lzSgtA6jL (size 1 KB) containing data sent by server
Created /tmp/tmp.XJiGXpU9i1 (size 1024 KB) containing data sent by client
Created /tmp/tmp.FcTDr6kK3k (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.XJiGXpU9i1 (size 128 KB) containing data sent by client
Created /tmp/tmp.FcTDr6kK3k (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

402

Created /tmp/tmp.zGOzYCBtSc (size 1 KB) containing data sent by client
Created /tmp/tmp.hgrwfwrIEH (size 1 KB) containing data sent by server
Created /tmp/tmp.0efL1tDhye (size 1024 KB) containing data sent by client
Created /tmp/tmp.O7vhfZE1Ih (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.0efL1tDhye (size 128 KB) containing data sent by client
Created /tmp/tmp.O7vhfZE1Ih (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

403

Created /tmp/tmp.9igB5PkJFJ (size 1 KB) containing data sent by client
Created /tmp/tmp.0x0olXnxGq (size 1 KB) containing data sent by server
Created /tmp/tmp.fbucooqrk3 (size 1024 KB) containing data sent by client
Created /tmp/tmp.DOvBPuHmCz (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.fbucooqrk3 (size 128 KB) containing data sent by client
Created /tmp/tmp.DOvBPuHmCz (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

404

Created /tmp/tmp.YAHadaO67D (size 1 KB) containing data sent by client
Created /tmp/tmp.iBJPJHjjzY (size 1 KB) containing data sent by server
Created /tmp/tmp.30n83fszdN (size 1024 KB) containing data sent by client
Created /tmp/tmp.lwSwAfgVv6 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71479
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.30n83fszdN (size 128 KB) containing data sent by client
Created /tmp/tmp.lwSwAfgVv6 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

405

Created /tmp/tmp.1GAp1FOcvL (size 1 KB) containing data sent by client
Created /tmp/tmp.KN75VHJqce (size 1 KB) containing data sent by server
Created /tmp/tmp.qyJWt06MMf (size 1024 KB) containing data sent by client
Created /tmp/tmp.KQpX8VjLnO (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.qyJWt06MMf (size 128 KB) containing data sent by client
Created /tmp/tmp.KQpX8VjLnO (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

406

Created /tmp/tmp.km9OMK8Paq (size 1 KB) containing data sent by client
Created /tmp/tmp.pceeBCGG2d (size 1 KB) containing data sent by server
Created /tmp/tmp.i8YxLeUn4Q (size 1024 KB) containing data sent by client
Created /tmp/tmp.6QsCorPD0w (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.i8YxLeUn4Q (size 128 KB) containing data sent by client
Created /tmp/tmp.6QsCorPD0w (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

407

Created /tmp/tmp.Quan9KZLGs (size 1 KB) containing data sent by client
Created /tmp/tmp.0adRqS37oq (size 1 KB) containing data sent by server
Created /tmp/tmp.e0VqUy8Hax (size 1024 KB) containing data sent by client
Created /tmp/tmp.ruwFu0N0yX (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.e0VqUy8Hax (size 128 KB) containing data sent by client
Created /tmp/tmp.ruwFu0N0yX (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

408

Created /tmp/tmp.lOnCb4LkrG (size 1 KB) containing data sent by client
Created /tmp/tmp.gEzvALurZ6 (size 1 KB) containing data sent by server
Created /tmp/tmp.6PXqc48Foa (size 1024 KB) containing data sent by client
Created /tmp/tmp.yjWc5nZKBm (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.6PXqc48Foa (size 128 KB) containing data sent by client
Created /tmp/tmp.yjWc5nZKBm (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

409

Created /tmp/tmp.hDE8gKKGCj (size 1 KB) containing data sent by client
Created /tmp/tmp.qmcboME2ja (size 1 KB) containing data sent by server
Created /tmp/tmp.Vjjz3p7qVj (size 1024 KB) containing data sent by client
Created /tmp/tmp.04kzJCxgNz (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Vjjz3p7qVj (size 128 KB) containing data sent by client
Created /tmp/tmp.04kzJCxgNz (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

410

Created /tmp/tmp.2qF9ojGOLG (size 1 KB) containing data sent by client
Created /tmp/tmp.tS99uT6VZB (size 1 KB) containing data sent by server
Created /tmp/tmp.2G7cIv306h (size 1024 KB) containing data sent by client
Created /tmp/tmp.75etPdzrT6 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.2G7cIv306h (size 128 KB) containing data sent by client
Created /tmp/tmp.75etPdzrT6 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

411

Created /tmp/tmp.iGUsY1KQ8H (size 1 KB) containing data sent by client
Created /tmp/tmp.Hz2aqXI2A8 (size 1 KB) containing data sent by server
Created /tmp/tmp.A8lOhhvnWr (size 1024 KB) containing data sent by client
Created /tmp/tmp.jdH3CV8RJ2 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.A8lOhhvnWr (size 128 KB) containing data sent by client
Created /tmp/tmp.jdH3CV8RJ2 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

412

Created /tmp/tmp.pE8DpGfGOx (size 1 KB) containing data sent by client
Created /tmp/tmp.DlUcUK7Nzn (size 1 KB) containing data sent by server
Created /tmp/tmp.rHp5mo1Mwv (size 1024 KB) containing data sent by client
Created /tmp/tmp.chTsl0yyzU (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.rHp5mo1Mwv (size 128 KB) containing data sent by client
Created /tmp/tmp.chTsl0yyzU (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

413

Created /tmp/tmp.qpG3EaPJYe (size 1 KB) containing data sent by client
Created /tmp/tmp.3vSiZgQ92w (size 1 KB) containing data sent by server
Created /tmp/tmp.jSJbP6yYjJ (size 1024 KB) containing data sent by client
Created /tmp/tmp.88ej5E8kOo (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.jSJbP6yYjJ (size 128 KB) containing data sent by client
Created /tmp/tmp.88ej5E8kOo (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

414

Created /tmp/tmp.Xet7kOh21J (size 1 KB) containing data sent by client
Created /tmp/tmp.bbVlemzgQg (size 1 KB) containing data sent by server
Created /tmp/tmp.O5gf3zohBq (size 1024 KB) containing data sent by client
Created /tmp/tmp.cdKkQh0YA6 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.O5gf3zohBq (size 128 KB) containing data sent by client
Created /tmp/tmp.cdKkQh0YA6 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

415

Created /tmp/tmp.NLbyCJ4TjA (size 1 KB) containing data sent by client
Created /tmp/tmp.37J0kP2txp (size 1 KB) containing data sent by server
Created /tmp/tmp.UYHmgH3dBQ (size 1024 KB) containing data sent by client
Created /tmp/tmp.cY4lK9ZM7c (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.UYHmgH3dBQ (size 128 KB) containing data sent by client
Created /tmp/tmp.cY4lK9ZM7c (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

416

Created /tmp/tmp.G5dzkAOtPF (size 1 KB) containing data sent by client
Created /tmp/tmp.ipjWffvdTw (size 1 KB) containing data sent by server
Created /tmp/tmp.xsoujtDwiU (size 1024 KB) containing data sent by client
Created /tmp/tmp.QEBchrCX07 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.xsoujtDwiU (size 128 KB) containing data sent by client
Created /tmp/tmp.QEBchrCX07 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 2 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

417

Created /tmp/tmp.PFF9ltgvVz (size 1 KB) containing data sent by client
Created /tmp/tmp.42rttPdgHI (size 1 KB) containing data sent by server
Created /tmp/tmp.UkCHBgiqeV (size 1024 KB) containing data sent by client
Created /tmp/tmp.bIHmhjpVXX (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.UkCHBgiqeV (size 128 KB) containing data sent by client
Created /tmp/tmp.bIHmhjpVXX (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

418

Created /tmp/tmp.Tf8cG27jxs (size 1 KB) containing data sent by client
Created /tmp/tmp.1tqmQruPwA (size 1 KB) containing data sent by server
Created /tmp/tmp.TXoTVoq0Cv (size 1024 KB) containing data sent by client
Created /tmp/tmp.BGlJhXzBYY (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.TXoTVoq0Cv (size 128 KB) containing data sent by client
Created /tmp/tmp.BGlJhXzBYY (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

419

Created /tmp/tmp.LaxbiTinTS (size 1 KB) containing data sent by client
Created /tmp/tmp.e6mnZqb8dP (size 1 KB) containing data sent by server
Created /tmp/tmp.nGC27GUEom (size 1024 KB) containing data sent by client
Created /tmp/tmp.P0WVCT6Ak1 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72389
001 MP_FAIL MP_RST: 3 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.nGC27GUEom (size 128 KB) containing data sent by client
Created /tmp/tmp.P0WVCT6Ak1 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

420

Created /tmp/tmp.E5l7eRxEk4 (size 1 KB) containing data sent by client
Created /tmp/tmp.irx5qywC5D (size 1 KB) containing data sent by server
Created /tmp/tmp.jCcdCk9BGI (size 1024 KB) containing data sent by client
Created /tmp/tmp.6tzyebddAS (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72389
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.jCcdCk9BGI (size 128 KB) containing data sent by client
Created /tmp/tmp.6tzyebddAS (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 3 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

421

Created /tmp/tmp.cklMvFCJmL (size 1 KB) containing data sent by client
Created /tmp/tmp.kOwddzNpLQ (size 1 KB) containing data sent by server
Created /tmp/tmp.8uNw7rgsPR (size 1024 KB) containing data sent by client
Created /tmp/tmp.cG83jAF63e (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.8uNw7rgsPR (size 128 KB) containing data sent by client
Created /tmp/tmp.cG83jAF63e (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

422

Created /tmp/tmp.gUjpAAl2CR (size 1 KB) containing data sent by client
Created /tmp/tmp.SrdaJa0nZG (size 1 KB) containing data sent by server
Created /tmp/tmp.CM74lMVq1B (size 1024 KB) containing data sent by client
Created /tmp/tmp.jxOyeBB4kP (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.CM74lMVq1B (size 128 KB) containing data sent by client
Created /tmp/tmp.jxOyeBB4kP (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

423

Created /tmp/tmp.TpbvVnzSbA (size 1 KB) containing data sent by client
Created /tmp/tmp.dy365FFd6L (size 1 KB) containing data sent by server
Created /tmp/tmp.gHIYDBNwvL (size 1024 KB) containing data sent by client
Created /tmp/tmp.v2BOArFJgK (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.gHIYDBNwvL (size 128 KB) containing data sent by client
Created /tmp/tmp.v2BOArFJgK (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

424

Created /tmp/tmp.y4u7s4pxNc (size 1 KB) containing data sent by client
Created /tmp/tmp.bXFAdTHTNU (size 1 KB) containing data sent by server
Created /tmp/tmp.etb3o6RUys (size 1024 KB) containing data sent by client
Created /tmp/tmp.rRrS9aGSkw (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.etb3o6RUys (size 128 KB) containing data sent by client
Created /tmp/tmp.rRrS9aGSkw (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 3 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

425

Created /tmp/tmp.6FiiNtEbBK (size 1 KB) containing data sent by client
Created /tmp/tmp.WsTqliNGJ1 (size 1 KB) containing data sent by server
Created /tmp/tmp.S0RVXJgHgb (size 1024 KB) containing data sent by client
Created /tmp/tmp.oh2dV4TlCQ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.S0RVXJgHgb (size 128 KB) containing data sent by client
Created /tmp/tmp.oh2dV4TlCQ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

426

Created /tmp/tmp.ejwj6jD1Ew (size 1 KB) containing data sent by client
Created /tmp/tmp.ld7H6UQoHR (size 1 KB) containing data sent by server
Created /tmp/tmp.bkjj8ZFf1B (size 1024 KB) containing data sent by client
Created /tmp/tmp.qidpxUfCAJ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.bkjj8ZFf1B (size 128 KB) containing data sent by client
Created /tmp/tmp.qidpxUfCAJ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

427

Created /tmp/tmp.9oLdycNndr (size 1 KB) containing data sent by client
Created /tmp/tmp.AKFR4cgtUP (size 1 KB) containing data sent by server
Created /tmp/tmp.IkV9Fv03qM (size 1024 KB) containing data sent by client
Created /tmp/tmp.oKyBdJLYGX (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.IkV9Fv03qM (size 128 KB) containing data sent by client
Created /tmp/tmp.oKyBdJLYGX (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

428

Created /tmp/tmp.GtEVjnhCiZ (size 1 KB) containing data sent by client
Created /tmp/tmp.x9NvWRqebn (size 1 KB) containing data sent by server
Created /tmp/tmp.iyinMr5S4O (size 1024 KB) containing data sent by client
Created /tmp/tmp.LpZ353O3cB (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.iyinMr5S4O (size 128 KB) containing data sent by client
Created /tmp/tmp.LpZ353O3cB (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

429

Created /tmp/tmp.uGxAoK2bcf (size 1 KB) containing data sent by client
Created /tmp/tmp.CXYWNQw6YB (size 1 KB) containing data sent by server
Created /tmp/tmp.coOk0TDUj2 (size 1024 KB) containing data sent by client
Created /tmp/tmp.AVw84BvHR9 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 3 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.coOk0TDUj2 (size 128 KB) containing data sent by client
Created /tmp/tmp.AVw84BvHR9 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

430

Created /tmp/tmp.GUBmIdZeZn (size 1 KB) containing data sent by client
Created /tmp/tmp.J7kPMZ9vqV (size 1 KB) containing data sent by server
Created /tmp/tmp.ZNTD514fz2 (size 1024 KB) containing data sent by client
Created /tmp/tmp.MeBdBUQhEk (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ZNTD514fz2 (size 128 KB) containing data sent by client
Created /tmp/tmp.MeBdBUQhEk (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

431

Created /tmp/tmp.zaNkqdW3gV (size 1 KB) containing data sent by client
Created /tmp/tmp.SX1lRoQOdP (size 1 KB) containing data sent by server
Created /tmp/tmp.6Z8ZSP0gLG (size 1024 KB) containing data sent by client
Created /tmp/tmp.x9nLttMP4D (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.6Z8ZSP0gLG (size 128 KB) containing data sent by client
Created /tmp/tmp.x9nLttMP4D (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

432

Created /tmp/tmp.Cx83BvHlF5 (size 1 KB) containing data sent by client
Created /tmp/tmp.iPKTuVdvyn (size 1 KB) containing data sent by server
Created /tmp/tmp.ZRXRGf38ZH (size 1024 KB) containing data sent by client
Created /tmp/tmp.xzA59YsQzv (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ZRXRGf38ZH (size 128 KB) containing data sent by client
Created /tmp/tmp.xzA59YsQzv (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

433

Created /tmp/tmp.OBCctrSxt7 (size 1 KB) containing data sent by client
Created /tmp/tmp.6202Tologt (size 1 KB) containing data sent by server
Created /tmp/tmp.mDwpSBZvWd (size 1024 KB) containing data sent by client
Created /tmp/tmp.ThUqItgGkJ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.mDwpSBZvWd (size 128 KB) containing data sent by client
Created /tmp/tmp.ThUqItgGkJ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

434

Created /tmp/tmp.2sczH3YXjq (size 1 KB) containing data sent by client
Created /tmp/tmp.ZjR3QyZciA (size 1 KB) containing data sent by server
Created /tmp/tmp.XKetQdEgkM (size 1024 KB) containing data sent by client
Created /tmp/tmp.HBVJQXlmUn (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.XKetQdEgkM (size 128 KB) containing data sent by client
Created /tmp/tmp.HBVJQXlmUn (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

435

Created /tmp/tmp.6mLQCMO5xE (size 1 KB) containing data sent by client
Created /tmp/tmp.KzdDlcIjWQ (size 1 KB) containing data sent by server
Created /tmp/tmp.5O4IHChz0x (size 1024 KB) containing data sent by client
Created /tmp/tmp.21DSpAlA1D (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.5O4IHChz0x (size 128 KB) containing data sent by client
Created /tmp/tmp.21DSpAlA1D (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

436

Created /tmp/tmp.uR2gEqXSbj (size 1 KB) containing data sent by client
Created /tmp/tmp.S9GjnFPLsX (size 1 KB) containing data sent by server
Created /tmp/tmp.xAbWPJSMzz (size 1024 KB) containing data sent by client
Created /tmp/tmp.hU9i4o0T2s (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.xAbWPJSMzz (size 128 KB) containing data sent by client
Created /tmp/tmp.hU9i4o0T2s (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

437

Created /tmp/tmp.ok0KZZAMzc (size 1 KB) containing data sent by client
Created /tmp/tmp.TdGkZWFzKi (size 1 KB) containing data sent by server
Created /tmp/tmp.bDt8PV0HEP (size 1024 KB) containing data sent by client
Created /tmp/tmp.ho1RBlwxK1 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.bDt8PV0HEP (size 128 KB) containing data sent by client
Created /tmp/tmp.ho1RBlwxK1 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

438

Created /tmp/tmp.VIbOOHIivC (size 1 KB) containing data sent by client
Created /tmp/tmp.X1tLjlm8dS (size 1 KB) containing data sent by server
Created /tmp/tmp.nkogUlRe81 (size 1024 KB) containing data sent by client
Created /tmp/tmp.b0Lof9CiPn (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.nkogUlRe81 (size 128 KB) containing data sent by client
Created /tmp/tmp.b0Lof9CiPn (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

439

Created /tmp/tmp.cAuecSRa1g (size 1 KB) containing data sent by client
Created /tmp/tmp.4EcpARrYsF (size 1 KB) containing data sent by server
Created /tmp/tmp.Fe6sHjMHIm (size 1024 KB) containing data sent by client
Created /tmp/tmp.0r1T1ie8R9 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Fe6sHjMHIm (size 128 KB) containing data sent by client
Created /tmp/tmp.0r1T1ie8R9 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

440

Created /tmp/tmp.cEC0BBXwn7 (size 1 KB) containing data sent by client
Created /tmp/tmp.D8nuMMswct (size 1 KB) containing data sent by server
Created /tmp/tmp.J7wADeholk (size 1024 KB) containing data sent by client
Created /tmp/tmp.NhhC7gO5l8 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.J7wADeholk (size 128 KB) containing data sent by client
Created /tmp/tmp.NhhC7gO5l8 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 1 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

441

Created /tmp/tmp.N90YIncPcA (size 1 KB) containing data sent by client
Created /tmp/tmp.IiPq8WZL7i (size 1 KB) containing data sent by server
Created /tmp/tmp.KS9NazehX4 (size 1024 KB) containing data sent by client
Created /tmp/tmp.3V1XIoWSwO (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.KS9NazehX4 (size 128 KB) containing data sent by client
Created /tmp/tmp.3V1XIoWSwO (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

442

Created /tmp/tmp.jlh78l490y (size 1 KB) containing data sent by client
Created /tmp/tmp.Mp56CcYJy9 (size 1 KB) containing data sent by server
Created /tmp/tmp.o8DWLgB5tw (size 1024 KB) containing data sent by client
Created /tmp/tmp.fkQ7YQOWQQ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.o8DWLgB5tw (size 128 KB) containing data sent by client
Created /tmp/tmp.fkQ7YQOWQQ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

443

Created /tmp/tmp.3HtSAr3jqG (size 1 KB) containing data sent by client
Created /tmp/tmp.mx1ztrfrnr (size 1 KB) containing data sent by server
Created /tmp/tmp.83JFPjCP2B (size 1024 KB) containing data sent by client
Created /tmp/tmp.mERW3rRS6u (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.83JFPjCP2B (size 128 KB) containing data sent by client
Created /tmp/tmp.mERW3rRS6u (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

444

Created /tmp/tmp.0SJb9S7DhA (size 1 KB) containing data sent by client
Created /tmp/tmp.jAcf1hBcxl (size 1 KB) containing data sent by server
Created /tmp/tmp.qnzvuoatfv (size 1024 KB) containing data sent by client
Created /tmp/tmp.GhMnLka8tH (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.qnzvuoatfv (size 128 KB) containing data sent by client
Created /tmp/tmp.GhMnLka8tH (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

445

Created /tmp/tmp.75BR954ZEC (size 1 KB) containing data sent by client
Created /tmp/tmp.FbO264uatd (size 1 KB) containing data sent by server
Created /tmp/tmp.IThlurlXHE (size 1024 KB) containing data sent by client
Created /tmp/tmp.ND5YwD1XjE (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.IThlurlXHE (size 128 KB) containing data sent by client
Created /tmp/tmp.ND5YwD1XjE (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

446

Created /tmp/tmp.q5fl4mviQm (size 1 KB) containing data sent by client
Created /tmp/tmp.2xqRlqvWL6 (size 1 KB) containing data sent by server
Created /tmp/tmp.SKlGxTxAhT (size 1024 KB) containing data sent by client
Created /tmp/tmp.wpbw17GDgp (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.SKlGxTxAhT (size 128 KB) containing data sent by client
Created /tmp/tmp.wpbw17GDgp (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

447

Created /tmp/tmp.g2IMkUhUUc (size 1 KB) containing data sent by client
Created /tmp/tmp.eTnPcnQmLm (size 1 KB) containing data sent by server
Created /tmp/tmp.2t4NOoTJ5N (size 1024 KB) containing data sent by client
Created /tmp/tmp.LU8kAFiurb (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.2t4NOoTJ5N (size 128 KB) containing data sent by client
Created /tmp/tmp.LU8kAFiurb (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

448

Created /tmp/tmp.DddzmHF55w (size 1 KB) containing data sent by client
Created /tmp/tmp.ZaeHr74Whv (size 1 KB) containing data sent by server
Created /tmp/tmp.5G77PPV4kr (size 1024 KB) containing data sent by client
Created /tmp/tmp.DF6GmvBJu7 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.5G77PPV4kr (size 128 KB) containing data sent by client
Created /tmp/tmp.DF6GmvBJu7 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

449

Created /tmp/tmp.HOkbhJjfk7 (size 1 KB) containing data sent by client
Created /tmp/tmp.SbkfpiYD7d (size 1 KB) containing data sent by server
Created /tmp/tmp.YnwDjpYLS4 (size 1024 KB) containing data sent by client
Created /tmp/tmp.jm2X7u9FI1 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.YnwDjpYLS4 (size 128 KB) containing data sent by client
Created /tmp/tmp.jm2X7u9FI1 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

450

Created /tmp/tmp.Izt2Eq5uUM (size 1 KB) containing data sent by client
Created /tmp/tmp.pIOjp1dxh7 (size 1 KB) containing data sent by server
Created /tmp/tmp.LhNnIZ9pTU (size 1024 KB) containing data sent by client
Created /tmp/tmp.t0Z3WLaCHj (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.LhNnIZ9pTU (size 128 KB) containing data sent by client
Created /tmp/tmp.t0Z3WLaCHj (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 3 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

451

Created /tmp/tmp.NwxTIT9KLx (size 1 KB) containing data sent by client
Created /tmp/tmp.za0HKNLFhC (size 1 KB) containing data sent by server
Created /tmp/tmp.WR3HEx4Wz9 (size 1024 KB) containing data sent by client
Created /tmp/tmp.KqAF5cJNWh (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.WR3HEx4Wz9 (size 128 KB) containing data sent by client
Created /tmp/tmp.KqAF5cJNWh (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 4 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

452

Created /tmp/tmp.nTJMbh10Wx (size 1 KB) containing data sent by client
Created /tmp/tmp.GOH2QI7OXq (size 1 KB) containing data sent by server
Created /tmp/tmp.86h5nRwnrT (size 1024 KB) containing data sent by client
Created /tmp/tmp.4c354tCzfm (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.86h5nRwnrT (size 128 KB) containing data sent by client
Created /tmp/tmp.4c354tCzfm (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

453

Created /tmp/tmp.f7NNYduNhT (size 1 KB) containing data sent by client
Created /tmp/tmp.uTimRo3D4R (size 1 KB) containing data sent by server
Created /tmp/tmp.ZsEBcbFVgF (size 1024 KB) containing data sent by client
Created /tmp/tmp.BcDh0uMdKX (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ZsEBcbFVgF (size 128 KB) containing data sent by client
Created /tmp/tmp.BcDh0uMdKX (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 4 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

454

Created /tmp/tmp.sTBrBIE34p (size 1 KB) containing data sent by client
Created /tmp/tmp.q1xvwd73QJ (size 1 KB) containing data sent by server
Created /tmp/tmp.LvY0dx6J4x (size 1024 KB) containing data sent by client
Created /tmp/tmp.OCzxie1WbI (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.LvY0dx6J4x (size 128 KB) containing data sent by client
Created /tmp/tmp.OCzxie1WbI (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

455

Created /tmp/tmp.7cKSMVttrH (size 1 KB) containing data sent by client
Created /tmp/tmp.89cEnCRzle (size 1 KB) containing data sent by server
Created /tmp/tmp.7OEtzMma7M (size 1024 KB) containing data sent by client
Created /tmp/tmp.Pm4wCfaCn7 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.7OEtzMma7M (size 128 KB) containing data sent by client
Created /tmp/tmp.Pm4wCfaCn7 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

456

Created /tmp/tmp.dYsMdswoJy (size 1 KB) containing data sent by client
Created /tmp/tmp.iHXRRoOxd0 (size 1 KB) containing data sent by server
Created /tmp/tmp.v2IGYf7OsU (size 1024 KB) containing data sent by client
Created /tmp/tmp.vEUEoNaiav (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 3 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.v2IGYf7OsU (size 128 KB) containing data sent by client
Created /tmp/tmp.vEUEoNaiav (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

457

Created /tmp/tmp.7Kxcvw4Wod (size 1 KB) containing data sent by client
Created /tmp/tmp.uvvSBMQzW3 (size 1 KB) containing data sent by server
Created /tmp/tmp.rIwPmIPH60 (size 1024 KB) containing data sent by client
Created /tmp/tmp.uzIcdkdry8 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.rIwPmIPH60 (size 128 KB) containing data sent by client
Created /tmp/tmp.uzIcdkdry8 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

458

Created /tmp/tmp.Zaphy2dloK (size 1 KB) containing data sent by client
Created /tmp/tmp.Ocpvlboxvg (size 1 KB) containing data sent by server
Created /tmp/tmp.EWPCGFm2SF (size 1024 KB) containing data sent by client
Created /tmp/tmp.8QCUQ8aBxm (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.EWPCGFm2SF (size 128 KB) containing data sent by client
Created /tmp/tmp.8QCUQ8aBxm (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

459

Created /tmp/tmp.DSeadnY3MZ (size 1 KB) containing data sent by client
Created /tmp/tmp.QZdcs6Pees (size 1 KB) containing data sent by server
Created /tmp/tmp.yX5z6L9BHH (size 1024 KB) containing data sent by client
Created /tmp/tmp.CfJGzjGuCz (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.yX5z6L9BHH (size 128 KB) containing data sent by client
Created /tmp/tmp.CfJGzjGuCz (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

460

Created /tmp/tmp.fQz6eNrtNv (size 1 KB) containing data sent by client
Created /tmp/tmp.wriMVPZve1 (size 1 KB) containing data sent by server
Created /tmp/tmp.sRj9ku3l63 (size 1024 KB) containing data sent by client
Created /tmp/tmp.VqTvyUN9y5 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.sRj9ku3l63 (size 128 KB) containing data sent by client
Created /tmp/tmp.VqTvyUN9y5 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

461

Created /tmp/tmp.jhBWoI3Fb1 (size 1 KB) containing data sent by client
Created /tmp/tmp.yEhH3nlBX8 (size 1 KB) containing data sent by server
Created /tmp/tmp.0ygIpwKKY3 (size 1024 KB) containing data sent by client
Created /tmp/tmp.gZ75s2JDAk (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.0ygIpwKKY3 (size 128 KB) containing data sent by client
Created /tmp/tmp.gZ75s2JDAk (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

462

Created /tmp/tmp.GRaXvekfL5 (size 1 KB) containing data sent by client
Created /tmp/tmp.TbmPS6IWoJ (size 1 KB) containing data sent by server
Created /tmp/tmp.FhhW2ohK4p (size 1024 KB) containing data sent by client
Created /tmp/tmp.UkauESJjJW (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.FhhW2ohK4p (size 128 KB) containing data sent by client
Created /tmp/tmp.UkauESJjJW (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

463

Created /tmp/tmp.PRio8aw2t3 (size 1 KB) containing data sent by client
Created /tmp/tmp.9cBrKVFXjK (size 1 KB) containing data sent by server
Created /tmp/tmp.WP8SnK7s9e (size 1024 KB) containing data sent by client
Created /tmp/tmp.udzRA5Piw5 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.WP8SnK7s9e (size 128 KB) containing data sent by client
Created /tmp/tmp.udzRA5Piw5 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

464

Created /tmp/tmp.cQEQV2qaP7 (size 1 KB) containing data sent by client
Created /tmp/tmp.xu4Iw7Vsab (size 1 KB) containing data sent by server
Created /tmp/tmp.rMR1qJ5BK5 (size 1024 KB) containing data sent by client
Created /tmp/tmp.6DDK8yHDRf (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.rMR1qJ5BK5 (size 128 KB) containing data sent by client
Created /tmp/tmp.6DDK8yHDRf (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

465

Created /tmp/tmp.TgXu02FcKA (size 1 KB) containing data sent by client
Created /tmp/tmp.5yMqOjKbyZ (size 1 KB) containing data sent by server
Created /tmp/tmp.8wVlNouj4X (size 1024 KB) containing data sent by client
Created /tmp/tmp.dNhsAstqkj (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.8wVlNouj4X (size 128 KB) containing data sent by client
Created /tmp/tmp.dNhsAstqkj (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

466

Created /tmp/tmp.3nzPMSuXuX (size 1 KB) containing data sent by client
Created /tmp/tmp.4U2shtWqyC (size 1 KB) containing data sent by server
Created /tmp/tmp.YFTW9D4YJA (size 1024 KB) containing data sent by client
Created /tmp/tmp.43TdbVFdeM (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.YFTW9D4YJA (size 128 KB) containing data sent by client
Created /tmp/tmp.43TdbVFdeM (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

467

Created /tmp/tmp.8sXzrwPQ5E (size 1 KB) containing data sent by client
Created /tmp/tmp.Cr3DUGyYZu (size 1 KB) containing data sent by server
Created /tmp/tmp.7N2PkP5vPm (size 1024 KB) containing data sent by client
Created /tmp/tmp.EPYYKxnJC5 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.7N2PkP5vPm (size 128 KB) containing data sent by client
Created /tmp/tmp.EPYYKxnJC5 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

468

Created /tmp/tmp.WsGkOuJpAf (size 1 KB) containing data sent by client
Created /tmp/tmp.h6pPjfTUsr (size 1 KB) containing data sent by server
Created /tmp/tmp.Xb6InjdGks (size 1024 KB) containing data sent by client
Created /tmp/tmp.o9xLbm6pm1 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Xb6InjdGks (size 128 KB) containing data sent by client
Created /tmp/tmp.o9xLbm6pm1 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

469

Created /tmp/tmp.woYAjcuSiQ (size 1 KB) containing data sent by client
Created /tmp/tmp.iDRcVGsRpk (size 1 KB) containing data sent by server
Created /tmp/tmp.uVAhD9qagm (size 1024 KB) containing data sent by client
Created /tmp/tmp.RCzGUwu6Bj (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.uVAhD9qagm (size 128 KB) containing data sent by client
Created /tmp/tmp.RCzGUwu6Bj (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

470

Created /tmp/tmp.ak6MlFpYny (size 1 KB) containing data sent by client
Created /tmp/tmp.WrFaopXVN0 (size 1 KB) containing data sent by server
Created /tmp/tmp.c2aeMuPItB (size 1024 KB) containing data sent by client
Created /tmp/tmp.0lSgkGcDL2 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.c2aeMuPItB (size 128 KB) containing data sent by client
Created /tmp/tmp.0lSgkGcDL2 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

471

Created /tmp/tmp.1X5NeJSq5t (size 1 KB) containing data sent by client
Created /tmp/tmp.noQlLsYwYS (size 1 KB) containing data sent by server
Created /tmp/tmp.DnD6FsLeNe (size 1024 KB) containing data sent by client
Created /tmp/tmp.5phmpdjR1z (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.DnD6FsLeNe (size 128 KB) containing data sent by client
Created /tmp/tmp.5phmpdjR1z (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

472

Created /tmp/tmp.3RGCG9iZKI (size 1 KB) containing data sent by client
Created /tmp/tmp.8KmUh8mqx9 (size 1 KB) containing data sent by server
Created /tmp/tmp.QvIHni19nW (size 1024 KB) containing data sent by client
Created /tmp/tmp.S9o3s2VmKw (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.QvIHni19nW (size 128 KB) containing data sent by client
Created /tmp/tmp.S9o3s2VmKw (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

473

Created /tmp/tmp.v7uP4aBJKV (size 1 KB) containing data sent by client
Created /tmp/tmp.FmhKSdJo39 (size 1 KB) containing data sent by server
Created /tmp/tmp.ENvEy36gsM (size 1024 KB) containing data sent by client
Created /tmp/tmp.2f71gALcSC (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ENvEy36gsM (size 128 KB) containing data sent by client
Created /tmp/tmp.2f71gALcSC (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 3 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

474

Created /tmp/tmp.kdmrAi094w (size 1 KB) containing data sent by client
Created /tmp/tmp.5S8ncMgdSC (size 1 KB) containing data sent by server
Created /tmp/tmp.aF6m5Aam1Q (size 1024 KB) containing data sent by client
Created /tmp/tmp.uhtbOFQnmJ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.aF6m5Aam1Q (size 128 KB) containing data sent by client
Created /tmp/tmp.uhtbOFQnmJ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

475

Created /tmp/tmp.Sr2Q7P2fBE (size 1 KB) containing data sent by client
Created /tmp/tmp.aet0UT6Qfe (size 1 KB) containing data sent by server
Created /tmp/tmp.FpUwBjQJkI (size 1024 KB) containing data sent by client
Created /tmp/tmp.3gbUkKChNB (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.FpUwBjQJkI (size 128 KB) containing data sent by client
Created /tmp/tmp.3gbUkKChNB (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

476

Created /tmp/tmp.3muMphHhZp (size 1 KB) containing data sent by client
Created /tmp/tmp.tiPHJI2P3k (size 1 KB) containing data sent by server
Created /tmp/tmp.u4vjBGUUy0 (size 1024 KB) containing data sent by client
Created /tmp/tmp.FHz5OOB8IU (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.u4vjBGUUy0 (size 128 KB) containing data sent by client
Created /tmp/tmp.FHz5OOB8IU (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 3 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

477

Created /tmp/tmp.IrYSeUx3AV (size 1 KB) containing data sent by client
Created /tmp/tmp.VSsKhknfQV (size 1 KB) containing data sent by server
Created /tmp/tmp.5Bj3UOcZlF (size 1024 KB) containing data sent by client
Created /tmp/tmp.H27WayUslA (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.5Bj3UOcZlF (size 128 KB) containing data sent by client
Created /tmp/tmp.H27WayUslA (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

478

Created /tmp/tmp.tX1IfeQyOL (size 1 KB) containing data sent by client
Created /tmp/tmp.SLWmQ53YKD (size 1 KB) containing data sent by server
Created /tmp/tmp.HKbFwCpZWm (size 1024 KB) containing data sent by client
Created /tmp/tmp.KCNUPScDyz (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.HKbFwCpZWm (size 128 KB) containing data sent by client
Created /tmp/tmp.KCNUPScDyz (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

479

Created /tmp/tmp.bdD3VTs0bJ (size 1 KB) containing data sent by client
Created /tmp/tmp.flvS0VmfDX (size 1 KB) containing data sent by server
Created /tmp/tmp.MRxGa3hIkP (size 1024 KB) containing data sent by client
Created /tmp/tmp.aWaEGTf8PE (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71365
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.MRxGa3hIkP (size 128 KB) containing data sent by client
Created /tmp/tmp.aWaEGTf8PE (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

480

Created /tmp/tmp.qFGQWs8d5H (size 1 KB) containing data sent by client
Created /tmp/tmp.7Vrq2Pl2D8 (size 1 KB) containing data sent by server
Created /tmp/tmp.Rwv8J3NTbr (size 1024 KB) containing data sent by client
Created /tmp/tmp.craBnMsk9K (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Rwv8J3NTbr (size 128 KB) containing data sent by client
Created /tmp/tmp.craBnMsk9K (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

481

Created /tmp/tmp.6YG7vykNGm (size 1 KB) containing data sent by client
Created /tmp/tmp.js8I0vB5DF (size 1 KB) containing data sent by server
Created /tmp/tmp.04GySqcW7W (size 1024 KB) containing data sent by client
Created /tmp/tmp.SThnwciZ2J (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65750
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.04GySqcW7W (size 128 KB) containing data sent by client
Created /tmp/tmp.SThnwciZ2J (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

482

Created /tmp/tmp.8nG2b0oC0a (size 1 KB) containing data sent by client
Created /tmp/tmp.G3aqw5ZBOF (size 1 KB) containing data sent by server
Created /tmp/tmp.3XEgwftwX3 (size 1024 KB) containing data sent by client
Created /tmp/tmp.M90zMvoi9w (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.3XEgwftwX3 (size 128 KB) containing data sent by client
Created /tmp/tmp.M90zMvoi9w (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

483

Created /tmp/tmp.YBM7HO5Ejg (size 1 KB) containing data sent by client
Created /tmp/tmp.hADTFhsdie (size 1 KB) containing data sent by server
Created /tmp/tmp.hXoY8HyaVX (size 1024 KB) containing data sent by client
Created /tmp/tmp.XJJiOFfEMO (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.hXoY8HyaVX (size 128 KB) containing data sent by client
Created /tmp/tmp.XJJiOFfEMO (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 2 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

484

Created /tmp/tmp.DPJ92lJ24x (size 1 KB) containing data sent by client
Created /tmp/tmp.qf7mpBfBGZ (size 1 KB) containing data sent by server
Created /tmp/tmp.5ZkjFhAgvI (size 1024 KB) containing data sent by client
Created /tmp/tmp.nvGpjQF8XA (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.5ZkjFhAgvI (size 128 KB) containing data sent by client
Created /tmp/tmp.nvGpjQF8XA (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

485

Created /tmp/tmp.HXzezPM3Zx (size 1 KB) containing data sent by client
Created /tmp/tmp.ezAiOR0QqK (size 1 KB) containing data sent by server
Created /tmp/tmp.IJxczQQuWO (size 1024 KB) containing data sent by client
Created /tmp/tmp.oSlZLLAexd (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.IJxczQQuWO (size 128 KB) containing data sent by client
Created /tmp/tmp.oSlZLLAexd (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

486

Created /tmp/tmp.ZtaQK4aWzb (size 1 KB) containing data sent by client
Created /tmp/tmp.o9MPuqEd7l (size 1 KB) containing data sent by server
Created /tmp/tmp.5opWGNVJC1 (size 1024 KB) containing data sent by client
Created /tmp/tmp.c2EY8duFNK (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 3 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.5opWGNVJC1 (size 128 KB) containing data sent by client
Created /tmp/tmp.c2EY8duFNK (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 2 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

487

Created /tmp/tmp.VQ2SeDW7TJ (size 1 KB) containing data sent by client
Created /tmp/tmp.Lyj4AvZBHj (size 1 KB) containing data sent by server
Created /tmp/tmp.b21gPxiH12 (size 1024 KB) containing data sent by client
Created /tmp/tmp.MblMQ2I8nW (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.b21gPxiH12 (size 128 KB) containing data sent by client
Created /tmp/tmp.MblMQ2I8nW (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

488

Created /tmp/tmp.lSWLt1d6ix (size 1 KB) containing data sent by client
Created /tmp/tmp.fzmCOMIGAI (size 1 KB) containing data sent by server
Created /tmp/tmp.ZaFaQBILO8 (size 1024 KB) containing data sent by client
Created /tmp/tmp.XLXJK2sxy1 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ZaFaQBILO8 (size 128 KB) containing data sent by client
Created /tmp/tmp.XLXJK2sxy1 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

489

Created /tmp/tmp.hyUevrQJGw (size 1 KB) containing data sent by client
Created /tmp/tmp.MrtJSLeS2r (size 1 KB) containing data sent by server
Created /tmp/tmp.XzniVlwPTC (size 1024 KB) containing data sent by client
Created /tmp/tmp.Je4cxwVCNC (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.XzniVlwPTC (size 128 KB) containing data sent by client
Created /tmp/tmp.Je4cxwVCNC (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

490

Created /tmp/tmp.rOpfKIF8Na (size 1 KB) containing data sent by client
Created /tmp/tmp.ia0nwFJ73w (size 1 KB) containing data sent by server
Created /tmp/tmp.UElqqFjocI (size 1024 KB) containing data sent by client
Created /tmp/tmp.AdchhmOs7v (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.UElqqFjocI (size 128 KB) containing data sent by client
Created /tmp/tmp.AdchhmOs7v (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

491

Created /tmp/tmp.bUGpYFQ8YL (size 1 KB) containing data sent by client
Created /tmp/tmp.nMTN6zNGqE (size 1 KB) containing data sent by server
Created /tmp/tmp.KRtpes2MRN (size 1024 KB) containing data sent by client
Created /tmp/tmp.tvd8JHRTuQ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.KRtpes2MRN (size 128 KB) containing data sent by client
Created /tmp/tmp.tvd8JHRTuQ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 3 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

492

Created /tmp/tmp.qw2Z45pNpJ (size 1 KB) containing data sent by client
Created /tmp/tmp.3IiI9eA2eg (size 1 KB) containing data sent by server
Created /tmp/tmp.g5tOqisTD6 (size 1024 KB) containing data sent by client
Created /tmp/tmp.8QjeZj6oDc (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.g5tOqisTD6 (size 128 KB) containing data sent by client
Created /tmp/tmp.8QjeZj6oDc (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

493

Created /tmp/tmp.vwcMyn1si5 (size 1 KB) containing data sent by client
Created /tmp/tmp.68DtIN3Uel (size 1 KB) containing data sent by server
Created /tmp/tmp.s4XyYSODCu (size 1024 KB) containing data sent by client
Created /tmp/tmp.zt7AR0mwrH (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.s4XyYSODCu (size 128 KB) containing data sent by client
Created /tmp/tmp.zt7AR0mwrH (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

494

Created /tmp/tmp.Q8Vs6VzdKD (size 1 KB) containing data sent by client
Created /tmp/tmp.PgD7QmtNeh (size 1 KB) containing data sent by server
Created /tmp/tmp.fGll94NphI (size 1024 KB) containing data sent by client
Created /tmp/tmp.NmHfqgxruI (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.fGll94NphI (size 128 KB) containing data sent by client
Created /tmp/tmp.NmHfqgxruI (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

495

Created /tmp/tmp.018xeTLzX7 (size 1 KB) containing data sent by client
Created /tmp/tmp.DnbATXTYHM (size 1 KB) containing data sent by server
Created /tmp/tmp.xo6GlWLKG4 (size 1024 KB) containing data sent by client
Created /tmp/tmp.PyB03J452M (size 1024 KB) containing data sent by server
file received by server has inverted byte at 69339
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.xo6GlWLKG4 (size 128 KB) containing data sent by client
Created /tmp/tmp.PyB03J452M (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

496

Created /tmp/tmp.btKC7IKSMA (size 1 KB) containing data sent by client
Created /tmp/tmp.jlLpQq77rU (size 1 KB) containing data sent by server
Created /tmp/tmp.eQmPfDwslA (size 1024 KB) containing data sent by client
Created /tmp/tmp.ea5XRR0AJ9 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 66320
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.eQmPfDwslA (size 128 KB) containing data sent by client
Created /tmp/tmp.ea5XRR0AJ9 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

497

Created /tmp/tmp.Up5CrDLqWq (size 1 KB) containing data sent by client
Created /tmp/tmp.gSJltNRrqo (size 1 KB) containing data sent by server
Created /tmp/tmp.uIrWWZt3nV (size 1024 KB) containing data sent by client
Created /tmp/tmp.0HWlGpembt (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.uIrWWZt3nV (size 128 KB) containing data sent by client
Created /tmp/tmp.0HWlGpembt (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

498

Created /tmp/tmp.ohPeJGqa7Z (size 1 KB) containing data sent by client
Created /tmp/tmp.3Vshfb7ZO9 (size 1 KB) containing data sent by server
Created /tmp/tmp.tVgyYViNqJ (size 1024 KB) containing data sent by client
Created /tmp/tmp.PCcXHHCj7l (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.tVgyYViNqJ (size 128 KB) containing data sent by client
Created /tmp/tmp.PCcXHHCj7l (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

499

Created /tmp/tmp.QnzkdCDuCA (size 1 KB) containing data sent by client
Created /tmp/tmp.1GNCmMgxVY (size 1 KB) containing data sent by server
Created /tmp/tmp.PK8DrPqzoK (size 1024 KB) containing data sent by client
Created /tmp/tmp.A4FTxTsklA (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71493
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.PK8DrPqzoK (size 128 KB) containing data sent by client
Created /tmp/tmp.A4FTxTsklA (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

500

Created /tmp/tmp.OZa1zJlOKx (size 1 KB) containing data sent by client
Created /tmp/tmp.LVSQH10h4l (size 1 KB) containing data sent by server
Created /tmp/tmp.E7h7aJQUbV (size 1024 KB) containing data sent by client
Created /tmp/tmp.21MtylYyPR (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65449
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.E7h7aJQUbV (size 128 KB) containing data sent by client
Created /tmp/tmp.21MtylYyPR (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

1 / 500 tests failed


--sm4nu43k4a2Rpi4c--

