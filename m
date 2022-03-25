Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682927E
	for <mptcp@lists.linux.dev>; Fri, 25 Mar 2022 00:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648167521; x=1679703521;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=PNURDisPjJ56H0135pWsTcBIX4QhT3Pn/4dQNOps8Bc=;
  b=iRYlQRo2hDnOhkti6VBqE1fdTJs4AuVqM8n+ztpzSC89h9H9yO3KRTji
   dvx6c6D/3EpsNpJeXvbHFf9msrr0Z7ovyZx8jLVLi+6rKGZZRLF2VblsO
   n8ZPUnS8PpIrfqQdh67+UoVFJEcoT+WeIQi0U/eygyA38CpDIOckfoTHb
   WxQ94gdxw6pCB5uO38AFGNwlMoHO8iwEEShYWn1AH2K4fP+NcI8a7hi7D
   21YbnNEnyPOWiK85OpgZ4lRU1qsLh0ZvLP9a18F6L6aqiXCPRQ1LffF6L
   yTGXf9TCVQhr4BgX3TK/QqYS33S+h2bVkwy8IvSgzGeHHLtAKBIhlJ7X4
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="240677379"
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="240677379"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 17:18:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="553050804"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 24 Mar 2022 17:18:40 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 24 Mar 2022 17:18:40 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 24 Mar 2022 17:18:39 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 24 Mar 2022 17:18:39 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 24 Mar 2022 17:18:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cliapBgNuqbznW8EIcC6vMfZk/Sv2odZYq2WDjecpXgwsjaIZCJyhwNQrqEesZq34ZNTeOaHa3H4lbCRJ8oOuPFCHMu32XPke6Eco2yLJH6jRUrn/hFkDgayuRMKkXeZaM+m150c7BU7bGSrR/PtjaBemD+A28oa3x8MxWXJSFICx9sB2LtbTqEVhEmFG8RGEg25z9nAGS1vb9X6pyn2ZgBcLbWQ4S9E5AVXx6Q1pmbEvfEHh0QZOh47TvSZtSq6/ILESC2MM4VneXiK7JdwQWU3D7kbMdVAPcaW9QhVcxKUZCJIk33jSsU/7Q3thisw/OuJmwaAxfPc7wpAYyjAUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCRpiw0UWeDQGEFlItB8915hYdbw5GwvV2CNQWVJZfk=;
 b=Nbxse76nNIejFsi6k19JDHJwD2w/PV5jI1yTHmvgDkRjSUzA2NU2wCx9WizjJOSXpd0nVrkuOKv/yp48gj8g09v9yYwMhiYrmHtgcylwBAnHQw7dhzybKgYO+CXdU+UtRJIL57hIZaYFT1A5pDV7vb0LSAUg51qBhp635Ri0LI/4WmTqPwqgE1mFpAuhq9iKXZqXHcx6hWeTdCp8QH89luJ5ibt4/IbIBRBoLJ3vNMI1zmf9pjqSB1op+Vc7E+crqUC5MwQl7MhHkCAKxelGK7Q7DyMfEKYumhA3xIynMBoKYKgf1cNMEVdVjo2fdf5lrNZkMPfa9+pVa28AMwwkBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21)
 by SA2PR11MB4777.namprd11.prod.outlook.com (2603:10b6:806:115::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Fri, 25 Mar
 2022 00:18:38 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::44ba:c91c:ea6c:118d]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::44ba:c91c:ea6c:118d%5]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 00:18:38 +0000
Message-ID: <6ec189f4-432a-7f53-c566-ee42d5aee7f3@intel.com>
Date: Thu, 24 Mar 2022 17:18:35 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH mptcp-next v5 03/14] mptcp: read attributes of addr
 entries managed by userspace PMs
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, <mptcp@lists.linux.dev>
References: <20220316231636.645625-1-kishen.maloor@intel.com>
 <20220316231636.645625-4-kishen.maloor@intel.com>
 <fe282bdf31c684037c4be06bbc5dbb08ff756bb4.camel@redhat.com>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <fe282bdf31c684037c4be06bbc5dbb08ff756bb4.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0070.namprd05.prod.outlook.com
 (2603:10b6:a03:74::47) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:9e::21)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 164dca22-e946-4009-b8b0-08da0df5020e
