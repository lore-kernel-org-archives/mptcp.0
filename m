Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795187718;
	b=RDSXSdmXnWNcPP0IUIlzhnKqdB1es0zZ3LiPY46RLNIXseW52Dm6jlLcPo0XLDbv8pIO
	 PiUq6ROBDTSoIUpONWo8Hzih8ycJEjsuIi7Y7GEoKYP9tUkjFhgIyqNBBBTQ5aVgmXP6d
	 sr1ivgXCPXN0vD0wuH9JuUzTyP5qbxM5a9j1bnkmuh/XUZGP3XD8HSWQZjjHLh1a+dOPF
	 NAeEMORWvzlZW4stfEM8KCCmOVq2qIt3G8lAblfMUWMp79k/MG8Sm6Cor59SR2hKSbrt7
	 FtU3MlOjxLNTKaf76h1tUlmhkgN9zf0ulzRZEV4S6pSfL2RhQ6DeLihWHBii9MnbTPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187718;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=wZ4iGx1hB6JaY8F2+fZrPaRW+jYVtG/e8ODGjd7WFls=;
	b=fzr+cJ31kMLZBSayi4szqs/E1KSIRXXBJQnYBLYgSBhIRdtyQ8YT6qkip1N0KIG+5mnE
	 rMZz8HsJgFGqixpkX/Ra76eKjL4jmqCh2T26NYjWIgCRVWAkmHRWsSQ35Fbk7+I/cj1fr
	 SMyy0Aw4lWeSZYkwe3N6UrnvefF8+IqJz91WwQUWxkPrOAvJuahBciK0Bx3DuAwjtYJSu
	 pQIAImG1IDurmt+j7TwbXlVvsrHnwsFMlLWftvDbilwqx6giqXSeXTY9snfxxlCOFwciS
	 77c6kfiqrOTTE5VOoU7Za6CEDfr1ZoVXgqSi8J2rl9wtGraD6mu1EbZwoykHhY+Te4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MBV+Dod2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E07B606A33C
	for <mptcp@lists.linux.dev>; Fri, 20 Nov 2026 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MBV+Dod2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777811F000CA;
	Fri, 20 Nov 2026 15:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795187717;
	bh=wZ4iGx1hB6JaY8F2+fZrPaRW+jYVtG/e8ODGjd7WFls=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MBV+Dod27GB93vYn2zJhW2+60skBwC+g62sQhTPDcZuS3cI4sOayC8lU8C/IeoTf6
	 AsdCT8YSANfqRYJA0Pp5qDOLm9BXZl7CqQEH2RYZpn4nHtrvaoDssBcfth3jQ2cIZd
	 YKF6B6xQbqEYBVrum2zuQDl23fSvRxS0QEoeILyPWgooCocTkNU3umLr+OVpVkB2IR
	 RQScgab47XO4Eo2mPkagWJvGFZhcOsCazzvB57XSq8XLFphNzIvjQ0AbjgTEnCX1/c
	 mJRi09friZdFPRIzQx7+zutH24ohwbuxZxr5gqTcUdDE5u51CLRsDVGjau25M9W9Iw
	 3gC0uMrm18wKw==
Message-ID: <e4f8f699-9f92-41b7-92fc-4b8ab1750254@kernel.org>
Date: Fri, 20 Nov 2026 16:15:11 +0100
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v13] mptcp: hide sequence numbers in Netlink
 diagnostics
Content-Language: fr
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: kalpan.jani@mpiricsoftware.com, mptcp@lists.linux.dev,
 shardul.b@mpiricsoftware.com, janak@mpiric.us, kalpanjani009@gmail.com,
 kuba@kernel.org, netdev-bot+sashiko@kernel.org
References: <20261117050804.134954-1-kalpan.jani@mpiricsoftware.com>
 <179502798858.3133.4822986587776409521@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <179502798858.3133.4822986587776409521@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Kalpan,

On 18/11/2026 19:53, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 2 · Low: 3
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] In net/mptcp/mptcp_diag.c, mptcp_diag_get_info() now always
>   sets mptcpi_write_seq, mptcpi_snd_una and mptcpi_rcv_nxt to 0 in…
> - [Medium] The new 'chk dump_one zero sequence fields' subtest in
>   tools/testing/selftests/net/mptcp/diag.sh:chk_dump_one() hard-FAILs…
> - [Low] The commit message does not say who the change protects against
>   or what users will see change.
> - [Low] diag.sh:chk_dump_one() calls `ip netns exec "$ns" ./mptcp_diag -z
>   -t "$ss_token"` with no stdout redirect, between mptcp_lib_print_title…
> - [Low] struct mptcp_info (include/uapi/linux/mptcp.h) is a single uAPI
>   object with two producers that now disagree.
> 
> --
> 
> mptcp: hide sequence numbers in Netlink diagnostics
> 
> This commit zeroes mptcpi_write_seq, mptcpi_snd_una and mptcpi_rcv_nxt in
> the MPTCP sock_diag INET_DIAG_INFO reply. The getsockopt() interface is
> left unchanged. The mptcp_diag selftest helper gets a -z mode, and diag.sh
> gets a subtest that checks these fields are zero.
> 
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/445
> 
>> MPTCP Netlink diagnostics expose sequence numbers that can reveal
>> internal connection state.
> 
> [Severity: Low]
> This isn't a bug, but could the commit message say who this change
> protects against? For example, unprivileged users in the same netns
> reading data-level sequence numbers of other users' MPTCP sockets through
> sock_diag.
> 
> The message also doesn't say that these three fields become 0 over
> netlink for every requester, including root and tools like ss -M. It only
> says getsockopt() is unchanged.

