Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EFF173
	for <mptcp@lists.linux.dev>; Wed, 19 Jan 2022 01:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642555298; x=1674091298;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=0NbKaJPgIJXa/26eonarDzM6GNQ4NdhXZ8r5RFDz0Ak=;
  b=T2ZdBgx+Iy5y82TyxwZHTqzwfItjmDlFaDvligLziD7R8s9N0dty4AK/
   +809hen39aKPsYgLjoUikhPuXbStTbw7lGMJvINYPU3Xzq9+jHuihIJjg
   RG4yPihmTQr55wN4nIGvL8vt7ki6SmUkw4x4bbp/S9KBDzWOvXTulsg6g
   muGmWjYOQujnLcMPUJv9K1kJv5g8H2qKYQpMQYG/vxP+r/9BC2OXfXjFU
   i4r2KqNLzXMDvbCnBUUSdol1a+G0GSTQ7daczHJtwOWakP6Qpyts6Sxsf
   Bs1AHRIaPQ81l8HQaGjNCYKUs3+HV5eKLAHqZs+iaiNhYOuY5KxJ/lBnY
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="305687101"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="305687101"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 17:21:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="578638593"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jan 2022 17:21:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 18 Jan 2022 17:21:36 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 18 Jan 2022 17:21:36 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 18 Jan 2022 17:21:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElLbHZAXp0Rjilw0kLtVgtT7gG563BzZ2J+ZcP4t96YHwDCFcC568AeG8B1BPtZJ/T1VD5kOfxcaDWohtuGeqd15yjHUUbIBliSf4fBgntVz/8sJw9viGLZnrrgeUo/qbgV8YPCLU1dZErvfJbyUEtMVdG1wP5QURh/2mmJGo0sXdxHfUqIOaAbUx9dLEY+VFLVqYOz83C6aqhgSuBIpThY9zk8r2RChaRbuFJUNlzqsdWGPmCC40U7AqMXoUHYSsJB3ksyOWbLZ3FsceU0DOoiLVojlw3k9oXGRN8FKQhQ2FA62INwtK3zNn3Y4kdFIJsWymb6okh7u1tHi9fhoVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZRk1hC2e0yodlLyC5BwKmR1hXu7ccqXjP2fgQwwX0E=;
 b=HrwKxvrYbQRN3h+OSkvUmG5AwNuPEiKXGyrOaLkb5WqIyMy12oXFGFkp4Lo4xx+G3C6vF7fRQ66JCIDpI62vWa+abOZGYP9DliXpBGvGNqJcUgrshc910oIHKf6TAa5HWaeTI92920CfB+HPSx5Jlo1I8HZZDR1K/ZQLPIYDPXwjRtTMOh/caeDtseAMMHY5p/PNjciec6OuiZJvg+NxHr1LVxdXXDkI5uiKdxKNCHcQZPjofenvp5dzkBUGic1rluGh5rtjGw1Qd2X/i8+LeOtpo01LlgAtoJMmvxpsSYK4gVjodeoP/CP37wZz8y/I1est90RLuIDT7AiRu727Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5145.namprd11.prod.outlook.com (2603:10b6:806:113::6)
 by SA1PR11MB5900.namprd11.prod.outlook.com (2603:10b6:806:238::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Wed, 19 Jan
 2022 01:21:29 +0000
Received: from SA2PR11MB5145.namprd11.prod.outlook.com
 ([fe80::992:6137:3ea3:6cfd]) by SA2PR11MB5145.namprd11.prod.outlook.com
 ([fe80::992:6137:3ea3:6cfd%4]) with mapi id 15.20.4909.007; Wed, 19 Jan 2022
 01:21:29 +0000
Message-ID: <a5b13036-22a1-6b2f-f40a-8171767b679a@intel.com>
Date: Tue, 18 Jan 2022 17:21:26 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH mptcp-next v2 13/21] mptcp: netlink: Add
 MPTCP_PM_CMD_ANNOUNCE
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, <mptcp@lists.linux.dev>
References: <20220112221523.1829397-1-kishen.maloor@intel.com>
 <20220112221523.1829397-14-kishen.maloor@intel.com>
 <e3e0f5dda757b01930c36ead9c453e99eb4bccac.camel@redhat.com>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <e3e0f5dda757b01930c36ead9c453e99eb4bccac.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR05CA0103.namprd05.prod.outlook.com
 (2603:10b6:104:1::29) To SA2PR11MB5145.namprd11.prod.outlook.com
 (2603:10b6:806:113::6)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8146580a-c5b9-426c-cf8d-08d9daea0569
