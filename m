Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900D73D76
	for <mptcp@lists.linux.dev>; Tue,  2 Sep 2025 08:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756801328; cv=fail; b=VfB15MZqvC/FicCWzhi4zDAQGitbsXaTujiTADNSN+F/j+my4ixxLRHIMB+uF0CPXRyZ/QYKeXn/PRe0/qs1L52vbkMkk8QB1FEiQCg/iZUK+n8WeKsrCQNJFSAqRGszWJ1EhpUcRq6YOyQbCL03dVad5MUqzGxfxScwaPRpP2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756801328; c=relaxed/simple;
	bh=W6StMM7D2wnHr/74Xw0+HHUpyPkjes2beedc3h8TcSc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QN8e3ciVyLxyNCFrxaC+olC7OTSGP0ijFpoQBIPgV2ML+L+GiECU/ntETeI3MFZ3HzQJZ3Rrut1QVBmEDt1z63sJs2tQNbCpZ62GyV93XJJnfK3P/jf5K7vW3d3QgGks6yYT+XDTwlJr5bIbf/3K7Jf0JPiD3b5Rx//y8+alTKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h8Zp9wp5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RBDa1iOq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h8Zp9wp5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RBDa1iOq"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5826fiDS032091;
	Tue, 2 Sep 2025 08:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ktpTvrKr9te2sA1hWSd+m96o1AOa2wQBzVdGK8kMpEQ=; b=
	h8Zp9wp5izrQvhmA7Yz0kgAnDJ3do2deZ6yIsSNA5PwndSobQl7NFfUWlbCFI6Im
	OJs+NOXcbq4Rn5CAOEeooxXUUy62YQ9OnVX/6fey34yaBnJpop7GkKABdirZcR+g
	gtcr7I971tzFq2OcxakJccF5TVwzuZOHN2ET1jFZKqV5s4yFK/U0dsEVVawTUWO0
	b7oJbS7DIg3JDY2jOdBF9/nOPRh4HjrUrEkQ2j0iecJu02uRaONN44l4qImpD9s7
	d/QW7dFfCQfN8XsjruaVNf1Nd27aqDiq5OiVm2hQvg9aHt0aTVGcMc6fbLVHYcPp
	yrsK22VpIVzis7tnE43Rdg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmbbfkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 08:22:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5826orok026871;
	Tue, 2 Sep 2025 08:22:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48v01n317s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 08:22:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FxkYaFGqYcHWwGafiekzz0YAxzCMiZ/JrDviTk5c/pNukjynckTjgihFlaR01orHoTGokLyRI5Hr9Mvh2wHaCjZIgd95g5pna5cZFWWdC/IkoBeKwQzUe/BXQWBCoQN1ASl9mwAh8Myiz37QiR3lLlwIzHUJZhlDYVeO5ZTSP2tFcuOCeblIm1gSmKIJXRuVPFDwqdm6Mmya69hAcfaHDj2zB+pHAYW39tiHy70KOopGMJ1Zi0naQyS+vhqovNxOZpgUidbyY07Dor7gsvyO54ZgYvlSdV+FC1r/vcwfToXY/usI7fNWrwxEJS3/dBSfNv+3e21Dpl2B0ka328Jjyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktpTvrKr9te2sA1hWSd+m96o1AOa2wQBzVdGK8kMpEQ=;
 b=vZfV5DZ44v6Ng8TzCFBZrY/jlmN3mVDjfhivJu6ZzNaty1bSQjQmDrUv1AW4O98F4Ofjvr/rHANQ4rWViCstz3LDJqbOAei1Qp4gUeuXszUl26iklLbyii1q/7wknmFtIbJVfCLAsu+xswYpBlyIFbFr9jvSkANoJQ63OydWCg0H8bVWq3BNidtK6Hfymhh3MchUG5etRDZ/rs6kcZbWO8sDtP9Wp0rUe2EFK4p9W20OZa/x2gXQITSydA7gxYwFhMnt6ECS/I6Wdnvs62V6keYNetozO+2cq2oKVcEXvMDm5M9OiaJvYVLh1rZJ5LRycShmufJliAC2vaSgTnaaHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktpTvrKr9te2sA1hWSd+m96o1AOa2wQBzVdGK8kMpEQ=;
 b=RBDa1iOqjn+ku6joYNWzp8DCE92Hm+ln/Y2de2EXMTsNuZHqUVeb89fhrhQe3PUBeqGJrULw1UjsW4wmEsTxtp2w1XO3Z6yYDuW+Lic+vr7JkKXBEVvqOk2d5d5rZZDnENq9FcVpPYx4PCuAojKx0ln2sMwY2vXWwc7bPi6U3Yk=
