Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11021139.outbound.protection.outlook.com [40.107.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBFA1C5D5E
	for <mptcp@lists.linux.dev>; Sun, 11 Oct 2026 00:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.51.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791677721; cv=fail; b=Bn/b910bSqOkebAeFZBYYtSFCLY2d+L9cFla+zKi+Gecym6D5s4vHPdCViVvO4TExVl+eT+ZDkhNb2KST/dxM/6tPHN1cMTYHU4xn6pXvidQmPlLaYgfHpEXbwBcZg1xS5mf5fQeuHuIwgQOnwXSxhMAlZdFWecchia0m+DZxTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791677721; c=relaxed/simple;
	bh=S9AZZvtYrG27lAvPVT7bqS0ZXHxGR4tPbm4n3LFdiIU=;
	h=Message-ID:In-Reply-To:References:From:To:Subject:Date:
	 Content-Type:MIME-Version; b=EsXxLRhqlP00bXQ4hQyFjwfEsI4J9EqNzNOV74krkeP3JrbWb3wL/ZXgpfEwwW2cY9QqVpijCkF3pEhI5TSFKPmD9c3drSy5rRMev6zWp1ODN5VKyGbAHiv28dYRRLAEfyjKgIEKX1KtwEVaKxW1HAhEswJOgvTSYPfbko3MY/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=persistiqalpha1.pro; spf=pass smtp.mailfrom=PersistIQAlpha1.pro; dkim=pass (2048-bit key) header.d=PersistIQAlpha1.pro header.i=@PersistIQAlpha1.pro header.b=PRO3ZAq3; arc=fail smtp.client-ip=40.107.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=persistiqalpha1.pro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=PersistIQAlpha1.pro
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=PersistIQAlpha1.pro header.i=@PersistIQAlpha1.pro header.b="PRO3ZAq3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUVunNFZvCIqE/v7vztXiu6iHgmk5aNFI7wmdG8NHr6fjvpLeak9Ytf51PMJ7q5JKIV08eZsRVhu7M4rD2fKBb0pMFvwwNowBcRQGVm2HbbhVwzZP1uWNeQl1XOrbAv9hujx4ulupUqcMO/G+z6B2mzUOn+hmmh199eCSTQWNiRadiQqE3ELgy7Fta0MZxtXm+pkh61auSvjkbLaVDSPY3C6CjEZXneQTibm9Qgc8gFSFlEsME5dF00Y1kfKxATZHrF/HdnEb6JSht7Z6JFNS7lI53ouT/Gkn8Kbtazw1LQhBHsZ6sgJ+t7aBvXE/QiyxJ41cfXUrVOC3mT+D949/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9AZZvtYrG27lAvPVT7bqS0ZXHxGR4tPbm4n3LFdiIU=;
 b=fVamB/SL4x8ffWGJwYnAjPPwAaBmo7VlEoLI0WvLU4gWQ0qLbE52ziFKGwZYiO3MWVQHEolyZP3smN8AmF+wwkdaMEad0XKsvJEi4dHJf0AZzCHFCsNYZtpHSgQ9dALvtyCx9ZOQ4VGxc07tbxZ0M4rKpIECOJoGsFuH2/2/Af26uDQ9GjScvTd7UGtD3E7dA3BwdEJx7a4rWqRVrN3bHliGYW9kkY3Qhal5+sGQ/bfT924Pcp78soXOxNWCfYx/3EdfAFJKG1dWlCDSKzRJiSGU8jgw/enhVXseHVlEjYkurv575OGulJYWYpVbxHZjDp7PNRG9Cf2qVaJCMwhY2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=persistiqalpha1.pro; dmarc=pass action=none
 header.from=persistiqalpha1.pro; dkim=pass header.d=persistiqalpha1.pro;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=PersistIQAlpha1.pro;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9AZZvtYrG27lAvPVT7bqS0ZXHxGR4tPbm4n3LFdiIU=;
 b=PRO3ZAq3lpFC2GhVpNI8Tc+KwDbZ1S7Vjkhsv+f2fTlnAkH6GUH4mh/bgIOiPDBGzShtVs+b7oxwT6kpO31DdDU1wMPE6pFXDHNp3LqUJ7pnARSGnJr1v41G/p6HoCB5Mq2zRUNp44v+bhIsPqC+M9YAGCR+fkbN5ctDRUSJF377ZLXKyHacdP6T49ms3mnJiNITI3ccR1qxVJjCGOCLnUqsxIOyHxycjknOYr5IR2GO8vd6qDDbjLoWdYFgO7YmIi2eI3UURSudzif7Ss1A5O1BaVAYHce4R4aCF2QOyYzdMuHHhZmWrgL8VcHFYAj1MldJEZ8GxFizkIBQVak8tQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=persistiqalpha1.pro;
Received: from MA5PR01MB12114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1bc::12) by MAZPR01MB5583.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:62::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.9; Sun, 11 Oct
 2026 00:15:16 +0000
