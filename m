Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3314DA0C;
	Mon, 25 Mar 2024 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711383702; cv=none; b=BQrF8f6EYmj/+uo2KuYglyPZJKN/K7nc5//ewBnCrhidim2NdwH27KPT4BhxIEszS1iGJYEZEjHDIiLIR/rOHZqoOxCBGIJhwEAMG8xfqUd5ncPGO2Bt4hfcordiNpjc9v50t1mmLmYUrm8hnBLfsFjnyNuSFUOuxiSmaXjBzC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711383702; c=relaxed/simple;
	bh=8XxtinYgzZ8px/l3hS1/c0zV25EAZGOJ0XIuQ8fn0WA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=D+jwLJxya3az4FiaZn6VdGoKH7OHuz06xbl9EUKSrA0/t2OnBBwkC5Jjbg3fsl22segFDLg3Y0d83z8q5ODcUei+oo6ZGj1U+PPxDnwS2xoC7l/SHoaEQ1CIdKm0IlbTcw9o9JZi1av/BQBlH2CgisP6gUvgbrcJ9jRYr/Xxuy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Jktam5yV; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Jktam5yV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=1a25lBRJFEKgdjTodykGfTgFKA83lENmTjWQ+IGA7BM=; b=Jktam5yVwpEZuXlQ6JwYB0PJP0
	dEsCelikSt/OhWjP0mfyZ+3NXlq70AOk6QxCIp5kKXoP0jQcRbCSiVadNH6h6II/6k+dx9OaSK3Dh
	bHJuSk1Ce0i2CDBkO+1+LEP47Qyikc2RkViIhzCA/HQIUOM33BX4LyEUmAjZN1q05at8fyc2TGKZZ
	bdnL2UqfsAd90Ic33Trx0j4/TBLwQw/tLv4Z97EW4x8jpUPt3E8m/14hnYxnN+RYbyhjx1Ztn80T7
	GByWpcBLOy87QaH62pmhbX7MM2leYWKKCEW6Enqms238G885T+E6gwn4rCFBbAU+SvsS9ehq1H/6K
	LdUYWIxQ==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1ron4q-0006bq-06; Mon, 25 Mar 2024 17:21:36 +0100
Received: from [178.197.248.30] (helo=linux.home)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1ron4p-0002yT-0H;
	Mon, 25 Mar 2024 17:21:35 +0100
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Use start_server and
 connect_fd_to_fd
To: Geliang Tang <geliang@kernel.org>, bpf@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, mptcp@lists.linux.dev
References: <686400b5c4eefdb930048df57cc513dbd6e94fa1.1711343483.git.tanggeliang@kylinos.cn>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f4e6d3a5-f02a-9895-cc6b-b0ff4795f1c2@iogearbox.net>
Date: Mon, 25 Mar 2024 17:21:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <686400b5c4eefdb930048df57cc513dbd6e94fa1.1711343483.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27225/Mon Mar 25 09:30:27 2024)

On 3/25/24 6:15 AM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> To simplify the code, use BPF selftests helpers start_server() and
> connect_fd_to_fd() in bpf_tcp_ca.c instead of open-coding. These helpers
> are defined in network_helpers.c, and exported in network_helpers.h,
> which is already included in bpf_tcp_ca.c.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> v2:
>   - use connect_fd_to_fd too.

These are two logical changes in one, please send an individual patch for the
connect_fd_to_fd.

Thanks,
Daniel
