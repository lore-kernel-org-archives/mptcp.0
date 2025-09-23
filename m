Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A99C14B977
	for <mptcp@lists.linux.dev>; Tue, 23 Sep 2025 09:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758621325; cv=none; b=TvSKiRCHh1UwjDr2YHHux/zYyJm76F5w5oofn6Wuopsdi81MIhHVzWqT84NtQyS18bVcenq0KQr0tYUBJW5rGE167Cv2yNV7VA6l7pKU7rNrJQ+wEvaOKZWLmdxdnq0edw4pUmVOfrVfRunM31lKUZXwRl5XPOMoek4Zps4dpL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758621325; c=relaxed/simple;
	bh=zg/wyq+tgR0KD1JudrTZSXPHUBQ8uEw2zPhxBHZlMbY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HH/xIhv09rUEza6XRBotUEYc57nWS84qkobkomNR+n+r4cPNfONOSqU/YmfrTer8uP0bvtsSDCZz9Xwu3KjTq2RkNo7w9VFT0oUmomvcyuC3VkD2TwaVvH8BPR5HA4zsCozdbDS2afe3w4FX+j/DJDsjGozLdQp4V5k4ycZrUkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0pSa9iI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0pSa9iI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EADC4CEF7;
	Tue, 23 Sep 2025 09:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758621325;
	bh=zg/wyq+tgR0KD1JudrTZSXPHUBQ8uEw2zPhxBHZlMbY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Z0pSa9iIbAYSEX2e5UxfTbxvgCqXIG7mzMdhMEsicXuA01Iu+I/jQYaZt2buFe+/D
	 dC109yWqiv0C7Qz/+fwzBfs6fifyYuFqsDsUziBUKQpOKmJzSXddeO5bc/KPIGgy0I
	 yjeDhm8zVjbaSk8INZiclXrIWCn81/HG+1nS6zI3Q1hsdc+JR5wgpvRY8vr3FhmZFI
	 GxirYH+2sYLVsANsUX0o6qO8vYGYnS29B8AToHwIrDKh2PGD8a/7izMOt/HHUN99Vt
	 BXKzEQv27ykca9AjxKKYtMqVnIg/o3bK+dn26ZOSdknYWfgKEfw6MpuQMLR8YFSBH2
	 3pxxvaY2XndZg==
Message-ID: <2baf027907da32f096cb522691e5d92c454000e4.camel@kernel.org>
Subject: Re: Add Multipath TCP (MPTCP) Support to the Java Networking API
From: Geliang Tang <geliang@kernel.org>
To: Alan Bateman <alan.bateman@oracle.com>, net-dev@openjdk.org, 
 "nio-dev@openjdk.org"
	 <nio-dev@openjdk.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, 	mptcp@lists.linux.dev, Gang Yan
 <yangang@kylinos.cn>, Xiang Gao	 <gaoxiang@kylinos.cn>,
 core-libs-dev@openjdk.org
Date: Tue, 23 Sep 2025 17:55:15 +0800
In-Reply-To: <2b699d6c-d05b-4445-9448-99348eebdf4a@oracle.com>
References: <da3912a3e0b03974305513219621856d33f82219.camel@kernel.org>
	 <7403952e-14c1-4ba2-871e-0e2174fd5167@oracle.com>
	 <c01f7f30efd2f9fb3185f9ad82579eca8a613ac3.camel@kernel.org>
	 <717920eaaa9d4d0da181d84dd11334dae2568f34.camel@kernel.org>
	 <2b699d6c-d05b-4445-9448-99348eebdf4a@oracle.com>
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

Thanks for your reply.

On Thu, 2025-09-18 at 12:30 +0100, Alan Bateman wrote:
>  
> On 18/09/2025 08:36, Geliang Tang wrote:
>  
> >  
> > I have completed the implementation. Thanks to Xiang Gao and Gang
> > Yan
> > for their help. I added a new option named TCP_MPTCPIFY in
> > jdk.net.ExtendedSocketOptions (the name was chosen to align with
> > 'mptcpize' tool in mptcpd and 'mptcpify' in BCC). When this option
> > is
> > set, it calls the JNI function mptcpify0.
> > 
> > Following your suggestion, mptcpify0 is implemented by referencing
> > Java_sun_net_sdp_SdpSupport_convert0. It creates a new MPTCP
> > socket,
> > uses dup2 to duplicate it, and then closes the redundant socket.
> > 
> > I have added your tag in the patch:
> > 
> > Suggested-by: Alan Bateman <alan.bateman@oracle.com>
> > 
> > I also included a test example for this option. All modifications
> > can
> > be found here:
> > 
> > https://github.com/openjdk/jdk/compare/master...geliangtang:jdk:master
> > 
> > Please provide any feedback or suggestions. As for the next steps,
> > should I create a new issue for this feature and submit a proper
> > pull
> > request?
> >  
>  
>  Thanks for confirming that the direction suggested works. This at
> least demonstrates a feasible direction that does not impact the
> standard API.
>  
>  As regards next steps then I think start a thread on net-dev to try
> to get input. I think it would be useful to show potential scenarios
> where it would be useful and what performance benefits might come
> from it. I think also useful to talk about whether this is something
> that an application has to opt into, maybe there are other
> configuration approaches that would not require application changes?
>  
>  I think it would be useful to discuss testing. If this feature were
> integrated into the JDK then how would it be tested? Who would test
> and maintain it? There is a JDK release every 6 months, is someone
> going test it with each release?
>  
>  If it goes ahead then there the name of the extended socket option
> and its API docs will need discussion. Details around state will need
> to be specified, would it be supported to set TCP_MPTCP when bound or
> connected, does it make sense to ever attempt to set it to false
> after setting it to true (these are just examples of the details that
> will need to be specified, they are not important right now).

Following your suggestion, I have started a new thread on net-dev:

Add Extended MPTCP (Multipath TCP) Socket Option Support to OpenJDK
https://mail.openjdk.org/pipermail/net-dev/2025-September/028085.html

Thanks,
-Geliang

>  
>  -Alan.
>  
>  
