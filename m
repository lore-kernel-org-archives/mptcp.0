Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9AC15B0
	for <mptcp@lists.linux.dev>; Fri, 23 Sep 2022 02:26:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663899974; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=C7EHhizBl8x8MYKm1cQiwuEOzt6REg1V1jOpZmRAOgm0DQa0kiXzKpymdLoL8+IdL7qeIprEwf8uajBFdjhiru3Msm4JrA0EDeSqDFNse2PXLGkMh55d9dKFNIco0VIIltY3eqD3Su83HH5vFECV0qW0rAejkdGAJRbkvREpdyg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663899974; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=1Lw9nwNUi3sib4YnsJiUjVIkfuiGJr671bTLlwPr1zY=; 
	b=PiY/4mgsf34QykHWMzCxHIujDpqom0RL2wexiJGO8vvlYz0f/OMURabAKG879jQNzBu81hmz7B0MIjqI/FwC+sSM7LhAEAE/73G09USzGr5RLoU/MYO+Vm97nB8dmUn2lt6xHzoEbd4ohIANVWdpWWIjq334l730q5WUg4YSGxY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663899974;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=1Lw9nwNUi3sib4YnsJiUjVIkfuiGJr671bTLlwPr1zY=;
	b=NV1/598enuWWfaofaIsHTSPzF06zP2V6AzeGhOw+XVBtQc8BjDAuQR9DJi+f+gQL
	paSWsjK9DX0VxyPBRFyKBNg+PBRoLCCJdYhJZlJeixC0DD76BtSYiYN1wVCPb0gTeoC
	sqUGa3P34WwCdjAgV1kbEMX9dxX71PAMM1/ZfxrI=
Received: from [192.168.1.25] (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663899971135939.4157839469492; Fri, 23 Sep 2022 04:26:11 +0200 (CEST)
Message-ID: <85949067-c35d-26bd-b5ea-5342d3a6f841@shytyi.net>
Date: Fri, 23 Sep 2022 04:26:10 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH mptcp-next v10 0/3] mptcp: Fast Open Mechanism:
Content-Language: fr
To: mptcp@lists.linux.dev
References: <20220923001530.9722-1-dmytro@shytyi.net>
From: Dmytro Shytyi <dmytro@shytyi.net>
In-Reply-To: <20220923001530.9722-1-dmytro@shytyi.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hello all,


Do you grant a permission to submit v11 in less then 24h period?

I have 2 things to do:
1. I have one line to modify in tcp.c and build will be successful (I 
think).
2. Change the name of the patch (add "sender" in the topic) as somehow 
it wasn't applied.

Best regards,
Dmytro SHYTYI

On 9/23/2022 2:15 AM, Dmytro Shytyi wrote:
> Compared to the previous patches, these focus on the sender side.
>
> Dmytro Shytyi (3):
>    mptcp: add mptcp_setsockopt_fastopen
>    mptcp: add mptcp_stream_connect to *.h
>    mptcp: reuse tcp_sendmsg_fastopen()
>
>   include/net/tcp.h    |  3 +++
>   net/ipv4/tcp.c       | 23 ++++++++++++++++++-----
>   net/mptcp/Makefile   |  2 +-
>   net/mptcp/fastopen.c | 32 ++++++++++++++++++++++++++++++++
>   net/mptcp/protocol.c | 22 ++++++++++++++++++----
>   net/mptcp/protocol.h |  6 ++++++
>   net/mptcp/sockopt.c  |  3 +++
>   7 files changed, 81 insertions(+), 10 deletions(-)
>   create mode 100644 net/mptcp/fastopen.c
>
