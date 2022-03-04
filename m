Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E26E7C
	for <mptcp@lists.linux.dev>; Fri,  4 Mar 2022 19:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646420922; x=1677956922;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=271pA9TiEevv2o/8OZIr6PNHA6N/W/6RVRX84l9gQX0=;
  b=LPqLFGYIA921jLklXuyK3MVl77svNThSqLV+7uMhB+Udm2LQDxKKkOp+
   UZJFbA9XeF7blpheBD/JtAbw7u40NB7qvksR5O1V1C7G3X7DjNaHr/XWB
   ZW4cySh8lpRX4T0BZmQ+7Z0li+y6P6eR0MogAuXnutEwqgu23wTcGdqME
   I07fUKTgp/3N7DrVxZ3M4i6jztPyrnctTLfb17x7PBXxvXZHlZtmc6OBu
   WMtc4qivVZItTvQ6XOcgViWfjtjuW6O7Jsi5Du4SjDLwwl5NnDpkNKd1X
   cR3PJZt6giTN0iE2rLJLoDDnfYvzZgI5wlBJKz2/joJNKveo9lPTAQUDu
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="253773141"
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="253773141"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 11:08:42 -0800
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="511952994"
Received: from iballa-mobl2.amr.corp.intel.com ([10.251.12.232])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 11:08:41 -0800
Date: Fri, 4 Mar 2022 11:08:41 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: Matthieu Baerts <matthieu.baerts@tessares.net>, 
    MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: Reordered MPTCP export branch
In-Reply-To: <CA+WQbwt_-s-EkCFPLUF3HCAS-dGrjcZOW-Y=LwWrC=0jCf3sPg@mail.gmail.com>
Message-ID: <bc642949-ab3c-933-a756-664bac9e6d1@linux.intel.com>
References: <5b92e547-12d6-91e0-6636-e98b3dffa27@linux.intel.com> <CA+WQbwt_-s-EkCFPLUF3HCAS-dGrjcZOW-Y=LwWrC=0jCf3sPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1404719460-1646420921=:51852"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1404719460-1646420921=:51852
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 4 Mar 2022, Geliang Tang wrote:

> Hi Mat, Matt,
>
> Mat Martineau <mathew.j.martineau@linux.intel.com> 于2022年3月4日周五 12:15写道：
>>
>>
>> Hi Matthieu,
>>
>> I pushed the reordered export branch to:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git
>>
>> Branch: mptcp-reorder-export (da80d856dc17)
>
> Please move the following line from the commit "selftests: mptcp: add more
> arguments for chk_join_nr" to "selftests: mptcp: add infinite map mibs
> check" on the mptcp-reorder-export branch:
>
> +        local infi_nr=${9:-0}
>
> And move the following two lines from the commit "selftests: mptcp: add
> the MP_FAIL testcases" to "selftests: mptcp: drop msg argument of
> chk_csum_nr":
>
> +validate_checksum=0
>
> +        validate_checksum=$checksum
>
> If it's better to send some squash-to patches, please let me know.
>

Thanks for reviewing the changes to the patches, Geliang! I've made the 
changes and pushed to the same branch, now e4beefe49d93 is the head.


--
Mat Martineau
Intel
--0-1404719460-1646420921=:51852--
