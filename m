Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E7229CA
	for <mptcp@lists.linux.dev>; Thu, 30 Sep 2021 21:49:26 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18ULA1pC014611
	for <mptcp@lists.linux.dev>; Thu, 30 Sep 2021 21:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=egHsr+uToutAms4EBnC7W0QwJSaRJ/jDG/eryWueY7Y=;
 b=Svkwjq2Tljh8DEZoh2pUqmX0qwFEO+wEtC94oU2/n3E1eaJxtbhA2ctMXm5q5+xsOdvx
 TcPLbH5i1EPKM1Yfc7FiUdG9lEkMmPjOg5UgHJVPpymKo3QstZfj7jirjfEdJo+l++F+
 83ls/Iln8NiKOzu1lc55JfNQv/DR84sOJq9k3AHYARVRTswvsbNxbAz+ql3Esaa0H4tS
 SCgsFLNnfZf6hmWogTim6HdA1vHeEp54p2aflP9JgN86X5wGFX/9AtxMyc9J/TKsKmkJ
 x0P5vfdLeLDjRwxunSek+E2eOjlZ343AMmlx84dQ8CtmaHjjrBxIRUjGeghD7df8uYBC qQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by mx0b-00069f02.pphosted.com with ESMTP id 3bddu8us1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <mptcp@lists.linux.dev>; Thu, 30 Sep 2021 21:49:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18ULeWOO160076
	for <mptcp@lists.linux.dev>; Thu, 30 Sep 2021 21:49:24 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by userp3030.oracle.com with ESMTP id 3bc3bn992v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <mptcp@lists.linux.dev>; Thu, 30 Sep 2021 21:49:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7vL0t5puAYIYhe0YLshUaxpLg2hWIPFxGEAgY8Pi454cs3CpX4ODCcR0CAQwsOM8v5+YyYUKoiDnWASK+YPe812jNH64D7mZVXtElvw46siJPA0PIK9yhQifp/lr6jjpYz431ANjYR1HyJ0/PtaVNkJqhIOd0QYvBavE1ODx2363yuwj9D3DWXjG9DgEy58fL3x5+y1JwRLkhg3jDYAnu+x5sOXWZI0eYPJP4yCfdz/hY9NwISNkGzouyURWzyVoixJ7Yyti4E0c7WdJuKEQhsIedD4//hYMjl53OzZ55h+rETSwd5775HyrNKMOCKit8i3+66fjtExIRdB0beq5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egHsr+uToutAms4EBnC7W0QwJSaRJ/jDG/eryWueY7Y=;
 b=M5Y2+liQU3hXX/cHLjYRD39/TWGHAupx+VvorKyoLC5pKmXF7hzkEnBxdY0VYnP3K55vnPBA+o7rGMZ4eK2qFxMlIng6fV39CluusabxpCCpzfymBrR8Me4a1ZXyE1AdL0s9TCceRFUJw9Vwsu5tyz4vfD2AsHLKBTbgMtdMU+oRhKZ+4NOniIya99SmVdeVGIL+irSm39GES2D9fGpHJjifKppCzTPflPuSzax1Hy63AldjESAjTKbN/fh9Tg5mFSI98DNQPGLS4jbXmSAhbttLqXU2jMiah21hakzbUroY0hBgTHDxH67MQYB+GIpvPMsdRWVS3fLPeZOixIfEbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egHsr+uToutAms4EBnC7W0QwJSaRJ/jDG/eryWueY7Y=;
 b=FXzRvuKykWABht8YG5RKaOq8Hs16pHsougj71Nf+xRN3Udp2ijvwRSO7hHnWJBszWWHIvJkYfxt5zcyUpWbYc0aOB6kXTJN1qgEmniAtJ0QFkzNl+yr3qV1OZbNh8Fvta7tSNnMXhjPd07LvnN5ZmpcMii/fRs84oPyPxbNZltg=
Authentication-Results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by BY5PR10MB4034.namprd10.prod.outlook.com (2603:10b6:a03:1b1::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Thu, 30 Sep
 2021 21:49:22 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::d41c:d8ff:89d6:8457]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::d41c:d8ff:89d6:8457%7]) with mapi id 15.20.4566.016; Thu, 30 Sep 2021
 21:49:22 +0000
