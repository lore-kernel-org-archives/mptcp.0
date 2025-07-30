Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F3A1FDE3D
	for <mptcp@lists.linux.dev>; Wed, 30 Jul 2025 22:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753912995; cv=none; b=UiUz3wNRjjS/YPmrfaeuPltZMGpZKeJWNWW7/sGtz2VRg7UibKvUol5pNcQPpw1nNmYGaapwhdl9gj+fIpkH4ajiOpBXaxNJ8ay8moAanpZkVs90OQKCCTk4fhYwgxEkW/mymJg7qbblYyCRbZX9Dyi6epJHuEtN7mginuBkHmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753912995; c=relaxed/simple;
	bh=lh6LbdklXutDSs3CoB0UBPAzdbvw2lJNXhqa///Mfkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=X9BxERAC9ZtZcE2JbNtu9Y3WXDK88tHEhoNs1zzpyDIN1loI7Urhyndi8fevSOmvLdZO92bk42rw6PgvmnjxvhwncWUG0SlI1v5jpqjb1SFqfO8NpHeOlxeZbZE/yAMXJeV4xug7g1qQzd3JEOkS1S6cP5xcxmGMtc7SghAsehk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4Rz9P+C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4Rz9P+C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F11FC4CEE3;
	Wed, 30 Jul 2025 22:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753912994;
	bh=lh6LbdklXutDSs3CoB0UBPAzdbvw2lJNXhqa///Mfkk=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=f4Rz9P+CVLD8PC2rreV5ngh8+t005vwp1EMJqWk1xVFdDhl0y9cP59FEuV+WQ4+kJ
	 aTwEey68+k99Q8Xe+O/afgxg0p6thx0opPZNHY3tDDWVNsQNYXzne1kfc2QtTO4wtO
	 phTCIh7agfKqKKTnu01L3fMW69xKkTCNn4hvs5PxrQEcipKrH+BRGrJ8Ek1o3fKsIK
	 z8YlqP11dO7FtNdKWaL/yZItEnSgRGit06J7h2nG4iXQHz3VcApRWBod2IrsgVyKtJ
	 JPFtzx+AN7bpbzxTBgdwWFicvOLtCNz80i2916eE/48O2igNIrQ5Xxcj6XoLkYOa86
	 5wj//HxWNiHww==
Message-ID: <0e6a7026-e1cf-43b1-9ed3-829abe78a69b@kernel.org>
Date: Thu, 31 Jul 2025 00:03:11 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 0/7] Add MPTCP support to Java Networking API
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <cover.1753247666.git.geliang@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <cover.1753247666.git.geliang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 23/07/2025 07:16, Geliang Tang wrote:
> The Multipath TCP (MPTCP) protocol (v1 / RFC 8684) has been added in
> the upstream Linux kernel since v5.6.
> 
> This patch series introduces comprehensive Multipath TCP (MPTCP) support
> to the Java Networking API, enabling applications to leverage MPTCP's
> capabilities for improved reliability and throughput.

Thank you for having looked at that.

> The implementation provides:
> 1. Core infrastructure for MPTCP socket creation (Patch 1)
> 2. Server and client socket creation APIs (Patches 2-3)
> 3. Integration with NIO socket implementation (Patch 4)
> 4. High-level Socket and ServerSocket support (Patches 5-6)
> 5. Comprehensive test cases (Patch 7)
> 
> Key features:
> - Backward compatible API extensions
> - Platform-independent implementation
> - Explicit MPTCP enablement through new constructors
> - Full integration with existing socket functionality
> - Test coverage for basic MPTCP operations
> 
> The changes maintain all existing functionality while adding MPTCP
> capabilities. When MPTCP is not enabled or not supported by the system, the
> implementation gracefully falls back to regular TCP behavior.

I don't think it is the case: if the system doesn't support it, an error
will be returned.

If the other host doesn't support it or didn't request it, a fallback
will be done.

Also, don't hesitate to share a link to https://mptcp.dev to help
reviewers understanding what MPTCP is.

> This work enables Java applications to benefit from MPTCP's capabilities:
> - Seamless handover between network interfaces
> - Aggregated bandwidth from multiple paths
> - Improved resilience to network failures
> 
> The implementation has been tested on Linux systems with MPTCP kernel
> support enabled.
> 
> https://github.com/openjdk/jdk
I have a few comments, but I don't know the project, and I didn't code
in Java for a while. Then, feel free to send this version or an updated
one to the Java Net maintainers (not sure how, but I'm sure you will
figure out :) ). Do not hesitate to share the link here.

> Geliang Tang (7):
>   Add MPTCP support for socket creation
>   Add MPTCP server socket creation support
>   Add MPTCP client socket creation support
>   Add MPTCP support to NioSocketImpl
>   Add MPTCP support to ServerSocket class
>   Add MPTCP support to Socket class
>   Add test cases for MPTCP socket functionality
> 
>  .../share/classes/java/net/ServerSocket.java  | 66 ++++++++++++++
>  .../share/classes/java/net/Socket.java        | 88 +++++++++++++++++++
>  .../share/classes/java/net/SocketImpl.java    |  8 ++
>  .../share/classes/sun/nio/ch/Net.java         | 26 +++++-
>  .../classes/sun/nio/ch/NioSocketImpl.java     | 19 +++-
>  src/java.base/unix/native/libnio/ch/Net.c     |  5 +-
>  src/java.base/windows/native/libnio/ch/Net.c  |  2 +-
>  .../java/net/ServerSocket/MPTCPServer.java    | 58 ++++++++++++
>  test/jdk/java/net/Socket/MPTCPClient.java     | 62 +++++++++++++
>  9 files changed, 326 insertions(+), 8 deletions(-)
>  create mode 100644 test/jdk/java/net/ServerSocket/MPTCPServer.java
>  create mode 100644 test/jdk/java/net/Socket/MPTCPClient.java
> 

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

