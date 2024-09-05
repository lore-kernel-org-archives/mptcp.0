Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1FA1957F8
	for <mptcp@lists.linux.dev>; Thu,  5 Sep 2024 10:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725533955; cv=none; b=uqhInPdFkw1cucqrY64VRH3I7fBblABDBgYtDXmmWlgnBHE+tp4X+jwnPlVo65lmWDqMgkZlxZyFIQPltY2f8BP+Sq4I1HXwhIa+INdPN7X3h+PeNJeV4RqwXzg3WBrttQOSMfn7ybqEVVrDN+KQxi5j/89Scoi4czUoQ+62QRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725533955; c=relaxed/simple;
	bh=rfKTqev/OCaWUYTss80e6uXz1+rY15tw1voLxnk38Cw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bblKkeM+PM1X3ZrJMP63fLwVeqdns8Gn+tonO9MvN7JKF2YVs4mMlQwAmpHxiNdXpeX0YIKA82JBMy0TLhyNFB8ZiEeqDgAdlSzkAX1ugQGOyudNtVTghezWmBv6qhymEEba5zXE4ibdf0CSB4ddwMZpICDPM0TAap57oV/dApQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGlh9/Gm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGlh9/Gm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2719C4CEC3;
	Thu,  5 Sep 2024 10:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725533955;
	bh=rfKTqev/OCaWUYTss80e6uXz1+rY15tw1voLxnk38Cw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ZGlh9/Gm6UA1CVxsO7uYWsKlfhQz9lcoNqehm68mPa3Ph5+Yh/tEjeaqbcWxRre1t
	 8PrMqCzaONc2FeFjB0Or5by3Z1HIs2YuIUc5v2pSAQp3bR658QdysSU/jQiux4J1pp
	 5aTUWma6QiQ4cTQrpFAeFMVCn0+owI3slX2PbKASATIFJJNc5NjcucSRyvDezNzyw2
	 v2dPqGfitEF7bibqhUr0jaNXCtQ3q0j3ZecUKSoVitEu5RtHLMoraLL0N749lk+dQr
	 uIbP6CpVovZyPiE41qcmedR7HejqBigBlJ8Cr8sMPcQ4ETfcvZJYUPb3ouuIezmx91
	 Q8oWhf/HLce7A==
Message-ID: <2466edbcaa6c6031e35270ecc359c92873cf259f.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v8 0/4] fixes for "new MPTCP subflow subtest
 v4"
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Thu, 05 Sep 2024 18:59:06 +0800
In-Reply-To: <0d421ac2-173c-4ab4-9b95-95c9251acbd8@kernel.org>
References: <cover.1725502822.git.tanggeliang@kylinos.cn>
	 <0d421ac2-173c-4ab4-9b95-95c9251acbd8@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Thu, 2024-09-05 at 12:29 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 05/09/2024 04:26, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > v8:
> >  - drop bpf_printk, use different errnos (-1, -2) instead for
> > debugging:
> > 
> > run_subflow:FAIL:getsockopt(client_fd, SO_MARK) unexpected error: -
> > 1 (errno 1)
> > run_subflow:FAIL:getsockopt(client_fd, TCP_CONGESTION) unexpected
> > error: -1 (errno 1)
> > run_subflow:FAIL:getsockopt(client_fd, SO_MARK) unexpected error: -
> > 1 (errno 2)
> > run_subflow:FAIL:getsockopt(client_fd, TCP_CONGESTION) unexpected
> > error: -1 (errno 2)
> > 
> >  - move more duplicate code into _getsockopt_subflow.
> 
> Thank you for the new version! Now in our tree. Because there were a
> few
> squashed-to patches + additional corrections + conflicts, please
> check
> that the export branch looks OK now.
> 
> New patches for t/upstream:
> - a46e44a2ac5b: "squashed" patch 1/4 in "selftests/bpf: Add mptcp
> subflow example"
> - df1c9da900a8: tg: remove t/selftests-bpf-Add-mptcp-pm_nl_ctl-link
> 
> - f259c76495da: selftests/bpf: Add getsockopt to inspect mptcp
> subflow:
>   + updated commit message
>   + added mptcp_bpf.h file
>   + adapted MAINTAINERS file
>   + added comments in mptcp_bpf.h about the origin + modifications
> - 6efeaa2ddfaf: conflict in t/selftests-bpf-add-bpf_first-scheduler
> - 52d77c8981d3: conflict in t/selftests-bpf-Add-bpf_bkup-scheduler
> 
> - 5daceaf2c412: "squashed" patch 3/4 in "selftests/bpf: Add mptcp
> subflow subtest"
> - a1f7132c9bad: Also drop _ss_search()
> 
> - d2064c588b9f: "squashed" patch 4/4 in "selftests/bpf: Add bpf
> scheduler test"
> 
> - Results: df250dc71896..fb68bc3776eb (export)
> 
> Tests are now in progress:
> 
> - export:
> https://github.com/multipath-tcp/mptcp_net-next/commit/51e2be27cea9c5e4dd17b25cade6fcaf055daf52/checks
> 

This error occurs:

progs/mptcp_bpf.h:53:1: error: redefinition of 'mptcp_subflow_tcp_sock'
   53 | mptcp_subflow_tcp_sock(const struct mptcp_subflow_context
*subflow)
      | ^

mptcp_subflow_tcp_sock() needs to be drop from "selftests/bpf: Add
bpf_rr scheduler & test".

Thanks,
-Geliang

> 
> Cheers,
> Matt

