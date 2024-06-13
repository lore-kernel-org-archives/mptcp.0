Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [178.154.239.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E05015E85
	for <mptcp@lists.linux.dev>; Thu, 13 Jun 2024 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290604; cv=none; b=FmNvF87BiWnih9YNSBVjwbPZOHe4lpV9K5+9yYvtb2ynxcnwWyG2tM46mmTng9c+J92QS9YD2u87LkO9eIHhLMfRgaNUhmjaWzFgayN6RKCVLIH99SkkRQDNylUPQ0/LbLAEy9Rl+5dZ8JBqGOMdgCHmVwlwtzYCDBCvib0s3sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290604; c=relaxed/simple;
	bh=ZwsUJv2Y8pGcq7XvmcsCL/XCfGpjfOxrnOf5ENpavBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YzPSuSUy9BWUEs78Jx4wtsY07vtFpODl2nwbXJXZue+IpY4nFuc72czqCMZC1mhftolpKOXhcubBcvPL5c2T2oG0sQjGvy2jeG6VDCvG+rJB/U+QwKkjZB/Dmw058gIRjrjL88qeo/3g/r+hCFvUF4vzZbioj8cIGopJnif2edc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=I3tNvCBd; arc=none smtp.client-ip=178.154.239.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="I3tNvCBd"
Received: from mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:3b2:0:640:ff71:0])
	by forward501c.mail.yandex.net (Yandex) with ESMTPS id 475EE60A41;
	Thu, 13 Jun 2024 17:50:44 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id aohbc1AmA4Y0-XtmQhGwb;
	Thu, 13 Jun 2024 17:50:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1718290243; bh=3lghH3FJUVsMR5pO7k3oFb4zXxPS4db6eZ+IreJj9+I=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=I3tNvCBd99Tjg9JDJUXxl7FOejtMWFH5R5G+J+X+RqpXzuqzLNPQwFkapMj+PsE1T
	 qpA3MRUnGEe6vNMvyRlMeFlAZwanqKUFjtkcb6CKvBP96pOrLKi+xtH4g2YGBxAEvp
	 owf7M6Wq2S6Kht9tUunyGBZKWJoGy7xe9T3lo4qM=
Authentication-Results: mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <2ce5931f-2551-4aba-9d86-2bf1a39f44f3@yandex.ru>
Date: Thu, 13 Jun 2024 17:50:35 +0300
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Create_on_err or anything else for auto recreate subflows in
 mainline kernels
Content-Language: en-US
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20240611152044.3q6OMIkD@mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net>
 <4c776740-3953-41c9-bb63-a5814351293b@kernel.org>
From: =?UTF-8?B?0JPRg9GB0LXQsiDQktC40LrRgtC+0YA=?= <vgusev2007@yandex.ru>
In-Reply-To: <4c776740-3953-41c9-bb63-a5814351293b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Matthieu Baerts, first of all I want to thank you for you answer to me.

I try to re-add subflow, but no luck. Please see that below.

before:

root@mptcp-clt:~# ss -nti '( dport :1194 )' dst 158.160.3.76
State                    Recv-Q 
Send-Q                                             Local 
Address:Port                                        Peer Address:Port
Process
ESTAB                    0 0 62.117.117.117:46234 158.160.3.76:1194
  cubic wscale:7,7 rto:211 rtt:10.188/2.94 ato:40 mss:1448 pmtu:1500 
rcvmss:536 advmss:1448 cwnd:10 bytes_sent:156 bytes_acked:157 
bytes_received:156 segs_out:6 segs_in:5 data_segs_out:2 dat
a_segs_in:2 send 11370239bps lastsnd:2721 lastrcv:2647 lastack:2647 
pacing_rate 22739080bps delivery_rate 1139144bps delivered:3 busy:20ms 
rcv_space:14480 rcv_ssthresh:31832 minrtt:9.921 snd_wnd:31
872 tcp-ulp-mptcp flags:Mmec token:0000(id:0)/3172dd19(id:0) 
seq:895f63b32fbca2b5 sfseq:4f ssnoff:cf8ab108 maplen:4e
ESTAB                    0 0 94.247.123.178%eth2:36301 158.160.3.76:1194
  cubic wscale:7,7 rto:209 rtt:8.898/4.449 mss:1448 pmtu:1500 rcvmss:536 
advmss:1448 cwnd:10 bytes_acked:1 segs_out:2 segs_in:2 send 13018656bps 
lastsnd:7230 lastrcv:7230 lastack:7221 pacing
_rate 26037304bps delivered:1 app_limited rcv_space:14480 
rcv_ssthresh:31832 minrtt:8.898 snd_wnd:31872 tcp-ulp-mptcp flags:Jjec 
token:180a97fe(id:0)/3172dd19(id:2) seq:895f63b32fbca267 sfseq:0 ssn
off:f227a127 maplen:0


