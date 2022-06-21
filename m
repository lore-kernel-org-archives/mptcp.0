Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58D71C0C
	for <mptcp@lists.linux.dev>; Tue, 21 Jun 2022 22:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655851629; x=1687387629;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OK3moTayp9OIh12XSNeOB9n0uwBOGzP9D4MIQCwAWpk=;
  b=AumaCdg0VsOrGzYRL84Esi1LOiRPbwbcvTZFP5LvPt0zdg/Mp+Wrjlh6
   v/WA26f0bf6kXqHnZ+krgluW08mgrmU/729Q19G40BWTubn9LJqrc9ysz
   P99mB/HpJGhmrT1QSVbhnCcT6xJoGwGdMXhLsfu9XjHhQtNW2bXkkTQJr
   YyvC/mniz0yUXzgVzdqhvQTHd38DZFOU+MJNDKh7hPDkW5qV6C/C22GmH
   sb1D+P0SKGkrc/yww5OtOJ4BMxnxokBfq1+Qerf1paiVv2BsHEYBSF8oT
   ofKRqZD8s6gSCjkUCSxkMiH4e4Rkho6mpmOHArAa5snB4+lTNeli8xgxZ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="280988358"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="280988358"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 15:46:58 -0700
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="833796769"
Received: from vanehosx-mobl.gar.corp.intel.com ([10.251.13.241])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 15:46:58 -0700
Date: Tue, 21 Jun 2022 15:46:58 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v4 mptcp-next 1/4] mptcp: never fetch fwd memory from
 the subflow
In-Reply-To: <f6421a9f-b294-862-2077-67a2e57eeb43@linux.intel.com>
Message-ID: <372de32b-6ee8-c294-6b43-fde2dae1a46@linux.intel.com>
References: <630f7e13d7226f8c37a9cc0c66008a298c1e6b9e.1655828070.git.pabeni@redhat.com> <f6421a9f-b294-862-2077-67a2e57eeb43@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 21 Jun 2022, Mat Martineau wrote:

> On Tue, 21 Jun 2022, Paolo Abeni wrote:
>
>> The memory accounting is broken in such exceptional code
>> path, and after commit 4890b686f408 ("net: keep sk->sk_forward_alloc
>> as small as possible") we can't find much help there.
>> 
>> Drop the broken code.
>> 
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>
> Thanks Paolo, v4 looks good.
>

One more question Paolo: given the SCTP regression that was bisected to 
the fwd alloc change:

https://lore.kernel.org/netdev/20220619150456.GB34471@xsang-OptiPlex-9020/

is there any need to wait before upstreaming this series for net-next? 
(Such upstreaming will probably be after our Thursday meeting anyway)

- Mat


> For patches 1-3:
>
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>
> See patch 4 for different tag.
>
>
>> This is possibly for net, but makes sense only on top of recent
>> net-next patches, so whatever ;)
>
> I agree it makes sense for net-next.
>
> - Mat
>
>> ---
>> net/mptcp/protocol.c | 11 +++--------
>> 1 file changed, 3 insertions(+), 8 deletions(-)
>> 
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 6d2aa41390e7..0d4b2c010da0 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -328,15 +328,10 @@ static bool mptcp_rmem_schedule(struct sock *sk, 
>> struct sock *ssk, int size)
>>
>> 	amt = sk_mem_pages(size);
>> 	amount = amt << PAGE_SHIFT;
>> -	msk->rmem_fwd_alloc += amount;
>> -	if (!__sk_mem_raise_allocated(sk, size, amt, SK_MEM_RECV)) {
>> -		if (ssk->sk_forward_alloc < amount) {
>> -			msk->rmem_fwd_alloc -= amount;
>> -			return false;
>> -		}
>> +	if (!__sk_mem_raise_allocated(sk, size, amt, SK_MEM_RECV))
>> +		return false;
>> 
>> -		ssk->sk_forward_alloc -= amount;
>> -	}
>> +	msk->rmem_fwd_alloc += amount;
>> 	return true;
>> }
>> 
>> -- 
>> 2.35.3
>> 
>> 
>> 
>
> --
> Mat Martineau
> Intel
>
>

--
Mat Martineau
Intel
