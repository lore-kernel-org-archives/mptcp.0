Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D44134A7
	for <mptcp@lists.linux.dev>; Wed,  5 Jul 2023 17:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD52C433C7;
	Wed,  5 Jul 2023 17:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688579591;
	bh=50wZnD7dDcv1AZT47SAkX55b8nYldQ+oV9xqe5PlPuc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=a+nT8ykkiVzFfvTnSehDfgx8o3KNfnxFfYF/UXekfSGT2tqjv5YSnpgUFJDZLkIiN
	 dYo61W6aR9Ya+QRGqVBt0jrbpaHcykTiGbXIrtAwZ6gMbJbTyWit5ZnR7p/cQAAnku
	 K2usK5pcLzAwjCVgRoXsNts2Mpec5+FFMZBn+8+Da8KgpVKPV0JRM6KmxEZ0e8Me4p
	 whTbxyS2Kzp+kxQpi63+B+b7gObUoe8B9XwGTNr6JGzLsOnZsjJq8pk3Avc6TBptHF
	 +fwcWtQWCOK8qhYK9qEX1ZlkAG+lG6sDVUIcYJfhuDkOE+JoyiWXWKicYHk0ZZ7BDk
	 gT2eCxfsi860A==
Date: Wed, 5 Jul 2023 10:53:09 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v11 00/11] BPF packet scheduler updates part
 1
In-Reply-To: <0e153aab-5f76-c75e-677d-8a59ca4bc331@tessares.net>
Message-ID: <93281b63-b0b9-0dd8-663a-679269be9158@kernel.org>
References: <cover.1687827857.git.geliang.tang@suse.com> <0e153aab-5f76-c75e-677d-8a59ca4bc331@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 5 Jul 2023, Matthieu Baerts wrote:

> Hi Geliang, Paolo,
>
> On 27/06/2023 03:06, Geliang Tang wrote:
>> v11:
>>  - use sk_storage instead of mptcp_storage.
>>  - drop mptcp_storage.
>

sk_storage (and bpf_sk_storage_{get,delete}) are a very good solution for 
bpf scheduler data - thanks for finding that Geliang!

Glad that this is merged, appreciate the review by Paolo and Mattheiu 
applying the series.


- Mat

> Thank you for the patches and the reviews!
>> https://patchwork.kernel.org/project/mptcp/cover/cover.1665753926.git.geliang.tang@suse.com/ [1]
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/342
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/349
>
> Does this first part still close these two tickets?
>
> Now in our tree (feat. for other trees) + one extra patch and a squash
> of a squash. Please don't hesitate to check if everything has been done
> properly because there were quite a few manipulations to do :)
>
> - 8efabdbcaa2c: "squashed" patch 1/11 (with conflicts) in "mptcp: drop
> last_snd and MPTCP_RESET_SCHEDULER"
> - b0f6d5c5ae25: "squashed" patch 1/11 (with conflicts) in "mptcp: use
> get_send wrapper"
> - 9de04aa46c59: "squashed" patch 1/11 in "mptcp: use get_retrans wrapper"
> - Results: e77e1cb5a372..3fcf166a9c7e (export)
>
> - 6e930aa67c6e: "squashed" patch 2/11 in "mptcp: add struct mptcp_sched_ops"
> - Results: 3fcf166a9c7e..437c8b684629 (export)
>
> - f7e28c2443da: "squashed" patch 3/11 (with conflicts) in "mptcp: add
> sched_data_set_contexts helper"
> - 9dc7c0042a01: conflict in t/mptcp-add-scheduler-wrappers
> - Results: 437c8b684629..504bc1f2d42d (export)
>
> - Applied patch 4/11 with Paolo's ACK just before "bpf: Add
> bpf_mptcp_sched_ops"
> - 7f44744d88c6: mptcp: register default scheduler
> - Results: 504bc1f2d42d..d45b69d4109b (export)
>
> - 0c323c5cc341: "squashed" patch 5/11 in "bpf: Add bpf_mptcp_sched_ops"
> - Results: d45b69d4109b..1b64ad359430 (export)
>
> - 9ffacd26fad5: "squashed" patch 6/11 in "bpf: Add
> bpf_mptcp_sched_kfunc_set"
> - Results: 1b64ad359430..f95ddf57fd7e (export)
>
> - 8f050b24bd4d: "squashed" patch 7/11 in "selftests/bpf: Add mptcp sched
> structs"
> - Results: f95ddf57fd7e..b1bfdcd53258 (export)
>
> - a3eacd00bfb7: "squashed" patch 8/11 in "selftests/bpf: Add bpf_first
> scheduler"
> - Results: b1bfdcd53258..b80981f0543b (export)
>
> - bc7512c33473: "squashed" patch 9/11 in "selftests/bpf: Add bpf_bkup
> scheduler"
> - Results: b80981f0543b..e1dbf174936b (export)
>
> - 506feec3a419: "squashed" patch 10/11 in "selftests/bpf: Add bpf_rr
> scheduler"
> - Results: e1dbf174936b..c6edb7e5168c (export)
>
> - 151a85fd02ab: "squashed" patch 11/11 in "selftests/bpf: Add bpf_red
> scheduler"
> - Results: c6edb7e5168c..679a4538b06c (export)
>
> - 064c5746a0d9: "squashed" patch 12/11 (squash squash) in
> "selftests/bpf: Add bpf_rr scheduler"
> - Results: 679a4538b06c..255b06daaf0d (export)
>
> - cebedb75ff65: "squashed" patch 6/7 from BPF 'force to MPTCP' v4 series
> in "selftests/bpf: add two mptcp netns helpers"
> - Results: 255b06daaf0d..cde4fa6a0a5e (export)
>
>
> Tests are now in progress:
>
> https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230705T090903
>
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>
>
