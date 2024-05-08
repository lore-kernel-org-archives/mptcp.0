Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020E84C61F
	for <mptcp@lists.linux.dev>; Wed,  8 May 2024 11:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167203; cv=none; b=pXe415eoNvsrBT9frS0aHM79j/gmW9yIR1+uKci6v+CXFzJCivuSd2HAG1eELzRQgi87tzb0tBg1LhU3ukKIZhES2koBopH5o8imesbOnh64mJKByqTuueRq42QqrLQ5b4jRBLERVACczl9Y4Evkn6+pKksDNGtnIGOyot3Tbdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167203; c=relaxed/simple;
	bh=cPUKJUiNlYeUhQ5YdeYGS6oQPf7eHps4PVllXu5KcDo=;
	h=Message-ID:Date:MIME-Version:From:Subject:References:To:Cc:
	 In-Reply-To:Content-Type; b=kSG5rvJ4M3VsnZKme2aREUi6Ph0IgC3xoOYyl0KmXO3E/k6t4u+/rpnCI1kJ3HPMZMnESq1EQ2IXZqkwyfF5hfEDsOll8WlB2r3mhu73Al5LzdZ/Iwd7Sume8KwRDHC5E0shGdCi20QBJi0ygXvFyn3La+FrCZFF35wKycEByig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1fTxr9F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1fTxr9F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CEFCC4AF17;
	Wed,  8 May 2024 11:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715167202;
	bh=cPUKJUiNlYeUhQ5YdeYGS6oQPf7eHps4PVllXu5KcDo=;
	h=Date:From:Subject:References:To:Cc:In-Reply-To:From;
	b=P1fTxr9F4FAsY4uA0cf9pJW2uUe9bOMQzq4wXK9j4oWXr5yNYe12xqnmPo0Gf5olQ
	 qToXmSg/LN8+ZD5uIYVuUzH3MdIjFrl0XcXtzMNXvEoAdSV/aoPBNh4s4Cq9yMK6Q4
	 zf7FCZc3hgPEKbJox8Wm46RFczBwNSnrORNgM1NWRr8lWFGwEblsWHcjKc+8AdFc8R
	 uwclJqFQuxLrrwFm8CEROmmwktvGuh38mk6jvUbyOCPkFuSOz+AN93g6AB5LUAbG4m
	 63XKNPw8tf9nSHc/bHQU6P0hueF73NsbpN/F15HxZboQcDavx+KQ/1g/VPX1TfFNrD
	 VssH7++Ri24Yw==
Message-ID: <7b052697-15e1-425c-8127-7adfaca28c4b@kernel.org>
Date: Wed, 8 May 2024 13:20:00 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Matthieu Baerts <matttbe@kernel.org>
Subject: Multipath TCP (MPTCP) support in OpenSSH
Content-Language: en-GB
References: <52bdf14c-1c1a-411d-a72c-28e7596806da@kernel.org>
To: openssh-unix-dev@mindrot.org
Cc: Olivier Bonaventure <Olivier.Bonaventure@uclouvain.be>,
 Dorian Craps <dorian.craps@student.vinci.be>,
 Christoph Paasch <cpaasch@apple.com>, Mat Martineau <martineau@kernel.org>,
 MPTCP Upstream <mptcp@lists.linux.dev>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <52bdf14c-1c1a-411d-a72c-28e7596806da@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

First, thank you so much for developing and maintaining this very useful
project!

I'm currently involved in a project around Multipath TCP (MPTCP) [1].
MPTCP, standardized in RFC8684 [2], is a TCP extension that enables a
TCP connection to use different paths. Multipath TCP has been used for
several use cases. On smartphones, MPTCP enables seamless handovers
between cellular and Wi-Fi networks while preserving established
connections. This use-case is what pushed Apple to use MPTCP since 2013
in multiple applications [3]. On dual-stack hosts, Multipath TCP enables
the TCP connection to automatically use the best performing path, either
IPv4 or IPv6. If one path fails, MPTCP automatically uses the other path.

A long requested feature we got, is to have a native MPTCP support in
OpenSSH. It is very useful when SSH is being used in a mobility use-case
as demonstrated in [4]. I'm here to see if such native support could be
possible.

On Linux, apps can be forced to use MPTCP instead of TCP with different
techniques (LD_PRELOAD, eBPF, SystemTAP, etc.) [5], but that's more a
workaround, and some system administrators don't accept them.

I'm aware of a previous pull-request [6] that has not been accepted
because MPTCP was not widely supported. It is true that MPTCP is
currently only officially supported on macOS and Linux (since 2020). It
is also supported in load balancers and in userspace implementations,
but that's for specific use-cases [7]. There was an ongoing
implementation on FreeBSD, from people from the Swinburne University of
Technology in Melbourne, but it looks like the development has stopped
[8]. MPTCP can also be used on Windows, via their WSL2 environment [9].

If such native support cannot be done in OpenSSH, I guess it means we
should ask GNU/Linux distributions to add this support. That's what
Apple already did apparently [10] -- they already patched OpenSSH before
to support their Network framework.

Following the xz-utils backdoor, I don't know if GNU/Linux distributions
will continue to accept such modifications. Before asking them, and also
to avoid having different implementations per distributor, is it still
not OK to add (native) MPTCP support in the upstream project?

[1] https://www.mptcp.dev
[2] https://www.rfc-editor.org/rfc/rfc8684.html
[3] https://www.tessares.net/apples-mptcp-story-so-far/
[4] http://blog.multipath-tcp.org/blog/html/index.html#real-life-testing
[5] https://www.mptcp.dev/setup.html#force-applications-to-use-mptcp
[6] https://github.com/openssh/openssh-portable/pull/335
[7]
http://blog.multipath-tcp.org/blog/html/2018/12/15/apple_and_multipath_tcp.html
[8] http://www-cs-students.stanford.edu/~sjac/freebsd_mptcp_info.html
[9] https://perso.uclouvain.be/tom.barbette/mptcp-on-windows-with-wsl2/
[10]
https://github.com/apple-oss-distributions/OpenSSH/blob/main/openssh/sshconnect.c#L487

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
--
PS: sorry for the repost, the OpenSSH dev ML info page mentioned [11]
the list was open for non-subscribers to post to, but it looks like it
is no longer the case :)
[11] https://lists.mindrot.org/mailman/listinfo/openssh-unix-dev

