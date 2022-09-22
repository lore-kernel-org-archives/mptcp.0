Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B177B
	for <mptcp@lists.linux.dev>; Thu, 22 Sep 2022 23:23:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663888985; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=YyiMXayKtgr3bOJtwTt7TJcf4gbou2oUVKa4onk/KdhmltqQTVjDnX3lyrgYtp0MwtgrMJQTZQNkKn4hv00ddBbzvsl9YuQpaclZaXRgrdoZ3HNl8wFtShFCxVhDWq4TFzKOKGnuNBgWcHEv/frCv/0ZiLgTUB8luZWioB3Th50=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663888985; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=47PJYP6qxMTZvHY8exgCyBof51XcmyP2fwLKe2IOtwI=; 
	b=WiwPvx1TOKK49ysEOnEgA8mLcbXwcb2YtP0EcwO9Y9cQ87FEzeTcjR1qWo332c31ixkYvwfp9lnnc9M/6QsvxWvxsdUtPz9Nm+sJPc3JVxx+8FPCZxqCBJHpBps5zStgsnDPJ9ex8IOTV1T3TzE3jAU/88iaTN9fxvauihzihPI=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663888985;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:Message-ID:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=47PJYP6qxMTZvHY8exgCyBof51XcmyP2fwLKe2IOtwI=;
	b=TW8AU5fVaAZ8LQRvyvihoShMMM572WxnLusRtOMEFPebX+UxHAWHjep+QJSDkPKJ
	PWvi5Di98/PAyXuUz2elH65dUEMFHMu0l1PyuFSMNLTOJgtUwZz4qlO4Bwd7B58dfIz
	rrXR/9GNz6i/ogMbQpJplTAGiH4PSn7Y1RAbh1BA=
Received: from [192.168.1.25] (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663888982709913.8124644791819; Fri, 23 Sep 2022 01:23:02 +0200 (CEST)
Date: Fri, 23 Sep 2022 01:23:01 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH mptcp-next v2 0/4] mptcp: add support for TFO, sender side
 only
Content-Language: fr
To: benjamin.hesmans@tessares.net, mptcp@lists.linux.dev, pabeni@redhat.com
References: <20220921125558.19483-1-dmytro@shytyi.net>
From: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <709a843b-b7f7-438d-39c6-f139aaa55a10@shytyi.net>
In-Reply-To: <20220921125558.19483-1-dmytro@shytyi.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

Hello Benjamin, All,

I excuse for the later if I made any mistake.

My thought is comming from experience with the patch.


Will huge respect, I think this patch _*MUST NOT*_ be accepted because=20
of multiple reasons:

1. it violates the RFC 8684 [1] section B1:

