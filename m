Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7193C286A9
	for <mptcp@lists.linux.dev>; Fri, 23 Jan 2026 13:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769175237; cv=none; b=eV6HGroJqXVyuWhx26YRCH0bWUeimBeR82DZbbTS3gGW+oHgvLDjcguY0ZfW1swArRD0YJ/UDVzMPrwGnPh9qew0i+RS/SL2H8O/AQUV/wDZr4YH0S8ozMa/srfh5jjJLl2NEZ3cclMDF0l133ghYL48tT01BuCya/B0QbPx/sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769175237; c=relaxed/simple;
	bh=75ICJCxKbgxNvQjzhyzFGLxCPhUa/JywXja4HxjERvo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=k9zoZpTclSCNJa7E8sKCWyKHSB4f2Qmatdg7V+aTpI7bXp8qowYmhtgDHQxGCiu18ZUYAGheU6GtKQec3X+MUErqVZeFvXx8YZzakH4gMxq/EwMJm5r8TO2rJZ4e26fKOBm0R49HkaW+k3oSA+Q/S0/2yoFsRERsmRvnwFnd7BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHPMO9Hm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHPMO9Hm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7F3C4CEF1;
	Fri, 23 Jan 2026 13:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769175237;
	bh=75ICJCxKbgxNvQjzhyzFGLxCPhUa/JywXja4HxjERvo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=hHPMO9HmBXluxca7kXUqu/pqCjYFD6TOfIMx254Tbka7eL4rK/5JK9G8YMD2YP6jG
	 AqZ/X1TxvKNS1VXuKqRk9DZI/U/0B7xP13uN3w8+98ZGjKsBjQSOYMSDnJAi1po0YO
	 2rNo1R1gYgQ7pgjXSebZgQcgscTLUQh4gz6+IgMPasvuH6vzUKdS/juZt3MTKdgxp5
	 1Ugbze/68fQxJkF7YDNn7Iyr+14O3r053YvetL/5sjZXCWNPyHr4AxVLDKTrfG5zaw
	 9cJOkbWd783wVI3reVO8UHrp+CBpvOK6xg9XnOcPlT7DVVXv0e0Q5u/yA+x72uyO/W
	 IV5eNLXnuuKEw==
Date: Fri, 23 Jan 2026 14:33:52 +0100
From: Matthieu Baerts <matttbe@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: mptcp@lists.linux.dev
Message-ID: <5ffec702-b8e5-4864-95ae-d4c94357dc04@kernel.org>
In-Reply-To: <CANn89iJ+c=_DdT5CPj4Zxfhx__gKOeNjBhQuOaBqOgkR7ugkdQ@mail.gmail.com>
References: <20260123030327.3041148-1-edumazet@google.com> <f146d0f7-1d16-e749-04a9-05a79d1ddf98@gmail.com> <CANn89iJ+c=_DdT5CPj4Zxfhx__gKOeNjBhQuOaBqOgkR7ugkdQ@mail.gmail.com>
Subject: Re: [PATCH v2 net] mptcp: fix race in
 mptcp_pm_nl_flush_addrs_doit()
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <5ffec702-b8e5-4864-95ae-d4c94357dc04@kernel.org>

Hi Eric,

Thank you for having looked at this and sharing this fix.

23 Jan 2026 12:36:37 Eric Dumazet <edumazet@google.com>:

> On Fri, Jan 23, 2026 at 12:03=E2=80=AFPM MPTCP CI
> <wpasupplicant.patchew@gmail.com> wrote:

>> Our CI did some validations and here is its report:
>>
>> - KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 faile=
d test(s): selftest_simult_flows =F0=9F=94=B4
>
> This seem a flake ?

Yes it is, and due to a commit ("mptcp: better mptcp-level RTT
estimator") which is only in our tree (used by our CI), see:

https://github.com/multipath-tcp/mptcp_net-next/issues/607

Sorry, I didn't have the opportunity to find a solution for that.

Regarding your patch, it looks like it is corrupted. Both NIPA and
Patchew are complaining about it:

=C2=A0 Applying: mptcp: fix race in mptcp_pm_nl_flush_addrs_doit()
=C2=A0 error: corrupt patch at line 15
=C2=A0 error: could not build fake ancestor

"git am" complains, but it is OK to manually apply it with "patch". Any
idea why? If you are not available, do you want me to resend it later
on?

Cheers,
Matt