Received: from MA5PR01MB12114.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5e2f:fac0:972d:8c93]) by MA5PR01MB12114.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5e2f:fac0:972d:8c93%5]) with mapi id 15.21.0522.008; Sun, 11 Oct 2026
 00:15:16 +0000
Message-ID: <01a12850-490a-78bd-bbac-a07716cf46f8@persistiqalpha1.pro>
In-Reply-To: <01a0f4c9-6046-7b14-91fa-0f93f02c6a22@persistiqalpha1.pro>
References: <01a0f4c9-6046-7b14-91fa-0f93f02c6a22@persistiqalpha1.pro>
From: Christine Bennett <christinebennett@persistiqalpha1.pro>
To: mptcp@lists.linux.dev
Subject: Re: about network protocols clients
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 00:15:12 +0000
Content-Type: text/plain; charset=utf-8
X-ClientProxiedBy: BL1PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::14) To MA5PR01MB12114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1bc::12)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA5PR01MB12114:EE_|MAZPR01MB5583:EE_
X-MS-Office365-Filtering-Correlation-Id: 52674083-9438-43c3-8bf2-08df272cba05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|56012099006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	G+d/XPwou/Nsw4Saww2R3Rw/wcpfQeL58nOJConTuPNIemXdWtP6X5GLdsPAcjOnmKhs59g7xI2KYxUSnso1ASiKX+vrzvNx4QEnz0Ea9/W7AcBDTdAC+cA1PVi2K1LmBUoWefBHk4WRFLlliouEu+vdbua3ibzPsmwxdplgwR63TV6RN8u503asXTO0OsfZWcs6mMm2PB0Ubxtjajnt8EubTj7NEP7ihwKYlBidsQ/vpMGkFqpJCO0OEm3H90s6hzyHX5j3Uc+LGADiiHYnJVFMnBhe1S7zNmzmxWa+e5D1J4X5CjygWglbtNOV1sLKl4spYxFsWzoyN9ZBb12dlK5VQCBI7x3MMjzdLUjOedAQh25R7OgnescA73tYmSzAYfgcVIluMQk6HfhJ3AeWbGkhGz0DeSoY1npeAw93Hf6wEOcxTBMP1T525Eeu5ZjGR35KqRURi7f9FXTiuQKuJqognWcIQSdRqb2wnruqLaOMmo+FDJ7Kif0eH4LnTe/YzSbpNSHD8BmetRRlsOeIOqnFB2DiaJl1dxOj1FaiD2Yg4s3Jr833PZha2E3VzXP7pY4yeTDkXxy7ubI/QcusCaZarFJwzYYtK+E6+kziLvfoaBm09FKxgzjcJny1fkEFnWEU2u12Z8ON231kDOVxDGcHGbR/Rwq+2bQ9eyj0cEU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA5PR01MB12114.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVpjNlBWQzdpVkxGMzZ3ZXVrQXRCU0lFZVJOY1FiR0xIZU51VTZnbldmSkg1?=
 =?utf-8?B?bUZIdVF1dTFJQllMYUhsZitCS3d0dGxUVUJXa2VEQ21JTGEyTjBFNkczREFJ?=
 =?utf-8?B?NEM4M2lPRlJObzdVelVFRUk3ZUhOMStYUVhzbWR1aDNPU1pObHQ2V3BHUGxw?=
 =?utf-8?B?bVBFQXlMNkl2b1J5cWcxWEhoRG9qZ0ZnTXlVZEo4VG5oV3FyTVUyMmtjU0dh?=
 =?utf-8?B?cVlIZVRMaUNXcmt3cDRISEFXS1IwV0t6UmNSdG5CMUNUZnlvTlprUXp6UE9p?=
 =?utf-8?B?WVBjMW9EQ0crUWE1c2lqYkl6N3cvU1ZoWHNKdytqSUxrdC9FQ0NwRmEvaHlU?=
 =?utf-8?B?VVRKL3FqMUM5TzVsb2lHbGNNVTBMNGlBdnJXVzFhM0tla0hBdjNtVk55SVFO?=
 =?utf-8?B?T3JnVFN1bXRha2ZXWnErWHZteWUzc296OE41WWVsR0NLMngrR2QraXpoM2ti?=
 =?utf-8?B?Ny9VQTI3KzJPT1R5WDFkK1RvRTNqRS9zRDUwOEpvNWE3MVFGdmtqdVkySFhP?=
 =?utf-8?B?WVNNMFdhRFNwYjYvR0xRZTk4WWtGU3RCTUtrT0tXdXIvY2gxS3doUFVPVmx3?=
 =?utf-8?B?SnVKTE5KaDZONlJQUldUcEZiZE5ZY05XamR5ZzFyNElqODB5N3V3WkdwZnlp?=
 =?utf-8?B?YjI4Sit2Ry9xZVY4SGNqeTZoRDYyL2xvZXNRZmJnVkxkRWQ3Y28rZEErcGZm?=
 =?utf-8?B?R2tJaWlEUFA1QzQxYUNBQUJhQkpWVnY5L3BWeW00RGFOd2hvNTZJSko0eTRX?=
 =?utf-8?B?SDdWVy84U0EyVHN1QTh3aGF2eHYyakY1TkNtMjJNVzUzRXZOVGQ0ZEZBbEh1?=
 =?utf-8?B?eGJqU0QvMitRbHFkMUJUdm1iUVFtSXJYbWgrdkh0cEJ5eEJSWTBmMERRUGVJ?=
 =?utf-8?B?dU9wSHNWb3F1UEt5dnFVdWNrSmQ4OE95V3VaQVhQVlIyQ3N2WGJISEM3V0E2?=
 =?utf-8?B?U3NJdUpYT2NxU3JJWHFHY3JFSXlnRXRtbkxhR1FBbGpEOE5lTGwzM3hZSmUr?=
 =?utf-8?B?STVPWGQzZTFVUWFFWTJUbFhSTlBqeVBOZkk4TmN1dmU4Qk9vYm9FVjhnM2t3?=
 =?utf-8?B?TUFlbHRoVVVVM05MMXE0eW9QZjQwVlZnY1lNZkdUTVZxRHE1OFZSdWI1SHVn?=
 =?utf-8?B?d09nNGhEOVhFRlZrbUFNbWN4ZmVPMnhWVDFmQm85U2cwSU1hY0I3c0dWL3k2?=
 =?utf-8?B?NFZHQmo2N2pWZ3NMWHdsZ1BOWGd5MWY4YlloZDd5Ui9XUE5aQ0lTakE5V2dQ?=
 =?utf-8?B?Q2lVaWx4QnhHWlo1YkVMNzJwSzZIRmM2TW5ZeXFtMDhIeEo4Ynp4djY5U29m?=
 =?utf-8?B?YjhOWmNFVy81V0k3R09yRWk1VzBmTFVDSDNsQ05kbFltMmV0ME1EOXdWaktE?=
 =?utf-8?B?Ym40ZU9xMWFaMFNHdERPTkpBbmhOemVXMlFJQUlhY2ZSblQ3Y2VQR1pVMFlh?=
 =?utf-8?B?QVB1TXEvVTd5MU1KTUxnZ0ZDTXhES1FGdXNCOHR1ZVpGN05reGQ0cW9GSVN1?=
 =?utf-8?B?RXdXWlM5ZlVYeVZLby9yWFl1MFZ4MEhoUi9malhJVGxQSCtoK0EvOVVkSjJY?=
 =?utf-8?B?NmRzSVBzS0l4N3BVMXE1YldLeWEyeG85OUxLNC9WOWltTE1pd3FRRWhhakN4?=
 =?utf-8?B?ckdlTDdOdjdScjBqTVV5TVdVQ05peS80RTV4RkdhNGV0RC8yS0NlN1pkWmlX?=
 =?utf-8?B?cEpQQjhBY0xsTmx0WmV2YUo1TWlENkxIMHptREh2RFpXck4vakJxZVdyekFJ?=
 =?utf-8?B?dUVXOUUyU29QM2xvS1NxTHZJNmFBRXZldzFwRTlpWWpqdm1KbnQvRFBVaU4v?=
 =?utf-8?B?cDc3Wk5hdTdCRVY3N29BbW1hbG5LSUV1SjYwVHFhUHJiTmRxRG5jRUVhdmhD?=
 =?utf-8?B?ME9tREtKYUtkb0VJMlV2MWRiVTFUMEw3M2dydGhlMzVxeWxwTEw2c0p1WlBH?=
 =?utf-8?B?UW1DNDFaaGE2WkVYYWdvYk5CSXBwNVdINzVEUU9YY3RxRFRVMUdVN3doOEpX?=
 =?utf-8?B?TFByMEU2ZnVCS0NldkN1QmtMOGl6OGZ2VUlJbGFkcjVwU0ZzS3NHQUVUbWtv?=
 =?utf-8?B?Uk1xb1JmRkIwZENzR3hrOGc1dWUwSVJ6L3lmemUzQkpKVys2cE03NVlmeFZm?=
 =?utf-8?B?YmVoWWplVmRCVVhoOGl1OTNkVHpGNFdHQ3MzV3ZrVUhEWXVLaDhSc0s0Njcw?=
 =?utf-8?B?eEY2N1dUWm15UVovdmdXdFRUZWdUNUVqK0h4a0tjQmw0dTRlemZacTdVTG5E?=
 =?utf-8?B?ZTZ1VW55eHF0RGNCdHQ4YjFORUdlbFovYkVnQUF5MEFyK1hIbHlaQWFyMFJO?=
 =?utf-8?B?YXRVdWdHQW02N0ZEVWtzZk1GTHQvY1FFS05wd2plRElIQUtWR1J6YWlHdlU3?=
 =?utf-8?Q?qAyh4QnG79sl0DWVAfm5ZAJinV+Pm1ahtJ7+V?=
