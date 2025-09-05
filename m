Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C26145329
	for <mptcp@lists.linux.dev>; Fri,  5 Sep 2025 01:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757036603; cv=none; b=kZWCo3QWuQL6ivr5nLHG3+HAp7S+t9vF1F9oogbkaT4UWC939bLIDLiVrCMSDreCRZoZr7urd1heKe4msuMp6iwJ/Bcgh8EtrDUmUuW+KOGPXWHVa9qFj6zXjkmAEdG1HMKf0Ggrq6Nc5+rj7u1BoIdc0pASJ3/3MHmQ6zqUZ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757036603; c=relaxed/simple;
	bh=8z/kL+/T44wX/bc+XRMNtUZW9pgO8KtBSzB35boJqS8=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=R1SpJgnI64NbblI/NGGF74UPSLGa72EI8OFitzb01ocmkKsQxyJ2TeLtOrWVYQIPzu3KLz8VS5B3daGgFDYlXkX02Q3Ef3AvujGMNyZj6wjzXxu3wc/QNsUfc2w7Yi/TOMhyA10MzHjrpA8DhxZGPOYwhUKQSsJg4+gOn+BDuc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCF7+3HR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCF7+3HR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C6BC4CEF0;
	Fri,  5 Sep 2025 01:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757036602;
	bh=8z/kL+/T44wX/bc+XRMNtUZW9pgO8KtBSzB35boJqS8=;
	h=Subject:From:To:Cc:Date:From;
	b=QCF7+3HR4pOcgmlsNM+S06mQb55Lxx94LTaKGjh3I7R9FdwExveaPOpBJvPe6JhIF
	 kdikOGr4FO+nbehnVCC7wtP3aA11meOpC+5mUm9NFTyaU4TxBkNQgdXccSMgiK8zUA
	 ZLe9ONirsyAC2cAv91//+jsUmTWnCfiA2sdiDsXacbLT/wTE+UN5ZpjSEQC/jXowFK
	 a3kodm/d3+v42mCZWNMxff290FfoigSnXCoPUqqDqdtSd9JbwJxMGyss2X/4vMiA8L
	 hDLse0P50D9Vki/KltzT0qHVwY8bzcCjg4OzGukSsIOn8+cIBB8GwuUE3ZSat7+AiV
	 Ta/apQ7XKtHpA==
Message-ID: <00cc9a4fa008cd346c8c12a044d5c41b5af58a6f.camel@kernel.org>
Subject: Add Multipath TCP (MPTCP) Support to the Java Networking API
From: Geliang Tang <geliang@kernel.org>
To: net-dev@openjdk.org, core-libs-dev@openjdk.org
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, 	mptcp@lists.linux.dev, Gang Yan
 <yangang@kylinos.cn>, Xiang Gao	 <gaoxiang@kylinos.cn>
Date: Fri, 05 Sep 2025 09:43:16 +0800
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

we can create a new issue for this feature, and submit a proper pull
request after if that's OK for you. We didn't do that yet because we
noticed that it is recommended to send more explanations to this list
first.

Best regards,
MPTCP Upstream Developers
