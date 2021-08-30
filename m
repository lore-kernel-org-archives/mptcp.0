Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5640A72
	for <mptcp@lists.linux.dev>; Mon, 30 Aug 2021 18:10:51 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="218370886"
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="218370886"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 11:10:50 -0700
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="540646927"
Received: from sahushub-mobl1.amr.corp.intel.com ([10.209.36.196])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 11:10:50 -0700
Date: Mon, 30 Aug 2021 11:10:50 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: pabeni@redhat.com, geliangtang@gmail.com, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] mptcp: Only send extra TCP acks in eligible
 socket states
In-Reply-To: <5ea0f310-8798-e436-24ae-2476b16b1813@tessares.net>
Message-ID: <4f65e83-3f44-15a7-a9b8-95b4d74b745d@linux.intel.com>
References: <20210826004601.196834-1-mathew.j.martineau@linux.intel.com> <5ea0f310-8798-e436-24ae-2476b16b1813@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Thu, 26 Aug 2021, Matthieu Baerts wrote:

> Hi Mat, Paolo,
>
> On 26/08/2021 02:46, Mat Martineau wrote:
>> Recent changes exposed a bug where specifically-timed requests to the
>> path manager netlink API could trigger a divide-by-zero in
>> __tcp_select_window(), as syzkaller does:
>
> (...)
>
> Thank you for the patch, the review and the testing!
>

More info on the testing: I was able to run syzkaller over the weekend, 
and the error has not reoccurred in the last 5 days.

> This is now in our tree:
>
> - ea8a43942429: mptcp: Only send extra TCP acks in eligible socket states
> - Results: 99a16463048d..6d52100ab2ab
>
>> Fixes: 84dfe3677a6f ("mptcp: send out dedicated ADD_ADDR packet")
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/229
>> Co-developed-by: Paolo Abeni <pabeni@redhat.com>
>
> Checkpatch is yelling at me because a SoB is not present here.
>
> @Paolo: sorry to ask this question but for the record, is it OK for you
> if I add it? :)
>

Still an open question here about signoff (or changing author header) for 
Paolo !


--
Mat Martineau
Intel
