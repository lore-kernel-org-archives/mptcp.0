Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC04120B3E
	for <mptcp@lists.linux.dev>; Thu,  4 Apr 2024 05:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712210073; cv=none; b=FSydyzSzMNCAu/RqP+6eIwYe409txL6vawi09ebIjXcMweWg8O+nBx48Y2e3D8OfQiwUNGNzSUwMd0Qo6eey/RajxAx5N0AAewLNSNebU+8MTDRporueJQ0//jgK9rRGQO7QelSnDopjikvaXiWCow282z1WVizudhz5vNAgP9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712210073; c=relaxed/simple;
	bh=V+m4qd+d1fefL6upImWHfPJTEUCXar+iulDGwua+gbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tI4c9AdzEqr9fCxGy5QWMfjZdhlLbQSAKlvxwbR4COe5ub0g4q+5YzNpMJC2s4G9Gy+O1F4n21u2xzgR9uLtTZ9jWY2YYkcnn5P7LX/r57s1oRwjXSP54q7IAys7Y8k00qkyLKufUr9j4aCpvLtHHQdtUgPOfmic0LT022sVKb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nlzwsPEJ; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nlzwsPEJ"
Message-ID: <042ced8c-d39f-4ff5-91a4-ad55f60eeeeb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712210068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ccg4H4dntrS+7JRYdB3nAqpfOY+VAY2XeZ6Kzs0vzr0=;
	b=nlzwsPEJKMZ4H6T976jfKkcx/eCJ+RWws+sE0iySNDYtiYU3AbzDBonj9oXn2WlDZPaNij
	RfrOpqSXLOXYSIYKA6/iWMuhq1zQ2/zkscvL3VhQLOriSwze4fRgXnL5A1/McqGzt1CbWt
	Puc5rI/KwumEx0Jad5bbYhWFr0YZEMw=
Date: Wed, 3 Apr 2024 22:54:19 -0700
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Export send_recv_data helper
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
 <5a1d3a5e2e5318c237a390f8480b51471ed7a488.1712039441.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <5a1d3a5e2e5318c237a390f8480b51471ed7a488.1712039441.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/1/24 11:38 PM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch extracts the code to send and receive data into a new
> helper named send_recv_data() in network_helpers.c and export it
> in network_helpers.h.
> 
> This helper will be used for MPTCP BPF selftests.

It is good to see the codes can be reused for the mptcp selftests.

What about the patches for the new mptcp tests? It is not included in this set 
because it depends on other patches that have not been in the bpf-next yet? It 
is not mentioned in the cover letter.

> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   tools/testing/selftests/bpf/network_helpers.c | 86 +++++++++++++++++++
>   tools/testing/selftests/bpf/network_helpers.h |  1 +
>   .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 82 +-----------------
>   3 files changed, 88 insertions(+), 81 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index f2f8f7388d7c..9878d8072e7f 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -506,3 +506,89 @@ int send_byte(int fd)
>   		return -1;
>   	return 0;
>   }
> +
> +struct send_recv_arg {
> +	int		fd;
> +	uint32_t	bytes;
> +	int		stop;
> +};
> +
> +static void *send_recv_server(void *arg)
> +{
> +	struct send_recv_arg *a = (struct send_recv_arg *)arg;
> +	ssize_t nr_sent = 0, bytes = 0;
> +	char batch[1500];
> +	int err = 0, fd;
> +
> +	fd = accept(a->fd, NULL, NULL);
> +	while (fd == -1) {
> +		if (errno == EINTR)
> +			continue;
> +		err = -errno;
> +		goto done;
> +	}
> +
> +	if (settimeo(fd, 0)) {
> +		err = -errno;
> +		goto done;
> +	}
> +
> +	while (bytes < a->bytes && !READ_ONCE(a->stop)) {
> +		nr_sent = send(fd, &batch,
> +			       MIN(a->bytes - bytes, sizeof(batch)), 0);
> +		if (nr_sent == -1 && errno == EINTR)
> +			continue;
> +		if (nr_sent == -1) {
> +			err = -errno;
> +			break;
> +		}
> +		bytes += nr_sent;
> +	}
> +
> +	ASSERT_EQ(bytes, a->bytes, "send");
> +
> +done:
> +	if (fd >= 0)
> +		close(fd);
> +	if (err) {
> +		WRITE_ONCE(a->stop, 1);
> +		return ERR_PTR(err);
> +	}
> +	return NULL;
> +}
> +
> +void send_recv_data(int lfd, int fd, uint32_t total_bytes)
> +{
> +	ssize_t nr_recv = 0, bytes = 0;
> +	struct send_recv_arg arg = {
> +		.fd	= lfd,
> +		.bytes	= total_bytes,
> +	};
> +	pthread_t srv_thread;
> +	void *thread_ret;
> +	char batch[1500];
> +	int err;
> +
> +	WRITE_ONCE(arg.stop, 0);

nit. It is not needed now because stop is not a global variable which was reused 
by multiple tests.

Anyway, it has a conflict with the bpf-next tree and requires a re-spin.

