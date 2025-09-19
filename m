Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D3D23FC54
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 07:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267044; cv=none; b=RXUxF7HZgzongYJIcFaBOGpsI3rEuWKPTtJFBynS3rEUGcdv76Yor6fk2rmkN8GHUI7iQyQznmRPIqzGC9MqPvmFfNazGtofOzIR0kKTpEz/GHI+8OiuSxIiFugWhXuxZPeflQvjfmXDwhlrfbu+AvMopUfXxZ2NVJAt99JfggY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267044; c=relaxed/simple;
	bh=6TPnCkNrj/AcRaxoOY+Ag6eIVvef3bWI9hpnYZ/nrF0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QBZL+XAsl2zRd2tXwejoLCE7Qw57xbCrNV71WSxmPze77wo6kmmP0wxoSP/CqRCZR8teDHNk3e/fAafzW6DrLzLyklk573Sv1S6gv4nDmfdHpK+j2+1MoR7XKDO+F6jPmnmzQkeqwFgiEuzwszT0JsywPbVrvSTk1SnUgNnjq4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1ns6Mgy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1ns6Mgy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC62C4CEF0;
	Fri, 19 Sep 2025 07:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758267044;
	bh=6TPnCkNrj/AcRaxoOY+Ag6eIVvef3bWI9hpnYZ/nrF0=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Y1ns6MgyNTW6qzhxz3Mb5mYaj5ZcPe1P1IrrFZ5F9zCjfe4Z2/35KdSaXE6gGgWHl
	 sWcpbYfxBrtR1v8s6aRbQ68oYQXBChCKxQ6PlVsZJdc3CC0uky/ApMbCzka8EmZNkN
	 IEYN6giqXnzCPgmGjyLQVruR++C7ORcxIKJ19kEGmabqEvWVFZ9KwKdjp3HvrRMcc5
	 dheMBV6aGm3/T6E2jrXXGa4/xjPHl40VLmbMl8WJkhE8I9a62XFkx+bYEHEqK8lD7o
	 EHJxqBsObR5uR6TT7MmY4Js/wMZ12KBbGNfb2Kbedh8wbe+Cxvfy4+H75o8MJ6+im+
	 SNqtoTd8cCnoA==
Message-ID: <f22ea68c9b2647da7d50ad7ab77f513a98ff5736.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 00/12] mptcp: receive path improvement
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, MPTCP Linux <mptcp@lists.linux.dev>
Date: Fri, 19 Sep 2025 15:30:37 +0800
In-Reply-To: <7da5cd03-b5ce-4062-a23f-7bd7ecbec38c@redhat.com>
References: <cover.1758214563.git.pabeni@redhat.com>
	 <dd39e243-9ffe-86c0-9db7-6c108470b3b2@gmail.com>
	 <0387885e84d41f14cf23914c85d2191f1cdfdae9.camel@kernel.org>
	 <7da5cd03-b5ce-4062-a23f-7bd7ecbec38c@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2025-09-19 at 08:54 +0200, Paolo Abeni wrote:
> On 9/19/25 4:22 AM, Geliang Tang wrote:
> > On Thu, 2025-09-18 at 20:33 +0000, MPTCP CI wrote:
> > > Hi Paolo,
> > > 
> > > Thank you for your modifications, that's great!
> > > 
> > > Our CI did some validations and here is its report:
> > > 
> > > - KVM Validation: normal: Unstable: 5 failed test(s):
> > > packetdrill_mp_capable selftest_mptcp_connect
> > > selftest_mptcp_connect_checksum selftest_mptcp_connect_mmap
> > > selftest_mptcp_connect_sendfile 🔴
> > > - KVM Validation: debug: Unstable: 5 failed test(s):
> > > packetdrill_mp_capable selftest_mptcp_connect
> > > selftest_mptcp_connect_checksum selftest_mptcp_connect_mmap
> > > selftest_mptcp_connect_sendfile 🔴
> > > - KVM Validation: btf-normal (only bpftest_all): Success! ✅
> > > - KVM Validation: btf-debug (only bpftest_all): Success! ✅
> > > - Task:
> > > https://github.com/multipath-tcp/mptcp_net-next/actions/runs/17836736262
> > 
> > CI reports that this series breaks the mptcp_connect.sh test:
> > 
> > # INFO: disconnect
> > # 63 ns1 MPTCP -> ns1 (10.0.1.1:20001      ) MPTCP     (duration 
> > 1348ms) [ OK ]
> > # 64 ns1 MPTCP -> ns1 (10.0.1.1:20002      ) TCP       main_loop_s:
> > timed out
> > # (duration 61185ms) [FAIL] client exit code 124, server 2
> > # 
> > # netns ns1-HugJD9 (listener) socket stat for 20002:
> > # Netid State     Recv-Q Send-Q Local Address:Port  Peer
> > Address:Port 
> > # tcp   TIME-WAIT 0      0           10.0.1.1:20002    
> > 10.0.1.1:47722
> > timer:(timewait,,0) ino:0 sk:2066
> > # ^I
> > # TcpActiveOpens                  2                  0.0
> > # TcpPassiveOpens                 2                  0.0
> > 
> > I also tested it on my end and found that starting from patch 8
> > "mptcp:
> > cleanup fallback data fin reception", the mptcp_connect.sh test has
> > been failing.
> > 
> > I apologize for not providing this feedback during the v1 review,
> > but I
> > was too busy yesterday to complete the testing.
> 
> Thank you very much for bisecting. I did not observe the failures on
> v1,
> but I see them on v2 (which is quite suprising, giving no big changes
> in
> there). I submitted v2 anyway to give syzkaller/CI a chance to run
> more.
> 
> I think patch 1-3 should be sane and effective, we can probably merge
> them.

Yes, indeed. I think patch 5 and patch 7 can be merged too. I have just
applied these 5 patches (1-3, 5, 7) to my tree and started testing.
Once all the tests pass, I will add my Reviewed-by and Tested-by tags
for them today.

Thanks,
-Geliang

> 
> Thanks,
> 
> Paolo
> 
