Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC95168
	for <mptcp@lists.linux.dev>; Wed,  5 Jan 2022 03:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641353836; x=1672889836;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Piw4/t2fezpQ/5jb0gNrr2n8Y7MNuPNj6aIowaB9mEY=;
  b=HiotJ+qXH5JdkE/R5B/Fz+ILVpTI4fc1OIub4kL+h+v0V0+Pp5MqezQb
   xFSXydrwZ7Xkig5UFXWbF1DbiUAL6EsbfWSS/7FonqTFpgbOeKWDRCbcY
   1rGITO2JctggQ7gjD7GhlVmKxKFTfR4C+vhEWmSHZ1Xr2rNrNjKrDlYTS
   n7864ieiloIP6uaUQuGPt/HbgOal0JTdBh+PSwglUG+WjlSzYlKbZ1hng
   bWxqgXcJ5pzpFq3cr66eBc3nSohn1hQX2T0JNQrRjBMvbFxy2pn0PNJXs
   wtI9EyxvTacOVhrro6XtQVcm8DObTFRIy1J2D7NktB4t/70r37BbzUKM3
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="222352941"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="222352941"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 19:37:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="526473361"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga007.fm.intel.com with ESMTP; 04 Jan 2022 19:37:15 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 19:37:15 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 19:37:15 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 4 Jan 2022 19:37:15 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 4 Jan 2022 19:37:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYNwgbA8m/440+ByhL4izcrxsJkFgBGkEA7zLZNhsBWLISrUMH3K/xytlxWrCp/hI2en8uU99crguKnhGdEyNpGfRiLY74gbXI5xWYbF8BAUWzORRXqIsbJcEoZQM9ask1edvtIke+KCis+l4fn2GOZ/N4JJfdlecwok7DlgmxAw3g2NVAepBiPN4JVmaR4ILRBPcQXfxn50Jbz8e5OAuo6uzF64X5SBygeUn+g/axFq++L4cgLcZhgLAHFDQQcDUWrpXoslxRKXGyGr6N299SDvtZ+6XQ5Xw18fRVcn6E2lwrdHJj5P/aiCtHmOppCJ9sRHjiyfmk3mXxYABYIVhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rq7KTW6mFgsjYkNtNhPadAOss0n7oxIwo5bLs2uZg/Q=;
 b=YNkJ0W5s3GZapRLP17wRbxDViuq/aM4fD0JErS/UCrgkwIMc8vrtolQJhaJ1TfX6HSnqeWdVmZt46zwLY837n2iB15ijb9pyiQITHExD7BBHknMb4PNzFmkaH8+RslukR8IAmW1LOMUVjMngiRIVSrzHp1DkCYNp1IkPZWeIg1zYcp8owoYATDhHTzigQuu+9hszyOgCZYNPttwfj6/PitcCo7oK7g6FMyfa8LcjrJ/KKPOZBjsxqfIJklYn2ra4FQG0Dwarcknl6Z+bwuKDnZO1Ny8jBl9R8aXa/fJVAEZpeIqurPeyL8yb9J1hR+x0WR0+1llA6EZe2GJS2BESFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:95::6)
 by MW3PR11MB4588.namprd11.prod.outlook.com (2603:10b6:303:54::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Wed, 5 Jan
 2022 03:37:08 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::1c3e:cd78:54b3:2432]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::1c3e:cd78:54b3:2432%5]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 03:37:08 +0000
Message-ID: <b4adf3be-20ea-7a9e-7c01-c500ed7214ff@intel.com>
Date: Tue, 4 Jan 2022 19:37:05 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH mptcp-next 08/21] mptcp: attempt to add listening sockets
 for announced addrs
Content-Language: en-US
To: Matthieu Baerts <matthieu.baerts@tessares.net>, <mptcp@lists.linux.dev>
References: <20211216222314.1244708-1-kishen.maloor@intel.com>
 <20211216222314.1244708-9-kishen.maloor@intel.com>
 <7be3ba91-232d-1357-dcb7-b55b01d46f3f@tessares.net>
 <39006fe0-fbff-f08f-4642-6ef8cdb2ad8f@intel.com>
 <1d349ddc-a3bc-7d74-f626-737576af8e9a@tessares.net>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <1d349ddc-a3bc-7d74-f626-737576af8e9a@tessares.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::6) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:95::6)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25435744-ca90-49a7-d6c6-08d9cffca662