X-MS-TrafficTypeDiagnostic: SA2PR11MB4777:EE_
X-Microsoft-Antispam-PRVS: <SA2PR11MB47770ED96AA008A51BA5DA46E11A9@SA2PR11MB4777.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vp173QGklLjfZXTf1XPyppV3IxeX56FON9wbd0Nc6OVnLvrz3C/PkZ/W11URaPaH9LaTtVm3HTdnkiP3H6eA8nd+TdKhpe9HelwLyKxac756Sx8yEpELCeNq9gK0XObaeQE+2zF0GXGgd3s2rS5l480yvCaC4N2p4HinO267yc1jDzMsCY7NAX6+PuGyZEHikKEbVMfZQxb0zg3Qjr610CZ8qb9nkhmvhQhvos7qE1vlu4dX7RCxDXWwyeZ7mcNaiqJS9I+rDXDSDp1esyxYxvQGei3kL8cauKvDFZ7LUTH4ajQldi8Q11M5HdV97rCkQf1iPYNav6ugRHYMMPikyp/XjkQzPSuh2OmZHw0r4uvr3PttProzVIyXqOYeJ1dHI3q3y4toNs+frXqK15i8XXBQfJ5TGm6hMLQcKZ1ny/g9BioxXW+ziSeOH1Z2DXo5VKmf2XQgMGnUJt7HzBJcF7bWgtM1mVGIYKlpnETl0F4+6sPqA/hyikZnv+OCwwPNCYidoTrPTmW0DaN6k4OfEAokK9sXRpmfMCkVGDMHVPWwwBC7NEx6eypp/GkRuNN5EykQ/Wqx043AyawEkV2hTAckbJNa1x4pKRbgE1Np/ux1q1BTQo8MVoVBQB/dnpdc4C7MLYr2YhCiesD9xJ5kOSPfNooFR0vsuaqjifaxSA7u2AARdG3aai2FLpQIoe8fHMi44nYJRl8/Km/DkaHlLxvLTlzaW9USmG68+soaSuEP9KkShUOP9vDpbLGN29yYfWRo2pq9/p5rTR54NiTBNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6512007)(2616005)(8936002)(186003)(6486002)(53546011)(83380400001)(508600001)(6506007)(2906002)(31696002)(6666004)(86362001)(44832011)(5660300002)(82960400001)(66946007)(38100700002)(36756003)(66476007)(66556008)(8676002)(31686004)(316002)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?US90eXdZNkFXdlY5ZVAzMTVJS2ZjSFFPeDRnMDZ0NWlLYk9qWkVnc2xnTkgz?=
 =?utf-8?B?QndoUHVHeERxZ2dUcHRYelhTOXJzM1pnVWVGYVdSVE9WV0NZcEhhUVVocXlk?=
 =?utf-8?B?RDQrYVZ1MWJtNGdZdzRLaVZjZDl3OTRQTUhwKzVTNHQxRHZZc1NaLzE4Q2U1?=
 =?utf-8?B?bE1uQnNYRXUvQWJvSkRKY0tJNkg2cnBGbHJiRUZkNlZGWHlhY1JMVzQrMkg4?=
 =?utf-8?B?enJPSjdaa3cxem1kcTBmVDZzclJaWjhQdWM4NS9pN2ZBU0NVVTFzREJtMWVI?=
 =?utf-8?B?QXo0VzhoZG1SS0NBTEhlTEFLY1BCeTdMV0s0OEVhbGE1REpRa0sxcElOYk1h?=
 =?utf-8?B?WlZDU1RQVll5anhEK1NtQk15dHZVYWJSOFpnSnJvcDJnU3ludmN4N2ZMNFdT?=
 =?utf-8?B?emVzazMvcVJyQ2dhN2k3MHErRWFrbWo5NThISU4wb2djOHBNWnVLWTV4OFlJ?=
 =?utf-8?B?S0NFZlIyM1psNG0zTjVUTFhwbGdjSS9KVWVRWGJMWWlmZjhaTEt5K3dkK2Nz?=
 =?utf-8?B?bmtyaUx6RnVhenZpQ05YQ1NRQklEdVZGeVNITDNnR2l5WkcrQ3NVSklCdUla?=
 =?utf-8?B?VTg4WDdUL0JFbGtGd0RyZFYzYnZ5NXg0UE1IVVlzS0VtSDZ0dlBGRVN4NTlq?=
 =?utf-8?B?Y2RMOXY5Q0VlaWJMaUFWc0xRZU8rZEUzQy9tamo0Nnh0YVpyVkkrK1U2LytK?=
 =?utf-8?B?bDBoYWtUaVRqbktMQ1p6T3JiQUFnNUF5S0ZWejQzRWRZZEVxU0RzcUpIYVkv?=
 =?utf-8?B?TURRdXZoakhUZ2V1cDdnSzZEbVVEZ2ZSRms3WE1DSDdvVjhEM3NpRXBaOXEr?=
 =?utf-8?B?Z2Uwa3krc2RXQWFuWXFib3F4UXY5cUI0K05EWG9PRjUwUEFmd3k5d2ptL2hW?=
 =?utf-8?B?d1lMdm5BYVBnSi9rZXJ6VE5TSzVxd3dqbUNtdzVtY3A2NzBtRHN1RzZlOUNK?=
 =?utf-8?B?YzFwamVSUzBNYmI1ODQyZDdoQ3JDbU9GMTNEMVlaMzVseDdXTU5ZdUhoRjJZ?=
 =?utf-8?B?WG9JaHdydVNYNk1HWVpEOFQyejJPS3kyaXB5S2s3bStUSWtyV2c4TzRjeHRr?=
 =?utf-8?B?MDYvN2pnc3hEWWJhc2ZxeDVySEhrRzlTQkFrMW01MXJiQlB6cVdXa3pQMTQ2?=
 =?utf-8?B?MGI4cW5GakNoNkFoWW1GbUdNa1pIMnJUckFIcG02UGk3V0Q0a1FEMWZiN0kr?=
 =?utf-8?B?d0pKSnFrY0NXbW9BS2dxOWU5OTJ2L05jcTc1ZjFGYWxUQWtaek5pZDZsTXls?=
 =?utf-8?B?UU40ZHhSMWlqVW5XbXN1TjEwRjluOWFlbG9nTG5ualVST3lpZFhoOTVrK3hi?=
 =?utf-8?B?ZTExSW9zTVYva2dYUktqMVlKR2grR0JYdkZ3NGowR0d5dHAzRDBreURRQ2FM?=
 =?utf-8?B?eUVhejJYQTA5d1I0U1lnWjVDcjhGSU54RVBWS2MvR0lHVTY3MklTSGNpWTdv?=
 =?utf-8?B?dXNiV0hoNG8zQWRzUlA0K0FZY05xM09XS05xWEJYNTFBYkZKeFZsQW9iMEQx?=
 =?utf-8?B?emNFZHhWLzlnQ0hmRlRuRzRDTFJSckpJNjIrQjR5N3d0bDZpOEhCRGZqNUty?=
 =?utf-8?B?enJFWlBmWDVNc2FwN3ZnYlhlWm1tbDhzVVV6T0o0QytVOGREQXVPUHhSSUQv?=
 =?utf-8?B?OEtRWWsvaENOamtaTFozZWlXN3o5d0lZQ0N0ejlzMEZjZGZFdjRNZjZ4WkdH?=
 =?utf-8?B?SUtsSjJ5TVlvL0NERkhjcW1JNG1pbWlrYWpFZ3hFK3RmWi9SOTNDN1RlV3pS?=
 =?utf-8?B?MEYvbHh1MDUvbWtGNWg3bnVtZHZjbUlDaERYU3ZvcXBXRTRaN3ZqQWY1U1RU?=
 =?utf-8?B?MEc2SFUzT3IxeUNQWnBNOU10Y05qRGlSRHlyWEM5b0RLWVJnRmdZYzhhbWdw?=
 =?utf-8?B?S29qRzltK0VUQU1CaDlmOWZXOGNQNlVLeWZ4aktBeWlyZ05yWERoSWhwcDll?=
 =?utf-8?B?QUJ0R0NtdzFrbG5ZUlFIMWUySlh6emtrVkZ3V3JrOGxrOFdqR1pHbThJQ2R5?=
 =?utf-8?B?cTI5ZVdLbERnPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 164dca22-e946-4009-b8b0-08da0df5020e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 00:18:38.0419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URWy6cahlz0F2JDFZSKvUrAmY8eo19mrI8giv/yWwufxm3trytXa9iQJ5a7u9qfWrgfxSvqkZeSCSCeho0iAsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4777
