Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7052F29CA
	for <mptcp@lists.linux.dev>; Thu, 30 Sep 2021 21:48:37 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18UL6jdF001187
	for <mptcp@lists.linux.dev>; Thu, 30 Sep 2021 21:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : from : subject :
 message-id : date : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=wjunn4+x2QEs4HRrQcozT7INn2DM0lGSHIZkmkDz3T0=;
 b=phffLHoHzE8bYvBPaPOhKdOhj2ingPLDMXMi2bgebTywgmynBAaAgnrwTqGXqgakJDqB
 Muclk3vd1zbh+yFiOPGNCjejDYtDNhiGrByX2R76SeyRDziDJUF4b4HpabKwdaTUUsbO
 DG9nOi22xt8TfVoj+oRTA2OZw4bCA78MHxLDaDsvbUZoF9CN9KT6eAlG/gxz/+IcugFU
 bm4A+DcsICwWdSk+1u+x9jFaYNiU0I7QruWYoB8Xonb27zMcicOcXJQBw7YCJIgnODgP
 We/bvQAAI6XlH/2yiFAJ9S9Rr66TlxwYEFRS0zDjw3S6Ef57YWua0KMQtRrN8OjM2jtI Hg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by mx0b-00069f02.pphosted.com with ESMTP id 3bdds83es7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <mptcp@lists.linux.dev>; Thu, 30 Sep 2021 21:48:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18ULdosf102910
	for <mptcp@lists.linux.dev>; Thu, 30 Sep 2021 21:48:35 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
	by aserp3020.oracle.com with ESMTP id 3bceu7qxut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <mptcp@lists.linux.dev>; Thu, 30 Sep 2021 21:48:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+SB3eNWZ4Fh1BKOU4hAzX261cTDlHPiyMxg6b01iJACMnB+LFm9uRxbDfo26sM77mkUSEhbQV0jFoiX//nNrMP5VLgTeFUulsPrywulzaKgpRK11le7Gn2fxhirXTmznGspGKj4Gawm7Bo8RG8aWs+xyYgsO3if2dDGyUZtti40cw8aqJb1d35lS8kV0f8mARKCLe73MlYx30otnfRJx7XzPNyR5ynvzDgW+TsyKqQYvU16sn/AJVbpHT2TDzQYSeMm8Ol2lM+ckk2TvbdQsc0DCZNYrKnWoI/5uDIzL935FVygXI0at1F9UUwKOfHwph6dlTsiigWiY5uxrdZMew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjunn4+x2QEs4HRrQcozT7INn2DM0lGSHIZkmkDz3T0=;
 b=lWTCMHRRiQtPnJz2zZ1N9Y5DfcKRuhUu0kblWB2hWlrGA5t+n5AVuAP7LqfJLK4azsGcW/HuBfaaT/VU8GTbzlPSlb/tLyUSSP7hTNTVcdRxdaBiO+QCYOJSvgxAZkQc6w5BRqLJmlG12+JTQuX5YtvJGCvUc3h2yJtf+TcR3wooI1k4RhGyn2GbaftK257JFlHniD9IVOaumtpAtszNUhw5ArpYMTNHdI2mveY1WQ4IAOD6vJFbRcJdJVyMbz16/MKZJhnEmnHQHAgdk1WUxvms1ucaxCrexFvQ5eXpFsynmANxBa7LZ1g4wPCiOi5nYx0HeTpdqm0Wob64SyTLow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjunn4+x2QEs4HRrQcozT7INn2DM0lGSHIZkmkDz3T0=;
 b=pIIiQXmDfcm7wiQ3yx7AiNQntYQdKkHr2NBl52TYX7moW/3WzrLqZG19YFdaDFujLO8nC8GrbD/7jxOWIoA4YARnssSEhoogSVtvK7P9dbhnIhn8X0o0VbLVgXInCusCEd8FTeB7gKx1wvQH+kLKDfv+ML5xw8pCJobFMOfAA6Y=
