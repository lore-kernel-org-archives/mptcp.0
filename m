Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE1E40856
	for <mptcp@lists.linux.dev>; Fri, 21 Jun 2024 14:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981544; cv=none; b=EnWkQ9/9bqj3X4qV+nBrnmG8sbNToQIXpLXDIFvU/kaXqg/RBE2HxCzEusr770Sr/2Dl5cMhb0FQC7q4IDVWuQUR6015N0gvU4HVfpwOzkzN0iJRJlm0NtIpkifkInJ/0u1+LCekHYVKc+1iGVooQcLtA8kxpGB2m/GwZL3QdOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981544; c=relaxed/simple;
	bh=FfGykM9ProZzgxnTUtjhKHD/Z2bkI1wXsnaydoSIxyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ScFP2ODaCmgnA4put3+FBOSSnjfRwE3eknh/8k8UjzeGHYE2JFsp+ZES/znTIKOkCBQE+qH4FICrraUQDRP+8hvLZ/IzNh02rFlTDO7K5lR1rh9VXPrG7CfP5lLjVcVeMaQaKvEFPKRxPlLZr+EXmS8uFG//g6126ipxmm2nD8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3nD4Jwt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3nD4Jwt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE60AC2BBFC;
	Fri, 21 Jun 2024 14:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718981544;
	bh=FfGykM9ProZzgxnTUtjhKHD/Z2bkI1wXsnaydoSIxyI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L3nD4JwttN66FlLQPz01yBLq4GggRNoldEDnqn6gcwbXKGXnLRaK8YDj2UFonWcIl
	 DXklRIs/5JCsX2hq+Og+9NeU7HCFo2LUzZ2GGVcP1qHy6hYGjFZr80vd8SnBgRzLol
	 ZMRTQTl4MEowTFzT0i+0vNLClfnezqcyb2RdeXGYfu01OgOJEPg2QA99akTEfe/7dt
	 rjUovCoH/oU7kOtKNy66L7nOdS2tPaejVl/w6hI1cpSEYZxlfNlM15cn5TmyrK58bG
	 VD5ooMJ1LOGiKXqRxFSNbvQg7ykSxoWM5vMyN/EVgiUhLwN9WGzhztbNSjYjUCtdbE
	 OosDmNbUHIw7w==
Message-ID: <bfa658a3-7b5f-4a04-8268-ef3412c28331@kernel.org>
Date: Fri, 21 Jun 2024 16:52:15 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: Create_on_err or anything else for auto recreate subflows in
 mainline kernels
Content-Language: en-GB
To: =?UTF-8?B?0JPRg9GB0LXQsiDQktC40LrRgtC+0YA=?= <vgusev2007@yandex.ru>
Cc: mptcp@lists.linux.dev
References: <20240611152044.3q6OMIkD@mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net>
 <4c776740-3953-41c9-bb63-a5814351293b@kernel.org>
 <2ce5931f-2551-4aba-9d86-2bf1a39f44f3@yandex.ru>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2ce5931f-2551-4aba-9d86-2bf1a39f44f3@yandex.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Viktor,

