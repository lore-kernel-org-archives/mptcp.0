Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F605395
	for <mptcp@lists.linux.dev>; Wed,  9 Mar 2022 23:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646868287; x=1678404287;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vlFUhClrP6Zy7U7A7ccMsJM6m4ZEPAv7+FkSbvzevkY=;
  b=fRpigftnSH6e1DVDErdp558V/5eUZO7oQmuQxK9nPHJqTdw0Lt62prrI
   HTxNixLdr+Lpef2cqTq3TnK9HOcZykNYDClKnMsYrry1ORAJ6F8st06RC
   4i2BYWhtpuQalLkPK2UPSmMFHgXiaoJHxzdkuG8ipgXZz3DLwaJ2vVzuA
   IdiW4FdEEC6AQpmQT6B08Lw62QEWhEcPjuzJicesiHz6q6JTIKvb58U6/
   7tyOH3YWbYcrDYHjm12dXNH3hQf9++IN861gqjAIP/fLG9l84GqtoOuBJ
   47sz3pyVaiNd7F9cuFThOdw8llNQ75G+eZVHW7E3vShZ4ODEPWyonnKrf
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="252683678"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="252683678"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 15:24:46 -0800
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="547807777"
Received: from amadhuso-mobl2.amr.corp.intel.com ([10.212.252.248])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 15:24:45 -0800
Date: Wed, 9 Mar 2022 15:24:45 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>, 
    Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v10 0/5] add add skc_to_mptcp_sock
In-Reply-To: <a28fe12f-261e-82dd-8b0d-bd66cffb3524@tessares.net>
Message-ID: <6e8d81f-eca5-f49b-3bfb-59d8b5ea69a5@linux.intel.com>
References: <cover.1646796538.git.geliang.tang@suse.com> <a28fe12f-261e-82dd-8b0d-bd66cffb3524@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 9 Mar 2022, Matthieu Baerts wrote:

> Hi Geliang,
>
> On 09/03/2022 04:35, Geliang Tang wrote:
>> v10:
>>  - merge the squash-to patch.
>>  - update patch 3 as Matt suggested.
>>  - add sync() in get_msk_token() before read().
>>  - add a comment for get_msk_token().
>>  - update subjects and commit logs.
>
> Thank you for this new version! It looks good to me!
>
> Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>
> I'm looking at rebuilding the TopGit tree. I will apply this just after.
>

Thank you both for iterating on this. Builds and runs fine for me 
(although I didn't try !CONFIG_MPTCP).

Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
