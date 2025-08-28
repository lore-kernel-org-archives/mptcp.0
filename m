Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A616D21E0AF
	for <mptcp@lists.linux.dev>; Thu, 28 Aug 2025 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756391310; cv=fail; b=BGnwt/9cXoG2uyEsrBIxNwBcwe0bt86MhKuN3ZjkIpo9Y79alwvz8vI8Tzb7DdxrXDA/unZaxPMXAsGdWgE5wZrzBJ4VBznKuc9/4DBUoT+B8zZTKJsnAtQAZ3//MuRck9xB+F9vqQo/5wAs7GbJ+7ErER1iYuXms7cAGoNEJjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756391310; c=relaxed/simple;
	bh=xbdw6rV+BbpCgu5zra1ptWUGt8T6TBqljM/xl0osjkg=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=QSoDWCKmyzAJi5AM0rws33YHaZi+2BC5sB53y9ll8DbNFyZfr0EhsyB8IOxAZlwENtNX0AYFdoc2yatLY6dqENangc4TLNj2Ne83lVXyw2qGHBHAOxb+IBTA076Az2IUlkNdCMHqB+jQkffEokCTMP6gHPeiqSEFKNdDLor1XQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kPsWvzwq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NSl9ELQ2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kPsWvzwq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NSl9ELQ2"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SEN2Wo014302
	for <mptcp@lists.linux.dev>; Thu, 28 Aug 2025 14:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=xbdw6rV+BbpCgu5z
	ra1ptWUGt8T6TBqljM/xl0osjkg=; b=kPsWvzwq8GObMwKM7cdoi3oGgyIyaQ0u
	TgbjHgyXtPg5y993JZdxFk7VYffGAo3ZToGEblPlMCWy5+fn5hPEBU+RBN1ys3BT
	9yTFyXXt51FRcXRZMoBr349rX/ASv7oHMzGqQLMGXhM8Yc47DSl3/+VZgBffStYx
	tt1NkCN45wMewKA9Lwb1/8mGDPsXROBlUig3jXAoXEOtL/DCHWu2zOxGfMR7hhhs
	a0lq3KymlIah49fzQi1UEzM555aMqvu94MGRXPKTeOsisjSm8vpqPjuYZrWzuoiB
	gO7pqGh433pX2/+aS4la9acUzjefefgBLZkAMt7MoWmeQFhtHQex1Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q6790nd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <mptcp@lists.linux.dev>; Thu, 28 Aug 2025 14:28:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57SD1Icm005062
	for <mptcp@lists.linux.dev>; Thu, 28 Aug 2025 14:28:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43c39ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <mptcp@lists.linux.dev>; Thu, 28 Aug 2025 14:28:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1Qn0EWeFAAidQfN3SE11cXPxDzDqYU71IONynkHREJ7oVI/YU2q+1k0KhaeqjJmKpd9kJsu9KBmqjht+CPD7OZ/ZN/BtTaVTZmELCsXeHciLu51QrRDFCXQdJ4hJAysGmzC/x5bMrfx7ocamcqluEWmz/V3EKVhG0mP8JM1a63YvMXSbBEcwmQAHJq5WBrULOStVwxhFNDYB6Y4X6RzqkOrfjGNVttGBSOQ6YZJvS98QSTMogRnWWd93+s0mKi+4iYuQ8vnkCbW0SpEIZruSosFCcKWTHd/59Tw5qetMmBJ4ld7U0v1EqW3tXzycT+1PFI2ZREvdScuMqLQoxwfQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbdw6rV+BbpCgu5zra1ptWUGt8T6TBqljM/xl0osjkg=;
 b=iJzR3z/J75T+RT6i8V+8eAuJVYp6AAlUHELOxhdzBhkjMul471UP8MXSngglu/1IWEDto8CGZ+Qb7gIa4Jz1uqkc25QjtQmJ9a8/dLusu7efEmKf6VGhuFobmkadyxgvR40kRfENHnh/3yGUcEqcT21kFtXGBp79f4VHCsVk6xq3OuVa5k3wHOQR5g3RHkbMKKRLK6IsfWa1H6T4BkYWGl6bficOVjNru4t2YNeMZWJvox9JEJ+kK3VFBqoKe4tLSl0kPAws5UeF6IDYiQ262xrbXngr0oIxfam0G4Pks4KOnefosjRgYt1i4hWlV6Mbi5W7hGg1daxpX9XyaQBGNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbdw6rV+BbpCgu5zra1ptWUGt8T6TBqljM/xl0osjkg=;
 b=NSl9ELQ2Yteju6fbAqqJ0MCgK14JQx4JMXPsL1+KpPg/86sRkbaf8cG0JeEZ5bitN5UaK/ypJNxFQWdr815X3/fc8Gj1ytTBCvfffPOweaklPawkxViYkBUYb/bjDaAVGFzpmUzL8/qIZ5SFk4UPpsstqynvuCWaN29VIU1IX8Q=