X-OriginatorOrg: PersistIQAlpha1.pro
X-MS-Exchange-CrossTenant-Network-Message-Id: 52674083-9438-43c3-8bf2-08df272cba05
X-MS-Exchange-CrossTenant-AuthSource: MA5PR01MB12114.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 00:15:16.7067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 207f505b-349f-4fb5-a048-321d02f8ab9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VXKZcBTgrKya8+M1he2jxULk3UsOoNZqWQ9GG+JuUqH2TTQi7jOgPf2mzyMgRke0K4UFP8Gec2vbXdfC6GOQzIcEt9GARgZYSGo2c6c3ewxIKjt9DiymgBXg3b7F0eP1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB5583

Hi =C2=A0

I previously mentioned that I=E2=80=99ve been helping software projects fin=
d clients by creating personalized email sequences, finding targeted prospe=
cts, and booking them meetings with warm leads.

Would that be interesting to you?

Best,
-Christine
PersistIQ

P.S: let me know if irrelevant.

On Thu, October 1, 2026 12:07 AM, Christine Bennett <christinebennett@persi=
stiqalpha1.pro>
[christinebennett@persistiqalpha1.pro]> wrote:

> Hey,
>=20
> Came across MPTCP, and wanted to check if you are looking to bring in mor=
e clients for network protocols?
>=20
> If yes, worth a quick chat to see how we can help?
>=20
> -Christine
>=20
> Thanks,
> -Christine
> PersistIQ
>=20
> P.S: let me know if irrelevant.
>
