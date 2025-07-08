Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B14D25B1EA
	for <mptcp@lists.linux.dev>; Tue,  8 Jul 2025 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751991381; cv=none; b=Xm0sJfSbkBCG2BhCbg6tiJ0qrX2/HntpfyPpjlv2IgDxY6+ORb+qPXzuTDuZYIaSUfck7YZbV7CibF8zHjcxvxdzipL5trejaRlQsf/OoqLPMIU6CXWLmjhIi8cvO5XYNIErOQidt1BghT/1wevlB5c3aN8j3oEry1ct7SWKIn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751991381; c=relaxed/simple;
	bh=TelDDBhE7ZfQtnMDusnN5xsVVdZ+vDa8OHw632+Eens=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LThad3jt4NRS77H3ffC34WEM7FLiCq9ccYzBKWHkUn6JeF+oGT+IxX1o6kT2UcMDLH1/eKHoP7m8BD552+koGR6VEd4MfMac0ZXPE1iy8A80Ug6TL/+3jPRybtVl+R/IP45nnG8qP5e00bIWd+Cq12V/Fyi50heuJaIVXNryIl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+G2rB9h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+G2rB9h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E19C4CEED;
	Tue,  8 Jul 2025 16:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751991380;
	bh=TelDDBhE7ZfQtnMDusnN5xsVVdZ+vDa8OHw632+Eens=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o+G2rB9haPGq4EB87fWPiVmi/wlj3zRYKvLGFhlS8yMWpE8bIc0tVyXCAhi9aPwiB
	 tGrC0oYLjyVmMelfiMLc9lCFqkvtKBWRAwe6fXMSKzOTUtZDGqRvdRlzpzBrfooyeM
	 IqawCXP5rXIpOfB7RiclS2tqHvQd0kOtFiNKrOQx3FAzjFbVTEdqJmXE8Gie5+o1S2
	 XsV3kvWKCf+Lx4J0x6BcIsG9qc+OSvXf5cRztA9Kqqk1Qo8x3RcvQ1F+m0uScgLtGo
	 7+yz4opZdQIUb/WXG8p8exKd9HnQq22rJZZgbsRIj9ULltKZgqfpawDM+qOa3P/W0t
	 6vZZ7FDEQ2xAw==
Message-ID: <901fe63e-4ba6-4efa-aa02-7b095a3d33aa@kernel.org>
Date: Tue, 8 Jul 2025 18:16:17 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v7 2/4] mptcp: implement .read_sock
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev,
 pabeni@redhat.com, hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1751880561.git.tanggeliang@kylinos.cn>
 <5cbb736addab5da388d5a43d3ad147ad50ff282f.1751880561.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <5cbb736addab5da388d5a43d3ad147ad50ff282f.1751880561.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for the new version!

(Thank you, Paolo, for the previous reviews!)

On 07/07/2025 11:34, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> nvme_tcp_try_recv() needs to call .read_sock interface of struct
> proto_ops, but it is not implemented in MPTCP.
> 
> This patch implements it with reference to __mptcp_recvmsg_mskq().

I still think more explanations are needed to help reviewers and
developers later, e.g. explaining what this interface is supposed to do,
what are the particularities linked to MPTCP and the differences with
TCP, why you cannot re-use something already there or the differences
with __mptcp_recvmsg_mskq(), etc.

> v2:
>  - first check the sk_state (Matt), but not look for the end of the
> end of a connection like TCP in __tcp_read_sock():
> 
> 	if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)
> 		break;
> 
> This will cause a use-after-free error:
> 
> 	BUG: KASAN: slab-use-after-free in mptcp_read_sock.
> 
> v3:
>  - Use sk->sk_rcvbuf instead of INT_MAX as the max len.
> 
> v4:
>  - invoke __mptcp_move_skbs.

Thank you for the changelog, it is very useful, but please move it in
the comment section, under the last Signed-off-by, after a line
containing "---":

  (...)
  Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
  ---
  Notes:
    v2:
      - (...)

Otherwise, the changelog will be part of the commit message when sending
this patch to netdev.

Same in the other patches.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

