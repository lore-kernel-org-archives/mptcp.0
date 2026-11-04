Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818232;
	b=ZEkDIJQEPajp+vJE2Ru4WRTchwRpIj73eJCxOlDYEv59Avp4KeYBg1tAR3Rj/ynsEXSU
	 mNByzLDiIhBRE+Z6/5g202NM54IzLvbqtizul7VOmFtI7b7odFM6Sabm/jZYS+xovOLmh
	 FwhZ3715BQQkAH/4oU3cGR1BSqw+cgAbMbg9KBPuuJ0nu5T78L5umMzI9O+inQ8I3/YAh
	 cOhInRzFoRT+q64RM6GHhJwkAbQ7cVLAShDPudPAMSUoPppkhabTooWQrBskGANQ4pjjT
	 lHE/KDjXyRL9xk0rVAFeRyymwTlG2OyEH5KHa/ThOlf6NLD/fOOOtkp+CzMk5stedpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818232;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=EwghIjCIbGs1NDrmAzR7dg2Zewz0hQEfosg9p/Jb5jA=;
	b=xHKoo1dYxWTxUJdXF+jnoneZHCs9Yk70LFL/ijs8ujn4szwmcRX8YM4VwX52SH/EGdzr
	 PCwCTFdE5lr+z1OQy7s5SonFKyXBjTWPPbCjHzlq5LwYCSFkYHg82u8gUP4oNIqpvq9rv
	 eUlg71traBtpNwpsnI7ZUV+7fe4/B3m21Y4XGCcDMh73n4go9PwDN1Cnzlxi/f+wcWRxk
	 SvWziQ0BCHCWcPROSUrlNfhILUCeGNOwBEedtVrXRWRTF255tNtWNHm4xEWt9MvKwLlES
	 o7gc6/irWeWu2dp8L2nZpg38fGDNxB1Y9bXnuG2A2iLKZ8NvKZetoV4zU/1fTdcvD/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WtbUHL8H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137DF606A329;
	Wed,  4 Nov 2026 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WtbUHL8H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D751F000C1;
	Wed,  4 Nov 2026 18:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793818231;
	bh=EwghIjCIbGs1NDrmAzR7dg2Zewz0hQEfosg9p/Jb5jA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WtbUHL8HAxJZdXcvlrmHLqrRFBKaGhlzDRyNw0FbP9teGOyukxU/0FyvTa7t4JF8x
	 Rohly1WUN3ysOy99n6OxvN9mWkgpbslRt0Yougir3WysLxZE3wYm66cfEiU2dPjT8/
	 Lzrh8lT0qAwxssUlRDDpIW6fSMHpd/1ZrOrMAtDVNsP3RTI6GzCbF73Lw7P6aSoRg0
	 uJ0v3OPbkKj+ZKzW5AxDpvOACfg1fgMk+Sv7m1q3y7RUB20aDkeO9FQnJsd0MxDt1U
	 FSkzbRKmQIpcH80DtLr3cRdRGJ/uY3GFaHOcL408IjQuv+Pjsajh3eI2ErzGkg579M
	 oKd1lf8SSW5kw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA1E2380045E;
	Wed,  4 Nov 2026 18:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 00/15] bpf, sockmap: Fixes for verdicts, redirects,
 corks and recvmsg()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179381823055.3044562.10845634608221940300.git-patchwork-notify@kernel.org>
Date: Wed, 04 Nov 2026 18:50:30 +0000
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, kuniyu@google.com, willemb@google.com, matttbe@kernel.org,
 mptcp@lists.linux.dev, mason@kernel.org, josef@toxicpanda.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  2 Nov 2026 07:20:57 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> These patches fix bugs in sockmap:
> 
>   patches  area
>   -------  ----------------------------------------------------------------
>   01       recvmsg() after a fault
>   02-04    the verdict of an sk_msg prog and the return value of sendmsg()
>   05       the backlog of a stopped psock
>   06       TCP listeners
>   07-08    the target of an egress redirect
>   09       the TCP state in recvmsg()
>   10-14    corks and the redirect target
>   15       bpf_msg_push_data() and bpf_msg_pop_data()
> 
> [...]

Here is the summary with links:
  - [bpf,v2,01/15] bpf, sockmap: Write sg.start when recvmsg() faults
    https://git.kernel.org/bpf/bpf/c/b889ea1f6dbe
  - [bpf,v2,02/15] bpf, sockmap: Don't let an SK_DROP verdict stick
    https://git.kernel.org/bpf/bpf/c/436c4cfa071e
  - [bpf,v2,03/15] bpf, sockmap: Don't let an SK_PASS verdict cover the next message
    https://git.kernel.org/bpf/bpf/c/f4c044966d6c
  - [bpf,v2,04/15] bpf, sockmap: Subtract all dropped bytes from the return value
    https://git.kernel.org/bpf/bpf/c/fa84be67b5bc
  - [bpf,v2,05/15] bpf, sockmap: Clear the resume state of a stopped psock
    https://git.kernel.org/bpf/bpf/c/51e0f3d60be5
  - [bpf,v2,06/15] bpf, sockmap: Give no progs to a TCP listener
    https://git.kernel.org/bpf/bpf/c/7c036a39ba29
  - [bpf,v2,07/15] bpf, sockmap: Check the target of an egress redirect before each send
    https://git.kernel.org/bpf/bpf/c/4aeaad1c536e
  - [bpf,v2,08/15] net: Leave sk_stream_wait_memory() once the socket is dead
    https://git.kernel.org/bpf/bpf/c/430775a30b1f
  - [bpf,v2,09/15] bpf, sockmap: Check the TCP state in recvmsg()
    https://git.kernel.org/bpf/bpf/c/9f5763e6287a
  - [bpf,v2,10/15] bpf, sockmap: Reset the copy position when corking
    https://git.kernel.org/bpf/bpf/c/12c45473dfe7
  - [bpf,v2,11/15] bpf, sockmap: Don't copy 0 bytes into a full cork
    https://git.kernel.org/bpf/bpf/c/a912358996f8
  - [bpf,v2,12/15] bpf, sockmap: Clear the redirect target before the sk_msg prog runs
    https://git.kernel.org/bpf/bpf/c/e4c2fe0b9a62
  - [bpf,v2,13/15] bpf, sockmap: Check that the redirected message is the cork
    https://git.kernel.org/bpf/bpf/c/815cfc482e63
  - [bpf,v2,14/15] bpf, sockmap: Keep the rest of the cork after a redirect
    https://git.kernel.org/bpf/bpf/c/13c41b87e4a7
  - [bpf,v2,15/15] bpf, sockmap: Clear the end mark of elements added by push and pop
    https://git.kernel.org/bpf/bpf/c/0048086bd361

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