"When a TFO initiator first connects to a listener, it cannot=20
immediately include data in the SYN for security reasons[RFC7413=20
<https://www.rfc-editor.org/rfc/rfc8684.html#RFC7413>]. Instead, it=20
requests a cookie that will be used in subsequent connections."


Also I created environment[3] using commit[2], I tested v0, v2 and I do=20
not see the mptcp capable option in SYN.

2. Abscense of MP_CAPABLE in SYN=C2=A0 violates the RFC 8684 [1] section B3=
.


3. Patch uses an original Idea of another autor from mailing list (Reuse=20
the TCP FASTOPEN option in MPTCP).


[1] RFC 8684: TCP Extensions for Multipath Operation with Multiple=20
Addresses (rfc-editor.org)=20
<https://www.rfc-editor.org/rfc/rfc8684.html#name-tfo-cookie-request-with-m=
pt>

[2][PATCH RFC mptcp-next 00/10] Implement TCP_FASTOPEN_CONNECT for mptcp=20
(kernel.org)=20
<https://lore.kernel.org/mptcp/20220908133829.3410092-1-benjamin.hesmans@te=
ssares.net/T/#m021bdd02260ccf1a556f7bbe5657acf9bf0cdb24>

[3]=C2=A0 preparation of environment provided by Benjamin's patch:

+ DO_CLEANUP=3D1
+ DO_MPTCPIZE=3D1
+ trap cleanup EXIT
+ ip netns add client
+ ip netns add server
+ netns client sysctl net.ipv4.tcp_fastopen=3D0x5
+ ns=3Dclient
+ shift
+ ip netns exec client sysctl net.ipv4.tcp_fastopen=3D0x5
net.ipv4.tcp_fastopen =3D 0x5
+ netns server sysctl net.ipv4.tcp_fastopen=3D0x602
+ ns=3Dserver
+ shift
+ ip netns exec server sysctl net.ipv4.tcp_fastopen=3D0x602
net.ipv4.tcp_fastopen =3D 0x602
+ netns client ip link add eth0 type veth peer eth0 netns server
+ ns=3Dclient
+ shift
+ ip netns exec client ip link add eth0 type veth peer eth0 netns server
+ netns client ip addr add 6.6.6.1/24 dev eth0
+ ns=3Dclient
+ shift
+ ip netns exec client ip addr add 6.6.6.1/24 dev eth0
+ netns server ip addr add 6.6.6.6/24 dev eth0
+ ns=3Dserver
+ shift
+ ip netns exec server ip addr add 6.6.6.6/24 dev eth0
+ netns client ip link set eth0 up
+ ns=3Dclient
+ shift
+ ip netns exec client ip link set eth0 up
+ netns server ip link set eth0 up
+ ns=3Dserver
+ shift
+ ip netns exec server ip link set eth0 up
[=C2=A0=C2=A0 36.774284] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes =
ready
+ sleep 1
+ netns client tcpdump -i eth0 -w ./client.pcap
+ ns=3Dclient
+ shift
+ ip netns exec client tcpdump -i eth0 -w ./client.pcap
[=C2=A0=C2=A0 36.796976] device eth0 entered promiscuous mode
tcpdump: listening on eth0, link-type EN10MB (Ethernet), snapshot length=20
262144 bytes
+ '[' 1 =3D=3D 0 ']'
+ LD_PRELOAD=3D/home/awesome/workspace/userspace/mptcpize/libmptcpwrap.so
+ sleep 3
+ LD_PRELOAD=3D/home/awesome/workspace/userspace/mptcpize/libmptcpwrap.so
+ netns server python3 -m http.server 666
+ ns=3Dserver
+ shift
+ ip netns exec server python3 -m http.server 666
[=C2=A0=C2=A0 37.801129] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes =
ready
Serving HTTP on :: port 666 (http://[::]:666/) ...
+ LD_PRELOAD=3D/home/awesome/workspace/userspace/mptcpize/libmptcpwrap.so
+ netns client curl --tcp-fastopen -o out.txt http://6.6.6.6:666/tfo.sh
+ ns=3Dclient
+ shift
+ ip netns exec client curl --tcp-fastopen -o out.txt=20
http://6.6.6.6:666/tfo.sh
 =C2=A0 % Total=C2=A0=C2=A0=C2=A0 % Received % Xferd=C2=A0 Average Speed=C2=
=A0=C2=A0 Time=C2=A0=C2=A0=C2=A0 Time Time=C2=A0 Current
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Dload=C2=A0 Upload=C2=A0=C2=
=A0 Total=C2=A0=C2=A0 Spent Left=C2=A0 Speed
 =C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=
=C2=A0 0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 --:--:-- --:--:--=20
--:--:--=C2=A0=C2=A0=C2=A0=C2=A0 0::ffff:6.6.6.1 - - [22/Sep/2022 17:54:31]=
d
::ffff:6.6.6.1 - - [22/Sep/2022 17:54:31] "GET /tfo.sh HTTP/1.1" 404 -
100=C2=A0=C2=A0 469=C2=A0 100=C2=A0=C2=A0 469=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=
=A0=C2=A0=C2=A0 0=C2=A0 53289=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 --:--:-- --:-=
-:-- --:--:--=20
58625
+ sleep 3
+ cleanup
+ '[' 1 =3D=3D 0 ']'
+ pkill tcpdump
[=C2=A0=C2=A0 43.839628] device eth0 left promiscuous mode
24 packets captured
25 packets received by filter
0 packets dropped by kernel
+ pkill python
+ ip netns delete client
Terminated
+ ip netns delete server


> The series only consider the sender side.
>
> Compared to the previous RFC patches, these ones focus on
> the sender side only. It corresponds to the 4 first patches from the RFC
> series.
>
> The sending part is less complex and even if it looks like we are
> converging for the receive part, there are still discussions on-going
> there.
>
> Again, thank you Dmytro for the previous work done. As already discussed
> on the ML and meeting, this approach was slightly different from what
> Dmytro originally proposed. Here tcp_sendmsg_fastopen() is exported and
> re-used and TCP_FASTOPEN_CONNECT is supported.
>
> MSG_FASTOPEN will be handled by Dmytro's patches.
>
> Individual changelogs have been added per patch.
>
> v2:
> - Drop support for MSG_FASTOPEN because we were not sure that it was the
>    correct way to do it.
> - latest patch of the series: apply comment from Paolo concerning
>    mptcp_poll()
>
> Benjamin Hesmans (4):
>    mptcp: add TCP_FASTOPEN_CONNECT socket option
>    tcp: export tcp_sendmsg_fastopen
>    mptcp: handle defer connect in mptcp_sendmsg
>    mptcp: poll allow write call before actual connect
>
>   include/net/tcp.h    |  2 ++
>   net/ipv4/tcp.c       |  5 ++---
>   net/mptcp/protocol.c | 26 ++++++++++++++++++++++++++
>   net/mptcp/sockopt.c  | 19 ++++++++++++++++++-
>   4 files changed, 48 insertions(+), 4 deletions(-)
>
> --=20
> 2.25.1
>