del endpoint:

root@mptcp-clt:~# ip mptcp endpoint del id 2
root@mptcp-clt:~# ss -nti '( dport :1194 )' dst 158.160.3.76
State                 Recv-Q Send-Q                                  
Local Address:Port                                    Peer 
Address:Port                 Process
ESTAB                 0 0 62.117.117.117:46234 158.160.3.76:1194
  cubic wscale:7,7 rto:215 rtt:14.505/10.008 ato:40 mss:1448 pmtu:1500 
rcvmss:536 advmss:1448 cwnd:10 bytes_sent:465 bytes_acked:466 
bytes_received:465 segs_out:13 segs_in:11 data_segs_out:5
  data_segs_in:5 send 7986212bps lastsnd:12506 lastrcv:12944 
lastack:12496 pacing_rate 15972280bps delivery_rate 1154816bps 
delivered:6 busy:90ms rcv_space:14480 rcv_ssthresh:31832 minrtt:9.921 snd_
wnd:31872 tcp-ulp-mptcp flags:Mmec token:0000(id:0)/3172dd19(id:0) 
seq:895f63b32fbca3ea sfseq:184 ssnoff:cf8ab108 maplen:4e


check:

root@mptcp-clt:~# ip mptcp endpoint add 94.247.123.178 id 2 dev eth2 
subflow
root@mptcp-clt:~# ss -nti '( dport :1194 )' dst 158.160.3.76
State                 Recv-Q Send-Q                                  
Local Address:Port                                    Peer 
Address:Port                 Process
ESTAB                 0 0 62.117.117.117:46234 158.160.3.76:1194
  cubic wscale:7,7 rto:214 rtt:13.94/8.635 ato:40 mss:1448 pmtu:1500 
rcvmss:536 advmss:1448 cwnd:10 bytes_sent:543 bytes_acked:544 
bytes_received:543 segs_out:15 segs_in:13 data_segs_out:6 d
ata_segs_in:6 send 8309900bps lastsnd:33271 lastrcv:33197 lastack:33197 
pacing_rate 16618752bps delivery_rate 1159440bps delivered:7 busy:100ms 
rcv_space:14480 rcv_ssthresh:31832 minrtt:9.921 snd_w
nd:31872 tcp-ulp-mptcp flags:Mmec token:0000(id:0)/3172dd19(id:0) 
seq:895f63b32fbca438 sfseq:1d2 ssnoff:cf8ab108 maplen:4e

There is still only one connect. Also I tried to delete connect by 
iptables (I used DROP action) - in any case: no luck. Connection didn't 
restore at all. For restore it I need to restart my vpn.

Can you show me how can I re-add subflow into established connection?

The second question is about create SO_KEEPALIVE. Is it possible do that 
by other external program like mptcpize do mptcp socket? For example, I 
mean create openvpn tunnel. I think that I can use ssh as a tunnel with 
TCPKeepAlive option but I think that is not good idea at all because 
I've read about maximum KEEPALIVE is 2 hours but I need it up to 1 or 2 
weeks.

The last question is about old implementation of mptcp. What do you 
think about openmptcprouter.com project? Can you advice me to use that 
for my purpose (make vpn over 3 ISP for long time)?

Best regards,

Viktor.



On 11.06.2024 18:42, Matthieu Baerts wrote:
> Hi,
>
> Please be patient: I got 4 messages from you from different canals in a
> couple of hours about the same question.
>
> On 11/06/2024 14:20, vgusev2007@yandex.ru wrote:
>> Dear all, I don' t understand where is that parameter? I mean create_on_err  or anything else for auto recreate subflows. Is it possible to change shceduler?
>>   
>> In the old doc it was in a separate mptcp module, but I don't understand where I can create it or found it in a new kernel (after v 5.6 - for example 6.8 in ubuntu 24.04).
> The two implementations are very different: the new implementation is a
> rewrite of the previous one to fit Netdev maintainers' requirements.
>
> There is no such "create_on_err" handled by the in-kernel path-manager
> with the new implementation. Currently, subflows are re-created when the
> MPTCP endpoints are removed and re-added later, but not when there are
> network issues as described in [1]. New contributions are welcome!
>
> Note that such issues can be prevented by enabling SO_KEEPALIVE socket
> option in the userspace program. Of course, if you create your own
> path-manager controlled by the userspace -- e.g. by creating a custom
> plugin with mptcpd [2] -- it can handle this.
>
> [1] https://github.com/multipath-tcp/mptcp_net-next/issues/440
> [2] https://github.com/multipath-tcp/mptcpd/wiki/Plugins
>
> Cheers,
> Matt
