Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99921422A5
	for <mptcp@lists.linux.dev>; Mon,  8 Apr 2024 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591720; cv=none; b=CossW1PB5gDNs+POmNmkVZQVlYvUrCH2EKAfgCoLgyqR3fOMM1vG1tOAkOPu/O6kusbKfYWH0comSQE/QFd5BdBZA2BUvxZiFa1zXf+iuy26B0jmKQsZ1t7MEpk2/7XjGOC6YevAoVntvq1zNziEvcmTSVdoInNXc3wGw3S+yM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591720; c=relaxed/simple;
	bh=hE817CDdKg+SxH2QMPBR35McYv5Tljp1R3u9MzigeBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pKTc0F1cQ33LY8LW/FHzn2BKy0xKiF3AqoOMCpqpprwwj9lcM0U+KHGg8yGlDpahSyq07lSf4YYshC/R6+NEj+nbKHj4WK/APvLUzf6pBTOpMc6UYt9m+Tfp9m3dF2IHuHqujurN94FY+69XAMuLQp9Iq6XOPpBYwP/jlQWX7LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ATM3KCev; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ATM3KCev"
Message-ID: <5ee0db00-0895-448a-aa62-c5c9f6a3f5f4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712591714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hE817CDdKg+SxH2QMPBR35McYv5Tljp1R3u9MzigeBQ=;
	b=ATM3KCevoHmmre2IztwZOXdXCKD9HWVHAPNDZkvxNwe5+l6Cd50ZD8FUOhh1yCqbMY2dMq
	DxLnFmhGSXmY2FSg2wPbRpQukfq4MxvzhYfZH3EC1dQ4kvbtHx38taRFWdA01d6eXlZaKf
	3LjTBxcM4y/751iTolO+pRLeGwQI+7w=
Date: Mon, 8 Apr 2024 08:55:08 -0700
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] selftests/bpf: Add F_SETFL for fcntl in
 test_sockmap
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org,
 mptcp@lists.linux.dev
References: <cover.1712539403.git.tanggeliang@kylinos.cn>
 <2f9f84be1366ca68b1123dd2f3fd06034e1bd3a4.1712539403.git.tanggeliang@kylinos.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <2f9f84be1366ca68b1123dd2f3fd06034e1bd3a4.1712539403.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/7/24 6:36 PM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Incorrect arguments are passed to fcntl() in test_sockmap.c when invoking
> it to set file status flags. If O_NONBLOCK is used as 2nd argument and
> passed into fcntl, -EINVAL will be returned (See do_fcntl() in fs/fcntl.c).
> The correct approach is to use F_SETFL as 2nd argument, and O_NONBLOCK as
> 3rd one.
>
> In nonblock mode, if EWOULDBLOCK is received, continue receiving, otherwise
> some subtests of test_sockmap will fail.
>
> Fixes: 16962b2404ac ("bpf: sockmap, add selftests")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

