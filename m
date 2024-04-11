Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC6F139CEE
	for <mptcp@lists.linux.dev>; Thu, 11 Apr 2024 18:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712859067; cv=none; b=pzb3815grHUpilzeYjMI6JbfsQ7Q6BrOWoE1WfgmPk9jOZxroNBXKhxWQaDW0x/+JN6YI+4KGKSIlklAFCQKTaWSO8tPEPpLHNeVxF+dJ1WdpWXY188XD2/wk8Hkwshsr5P5wklBcTtnsOAiy3+3MIvXnjpGpjQevOOlpRCDjxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712859067; c=relaxed/simple;
	bh=Un1X4Awdlcl5O0s/Mp6g/huZu7KIX8C978fCTpZt848=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PcQO+hUiXainK17Sk49AZws76l2TwjF9Erh7H0JO7CPej8ibEVzMg8cFbjOKSGRcLB9WCQSm2HBPE8WsFtmQBcaQ3MDyHoK4UKYmjDfM4jQLo6ZpG4B3T6E22T5T2AG1QRDQSm+17KcZs7L4DLU/Sc8MjmJ+j4VSPDwWJFl3D9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NhpHPKnB; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NhpHPKnB"
Message-ID: <e2aaa0f0-7641-4d26-9256-1151976235f1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712859062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UuPsWMYO5T1HxiMlvFvVkgrqm02LlJEm/ffWXLbh23s=;
	b=NhpHPKnBVcMk+vGramEV7kXPCMJCKr20/SDHVRIHwP5acC3xOlcCrQYCubVb1f2V1mu6ck
	rtPx2B0v3l+9QPn4K2UYfc+N0a5sx3mOzZ/1kOo17NZiIow1ZWwSklGbS5/okvoiEzrH2k
	dEUkj+JGaQOlpRfNdUectpu4Ajq8+JQ=
Date: Thu, 11 Apr 2024 11:10:49 -0700
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v4 1/2] selftests/bpf: Add F_SETFL for fcntl in
 test_sockmap
To: Geliang Tang <geliang@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jakub Sitnicki <jakub@cloudflare.com>, Geliang Tang
 <tanggeliang@kylinos.cn>, bpf@vger.kernel.org, mptcp@lists.linux.dev
References: <cover.1712639568.git.tanggeliang@kylinos.cn>
 <e4efa52c26ca5ae97c7e4e7570d8da9cd44df533.1712639568.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <e4efa52c26ca5ae97c7e4e7570d8da9cd44df533.1712639568.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/8/24 10:18 PM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Incorrect arguments are passed to fcntl() in test_sockmap.c when invoking
> it to set file status flags. If O_NONBLOCK is used as 2nd argument and
> passed into fcntl, -EINVAL will be returned (See do_fcntl() in fs/fcntl.c).
> The correct approach is to use F_SETFL as 2nd argument, and O_NONBLOCK as
> 3rd one.
> 
> In nonblock mode, if EWOULDBLOCK is received, continue receiving, otherwise
> some subtests of test_sockmap fail.
> 
> Fixes: 16962b2404ac ("bpf: sockmap, add selftests")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>   tools/testing/selftests/bpf/test_sockmap.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
> index 024a0faafb3b..4feed253fca2 100644
> --- a/tools/testing/selftests/bpf/test_sockmap.c
> +++ b/tools/testing/selftests/bpf/test_sockmap.c
> @@ -603,7 +603,9 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
>   		struct timeval timeout;
>   		fd_set w;
>   
> -		fcntl(fd, fd_flags);
> +		if (fcntl(fd, F_SETFL, fd_flags))
> +			goto out_errno;
> +
>   		/* Account for pop bytes noting each iteration of apply will
>   		 * call msg_pop_data helper so we need to account for this
>   		 * by calculating the number of apply iterations. Note user
> @@ -678,6 +680,7 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
>   					perror("recv failed()");
>   					goto out_errno;
>   				}
> +				continue;

 From looking at it again, there is a select() earlier, so it should not hit 
EWOULDBLOCK.

Patch 2 looks good. Only patch 2 is applied. Thanks.

>   			}
>   
>   			s->bytes_recvd += recv;

