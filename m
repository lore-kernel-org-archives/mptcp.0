Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03C6815
	for <mptcp@lists.linux.dev>; Fri,  4 Mar 2022 07:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646379370; x=1677915370;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=nL4Td5amhq/wR8GgSEKzxbf875bhP9FtjrUiuIKEkLI=;
  b=SV4rBD9jVVNYmqW5ynBjSxY9COcZVBSBj+iaLkuPJ/d6obbUnfy9EJNW
   Bo1rE9i6adN/H+h6rGbw6ShpxLxjeE4kpZuSRW8kjlaHWrS7L89iwO4sE
   utaSBJMZbhiPv+LNDjd1LQ711ye/YfPt1750hDBQ5ZO9j7m+1Z6fCzK8P
   30ZbJj0BrTppId2j3pRG1lE/xbDkv5OU+kik3Fd11B21qcbV72Y7u5rNH
   D+IPjggRbwXvjvt/H3YvGZeweDjGexoB3LoAdRA/lci8EVjr5+U1/K+Iz
   52u0JgF31E+8OtGnrwBIUVr3v3p8jh5octMkXZDuRR5AdsdTvSc73Dwgx
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="252744194"
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; 
   d="scan'208";a="252744194"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 23:36:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; 
   d="scan'208";a="536184018"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga007.jf.intel.com with ESMTP; 03 Mar 2022 23:36:09 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 23:36:09 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 23:36:08 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 3 Mar 2022 23:36:08 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 3 Mar 2022 23:36:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZtIEdE+u+/PTkxpr+5K5/H/uC/HMZpOyX6zntKnPgd3XmojEbeGlGvOorfKY+JeZs4UMrLHAKUoDlHjn819bBURi21e34AM9Lf2dYMXFBzjd+drk8dTeHRC0pO3CYVp/T2nSYCmGkLz6uEtvWRvv8LgOc+JaPf9PLnhBxjB7djdgfou37E3ygppjPmReFeJb7WzXxk62mhOFlyWXXfVWphxrAA4qubGWFU4oN6JUlxw3Y/pacGEq4MuuX8xfqd1XMse1HyArqgE7PTCQ+vu35ZbhrMAhmxXSvT/9WYdltroqjCl7o18ssrsiWmMcwde0Q8b0O3A61wOtJZ13/RSGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6IjcAuhRBWztGkj7jTbkNaBvQgRsIGbnFDY1hL+RmQ8=;
 b=oAS9x1VT5Kq/6xgC3yZYpPx7XD9epJ4e/TXjRfGb9Ok0Cpp5qFX4KU7reO9rFHpAj78b6RBN4tDhSUcZEl99Vf66N8bYczz8O1J013ytU5CzRu3Y0HQ8MM4woh0XOys1XciExoHtAc17L7/2qCPijdInrVXuC7UhVWG5vuxcER7+HAGBh3mwdQLlcfFmEZjiJhsvPxALQ+P5OeRe5SR0Erh1iRqhJxBcJ0xPzahFAxbvvPto6htx4qsjirbUuQotIdgaDJrhJxDZfpKjkUlm528zRbhsT+fRgwslBTMOi4IKUncWrFvQwm7mzM8LbuZxFmPqrEiKi5T4yObRa2l2hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21)
 by SA0PR11MB4606.namprd11.prod.outlook.com (2603:10b6:806:71::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Fri, 4 Mar
 2022 07:36:06 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::44ba:c91c:ea6c:118d]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::44ba:c91c:ea6c:118d%5]) with mapi id 15.20.5038.016; Fri, 4 Mar 2022
 07:36:06 +0000
Message-ID: <ab1f9296-3637-d13a-bfe3-97183f593190@intel.com>
Date: Thu, 3 Mar 2022 23:36:02 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH mptcp-next 3/4] mptcp: handle join requests via pernet
 listen socket
Content-Language: en-US
To: Florian Westphal <fw@strlen.de>, <mptcp@lists.linux.dev>
References: <20220224155010.23676-1-fw@strlen.de>
 <20220224155010.23676-4-fw@strlen.de>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <20220224155010.23676-4-fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR19CA0013.namprd19.prod.outlook.com
 (2603:10b6:300:d4::23) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:9e::21)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b8b6d35-61d8-46b7-3df6-08d9fdb1a461
