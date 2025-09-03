Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518AB6D1A7
	for <mptcp@lists.linux.dev>; Wed,  3 Sep 2025 06:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756880174; cv=none; b=XH3Yb9IIP+3rkYZyh8vtoSz5Iu1paRh1TqYaq9UxyGevFAio7d2ouloNLAIkYZjUPaZ7INogO2yeXDDMALXPJE2mu3Mf6v6LFzByV5NqCW/OnXm6qoFCS/7s4XTaKPlPXfdjvnxuAI5rfTZouVmA1rr5K07/b3jfKscr5XofU44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756880174; c=relaxed/simple;
	bh=1qVb6w4r1/tzVwEhaarVaB5FmueAupL9Ft7OLoE5KOY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bze3hXCNyoDYGVDPW0Z5VKvrgPA6/h6aFLSbwYLdU40ontMwWDdMJiDI+NQ4B5aq9f+gsw0PTxXfNGQ9xvp1Pc44qNFAwf9i9hk4Ayf2pU8BNs+EMdeaFKCQT+clDBO3xU4oLn6U6BveaI8MJ3CU0qPiZuXBHGAzu6tWIiSZmAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLVyxdE2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLVyxdE2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25165C4CEF0;
	Wed,  3 Sep 2025 06:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756880172;
	bh=1qVb6w4r1/tzVwEhaarVaB5FmueAupL9Ft7OLoE5KOY=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=HLVyxdE28Dot9vC+C1JBncPK4zYQ+YYSEL3EmaIzR91MK4RQcqC73xA08hCPeTicx
	 GRGWyJhwuBMt5uN+CwiIX57wZtsmUJNwfnSLxvJidPfzUfAfctsZIJQYayEk7fUfkj
	 x9C7lKvs/MFxye2YYkClTWBvnrRYZC4HB7hVbDnN80Jq1GTfEbT0/Y/MV+fV9b2C65
	 LEZObmG6kMzANrIlWQyPJnjubJGs8HeEJe88Fkb4pmLj47dpqfr4AO3aBMZQwSy1+b
	 7t/GaDKtceC8L7AvhynchrkAYQQovFqmYrPQlirX/nNl3Tg6hBAcpfFvRtnOpA1bDi
	 4iVnV6/eLkVgA==
Message-ID: <2dc597d59d3aff65b2955f5accf0a14e2c788cf5.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 0/3] Add MPTCP support to Java Networking
 API
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Wed, 03 Sep 2025 14:16:09 +0800
In-Reply-To: <3a401acb-bcc6-4885-a1a4-7aa88ed55cb5@kernel.org>
References: <cover.1756369940.git.tanggeliang@kylinos.cn>
	 <3a401acb-bcc6-4885-a1a4-7aa88ed55cb5@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Thu, 2025-08-28 at 11:57 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 28/08/2025 10:47, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > v2:
> >  - drop redundant helpers as Matt suggested.
> >  - squash into fewer patches.
> >  - use "JNI_TRUE" and "(void)mptcp" in Java_sun_nio_ch_Net_socket0
> > as
> >    Xiang Gao suggested.
> > 
> > The Multipath TCP (MPTCP) protocol (v1 / RFC 8684) has been added
> > in
> > the upstream Linux kernel since v5.6. See https://mptcp.dev.
> > 
> > This patch series introduces comprehensive Multipath TCP (MPTCP)
> > support to the Java Networking API, enabling applications to
> > leverage
> > MPTCP's capabilities for improved reliability and throughput.
> 
> Thank you for the new version! Feel free to start the process to
> upstream these patches [1]. Don't hesitate to share here the link to
> the
> new ticket.
> 
> [1] https://openjdk.org/guide/#i-have-a-patch-what-do-i-do
> 

I followed the instructions and "Signed the OCA" on August 1st, but it
is still in the "Under Review" status.

For the second step, "Socialize your change", I would like to send the
following letter to net-dev@openjdk.org:

'''
Hi OpenJDK maintainers,

I hope this message finds you well. The purpose of this letter is to
propose the integration of Multipath TCP (MPTCP) support into OpenJDK.
We have developed a set of patches to enable this functionality and are
eager to submit it for upstream inclusion. We would greatly appreciate
your feedback and opinions on this contribution.

1. Introduction

Multipath TCP (MPTCP), as standardized in RFC 8684, is a major
evolution of the TCP protocol. It enables a transport connection to use
multiple network paths simultaneously for redundancy, resilience, and
bandwidth aggregation. Since its introduction in Linux kernel v5.6, it
has become a key technology for modern networking, particularly on
mobile devices with multiple interfaces (e.g., Wi-Fi and cellular).

Key benefits include:

    Bandwidth Aggregation: Combine the bandwidth of multiple network
links.

    Seamless Handover: Maintain connections when switching networks
without dropping the session.

    Improved Resilience: Traffic is automatically rerouted if one path
fails.

For more details, see the project website: https://mptcp.dev.

2. Technical Background

On a supporting system like Linux, an MPTCP socket is created by
specifying the IPPROTO_MPTCP protocol in the socket() system call:

    int fd = socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP);

This creates a socket that looks like a standard TCP socket to the
application but uses the MPTCP protocol stack underneath.

3. Proposed Java API Changes

The goal is to allow Java applications to opt-in to using MPTCP when
creating sockets, without breaking existing code. The proposed changes
are additive and backward-compatible.

The core idea is to add a boolean mptcp parameter through the API
layers, from the public Socket class down to the native system call.

4. Implementation Plan

The implementation involves changes across four layers of the JDK:

JNI Layer (sun.nio.ch.Net):

Modify Java_sun_nio_ch_Net_socket0 to accept a new jboolean mptcp
parameter.

    The native implementation will be updated to use this parameter:

    int protocol = mptcp == JNI_TRUE ? IPPROTO_MPTCP : 0;
    fd = socket(domain, type, protocol);

NIO Layer (sun.nio.ch):

    Add the mptcp parameter to the Net.socket() and Net.serverSocket()
methods.

    Propagate the parameter down to the JNI call.

Socket Implementation Layer (java.net):

    Add the mptcp parameter to the constructor of NioSocketImpl.

    Within NioSocketImpl, pass the parameter to the Net.socket() or
Net.serverSocket() calls.

Public API Layer (java.net.Socket & java.net.ServerSocket):

    Add new constructors that accept the mptcp parameter.

    Example:

        // Proposed new constructor
        public Socket(String host, int port, boolean stream, boolean
mptcp) throws IOException {
            // ... implementation that passes 'mptcp' to NioSocketImpl
        }

5. Full Implementation

The complete working implementation for this proposal is available for
review:

https://github.com/openjdk/jdk/compare/master...geliangtang:jdk:master

We look forward to your valuable feedback and suggestions on this
proposal.

Best regards,
The MPTCP Upstream Developers
'''

Please review this letter for me.

Thanks,
-Geliang

> Cheers,
> Matt
