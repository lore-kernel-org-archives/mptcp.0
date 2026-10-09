Received: from mta0.migadu.com (out-3.mta0.migadu.com [91.218.175.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDCC3DB300
	for <mptcp@lists.linux.dev>; Fri,  9 Oct 2026 09:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791538000; cv=none; b=VvB7KDkDApIH3sM6BUw3x0pl0BvMleXvw6oDWIrlaMU0ZwLLx+/8UmQwx2twBYWy0c2SiufFnc7P43ddSiCQzP0tL9DRN6pONzuLmGYQwnUOv1N+KxIw1NSlCxfdIqKsW/bVcoBMg3Yvzl3sUK2VdcqP+gL7+i8S0HB9Sv0D118=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791538000; c=relaxed/simple;
	bh=uzA8DQK0HwfCpzKe3M6fLRHXV6UAY16hwY+LS85j3RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKO4qM4kfQllqNRG8ZOBRiO0pu1MZT+8dRaocjkjWvCGSij03ad3zc4i7oLKoCjVSmTsYAtpwrszB0VM49Gx3wTo2P1/E8cuCFA3MT27HTAHnsTWAkGLMxA8WEB8ogE3yV9FW7KOxDVaDEUEX3lVMs4Lo7ftyJKlR4fAPxY+Zvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n3uWvjyc; arc=none smtp.client-ip=91.218.175.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n3uWvjyc"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=uzA8DQK0HwfCpzKe3M6fLRHXV6UAY16hwY+LS85j3RE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791537994; v=1; x=1792142794;
 b=n3uWvjycfl9OlKHguf6BDoC7OELM3e/BKE8/GhjE5TLWR6tEJ+19MfXPnHEEN7Te918cEGpM
 ikxOm5oZnfo/VRrCQs/t78+ESxV1mH/k5tpoWoj/AwsIn6hzrwpjIcSGuNBV9wRyyAARGDS1lzB
 8D8lwwCafMJeR0Ufi3xc9q+M=
X-Envelope-To: mptcp@lists.linux.dev
Received: by mta10.migadu.com with ESMTPS id 2879a781930ca88f;
	Fri, 09 Oct 2026 09:26:34 +0000
X-Mizu-Trace-ID: 2879a781930ca88f
X-Migadu-Flow: FLOW_OUT
Date: Fri, 9 Oct 2026 17:26:26 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>,
	Hangbin Liu <liuhangbin@kylinos.cn>
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: convert iptables
 to nftables for mptcp_join.sh"
Message-ID: <asizQp6ewh2fF0Q5@fedora>
References: <20261009-mptcp_remove_addr-v1-1-4471d460e026@kylinos.cn>
 <f76282e6-9120-414b-8402-72beb0a12ec9@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f76282e6-9120-414b-8402-72beb0a12ec9@kernel.org>

On Fri, Oct 09, 2026 at 11:03:07AM +0200, Matthieu Baerts wrote:
> Hi Hangbin,
> 
> On 09/10/2026 09:26, Hangbin Liu wrote:
> > From: Hangbin Liu <liuhangbin@kylinos.cn>
> > 
> > After squash, the new commit description could be:
> 
> Thank you for the new version!
> 
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > index b16e24418e73..cf079c18af12 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -97,6 +97,20 @@ unset add_addr_tx_nr
> >  unset add_addr_echo_tx_nr
> >  unset add_addr_drop_tx_nr
> >  
> > +# A tcpdump capture of the RM_ADDR message looks like:
> > +#
> > +#   [TCP header: 20 bytes] [nop] [nop] [timestamp: 10 bytes] \
> > +#         [MPTCP DSS: 12 bytes] [MPTCP RM_ADDR: 4 bytes]
> > +#
> > +# nft cannot process the RM_ADDR option because it stops parsing after
> > +# matching the first DSS option. Use hard-coded byte offsets to match
> > +# RM_ADDR messages. We verify:
> > +#
> > +# TCP Data Offset (12 x 4 = 48 bytes), DSS (TCP[32] x 8) kind (MPTCP 0x1e)
> > +# and length (0x0c). RM_ADDR (TCP[44] x 8) kind (MPTCP 0x1e) and subtype (4)
> > +
> > +RM_ADDR_OFFSETS="tcp doff 12 @th,256,16 == 0x1e0c @th,352,8 == 0x1e @th,368,4 == 4"
> 
> The subtype is on 4 bits. For the moment, the rest are not used, but
> would it not be better to compare the 20 first bits of this offset?
> 
> So using this: (not tested)
> 
>   "tcp doff 12 @th,256,20 == 0x1e0c2 @th,352,12 == 0x1e044"

Here it should be @th,352,20 == 0x1e044
> 
> Or maybe we prefer not to be strict for the RM_ADDR size to match
> options with multiple IDs? Then having:
> 
>   "tcp doff 12 @th,256,20 == 0x1e0c2 @th,352,8 == 0x1e @th,368,4 == 4"
> 
> and for the comment:
> 
> # TCP Data Offset (12 x 4 = 48 bytes).
> # DSS (TCP[32] x 8) kind (MPTCP 0x1e), length (0x0c), subtype (2).
> # RM_ADDR (TCP[44] x 8) kind (MPTCP 0x1e), variable length, subtype (4).
> 
> I can modify this when applying if that's OK for you (and validated).

And both works for me. I tested these 2 rules, all are able to capture the
RM_ADDR messages.

        chain OUTPUT {
                type filter hook output priority filter; policy accept;
                ip saddr 10.0.2.1 tcp doff 12 @th,256,24 & 0xfffff0 == 0x1e0c20 @th,352,24 & 0xfffff0 == 0x1e0440 counter packets 1 bytes 68 accept
                ip saddr 10.0.1.1 tcp doff 12 @th,256,24 & 0xfffff0 == 0x1e0c20 @th,352,24 & 0xfffff0 == 0x1e0440 drop
        }

        chain OUTPUT {
                type filter hook output priority filter; policy accept;
                ip saddr 10.0.2.2 tcp doff 12 @th,256,24 & 0xfffff0 == 0x1e0c20 @th,352,8 0x1e @th,368,8 & 0xf0 == 0x40 counter packets 3 bytes 204 accept
                ip saddr 10.0.1.2 tcp doff 12 @th,256,24 & 0xfffff0 == 0x1e0c20 @th,352,8 0x1e @th,368,8 & 0xf0 == 0x40 drop
        }

Thanks
Hangbin
