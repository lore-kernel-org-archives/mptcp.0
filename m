Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19384320B
	for <mptcp@lists.linux.dev>; Fri, 17 Jun 2022 23:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655507176; x=1687043176;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=erNU4CrNywXs/vjlNGViNsWbVJMvtUN7PkPm0WUIBtc=;
  b=ge+SkuL4riaPK6LvHBDromHIkeHExOlkzcyXlSZDUEZndjj4me9pM3zY
   hu3IZOnFT9uR9bpk/uqOW5NOikCZQFJY4cXC4gAHMoNZqu+LOtTjt5ZSl
   Z5CnopKlVL8WWm7tocaAGl2cV5rcDSRPfK+Ezf7Z33BRDR0OAGXJzcGQg
   GLqiMTHxut/BNEkLndi656UR5dvNhGac86eiuHu23xbsYoB8TD7nLB4tV
   a6VCjxBpiQz2EVRgmMau2eFsJJPOE9cwN3Yz1h/WT4S6FFw7EEYClVeDL
   kliyfFYS8gP6jv+Kiu97KrC2UDO4/GLkdQ5+Axq1VnVgojpZdVTK52U5d
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280337602"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280337602"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 16:06:15 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="590303472"
Received: from theiders-mobl.amr.corp.intel.com ([10.209.81.3])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 16:06:15 -0700
Date: Fri, 17 Jun 2022 16:06:14 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v3 3/6] Squash-to: "mptcp: invoke MP_FAIL
 response when needed"
In-Reply-To: <3c73bf6e5c29fd1639a2ce0ccc93b06f5a49a335.camel@redhat.com>
Message-ID: <b6d4766-c366-224c-548-afa65115d94c@linux.intel.com>
References: <cover.1655460262.git.pabeni@redhat.com>  <7b8fcd495f785d51cf87149826b0ce07cbdd1da0.1655460262.git.pabeni@redhat.com> <3c73bf6e5c29fd1639a2ce0ccc93b06f5a49a335.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 17 Jun 2022, Paolo Abeni wrote:

> On Fri, 2022-06-17 at 12:05 +0200, Paolo Abeni wrote:
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index 98b12a9c4eb5..c82a9a6e0267 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -1158,6 +1158,33 @@ static bool subflow_can_fallback(struct mptcp_subflow_context *subflow)
>>  		return !subflow->fully_established;
>>  }
>>
>> +static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
>> +{
>> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
>> +	unsigned long fail_tout;
>> +
>> +	/* grecefull failure can happen only on the MPC subflow */
>> +	if (WARN_ON_ONCE(ssk != READ_ONCE(msk->first)))
>> +		return;
>> +
>> +	/* since the close timeout take precedence on the fail one,
>> +	 * no need to starte the latter when the first is already set
>
> Typo here ("starte"). It would be great if it could be addressed
> without reposting the whole series... A later squash-to patch could be
> ok?
>

Typo fix via squash or edit is fine by me. Also, grecefull->graceful a 
few lines earlier.

--
Mat Martineau
Intel
