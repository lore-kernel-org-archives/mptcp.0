Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E442F80
	for <mptcp@lists.linux.dev>; Fri, 10 Sep 2021 16:49:21 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10103"; a="219260261"
X-IronPort-AV: E=Sophos;i="5.85,283,1624345200"; 
   d="scan'208";a="219260261"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2021 09:49:14 -0700
X-IronPort-AV: E=Sophos;i="5.85,283,1624345200"; 
   d="scan'208";a="526157473"
Received: from svuppala-mobl.amr.corp.intel.com ([10.212.165.209])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2021 09:49:13 -0700
Date: Fri, 10 Sep 2021 09:49:13 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev, 
    Geliang Tang <geliangtang@xiaomi.com>
Subject: Re: [PATCH mptcp-next v2 1/9] mptcp: add noncontiguous flag
In-Reply-To: <4300fcede93507b5d6c8d3e743007e31985ce84b.camel@redhat.com>
Message-ID: <8f5469f2-c25f-31f-d562-da5f1d6b6a2e@linux.intel.com>
References: <cover.1631188109.git.geliangtang@xiaomi.com>   <138e3913108d313b11a261e6c9e3db2cc788183f.1631188109.git.geliangtang@xiaomi.com>  <7147f377124eaa4445aa11e8f8f4efbd72d69261.camel@redhat.com>  <4e24a896-b1bf-c6ee-2db9-4d1d572c99cd@linux.intel.com>
 <4300fcede93507b5d6c8d3e743007e31985ce84b.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 10 Sep 2021, Paolo Abeni wrote:

> On Thu, 2021-09-09 at 17:00 -0700, Mat Martineau wrote:
>>> On Thu, 9 Sep 2021, Paolo Abeni wrote:
>>> msk stream is 'continuous' if and only if 'before64(last_retrnas_seq,
>>> msk->snd_una)'
>>>
>>
>> If last_retrans_seq is checked only when msk->noncontiguous is true, I
>> think that works out. Otherwise the last_retrans_seq is stale/invalid if
>> retransmission never happened, or any retransmissions have been fully
>> acked.
>
> I think can we just init 'last_retrans_seq' to intial_seq - 1 at msk
> creation time and we could always use the above check:
>
> 	if (before64(last_retrnas_seq, msk->snd_una))
>
> WDYT?
>

Ah, ok. Initialize it like that, and then keep moving last_retrans_seq 
ahead when updating snd_una and the MPTCP stream *is* contiguous, so we 
don't run in to problems when snd_una wraps around relative to 
last_retrans_seq.

And be sure to set last_retrans_seq to the sequence number for the end of 
the retransmitted data when entering recovery as well as in 
__mptcp_retrans().

--
Mat Martineau
Intel
