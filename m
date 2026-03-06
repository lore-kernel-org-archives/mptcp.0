Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C6E36A02D;
	Fri,  6 Mar 2026 16:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814516; cv=none; b=eecX8LucWkV3dMNh/BNjQh2XRBuKptMy4BpM+weBcoHjrkSBsisscVgcLg4pPHUwkMcNDora0UWxKVMbAhm1BHWPBEldNaXUumuSzEbJEy2ba1/seSgasEfQtEke6uic3YJ5ybU9GEcQvZZjBluuOM90kOMDG4X9sGGTvdPFFMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814516; c=relaxed/simple;
	bh=205rfIeun8AwJY38haTQgbjnsy/DlyRTaLsXQffpNHE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Eig0YBtndm/3zXXM7Et7OQy7qXcBsIEPtn6y4HT4NWMPbRzCzfsbca4U9iO6lLFugezLTd7SOvJW5d62w3UQGXsXZ646Nn13GfHUMv/3aJB//0UCtcR0hItA3KyePvV/O0N6aIWRbrO5HNnpJqfj5acC5hiJFuMpHxsarAekjBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5iGld1M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5iGld1M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2DEC2BC86;
	Fri,  6 Mar 2026 16:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772814515;
	bh=205rfIeun8AwJY38haTQgbjnsy/DlyRTaLsXQffpNHE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=a5iGld1M6hGqiZ8SR4yq2NziFDbhCxtlVHcMYW0Ue7kFQ3GM4UArem1NDdR9bLUA5
	 IChadfebU2WtaNregf8eTSVdAnWL+cG2ZJXe9JKGKbkViP1g5ZwgIaQC0WzB3ZnhYU
	 XkehYFYN/ypXA3WtS5lhoGO8FXRD8wgExVH0eXGRDR0lV0RY0qxs1IqkDwba8kglUp
	 64obhyAhGYsMPkHf/h2jbjQFKHev8Tdtn8z3lBmLHj5zFHbFnQvvVybgfj9/ASsD/Q
	 cnLHxXyck4VvsSPum30opewQYiq9s3vXr2C/kwN/nVTNXgVv+eM94ygpie92PJOgrX
	 7l4EcjqXESFaA==
From: Thomas Gleixner <tglx@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, Stefan Hajnoczi
 <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, Netdev
 <netdev@vger.kernel.org>, rcu@vger.kernel.org, MPTCP Linux
 <mptcp@lists.linux.dev>, Linux Kernel <linux-kernel@vger.kernel.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 "luto@kernel.org" <luto@kernel.org>, Michal =?utf-8?Q?Koutn=C3=BD?=
 <MKoutny@suse.com>,
 Waiman Long <longman@redhat.com>
Subject: Re: Stalls when starting a VSOCK listening socket: soft lockups,
 RCU stalls, timeout
In-Reply-To: <babe39d9-aeb4-47ae-83fb-eae6193fb3aa@kernel.org>
References: <b24ffcb3-09d5-4e48-9070-0b69bc654281@kernel.org>
 <7f3e74d7-67dc-48d7-99d2-0b87f671651b@kernel.org>
 <863a5291-a636-47d0-891c-bb0524d2e134@kernel.org>
 <20260302114636.GL606826@noisy.programming.kicks-ass.net>
 <717310d8-6274-4b7f-8a19-561c45f5f565@kernel.org>
 <a2b573b4-af61-4b84-a7d1-012ed6bb23c9@kernel.org>
 <ba067933-bf3b-476d-a0bb-53eda56996ca@kernel.org> <87zf4m2qvo.ffs@tglx>
 <47cba228-bba7-4e58-a69d-ea41f8de6602@kernel.org> <87tsuu2i59.ffs@tglx>
 <7efde2b5-3b72-4858-9db0-22493d446301@kernel.org> <87qzpx2sck.ffs@tglx>
 <babe39d9-aeb4-47ae-83fb-eae6193fb3aa@kernel.org>
Date: Fri, 06 Mar 2026 17:28:31 +0100
Message-ID: <87o6l03osw.ffs@tglx>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Mar 06 2026 at 11:16, Jiri Slaby wrote:
> On 06. 03. 26, 10:57, Thomas Gleixner wrote:
>
> If that helps, I would be likely able to "bisect" the 4 your mm_cid 
> patches if they can be reverted on the top of 6.19 easily. (By letting 
> the kernel run in the build service.)

That would just introduce the other bugs again. Let me try to reproduce.