X-MS-TrafficTypeDiagnostic: SA1PR11MB5900:EE_
X-Microsoft-Antispam-PRVS: <SA1PR11MB590056FF07FC6251D674287BE1599@SA1PR11MB5900.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bwHOlKTsJnxfFArXuUROqlmLJZHbdKijbAyagj/xUXpqmFThHlBznaOWaymAiqx/mHNaYlpGuyFNnbd1Lb4zy74yTUKBgdSmnKHp1eMKUJxiDS4cz/3YgPTBU9XRDVBZ6nvNJo1o2kVnXrKF8nCu0tSu7pOw2KPsVNo6jduVd67g4sjsBaXYNoJr9lPuisiudun6yaYuEQ1oEIzwK2P0YQxPBD2gyTEZmo9mu44nwxD7Aoy873nD1bqEZWVGnu0C52xVgPsu9yVI5a6QR4mUAlSZFNrM9zCQ/BnIyuEthFpxDFyprAG15MJchb2wX1SgJxvD0OnBUPkIw5iNE8V0qZFffJAh3YpA6lAvzpt4csftb+mlfdy2CXkhwXERXWhegHQm7yuvNaOSxcLqHI7HwhHqOTWJOjlNUBftUSUXHEC5OKLhutmNAv/BAV/kq7Gw9mvW4Nu1WJEpF0g0vzH/Y0l9WVxmrgcyhZHizsLXJDKoLLT/22TWzWwbGOGBX+d6cjXkkPPEdLvtb0LgUBB3yxdW6nGAZNop4Rfc1kwESbZk9sU0A7cqb4fPe/Jls/tp3AFkYcWBLE8W2NBGSiCRrGeqGV9TjnDd/6RXQOEalZQaNKAMXCUlu0jYFTLsHRxNstKusSouoO28+oyywQh5/m7PqT9ue9QiLExlo3Wx29IasMklW4vsDj0BulIsNGWc1GF1vmdxjUTkKRsllfOJQBKb2a8d1pqFw2WF2JhanZ53UvsOBYyqSOey5ga87wmi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5145.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(6512007)(508600001)(8676002)(5660300002)(2616005)(6666004)(86362001)(82960400001)(316002)(186003)(2906002)(31686004)(8936002)(6486002)(36756003)(6506007)(53546011)(26005)(83380400001)(38100700002)(66476007)(66946007)(66556008)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDBIbS82cWNuZzhkY2szZnpVVGVUZ3JkdVVCMmJ6c3pkUysrQ3M0MmhsYXFJ?=
 =?utf-8?B?NWNCRkJRMHpaLy9jTWJ1VWNyMytwNGVUQWMyZEhDMCtpWEJGSDJpSEZiMjA3?=
 =?utf-8?B?UUgwTlE2MnZ2VFBPOHA3S3Q0MWl4cFhUVEt3cTkxb3BrYVFpT016OCtVVDJz?=
 =?utf-8?B?WEVBV21EYkVlaExsY3NJSkV2aW9jNDVQRXpFUTE0amNoa2daSUJYTTNnb2Jq?=
 =?utf-8?B?SDFHL1RKa1AyWWF4Tm02ODhCbFRVVkVjYjZXZmVKaTI3OURid1hSWXpKRWV6?=
 =?utf-8?B?WXV5TzNpcTFoTDRnVE9rWlMvejMrVjN5SUNsaVE2MVEvRXZtdU5NVGhSMUZY?=
 =?utf-8?B?Z2xaZU4yWFcvWndUNjZodU1XQmJ0YVprWGpjNUMzTENWUi8vb0QxdWVTVU94?=
 =?utf-8?B?ckZPV0pYTk5lM3dMdFRjcWd5VW5OY1BkYUtaWW85RzFyeWN1a3VNc3FrQ1Ji?=
 =?utf-8?B?R1VWUFQzSS9ud1NDaGFNWVJNVlEyK3prZE9haE4wNU93WjFrV3NQYjJkK2lP?=
 =?utf-8?B?cFdweXRVV0txbjg2T3BCTkVQU29ZNVdsY3VPemlMN1hWd2t2VUp4OGJsdzRX?=
 =?utf-8?B?WnE3M0QyQ2xFTUt3ZzU3dE85MkVhMFc1RGNlMU9oeWlJM0RBUUZQY0p2Lzlh?=
 =?utf-8?B?OUN6aklPcDlhMXdySFkrc1B2aG5TOThrQm5YY1Z4b0cwQTJXcUhaYXRjbjFK?=
 =?utf-8?B?dFdsVHIwQUF6U3dpWldaMWNjdWpDczhmUlZ6dHpKeUt4REE0MU9BT3kzTUNW?=
 =?utf-8?B?QjZYcUJjN2F5WVhTN1JKRUl5MGtFVy80Znl5dWJObmwrQ3VnaWxwSlZONVJE?=
 =?utf-8?B?Skg3WGI4eXRNRUNtbVdzd3lxM2p6SE1jeloram1QWmJVVDZ4cTBTRTN4MnUr?=
 =?utf-8?B?cUxWSnVmVVUxK21NcXYxWDczNTRqRmV0U2ltK2p0Y0p6dkdtZVhObE95SWhS?=
 =?utf-8?B?VHZMVVIvVTYyWElrOUErU09zNnp2VG91ay81VXB6L1RPT2RhblJxendoSDhL?=
 =?utf-8?B?U0pFV1NwYVRoeE1UaUdqSVZ0TEQxYUNsTmpNZzJKNWhuKzNsQkhXdlp2RDQw?=
 =?utf-8?B?cE1STE9ibENTVlNVMnlTeCtzVmgxVnVoNVlKd0ZyV0hJY0gxaCtkLzNJakZk?=
 =?utf-8?B?Y1JjbDJ5ZHlWSlZBa05QY2ViTTRBZUxIdm1hWHNLRnA4MlpTVlhrTnN6aXNS?=
 =?utf-8?B?VmVKL1JNYlMvL1QveXd5Q3gxYnJVTkZic2t2dGp2d1MvNzJDTzVGSHlSR1h6?=
 =?utf-8?B?K1lWd2dvUGdGdXBrVS82SVNiQ2JtWloxWEdxNzJkcDhvTGFPWFpnaFFwQjZz?=
 =?utf-8?B?ZlRFdmJSQzZjNHRBYUF5VVpzV3BDV2I3cmk4ckg3a0o3clpQNTVHZ1ovR0Vp?=
 =?utf-8?B?cUFpcXBqZUdIOUw2RDU0S1VPWFpHcElEZVhaTVZzRkREaFdCNzFaY25zdFBU?=
 =?utf-8?B?NS9aY3RWR1VLazNQMFFFYlRMU1dUSWErVVovWHZ1VGMrd3BwdHk0bnBxMWtr?=
 =?utf-8?B?NXptWG50ZkRHdVA5azFqbnVad09tT0JjK1lEU3JsaWg5bmg4R1dHRm5xVmt1?=
 =?utf-8?B?ZkhoNXJENlBWZVpkd08xTjZpMHVLYXpNZXpyYzljWHpWTWdpRDl2QWxXVUFi?=
 =?utf-8?B?aDU0d21SZlN6L0NVeG9BeXlTbUFYRTVKcmI3emJtWHJNZ2x4dkhOb0sva09P?=
 =?utf-8?B?Zm1LOWhpTU5tUmZRRUxJR1Avb2RtYkVCV3N6emI5bkNwZlJMWnF6SHVCdERx?=
 =?utf-8?B?bWlhTUpTVlBwK1NxamNFREpGWWdINEZkRUVDaGdzSkRMc2luUnk2YXZoOTdl?=
 =?utf-8?B?UlZ5MVJKTENoa25zQnhFa2ZpVTFiR3h2RU5xOHQzME1Nd3Y1RVF2SUNscE5Y?=
 =?utf-8?B?aUlwN2t6L2xrS1h2d0VzREZsZmtCZjNlVUVCdW9KU3V5WXFqbjZER2UyQ29G?=
 =?utf-8?B?ZmNmZnNqd01wblJSVDZVN240KzlGQTVTRVQ3SXBqWGRiZkdTeldIcEZzMmNw?=
 =?utf-8?B?ZEV3Z1g1dnphWk5kT2d1ZnhkU0VzamdnNkRoT0lhUS9Reis2QmM1dkdKMmFY?=
 =?utf-8?B?SUJkZVliWVpiVzc5SlYxTzlLUVJQZkkwRVBxWGNsQkZaQ3M5cmNJbnZJV2ZW?=
 =?utf-8?B?RWN1UGgxQXBIeEN0aU94R2lKZGhtVCtpeXAzOUJndUdjSXhabGFMSWdBUWZ6?=
 =?utf-8?Q?PERtanhVhHoGU+cDo/g8RiY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8146580a-c5b9-426c-cf8d-08d9daea0569
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5145.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 01:21:29.8439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9AkjBYszChb6qRG44Wek4j9w/6ghQqhXf/iyhmo1orRBnaeoR1iN+q/KLDle/6nZmvtZEpE1o7goAzT7qax/Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5900
X-OriginatorOrg: intel.com