I guess the commit message can indeed be clearer: "sequence numbers that
can reveal internal connection state" is a bit vague. We can say that
the TCP seq num are not exposed for the same reasons: not to let someone
else on the machine getting access to them which can eventually be used
to mess with the connection by injecting some specific packets.

>> diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
>> index 136c2d05c0eeb..fe1603ce80162 100644
>> --- a/net/mptcp/mptcp_diag.c
>> +++ b/net/mptcp/mptcp_diag.c
>> @@ -215,6 +215,10 @@ static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
>>  		return;
>>  
>>  	mptcp_diag_fill_info(msk, info);
>> +
>> +	info->mptcpi_write_seq = 0;
>> +	info->mptcpi_snd_una = 0;
>> +	info->mptcpi_rcv_nxt = 0;
> 
> [Severity: Medium]
> Does this also hide the values from CAP_NET_ADMIN callers? The fields are
> cleared in mptcp_diag_get_info() for every sock_diag requester. Root
> running ss -M -i, or a monitoring daemon, now always gets 0 where it used
> to get the real msk-level data sequence values.
> 
> The subflow side of the same reply family already uses a different rule:
> 
> net/mptcp/diag.c:subflow_get_info() {
> 	...
> 	/* Only export seq related counters to user with CAP_NET_ADMIN */
> 	if (net_admin &&
> 	    (nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ,
> 			 sf->rel_write_seq) ||
> 	     nla_put_u64_64bit(skb, MPTCP_SUBFLOW_ATTR_MAP_SEQ, sf->map_seq,
> 	...
> }
> 
> The privilege bit is already in scope. mptcp_diag_dump_one() passes
> netlink_net_capable(in_skb, CAP_NET_ADMIN) into inet_sk_diag_fill(), but
> inet_sk_diag_fill() only hands it to idiag_get_aux():
> 
> net/ipv4/inet_diag.c:inet_sk_diag_fill() {
> 	...
> 	handler->idiag_get_info(sk, r, info);
> 
> 	if (ext & (1 << (INET_DIAG_INFO - 1)) && handler->idiag_get_aux)
> 		if (handler->idiag_get_aux(sk, net_admin, skb) < 0)
> 	...
> }
> 
> If the concern is unprivileged readers, would it fit better to gate these
> fields on net_admin, as the subflow attributes are?
> 
> If the concern is all readers, a privileged user still receives
> MPTCP_SUBFLOW_ATTR_MAP_SEQ, which is in the same data sequence space. Is
> the hiding complete in that case?
> 
> The new selftest runs as root and requires zeros, so it would lock in the
> unconditional behaviour. The Fixes: tag also carries this into stable.

The commit message can explain why: ideally, it would be good to only
reset these fields for unprivileged readers, but with the current
architecture, we cannot distinguish the different readers. So we keep
this fix small for the moment.

> [Severity: Low]
> Is it intended that struct mptcp_info now has two producers that disagree?
> getsockopt(MPTCP_INFO) and getsockopt(MPTCP_FULL_INFO) go through
> mptcp_diag_fill_info() in net/mptcp/sockopt.c and still report the real
> values:
> 
> 	info->mptcpi_write_seq = msk->write_seq;
> 	...
> 	info->mptcpi_snd_una = msk->snd_una;
> 	info->mptcpi_rcv_nxt = msk->ack_seq;
> 
> INET_DIAG_INFO now always reports 0 for the same fields. Nothing in
> include/uapi/linux/mptcp.h or in mptcpi_flags marks the values as
> suppressed.
> 
> How would a netlink consumer tell a hidden value from a real 0? A
> TCP_LISTEN msk, for example, really does report 0, because
> mptcp_diag_fill_info() returns right after the memset(). The in-tree
> print_info_msg() also still prints these fields as if they were real.
> 
> Should the per-interface meaning of these fields be documented?

Also for the commit message: yes, that's intended. That's OK, the seq
nums shouldn't have been exposed initially, and don't have a lot of
value for Netlink readers. Instead, they can have access to other info
from TCP subflows, or the bytes sent/received.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

