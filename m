Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B398032C84
	for <mptcp@lists.linux.dev>; Tue, 12 Mar 2024 07:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710227431; cv=none; b=MPPvZJEke1yP7MADpLO2g6y58OqtOtpEhZoBANw/YshB3NaAxY9vs+9pGbEytOymD8bUYDpOOy7CTVx9q611GIRRRQ+xTD6+/WlUKtg/nZuKUHcfdSmwBLxQdozAmFabuJ99YCn16xdoT6T3Z20x7KnUbIOvrjbEFYt5a4bGn2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710227431; c=relaxed/simple;
	bh=QdheXpEWjAoI+UBVeRPFYmJu2Lzs3ZwYbmRnm/cBm1A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=OHkvhpLqnzq+iEyWFoCGGP40IgMBs1j+rw+FQXv+kghg/4nNEuqjnCgWAMuSug1WPO7K+LnEHERAdyFqd/SgYtXGwORhBxVi6pkpZFdtOdiEPusgIJOhYYYJLrQg4AjgUXj8GymtCvYoVPhV/VNqJJYEDc6Y6rKrsTnrxJ1FYbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbHP2BLh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbHP2BLh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6ADEC433F1;
	Tue, 12 Mar 2024 07:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710227430;
	bh=QdheXpEWjAoI+UBVeRPFYmJu2Lzs3ZwYbmRnm/cBm1A=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=kbHP2BLhVVT6q1mfon8k/0Ye2GJh/jjRx4pLyLMcSDSkzddQQfDORwYpwHqOtmTef
	 8RXOASVuNREHLduVEYo0/gOCzHlzfUiCU6pOeW6gVgsJtJ4UHDV8PKoAPvWct75r2R
	 UbA1vnUwjgMjX2tP+vKLOXocZXgWCHpnbpiG8Wz3YAeg6916WHl2bAGV/jy5RpQ22y
	 tQm7nWVk9/c3sP2LegNT87uKgsWI6oamQp9Hdt7WMrpe6vVQuHZD0AfBUM0QMKgCeL
	 zTehzZdAPJTj+SuMxWteJLSSbXwT+QW/3M98NTno0VZmIjwFIYILBoLKdlQ25wNHJd
	 P+qs43nieyYdg==
Date: Tue, 12 Mar 2024 08:10:28 +0100 (GMT+01:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Message-ID: <fd131421-bb46-4d40-befd-b2bcd6d2b832@kernel.org>
In-Reply-To: <4a85ab6ab759ba852647b03af58faded31fbb8f6.1710140596.git.geliang@kernel.org>
References: <4a85ab6ab759ba852647b03af58faded31fbb8f6.1710140596.git.geliang@kernel.org>
Subject: Re: [PATCH iperf3 v3] add MPTCPv1 support
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <fd131421-bb46-4d40-befd-b2bcd6d2b832@kernel.org>

Hi Geliang,

11 Mar 2024 08:04:05 Geliang Tang <geliang@kernel.org>:

> The Multipath TCP (MPTCP) protocol (v1 / RFC 8684) has been added in
> the upstream Linux kernel since v5.6.
>
> MPTCP is strongly tied to TCP, and the kernel APIs are almost the same.
> The only required dependency is the 'IPPROTO_MPTCP' protocol number
> definition, which should be provided by the netinet/in.h header if it
> is recent enough.
>
> This patch adds a new flag '-m' or '--multipath' to support MPTCPv1.

I just noticed you switched back to "multipath" instead of "mptcp".
I think it is best to stick with "mptcp", because "multipath"
is too vague, thus confusing: it could be multipath as in multiple
flows, multicast, with other protocols like UDP, etc.

Best to use "mptcp" everywhere: variables, strings, description, etc.


> It can be used like this:
>
>> iperf3 -m -s
>> iperf3 -m -c 127.0.0.1

If the server doesn't have "-m", only the client, does it use MPTCP?

Cheers,
Matt
