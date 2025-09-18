Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951612EA494
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 07:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758181025; cv=none; b=p995uPltmLTyhQNxhYoL//R/zNqbUfCCG8jbL22XnCvStU3yUpA4BhHiyeqJIME/pFUXAykQwlW1ePa/xE1wKem+0XGK/Ytfdx41Es6dVGZs9C8RMd7zVU2bvUqlaMIvAYKg3kPxt2fbT9ns3yhgYq78AEkXFEOb5RL5X7seUwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758181025; c=relaxed/simple;
	bh=9Ho4P42EGhvYhFEdUEyI88E9SAoONBBfgOPND3eHMvo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e6nfDfIFvkOwbxscEby4D2eIb8xAdzJg09wF3onfCakrMtFuKvfZbnCHoJlKAdR236Nb8GNnGsmaFIpueLWcZWAJth2zXuJ96Fs3ppnLxJ0aDd2dE9pe74ZhuX1L+Dq9oK4Hg74AW0+zrhNNaJTZR0HERD/6vlWfb4VOKTj69a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tngvvhvX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tngvvhvX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E594C4CEE7;
	Thu, 18 Sep 2025 07:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758181025;
	bh=9Ho4P42EGhvYhFEdUEyI88E9SAoONBBfgOPND3eHMvo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=tngvvhvXCkfnjR62T+RWB02QA9gd0beiXWP/UEFTYKZuDw9Qjfwlus7R+mrcVHBnw
	 NVeLc4OlU0I8A8PFwTI/eAN5wfQlLveTpJhF8xYo8+8IHKq3Lzoe7gyoSlokNGOjzB
	 bqIWfMni+obHQQLYMC6RspQ4i6YP/nefKRqyz3Bv5ki22on7LcJkKCcBS8BW+nS6O/
	 A6lXI0fIDWO6O7Gf6BawEKkSreL4XZRQTtoSgnKUMSOBS0ceW6Bu0uzmpyBccqA6LA
	 D7bsW+JAeiiuKZrRUK9Bik/iLlwD5DCdeHkh3/T0607tWlWNgNVfqoOKYL2PLc9nZq
	 zun1cKpTP8svg==
Message-ID: <717920eaaa9d4d0da181d84dd11334dae2568f34.camel@kernel.org>
Subject: Re: Add Multipath TCP (MPTCP) Support to the Java Networking API
From: Geliang Tang <geliang@kernel.org>
To: Alan Bateman <alan.bateman@oracle.com>, net-dev@openjdk.org, 
 "nio-dev@openjdk.org"
	 <nio-dev@openjdk.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, 	mptcp@lists.linux.dev, Gang Yan
 <yangang@kylinos.cn>, Xiang Gao	 <gaoxiang@kylinos.cn>,
 core-libs-dev@openjdk.org
Date: Thu, 18 Sep 2025 15:36:58 +0800
In-Reply-To: <c01f7f30efd2f9fb3185f9ad82579eca8a613ac3.camel@kernel.org>
References: <da3912a3e0b03974305513219621856d33f82219.camel@kernel.org>
			 <7403952e-14c1-4ba2-871e-0e2174fd5167@oracle.com>
	 <c01f7f30efd2f9fb3185f9ad82579eca8a613ac3.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Alan,

On Fri, 2025-09-05 at 18:11 +0800, Geliang Tang wrote:
> Hi Alan,
> 
> Thanks for your reply.
> 
> On Fri, 2025-09-05 at 10:28 +0100, Alan Bateman wrote:
> >  
> > On 05/09/2025 09:43, Geliang Tang wrote:
> >  
> >  
> > >  
> > > :
> > > 
> > > 3. Proposed Java API Changes
> > > 
> > > The goal is to allow Java applications to opt-in to using MPTCP
> > > when
> > > creating sockets, without breaking existing code. The proposed
> > > changes
> > > are additive and backward-compatible.
> > > 
> > > The core idea is to add a boolean mptcp parameter through the API
> > > layers, from the public Socket class down to the native system
> > > call.
> > >  
> >  
> >  (moving the discussion to nio-dev and net-dev).
> >  
> >  Adding new constructors to legacy Socket/ServerSocket may work for
> > your initial prototype but would be problematic to propose as it
> > would bake non-standard features into the standard API. Also many
> > high performance servers use SocketChannel rather than Socket.
> >  
> >  One suggestion for a next prototype is to model the enablement of
> > MultiPath TCP as as a JDK-specific socket option (see
> > jdk.net.ExtendingSocketOptions). All of the standard APIs for
> > networking sockets define a setOption method for setting socket
> 
> I was initially concerned that calling setOption() after Socket()
> creation to convert TCP to MPTCP was too late. Creating an MPTCP
> socket
> must be done during the socket() system call.
> 
> > options. If modeled as a socket option then enabling can create a
> > new
> > AF_INET6/SOCK_STREAM/IPPROTO_MPTCP socket and then dup2 it into
> > place
> 
> Until I saw here, it should be feasible if the socket can be created
> again and dup when calling setOption().
> 
> I will try to reimplement MPTCP support using
> jdk.net.ExtendingSocketOptions soon and give you feedback.

I have completed the implementation. Thanks to Xiang Gao and Gang Yan
for their help. I added a new option named TCP_MPTCPIFY in
jdk.net.ExtendedSocketOptions (the name was chosen to align with
'mptcpize' tool in mptcpd and 'mptcpify' in BCC). When this option is
set, it calls the JNI function mptcpify0.

Following your suggestion, mptcpify0 is implemented by referencing
Java_sun_net_sdp_SdpSupport_convert0. It creates a new MPTCP socket,
uses dup2 to duplicate it, and then closes the redundant socket.

I have added your tag in the patch:

Suggested-by: Alan Bateman <alan.bateman@oracle.com>

I also included a test example for this option. All modifications can
be found here:

https://github.com/openjdk/jdk/compare/master...geliangtang:jdk:master

Please provide any feedback or suggestions. As for the next steps,
should I create a new issue for this feature and submit a proper pull
request?

Thanks,
-Geliang

> 
> Thanks,
> -Geliang
> 
> > so that the original AF_INET6/SOCK_STREAM/0 socket is closed.
> > Enabling can be made to fail if the socket is already bound. It
> > could
> > copy over existing socket options if needed. Look at the built-in
> > (and no longer used) SDP support for an example that does similar
> > with AF_INET_SDP/SOCK_STREAM/0. The only API surface would be a
> > socket option defined in jdk.net.ExtendingSocketOptions.
> >  
> >  -Alan
> >  
> >  