X-MS-TrafficTypeDiagnostic: MW3PR11MB4588:EE_
X-Microsoft-Antispam-PRVS: <MW3PR11MB458800AB56BE3EDBB4CF9E0CE14B9@MW3PR11MB4588.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FQNERwOIxWmXSD1ZEW09m3M/UXfq/iSr9Gj1tM5Zmj9o1VPEzbw1NDxLf+uSDlTohURcwrlqQrXToc/5Ew+wY+YzlZAX/g9zDWLaK1cWcL4RAA9iKxs89Zt39CweWpDeQiR818+K7EUSgMMqfLQhvpX0CoNH96nkebviJM6p7dy+nmymeYOypSsjqlLjtzL3O3XcTgjuiZA7hp+BWWYDBrcLsFPLU/w2Gj4sqbjJvSnHy+AQ6wch4aIhzZvVgUtOouZhRYu8kZQzpw+cTPpkrwr5XqySEmuOe0n9W0/BwHdrIKGFI/Fl2RYTyaSv0QeWpyB+OF0Rd2JUX0MILgSQJoMdwWLf8ZeKso0aeguV3c07aX6eFln69tH1vcFmP5SwxmwZpXhQDJdi777aISIOm5n+0RRMlTbhtxfmFeDQUTQX/qerONnNLE7WH+rHlSv4Ru33KqhCSh+WljzlXwYiuIAiYY84/2iJc7ydHKkR516ev7mdgXqJUsa8azkXuiRizDjPkRfX/AvyUU+T4o6Cb0AhKGol3VUxE76o+owtBdkF7BrbSAHzfJmG0F3odYNcULKWANkhvGiYoS508GD3qUM+PTmBovhRFzObqFXyxT/Z8/fLhgj6RvxPrsIoV6gignC3L7bc0zfGy3ZghgW1rKh/yxIjjLxDn5DB3O7m/gcbdnWKgljFbbiu8BCzQnY5FcAHsm6myqAAQqC7+VU1lZOXN8tUEKp2JwUXGuOZOLk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(6666004)(186003)(31686004)(38100700002)(6512007)(316002)(86362001)(5660300002)(31696002)(66946007)(66556008)(66476007)(44832011)(2616005)(26005)(508600001)(6486002)(8676002)(6506007)(36756003)(8936002)(53546011)(83380400001)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amlIdkJjVlplcWFnWWxMWURmOC9DVzEzT0t2ZjJiaWs0ZHdVY3VzTE5leVVP?=
 =?utf-8?B?b1g2WE5xQmVlcG1jeTBrbkg0bTJEOHd2ZFhVR0FBdDVTWkIwNjBQM1pneTNq?=
 =?utf-8?B?K0pGdkRocWpQSlErL3VObElWWGhoU3lRQkp5QUdoY3ZhMjRYeExMQlM5Y3I4?=
 =?utf-8?B?MDZwWVNZV1lzaXJmRThMTzZsLzNOdTQ4MC95MktpR3dvWHYyY3AxaUFVT1Zq?=
 =?utf-8?B?R0hRbldRYkk3L0daTzRRbG84MkI0bzBmMkdrZ0ZrUFZjMUNidm9ackFnNFhy?=
 =?utf-8?B?RzZFZG9ZdU92ckdWaDFEdW9ZMnVoeE5kMyt0Wk1oRHRGUHg2TjZUZzVJdUZp?=
 =?utf-8?B?V3RWZ1NJQitJRTAyNFJLNEN5RE9kd3ZBRUtQZkFoTWxiRGNPK01zb2tHb2tI?=
 =?utf-8?B?WUZmSkFxZnFNdGRIWlV1ZGlMVjR1ZXhpYkg3cTJPS2hYUjhEM0pZZWFBUk55?=
 =?utf-8?B?SXRXejNEVjN4RDdSN0V3SzFGd3pCbElaV0tRYXQ4ZFJNSmNNV1RNcVdEazhI?=
 =?utf-8?B?N3o0QXhpWWJNSW1Jd0syUVRnaEMva1dGWGx0a0ZVN0xFRTZqOVFFZDdla0Jo?=
 =?utf-8?B?dnFhWjh0TG15T2RrZThmN2FIV1JyL2RLVitFblZCd0FsQUkzenVVNGtqekpv?=
 =?utf-8?B?c0RDcnVjaC9INWpRUHIwWSs1cHorckNMTW1VeHZpb3FTQUFNY3hPVWZSMTlo?=
 =?utf-8?B?RU10Z0NMNHo2NG45MkN5SG9ONkRwRkJTMUJhSkNJZnd6dzNOYndXZThjNE1E?=
 =?utf-8?B?WkQrSE1RbzA1REFlbXRrTEdYUzREZ3J6cXNSL1JwcE5FZDQ0VmM3R0RuWktZ?=
 =?utf-8?B?eFR1MHBtc0Q4VzNRaWs2V2djNCsrdUFTR3NJWGtrdG5kcnhUTHFudlEwQ3Zv?=
 =?utf-8?B?NTBNbDRDaUpQcVpld3BZY1JOZmRJMEJPMmNsc3JmKzE3bk5uajF6NDJSN2ZD?=
 =?utf-8?B?M2pXcktFYytGZDJ2MHp4Q2YwUzVFd1FKeTI3dDg1bW83N3RwbUFYMnYyNGN0?=
 =?utf-8?B?a28xQ1QxSGZhL3IvZHVHSUxTbFBTRU9uWDhzWnZqQTc1TjN6ejBJbm1JanAz?=
 =?utf-8?B?eHdjOXJ4VFIwN3VoQ2tOSThHRzJWMHRVcHVVSHM5T0pCZTZQZUl6WlJQMzlG?=
 =?utf-8?B?T04vMGFSRk1xcTNPSWVvU0ZwbUNDUVRzVnB3WGRpOWVoR29ZUnNud2pqbm4z?=
 =?utf-8?B?NGwvR2IwMVZSWkg3Kyt3RDFONDEvTlNKaVdlWVVXS0lKT3RhUXZRRVhVR0Rm?=
 =?utf-8?B?blRYRGJ1ME85dW5adk5wcFdycnIzM1cwRFdBQWYwYnRSbHB0Y3dUcms0ZFFi?=
 =?utf-8?B?ajczSlhtVGIyeEV5VVZXMHp0eEJKaEN6VXpHZDFNK09jMmNJMkJjeG1tZGFM?=
 =?utf-8?B?MEM3Z0QrQnEva0hCVU1wNFk0WVh0Tkk3eHJjd05IQzc4TFdodEY3Tkh6MWsy?=
 =?utf-8?B?YjNzYzNiQ0hBcHRBemFIcmw5dUV2TzczZHlMdC8rQk1aTEZhY0hGd0dhTHZa?=
 =?utf-8?B?LzJUN3pDeVNLZ3BJRHc1UXM0VjhpTVRRdHhCYXRaL0RXSWtmQ0MvcSswNmRt?=
 =?utf-8?B?dE51SldFY2lSNm5tT1lSME55Unhpd21ZZTlzRUNUVDlOUjQ2V2dGTjVUV29B?=
 =?utf-8?B?QnhIMkhGVFhGaGdsRmhPTXV1TTFOYlRVNWt0VUZCTXVnSDVYdzcwcm9jcGpw?=
 =?utf-8?B?N05sMFNOWEtySk1nKzd3RVBEMjZ5c25GVzBqMGV1eXVKbkJXTVdnRVVjVldR?=
 =?utf-8?B?ZTR2dEhpbWsxMXQ3SngwNzBrZkJQTXpnUDJFWEFidklYdW9HQVN0VzdtY2Fr?=
 =?utf-8?B?dVlnYnEybjNlOHhtMHoxTS9uNjNQaklTamp1Z0tDRTVuRmVpc295RWxZK0dK?=
 =?utf-8?B?U2hVY0FLMTFlRUxnMWVUWFVtbjFqN24vT01pL1RtZXovMjVwcVRkdUx3Q0p4?=
 =?utf-8?B?Y0ZmVVZSQ3hvOGdLSVVYZExJQlZsNUNPNUM3b2I3R2Q3eTY4RjlxdDNpNDRj?=
 =?utf-8?B?dm1Dc2dzQ01tSmNYTVpLNDIwRVBSRW9yc0gxMWhUY3FDcUl1bWpQcmJ6Y0hr?=
 =?utf-8?B?TDAvY3U4VndqR2Q0djRCaTEvOFR1TUJuSTBUV3AzMkRqUkFBNEYrZU1nbHRG?=
 =?utf-8?B?NVV6c3hITUNnOFc4aDZLNTJRUCs4OUZsTVh1UFB2c3NpZDU5V0JOdDBmNFZx?=
 =?utf-8?Q?qapA2kEJM2NAAeIGQCA8w9w=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25435744-ca90-49a7-d6c6-08d9cffca662
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 03:37:08.0932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmZWkcmIrCccUjGJFh5G6IyJQBNIAzkOdayofuuiPKgVPkwUq0usaNiI2PDtWhaR/xwhZWIbu8fMDBJAU1ZjNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4588
X-OriginatorOrg: intel.com

