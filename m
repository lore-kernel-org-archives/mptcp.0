Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C6228EE
	for <mptcp@lists.linux.dev>; Thu, 19 May 2022 15:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652972730; x=1684508730;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/GxjhSPhnQEEgP3zQFVvYmheMkWldUr2cZcaIX2JHNQ=;
  b=HNPGimkOmDGPfiCn7BX6xswhKrdW7TeseCgds/3c0cP5ipJGIr+gYWvw
   q4tr1hhRk9vkLKvhwh0kH5B2oYOlnfebcySZbJvjILN0pQ4Dn1oicLP6b
   TFLQE9Y83KlqL1OYk6rjjB4pdBOFpMDDTuAcAFPL2IB8VDLptZEBW3/5B
   OujazhuEl750gO1x4F8vXL7nsl1YY9UkzrMCg624CWBjME1YmExoenq/a
   K/RrgXWgt29NMBuyh/ZRbjphxo3jL3IPcE2wzXZbZ6BeTHa2HsEjlyz1W
   Ue4omtR+k2PVHPSyoD/l3F5yHwQnn441eeYV0Vx0EXstlFNRT9W4HrrXr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="252753504"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="252753504"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 08:05:29 -0700
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="661734121"
Received: from camcconn-mobl1.amr.corp.intel.com ([10.255.229.130])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 08:05:29 -0700
Date: Thu, 19 May 2022 08:05:22 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: Geliang Tang <geliang.tang@suse.com>, 
    MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next 02/17] mptcp: move mptcp_subflow_context in
 net/mptcp.h
In-Reply-To: <CA+WQbwsy5nyUc+NFbG0Uks-zZzUHs0G_w30Z9L+0+=FVcJWVJw@mail.gmail.com>
Message-ID: <dee76f4c-3caf-27ae-5343-2440d22dee4c@linux.intel.com>
References: <cover.1652853898.git.geliang.tang@suse.com> <b06c5cd73cb6f6bd8c57cd1b23c95ca365b30708.1652853898.git.geliang.tang@suse.com> <8573a785-26d2-c69b-e18b-fc3a5220e4f3@linux.intel.com>
 <CA+WQbwsy5nyUc+NFbG0Uks-zZzUHs0G_w30Z9L+0+=FVcJWVJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 19 May 2022, Geliang Tang wrote:

>>> Move struct mptcp_subflow_context definition from net/mptcp/protocol.h
>>> to include/net/mptcp.h. And move the related struct mptcp_data_avail and
>>> function mptcp_subflow_ctx() too.
>>>
>>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>>
>> I'm not sure I agree with moving all of this just because Martin asked
>> about an inline function. I'll follow up on the netdev email thread.
>
> Mat, I removed the first three patches in v2. Could patch 1 still be
> used as an effective cleanup?

Sure, I'll update that in patchwork.


--
Mat Martineau
Intel
