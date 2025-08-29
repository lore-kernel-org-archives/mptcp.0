Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDEB1BC5C
	for <mptcp@lists.linux.dev>; Fri, 29 Aug 2025 02:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756434505; cv=fail; b=VRD7P4G0aGveRBD5GDCORvhpRp8HlBIH+4lBE9HZZ+qM6MkZWdaHqNJ+T+FdByU+nHIPmHzuvXGNzygs3yynIznf9sGYSKFFIB/p5ADhC+4Q5z5g+HJbxpMwBtF3nr+s80ScQzlx2jAM3nVsQadQvMAKWK2cuzBjeuSiZRbpRxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756434505; c=relaxed/simple;
	bh=t/2V8hwD+7A7cNtI+ls7lGpZoFCKxQ/Vr2/kmh8+xM4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f3E6kPjEnWCFb3Gcedf03hTOkhW7D9E/fZWhruptfVTMa6BzurrQRkukxgqRFC/e6E4MOg4yaE21rsEYZrBf41OGW//i/nnHTmJLyg8q375jXCagKSw7nLNbIPBJEjPYXA0lydaH8zawKe2xDjfV27S9ngFqPUxhQHmtcfYTc0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XCE1xkS4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=shIrNgJ3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XCE1xkS4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="shIrNgJ3"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T1gYRM017620;
	Fri, 29 Aug 2025 02:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=VOweuPoc8LYl/gmP4mwmU3hRUHJFCeaHi2LkMEMw+LY=; b=
	XCE1xkS4VkHHAPLPfLDJcC7B0ocDRU8WH3DNs2k3zVTh7aIbdWF9U1MJy4A/U9XB
	LIJdhnNNZgP+tXobBdN01u/A1erlKKc6ewl0LVgpw2yBXrmzdXiT0ylGXoGdgyim
	/gc6HsWUs7rT2yPO5twsVFdWI/S9U1ZcooQ/8jiZ6B6E93V9u1fape9dBScpf6gb
	tv+R2mlURTkL9JiXtTO9GSvAvx964932FKGup94egrsYjWQX3gVrj5bvze0XYJRh
	4FPvTJbFaoF/eNoGsiJdSnqoQ/ByHptCb5/RL7P1Gt8Jsl3hnZxs2oDjcWa/TvOH
	AqhQzpvqkz1D643Vw80d/A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q58s9p6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 02:28:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57SNeDC0027103;
	Fri, 29 Aug 2025 02:28:18 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43cfsh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 02:28:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8Iv4jKoXi4cUO2YPj5taxvdNCVeBNxpVUqb2kIPCs0Inp2oKiCxMKmoKJkIorrx36w+dMNmTzIPBYt1ycv6WhjEWjynL2YmBvklfyDBun80vYI4tW27WNUSqtBYybhWsTaydxegVFUKQ3oxvR5/bU6e57FSRqLCXOoLrvhjbfyS5IfJHFGpUiyMTxfaQri3+EO36RiVhWxJ5Qs02Wv0knskgPdbcwbMc3NFaUZ3WiqiZNfxCkIYbZFBVn4vBfvR1QOjQcwEyDvB7FvlWdn2z7Bu03kZMb6jGVYN4XJjRbwm73y+oVr57RCmeBxjyaUlMXRzj7EE57RsgsMtO9eg9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOweuPoc8LYl/gmP4mwmU3hRUHJFCeaHi2LkMEMw+LY=;
 b=NfhJlN/WUtcoGAD6XneIUpK9jHLZmzQQO/3gFAFco/fQjvMYVUb7mHxd6BoZhshAbY4QEaIXfn5YpcRix8jCvRmNic3Xy0qVMqUVGmMkvJilnAuYmiRK03/gL4I4+bP9rSsaFncXzRufh7xGZsE1ey/kW2QTHc1yC/mfZSyqlabzgBoOwQ4xBjdb5iMEWFIk6ir8S9tHcDI1xrLya1r8U9sT1+Oi/6oEbxNydVqGXuu+hN6AZR2bHKYXsNtvDgnLsglFaGBqLKeRIcIchaayuMJ1lunys+FW6EzobTcIFbUO3D4C56dwbKMmddVZn7ozvlGffd/1Hgd9Vq7K7h9PwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOweuPoc8LYl/gmP4mwmU3hRUHJFCeaHi2LkMEMw+LY=;
 b=shIrNgJ3wlmSi2QYZIRc/Op/dRXH+8B2Tn12ghl8b1NuqtNjOTmee2ayLyQZxouvHJ8OICATcG9jgEK1DFxgf2aeecMocHNrwW67TvUDKJ/DbNUsLN3qv2QWA06BmG0iSMePC0SWe1bRE27mgOKpv/zFRKSAol0lN+21iWDMjx0=
