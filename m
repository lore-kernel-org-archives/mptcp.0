Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A9D3A8F7
	for <mptcp@lists.linux.dev>; Fri, 19 Apr 2024 09:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520698; cv=none; b=t9rP5tmRXkvtATImupV8G53itbIl8AckfhIIciVtEqjt0+e0BEWznmscx3iqUD853ECqK2o5VYN8rQ+jU7C9pD9gbkjdgteEjn//CeCj4SwInJBZ0m8lBtuMASgGsWXHWLW/wtRLyRFXh9bOm/vOvTc4mTedHAyylCLm1aLzDUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520698; c=relaxed/simple;
	bh=a3AEkYXcfF2bb4YEstX4JBFS6Sd+K7YVOb5VmofW3PU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TL6ijHfCKOLriqe4mkX6/Ifqftk/sI1128PcGQWPftl3W8vY+R6aoNXYLX44AVVRgA1KZwz+O6il0TUAuth0hZuoJ+zccy8SKXnptClMGjPlVQXIN2wqOR9/NsvmL/hNxcS/apC4Kcz8qPp2Quuqpd+acD49bo3RbtLHcWfhV6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hb8TLM4y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hb8TLM4y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E97C072AA;
	Fri, 19 Apr 2024 09:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713520697;
	bh=a3AEkYXcfF2bb4YEstX4JBFS6Sd+K7YVOb5VmofW3PU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Hb8TLM4yP/t5x38U1Wvy4Z9doR6BsCHuIOpQq62VlkC2rpAlYTOp0HR1GQ6kkAjWd
	 zzx2HEPaF15xwgWJPZqxRlSI7lErGZGB7IgK4kh/QjodMnkh/pmDv+FRwTdzKMBBEl
	 +u57cbodmz9FKyXRqGF9pcvRi7Pt1M/oj2ac/uR52I0CYpkDuBzMh0gROnqJq0CuCz
	 zkU8tUdrGvLDbGUS16cSDTHbNlPgjbIgc756shwhpPKqoBswW4UyHGhEBWgCxC6/Ko
	 /ce/jfnEcpGsgfz1LHKK00lD+ETUB43/n5IUgDpvqmZu5Al2H6mtA0RvpaT8mxQQwY
	 JHmel08OoNqBw==
Message-ID: <10659d84-5d60-4a0f-84d9-859ad39a23f5@kernel.org>
Date: Fri, 19 Apr 2024 11:58:14 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v9 0/8] refactor mptcp bpf tests
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1713321357.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <cover.1713321357.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 17/04/2024 04:38, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> v9:
>  - extract a new helper test_bpf_sched() from MPTCP_SCHED_TEST() to make
>    the macro simpler as Mat suggested. (thanks)
>  - squash MPTCP_SCHED_TEST() into "selftests/bpf: Add bpf_first
>    scheduler & test", not "selftests/bpf: Add bpf scheduler test" to
>    avoid a build error "test_bpf_sched is not used".
Thank you for the v9, and the review!

@Geliang: there were a lot of Git (TopGit) manipulations here, please
check that the result is the expected one.


New patch for t/upstream:

- d0432b7d2bb0: selftests/bpf: Add RUN_MPTCP_TEST macro
- 9791281821ba: conflict in t/selftests-bpf-Add-bpf-scheduler-test
- 92efb2a19752: conflict in t/selftests-bpf-add-bpf_first-test
- 78858b124aee: conflict in t/selftests-bpf-Add-bpf_bkup-test
- e25a04564f65: conflict in t/selftests-bpf-Add-bpf_rr-test
- d474c99c9c56: conflict in t/selftests-bpf-Add-bpf_red-test
- 0091786b07e3: conflict in t/selftests-bpf-Add-bpf_burst-test
- Results: eb9a8fbc1cd3..6ad6176a437b (export)


Squash-to patches:

- da0ce2d96df7: "squashed" "1 verify" (with conflicts) in
"selftests/bpf: Add bpf scheduler test"

- d08d36c72f3e: "squashed" "2 time" in "selftests/bpf: Add bpf scheduler
test"
- f9800e6dbb07: conflict in t/selftests-bpf-add-bpf_first-test

- d910fb60db22: "squashed" (with conflicts) in "selftests/bpf: Add
bpf_first test"
- 6723021b9a04: "squashed" "2 strlen" in "selftests/bpf: Add bpf_first test"
- 1bcf273624e6: "squashed" "3 err msg" in "selftests/bpf: Add bpf_first
test"
- 20df6c66a4bf: conflict in t/selftests-bpf-Add-bpf_bkup-test

- 6f9d19a73d33: "squashed" (with conflicts) in "selftests/bpf: Add
bpf_bkup test"
- 9c86e3027008: conflict in t/selftests-bpf-Add-bpf_rr-test

- 2bbbcc6cc7c1: "squashed" (with conflicts) in "selftests/bpf: Add
bpf_rr test"
- 3bdb5c116569: conflict in t/selftests-bpf-Add-bpf_red-test

- 9eb2410e20b4: "squashed" (with conflicts) in "selftests/bpf: Add
bpf_red test"
- 55e93f797697: conflict in t/selftests-bpf-Add-bpf_burst-test

- 9004d2b898a4: "squashed" (with conflicts) in "selftests/bpf: Add
bpf_burst test"
- Results: 6ad6176a437b..665448084780 (export)


Squash "sched & test":

- 57731e73cc97: tg:squash: bpf_first sched & test
- 45b46aeeb072: tg:msg: update after squash

- a5a572331f7c: tg:squash: bpf_bkup sched & test
- d89c4282bf53: tg:msg: update after squash

- 44155448f992: tg:squash: bpf_rr sched & test
- 702454c6ba93: tg:msg: update after squash

- 71681fc66d24: tg:squash: bpf_red sched & test
- a15a6438bcbd: tg:msg: update after squash

- 297175c89808: tg:squash: bpf_burst sched & test
- c4624cdf779e: tg:msg: update after squash
- Results: 665448084780..c23ad453d8cc (export)


While at it, I also updated your email address:
- dbec7401465d: tg:msg: update Geliang's email address
- facd3cec3d0a: tg:msg: update Geliang's email address
- 59127f756c66: tg:msg: update Geliang's email address
- c20d79792bb2: tg:msg: update Geliang's email address
- 5f3d6b7755a2: tg:msg: update Geliang's email address
- 05efce6832cb: tg:msg: update Geliang's email address
- becd15a77346: tg:msg: update Geliang's email address
- e2b1e31d7720: tg:msg: update Geliang's email address
- a3bcc475f994: tg:msg: update Geliang's email address
- 699e0dbd591c: tg:msg: update Geliang's email address
- 2d5b66a3675f: tg:msg: update Geliang's email address
- 1df821d94ac8: tg:msg: update Geliang's email address
- 7a0adfdb70d0: tg:msg: update Geliang's email address
- cce49572147a: tg:msg: update Geliang's email address
- fff8347933fd: tg:msg: update Geliang's email address
- 6118caa31040: tg:msg: update Geliang's email address
- 6603ca35adf6: tg:msg: remove my SoB
- Results: c23ad453d8cc..f0f388aa6196 (export)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

