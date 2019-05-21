Content-Type: multipart/mixed; boundary="===============7164365496090575289=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: selftests: exercise GSO,
 retransmission and reorder code path
Date: Tue, 21 May 2019 10:49:04 -0700
Message-ID: <alpine.OSX.2.21.1905210912530.13454@cwhilton-mobl1.amr.corp.intel.com>
In-Reply-To: 19f6daab-98e1-a4d3-e849-b51511d0960a@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1213

--===============7164365496090575289==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 21 May 2019, Matthieu Baerts wrote:

> On 21/05/2019 15:55, Paolo Abeni wrote:
>> On Tue, 2019-05-21 at 15:28 +0200, Matthieu Baerts wrote:
>>> On 21/05/2019 12:51, Florian Westphal wrote:
>>>> Thats another option, but I don't have a preference, your change is fi=
ne
>>>> as-is.
>>>
>>> Paolo, do you want to change something or can I apply this patch?
>>
>> If nobody opposes, I think it can go in as-is, thanks!
>
> Great! If someone opposes, we can easily revert/modify later!
>
> Just "squashed" into commit 40e8869bdd0f ("mptcp: selftests:
> switch to netns+veth based tests")
>
> - squash: 2707b30453da
> - signed-off: b23efa13d890
> - no conflict: /
> - export commit: fb5407ead32f
>

Thanks for the test updates, Paolo.

One thing to note: the packet reordering is only affecting TCP reassembly, =

and does not exercise reassembly at the MPTCP layer differently. The =

stream is still delivered to the MPTCP layer in-order.

MPTCP-level reassembly in the prototype implementation does not yet handle =

out-of-order mappings. That will get built in when updating =

mptcp_recvmsg() for multiple subflows.

--
Mat Martineau
Intel

--===============7164365496090575289==--