X-MS-TrafficTypeDiagnostic: SA0PR11MB4606:EE_
X-Microsoft-Antispam-PRVS: <SA0PR11MB460666C89EC8EA2CAD24C21FE1059@SA0PR11MB4606.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ypwhQOZ3NxmrLg6SnlDJUKyTys5a16y2TSUP+ysfr3Ua3yMxnBKE5ii+aWp9aom+hD4YjnXPv62EUUG1PAL7hr53Vf2Ynen2wiwVXuudB9aMZHr2Z7OxOKZftTAWdDfMMFJ/nFmy3GjH/c67j7LahSFlIsDKHS0h5R1rooj9F4oasW5IS74uAaht5hPYY/N8HO6unsZoL7PMBFjnxfbSo8jxxZzO8QJUfsloUNmf0dhMtVhyw42eKxFomXtSKY1HNVLzWNSlu6ijRuWm86I6fyXrXFszqy2Jx3KetY7LdnkVH6epaicdIkqofGWN88foycriSNKd04BU1Tt49feA7wHydIw4RBS7/pfcAPPydUXuwL+qC5Iet0Ql2xRPu16mscriztzXi/nURaWsOGbA3ISeoYLYsGpsBXPa0nFYZHYC3PxNxLfJaeEU/GXohBT1r9yDPVgf5JmRlkbZRJ9ROSUS5EDPlchDy4r8LbwiXrwE1CKxhYFYz/HMEkjcHOVQZk0QVmV+VOnx3Etbb1MnkvrapW8Kl+4q8jiDMXiphNDZkU4noUjBkXoQlVX7bgogTkhwj5P56Ptp6NhSi3r2PjPSILtBint6UO8uWjuqn3FIVkWfTM0EiifmarDv9eXVsWjeV9g5pVFsDthdW5oYbEX7aOeM8pXw0+3Va8srsy0hnoRKB5qBOHGLUyRXQtXlued17HSRt1sjmA3/w/fVcidWPoym3kqh4DC1e50nycgxlU0piOBTRrI76lwEV1p8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(186003)(6506007)(83380400001)(26005)(6666004)(508600001)(2616005)(36756003)(82960400001)(2906002)(38100700002)(86362001)(31686004)(44832011)(30864003)(66556008)(66476007)(66946007)(8676002)(8936002)(31696002)(5660300002)(316002)(53546011)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUF2K1lTeStFR1QzU1FjN1VrdE8wcXZyMUdlVzdROEU4d0ROekpHT041Y2RI?=
 =?utf-8?B?UllZb24wdjh5blRBU0Nsa0JXRStyeTg5R0x3a1BWK1RUMUN1cEoxc24zdUxa?=
 =?utf-8?B?QVNtdmNzZmd0VG42SWpua3NIdnVSOTlPYjV4VGFROXR4clVtVGxNNEd5c1Rt?=
 =?utf-8?B?ZVlHNktzV0Z6S08rMzRiZCtvVWdZUkNwbzh3NEROZ2c5UnhVNWtwMDhZOW5K?=
 =?utf-8?B?Qk1nWmIvTDlQTUxTOW9ub0UrQVVDb2d0ZVR5Y1FpdE9JTy9QbE5walZTTDVV?=
 =?utf-8?B?cmZieGNGdnlUOTVFKytRL0hsY1dRazR6L3hpQUc0eExJSUhDS2c2NjJScXhH?=
 =?utf-8?B?WTU3Vy9CbG5MRGdCWk83bUx6eUphQ0NKcUtiUFBlOFB2NzVwdG9jWkt1RTJj?=
 =?utf-8?B?UWtKS28yTjNOSmhwd2ozU2JVSlhLQk11bVBtdGVVK0FOR3F2elJqOWRXR2NM?=
 =?utf-8?B?b2NidFJIU0pnaEFhMVJZSmVnbHdZeVg1TktGQ1dBWWpCVU5aVGZ2VmVzcEIz?=
 =?utf-8?B?djhzbHFqUXhtcU01eWdrbTBOSzVQYnNpSzBIaDJLZE4xdkV6YTRGb0MxV2pP?=
 =?utf-8?B?VXFReXpTV29URjBETTlveFA2NDVqeW9wQ3p2aHBMNWJ6MnpXcWprRDRHMGwv?=
 =?utf-8?B?SXF2QWRwRVFxTjA4ZFp4QjA0eGFEaWtqM1BWd2VjZWxoeGpTQzNEMTlDL3RW?=
 =?utf-8?B?VTV3d0syT1lmUnNtSkNycVh4WVhNbk1IQTJOODQ2b1ErZlo4Uk9hQUwzK0ov?=
 =?utf-8?B?K2dxRkZOU2VPRFYvbGF3ZWtmM0FDOStBODlFOUg4Tm4vaUczcytQUjNwcVQx?=
 =?utf-8?B?ZVFrRHBrTzdqSWQ0bFY4aWhmM25Id2dKNk9INmN4YXBxZGh1Tk9tbXh6RFhR?=
 =?utf-8?B?Q0xKL1J2Q1hKZ21KdUpLcVUvdVpham5PZ09hU2tzdDJHNzUveFJCcUZ1QnRo?=
 =?utf-8?B?Sm1ITnpmaDVHem9CczJiUkExTnBsVTY4Yk9JZWlNN2NXVHRqVzVmazZlSzUr?=
 =?utf-8?B?SW5XeFdSYUJUaWtVU0Jhd2lCWm1jYmc1WWFMenE3MGZXaDhGVk5HUERKTmQ0?=
 =?utf-8?B?VURKWkFES0tPNVErc3pzaGFxcER1c21YQUJadWZQRUN1cnZrR0dEYVpONFlJ?=
 =?utf-8?B?K3R4Myt1UDU3R2xjbkFZNjd0cVYrMkpVSEk3N2dwaDZmRFBzYXlURndkS1pu?=
 =?utf-8?B?RlJ1N01SRzg5ZEg3dUYzaUQybjV3MHl3Z1hVTHpkRitaS3l1L0NKakhYVU9X?=
 =?utf-8?B?eUhQMVdXUUFaYnVOWTFKS2haM0dhd3htclltNWFPV29tUzIxZU9KbzJWSHNE?=
 =?utf-8?B?M09LUlo5a25VTFhNSWNQUm1mQTlQK2NVUHNSK25yVWtuUmdwN3NKSG5XOEZa?=
 =?utf-8?B?R3pORXhVRGliQTFXc2VzUEtNSGQ1UDJhczh5Wm5laXBmblc1YkdOUytYVW1h?=
 =?utf-8?B?emF0STBVdUZKbzBsVFUxUlhlb0xVTEgzaEdTU1l5Y0hVOWY0aGY0YTFXYVZH?=
 =?utf-8?B?b0c5eExzZ2FjU01NZlFGNmVwY3VtYmtwbXBKOGNJdWVXbGV0YlVJeU1iMStt?=
 =?utf-8?B?K0xZNHMxdTBUTGsybDBkRW1yMFBUYjBJRHgwcDVPaVY1cElhUEZoY0pZNEg2?=
 =?utf-8?B?STlSYStCcnlZS09xS09Pb0trTExQQm8ydDd6eWpsRWROR3dRQ0Z4cDAvWklp?=
 =?utf-8?B?WUUzdVlUTWNpaDMrbHJ5STRlcmNyVmtidGpwY1Z1WlZIZThNUkw2U1ZPMEtM?=
 =?utf-8?B?UUVhYUlVVWRLbHJ4WVg0Sis3bmZnaVdZK3ZESUR1blJtWVdjaEhKbXk5aGl5?=
 =?utf-8?B?MDNUamJoSWlONzgrdjMrRU9yL0IrRDBndVlpVEp2YUtLR2Q3VHY5Ly9UQzFN?=
 =?utf-8?B?K2svQ3ZjN2g1UVNYN0xHQTVKSnVXY0hPeURVZVM3R1plUGY3UGtZZE84cko3?=
 =?utf-8?B?SjkvemNhME5QMUVoTSs0Mnh3R21qUUhIV1lQbllWOFc5WGZaV0RkMCtuS2R6?=
 =?utf-8?B?Um9QeHR1OWYvaS9nTVFia3hCa0wxZXV2L3NiYmduR0thMU9VMHJVbE9XMDV6?=
 =?utf-8?B?M1hYdDIwYThWTUVBVmVwYzUwSlFXZHpQY0s3eTM4eHB4bEhiUzVrMmt5di9W?=
 =?utf-8?B?cEMrQmxmMEFGUUhyMFRTdXBuKzQxbXNmRUYwN2NXc1p6QVlmSXFLM3RBR2JY?=
 =?utf-8?Q?WUMRJo8U1vlUNt/LTvGEdas=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8b6d35-61d8-46b7-3df6-08d9fdb1a461
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 07:36:06.0073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrzlfh5i+aampW+sWA2/KrRB+tiaJun9+I4H63WIvwT7t8XBn2p9I9RfiEE1xTPqh8C2YA1FEGWi5cU6pQY9eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4606
X-OriginatorOrg: intel.com

