Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A9C2906
	for <mptcp@lists.linux.dev>; Sun, 17 Jul 2022 22:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658095301; x=1689631301;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qytVaSj98w1UsbcqCyJrnAtImiKHV8YNSN/2TfLn5sI=;
  b=K1IGvK8cktfka5/1wdn7y4BrSehTGQm72/Zas08SfrnoWgSUFkLiybIn
   vqDSBm8J/jvK7lrP7q1HiuUdWZ/G4Pef/k/XAoQjBhDwI387tBf7f32w+
   FJD3TPb3smc/RELxrTjqsueYUJw8mWlyq4rTnZHK2foH/3Y1xqOntOnqX
   lWeI8nGqsDIsZZ/290ZTdz05FLrh+4B1XX+Ez8PfW8Jmjw8svpzvg6Ohb
   g7CT9vGwWr5HbRUL6F8cFssiJVWlWAYnjTvd57cHzKJvEsX66zibrZMSX
   PfsOeFzeGHATj8KlV0eiTr+BTw4FdMN2/CoRDoTS/WzhrZBDx05X4lwgZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="286116676"
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="286116676"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 15:01:41 -0700
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="739255486"
Received: from aditgoya-mobl.amr.corp.intel.com ([10.209.38.139])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 15:01:40 -0700
Date: Sun, 17 Jul 2022 15:01:40 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: Draft talk proposal for MPTCP @ Linux Plumbers '22 (2nd draft)
In-Reply-To: <7cd436ad-6c05-d788-7af3-2ff08d647dfd@tessares.net>
Message-ID: <83393fe2-91ad-9b65-58b7-b5f66264e31@linux.intel.com>
References: <78ff1ebd-f440-9dd0-256-abf3345e6d3@linux.intel.com> <3f3a487-64b-e687-f566-ae9b3b930bb@linux.intel.com> <7cd436ad-6c05-d788-7af3-2ff08d647dfd@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1177811439-1658095301=:1521"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1177811439-1658095301=:1521
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 15 Jul 2022, Matthieu Baerts wrote:

> Hi Mat,
>
> On 15/07/2022 00:50, Mat Martineau wrote:
>>
>> After some discussion at out last couple of weekly meetings, here's an
>> updated draft.
>>
>> Changes:
>>
>>  * Moved BPF section up (before userspace PM)
>>  * Emphasized interactive discussion for BPF issues we've been trying to
>> resolve, like the BPF/kernel API.
>>  * General edits
>
> Thank you for this v2!
>
> This looks really good. I have one general comment below:
>
>> Suggestions, edits, feedback, etc, all welcome!
>>
>>
>> ---
>>
>> Multipath TCP (MPTCP) was initially supported in v5.6 of the Linux
>> kernel. In later releases, the MPTCP development community has steadily
>> expanded from the initial baseline feature set to now support a broad
>> range of MPTCP features on the wire and through the socket and generic
>> netlink APIs. Two current projects are intended to make MPTCP more
>> customizable for client devices and unique use cases without requiring
>> custom kernel modules.
>>
>> One of these projects is the BPF MPTCP packet scheduler framework. When
>> there are multiple active TCP subflows in a MPTCP connection, the MPTCP
>> stack must decide which of those subflows to use to transmit each data
>> packet. The default in-kernel scheduler tries to utilize all the
>> available subflows to favor throughput, but it is not tunable.
>> Customizable schedulers can optimize for latency, redundancy, cost,
>> carrier policy, or other factors. We have patches implementing a
>> proof-of-concept BPF packet scheduler, and hope to discuss with the
>> netdev/BPF maintainers and audience how we might best structure the
>> BPF/kernel API to balance long-term API stability, future evolution of
>> MPTCP scheduler features, and usability for scheduler authors.
>
> Should we insist on the fact that these discussions are not specific to
> MPTCP but this is more general and MPTCP is used as one typical use-case?
>
> I would suggest to explain that before this 2nd paragraph. Maybe saying
> that we are trying to get answers to questions like: what's the
> recommended way to extend a subsystem(?)? The recommended ways seems to
> be with BPF and Netlink and they both have limitations. allowing
> customisations with BPF bring more questions for us, e.g.: what about
> long-term API stability and other questions you raised here at the end.
>
> Then we can introduce the two use cases. The first one with the Packet
> Scheduler where we need something on the kernel side as it is a decision
> to take per packet. There are some uncertainties when using BPF but a
> proof-of-concept implementation exists.
>
> Then for the Path Manager, the decision can be done from the userspace
> because the communications are per connections and not per packet. So
> this is a another use-case where exposing a Netlink API seems to be a
> good fit (even if there are some limitations if there is a very high
> number of connections to deal with).
>
> We can then compare BPF and Netlink and trying to get answers to our
> questions.
>
> What do you think?
>

I think that's a good way to frame the talk: emphasizes that the content 
can be useful for understanding general ideas about extending/customizing 
kernel functionality, and also cover what we've done in MPTCP for these 
two cases. I'll update the draft and post a v3 on Monday.


--
Mat Martineau
Intel
--0-1177811439-1658095301=:1521--