On 12/29/21 6:03 AM, Matthieu Baerts wrote:
> On 21/12/2021 08:34, Kishen Maloor wrote:
>> On 12/17/21 8:34 AM, Matthieu Baerts wrote:
>>> Hi Kishen,
>>>
>>> On 16/12/2021 23:23, Kishen Maloor wrote:
>>>> When ADD_ADDR announcements use the port associated with an
>>>> active subflow, this change ensures that a listening socket is
>>>> bound to the announced address and port for subsequently
>>>> receiving MP_JOINs from the remote end. In case there's
>>>> a recorded lsk bound to that address+port, it is reused.
>>>> But if a listening socket for this address is already held by the
>>>> application then no further action is taken.
>>>
>>> Do you think we should add an option not to do that?
>>
>> I can't immediately see why that would be necessary. I would think that a machine that
>> wants to restrict MPJs could choose to not issue ADD_ADDR advertisements. 
>> So it could be more a matter of path management policy?
> 
> Yes but likely, the PM is a daemon separated from apps creating
> connections. Maybe some apps want to add restrictions on purpose and it
> would not be practical for the PM to check what kind of lsk has been
> created to know if it has to send an ADD_ADDR (+ create a new lsk) or
> not to respect restrictions set by the linked app.

Yes, the PM daemon operates independently of the application and within the scope
of its namespace. The PM daemon could be the enforcement point for any application-specific
restrictions.

