Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B943F3D6CCA
	for <mptcp@lists.linux.dev>; Fri,  1 May 2026 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777651002; cv=none; b=nH0RFZaKcCNw0v0ONdAkiMTld4Rui2msNXZLCjohwdkB8fpCMgRseS0+ucLSYi+2VwDPRpF+vYJ/qwRngjocxNpKLeZP1oLvdTRzOPwJpMbHrHgL5Q7OSFuVgpyQb0KEGOutWePDdNyfuE1LJwA/vAjGXph91LRs8v1AWAp6MZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777651002; c=relaxed/simple;
	bh=aC2XrvUnG5Qa31ySKV7/rNahl/9gSTgtZ9Y++MLlC+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gaqy6/N+3XMPqe8nAfg9eGgJWoO3nxQPgYHxe5yV2/DBioLRBljgkVyKmYE8FAPrKpvfmwKe3BRBPVqA7IDVER7Vva/Z+qQ3jKbf1nyj840Z2x8YYU6tKA258DRjJZwPfq9TGahn8jo5Bl5qalXxcobfpN8CejQRC3TFE38nSLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agsLldAr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agsLldAr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBA0C2BCC7;
	Fri,  1 May 2026 15:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777651002;
	bh=aC2XrvUnG5Qa31ySKV7/rNahl/9gSTgtZ9Y++MLlC+w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=agsLldArg+UgYqKtkS5Uum+XmthPAN9hCsbYfsBQFKm9Vn4JChtlDUXJNe5H70/3o
	 +AexNP4VyeWCjjb7h7KeuX70ASwzFaTTLih+SaTP5r14+CeWdK4VGZ3OriFXWu2lgA
	 pQABC72HK5jojAJn5NjhMaKhWc29Z35rH/axwv5FHZ+eZvy4nSsEpCtJVo1R+dedFD
	 YacpT9mWz0mDJ1tUch1reslWIypyCXNN4DHrivV/nirEkWxLdPxVz7FvllCpqPO6cj
	 z/baKxJSc2UZ9hg4Q0nvP9rFhWyXJPCEMS37qi6fKHWDzduh87INMKhPxGGjdPryTS
	 BAreoP97lQv8g==
Message-ID: <b36e138a-d874-4eff-a428-55bcfbbfc495@kernel.org>
Date: Fri, 1 May 2026 17:56:39 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v4 0/4] mptcp: MSG_ERRQUEUE support on the
 parent socket
Content-Language: fr
To: David CARLIER <devnexen@gmail.com>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20260421223338.52743-1-devnexen@gmail.com>
 <cover.1777324037.git.devnexen@gmail.com>
 <43f69e5e-b0a5-4bc5-8e6b-8f41ef4cf55a@kernel.org>
 <59eccce4-cbc6-48b9-9243-9b9b5a5ca066@kernel.org>
 <efb7cbc4-a4c9-4f84-b440-0a2aa3267c02@kernel.org>
 <CA+XhMqweRpN9-fjS19zx=a_Lm_XSsZsLB__xEzWyB4THsBOdiQ@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CA+XhMqweRpN9-fjS19zx=a_Lm_XSsZsLB__xEzWyB4THsBOdiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/05/2026 17:28, David CARLIER wrote:
> Hi Matthieu,
> 
>   On 01/05/2026 16:49, Matthieu Baerts wrote:
>   > It looks like the CI (and sashiko) found some issues with this series.

(Please do fix your email client to avoid this formatting: some of your
emails are OK, but not all of them.)

>   For v5:
> 
>   - 1/4: per-bit inet_assign_bit() loop instead of WRITE_ONCE(), keeps
>     atomicity.
>   - 2/4: add missing sockopt_seq_inc(msk).
>   - 2/4: skip family-mismatched subflows in the v4/v6 helpers.
>   - 2/4: snapshot optval to a local int, pass KERNEL_SOCKPTR(&val) into
>     the loop.

(While at it, your new helpers mptcp_setsockopt_v[46]_recverr could have
a generic name)

>   - 3/4: pull-on-drain from mptcp_recv_error() so a parent-ENOMEM does
>     not strand subflow skbs.
> 
>   Will also re-run the docker repro to check the selftest_mptcp_join /
>   packetdrill rows are pre-existing.

The packetdrill errors might be pre-existing, someone should look at
improving the situation there:

  https://ci-results.mptcp.dev/flakes.html

>   > But globally, I'm a bit puzzled: with MPTCP, there might be multiple
>   > paths being used, and reporting errors about all of them when the
>   > "legacy" RECVERR socket options are used will confuse the userspace
>   > that doesn't (have to) know multiple subflows are being used.
> 
>   Fair, and Paolo raised it on v3. The use-case is tx timestamping and
>   MSG_ZEROCOPY completions - both are tied to user data, not the
>   subflow that carried it, so no subflow identity leaks into the cmsg.
>   ICMP/ICMPv6 is the part that does. v5 will filter the splice by
>   SO_EE_ORIGIN: forward TIMESTAMPING / ZEROCOPY / LOCAL, drop ICMP.

Maybe OK with this filter indeed..

>   > It might be easier to have a dedicated MPTCP_RECERR, and
> eventually
>   > propagate more MPTCP-specific messages. Something that could be
>   > linked to:
>   >   https://github.com/multipath-tcp/mptcp_net-next/issues/78
> 
>   Agreed - subflow ICMP and #78's lifecycle events belong there. As a
>   follow-up once v5 lands.

Indeed, better to split them.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

