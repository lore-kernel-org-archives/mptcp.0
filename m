Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACB92FB2
	for <mptcp@lists.linux.dev>; Tue, 15 Jun 2021 00:14:31 +0000 (UTC)
IronPort-SDR: Ksk/8gYCNIOa+9v6e/g7v2/0tJOGgZrrf5nkXi9G0znCu+nldGtbd50vJpWTfbh54+72BL4mIb
 pecsNHmCWohw==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="205718331"
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="205718331"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 17:14:30 -0700
IronPort-SDR: CU7aS2u052otkW80FJc09EaHjLdITTb+gm0wo0YhHJdRp3Qe4hUC9OomXX17+Uyg6EWZIDxHhY
 Q31q7V/u7pcQ==
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="553516812"
Received: from qyhenrio-mobl1.amr.corp.intel.com ([10.209.5.65])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 17:14:30 -0700
Date: Mon, 14 Jun 2021 17:14:29 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: Matthieu Baerts <matthieu.baerts@tessares.net>, 
    Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Subject: Re: MPTCP checksum interop
In-Reply-To: <8cceb711ad974911da62d62a354e6569b573e0b2.camel@redhat.com>
Message-ID: <be45ce3-c6ab-df89-96cc-1f9cdb4babdc@linux.intel.com>
References: <aedffae2-61ad-eb44-c083-e674f736fd96@linux.intel.com> <8cceb711ad974911da62d62a354e6569b573e0b2.camel@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 14 Jun 2021, Paolo Abeni wrote:

> Hello
>
> On Fri, 2021-06-11 at 20:57 -0700, Mat Martineau wrote:
>> I did some tests with connections with checksums enabled, between the
>> export branch and the multipath-tcp.org mptcp_trunk branch (v1 mode).
>
> Thank you for checking!
>
>> When the multipath-tcp.org kernel was listening, the connection would
>> always fall back to TCP when the first data was sent by the upstream
>> kernel. The multipath-tcp.org kernel was the first to fall back and stop
>> sending MPTCP headers.
>
> This sounds like a csum error detected ??! What does wireshark say
> about the MPTCP csum value?

Wireshark doesn't complain about the checksum, and the MPTCP option parses 
cleanly.

Fallback appears to have more to do with mptcp_trunk's handling for 
MP_CAPABLE + data. I turned on debug output on the mptcp_trunk side and 
saw:

mptcp_prevalidate_skb: mptcp_prevalidate_skb 0xc20cfa4 will fallback - pi 1 from tcp_data_queue+0x444/0x600, seq 2884338481 mptcp-flags 0x0

This might be the problem in mptcp.h:

#define MPTCPV1_SUB_LEN_CAPABLE_DATA		22
#define MPTCPV1_SUB_LEN_CAPABLE_DATA_CSUM	22   // <---- should be 24


>
>> When the upstream kernel was listening, the multipath-tcp.org kernel would
>> send corrupt TCP options with the first data packet (the first time a DSS
>> option was sent). The upstream kernel would then send TCP RST.
>
> How does TCP option look like? Could you please share a short pcap
> snippet?

The MPTCP option is not of the correct length to contain a checksum, and 
the bytes after the MPTCP option are getting interpreted by Wireshark as a 
separate (broken) option. That broken option looks like random bytes: 
invalid option number and way-too-large option length. The 
multipath-tcp.org kernel is also sending MP_CAPABLE + data here. The above 
definitions look suspicous for this too.

I'll add a github issue and upload the .pcap

--
Mat Martineau
Intel
