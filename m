Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC1225A35A
	for <mptcp@lists.linux.dev>; Fri, 13 Mar 2026 08:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773389083; cv=none; b=chnFNODMJX4zhTksWJOxDsvDF1hGug7fLQdgdEAR0WsqvMrlWUri/YxI4UQcmW1va5EVdBTc6glM0/k38FpJjiDch16QgNBaInPXl6FRnl8lUxvxZtvJctYh51bl0s1dUw9taJrexiXoWDWHFfWrHSXoEGpoXhyJ06x79c3a4gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773389083; c=relaxed/simple;
	bh=N0uyPqsrRZd7PXIfaFH16ITcvkDmMXQBsNrEKDhK0nI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HmCF39RIz2xDdp9OtXqfxEDhpcwoygMXGlnh+bcCpDaXRXBfvqTZFHebRS5rLV35pWokiYPtlX5D5l5gsmHriOi9EF5PC5X46JusKzasPgtVfMRGuS3OCzqm5clNyCMmKjxnaBKO4wn6Ipik0U3C0qPZ5GGWIFyxl4yC4m3VVGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6jzveH2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6jzveH2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC16C19421;
	Fri, 13 Mar 2026 08:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773389083;
	bh=N0uyPqsrRZd7PXIfaFH16ITcvkDmMXQBsNrEKDhK0nI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=j6jzveH23/pPculY23trlzgdSJ2RX6C0DqzQuKlpVw4q+tv0Ytd4G1Z12tck2bO/8
	 UwMJMifd1MfTUMF6CTRYPPHdAUmwneV54QbWJPM9AYBuutO1kYmVa9YdiLDoDntpdk
	 7vCImRy0cUF8xLBx/f6F2IkJKVg8i7T/Pw8p5EKsC6YVm8MPg59x6RGvVDtH4uHQK8
	 VDKWX0fPqpX8amNMd/Bu1+XPWGEcCt08b9NpXdoNPu4ngD03zraFs8Oqo57F8elHWT
	 ThWCbYaKYk6/HjQaFbsAY/qa265xEKy25J/iQJb/crinr73kA48+OiHk3IJeXKjGji
	 VdztLYfvZpOVg==
Message-ID: <5b5a0dfb286f60011750a83131bda08aeb779d29.camel@kernel.org>
Subject: Re: [RFC mptcp-next v9 09/10] selftests: mptcp: connect: set smc
 instead of tls
From: Geliang Tang <geliang@kernel.org>
To: dust.li@linux.alibaba.com, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>, Gang Yan <yangang@kylinos.cn>
Date: Fri, 13 Mar 2026 16:04:38 +0800
In-Reply-To: <abOuAUaS1Rjutn-D@linux.alibaba.com>
References: <cover.1773365606.git.tanggeliang@kylinos.cn>
	 <d146e42dfe374cf28164726f6afd4b0b0ee12b6e.1773365606.git.tanggeliang@kylinos.cn>
	 <abOuAUaS1Rjutn-D@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dust,

On Fri, 2026-03-13 at 14:26 +0800, Dust Li wrote:
> On 2026-03-13 09:42:51, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Hi Geliang,
> 
> Thanks for the effort !
> But it's a pitty that SMC ULP support was removed in
> df31a6b0a305(Revert "net/smc: Introduce TCP ULP support") due to
> it violates some VFS assuptions :(

Thanks for the reminder. I will consider using another ULP instead.

-Geliang

> 
> Best regards,
> Dust
> 
> > 
> > With KTLS being implemented, "tls" should no longer be used in
> > sock_test_tcpulp(), it breaks mptcp_connect.sh tests. Another ULP
> > name, "smc", is set instead in this patch.
> > 
> > Cc: Dust Li <dust.li@linux.alibaba.com>
> > Co-developed-by: Gang Yan <yangang@kylinos.cn>
> > Signed-off-by: Gang Yan <yangang@kylinos.cn>
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> > tools/testing/selftests/net/mptcp/config          | 1 +
> > tools/testing/selftests/net/mptcp/mptcp_connect.c | 2 +-
> > 2 files changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/config
> > b/tools/testing/selftests/net/mptcp/config
> > index 59051ee2a986..18bd29ac5b24 100644
> > --- a/tools/testing/selftests/net/mptcp/config
> > +++ b/tools/testing/selftests/net/mptcp/config
> > @@ -34,3 +34,4 @@ CONFIG_NFT_SOCKET=m
> > CONFIG_NFT_TPROXY=m
> > CONFIG_SYN_COOKIES=y
> > CONFIG_VETH=y
> > +CONFIG_TLS=y
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> > b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> > index cbe573c4ab3a..64c8a4bfe749 100644
> > --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> > @@ -289,7 +289,7 @@ static void sock_test_tcpulp(int sock, int
> > proto, unsigned int line)
> > 		if (ret == 0)
> > 			X("setsockopt");
> > 	} else if (proto == IPPROTO_MPTCP) {
> > -		ret = do_ulp_so(sock, "tls");
> > +		ret = do_ulp_so(sock, "smc");
> > 		if (ret != -1)
> > 			X("setsockopt");
> > 	}
> > -- 
> > 2.53.0