Received: from CY5PR10MB6165.namprd10.prod.outlook.com (2603:10b6:930:33::15)
 by CH0PR10MB5002.namprd10.prod.outlook.com (2603:10b6:610:c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Fri, 29 Aug
 2025 02:28:12 +0000
Received: from CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::7213:6bdc:800d:d019]) by CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::7213:6bdc:800d:d019%4]) with mapi id 15.20.9073.016; Fri, 29 Aug 2025
 02:28:12 +0000
Message-ID: <f6fee54e-cba1-4292-8ec8-f959bda48348@oracle.com>
Date: Fri, 29 Aug 2025 07:58:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Adding notify-flags=skip_link_local causes errors in mptcp daemon
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <05f302dd-2afd-4775-9099-5c34c23e462e@oracle.com>
 <d4c74f72-2595-4fea-8a3c-10bb374e5b06@kernel.org>
Content-Language: en-US
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
In-Reply-To: <d4c74f72-2595-4fea-8a3c-10bb374e5b06@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0001.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::6) To CY5PR10MB6165.namprd10.prod.outlook.com
 (2603:10b6:930:33::15)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6165:EE_|CH0PR10MB5002:EE_
X-MS-Office365-Filtering-Correlation-Id: b5879926-3758-4872-2103-08dde6a3b361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1ZCdy8rSHpqRW1RazFBOWk1UzRkSG1lUnNDVm1TMHVBMFd3TTFvT2Nwd2RU?=
 =?utf-8?B?M2tFUWRub0JvVTVVakxDVk8zbm5hYlM0UjJmWFRweDNHdzRoYkpQTnIyc1NZ?=
 =?utf-8?B?bFhtRFU5MVRwUS9rTGwvM1haekVRNFRmQ1FCeEpjQVdNUFVOZ0NkNkFqdWg5?=
 =?utf-8?B?MWhSNnUrbFV6TjczUGROVnFhaWIrcVZTOXBYbThXdyswc2FOekIwWk01ejhs?=
 =?utf-8?B?TDBGZWVXM05xU2srY1RLYzVJNWVFZ09RVzhVcDc3WGQ4czkza2tnQzI4K3li?=
 =?utf-8?B?KzBkczUwQ29CUzRNbGxyL1Nja09ON2NweU5RRzVHK0w3dXNTMEg4R0NkRy9i?=
 =?utf-8?B?c2w0c3dRbFhpdnA1R0RyM1NBOXV4RUFXV3E2OHc1ZVhCV2c5aFRzYkdFZ0VM?=
 =?utf-8?B?Vk1oeEpNUDBNMlFYTnFrUUllQlY5bjI0ZE5KdXdyakVzc0pRR2FHTm1OMEI5?=
 =?utf-8?B?bFJKN05Jbis1N2lSRXZSZWQwWXB6NzFVM3BDODNyMVBTWEk3N2JDSnFUKzdX?=
 =?utf-8?B?VDRhWkZ1WE5YNFV1alNIQ3NvMHZJbnFickJuYVZ4bmYxS0Y0WHRveU8vemxk?=
 =?utf-8?B?WTFhcmtQTjcxV2Vqdlg1czdSQU9EK2hiNnEyRnk1YnI1c2dzQVhraHJtMzJI?=
 =?utf-8?B?QUFyNU1USzNiOEZ2V0hPNHdwa3N4cEdIMlN6R1JDMWh4VDhBRlg1OWpDbDJk?=
 =?utf-8?B?dHZabUUzQmExQVR0VGV0U0dvdlRUelhhbFB4M2xiWVQvTUVpd0dGZVhwTURa?=
 =?utf-8?B?NDBvZzUyMWI4bWR4d2p3NmhqdDVJdG1uYXl6NzhuVlpJQU1HOUNBNmt3VUVo?=
 =?utf-8?B?Vzk2WTVDNUNFc0hsNCtwa0NEY056ZXBXQzFRcksxUGxIUjlvOVU3a0tqNkpO?=
 =?utf-8?B?eXVhVGNEZWJFYTVTTnM5UzE5SDZDTWttUm9ZN3YyK1JER1hOOHdMdFdMUTdQ?=
 =?utf-8?B?aVJHekIyZ25tTHM3c01FUU5LelFkK0V3OG00SkhVcWFGemtNSnhNVkRlM2Jy?=
 =?utf-8?B?eFg5NkFWWEtuajJtdndyK1lJN2N4MTN6bU11NUVWUDR1OHBIaWdEdmMveTFu?=
 =?utf-8?B?WlNxWUVQYTh6eG5rdTlsWEdnTDlrQU1PaERMaVM3eWlJd3NrZzFUNjk5S3R1?=
 =?utf-8?B?N0ZqdEJFNFB1YUtDME8rdmtCYUtyakFJUDVuSEQ5aFdrSFR1ekVTeDFia0R3?=
 =?utf-8?B?YUkrdnhBdVE1cktTdUNBYWR0a3d6ZStPWWpld3QzQXdqM1RmY1ZrSHVLQytV?=
 =?utf-8?B?Nk15UUUyT2Z1L2xrVnpLQlAzUDN5YTRXUjZjdisrZjRSS3g1ZjIyWnVncXZt?=
 =?utf-8?B?c1oxcXpDd240WFBxYkJRakhpQi9LS0ZNUnhvQXhUc21EaThRVGcyV3RFcGQ2?=
 =?utf-8?B?bzZxTzJ0bzZSSERJK2NhTUw4RTVSQTZhMWZUYnpnVlFqbVhjV0N5YnliOHNs?=
 =?utf-8?B?bXBaN0t2N0FtcVhQd3ZsODZlS0Q3ZlhSMVhuSy9od2d0S2NXREM4TkpyVEFL?=
 =?utf-8?B?ZDdGclQwbUhldXExQ0ZrMHdvTmZNN3lPYzVPUW96aHJuR2kwK3pNTXVUMU5a?=
 =?utf-8?B?RGZtZVVnZTJtVFRteFZGdmsrSGJUNy9ueU1FQmc4Y216RXZHZEQvZnhkTjZR?=
 =?utf-8?B?M2hSTWtqSnRNTCszUHBrN2NGVHU3YXVMZitKSkhKbll6SXhqSGZUdXRxQnd6?=
 =?utf-8?B?Lzk1RDN6cE9JQWUxK2xWa3BZa2lvVHlpdFQ3dXRXcFZVeG90bzJ4OFBDL21t?=
 =?utf-8?B?RXhyYTBFelhadGFRN0VuSGxOUjhPNFh5NEFHMGhWU2lWRGZ1anN0UEtrckM0?=
 =?utf-8?Q?Wh1JCFthAhaizbmygpZaXvxhjb7kORZhibrmM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6165.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVFab0pmb3dPcTRZSFlDOGNWa0xzWVpob1VOcnFlYm1mQ3p3ZTl6bDFTUFVP?=
 =?utf-8?B?dHNuWGF2K1ZCZnN2M2NGMnZaZ3NiWjZ4TlM2MUkwMmU3Wm9WeWJDR2JSMDlL?=
 =?utf-8?B?cU1NbjN6ZzhoSkRPY3FuenhkeHoyd21IbTlBL3ZENyswRGVKRFl2dElYT0xj?=
 =?utf-8?B?TG4yU1RsbWh6eUtXcThWRFdVS0I5b2xOUnZMdWNQK3lwVTVwRmRUUXRRZGVB?=
 =?utf-8?B?NVZvRlU4MW1hYnk0Y3RNMGFsVG14TDJiLzFUd3IrT2VEcXUzdXhURkI3bkxm?=
 =?utf-8?B?UW93bHVFQU5TUitiRUtIbHFMMlN2MXE2UWNvVHRYZkdVVzNVSGltZlNuMVZU?=
 =?utf-8?B?WU1COFo5bTlZSmY5dE05bktpVHFMNE5KVFNTTHVuZndtQXBodVRvWkVYR0tp?=
 =?utf-8?B?cDVBZVRUQnFaWXZTZjJ3cjNqc25rZTh5eHdpZmlZZldXeEZSWG5ha29OY05p?=
 =?utf-8?B?ay83b1BLcnJ4THIrNEVOWGcrL1kvb3dkU29BVm4vUklUMzZ4RUpyS1RkSUZM?=
 =?utf-8?B?T1dWQUdEd1BVc3FQbHI1M0wwL3grUzlna1NWdVhSdm9tSmNRS3BNaW1nOGNa?=
 =?utf-8?B?ejZTOGNWT1piSGh3UWdoN1hDWjAzWEVuZll3MGQ0STRROUJiY3AvcFI3TjI0?=
 =?utf-8?B?K0w4emlMNDhBN2xUWHZmWHEyNUFBdno5REYxYyt6TFBwVkhOL2liSFRlMWov?=
 =?utf-8?B?RHB4TjhBWmhZRzlZTmt0QnVVYmpQQUhqYTh1ekV6b0VIYy8wYkdPb3B1QWNu?=
 =?utf-8?B?T1dXQUNVdzJUZmM3bTFLcWVJZ09YSDk5NE54VE81dFgwYlJXbjYwbnhIa0Rm?=
 =?utf-8?B?eGlSZDNxRHVzd1docmc3emZWSHNxdTYrVVgwUGMyb0ZRSW45Mmk3dFlLdnJw?=
 =?utf-8?B?Qk0rSWVzK0pPaUYwSE9ER0pidUIyRlFGbjJPWWU5WXg4ME1BL0JQcHlPVmxW?=
 =?utf-8?B?SVdiOVNCVVhNa2JkeEYxMlF6Z0U1cENrTDhRRlVLdGt1TjRmeCtVTUVXZ2wy?=
 =?utf-8?B?OVdQckNzTm4rS2xpSGs4bGo5aEZVbzl4ZDV5ZmNNMFMwbnBZcm02VndDc2Vj?=
 =?utf-8?B?WWp1KzlXdCtEeGh6WitJUTAyS04rQnROSlpEeG9TU3gxcUVtWEhYNnZ3RjUr?=
 =?utf-8?B?OXN6Smg1Z09aZlQreTI3WnJSZXdLS0M5TzV0NFNrRVhGSDBxcmpSQ3VQay9k?=
 =?utf-8?B?Q1p1R1o3YlRYeG0zQzIvNFpMWGxNQm5EZzlOWkpMU0ZBNGhTd05JVUtNcmhN?=
 =?utf-8?B?S2FoQ3ducmhYWmdDMmZ4eEdFaWxHditvUTBsOWttcEN4QjVwRVNxZGJMd0V2?=
 =?utf-8?B?T2FiQ290Ny92QlBDTlVacGRYcEtJWnJLQXVzQS93eDdMY0VId3pXNE5vRnlE?=
 =?utf-8?B?RnBLRVBZSDkrWkJvdXgweGh6YjVBQXZ1MmRleFNZSzRnUUhXTHk1aFcvUC8r?=
 =?utf-8?B?VlFKbmcwWnlJMXVZT1NqaklQZzhDL2N5QzBYSk96cExkclpwMng3bUtWUjJY?=
 =?utf-8?B?VXdtY0dsYnV1Q0dnZXRGbEt3T0xVOGZUVUtMZXVUZGpYMXR1dmY5TmM3UTVp?=
 =?utf-8?B?TnJpL3E4N1JpSTEwK1pwUXdQNWNrM3RxQU52MEZ4d0VjZVdINTBwL0Y1UCsw?=
 =?utf-8?B?N2hvNmRPVHgzY052aUJibEhtUXZ2OW1PWGFVaG1hdUV2OG56dEdzLzB4MUJI?=
 =?utf-8?B?THlrc2U5QVB3UlEvYmpkWVFEL0pzOGluSitoWncrWnNxVEF6VWxQRmJaelNY?=
 =?utf-8?B?REM2R0oralNDa0dTb1h4SG9FU3FoVkhyTXlaWGhwbStTWjZGY1RIUHdLWXJG?=
 =?utf-8?B?aGJ0N1ZGdlpGaEhUbXlEZkxiT1VmTHp1WitCaDlCS3dkaU1JVkU0RTlBamI4?=
 =?utf-8?B?SXpJNldHSHdLd1dEMm1kVUJlN2QxU1FNMDhIMkN1dDhpVXFERjNWenFOOFIx?=
 =?utf-8?B?RlNQSmsxdVNQYThUU3ZLS1RRenUydWJEeEZHWDhza012ZDFBZ2JKYXBtVXFk?=
 =?utf-8?B?VjEvRmoxYkp0czJ3UzRqdGdaRUwwbmtaRGw2OGx6TENoZm1jY28yaUZZTnVk?=
 =?utf-8?B?NnhoQk80ZzBWTEdrMlZWS0c0enV3NTZtK1BqVFVOQXE5NkhKVVQ4bXlDRjha?=
 =?utf-8?B?a2tRVkxhNlpOQ054YmJqYkJQMmpDRDlOMWZBQVRQTWdQdkxjQVlZNEhvSGlH?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0tlcwx+E1GaMjbqk7iS8d3nOwuBX73T8rRtCt92PrQ88ob1950BOW8eiqIUpkxN6zeJTWNSU4bGy+LVNkr6HaL0VIMVZrqkRK8ZwvHVwJO6t1o2M/7sr12IDTos4HoBanCO/KErtLebtAWwjbJAAwMDnlFpw3mia2sYphLLNkTHXO2HG1dFgfe/QQTJRlEHZYm0wvZSu7ejiEXohyyEs87dzugzi17AfW9vZUbScGKAjND93hT5MLFAHjeI81uYn6DxdLcXDwaoRbzsmTHWRgvOYWLnBh5fgRtmv6LPQ18Qfbh+rUwaeOxdxXA2UT4rXY5KxkI+uLRzjNW/Tozh9qyQYcIdEUVWDs2rKYAZloav486mmZYcYAbroIEQf7qKZPpxC6TLSu5iGjcrMEnuSxCAYQR/3x8UJRKIIxfLNjOya2ai/hEfpYC3SdWU0VfTOyW/hSkGZOHFgXQDEeap6WGN/SCd/JBXNzEAzJ/phhcC8yss2FeAyzlUL0XBbYYF5lQ3LhiU6mfY+jnbH9BUuX3HdFS/TlhRMfhtwYHxQdBbjNs8Nq3x1gJpwMq8jXRR2llfn1zyAQi9kWsLYR5zby6+DDMFgW93hYAO9CVTJHvs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5879926-3758-4872-2103-08dde6a3b361
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6165.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 02:28:12.1423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +T2jCTo4KhBUZaS6jBjd4m8ley6f+kvzGd3WNdjz9ztdqEBkfiNQ7s453Fy2txzyweLrvkw0e1Q9q7eDQvSypbfhPT1bQ9yYVHLH5oYEVCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5002
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508290020
X-Authority-Analysis: v=2.4 cv=J6mq7BnS c=1 sm=1 tr=0 ts=68b11043 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=fshrNHaMAAAA:8 a=xNf9USuDAAAA:8
 a=NM8Wcmkxaa2OWvjuFXMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=e3mraj3_9yMA:10 a=-8yAR1PBeTAA:10 a=l905gZIBnaGlF0AENO7t:22
