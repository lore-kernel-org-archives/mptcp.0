Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC31829A1
	for <mptcp@lists.linux.dev>; Mon, 16 May 2022 23:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652742450; x=1684278450;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kf2RCuACHHyrq32dGzD/jJaBULkPvi31EzHIzgEuHJ0=;
  b=Zg6eyz5+0JOQR0RKcQggxfFwYpbEEUsbd+3ryAuWvRRWcbvl5/A7062n
   QeQW/5FDPa/4yVr+j/uTORzGfHDydOOzFeOePW0pBnOzCP9pvlv9Wpm5R
   lQpEvaq6OGxf/9i7NBpfivA4MFpFI8BHo9h33YnfRt7Y+D+cElXXzzg3B
   jmxJ+A96YM7v0j8ueD6fIUi2LYYf6NXEc5hG7MFjyBiq1//KVTnTkRRUD
   QLiRvHCJm7kaGuUY24MNS5UGnjYbwRBIftEsdj+MrFrWYY6yEtoqXzYfb
   drSSsC2/6ETm3YrFENYjsP0QaoYWSoH1z15uBO34vVIj0gL24uAFdCadt
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="334032745"
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="334032745"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 16:07:30 -0700
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="574241224"
Received: from scrowley-mobl1.amr.corp.intel.com ([10.212.97.175])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 16:07:29 -0700
Date: Mon, 16 May 2022 16:07:22 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, 
    Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2] mptcp: fix checksum byte order
In-Reply-To: <349fa6a5-6e64-8bce-5592-6164941659b9@tessares.net>
Message-ID: <314ab5c-3e28-4f49-3afc-82f01c6d2da4@linux.intel.com>
References: <595f104803a212df58db6d20f84947325b33a9d6.1652196378.git.pabeni@redhat.com> <349fa6a5-6e64-8bce-5592-6164941659b9@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII


On Sat, 14 May 2022, Matthieu Baerts wrote:

> Hi Paolo, Mat,
>
> On 10/05/2022 18:25, Paolo Abeni wrote:
>> The MPTCP code typecasts the checksum value to u16 and
>> then convert it to big endian while storing the value into
>> the MPTCP option.
>>
>> As a result, the wire encoding for little endian host is
>> wrong, and that causes interoperabilty interoperability
>> issues with other implementation or host with different endianess.
>>
>> Address the issue writing in the packet the unmodified __sum16 value.
>>
>> MPTCP checksum is disabled by default, interoperating with systems
>> with bad mptcp-level csum encodying should cause fallback to TCP.
>
> Thank you for the patch and the review!
>
> Now in our tree (fixes for -net) with Mat's RvB tag:
>
> - 5291df4774c1: mptcp: fix checksum byte order (with conflicts)
> - Results: 128393ceec9b..35e8b300fc90 (export-net)
>

Matthieu, Paolo -

I'm planning to send this patch and "mptcp: Do TCP fallback on early DSS 
checksum failure" to the -net branch on Tuesday - any concerns with that?

Thanks,

--
Mat Martineau
Intel