On 13/06/2024 16:50, Гусев Виктор wrote:
> Dear Matthieu Baerts, first of all I want to thank you for you answer to
> me.
> 
> I try to re-add subflow, but no luck. Please see that below.
> 
> before:
> 
> root@mptcp-clt:~# ss -nti '( dport :1194 )' dst 158.160.3.76
> State                    Recv-Q Send-
> Q                                             Local
> Address:Port                                        Peer Address:Port
> Process
> ESTAB                    0 0 62.117.117.117:46234 158.160.3.76:1194
>  cubic wscale:7,7 rto:211 rtt:10.188/2.94 ato:40 mss:1448 pmtu:1500
> rcvmss:536 advmss:1448 cwnd:10 bytes_sent:156 bytes_acked:157
> bytes_received:156 segs_out:6 segs_in:5 data_segs_out:2 dat
> a_segs_in:2 send 11370239bps lastsnd:2721 lastrcv:2647 lastack:2647
> pacing_rate 22739080bps delivery_rate 1139144bps delivered:3 busy:20ms
> rcv_space:14480 rcv_ssthresh:31832 minrtt:9.921 snd_wnd:31
> 872 tcp-ulp-mptcp flags:Mmec token:0000(id:0)/3172dd19(id:0)
> seq:895f63b32fbca2b5 sfseq:4f ssnoff:cf8ab108 maplen:4e
> ESTAB                    0 0 94.247.123.178%eth2:36301 158.160.3.76:1194
>  cubic wscale:7,7 rto:209 rtt:8.898/4.449 mss:1448 pmtu:1500 rcvmss:536
> advmss:1448 cwnd:10 bytes_acked:1 segs_out:2 segs_in:2 send 13018656bps
> lastsnd:7230 lastrcv:7230 lastack:7221 pacing
> _rate 26037304bps delivered:1 app_limited rcv_space:14480
> rcv_ssthresh:31832 minrtt:8.898 snd_wnd:31872 tcp-ulp-mptcp flags:Jjec
> token:180a97fe(id:0)/3172dd19(id:2) seq:895f63b32fbca267 sfseq:0 ssn
> off:f227a127 maplen:0
> 
> 
> del endpoint:
> 
> root@mptcp-clt:~# ip mptcp endpoint del id 2
> root@mptcp-clt:~# ss -nti '( dport :1194 )' dst 158.160.3.76
> State                 Recv-Q Send-Q                                 
> Local Address:Port                                    Peer
> Address:Port                 Process
> ESTAB                 0 0 62.117.117.117:46234 158.160.3.76:1194
>  cubic wscale:7,7 rto:215 rtt:14.505/10.008 ato:40 mss:1448 pmtu:1500
> rcvmss:536 advmss:1448 cwnd:10 bytes_sent:465 bytes_acked:466
> bytes_received:465 segs_out:13 segs_in:11 data_segs_out:5
>  data_segs_in:5 send 7986212bps lastsnd:12506 lastrcv:12944
> lastack:12496 pacing_rate 15972280bps delivery_rate 1154816bps
> delivered:6 busy:90ms rcv_space:14480 rcv_ssthresh:31832 minrtt:9.921 snd_
> wnd:31872 tcp-ulp-mptcp flags:Mmec token:0000(id:0)/3172dd19(id:0)
> seq:895f63b32fbca3ea sfseq:184 ssnoff:cf8ab108 maplen:4e
> 
> 
> check:
> 
> root@mptcp-clt:~# ip mptcp endpoint add 94.247.123.178 id 2 dev eth2
> subflow

Strange, it should create a new subflow I think. Can you try to use a
different ID? (id 2 → id 3?)

> root@mptcp-clt:~# ss -nti '( dport :1194 )' dst 158.160.3.76
> State                 Recv-Q Send-Q                                 
> Local Address:Port                                    Peer
> Address:Port                 Process
> ESTAB                 0 0 62.117.117.117:46234 158.160.3.76:1194
>  cubic wscale:7,7 rto:214 rtt:13.94/8.635 ato:40 mss:1448 pmtu:1500
> rcvmss:536 advmss:1448 cwnd:10 bytes_sent:543 bytes_acked:544
> bytes_received:543 segs_out:15 segs_in:13 data_segs_out:6 d
> ata_segs_in:6 send 8309900bps lastsnd:33271 lastrcv:33197 lastack:33197
> pacing_rate 16618752bps delivery_rate 1159440bps delivered:7 busy:100ms
> rcv_space:14480 rcv_ssthresh:31832 minrtt:9.921 snd_w
> nd:31872 tcp-ulp-mptcp flags:Mmec token:0000(id:0)/3172dd19(id:0)
> seq:895f63b32fbca438 sfseq:1d2 ssnoff:cf8ab108 maplen:4e
> 
> There is still only one connect. Also I tried to delete connect by
> iptables (I used DROP action) - in any case: no luck. Connection didn't
> restore at all. For restore it I need to restart my vpn.

For the moment, the PM will not try to re-establish a subflow closed by
the network (e.g. like here with IPTables) or the other peer.

This feature still needs to be implemented, see:

https://github.com/multipath-tcp/mptcp_net-next/issues/440

> Can you show me how can I re-add subflow into established connection?
> 
> The second question is about create SO_KEEPALIVE. Is it possible do that
> by other external program like mptcpize do mptcp socket? For example, I
> mean create openvpn tunnel. I think that I can use ssh as a tunnel with
> TCPKeepAlive option but I think that is not good idea at all because
> I've read about maximum KEEPALIVE is 2 hours but I need it up to 1 or 2
> weeks.

Technically, I think it is possible to change the behaviour of an app,
but I don't know any tool like 'mptcpize' to be able to do that.

If you can modify the application, it is just one line to add. And many
apps are already doing that.

But again, here it will not help you, because the path-manager will not
re-open subflows that got closed:

https://github.com/multipath-tcp/mptcp_net-next/issues/440

> The last question is about old implementation of mptcp. What do you
> think about openmptcprouter.com project? Can you advice me to use that
> for my purpose (make vpn over 3 ISP for long time)?

I never used it, but I know they support the new implementation with
MPTCP in the upstream kernel -- unfortunately with still an old kernel,
v5.15, 9 major versions behind, with features added 3 years ago -- and I
think they use something like mwan3 to monitor the interface, and
delete/re-add them again in case of issue. So it might help you.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

