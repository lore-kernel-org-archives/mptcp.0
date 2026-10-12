Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90B932570D
	for <mptcp@lists.linux.dev>; Mon, 12 Oct 2026 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811732; cv=none; b=r2hfHAWtkMmePxk0aaWlCP/HqFwDzhFPomyUCTUBYHzFhtP9y3/BImgyCHLXYDbDnOi1BM1mruFrIAw4xCFMdmVer3IiFPUczS7rgDIiYwa+7iDICBAySZ52dYV6D7Ibkn4182gm5X52LTApN8A1KHXfF601IkjfV/GVdakbRvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811732; c=relaxed/simple;
	bh=+IR7rUBKXwZcd8Lj3UMr+KmJXKrL5fJwUDv9YtZBe38=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=SVAzb9p0R+cBoqm1wAk0Rx94R31aM6YyODAUfBI7wyBbbtrlXNOP/QwgxNKeo5QIt/CfbggnHCdxVNCs+ID5iG5o/C4iBCJK/R2TFhR4AlmD5WDX/Ez3JQEoSJGYQzU+068krXnCFG4soeCw7087WfE620296ztE0dNWItewV0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fv8/ErW2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fv8/ErW2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D771F0089B;
	Mon, 12 Oct 2026 13:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791811731;
	bh=QYAY+zkeNWacH9t661vnDnRJgy5aywGDi+e4lgDEUjo=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To;
	b=fv8/ErW2QAc0ZjQa4zpNFpAON4/rCC7FXxEmfM9IlsBnmEmEo45tydfJNAYa4HDcU
	 W6EFl0orTaj3Jhxi09RWMm5ktVBbXFWrFSBY2OkHBovNKVRDrqw5Y74Eja2Rz39i+2
	 3KjNcrTZCiDilcOX3Tf+m/F1bcuwyv+QDENisbYPAMJmvu3BJybXRZXDXMumLV4UKb
	 TWkKneoDTGmYZ8PDnjePrA21PnFnF0mvDionQCRTUOQarRZQS8b5QHB6CRj9whIn5q
	 hIwFaexv3Gl6Kbp7RJynLcZCByxbXe10ZHeTfRdng90An9O+sU1nCTNPiP86JanxGT
	 T2itYMn6XF/TA==
Message-ID: <b5d420d1-859a-4c84-a658-e7aa44abbb30@kernel.org>
Date: Mon, 12 Oct 2026 15:28:48 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v4] mptcp: push queued data on passive TFO subflows
 becoming established
Content-Language: fr
To: T S RAMESHKUMAR <rameshsv06@gmail.com>
References: <20261008121602.206507-1-rameshkumar.t@phytecembedded.in>
 <CADRhS2uk-P8TSmyiM=X5JQXHtzdm68vg6+vyBDr-UCf0EAu0HA@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Cc: Petar Sakic <petar.sakic@ink.fish>, mptcp@lists.linux.dev
In-Reply-To: <CADRhS2uk-P8TSmyiM=X5JQXHtzdm68vg6+vyBDr-UCf0EAu0HA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi T S,

+cc Petar.

On 12/10/2026 12:00, T S RAMESHKUMAR wrote:
> Hi Matt, Petar,
> 
> Thank you both!
> 
> I have prepared [PATCH mptcp-net v2] based on the export branch.
> In v2:
> - Reverted bitfield modifications: check_fully_established() is only
> called once upon receiving the MPC 3rd-ACK, so is_mptfo is read-only at
> that stage and safe from concurrency races.
> - Added "Suggested-by: Petar Sakic <petar.sakic@ink.fish>" and
> "Reported-by: Petar Sakic <petar.sakic@ink.fish>".
> - Kept the Fixes tag pointing to fb7084501a61 ("mptcp: add support for
> TCP_FASTOPEN sockopt") to ensure backports cover 6.8 and all stable trees.

Thank you. I will try to review this after the automated tests.

> Regarding Packetdrill:
> I have prepared the packetdrill test case (server-TCP_FASTOPEN-early-
> write.pkt) which simulates the server writing data in SYN_RECV before
> the 3rd ACK arrives and verifies that the 100 bytes are pushed
> immediately with DSS mapping once the 3rd ACK is received. All 51
> fastopen tests pass.
> 
> I can submit the packetdrill test via a PR on https://github.com/
> multipath-tcp/packetdrill <https://github.com/multipath-tcp/
> packetdrill>, or send it directly to the list if preferred. Here is the
> test script for reference:

Please open a new PR.

> --- server-TCP_FASTOPEN-early-write.pkt ---
> // SPDX-License-Identifier: GPL-2.0
> // Test MPTCP passive Fast Open early write before 3rd ACK arrives
> --tolerance_usecs=100000
> `../common/defaults.sh`
> 
>  0.0    socket(..., SOCK_STREAM, IPPROTO_MPTCP) = 3
> +0.0    setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
> +0.0    setsockopt(3, SOL_TCP, TCP_FASTOPEN, [2], 4) = 0
> 
> +0.0    bind(3, ..., ...) = 0
> +0.0    listen(3, 1) = 0
> 
> // Client connects with TFO Cookie and 500 bytes of SYN data
> +0.1      <  S   0:500(500)                win 65535  <mss 1460, sackOK,
> TS val 100 ecr 0,   nop, wscale 8, FO TFO_COOKIE, nop, nop, mpcapable v1
> flags[flag_h] nokey>
> +0.0      >  S.  0:0(0)          ack 501              <mss 1460, sackOK,
> TS val 100 ecr 100, nop, wscale 8,                          mpcapable v1
> flags[flag_h] key[skey]>
> 
> // Server accepts while still in SYN_RECV and reads the SYN data
> +0.0    accept(3, ..., ...) = 4
> +0.0    read(4, ..., 500) = 500
> 
> // Server writes early reply data before receiving client's 3rd ACK
> +0.0    write(4, ..., 100) = 100
> 
> // Client's 3rd ACK arrives with no data, establishing the MPTCP connection
> +0.2      <   .  501:501(0)      ack 1     win 450    <                
>                                                              mpcapable
> v1 flags[flag_h] key[ckey, skey]>

Here, you are dropping TCP Timestamps (TS) negotiated before. Probably
better to keep it (or you don't inject it in he first SYN, clearer).

> // Server must immediately push the queued 100 bytes with DSS mapping
> +0.0      >  P.  1:101(100)      ack 501              <nop, nop, TS val
> 100 ecr 100, dss dack8=0 dsn8=1 ssn=1 dll=100 nocs>

"dack8=0"? That's strange...

Also, TCP options are not padded correctly to ensure TCP header is a
multiple of 4 bytes: 2 excess bytes → you are missing two "nop" at the end.

How did you test it?

 $ cd <Packetdrill DIR>/gtests/net
 $ run_all.py -lv mptcp/fastopen/server-TCP_FASTOPEN-early-write.pkt

Don't forget to add the "Assisted-by: LLM" tag if used, and mention what
you did, how you tested things. You can use this docker image to ease
the testing part:

  https://github.com/multipath-tcp/mptcp-upstream-virtme-docker

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