Subject: Re: unsubscribe
From: Shoaib Rao <rao.shoaib@oracle.com>
To: MPTCP Upstream <mptcp@lists.linux.dev>
References: <c40812c1-f16e-59d2-6839-8b1713831acd@oracle.com>
Message-ID: <4c0e7d73-914b-748f-1979-141df2881c67@oracle.com>
Date: Thu, 30 Sep 2021 14:49:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <c40812c1-f16e-59d2-6839-8b1713831acd@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SA9PR10CA0029.namprd10.prod.outlook.com
 (2603:10b6:806:a7::34) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from [IPv6:2606:b400:2001:91:8000::f51] (2606:b400:8024:1010::17c6) by SA9PR10CA0029.namprd10.prod.outlook.com (2603:10b6:806:a7::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Thu, 30 Sep 2021 21:49:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12da905d-0189-4341-b8da-08d9845c29ca
X-MS-TrafficTypeDiagnostic: BY5PR10MB4034:
X-Microsoft-Antispam-PRVS: 
	<BY5PR10MB40349AB568B4D5EC8F64DFDDEFAA9@BY5PR10MB4034.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SzePkmJoYZQJYMz0si1tukpavPhH6hG59QhHB4PDUvpz1M3ByD4Zo07KaYThn9bUeffx5JnMsYJIhMi6FnDFBwxnHzP6detFy9nrKBWGkRVoobCJKFok3dRGDRgcHRUbwta0gsc+aoxy18Zwbp7GtIPD9LXPVt03iQm9aGV+X4nK0WKi0cog6eyp/BGK/tkYb9XxesNl4qwP6Mu8eQAZykyvH8wVN4RfjWy6EAoE6Fb9jML22Pn/yEOXXFDSzpK3auSpv9Bpi3Ag7VsOWLs1ksB0mfyUXlP0SMN1L96J68VJYUdZcQt6pe/nqELWH4feXJ7AxOr1biz7cWf49zyjdex8+e188tUcoKV3//4dqC7W+Hl6VV6s8gxGI09WJN3aRJyV2rW/qV3Nw0sUiohmUE8eVkXwUlQXbBee6Qoud0jt//bvXKcCYIAhfAhT+Uja4GC13w1D8mR3CVkdNpLfZsTHZoFIBdda6Wnjp92OjXyl4VLSv2Rd/3PK0vfxFiM7WEisosW86SfH7e5iHqUyFYKLdmSEu3GFjoc9Y8NZxw5vNahcbnS3htc61txDUKw2KKh9CsVzS2Rayt+1gHopDEwOYkPmWpxv7A7hUfW8/+ckgxYSe8MXQcCUEECGC6G2Mce1e0iEY++gyjoquGQrMkpZbnaKrdz1KU865DJ2DHk1jfATHuWHBlk4jZ/G6jujxOMMqNmcDaksUXFCZi//OkCyJbGGD7UTFZD8YDT8x3GPAbl4ySKgmK0HOortyQR5Z5KF/4gsGsAoCjoKBeyI6A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(6916009)(2906002)(38100700002)(6486002)(5660300002)(7116003)(66476007)(31696002)(66556008)(86362001)(316002)(8936002)(186003)(2616005)(558084003)(36756003)(31686004)(508600001)(53546011)(3480700007)(8676002)(499474002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aDNWTWV2MkVPTnNtWGdYUFl5YmY5RzhPVGFySlJXZFJjVFFaU2NGVy9VcDM2?=
 =?utf-8?B?YWdYSitIckNXTzVzVUJqK2NLTXhXNnc1RTJrSi92RCtjOUNzamdQckVMNGNN?=
 =?utf-8?B?c3FYY3JIRk53Tlk0Y3NDWGRmQmxUcDdRRzlRcjZPcXhrcTlmNi9Ga0dqcjcw?=
 =?utf-8?B?aFFTRjJXZUF2dWsya2lEZ25iL2IrNkNqR2dmUGNoUDgzQ1V5Q0svM0xWeU94?=
 =?utf-8?B?bG95NDRRUDBWSkhWT1VhWXFWTFNrWjVXTnphR3p0T0UwY25sUzJqR1FFSGNJ?=
 =?utf-8?B?cFIrZ3pxYWRZV09ma25zVWNsK2FKZEFhVlRZUlJZUzhoVnh0dktUMCtuY3h5?=
 =?utf-8?B?VmlZZmI2ckJzSDl2bXNzQnV5aUNQeHpNa2d5amlFNGxvQnNIek9VT2NzR3Rt?=
 =?utf-8?B?UDFGdXdxS1JseVJLdlJnNzJhMHpBQUhhZkpUeWtVYnZTR0hmeEh2R21pRHYy?=
 =?utf-8?B?Qk1vTXQyeFpCSWF0LzBkSjhrQ2xFZi9JejJRNFZ3NlIzVE1LRWcydHAxSnI0?=
 =?utf-8?B?dEFPTmZHbXBLc2JMMkIvY0gySHREMk9STjFLek5TT0pnZHZQcDlpNkZ0M3J4?=
 =?utf-8?B?RUVoZ2wxaTRoTzlpaXZ1Q0djWUpOSE9VMkxaQlFhbS83NUU3NElFRGtJTEZp?=
 =?utf-8?B?YkVXQXlSb2RVVDFLRWRpTzRpcFFlRzV5Uis0Y2ZtVHhVQU5pZk9QRG4vcWxV?=
 =?utf-8?B?KzlBY084Tm1LWHhhV3pqa3FGVUdFTWtmN2VNS1dxUUl6a1NUNFZxWmhzdzM4?=
 =?utf-8?B?R2NlcVZCTzVCbWg1ZldrcUdoNnc4N1ZteUNkOVRrckcvdnZqZ25kcWlNV3Zn?=
 =?utf-8?B?YWdXd1ZMb1hyUDUyaG5pRUVtRklYZlVCdWlOOWpsNkxVazVOVDdpQnRpek4v?=
 =?utf-8?B?TVlGZXFZNHMxZE9RbmM5MlJvamVnVmZmTlNWZ094OWNBRmVhUTJBWHgxODcz?=
 =?utf-8?B?N01CSEZaNmlxQkZyL1lXT29rV3pqRXMrZXhaRG1laE9LS0hyMHdmS2xnUmVx?=
 =?utf-8?B?UmFxUjFOOHdwMFQxMThCbFpzbGZ3SU8vSnNyRHZXSlZIZjlPMHE4aWlSMkdK?=
 =?utf-8?B?cjZxQWtQRTZ4OHBoVGlJT2FCTkV1OHJEZWpYUUU0c3creW5HN0YzZnlwZzdG?=
 =?utf-8?B?MDZRb3ZXdTJBUjRON0JLNHphY2JyNlN4cVU4RTBsUGFNcFFZSjJuMDg4c1Yr?=
 =?utf-8?B?RDVHOEhwQWNzTGhKa0dYSXBPdnVMTDZLbDA0WW1HTHZobzE3NWRrUDN1RUVJ?=
 =?utf-8?B?VCtNaWNYUjl3bWhQME95clczbmZQL3RVKzBQYkMxK2w3Vmo0ZjlLMk1ubVo1?=
 =?utf-8?B?aXk5bjlHS0ltbFpNNDVUTzludkJ3WDRPa25iOTdrMm13OW03MmpkQ0ZuUmsz?=
 =?utf-8?B?ajRlVHkzSjhLUnVzNEM2cllpc3BpaGF1Vit1dFMzbjY1bFJXS2pZN25iK1U2?=
 =?utf-8?B?bEFpZ0RwU0FFMUJTNDNoL0MyVnZhekZ2RFhCNU1DY25rV1A4Mk5OZzY4Slpy?=
 =?utf-8?B?WmxaNXpYd0xCRVdmdUl1WWJ1QU5OeC9adTdOU3JGZW9jWXZBaWpkNGNPeWI5?=
 =?utf-8?B?Ujg2SDBIcVhRYXFvVFFCOEZSeHFGd2hDNnFENGxQbWhBSklQcEwwRHBWU1R1?=
 =?utf-8?B?SVNEamhWR1cxdGZzNTR1WVNSTVFPQnN4d0p6U1JhVlVwVWV6aDJkQi9qNmFB?=
 =?utf-8?B?bjloUUxaQ21oMzJoYU1ZUGREdXhBbEx0OVZDdmVVT3l4NHovY1A4bWoxZ0ZZ?=
 =?utf-8?B?OUlhejUzZzNFY0lwd01sMzVpc1RkNTFhZ0dvYTdrTzgyQlZwNjNYSlZJK2xI?=
 =?utf-8?Q?BYDYBusvPZJoiTl7d2RPsm4dI7kD26YIkZ478=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12da905d-0189-4341-b8da-08d9845c29ca
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 21:49:22.4526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xdErI++UrqvHHPTTWp2GJh7jPq13K3rtZuUt2UrEAQT5QaSXXFvd8X6j0+0rpwysvoz+4bYsYMO3MpOn7WBJQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4034
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10123 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=896 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109300134
X-Proofpoint-GUID: Ek3s9kXw_86YPqmm7w14nF8MCRdajSWs
X-Proofpoint-ORIG-GUID: Ek3s9kXw_86YPqmm7w14nF8MCRdajSWs


On 9/30/21 2:48 PM, Shoaib Rao wrote:
> unsubscribe
>
>
