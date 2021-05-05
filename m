Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAD371
	for <mptcp@lists.linux.dev>; Wed,  5 May 2021 18:03:59 +0000 (UTC)
IronPort-SDR: 4foRtNdcnIR2Lgy1tgDUYgey2QYpUYnqFp4TwGQC96Oou6XcRXdn6GTnK92A9/ck6vOQIpanPY
 ox8CJvnRuWdw==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="283702053"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="283702053"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 11:03:58 -0700
IronPort-SDR: tm0LvIQ5BMlTc175NY63UQ2A6zQUWwr92ukCg0Ms/4Z9wh0SKRfTH8HH1kTpid7X8vzcuvBae9
 ToqvXh8IpNcA==
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="389274723"
Received: from kkkoney-mobl3.amr.corp.intel.com ([10.212.161.105])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 11:03:57 -0700
Date: Wed, 5 May 2021 11:03:54 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Christoph Paasch <cpaasch@apple.com>
Subject: Re: [PATCH v6 mptcp-next 00/22] mptcp: data checksum support
In-Reply-To: <521bebd638f2baae1d511af64690b5c64b910d57.camel@redhat.com>
Message-ID: <ef9a9dbe-8ac4-82af-316e-5680377ac7ee@linux.intel.com>
References: <cover.1620163861.git.pabeni@redhat.com> <521bebd638f2baae1d511af64690b5c64b910d57.camel@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 5 May 2021, Paolo Abeni wrote:

> On Tue, 2021-05-04 at 23:41 +0200, Paolo Abeni wrote:
>> Changes from v5:
>>  - none really, added patch lost in previous iteration due to PEBKAC
>
> Note: self-tests are successful here (even with -C flag), but I did not
> test interoperability with mptcp.org because...
>
> ... I think mptcp.org csum implementation does not respect RFC 8684.
>
> In the current mptcp.org git repo
> @f8b7c5e4a105b9d561eb5fb8cba26efbac861bc7,
> file net/mptcp/mptcp_output.c, function mptcp_write_dss_mapping():
>
> 		csum = csum_partial(ptr - 2, 12, skb->csum);

12 bytes are checksummed here.

>                p16++;
>                *p16++ = csum_fold(csum_partial(&hdseq, sizeof(hdseq), csum));

sizeof(hdseq) is 4, so 4 more bytes for the upper bits of the DSN are 
checksummed by csum_partial() here, assuming that 
mptcp_get_highorder_sndbits() grabs the right bits.

>
> since the pseudo header len is 12, it looks like 4 bytes/32bits DSN is used.
>
> But RFC 8684 section 3.3.1. says:
>
> """
>   Note that the data sequence number used in the pseudo-header is
>   always the 64-bit value, irrespective of what length is used in the
>   DSS option itself.
> """
>
> Even RFC 6824 reports the same sentence, so it looks like I'm missing
> some bits here?!?

The verification side in mptcp_verif_dss_csum() uses the full 64 bit 
pseudoheader too, and that would fail if the sender side was skipping part 
of the DSN.


--
Mat Martineau
Intel