X-Proofpoint-GUID: 4p4tIBcSC1F81uHTsNEIuHGl7ZVqKOWv
X-Proofpoint-ORIG-GUID: 4p4tIBcSC1F81uHTsNEIuHGl7ZVqKOWv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyNyBTYWx0ZWRfXxt2gCP84g7dM
 d6QY8oTwTK4ekSMqGHCzlhh3rUiqPXRiTZOmEsdXaYK5q9c8GNtH9vD75mPnuMMA1CijNJbb6fd
 6FQaei6Ewc+6nV6PfrwjoTJP0Nz2ERVRCEytE7KC/9oAJ/Gu0f8fQV4ztVNI8vkcpCOxjuSk2HK
 IySnYW4pLaDRFPvX6TXrtWhgAMn6RhcK92xc6PENT3S1FiTjHtqh0X1tnZH343k28UT3iBiTbWF
 lmkQzTr5djuj19b12j40LIRUOi1OhXyz43yXneuZ4oiNmqID7t/hBNBJD01fkl+t+uttQJmdiYd
 lYfhtG3Imn515+2oYeVFGpYMYrUbuXb1IcH5MaNnRwHOa2WF5gxp6QBrXzqgHzh5kcbpsYGZrxv
 wVYu0hrz


On 28/08/25 9:04 PM, Matthieu Baerts wrote:
> Hi Harshvardhan,
>
> On 28/08/2025 16:28, Harshvardhan Jha wrote:
>> I have been using mptcpd version 12 on my system and observed this issue:
>>
>> systemd[1]: Started mptcp.service - Multipath TCP service.
>> mptcpd[2996]: MPTCP address advertiser path manager initialized.
>> mptcpd[2996]: MPTCP single-subflow-per-interface path manager initialized.
>> mptcpd[2996]: add_addr: too many addresses or duplicate one: -16: Device
>> or resource busy
> Thank you for having reported this!
>
>> After extensive debugging I found out that this was due to the custom
>> flags I had added to my configuration:
>> addr-flags=subflow
>> notify-flags=existing,skip_link_local,skip_loopback
>>
>> Keeping the first flag as is doesn't change much and only the
>> skip_link_local part of the second flag is what causes the issue
>> mentioned above.
> Do you mean that with the following configuration ...
>
>   addr-flags=subflow
>   notify-flags=existing,skip_loopback
>
> ... you don't have this "too many addresses or duplicate one" error in
> mptcpd logs, which means it might be due to the "skip_link_local" flag?
Yes, skip_link_local causes this error for me without it this disappears
>
> The "too many addresses or duplicate one" error seems to suggest either:
>
> - too many MPTCP endpoints have been added
> - or some endpoints cannot be added because they are already there
> - (or the help message is wrong)
>
> ... which is strange, because "skip_link_local" is supposed to insert
> fewer endpoints.
>
> When looking at the kernel code (dev version), I think the "-16: Device
> or resource busy" is supposed to happen only if the userspace tries to
> add an MPTCP endpoint with a specific ID, and this ID has already been
> taken. Which makes me suspect the following: is it possible either NM
>> =1.40 is being used, or mptcpd has been restarted after a crash, no?
> By default, NetworkManager >=1.40 will add MPTCP endpoints, see this note:
>
>   https://urldefense.com/v3/__https://www.mptcp.dev/pm.html*automatic-configuration__;Iw!!ACWV5N9M2RV99hQ!M7wLbtcCWMUOxiZYPRZeuYxv3UR0LiDdFkqbSyB9H8eWUKvQthCSKvY4MAyYNCnD0gKQjDnQo57TEg8PB-5eIBpE$ 
>
> Are you using NM >= 1.40?
Yes I am,
❯ rpm -q NetworkManager
NetworkManager-1.52.0-5.0.1.el10_0.x86_64
>
> If no, what's your kernel version, and the output of 'ip addr show up',
> but also 'ip mptcp endpoint' before and after having started 'mptcpd'?
>
>
>> The version doesn't matter, I installed mptcpd built from source on the
>> main branch and upon adding these flags to
>> /usr/local/etc/mptcpd/mptcpd.conf this issue still appears.
>>
>> I will remove this option for now but Fedora had added this way back in
>> 2021 so I'm not sure whether removing this will cause any unwanted
>> regressions or not.
> I don't know if this note related to NM is well visible in the package
> description in Fedora and others. On Debian and related, there is this note:
>
>>  By default, this daemon will load the 'addr_adv' plugin from the
>>  'mptcpd-plugins' package, which will add MPTCP endpoints with the
>>  'subflow' flag ("client" mode) for the default in-kernel path-manager.
>>  Note that this is something NetworkManager does by default. Having
>>  several daemons configuring the MPTCP endpoints at the same time
>>  should be avoided. This daemon is usually recommended when
>>  NetworkManager is not available, or when advanced per-connection path
>>  management is needed, using the userspace path-manager and a
>>  custom-made made plugin using the C API.

Is this for all config options in /usr/local/etc/mptcpd/mptcpd.conf?

This note only mentioned subflow so I felt it seems to be related to the
addr-flags=subflow flag only. Please correct me if I'm wrong here.

Even removing the subflow flag flag and keeping:
notify-flags=existing,skip_link_local,skip_loopback,check_route
Still causes the error.

> See: https://urldefense.com/v3/__https://salsa.debian.org/debian/mptcpd/-/commit/66c1e8864a9__;!!ACWV5N9M2RV99hQ!M7wLbtcCWMUOxiZYPRZeuYxv3UR0LiDdFkqbSyB9H8eWUKvQthCSKvY4MAyYNCnD0gKQjDnQo57TEg8PB_IRLNLV$ 
>
> Do not hesitate to add a similar note in Fedora packages if it is
> missing, that should help people.
>
> Cheers,
> Matt

Thanks & Regards,
Harshvardhan