Received: from CY5PR10MB6165.namprd10.prod.outlook.com (2603:10b6:930:33::15)
 by PH7PR10MB7729.namprd10.prod.outlook.com (2603:10b6:510:30d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 08:21:57 +0000
Received: from CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::7213:6bdc:800d:d019]) by CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::7213:6bdc:800d:d019%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 08:21:56 +0000
Message-ID: <52b23670-87fc-4e88-92c6-5a4b2ed6cf27@oracle.com>
Date: Tue, 2 Sep 2025 13:51:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Adding notify-flags=skip_link_local causes errors in mptcp daemon
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <05f302dd-2afd-4775-9099-5c34c23e462e@oracle.com>
 <d4c74f72-2595-4fea-8a3c-10bb374e5b06@kernel.org>
 <f6fee54e-cba1-4292-8ec8-f959bda48348@oracle.com>
 <2cf621b7-ae02-48d0-81f1-1c56e24fd13a@kernel.org>
Content-Language: en-US
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
In-Reply-To: <2cf621b7-ae02-48d0-81f1-1c56e24fd13a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0233.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::22) To CY5PR10MB6165.namprd10.prod.outlook.com
 (2603:10b6:930:33::15)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6165:EE_|PH7PR10MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: d5c13c44-f40e-4cd8-4e87-08dde9f9c7be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmhyMXBMRDNqQjdBaUNoV3gwY3VDclZqVmRrY2ZpbUZlbTlobTFTc1ozOGxq?=
 =?utf-8?B?ZDM5dFdxT2Jta09iWS95dVpQQnl4eWt3YUdLV1hBV0lwTmM5WWZsTWZWTFVi?=
 =?utf-8?B?UHJaOEJ3Zy84WnVjYytmdEdFYm5Wc2Q4bTJqMWRBU0xDdk81Wkx0TUd1S25s?=
 =?utf-8?B?dHIvbGMrWW1uYXpKWEhrTHB2Mi9QL0wxc0E5b1RHeXc5ZzBZcm9DQU9VN3dM?=
 =?utf-8?B?T2lodzJVa3NtNEovTXFVcmkzNnpYbFFCS1NwS0NyTjZ2VWlpeEZ5VFhiWFh5?=
 =?utf-8?B?azNsVW5nL3VMcWhkSEkveElZbXBMNTh5SUdwRFRVUW1KdlVoUlJGUHlZbVRs?=
 =?utf-8?B?YS9oaWFxa0hBVE5JQ0d1VzBhOFpyazJkVVVsaGJJYk05TkloaUFHSWtlN2ZG?=
 =?utf-8?B?b0c5NEVaSEI5UlNvNC8zNHZyc1luTHJkdmFFRXUvdFQxWTR0U2Vta3JaMjVs?=
 =?utf-8?B?NDlGZUhEM3E1TFlnaG1oaUNkVVBNaCthYUFMQmhWUXp3dlpmaXdZRmtONWFV?=
 =?utf-8?B?YWhIRUZWUkdZY0NuSUVRKzVsRC9Help1angvdUYvaU9zck9UYjMzM3ZNNlhI?=
 =?utf-8?B?QllWME55clVnS2MxVW1jQUlJaEtRMW1zUVNrbjZSWHlGV0Rac1lFako4YXJK?=
 =?utf-8?B?MFEvbkVVdCtBUkhsM3RjQ3Y5QTQzdzVycmwveGIrb25DeVo5Y1FhOU5vN0U3?=
 =?utf-8?B?TUFKWnhPK1dWZFEveS9hdm5hV0dCZzhITWc3MkVRaEhZbzRYcmQ2STlDdTVw?=
 =?utf-8?B?TW5sRlhGUEYxR01UWng4OXI4MWRlZnNibzVwR2dkZjhlblU5S2Vad0ZwaTl6?=
 =?utf-8?B?b2l2dHhhY00rWUxkcm8zN05zL2s1WDdtbEViS1VlcjFYNHdJZmdERHYweVI4?=
 =?utf-8?B?UHl1eHIyaUp5S3czclpNVm1wQWo0d3FHcjY4ZXd5eGhhZ1l4MUlPWWJ4TlIr?=
 =?utf-8?B?dHliVXgvWFRPRi9CT1MzblozbXZzckFubThtbXk0bGJvbEF0RVd6U2RvVmRx?=
 =?utf-8?B?OXRVWTk0UDE3REFDM1JoMTZKcnJ5RlN6S1g0S2Q2Wnc1V1g2bzIzcnR2bGY0?=
 =?utf-8?B?NjZEMlVWK2lJbEVGWmlIZGI1akRhK01MVTJBSERydTBPbDB3MG1EaUdaU3Ny?=
 =?utf-8?B?eXE5TzJldjNWVGcxajhYalk0NVk1MTl5ME16QkdFWkJuNkc4VHUrc0dLZm1G?=
 =?utf-8?B?N2J5dmhTN2J1dEVqbFAxdjhvd1ZsRG5rM1NUaUY0YTJmTFFQaENSOHdKR2JN?=
 =?utf-8?B?aGJIVmRsdjdxbTZuNWRkTDRRV2lWNGhTZndiQmQrSS94RlQ1MkMyRFRHbUJ6?=
 =?utf-8?B?Uk1kSitkV2VJN0VPcWo2RjcwdkZmNE5sTnVqU3JjdnRJOWFqMXZQelBxdWtI?=
 =?utf-8?B?OU4zN3BBMytvd1Y3YmdTTWgvM2drVTQ2K25aR0NKOURNTGRFMTllbUFJcSti?=
 =?utf-8?B?REVPOG5XR3dNREZQcStmU2ZPVUtRMzI0YW11YTFrd2tsaSs4R3NoSmthZFpW?=
 =?utf-8?B?ekpucEoyNnp4U1FEOXBkVCtaZFhOKzhlZUZzbXhzbTA1YlBoSzFjRjl2M2ZE?=
 =?utf-8?B?cG16SUFKZE9wRFNYR283Z3Y1cGswT1FYOVMwK1dVUEJiMDA2R1BvNnBpOGli?=
 =?utf-8?B?bXdYTkl4Snd4R2tRdllTRHlyMGU3aWVZLzZCeDZFWStpWmthcjdERVJab2hP?=
 =?utf-8?B?OVNOVjFPS0trV2d3U2FSNXlQM2pSNkY5VEVOcXE4VW50WmpiZlIyZE9lcEF0?=
 =?utf-8?B?VWk3a2w5MFNmOXVOM0lKSTZHaFZhT0xFdzhRaGttTXhPYk1meHNtUERKV2JL?=
 =?utf-8?Q?sw1rpbMSBoKP9brm/dLq00lf2NY64hIEjPTM8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6165.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YW1ySTNiR1BCNVVlUlZUOWN1ZEV1dmNtLzdLZDBWUXREblE0MTJGSDdHNDJZ?=
 =?utf-8?B?Zi9KRVdyVjVROEJiS3BqUHVUYnZWOUtJNzB2TURWMXJxL0crZWIyUWl0Sy9q?=
 =?utf-8?B?emxoSEFxdVJmUUZtSjc4Y2dtTllOcm1ZTStRV29WclJTYUx4ZmhEc2lGRyty?=
 =?utf-8?B?NElWYjQrNkt0WVB5Y25WR0lCSHJMcWUxVlEwZEl5ZDhZdWh4QytLSjcwVk9u?=
 =?utf-8?B?STY3S2pGenVOQjZvcW9Xd3cwMXFIRzJWRk1PNS8xUEM4ZHFISlpWSzNlT1h4?=
 =?utf-8?B?S3Z1RkdaeDV5Vng2UXhRclkwcGNsTGtkOTFjbnI5Yk00QndEbTZDaEVIdjVo?=
 =?utf-8?B?NVIyTDRPeUxpdHVwSjdSaVNzS0VEcXdpT1FjcE0rR0VwZWl1dTlQYklISFNu?=
 =?utf-8?B?aEx3eDZSSkxSN2FldHo4QXhxb3V5eG5OTk9QNkJRMGFEaEt3WFpxVmRIR2Nz?=
 =?utf-8?B?cWUyRlIxYjIwN2dsaSt6MWRwcFk0bTV5ZHBCeU5VQWZZdm5LdS9pam9xeUxr?=
 =?utf-8?B?akZsY1FDV0cwMEpDalhGL1pwWTE1d0RzbVN1M05UajdLOWlscHdveldaakUr?=
 =?utf-8?B?T3hVU0pRdHpSK1RyTk93dUhmYkM0dW83MVNtQTlQSGdoMDNpdzNwWVI1dUVE?=
 =?utf-8?B?T2tTdDZMb2xyWm1GRDduT2JYcEZ6U3Y4MFFjODVPSW5JSWRxYkNqL1gvazRW?=
 =?utf-8?B?VHArZXY1cHcwaGhUK0RxOXlINE1tMC9HUDhBUmg5cTgwOVBScWorRzRVRXNY?=
 =?utf-8?B?RXRmOHV3bW95VmVTK25VclFWWU1mSklyM29OSFlNaE5YQ1o0YWlRZVl2b0E3?=
 =?utf-8?B?eG93VmNBR1ZNWERjNWdiMHpYa0pOc1JsTVhpT2dQUENaTWJSWjFjN2tIaitN?=
 =?utf-8?B?dmFOSUhIWWFIbGFpNjJzUUV4SEF3b09nSU1lengwTlFwZ3phUHpBRUtVak5i?=
 =?utf-8?B?bHgzMGxFTkxWMjgwUnloL1lwWHUyczJFWTdSM25vN1dSNnlpM3JrQ1NlSHJJ?=
 =?utf-8?B?Y0tzcit5QndTelF5MWYzNHpvZm55bGkxTDNBaGZwYy9FVHFUTFczNWNlTEZr?=
 =?utf-8?B?SHVRWElQWTdlL3JJaVIrVE10MHRGTFhnSDgyR0hUVlJWdWgvZ3lxSGY2VUtp?=
 =?utf-8?B?a2hCdTJZdkxZWWJnc3VHazYxT1BGNkllMCtSZHRYNzZjSUM4YTBCRXJzUXNO?=
 =?utf-8?B?SXRLcmhUbmREQzQ2WnRHc1d5UWs4OXczSTNsbVEraDFheEI4VEFRMkI4cGxJ?=
 =?utf-8?B?cnRWWTFRTktVd21jVHVrckVleEtFeFRHRzVaQ29sU0RxZENKSGJRMTMweDlJ?=
 =?utf-8?B?Y2xEUjVIUlJUV2JTREJsTmJWWjl0T29iVms3SzNVUVFqaXA2eXc1NFdaVldn?=
 =?utf-8?B?bUl1R0VXakw1dGg4NUM0Q2NRT1ZOVzdteWxmOUtpUllQZXBtS3VtamErdC8v?=
 =?utf-8?B?V2NXSUxiMVhKUzZHMVpLWlptNW9TM0lDN2ErUVg0aG5JVlQ4NG40RHZGb2Fu?=
 =?utf-8?B?V3pZcGpwVk9Oblp1dk42Ly9ER1JIRUh2ejZGQ2ljeU5HVUdFODNEaEtVZ1BR?=
 =?utf-8?B?QXcvU29LOTJ5VHlRQmVjYmprdDBYdFFNRmk2eVRZVCtySkRXREszWFBOMWQy?=
 =?utf-8?B?OW5VdTNlSVJkTkxaU0VBVEdNM2hDK1U4K3VneHpuUUV5L0w5eC82K3ViNmZG?=
 =?utf-8?B?Ri9rYUNUcVNvQUlmK0FScTJ6K2NHRFJnK0w3d3Q5dFZuaWxmMklmOUtzbmFO?=
 =?utf-8?B?anZuUG1acjVJNDlpcTJoWkJWNDJOUmlVa3RSYWVWTldCVUh5NTVhSnVjV3R1?=
 =?utf-8?B?RkY2eDVlZWJRRnpDY1ROWDRmK1Nzc25ENjBrcStTY2FKaTN0Y3V6cGZONlBX?=
 =?utf-8?B?djl5djk0cS8rMGRRd0pzSHNCYjlHeGR3UFJGK0Z1VjFZdzZPNFl5UEoyUHJG?=
 =?utf-8?B?dldMSHhVVVl1MHp4clIrWHJBSHFiSGRGMmZqZ3YrQ0RlTTJ5MW9rR0xyUFFS?=
 =?utf-8?B?OFFlckVDTEFjUC91cmRJSmdCUkJqdkVlMktvNjg3ZEtJY2g5Sk1rMXpSWkJI?=
 =?utf-8?B?MTBIL1p6UFU0eVhuK0doaWNJUmhLRE1lS0VYbjcxNjVUeE1TSmFoeG5Ub3o2?=
 =?utf-8?B?S0ZRMU9TcFljaEpBNHkrUG50OGZsVUJtRDJUK2hjMmk0MDJFQmVVelBGRWpo?=
 =?utf-8?B?Z2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zRDoJsy8axBTiX7Pm61hU9yTN0wRfEE10sQYqc7UYnipSSLviDd5sCyWW1R0vQLI3zxXIo3lza6ZMItaUorvLJz5VeLbJLyCsVPOvi/zA9iRvc0UXuMwZLvfOAEB+gebL9pByENWPcB07qTI6Qbjv/QhFCutFJ28vG1co/RY+kdUeFturMg/im2S4uN4J8VQ4Viswx0MJ3IcaLPo1+vSF/wx2m/gqi9CgEGXX12aVB2gYHLEuMM9zjl5O7436ngO1AtqbLkAtjVfSunmOfzHqVLUbb7ON6AC2QmW14l0tM+Bl4pV9BY6b1qj8LO+MDqXez4dkEuxO70I42FU4wNMPrp3nNf/lEqRfqcKfigNYzOI39ElOK5ZUYNSUFMIljBuwy28mM3mrxJr9j6xiZRW1zvWyu62pUhF2Vh+2ObSJkF2XsXSC7jAEe6O7RkaU3ItBy7G4o/Ngicibz2x7h/HV4qx+UWTxL1lNmFCSWuXEyVDXk7V6TRPTWb76sxJaans10w6/tG8lmOSmhnFrHLtTys5Inqz5fCT96H/zt17OHL54zBY/EYhjF5U3zdcciCInY1wvpUrA9dRyatTAxS6rAFTQzpPQqoIPIDDW/ahv7k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c13c44-f40e-4cd8-4e87-08dde9f9c7be
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6165.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:21:56.7823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z5OdxDOza9NQGYzsq0nnLOgTovUfeTEJYdv4q32Yc9xqCZ+4QwNDcDQNnVNfJ2ByG/U1uMS0q0T9zG+9hkmTq3M/mPGD9/tWsoN8v5X6AiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7729
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509020082
X-Proofpoint-ORIG-GUID: jkknpBCV-tlj15Ymzsvt4Pvia0v8g2KB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfXz5VifhbsHO6a
 RV7Eoi3kxge5nI7vksxulStnLBAn8ul5kT5A8psfo9jy3vVIbK1YEXHizwdkhSHNP2oscWlSTKY
 iGDtlbSgmyp3kXsIzrVBEr3lyXNWUcYUv08YyoOSDzYfcF0rFuFuiy0GHCUhN6p/mZg9gdX99IK
 kvUJpexjl54/fWkwmGnfX/qVMBai7ditX1bGRzi4G0tyA2KeEqTAcsTywff/2dF9GPo6k8OYFEx
 C4ymvxnzsACx6//QGZl9PTNuEjcBRsW8lcWbLGaJK9BaY2AEqnIua7U+gbruGQVYg0TpwL/1Ktm
 XfcaMt8PPClJ8Xo8GzeQibZHWhl6fsriFZMy9+JKPImSKqA+PpI5bsgVPwI5QT1VY5gd41Kw+a6
 GmfuBfey