On 1/14/22 9:04 AM, Paolo Abeni wrote:
> On Wed, 2022-01-12 at 17:15 -0500, Kishen Maloor wrote:
>> This change adds a MPTCP netlink interface for issuing
>> ADD_ADDR advertisements over the chosen MPTCP connection from a
>> userspace path manager.
>>
>> The command requires the following parameters:
>> { token, { loc_id, family, daddr4 | daddr6 [, dport] } [, if_idx],
>> flags/signal }.
>>
>> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
>> ---
>>  include/uapi/linux/mptcp.h |   2 +
>>  net/mptcp/pm_netlink.c     | 111 +++++++++++++++++++++++++++++++++++++
>>  2 files changed, 113 insertions(+)
>>
>> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
>> index f106a3941cdf..40380be396c8 100644
>> --- a/include/uapi/linux/mptcp.h
>> +++ b/include/uapi/linux/mptcp.h
>> @@ -55,6 +55,7 @@ enum {
>>  	MPTCP_PM_ATTR_ADDR,				/* nested address */
>>  	MPTCP_PM_ATTR_RCV_ADD_ADDRS,			/* u32 */
>>  	MPTCP_PM_ATTR_SUBFLOWS,				/* u32 */
>> +	MPTCP_PM_ATTR_TOKEN,				/* u32 */
>>  
>>  	__MPTCP_PM_ATTR_MAX
>>  };
>> @@ -92,6 +93,7 @@ enum {
>>  	MPTCP_PM_CMD_SET_LIMITS,
>>  	MPTCP_PM_CMD_GET_LIMITS,
>>  	MPTCP_PM_CMD_SET_FLAGS,
>> +	MPTCP_PM_CMD_ANNOUNCE,
>>  
>>  	__MPTCP_PM_CMD_AFTER_LAST
>>  };
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index 07536abab3e5..18228b2dfa2d 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -1268,6 +1268,7 @@ static const struct nla_policy mptcp_pm_policy[MPTCP_PM_ATTR_MAX + 1] = {
>>  					NLA_POLICY_NESTED(mptcp_pm_addr_policy),
>>  	[MPTCP_PM_ATTR_RCV_ADD_ADDRS]	= { .type	= NLA_U32,	},
>>  	[MPTCP_PM_ATTR_SUBFLOWS]	= { .type	= NLA_U32,	},
>> +	[MPTCP_PM_ATTR_TOKEN]		= { .type	= NLA_U32,	},
>>  };
>>  
>>  void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
>> @@ -2028,6 +2029,111 @@ static int mptcp_nl_addr_backup(struct net *net,
>>  	return ret;
>>  }
>>  
>> +static int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
>> +{
>> +	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
>> +	struct nlattr *addr = info->attrs[MPTCP_PM_ATTR_ADDR];
>> +	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
>> +	struct mptcp_pm_addr_entry addr_val;
>> +	struct mptcp_local_lsk *lsk_ref;
>> +	bool reuse_port = false;
>> +	struct mptcp_sock *msk;
>> +	struct socket *lsk;
>> +	u32 token_val;
>> +	int err;
>> +
>> +	if (!addr || !token) {
>> +		GENL_SET_ERR_MSG(info, "missing required inputs");
>> +		return -EINVAL;
>> +	}
>> +
>> +	token_val = nla_get_u32(token);
>> +
>> +	msk = mptcp_token_get_sock(sock_net(skb->sk), token_val);
>> +	if (!msk) {
>> +		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (READ_ONCE(msk->pm.pm_type) != MPTCP_PM_TYPE_USERSPACE) {
>> +		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
>> +		return -EINVAL;
>> +	}
>> +
>> +	err = mptcp_pm_parse_entry(addr, info, true, &addr_val);
>> +	if (err < 0) {
>> +		GENL_SET_ERR_MSG(info, "error parsing local address");
>> +		return err;
>> +	}
>> +
>> +	if (addr_val.addr.id == 0 || !(addr_val.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
>> +		GENL_SET_ERR_MSG(info, "invalid addr id or flags");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!addr_val.addr.port) {
>> +		addr_val.addr.port =
>> +			((struct inet_sock *)inet_sk
>> +			 ((struct sock *)msk))->inet_sport;
>> +
>> +		reuse_port = true;
>> +	}
>> +
>> +	lsk_ref = lsk_list_find(pernet, &addr_val.addr);
>> +
>> +	if (!lsk_ref) {
>> +		err = mptcp_pm_nl_create_listen_socket(skb->sk, &addr_val, &lsk);
>> +		if ((err && !reuse_port) || (err && (err != -EADDRINUSE) && reuse_port)) {
>> +			GENL_SET_ERR_MSG(info, "error creating listen socket");
>> +			return err;
>> +		}
>> +
>> +		if (lsk) {
>> +			lsk_ref = lsk_list_add(pernet, &addr_val.addr, lsk);
>> +			if (!lsk_ref) {
>> +				GENL_SET_ERR_MSG(info, "can't allocate lsk ref");
>> +				sock_release(lsk);
>> +				return -ENOMEM;
>> +			}
>> +		}
>> +	}
> 
> It looks like that the above chunk of code is sort of recurring. it's
> likely worthy to factor it in some helper alike
> "lsk_list_find_or_create()"

The find->create_listen_sock sequence is run in 3 places, but there are deviations in
the logic that follows a failed create_listen_sock. Hence, I did not over optimize.
But I will check if it makes sense to refactor.

> 
> Cheers,
> 
> Paolo
> 

