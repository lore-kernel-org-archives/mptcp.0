Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEF922688C
	for <mptcp@lists.linux.dev>; Fri, 10 Oct 2025 12:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760098971; cv=none; b=Ca1DC6r923TiLqXgeldMWdUKTyAVkqiqWhoI6nAzyfk16kYLVFZGprlQ+f+7Fkxr5Go4jliGMqnC2qyJmMO50fkHoy/XFy9FppBsY3FFsnRVP6sN4MmPWIQypt7IgktuyUb4Tq7DD19jO+VYnqmvdjfahiyZUuPsSgA2lSikuRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760098971; c=relaxed/simple;
	bh=DPl+wYYxZtdn8naCkBO6KrLaqHTZ42k66dMrzAgp+ow=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aSprBovuyUo4M8GO8d9MGUVUU/oiaXOni++r9uR56ofrmOAywkpUUmKfL/colIpoU8UD3jdbTbtQ+2vZhFqxDnYIppYxaxpYTM32Q7Rn59a/72tQjCm+047IATlgZVemV3e79QwUfvrG6lzg4JOZdCRzCvKkb92ymI1eQsYVXSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TySSDdK0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TySSDdK0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE9CC4CEF1;
	Fri, 10 Oct 2025 12:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760098971;
	bh=DPl+wYYxZtdn8naCkBO6KrLaqHTZ42k66dMrzAgp+ow=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=TySSDdK0kxgxmV+X2ssJetQQwv+ys2ebbxUf1BCaLAlRwZjCfTlLURzRYQBQ0l62E
	 /Vjyr8V7T5EyYrmTbNE1TFOMqFM1av17VaeBvX9pp9MtVudXtj2ZH9l/gA08vCTKY8
	 yHgpfjQIUMtG9VZ4jv6jGEyHVh4QKGBOHYJBgX1RPUvcT2oDIbLDFVyyqxqSzIhGPo
	 ZwoYdgI6f/w6n4+d2k23JaT8GnLcLCGX4mXaIeTFKsHVVYEvjDuutlxpKhDz4z/5MT
	 rJ7mvtj/4l+Xk1PDmd0Kcjh9QvFxWy0B6cajrrPfAv4RUNp6Jahxc8vSR17OhVpeBa
	 KcKTKCV1G/3ww==
Message-ID: <20a3df573803203df6b672d1ecd606e242e84b20.camel@kernel.org>
Subject: Re: [PATCH v5 mptcp-next 00/10] mptcp: introduce backlog processing
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, 
	mptcp@lists.linux.dev
Date: Fri, 10 Oct 2025 20:22:46 +0800
In-Reply-To: <53ed629a-d364-470f-8a52-5a34692f0da7@redhat.com>
References: <cover.1759737859.git.pabeni@redhat.com>
	 <2c9f131e-ef34-4916-8aab-e1420e1ae90b@kernel.org>
	 <d0a814c364e744ca6b836ccd5b6e9146882e8d42.camel@kernel.org>
	 <b90e5899-6473-4b3b-a239-9202c2e2cb03@redhat.com>
	 <2389029f56a9fa496b59be7655987e6d9c6362f2.camel@kernel.org>
	 <8a8feb1d-ad10-4ba4-a448-db8a0e45c7c3@redhat.com>
	 <c53540268cb422a14d38745c6d0bdb440deb7c11.camel@kernel.org>
	 <6d3545fc-f342-4532-b1c3-fb96d9c79fe6@redhat.com>
	 <e759f7f6-b90f-4663-9ab4-040f76c2bbba@redhat.com>
	 <53ed629a-d364-470f-8a52-5a34692f0da7@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo,

On Fri, 2025-10-10 at 10:21 +0200, Paolo Abeni wrote:
> On 10/9/25 3:58 PM, Paolo Abeni wrote:
> > @Geliang: if you reproduce the issue multiple times, are there any
> > common patterns ? i.e. sender files considerably larger than the
> > client
> > one, or only a specific subsets of all the test-cases failing, or
> > ...
> 
> Other questions:
> - Can you please share your setup details (VM vs baremetal, debug
> config
> vs non debug, vmg vs plain qemu, number of [v]cores...)? I can't
> repro
> the issue locally.

Here are my modifications:

https://git.kernel.org/pub/scm/linux/kernel/git/geliang/mptcp_net-next.git/log/?h=splice_new

I used mptcp-upstream-virtme-docker normal config to reproduce it:

docker run \
	-e INPUT_NO_BLOCK=1 \
	-e INPUT_PACKETDRILL_NO_SYNC=1 \
	-v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always ghcr.io/multipath-tcp/mptcp-upstream-virtme-
docker:latest \
	auto-normal

$ cat .virtme-exec-run 
run_loop run_selftest_one ./mptcp_connect_splice.sh

Running mptcp_connect_splice.sh in a loop dozens of times should
reproduce the test failure.

> - Can you please share a pcap capture _and_ the selftest text output
> for
> the same failing  test?
> 
> In the log shared previously the sender had data queued at the
> mptcp-level, but not at TCP-level. In the shared pcap capture the
> receiver sends a couple of acks opening the tcp-level and mptcp-level
> window, but the sender never replies.
> 
> In such scenario the incoming ack should reach ack_update_msk() ->
> __mptcp_check_push() -> __mptcp_subflow_push_pending() (or
> mptcp_release_cb -> __mptcp_push_pending() ) -> mptcp_sendmsg_frag()
> but
> such chain is apparently broken somewhere in the failing scenario.
> Could
> you please add probe points the the mentioned funtions and perf
> record
> the test, to try to see where the mentioned chain is interrupted?

Thank you for your suggestion. I will proceed with testing accordingly.

-Geliang

> 
> Thanks,
> 
> Paolo
> 