Received: from CY5PR10MB6165.namprd10.prod.outlook.com (2603:10b6:930:33::15)
 by SJ2PR10MB7707.namprd10.prod.outlook.com (2603:10b6:a03:578::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 14:28:21 +0000
Received: from CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::7213:6bdc:800d:d019]) by CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::7213:6bdc:800d:d019%4]) with mapi id 15.20.9073.016; Thu, 28 Aug 2025
 14:28:21 +0000
Message-ID: <05f302dd-2afd-4775-9099-5c34c23e462e@oracle.com>
Date: Thu, 28 Aug 2025 19:58:16 +0530
User-Agent: Mozilla Thunderbird
To: mptcp@lists.linux.dev
Content-Language: en-US
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
Subject: Adding notify-flags=skip_link_local causes errors in mptcp daemon
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0282.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::17) To CY5PR10MB6165.namprd10.prod.outlook.com
 (2603:10b6:930:33::15)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6165:EE_|SJ2PR10MB7707:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c1879c8-47e7-42a6-41ca-08dde63f2342
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3RrWnFqbXd4dm5qMTc3K095K1dzdmtUNkpqY1dTVDlmOHB4TUVLZFRCc0hW?=
 =?utf-8?B?WWQxSlZnK0s4b3pUaFE3L3VMTHd2WXlDUEplb3NWVHdON1BMdDJNTEticzlj?=
 =?utf-8?B?bENzaHpTVG8xRVlmWEEyTXAxQTJCalhLVzFwMjVjcGpJVjRzdFY4cXdDclR1?=
 =?utf-8?B?eXYzcjN0Z0JXTDVwaWFSM3c4T3NGRHZFRGgrSmZ2bjVFYkNDcG1Cb3Z2SDZF?=
 =?utf-8?B?b2dIS1BhNUdPemVvc3htS0VLb3lLZ3ltYUN0c3BJWkp6bDRCMkxpQ2RRTk84?=
 =?utf-8?B?cE9VeHlGaXRRZDMybHh3alFYYkwzT3JmU3hCTjVueGJGaXJtNDcyK1NmQy9M?=
 =?utf-8?B?VHR3SndWZWl6WDBibEtMSUh0V1RYS1E0ci90Q1BBT09CbXQzclJLOE5kTFhl?=
 =?utf-8?B?OW1LS1N2elZKamYxRE1DeDBKSElxMWtkMVkzMmRsRkpNL3lJSzMyaU5wUUxX?=
 =?utf-8?B?Mkc5ZHBqV0hQcjFadmVBQStDYk0vMFM2a0IzOUhwWGorZytDdnB6bFlnU29L?=
 =?utf-8?B?bENHdnVYWnFId01yT21mMU1vd1FzdE1OL3NyK2xFRmQ1UTViN2MrU0dsbG5r?=
 =?utf-8?B?SXBBalNOR3FGVHluUnkzSHNlRDdpUjc1SVRtMFRWQ3ozWWFsdXprWWtwalBL?=
 =?utf-8?B?eHlsUm5vZ3QvdGlFVUttRkp6bmVKaEVORFR6UXZSdEFrUFIxRXpmUFhacXdk?=
 =?utf-8?B?cUt0QXhLeXYxTnNaeVRld1EvK3FYQzF0SWJHZ3NxQjFoMjBFenh6eXRLRXNT?=
 =?utf-8?B?c2lvaUVEZHJiY3ZtRms4Q2swQ1dyc3RCNFJUaHBEN0JhZTRxSGx3NStVZFJz?=
 =?utf-8?B?U1BLWll0d216YWdIeWQwdmZuR240bEVnYWd2TGR5R2xpZlI1YWxhZkk0UzZ2?=
 =?utf-8?B?WUlVQWRRempsZ0lHenVvNWNIeUthbmJFamdJVEdMQmJWY2pkRWYwSjgxQ29U?=
 =?utf-8?B?OUtCaFk4cERJdVQ0ZkFFRWdzRUtBcldpcEgrdEdoMk1za0ZHSkVZUlg2eDk5?=
 =?utf-8?B?OXZKVnFrRkVFUWJYcWhFeGZXWHFTR05hU2hvK1FWVGhaM29DRGRqVXRwbmFL?=
 =?utf-8?B?VjgrK1hWeis1WENwQnpSUVdHeUJKc0c3WFk3d0V6ZldKUk5JZkFJb2YvY29i?=
 =?utf-8?B?cE1OSjFyeWpjb3ZBS3lmUzQ3U3d0V0c4Zkd6alNnVzE3aDdDbVJ2VktWR2JM?=
 =?utf-8?B?OXBTRy9yT2d4YWp3eUdLS20rWnlhaTBVbGd0ZWhFNGRTeEF6YUE1M05XVjdo?=
 =?utf-8?B?NUQ4TXRkazZybk1zWFljK0h6ditFWW1zTTYwZXNKVnBCNmdkSTcydVk4Ykkw?=
 =?utf-8?B?UDl5U2Y1TTVKTUc1TGdpS2NPdHM5UUovQ1NhdGJOWUJYajNFTkpYNVQxWWo5?=
 =?utf-8?B?RmJJUzJQV0JOR0N6ZUNoZVcxNWhPTW5CbXFTcWMvQ2dxTkxuM0Z1YThWOEhx?=
 =?utf-8?B?WmZCN0hJbGVLZUlwUFdvSGdiRmlsYnVBSHJWcFBBUllWa3VWV3ZKS0ZqUTkw?=
 =?utf-8?B?MVFZWWF1ZzVmOHB6bi85eGRpK0x1eGloTkUxRnJxZmViS2xtOVA4cWNWWWht?=
 =?utf-8?B?dmhDcVRITWNuUGtjRTcrUHNET3lMUUhrcndHUWUyYkJ0OTFJdTN0YjNjU1A5?=
 =?utf-8?B?QlFBUHFNTFdRaU1YcHpMUUxIT2UvRUw2TlcvNGxjZStiWGhobEx6R3oySFZm?=
 =?utf-8?B?RVRsWk10NDNyWHMvNGlpdWRmUTdiMnBCby91SDluOUV1Tk1sVXIzNWpMSjBN?=
 =?utf-8?B?SmZIWnNNNDdvU0RRK0JNRkgrWmVEWks3c0JJWnBmMkhQaGhCdFUrTEhKVldR?=
 =?utf-8?B?YVlNU1BMeW0xcHhpK0NhRDdPU1dwMHphUXR1MytJWFZGbUU2MVRmdTlnVGZu?=
 =?utf-8?B?SkMvWmN6Vld0Y0l1ZHVuZGNDTVdsQ2ZlWDNMVmwyak05UXBOR0FBNzJMRlgr?=
 =?utf-8?Q?hrjpIRpBa6k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6165.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTRxaUo0ZWEzZTRPc3FZL1M0V09KT2wvOTc5bkkxdGdBWVJzQVNCWTNXNzZu?=
 =?utf-8?B?MWhOYnR4SXVVQ1l1VHlUNjYxUWY1NlpwNTdtNWo4Z29uRzFYbFdTK1FMVW13?=
 =?utf-8?B?aVVZQ051d1pFU3JSNW44UEwxRGVtYnd6emI1ckViTXVIWHUwMWxRNnNEcFA0?=
 =?utf-8?B?NnRKd2VlYitpM0VDTkhmL1ltM1FsaHc2cVN1QWphOEVKQjhVVEExdFAxVThO?=
 =?utf-8?B?ajdicWIwY3FwemdXK0MzN000aE1BbzhsZ0pqcFpQb0VwSWMyVkF3Z1RCaC8y?=
 =?utf-8?B?c2F4bHhkMnJuK3p0ODZCTjdzVmM2UnI0dVd3czVSZit5WEpzZkdsNUhHWW94?=
 =?utf-8?B?Qk96MG11WW9ZL2c5VmJmaWdmbmJZaHBYUDR2VDZqbW9PU2J0K254Rmh0QkRH?=
 =?utf-8?B?bUdTRUQwNU5ZZEdObExxcTFRdm1sT3h4dmErM0locFFsQWs5aWdOY21hTUkx?=
 =?utf-8?B?QkFQTG5HRXRETU1PZmljVkd0ZDFEa3dNSzRqR05yWCszUDBXeWh1WnpwNlBx?=
 =?utf-8?B?RUNWZUVLbTVXMitnRFZHQ1hsRExxbGtoT2RJNWZlMzNMMzdUU1VQYllQczNq?=
 =?utf-8?B?K2V0ZlkrbzZoZW5ZajZtdEhwTU4xOEpQYnFEQVJTbzhYdU9jMmRrU0VJWWJo?=
 =?utf-8?B?aTVZMUlGdnlkVXJWTVZ4Uk1ncFlSMks1dWdXVzZzN0J2T051YUE5M2MzZUpx?=
 =?utf-8?B?MTlNL1JTSDdWZmdjbHNCbGM5R2puZG10c0FKQ1BIVE51QkdFa3Q2VlJBWFo1?=
 =?utf-8?B?TDJFSWdwMGk0Z2hob0Vzb2g0alI2RlRLMnNvNDZvSlRMamNwblFETWVrWE1Y?=
 =?utf-8?B?QjJsc0RJOHFvcEJvQlpmZzVIQm9YVkpSdlJkTUcyWVB2c1VkRGs4c2djUkx4?=
 =?utf-8?B?NWlWY0xXc2t1R1BpZlQvTU5ub2FNRTcvVFlHb2ptTnhwQ01FdmQrZEpNZ0dk?=
 =?utf-8?B?YndEcmV3UStzTWZEY21pbUp6bkNCVlo2Nmg5blNEV212Q2xoeUcvSktleitO?=
 =?utf-8?B?dEw2T3VUMkxtVjdHNXYrWEl5YkhiTElzNzBKVzkvbXZrU2N5VmlMQTRicWRN?=
 =?utf-8?B?ZVdudGpSZWJaa0tOK2J4czgyU1hITXZhUTN2SVdFTDJMN2NrclBVTzRDNDAw?=
 =?utf-8?B?blF1L2FyTnMrNUlHamcyMEpBSnpQVEgwL2owWlVIUHNFTzhuZnBRUFZXbWt5?=
 =?utf-8?B?ZUIraWY1Z0RMZW5xVEhlSDFSSXNJNm1kcU53ZDhNcWtUR3NUTXpIN1V1SlVF?=
 =?utf-8?B?N1ZwZk9qaUYrSnhrbFg0OXZZRFpvMDFmN2UxVjU0azU1TmwyRHp6ckdVZWJy?=
 =?utf-8?B?alV3VndodnducDl3b2labzFSaXVBdnBsOXdUd3F6cG9EVjQrbHpmUzI4WHFv?=
 =?utf-8?B?UHQzQUxjTHhsODExNkZBUmp1WXJCRWlMdzFKYjlUSXozYUpnSkpMeTdldXd0?=
 =?utf-8?B?RjhuVWpTRjJzWU9UWWNqcHluOU1qRk9PcS9rbUNOeGE1dEVyZHNHOU9ZQUp1?=
 =?utf-8?B?ZTQ0QmhVQUZ5SGtibnZzV29NMmdsTUVJcUhNcEhINE8yWk43QmtHS0I0ZEhW?=
 =?utf-8?B?TXdHWHBKV01TRVM0Q1d1SWk4MXVGVjBNYklEaFJ1U3ZaMFVXdXJtMlVDMDRy?=
 =?utf-8?B?Z0VoWTU5RUNQaDZOcUdnaVVSSURZUGFuQ0F5T2VZSnZSbVZ4eWxickx3Y1Zx?=
 =?utf-8?B?UEdyaFh1YmQvdUd5anNqV1o2dkY2aVBXbldwWjUwVEpCVGhac3ZOL0xtaWRL?=
 =?utf-8?B?bHdEYjFDaDJiUjQxNXYxYlN4ZkMvUm14L0JieHpMaDJDUEZ1enQyWmpsSHVM?=
 =?utf-8?B?c2xYeU5OSHdKNlN3SlhPMUxsN2tBS0lZejNZMUxXNTRITjdOSlNRbFhZMkRC?=
 =?utf-8?B?Q3ZRZWlyYURkOGNPWkNpMHdqTzVoR1NqbHRhVFBjYzN5Y1hueGR0ZzhXeUU5?=
 =?utf-8?B?aWRGV2VCMFFCVDRYdkZSc0dDZHhSc1RXc1RycGVXRVZMZ0F6ZEZtcnREeEl6?=
 =?utf-8?B?dHhEZmhTRGM1Z3hQVUM2WDBxcm1EWXZuUW56dVB4bG1OMFlpR21Kcy9qMGxJ?=
 =?utf-8?B?MjU0OU83UTRWbFp2Mk9Nb2pid05XVHlyMTU5RHdXa0FKYzl5UXYzbjBNVS8x?=
 =?utf-8?B?ZzBxZXFJZlF3VmwrL2EyZU5FeG5tNW52ZUp6UytWSWNzaEVxa3RYbjVOaU5K?=
 =?utf-8?B?cWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f6gMVX2cOWUMlKr6fx/0Jhayxc7eV7dOd0/5/XkV+YjR6pMElfy265kVzdfvB/f+pn0tdS6QX5pJE1+QqkiK5sB2zGFCtfuV0HqnmqZPxUDCqOp0SLKXS3lWkSWhCY4bSiyaKJdrrB9Oyt04YaKRuMBPH/NdiTM7o+Li1kQS6kr2ZbIFjKjhiL2W4oQbnSJxAFAhsx1w7wXA9BbRAXO6FEHMrS8q/l/Ano1dG0H/5e5Mhz0Li5CPLo3OLWIEvm+SlW7UGRo9CJc9d3Fk7X4Ok1veJS/sSRnMCs/IhJM6NtY8A/1Nm8XtFzqA0EtLqndD2JojrfmOD5p8CSzECuxraphbQy0ZyrJrEwU3pMIch5qDPdWQihRQAIiIYDdmob9oOdpUkcOeviHZ99jjEYtpWSSy8TCi3TqfQOoaaqmaLwNP6m6HIHUHUenFT5oRUjr+FAgX0pzHq3yWJdm3l5/ZT1GZy7HVPYsYTsWgbpE6g5sIo5uDx9LpoBd+mDCkIoNrQG7jplfSe/hsCG9eyjx0lYIQkxoimkAtoEeO7qs7QEYCZfHF9H9ulBYoXRGVlGoHtCHPfx8GE4BHIcUtFp/H7HBcmKlkeI4aBkt9gEWPeOk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1879c8-47e7-42a6-41ca-08dde63f2342
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6165.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 14:28:20.9149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CpplAAfmHV/YYS1pPgXTwGEH2zpa4NLpNnxgrSMuWsdij/OGoRTvOdxfBw7CZ8huBpIvOhR0MvGun7vPH9PxvmtLoWpZODVelKdaOxTpSZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7707
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=730 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508280121
X-Proofpoint-GUID: UE8VewXOTe9Qp88XzcLBKVVCEhEvZLuK
X-Proofpoint-ORIG-GUID: UE8VewXOTe9Qp88XzcLBKVVCEhEvZLuK
X-Authority-Analysis: v=2.4 cv=NrLRc9dJ c=1 sm=1 tr=0 ts=68b0678b b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=_6YsPXZNhb7lfJ9j4bAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNSBTYWx0ZWRfXzeteXWNBSsNK
 zK/OZIHx5L+srmUXM6GxARrf3NODUeeH9OxqBoMfkF5NuGBrVwJ8TuL4O4KrZo2Yu3UbxP6s+6t
 sClAFM645NBOrGmfEIigwwJafxXWWs9rStfvbTMzq7Lg5l0tjG6Sby6ega/qeJU4G/fAIs//H4g
 Uql5zoIxKNSDt7pAE/wWRy69RtlDzYp/Thhe9x5vuZnZBkQqVue3h5G5fEszf8xpac55s9cwK21
 qG+D9lgQFovcqsWxMFR+VQUgWmFw7MbRiP6Sca8xS6LQT0XwERMZ88p8Ft+a1VefciOkMca0z9G
 AK7/LAcQ1vE82tnu4m9fDs7aaoUjnIKCWCC3t+9U6FhATVELqP+Je57DjEOrfSOpqBkGp0Nf3aS
 1fqOAuFx

Hi there,

I have been using mptcpd version 12 on my system and observed this issue:

systemd[1]: Started mptcp.service - Multipath TCP service.
mptcpd[2996]: MPTCP address advertiser path manager initialized.
mptcpd[2996]: MPTCP single-subflow-per-interface path manager initialized.
mptcpd[2996]: add_addr: too many addresses or duplicate one: -16: Device
or resource busy

After extensive debugging I found out that this was due to the custom
flags I had added to my configuration:
addr-flags=subflow
notify-flags=existing,skip_link_local,skip_loopback

Keeping the first flag as is doesn't change much and only the
skip_link_local part of the second flag is what causes the issue
mentioned above.
The version doesn't matter, I installed mptcpd built from source on the
main branch and upon adding these flags to
/usr/local/etc/mptcpd/mptcpd.conf this issue still appears.

I will remove this option for now but Fedora had added this way back in
2021 so I'm not sure whether removing this will cause any unwanted
regressions or not.

Thanks & Regards,
Harshvardhan


