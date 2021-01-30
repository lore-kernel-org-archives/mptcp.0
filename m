Content-Type: multipart/mixed; boundary="===============7858685601197193160=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][RFC mptcp-next 0/6] add trace events
Date: Fri, 29 Jan 2021 16:42:28 -0800
Message-ID: <3e644a2d-a291-cf1-e3df-c94c57911986@linux.intel.com>
In-Reply-To: 866985d7f86eb25ec273b59182269458699691f3.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7536

--===============7858685601197193160==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 29 Jan 2021, Paolo Abeni wrote:

> Hello,
>
> On Tue, 2021-01-26 at 21:21 +0800, Geliang Tang wrote:
>> This patchset addressed issues 131, replace some/most pr_debug with trace
>> events.
>>
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/131
>>
>> Geliang Tang (6):
>>   mptcp: add tracepoints for data operations
>>   mptcp: add echo field in mptcp_out_options
>>   mptcp: add tracepoints for options operations
>>   mptcp: add mptcpi_local_addr_* in mptcp_info
>>   mptcp: add tracepoints for PM operations
>>   mptcp: add tracepoints for subflow operations
>
> I'm sorry for the late feedback.
>
> I think we should first agree on which functions we want to
> instrument/where we want to add the tracepoint.
>
> I suggest avoiding functions invoked not frequently (pr_debug would
> probably suffice there) and avoiding exposing data accessible elsewhere
> e.g. packet capture.
>
> I think it would be nice to instrument the packet scheduler and the
> mapping status. I would not add much more tracepoints than that.
>

Yes, these seem like good places to focus first as the main high-frequency =

tracepoints that will be helpful.

> Additionally, I suggest dropping the pr_debug() from places where
> tracepoints are added.
>
> I'd love to ear others opinions, too!
>

Agree with Paolo on all the above!

Thanks for the patches Geliang, and thanks for the review Paolo.

--
Mat Martineau
Intel
--===============7858685601197193160==--
