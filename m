Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725072CA6
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 15:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652282567; x=1683818567;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=L+nuBF7MplyUdywP4Gq83RRfCgGSbCvlCCOVzMyGdu0=;
  b=WiIx5nxWFJj4Rqvum8rJV3Xvg1/Mz8k/93SUQx5UiAnWDHqs89mqphER
   +17Ctt28TUsc8qvg55BtU1X5mJo+/01y9+Cfo0Sd+dV+OuhoeVFm+7Ck5
   SgEYs7bbiJRS0Eaktj4ViKumAvd8m+O5nnYlWnUbpoSySFzi4sbv2CM2p
   Bx0BA6JUvWfWLCdCyF/Q1T82aoMElCR8VyNkC0j/A0qOIURwDNPO2V2H7
   RbA/wRN4w194zc3GnAr9SQpmwQGtw04MG2OwkHvSsAts1u5RrXFlPuY/v
   USbbRmKORxyauGSZ84LdBDPFWhMKFlBWWrucemKoG2aQkmpgjr5RfraXJ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="268565614"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="268565614"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 08:22:45 -0700
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="572130201"
Received: from rdstein-mobl.amr.corp.intel.com ([10.212.177.197])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 08:22:45 -0700
Date: Wed, 11 May 2022 08:22:36 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2] mptcp: fix checksum byte order
In-Reply-To: <2bf857cc4abe21426ce2418645667663ca7cefcb.camel@redhat.com>
Message-ID: <c553dddb-98ed-85ac-bd5f-cc23a331e61@linux.intel.com>
References: <595f104803a212df58db6d20f84947325b33a9d6.1652196378.git.pabeni@redhat.com>  <331ef61b-19b7-ea0-6832-ebf3c97aa9c@linux.intel.com> <2bf857cc4abe21426ce2418645667663ca7cefcb.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 11 May 2022, Paolo Abeni wrote:

> On Tue, 2022-05-10 at 16:10 -0700, Mat Martineau wrote:
>> On Tue, 10 May 2022, Paolo Abeni wrote:
>>
>>> The MPTCP code typecasts the checksum value to u16 and
>>> then convert it to big endian while storing the value into
>>> the MPTCP option.
>>>
>>> As a result, the wire encoding for little endian host is
>>> wrong, and that causes interoperabilty interoperability
>>> issues with other implementation or host with different endianess.
>>>
>>> Address the issue writing in the packet the unmodified __sum16 value.
>>>
>>> MPTCP checksum is disabled by default, interoperating with systems
>>> with bad mptcp-level csum encodying should cause fallback to TCP.
>>>
>>> Fixes: c5b39e26d003 ("mptcp: send out checksum for DSS")
>>> Fixes: 390b95a5fb84 ("mptcp: receive checksum for DSS")
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>> v1 -> v2:
>>> - move the typecast inside put_len_csum (Mat)
>>> - updated the commit message (Mat)
>>> - fix a few sparse issues
>>
>> Hi Paolo, thanks for the v2:
>>
>> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>>
>> (for export-net)
>>
>> Still ok with you to apply this to export-net? There are a couple of minor
>> conflicts when rebasing to export-net, and it also creates a merge
>> conflict with net-next. But I think it's worth it to be able to say "every
>> 5.18 and later kernel has the checksum fix".
>
> Agreed.
>
>> Have you tried backporting this commit to 5.17-stable or 5.15-stable?
>
> No, that is likely worthy, but I really have my hands full :( I think I
> can have a look not earlier than next week.

No problem - I can handle the backporting and sending to the stable trees.

--
Mat Martineau
Intel
