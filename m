Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24C515AE6
	for <mptcp@lists.linux.dev>; Mon, 11 Sep 2023 20:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5766BC433C7;
	Mon, 11 Sep 2023 20:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694462786;
	bh=MRbU3sC5lxACG27QII9BEhd2l1w6DiUCSt9Caokv3Qk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=g7Ezq2dMkrH6F7ml6C0aFqGHBpPC57P4qhY72iKccjBcCruq6hbfzg6Wp1gyXNViv
	 4qV4K7YNptO5tGFcG9DNrWd0oda2khjGS+ZHn6CyHcq6qBJzKQMDFRpyZnZMwgFloE
	 08I3fkQrA3uswsOijDeSoq1Wupt7Si5g6ug6+zVTSspc3odlMJ6XSYKTRWsShTrGNk
	 uzjgza1FIF5HSnIhAghQ3WVMSYh4ChCVeFD2kdNIQGW3UbW6NF+mGb7d56ogFKKft9
	 nvEgFGF7DvZ9Fj7jOeKEMfTYLYZ0Pi4AY4t9qPTplh1VWcwjt+6hwTrrubfbUihVAl
	 VpZp54jKDABaw==
Date: Mon, 11 Sep 2023 13:06:23 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Alexander Witte <alexander.witte@blueflag.consulting>
cc: "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>
Subject: Re: Subflows for specific types of traffic?
In-Reply-To: <97EFFF48-340C-4859-9657-ED70137C2CF7@blueflag.consulting>
Message-ID: <69e641b3-0989-fb32-95e7-88283106904a@kernel.org>
References: <37779FCF-34D3-449F-B966-925845496DA5@blueflag.consulting> <2686ea81-0ae3-4c3f-92fc-59cb9275829a@kernel.org> <97EFFF48-340C-4859-9657-ED70137C2CF7@blueflag.consulting>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1879064827-1694462786=:10715"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1879064827-1694462786=:10715
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 7 Sep 2023, Alexander Witte wrote:

> Hi Mat,
>
> Apologies I had sent a reply not including the mailing list.  Anyway 
> thank you very much for the response.
>
> I think I got it- a singular Path Manager plugin can accommodate the 
> management of subflows for multiple MPTCP socket connections (and could 
> contain logic specific for each socket connection).  We’re looking to do 
> all the Path Management using the mptcpd plugin system.

Yes, a single mptcpd path manager plugin could manage different subflows. 
It's not really set up to differentiate based on specific sockets, but it 
could look at the port numbers in use on the initial subflow in order to 
choose which addresses advertise with ADD_ADDR, or which subflows to 
initiate.

>
> As for the MPTCP BPF packet scheduler, is there anywhere I can go to 
> read about this framework and its ETA?

We are carrying a number of BPF packet scheduler commits in our 'export' 
branch right now:

https://github.com/multipath-tcp/mptcp_net-next/commits/export

In particular, look at the test cases for some example BPF schedulers.

We're trying to get the kernel/BPF APIs correct before we send these 
patches upstream to the netdev mailing list, since we don't want to 
present too much of a moving target to BPF scheduler developers once the 
feature is out in the wild.

At this point, features added to the net-next branch will appear in kernel 
v6.7. Depending on when we send those patches, I would tentatively expect 
6.7 or 6.8. According to the "PHB Crystal Ball" 
(https://hansen.beer/~dave/phb/) that would be either mid-January or late 
March 2024 to be in a mainline Linux release.

- Mat

>
>> On Sep 5, 2023, at 4:35 PM, Mat Martineau <martineau@kernel.org> wrote:
>>
>> On Tue, 5 Sep 2023, Alexander Witte wrote:
>>
>>> Hi!
>>>
>>> Couple questions (brace yourself, they might be dumb):
>>>
>>
>> Hi Alexander -
>>
>> No problem, happy to help.
>>
>>> 1. If we want to direct specific types of application traffic to 
>>> specific MPTCP subflows, would this be the role of a custom developed 
>>> packet scheduler?  If so, I am also assuming that there is no 
>>> userspace way to make changes on the fly..?  The use-case is around 
>>> defining rules like: "send all HTTP traffic across these specific 
>>> links, send all OTHER_TCP traffic on those specific links"
>>>
>>
>> Each MPTCP connection only has one data stream, so in your example a 
>> HTTP connection would have an entire MPTCP connection to itself. 
>> OTHER_TCP traffic would be on separate MPTCP sockets.
>>
>> This sounds like a job for the path manager. The connections for HTTP 
>> would presumably be using well known HTTP/HTTPS ports. If your initial 
>> connection is to port 80 or 443, you could establish new subflows to 
>> your designated HTTP links. Initial connections to other port numbers 
>> could go to dedicated non-HTTP links.
>>
>>> 2. Another thing we might want to do is weight traffic based on some 
>>> business criteria ie. “80% of HTTP traffic goes on sub flow #1 and 20% 
>>> on sub flow #2 (because subflow #1 uses a cheaper cellular provider”). 
>>> From reading, it also appears like this would be the job of the packet 
>>> scheduler where we cannot dynamically make changes from userspace?
>>
>> Yes, this is the packet scheduler's job. We're working on a BPF packet 
>> scheduler framework that would allow customizing these per-packet 
>> decisions.
--0-1879064827-1694462786=:10715--