Authentication-Results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by BYAPR10MB3141.namprd10.prod.outlook.com (2603:10b6:a03:154::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Thu, 30 Sep
 2021 21:48:33 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::d41c:d8ff:89d6:8457]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::d41c:d8ff:89d6:8457%7]) with mapi id 15.20.4566.016; Thu, 30 Sep 2021
 21:48:33 +0000
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Shoaib Rao <rao.shoaib@oracle.com>
Subject: unsubscribe
Message-ID: <c40812c1-f16e-59d2-6839-8b1713831acd@oracle.com>
Date: Thu, 30 Sep 2021 14:48:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SA9PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:806:a7::21) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from [IPv6:2606:b400:2001:91:8000::f51] (2606:b400:8024:1010::17c6) by SA9PR10CA0016.namprd10.prod.outlook.com (2603:10b6:806:a7::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Thu, 30 Sep 2021 21:48:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52be2e91-467d-4aee-1227-08d9845c0ccf
X-MS-TrafficTypeDiagnostic: BYAPR10MB3141:
X-Microsoft-Antispam-PRVS: 
	<BYAPR10MB314174E6D39C6AF3FDF1A4B7EFAA9@BYAPR10MB3141.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Ek7MQhtRBL5GFSPPHJX2BWy0qQ4eXwdrbIuf8iag7QWcMDvrRXkma3pEY/yl1bgNd8CScduNw2Nuo1O7I412m5/oFiXKH1B6VZ7mSbfwR3vqPzOTG6RIdSF1RklPD2wIF6wTd85xytxz2dJWOdg3k2FWojkmkkojSDcUuZUNVBD2hikxP5bNX5ZL7O4p+r7ehJosYouUssOdim70dyMtfjz3svGVtrnLZXVIAbzVDncc1g0Yx774dqJ2mCJAW7n2RB/z9TceUXAtrUDBVYfIWRoFIl0BmNB6JgFTSq6HWwR/6b7VJJ/wJ189vdCK03Aa/kZ1gPM9slMyOuYaXKzu7QmaaRVBpvIXiOM3SyBVWyo4gISKC33COdRey85pH5lvEnIBDZ6hh0nyv3CAMkjPDBzaL+S9WNzSg9Qjuo4hqmtyABs82NsqPrD/iy2V4EcOqRc7olZyL8KHsTFG63bDH/8QjqnEaeVsE7HxDWqw9TXS5YPb22z3JsVc2gnKw33cySrVtyTB/wHH9QKbbiLq0qIH6pulO5ksEQV2F+s7zSpSIrUXFYESu52vtTuJ/VPQEm7Gb9ZpiJ4sldy6BMB0nEx4G4wPxhIWy7yz/GpylL/zEaoVFP3D4WHC/BrSXYyHOYlqaqBDwvGihWlEeEl2GHZdpAFaQoK7xA4X2E8v/lUKVNaVD8pMoFB8b8iOPZYxUxXg2viiTirJoYjU5FGfwwFpxNZGOvKDwaO8G4MzqKXslOnDFHOk0OVtMuQ+CDkYnDaTOVxaLxDUjsQwgjKQc+Vp2FqVJ9Y6laCbRwi7MFmpOAgaLMZsGE56KKA/l9yovOF7/EoUjWcj9EYL6+c/iwI30c44dCDuQA7s8l/IUDeW04XDbnr7c8HxvugE8iOB
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(558084003)(38100700002)(31696002)(316002)(6486002)(8676002)(6916009)(2906002)(31686004)(508600001)(8936002)(66556008)(186003)(66476007)(19618925003)(66946007)(7116003)(3480700007)(86362001)(2616005)(166393002)(220243001)(45980500001)(43740500002)(239884005)(425394004)(19559445001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WHZQM1hqajJ1SlZObmt2SDJlYzhmTE9NQlh2YzF5UzFqWDJtM3dUY3JPOFg3?=
 =?utf-8?B?Z3Z0U2NOLytXVWsxY0FOd2tONzlNYjNHYllYZkxyYk5NZGoya2RRUG1FSlZU?=
 =?utf-8?B?MVlDeUpMYUZTc3RYYU9DdmhkNGhRVndxeWE5SG5jUEhJR1ZLMGNoUitTZW0v?=
 =?utf-8?B?N0Yzamw5dHl2aWQxWVdLN00rQTBraS9la0lyVVYrdmQ3ZEFKTXdySjVQbFZK?=
 =?utf-8?B?SlZPdEhQVi9aK3d2OXlKWTM3RnVoRjJoUjMyS2VwdjJ1RGR0ajBHVjBabm9y?=
 =?utf-8?B?NTRIN2RVV1c0d2R4V2VjdGNJakxVcENwMjFydnFQWHowcnpQY014cWJkajNG?=
 =?utf-8?B?eFU3Y3F1SzdTait2bHBQcjlqNllMcG1xY3pYVUxyYm9EVVE0RGtaczdiWjh0?=
 =?utf-8?B?VlJaazQwbnVPZm1LZnNOditoVTFnL29jVEhnR3dMRzhWR0czTUU0Q1E2dnNG?=
 =?utf-8?B?ODlPdWNqa3c0M3lTR2hycUFmZndKdFR5ZllzUmhUTUtrSlBWRHRycTJ5aHdF?=
 =?utf-8?B?NSt1M3laUEwxeEg5TU5UakQ4VnBJUWZyNzlzVkd0RjVNQTJCaWJEQVl1SGUy?=
 =?utf-8?B?dFA1N0xJMC8vWmdxRnVjajVjMWRDQks2anFKNUttWlhhYngwQmw5RDh1NnFS?=
 =?utf-8?B?TUtXUDg3Z3RwMU5HTkt0WUNBMGpYTmlKZDlXelJXMGR0Ukg0NG8wYko4SEFF?=
 =?utf-8?B?WlphYzBrMVdDMW5MNk9kbXZmaVdocDF4bGpOVFdqV1VKMXdQVjE1R0REVjB2?=
 =?utf-8?B?TElGbHZNQ3R1dm5JdzlpYUdJd0VNYkU5VkptcGFRTlVkMGFBVE9wQWhuRlhm?=
 =?utf-8?B?MGo0RVZIMnNOdDY1cEJHNDhxWnE0WEI1cEMwM1N1VGNNYnoxNDFMMUJlTVBG?=
 =?utf-8?B?am1GdUp3YkdZQ0JLRUdJanZEVHlTQXFOSVEvNWZhRVZvem8xYmhuTnd2WW1B?=
 =?utf-8?B?K3g5bkUrQitPeFFndjQydUtROUxOcGtobzl6VTlTRGlMR0xLMUpJa1BZaWd2?=
 =?utf-8?B?QTl5UEFDclhQV04rYVNSb0grSmphT280ZWQwMm9lMnIxUHcwWDU1aGU1d05J?=
 =?utf-8?B?RG1aalRtOWFHOS9UWE1Rd3hHZ01ITVRjUURxVXlYdHl3Q085YVBBSFlOand1?=
 =?utf-8?B?aGh2Wk5ya09NUFlmaHF6UFE2cDMvckgwcS9BRSttRVBxR0RyNFpLUFo1djZi?=
 =?utf-8?B?M2pzUEcvWngrQ1N5VGhQei9XczdqYllmMFlGWlFhZERDdjZ4MkpTS2dhTDly?=
 =?utf-8?B?dUpvQTJhTTRTSWZ6Mll4TmZOdTJsWjRucmhPL2ladkMvNjlnc21xY1FUci9C?=
 =?utf-8?B?b1RSYmt1S1VRWlRaNDgzQ0JsQVU0YTNPSEtyRC8vUm5Da3Jjem4ycHRNUHdT?=
 =?utf-8?B?d05RU25kc3A2ZVdlbDVtYnVQeFExOVMwZkEwY0VrdGd3cGhaQ1pHdG9jTWlE?=
 =?utf-8?B?bWlIa01LWFdScklkbTl0NFpaOGZYNUJWcG9CTER4dmNqcHJoQWtHd3drRGhZ?=
 =?utf-8?B?RlhWa2Y2TWJXUkpuTWNNenBVL25YTmZWcHZlemRQaExURC9EODM0dEpQdWJ3?=
 =?utf-8?B?eGg2MG5JQzYzQUYvL1pOMW12VkxYSlorZkVlUWtjMitzUkM5dzYwdCtTb2JL?=
 =?utf-8?B?RE9mN3U1SWV5R1FYTTBXblNDeWFKL2xYd1QvT0s4THVFcGRYUG05MUJ5RTVu?=
 =?utf-8?B?ZGFpWnJ6anJoaGRyMlJlRGxGby8zYmxQTkg2MjE3TmlnMkd0VHZZejkrbnZs?=
 =?utf-8?B?eHhVZ1daVEtUM2M1VTJnRDRYaTYxUFQraVkrWStkVTF2MDZCdUd4aVFiTVZr?=
 =?utf-8?Q?QU6NPkj24LlFRYTgl5YdLZm6BWOmUUrIhTHTs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52be2e91-467d-4aee-1227-08d9845c0ccf
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 21:48:33.7675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qmvGUta6lIgPJtH/qg7b/AxG02nrCK848kbJn1lqFZUUzEKVyPMLHrEEvbcLJSohUhf3ZyvOOj3ZvH9USiZJgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3141
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10123 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=764
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109300134
X-Proofpoint-GUID: JazN6gomHujNfKjv4lmJWHMcbCk0kjhB
X-Proofpoint-ORIG-GUID: JazN6gomHujNfKjv4lmJWHMcbCk0kjhB

unsubscribe

