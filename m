Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C20F72
	for <mptcp@lists.linux.dev>; Wed, 10 Nov 2021 19:37:38 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="213474384"
X-IronPort-AV: E=Sophos;i="5.87,224,1631602800"; 
   d="scan'208";a="213474384"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 11:35:53 -0800
X-IronPort-AV: E=Sophos;i="5.87,224,1631602800"; 
   d="scan'208";a="452437999"
Received: from pkkelley-mobl.amr.corp.intel.com ([10.209.109.110])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 11:35:52 -0800
Date: Wed, 10 Nov 2021 11:35:52 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 1/3] mptcp: add TCP_INQ cmsg support
In-Reply-To: <9ac5fe56-ff93-613f-13a-8017b938ceb6@linux.intel.com>
Message-ID: <ed6bb478-c85f-34e2-70c1-424dccb082a7@linux.intel.com>
References: <20211108105711.16200-1-fw@strlen.de> <20211108105711.16200-2-fw@strlen.de> <add0921a-4ce2-a3d4-d4d-442d4e88365f@linux.intel.com> <20211110101732.GE16363@breakpoint.cc> <9ac5fe56-ff93-613f-13a-8017b938ceb6@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 10 Nov 2021, Mat Martineau wrote:

> On Wed, 10 Nov 2021, Florian Westphal wrote:
>
>> Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
>>> On Mon, 8 Nov 2021, Florian Westphal wrote:
>>> 
>>> I did run in to a selftest failure, but could not reproduce:
>>> 
>>> $ sudo ./mptcp_sockopt.sh
>>> Created /tmp/tmp.Kj9eQSvhn3 (size 1024 KB) containing data sent by client
>>> Created /tmp/tmp.qOpE4X43Jp (size 1024 KB) containing data sent by server
>>> tcp_inq is larger than one mbyte
>>> copyfd_io_poll: poll timed out (events: POLLIN 0, POLLOUT 4)
>>>  client exit code 1, server 2
>> 
>> Hmm, could not repro either so far.
>> 
>
> Still trying here, modified the test to show the inq value in case that helps 
> debug.

Well, that was quick:

"tcp_inq=7ffffffe is larger than one mbyte"

At least it's the expected INT_MAX - 1 value... I'll instrument the kernel 
some more and try again.



The rest of the failure dump:

copyfd_io_poll: poll timed out (events: POLLIN 0, POLLOUT 4)
  client exit code 1, server 2

netns ns1-0-ExcWL9 socket stat for 12001:
Netid                        State                            Recv-Q                        Send-Q                                                  Local Address:Port                                                    Peer Address:Port                         Process 
tcp                          TIME-WAIT                        0                             0                                                            10.0.3.1:12001                                                       10.0.3.2:45689                         timer:(timewait,28sec,0) ino:0 sk:1 fwmark:0x1

tcp                          TIME-WAIT                        0                             0                                                            10.0.1.1:12001                                                       10.0.1.2:55212                         timer:(timewait,28sec,0) ino:0 sk:2 fwmark:0x1

tcp                          TIME-WAIT                        0                             0                                                            10.0.2.1:12001                                                       10.0.2.2:41595                         timer:(timewait,28sec,0) ino:0 sk:3 fwmark:0x1

tcp                          TIME-WAIT                        0                             0                                                            10.0.4.1:12001                                                       10.0.4.2:54849                         timer:(timewait,28sec,0) ino:0 sk:4 fwmark:0x1

tcp                          ESTAB                            0                             0                                                    [dead:beef:1::1]:12001                                               [dead:beef:1::2]:52336                         ino:0 sk:5 fwmark:0x1 <->
 	 ts sack cubic wscale:7,7 rto:203 rtt:2.136/2.521 ato:40 mss:1428 pmtu:1500 rcvmss:1428 advmss:1428 cwnd:27 ssthresh:27 bytes_sent:5020656 bytes_acked:5020656 bytes_received:81527 segs_out:3748 segs_in:746 data_segs_out:3718 data_segs_in:62 send 144404494bps lastsnd:137 lastrcv:30088 lastack:137 pacing_rate 173285392bps delivery_rate 215547168bps delivered:3719 busy:1372ms rwnd_limited:1ms(0.1%) sndbuf_limited:49ms(3.6%) rcv_rtt:1.095 rcv_space:14400 rcv_ssthresh:64096 minrtt:0.081 tcp-ulp-mptcp flags:Mec token:0000(id:0)/587fabd7(id:0) seq:1c219faa3cd01b83 sfseq:e001 ssnoff:f8380bd4 maplen:5e77
mptcp                        LAST-ACK                         0                             0                                                    [dead:beef:1::1]:12001                                               [dead:beef:1::2]:52336                         timer:(keepalive,59sec,0) ino:0 sk:6 fwmark:0x1 ---
 	 subflows:7 add_addr_signal:8 add_addr_accepted:7 subflows_max:8 add_addr_signal_max:8 add_addr_accepted_max:8 remote_key token:587fabd7 write_seq:674f10efa988edc3 snd_una:674f10efa985917a rcv_nxt:1c219faa3cd079fb

netns ns2-0-ExcWL9 socket stat for 12001:
Netid                       State                             Recv-Q                         Send-Q                                                  Local Address:Port                                                    Peer Address:Port                        Process 
tcp                         ESTAB                             4843536                        0                                                    [dead:beef:1::2]:52336                                               [dead:beef:1::1]:12001                        ino:0 sk:1001 fwmark:0x2 <->
 	 ts sack cubic wscale:7,7 rto:201 rtt:0.895/0.65 ato:40 mss:1428 pmtu:1500 rcvmss:1400 advmss:1428 cwnd:22 ssthresh:20 bytes_sent:81527 bytes_acked:81528 bytes_received:5020656 segs_out:746 segs_in:3749 data_segs_out:62 data_segs_in:3718 send 280813408bps lastsnd:30109 lastrcv:158 lastack:66 pacing_rate 336834952bps delivery_rate 232090288bps delivered:63 busy:5ms rcv_rtt:103.546 rcv_space:14280 rcv_ssthresh:351074 minrtt:0.176 tcp-ulp-mptcp flags:Mmec token:0000(id:0)/ec432c53(id:0) seq:674f10efa985727a sfseq:294e1 ssnoff:cc6bcb15 maplen:1f00
mptcp                       FIN-WAIT-2                        62616                          0                                                    [dead:beef:1::2]:52336                                               [dead:beef:1::1]:12001                        timer:(keepalive,29sec,0) ino:0 sk:1002 fwmark:0x2 ---
 	 subflows:7 add_addr_signal:8 add_addr_accepted:7 subflows_max:8 add_addr_signal_max:8 add_addr_accepted_max:8 remote_key token:ec432c53 write_seq:1c219faa3cd079fb snd_una:1c219faa3cd079fb rcv_nxt:674f10efa985917a



--
Mat Martineau
Intel
