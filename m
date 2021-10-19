Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A991F2C85
	for <mptcp@lists.linux.dev>; Tue, 19 Oct 2021 23:44:52 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="252132372"
X-IronPort-AV: E=Sophos;i="5.87,165,1631602800"; 
   d="scan'208";a="252132372"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 16:44:52 -0700
X-IronPort-AV: E=Sophos;i="5.87,165,1631602800"; 
   d="scan'208";a="444734446"
Received: from mkharan-mobl.amr.corp.intel.com ([10.212.135.69])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 16:44:51 -0700
Date: Tue, 19 Oct 2021 16:44:51 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: Davide Caratti <dcaratti@redhat.com>, Geliang Tang <geliang.tang@suse.com>, 
    MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next v7 8/8] DO-NOT-MERGE: mptcp: mp_fail test
In-Reply-To: <CA+WQbwt4dk5vQyoPgxv7=ctsaNetcbt855Md+SL6juFZcLUPgA@mail.gmail.com>
Message-ID: <609c4413-b7a2-bb19-5ebc-9b5ff5d8376b@linux.intel.com>
References: <cover.1634531093.git.geliang.tang@suse.com> <2e9a15d32cd39483dd1e18174d6c73b33e0566b5.1634531093.git.geliang.tang@suse.com> <7e1c37e5-a636-68f1-aaa-329f951b2c55@linux.intel.com>
 <CA+WQbwt4dk5vQyoPgxv7=ctsaNetcbt855Md+SL6juFZcLUPgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="0-1588046296-1634685128=:36950"
Content-ID: <2887ace-c4c-aa8-1f61-abda7b99616@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1588046296-1634685128=:36950
Content-Type: text/plain; CHARSET=ISO-2022-JP; format=flowed
Content-ID: <698beea0-f66f-ab72-482b-c3911c78939@linux.intel.com>

On Mon, 18 Oct 2021, Geliang Tang wrote:

> Mat Martineau <mathew.j.martineau@linux.intel.com> 于2021年10月18日周一 下午8:50写道：
>>
>> On Mon, 18 Oct 2021, Geliang Tang wrote:
>>
>>> ./mptcp_join.sh -Cf
>>
>> When I tried running this as './mptcp_join.sh -Cfc', I'm not seeing
>> fallback in the packet trace (no data level len == 0, and the packets all
>> have DSS headers until disconnect). Is the test working on your system?
>
> Hi Mat,
>
> This test can't trigger the checksum failure every time, so you need
> to run it again.
>

I ran it four or five times yesterday, with no failures. When I tried 
again today, it triggered the checksum failure the first time :)

>
> My pcap file (mp_join-01-ns1-0-U5nzEu.pcap) is attached.
>

Thanks for sharing the pcap. When I capture failures on my system, I'm 
seeing slightly different results. The MP_FAIL is only sent in one 
direction, and there is only one infinite mapping sent (in reply to the 
MP_FAIL), but the connection still acts like fallback has happened. I 
uploaded that pcap to the infinite mapping github issue:

https://github.com/multipath-tcp/mptcp_net-next/issues/216#issuecomment-947172574

I noticed in your pcap that the infinite mapping is only sent in one 
direction, but MP_FAIL is sent by both sides.

Section 3.7 of the RFC (after Figure 16) says the MP_FAIL must be sent 
both directions, and I think that also implies the infinite mapping should 
be sent in both directions. So, should make sure that the last mapping 
sent by both peers is an infinite mapping. And if other people have 
differing interpretations of the RFC (especially the "infinite mapping in 
both directions" part that is not completely spelled out), please discuss!


--
Mat Martineau
Intel
--0-1588046296-1634685128=:36950--
