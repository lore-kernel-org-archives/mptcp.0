Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4449727D781
	for <mptcp@lists.linux.dev>; Fri,  5 Sep 2025 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757061803; cv=none; b=Nc/h9EwzeYrBBBjmY27pX7W5rEDrJGV/vYSmetu5/nBHefJR54efS9xtqJz4JogqRRpt2UsobYoZQFj8s5gms/yN/DphwXsaSuMoG2Msm69v00jSMxuc5CYgKavGHf6chkjLks7pffaQjUgNd0P3QM4e/r/cwnsXwz72PkZoS9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757061803; c=relaxed/simple;
	bh=FbrPPWvnOjHB17/sBuSj5bV7mbhZ6qdLBv31yKDlkbI=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=K++Dq7XGSMrm5z5Q2ipgnH6cprqzcJvx7dptEy6l5/1h1SkbaVCjvJRZOA5I6CU5CD2xzMbLkeWdEXFYRE8jYlZeFbwVmPRGRMYUpSr8Q3QrQJ10HLKB07LEYULIbRLtmhcBeMmzYlo/DPFvWc0LPTLwlpbq+rCZbs5NQBEjvco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8iwnutV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8iwnutV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591DAC4CEF1;
	Fri,  5 Sep 2025 08:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757061801;
	bh=FbrPPWvnOjHB17/sBuSj5bV7mbhZ6qdLBv31yKDlkbI=;
	h=Subject:From:To:Cc:Date:From;
	b=X8iwnutVB9wdf7hTNeZbfgTfq1TlChzFUZoAs6CZtW2IWJeLUViU9DgbYDfoFyeXo
	 tO1eFIwBgv09PIpjJcVYDZ2RzR09jT9O2SZP9tN8wnEnN4f98uApBeC5fKOgqEVCo2
	 KeO6aj680hWz+N9NtVYNjhUeT0272ebmT43g58mprqg0olYlSqLrSFB4oNvdSbzArX
	 ilIjxWtiG3ccB2TJzHUYI0kJe56xDaZbcTMKGmk4l88VpQ1Kou3W2BeJ7Aeg5M99iM
	 WkzTp5cqCKDJvP2oRT/jj4D1g4cWme7cZe+h8V+1xjrL67YH4rkp0lWwNI0gV2sOt8
	 6kNdJLXWGGH3w==
Message-ID: <da3912a3e0b03974305513219621856d33f82219.camel@kernel.org>
Subject: Add Multipath TCP (MPTCP) Support to the Java Networking API
From: Geliang Tang <geliang@kernel.org>
To: net-dev@openjdk.org, core-libs-dev@openjdk.org
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, 	mptcp@lists.linux.dev, Gang Yan
 <yangang@kylinos.cn>, Xiang Gao	 <gaoxiang@kylinos.cn>
Date: Fri, 05 Sep 2025 16:43:16 +0800
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

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
specifying the IPPROTO_MPTCP protocol in the socket() system call
instead of IPPROTO_TCP (or 0):

    int fd = socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP);

This creates a socket that looks like a standard TCP socket to the
application but uses the MPTCP protocol stack underneath.

With the Java API, it is possible to create "stream" sockets, but it is
not possible to change the last argument, which blocks apps to ask to
use MPTCP.

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

We can create a new issue for this feature, and submit a proper pull
request after if that's OK for you. We didn't do that yet because we
noticed that it is recommended to send more explanations to this list
first.

Best regards,
MPTCP Upstream Developers
