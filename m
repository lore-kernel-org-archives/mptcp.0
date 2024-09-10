Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64809188013
	for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960471; cv=none; b=Un1H+t3/i5jRhTlWGa25rjioCRHXEiSfcOV5FhI/9Z1KhNLNBUW7g0IIg5QDX26dpleTna5gFmv1Az9fxSku5LhntJj94wIOrITuXRhv+fZHFXQu9n2kN+cBbG9QOYj7x7HhVHOBmFoaIwVCI9xcer0rE3rYoLZFLU011YPYNeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960471; c=relaxed/simple;
	bh=0cqIFJl0dhjxBt37HiWcuyOPMfbUz5LQx/bWiTRHxVY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X8JWqce57ijKwXs7zZaSQo3L3cXtbpPwrrT0FVP7p5LiGzmIFoWdyw5bVH9uEVAysHeZRtilPe4HdZGSJrTY+Ph9HLcNIyNux7La5PQ4GHGBtYoO4jNQcTu+bNQF6MyRUmHBPFtMjNMZfIIBQs5nXigk21WZC2XvNsSb2yQRpF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7KtC5/g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7KtC5/g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E75C4CEC3;
	Tue, 10 Sep 2024 09:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725960471;
	bh=0cqIFJl0dhjxBt37HiWcuyOPMfbUz5LQx/bWiTRHxVY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=E7KtC5/gKV5l7Bli+2Zvqbli+mco+OgZMEUHYfd7/8qlbtFdOK667C8TNdDIMKXNa
	 gpH+zIMEjcScKi5sIy/lf+bG09Y/zKmqc5ewT7DiRSzI/jViUBlzKUccV4Wb62DmQK
	 j99GeWO2CFle7n56xJtGpH5SbCj/k/tbhSRYJjfvUAkG1g0FPoywemW+2jaD/NlW4d
	 eE2OpDF+h2jCCX6mmcTXJ5Fewb+rntrsE7f3yahJAdAu1N4LzKZZYlWBRTB3T8HRxe
	 sqxSnzKIjsDBpt/gMCQkeN3x8yzU1gl9Z6Qz6FzlEWNUyMxEUlC2Vg4PtzGxlgsOii
	 j476a/NpVz8Iw==
Message-ID: <72458d8097fa7ee4f8b783c51ec70376fc1234e2.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 1/2] Squash to "bpf: Add mptcp_subflow
 bpf_iter"
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Tue, 10 Sep 2024 17:27:46 +0800
In-Reply-To: <a1822c37-3c2d-4865-848c-e6d92fa439aa@kernel.org>
References: <cover.1725958296.git.tanggeliang@kylinos.cn>
	 <cb7ca604cdc487d1f9a2f03a3a14904b003227fd.1725958296.git.tanggeliang@kylinos.cn>
	 <a1822c37-3c2d-4865-848c-e6d92fa439aa@kernel.org>
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
Content-Transfer-Encoding: 7bit

Hi Matt,

On Tue, 2024-09-10 at 11:12 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 10/09/2024 10:53, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Register mptcp_subflow bpf_iter helpers in common_btf_ids in
> > kernel/bpf/helpers.c, then they can be used on a larger scale,
> > not only in types BPF_PROG_TYPE_TRACING and
> > BPF_PROG_TYPE_STRUCT_OPS.
> 
> Why could they not be used in these types? I find it good to have
> them
> defined in net/mptcp, from a maintenance point of view.
> 
> Also, the different bpf_iter_xxx helpers defined there look generic.
> While here, it is specific to MPTCP, I'm not even sure that would be
> OK
> to add them there. Is it not OK to define them only in
> net/mptcp/bpf.c?

Yes, a new test for #484 (BPF: setsockopt on an MPTCP socket: check
support) will use these helpers in "cgroup/setsockopt", that is the
BPF_PROG_TYPE_CGROUP_SOCKOPT type.

register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCKOPT,
		&bpf_mptcp_sched_kfunc_set);

will fail, since BPF_PROG_TYPE_CGROUP_SOCKOPT is not allow to register
more kfuncs (see bpf_prog_type_to_kfunc_hook() in kernel/bpf/btf.c).

So I have to move them into common_btf_ids in kernel/bpf/helpers.c to
allow them can be used in almost every BPF program type.

Thanks,
-Geliang

> (or at least for the moment)
> 
> Cheers,
> Matt

