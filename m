Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11021101.outbound.protection.outlook.com [40.107.51.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD4A23BD1D
	for <mptcp@lists.linux.dev>; Thu,  1 Oct 2026 00:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.51.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790813252; cv=fail; b=Wf/EMwreCQa/Fl/LTlQ0OQ7g3BmMwHpS6aotb2JEuX9C/y+QJuidRMdmmnhjnt+DQHeRI/KKoMif+CF9BPBdn1Hwxgo31tNuPq2p+JOTEEc1gpQkF8fshF8paGKoyTWDoLI6jva9f9Ee/1BmTKdUr3xJvrJtJ4AqMtEl9wTwwVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790813252; c=relaxed/simple;
	bh=+3FruzEp5MpcvX21JB3IBepq5esxCTZdQSql6ocGtuI=;
	h=Message-ID:From:To:Subject:Date:Content-Type:MIME-Version; b=B7WBOVLoKo5zYURaB8Ca/NHzhywodKZDRGSzwtcfylpa1Dy27kYALNJHzQlppMFdxoDzzca5q09WwNKXSZmTkWz3e5spZpJX/leuj49j0W87WDbUXziAylHX13Rf5adFmEqHefKvOGae8WMPhgIinOxXIJ+4Yd6tS0gy8LtnUlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=persistiqalpha1.pro; spf=pass smtp.mailfrom=PersistIQAlpha1.pro; dkim=pass (2048-bit key) header.d=PersistIQAlpha1.pro header.i=@PersistIQAlpha1.pro header.b=PQsVBj9s; arc=fail smtp.client-ip=40.107.51.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=persistiqalpha1.pro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=PersistIQAlpha1.pro
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=PersistIQAlpha1.pro header.i=@PersistIQAlpha1.pro header.b="PQsVBj9s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6Pf/B8e/zLrcpPbIIAZ/z0SQpkQLdhZ0Fk5HpVVpTIdk03ebr1tBl6tz+5lY51cxjxrpVhW8nm584WkjldRuRC10zOeY2JbVqh9TENasBRNqtld3IKkCdAeXbtzHZv0zuzw4+q/khhpMWns8KFz7Xd5qhFJMqlOqii1t271y9+9ERyvA55zb6MJ/vZ9lM3o0XGaNMSylGi48RDOVLShyjBLr0DjnpuvQF5wlrCJmDg8YI7geXO/4k65NwTGfGzZURNjfHSgrrLhu+5zlUHxdt9AahddApgy2Rcm5kB9FdLY/BmA8Pbrh+qyOPsRnQmH14J5tydQ4TKOW4MtDzc48w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3FruzEp5MpcvX21JB3IBepq5esxCTZdQSql6ocGtuI=;
 b=bNaibVqcCW7pa2Cksxa7JRLz+bgQHn6Pk85EHVqQz/MEwKbbR8INw7U/uhn6Ej3Anwp7veXRDOr0G1ksCgRGOQXwTuEzdA3dVxY+BLln8FC0JQAInjF/SUzuWu+ct6Cc7lmwSi3PBIpc3XHx9RVgQxJVuAXszeQDrdiKSctorUaPxczhb9rSH6QLvXzrGLCT9Pb7Wsjy8EddPOoJjVUmqePesfBtKF5ugPdvN4M+cR8z9VSkZ0VMrqd23AGO9CabZPV+ERX+rBg75/Q6A1BnVMD9mswVmC+cniAom/9x5/6gzS7vnTySfkaqPfqvoyaXLgWt6Qy4A/Q2IL9RwO5t5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=persistiqalpha1.pro; dmarc=pass action=none
 header.from=persistiqalpha1.pro; dkim=pass header.d=persistiqalpha1.pro;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=PersistIQAlpha1.pro;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3FruzEp5MpcvX21JB3IBepq5esxCTZdQSql6ocGtuI=;
 b=PQsVBj9slDGvqbDjsna1NGSXpxepv8BOGXacGiy8Y4WAe8FaQUlQ7heK4SxKZIMTVpj1rhLOz3iVhOzydRi8I0sw6qpC53fyD0fww3zqTgRgv0kXEVnrwaOvHcDlr6RK7+2aXs/A5e/2QikdKay4hq45kFqy2L0vJ5VwbDCltoH2RYAbZmYqO8szSDV1G34QsDgy++aT7uOJFwdJUe6rgRnUSJBXTCYoDWV0/fPZV+Xn4bm9ycyrA5QCrKPWBs3ZVlGAddqweEP+AoX1CWTCF/mCkwAGYDPSLuBB7ZvkfJaX7sVModMhyZRJTZWzMoAiNtrM8ZWVIiYTYHhAB0ZgXA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=persistiqalpha1.pro;
Received: from MA5PR01MB12114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1bc::12) by MA7PR01MB728976.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:23c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 00:07:20 +0000
Received: from MA5PR01MB12114.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5e2f:fac0:972d:8c93]) by MA5PR01MB12114.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5e2f:fac0:972d:8c93%5]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 00:07:20 +0000
Message-ID: <01a0f4c9-6046-7b14-91fa-0f93f02c6a22@persistiqalpha1.pro>
From: Christine Bennett <christinebennett@persistiqalpha1.pro>
To: mptcp@lists.linux.dev
Subject: about network protocols clients
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 00:07:17 +0000
Content-Type: text/plain; charset=utf-8
X-ClientProxiedBy: BL1PR13CA0109.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::24) To MA5PR01MB12114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1bc::12)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA5PR01MB12114:EE_|MA7PR01MB728976:EE_
X-MS-Office365-Filtering-Correlation-Id: cc9a2deb-4253-4e23-681a-08df1f4ff64d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|3023799007|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	KAiSC6olr7OfTM3jBfXBoLmuY+3SUkKvgEXWOSxzhy10V3FW3Ldrwz2SSdqqWz4A012adF/NGujA/fqFfBSEro+BOOIo9MCykbP7OVc1YlLBAyZLfR5LZ6NRwhepcm2CnZPFxeejj2HjGeBDJnIvyCCJZuacWuO8qm0ZgCjOsnl2YRkv6p6V9SuEkahR1CXJgC67wdB/1iVIg2yHXfNt0PCo6qzU8zicSh7ziQtcmVxzGxhXLm4vMQcIfEB+V1gPm9XNfTtv9QPhe4TThYb38Ow5Y6LVLnK/pntRuxEpSjOiVGNoe3BLrf4ZFl7DaK4l1xYqIej1BWObwbtEJ83zkeqWrbahipy8h15Md4h2apf8RNnvCYpR6twDF5/hERdgoIbUOYwe2YywauXX+XQFU0Xvvfnr6AnlvJPa+mGhoCcWKLqxW/NUSgXJpf/+gp/8ZJd1SAUzylaXL3BF6UiIGq4cdH37HpSS0EJYmyCRFllDixGCEIcvLtOwHNjNh8jLBt2+2Uz3/et0cLXL+QwdmIcmu3arqAUqp+Ucz+nqVbDr/od/LvdLtXyoeYi+bsD/B8Gim9NrH8SYhgQ7CklyZ9QOVfO0PVQQMOS1b9s2vpZWtZhyUMsXND/9Vp/tF+ZR8ihiBBA5hq9ZLRdVver/YN1mdJaxu7wCqxIn9Hbsjmo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA5PR01MB12114.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(3023799007)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0RPQWRMSWlCR3JTU05EWmJMUTY5SCtUZEl6TEF6WFVNRVBGRC9uOFZZTStv?=
 =?utf-8?B?T0l1ZEs5dFpBZnZva1VsYURXY2lDOUtRRXZJdWhKZnVERzI2SGhEbmkzbVZs?=
 =?utf-8?B?NkYvVGppVXdWQXhseHkvN3NFaFZGajFOanU4VVJOVTRtblY0eTlBeERxVGMv?=
 =?utf-8?B?Z2d2WkVjODNqVU9hSXVJZHJMT2lWNzZleGJMVUJPWkdGYWdEYTduWlBYakpi?=
 =?utf-8?B?RkZnSXdhM3FHVnBXRnZNdzlJbzFhN0N5VllZME9YVmhXS1V5VVpIQnVXZ3l0?=
 =?utf-8?B?alBUS3JOeVc3R0pVWWpKeWpkeUl5V0w1R0RhaUFpWWFrYmhJS2RxZUVjVU03?=
 =?utf-8?B?TnNIcFJyOFNYWGUwYnV5cTYwT0Z0bXdjdjhWZzRuM242YXlqZ1p2VFpxWE96?=
 =?utf-8?B?QUdWTTNMSHJ0aTVNZUxPUGlOWnZpSzJSZlYxRUN0UGpHUjlCNk1YaUVHRk1j?=
 =?utf-8?B?NU83Wmc0T1NhM3BCc2t0RjBuV0x3UEowa1dtckRBblpCaDl6NXM3bmhDTTRl?=
 =?utf-8?B?b3dxVjd6U3FPRmdoQzdhQ0l6bjNxdDNPNlU5Tld6RGhZWkVuZEVManBuT3dK?=
 =?utf-8?B?eWwvSm5JWUpoMldwUWtiNW0rSVFCVDlicVNDWFhQZFYwQ3hHRGpUcytIQUQ2?=
 =?utf-8?B?QlFKV0FWNGdBWjVEcXRVdTNBL0lnZldicnlrcVpCRzM5ZGZSMjBPMy9kdWRS?=
 =?utf-8?B?VlZMK3YyckFSRkJGbWFvRVp3bWg5K013dWpCK2JWN09FVWpIZWMxVE9JRFND?=
 =?utf-8?B?MW5ocjdmZllxbG9WTHMxSGNNcXVBa3NBRTV6eVluZ2p6RmVEV1d1a05YTFVY?=
 =?utf-8?B?a1NjVUV4WnNQNVZqd2kvTEJnRmNUL1Vld2gwdW5GQldscWpaUHMxRkVjd24w?=
 =?utf-8?B?TmVxalpZUHd6TFNza3JBZUdWejh2QlVqdC9YTXNmakxneTZnejk5YVlONTMv?=
 =?utf-8?B?V1BXbHY0bGI2Q2hkRzBGVkZWbTh0akNWa3BTTnlZQmFjenE3V1RON0VtbkFZ?=
 =?utf-8?B?Q0JHMFBCQmVYMER4eVl2YzNrNmdFcndDODRrc2tMRmNsS1lwdjBBT01xb0E5?=
 =?utf-8?B?UDRvNis3akhTSTlRTDBKQXI5UEtQbzROQnlPT0RmZmZWdHdFc3lpQm9QUGVS?=
 =?utf-8?B?Y0VoSXQ2TVcvYUMyMWxsVTdQTE53TXpLaHJlSSswcFJCWjd4Z0RrYStSOXlk?=
 =?utf-8?B?dWpxYzZoRUZqeVRTN2d4aUNjaUF4ZFFvOGgwQXpIMU4vREF4Yys3VnRGYWZy?=
 =?utf-8?B?c29oM1Arc2NRRjNLK1Z0bGZGaVppQjFOemw5VW0zUTV0bStXT0w2NU9Sb2tD?=
 =?utf-8?B?eU9ZNUJmeVNhTlhqMDN5cGJQc1c2alRpMk9aS2NQUkRNQ3Z4TUZlSGFyY3lQ?=
 =?utf-8?B?c3hMaHJTMC8xM2ZoZ2sydXRlU1cvN0E5LzlsOVJxN0cxd3N4YVpodHdSc2tV?=
 =?utf-8?B?UDZaTDRibEtFVnJwSUNHaitKWXZjU3RzeVYralI0OFNKYitSUkp0OU1vbC9C?=
 =?utf-8?B?cmZVeVlxRS9FU0xsT3pwaS8xS2hKOHlwa0U3SEVGUTFwM1NrRVhpeVZaZlpr?=
 =?utf-8?B?UFRkY0hEYWxXcFQ5aC9hZEFrKy9PS3haY1Y2WGxIRU14REhrNWxFSnZnWkk1?=
 =?utf-8?B?T0t4SURGZnpxcW5jZURxTEpPMUtjWlpmVzJSSEt2QTl5enAyUEdCd3ozUHFq?=
 =?utf-8?B?Qlp3TjdvaFBxYk9ya1pFbURQZnJ0U2FmOFBJZkZWQ2YxUTRscVBiN1N3QWUv?=
 =?utf-8?B?VDlwVXZzNlg4NWZmNDZkNmN1ZkJEWitSV0JHVFRubC9Hb1Z5Wnd2d3grWXVS?=
 =?utf-8?B?RkExOGVNbEtJYldCT2kzaVJYZUZtQkJvVjlUT1BqVmpZY1U0Qnd0OE5MNldh?=
 =?utf-8?B?c1VtQlZnbnBBZmcvTGhVZ0cvazQxdHZZbUFGKzJVUEUwTk1McEVMUHR1cGY2?=
 =?utf-8?B?NXA4WWhBSExHYUZBQXBTNHVFMkJiK0QrMEdydUsrSEEySUFIR2JoR0lha2p4?=
 =?utf-8?B?cE9WZE5RQmF6ZXFZcHRaZTFGM2Q0V094bmZXSnRDaFN3SlpxeWtZZnZWWTJn?=
 =?utf-8?B?ZnlTVzdXaEY4cU9lWW5SSSsvOWJtUGs2aEZTN1BMMGZvTWx1WTZMS2l3Lzla?=
 =?utf-8?B?Zyt2dXdhaVZMU0UxMktPS0J2bkNYSVdhNUYzTmZVbXUvU1dpRzBZVWJmU1FL?=
 =?utf-8?B?dGh0UlJkb3dNL2VkS2J2TWd2WWtaK0dZZlV0MnJudjZSNlVKZkQ5U1M5TlNy?=
 =?utf-8?B?bGhYVGozaHh4Wkt3cmdEZllxNjZDbGMvWXlZajh0cUhXWTF4ZTUzaDBEOEY2?=
 =?utf-8?B?V3kzVldqR29USWJwR1hFRWZFdkVCUHJIREZPTWZNN201QmVYM0dYRGxGd0xL?=
 =?utf-8?Q?Kk5mzDbPDEXfakV0LjMiUKUC2zyDoSPF2sxsG?=
X-OriginatorOrg: PersistIQAlpha1.pro
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9a2deb-4253-4e23-681a-08df1f4ff64d
X-MS-Exchange-CrossTenant-AuthSource: MA5PR01MB12114.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 00:07:20.8337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 207f505b-349f-4fb5-a048-321d02f8ab9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0PqZRRzoQOh1tp+8X2J+VcY3E+5KS19FPObTyVnCDsYkkQD1ViKeA2aKV9bK8wBAE+EnOQOhNRF37UW29ijiGIFAEYXaWhRWgFdhQXB17XNvhrGqKD3eyAmGqfqcQ8M1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA7PR01MB728976

Hey,

Came across MPTCP, and wanted to check if you are looking to bring in more =
clients for network protocols?

If yes, worth a quick chat to see how we can help?

-Christine

Thanks,
-Christine
PersistIQ

P.S: let me know if irrelevant.