X-Authority-Analysis: v=2.4 cv=KORaDEFo c=1 sm=1 tr=0 ts=68b6a929 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=fshrNHaMAAAA:8 a=VwQbUJbxAAAA:8
 a=_R5phv-D7z5Lf8aO1UQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=e3mraj3_9yMA:10 a=PI-FPnl-8C8A:10 a=-8yAR1PBeTAA:10
 a=l905gZIBnaGlF0AENO7t:22
X-Proofpoint-GUID: jkknpBCV-tlj15Ymzsvt4Pvia0v8g2KB

Hi Matthieu,

On 29/08/25 2:11 PM, Matthieu Baerts wrote:
> On 29/08/2025 04:28, Harshvardhan Jha wrote:
>> On 28/08/25 9:04 PM, Matthieu Baerts wrote:
>>> Hi Harshvardhan,
>>>
>>> On 28/08/2025 16:28, Harshvardhan Jha wrote:
>>>> I have been using mptcpd version 12 on my system and observed this issue:
>>>>
>>>> systemd[1]: Started mptcp.service - Multipath TCP service.
>>>> mptcpd[2996]: MPTCP address advertiser path manager initialized.
>>>> mptcpd[2996]: MPTCP single-subflow-per-interface path manager initialized.
>>>> mptcpd[2996]: add_addr: too many addresses or duplicate one: -16: Device
>>>> or resource busy
>>> Thank you for having reported this!
>>>
>>>> After extensive debugging I found out that this was due to the custom
>>>> flags I had added to my configuration:
>>>> addr-flags=subflow
>>>> notify-flags=existing,skip_link_local,skip_loopback
>>>>
>>>> Keeping the first flag as is doesn't change much and only the
>>>> skip_link_local part of the second flag is what causes the issue
>>>> mentioned above.
>>> Do you mean that with the following configuration ...
>>>
>>>   addr-flags=subflow
>>>   notify-flags=existing,skip_loopback
>>>
>>> ... you don't have this "too many addresses or duplicate one" error in
>>> mptcpd logs, which means it might be due to the "skip_link_local" flag?
>> Yes, skip_link_local causes this error for me without it this disappears
>>> The "too many addresses or duplicate one" error seems to suggest either:
>>>
>>> - too many MPTCP endpoints have been added
>>> - or some endpoints cannot be added because they are already there
>>> - (or the help message is wrong)
>>>
>>> ... which is strange, because "skip_link_local" is supposed to insert
>>> fewer endpoints.
>>>
>>> When looking at the kernel code (dev version), I think the "-16: Device
>>> or resource busy" is supposed to happen only if the userspace tries to
>>> add an MPTCP endpoint with a specific ID, and this ID has already been
>>> taken. Which makes me suspect the following: is it possible either NM
>>>> =1.40 is being used, or mptcpd has been restarted after a crash, no?
>>> By default, NetworkManager >=1.40 will add MPTCP endpoints, see this note:
>>>
>>>   https://urldefense.com/v3/__https://www.mptcp.dev/pm.html__;!!ACWV5N9M2RV99hQ!IpYyHXknDf7OI13aAkdo-amupYoR7R-gsFQtsQwMZh29C_9taCiFSCK5C-JcJZ8-C4bv53kqSPUSzjpemAmXgIxR$ 
>>>
>>> Are you using NM >= 1.40?
>> Yes I am,
>> ❯ rpm -q NetworkManager
>> NetworkManager-1.52.0-5.0.1.el10_0.x86_64
> OK, so I guess mptcpd is conflicting with NM, right?
>
>>> If no, what's your kernel version, and the output of 'ip addr show up',
>>> but also 'ip mptcp endpoint' before and after having started 'mptcpd'?
>>>
>>>
>>>> The version doesn't matter, I installed mptcpd built from source on the
>>>> main branch and upon adding these flags to
>>>> /usr/local/etc/mptcpd/mptcpd.conf this issue still appears.
>>>>
>>>> I will remove this option for now but Fedora had added this way back in
>>>> 2021 so I'm not sure whether removing this will cause any unwanted
>>>> regressions or not.
>>> I don't know if this note related to NM is well visible in the package
>>> description in Fedora and others. On Debian and related, there is this note:
>>>
>>>>  By default, this daemon will load the 'addr_adv' plugin from the
>>>>  'mptcpd-plugins' package, which will add MPTCP endpoints with the
>>>>  'subflow' flag ("client" mode) for the default in-kernel path-manager.
>>>>  Note that this is something NetworkManager does by default. Having
>>>>  several daemons configuring the MPTCP endpoints at the same time
>>>>  should be avoided. This daemon is usually recommended when
>>>>  NetworkManager is not available, or when advanced per-connection path
>>>>  management is needed, using the userspace path-manager and a
>>>>  custom-made made plugin using the C API.
>> Is this for all config options in /usr/local/etc/mptcpd/mptcpd.conf?
>>
>> This note only mentioned subflow so I felt it seems to be related to the
>> addr-flags=subflow flag only. Please correct me if I'm wrong here.
> This note is explaining the default behaviour: in short, the same as
> what NM >= 1.40 will do. As mentioned, mptcpd should then be used when
> NM is not, or for its main purpose: when the userspace path-manager is
> used on the kernel side. That's not the default behaviour, and it is for
> advanced usages: when a use-case is not covered by the in-kernel PM.
>
>   https://urldefense.com/v3/__https://docs.kernel.org/next/networking/mptcp.html*path-manager__;Iw!!ACWV5N9M2RV99hQ!IpYyHXknDf7OI13aAkdo-amupYoR7R-gsFQtsQwMZh29C_9taCiFSCK5C-JcJZ8-C4bv53kqSPUSzjpemFSPvx02$ 

I went through this and set net.mptcp.pm_type = 0 however I'm still
getting the error when I start the daemon and use the same options in
the mpcpd.conf file.

Shouldn't net.mptcp.pm_type sysctl flag prevent this from happening?

>
>> Even removing the subflow flag flag and keeping:
>> notify-flags=existing,skip_link_local,skip_loopback,check_route
>> Still causes the error.
> mptcpd's 'addr_adv' plugin will still continue to add endpoints, but
> without the "subflow" flag. Other plugins like sspi or custom ones will
> not cause these errors, because they will not add MPTCP endpoints. These
> endpoints are only used by the in-kernel PM (the default one).
>
> Cheers,
> Matt

Thanks & Regards,
Harshvardhan

