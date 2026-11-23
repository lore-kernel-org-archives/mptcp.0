Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795467744;
	b=eyUFcJwSJKW9mMcpwG3cv8hN4k/73ljKE9V0ryDehsJKqtK9Ca26PJvN+/uH7C+45yDu
	 l54iX78N1SYnxSfUb+pCaw9QtD0k2A03JKoqeAED2IITnHBVjFk6RRBecFL7EVaRcbR30
	 vFASl6/VWyGuz+akbfWi+Btim9FG7Yl0UVc13Ogc+EVZZ8nqcpmJDnUGeSTKlMJBBpxbh
	 C8MSyHijV4W8Hdk/mklkmTi0Aex8+y06ghR2WNv/AW+zG65SX7Ww3PK53mUGdttOHR59f
	 LQpZ0PTUpszOToFXdFZzwV5bz9aMcS/kLDg9Cg8N526m/cnnFrQ1fsDPOEyeVy9KgGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795467744;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Gbaif+XIdI4DBVG3Me4SbEFEKEaWMOTcGzSJnRXY9fE=;
	b=5aOnIsd7whUF9eRHNfPNmXa8AoCZjPpHQokLJe7+6xlwf152kNVUMB1Yz+CloeMsZPvJ
	 OUb4aFLXodgfErYijpU7UroYAHS5hFJo5MlgPsiGJe678png90S1DIhsB9urzutodSow0
	 44gOzgKr86IIBWMpxNkuZcM8QV945mCbprDB+QeM9gAw5nt52lQIYtql9qYvCAfbp08AW
	 c+jEV0DQQhOBmrM3oMb8nPBVVcSokteztrlhlFYMnbqsYe4wcPB1vZXAAhrVpkH0jmdsk
	 0KXVbFpxFe9E8elvb7IcrBmCZRbMAxSg4d903dok+MkuEPPoIae/lN+WJxWY/Dc5ajw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BfwHf9Vn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F096606A31E;
	Mon, 23 Nov 2026 21:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BfwHf9Vn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2951F000C6;
	Mon, 23 Nov 2026 21:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795467743;
	bh=Gbaif+XIdI4DBVG3Me4SbEFEKEaWMOTcGzSJnRXY9fE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BfwHf9VnkMpM8Q0J3FQNG/cslv+xlhB9DEAWsHHS9KMlb5+jVixL/3RDE79vHFbHb
	 QyGJGVBUX/GG+WlvsL5vQH0nKf3utDNrcZ+LPPpD4Aw7mx8SiSf/37MZYXo+gxCqI4
	 GzhitylaRzwuFd9lXom95BhxSPF0Uy+cd+haavYk+sLxczuA08vgIOdwFZuPdb75AA
	 XyFhAe1L5zYDWDHpwn5TB0oeYczYNCrqy+u2of3i8ux0fF0CoY5DGqR3zsuvJbc0i+
	 6v/7kDRUISTPqIxDe3EfqOH7TrUh+oK5xx32WZ6Kjrek2iPltfkk8CxUnLkpJfyL9Z
	 faD4E7f3wsM8w==
Message-ID: <0fd135d4-ac73-423f-9813-f19cdeb1e21e@kernel.org>
Date: Mon, 23 Nov 2026 14:02:23 -0700
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] ss: move to its own directory and split up
 ss.c
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
Cc: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <20261119024049.3109143-1-stephen@networkplumber.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20261119024049.3109143-1-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/26 7:40 PM, Stephen Hemminger wrote:
> The ss command has grown over time and was a single large file.
> Move it and its filter parser to ss/ with their own Makefile, and
> split ss.c by function:
> 
>   ss.h        shared types, option flags and prototypes
>   ss.c        main() and option parsing
>   output.c    column layout and buffered output
>   sock.c      output common to all socket families
>   filter.c    socket selection and filter expressions
>   users.c     socket owners and SELinux contexts from /proc
>   service.c   port to service name resolution
>   inet.c      inet_diag dumps, kill and TCPDIAG_FILE replay
>   tcp.c       TCP, TLS and MPTCP details
>   sctp.c      SCTP details
>   bpf.c       BPF socket-local storage
>   unix.c, packet.c, xdp.c, netlink.c, vsock.c, tipc.c
>               one file per socket family
>   events.c    -E event monitoring
>   summary.c   -s summary
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---


does not apply to top of tree