X-OriginatorOrg: intel.com

On 3/21/22 3:56 AM, Paolo Abeni wrote:
> On Wed, 2022-03-16 at 19:16 -0400, Kishen Maloor wrote:
>> This change introduces a parallel path in the kernel for retrieving
>> the local id, flags, if_index for an addr entry in the context of
>> an MPTCP connection that's being managed by a userspace PM. The
>> userspace and in-kernel PM modes deviate in their procedures for
>> obtaining this information.
>>
>> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
>> ---
>>  net/mptcp/pm_netlink.c | 95 ++++++++++++++++++++++++++++--------------
>>  net/mptcp/protocol.h   |  3 +-
>>  net/mptcp/subflow.c    |  2 +-
>>  3 files changed, 67 insertions(+), 33 deletions(-)
>>
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index d8825bf580b7..b597e84affd5 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -1106,31 +1106,47 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
>>  
>>  	pernet = net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
>>  
>> -	rcu_read_lock();
>> -	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
>> -		if (addresses_equal(&entry->addr, &skc_local, entry->addr.port)) {
>> -			ret = entry->addr.id;
>> -			break;
>> +	if (mptcp_pm_is_kernel(msk)) {
>> +		rcu_read_lock();
>> +		list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
>> +			if (addresses_equal(&entry->addr, &skc_local, entry->addr.port)) {
>> +				ret = entry->addr.id;
>> +				break;
>> +			}
>>  		}
>> +		rcu_read_unlock();
>> +		if (ret >= 0)
>> +			return ret;
>> +
>> +		/* address not found, add to local list */
>> +		entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
>> +		if (!entry)
>> +			return -ENOMEM;
>> +
>> +		entry->addr = skc_local;
>> +		entry->addr.id = 0;
>> +		entry->addr.port = 0;
>> +		entry->ifindex = 0;
>> +		entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
>> +		entry->lsk = NULL;
>> +		ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
>> +		if (ret < 0)
>> +			kfree(entry);
>> +	} else if (mptcp_pm_is_userspace(msk)) {
> 
> Since pm_netlink.c is growing big and complex, a few pm-related helpers
> are getting the user-space specific implementation, and we already have
> a "generic" wrapper for some of them in pm.c, I think it would cleaner
> keep all the user-space realted new code in a new/separate .c file, and
> move the if (mptcp_pm_is_userspace(msk)/if
> (mptcp_pm_is_kernelspace(msk)) checks in pm.c


I think there's only one other case besides the one above with parallel in-kernel and
userspace branches. Other mptcp_pm_is_xxx() checks are tweaks to existing functions where 
for e.g., a check is done to process or skip over an entry in a list. So I think the
existing code is more maintainable with these in-place changes as have been done.

However, I think we could easily move the new (and distinct) userspace code: netlink impls, 
local_addr_list handling into a pm_userspace.c.

> 
> /P
> 

