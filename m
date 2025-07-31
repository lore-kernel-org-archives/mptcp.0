Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF67E55B
	for <mptcp@lists.linux.dev>; Thu, 31 Jul 2025 07:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753948157; cv=none; b=p24HX5ZGwkCEoKhtSGw2Kf5hUMfcxsNqWfrO6H2AQWu14AOzVQV25MqsWkW6QYzN8NuB7G7BhM2WgffBjDglNNIZ/81R+KUBJ+PGiTeAry1Sn+MwnOz4bJJNpRowep9wq2h2J6LpigCdOVhtZauLhhZGj8QnFJ08u5ZoaCxvXeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753948157; c=relaxed/simple;
	bh=q8JJEE2vuphFJnm1iDB/5dSdMW3dVIqLCYILHoojSTw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UIyWh9V7Us12uZsEJ1bw8wWl+GlnE0MR5dtPSLj1qYpUFmiWPbCiNuDaX2rJr7D58ShRMI0YGoPSfJdrt+MW+lcZPGdM1yYx1ECz5bZHHf0IIOy76qb3nSYeveqs0njkV8eRW28vtH6NTj8LQZlJOBk5ysc42WX9eWlMuKD/3TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmB57+9l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmB57+9l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE6CC4CEEF;
	Thu, 31 Jul 2025 07:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753948156;
	bh=q8JJEE2vuphFJnm1iDB/5dSdMW3dVIqLCYILHoojSTw=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=YmB57+9lxRMSaWXKqQSWcGyKm3GsYf1kieORkNhXfeKfgVEtX6Vvtcfm10ojcJXoV
	 zmOb2DGZeeyvPCSSYUsG6uyzTRvpI7UJZoFEsOycUjY4y1dsEPCSNPla1YfbYaL/Qr
	 EW3st31tS7X2hi/PzZMLuoz5sykMGWW+CxBSQ1ANBxUInHmvl6one2N1yCZ4taXw/K
	 mBwlScRcyUJoY9V4WmrpuQA7CLzxiitjLQhzQnzkjj30HyZLwcvtBWd16oG07HgAdX
	 agaJpuupJxtbq8Q6mryi02oixPe3sg30SdLDdid2AzRwU+fSsZczjuVBHb4ochNINm
	 tJVMVPCVNDqYg==
Message-ID: <411af696051518c1ef0a6a918626491a1fdc807d.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 0/7] Add MPTCP support to Java Networking API
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Thu, 31 Jul 2025 15:49:13 +0800
In-Reply-To: <0e6a7026-e1cf-43b1-9ed3-829abe78a69b@kernel.org>
References: <cover.1753247666.git.geliang@kernel.org>
	 <0e6a7026-e1cf-43b1-9ed3-829abe78a69b@kernel.org>
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

On Thu, 2025-07-31 at 00:03 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 23/07/2025 07:16, Geliang Tang wrote:
> > The Multipath TCP (MPTCP) protocol (v1 / RFC 8684) has been added
> > in
> > the upstream Linux kernel since v5.6.
> > 
> > This patch series introduces comprehensive Multipath TCP (MPTCP)
> > support
> > to the Java Networking API, enabling applications to leverage
> > MPTCP's
> > capabilities for improved reliability and throughput.
> 
> Thank you for having looked at that.
> 
> > The implementation provides:
> > 1. Core infrastructure for MPTCP socket creation (Patch 1)
> > 2. Server and client socket creation APIs (Patches 2-3)
> > 3. Integration with NIO socket implementation (Patch 4)
> > 4. High-level Socket and ServerSocket support (Patches 5-6)
> > 5. Comprehensive test cases (Patch 7)
> > 
> > Key features:
> > - Backward compatible API extensions
> > - Platform-independent implementation
> > - Explicit MPTCP enablement through new constructors
> > - Full integration with existing socket functionality
> > - Test coverage for basic MPTCP operations
> > 
> > The changes maintain all existing functionality while adding MPTCP
> > capabilities. When MPTCP is not enabled or not supported by the
> > system, the
> > implementation gracefully falls back to regular TCP behavior.
> 
> I don't think it is the case: if the system doesn't support it, an
> error
> will be returned.
> 
> If the other host doesn't support it or didn't request it, a fallback
> will be done.
> 
> Also, don't hesitate to share a link to https://mptcp.dev to help
> reviewers understanding what MPTCP is.
> 
> > This work enables Java applications to benefit from MPTCP's
> > capabilities:
> > - Seamless handover between network interfaces
> > - Aggregated bandwidth from multiple paths
> > - Improved resilience to network failures
> > 
> > The implementation has been tested on Linux systems with MPTCP
> > kernel
> > support enabled.
> > 
> > https://github.com/openjdk/jdk
> I have a few comments, but I don't know the project, and I didn't
> code
> in Java for a while. Then, feel free to send this version or an
> updated
> one to the Java Net maintainers (not sure how, but I'm sure you will
> figure out :) ). Do not hesitate to share the link here.

How about I submit a pull request to openjdk?

> 
> > Geliang Tang (7):
> >   Add MPTCP support for socket creation
> >   Add MPTCP server socket creation support
> >   Add MPTCP client socket creation support
> >   Add MPTCP support to NioSocketImpl
> >   Add MPTCP support to ServerSocket class
> >   Add MPTCP support to Socket class
> >   Add test cases for MPTCP socket functionality
> > 
> >  .../share/classes/java/net/ServerSocket.java  | 66 ++++++++++++++
> >  .../share/classes/java/net/Socket.java        | 88
> > +++++++++++++++++++
> >  .../share/classes/java/net/SocketImpl.java    |  8 ++
> >  .../share/classes/sun/nio/ch/Net.java         | 26 +++++-
> >  .../classes/sun/nio/ch/NioSocketImpl.java     | 19 +++-
> >  src/java.base/unix/native/libnio/ch/Net.c     |  5 +-
> >  src/java.base/windows/native/libnio/ch/Net.c  |  2 +-
> >  .../java/net/ServerSocket/MPTCPServer.java    | 58 ++++++++++++
> >  test/jdk/java/net/Socket/MPTCPClient.java     | 62 +++++++++++++
> >  9 files changed, 326 insertions(+), 8 deletions(-)
> >  create mode 100644 test/jdk/java/net/ServerSocket/MPTCPServer.java
> >  create mode 100644 test/jdk/java/net/Socket/MPTCPClient.java
> > 
> 
> Cheers,
> Matt
