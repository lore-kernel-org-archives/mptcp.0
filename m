Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C23A3A3816
	for <mptcp@lists.linux.dev>; Mon,  1 Jun 2026 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780312836; cv=none; b=u8bUKIfU19AHniiT8HvkWjanDh+Re1meDzG06QZTWXrci+6R1e5Y9QaYN6Zqh8xZpGQ9BL5yo70qlvgns9KY34v3CFSiUkaOVhwcX+ib1oggR1fT7G9Qi0UwcHgmigS04w6TR8+jEfYucAEdf/RiNo8sUg22n+sHZ9fWqw87sOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780312836; c=relaxed/simple;
	bh=ebbB57HptqmEwoffo5UxzsYuHpu0KHC4VMGfwMHbzKk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=rr3mKN7Qixfnp6OskV+s8WxyxpdrwycrqweC2vPDq61QtRWoA+W/7np2jeQoPF9qsvDiDJle0nfzjFtJSqTWVdI1eVmMTCjzr5G3YVXEESWIMNwXvbsg3lIB6dxZFsgqeayjKyAjln+CCFu0dn4q8Ub/c7tX3dqKbZUkMNRrUcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrsVdw3i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrsVdw3i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C3D1F00893;
	Mon,  1 Jun 2026 11:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780312835;
	bh=ebbB57HptqmEwoffo5UxzsYuHpu0KHC4VMGfwMHbzKk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=PrsVdw3iIj7UpzVSm7E6+qCCvn+N4uV51EShMVEFJh3objS0uTD8HxSPAcUasZWXT
	 vSxpW7uGFgKiD6X1hfxiR7u9vhbQhugUMQIZAeXQHqofRy6E5UB37jz0ie1i7Ty3Gq
	 s65ghTBKbdmU0oFNrLFCwqpw2K7sYj8gA7m8SbBaUQqPyCvOMl0yIOtwLqiqy1XE3k
	 D+VKOUYfCJHniiutG1za5piWT+nPAfP97XCy4chr2RRoDA9tVYbvKtpoTt2nu4b1W1
	 CheYX/yBsTbDi2JtlMNdFP6G8+xN4FPJvQsizbIGzXgKu/J2ncOuf6rMprRLpV+0Q2
	 LFYk/W2frX5uA==
Date: Mon, 1 Jun 2026 21:20:27 +1000
From: Matthieu Baerts <matttbe@kernel.org>
To: mptcp@lists.linux.dev
Cc: Eric Dumazet <edumazet@google.com>
Message-ID: <ac55ea06-77eb-41f6-86cd-4faa2a36b6df@kernel.org>
In-Reply-To: <a224861f-92f5-d645-fdf3-9cb533f914b0@gmail.com>
References: <7a377984-5a2e-4981-96dc-c76076f93f4a@kernel.org> <a224861f-92f5-d645-fdf3-9cb533f914b0@gmail.com>
Subject: Re: [PATCH net-next] mptcp: change mptcp_established_options() to
 return opt_size
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <ac55ea06-77eb-41f6-86cd-4faa2a36b6df@kernel.org>

Hello,

01 Jun 2026 21:13:02 MPTCP CI <wpasupplicant.patchew@gmail.com>:

> - KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed=
 test(s): packetdrill_add_addr =E2=9A=A0=EF=B8=8F

FYI, this failed test is expected: the patch has been applied on an
older base to avoid conflicts, and these tests depend on new features.

Cheers,
Matt