It could expose an API that applications call into to set PM policy (e.g. don't
advertise addresses over this connection), or may be the he admin/app deployment configures 
the PM as such for that namespace? 

The kernel PM has an API to set "limits" and I'm not sure what's its usage model wrt address
advertisements (like who decides to not add_addr on a machine running a client application?).
So userspace PMs could be modeled similarly but with much more fine-grained controls.

> 
>> However, for PMs that do issue ADD_ADDR messages, this change merely attempts to create
>> or reuse a (previously established) lsk (which was stored in the kernel context).
>> But if the lsk is held by the application, then no action is taken.
> 
> I didn't look what was the cost exactly -- probably a look-up in a table
> without locks? -- but maybe on a busy server, you don't want to do extra
> actions if you know they are not needed.

When one end of a connection issues ADD_ADDR messages, an attempt is made to
create a lsk or reuse a previously created lsk.
If the application happens to be listening on the wildcard address (which may be most of
the cases), then no lsk is created. 
You could say that this change is at its core mostly covering corner cases that were previously
left out.

If an ADD_ADDR message is not issued (based on PM policy, for e.g.), then I think essentially 
nothing extra happens.

> 
>> There's a separate change in the series to allow subflows to be initiated from either
>> end of the connection. So in a scenario where a machine that happens to be running a MPTCP 
>> client application issues an ADD_ADDR message (and reusing the subflow port), an lsk would
>> be created as a consequence of this change.
> 
> Even if it looks very unusual to me to create subflows from the server
> side, it is good to have this option! Thanks for adding it!
> But we can also have an option for these two changes :)
> 
> Cheers,
> Matt

