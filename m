Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EA82F80
	for <mptcp@lists.linux.dev>; Mon,  7 Jun 2021 16:45:34 +0000 (UTC)
IronPort-SDR: E9yYycrbWlXRydy5fVzyBtI3udk+rX3tbNLSekc/0SlAxAQcQ7Q8DgbQQsprrGe7vsPyCvQ7Am
 0S0TxwOzGKYA==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="201638467"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="201638467"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 09:45:32 -0700
IronPort-SDR: j8HUZH0ZiB8A8Y8v0Cw9VL635vqJ2t84Q+vAW+co4LvbT4ehR4tstzzTh7VjXMRmKZ5ec77Ypf
 iPl4o+kRpC5A==
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="551951723"
Received: from sravikum-mobl1.amr.corp.intel.com ([10.212.171.223])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 09:45:32 -0700
Date: Mon, 7 Jun 2021 09:45:31 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH] Squash-to: "mptcp: wake-up readers only for in sequence
 data"
In-Reply-To: <7d6fdeb1-6155-6481-70f8-ab1115317c5d@tessares.net>
Message-ID: <46364e9-a88c-45ba-1bf1-34d4bef3faf@linux.intel.com>
References: <8c07c4b90aac3f1d3bdd64c5ba8f5c83372005a1.1623074917.git.pabeni@redhat.com> <7d6fdeb1-6155-6481-70f8-ab1115317c5d@tessares.net>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 7 Jun 2021, Matthieu Baerts wrote:

> Hi Paolo, Mat,
>
> On 07/06/2021 16:08, Paolo Abeni wrote:
>> We need to flip the DATA_READY bit under the mptcp_data_lock()
>> (or before acquiring it, as the old code did), or the BH could
>> end-up flipping the bit after that the user-space already
>> flushed the just-appended data.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>
> Thank you for the patch!
>
> @Mat: I hope you don't mind if I already apply it to fix issues/201 and
> apply other patches!

No problem!

>
> - b2427404975d: "squashed" in "mptcp: wake-up readers only for in
> sequence data"
> - Results: 3c5535f65726..e5d80c7af352
>
> Builds and tests are now in progress:
>
> https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210607T145646
> https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210607T145646

--
Mat Martineau
Intel
