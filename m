Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB733FC2
	for <mptcp@lists.linux.dev>; Tue, 21 Sep 2021 03:42:36 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="222922921"
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="222922921"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 20:42:32 -0700
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="556612060"
Received: from mrbrayko-mobl1.amr.corp.intel.com ([10.212.230.97])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 20:42:32 -0700
Date: Mon, 20 Sep 2021 20:42:31 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] mptcp: always provide MPTCP skb ext for tx
 skb
In-Reply-To: <19d65be-6eb-a183-7e47-9676d19d66a0@linux.intel.com>
Message-ID: <c93359d-ea16-c2dd-8845-19c5796c1853@linux.intel.com>
References: <0bcf04149918792f287bf56fb5a38e4a19be4fe0.1631808364.git.pabeni@redhat.com> <7a42709a-8637-d9a1-ee01-765dae184385@tessares.net> <19d65be-6eb-a183-7e47-9676d19d66a0@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 20 Sep 2021, Mat Martineau wrote:

> On Mon, 20 Sep 2021, Matthieu Baerts wrote:
>
>> Hi Paolo, Mat,
>> 
>> On 16/09/2021 18:06, Paolo Abeni wrote:
>>> The mptcp code will uses whatever skb is present into
>>> ssk->sk_tx_skb_cache. If the skb tx cache is enabled, the
>>> recycle operation will clean the MPTCP extension from the
>>> cached skb, and the MPTCP would hit a later WARN.
>>> 
>>> Fix the issue always invoking the mptcp skb allocation
>>> helper, which will safely check the cached skb for the extension
>>> presence.
>> 
>> Thank you for the patch and the review!
>> 
>> This patch is now in our tree (fixes for net) with the Reported-by tag
>> and Mat's RvB tag.
>> 
>> Please note that as expected, I had a conflict with "mptcp: stop relying
>> on tcp_tx_skb_cache". As a result, 'export' is seen as unmodified
>> because the modification here is no longer needed thanks to "mptcp: stop
>> relying on tcp_tx_skb_cache".
>> 
>> - cc90251fe40f: mptcp: always provide MPTCP skb ext for tx skb
>> - 1027c0b1c29c: conflict in t/mptcp-stop-relying-on-tcp_tx_skb_cache
>> - Results: 1c6ca6c7576e..82229863a0d7 (diff is empty as expected)
>> 
>> Builds and tests are now in progress:
>> 
>> https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210920T154149
>> https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210920T154149
>> 
>> (but the tests are validating the same code as before as "export" still
>> has the same code at the end)
>> 
>
> I'll give the syzbot reproducer a try with this patch today.
>

Paolo's proposed fix didn't resolve the issue for syzbot. Unfortunately 
I didn't get good information from my local syzkaller setup today trying 
to reproduce the issue (without the fix) on net-next. Will have to try a 
different approach to reproducing it tomorrow.

--
Mat Martineau
Intel
