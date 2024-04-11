Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E08C2EAF7
	for <mptcp@lists.linux.dev>; Thu, 11 Apr 2024 19:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712863414; cv=none; b=EagwEWaYSV+Fyi2w+sgUHaKXmcMt8gFAM9gUfoI5yjA1YU+RaD5hVgWt4BOVK2yRtSxcBDbqQ//eBesUIuWSKsZWM6uzSeeCvr39Xqk7l5WjyL24OK06C/N0F+/Zk9ZvUiTulo3j7zl/VphubfU132cGOmwE1QwIIWYjth4o6sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712863414; c=relaxed/simple;
	bh=P4wCNLmtXPLsDqGfupgn4JTY+JEmagcCUnkDyIsmNW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bo3Tr2Bd90mLyGWTYnwSpRo87UI09gHnVGKbqnC/p16wFWr/arx/KZ4AXTTQ2x+0/LmXGLVryZyPKueSbhpeVmyZtxWjKQwKJoe24syWYzxVjFAYQEBJshW35q8irjcWGJf0zMfiwa/7RBteYxb5kpORkZzcvftFHAqkfqKM9I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C+lXujML; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C+lXujML"
Message-ID: <a0e2e9f2-9993-4c25-aace-f624986cf874@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712863410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NaltdheOilOpkmrqvkPu9UV2s+iUUvoBTjYEuk47i1A=;
	b=C+lXujMLofgkOBT1Bmw6WrKHQAP9NBN26FRgHVCRdwAjwNAYRQ9mTH8HDljxR1NKbUE+97
	4u5f5WuMolcm+BLlGAM5BPZNzeg7cSZ9SMNFtUzVs0QyZbffX9UfgYSGOzvksd+4xjx7xB
	+cccVM9dHq4awF0UNyJFlUQATIsr+g4=
Date: Thu, 11 Apr 2024 12:23:21 -0700
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 2/2] selftests/bpf: Export send_recv_data
 helper
To: Geliang Tang <geliang@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org
References: <cover.1712813933.git.tanggeliang@kylinos.cn>
 <5231103be91fadcce3674a589542c63b6a5eedd4.1712813933.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <5231103be91fadcce3674a589542c63b6a5eedd4.1712813933.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/10/24 10:43 PM, Geliang Tang wrote:
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
> +	if (bytes != a->bytes)
> +		log_err("Failed to send");

I logged the "bytes" and "a->bytes" here.

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
> +int send_recv_data(int lfd, int fd, uint32_t total_bytes)
> +{
> +	ssize_t nr_recv = 0, bytes = 0;
> +	struct send_recv_arg arg = {
> +		.fd	= lfd,
> +		.bytes	= total_bytes,
> +		.stop	= 0,
> +	};
> +	pthread_t srv_thread;
> +	void *thread_ret;
> +	char batch[1500];
> +	int err = 0;
> +
> +	err = pthread_create(&srv_thread, NULL, send_recv_server, (void *)&arg);
> +	if (err) {
> +		log_err("Failed to pthread_create");
> +		return err;
> +	}
> +
> +	/* recv total_bytes */
> +	while (bytes < total_bytes && !READ_ONCE(arg.stop)) {
> +		nr_recv = recv(fd, &batch,
> +			       MIN(total_bytes - bytes, sizeof(batch)), 0);
> +		if (nr_recv == -1 && errno == EINTR)
> +			continue;
> +		if (nr_recv == -1) {
> +			err = -errno;
> +			break;
> +		}
> +		bytes += nr_recv;
> +	}
> +
> +	if (bytes != total_bytes)
> +		log_err("Failed to recv");

Same here.

> +
> +	WRITE_ONCE(arg.stop, 1);
> +	pthread_join(srv_thread, &thread_ret);
> +	if (IS_ERR(thread_ret) && !err) {

Removed the "&& !err: check. The thread_ret error should always be logged.

Applied. Thanks.

> +		log_err("Failed to thread_ret");
> +		err = PTR_ERR(thread_ret);
> +	}
> +
> +	return err;
> +}

