Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258C114A60C
	for <mptcp@lists.linux.dev>; Wed,  8 Oct 2025 03:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759892840; cv=none; b=K1OHvaYo/537VKqeUSU7amYejNr6WCFli1m1EkzD3WbNsXT60zjDKCtQSGH+c8OkhQZ5cZesKuAtGAPBpg+Cu6dIzh9Gyp5arOQN2ChzOzNEcs/GPtCrfwV+oSiLX0abHPFRCFrjh44LbqnlO1CzbCfcp7/6GONvFy0P3cVMo1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759892840; c=relaxed/simple;
	bh=2MbRBDmQ/qh3Ll95dMD8ulTUmY+5lXhULDDIaCevJqc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kc5UikVuwjtPs6oYEgl53RA+SzZWzLSVZBhS8JpcBqtLcbpRSBPCD8AqE8whT5IKEUfmKobiH9R9R7lLp3gxbhEs1MSj57rGJRuogHFUhpp4gSg75WyCrtkEma1M1P/G4vmOqtGYQkTotbXUVTj0UYJagbW+VXR3EBWvGrOWa6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWLNWxw+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWLNWxw+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AE0C4CEF1;
	Wed,  8 Oct 2025 03:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759892839;
	bh=2MbRBDmQ/qh3Ll95dMD8ulTUmY+5lXhULDDIaCevJqc=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=ZWLNWxw+Rix/bhPZp2gugWu3PxIGogOBLDVR8x/Nz4AKxmjpRGIteSFPPkqphQqkI
	 ntijKT68Woai5Uj7iBE7e+jq1bFgIjJmEBYPByI3fUa7DjexIyR2mUw4Xg1UmhlfoV
	 1SBQp6Yul00sr4O0Fa3SZglt/2E2PuRR/jAGxs429j4PHS0X//RcrWPHPAts1qmP70
	 AeboNF87jWwmzRbbb/ftQwM1QxASe7t3UErQGs7cW6wptQ64dBHo/thDQM3KZX99lK
	 c8eLplHisJDk75QXqHJmsvBZiSFxfqv8+kQdJds4srfJeHYa55xbbi+kwsGt53Zkqa
	 FkOnit/oqgRNg==
Message-ID: <d0a814c364e744ca6b836ccd5b6e9146882e8d42.camel@kernel.org>
Subject: Re: [PATCH v5 mptcp-next 00/10] mptcp: introduce backlog processing
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	mptcp@lists.linux.dev
Date: Wed, 08 Oct 2025 11:07:16 +0800
In-Reply-To: <2c9f131e-ef34-4916-8aab-e1420e1ae90b@kernel.org>
References: <cover.1759737859.git.pabeni@redhat.com>
	 <2c9f131e-ef34-4916-8aab-e1420e1ae90b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Paolo, Matt,

On Mon, 2025-10-06 at 19:07 +0200, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 06/10/2025 10:11, Paolo Abeni wrote:
> > This series includes RX path improvement built around backlog
> > processing
> Thank you for the new version! This is not a review, but just a note
> to
> tell you patchew didn't manage to apply the patches due to the same
> conflict that was already there with the v4 (mptcp_init_skb()
> parameters
> have been moved to the previous line). I just applied the patches
> manually. While at it, I also used this test branch for syzkaller to
> validate them.
> 
> (Also, on patch "mptcp: drop the __mptcp_data_ready() helper", git
> complained that there is a trailing whitespace.)

Sorry, patches 9-10 break my "implement mptcp read_sock" v12 series. I
rebased this series on patches 1-8, it works well. But after applying
patches 9-10, I changed mptcp_recv_skb() in [1] from

static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
{
        struct mptcp_sock *msk = mptcp_sk(sk);
        struct sk_buff *skb;
        u32 offset;

        if (skb_queue_empty(&sk->sk_receive_queue))
                __mptcp_move_skbs(sk);

        while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
                offset = MPTCP_SKB_CB(skb)->offset;
                if (offset < skb->len) {
                        *off = offset;
                        return skb; 
                }    
                mptcp_eat_recv_skb(sk, skb);
        }    
        return NULL;
}

