Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6A47E
	for <mptcp@lists.linux.dev>; Mon, 23 Oct 2023 00:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqqMy8NC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4258DC433C8;
	Mon, 23 Oct 2023 00:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698019935;
	bh=/HO9U73Ff/R0rvqdDk5bxaQdUNzXHS0trVextDf7Ta0=;
	h=Date:To:Cc:From:Subject:From;
	b=KqqMy8NC1RAu+peA1ydzCieP0KudRyXyG82UjRbKqQtzjmTfwryMso1MydMONtwE7
	 IKmGOb59VOZH2IcW+jKSYrlLZ6D0i5G2vrRPMKKjDiYRW6px09Pemv7q+8R3cB2Uat
	 0jRLIttymcAGhUkOtq80Rson8uBsQ6nDXVRoBjrnehBmNHLQWSxb2R8oTCO82xxbhf
	 vTq1qFEtiIwLUn8kmeFw/J6P6p4XBtOjbQrJ/tBXmsD0iFgY88AHz09pGvL4/+OyX9
	 JYJdiNj02Knwi42iqAUfTXESPah0FAf8QUd17wqtvxdvfQDNvnnjoAaAAWtda026oD
	 zzcpkFYxPb4Hg==
Message-ID: <ee535704-52c3-48a5-9893-c195f7975e64@kernel.org>
Date: Mon, 23 Oct 2023 02:12:12 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB, fr-BE
To: Mat Martineau <martineau@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Paolo Abeni <pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Subject: Patches for netdev (for 6.7)
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 Fe7fduHbABmYz9cefQpO7wDE/Q==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

Regarding the patches we might want to send to netdev this week, I think
all the ones for -net and net-next can go.

- Fixes for -net:

    - selftests: mptcp: run userspace pm tests slower (Geliang Tang)
    - selftests: mptcp: fix wait_rm_addr/sf parameters (Geliang Tang)
    - mptcp: userspace pm send RM_ADDR for ID 0 (Geliang Tang)


- Features for net-next:

    - mptcp: add a new sysctl for make after break timeout (Paolo Abeni)

    - tools: ynl: add uns-admin-perm to genetlink legacy (Davide Caratti)
    - tools: ynl-gen: add support for exact-len validation (Davide Caratti)
    - net: mptcp: convert netlink from small_ops to ops (Davide Caratti)
    - Documentation: netlink: add a YAML spec for mptcp (Davide Caratti)
    - uapi: mptcp: use header file generated from YAML spec (Davide Caratti)
    - net: mptcp: rename netlink handlers to
mptcp_pm_nl_<blah>_{doit,dumpit} (Davide Caratti)
    - net: mptcp: use policy generated by YAML spec (Davide Caratti)

    - mptcp: properly account fastopen data (Paolo Abeni)
    - mptcp: use plain bool instead of custom binary enum (Paolo Abeni)
    - tcp: define initial scaling factor value as a macro (Paolo Abeni)
    - mptcp: give rcvlowat some love (Paolo Abeni)
    - mptcp: use copy_from_iter helpers on transmit (Paolo Abeni)
    - mptcp: consolidate sockopt synchronization (Paolo Abeni)
    - mptcp: ignore notsent_lowat setting at the subflow level (Paolo Abeni)
    - mptcp: refactor sndbuf auto-tuning (Paolo Abeni)

    - mptcp: drop useless ssk in pm_subflow_check_next (Geliang Tang)
    - mptcp: use mptcp_check_fallback helper (Geliang Tang)
    - mptcp: use mptcp_get_ext helper (Geliang Tang)
    - mptcp: move sk assignment statement ahead (Geliang Tang)
    - mptcp: define more local variables sk (Geliang Tang)
    - selftests: mptcp: sockopt: drop mptcp_connect var (Geliang Tang)
    - selftests: mptcp: display simult in extra_msg (Geliang Tang)

    - mptcp: add mptcpi_subflows_total counter (Geliang Tang)
    - selftests: mptcp: add evts_get_info helper (Geliang Tang)
    - selftests: mptcp: add chk_subflows_total helper (Geliang Tang)
    - selftests: mptcp: update userspace pm test helpers (Geliang Tang)
    - selftests: mptcp: userspace pm create id 0 subflow (Geliang Tang)
    - mptcp: userspace pm rename remove_err to out (Geliang Tang)
    - selftests: mptcp: userspace pm remove initial subflow (Geliang Tang)
    - selftests: mptcp: userspace pm send RM_ADDR for ID 0 (Geliang Tang)

    - selftests: mptcp: add mptcp_lib_kill_wait (Geliang Tang)
    - selftests: mptcp: add mptcp_lib_is_v6 (Geliang Tang)
    - selftests: mptcp: add mptcp_lib_get_counter (Geliang Tang)
    - selftests: mptcp: add missing oflag=append (Geliang Tang)
    - selftests: mptcp: add mptcp_lib_make_file (Geliang Tang)
    - selftests: mptcp: add mptcp_lib_check_transfer (Geliang Tang)
    - selftests: mptcp: add mptcp_lib_wait_local_port_listen (Geliang Tang)



Just a few notes:

In -net, 2 patches introduce conflicts with what is queued for net-next:

- "selftests: mptcp: fix wait_rm_addr/sf parameters" conflicts with:
  - "selftests: mptcp: update userspace pm test helper"
    → the patch fixes the same issue but in different functions

- "mptcp: userspace pm send RM_ADDR for ID 0" conflicts with:
  - "net: mptcp: rename netlink handlers to
mptcp_pm_nl_<blah>_{doit,dumpit}"
    → the conflict is easy to fix: we want to put a function before one
that is being renamed

  - "mptcp: define more local variables sk"
    → also easy to fix: one line in the context that has changed

Because these fixes don't seem critical and because we are getting
closer to have a new release, I think it might be better to send these 3
fixes with the new feature (but keep them at the beginning of the
series). I guess if a note is added in the cover-letter message
explaining it is easier like that, and it is fine to delay the fixes, it
should be OK. WDYT?

Also, about the MPTCP NL YAML specs series where a v2 was needed: it
looks OK to me, but I don't know if Paolo wants to double-check the last
modifications from Davide before sending them. There is a conflict with
one patch from this series and one for -net (see above). I think it
might be better to send this YAML specs series first, then the other
patches.

I think Paolo's patches for net-next can be sent in parallel to Davide's
patches.


Do you think you can send all these patches, please? :)

Cheers,
Matt
