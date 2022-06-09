Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C507A
	for <mptcp@lists.linux.dev>; Thu,  9 Jun 2022 17:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654795793; x=1686331793;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GNNcxrW8QPkfz8/DdhaJp74+Rzbyw8+Deqxl6rvjNBM=;
  b=IFJPiKeJ7Y2OxLfKEG1K/25XfW5dg5+vY6PMB1PasTOQbaOuXf/bnhgv
   94FY1vpHSThoXhCLijDEa+Mwud6rkoxjxDz4VrLtngFvC1g2v6KVmgqqp
   4DcxJVCDcDAFDiqarurM3ZCnk1NcfEUy2AMiaJzxhVnzmOOt5ykGzJeoc
   CAAT3tovbt30eFOZcxADBe7DMNIvKAuFkqAG9voNA2BLS/5ntX5lTA2ir
   Iyw48PNJNg/N64io4jcsMfZ3wx11wUKw1N9dYHCtwgs/QWTxNqX8hna6G
   EfCNFQm/RriTnRgwhW27Z//Aulnp0hTZq8YPdkWDPsPWqs6J/Mzb1gjc/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="341433997"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="341433997"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 10:29:52 -0700
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="616012515"
Received: from stolud-mobl1.ger.corp.intel.com ([10.212.124.13])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 10:29:52 -0700
Date: Thu, 9 Jun 2022 10:29:52 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4 1/2] mptcp: refactor MP_FAIL response
 timeout
In-Reply-To: <0bf29017a5a85214d3fe520288a731496c12df1e.camel@redhat.com>
Message-ID: <4a6a3b-9a28-d2a-03c-23a211b76ab1@linux.intel.com>
References: <cover.1654732564.git.geliang.tang@suse.com>  <ee1ab6a8d4525e7af542f84ad11fcca7a1e938e6.1654732564.git.geliang.tang@suse.com> <0bf29017a5a85214d3fe520288a731496c12df1e.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 9 Jun 2022, Paolo Abeni wrote:

> On Thu, 2022-06-09 at 08:00 +0800, Geliang Tang wrote:
>> mptcp_mp_fail_no_response shouldn't be invoked on each worker run, it
>> should be invoked only when MP_FAIL response timeout occurs.
>>
>> This patch refactors the MP_FAIL response timeout logic. Add fail_tout
>> in mptcp_sock to record the MP_FAIL timestamp. Check it in mptcp_worker()
>> before invoking mptcp_mp_fail_no_response(). Drop the code to reuse
>> sk_timer for MP_FAIL response.
>
> I'm sorry for not noticing it on the previous version - likely for the
> lack of clarity on my side: we still need to start the timer for
> mp_fail response: otherwise we are not assured that the mptcp_worker
> will be triggered.
>

(capturing this on the mailing list in addition to the recent meeting)

Yes, I agree. I saw that the timer stop calls were removed but missed the 
timer reset removal. It is imporant for the timer to still be started.

> Additionally we need some more care to manipulate the timer reset. I
> think it's easier if I send a squash-to patch - assuming I'll have some
> time for that early next week.
>

Thanks Paolo!

--
Mat Martineau
Intel