to

static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
{
        struct mptcp_sock *msk = mptcp_sk(sk);
        struct sk_buff *skb;
        u32 offset;

        if (!list_empty(&msk->backlog_list))
                mptcp_move_skbs(sk);

        while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
                offset = MPTCP_SKB_CB(skb)->offset;
                if (offset < skb->len) {
                        *off = offset;
                        return skb; 
                }    
                mptcp_eat_recv_skb(sk, skb);
        }    
        return NULL;
}

The splice tests (mptcp_connect_splice.sh) have a low probability
(approximately 1 in 100) of reporting timeout failures:


	=== Attempt: 158 (Wed, 08 Oct 2025 02:35:45 +0000) ===


Selftest Test: ./mptcp_connect_splice.sh
TAP version 13
1..1
# INFO: set ns3-0wY081 dev ns3eth2: ethtool -K  gso off gro off
# INFO: set ns4-MjBWza dev ns4eth3: ethtool -K tso off gro off
# Created /tmp/tmp.rxe4DwYW9E (size 5136 B) containing data sent by
client
# Created /tmp/tmp.0H0GbllUo9 (size 7193203 B) containing data sent by
server
# 01 New MPTCP socket can be blocked via sysctl                       
[ OK ]
# 02 Validating network environment with pings                        
[ OK ]
# INFO: Using loss of 0.07% delay 21 ms reorder 99% 66% with delay 5ms
on ns3eth4
# INFO: extra options:  -m splice
# 03 ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP     (duration  
152ms) [ OK ]
# 04 ns1 MPTCP -> ns1 (10.0.1.1:10001      ) TCP       (duration  
152ms) [ OK ]
# 05 ns1 TCP   -> ns1 (10.0.1.1:10002      ) MPTCP     (duration  
149ms) [ OK ]
# 06 ns1 MPTCP -> ns1 (dead:beef:1::1:10003) MPTCP     (duration  
151ms) [ OK ]
# 07 ns1 MPTCP -> ns1 (dead:beef:1::1:10004) TCP       (duration  
169ms) [ OK ]
# 08 ns1 TCP   -> ns1 (dead:beef:1::1:10005) MPTCP     (duration  
152ms) [ OK ]
# 09 ns1 MPTCP -> ns2 (10.0.1.2:10006      ) MPTCP     (duration  
172ms) [ OK ]
# 10 ns1 MPTCP -> ns2 (dead:beef:1::2:10007) MPTCP     (duration  
172ms) [ OK ]
# 11 ns1 MPTCP -> ns2 (10.0.2.1:10008      ) MPTCP     (duration  
157ms) [ OK ]
# 12 ns1 MPTCP -> ns2 (dead:beef:2::1:10009) MPTCP     (duration  
157ms) [ OK ]
# 13 ns1 MPTCP -> ns3 (10.0.2.2:10010      ) MPTCP     (duration  
497ms) [ OK ]
# 14 ns1 MPTCP -> ns3 (dead:beef:2::2:10011) MPTCP     (duration  
500ms) [ OK ]
# 15 ns1 MPTCP -> ns3 (10.0.3.2:10012      ) MPTCP     (duration  
602ms) [ OK ]
# 16 ns1 MPTCP -> ns3 (dead:beef:3::2:10013) MPTCP     (duration  
571ms) [ OK ]
# 17 ns1 MPTCP -> ns4 (10.0.3.1:10014      ) MPTCP     (duration  
544ms) [ OK ]
# 18 ns1 MPTCP -> ns4 (dead:beef:3::1:10015) MPTCP     (duration  
627ms) [ OK ]
# 19 ns2 MPTCP -> ns1 (10.0.1.1:10016      ) MPTCP     (duration  
136ms) [ OK ]
# 20 ns2 MPTCP -> ns1 (dead:beef:1::1:10017) MPTCP     (duration  
181ms) [ OK ]
# 21 ns2 MPTCP -> ns3 (10.0.2.2:10018      ) MPTCP     (duration  
415ms) [ OK ]
# 22 ns2 MPTCP -> ns3 (dead:beef:2::2:10019) MPTCP     (duration  
490ms) [ OK ]
# 23 ns2 MPTCP -> ns3 (10.0.3.2:10020      ) MPTCP     (duration  
438ms) [ OK ]
# 24 ns2 MPTCP -> ns3 (dead:beef:3::2:10021) MPTCP     (duration  
498ms) [ OK ]
# 25 ns2 MPTCP -> ns4 (10.0.3.1:10022      ) MPTCP     (duration  
602ms) [ OK ]
# 26 ns2 MPTCP -> ns4 (dead:beef:3::1:10023) MPTCP     (duration  
559ms) [ OK ]
# 27 ns3 MPTCP -> ns1 (10.0.1.1:10024      ) MPTCP     (duration  
580ms) [ OK ]
# 28 ns3 MPTCP -> ns1 (dead:beef:1::1:10025) MPTCP     (duration  
603ms) [ OK ]
# 29 ns3 MPTCP -> ns2 (10.0.1.2:10026      ) MPTCP     (duration  
628ms) [ OK ]
# 30 ns3 MPTCP -> ns2 (dead:beef:1::2:10027) MPTCP     (duration  
451ms) [ OK ]
# 31 ns3 MPTCP -> ns2 (10.0.2.1:10028      ) MPTCP     (duration  
416ms) [ OK ]
# 32 ns3 MPTCP -> ns2 (dead:beef:2::1:10029) MPTCP     (duration  
497ms) [ OK ]
# 33 ns3 MPTCP -> ns4 (10.0.3.1:10030      ) MPTCP     (duration  
159ms) [ OK ]
# 34 ns3 MPTCP -> ns4 (dead:beef:3::1:10031) MPTCP     (duration  
156ms) [ OK ]
# 35 ns4 MPTCP -> ns1 (10.0.1.1:10032      ) MPTCP     (duration  
574ms) [ OK ]
# 36 ns4 MPTCP -> ns1 (dead:beef:1::1:10033) MPTCP     (duration  
863ms) [ OK ]
# 37 ns4 MPTCP -> ns2 (10.0.1.2:10034      ) MPTCP     (duration  
471ms) [ OK ]
# 38 ns4 MPTCP -> ns2 (dead:beef:1::2:10035) MPTCP     (duration  
538ms) [ OK ]
# 39 ns4 MPTCP -> ns2 (10.0.2.1:10036      ) MPTCP     (duration  
520ms) [ OK ]
# 40 ns4 MPTCP -> ns2 (dead:beef:2::1:10037) MPTCP     (duration  
511ms) [ OK ]
# 41 ns4 MPTCP -> ns3 (10.0.2.2:10038      ) MPTCP     (duration  
137ms) [ OK ]
# 42 ns4 MPTCP -> ns3 (dead:beef:2::2:10039) MPTCP     (duration  
155ms) [ OK ]
# 43 ns4 MPTCP -> ns3 (10.0.3.2:10040      ) MPTCP     (duration  
563ms) [ OK ]
# 44 ns4 MPTCP -> ns3 (dead:beef:3::2:10041) MPTCP     (duration  
152ms) [ OK ]
# INFO: with peek mode: saveWithPeek
# 45 ns1 MPTCP -> ns1 (10.0.1.1:10042      ) MPTCP     (duration  
150ms) [ OK ]
# 46 ns1 MPTCP -> ns1 (10.0.1.1:10043      ) TCP       (duration  
184ms) [ OK ]
# 47 ns1 TCP   -> ns1 (10.0.1.1:10044      ) MPTCP     (duration  
153ms) [ OK ]
# 48 ns1 MPTCP -> ns1 (dead:beef:1::1:10045) MPTCP     (duration  
154ms) [ OK ]
# 49 ns1 MPTCP -> ns1 (dead:beef:1::1:10046) TCP       (duration  
148ms) [ OK ]
# 50 ns1 TCP   -> ns1 (dead:beef:1::1:10047) MPTCP     (duration  
175ms) [ OK ]
# INFO: with peek mode: saveAfterPeek
# 51 ns1 MPTCP -> ns1 (10.0.1.1:10048      ) MPTCP     (duration  
175ms) [ OK ]
# 52 ns1 MPTCP -> ns1 (10.0.1.1:10049      ) TCP       (duration  
155ms) [ OK ]
# 53 ns1 TCP   -> ns1 (10.0.1.1:10050      ) MPTCP     (duration  
146ms) [ OK ]
# 54 ns1 MPTCP -> ns1 (dead:beef:1::1:10051) MPTCP     (duration  
153ms) [ OK ]
# 55 ns1 MPTCP -> ns1 (dead:beef:1::1:10052) TCP       (duration  
153ms) [ OK ]
# 56 ns1 TCP   -> ns1 (dead:beef:1::1:10053) MPTCP     (duration  
151ms) [ OK ]
# INFO: with MPTFO start
# 57 ns2 MPTCP -> ns1 (10.0.1.1:10054      ) MPTCP     (duration
60989ms) [FAIL] client exit code 0, server 124
# 
# netns ns1-RqXF2p (listener) socket stat for 10054:
# Failed to find cgroup2 mount
# Failed to find cgroup2 mount
# Failed to find cgroup2 mount
# Netid State    Recv-Q Send-Q Local Address:Port  Peer Address:Port  
# tcp   ESTAB    0      0           10.0.1.1:10054     10.0.1.2:55516
ino:2064372 sk:1 cgroup:unreachable:1 <->
# 	 skmem:(r0,rb131072,t0,tb340992,f0,w0,o0,bl0,d0) sack cubic
wscale:8,8 rto:206 rtt:5.026/10.034 ato:40 mss:1460 pmtu:1500
rcvmss:1436 advmss:1460 cwnd:10 bytes_sent:115312 bytes_retrans:1560
bytes_acked:113752 bytes_received:5136 segs_out:85 segs_in:16
data_segs_out:83 data_segs_in:4 send 23239156bps lastsnd:60939
lastrcv:61035 lastack:60912 pacing_rate 343879640bps delivery_rate
1994680bps delivered:84 busy:123ms sndbuf_limited:41ms(33.3%)
retrans:0/2 dsack_dups:2 rcv_space:14600 rcv_ssthresh:75432
minrtt:0.003 rcv_wnd:75520 tcp-ulp-mptcp flags:Mec
token:0000(id:0)/32ed0950(id:0) seq:2946228641406205031 sfseq:1
ssnoff:1349223625 maplen:5136
# mptcp LAST-ACK 0      0           10.0.1.1:10054     10.0.1.2:55516
timer:(keepalive,59sec,0) ino:0 sk:2 cgroup:unreachable:1 ---
# 	 skmem:(r0,rb131072,t0,tb345088,f4088,w352264,o0,bl0,d0)
subflows_max:2 remote_key token:32ed0950 write_seq:6317574787800720824
snd_una:6317574787800376423 rcv_nxt:2946228641406210168
bytes_sent:113752 bytes_received:5136 bytes_acked:113752
subflows_total:1 last_data_sent:60954 last_data_recv:61036
last_ack_recv:60913                                                   
# TcpPassiveOpens                 1                  0.0
# TcpInSegs                       13                 0.0
# TcpOutSegs                      84                 0.0
# TcpRetransSegs                  2                  0.0
# TcpExtTCPPureAcks               11                 0.0
# TcpExtTCPLossProbes             3                  0.0
# TcpExtTCPDSACKRecv              2                  0.0
# TcpExtTCPDSACKIgnoredNoUndo     2                  0.0
# TcpExtTCPFastOpenCookieReqd     1                  0.0
# TcpExtTCPOrigDataSent           81                 0.0
# TcpExtTCPDelivered              83                 0.0
# TcpExtTCPDSACKRecvSegs          2                  0.0
# MPTcpExtMPCapableSYNRX          1                  0.0
# MPTcpExtMPCapableACKRX          1                  0.0
# 
# netns ns2-xZI1rh (connector) socket stat for 10054:
# Failed to find cgroup2 mount
# Failed to find cgroup2 mount
# Failed to find cgroup2 mount
# Netid State      Recv-Q Send-Q Local Address:Port  Peer Address:Port
# tcp   ESTAB      0      0           10.0.1.2:55516     10.0.1.1:10054
ino:2065678 sk:3 cgroup:unreachable:1 <->
# 	 skmem:(r0,rb131072,t0,tb46080,f12288,w0,o0,bl0,d2) sack cubic
wscale:8,8 rto:201 rtt:0.029/0.016 ato:80 mss:1460 pmtu:1500
rcvmss:1432 advmss:1460 cwnd:10 bytes_sent:5136 bytes_acked:5137
bytes_received:113752 segs_out:16 segs_in:86 data_segs_out:4
data_segs_in:83 send 4027586207bps lastsnd:61068 lastrcv:60986
lastack:60972 pacing_rate 7852100840bps delivery_rate 6674285712bps
delivered:5 rcv_rtt:0.043 rcv_space:14600 rcv_ssthresh:114691
minrtt:0.007 snd_wnd:75520 tcp-ulp-mptcp flags:Mmec
token:0000(id:0)/73d713b3(id:0) seq:6317574787800368999 sfseq:106329
ssnoff:821551077 maplen:7424
# mptcp FIN-WAIT-2 124504 0           10.0.1.2:55516     10.0.1.1:10054
timer:(keepalive,,0) ino:0 sk:4 cgroup:unreachable:1 ---
# 	 skmem:(r124504,rb131072,t0,tb50176,f6568,w0,o0,bl0,d0)
subflows_max:2 remote_key token:73d713b3 write_seq:2946228641406210168
snd_una:2946228641406210168 rcv_nxt:6317574787800376423 bytes_sent:5136
bytes_received:113752 bytes_acked:5137 subflows_total:1
last_data_sent:61068 last_data_recv:60986 last_ack_recv:60972         
# TcpActiveOpens                  1                  0.0
# TcpInSegs                       17                 0.0
# TcpOutSegs                      16                 0.0
# TcpExtDelayedACKs               3                  0.0
# TcpExtDelayedACKLost            2                  0.0
# TcpExtTCPPureAcks               2                  0.0
# TcpExtTCPDSACKOldSent           2                  0.0
# TcpExtTCPToZeroWindowAdv        1                  0.0
# TcpExtTCPOrigDataSent           4                  0.0
# TcpExtTCPDelivered              5                  0.0
# MPTcpExtMPCapableSYNTX          1                  0.0
# MPTcpExtMPCapableSYNACKRX       1                  0.0
# 
# 58 ns2 MPTCP -> ns1 (10.0.1.1:10055      ) MPTCP     (duration
60992ms) [FAIL] client exit code 0, server 124
# 
# netns ns1-RqXF2p (listener) socket stat for 10055:
# Netid State Recv-Q Send-Q Local Address:Port Peer Address:Port
# TcpPassiveOpens                 1                  0.0
# TcpEstabResets                  2                  0.0
# TcpInSegs                       28                 0.0
# TcpOutSegs                      142                0.0
# TcpRetransSegs                  22                 0.0
# TcpExtTCPPureAcks               23                 0.0
# TcpExtTCPLostRetransmit         8                  0.0
# TcpExtTCPSlowStartRetrans       13                 0.0
# TcpExtTCPTimeouts               1                  0.0
# TcpExtTCPLossProbes             1                  0.0
# TcpExtTCPBacklogCoalesce        1                  0.0
# TcpExtTCPFastOpenPassive        1                  0.0
# TcpExtTCPOrigDataSent           138                0.0
# TcpExtTCPDelivered              83                 0.0
# TcpExtTcpTimeoutRehash          1                  0.0
# MPTcpExtMPCapableSYNRX          1                  0.0
# MPTcpExtMPCapableACKRX          1                  0.0
# MPTcpExtMPFastcloseRx           2                  0.0
# MPTcpExtMPRstRx                 2                  0.0
# MPTcpExtSndWndShared            5                  0.0
# 
# netns ns2-xZI1rh (connector) socket stat for 10055:
# Netid State Recv-Q Send-Q Local Address:Port Peer Address:Port
# TcpActiveOpens                  1                  0.0
# TcpEstabResets                  2                  0.0
# TcpInSegs                       32                 0.0
# TcpOutSegs                      30                 0.0
# TcpOutRsts                      2                  0.0
# TcpExtBeyondWindow              4                  0.0
# TcpExtDelayedACKs               2                  0.0
# TcpExtTCPPureAcks               3                  0.0
# TcpExtTCPFastOpenActive         1                  0.0
# TcpExtTCPToZeroWindowAdv        1                  0.0
# TcpExtTCPOrigDataSent           4                  0.0
# TcpExtTCPDelivered              5                  0.0
# TcpExtTCPZeroWindowDrop         10                 0.0
# MPTcpExtMPCapableSYNTX          1                  0.0
# MPTcpExtMPCapableSYNACKRX       1                  0.0
# MPTcpExtMPFastcloseTx           2                  0.0
# MPTcpExtMPRstTx                 2                  0.0
# 
# 59 ns2 MPTCP -> ns1 (dead:beef:1::1:10056) MPTCP     (duration
60983ms) [FAIL] client exit code 0, server 124
# 
# netns ns1-RqXF2p (listener) socket stat for 10056:
# Failed to find cgroup2 mount
# Failed to find cgroup2 mount
# Failed to find cgroup2 mount
# Netid State    Recv-Q Send-Q    Local Address:Port      Peer
Address:Port                                                          
# tcp   ESTAB    0      0      [dead:beef:1::1]:10056
[dead:beef:1::2]:51008 ino:2066517 sk:5 cgroup:unreachable:1 <->
# 	 skmem:(r0,rb131072,t0,tb354816,f0,w0,o0,bl0,d0) sack cubic
wscale:8,8 rto:206 rtt:5.142/10.26 ato:40 mss:1440 pmtu:1500
rcvmss:1416 advmss:1440 cwnd:10 bytes_sent:116192 bytes_retrans:1860
bytes_acked:114332 bytes_received:5136 segs_out:88 segs_in:16
data_segs_out:86 data_segs_in:4 send 22403734bps lastsnd:60928
lastrcv:61025 lastack:60901 pacing_rate 345009112bps delivery_rate
1967640bps delivered:87 busy:123ms sndbuf_limited:41ms(33.3%)
retrans:0/2 dsack_dups:2 rcv_space:14400 rcv_ssthresh:74532
minrtt:0.003 rcv_wnd:74752 tcp-ulp-mptcp flags:Mec
token:0000(id:0)/dfc0f4f3(id:0) seq:4063451370598395855 sfseq:1
ssnoff:3788096358 maplen:5136
# mptcp LAST-ACK 0      0      [dead:beef:1::1]:10056
[dead:beef:1::2]:51008 timer:(keepalive,59sec,0) ino:0 sk:6
cgroup:unreachable:1 ---
# 	 skmem:(r0,rb131072,t0,tb358912,f316,w351940,o0,bl0,d0)
subflows_max:2 remote_key token:dfc0f4f3 write_seq:2127521061748173342
snd_una:2127521061747829521 rcv_nxt:4063451370598400992
bytes_sent:114332 bytes_received:5136 bytes_acked:114332
subflows_total:1 last_data_sent:60942 last_data_recv:61025
last_ack_recv:60901                                                   
# TcpPassiveOpens                 1                  0.0
# TcpInSegs                       13                 0.0
# TcpOutSegs                      87                 0.0
# TcpRetransSegs                  2                  0.0
# TcpExtTCPPureAcks               11                 0.0
# TcpExtTCPLossProbes             3                  0.0
# TcpExtTCPDSACKRecv              2                  0.0
# TcpExtTCPDSACKIgnoredNoUndo     2                  0.0
# TcpExtTCPFastOpenCookieReqd     1                  0.0
# TcpExtTCPOrigDataSent           84                 0.0
# TcpExtTCPDelivered              86                 0.0
# TcpExtTCPDSACKRecvSegs          2                  0.0
# MPTcpExtMPCapableSYNRX          1                  0.0
# MPTcpExtMPCapableACKRX          1                  0.0
# 
# netns ns2-xZI1rh (connector) socket stat for 10056:
# Failed to find cgroup2 mount
# Failed to find cgroup2 mount
# Failed to find cgroup2 mount
# Netid State      Recv-Q Send-Q    Local Address:Port      Peer
Address:Port                                                          
# tcp   ESTAB      0      0      [dead:beef:1::2]:51008
[dead:beef:1::1]:10056 ino:2065857 sk:7 cgroup:unreachable:1 <->
# 	 skmem:(r0,rb131072,t0,tb46080,f12288,w0,o0,bl0,d2) sack cubic
wscale:8,8 rto:201 rtt:0.032/0.018 ato:80 mss:1440 pmtu:1500
rcvmss:1412 advmss:1440 cwnd:10 bytes_sent:5136 bytes_acked:5137
bytes_received:114332 segs_out:16 segs_in:89 data_segs_out:4
data_segs_in:86 send 3600000000bps lastsnd:61060 lastrcv:60977
lastack:60963 pacing_rate 7116602312bps delivery_rate 6582857136bps
delivered:5 rcv_rtt:0.051 rcv_space:14400 rcv_ssthresh:115128
minrtt:0.007 snd_wnd:74752 tcp-ulp-mptcp flags:Mmec
token:0000(id:0)/45f63d89(id:0) seq:2127521061747821841 sfseq:106653
ssnoff:320893875 maplen:7680
# mptcp FIN-WAIT-2 124188 0      [dead:beef:1::2]:51008
[dead:beef:1::1]:10056 timer:(keepalive,,0) ino:0 sk:8
cgroup:unreachable:1 ---
# 	 skmem:(r124188,rb131072,t0,tb50176,f6884,w0,o0,bl0,d0)
subflows_max:2 remote_key token:45f63d89 write_seq:4063451370598400992
snd_una:4063451370598400992 rcv_nxt:2127521061747829521 bytes_sent:5136
bytes_received:114332 bytes_acked:5137 subflows_total:1
last_data_sent:61060 last_data_recv:60977 last_ack_recv:60963         
# TcpActiveOpens                  1                  0.0
# TcpInSegs                       17                 0.0
# TcpOutSegs                      16                 0.0
# TcpExtDelayedACKs               3                  0.0
# TcpExtDelayedACKLost            2                  0.0
# TcpExtTCPPureAcks               2                  0.0
# TcpExtTCPDSACKOldSent           2                  0.0
# TcpExtTCPToZeroWindowAdv        1                  0.0
# TcpExtTCPOrigDataSent           4                  0.0
# TcpExtTCPDelivered              5                  0.0
# MPTcpExtMPCapableSYNTX          1                  0.0
# MPTcpExtMPCapableSYNACKRX       1                  0.0
# 
# 60 ns2 MPTCP -> ns1 (dead:beef:1::1:10057) MPTCP     (duration
60988ms) [FAIL] client exit code 0, server 124
# 
# netns ns1-RqXF2p (listener) socket stat for 10057:
# Netid State Recv-Q Send-Q Local Address:Port Peer Address:Port
# TcpPassiveOpens                 1                  0.0
# TcpEstabResets                  2                  0.0
# TcpInSegs                       29                 0.0
# TcpOutSegs                      144                0.0
# TcpRetransSegs                  22                 0.0
# TcpExtTCPPureAcks               23                 0.0
# TcpExtTCPLostRetransmit         8                  0.0
# TcpExtTCPSlowStartRetrans       13                 0.0
# TcpExtTCPTimeouts               1                  0.0
# TcpExtTCPLossProbes             1                  0.0
# TcpExtTCPBacklogCoalesce        2                  0.0
# TcpExtTCPFastOpenPassive        1                  0.0
# TcpExtTCPOrigDataSent           140                0.0
# TcpExtTCPDelivered              84                 0.0
# TcpExtTcpTimeoutRehash          1                  0.0
# MPTcpExtMPCapableSYNRX          1                  0.0
# MPTcpExtMPCapableACKRX          1                  0.0
# MPTcpExtMPFastcloseRx           2                  0.0
# MPTcpExtMPRstRx                 2                  0.0
# MPTcpExtSndWndShared            5                  0.0
# 
# netns ns2-xZI1rh (connector) socket stat for 10057:
# Netid State Recv-Q Send-Q Local Address:Port Peer Address:Port
# TcpActiveOpens                  1                  0.0
# TcpEstabResets                  2                  0.0
# TcpInSegs                       32                 0.0
# TcpOutSegs                      31                 0.0
# TcpOutRsts                      2                  0.0
# TcpExtBeyondWindow              4                  0.0
# TcpExtDelayedACKs               3                  0.0
# TcpExtTCPPureAcks               3                  0.0
# TcpExtTCPFastOpenActive         1                  0.0
# TcpExtTCPToZeroWindowAdv        1                  0.0
# TcpExtTCPOrigDataSent           4                  0.0
# TcpExtTCPDelivered              5                  0.0
# TcpExtTCPZeroWindowDrop         10                 0.0
# MPTcpExtMPCapableSYNTX          1                  0.0
# MPTcpExtMPCapableSYNACKRX       1                  0.0
# MPTcpExtMPFastcloseTx           2                  0.0
# MPTcpExtMPRstTx                 2                  0.0
# 
# INFO: with MPTFO end
# [FAIL] Tests with MPTFO have failed
# INFO: test tproxy ipv4
# 61 ns1 MPTCP -> ns2 (10.0.3.1:20000      ) MPTCP     (duration  
161ms) [ OK ]
# INFO: tproxy ipv4 pass
# INFO: test tproxy ipv6
# 62 ns1 MPTCP -> ns2 (dead:beef:3::1:20000) MPTCP     (duration  
163ms) [ OK ]
# INFO: tproxy ipv6 pass
# INFO: disconnect
# 63 ns1 MPTCP -> ns1 (10.0.1.1:20001      ) MPTCP     (duration   
54ms) [ OK ]
# 64 ns1 MPTCP -> ns1 (10.0.1.1:20002      ) TCP       (duration   
56ms) [ OK ]
# 65 ns1 TCP   -> ns1 (10.0.1.1:20003      ) MPTCP     (duration   
59ms) [ OK ]
# 66 ns1 MPTCP -> ns1 (dead:beef:1::1:20004) MPTCP     (duration   
60ms) [ OK ]
# 67 ns1 MPTCP -> ns1 (dead:beef:1::1:20005) TCP       (duration   
56ms) [ OK ]
# 68 ns1 TCP   -> ns1 (dead:beef:1::1:20006) MPTCP     (duration   
55ms) [ OK ]
# Time: 288 seconds
not ok 1 test: selftest_mptcp_connect_splice # FAIL
# time=288

=== ERROR after 158 attempts (Wed, 08 Oct 2025 02:40:34 +0000) ===

	Stopped after 158 attempts


I'm not sure if this error indicates a bug in patches 9-10, or if
there's an issue with the implementation of mptcp_recv_skb(). I'm still
unsure how to resolve it. Could you please give me some suggestions?


But patches 1-8 look good to me indeed:

Reviewed-by: Geliang Tang <geliang@kernel.org>

I'm wondering if we can merge patches 1-8 into the export branch first.
I changed the statues of them as "Queued" on patchwork.


Besides, I have one minor comment on patch 9, which I'll reply directly
on patch 9.


Thanks,
-Geliang

[1]
https://patchwork.kernel.org/project/mptcp/patch/2f159972f4aac7002a46ebc03b9d3898ece4c081.1758975929.git.tanggeliang@kylinos.cn/

> 
> Cheers,
> Matt

