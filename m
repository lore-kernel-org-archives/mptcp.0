Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFC67B
	for <mptcp@lists.linux.dev>; Thu, 31 Mar 2022 00:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648685555; x=1680221555;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZWkyT5TIv4BAQ3bew6K+8sgfMaK968XbAF8/DESvulg=;
  b=fcdw1TIBzquAxX3fxZ1Xv4dn+znFgm6MhsOwbt1qus5g3Z8HOfRS1X8X
   Q+1W2YKTml126RLjSO6sSOroISftmRxgRw8lOQl01d+ydm0eC8yCGR7+J
   Cz4jaLXY+IiP4CYpauwP/v8kqoP99b//LTsndMZn8twm5E13JpxFzlkY0
   /QQs06YiE0hXwJPsstqIDC1j8GQwwqEKcpGan/tIgCIb147VGSIHpcjiR
   nHwwu7cgGUeILfZV4aO4fIn2mOCkS6GFVZxLnrsu1oPj4yDMpyYOrJTKI
   az/JOIMXFk74uHvPzQaXlox0zPBYHmEt4mKKCXngrOEzZIeH9VpQNrurY
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="247176243"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="247176243"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 17:12:34 -0700
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="503514250"
Received: from elicahil-mobl.amr.corp.intel.com ([10.255.228.91])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 17:12:34 -0700
Date: Wed, 30 Mar 2022 17:12:34 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev, Geliang Tang <geliang.tang@suse.com>
cc: Christoph Paasch <cpaasch@apple.com>
Subject: Infinite mapping and dropping data
Message-ID: <5e9cc0c5-1514-a198-5191-a765a67b9de4@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-981912963-1648685554=:62812"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-981912963-1648685554=:62812
Content-Type: text/plain; format=flowed; charset=UTF-8
Content-Transfer-Encoding: 8BIT


We talked about the infinite mapping changes in the export branch at the 
meeting last week:

   216  The infinite mapping support [enhancement] @geliangtang:
       - last and hard remaining part: drop data that have been corrupted
       - Geliang is looking for help on this one
       - Mat will have a look at alternative ways → at least the 1 subflow case
       - Maybe best to create a new dedicated ticket for that?
       - technically, it is difficult to drop data with the current architecture:
           - but when does it make sense to drop packets?
           - when a middlebox adds/removes data from a packet without modifying the DSS?
           - maybe not an issue when there is only one subflow
           - Mat will check that (RFC)


I've been holding off upstreaming those commits while the MP_FAIL 
retransmit work was in progress, and also because the multipath-tcp.org 
kernel discards some data after MP_FAIL is sent but before an infinite 
mapping is received.

The discussion on discarding data goes back to 
https://lore.kernel.org/mptcp/DEA13B0F-B535-42A3-95C6-595859A1CD55@apple.com/, 
here's the relevant section:

I said:

>> I also noticed that the multipath-tcp.org kernel does something 
>> interesting with connections that are entering fallback with MP_FAIL: 
>> packets that contain a regular mapping (not infinite) are dropped after 
>> MP_FAIL is sent but an infinite mapping has not been received yet. Look 
>> at mptcp_detect_mapping() and "Ignore packets which do not announce 
>> fallback" comment text in mptcp_input.c.
>>
>> I think the reasoning may be that the bad checksum that triggered the 
>> MP_FAIL has dropped some data, so to get the data stream back in a good 
>> state we need to wait for the infinite mapping as a signal that the 
>> other peer received the MP_FAIL and has resent data starting from the 
>> last DATA_ACKed byte.
>>
>> @Christoph, does that sound correct? ^^^^
>> 'git blame' said I should ask you :)

And Christoph replied:

> :) Yes, this sounds correct to me!
>
> In general, fallback to infinite mid-stream is really a best-effort 
> thing. Don't spend CPU-cycles on that in the fast-path :) It happens 
> only if middleboxes start interfering with the data-stream in a very 
> disruptive way. It's ok to try to work-around these things but not at 
> any cost. Better to kill the connection and fail hard.
>
> The fallback scenarios that are more common are the ones during 
> connection establishment. Also, right after the TCP-handshake is a 
> scenario that does happen.


So, it seemed that there was some data dropping behavior necessary to make 
infinite mappings work.


I spent some time today looking through our code and the RFC. There was 
one sentence in section 3.7 of the RFC that stood out as the most 
important:

"The sender will receive this information and, if all unacknowledged data 
in flight is contiguous, will signal an infinite mapping."

So, we only need to be concerned with receiving infinite mappings (and 
handling fallback) from peers that know they only have in-sequence 
transmitted data in flight. Geliang's infinite mapping patches in the 
export branch already have an even narrower requirement: infinite mappings 
and non-RST MP_FAIL are only sent if *all* transmitted data has been 
in-sequence.

Given that, I don't think it's necessary to discard any incoming data to 
handle this single-subflow fallback scenario. As Matthieu mentioned in the 
meeting, the checksum failure tells us that there was either MPTCP header 
corruption or a mismatch between the data payload and the MPTCP mapping - 
it is not an indication that the data was "bad". If the incoming data that 
is read from the MPTCP socket matches the subflow's reassembled TCP 
stream, then fallback was successful.

I'm not quite sure what problem the multipath-tcp.org code was solving by 
discarding data (or if it was from an earlier draft of the spec?). It's 
also a confusing approach since it assumes the peer will retransmit data 
to recover what was discarded, which would make the data non-contiguous!

If any protocol experts think I'm misreading the RFC or this would 
cause an interop problem please speak up :)


--
Mat Martineau
Intel
--0-981912963-1648685554=:62812--
