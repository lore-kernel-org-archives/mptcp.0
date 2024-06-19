Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5823FD4
	for <mptcp@lists.linux.dev>; Wed, 19 Jun 2024 00:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718757665; cv=none; b=oiqiPPHl4yvxfi7Y/JLAnEDh/EFDx/lkUakn1iyH+d1ypU3vAvrqreZyWvorOwK1cysBpiBULV1NRpMt+w3WJ+lTMRTwYu8ZwEzCXy2NPii0EUxL2b/hID3GwAlBkC1nL7dhzZC4DLPGN+n7t4uOPgFNpJKQZtzcvLDFHe3esps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718757665; c=relaxed/simple;
	bh=TaOJakwlnwn/0Dt2aKHVPW9836z1OXyFxkLR4lCwiGk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gq4Q0c2VfgPfiG/URfljR+CktfvCAb7HoTAbqBM2vdqTJ5fRyyork/+a4wss/0bRdMqIlaSYlF5bjGg6zcPzhyoeMQbV3i/q6iTdYum8RtiCyFXqzpHcKuD8LjPBbH9vlfTdGF2wTDEa0LVEDDdz0/ytapIh+tkKlHOLT4UCyKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIbrl7vB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIbrl7vB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8BAC3277B;
	Wed, 19 Jun 2024 00:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718757664;
	bh=TaOJakwlnwn/0Dt2aKHVPW9836z1OXyFxkLR4lCwiGk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=WIbrl7vB7UAVLWpauDLS5GFascnJedvMIdCCBJ+uH8EsbfKD9843GdyQYyAtsjwh9
	 7HIzRCzebPVJGUXQwUzy9Gce4MDLGiYbl5BeOwcAUsJYQaZHL93dErEWOxhtIlg1//
	 KNYz6FAcbEESFAo2E3z+lIsJn9B2UFcrbpo6NQd5QbI2/HqJs6YTQtL3tysz09FfB7
	 emRhEo/exUMSGSE5NByHTLs8OSoBuCCk7xQM/1ETjm50PEy6pC2yfK78jkaikTDjmR
	 xTenRfNVVZ4AFdXGsJ+0hd8mH+jyYAcomTJ5YCHmRf6R/31hf8hNNEeptMcjkx4Uq+
	 iptRRT2Z7vUyg==
Date: Tue, 18 Jun 2024 17:41:04 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Gregory Detal <gregory.detal@gmail.com>
cc: MPTCP Upstream <mptcp@lists.linux.dev>, 
    Matthieu Baerts <matttbe@kernel.org>
Subject: Re: [PATCH mptcp-next RFC 0/4] mptcp: update scheduler API
In-Reply-To: <20240527-sched_per_packet-v1-0-09a41d405f7c@gmail.com>
Message-ID: <80f81101-e006-a3fc-dbd4-f4458fe9609c@kernel.org>
References: <20240527-sched_per_packet-v1-0-09a41d405f7c@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 27 May 2024, Gregory Detal wrote:

> This patchset proposes an updated API for mptcp schedulers to provide
> more flexibility for future scheduling strategies. This does not change
> the current behavior of get_subflow. It adds an optional hook to control
> scheduling behavior after selecting a subflow in get_subflow.
>
> The main idea is to provide a way to perform a scheduling per-MSS or per
> chunk of data. To demonstrate this, the mptcp_bpf_rr scheduler has been
> modified to send one MSS per subflow in an alternating fashion.
>
> The other potential application of this API could be to define a
> scheduler that will proactivelly reinject data on available subflows
> based on some heuristics (eg. when one subflow RTT increases when moving
> away from WiFi AP). It could also allow to limit the usage of a specific
> subflow, eg., in the case of high BDP.
>
> I am mainly looking for feedback to see whether this design make sense.
> Matthieu already did a quick pass on it.
>

Hi Gregory -

Sorry about the delay, thanks for working on this scheduler code!

> The API introduces a push() function (name TBD) that takes the subflow
> and data chunk (sequence number and length) as arguments. The scheduler
> can then control packet scheduling by:
> - Setting data transmission limits (e.g., per-MSS on a subflow or per window).
> - Setting flags associated with the data. Currently, only
>  MPTCP_SCHED_FLAG_RESCHEDULE is defined, forcing the scheduler to call
>  get_subflow after sending the chunk.
>
> I am envisioning another flag MPTCP_SCHED_FLAG_REINJECT that will ensure
> that chunk of data can be rescheduled directly on another subflow.
>
> I've written some packetdrill tests to validate the update RR scheduler
> the test are available on my fork:
>
> https://github.com/gdetal/packetdrill/tree/mptcp-net-next/gtests/net/mptcp-bpf/round-robin
>
> Open questions:
> - Is the current API for setting flags and limits appropriate? What are
>  eBPF best practices to pass back information to kernel ?

I think the approach of using a regular u16 for the flags and preprocessor 
constants like MPTCP_SCHED_FLAG_RESCHEDULE isn't a good fit for eBPF. The 
main reasons I see:

* The user's eBPF code can set any combination of bits in the u16 flags 
without the kernel automatically checking that those bits are 
known/expected.

* The flag values as preprocessor constants can't be represented in BTF 
format to allow compiling the BPF scheduler using type information from 
the kernel (rather than manually setting those #defines in the scheduler 
code).

Even though it's not as space-efficient, I think individual struct members 
would be better than an integer bitfield for this kind of flag. Then the 
struct_access hook can check what's supported at load time.

> - should get_scheduler and this new API be merged somehow as to provide
>  a single way of scheduling data ? Eg. could pass chunk and return
>  flags, limit and subflow to send this data to.

Yes, I think it would be good to consolidate get_scheduler and the new 
API, so two calls out to the BPF scheduler are not required for each 
packet. It's ok to change the internal scheduler APIs, and I think that 
will be required to support reinjection.

- Mat


>
> Co-Developed-By: Matthieu Baerts <matttbe@kernel.org>
> Signed-off-by: Gregory Detal <gregory.detal@gmail.com>
> ---
> Gregory Detal (4):
>      mptcp: add push sched callback
>      mptcp: use new push callback to schedule chunks
>      mptcp: bpf: allow to write to mptcp_sched_chunk
>      selftests/bpf: mptcp RR: send 1 MSS on each subflow
>
> include/net/mptcp.h                              | 29 ++++++++++++++++++++++++
> net/mptcp/bpf.c                                  | 25 ++++++++++++++++++--
> net/mptcp/protocol.c                             | 14 ++++++++----
> net/mptcp/protocol.h                             |  9 ++++++++
> net/mptcp/sched.c                                | 20 ++++++++++++++++
> tools/testing/selftests/bpf/progs/mptcp_bpf.h    |  1 +
> tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c | 18 +++++++++++++++
> 7 files changed, 110 insertions(+), 6 deletions(-)
> ---
> base-commit: c98f8dc106a6d6c4424f2e612762821e1be14bf0
> change-id: 20240503-sched_per_packet-d6e4488e54e8
>
> Best regards,
> -- 
> Gregory Detal <gregory.detal@gmail.com>
>
>
>
