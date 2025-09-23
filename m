Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971CE22ACEB
	for <mptcp@lists.linux.dev>; Tue, 23 Sep 2025 09:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620098; cv=none; b=MgUun6M9BkcXcy4XVxSPRRBTbSvN9H7eOXDk3RXuZ5j47QfDMoihuxOBVqzKKDywngrxqSpzJdbceKE9fwgAMJHI2AaHWt2H6h+c58TvC048ZbnSuCq4WoDpVsxtgQy3WmnUGtIGGYhvMnLcLme1X5TrhRq/9u+vABT3PlgGegk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620098; c=relaxed/simple;
	bh=yosSWK+Af1nfpDkyg5N9M1s4cLWOvCxQCvZ3+n2PC9s=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=jn45xmBwwDbD3hz/BLGLIq2S1YvANveFxqpxa2VMCJbFbUxlgXYoSLdbptxzxTxCjXC1iV86kjNCn7krRTZc7JRmTU9TwSJWS/wH0or0WSUN7mpT/HItuiAzZvLT4oB6kQle0IzpdIwRYak2EqWK39Y0Wsp8vKffYoq8guSjKK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnKCh8Go; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnKCh8Go"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE91C4CEF5;
	Tue, 23 Sep 2025 09:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758620098;
	bh=yosSWK+Af1nfpDkyg5N9M1s4cLWOvCxQCvZ3+n2PC9s=;
	h=Subject:From:To:Cc:Date:From;
	b=nnKCh8Gol2bUkpjIHw1JKjmpxbY+Z0opswDFfqMk814zsCFJnai/r/6fxNcb6Gi/v
	 bxlun9fTjHPvnWFYausReMiBVJE2W4tMqNztO2WfOHVYBzu3CGRISuO1VzxzqZlmYb
	 T5nKUOTmqW2aoi7cRe+ZvDq0OxM/EP6+G/8Q1cFyx3wl2XFFaq+LxRxF7zhHfKIcf9
	 O9jkUD98iOMyg7nKnFLfVWJgv/+S/e7wiScpChLzexSjUee4Uu8LZlz9TtxRSacxwL
	 VaZQKwOktRjpjSVvcOkKXcjGhv3hC4yFVWZySnyRlOCZ53NguU16DFXu6OtdUPD9Ph
	 FNVKyMcHFV+cQ==
Message-ID: <69f2513f5d13b65aeb3fd23c9fcc6dc410968466.camel@kernel.org>
Subject: Add Extended MPTCP (Multipath TCP) Socket Option Support to OpenJDK
From: Geliang Tang <geliang@kernel.org>
To: net-dev@openjdk.org, Alan Bateman <alan.bateman@oracle.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, 	mptcp@lists.linux.dev, Gang Yan
 <yangang@kylinos.cn>, Xiang Gao	 <gaoxiang@kylinos.cn>
Date: Tue, 23 Sep 2025 17:34:52 +0800
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear OpenJDK Maintainers,

We are writing to propose the integration of Multipath TCP (MPTCP)
support into OpenJDK. In response to Alan's feedback in earlier
discussions [1], we have developed a Java-based implementation that
utilizes the setOption method to enable MPTCP before binding or
connecting a socket, as illustrated below:

  Socket c = new Socket();
  c.setOption(ExtendedSocketOptions.TCP_MPTCPIFY, true);
  c.connect(new InetSocketAddress(loop.getHostAddress(), port));

The name 'TCP_MPTCPIFY' was chosen to align with 'mptcpize' tool in
mptcpd and 'mptcpify' in BCC. The complete implementation can be found
in [2].


This email outlines the technical background and aims to facilitate
further discussion on the proposed approach.


1. Use Cases and Performance Benefits

MPTCP extends standard TCP (as defined in RFC 8684) by allowing the use
of multiple paths simultaneously, offering significant advantages:

    Seamless handover: Maintain active connections during network
transitions (e.g., as implemented in Apple smartphones since 2013).

    Optimized path selection: Dynamically route traffic based on
latency, cost, bandwidth, and other metrics.

    Bandwidth aggregation: Combine links (e.g., Wi-Fi and cellular) to
increase total throughput.

Our immediate motivation for introducing MPTCP support in Java is to
enable MPTCP capabilities in valkey-java [3]. Valkey - a Redis-
compatible key-value database - officially incorporated MPTCP support
in its 9.0.0-rc1 release, which reduced latency by approximately 25%
under 1% packet loss conditions (see PR [4]).

While the Valkey server (written in C) uses MPTCP natively via the
socket() API, most Java clients (including valkey-java) currently lack
built-in MPTCP support. As multi-NIC systems become increasingly
common, providing Java applications with native MPTCP support is
essential for enhancing network performance and reliability.


2. Application Compatibility

A number of applications already support MPTCP natively, as documented
on https://www.mptcp.dev/apps.html, including Apache, FreeNginx, and
QEmu.

In response to Alan's earlier question regarding enabling MPTCP without
modifying applications: the MPTCP community does provide tools such as
mptcpize and BCC (mptcpify) to enable MPTCP at the socket level system-
wide - for example:

 $ mptcpize run java app.jar

However, this method lacks fine-grained control, which becomes
problematic when a Java application must use MPTCP and TCP
simultaneously - such as one that connects to both Valkey and MySQL.
Given this limitation, enabling MPTCP explicitly within the application
code remains the most practical and controlled approach, consistent
with early MPTCP adoption strategies.


3. Testing

We would also like to initiate a discussion on testing strategies and
API documentation for this feature. In [2], we have included a basic
MPTCP test. Should this MPTCP implementation be accepted into OpenJDK,
we are prepared to develop and maintain corresponding jtreg test cases
within the OpenJDK test framework to ensure interface stability. If
needed, we - the MPTCP upstream developers - commit to validating this
feature in each future OpenJDK release.


We welcome alternative ideas or suggestions on this topic and are open
to further discussion. Your feedback on this proposal is highly
appreciated.


Best regards,
MPTCP Upstream Developers

References
[1]
https://mail.openjdk.org/pipermail/net-dev/2025-September/027969.html
[2]
https://github.com/openjdk/jdk/compare/master...geliangtang:jdk:master
[3] https://github.com/valkey-io/valkey-java
[4] https://github.com/valkey-io/valkey/pull/1811


