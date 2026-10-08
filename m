Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B4B44D020;
	Thu,  8 Oct 2026 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791459090; cv=none; b=bKsR3AucxrKmxZdCyM7fvvDrWjJRU7q7R2Ra4bubM8IR1rl1Ksti9uc2OK4H6mZhW2reKbXo+OY/LrjthfpOZNN2qQW4whCImJXacocvytppPIVv5mtFyPJnHjWkMLY6LJGw/fuxASqP5mQjKddt3AHeWFBGNRb9BfHszzfaTWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791459090; c=relaxed/simple;
	bh=P8ezITXazWqTIAcIFJx3dKlTxsw0wda7JhywNH4aDps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IuVBPL7PnXlkRIFGq/NHq7J2CSVwEOPzZ4ElEw1LfgpwNyKsmwXBCyau4Tlhy5DAfKcDWvKqtMghuxw+8fy6aVy5OWsNfu9uef0MFUqatBKnoL0AxJqxsuhBduNlkeXho07h6WEXATFMh5Z2WL4/Iv3tc0gatdava4dlJcaD8f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkHFUsMm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkHFUsMm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416C41F00893;
	Thu,  8 Oct 2026 11:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791459088;
	bh=LFgt5G4BJjDVzGv1I9MmD6H+ginunoO913AWMusdSyw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gkHFUsMm7IPsucZ9BdVS8SwLOoDbhdUEUrAH35KSaRrfMwnve9uNEMPnTAm+Fm+xP
	 lbUUZjjZN0ybG5m3sPWAwdfazst69IjIMiJSmCYYxk+54XBlC8wr5ABqr0SjPsuCoB
	 iDcghg6p2NdXZ/+76DkSe4vPnt25fGsQTOlu9vRiMC1kRj76VBSbVSOFa7qgNWv2qC
	 uf41DgJ6JoKA4Gckojh7kb9tqVIf19TcfYdghud2u6JLbxbwahhoDJtU/m9FlRVxEM
	 TTaznSKDwOVnzsx95kmesyq3oAongng8ZJQuYmBbTr7DvXdX97WdEjGOZD2ebx8KeS
	 2mk2Y+ywI5++Q==
Message-ID: <bfd64e10-7f1e-41f6-ad12-12f06c4d2880@kernel.org>
Date: Thu, 8 Oct 2026 13:31:24 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] selftests: mptcp: sockopt: test passive Fast
 Open early write push
Content-Language: fr
To: T S Rameshkumar <rameshsv06@gmail.com>, martineau@kernel.org,
 geliang@kernel.org
Cc: mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 T S Rameshkumar <rameshkumar.t@phytecembedded.in>,
 Netdev <netdev@vger.kernel.org>
References: <20261008111003.136143-1-rameshkumar.t@phytecembedded.in>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261008111003.136143-1-rameshkumar.t@phytecembedded.in>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi T S,

On 08/10/2026 13:10, T S Rameshkumar wrote:
> Add automated test coverage for passive Fast Open early write data
> push in mptcp_sockopt.c and mptcp_sockopt.sh.

Please next time join the test with the fix, otherwise this patch alone
will not work.

Also, if you use 'mptcp*' prefix in the subject, please don't Cc the
netdev mailing list. (and remove it from any replies here)

> The server enables TCP_FASTOPEN on an MPTCP listening socket, accepts
> an incoming connection with SYN payload data, and immediately writes
> reply bytes before the 3-way handshake fully completes. The client
> connects with TCP_FASTOPEN_CONNECT, sends request data, and validates
> reception of the server's reply over both IPv4 and IPv6.

A more efficient way of validating that is to add a packetdrill test
instead of increasing the complexity of the "sockopt" test to validate a
connection issue.

Can you add your new test in the MPTCP fork [1], and validate it with:

  # cd gtests/net
  # ./packetdrill/run_all.py -lv mptcp/fastopen/<test>.pkt

[1] https://github.com/multipath-tcp/packetdrill/

> Signed-off-by: T S Rameshkumar <rameshkumar.t@phytecembedded.in>

If LLM is used, you need to add the Assisted-by tag:

  https://docs.kernel.org/process/coding-assistants.html

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

