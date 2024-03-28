Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF34FBA53
	for <mptcp@lists.linux.dev>; Thu, 28 Mar 2024 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711644945; cv=none; b=A93wF5BFHeVW0gJrETS1SOcbWY6ALrf0JW4wmv+tIB1ifOy/qznN9eZeKkRAxxpr3dasZGeN0vC/g8rKrzyVjxlXOobFc/dc5eL2ZQVISN/IxpiTysGJofrXzY+D8bku6VALTmmre6pVcwA5VticpPdcVuhTzNFk/OMALmcyyvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711644945; c=relaxed/simple;
	bh=S5mk/4kAWwkGjMph+Xm6NXpmuRuGDj2qKW0eLhH8Ca4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMw43L5VpfkXGTMB1rz5WtumH2PPj1fzrteCOmd+A/HY0Yc9XmN/llEmn/ot2DTojEPZhu2WrgS2mQaM8HrjjweGP0JEZnLd+PIFjvJMuc00Cq25IUqOk1pK3D0olw9K/GFbCQyxat9AaaaZwYWDkjJroDRX1kqdS7dJ62wDXfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xcI099aF; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xcI099aF"
Message-ID: <e6074193-7530-4c85-9429-9393e24c172d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711644941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eIlBWmFkmVQXGtOdfD7viLDeSyYHEZHX+iplvSflMGA=;
	b=xcI099aFB32OX+rq71ISLdz0N53Nn9G4O+eU4e+/x2Rv2GIqPCUJUWKxKk4/jyoIsDKhRG
	17avJ9iccdjzFANK8FqEpWGGOcnkfL9oujAS5J+3AKbVE5vpCRx34+auwA75ipt/sM7q1/
	ay5XE/rw38jByDZJhZbzDnrToauGf1I=
Date: Thu, 28 Mar 2024 09:55:32 -0700
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Handle EAGAIN in bpf_tcp_ca
Content-Language: en-US
To: Geliang Tang <geliang@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org,
 mptcp@lists.linux.dev, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <78a17486bd12d7afb4cce565d58dac3f15e55c49.1711620349.git.tanggeliang@kylinos.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <78a17486bd12d7afb4cce565d58dac3f15e55c49.1711620349.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/28/24 3:23 AM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> bpf_tcp_ca tests may emit EAGAIN sometimes. In that case, tests fail with
> "bytes != total_bytes" errors. Sending should continue, not break when
> errno is EAGAIN. This patch can make bpf_tcp_ca tests stable.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> index 077b107130f6..fbc219c2d53b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> @@ -56,7 +56,7 @@ static void *server(void *arg)
>   	while (bytes < total_bytes && !READ_ONCE(stop)) {
>   		nr_sent = send(fd, &batch,
>   			       MIN(total_bytes - bytes, sizeof(batch)), 0);
> -		if (nr_sent == -1 && errno == EINTR)
> +		if (nr_sent == -1 && (errno == EINTR || errno == EAGAIN))

This is a non blocking socket. EAGAIN is hitting the timeout situation?

The default timeout is 3s and it has not been changed after the recent 
connect_fd_to_fd and start_server simplifications. I don't find bpf CI failing 
in this test in the last month also.

I would prefer to fail after timeout instead of keep retrying. Do you really hit 
that in your environment for this specific bpf_tcp_ca test? There are many tests 
using this timeout value also.

