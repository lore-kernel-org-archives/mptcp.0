Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFE443AB7
	for <mptcp@lists.linux.dev>; Thu,  4 Apr 2024 06:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712210606; cv=none; b=M1m6WhhKk2mLjOp2ykh7mfuyTXDob2KYtaAAHGCkGs0gQzIfQNgHmI+EuL6tydI+aZD8sGJee+Fc5ilbN3uhXa0H4mMpFTKDuDgxB4fqRQkGCJTg4uSSiIsa+w4G3o+uY7OlY+VGFJc16eE/RBNo0TTSF6Z2CXi/cU8UMcRwmgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712210606; c=relaxed/simple;
	bh=lDjjUYnYOCDDCjKRppbWACBxT0WqyIjAB63wTMEYgL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GVk2ILlFSIqE0S43E0d82OTlOeRl4nI1rA0hdNoM7WcRL9RjTxuuTTFKIik/Je9XLwBIjcC9MQNAGgnal80K4fl5E8FvDg3MAAoQ7njP7J6rhA0fKe+fNlOCjeK4oetTdAK/j4aFNhX1qHdrEIp+tEi2SdXThByePH2j9ge6uFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L0s5iKF6; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L0s5iKF6"
Message-ID: <c3db579d-78d3-4135-8fd8-58a17a4a4382@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712210601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HujBcmBKaGPA3mkWrsbFEDcr7+iQf+QjXFivfPNlR7o=;
	b=L0s5iKF60/agAVK7GahlQ0applM83ySLdtU4bnwpYIYgLQCXeVeTT7o15czd1t7uniBJPA
	3N4k1FLTrWPDZ4a8AXwugPOUJx83CdteFmnO6dLb4Lpuo9QkHM9A3z60lB37zC71PuLlA9
	V3dX3R4z+QJnPWOj6gEs/hI7Ei/avqc=
Date: Wed, 3 Apr 2024 23:03:09 -0700
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: Export send_byte helper
To: Geliang Tang <geliang@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org,
 mptcp@lists.linux.dev, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <cover.1712039441.git.tanggeliang@kylinos.cn>
 <4daa40f84a7b9e506bb21c4dcbccdcf1db8fc750.1712039441.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <4daa40f84a7b9e506bb21c4dcbccdcf1db8fc750.1712039441.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/1/24 11:38 PM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The helper send_byte is defined in mptcp.c, sk_lookup.c and tcp_rtt.c.
> It makes sense to export it into network_helpers.h to let it can be
> used for all BPF selftests.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   tools/testing/selftests/bpf/network_helpers.c      |  9 +++++++++
>   tools/testing/selftests/bpf/network_helpers.h      |  1 +
>   tools/testing/selftests/bpf/prog_tests/mptcp.c     |  7 -------
>   tools/testing/selftests/bpf/prog_tests/sk_lookup.c | 13 -------------
>   tools/testing/selftests/bpf/prog_tests/tcp_rtt.c   |  7 -------
>   5 files changed, 10 insertions(+), 27 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index 6db27a9088e9..f2f8f7388d7c 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -497,3 +497,12 @@ int get_socket_local_port(int sock_fd)
>   
>   	return -1;
>   }
> +
> +int send_byte(int fd)
> +{
> +	char b = 0x55;
> +
> +	if (!ASSERT_EQ(write(fd, &b, sizeof(b)), 1, "send single byte"))
> +		return -1;
> +	return 0;
> +}

I think it is overkill to have a dedicated helper that only does the error 
checking on the single syscall send/write. I would drop this patch and directly 
use the syscall send/write instead.