Hi Florian, Paolo,

I had responded as below to v2 of this series but wondered if perhaps it got lost
in the barrage of emails. So thought I'd resend it as I still have questions
regarding our rationale here.

On 2/24/22 7:50 AM, Florian Westphal wrote:
> Currently mptcp adds kernel-based listener socket for all
> netlink-configured mptcp address endpoints.
> 
> This has caveats because kernel may interfere with unrelated programs
> that use same address/port pairs.
> 

I assume that this refers to a potential race between a kernel listener and
the application which Paolo had raised. But I'm not sure if these changes
eliminate that possibility. Pasting Paolo's example below from the prior discussion:

"""
s1 = socket()
bind(s1, A)
listen(s1)
// at this point incoming MPTCP connection can be established on s1
// and ADD_ADDR sub-options could be sent back

s2 = socket()
bind(s2, B)
listen(s2)
"""

Over a newly established MPTCP connection following listen(s1), the PM can issue an 
ADD_ADDR with B. In light of this change there would be no listener created for B. 
But if the remote endpoint immediately established a subflow in response (to the 
ADD_ADDR), then that would create a subflow (connection) socket at B.
It appears (and correct me if I'm wrong) that bind(s2, B) would fail after this point (?).

In other words, a subflow creation at an address could race with a subsequent bind()
at that address causing startup issues in the application.
The only difference now from our prior discussion is that previously the announcement (and 
the act of creating a listener) could race with the bind().

If this assessment is correct, then these changes aren't really sidestepping the 
above race which motivated this alternate approach in the first place. 

Hence, I had the following questions:

What are the benefit(s) of this alternate approach?

If the above race is still a worry, then isn't it a problem that we have no way to
prevent it with this approach? 
Whereas with kernel listeners we could choose to not create a listener with the
netlink API (and thus avoid a race), but in this approach the behavior is baked
into the code and outcomes could vary at runtime.

I do like the fact that we don't need code to manage kernel listeners with this approach
even if it does not resolve the above race, but it comes with other caveats as we've 
been discussing like potential clashes with TCP listeners and TCP code changes that would 
have to be accepted upstream. 

So given the tradeoffs, I am considering the relative merits
of the kernel listener approach: deterministic, documentable behavior and wholly 
contained in the MPTCP layer.

I wanted to take a step back to make sure we're all on the same page as to 
why we're considering these changes. Hope it makes sense :)

> RFC 8684 says:
>  Demultiplexing subflow SYNs MUST be done using the token; this is
>  unlike traditional TCP, where the destination port is used for
>  demultiplexing SYN packets.  Once a subflow is set up, demultiplexing
>  packets is done using the 5-tuple, as in traditional TCP.
> 
> This patch deviates from this in that it retains the existing checks of
> verifying the incoming requests destination vs. the list of announced
> addresses.  If the request is to an address that was not assigned, its
> treated like an invalid token, i.e. we send a tcp reset with mptcp
> error specific code is returned.
> 
> The checks that do this are moved from subflow specific code to the new
> hook, this allows us to perform the check at an earlier stage.
> 
> Furthermore, TCP-only listeners take precedence: An MPTCP peer MUST NOT
> announce addr:port pairs that are already in use by a non-mptcp listener.
> 
> This could be changed, but it requires move of mptcp_handle_join() hook
> *before* the tcp port demux, i.e. an additional conditional in hotpath.
> 
> As-is, the additional conditional (syn && !rst && ...) is placed in the
> 'no socket found' path.
> 
> The pernet "listening" socket is hidden from userspace, its not part of
> any hashes and not bound to any address/port.
> 
> TPROXY-like semantics apply: If tcp demux cannot find a port for a given
> packet, check if the packet is a syn packet with a valid join token.
> 
> If so, the pernet listener is returned and tcp processing resumes.
> Otherwise, handling is identical.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  include/net/mptcp.h  |  19 +++-
>  net/ipv6/tcp_ipv6.c  |  19 ++--
>  net/mptcp/ctrl.c     | 229 ++++++++++++++++++++++++++++++++++++++++++-
>  net/mptcp/protocol.c |   2 +-
>  net/mptcp/protocol.h |   2 +-
>  net/mptcp/subflow.c  |   8 +-
>  6 files changed, 258 insertions(+), 21 deletions(-)
> 
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index b914e63afc13..b8939d7ea12e 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -189,6 +189,7 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
>  				  struct sk_buff *skb);
>  
>  __be32 mptcp_get_reset_option(const struct sk_buff *skb);
> +struct sock *__mptcp_handle_join(int af, struct sk_buff *skb);
>  
>  static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
>  {
> @@ -198,10 +199,20 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
>  	return htonl(0u);
>  }
>  
> -static inline struct sock *mptcp_handle_join4(struct sk_buff *skb)
> +static inline struct sock *mptcp_handle_join(struct sk_buff *skb, int af)
>  {
> +	const struct tcphdr *th = tcp_hdr(skb);
> +
> +	if (th->syn && !th->ack && !th->rst && !th->fin)
> +		return __mptcp_handle_join(af, skb);
> +
>  	return NULL;
>  }
> +
> +static inline struct sock *mptcp_handle_join4(struct sk_buff *skb)
> +{
> +	return mptcp_handle_join(skb, AF_INET);
> +}
>  #else
>  
>  static inline void mptcp_init(void)
> @@ -284,14 +295,18 @@ static inline struct sock *mptcp_handle_join4(struct sk_buff *skb) { return NULL
>  
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>  int mptcpv6_init(void);
> +int mptcpv6_init_net(struct net *net);
> +void mptcpv6_exit_net(struct net *net);
>  void mptcpv6_handle_mapped(struct sock *sk, bool mapped);
>  
>  static inline struct sock *mptcp_handle_join6(struct sk_buff *skb)
>  {
> -	return NULL;
> +	return mptcp_handle_join(skb, AF_INET6);
>  }
>  #elif IS_ENABLED(CONFIG_IPV6)
>  static inline int mptcpv6_init(void) { return 0; }
> +static inline int mptcpv6_init_net(struct net *net) { return 0; }
> +static inline void mptcpv6_exit_net(struct net *net) { }
>  static inline void mptcpv6_handle_mapped(struct sock *sk, bool mapped) { }
>  static inline struct sock *mptcp_handle_join6(struct sk_buff *skb) { return NULL; }
>  #endif
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 2f7a621aa24d..b414e2f77fa3 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -2256,13 +2256,22 @@ static struct inet_protosw tcpv6_protosw = {
>  
>  static int __net_init tcpv6_net_init(struct net *net)
>  {
> -	return inet_ctl_sock_create(&net->ipv6.tcp_sk, PF_INET6,
> -				    SOCK_RAW, IPPROTO_TCP, net);
> +	int err = inet_ctl_sock_create(&net->ipv6.tcp_sk, PF_INET6,
> +				       SOCK_RAW, IPPROTO_TCP, net);
> +	if (err)
> +		return err;
> +
> +	err = mptcpv6_init_net(net);
> +	if (err)
> +		inet_ctl_sock_destroy(net->ipv6.tcp_sk);
> +
> +	return err;
>  }
>  
>  static void __net_exit tcpv6_net_exit(struct net *net)
>  {
>  	inet_ctl_sock_destroy(net->ipv6.tcp_sk);
> +	mptcpv6_exit_net(net);
>  }
>  
>  static struct pernet_operations tcpv6_net_ops = {
> @@ -2287,15 +2296,9 @@ int __init tcpv6_init(void)
>  	if (ret)
>  		goto out_tcpv6_protosw;
>  
> -	ret = mptcpv6_init();
> -	if (ret)
> -		goto out_tcpv6_pernet_subsys;
> -
>  out:
>  	return ret;
>  
> -out_tcpv6_pernet_subsys:
> -	unregister_pernet_subsys(&tcpv6_net_ops);
>  out_tcpv6_protosw:
>  	inet6_unregister_protosw(&tcpv6_protosw);
>  out_tcpv6_protocol:
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index ae20b7d92e28..c7370c5147df 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -12,6 +12,7 @@
>  #include <net/netns/generic.h>
>  
>  #include "protocol.h"
> +#include "mib.h"
>  
>  #define MPTCP_SYSCTL_PATH "net/mptcp"
>  
> @@ -21,6 +22,12 @@ static int mptcp_pernet_id;
>  static int mptcp_pm_type_max = __MPTCP_PM_TYPE_MAX;
>  #endif
>  
> +struct mptcp_join_sk {
> +	struct sock *sk;
> +	struct inet_bind_bucket *tb;
> +	struct inet_bind_hashbucket head;
> +};
> +
>  struct mptcp_pernet {
>  #ifdef CONFIG_SYSCTL
>  	struct ctl_table_header *ctl_table_hdr;
> @@ -32,6 +39,18 @@ struct mptcp_pernet {
>  	u8 checksum_enabled;
>  	u8 allow_join_initial_addr_port;
>  	u8 pm_type;
> +
> +	/* pernet listener to handle mptcp join requests
> +	 * based on the mptcp token.
> +	 *
> +	 * Has to be pernet because tcp uses
> +	 * sock_net(sk_listener) to obtain the net namespace for
> +	 * the syn/ack route lookup.
> +	 */
> +	struct mptcp_join_sk join4;
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	struct mptcp_join_sk join6;
> +#endif
>  };
>  
>  static struct mptcp_pernet *mptcp_get_pernet(const struct net *net)
> @@ -185,13 +204,190 @@ static void mptcp_pernet_del_table(struct mptcp_pernet *pernet) {}
>  
>  #endif /* CONFIG_SYSCTL */
>  
> +static void add_mptcp_rst(struct sk_buff *skb)
> +{
> +	struct mptcp_ext *ext = skb_ext_add(skb, SKB_EXT_MPTCP);
> +
> +	if (ext) {
> +		memset(ext, 0, sizeof(*ext));
> +		ext->reset_reason = MPTCP_RST_EMPTCP;
> +	}
> +}
> +
> +struct sock *__mptcp_handle_join(int af, struct sk_buff *skb)
> +{
> +	struct mptcp_options_received mp_opt;
> +	struct mptcp_pernet *pernet;
> +	struct mptcp_sock *msk;
> +	struct socket *ssock;
> +	struct sock *lsk;
> +	struct net *net;
> +
> +	/* paranoia check: don't allow 0 destination port,
> +	 * else __inet_inherit_port will insert the child socket
> +	 * into the phony hash slot of the pernet listener.
> +	 */
> +	if (tcp_hdr(skb)->dest == 0)
> +		return NULL;
> +
> +	mptcp_get_options(skb, &mp_opt);
> +
> +	if (!(mp_opt.suboptions & OPTIONS_MPTCP_MPJ))
> +		return NULL;
> +
> +	net = dev_net(skb_dst(skb)->dev);
> +	if (!mptcp_is_enabled(net))
> +		return NULL;
> +
> +	/* RFC8684: If the token is unknown [..], the receiver will send
> +	 * back a reset (RST) signal, analogous to an unknown port in TCP,
> +	 * containing an MP_TCPRST option (Section 3.6) [..]
> +	 */
> +	msk = mptcp_token_get_sock(net, mp_opt.token);
> +	if (!msk) {
> +		add_mptcp_rst(skb);
> +		return NULL;
> +	}
> +
> +	if (!mptcp_pm_sport_in_anno_list(msk, af, skb)) {
> +		sock_put((struct sock *)msk);
> +		MPTCP_INC_STATS(net, MPTCP_MIB_MISMATCHPORTSYNRX);
> +		add_mptcp_rst(skb);
> +		return NULL;
> +	}
> +
> +	sock_put((struct sock *)msk);
> +	pernet = mptcp_get_pernet(net);
> +
> +	switch (af) {
> +	case AF_INET:
> +		lsk = pernet->join4.sk;
> +		break;
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	case AF_INET6:
> +		lsk = pernet->join6.sk;
> +		break;
> +#endif
> +	default:
> +		WARN_ON_ONCE(1);
> +		return NULL;
> +	}
> +
> +	ssock = __mptcp_nmpc_socket(mptcp_sk(lsk));
> +	if (WARN_ON(!ssock))
> +		return NULL;
> +
> +	return ssock->sk;
> +}
> +
> +static struct socket *mptcp_create_join_listen_socket(struct net *net, int af)
> +{
> +	struct socket *s, *ssock;
> +	int err;
> +
> +	err = sock_create_kern(net, af, SOCK_STREAM, IPPROTO_MPTCP, &s);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	ssock = __mptcp_nmpc_socket(mptcp_sk(s->sk));
> +	if (!ssock) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	ssock->sk->sk_max_ack_backlog = SOMAXCONN;
> +	inet_sk_state_store(ssock->sk, TCP_LISTEN);
> +
> +	s->sk->sk_max_ack_backlog = SOMAXCONN;
> +	inet_sk_state_store(s->sk, TCP_LISTEN);
> +
> +	s->sk->sk_net_refcnt = 1;
> +	get_net_track(net, &s->sk->ns_tracker, GFP_KERNEL);
> +	sock_inuse_add(net, 1);
> +
> +	return s;
> +out:
> +	sock_release(s);
> +	return ERR_PTR(err);
> +}
> +
> +static int mptcp_init_join_sk(struct net *net, struct sock *sk, struct mptcp_join_sk *join_sk)
> +{
> +	struct socket *ssock = __mptcp_nmpc_socket(mptcp_sk(sk));
> +	struct inet_hashinfo *table = ssock->sk->sk_prot->h.hashinfo;
> +	struct inet_bind_bucket *tb;
> +
> +	spin_lock_init(&join_sk->head.lock);
> +	INIT_HLIST_HEAD(&join_sk->head.chain);
> +
> +	/* Our "listen socket" isn't bound to any address or port.
> +	 * Conceptually, SYN packet with mptcp join request are steered to
> +	 * this pernet socket just like TPROXY steals arbitrary connection
> +	 * requests to assign them to listening socket with different
> +	 * address or port.
> +	 *
> +	 * The bind_bucket is needed for sake of __inet_inherit_port(),
> +	 * so it can place the new child socket in the correct
> +	 * bind_bucket slot.
> +	 *
> +	 * A phony head is used to hide this socket from normal sk loookup.
> +	 */
> +	tb = inet_bind_bucket_create(table->bind_bucket_cachep,
> +				     net, &join_sk->head, 0, 0);
> +	if (!tb)
> +		return -ENOMEM;
> +
> +	inet_csk(ssock->sk)->icsk_bind_hash = tb;
> +	return 0;
> +}
> +
>  static int __net_init mptcp_net_init(struct net *net)
>  {
>  	struct mptcp_pernet *pernet = mptcp_get_pernet(net);
> +	struct socket *sock;
> +	int err;
>  
>  	mptcp_pernet_set_defaults(pernet);
>  
> -	return mptcp_pernet_new_table(net, pernet);
> +	err = mptcp_pernet_new_table(net, pernet);
> +	if (err)
> +		return err;
> +
> +	sock = mptcp_create_join_listen_socket(net, AF_INET);
> +	if (IS_ERR(sock)) {
> +		err = PTR_ERR(sock);
> +		goto out_table;
> +	}
> +
> +	err = mptcp_init_join_sk(net, sock->sk, &pernet->join4);
> +	if (err) {
> +		sock_release(sock);
> +		goto out_table;
> +	}
> +
> +	/* struct sock is still reachable via sock->sk_socket backpointer */
> +	pernet->join4.sk = sock->sk;
> +	return err;
> +
> +out_table:
> +	if (!net_eq(net, &init_net))
> +		mptcp_pernet_del_table(pernet);
> +	return err;
> +}
> +
> +static void __net_exit mptcp_exit_join_sk(struct mptcp_join_sk *jsk)
> +{
> +	struct socket *ssock = __mptcp_nmpc_socket(mptcp_sk(jsk->sk));
> +	struct inet_bind_bucket *tb;
> +	struct inet_hashinfo *table;
> +
> +	table = ssock->sk->sk_prot->h.hashinfo;
> +
> +	tb = inet_csk(ssock->sk)->icsk_bind_hash;
> +	inet_bind_bucket_destroy(table->bind_bucket_cachep, tb);
> +
> +	ssock = jsk->sk->sk_socket;
> +	sock_release(ssock);
>  }
>  
>  /* Note: the callback will only be called per extra netns */
> @@ -200,6 +396,7 @@ static void __net_exit mptcp_net_exit(struct net *net)
>  	struct mptcp_pernet *pernet = mptcp_get_pernet(net);
>  
>  	mptcp_pernet_del_table(pernet);
> +	mptcp_exit_join_sk(&pernet->join4);
>  }
>  
>  static struct pernet_operations mptcp_pernet_ops = {
> @@ -219,12 +416,36 @@ void __init mptcp_init(void)
>  }
>  
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -int __init mptcpv6_init(void)
> +int __net_init mptcpv6_init_net(struct net *net)
>  {
> +	struct mptcp_pernet *pernet = mptcp_get_pernet(net);
> +	struct socket *sock;
>  	int err;
>  
> -	err = mptcp_proto_v6_init();
> +	if (net_eq(net, &init_net)) {
> +		err = mptcp_proto_v6_init();
> +		if (err)
> +			return err;
> +	}
> +
> +	sock = mptcp_create_join_listen_socket(net, AF_INET6);
> +	if (IS_ERR(sock))
> +		return PTR_ERR(sock);
>  
> -	return err;
> +	err = mptcp_init_join_sk(net, sock->sk, &pernet->join6);
> +	if (err) {
> +		sock_release(sock);
> +		return err;
> +	}
> +
> +	pernet->join6.sk = sock->sk;
> +	return 0;
> +}
> +
> +void __net_exit mptcpv6_exit_net(struct net *net)
> +{
> +	struct mptcp_pernet *pernet = mptcp_get_pernet(net);
> +
> +	mptcp_exit_join_sk(&pernet->join6);
>  }
>  #endif
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3cb975227d12..bc7108ed453c 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3794,7 +3794,7 @@ static struct inet_protosw mptcp_v6_protosw = {
>  	.flags		= INET_PROTOSW_ICSK,
>  };
>  
> -int __init mptcp_proto_v6_init(void)
> +int __net_init mptcp_proto_v6_init(void)
>  {
>  	int err;
>  
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 6b2d7f60c8ad..7ec2513e1c2f 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -648,7 +648,7 @@ static inline bool mptcp_has_another_subflow(struct sock *ssk)
>  
>  void __init mptcp_proto_init(void);
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -int __init mptcp_proto_v6_init(void);
> +int __net_init mptcp_proto_v6_init(void);
>  #endif
>  
>  struct sock *mptcp_sk_clone(const struct sock *sk,
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 77da5f744a17..67a4c698602d 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -116,6 +116,9 @@ static void subflow_init_req(struct request_sock *req, const struct sock *sk_lis
>  
>  static bool subflow_use_different_sport(struct mptcp_sock *msk, const struct sock *sk)
>  {
> +	if (inet_sk(sk)->inet_sport == 0)
> +		return true;
> +
>  	return inet_sk(sk)->inet_sport != inet_sk((struct sock *)msk)->inet_sport;
>  }
>  
> @@ -216,11 +219,6 @@ static int subflow_check_req(struct request_sock *req,
>  			pr_debug("syn inet_sport=%d %d",
>  				 ntohs(inet_sk(sk_listener)->inet_sport),
>  				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
> -			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk,
> -							 sk_listener->sk_family, skb)) {
> -				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTSYNRX);
> -				return -EPERM;
> -			}
>  			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINPORTSYNRX);
>  		}
>  

