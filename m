Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE64D2C9D
	for <mptcp@lists.linux.dev>; Mon,  6 Dec 2021 18:47:48 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="217404920"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="217404920"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 10:47:48 -0800
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="461947381"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2) ([10.251.18.10])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 10:47:48 -0800
Date: Mon, 6 Dec 2021 10:47:47 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp] mptcp: remove tcp ulp setsockopt support
In-Reply-To: <61ea8986-10c2-1d4f-6c35-2c910dbdcf89@tessares.net>
Message-ID: <38c041f7-29d9-e61d-d5bf-6523785ce12@linux.intel.com>
References: <00000000000040972505d24e88e3@google.com> <20211205192700.25396-1-fw@strlen.de> <61ea8986-10c2-1d4f-6c35-2c910dbdcf89@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 6 Dec 2021, Matthieu Baerts wrote:

> Hi Florian,
>
> (without netdev and syzbot ML)
>
> On 05/12/2021 20:27, Florian Westphal wrote:
>> TCP_ULP setsockopt cannot be used for mptcp because its already
>> used internally to plumb subflow (tcp) sockets to the mptcp layer.
>>
>> syzbot managed to trigger a crash for mptcp connections that are
>> in fallback mode:
>>
>> KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
>> CPU: 1 PID: 1083 Comm: syz-executor.3 Not tainted 5.16.0-rc2-syzkaller #0
>> RIP: 0010:tls_build_proto net/tls/tls_main.c:776 [inline]
>> [..]
>>  __tcp_set_ulp net/ipv4/tcp_ulp.c:139 [inline]
>>  tcp_set_ulp+0x428/0x4c0 net/ipv4/tcp_ulp.c:160
>>  do_tcp_setsockopt+0x455/0x37c0 net/ipv4/tcp.c:3391
>>  mptcp_setsockopt+0x1b47/0x2400 net/mptcp/sockopt.c:638
>>
>> Remove support for TCP_ULP setsockopt.
>
> Good catch!
> Indeed, it doesn't make sense to support TCP_ULP.
>
>> Reported-by: syzbot+1fd9b69cde42967d1add@syzkaller.appspotmail.com
>> Signed-off-by: Florian Westphal <fw@strlen.de>
>
> I guess we need a Fixes tag here:
>
> Fixes: d9e4c1291810 ("mptcp: only admit explicitly supported sockopt")
>

Thanks Florian.

Matthieu, could you apply this to the export branch with your suggested 
Fixes tag?

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
